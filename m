Return-Path: <linux-rdma+bounces-22343-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IIPgCqF5M2ouCgYAu9opvQ
	(envelope-from <linux-rdma+bounces-22343-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 06:52:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8226069D8FD
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 06:52:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=gV6C91vo;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22343-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22343-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECD993045EC8
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 04:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDB12FFDE3;
	Thu, 18 Jun 2026 04:51:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF96175A7F
	for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2026 04:51:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781758294; cv=none; b=tSnpxMSkmY/e9Syq0riFH3BRAiZxP8xrO2Yu5QOCunxHB73PeMOd+UxR99ysRWi5vB3Qkq2YQG6r+u/qrttEyX+ihx591kwS+swd0PQd1NpomSFJSCJShNVnWoA6Hd9LxTtZjc3zzL5HUv+SRx+p4qV9+4TN8Q/ndJwk6UHs+2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781758294; c=relaxed/simple;
	bh=fPjzeuKdZFou3E6c4l/cdJVjpNq7wPlU253rA9A+7dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxEnRl7b6DWBobGRbMf2r88tqVrjjiJz7xllNu3CwfJfsgiLnD98RKgUaOuLEn172DUjhPJ1D/Kgyc9uTQsL/5Cf6j+O9JhWciuqLZezcRpCzgZOi4SGGR3JeQM8lEMfyQh9QKYn1v1ZJECFCHi1U5v7Y2JzTjK+XdjHKGEOlbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gV6C91vo; arc=none smtp.client-ip=115.124.30.119
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781758283; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lSHMXuodCAUvxQb6yx89FyA+FK/vzHzHOwNE8pObtgs=;
	b=gV6C91vo7M7kjwQS85nLTRZWwQjZoMNSnCDBfK2XYmYsAXCw0p2LsvxAwMuntu12B1QHqWp3KK++XUuMPrUzIh51GcwA/PoQX/Lar/k2mVKq1thK/YTx9xfNg+pLqM0bUFCSNne6SoXaabF8EGd67eNV/GTZU1XWLP6CZ6b168Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=boshiyu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X55fLUJ_1781758281;
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0X55fLUJ_1781758281 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Jun 2026 12:51:22 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	chengyou@linux.alibaba.com,
	kaishen@linux.alibaba.com
Subject: [PATCH for-next v3 1/3] RDMA/erdma: Rename get/put_mtt_entries to erdma_mem_init/uninit
Date: Thu, 18 Jun 2026 12:51:03 +0800
Message-ID: <20260618045120.51210-2-boshiyu@linux.alibaba.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260618045120.51210-1-boshiyu@linux.alibaba.com>
References: <20260618045120.51210-1-boshiyu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22343-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[boshiyu@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:chengyou@linux.alibaba.com,m:kaishen@linux.alibaba.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boshiyu@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,vger.kernel.org:from_smtp,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8226069D8FD

The get_mtt_entries() interface actually initializes the struct
erdma_mem. Rename the get_mtt_entries/put_mtt_entries to
erdma_mem_init/erdma_mem_uninit, respectively.

Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 64 +++++++++++------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 74afe6eb18b0..92cd8cd846b6 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -828,9 +828,9 @@ static void erdma_destroy_mtt(struct erdma_dev *dev, struct erdma_mtt *mtt)
 	}
 }
 
