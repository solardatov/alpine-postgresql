# 알파인 리눅스 환경에서 오래된 포스트그레스큐엘 서버 사용하기 Legacy PostgreSQL binaries on Alpine linux

```diff
- 이 서버들은 운영 환경에서 사용하지 마십시오!
- Don't use these in a product environment!
```

## 서버 따로 따로 만들기 Make each server
```bash
# 작업 디렉터리 만들어 이동하고,
# make directory and change cuttent it
mkdir ~/pgtemp && cd ~/pgtemp
# 작업할 파일들 다운로드 받고, 
# download files for working
git clone https://github.com/i0seph/alpine-postgresql.git .
# 각 서버들을 실행 할 수 있는 기본 이미지 만들고,
# make base docker image for making each version
docker build -f Dockerfile.pgbase -t alpine-pgbase .
# 각 버전별 도커 이미지 만들,
# make a docker image for each version
docker build -f Dockerfile.x.x.x -t alpine/postgres:x.x.x .
# 해당 버전 서버 실행하는 컨테이너 등록 및 실행
# make a container and start it
docker run -d --name postgresql-x.x.x alpine/postgres:x.x.x
# 해당 서버로 접속하고,
# connect that server
docker exec -it postgresql-x.x.x psql -U postgres template1
# 해당 서버 종료하고, (docker stop 명령은 위험합니다.)
# stop server (don't use 'docker stop' command)
docker exec -it postgresql-x.x.x su postgres -c "pg_ctl -mf stop"
# 해당 컨테이너 지우고,
# remove a container
docker rm postgresql-x.x.x
# 해당 이미지 지우고,
# remove a image
docker image rm alpine/postgres:x.x.x
```

## 한번에 모든 서버 한꺼번에 작업하기 working all servers
```
# 작업 디렉터리 만들어 이동하고,
# make directory and change cuttent it
mkdir ~/pgtemp && cd ~/pgtemp
# 작업할 파일들 다운로드 받고,
# download files for working
git clone https://github.com/i0seph/alpine-postgresql.git .
# 모든 이미지 만들고, 모든 컨테이너 만들고
# make every image and conainer
./1.runall.sh
# 모든 서버 시작하기
# start every
./2.startall.sh
# 모든 서버로 어떤 작업하기
# execute a command at every server
#./3.executeall.sh .....
# 보기 ex: ./3.executeall.sh psql -c "select version()"
#
# 모든 서버 중지
# stop every server
./4.stopall.sh
# 모든 컨테이너와 이미지 지우기
# remove all images & containers
./5.cleanall.sh
# 모든 흔적 지우기
# clean all
cd ~ && rm -rf pgtemp
```
