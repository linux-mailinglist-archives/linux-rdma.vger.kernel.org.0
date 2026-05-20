Return-Path: <linux-rdma+bounces-21040-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NvYIA2JDWpdygUAu9opvQ
	(envelope-from <linux-rdma+bounces-21040-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:12:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1753058B76E
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBEE43033F67
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 10:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78B53CFF7E;
	Wed, 20 May 2026 10:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="fSZWtQPt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284DA3D5672
	for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 10:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271908; cv=none; b=k5aiGqnqnxV/kDMfgcwgGTv49pFvLrPhjmEJc6HwLv44n8+P1QzQKlGb7kroHXbXm2MVFl8wArLac6i6TjP1A/q28oqAnUoycFNYR00n/MyI10rDgxUBj/kIE0+otDs3fw1Y2wlqKn7JtHNys6tSlAMtmnJ+iHapYL5N6LghhNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271908; c=relaxed/simple;
	bh=PzFBEoeHLd+kNgCq0+n7Gh7mrWuy+EJi9mzQpqJKu2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2Bg7N61he4C6Vfc7ivrUFf+jUZFYGk9lhGtdz06JNeQElGXfM0wjzobRMbep2jooL349pHXTNWU8xm8CvvDSAFXkDHvnQOzsvIqn52mAj46maQBHZ9ZhAeGAwUrF4o6oRiVXFJusszbRl4zv4QVWnsfYrv0lEPTrELRJ8l1DV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=fSZWtQPt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488d2079582so45213745e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 03:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779271905; x=1779876705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyQzMVuTc3sMKNBsSAJ9NnKA/LLI3SrB665XmR2HKMA=;
        b=fSZWtQPtMM8aGms+8RtlgnrlrOv795f1oNH0M8a8TNc9LRUMVboGaQpoB7qdzSduB+
         A1abueS5iUHBPw22L98+LyT0Xik2q9rHthYf2Pdcowx/TrhDCmdISFaeaLNKBxVtq0os
         rBZSvsomqCU8WDn4tvH+LnK+LbWBnzJIcQAavvB46kf1buDMp1AcCXIWgEIb5p8enbu5
         524h55qXvpKPYprXeuE10aCb8OoFojP95fnRCvd8hAZAZGxp3ZwwTxj26gvzaTD5m+Cg
         e42mivWn6tvYrJldsVCT5ZdORD1p+qagaNSRYqtbIw81mwduZHG6U4bwZGuZfvaCjn+1
         EAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779271905; x=1779876705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tyQzMVuTc3sMKNBsSAJ9NnKA/LLI3SrB665XmR2HKMA=;
        b=nSsKg24cD1aBvDn6Gw5nm6rP/H0z1zT+M6BayfhfN9PxWvJu/69ODTRi69PLoQCMyy
         2pG41jyfsIFbsbv1n/T7H//1ZTAj4sl+EDyyzGGumt3d+CfJsyM0YFl21EAWZNTWiffG
         h/6tWBzdrXFXBnupMBDwYkT0c1c3Nsx/+uy0BYKy79x6tBNhIvFg4caCaGcnbRBV/gPW
         8s6hKMjtfDtDLU8HNkV4FgxMfC/zah5mlSmG5ZbJhplP/RonIb1e9vJ70RZjr+sEusRy
         DHXBwbaMmCamC6ND140wOWF7+t7VYrNJCRoER+7/uuj4RCbBALxTlV694ajQR20VzlXH
         /emA==
X-Gm-Message-State: AOJu0YwhGTU1SQ9fecY/FJo9s2129Ugyv3S3jN+r3bb5eOBWQIi2oaKk
	Zlqth7HMnlLcEWCB0wIz21TMnuCm9cAyX+Olm6fP7gGAccpYirX9D9qG1ZpYOL31KhGo9cwVQeb
	C6JqXh8LMDQ==
X-Gm-Gg: Acq92OHDUUp27nP/oJW9Y4WiogHfctBpsH8pncq8rxVE91kujJoMPMFKxJeJxLX7zBl
	adAZJ2r6UU91pICEznODvvFCj5AhSYmYxzZJnNs+rI3KuBIiik97wXsDfJkyT2ERNS01Fr6XMv4
	vd3CVFqU2FGAukVsZF94ExQCu7pJImy7Yyu2aIhM6F/uUUkFv4I9Dctl0jScwqWkH6mcvvHvkLU
	eLmyp4XMukxGdmx6OPdnS/RmD5mNlH6nj1QLKo+YGt1RR1761OVY/XnRaX5E/ZP7+C7Ro/TyZrw
	xN0SRehiAwXmpf3R5YVSUXsZfJ/gf3YaHbQDoAsRfF4O5JkFkm07AM8W8j7mFdV+YyAoJ0VnHnu
	AeNBC59xSwes9KUhI6WLRZvOjcNiRag0SwqPuk3V1/t5ITBrBTYKpyDv5LJE/ED7D0zgm1i9aWd
	/bEHp5Xsc16xdNgbNNOUS7JaUKQ9/j/go8
X-Received: by 2002:a05:600d:c:b0:48a:56de:d62a with SMTP id 5b1f17b1804b1-48fe60eca75mr325776355e9.11.1779271905438;
        Wed, 20 May 2026 03:11:45 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fffb9aac4sm512629415e9.9.2026.05.20.03.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 03:11:45 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	edwards@nvidia.com,
	kees@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yishaih@nvidia.com,
	lirongqing@baidu.com,
	huangjunxian6@hisilicon.com,
	liuy22@mails.tsinghua.edu.cn,
	jmoroni@google.com
Subject: [PATCH rdma-next v6 07/15] RDMA/efa: Use ib_umem_get_cq_buf() for user CQ buffer
Date: Wed, 20 May 2026 12:11:21 +0200
Message-ID: <20260520101129.899464-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520101129.899464-1-jiri@resnulli.us>
References: <20260520101129.899464-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21040-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 1753058B76E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Pin the user CQ buffer with ib_umem_get_cq_buf() and take
ownership of the umem in the driver. Fall back to the
existing kernel-DMA path on NULL.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v5->v6:
- changed to pass attrs instead of udata to ib_umem_get*()
v2->v3:
- used ib_umem_get_cq_buf() to get umem, stored in efa_cq->umem
- replaced ib_umem_release_non_listed() with ib_umem_release()
- added release to efa_destroy_cq() and new error path
---
 drivers/infiniband/hw/efa/efa_verbs.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 8d97a837fa6a..434d60235945 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1049,6 +1049,7 @@ int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 
 	if (cq->cpu_addr)
 		efa_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size, DMA_FROM_DEVICE);
+	ib_umem_release(cq->umem);
 	return 0;
 }
 
@@ -1101,6 +1102,7 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct efa_ibv_create_cq cmd;
 	struct efa_cq *cq = to_ecq(ibcq);
 	int entries = attr->cqe;
+	struct ib_umem *umem;
 	bool set_src_addr;
 	int err;
 
@@ -1149,26 +1151,29 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->ucontext = ucontext;
 	cq->size = PAGE_ALIGN(cmd.cq_entry_size * entries * cmd.num_sub_cqs);
 
-	if (ibcq->umem) {
-		if (ibcq->umem->length < cq->size) {
-			ibdev_dbg(&dev->ibdev, "External memory too small\n");
-			err = -EINVAL;
-			goto err_out;
-		}
+	umem = ib_umem_get_cq_buf(ibcq->device, attrs, cq->size,
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
 
@@ -1235,6 +1240,8 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (cq->cpu_addr)
 		efa_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size,
 				DMA_FROM_DEVICE);
+err_release_umem:
+	ib_umem_release(cq->umem);
 err_out:
 	atomic64_inc(&dev->stats.create_cq_err);
 	return err;
-- 
2.54.0


