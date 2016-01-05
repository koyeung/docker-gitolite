docker-gitolite
==
Host gitolite in a docker container.

Building
==

Copy the sources to your docker host and build the container:

    # docker build --rm -t <username>/gitolite .

Running
==

To run the container, binding to port `2200` on the host, and map local directory `/tmp/repositories`:

    # mkdir -p /tmp/repositories
    # chcon -Rt svirt_sandbox_file_t /tmp/repositories
    # docker run --name git -d -p 2200:22 \
        -v /tmp/repositories:/home/git/repositories <username>/gitolite

If it is the first run, it needs to finish the setup by `gitolite setup`

    # YOURNAME=yourname
    # docker cp /tmp/${YOURNAME}.pub git:/tmp/${YOURNAME}.pub
    # docker exec -u git git /setup.sh /tmp/${YOURNAME}.pub

Basic Administration
--
Since non-standard port `2200` is used, we have to use full URL style for the repositories. To clone the admin repo:

    # git clone ssh://git@localhost:2200/gitolite-admin

Please refer to [gitolite](http://gitolite.com/gitolite/) for information.
