Return-Path: <linux-rdma+bounces-20729-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJ+XCvUFBmrFdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20729-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 19:27:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C70BE5454CF
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 19:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 346C930A77BC
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 17:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3768D3B582F;
	Thu, 14 May 2026 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbNE0fqG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB6B392821
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778779383; cv=none; b=oMYeoPnlFu5ep6JLkvYLBgKw9GJPgAwFEu0vgWc+Rvv/kxn7Veb/c2scBOMAGfdE3wPtDshFDDemPxt8lwb1hactzr1mO6zjiMR1BgwiEcPeMSSUYcFbdeI5TbUwP+B7zQdCO+ODUQiMBhoK59DHg8YtnTNR/irh7BQshM+YI/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778779383; c=relaxed/simple;
	bh=EDyBqkyN5bDm600u/I66EqsZzueKCojlerqIBUvyphs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ao65cPZ8oeCcFNpWLDtyvKop21ynHucF04ehvVZK4id3/NcUDkJNPDrOWp+H5tmfK1NRE+I6zJiN7AiMS9Cm9M4lzLXLqpXnQNQGsGn2/6k2T3O1jycolAOfZALKo191W4Ow0qML3I4uUJDxn2hqzwMj2G0Dd6OVtOzW+9Qh+lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbNE0fqG; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7de46b8e432so7826299a34.1
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 10:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778779379; x=1779384179; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fK6Hgo3Ntm+Mk5vI9D7ReSoIcT5DoQh4kA5KdiywL8c=;
        b=EbNE0fqGgztfEhlDW8IO7XoiGkpsuYndZ6xw/l+/6KOaeGXducdM7IGPNHTwgx9Uyc
         IOnE3akvzeLJ/calq8q0VCT9+GIrxnoigU88AI5AqSKI7DkJOIyRAC0dym5wt8gQkuLn
         vYvkpL8oPwe1alB7ptzJD6B+WPBFT3G0ThHplSa7rZAHgkmGdWx1HWlx5ct6s+a6Pb+f
         pWBeolusN/C7fbIYzE/OrN10SjNljgi6j9FcGmD/zGXOxpDi2n41GKGXD5jrLoaGy6A8
         IDc21bQ3Rlh6YVmQ5Q8ytHLLq3jU2NLB/rFJ645f9dpU9cEpvvVP5lbyj+fPvBiJ9DSb
         NHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778779379; x=1779384179;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fK6Hgo3Ntm+Mk5vI9D7ReSoIcT5DoQh4kA5KdiywL8c=;
        b=cCcxgeL49N0mcODexXH1Kz+NpCHh9ruUDryOqfsRtYNfnfGfNAmlBzR+mtugjCOqPh
         sUk2P7ra9JMLncsFta3p5Z/H33yHplr0+VER+T0vLJS5T1a8flKNYGBJun87tLhhb2ts
         wdM/BdDMU/N1Y9RAy8lcdFcggBRsN6BiGchIrxZIT2ix70dZYC3gihdPFcvCgLJUfqP3
         p++NU8A2gOEQrUVNImm0xA76BVSJ/nbFAS2J9p+B4WGKwKcsCEvH3WvXodIAM3hyMKJQ
         JY7XeCE/TeDPp29LlL4taONFxwuvqTEwEepJe3fCEb7o6Q38jOvhcIwUUFaIGVxMjn0P
         EG6g==
X-Forwarded-Encrypted: i=1; AFNElJ9zOhYT9m9+72ybVU8iIs8bAT3wh7a0rEp0q2bR/BxHgyH3sRoUL0sDhGf8Dpq8F36kSVatBI2/MfKa@vger.kernel.org
X-Gm-Message-State: AOJu0YzF+5Y90hWkDZZJxnRtSg6BeYw0L1N2tSzgHPEVjUz0thHiW1v2
	H8OnLAr/dQaLOLfVSYDpqSqJ5ozPAD45/iRjA0PEfhyJ/aTVNXyh8PbL
