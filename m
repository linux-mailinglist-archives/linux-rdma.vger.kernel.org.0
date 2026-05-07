Return-Path: <linux-rdma+bounces-20149-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8B1KEUyL/GleRAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20149-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:53:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CE54E8872
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9D6E303851C
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 12:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8313B3F0A91;
	Thu,  7 May 2026 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="IDknyFpv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5023F0AA1
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158364; cv=none; b=JYVVr49TtsvWtwHmzcBn8fK+YgKhO5nMk+TMEmPRefUtz1K/dYj4Y9KO5lCrrk6artENAB89qbbfpcd63a5qvxLqEPfKhVnaFW4Iab3e2SEv2Tusqbs57lvTror2YiHBAjCuqXVB1yp6QZRjTIFtadVguEzf42mcmRBg0cp1+4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158364; c=relaxed/simple;
	bh=13zgOMmXs5RZRCquXhQbhGFl99rbjsWPCA0+wkADjVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nk0iYorSUD5v/54PSTxbt52G1eZQTEcDYtndczdZqLZeS3RirZDUyiTkBExkPaxbPnntkIDmJrkMXrsNNJaE+LMuJEzxkEYqQwZayAIzrSDmaiZ5/6mNvY7ArzJwmYiOzqqsUV8c+XXZFajnnEjvP63FO6v51k9LNYaObiOp72Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=IDknyFpv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so10315705e9.2
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 05:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778158361; x=1778763161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRs582LkxGN5UKsfkEnYQl+gUjBDkAvHlkfp1nIRmm4=;
        b=IDknyFpvt3UAGU2os7/eIMeN4R1QIPgWu44SjQEaGx2qQn+5S+0a14X1kN/x1gfKTK
         DcWD7WuuDLUWZimalblKhBR8PJKykuWbqM2H2mDCXtttvj7pSB9urI61Y9lZfk+iwNNO
         2eScJ8qZN16jB94C+TsU8A7GUEEh5/SpdE9odJiVkEcMG7gvpUm604Zi/DA5MXiS/6gM
         KwugcFYonyTiKwqjalhbjy7KjMiF9xp4g1r62wuhfxi15UsaSH0p4VQOoA/l+Qn41FrM
         vZcSTMiS4pIm+28XMPuXHB9UOkbAGQyzpq9EDtAqxyT/cn3x3+SpPsBHomwTimbt0jxb
         E9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158361; x=1778763161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IRs582LkxGN5UKsfkEnYQl+gUjBDkAvHlkfp1nIRmm4=;
        b=DNMJaVhM+B9uqvDPP/Sq8PVs6GV8ZL9AheIt3S9IqXhfdolFC+ChL7s2AK1x/PVLBm
         0+bHjWzv594u9rp/wjRCHgQP3PYtByyCAAWOcCVm44ft1uJh2vbc40XG/1/N8Lmy9u6V
         6bHFswi0jJ0MQN/HCvR81WTW4zgmIr65r9p1p16GWzc5os9lUow5SBBfvDPPZJbHkgpl
         htVe4UxIBGO6xF0FK7cokme62C2ywikis+9TI0Iy4HsZfQWRBXXStwhl+dXGDE0EymIR
         q/BzaNgs8Ug/NqRuC6hovbnQJUOrJVCjzk26CFqbVkKqvyOd2Wts68fus05mVii8XAJi
         obuA==
X-Gm-Message-State: AOJu0Yz9S6bCx+LFfeXlyfhNcNXmBPnAVjScbwoenAVc5imnp2fPPcU2
	q8MW/mLtkhwtkxwxAkYBw3ACVd5k1b85XzGCUX0jWMAdXy5/z1YyoFty7vaD8Dvlsd1a98yvqjc
	88Zly
X-Gm-Gg: AeBDietACzvvDuzA7u9W0TxPnuKeKolLxRcgmZfLWfRkTWy6LI68SbVuTXgJps7sxvw
	kkYG4mqSqHj1B28fBdYPEBWtHQd7700CNwblTNkQvvtR55AfgRXglMRuKmLcIQ9gXeXQad8n1Px
	oIBSfPw8SBJZSGFPvlbWfdbll4B4X8z32s7bk9LUQAW7fhpEngwNk8/iqHzZCw7Evq4GJWUSAso
	ipG8Wvlsk8YyshjHLc1HN1B/aEvC141rP73fJ91CKXTBKk95dFIpgKb65mNo4METbLmc7cIwZq1
	LpUV/ugKDB/Ej8JTO2fNtd0wLpyw5O27p5CeS/aTQLCkNz0USsNJr205H1D6Mfj0tTbuyKIJ4rW
	UMISoaue9xTzN8jtJgJzGarZzx9eAC1lp58BpFTCyXEY2k63YAPfrzQU4tyvQuJI3n3GKApjTAP
	x8KrdXC1L5DodSqC/s86A5KFHf0tZEBsWgT0NMKXeLcN0vG0Reh+xFv7RC
