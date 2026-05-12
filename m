Return-Path: <linux-rdma+bounces-20443-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLwnDUuBAmqAtwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20443-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 03:24:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C873518334
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 03:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D40B1309EA7D
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 01:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8732F18FDBE;
	Tue, 12 May 2026 01:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAst1Ifu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C207530E84A
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 01:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778548728; cv=none; b=dQz6iJQMAf5+IgpioUPRC7inQiJ8jKzr2w5KUrPaxrYl/WnuNM9BzN+Q9436vKjFqTfyamjpPl6JZ0Q2dRKWHCQW4nlt1q8LX4C3gEokjSpYMr/wxNACQ8kKVUOn/+FJjWMIHzzwe/dPWhbDaRak38cJvmeI8vcKcXIR8FBi/k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778548728; c=relaxed/simple;
	bh=epQpfK9MSdf9Lkqj78QKFmtwPQbQQ3QJ5WPjew3n+tk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KSRq9rgVFtRzrC/STwYaNJDdA2NS0et2ernQ9CDnNtCU8T4fOqbLlshDOkvzX9SK7weVVrGCLYCi4hgveIBSNRDYoXy15cd/vEq9NlBsvX21g5xGZi7h0MS20Ti23a19M72GiBuo9iCpAAcn/CVqRaw4VUWpEhxPQHkamGHIqXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rAst1Ifu; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-65d071aac6eso4486268d50.0
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 18:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778548701; x=1779153501; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGlgGG0HcaZYFyQRM9KLJ9chCZP0emxdYmUdgJoNtbw=;
        b=rAst1IfuGJ5CMSRhJSlOJK5BOhGGyGtAVUabei+sTp6fb1708r1aMRspQE/Eb0guyF
         Pf0+NX+eKbAKVKeMYqckNKVOKDEfoLa+9nyaE7dMpWvnytAxtlK9Sam+gOBS40JySGpx
         7RCIggMUNiRI1GnOe/5JLulrL1jSwlZAjkbM8Y8ZTdjYZbQQ3u5rJDx6lGu608YBjmKc
         pOTSjqSal3wNnymvaYKo88AxaF3u+hpjjFP2+9x/VnEPFuBRoPm+zmWqwZTnJ2vJGmPt
         9JvNqPbJjfIistG4jby3DfDnrCxIybb2eskQWLKNUkrXreJgVpog/D55XFt0Uw+0kGmh
         rXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778548701; x=1779153501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JGlgGG0HcaZYFyQRM9KLJ9chCZP0emxdYmUdgJoNtbw=;
        b=c5a12vPybslBj30HezlW5JOQTXIU0G/wqCG5iiZBsqOlcP4oZlMSTs+5xCU79DXGTq
         5F7Syy8v9cAtR5VJ6yybcJfQzIJ0kSNeycBSOJtWsOqQfxmq5TLa6v0aRQSukVd1oLEK
         fVGMNUIf6xAIZaBjoEDHGwkA3Oyxj9LFrImveQ/Rl3qdQtV7vhojBpvdD0F2YEp5pBBM
         jolp3S/qv8JQrqVmYAhvlaFqbHXUXn6YBQHzPvn26n+wJQve3gbSd110kUFFGlGJu6rl
         U1QtWytwFr+ebDdiVrm1zxWh8LyEgDIA2mdt7z+YxOaggecNs4INFEyVlype+qZiWZ5B
         4piA==
X-Forwarded-Encrypted: i=1; AFNElJ833Ex57zX3yPTN3o2JdrFdQ9jAhtwSm6AwbmPg0oNKSSHz2gn9QD6LoDzVsvLHGIwQ1cJFHwf2XSHE@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2i9SCMs0gCqwZpF8frts6MEV+50pKRTnNooNQQiCZGuD2q5JO
	tjB508BTDawZtxhmZ6P6QnsAKJShvjQIFQJlRtAWGh12rgoodWUCjesK
X-Gm-Gg: Acq92OGDS2CDWhG3AyeEWMlbzJfcqg3Eo6Hf6Wk8rfQUcZQe7iZ7kRnM2RNu0GW86U7
	SQ6BVSd6kNzF3/1vAZjFIhi///Gf4qg7H/hnl2aLI+423+KwCss8XYtxl9wfXDvDph+KgbvYuN+
	55pHZISoSNheVR6tmXKjRikoxhHobRhHbfLow8mW3vCpAyI0U8woIPpb8TKRjo9C24BeDXkSevC
	+8bywsrUd60eDN2paNKha0pr2Jx88QWuudOjIv15opeO+y8dH7JF+7AEiHhmmy6QF0gXUcjgseT
	DBo2qPD9QljWzMRxp34TXdWHw2VIjSXKAMNJ/0Q58Mt3Z0jTRGCGPMSYQLMxX21V+SsSZy+8IIq
	aE9ehfYcvuNSrKiKoy3EF0nVZLnQR169IZLi0zN4i7Q/l7rO0PuM62UdvylpOq82W5FzBueWbtJ
	14bn/yCzHfGnlwJipHnEUxtOVrECZ4sGg=
X-Received: by 2002:a05:690e:d01:b0:654:63e0:d1d1 with SMTP id 956f58d0204a3-65c79d13383mr28050604d50.43.1778548701306;
        Mon, 11 May 2026 18:18:21 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:7::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d96a67a9bsm6120649d50.9.2026.05.11.18.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:18:21 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 11 May 2026 18:18:00 -0700
Subject: [PATCH net-next v4 6/8] selftests: drv-net: refactor devmem
 command builders into lib module
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-tcp-dm-netkit-v4-6-841b78b99d74@meta.com>
References: <20260511-tcp-dm-netkit-v4-0-841b78b99d74@meta.com>
In-Reply-To: <20260511-tcp-dm-netkit-v4-0-841b78b99d74@meta.com>
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
X-Rspamd-Queue-Id: 7C873518334
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-20443-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[davidwei.uk,gmail.com,google.com,zte.com.cn,vger.kernel.org,fomichev.me,meta.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.py:url,meta.com:email,meta.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email]
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

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v4:
- Fixed bad change list version, v4 -> v3 (Stan)

Changes in v3:
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


