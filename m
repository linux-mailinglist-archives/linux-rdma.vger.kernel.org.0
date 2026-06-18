Return-Path: <linux-rdma+bounces-22344-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hVWJFV95M2ooCgYAu9opvQ
	(envelope-from <linux-rdma+bounces-22344-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 06:51:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 602B169D8F4
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 06:51:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=lBuZZVAd;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22344-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22344-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7327A300530D
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 04:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC40828469F;
	Thu, 18 Jun 2026 04:51:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C9E21C173
	for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2026 04:51:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781758296; cv=none; b=cjJF+yT4iFA4k6wrvxJTfRPH+d3ey+EOGA20rJApspWFYyRv/3jDlkC1CGeXI0XesZprKL3nU59HZzMwI/Or1r+pkyD6JICjootQcx8GbFuKzcSiuyu3/quzuensgjKdlSo5s0LYOg66tE/ClJt13RTRWhIxaz6JN3o4uhL254Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781758296; c=relaxed/simple;
	bh=2api4+J8S+Lih8NX90FvmcnjgJ6P6YFBcp0AvquQPsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MiA7zC+SaHl0bvyJVQWS0rQwKjhEwnGuDQtwGGKJ2dvqAq4euO2ksOjaZfyZY8s3NU079fWAOHRK9yYmOxnkv1mzcSQ0931DucFrdEVRJrGUaTDbUvoExbeKO5Ayp+jE7mtbCyPSOuVOdquqV4oWNMjHyh4OYcCxm1/1yVllbWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lBuZZVAd; arc=none smtp.client-ip=115.124.30.119
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781758284; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=V46c464CJzfN/r6VmEeSp/nT0LVXSw3nj/ZFKdSDnNk=;
	b=lBuZZVAdXzOAs+bkANJutOa5Fkev1mcv5QBEdJ7DcT1fWJL3g15HsHCgTSDDRb20ITXnNOkJLbJPhhPaILOwh/WVbj0AKZ5JtVGzGmUsl1PKCjYM0qQZE3Q5BWdi7omJi5vmKeNb3vvBYnZAoxeJRbErAAOWvNA0/bUZCDs0O4Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=boshiyu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X55c.JJ_1781758283;
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0X55c.JJ_1781758283 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Jun 2026 12:51:23 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	chengyou@linux.alibaba.com,
	kaishen@linux.alibaba.com
Subject: [PATCH for-next v3 3/3] RDMA/erdma: Implement erdma_reg_user_mr_dmabuf
Date: Thu, 18 Jun 2026 12:51:05 +0800
Message-ID: <20260618045120.51210-4-boshiyu@linux.alibaba.com>
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
	TAGGED_FROM(0.00)[bounces-22344-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,alibaba.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 602B169D8F4

Support DMA-BUF based user memory registration using the pinned
revocable dmabuf interface, so that erdma can import dmabufs from
exporters that may require revocation, such as VFIO.

On revocation, the revoke callback destroys the MPT entry in hardware
to stop the device from accessing the revoked memory, while the stag
index is reserved until the MR is fully deregistered, ensuring the key
cannot be obtained by a new region in the meantime.

Refactor the existing erdma_reg_user_mr() into a common
_erdma_reg_user_mr() function that handles both regular and DMA-BUF
memory registration.

Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_main.c  |   1 +
 drivers/infiniband/hw/erdma/erdma_verbs.c | 189 ++++++++++++++++------
 drivers/infiniband/hw/erdma/erdma_verbs.h |   4 +
 3 files changed, 142 insertions(+), 52 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index 7e87a815e853..6e4860428e5b 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -526,6 +526,7 @@ static const struct ib_device_ops erdma_device_ops = {
 	.query_qp = erdma_query_qp,
 	.req_notify_cq = erdma_req_notify_cq,
 	.reg_user_mr = erdma_reg_user_mr,
+	.reg_user_mr_dmabuf = erdma_reg_user_mr_dmabuf,
 	.modify_qp = erdma_modify_qp,
 
 	INIT_RDMA_OBJ_SIZE(ib_cq, erdma_cq, ibcq),
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 98278432ba80..5c6d84d83fc9 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -189,6 +189,20 @@ static int regmr_cmd(struct erdma_dev *dev, struct erdma_mr *mr)
 				   true);
 }
 
+static int dereg_mr_cmd(struct erdma_dev *dev, struct erdma_mr *mr)
+{
+	struct erdma_cmdq_dereg_mr_req req = {};
+
+	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_RDMA,
+				CMDQ_OPCODE_DEREG_MR);
+
+	req.cfg = FIELD_PREP(ERDMA_CMD_MR_MPT_IDX_MASK, mr->ibmr.lkey >> 8) |
+		  FIELD_PREP(ERDMA_CMD_MR_KEY_MASK, mr->ibmr.lkey & 0xFF);
+
+	return erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL,
+				   true);
+}
+
 static int create_cq_cmd(struct erdma_ucontext *uctx, struct erdma_cq *cq)
 {
 	struct erdma_dev *dev = to_edev(cq->ibcq.device);
@@ -828,50 +842,50 @@ static void erdma_destroy_mtt(struct erdma_dev *dev, struct erdma_mtt *mtt)
 	}
 }
 
