# nexus-client-docker

Nexus Client 多平台镜像，同时支持 Linux/Mac 下的 X86 和 ARM 架构。

## 使用说明

```
docker run -d \
    --name nexus \
    --network host \
    --cpus 3 \                                    
    -e PROVER_ID=V6IkE6gZWzOV3HXdhXtJSmGLuGQ2 \   # 这里改成你的 prover ID 即可。
    jagerzhang/nexus-c^Cent:v0.4.2
```

- `注1：如需控制CPU数量，请修改 --cpus 参数，不需要控制可以直接去掉`
- `注2：实际使用，请修改 PROVER_ID 为自己的 ID，否则你就是给我打工了。`

## TODO
二进制编译使用 Docker 多阶段。
