# Archiva Proxy

This image is for testing a maven project from scratch.
Mount your `.m2/repository` directory to the archiva.

```
% docker run -v /home/[user]/.m2/repository:/apache-archiva/repositories/internal -it kawasima/archiva-proxy
```

When you use `mvn` command in another images, write mirror settings at your settings.xml.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<settings>
  <mirrors>
    <mirror>
      <id>archiva</id>
      <url>http://172.18.0.2:8080/repository/internal/</url>
      <mirrorOf>external:*</mirrorOf>
    </mirror>
  </mirrors>
</settings>
```
