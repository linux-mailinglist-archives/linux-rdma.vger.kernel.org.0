Return-Path: <linux-rdma+bounces-20442-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JYZJS+AAmpDtwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20442-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 03:19:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EC151821B
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 03:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B59FB30331AF
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 01:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF1B2E0413;
	Tue, 12 May 2026 01:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGD1xBAm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106E52BE053
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 01:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778548709; cv=none; b=mhsI/vFq0u79NPeoQg0Cqnv/rCi00HDTdxWTBWz7zAUtNThKZh+8BxHHWxdE26vX+OZsTFMGdCj8NR4DyJkvpMK6M3PnUiWcMOWJqciw882bzoihOciQjVKePyiRBoTsUXnUrnyOOMtBnQx2ElqNCo6J1BXaFNFKfI1Ex75u20k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778548709; c=relaxed/simple;
	bh=w3CtU+hYwk0vuDDvZWpVkcnsbUsLWI9bRzUE1HZQ2bs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ThQuWjtLr7xL/7HKD79jCjzETjxBhU3hKT1EkJHwcjh1wGHDEIRp7wUzDM9iU0HIchCTbHVgERT2QUl+qjGjZTSVIqv6TQKspc0rP6G0yYoSL8gCfG+8gngWNZIwKbWDyeIdc2LzrzygILulx7LW794Tmaem3s3tZwbrtmeCJeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tGD1xBAm; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50e5c7eb565so48662101cf.3
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 18:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778548705; x=1779153505; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4O7WaEUgH7uVF1t7R5QzWbPYxx8khqSIJzO/Wkups0=;
        b=tGD1xBAmuKbAf60hHbmrhLIh/GOC3eDjfW/1xR61lPL6YWmQkkF/rfbm/xJoxHjuZ+
         Qag2O9wajlRkgDpLU+V0ABhLAn4ILDcFiOp3tIy7mtnzBK0rqeF2qXptBJhbaNqR1jWI
         cMf648R7YQgT2p8Xg0+PakWlV6Czvj+ArGkxJVlNEY7mphYoQIGTP6C8LZykq0wRaxI/
         Y8Vzx+p8im7VdbfdHt6h7jb6TeGW7rJqOEtqWUw6Ia8+tJO/4omkHerzrzXsI2wzcoy1
         iBIPYRezCFtASQz5aN6YKXQjrFmzSc7HoUG2NfEzeHWBfKE4eESo2cMWmxhIR/LdjtwJ
         QM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778548705; x=1779153505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T4O7WaEUgH7uVF1t7R5QzWbPYxx8khqSIJzO/Wkups0=;
        b=FIORDk6XpNo8aOtxndlIVdE6GBYHdxggmP+2CU9boh17kQGIMLNmZQEWz7iKawZsBy
         SDHjSuNc7HxPprNiKX6E3YywmGaY4lZTXzS6AntDfOOZCmX75JhbdHsh24iyNxXpcj/Y
         I5gE/fFDvsvVMo/Xq1aD553Ry6RyqylLhbPVzk5JUix/77rs5etkvd6eDBK6rHFgHN/r
         fXXoIynWSOUszX63Wyqb9L36W0tnlIZyb+qpLpNaC7xx/LNLLDJIR4WPGUky0chFA0C9
         cxgXCLMC9yLqlWqWWbdJJKm8S0JVtRIG/E97kLi4102AYUF4cMcXWgtq+IjQn8sbaFB5
         aCRQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ozHxWvxrL+rVBh49AusDkYr9R1PiD1EMdChFkpGwMCJ3ToQQLT7hln6IP5aiOm5cIN4IaID3df+8f@vger.kernel.org
X-Gm-Message-State: AOJu0YwLWnyBuRr0Q2fzknG9WUBX7bUT1gsN8Wpt7goLgraKUkmBlvDT
	iv+7SiLl5OLPOiTaGhmYoiff9lk4SKv8l0tgBEeFrLnYFkFx9rpVC5Ok
X-Gm-Gg: Acq92OFxJW/eduHE1GKIRckqp+0KFuwNzUkVeL36E15bAjcDyNZGTHjo1DjO13kRIoY
	/3BTX2qyMFSxKe9RSU0mZM+heReZveK35AVcYGNNhiKfZN8bqoR1ZyIz8Y8a+WiWQkOupfFTT5O
	y/A+4qZaPcKlumeDHcCCq24tETDvyVgy9UaQz3hkBGyKM63X1/3WNs7arieipcA1a3EatGjUsRD
	+RIbYc7kbVBWyV3zr3SkU81cyfgCq5cuoce64hig7fCDRn8N0f+/kJzgJXH2i0g4oI/oZu22hdW
	pYT6Edv37iXB3nGR2uV6f64ziJPVK6qPNfrDJwQAfTV7IKPzl9N/HZJkdusVXYppR6yny4FS+Wx
	EaTstcBJw87YbI0/AlXSBtI33A6GIXk7s5tu2/Nobpn5sca7b+kQ6FBsZsF2apgGew7N+A+vuCG
	2U5MCFdrC7YZ8fmlRkyyY=
