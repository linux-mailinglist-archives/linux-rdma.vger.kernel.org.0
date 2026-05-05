Return-Path: <linux-rdma+bounces-19979-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLjLIAM7+Wkn7AIAu9opvQ
	(envelope-from <linux-rdma+bounces-19979-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 02:34:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0250C4C5802
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 02:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB37230BD50B
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 00:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD992F0661;
	Tue,  5 May 2026 00:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDa2Dl2c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C172C375A
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 00:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777940892; cv=none; b=RV00Hhk1ej4jMmiSYmWyd3Slanw+ZVGeLGA+cS74w2f7iA+vQxHeweDy+VWS8sspytsK1dzAA7nAZ3uGU196l6r07AK1p6T6wrffapqv0rnf3mIqmSF1rEoxjR08jCop9A419s4rH60W9vXHqKvNAjV9lzfVjofdq/Dc6cNPYVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777940892; c=relaxed/simple;
	bh=rz0GaQVWFC5Ldv7XCxhQcnrPcxM3OWUNdbw0/XWxahY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PTwmfPf9eiHhUb/0ADEWhMOrdIaUNctc19H2uuZYSmLsRDjJjuJ9ToXvpN3Ir8jO3nmKjMX6W+VrnM7je7TZ7IBrb3l8gh9xrF2Xt3ogjGZ2r/DqiakW5TelHiD0aYyHi5ncUmVHdFvXRO2QWQ0XxTjFPrb++ybo9StQK/g7cVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDa2Dl2c; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-65c5361142fso1513234d50.0
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 17:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777940889; x=1778545689; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSp2GUXkgxtGrFcBtn8vEntUxKtdvA3MvOWwc4dLMzU=;
        b=MDa2Dl2ca6GUYsU2a7xMr0ZWI0GwSUsx99y85UMGJrdr/6fezJxNDssw/37zR49cHV
         ORLgcwD0xL+9lxuvRmGoGXCAnAer/y8Tu2Fjf51Scpgp5RIBuhTn+Ou/Q8F0pwShjJ6z
         UnaHXDe9T2eSnyfO1KIHX26/+3VfeZfA8i7MCiJY+lPRrUhsagBE3cNCKSlhJ7jzlIS1
         guFPRzm+p18+GD5+ZkB+OzXCk/yy6IkBlDM4tieLvfG0HatfEolLYlQlo6P0DvgtRZvq
         cnux6lda/RdvmEtsoiBbYh3V++0EEVcc3WHwRFAJlKZRah5IbSNVmXPbAhIqGJyF7OAV
         eMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777940889; x=1778545689;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TSp2GUXkgxtGrFcBtn8vEntUxKtdvA3MvOWwc4dLMzU=;
        b=Md9sarYZGH1CWgyBiPIohAfsdaRlTIDWhY3HvGof5K8cT9StSv7YMrTIMsCJctBWrB
         VssurRT0sDq6EmeAe+kID8Y+0LZuFnDfQ3IJ4e8R0YwLRcLiisM3iLPTETwV6OzzzgOI
         4kYZ0Ynt5kFclxhtiawGyW04/ZAJRCplAHwx29UTfeqaJo/z0T687jXfMApbAMtAm8ZO
         taO2cVAC6z1X1irdBcBybF1NRIY1miFdg9Yuu4ZKjDkqYuPo31F/EgW7Bd9W488Bd772
         QrYGbnHVJGoCWzOBk1sQMNEsnNtp1j54YxkG2HZCFs0M5QSJZZXVYq6gEY7Rt+VEcpcc
         wwwg==
X-Forwarded-Encrypted: i=1; AFNElJ/SnSSeK/uka7e3Ot/Y7m7dQSmKQ3GKLXXI4Jvce0NE+JPtjbPOvGYqtk+TJt60PtyN+d/OS3B+0SqO@vger.kernel.org
X-Gm-Message-State: AOJu0YyjrZqLpniSz0bbTEOrctLrYVTOQRH5ygttDyiCz83MSSwneL5a
	33QyIDmhh5bp8bM8pyAHqbvr3z9JaOCUXQlwif7SbD9Iii3m58CZ3XxK5iOM972L
X-Gm-Gg: AeBDies7ha+Fn7ZQKIgDBEaY6o+QV1/nMT2AE33cP/DQ1pC33mRSXySDXeRImwCpiD+
	NzfipkRSCpJ/ZvVdDghq+RRBYdkKGDssdPAFjDNV2/fXJRUJQ6SlnWvcpgoZKWRzgPRKy8+KbIb
	VdI2JF8uXNdBfOl90g4bKXPZvlowK/JWHsJ2oz8v11A9bsRZNWe1kouHr2cGaG4SG+Hys750YFZ
	KB5DjV0CVqJ+aSAkh2sKDIYYOX+NHat38Kj7mxVMu4TnL+VDq1SE5645OyXBEpzTEDz43RVQtQS
	hdCbDXpS8+Usv4+D5HT+ofE+00w1FVnjZuGv9UO7Uh23FKiVKUbsgI3zNBKIa1bYHEI5ko2MgwW
	2Vu4fiHv2uvHpo8zqyjp4qyHRrBPdWjJuasnJBOu9Nmc7a9AGx45Z3fXe7TZy0JnbfsqLm6Gbd1
	+z6PVn/jN32rTMbFZLG+JpdO+F6+mahihAExxvcNsa
X-Received: by 2002:a05:690e:1c08:b0:64e:e896:a86 with SMTP id 956f58d0204a3-65c3db39b1dmr12329280d50.36.1777940888641;
        Mon, 04 May 2026 17:28:08 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c2e8ae9c7sm6268726d50.19.2026.05.04.17.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 17:28:08 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 04 May 2026 17:27:53 -0700
Subject: [PATCH net-next v2 6/6] selftests: drv-net: add netkit devmem
 tests
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-tcp-dm-netkit-v2-6-56d52ac72fd4@meta.com>
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
X-Rspamd-Queue-Id: 0250C4C5802
X-Rspamd-Action: no action
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19979-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:mid,meta.com:email,nk_devmem.py:url,lib.py:url]

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add nk_devmem.py with four tests for TCP devmem through a netkit device:

These tests are just duplicates of the original devmem tests, with some
adjusted parameters such as telling ncdevmem to avoid device setup
(since it only has access to netkit, not a phys device).

Each test uses NetDrvContEnv with primary_rx_redirect=True to set up the
BPF redirect program on the primary netkit interface.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- Add nk_devmem.py to TEST_PROGS in Makefile (Sashiko)
---
 tools/testing/selftests/drivers/net/hw/Makefile    |  1 +
 .../testing/selftests/drivers/net/hw/nk_devmem.py  | 40 ++++++++++++++++++++++
 2 files changed, 41 insertions(+)

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


