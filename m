Return-Path: <linux-rdma+bounces-20118-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLkzBoQk/GnxLwAAu9opvQ
	(envelope-from <linux-rdma+bounces-20118-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 07:35:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 613E64E3204
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 07:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C29C330072BA
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 05:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6447331ED83;
	Thu,  7 May 2026 05:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="e40LqxrS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AC55464D
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 05:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778132093; cv=none; b=lXSaK4E12nWC3A13zYmO/Vz0S4fwWcKjSnCEYyqdiwflkyt0SxmGQfXJpAl/mcCrzKDiXL/2Cjd5jodn7nuwfYzDtjgRq23VRy3Vp63n0/EWs49eHu9GzQrp0tTz+3H50nDyX+AVqjF8uXsl3ZH4uxAe6veXjZjtLyP4VS61ZkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778132093; c=relaxed/simple;
	bh=h5Y7BPW9wA4bOetpOfNsgT4sqQBY5qYB+uFNh6g4wC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSL6GuhCAEqDMyU+qkG6Z6bLhOoGNwZ9aeF//19MhHyAngRDtb392xBrv5nAjuIxqVCUWxVoEenHS2/bBp8smhF2uceXTL2W2SDr1N4W34QQx8Xr38fVc3i5c1BcTlkna8dWYPxL2l2DINilr8LOifIuEXEyhcAK6QUmRJhrmYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=e40LqxrS; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778132082; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0G4l9yIHTvRg6z6T7CSCXG/dVvP4WltPGGsYQmlUKrI=;
	b=e40LqxrSZRAjFcWx0o4ZwuAqkXWRw8T1WPlRYFSirX1Q2zvzH5963DQbAcRRjdn3PBcr3aHm3W+MRHjtNGqsL6wq3clOx224FLl/2WrCp1zMt/pmUBHv4SSy8oxKVK9tFVhqg5ANTm0eRvavYqFweykM9Yz7jWds8jsgmiB+GSU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=boshiyu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X2TQgfH_1778132081;
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0X2TQgfH_1778132081 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 May 2026 13:34:41 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	chengyou@linux.alibaba.com,
	kaishen@linux.alibaba.com
Subject: [PATCH for-next 3/3] RDMA/erdma: Implement erdma_reg_user_mr_dmabuf
Date: Thu,  7 May 2026 13:34:21 +0800
Message-ID: <20260507053437.46211-4-boshiyu@linux.alibaba.com>
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
X-Rspamd-Queue-Id: 613E64E3204
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20118-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
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
index 59a2b8464a6f..d75ce1e4a3ab 100644
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
@@ -1235,9 +1248,10 @@ int erdma_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
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
@@ -1255,6 +1269,10 @@ struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
+	if (dmabuf)
+		attr.flags |= ERDMA_MEM_FLAG_DMABUF;
+
+	attr.fd = fd;
 	attr.len = len;
 	attr.virt = virt;
 	attr.start = start;
@@ -1270,8 +1288,6 @@ struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 
 	mr->ibmr.lkey = mr->ibmr.rkey = stag;
 	mr->ibmr.pd = ibpd;
-	mr->mem.va = virt;
-	mr->mem.len = len;
 	mr->access = ERDMA_MR_ACC_LR | to_erdma_access_flags(access);
 	mr->valid = 1;
 	mr->type = ERDMA_MR_TYPE_NORMAL;
@@ -1295,6 +1311,23 @@ struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
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


