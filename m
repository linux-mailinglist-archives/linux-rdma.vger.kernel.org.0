Return-Path: <linux-rdma+bounces-20907-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wByKEfADC2qj/QQAu9opvQ
	(envelope-from <linux-rdma+bounces-20907-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 14:20:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 701B456C7D0
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 14:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F7953069D39
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 12:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1D73FBED8;
	Mon, 18 May 2026 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fN6XGJ4F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834793E9C09
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 12:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106009; cv=none; b=sYdAha+pY0LeyVYPYWP2ZrcXYmYcmQrz6BeskYfoyE61cZBsHaVfHYi9OA24r8Nc7TYjaTq0bqP0zykDKIThymHrpoeOjtIh4b3ZW4YaalA0KMi3trhwEySFsNB8UU7klG6tDBX5MsiaYecDlPTaFEwjW/aHO077PGtFxkW6plo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106009; c=relaxed/simple;
	bh=sphPtDJpwGXORnM5lAdfqOn72W3pNFRPKX3y6JxcVf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNUxf/tkuEvIHDvQz/tFOtl+RSV2ojjQQBQaud2WCJQgnGcVNXa96zTzc8MkRFzzEhq5tsH037s2dfgCKcBYBZFXyIab2WG5rYOgQVALAvKn8L9TTvKV5EZ3ZR+BrD7XLlcDdWJumGvdzd1iXEM3zLl3Xfj6RaLM2Of28DOAScw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fN6XGJ4F; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779106001; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=YU4OyweNa19AIBpSXtpoaYfN20IiZbYBZUU8N3O1LzA=;
	b=fN6XGJ4F4z2WCj72HfRfd9MX5mqeEmbNNrjaRqLCw/Zx7wjqWFTIHJRe1uK5U7cyU1nE/BZjDA5JXcgCGsZnFYrbUWw0IHi94gtp+W9HPJFACgujGncnrAkcef6v9vHoVIG8eN/qBJDGWvqL/fKZigInOKjkDkUvqF/pI4w8CR0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=boshiyu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X392cp._1779106000;
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0X392cp._1779106000 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 20:06:40 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	chengyou@linux.alibaba.com,
	kaishen@linux.alibaba.com
Subject: [PATCH for-next v2 3/3] RDMA/erdma: Implement erdma_reg_user_mr_dmabuf
Date: Mon, 18 May 2026 20:06:28 +0800
Message-ID: <20260518120637.16831-4-boshiyu@linux.alibaba.com>
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
X-Rspamd-Queue-Id: 701B456C7D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20907-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

Support DMA-BUF based user memory registration by adding the
erdma_reg_user_mr_dmabuf() callback. We refactor the existing
erdma_reg_user_mr() into a common _erdma_reg_user_mr() function
that handles both regular and DMA-BUF memory registration.

Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_main.c  |  1 +
 drivers/infiniband/hw/erdma/erdma_verbs.c | 55 ++++++++++++++++++-----
 drivers/infiniband/hw/erdma/erdma_verbs.h |  6 +++
 3 files changed, 51 insertions(+), 11 deletions(-)

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
index 7cfe0ce3c9c0..995cc208cdd7 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -826,14 +826,27 @@ static void erdma_destroy_mtt(struct erdma_dev *dev, struct erdma_mtt *mtt)
 static int erdma_mem_init(struct erdma_dev *dev, struct erdma_mem *mem,
 			  struct erdma_mem_init_attr *attr)
 {
+	struct ib_umem_dmabuf *umem_dmabuf;
 	int ret = 0;
 
-	mem->umem =
-		ib_umem_get(&dev->ibdev, attr->start, attr->len, attr->access);
-	if (IS_ERR(mem->umem)) {
-		ret = PTR_ERR(mem->umem);
-		mem->umem = NULL;
-		return ret;
+	if (attr->flags & ERDMA_MEM_FLAG_DMABUF) {
+		umem_dmabuf = ib_umem_dmabuf_get_pinned(&dev->ibdev,
+							attr->start, attr->len,
+							attr->fd, attr->access);
+		if (IS_ERR(umem_dmabuf)) {
+			ret = PTR_ERR(umem_dmabuf);
+			mem->umem = NULL;
+			return ret;
+		}
+		mem->umem = &umem_dmabuf->umem;
+	} else {
+		mem->umem = ib_umem_get(&dev->ibdev, attr->start, attr->len,
+					attr->access);
+		if (IS_ERR(mem->umem)) {
+			ret = PTR_ERR(mem->umem);
+			mem->umem = NULL;
+			return ret;
+		}
 	}
 
 	mem->va = attr->virt;
@@ -1239,9 +1252,10 @@ int erdma_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 	return num;
 }
 
-struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
-				u64 virt, int access, struct ib_dmah *dmah,
-				struct ib_udata *udata)
+static struct ib_mr *
+_erdma_reg_user_mr(struct ib_pd *ibpd, struct ib_udata *udata,
+		   struct ib_dmah *dmah, u64 start, u64 len, u64 virt,
+		   int access, int fd, bool dmabuf)
 {
 	struct erdma_dev *dev = to_edev(ibpd->device);
 	struct erdma_mem_init_attr attr = {};
@@ -1259,6 +1273,10 @@ struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
+	if (dmabuf)
+		attr.flags |= ERDMA_MEM_FLAG_DMABUF;
+
+	attr.fd = fd;
 	attr.len = len;
 	attr.virt = virt;
 	attr.start = start;
@@ -1274,8 +1292,6 @@ struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 
 	mr->ibmr.lkey = mr->ibmr.rkey = stag;
 	mr->ibmr.pd = ibpd;
-	mr->mem.va = virt;
-	mr->mem.len = len;
 	mr->access = ERDMA_MR_ACC_LR | to_erdma_access_flags(access);
 	mr->valid = 1;
 	mr->type = ERDMA_MR_TYPE_NORMAL;
@@ -1299,6 +1315,23 @@ struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 	return ERR_PTR(ret);
 }
 
+struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
+				u64 virt, int access, struct ib_dmah *dmah,
+				struct ib_udata *udata)
+{
+	return _erdma_reg_user_mr(ibpd, udata, dmah, start, len, virt, access,
+				  0, false);
+}
+
+struct ib_mr *erdma_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start, u64 len,
+				       u64 virt, int fd, int access,
+				       struct ib_dmah *dmah,
+				       struct uverbs_attr_bundle *attrs)
+{
+	return _erdma_reg_user_mr(ibpd, &attrs->driver_udata, dmah, start, len,
+				  virt, access, fd, true);
+}
+
 int erdma_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
 	struct erdma_mr *mr;
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index 79b3a90b03e7..15bdad8b14ce 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -110,6 +110,7 @@ struct erdma_mtt {
 
 enum erdma_mem_flags {
 	ERDMA_MEM_FLAG_MTT_PHYS_CONT = (1 << 0),
+	ERDMA_MEM_FLAG_DMABUF = (1 << 1),
 };
 
 struct erdma_mem_init_attr {
@@ -118,6 +119,7 @@ struct erdma_mem_init_attr {
 	u64 len;
 	unsigned long req_page_size;
 	int access;
+	int fd;
 	u32 flags;
 };
 
@@ -467,6 +469,10 @@ int erdma_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
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


