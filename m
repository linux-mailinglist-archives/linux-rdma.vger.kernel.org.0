Return-Path: <linux-rdma+bounces-19710-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDTQISo58Wm/egEAu9opvQ
	(envelope-from <linux-rdma+bounces-19710-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:48:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BBC48CCCE
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15FBB30B4F3C
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 22:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F7C3A4F5A;
	Tue, 28 Apr 2026 22:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBzO3gi1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAEA3A3E65
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 22:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416147; cv=none; b=Wsj4rPVq/OlPwz6LPrfMSHL0ORjD6Zo85ucorLUrEc1l4MYShQ2Y6VOknhyx2HAIC8TjUb5Q+4efMGphDUIVWhZfZtPoZC5lsDK8jYnsZelCfMVpZhLucnoXCq9q3FsohFjCKzi8fx+iiTlSDGFoARj2yNgQO/63ZAwh31VDDRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416147; c=relaxed/simple;
	bh=Z+KSX41d6V07NDJYlZrWymWSIrW05h06dGJ5dmEO0so=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N7R4AhH/SRQBJkhxoe8S0SwRl7OtcuWWyaKqW2m1Sr09ssOtqcX7a5OKBQjsAHov/ldqUdJ3SJbWSlj/Il85FKxpDi0Wc1jgCkawoJJJmHWPx6meqQf5FcrzUXmIc/kuF4a9ZayXtJD0mONp1sFM7T0KEuQnaxGUyzD0B+pxRXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBzO3gi1; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f8b60e485so4984380b3a.0
        for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 15:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777416144; x=1778020944; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NwRH1bwDDN+6gtAVtp6tT94FrtoOSiX4OwTkZsArKRc=;
        b=HBzO3gi1gq1gQPrN8iRw+x6g3mq3W/igaNDqqYmiav4eWkTiC0ac08awPHzF8uTROj
         wOdq9Qbuh801CzcfrZsuIG8LMt++NTOxn57g0eD5QgrFa4enw6vG3A1BBo4eKIKaNK+j
         pQOhGYw8jx1jc4f9l5QT7ON5OLXE0Jq7KWqzHbAgYmC+Jt11I5cHysTsOtMyo5IYtFVZ
         nB9opP/+2UE/JhYjl/5AnSi95OVJ6Dr/XbYef1pKAWaR7a9oCPQw96AVxmAaqvGn/RNo
         CUWaOX6MB08FoQ+j955D6tNnjXiAXLrSTmcKhFwN1NigNdJKUpcxk5T2tM5iXb2gyyMf
         AK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777416144; x=1778020944;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NwRH1bwDDN+6gtAVtp6tT94FrtoOSiX4OwTkZsArKRc=;
        b=cyGOAGA8/an8nYsxuSvlZhw+juAiQlChsKG519NMuN5GYl24hWyvExwigB/SsLwqBt
         ht27JnMIRj1JnLX9hi40dulbqbmxvl5B5TVRj7DfthSAf1DYzR2oMVahF960HLNqYjSQ
         wSI32rKzkzjqg+ReTOW6wgCP6w7yHA5Pe7Emz0pYMixzeGR5hAiB65zORdH5BoYKwFY4
         f9LddaIHEMF8r42Ly4MG4x+R4O+OCCecARUpmD0X2Zng/xogX586HPgHEfoEK7+EgdKt
         AzcyQIS4uXfK1PTQ1/ImPL+/R1/b3SaLKJ4n5pWHMePKLfKBOVMdCFA5DSDIZFZ31NNk
         SCWg==
X-Forwarded-Encrypted: i=1; AFNElJ/WreP8eKTF5JNuK35B5TxsH/tJTwoSnHrwt1TjdoUa/qelG0Dcyi+j1KZsGAKQBN7HyMoI0NqfogEx@vger.kernel.org
X-Gm-Message-State: AOJu0YwVN9Q7bfxYlJsEfsT6JdNI4gKzCwxJ7OpZk5yLDd9yb8bC5acs
	2l21/DwxLh3f/0MsfPEyEyXRqNbYBh4biYLM+M31QytcILsS111sBtdq
X-Gm-Gg: AeBDieswk9Sdh/HpdC9vhmJ/g+ZsP0Uo8vZG6YIztzWXhqgTLiBCGzbmt6HM+0v5fbc
	OiinxdF7yEipqwQlDYhT9scrACvat77/oyQc7v6SUBjWGWQ3jO54MR1XBdFv77a6kqXlhdCsEiS
	oKeDCggmdKgzZrzvCjFQ7i/FbSNWc1FFVrAjiPuyo06ZwBPPMBt5r5WTjN8dttcFHavxOT/EqaI
	vuVe+2BX6C5hoIl/1yjhsKFy1pdDoiR2N8rRtGlzWUy44tR8lBTIzv/zvOnW/3eEbXxheXqf3oT
	B+/4zf3bPLF3mWn3IwDZtU8puRHPu9sbqJ6xDTj2u2sWv/AwyBqoW7Nrvy9sgKX+JZ9LMg89ARL
	7jWW0YLLd18v5/4G0gUz4Mzg7sgv1AgugB8TYGuFI9TGahIQqHIoH56X7xlrVxvXh1ScaMZWKJR
	Bc8rguWZ7XfbQSNEK4EJ9MDvLnszuJ7w==
X-Received: by 2002:a05:6a00:99f:b0:82f:6a64:deac with SMTP id d2e1a72fcca58-834ddbebdf9mr5161857b3a.28.1777416144009;
        Tue, 28 Apr 2026 15:42:24 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80de21sm97981b3a.55.2026.04.28.15.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:42:23 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 28 Apr 2026 15:42:06 -0700
Subject: [PATCH net-next 09/11] selftests: drv-net: refactor devmem command
 builders into lib module
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tcp-dm-netkit-v1-9-719280eba4d2@meta.com>
References: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
In-Reply-To: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
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
X-Rspamd-Queue-Id: 38BBC48CCCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19710-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.py:url,devmem.py:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:mid,meta.com:email]

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

No functional change to the existing devmem.py tests.

Assisted-by: Claude Code:claude-sonnet-4-6
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/drivers/net/hw/devmem.py   |  73 +------
 .../selftests/drivers/net/hw/lib/py/devmem.py      | 215 +++++++++++++++++++++
 2 files changed, 224 insertions(+), 64 deletions(-)

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
index 000000000000..e95fc38337fa
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/devmem.py
@@ -0,0 +1,215 @@
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
+def ncdevmem_rx(cfg, port, verify=True, fail_on_linear=False):
+    if hasattr(cfg, 'netns'):
+        flow_rule_id = set_flow_rule(cfg, port)
+        defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
+
+        ifname = cfg._nk_guest_ifname
+        addr = cfg.nk_guest_ipv6
+        extras = f" -t {cfg.nk_queue} -q 1 -n"
+        if verify:
+            extras += " -v 7"
+    else:
+        ifname = cfg.ifname
+        addr = cfg.addr
+        extras = ""
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
+    require_devmem(cfg)
+
+
+def run_rx(cfg):
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


