# Testbed Setup

This is the simplest way to set up a local testing instance of the testbed. This folder contains a docker-compose.yml file that will set up services as easy as possible by compiling them in docker images and then running those in docker containers.

Some services do not have public source repositories yet. Before they can be started, the binaries have to be compiled and provided manually. This step is also automated. If you have SSH access to the git repositories, you can compile them using `bash compileClosedServices.bash`. Starting the services using `docker-compose up <service_name>` will then work.

In case you want to modify the setup, read the developer documentation below for an overview.

## Developer documentation

Most services originating from KIT Data Manager are compiled using the same technologies. They usually need JDK-SE 8+ (openjdk11 recommended), are built using gradle and are started in a similar way. Therefore they can share the build-script, the run-script and even the `Dockerfile`. The difference will make the environment variables you can see in the `docker-compose.yml`. They are stored in the image (using `ARG` in the dockerfile) and given to the build-script at image-creation-time and to the run-script at container-run-time (using `ENV` in the dockerfile).
    - `SERVICE_FOLDER` stores the name of the repository folder name, which is the folder name in the url without the `.git` suffix.
    - `BINARY_NAME` is the name of the JAR-file without the `.jar` suffix.

There are services that do not yet have public source repositories and therefore can not be set up as easily as the ones described above. For those, there is a workaround. The `compileClosedServices.bash` script will compile the projects directly on your computer (in `tmp` subfolder) and store the result in `./bin/`. This requires ssh access to the repositories, though.

After compiling, you can use docker-compose as for all the other services. The technical difference here is that another dockerfile will be used to create them, which expect the binary (or byte-code) in the `bin/` folder. So ake sure to run the `compileClosedServices.bash` script successfully before using docker-compose.
