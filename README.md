# llama.cpp

**Run any GGUF model locally — share it with the world in seconds.**

A Make-driven wrapper around the [llama.cpp](https://github.com/ggml-org/llama.cpp) server and [Cloudflare quick tunnels](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/do-more-with-tunnels/trycloudflare/). No builds, no config files — just `make`.

[Quick Start](#quick-start) · [Public Tunnel](#public-tunnel) · [Commands](#commands) · [Configuration](#configuration) · [API](#api)

**Requirements:** `make` · `curl` · `wget` · Linux x86-64 (for the tunnel)

---

## Quick Start

```bash
make install     # 1 · install the llama CLI
make run         # 2 · start the server → http://127.0.0.1:8060
make health      # 3 · verify it's up (from a second terminal)
```

## Public Tunnel

```bash
make -f Makefile.tunnel install    # 1 · download cloudflared (first time only)
make -f Makefile.tunnel run        # 2 · start the tunnel in the background
make -f Makefile.tunnel url        # 3 · print your public https URL
make -f Makefile.tunnel stop       # 4 · stop the tunnel when done
```

---

## Commands

### Server — `Makefile`

| Command | Description |
| --- | --- |
| `make install` | Install llama.cpp via [llama.app](https://llama.app) |
| `make run` | Start the server |
| `make cli` | Chat with the model in the terminal |
| `make health` | Check server health |
| `make clean` | Remove the installation |

### Tunnel — run as `make -f Makefile.tunnel <cmd>`

| Command | Description |
| --- | --- |
| `install` | Download `cloudflared` |
| `run` | Start the tunnel (background) |
| `url` | Print the public URL |
| `stop` | Stop the tunnel |
| `clean` | Remove `cloudflared` + logs |

---

## Configuration

| Variable | Default | Used by |
| --- | --- | --- |
| `MODEL` | `Qwen/Qwen3-1.7B-GGUF` | Server |
| `HOST` | `127.0.0.1` | Server + Tunnel |
| `PORT` | `8060` | Server + Tunnel |

Override inline — keep `HOST`/`PORT` in sync between the two Makefiles:

```bash
make run MODEL=ggml-org/gemma-3-4b-it-GGUF PORT=9000
make -f Makefile.tunnel run PORT=9000
```

## API

The server exposes an OpenAI-compatible API:

```bash
curl http://127.0.0.1:8060/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"messages": [{"role": "user", "content": "Hello!"}]}'
```

Other endpoints: `/health` · `/v1/models` · `/props`

---

> **Note:** the tunnel URL is public and unauthenticated — stop it when you're done.