X-Gm-Gg: Acq92OG1k3ebiAGrA639LMHjRfj1siAglLS4zgho0auejyNjMaEQZRvvQ2MtHWFMSe3
	/HkmBxzNw1pbtZYQk258O6ZnQ7ehx/bzsV6q7GA4Hy/W25HHxA4ifTQRNktDTh9dKvIajyKanqu
	JY/nUQAJ7Od7c3zef/Q//lGDRviktnB271toSlSkR4OkNmO9WRGY/PG10t0rQ0GPZ1bIalgYKwI
	l+cYCdefIrhYy2DXhmoW98WAqIt5u+Jg4J9mTm4PI4Hje3SwYylkTZYf3leNHARYA26f53h8SiL
	TDxk9Tap1DSMZF/kqNCwF/pjFPPlIkxsd1NdstFCx2/4NOmx01lAWRt2hREByXbcDSrKtX/epg5
	Ecff3/Yr8gzS0tgW8456jtTJS66AJ0amxBxOVUI1mfr9jwVmlxA8hWXEk24+/GCv3AvRZxd762T
	TLDWMMybDGq/eOjDstsDQKhQ==
X-Received: by 2002:a05:6820:81c7:b0:69b:8c73:e921 with SMTP id 006d021491bc7-69c942ef1femr249405eaf.20.1778779379501;
        Thu, 14 May 2026 10:22:59 -0700 (PDT)
Received: from localhost ([2a03:2880:f812:6b::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc1e7bc7sm2229037fac.7.2026.05.14.10.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:22:59 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 14 May 2026 10:22:35 -0700
Subject: [PATCH net-next v5 8/8] selftests: drv-net: add netkit devmem
 tests
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-tcp-dm-netkit-v5-8-408c59b91e66@meta.com>
References: <20260514-tcp-dm-netkit-v5-0-408c59b91e66@meta.com>
In-Reply-To: <20260514-tcp-dm-netkit-v5-0-408c59b91e66@meta.com>
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
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: C70BE5454CF
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
	TAGGED_FROM(0.00)[bounces-20729-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[devmem.py:url,nk_devmem.py:url,lib.py:url,fomichev.me:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:email,meta.com:mid]
X-Rspamd-Action: no action

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add nk_devmem.py with four tests for TCP devmem through a netkit device.

These tests are just duplicates of the original devmem tests, with some
adjusted parameters such as telling ncdevmem to avoid device setup
(since it only has access to netkit, not a phys device).

Each test uses NetDrvContEnv with primary_rx_redirect=True to set up the
BPF redirect program on the primary netkit interface, then calls a
shared run_*() helper which probes for devmem support and configures
the NIC (HDS, RSS, queue lease) before driving the test. NIC state is
restored per-test via defer() callbacks registered inside the helper.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v5:
- Move require_devmem() inside test functions so ksft_run() reports it
  as a SKIP (Sashiko).
- Drop the inaccurate "mirroring the nk_qlease.py pattern" claim from
  v4 (Sashiko).

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
 .../testing/selftests/drivers/net/hw/nk_devmem.py  | 46 ++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 5e49d7bffced..c7a1206880ea 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -35,6 +35,7 @@ TEST_PROGS = \
 	irq.py \
 	loopback.sh \
 	nic_timestamp.py \
+	nk_devmem.py \
 	nk_netns.py \
 	nk_qlease.py \
 	ntuple.py \
diff --git a/tools/testing/selftests/drivers/net/hw/nk_devmem.py b/tools/testing/selftests/drivers/net/hw/nk_devmem.py
new file mode 100755
index 000000000000..300ed2a70ab4
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_devmem.py
@@ -0,0 +1,46 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""Test devmem TCP with netkit."""
+
+import os
+from devmem_lib import setup_test, run_rx, run_tx, run_tx_chunks, run_rx_hds
+from lib.py import ksft_run, ksft_exit, ksft_disruptive
+from lib.py import NetDrvContEnv
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
+    """Run the netkit devmem test cases."""
+    with NetDrvContEnv(__file__, rxqueues=2, primary_rx_redirect=True) as cfg:
+        setup_test(cfg,
+                   os.path.join(os.path.dirname(os.path.abspath(__file__)),
+                                "ncdevmem"))
+        ksft_run([check_nk_rx, check_nk_tx, check_nk_tx_chunks,
+                  check_nk_rx_hds], args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()

-- 
2.53.0-Meta


