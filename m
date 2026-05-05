Return-Path: <linux-rdma+bounces-19977-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EOaOMg5+Wm46wIAu9opvQ
	(envelope-from <linux-rdma+bounces-19977-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 02:28:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB31B4C5606
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 02:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F369D301643C
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 00:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3073195F9;
	Tue,  5 May 2026 00:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YreCqpYl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79EA2D23A6
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 00:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777940889; cv=none; b=ltT1nRrl5AC23UOXF+j6PJOMI82oJKYCKUPHfEOe900RpcKBBaBdzAqvkOQ6EI/YtZkEMbYqo3cXUNFlGRUwgnLExgruHzi/WufkgAClMCcsu+UrRhFfMnfhth0j9PWTpPJqirjT3Z8n/nrd762QKjJvb+t8EkMn8NmAgKTXJwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777940889; c=relaxed/simple;
	bh=Qa3qVnasFjeKcLXQGuewmxcuQRVtnPk652qg+JZlmVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VV6wIihlNCz+h9YSqo+MzNrOjyE0cgCnhXem6756gLK0krRKI/kcsEtr5bIFTstxZrxfFusNk6C7uTOmVsWlQwD2cgFZ4EoKf0eNbfsrq/gQEZ959RTXukiJF9sikqnfK/iN1uf//UC7O7b+Gt+bwXdmep5PwlYA/SopChx1odg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YreCqpYl; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8d4f78fc9f6so512167085a.3
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 17:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777940885; x=1778545685; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uKo0X1zLy79YbJbsw8fyk970YAWWmEL6K2YwtNFNBfc=;
        b=YreCqpYlAMqim2AuMSaAkWfdZekd3oeuX/xVg1OR8ndHDulJrVaU/rZ4zmz8ED6HnR
         FjFRgQrbxqkOxnwbQZSUDGvWfa9vYhOFjdDcAz3cs1CRdB/B6HtM3atQw4SO+2h/2dOl
         hihuRDLbm8pycePtGr5yBu0iB0B2bx0kfXjX4XNsX4FzX7JPlN5S8Xw9+wCuaAnYLvqj
         oTLlbqNbb+6AfhJ82teP7w8L+n5WJb8NehPGuXmYbG5/PLakmo1JYLIoXY5SWejJoY7i
         mxZHOBRiYwfsM/P7Qojt71Wv3/P8GAqQbynXm3aU2tzzye9jYf1dzAgRQnCDLqSTTnMa
         7mgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777940885; x=1778545685;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uKo0X1zLy79YbJbsw8fyk970YAWWmEL6K2YwtNFNBfc=;
        b=c9k6K4tlAeD/SzEGRKAUeo3/HYEL7iirYtV/feckvrY8zNBvcQWVvJqIZSENIt40I6
         ikLo1x5tz6iWfGA3FPyvbhPQcx4bc7kHZwDjKxkJ+qukDT6bJwnqjDXx94LlgAgPN2xa
         pwgmzGQPe3AKPQfGLFppEo31M8IA5DSjH6cYN94+edVNfNkY6ehzgjh4Ach6ogJYPc65
         25AKjXZiN9Wy/PqoZuzar/IDrF+AS6Ztm/NnXEt18z4qsxDHTk7VBjDaLE5IeqZFsNTj
         Sz1E7B1am+cJnlCX3VGY/OcMmWx2SxhlL3gaMQTrMuPGP/HQtRJ4EXzj7YurOppewkMO
         HSuw==
X-Forwarded-Encrypted: i=1; AFNElJ8Llpqau4S1gWd4dxrTeqmq54LhRlQeTLdM2s0co7VtVAkH98vMCH3tUGx7q3q/4MKKNObywN8OV7xN@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo3FwYlxrmGbJFGnTgMGn8H8J9toqQzXWCQjm54lvC56rf0Te6
	umtbznfilf9WZuYMM+TCZLRG8vfDQJMjbG1wSSMLrtD6SmI+7XXMl19q
X-Gm-Gg: AeBDieuvWdOKhsYD257rgduJiz75TVFSgXUpstbo7y3q4XGlaSD25PUUnHYF4RvFTT+
	fb9W6wzXoVxmf2DcOhqqoJtDOY8oBiebV1ZU+F7/VIov3zs9AR+tPqJiW6d9cBXgI9xKGmWD7mS
	XEHZxIOzsQzAeuPypKigUVDOUJn9kkqqQc8Wssya7/q4n9pMn63K97j9OnUWbMRjn23mMQn7N+v
	C6hy3xu8mxnSAK7pl8eifugRWwpdbTYW/4DP4RILkazjNUSvtaf4D2VT+mevbblvfePpkFFerez
	PlgQrmhbGE4BRfp6A4S48WAYpbWWCHWgvM+eWyPQYH/fRdhT6lvX3xTvQzGwET5gkLUThyTgXby
	oplRg8SQ+zIf1gRRQ2mEGTYs+H8gmiSwMYaDYgZEOTwqDX7EFy9/jnG4zqb62lUWbhv/TE/42va
	zOypWUjP8ZgLOr5wILdeVHzC+12hsYd34uNdu/X+9A0NOnHvRmUUV98g==
X-Received: by 2002:a05:620a:4722:b0:8cd:8f04:50ec with SMTP id af79cd13be357-902e49b6e22mr192973685a.2.1777940884520;
        Mon, 04 May 2026 17:28:04 -0700 (PDT)
Received: from localhost ([2a03:2880:f800:29::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc29a7f4dbsm1210668885a.16.2026.05.04.17.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 17:28:04 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 04 May 2026 17:27:51 -0700
Subject: [PATCH net-next v2 4/6] selftests: drv-net: refactor devmem
 command builders into lib module
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-tcp-dm-netkit-v2-4-56d52ac72fd4@meta.com>
References: <20260504-tcp-dm-netkit-v2-0-56d52ac72fd4@meta.com>
In-Reply-To: <20260504-tcp-dm-netkit-v2-0-56d52ac72fd4@meta.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: CB31B4C5606
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19977-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.py:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,meta.com:mid,meta.com:email]

From: Bobby Eshleman <bobbyeshleman@meta.com>

Adding netkit-based devmem tests is a straight-forward copy of devmem
test commands plus some args for the nk cases, so this patch breaks out
these command builders into helpers used by both.

Though we tried to avoid libraries to avoid increasing the barrier of
entry/complexity (see selftests/drivers/net/README.md, section "Avoid
libraries and frameworks"), factoring out these functions seemed like
the lesser of two evils in this case of using the same commands, just
with slightly different args per environment.

I experimented with just having all of the tests in the same file to
avoid having helpers in a library file, but because ksft_run() is
limited to a single call per file, and the new tests will require
different environments (NetDrvContEnv/NetDrvEpEnv), it would have been
necessary to have each test set up its own environment instead of
sharing one for the entire ksft_run() run. This came at the cost of
ballooning the test time (from under 5s to 30s on my test system), so to
strike a balance these tests were placed in separate files so they could
keep a shared environment across a single ksft_run() run shared across
all tests using the same env type (introduced in subsequent patches).

The helpers work transparently with both plain and netkit environments
by inspecting cfg for netkit-specific attributes (netns, nk_queue,
etc...).

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- Move require_devmem() into individual test functions so KsftSkipEx goes up to
  ksft_run() (Sashiko)
- in ncdevmem_rx(), move -v 7 to take effect for both netns and
  non-netns when verify=True
---
 tools/testing/selftests/drivers/net/hw/devmem.py   |  73 +------
 .../selftests/drivers/net/hw/lib/py/devmem.py      | 222 +++++++++++++++++++++
 2 files changed, 231 insertions(+), 64 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index ee863e90d1e0..33648e39577a 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -1,92 +1,37 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
+"""Test devmem TCP."""
 
 from os import path
-from lib.py import ksft_run, ksft_exit
-from lib.py import ksft_eq, KsftSkipEx
+from lib.py import ksft_run, ksft_exit, ksft_disruptive
 from lib.py import NetDrvEpEnv
-from lib.py import bkg, cmd, rand_port, wait_port_listen
-from lib.py import ksft_disruptive
-
-
-def require_devmem(cfg):
-    if not hasattr(cfg, "_devmem_probed"):
-        probe_command = f"{cfg.bin_local} -f {cfg.ifname}"
-        cfg._devmem_supported = cmd(probe_command, fail=False, shell=True).ret == 0
-        cfg._devmem_probed = True
-
-    if not cfg._devmem_supported:
-        raise KsftSkipEx("Test requires devmem support")
+from lib.py.devmem import setup_test, run_rx, run_tx, run_tx_chunks, run_rx_hds
 
 
 @ksft_disruptive
 def check_rx(cfg) -> None:
-    require_devmem(cfg)
-
-    port = rand_port()
-    socat = f"socat -u - TCP{cfg.addr_ipver}:{cfg.baddr}:{port},bind={cfg.remote_baddr}:{port}"
-    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port} -c {cfg.remote_addr} -v 7"
-
-    with bkg(listen_cmd, exit_wait=True) as ncdevmem:
-        wait_port_listen(port)
-        cmd(f"yes $(echo -e \x01\x02\x03\x04\x05\x06) | \
-            head -c 1K | {socat}", host=cfg.remote, shell=True)
-
-    ksft_eq(ncdevmem.ret, 0)
+    run_rx(cfg)
 
 
 @ksft_disruptive
 def check_tx(cfg) -> None:
-    require_devmem(cfg)
-
-    port = rand_port()
-    listen_cmd = f"socat -U - TCP{cfg.addr_ipver}-LISTEN:{port}"
-
-    with bkg(listen_cmd, host=cfg.remote, exit_wait=True) as socat:
-        wait_port_listen(port, host=cfg.remote)
-        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_local} -f {cfg.ifname} -s {cfg.remote_addr} -p {port}", shell=True)
-
-    ksft_eq(socat.stdout.strip(), "hello\nworld")
+    run_tx(cfg)
 
 
 @ksft_disruptive
 def check_tx_chunks(cfg) -> None:
-    require_devmem(cfg)
-
-    port = rand_port()
-    listen_cmd = f"socat -U - TCP{cfg.addr_ipver}-LISTEN:{port}"
-
-    with bkg(listen_cmd, host=cfg.remote, exit_wait=True) as socat:
-        wait_port_listen(port, host=cfg.remote)
-        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_local} -f {cfg.ifname} -s {cfg.remote_addr} -p {port} -z 3", shell=True)
-
-    ksft_eq(socat.stdout.strip(), "hello\nworld")
+    run_tx_chunks(cfg)
 
 
 def check_rx_hds(cfg) -> None:
