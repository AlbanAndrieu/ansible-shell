import os

import pytest
import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ["MOLECULE_INVENTORY_FILE"],
).get_hosts("all")

# Molecule runs the role as root, see provisioner.inventory in molecule.yml
HOME = "/root"


def test_hosts_file(host):
    f = host.file("/etc/hosts")

    assert f.exists
    assert f.user == "root"
    assert f.group == "root"


@pytest.mark.parametrize("package", ["bash", "bash-completion"])
def test_packages_installed(host, package):
    assert host.package(package).is_installed


@pytest.mark.parametrize(
    "name,mode",
    [
        (".bashrc", 0o644),
        (".bash_profile", 0o644),
        (".config/starship.toml", 0o644),
        (".git-prompt.sh", 0o644),
        (".novarc", 0o600),
        (".ssh/config", 0o600),
        ("step-0-color.sh", 0o755),
        ("step-1-os.sh", 0o755),
    ],
)
def test_home_files(host, name, mode):
    f = host.file(f"{HOME}/{name}")

    assert f.is_file
    assert f.mode == mode


def test_novarc_has_no_hardcoded_credentials(host):
    content = host.file(f"{HOME}/.novarc").content_string

    assert 'OS_TENANT_ID="${OS_TENANT_ID:-' in content
    assert "OS_SERVICE_TOKEN" not in content


def test_git_global_settings(host):
    cmd = host.run("git config --global alias.ci")

    assert cmd.rc == 0
    assert cmd.stdout.strip() == "commit"


@pytest.mark.parametrize("name", ["az.completion", "scons_completion"])
def test_bash_completions(host, name):
    assert host.file(f"/etc/bash_completion.d/{name}").is_file


def test_motd_banner_owned_by_root(host):
    f = host.file("/etc/update-motd.d/11-welcome")

    assert f.user == "root"
    assert f.mode == 0o755
