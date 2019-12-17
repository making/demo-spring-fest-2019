#!/bin/bash
rm -rf hello-graal
. demo-magic.sh
DEMO_PROMPT="(\w): "
clear

TYPE_SPEED=1000


############
printf "\033[32m⭐️ Java Versionを確認します \033[0m\n"
pe "java -version"

printf "\033[32m⭐️ Maven ArchetypeでSpring Boot Projectの雛形を作成します \033[0m\n"
pe "mvn archetype:generate \\
 -DarchetypeGroupId=am.ik.archetype \\
 -DarchetypeArtifactId=graalvm-springmvc-blank-archetype \\
 -DarchetypeVersion=0.1.2 \\
 -DgroupId=com.example \\
 -DartifactId=hello-graal \\
 -Dversion=1.0.0-SNAPSHOT \\
 -B"

############

printf "\033[32m⭐️ ディレクトリを変更します \033[0m\n"
pe "cd hello-graal"


############

TYPE_SPEED=50
printf "\033[32m⭐️ Mavenでnative imageをBuildします \033[0m\n"
pe "chmod +x mvnw* && ./mvnw clean package -DskipTests -Pgraal"

############

printf "\033[32m⭐️ native-imageを確認します \033[0m\n"

pe "ls -lha target/classes"


############

printf "\033[32m⭐️ native-imageを実行します \033[0m\n"

pe "./target/classes/hello-graal-osx-x86_64"