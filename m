Return-Path: <linux-rdma+bounces-20116-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBAgCH4k/GnxLwAAu9opvQ
	(envelope-from <linux-rdma+bounces-20116-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 07:34:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9E44E31F5
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 07:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9F13300A33D
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 05:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7748040DFA3;
	Thu,  7 May 2026 05:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EpCHeWq9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B1D25A655
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 05:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778132092; cv=none; b=SJMXjgyITjC1GjFmaoj6qzPrp+mAxjnyLmHuEzzBOWsjmFDiQSHLQyM4OHqd0xKjBQ4ViSz0VVQldzlp9WcPQr4i7ucro8yLWpSQ3GL+v0VPJASP9iJlVSc6rdBHNGHBRhU9WjLuTA/Xb8ZxL19GJ8HOgEWhR8BwdehzJNnkykI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778132092; c=relaxed/simple;
	bh=3EDq/af6Y3TKEB2WmcnqW30zhpmecwY837s4uyEfCFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQetGIJlfDKdZfkpjvG32Df4jlVjh5x3DCQyg4t8GecxuDNuEU4KnUhdXmyFgkiYbAyd6LVA/TjSMpV4YFSnzbisuH78Es9SGT6J2Yt80tdeGxsZSrGLc9Fp1W+tfwWa+hjMzWIuvLLbXw98FCxj7rc8EUm2Ei6pGF1pcVH8i7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EpCHeWq9; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778132081; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=W1vDl10VnyzrGBUhIaeaMbu+K/uz+MPnZqUQfdQmHDo=;
	b=EpCHeWq90NyHlEinpOV5GANRxkmBdcz4D+CCZ2o/xQhE4aL+/5NmQ5dyt0frOByNdsdfyf+6wcpkx6N78AOvhwsX7yswg3kgXR6kNT/tgQ4S/+0dlnrOdvTbOonDSu/4sS2F6vw59KVGE7sYoJfmTSv9qnD/uJDmBMJ/gxmoeto=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=boshiyu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X2TQgex_1778132080;
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0X2TQgex_1778132080 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 May 2026 13:34:41 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	chengyou@linux.alibaba.com,
	kaishen@linux.alibaba.com
Subject: [PATCH for-next 2/3] RDMA/erdma: Introduce struct erdma_mem_init_attr
Date: Thu,  7 May 2026 13:34:20 +0800
Message-ID: <20260507053437.46211-3-boshiyu@linux.alibaba.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260507053437.46211-1-boshiyu@linux.alibaba.com>
References: <20260507053437.46211-1-boshiyu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AB9E44E31F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20116-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[boshiyu@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Action: no action

Pass struct erdma_mem_init_attr to the erdma_mem_init() interface.

Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 57 ++++++++++++++---------
 drivers/infiniband/hw/erdma/erdma_verbs.h | 13 ++++++
 2 files changed, 49 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index a418a3c92754..59a2b8464a6f 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -824,26 +824,27 @@ static void erdma_destroy_mtt(struct erdma_dev *dev, struct erdma_mtt *mtt)
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
+	mem->page_size = ib_umem_find_best_pgsz(mem->umem, attr->req_page_size,
+						attr->virt);
+	mem->page_offset = attr->start & (mem->page_size - 1);
 	mem->mtt_nents = ib_umem_num_dma_blocks(mem->umem, mem->page_size);
 	mem->page_cnt = mem->mtt_nents;
 	mem->mtt = erdma_create_mtt(dev, MTT_SIZE(mem->page_cnt),
-				    force_continuous);
+				    attr->flags & ERDMA_MEM_FLAG_MTT_PHYS_CONT);
 	if (IS_ERR(mem->mtt)) {
 		ret = PTR_ERR(mem->mtt);
 		goto error_ret;
@@ -938,6 +939,7 @@ erdma_unmap_user_dbrecords(struct erdma_ucontext *ctx,
 static int init_user_qp(struct erdma_qp *qp, struct erdma_ucontext *uctx,
 			u64 va, u32 len, u64 dbrec_va)
 {
+	struct erdma_mem_init_attr attr = {};
 	dma_addr_t dbrec_dma;
 	u32 rq_offset;
 	int ret;
@@ -946,18 +948,22 @@ static int init_user_qp(struct erdma_qp *qp, struct erdma_ucontext *uctx,
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
 
@@ -1233,8 +1239,9 @@ struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 				u64 virt, int access, struct ib_dmah *dmah,
 				struct ib_udata *udata)
 {
-	struct erdma_mr *mr = NULL;
 	struct erdma_dev *dev = to_edev(ibpd->device);
+	struct erdma_mem_init_attr attr = {};
+	struct erdma_mr *mr = NULL;
 	u32 stag;
 	int ret;
 
@@ -1248,8 +1255,12 @@ struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
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
 
@@ -1904,12 +1915,16 @@ int erdma_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
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