X-Received: by 2002:a05:600c:4592:b0:488:7ff6:1f75 with SMTP id 5b1f17b1804b1-48e51f3c4e5mr128631105e9.21.1778158361168;
        Thu, 07 May 2026 05:52:41 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538aaa0fsm150064005e9.7.2026.05.07.05.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:52:40 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com,
	gal.pressman@linux.dev,
	sleybo@amazon.com,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yanjun.zhu@linux.dev,
	marco.crivellari@suse.com,
	roman.gushchin@linux.dev,
	phaddad@nvidia.com,
	lirongqing@baidu.com,
	ynachum@amazon.com,
	huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com,
	ohartoov@nvidia.com,
	michaelgur@nvidia.com,
	shayd@nvidia.com,
	edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: [PATCH rdma-next v4 08/16] RDMA/efa: Use ib_umem_get_cq_buf() for user CQ buffer
Date: Thu,  7 May 2026 14:52:23 +0200
Message-ID: <20260507125231.2950751-9-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507125231.2950751-1-jiri@resnulli.us>
References: <20260507125231.2950751-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B4CE54E8872
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20149-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Pin the user CQ buffer with ib_umem_get_cq_buf() and take
ownership of the umem in the driver. Fall back to the
existing kernel-DMA path on NULL.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- used ib_umem_get_cq_buf() to get umem, stored in efa_cq->umem
- replaced ib_umem_release_non_listed() with ib_umem_release()
- added release to efa_destroy_cq() and new error path
---
 drivers/infiniband/hw/efa/efa_verbs.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index e103d1654a69..aebae70b882c 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1072,6 +1072,7 @@ int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 
 	if (cq->cpu_addr)
 		efa_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size, DMA_FROM_DEVICE);
+	ib_umem_release(cq->umem);
 	return 0;
 }
 
@@ -1124,6 +1125,7 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct efa_ibv_create_cq cmd;
 	struct efa_cq *cq = to_ecq(ibcq);
 	int entries = attr->cqe;
+	struct ib_umem *umem;
 	bool set_src_addr;
 	int err;
 
@@ -1172,26 +1174,29 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->ucontext = ucontext;
 	cq->size = PAGE_ALIGN(cmd.cq_entry_size * entries * cmd.num_sub_cqs);
 
-	if (ibcq->umem) {
-		if (ibcq->umem->length < cq->size) {
-			ibdev_dbg(&dev->ibdev, "External memory too small\n");
-			err = -EINVAL;
-			goto err_out;
-		}
+	umem = ib_umem_get_cq_buf(ibcq->device, udata, cq->size,
+				  IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(umem)) {
+		err = PTR_ERR(umem);
+		goto err_out;
+	}
+
+	cq->umem = umem;
 
-		if (!ib_umem_is_contiguous(ibcq->umem)) {
+	if (umem) {
+		if (!ib_umem_is_contiguous(umem)) {
 			ibdev_dbg(&dev->ibdev, "Non contiguous CQ unsupported\n");
 			err = -EINVAL;
-			goto err_out;
+			goto err_release_umem;
 		}
 
-		cq->dma_addr = ib_umem_start_dma_addr(ibcq->umem);
+		cq->dma_addr = ib_umem_start_dma_addr(umem);
 	} else {
 		cq->cpu_addr = efa_zalloc_mapped(dev, &cq->dma_addr, cq->size,
 						 DMA_FROM_DEVICE);
 		if (!cq->cpu_addr) {
 			err = -ENOMEM;
-			goto err_out;
+			goto err_release_umem;
 		}
 	}
 
@@ -1262,6 +1267,8 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (cq->cpu_addr)
 		efa_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size,
 				DMA_FROM_DEVICE);
+err_release_umem:
+	ib_umem_release(cq->umem);
 err_out:
 	atomic64_inc(&dev->stats.create_cq_err);
 	return err;
-- 
2.53.0