X-Received: by 2002:a05:622a:92:b0:50d:770f:ad23 with SMTP id d75a77b69052e-514d1c943c9mr15635691cf.26.1778548704810;
        Mon, 11 May 2026 18:18:24 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-514a956cad9sm71871261cf.9.2026.05.11.18.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:18:24 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 11 May 2026 18:18:02 -0700
Subject: [PATCH net-next v4 8/8] selftests: drv-net: add netkit devmem
 tests
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-tcp-dm-netkit-v4-8-841b78b99d74@meta.com>
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
X-Rspamd-Queue-Id: 17EC151821B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-20442-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[davidwei.uk,gmail.com,google.com,zte.com.cn,vger.kernel.org,fomichev.me,meta.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[devmem.py:url,nk_qlease.py:url,nk_devmem.py:url,meta.com:email,meta.com:mid,lib.py:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fomichev.me:email]
X-Rspamd-Action: no action

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add nk_devmem.py with four tests for TCP devmem through a netkit device:

These tests are just duplicates of the original devmem tests, with some
adjusted parameters such as telling ncdevmem to avoid device setup
(since it only has access to netkit, not a phys device).

Each test uses NetDrvContEnv with primary_rx_redirect=True to set up the
BPF redirect program on the primary netkit interface.

The NIC (HDS, RSS, queue lease) is configured once in main() before
ksft_run() and torn down in a finally block via cleanup_nic(), mirroring
the nk_qlease.py pattern. This avoids re-toggling NIC settings around
every test case.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v4:
- Call configure_nic()/cleanup_nic() once around ksft_run() rather than
  relying on per-test configuration inside the run_* helpers.

Changes in v3:
- Reorder os.path expressions
- Drop @ksft_disruptive from check_nk_rx_hds to mirror the original
  check_rx_hds in devmem.py

Changes in v2:
- Add nk_devmem.py to TEST_PROGS in Makefile (Sashiko)
---
 tools/testing/selftests/drivers/net/hw/Makefile    |  1 +
 .../testing/selftests/drivers/net/hw/nk_devmem.py  | 55 ++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 85ca4d1ecf9e..2f78c6aec397 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -34,6 +34,7 @@ TEST_PROGS = \
 	irq.py \
 	loopback.sh \
 	nic_timestamp.py \
+	nk_devmem.py \
 	nk_netns.py \
 	nk_qlease.py \
 	ntuple.py \
diff --git a/tools/testing/selftests/drivers/net/hw/nk_devmem.py b/tools/testing/selftests/drivers/net/hw/nk_devmem.py
new file mode 100755
index 000000000000..0e36a0fa9688
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_devmem.py
@@ -0,0 +1,55 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""Test devmem TCP with netkit."""
+
+import os
+from lib.py import ksft_run, ksft_exit, ksft_disruptive
+from lib.py import NetDrvContEnv
+from lib.py.devmem import (setup_test, require_devmem, configure_nic,
+                           cleanup_nic, run_rx, run_tx, run_tx_chunks,
+                           run_rx_hds)
+
+
+@ksft_disruptive
+def check_nk_rx(cfg) -> None:
+    """Run the devmem RX test through netkit."""
+    run_rx(cfg)
+
+
+@ksft_disruptive
+def check_nk_tx(cfg) -> None:
+    """Run the devmem TX test through netkit."""
+    run_tx(cfg)
+
+
+@ksft_disruptive
+def check_nk_tx_chunks(cfg) -> None:
+    """Run the devmem TX chunking test through netkit."""
+    run_tx_chunks(cfg)
+
+
+def check_nk_rx_hds(cfg) -> None:
+    """Run the HDS test through netkit."""
+    run_rx_hds(cfg)
+
+
+def main() -> None:
+    """Configure the NIC once, then run the netkit devmem test cases."""
+    with NetDrvContEnv(__file__, rxqueues=2, primary_rx_redirect=True) as cfg:
+        setup_test(cfg,
+                   os.path.join(os.path.dirname(os.path.abspath(__file__)),
+                                "ncdevmem"))
+
+        require_devmem(cfg)
+        configure_nic(cfg)
+        try:
+            ksft_run([check_nk_rx, check_nk_tx, check_nk_tx_chunks,
+                      check_nk_rx_hds], args=(cfg,))
+        finally:
+            cleanup_nic(cfg)
+
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()

-- 
2.53.0-Meta


