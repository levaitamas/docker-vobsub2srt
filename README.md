# docker-vobsub2srt

<p align="left">
 <a href="https://hub.docker.com/r/levaitamas/vobsub2srt" alt="Docker pulls">
  <img src="https://img.shields.io/docker/pulls/levaitamas/vobsub2srt" /></a>

## How to use?

1. Put your subtitles to a folder (*e.g.,* `subs`)

2.  Start container:

If you use `podman`:
```shell
podman run --rm -ti --volume /path-to-subs:/subs --security-opt label=disable docker.io/levaitamas/vobsub2srt:latest conv <subfile>
```
If you use `docker`:
```shell
sudo docker run -it --rm -v /path-to-subs:/subs levaitamas/vobsub2srt conv <subfile>
```

## vobsub2srt documentation

### Usage

Assuming you have copied the subfile.idx and subfile.sub files in `/tmp/subtitles`

#### With bashrc

```shell
conv subfile
```

#### Without bashrc

```shell
cd /subs
vobsub2srt --blacklist "|\/_~<>" --verbose "subfile"
chown 1000:1000 subfile.srt
```
