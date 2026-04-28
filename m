Return-Path: <linux-rdma+bounces-19712-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNwgJ/k48Wm/egEAu9opvQ
	(envelope-from <linux-rdma+bounces-19712-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:47:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F7148CCA1
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A0983032A79
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 22:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152A83A6404;
	Tue, 28 Apr 2026 22:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkCBgfK8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F7D3A453C
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 22:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416149; cv=none; b=JCSUdT96FSpF2gLylIHM2Qg3U1ZWZG1nFmXvEJT2Tq2LG4bYidfqxmwT4S3VsKVQwO8gfSF5zL4LTdzLzI31a3cuCBzEmwt3uxTvXN6q1HAGuxBz8pCeUSORaPe1NVfNjXKbUpfGVMpOJcT7+9IxuffFJIgur46JmL9JIAwjDwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416149; c=relaxed/simple;
	bh=9CfxHHUrdkC2HOcb/TS/DNlnMmhpx5XoMYQJ/X3bIM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SGJ4+IZiw9kEyhWpk1ZfaVNfp3/NBumoRD3xFY48jhWUmG6NYAbTOFwXh01fzKC1/NHTlZdu7shouOOvkse32IMjYcplrs+lxD54C+FfzEPmUGFAPWQ1oG55OGxhSWCPib5411dirZuRANjT33+WPkx66os6qDgACStLT7FgAKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkCBgfK8; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82f8893bff3so5599644b3a.2
        for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 15:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777416147; x=1778020947; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zt/Ht0RhxHPOrumBmtiIhgjoCgVfyyPmVo07gYfbsYg=;
        b=mkCBgfK8IZCr029gch80jB56L0daRQ0xrq+mlojAk5EoADEJaBGZsLeSiqbKv9WNoh
         NqmoegMAZekTc4FYJzsrNMxDQSB9BgDL833cykHXh1GmO+4XAXSbWjHp3lXfen50X2MN
         M+fVOpsfIqIK2lsppRsl0085WaUYd8rqQQfpak+6nPnOQGQ4iZ838I7/aLGmrmzQ7s6B
         cN/WDOS270ZL2FP/E061dEy/QgmTJilrnHhb0VlZpkO2nsCo0g/1m5DIhfD78un31WD5
         GtbouO1ZfLTdddCmyRF9dCsCW+cpIIzRjHTxX1oMg7Z1phoBmVrO98tcDBXVUOcDtTMu
         NxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777416147; x=1778020947;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zt/Ht0RhxHPOrumBmtiIhgjoCgVfyyPmVo07gYfbsYg=;
        b=eqJ1eBywC5HqOa8dASq1gIQtcATdWcNzDCYAlB7jA9ZPB8rrYtF504PBUnUSQq6YvN
         oqaBAZYXNibPAR9qdgFpKYFPZU1fV1uqd7JwkpdjdpdBKSjluZIh8eZMF2nLlJUvM8+X
         o+BEy6iAEc45VEZZy1XWuFxaF/aaNLyrHcrBMqbbpPaiaKb3ajWIti7YronKtSjQs/Uy
         E/XBvzMzlBMHmCH/piD+5fj+NuJwhwfI0vkrWB9RaPclhB+7IaUOMLmXJWxZcFcVATlx
         Ti1IIsfA7PgGHL/QBILPHlLtqVGdgrTwS2BCHO2Zq0d6nCWwewYfYijMqcftcUrmhac/
         IrDA==
X-Forwarded-Encrypted: i=1; AFNElJ+6Vi1mYQjpKymF8HZXXzjwSa8XliKG8YTiuX3x4/Oytlw1xIB+wthRdzx97OPXhFjWJI82ZBugxu8l@vger.kernel.org
X-Gm-Message-State: AOJu0YxVPWTn2t3KnUHLxtItSrmJF8FHvtkskuJMOcv/kVgZx9uLYJ9J
	ikS/ml9I5BhVCN+9Wqg3dJ7MCpD1GQYVWFU59L1PbRYCLWQ9Hu/4XdbP
X-Gm-Gg: AeBDievtLM5RaFyF5csRiUUj/U82o+/JBI4dWOqaW7TXErPAhRfNmusiRvMscqz2tWM
	x6/QLoRlTPT5serLItz7undUjpmODdd606kBWZkwfrbqZYaxfubqchrAA6o/X+sGz0QWnrn21d6
	r/qouwgVFHd7JbJljGKPw6TDMoJIfp0C4mwjm3MSPC8EVx+NnxzJdmJH7+sgnh5lBLCTIM/08mm
	LOJrR/hkiUANducLxQknSQwyPtukS/rL1zc+F65Ihb6aCtXPVFCdWyn+MSBNMF132zuTFxStECy
	Ur7TMy3czFwgcbwzI8FuBYCwOkM2ZBkHheTCyN/UUmUAp45ImHRJ9jLVlCq0sQfUDqTVtoa0GUO
	wXYXEzP+I+EPHWMmc61IiP0mkB7qZi/Yj5uF7mF4EsPpWkK4udS52k5uR/cPuJ/JRSVkWUVoomZ
	IQSytu+TQvc/BNiRcZYEK/Pz2l6ETcXQ==
X-Received: by 2002:aa7:88c1:0:b0:82f:1973:4b96 with SMTP id d2e1a72fcca58-834ddc14602mr5517283b3a.26.1777416146426;
        Tue, 28 Apr 2026 15:42:26 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80f906sm96681b3a.60.2026.04.28.15.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:42:26 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 28 Apr 2026 15:42:08 -0700
Subject: [PATCH net-next 11/11] selftests: drv-net: add netkit devmem tests
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tcp-dm-netkit-v1-11-719280eba4d2@meta.com>
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
X-Rspamd-Queue-Id: 99F7148CCA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19712-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.py:url,nk_devmem.py:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,meta.com:mid,meta.com:email]

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add nk_devmem.py with four tests for TCP devmem through a netkit device:

