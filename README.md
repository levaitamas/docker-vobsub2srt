# Usage

Assuming you have copied the subfile.idx and subfile.sub files in `/tmp/subtitles`

## With bashrc

```
$ conv subfile
```

## Without bashrc

```
$ cd /subs
$ vobsub2srt --blacklist "|\/_~<>" --verbose "subfile"
$ chown 1000:1000 subfile.srt
```