-    """Test HDS splitting across payload sizes."""
-    require_devmem(cfg)
-
-    for size in [1, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192]:
-        port = rand_port()
-        listen_cmd = f"{cfg.bin_local} -L -l -f {cfg.ifname} -s {cfg.addr} -p {port}"
-
-        with bkg(listen_cmd, exit_wait=True) as ncdevmem:
-            wait_port_listen(port)
-            cmd(f"dd if=/dev/zero bs={size} count=1 2>/dev/null | " +
-                f"socat -b {size} -u - TCP{cfg.addr_ipver}:{cfg.baddr}:{port},nodelay",
-                host=cfg.remote, shell=True)
-
-        ksft_eq(ncdevmem.ret, 0, f"HDS failed for payload size {size}")
+    run_rx_hds(cfg)
 
 
 def main() -> None:
     with NetDrvEpEnv(__file__) as cfg:
-        cfg.bin_local = path.abspath(path.dirname(__file__) + "/ncdevmem")
-        cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
-
+        setup_test(cfg, path.abspath(path.dirname(__file__) + "/ncdevmem"))
         ksft_run([check_rx, check_tx, check_tx_chunks, check_rx_hds],
-                 args=(cfg, ))
+                 args=(cfg,))
     ksft_exit()
 
 
diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/devmem.py b/tools/testing/selftests/drivers/net/hw/lib/py/devmem.py
new file mode 100644
index 000000000000..6f8a3f5aae14
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/devmem.py
@@ -0,0 +1,222 @@
+# SPDX-License-Identifier: GPL-2.0
+"""Shared helpers for devmem TCP selftests."""
+
+import re
+
+from net.lib.py import (bkg, cmd, defer, ethtool, rand_port, wait_port_listen,
+                        ksft_eq, KsftSkipEx, NetNSEnter, EthtoolFamily,
+                        NetdevFamily)
+
+
+def require_devmem(cfg):
+    if not hasattr(cfg, "_devmem_probed"):
+        probe_command = f"{cfg.bin_local} -f {cfg.ifname}"
+        cfg._devmem_supported = cmd(probe_command, fail=False, shell=True).ret == 0
+        cfg._devmem_probed = True
+
+    if not cfg._devmem_supported:
+        raise KsftSkipEx("Test requires devmem support")
+
+
+def configure_nic(cfg):
+    """Channels, rings, RSS, queue lease for netkit devmem.
+
+    Rings and RSS are re-applied each call because per-test defers restore
+    them after every test case. The queue lease is created only once.
+    """
+    cfg.require_ipver('6')
+    ethnl = EthtoolFamily()
+
+    channels = ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    channels = channels['combined-count']
+    if channels < 2:
+        raise KsftSkipEx(
+            'Test requires NETIF with at least 2 combined channels'
+        )
+
+    rings = ethnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+    rx_rings = rings['rx']
+    hds_thresh = rings.get('hds-thresh', 0)
+    orig_data_split = rings.get('tcp-data-split', 'unknown')
+
+    ethnl.rings_set({'header': {'dev-index': cfg.ifindex},
+                     'tcp-data-split': 'enabled',
+                     'hds-thresh': 0,
+                     'rx': min(64, rx_rings)})
+    defer(ethnl.rings_set, {'header': {'dev-index': cfg.ifindex},
+                            'tcp-data-split': orig_data_split,
+                            'hds-thresh': hds_thresh,
+                            'rx': rx_rings})
+
+    cfg.src_queue = channels - 1
+    ethtool(f"-X {cfg.ifname} equal {cfg.src_queue}")
+    defer(ethtool, f"-X {cfg.ifname} default")
+
+    if not hasattr(cfg, 'nk_queue'):
+        with NetNSEnter(str(cfg.netns)):
+            netdevnl = NetdevFamily()
+            lease_result = netdevnl.queue_create({
+                "ifindex": cfg.nk_guest_ifindex,
+                "type": "rx",
+                "lease": {
+                    "ifindex": cfg.ifindex,
+                    "queue": {"id": cfg.src_queue, "type": "rx"},
+                    "netns-id": 0,
+                },
+            })
+            cfg.nk_queue = lease_result['id']
+
+
+def set_flow_rule(cfg, port):
+    output = ethtool(
+        f"-N {cfg.ifname} flow-type tcp6 dst-port {port}"
+        f" action {cfg.src_queue}"
+    ).stdout
+    return int(re.search(r'ID (\d+)', output).group(1))
+
+
+def ncdevmem_rx(cfg, port, verify=True, fail_on_linear=False, flow_steer=False):
+    if hasattr(cfg, 'netns'):
+        flow_rule_id = set_flow_rule(cfg, port)
+        defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
+
+        ifname = cfg._nk_guest_ifname
+        addr = cfg.nk_guest_ipv6
+        extras = f" -t {cfg.nk_queue} -q 1 -n"
+    else:
+        ifname = cfg.ifname
+        addr = cfg.addr
+
+        extras = ""
+        if flow_steer:
+            extras += f"-c {cfg.remote_addr}"
+
+    if verify:
+        extras += " -v 7"
+
+    if fail_on_linear:
+        extras += " -L"
+
+    return f"{cfg.bin_local} -l -f {ifname} -s {addr} -p {port} {extras}"
+
+
+def ncdevmem_tx(cfg, port, chunk_size=0):
+    """ncdevmem TX send command (without stdin pipe)."""
+    if hasattr(cfg, 'netns'):
+        ifname = cfg._nk_guest_ifname
+        addr = cfg.remote_addr_v['6']
+        nk_args = "-t 0 -q 1 -n"
+    else:
+        ifname = cfg.ifname
+        addr = cfg.remote_addr
+        nk_args = ""
+
+    chunk = f"-z {chunk_size}" if chunk_size else ""
+
+    return (f"{cfg.bin_local} -f {ifname} -s {addr} -p {port}"
+            f" {nk_args} {chunk}").rstrip()
+
+
+def socat_send(cfg, port, buf_size=0, nodelay=False, bind=False):
+    """Socat command for sending to the devmem listener."""
+    proto = f"TCP{cfg.addr_ipver}"
+
+    if hasattr(cfg, 'netns'):
+        addr = f"[{cfg.nk_guest_ipv6}]"
+    else:
+        addr = cfg.baddr
+
+    buf = f"-b {buf_size} " if buf_size else ""
+
+    suffix = ""
+    if nodelay:
+        suffix += ",nodelay"
+    # Match the 5-tuple flow rule ncdevmem installs when given -c.
+    if bind:
+        suffix += f",bind={cfg.remote_baddr}:{port}"
+
+    return f"socat {buf}-u - {proto}:{addr}:{port}{suffix}"
+
+
+def socat_listen(cfg, port):
+    """Socat listen command for TX tests."""
+    proto = f"TCP{cfg.addr_ipver}"
+
+    if hasattr(cfg, 'netns'):
+        opts = ",reuseaddr"
+    else:
+        opts = ""
+
+    return f"socat -U - {proto}-LISTEN:{port}{opts}"
+
+
+def setup_test(cfg, bin_local):
+    cfg.bin_local = bin_local
+    cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
+    cfg.listen_ns = getattr(cfg, 'netns', None)
+
+
+def run_rx(cfg):
+    require_devmem(cfg)
+    if hasattr(cfg, 'netns'):
+        configure_nic(cfg)
+    port = rand_port()
+    socat = socat_send(cfg, port)
+    data_pipe = (f"yes $(echo -e \x01\x02\x03\x04\x05\x06) | head -c 1K"
+                 f" | {socat}")
+    ns = getattr(cfg, "netns", None)
+
+    listen_cmd = ncdevmem_rx(cfg, port)
+    with bkg(listen_cmd, exit_wait=True, ns=ns) as ncdevmem:
+        wait_port_listen(port, proto="tcp", ns=ns)
+        cmd(data_pipe, host=cfg.remote, shell=True)
+    ksft_eq(ncdevmem.ret, 0)
+
+
+def run_tx(cfg):
+    require_devmem(cfg)
+    if hasattr(cfg, 'netns'):
+        configure_nic(cfg)
+    ns = getattr(cfg, "netns", None)
+    port = rand_port()
+    tx = ncdevmem_tx(cfg, port)
+    listen_cmd = socat_listen(cfg, port)
+
+    with bkg(listen_cmd, host=cfg.remote, exit_wait=True) as socat:
+        wait_port_listen(port, host=cfg.remote)
+        cmd(f"bash -c 'echo -e \"hello\\nworld\" | {tx}'", ns=ns, shell=True)
+    ksft_eq(socat.stdout.strip(), "hello\nworld")
+
+
+def run_tx_chunks(cfg):
+    require_devmem(cfg)
+    if hasattr(cfg, 'netns'):
+        configure_nic(cfg)
+    ns = getattr(cfg, "netns", None)
+    port = rand_port()
+    tx = ncdevmem_tx(cfg, port, chunk_size=3)
+    listen_cmd = socat_listen(cfg, port)
+
+    with bkg(listen_cmd, host=cfg.remote, exit_wait=True) as socat:
+        wait_port_listen(port, host=cfg.remote)
+        cmd(f"bash -c 'echo -e \"hello\\nworld\" | {tx}'", ns=ns, shell=True)
+    ksft_eq(socat.stdout.strip(), "hello\nworld")
+
+
+def run_rx_hds(cfg):
+    require_devmem(cfg)
+    if hasattr(cfg, 'netns'):
+        configure_nic(cfg)
+    ns = getattr(cfg, "netns", None)
+
+    for size in [1, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192]:
+        port = rand_port()
+
+        listen_cmd = ncdevmem_rx(cfg, port, verify=False, fail_on_linear=True)
+        socat = socat_send(cfg, port, buf_size=size, nodelay=True)
+
+        with bkg(listen_cmd, exit_wait=True, ns=ns) as ncdevmem:
+            wait_port_listen(port, proto="tcp", ns=ns)
+            cmd(f"dd if=/dev/zero bs={size} count=1 2>/dev/null | "
+                f"{socat}", host=cfg.remote, shell=True)
+        ksft_eq(ncdevmem.ret, 0, f"HDS failed for payload size {size}")

-- 
2.52.0


