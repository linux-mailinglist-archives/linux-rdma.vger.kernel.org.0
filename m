Return-Path: <linux-rdma+bounces-20205-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOp6KIlK/WmUaAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20205-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 04:29:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A659A4F0C50
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 04:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 165C4301A53F
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 02:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44182F8E97;
	Fri,  8 May 2026 02:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ie0ipZKK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE91026B74A
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 02:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778207314; cv=none; b=m9/IebYO7l76dH08L77ViSHP1RG56KIDz7ALKJMN9c0pzRbdEoQjyExVu8Pl6AJEO0M7VtbBvXZ5ecLFfCQVVm/5RfUv/s/0w6kYJlkWG95f/wHvC+QutDy/T7qdWSc2lW+A3yeeyd3ZVcTLLU5E2fAeObazQR1OeM1RqKGf7jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778207314; c=relaxed/simple;
	bh=wr5nOXXQbhXEnUpfkQ7Zz1wqfSv32AZh5IA6v1MiYWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DhFNKCe9bbcXzahdKVjt3mx2ma/0mIbN19SPdFODsCFlJPskyp7j3kQMyDpNhjDS88B9RgQWeDnG57zyyRQSpzXhyrIdMSchbpUyzyDxNY1uUdATuVM6ERXHjuS9wng+xASCKZmRyt0oVarvBFasO0QrnMFrzch8MaxEgXlA1yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ie0ipZKK; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8ef45a6d9dfso166676085a.0
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 19:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778207306; x=1778812106; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWcQzpCH4lUDwqOSoMTuBZLXwluzgAdtBYZzZZPaRJY=;
        b=Ie0ipZKKZsKfD9pFeSwmi5yyvI93riVlntxEIZz457M997K6+OT1JRr2ZCMznuMH9N
         Q2GFfMftnUNPeRYXlgkJRwS68bKJiVLvxsBAw5Rq0mvJ2OYE41psu8GHozLt9UKK++dR
         c26FrhzitJeewNLL3UbkOmEVItWNy2RQDzHn10YCi8XhSxsBdjhcIyzF8xBb+eM3xsRm
         u0UFjVholqSZPETOcWgbozvEWTgZsB0Uh+aXV0EieTsqzaz7YT+kcQsFS5NZ2LmVcvj7
         4d1LpLwSQh6dqiT849d1K0SbaARG3OgOcqBtCWvgswjr5gnSnB4zvEnn7tHeIV3F0YnW
         +5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778207306; x=1778812106;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aWcQzpCH4lUDwqOSoMTuBZLXwluzgAdtBYZzZZPaRJY=;
        b=HKZvvj3aCRxhXbhbpw5ZKfAiF5ejDDxqfyWryg1nO5NekK0VWS634HdV3OMK0GztLq
         Tc9Obmwre1sa+xus0tGF45WdnzA9rjiePpE8zXeDpRr/xdY5zlvjmPqXy9tLoxDxy/nA
         10JwLIofwCfj+xO929xYuKT75G5Ke9IIqtwlJcTze3CxW6vfQ3UCvYUSblQwOqUu4vRZ
         8I2LbTRD57Vu/+27omeyw7N5SKPPfGr70upFBhcxVrB70ceNLzTy7tOohInIVL1s4hpG
         1XFwOma8RxeqHX2mbrZDHrHFQbU3VAOWkb0+9RBzNEqSou5mQzr6CCxmuNGrz9CHdK0J
         1h4w==
X-Forwarded-Encrypted: i=1; AFNElJ+CnAI9J9yFC2U9AXXw+0uQ5JcYa9Q0Dvp2e8g0VQOCgGTkxrZBWTmw9/7GeB1T/KYz58KJMEMgr0R7@vger.kernel.org
X-Gm-Message-State: AOJu0YymVEHNwvF0vMFAFTQ0Xo1BZZHscLNt88KJx7N6/iEN423IiSHi
	1/lFVVX2FBrOhh+SnflKy0/3ijXiTjQfROe06b82cfbhYdt8emJxPVvP
