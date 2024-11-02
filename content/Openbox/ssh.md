---
{"dg-publish":true,"date":"2023-01-14T15:47:29+04:00","modified_at":"2023-09-21T21:18:49+04:00","dg-path":"/ssh.md","permalink":"/ssh/","dgPassFrontmatter":true}
---

# SSH (Secure SHell)

SSH - способ организации удалённого доступа для сервера на базе Linux. Позволяет использовать удалённую консоль, но и не только.

## Keys

Для генерации ключа используется команда:
```bash
ssh-keygen -t ed25519
```

Используется формат ed25519, потому что RSA стандартным openssh сервером уже отвергается и приходиться прописывать в ssh_config исключения.

## Tunneling

Ssh можно использовать не только для выполнения команд, но и для проброса портов.

Для переброса порта с удалённого сервера на локальный используется `-L`:

```bash
ssh -L 2222:localhost:8080 example.server
```

В обратную сторону используется `-R` и тогда весь траффик с внешнего сервера пойдёт на локальный:

```bash
ssh -R 8080:localhost:8888 example.server
```

Подробный [мануал](https://www.ssh.com/academy/ssh/tunneling-example#remote-forwarding).

![Красивая картинка](https://iximiuz.com/ssh-tunnels/ssh-tunnels.png)

## Материалы

- https://grahamhelton.com/blog/ssh-cheatsheet/
- 
