# 3-node ZooKeeper cluster with loopback latency simulation

## Instructions:

### Install:

```bash
vagrant up
```

### Recreate cluster:

```bash
vagrant provision
```

### Restart one node, possibly causing a leader re-election:

```bash
vagrant ssh -c '//vagrant/restart-node.sh 2'
```

Instances are on ports 2181, 2182, 2183

