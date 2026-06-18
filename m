Return-Path: <linux-rdma+bounces-22342-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HF5mFFV5M2ogCgYAu9opvQ
	(envelope-from <linux-rdma+bounces-22342-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 06:51:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEAC69D8EC
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 06:51:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=djdaBIWJ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22342-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22342-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58AED3008FC0
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 04:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D462A2E7396;
	Thu, 18 Jun 2026 04:51:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5F221C173
	for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2026 04:51:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781758288; cv=none; b=InrJKLhEzGv39HbGeNXTN/YBFRLk66/9/KI+QLmSQ03Mzk1EUYY3DI9j+x8YWWL5pmL7xqiw+UyXQWS5uIfRAgHY4ihxRcub6IQn1+yySZklLAoSCy5hxDvsfdWmky0pfsFzW1eCSdHmjtVP7fGq0kADNElsfJ8oZY42fuqWUwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781758288; c=relaxed/simple;
	bh=Pbxk65TGwhhLqLeWtIlex1yQ4n9302LYfWgHClN+1YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DH+9v5lRCwBdwtOO9mK0p5ZWSOLrkMvrd2N4Irm8SCW2gD3p9FWLNkWPl/z3Et4lR8HJZAxI/7U1oZPZOQ8Tk78lTp5VWynuCNLmWovW0g7I40k1NPnqjucl4RaDcXaQO6al6thcro/m97HT5qQhJsw7RdY3xozTxKnumvbIxL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=djdaBIWJ; arc=none smtp.client-ip=115.124.30.99
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781758283; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=A10Wi3Mx3+Z3PWCxBuAXGAYtmvQa+vQbz47DTDm+vo0=;
	b=djdaBIWJAlf9RAufJxc8dLii0BUxSgWNh2cZwBjKElOVUHQJ4M2p154PUFpHm1r7aCNIQy2yEE1x7ev7bqpUKelOIOMKW5o/UU5k5LBzb8yRXpnCWjPifEHT2FhYW6R7x0x3coK2i/3pfsXx/HQD0OkD+D5z6O15uk9SAbiPrWs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=boshiyu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X55atD0_1781758282;
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0X55atD0_1781758282 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Jun 2026 12:51:23 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	chengyou@linux.alibaba.com,
	kaishen@linux.alibaba.com
Subject: [PATCH for-next v3 2/3] RDMA/erdma: Introduce struct erdma_mem_init_attr
Date: Thu, 18 Jun 2026 12:51:04 +0800
Message-ID: <20260618045120.51210-3-boshiyu@linux.alibaba.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22342-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[boshiyu@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:chengyou@linux.alibaba.com,m:kaishen@linux.alibaba.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,alibaba.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4DEAC69D8EC

Pass struct erdma_mem_init_attr to the erdma_mem_init() interface.
Additionally, validate the return value of ib_umem_find_best_pgsz().

Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 65 +++++++++++++++--------
 drivers/infiniband/hw/erdma/erdma_verbs.h | 13 +++++
 2 files changed, 55 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 92cd8cd846b6..98278432ba80 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -829,26 +829,33 @@ static void erdma_destroy_mtt(struct erdma_dev *dev, struct erdma_mtt *mtt)
 }
 
 static int erdma_mem_init(struct erdma_dev *dev, struct erdma_mem *mem,
-			  u64 start, u64 len, int access, u64 virt,
-			  unsigned long req_page_size, bool force_continuous)
+			  struct erdma_mem_init_attr *attr)
 {
 	int ret = 0;
 
-	mem->umem = ib_umem_get_va(&dev->ibdev, start, len, access);
+	mem->umem =
+		ib_umem_get_va(&dev->ibdev, attr->start, attr->len, attr->access);
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
@@ -943,6 +950,7 @@ erdma_unmap_user_dbrecords(struct erdma_ucontext *ctx,
 static int init_user_qp(struct erdma_qp *qp, struct erdma_ucontext *uctx,
 			u64 va, u32 len, u64 dbrec_va)
 {
+	struct erdma_mem_init_attr attr = {};
 	dma_addr_t dbrec_dma;
 	u32 rq_offset;
 	int ret;
@@ -951,18 +959,22 @@ static int init_user_qp(struct erdma_qp *qp, struct erdma_ucontext *uctx,
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
-			     qp->attrs.rq_size << RQE_SHIFT, 0, va + rq_offset,
-			     (SZ_1M - SZ_4K), true);
+	attr.virt = va + rq_offset;
+	attr.start = va + rq_offset;
+	attr.len = qp->attrs.rq_size << RQE_SHIFT;
+	ret = erdma_mem_init(qp->dev, &qp->user_qp.rq_mem, &attr);
 	if (ret)
 		goto uninit_sq_mem;
 
@@ -1236,8 +1248,9 @@ struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 				u64 virt, int access, struct ib_dmah *dmah,
 				struct ib_udata *udata)
 {
-	struct erdma_mr *mr = NULL;
 	struct erdma_dev *dev = to_edev(ibpd->device);
+	struct erdma_mem_init_attr attr = {};
+	struct erdma_mr *mr = NULL;
 	u32 stag;
 	int ret;
 
@@ -1251,8 +1264,12 @@ struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
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
 
@@ -1262,8 +1279,6 @@ struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 
 	mr->ibmr.lkey = mr->ibmr.rkey = stag;
 	mr->ibmr.pd = ibpd;
-	mr->mem.va = virt;
-	mr->mem.len = len;
 	mr->access = ERDMA_MR_ACC_LR | to_erdma_access_flags(access);
 	mr->valid = 1;
 	mr->type = ERDMA_MR_TYPE_NORMAL;
@@ -1907,12 +1922,16 @@ int erdma_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
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


