Return-Path: <linux-rdma+bounces-20206-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDn+GL5K/WmUaAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20206-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 04:30:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D71174F0C9A
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 04:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17B5F306FE5F
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 02:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88FB2F99BD;
	Fri,  8 May 2026 02:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUrh6Ic9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF542BEFED
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 02:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778207314; cv=none; b=HTlKllWGxig+czBJ5kAv10H+IsCDexNDSZIV2WLGIfvmf5F4DHfEs65eMbl55y47a4BgTssvqMqQzOYa2QbtBlorVJcNBcg47OIpmkdF/Onvf64wEONnCI8yXC8aAXxF+WDjNMid/qMM8G96hUOzoTDhDwsAE5BZ4Jkg5Ko8jCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778207314; c=relaxed/simple;
	bh=n7tJve6PSP03zrqEiNRPQpgyL5Of2UxSvSD8zaqgtxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pw2dWUEWAmcO79A8vDus27Irf4sB2gKCH70SKi/+Zk1eODExbqYJYKt3zucSdDt2V82/XFVlIqCQJ19mQCQxrG7XhkpzoQrMCTdYVrZrARGa0FMEnG6lI+IadOzN9sDeRENmjcESKxN+Krqz3H5wh/P0s10kbeJv7cu9ORzT0LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUrh6Ic9; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8b4298d271fso24067996d6.3
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 19:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778207310; x=1778812110; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dXA1dxVApJgTc6+2n8TQWi9uv8RI7qdSUELHLNuyKvU=;
        b=CUrh6Ic9M3t2F3UbV8S4dQY58uu4g0KGDl+yntHgetpwybawUW+HDyLQFkZ43ddXPr
         6U13l9URBGfTLCoYhmCp2HbHFoxjltj0wO9LWOHyeLNGC59sFtZHyXs/EkFRYnduh8SY
         RKn/cibXHGzXrKnPzZuErnScbQ1Jwo2P5hQLEDOR80HJmicgBxgIrj7kHcfn0taTGzxA
         2t6+nLP/MWawRKEj2BWoxmTMDFxwkV+AIniQeF3VvVBMphhfzDFkL0PnNRfso7FiySdY
         Yc/p30iIhxsUFdp/bag84dp6IRa5jsPESuHQt9ve5URFkCXOpYDek1DSg408CfkiIlcp
         R06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778207310; x=1778812110;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dXA1dxVApJgTc6+2n8TQWi9uv8RI7qdSUELHLNuyKvU=;
        b=N/7OsmWg9JqTMe6gB+rvGB1elkrQYik+stzDLfxVCnJJJ9qdm8WilzOeIQSZ5hJfd/
         q8w6HIDeI4PKn3A36jQvXvkV1plj7U4C1jRAuXv36E6PdjDhKVTEE6kmGYuEeuLKyOek
         08wJEoMRV57mtkatlOEx/E++wlDIEHVjLL6uo7Ao07zQKlFlmZ22hCF3/txh8J/y+kmU
         otetnm0yk7JPfs3KxjXGmQ75e1UfM23alF7DcKNZZP2iOKCtSv2PNr9hieZpqhHS3ztU
         wrji8EBppYBV8/fM7t06+Hs5T/1RdHAdb0LLoK/thQtIueNOLSoB0IgxChJZ9XoBrJ5d
         /Aww==
X-Forwarded-Encrypted: i=1; AFNElJ/OzGLq5u39/3YIoOrG1Vu2oIiwgBBzWGFF+4Eap0RP+3CQ/4Rdb1FO7QYXkS6vXe+Sm4LFufqSbZNP@vger.kernel.org
X-Gm-Message-State: AOJu0YzNKFFzB5UyebQ32yQ1tgIujdEaEJVp3VA4bSEgcac6X47o6+WQ
	0YGrN6ZNwvo9NhjrkHLTqgEdoDbwxgvb1ehgRNY15gjQGci38VQCE8Aq
X-Gm-Gg: Acq92OF6n81jt8UIfgtam179AqRY2y0eqctEawenLRydnus3JIzISZvHKRQsM2YumGF
	fz2Vo10ElhhPFrxjAFb/+mMpwKEIMEUHu5+MAEHIHM5b1OCDlDocjIH+l7c5DR1K4kRxR0jcIHh
	S7z8BZSEtL+mbTg1FB+MbR7RhjfLLjLJlCZFU4znEI/HZhc7HfZfudekRYtCeHD5PxOQPzXJE6e
	OdS+rjmm1rmCZTZGOudhoAEkV+M0x6Yg5nCQYa8OjLr8fcbcbSnTAfNn58giyCYZklyjIY2nsWx
	nPLCFTMWTQrIRqmK+WfaVphajosqf1PcqzSeFRw0o2IlA8yqmeOMPd5hfBbf2Bj1L8XLJ9ND5WT
	O6x+51F8oDPBnqdkaqoRBxgJGY+zaHpeeMFPwRt654DJ71h8gWeJhd1NefjfaVzckiPKbzRZXF6
	3UZm4yzfAWWpSJOjX++/8=
X-Received: by 2002:a05:6214:320f:b0:8ac:a6a5:1f41 with SMTP id 6a1803df08f44-8bc443d5c2cmr162619636d6.27.1778207309884;
        Thu, 07 May 2026 19:28:29 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf3a33fab4sm5419346d6.23.2026.05.07.19.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:28:29 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 07 May 2026 19:27:53 -0700
Subject: [PATCH net-next v3 8/8] selftests: drv-net: add netkit devmem
 tests
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-tcp-dm-netkit-v3-8-52821445867c@meta.com>
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
X-Rspamd-Queue-Id: D71174F0C9A
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
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-20206-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[davidwei.uk,gmail.com,google.com,zte.com.cn,vger.kernel.org,fomichev.me,meta.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:email,meta.com:mid,nk_qlease.py:url,lib.py:url,nk_devmem.py:url,devmem.py:url]
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


