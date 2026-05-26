Return-Path: <linux-rdma+bounces-21311-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAC4IkyzFWpxYAcAu9opvQ
	(envelope-from <linux-rdma+bounces-21311-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:50:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C1A5D7F23
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2080C310993E
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 14:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A5F401497;
	Tue, 26 May 2026 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="aWQ+u93r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB556401496
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806544; cv=none; b=ogAoiPvGkBtxOKw6KV6zbEPfnNnaFqHOqaMb1ULyTXeJanCW7aHY9oarsqXBrU4p07JeIM8vIy+qzGJKpI8QFSlKJKp87i0ZW6t92C8Gr4bI5mEYDCGkIWWlUgvNi8wM3Czo5cHZmgx0xOfUaxF0K5vkOWubHNrQGduKWAx06A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806544; c=relaxed/simple;
	bh=PzFBEoeHLd+kNgCq0+n7Gh7mrWuy+EJi9mzQpqJKu2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgC8GQNjEh7WfuZSJZB08DRZpu1dFSt0j1rLT6/gqMjVtooMg/JKg6PXUFo5BcYshNi3XgR5b2MwOZrrgllGf8oYWF8VkR8ffztywtCXnIF+TY+S9SUe2yR8ew7QqzPZ0b+Zo80KFSPs8GgGQ0SJ+VHrhjcQWuyEJ6ztYnDw+9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=aWQ+u93r; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso74020425e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 07:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779806541; x=1780411341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyQzMVuTc3sMKNBsSAJ9NnKA/LLI3SrB665XmR2HKMA=;
        b=aWQ+u93rOkCxkhELX8v+W4zVYsSlhxoYsR2DxBBb/KveKFgl3TOPjWsMUhze0GjKnp
         OaRpfjRwS3zY+60goLrBMO4ULGrKqZGCFgnImpPLXZTa9JHP6ol5C8MVPYlcnGZMFuq6
         GYtR9lgV9Lt8wdZYI1atgH/c2nFrsPZvZ8xP/2k3XQ8a3j6ekLSf566/DG5RSbI99bPC
         tkYUjPoUZ0vfcW3hymrx1gars/7DiCvCSfXZGLAb1M2oxvCRzaFiDybgBFDEp51BG/q+
         Nkj7llTh8rN+pxskKuyY1KvKEmjJ71ZMfZQNNJ7jBgjSLGZFDWKLGvuHw6bBo7KAr5HA
         Mb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779806541; x=1780411341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tyQzMVuTc3sMKNBsSAJ9NnKA/LLI3SrB665XmR2HKMA=;
        b=sGK9MMGiAHCuyUT+zRiF4B18/3KH8L8m4W7oqyzzTr8BpabYPLAzzlZ3demRMp5bem
         CU/nKAeqI6RUnlgfh568FLjQ1UMWKnx18ihqS8BQEmogvksobA606XYbnqQ4lscCtemc
         ZZqN7WxUiGTXXClhKccWCsmIAldhd7TlkdHqHv2/p83axfX5xWDW2Agsf4EniNnOgBh3
         wG98r4FENZ3fcO0RBnVokDdKpgGD7Tju0pRJsDuWaFsfwCBy98lZbuR2WLvwVF8JFZp1
         L+pW6z73qVpsr25DzJ+9QISlaZVdZwmNGo3kdA6M20CDKRxFWOV9T+RKrcDt+l8LyIgm
         lG3A==
X-Gm-Message-State: AOJu0Yxox6oSL9Gtfn1HXBZdAvkQL0nb5i0RU/QIBZy7Bn5Ac52Y6kLS
	bg+SUke4A96kdoKEXvbH59mxen4+pIQHAZccHJxLQ8s1MejjzzfFw1Cyhl7rB6N+AjfimWheZ4k
	qhS53hFX+eg==
X-Gm-Gg: Acq92OEQCd3Sg2qak3jg/f24LWFXxn0TYy5JL+QNl7Epbhd2se6LmTHKZeaurPxLPQp
	nV5r+6kd15ss4nhrD5s+Jm9pyTXlff+hD1tH+hRV/lWrrJEX1n/O8g53BaHAlx8F+e2OdFR0cvI
	bTQZL/PZJdImcIqSyU2PTGh6B3+wZuwQSWsKk0r6Df9cKQxgweGrs16MrYK6I859MkiW6W9KDBj
	YeD3H+m3ZWNmuXD9iaaewGYyjJy9Vz/K9o9XjjRs43uCoWBLSi7hdiUziYrLDNxTrnrQVBE+iFc
	WTtYukKZaIFP9z9TRFY4xakgEOvVL8E0DHCQg3eQ8WFrqgEjkYuRR8142Ypnqfjr+4xCNe9kU7+
	taWny6uUTTq1DfumCKdsJTYip/kFXhT8RaUAVmjvkQ8vTDIwkAPnmQ7IDGwPLysncNM79p2oMmS
	Oe5vFP1Tpw/QCyizxIYkWGH5j3eZW+DGukUspmViN8g0s=
X-Received: by 2002:a05:600c:3b02:b0:489:201c:dc46 with SMTP id 5b1f17b1804b1-490424b2cf1mr322209875e9.12.1779806541116;
        Tue, 26 May 2026 07:42:21 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d7167dsm36381613f8f.35.2026.05.26.07.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:42:20 -0700 (PDT)
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
	selvin.xavier@broadcom.com,
	jmoroni@google.com
Subject: [PATCH rdma-next v7 07/15] RDMA/efa: Use ib_umem_get_cq_buf() for user CQ buffer
Date: Tue, 26 May 2026 16:41:44 +0200
Message-ID: <20260526144152.1422310-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526144152.1422310-1-jiri@resnulli.us>
References: <20260526144152.1422310-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21311-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 08C1A5D7F23
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


