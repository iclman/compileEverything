# --------------------------------------------
# Per-repo authorization based on gitolite ACL
# Include this in gitweb.conf
# See doc/3-faq-tips-etc.mkd for more info

# please note that the author does not have personal experience with gitweb
# and does not use it.  Some testing may be required.  Patches welcome but
# please make sure they are tested against a "github" version of gitolite
# and not an RPM or a DEB, for obvious reasons.

# HOME of the gitolite user
my $gl_home = $ENV{HOME} = "/home/auser/compileEverything";

# the following variables are needed by gitolite; please edit before using

# this should normally not be anything else
$ENV{GL_RC} = "$gl_home/.gitolite.rc";
# this can have different values depending on how you installed.

# if you used RPM/DEB or "root" methods it **might** be this:
$ENV{GL_BINDIR} = "/usr/local/bin";
# if you used the "non-root" method it **might** be this:
$ENV{GL_BINDIR} = "$gl_home/gitolite/bin";
# If in doubt take a look at ~/.ssh/authorized_keys; at least one of the lines
# might contain something like:
#       command="/home/git/.gitolite/src/gl-auth-command
# and you should use whatever directory the gl-auth-command is in (in this
# example /home/git/.gitolite.src)

# finally the user name
$ENV{GL_USER} = $cgi->remote_user || "gitweb";

# now get gitolite stuff in...
unshift @INC, $ENV{GL_BINDIR};
require gitolite_rc;    gitolite_rc -> import;
require gitolite;       gitolite    -> import;

# set project root etc. absolute paths
$ENV{GL_REPO_BASE_ABS} = ( $REPO_BASE =~ m(^/) ? $REPO_BASE : "$gl_home/$REPO_BASE" );
$projects_list = $projectroot = $ENV{GL_REPO_BASE_ABS};

$export_auth_hook = sub {
    my $repo = shift;
    # gitweb passes us the full repo path; so we strip the beginning
    # and the end, to get the repo name as it is specified in gitolite conf
    return unless $repo =~ s/^\Q$projectroot\E\/?(.+)\.git$/$1/;

    # check for (at least) "R" permission
    my ($perm, $creator) = &repo_rights($repo);
    return ($perm =~ /R/);
};