-static int get_mtt_entries(struct erdma_dev *dev, struct erdma_mem *mem,
-			   u64 start, u64 len, int access, u64 virt,
-			   unsigned long req_page_size, bool force_continuous)
+static int erdma_mem_init(struct erdma_dev *dev, struct erdma_mem *mem,
+			  u64 start, u64 len, int access, u64 virt,
+			  unsigned long req_page_size, bool force_continuous)
 {
 	int ret = 0;
 
@@ -867,7 +867,7 @@ static int get_mtt_entries(struct erdma_dev *dev, struct erdma_mem *mem,
 	return ret;
 }
 
-static void put_mtt_entries(struct erdma_dev *dev, struct erdma_mem *mem)
+static void erdma_mem_uninit(struct erdma_dev *dev, struct erdma_mem *mem)
 {
 	if (mem->mtt)
 		erdma_destroy_mtt(dev, mem->mtt);
@@ -951,45 +951,45 @@ static int init_user_qp(struct erdma_qp *qp, struct erdma_ucontext *uctx,
 		   qp->attrs.rq_size * RQE_SIZE))
 		return -EINVAL;
 
-	ret = get_mtt_entries(qp->dev, &qp->user_qp.sq_mem, va,
-			      qp->attrs.sq_size << SQEBB_SHIFT, 0, va,
-			      (SZ_1M - SZ_4K), true);
+	ret = erdma_mem_init(qp->dev, &qp->user_qp.sq_mem, va,
+			     qp->attrs.sq_size << SQEBB_SHIFT, 0, va,
+			     (SZ_1M - SZ_4K), true);
 	if (ret)
 		return ret;
 
 	rq_offset = ALIGN(qp->attrs.sq_size << SQEBB_SHIFT, ERDMA_HW_PAGE_SIZE);
 	qp->user_qp.rq_offset = rq_offset;
 
-	ret = get_mtt_entries(qp->dev, &qp->user_qp.rq_mem, va + rq_offset,
-			      qp->attrs.rq_size << RQE_SHIFT, 0, va + rq_offset,
-			      (SZ_1M - SZ_4K), true);
+	ret = erdma_mem_init(qp->dev, &qp->user_qp.rq_mem, va + rq_offset,
+			     qp->attrs.rq_size << RQE_SHIFT, 0, va + rq_offset,
+			     (SZ_1M - SZ_4K), true);
 	if (ret)
-		goto put_sq_mtt;
+		goto uninit_sq_mem;
 
 	ret = erdma_map_user_dbrecords(uctx, dbrec_va,
 				       &qp->user_qp.user_dbr_page,
 				       &dbrec_dma);
 	if (ret)
-		goto put_rq_mtt;
+		goto uninit_rq_mem;
 
 	qp->user_qp.sq_dbrec_dma = dbrec_dma;
 	qp->user_qp.rq_dbrec_dma = dbrec_dma + ERDMA_DB_SIZE;
 
 	return 0;
 
-put_rq_mtt:
-	put_mtt_entries(qp->dev, &qp->user_qp.rq_mem);
+uninit_rq_mem:
+	erdma_mem_uninit(qp->dev, &qp->user_qp.rq_mem);
 
-put_sq_mtt:
-	put_mtt_entries(qp->dev, &qp->user_qp.sq_mem);
+uninit_sq_mem:
+	erdma_mem_uninit(qp->dev, &qp->user_qp.sq_mem);
 
 	return ret;
 }
 
 static void free_user_qp(struct erdma_qp *qp, struct erdma_ucontext *uctx)
 {
-	put_mtt_entries(qp->dev, &qp->user_qp.sq_mem);
-	put_mtt_entries(qp->dev, &qp->user_qp.rq_mem);
+	erdma_mem_uninit(qp->dev, &qp->user_qp.sq_mem);
+	erdma_mem_uninit(qp->dev, &qp->user_qp.rq_mem);
 	erdma_unmap_user_dbrecords(uctx, &qp->user_qp.user_dbr_page);
 }
 
@@ -1251,14 +1251,14 @@ struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
-	ret = get_mtt_entries(dev, &mr->mem, start, len, access, virt,
-			      SZ_2G - SZ_4K, false);
+	ret = erdma_mem_init(dev, &mr->mem, start, len, access, virt,
+			     SZ_2G - SZ_4K, false);
 	if (ret)
 		goto err_out_free;
 
 	ret = erdma_create_stag(dev, &stag);
 	if (ret)
