# Archiva Proxy

This image is for testing a maven project from scratch.
Mount your `.m2/repository` directory to the archiva.

```
% docker run -v /home/[user]/.m2/repository:/apache-archiva/repositories/internal -it kawasima/archiva-proxy
```