X-Gm-Gg: AeBDievvf+v2xLewZNRPYcnJLt528Z3F9xWqx3rc03ze/0OOn/QXx5XSZ1ovSNubJE1
	JgvL1GmB2AwHQvEJQ+WfYk/2kjTmtdVAcEPzOJjJG6STMv/i1jZQoqkFkIDW7C7RSMtffCZ1ITQ
	oeUo54fGthmcwWA88ExrlxyuRWKivwtm7ZX+v05D7XBwnz475YZ4aviNl054mLkg9gjiN+4wrYV
	irgmWJjGpmBQt4LhTAZPsv+NfHFmJDxhefeyaj59Cyx77uQFv0TAyTvUnlmFqJkmAWJ4MnCAfvq
	QsDGrHomqIjEYHrxtTdimn/w6dRW47WfNl4NouJmcdtK2Sar9NIJTPoIOvcZnwS6Ozxf/bCzcqk
	/H3VFTDV/u1IH84qL8i3Q8NLKPf3T0+ilkFsCGVWas0vY4ujhP4IbY5jSZbWpz59i8NaJrmr3xG
	VxoOwMpzsBFaKa9g0KRIsM
X-Received: by 2002:a05:620a:448e:b0:8cd:871c:909d with SMTP id af79cd13be357-904d69e05d9mr1551888485a.53.1778207305584;
        Thu, 07 May 2026 19:28:25 -0700 (PDT)