-		goto err_out_put_mtt;
+		goto err_uninit_mem;
 
 	mr->ibmr.lkey = mr->ibmr.rkey = stag;
 	mr->ibmr.pd = ibpd;
@@ -1278,8 +1278,8 @@ struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 	erdma_free_idx(&dev->res_cb[ERDMA_RES_TYPE_STAG_IDX],
 		       mr->ibmr.lkey >> 8);
 
-err_out_put_mtt:
-	put_mtt_entries(dev, &mr->mem);
+err_uninit_mem:
+	erdma_mem_uninit(dev, &mr->mem);
 
 err_out_free:
 	kfree(mr);
@@ -1309,7 +1309,7 @@ int erdma_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 
 	erdma_free_idx(&dev->res_cb[ERDMA_RES_TYPE_STAG_IDX], ibmr->lkey >> 8);
 
-	put_mtt_entries(dev, &mr->mem);
+	erdma_mem_uninit(dev, &mr->mem);
 
 	kfree(mr);
 	return 0;
@@ -1340,7 +1340,7 @@ int erdma_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 			      cq->kern_cq.dbrec_dma);
 	} else {
 		erdma_unmap_user_dbrecords(ctx, &cq->user_cq.user_dbr_page);
-		put_mtt_entries(dev, &cq->user_cq.qbuf_mem);
+		erdma_mem_uninit(dev, &cq->user_cq.qbuf_mem);
 	}
 
 	xa_erase(&dev->cq_xa, cq->cqn);
@@ -1387,8 +1387,8 @@ int erdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	if (rdma_is_kernel_res(&qp->ibqp.res)) {
 		free_kernel_qp(qp);
 	} else {
-		put_mtt_entries(dev, &qp->user_qp.sq_mem);
-		put_mtt_entries(dev, &qp->user_qp.rq_mem);
+		erdma_mem_uninit(dev, &qp->user_qp.sq_mem);
+		erdma_mem_uninit(dev, &qp->user_qp.rq_mem);
 		erdma_unmap_user_dbrecords(ctx, &qp->user_qp.user_dbr_page);
 	}
 
@@ -1910,9 +1910,9 @@ static int erdma_init_user_cq(struct erdma_ucontext *ctx, struct erdma_cq *cq,
 	int ret;
 	struct erdma_dev *dev = to_edev(cq->ibcq.device);
 
-	ret = get_mtt_entries(dev, &cq->user_cq.qbuf_mem, ureq->qbuf_va,
-			      ureq->qbuf_len, 0, ureq->qbuf_va, SZ_64M - SZ_4K,
-			      true);
+	ret = erdma_mem_init(dev, &cq->user_cq.qbuf_mem, ureq->qbuf_va,
+			     ureq->qbuf_len, 0, ureq->qbuf_va, SZ_64M - SZ_4K,
+			     true);
 	if (ret)
 		return ret;
 
@@ -1920,7 +1920,7 @@ static int erdma_init_user_cq(struct erdma_ucontext *ctx, struct erdma_cq *cq,
 				       &cq->user_cq.user_dbr_page,
 				       &cq->user_cq.dbrec_dma);
 	if (ret)
-		put_mtt_entries(dev, &cq->user_cq.qbuf_mem);
+		erdma_mem_uninit(dev, &cq->user_cq.qbuf_mem);
 
 	return ret;
 }
@@ -2011,7 +2011,7 @@ int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 err_free_res:
 	if (!rdma_is_kernel_res(&ibcq->res)) {
 		erdma_unmap_user_dbrecords(ctx, &cq->user_cq.user_dbr_page);
-		put_mtt_entries(dev, &cq->user_cq.qbuf_mem);
+		erdma_mem_uninit(dev, &cq->user_cq.qbuf_mem);
 	} else {
 		dma_free_coherent(&dev->pdev->dev, depth << CQE_SHIFT,
 				  cq->kern_cq.qbuf, cq->kern_cq.qbuf_dma_addr);
-- 
2.46.0


