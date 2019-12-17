#!/bin/bash
docker rmi $(docker images | grep "^<none" | awk '{print $3}')
rm -rf hello-spring-fest
. demo-magic.sh
DEMO_PROMPT="(\w): "
clear

TYPE_SPEED=1000


############

printf "\033[32m⭐️ Spring InitializrでSpring Boot Projectの雛形を作成します \033[0m\n"
pe "curl https://start.spring.io/starter.tgz \\
  -d artifactId=hello-spring-fest  \\
  -d baseDir=hello-spring-fest \\
  -d dependencies=web  \\
  -d packageName=com.example  \\
  -d applicationName=HelloSpringFestApplication | tar -xzvf -"

############

printf "\033[32m⭐️ ディレクトリを変更します \033[0m\n"
pe "cd hello-spring-fest"

############

printf "\033[32m⭐️ ソースコードを修正します \033[0m\n"
pe "cat <<'EOF' > src/main/java/com/example/HelloSpringFestApplication.java
package com.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class HelloSpringFestApplication {

        @GetMapping(\"/\") 
        public String hello() {
                return \"Hello Spring Fest!\";
        }

        public static void main(String[] args) {
                SpringApplication.run(HelloSpringFestApplication.class, args);
        }
}
EOF"

############

TYPE_SPEED=50
printf "\033[32m⭐️ Pack CLIでコンテナイメージをBuildします \033[0m\n"
pe "pack build making/hello-spring-fest --builder cloudfoundry/cnb:bionic --no-pull -v"

############

printf "\033[32m⭐️ Dockerイメージを確認します \033[0m\n"

pe "docker images"

############

printf "\033[32m⭐️ Dockerイメージを実行します \033[0m\n"
pe "docker run --rm  \\
   -p 8080:8080 \\
  making/hello-spring-fest"

############

printf "\033[32m⭐️ ソースコードを更新します \033[0m\n"
pe "sed -i '' -e 's/Spring Fest/Spring Fest 🍃/g' src/main/java/com/example/HelloSpringFestApplication.java"

############

printf "\033[32m⭐️ バナーを追加します \033[0m\n"
pe "cp ../banner.txt src/main/resources/"

############

printf "\033[32m⭐️ Pack CLIでコンテナイメージをBuildします \033[0m\n"
pe "pack build making/hello-spring-fest --builder cloudfoundry/cnb:bionic --no-pull -v"

############

printf "\033[32m⭐️ Dockerイメージを確認します \033[0m\n"

pe "docker images"

############

printf "\033[32m⭐️ Dockerイメージを実行します \033[0m\n"
pe "docker run --rm \\
    -p 8080:8080 \\
    -e SPRING_OUTPUT_ANSI_ENABLED=ALWAYS \\
    making/hello-spring-fest"