-static int erdma_mem_init(struct erdma_dev *dev, struct erdma_mem *mem,
-			  struct erdma_mem_init_attr *attr)
+static int erdma_mem_init_by_umem(struct erdma_dev *dev, struct erdma_mem *mem,
+				  struct erdma_mem_init_attr *attr,
+				  struct ib_umem *umem)
 {
-	int ret = 0;
-
-	mem->umem =
-		ib_umem_get_va(&dev->ibdev, attr->start, attr->len, attr->access);
-	if (IS_ERR(mem->umem)) {
-		ret = PTR_ERR(mem->umem);
-		mem->umem = NULL;
-		return ret;
-	}
-
+	mem->umem = umem;
 	mem->va = attr->virt;
 	mem->len = attr->len;
 
 	mem->page_size = ib_umem_find_best_pgsz(mem->umem, attr->req_page_size,
 						attr->virt);
-	if (!mem->page_size) {
-		ret = -EINVAL;
-		goto error_ret;
-	}
+	if (!mem->page_size)
+		return -EINVAL;
 
 	mem->page_offset = attr->start & (mem->page_size - 1);
 	mem->mtt_nents = ib_umem_num_dma_blocks(mem->umem, mem->page_size);
 	mem->page_cnt = mem->mtt_nents;
 	mem->mtt = erdma_create_mtt(dev, MTT_SIZE(mem->page_cnt),
 				    attr->flags & ERDMA_MEM_FLAG_MTT_PHYS_CONT);
-	if (IS_ERR(mem->mtt)) {
-		ret = PTR_ERR(mem->mtt);
-		goto error_ret;
-	}
+	if (IS_ERR(mem->mtt))
+		return PTR_ERR(mem->mtt);
 
 	erdma_fill_bottom_mtt(dev, mem);
 
 	return 0;
+}
 
-error_ret:
-	if (mem->umem) {
-		ib_umem_release(mem->umem);
-		mem->umem = NULL;
+static int erdma_mem_init(struct erdma_dev *dev, struct erdma_mem *mem,
+			  struct erdma_mem_init_attr *attr)
+{
+	struct ib_umem *umem;
+	int ret;
+
+	umem = ib_umem_get_va(&dev->ibdev, attr->start, attr->len,
+			      attr->access);
+	if (IS_ERR(umem))
+		return PTR_ERR(umem);
+
+	ret = erdma_mem_init_by_umem(dev, mem, attr, umem);
+	if (ret) {
+		ib_umem_release(umem);
+		return ret;
 	}
 
-	return ret;
+	return 0;
 }
 
 static void erdma_mem_uninit(struct erdma_dev *dev, struct erdma_mem *mem)
@@ -1244,9 +1258,20 @@ int erdma_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 	return num;
 }
 
-struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
-				u64 virt, int access, struct ib_dmah *dmah,
-				struct ib_udata *udata)
+static void erdma_umem_dmabuf_revoke(void *priv)
+{
+	struct erdma_mr *mr = priv;
+	struct erdma_dev *dev = to_edev(mr->ibmr.device);
+	int ret;
+
+	ret = dereg_mr_cmd(dev, mr);
+	if (ret)
+		ibdev_err(&dev->ibdev, "dmabuf mr revoke failed %d", ret);
+}
+
+static struct ib_mr *
+_erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len, u64 virt, int access,
+		   struct ib_umem *umem, struct ib_dmah *dmah)
 {
 	struct erdma_dev *dev = to_edev(ibpd->device);
 	struct erdma_mem_init_attr attr = {};
@@ -1254,12 +1279,6 @@ struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 	u32 stag;
 	int ret;
 
-	if (dmah)
-		return ERR_PTR(-EOPNOTSUPP);
-
-	if (!len || len > dev->attrs.max_mr_size)
-		return ERR_PTR(-EINVAL);
-
 	mr = kzalloc_obj(*mr);
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
@@ -1269,16 +1288,17 @@ struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 	attr.start = start;
 	attr.access = access;
 	attr.req_page_size = SZ_2G - SZ_4K;
-	ret = erdma_mem_init(dev, &mr->mem, &attr);
+	ret = erdma_mem_init_by_umem(dev, &mr->mem, &attr, umem);
 	if (ret)
 		goto err_out_free;
 
 	ret = erdma_create_stag(dev, &stag);
 	if (ret)
-		goto err_uninit_mem;
+		goto err_destroy_mtt;
 
 	mr->ibmr.lkey = mr->ibmr.rkey = stag;
 	mr->ibmr.pd = ibpd;
+	mr->ibmr.device = ibpd->device;
 	mr->access = ERDMA_MR_ACC_LR | to_erdma_access_flags(access);
 	mr->valid = 1;
 	mr->type = ERDMA_MR_TYPE_NORMAL;
@@ -1293,8 +1313,8 @@ struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 	erdma_free_idx(&dev->res_cb[ERDMA_RES_TYPE_STAG_IDX],
 		       mr->ibmr.lkey >> 8);
 
-err_uninit_mem:
-	erdma_mem_uninit(dev, &mr->mem);
+err_destroy_mtt:
+	erdma_destroy_mtt(dev, mr->mem.mtt);
 
 err_out_free:
 	kfree(mr);
@@ -1302,30 +1322,95 @@ struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 	return ERR_PTR(ret);
 }
 
+struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
+				u64 virt, int access, struct ib_dmah *dmah,
+				struct ib_udata *udata)
+{
+	struct erdma_dev *dev = to_edev(ibpd->device);
+	struct ib_umem *umem;
+	struct ib_mr *ibmr;
+
+	if (dmah)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (!len || len > dev->attrs.max_mr_size)
+		return ERR_PTR(-EINVAL);
+
+	umem = ib_umem_get_va(&dev->ibdev, start, len, access);
+	if (IS_ERR(umem))
+		return ERR_CAST(umem);
+
+	ibmr = _erdma_reg_user_mr(ibpd, start, len, virt, access, umem, dmah);
+	if (IS_ERR(ibmr)) {
+		ib_umem_release(umem);
+		return ibmr;
+	}
+
+	return ibmr;
+}
+
+struct ib_mr *erdma_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start, u64 len,
+				       u64 virt, int fd, int access,
+				       struct ib_dmah *dmah,
+				       struct uverbs_attr_bundle *attrs)
+{
+	struct erdma_dev *dev = to_edev(ibpd->device);
+	struct ib_umem_dmabuf *umem_dmabuf;
+	struct ib_mr *ibmr;
+
+	if (dmah)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (!len || len > dev->attrs.max_mr_size)
+		return ERR_PTR(-EINVAL);
+
+	umem_dmabuf =
+		ib_umem_dmabuf_get_pinned_revocable_and_lock(&dev->ibdev, start,
+							     len, fd, access);
+	if (IS_ERR(umem_dmabuf))
+		return ERR_CAST(umem_dmabuf);
+
+	ibmr = _erdma_reg_user_mr(ibpd, start, len, virt, access,
+				  &umem_dmabuf->umem, dmah);
+	if (IS_ERR(ibmr)) {
+		ib_umem_dmabuf_revoke_unlock(umem_dmabuf);
+		ib_umem_release(&umem_dmabuf->umem);
+		return ibmr;
+	}
+
+	ib_umem_dmabuf_set_revoke_locked(umem_dmabuf, erdma_umem_dmabuf_revoke,
+					 to_emr(ibmr));
+	ib_umem_dmabuf_revoke_unlock(umem_dmabuf);
+
+	return ibmr;
+}
+
 int erdma_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
-	struct erdma_mr *mr;
 	struct erdma_dev *dev = to_edev(ibmr->device);
-	struct erdma_cmdq_dereg_mr_req req;
+	struct erdma_mr *mr = to_emr(ibmr);
+	bool dmabuf;
 	int ret;
 
-	mr = to_emr(ibmr);
-
-	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_RDMA,
-				CMDQ_OPCODE_DEREG_MR);
+	dmabuf = mr->mem.umem && mr->mem.umem->is_dmabuf;
+	if (!dmabuf) {
+		ret = dereg_mr_cmd(dev, mr);
+		if (ret)
+			return ret;
+	}
 
-	req.cfg = FIELD_PREP(ERDMA_CMD_MR_MPT_IDX_MASK, ibmr->lkey >> 8) |
-		  FIELD_PREP(ERDMA_CMD_MR_KEY_MASK, ibmr->lkey & 0xFF);
+	if (mr->mem.umem) {
+		ib_umem_release(mr->mem.umem);
+		mr->mem.umem = NULL;
+	}
 
-	ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL,
-				  true);
-	if (ret)
-		return ret;
+	if (mr->mem.mtt) {
+		erdma_destroy_mtt(dev, mr->mem.mtt);
+		mr->mem.mtt = NULL;
+	}
 
 	erdma_free_idx(&dev->res_cb[ERDMA_RES_TYPE_STAG_IDX], ibmr->lkey >> 8);
 
-	erdma_mem_uninit(dev, &mr->mem);
-
 	kfree(mr);
 	return 0;
 }
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index 79b3a90b03e7..f576f062aff3 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -467,6 +467,10 @@ int erdma_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
 struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 				u64 virt, int access, struct ib_dmah *dmah,
 				struct ib_udata *udata);
+struct ib_mr *erdma_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start, u64 len,
+				       u64 virt, int fd, int access,
+				       struct ib_dmah *dmah,
+				       struct uverbs_attr_bundle *attrs);
 struct ib_mr *erdma_get_dma_mr(struct ib_pd *ibpd, int rights);
 int erdma_dereg_mr(struct ib_mr *ibmr, struct ib_udata *data);
 int erdma_mmap(struct ib_ucontext *ctx, struct vm_area_struct *vma);
-- 
2.46.0


