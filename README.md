# python-fuse-sample

This repo contains a very simple FUSE filesystem example in Python. It's the
code from a post I wrote a while back:

https://www.stavros.io/posts/python-fuse-filesystem/

If you see anything needing improvement or have any feedback, please open an
issue.

how to run 

```
docker-compose exec fs
python3 passthrough.py /real /fuse
docker exec -ti <container id> bash
```