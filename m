Return-Path: <linux-rdma+bounces-20906-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNdQM/gDC2qj/QQAu9opvQ
	(envelope-from <linux-rdma+bounces-20906-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 14:20:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1A956C7DE
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 14:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F7983025D52
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 12:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD75D3F6C20;
	Mon, 18 May 2026 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vn8IzJU2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BDE3FB7D1
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106009; cv=none; b=Ik6fiqZam03spWlgIw2beqQGjPZDZU566/oCKYcM8qYjMHBoBCHKPCNueY8+psrwf345qXPhM0UbJ3i/JlmN8EKTiYYrsr6O82lvtNQrFxTxszPEWH+2t3+IgkaoxDXFpqu/bb3B2ewlGRVcC3oLCWDf5A6Y4H8W8e2f1bvRMgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106009; c=relaxed/simple;
	bh=OHzh09OS2cpDAfb6WpZkH/sDuN98JwJ8TWbS22nWyio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gu6qPQU8UGc7R9IUMx/1VpMbiuSu3UOe9kcqhrbHNW230GfhluaIrH6cR0fkoxnhHFjI1J/wNiYEVDyhSTUnv9FUsAz+k2EQ7AIyq8iRJaSvUPlUt10qxHtaJ6xVQbRGNNiHiWUm0gJm1UbCSjPwKZ+4fGC5Nb3Rhul5NfQ7RYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vn8IzJU2; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779106000; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=u7eK8d98EAUGi4tsq4utjaPcCp0C36+T9AzDfq3iziw=;
	b=vn8IzJU2WsrHPO2zb8lZDn4KhqFm2x20EMSZaLB8+0ilcwex2xOIENJGrztRQoKjCvV/ZUW3zkYKV+LsEk3TK8JFiW8xBfXJuCG+Z9IOWv4ERMMzqTvsJ4dd0+6LRBfQbbgzxP3qN/Kx7W9BrLsoF5UXCPy3teK5AiMwsPm3dJA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=boshiyu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X38ATPS_1779105999;
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0X38ATPS_1779105999 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 20:06:39 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	chengyou@linux.alibaba.com,
	kaishen@linux.alibaba.com
Subject: [PATCH for-next v2 2/3] RDMA/erdma: Introduce struct erdma_mem_init_attr
Date: Mon, 18 May 2026 20:06:27 +0800
Message-ID: <20260518120637.16831-3-boshiyu@linux.alibaba.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260518120637.16831-1-boshiyu@linux.alibaba.com>
References: <20260518120637.16831-1-boshiyu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CF1A956C7DE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20906-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boshiyu@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Pass struct erdma_mem_init_attr to the erdma_mem_init() interface.
Additionally, validate the return value of ib_umem_find_best_pgsz().

Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 63 +++++++++++++++--------
 drivers/infiniband/hw/erdma/erdma_verbs.h | 13 +++++
 2 files changed, 55 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 5ab66c9d8bdc..7cfe0ce3c9c0 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -824,26 +824,33 @@ static void erdma_destroy_mtt(struct erdma_dev *dev, struct erdma_mtt *mtt)
 }
 
 static int erdma_mem_init(struct erdma_dev *dev, struct erdma_mem *mem,
-			  u64 start, u64 len, int access, u64 virt,
-			  unsigned long req_page_size, bool force_continuous)
+			  struct erdma_mem_init_attr *attr)
 {
 	int ret = 0;
 
-	mem->umem = ib_umem_get(&dev->ibdev, start, len, access);
+	mem->umem =
+		ib_umem_get(&dev->ibdev, attr->start, attr->len, attr->access);
 	if (IS_ERR(mem->umem)) {
 		ret = PTR_ERR(mem->umem);
 		mem->umem = NULL;
 		return ret;
 	}
 
-	mem->va = virt;
-	mem->len = len;
-	mem->page_size = ib_umem_find_best_pgsz(mem->umem, req_page_size, virt);
-	mem->page_offset = start & (mem->page_size - 1);
+	mem->va = attr->virt;
+	mem->len = attr->len;
+
+	mem->page_size = ib_umem_find_best_pgsz(mem->umem, attr->req_page_size,
+						attr->virt);
+	if (!mem->page_size) {
+		ret = -EINVAL;
+		goto error_ret;
+	}
+
+	mem->page_offset = attr->start & (mem->page_size - 1);
 	mem->mtt_nents = ib_umem_num_dma_blocks(mem->umem, mem->page_size);
 	mem->page_cnt = mem->mtt_nents;
 	mem->mtt = erdma_create_mtt(dev, MTT_SIZE(mem->page_cnt),
-				    force_continuous);
+				    attr->flags & ERDMA_MEM_FLAG_MTT_PHYS_CONT);
 	if (IS_ERR(mem->mtt)) {
 		ret = PTR_ERR(mem->mtt);
 		goto error_ret;
@@ -938,6 +945,7 @@ erdma_unmap_user_dbrecords(struct erdma_ucontext *ctx,
 static int init_user_qp(struct erdma_qp *qp, struct erdma_ucontext *uctx,
 			u64 va, u32 len, u64 dbrec_va)
 {
+	struct erdma_mem_init_attr attr = {};
 	dma_addr_t dbrec_dma;
 	u32 rq_offset;
 	int ret;
@@ -946,18 +954,22 @@ static int init_user_qp(struct erdma_qp *qp, struct erdma_ucontext *uctx,
 		   qp->attrs.rq_size * RQE_SIZE))
 		return -EINVAL;
 
-	ret = erdma_mem_init(qp->dev, &qp->user_qp.sq_mem, va,
-			     qp->attrs.sq_size << SQEBB_SHIFT, 0, va,
-			     (SZ_1M - SZ_4K), true);
+	attr.virt = va;
+	attr.start = va;
+	attr.req_page_size = SZ_1M - SZ_4K;
+	attr.len = qp->attrs.sq_size << SQEBB_SHIFT;
+	attr.flags = ERDMA_MEM_FLAG_MTT_PHYS_CONT;
+	ret = erdma_mem_init(qp->dev, &qp->user_qp.sq_mem, &attr);
 	if (ret)
 		return ret;
 
 	rq_offset = ALIGN(qp->attrs.sq_size << SQEBB_SHIFT, ERDMA_HW_PAGE_SIZE);
 	qp->user_qp.rq_offset = rq_offset;
 
-	ret = erdma_mem_init(qp->dev, &qp->user_qp.rq_mem, va + rq_offset,
-			      qp->attrs.rq_size << RQE_SHIFT, 0, va + rq_offset,
-			      (SZ_1M - SZ_4K), true);
+	attr.virt = va + rq_offset;
+	attr.start = va + rq_offset;
+	attr.len = qp->attrs.rq_size << RQE_SHIFT;
+	ret = erdma_mem_init(qp->dev, &qp->user_qp.rq_mem, &attr);
 	if (ret)
 		goto uninit_sq_mem;
 
@@ -1231,8 +1243,9 @@ struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 				u64 virt, int access, struct ib_dmah *dmah,
 				struct ib_udata *udata)
 {
-	struct erdma_mr *mr = NULL;
 	struct erdma_dev *dev = to_edev(ibpd->device);
+	struct erdma_mem_init_attr attr = {};
+	struct erdma_mr *mr = NULL;
 	u32 stag;
 	int ret;
 
@@ -1246,8 +1259,12 @@ struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
-	ret = erdma_mem_init(dev, &mr->mem, start, len, access, virt,
-			     SZ_2G - SZ_4K, false);
+	attr.len = len;
+	attr.virt = virt;
+	attr.start = start;
+	attr.access = access;
+	attr.req_page_size = SZ_2G - SZ_4K;
+	ret = erdma_mem_init(dev, &mr->mem, &attr);
 	if (ret)
 		goto err_out_free;
 
@@ -1902,12 +1919,16 @@ int erdma_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 static int erdma_init_user_cq(struct erdma_ucontext *ctx, struct erdma_cq *cq,
 			      struct erdma_ureq_create_cq *ureq)
 {
-	int ret;
 	struct erdma_dev *dev = to_edev(cq->ibcq.device);
+	struct erdma_mem_init_attr attr = {};
+	int ret;
 
-	ret = erdma_mem_init(dev, &cq->user_cq.qbuf_mem, ureq->qbuf_va,
-			     ureq->qbuf_len, 0, ureq->qbuf_va, SZ_64M - SZ_4K,
-			     true);
+	attr.len = ureq->qbuf_len;
+	attr.virt = ureq->qbuf_va;
+	attr.start = ureq->qbuf_va;
+	attr.req_page_size = SZ_64M - SZ_4K;
+	attr.flags = ERDMA_MEM_FLAG_MTT_PHYS_CONT;
+	ret = erdma_mem_init(dev, &cq->user_cq.qbuf_mem, &attr);
 	if (ret)
 		return ret;
 
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index 7d8d3fe501d5..79b3a90b03e7 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -108,6 +108,19 @@ struct erdma_mtt {
 	struct erdma_mtt *low_level;
 };
 
+enum erdma_mem_flags {
+	ERDMA_MEM_FLAG_MTT_PHYS_CONT = (1 << 0),
+};
+
+struct erdma_mem_init_attr {
+	u64 start;
+	u64 virt;
+	u64 len;
+	unsigned long req_page_size;
+	int access;
+	u32 flags;
+};
+
 struct erdma_mem {
 	struct ib_umem *umem;
 	struct erdma_mtt *mtt;
-- 
2.46.0