These tests are just duplicates of the original devmem tests, with some
adjusted parameters such as telling ncdevmem to avoid device setup
(since it only has access to netkit, not a phys device).

Each test uses NetDrvContEnv with primary_rx_redirect=True to set up the
BPF redirect program on the primary netkit interface.

Assisted-by: Claude Code:claude-sonnet-4-6
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 .../testing/selftests/drivers/net/hw/nk_devmem.py  | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/nk_devmem.py b/tools/testing/selftests/drivers/net/hw/nk_devmem.py
new file mode 100755
index 000000000000..c069d525798b
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_devmem.py
@@ -0,0 +1,40 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""Test devmem TCP with netkit."""
+
+from os import path
+from lib.py import ksft_run, ksft_exit, ksft_disruptive
+from lib.py import NetDrvContEnv
+from lib.py.devmem import setup_test, run_rx, run_tx, run_tx_chunks, run_rx_hds
+
+
+@ksft_disruptive
+def check_nk_rx(cfg) -> None:
+    run_rx(cfg)
+
+
+@ksft_disruptive
+def check_nk_tx(cfg) -> None:
+    run_tx(cfg)
+
+
+@ksft_disruptive
+def check_nk_tx_chunks(cfg) -> None:
+    run_tx_chunks(cfg)
+
+
+@ksft_disruptive
+def check_nk_rx_hds(cfg) -> None:
+    run_rx_hds(cfg)
+
+
+def main() -> None:
+    with NetDrvContEnv(__file__, rxqueues=2, primary_rx_redirect=True) as cfg:
+        setup_test(cfg, path.abspath(path.dirname(__file__) + "/ncdevmem"))
+        ksft_run([check_nk_rx, check_nk_tx, check_nk_tx_chunks, check_nk_rx_hds],
+                 args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()

-- 
2.52.0