Received: from localhost ([2a03:2880:f800:b::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b9380925sm63082585a.11.2026.05.07.19.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:28:25 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 07 May 2026 19:27:51 -0700
Subject: [PATCH net-next v3 6/8] selftests: drv-net: refactor devmem
 command builders into lib module
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-tcp-dm-netkit-v3-6-52821445867c@meta.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
In-Reply-To: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
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
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
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
Cc: dw@davidwei.uk, sdf.kernel@gmail.com, mohsin.bashr@gmail.com, 
 willemb@google.com, jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, 
 wang.yaxin@zte.com.cn, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: A659A4F0C50
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-20205-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[davidwei.uk,gmail.com,google.com,zte.com.cn,vger.kernel.org,fomichev.me,meta.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_GT_50(0.00)[70];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
Changes in v4:
- Make socat_send() always bind the source; drop its bind= parameter
  and the matching bind=not_ns at the run_rx call site.
- Drop socat_send()'s nodelay= arg; have buf_size>0 imply TCP_NODELAY
  since they are only meaningful together.
- configure_nic(): stash originals on cfg instead of using defer(); add
  paired cleanup_nic() helper. Drop the per-test configure_nic() calls
  from run_rx/run_tx/run_tx_chunks/run_rx_hds; the netkit test file
  invokes configure_nic/cleanup_nic once around ksft_run().
- make cfg.devmem_supported and cfg.devmem_probed public attrs (no '_')
  for sake of linting
- general cleanup of the code, linting fixes

Changes in v3:
- In setup_test, drop the unused cfg.listen_ns = getattr(cfg, 'netns',
  None) assignment.
- In run_rx, pass flow_steer=not_ns to ncdevmem_rx and bind=not_ns to
  socat_send to avoid changing functionality (we want just a straight
  refactor here)

Changes in v2:
- Move require_devmem() into individual test functions so KsftSkipEx goes up to
  ksft_run() (Sashiko)
- in ncdevmem_rx(), move -v 7 to take effect for both netns and
  non-netns when verify=True
---
 tools/testing/selftests/drivers/net/hw/devmem.py   |  77 ++------
 .../selftests/drivers/net/hw/lib/py/devmem.py      | 218 +++++++++++++++++++++
 2 files changed, 231 insertions(+), 64 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index ee863e90d1e0..dbc1e6a27b6a 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -2,91 +2,40 @@
 # SPDX-License-Identifier: GPL-2.0
 
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
+    """Run the devmem RX test."""
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
+    """Run the devmem TX test."""
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
+    """Run the devmem TX chunking test."""
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
+    """Run the HDS test."""
+    run_rx_hds(cfg)
 
 
 def main() -> None:
+    """Run the devmem test cases."""
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
index 000000000000..d3e7a3645cba
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/devmem.py
@@ -0,0 +1,218 @@
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
+    """Probe ncdevmem on cfg.ifname and SKIP the test if devmem isn't supported."""
+    if not hasattr(cfg, "devmem_probed"):
+        probe_command = f"{cfg.bin_local} -f {cfg.ifname}"
+        cfg.devmem_supported = cmd(probe_command, fail=False, shell=True).ret == 0
+        cfg.devmem_probed = True
+
+    if not cfg.devmem_supported:
+        raise KsftSkipEx("Test requires devmem support")
+
+
+def configure_nic(cfg):
+    """Channels, rings, RSS, queue lease for netkit devmem."""
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
+    cfg.orig_rx_rings = rings['rx']
+    cfg.orig_hds_thresh = rings.get('hds-thresh', 0)
+    cfg.orig_data_split = rings.get('tcp-data-split', 'unknown')
+
+    ethnl.rings_set({'header': {'dev-index': cfg.ifindex},
+                     'tcp-data-split': 'enabled',
+                     'hds-thresh': 0,
+                     'rx': min(64, cfg.orig_rx_rings)})
+
+    cfg.src_queue = channels - 1
+    ethtool(f"-X {cfg.ifname} equal {cfg.src_queue}")
+
+    with NetNSEnter(str(cfg.netns)):
+        netdevnl = NetdevFamily()
+        lease_result = netdevnl.queue_create({
+            "ifindex": cfg.nk_guest_ifindex,
+            "type": "rx",
+            "lease": {
+                "ifindex": cfg.ifindex,
+                "queue": {"id": cfg.src_queue, "type": "rx"},
+                "netns-id": 0,
+            },
+        })
+        cfg.nk_queue = lease_result['id']
+
+
+def cleanup_nic(cfg):
+    """Undo configure_nic() by restoring RSS and ring settings."""
+    ethtool(f"-X {cfg.ifname} default")
+    EthtoolFamily().rings_set({'header': {'dev-index': cfg.ifindex},
+                               'tcp-data-split': cfg.orig_data_split,
+                               'hds-thresh': cfg.orig_hds_thresh,
+                               'rx': cfg.orig_rx_rings})
+
+
+def set_flow_rule(cfg, port):
+    """Install a flow rule steering to src_queue and return the flow rule ID."""
+    output = ethtool(
+        f"-N {cfg.ifname} flow-type tcp6 dst-port {port}"
+        f" action {cfg.src_queue}"
+    ).stdout
+    return int(re.search(r'ID (\d+)', output).group(1))
+
+
+def ncdevmem_rx(cfg, port, verify=True, fail_on_linear=False, flow_steer=False):
+    """Build the ncdevmem RX listener command."""
+    if hasattr(cfg, 'netns'):
+        flow_rule_id = set_flow_rule(cfg, port)
+        defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
+
+        ifname = cfg.nk_guest_ifname
+        addr = cfg.nk_guest_ipv6
+        extras = [f"-t {cfg.nk_queue}", "-q 1", "-n"]
+    else:
+        ifname = cfg.ifname
+        addr = cfg.addr
+        extras = []
+        if flow_steer:
+            extras.append(f"-c {cfg.remote_addr}")
+
+    if verify:
+        extras.append("-v 7")
+    if fail_on_linear:
+        extras.append("-L")
+
+    parts = [cfg.bin_local, "-l", f"-f {ifname}", f"-s {addr}",
+             f"-p {port}", *extras]
+    return " ".join(parts)
+
+
+def ncdevmem_tx(cfg, port, chunk_size=0):
+    """Build the ncdevmem TX send command."""
+    if hasattr(cfg, 'netns'):
+        ifname = cfg.nk_guest_ifname
+        addr = cfg.remote_addr_v['6']
+        extras = ["-t 0", "-q 1", "-n"]
+    else:
+        ifname = cfg.ifname
+        addr = cfg.remote_addr
+        extras = []
+
+    if chunk_size:
+        extras.append(f"-z {chunk_size}")
+
+    parts = [cfg.bin_local, f"-f {ifname}", f"-s {addr}",
+             f"-p {port}", *extras]
+    return " ".join(parts)
+
+
+def socat_send(cfg, port, buf_size=0):
+    """Socat command for sending to the devmem listener.
+
+    When buf_size > 0, force one TCP segment per write of exactly that size by
+    setting socat's buffer (-b) and disabling Nagle (TCP_NODELAY).
+    """
+    proto = f"TCP{cfg.addr_ipver}"
+
+    if hasattr(cfg, 'netns'):
+        addr = f"[{cfg.nk_guest_ipv6}]"
+    else:
+        addr = cfg.baddr
+
+    suffix = f",bind={cfg.remote_baddr}:{port}"
+
+    buf = ""
+    if buf_size:
+        buf = f"-b {buf_size}"
+        suffix += ",nodelay"
+
+    return f"socat {buf} -u - {proto}:{addr}:{port}{suffix}"
+
+
+def socat_listen(cfg, port):
+    """Socat listen command for TX tests."""
+    return f"socat -U - TCP{cfg.addr_ipver}-LISTEN:{port}"
+
+
+def setup_test(cfg, bin_local):
+    """Stash the local ncdevmem path on cfg and deploy it to the remote."""
+    cfg.bin_local = bin_local
+    cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
+
+
+def run_rx(cfg):
+    """Run the devmem RX test."""
+    require_devmem(cfg)
+    port = rand_port()
+    socat = socat_send(cfg, port)
+    data_pipe = (f"yes $(echo -e \x01\x02\x03\x04\x05\x06) | head -c 1K"
+                 f" | {socat}")
+    netns = getattr(cfg, "netns", None)
+
+    listen_cmd = ncdevmem_rx(cfg, port, flow_steer=not hasattr(cfg, 'netns'))
+    with bkg(listen_cmd, exit_wait=True, ns=netns) as ncdevmem:
+        wait_port_listen(port, proto="tcp", ns=netns)
+        cmd(data_pipe, host=cfg.remote, shell=True)
+    ksft_eq(ncdevmem.ret, 0)
+
+
+def run_tx(cfg):
+    """Run the devmem TX test."""
+    require_devmem(cfg)
+    netns = getattr(cfg, "netns", None)
+    port = rand_port()
+    tx_cmd = ncdevmem_tx(cfg, port)
+    listen_cmd = socat_listen(cfg, port)
+
+    with bkg(listen_cmd, host=cfg.remote, exit_wait=True) as socat:
+        wait_port_listen(port, host=cfg.remote)
+        cmd(f"bash -c 'echo -e \"hello\\nworld\" | {tx_cmd}'", ns=netns, shell=True)
+    ksft_eq(socat.stdout.strip(), "hello\nworld")
+
+
+def run_tx_chunks(cfg):
+    """Run the devmem TX chunking test."""
+    require_devmem(cfg)
+    netns = getattr(cfg, "netns", None)
+    port = rand_port()
+    tx_cmd = ncdevmem_tx(cfg, port, chunk_size=3)
+    listen_cmd = socat_listen(cfg, port)
+
+    with bkg(listen_cmd, host=cfg.remote, exit_wait=True) as socat:
+        wait_port_listen(port, host=cfg.remote)
+        cmd(f"bash -c 'echo -e \"hello\\nworld\" | {tx_cmd}'", ns=netns, shell=True)
+    ksft_eq(socat.stdout.strip(), "hello\nworld")
+
+
+def run_rx_hds(cfg):
+    """Run the HDS test by running devmem RX across a segment size sweep."""
+    require_devmem(cfg)
+    netns = getattr(cfg, "netns", None)
+
+    for size in [1, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192]:
+        port = rand_port()
+
+        listen_cmd = ncdevmem_rx(cfg, port, verify=False,
+                                 fail_on_linear=True)
+        socat = socat_send(cfg, port, buf_size=size)
+
+        with bkg(listen_cmd, exit_wait=True, ns=netns) as ncdevmem:
+            wait_port_listen(port, proto="tcp", ns=netns)
+            cmd(f"dd if=/dev/zero bs={size} count=1 2>/dev/null | "
+                f"{socat}", host=cfg.remote, shell=True)
+        ksft_eq(ncdevmem.ret, 0, f"HDS failed for payload size {size}")

-- 
2.53.0-Meta


