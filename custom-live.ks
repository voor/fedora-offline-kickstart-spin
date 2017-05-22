# Maintained by the Fedora Workstation WG:
# http://fedoraproject.org/wiki/Workstation
# mailto:desktop@lists.fedoraproject.org

%include ../fedora-kickstarts/fedora-live-base.ks
%include ../fedora-kickstarts/fedora-live-minimization.ks
%include custom-packages.ks
#
# Disable this for now to see if packagekit is causing
# compose failures by leaving a gpg-agent around holding /dev/null open.
#
#include snippets/packagekit-cached-metadata.ks
