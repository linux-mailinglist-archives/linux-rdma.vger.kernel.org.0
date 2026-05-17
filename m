Return-Path: <linux-rdma+bounces-20812-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAVVCntgCWrhXQQAu9opvQ
	(envelope-from <linux-rdma+bounces-20812-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:30:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BC03255F7AD
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C2863006815
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 06:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0249B2874E6;
	Sun, 17 May 2026 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="sYOR3w5i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6D112FF69
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 06:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999414; cv=none; b=LmL9uVO5ukjtj1qVtq2QkPHOtIg5PEJIAN8Xoc1gHvaE4s6v+8CwAMhjxMPd8Fy3DUu6Ep7rykteKEvb3L3+lt22KetPnR7pf6h9URMme5Hn+0iBloPHm8R8C33WrpQi/AHCiOWij4YbvyGcDbY34cmeIiDXu7bD07s0VlttuJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999414; c=relaxed/simple;
	bh=OZCRYoUPjfgI+MOmPd6NT/Uw47sTPR2+tPaJteRmZao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gw9udpDF1v7rJ7h+gWfIrq72UhUZE/x+N4F7Nu0TFTSU295m2A4We6X6OFLy5Z5xUqX966CXP4jt1C7loV+i4f3DS+9kE6f6Yo58lvXaiMh+sruB7xQPncXsUQU8DzFCAeIa3xAZHVjP6TziwV1DrSkBvelbzv5mSwEr1Hj7zkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=sYOR3w5i; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43eb05b1875so472432f8f.3
        for <linux-rdma@vger.kernel.org>; Sat, 16 May 2026 23:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778999410; x=1779604210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C98ta8nA1K0g/I5ohLaYXIW3N/51wWIR23wPTKJKJhQ=;
        b=sYOR3w5iiR9of179UQwe3fOnR8DOTNuS+3WGPnY6fX6WxMYhZQ/i6rcOxPseM2sqwt
         e+nKd6eCrQjyP3chqaDNrMY6x54jfI4htH42hA5OjBkMqBVOhsaiO8Lw0RpTduVY3Frf
         kYYdxZBTRrODj7p1sL0BFHVMvH47LyMfnDSRg2nMQka7T/+QCqensMelCJiZelHi8hLR
         Y8qKUwsEwX6geCYA3mkb64gHO0LpsA7N4AD1+j5/HsYq0V1noVryASNx+ifQIJ74ydHk
         BLvthtvv0SuxI1E0a3AKRXQ+AxOjYqxfsS/gkYvSeIMPVpm1LF4fSon4Oj/UvQz6RXQs
         dZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999410; x=1779604210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C98ta8nA1K0g/I5ohLaYXIW3N/51wWIR23wPTKJKJhQ=;
        b=sMp9CSLHB61qE46v3dzK3DYFldOXqjMf74XzwMjGpw7Ya6CpTGN6sRcDwCVxNDphDV
         c+p5U1XYQGilcd1/Mkk9vyuxSP+PLzdi13SV4blPGdTbpVRZ8jB7Ccjz36UNyBE32lah
         DDp6WpgzrnS56uA+vezsvWOfDdCCvFun1i0GY7KDaMa3YU6bptLAdTKXMmiRwuekUtcp
         ZaJC/RRpKcy452mdjplrNc/grOJ5h6bA23PQhx+5vGiC7OD7eTWhc6jTN9+sCGsGlDMB
         QjRpf6UAheNC2pag2Km2z8w2CvFM/Al2FARjGkBjxym+ydqoeqCAbMx4K/m61uBQaw2m
         +TtA==
X-Gm-Message-State: AOJu0YwU/DU1Thy89Tt4wqUYvuNWerQTsjgqVYbisl62OtlHZ4yulJNB
	5vxlpYZvisYpTin9e0G8qxwn/Ef8XwvJE1aZjCMGJOvFvO3rkQ8KElGRTMcPeQXZXsuF0lDB81s
	cIG0yTcYCyr2W
X-Gm-Gg: Acq92OFuD0DhGVpLq0ZHksbD2Id5WCO7Wnoxj+pnO18oNVZ+BbqKkjZWEmqslqrLXAE
	NG5N3NcVxXNZ1vLd2z5g2GrhfycG4d5e5hs/hIUl9MievMCgN3qsS21CVrNDwH+q966ZKbYjwrM
	yFX9KaCnubMKjp40FvIHtmAMenIreUS4HK5EmmRFkknrL0k6rgcb8yHa7/+WLz3BG1G2tH11cMI
	idsXDfAUs9sclotIqCYmI4nLLF3t3i2GMBGd53NlsYFo/chG8SGc/jmq3x68hkP5O8akdNN+LV+
	Vw34lBH+QZKS8nWfVUhcVQpM204l8Xl+WdgXglHr3Dac7Y8jpNeu4R9CdM4pnTQ/cL6egXqTS34
	mtE6l2GznXKoyJdaJsJmxN9LlJoEvXeR3vJhRXkjG1ar/wI3spQ4Z1ZwyQYoTNyewnRbpn153gn
	I5NY76M9rrFalVebesRiN9kO/KkKSgHTVNN0LAFRfkx1NiSA==
X-Received: by 2002:a05:6000:61e:b0:456:b23d:e57 with SMTP id ffacd0b85a97d-45e5c3480bamr14411595f8f.0.1778999409560;
        Sat, 16 May 2026 23:30:09 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9adc2209sm25489552f8f.0.2026.05.16.23.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:30:09 -0700 (PDT)
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
Subject: [PATCH rdma-next v5 01/15] RDMA/umem: Rename ib_umem_get() to ib_umem_get_va()
Date: Sun, 17 May 2026 08:29:52 +0200
Message-ID: <20260517063006.2200680-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517063006.2200680-1-jiri@resnulli.us>
References: <20260517063006.2200680-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BC03255F7AD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20812-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

The new umem getter family being introduced in follow-up patches
need a fitting name for the central all-source helper that resolves
attributes, legacy fillers and a UHW VA fallback.

Rename the existing VA-pinning helper ib_umem_get() to ib_umem_get_va()
so the name is freed up. The new name is consistent with names of rest
of the helpers that are about to be introduced.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v4->v5:
- rebased on top of siw changed
v2->v3:
- new patch
---
 drivers/infiniband/core/umem.c                | 10 +++----
 drivers/infiniband/core/uverbs_std_types_cq.c |  2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      | 28 +++++++++----------
 drivers/infiniband/hw/cxgb4/mem.c             |  2 +-
 drivers/infiniband/hw/efa/efa_verbs.c         |  2 +-
 drivers/infiniband/hw/erdma/erdma_verbs.c     |  6 ++--
 drivers/infiniband/hw/hns/hns_roce_db.c       |  4 +--
 drivers/infiniband/hw/hns/hns_roce_mr.c       |  4 +--
 .../infiniband/hw/ionic/ionic_controlpath.c   | 10 +++----
 drivers/infiniband/hw/irdma/verbs.c           |  4 +--
 drivers/infiniband/hw/mana/main.c             |  2 +-
 drivers/infiniband/hw/mana/mr.c               |  2 +-
 drivers/infiniband/hw/mlx4/cq.c               | 12 ++++----
 drivers/infiniband/hw/mlx4/doorbell.c         |  4 +--
 drivers/infiniband/hw/mlx4/mr.c               |  4 +--
 drivers/infiniband/hw/mlx4/qp.c               |  4 +--
 drivers/infiniband/hw/mlx4/srq.c              |  2 +-
 drivers/infiniband/hw/mlx5/cq.c               | 12 ++++----
 drivers/infiniband/hw/mlx5/devx.c             |  2 +-
 drivers/infiniband/hw/mlx5/doorbell.c         |  4 +--
 drivers/infiniband/hw/mlx5/mr.c               |  6 ++--
 drivers/infiniband/hw/mlx5/qp.c               | 10 +++----
 drivers/infiniband/hw/mlx5/srq.c              |  2 +-
 drivers/infiniband/hw/mthca/mthca_provider.c  |  2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  2 +-
 drivers/infiniband/hw/qedr/verbs.c            | 13 +++++----
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c  |  4 +--
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c  |  2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c  | 10 +++----
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c |  2 +-
 drivers/infiniband/sw/rdmavt/mr.c             |  2 +-
 drivers/infiniband/sw/rxe/rxe_mr.c            |  2 +-
 drivers/infiniband/sw/siw/siw_mem.c           |  4 +--
 include/rdma/ib_umem.h                        | 10 +++----
 34 files changed, 96 insertions(+), 95 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 786fa1aa8e55..b253090bb1ab 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -154,15 +154,15 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 EXPORT_SYMBOL(ib_umem_find_best_pgsz);
 
 /**
- * ib_umem_get - Pin and DMA map userspace memory.
+ * ib_umem_get_va - Pin and DMA map userspace memory.
  *
  * @device: IB device to connect UMEM
  * @addr: userspace virtual address to start at
  * @size: length of region to pin
  * @access: IB_ACCESS_xxx flags for memory being pinned
  */
-struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
-			    size_t size, int access)
+struct ib_umem *ib_umem_get_va(struct ib_device *device, unsigned long addr,
+			       size_t size, int access)
 {
 	struct ib_umem *umem;
 	struct page **page_list;
@@ -275,10 +275,10 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 	}
 	return ret ? ERR_PTR(ret) : umem;
 }
-EXPORT_SYMBOL(ib_umem_get);
+EXPORT_SYMBOL(ib_umem_get_va);
 
 /**
- * ib_umem_release - release memory pinned with ib_umem_get
+ * ib_umem_release - release pinned memory
  * @umem: umem struct to release
  */
 void ib_umem_release(struct ib_umem *umem)
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index 79b51f60ce2a..1a6bc8baa52b 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -139,7 +139,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 			goto err_event_file;
 		}
 
-		umem = ib_umem_get(ib_dev, buffer_va, buffer_length, IB_ACCESS_LOCAL_WRITE);
+		umem = ib_umem_get_va(ib_dev, buffer_va, buffer_length, IB_ACCESS_LOCAL_WRITE);
 		if (IS_ERR(umem)) {
 			ret = PTR_ERR(umem);
 			goto err_event_file;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 7ed294516b7e..1f626b7c6af2 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1166,8 +1166,8 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	}
 
 	bytes = PAGE_ALIGN(bytes);
-	umem = ib_umem_get(&rdev->ibdev, ureq->qpsva, bytes,
-			   IB_ACCESS_LOCAL_WRITE);
+	umem = ib_umem_get_va(&rdev->ibdev, ureq->qpsva, bytes,
+			      IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(umem))
 		return PTR_ERR(umem);
 
@@ -1180,8 +1180,8 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	if (!qp->qplib_qp.srq) {
 		bytes = (qplib_qp->rq.max_wqe * qplib_qp->rq.wqe_size);
 		bytes = PAGE_ALIGN(bytes);
-		umem = ib_umem_get(&rdev->ibdev, ureq->qprva, bytes,
-				   IB_ACCESS_LOCAL_WRITE);
+		umem = ib_umem_get_va(&rdev->ibdev, ureq->qprva, bytes,
+				      IB_ACCESS_LOCAL_WRITE);
 		if (IS_ERR(umem))
 			goto rqfail;
 		qp->rumem = umem;
@@ -2058,8 +2058,8 @@ static int bnxt_re_init_user_srq(struct bnxt_re_dev *rdev,
 
 	bytes = (qplib_srq->max_wqe * qplib_srq->wqe_size);
 	bytes = PAGE_ALIGN(bytes);
-	umem = ib_umem_get(&rdev->ibdev, ureq.srqva, bytes,
-			   IB_ACCESS_LOCAL_WRITE);
+	umem = ib_umem_get_va(&rdev->ibdev, ureq.srqva, bytes,
+			      IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(umem))
 		return PTR_ERR(umem);
 
@@ -3403,9 +3403,9 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 					     dev_attr->max_cq_wqes + 1, uctx);
 
 	if (!ibcq->umem) {
-		ibcq->umem = ib_umem_get(&rdev->ibdev, req.cq_va,
-					 entries * sizeof(struct cq_base),
-					 IB_ACCESS_LOCAL_WRITE);
+		ibcq->umem = ib_umem_get_va(&rdev->ibdev, req.cq_va,
+					    entries * sizeof(struct cq_base),
+					    IB_ACCESS_LOCAL_WRITE);
 		if (IS_ERR(ibcq->umem))
 			return PTR_ERR(ibcq->umem);
 	}
@@ -3562,12 +3562,12 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, unsigned int cqe,
 	if (rc)
 		goto fail;
 
-	cq->resize_umem = ib_umem_get(&rdev->ibdev, req.cq_va,
-				      entries * sizeof(struct cq_base),
-				      IB_ACCESS_LOCAL_WRITE);
+	cq->resize_umem = ib_umem_get_va(&rdev->ibdev, req.cq_va,
+					 entries * sizeof(struct cq_base),
+					 IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(cq->resize_umem)) {
 		rc = PTR_ERR(cq->resize_umem);
-		ibdev_err(&rdev->ibdev, "%s: ib_umem_get failed! rc = %pe\n",
+		ibdev_err(&rdev->ibdev, "%s: ib_umem_get_va failed! rc = %pe\n",
 			  __func__, cq->resize_umem);
 		cq->resize_umem = NULL;
 		goto fail;
@@ -4577,7 +4577,7 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 	if (dmah)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	umem = ib_umem_get(&rdev->ibdev, start, length, mr_access_flags);
+	umem = ib_umem_get_va(&rdev->ibdev, start, length, mr_access_flags);
 	if (IS_ERR(umem))
 		return ERR_CAST(umem);
 
diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
index 9fde78b74690..cd1b01014198 100644
--- a/drivers/infiniband/hw/cxgb4/mem.c
+++ b/drivers/infiniband/hw/cxgb4/mem.c
@@ -530,7 +530,7 @@ struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 
 	mhp->rhp = rhp;
 
-	mhp->umem = ib_umem_get(pd->device, start, length, acc);
+	mhp->umem = ib_umem_get_va(pd->device, start, length, acc);
 	if (IS_ERR(mhp->umem))
 		goto err_free_skb;
 
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 7bd0838ebc99..e103d1654a69 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1774,7 +1774,7 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 		goto err_out;
 	}
 
-	mr->umem = ib_umem_get(ibpd->device, start, length, access_flags);
+	mr->umem = ib_umem_get_va(ibpd->device, start, length, access_flags);
 	if (IS_ERR(mr->umem)) {
 		err = PTR_ERR(mr->umem);
 		ibdev_dbg(&dev->ibdev,
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 5523b4e151e1..b229064ea48c 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -829,7 +829,7 @@ static int get_mtt_entries(struct erdma_dev *dev, struct erdma_mem *mem,
 {
 	int ret = 0;
 
-	mem->umem = ib_umem_get(&dev->ibdev, start, len, access);
+	mem->umem = ib_umem_get_va(&dev->ibdev, start, len, access);
 	if (IS_ERR(mem->umem)) {
 		ret = PTR_ERR(mem->umem);
 		mem->umem = NULL;
@@ -896,8 +896,8 @@ static int erdma_map_user_dbrecords(struct erdma_ucontext *ctx,
 	page->va = (dbrecords_va & PAGE_MASK);
 	page->refcnt = 0;
 
-	page->umem = ib_umem_get(ctx->ibucontext.device,
-				 dbrecords_va & PAGE_MASK, PAGE_SIZE, 0);
+	page->umem = ib_umem_get_va(ctx->ibucontext.device,
+				    dbrecords_va & PAGE_MASK, PAGE_SIZE, 0);
 	if (IS_ERR(page->umem)) {
 		rv = PTR_ERR(page->umem);
 		kfree(page);
diff --git a/drivers/infiniband/hw/hns/hns_roce_db.c b/drivers/infiniband/hw/hns/hns_roce_db.c
index f64023f5cf0a..5e008a1700ef 100644
--- a/drivers/infiniband/hw/hns/hns_roce_db.c
+++ b/drivers/infiniband/hw/hns/hns_roce_db.c
@@ -29,8 +29,8 @@ int hns_roce_db_map_user(struct hns_roce_ucontext *context, unsigned long virt,
 
 	refcount_set(&page->refcount, 1);
 	page->user_virt = page_addr;
-	page->umem = ib_umem_get(context->ibucontext.device, page_addr,
-				 PAGE_SIZE, 0);
+	page->umem = ib_umem_get_va(context->ibucontext.device, page_addr,
+				    PAGE_SIZE, 0);
 	if (IS_ERR(page->umem)) {
 		ret = PTR_ERR(page->umem);
 		kfree(page);
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 896af1828a38..5c70cb20eabd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -591,8 +591,8 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 
 	if (udata) {
 		mtr->kmem = NULL;
-		mtr->umem = ib_umem_get(ibdev, user_addr, total_size,
-					buf_attr->user_access);
+		mtr->umem = ib_umem_get_va(ibdev, user_addr, total_size,
+					   buf_attr->user_access);
 		if (IS_ERR(mtr->umem)) {
 			ibdev_err(ibdev, "failed to get umem, ret = %pe.\n",
 				  mtr->umem);
diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index 7051a81cca94..d4ac6b116a80 100644
--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -110,8 +110,8 @@ int ionic_create_cq_common(struct ionic_vcq *vcq,
 		if (rc)
 			goto err_qdesc;
 
-		cq->umem = ib_umem_get(&dev->ibdev, req_cq->addr, req_cq->size,
-				       IB_ACCESS_LOCAL_WRITE);
+		cq->umem = ib_umem_get_va(&dev->ibdev, req_cq->addr,
+					  req_cq->size, IB_ACCESS_LOCAL_WRITE);
 		if (IS_ERR(cq->umem)) {
 			rc = PTR_ERR(cq->umem);
 			goto err_qdesc;
@@ -895,7 +895,7 @@ struct ib_mr *ionic_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 
 	mr->flags = IONIC_MRF_USER_MR | to_ionic_mr_flags(access);
 
-	mr->umem = ib_umem_get(&dev->ibdev, start, length, access);
+	mr->umem = ib_umem_get_va(&dev->ibdev, start, length, access);
 	if (IS_ERR(mr->umem)) {
 		rc = PTR_ERR(mr->umem);
 		goto err_umem;
@@ -1837,7 +1837,7 @@ static int ionic_qp_sq_init(struct ionic_ibdev *dev, struct ionic_ctx *ctx,
 		qp->sq_meta = NULL;
 		qp->sq_msn_idx = NULL;
 
-		qp->sq_umem = ib_umem_get(&dev->ibdev, sq->addr, sq->size, 0);
+		qp->sq_umem = ib_umem_get_va(&dev->ibdev, sq->addr, sq->size, 0);
 		if (IS_ERR(qp->sq_umem))
 			return PTR_ERR(qp->sq_umem);
 	} else {
@@ -2050,7 +2050,7 @@ static int ionic_qp_rq_init(struct ionic_ibdev *dev, struct ionic_ctx *ctx,
 
 		qp->rq_meta = NULL;
 
-		qp->rq_umem = ib_umem_get(&dev->ibdev, rq->addr, rq->size, 0);
+		qp->rq_umem = ib_umem_get_va(&dev->ibdev, rq->addr, rq->size, 0);
 		if (IS_ERR(qp->rq_umem))
 			return PTR_ERR(qp->rq_umem);
 	} else {
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 17086048d2d7..11ea4f649681 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3537,7 +3537,7 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	if (udata->inlen < IRDMA_MEM_REG_MIN_REQ_LEN)
 		return ERR_PTR(-EINVAL);
 
-	region = ib_umem_get(pd->device, start, len, access);
+	region = ib_umem_get_va(pd->device, start, len, access);
 
 	if (IS_ERR(region)) {
 		ibdev_dbg(&iwdev->ibdev,
@@ -3739,7 +3739,7 @@ static int irdma_rereg_mr_trans(struct irdma_mr *iwmr, u64 start, u64 len,
 	struct ib_umem *region;
 	int err;
 
-	region = ib_umem_get(pd->device, start, len, iwmr->access);
+	region = ib_umem_get_va(pd->device, start, len, iwmr->access);
 	if (IS_ERR(region))
 		return PTR_ERR(region);
 
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index ac5e75dd3494..6c3c436ad731 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -238,7 +238,7 @@ int mana_ib_create_queue(struct mana_ib_dev *mdev, u64 addr, u32 size,
 	queue->id = INVALID_QUEUE_ID;
 	queue->gdma_region = GDMA_INVALID_DMA_REGION;
 
-	umem = ib_umem_get(&mdev->ib_dev, addr, size, IB_ACCESS_LOCAL_WRITE);
+	umem = ib_umem_get_va(&mdev->ib_dev, addr, size, IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(umem)) {
 		ibdev_dbg(&mdev->ib_dev, "Failed to get umem, %pe\n", umem);
 		return PTR_ERR(umem);
diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index 8092a7bb785b..030bfdcfff3c 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -127,7 +127,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
-	mr->umem = ib_umem_get(ibdev, start, length, access_flags);
+	mr->umem = ib_umem_get_va(ibdev, start, length, access_flags);
 	if (IS_ERR(mr->umem)) {
 		err = PTR_ERR(mr->umem);
 		ibdev_dbg(ibdev,
diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/cq.c
index 7a6eb602d4a6..381c7dfa4667 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -179,9 +179,9 @@ int mlx4_ib_create_user_cq(struct ib_cq *ibcq,
 	buf_addr = (void *)(unsigned long)ucmd.buf_addr;
 
 	if (!ibcq->umem)
-		ibcq->umem = ib_umem_get(&dev->ib_dev, ucmd.buf_addr,
-					 entries * cqe_size,
-					 IB_ACCESS_LOCAL_WRITE);
+		ibcq->umem = ib_umem_get_va(&dev->ib_dev, ucmd.buf_addr,
+					    entries * cqe_size,
+					    IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(ibcq->umem)) {
 		err = PTR_ERR(ibcq->umem);
 		goto err_cq;
@@ -343,9 +343,9 @@ static int mlx4_alloc_resize_umem(struct mlx4_ib_dev *dev, struct mlx4_ib_cq *cq
 	if (!cq->resize_buf)
 		return -ENOMEM;
 
-	cq->resize_umem = ib_umem_get(&dev->ib_dev, ucmd.buf_addr,
-				      entries * cqe_size,
-				      IB_ACCESS_LOCAL_WRITE);
+	cq->resize_umem = ib_umem_get_va(&dev->ib_dev, ucmd.buf_addr,
+					 entries * cqe_size,
+					 IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(cq->resize_umem)) {
 		err = PTR_ERR(cq->resize_umem);
 		goto err_buf;
diff --git a/drivers/infiniband/hw/mlx4/doorbell.c b/drivers/infiniband/hw/mlx4/doorbell.c
index 8ba86b1e4e46..22ae728834fc 100644
--- a/drivers/infiniband/hw/mlx4/doorbell.c
+++ b/drivers/infiniband/hw/mlx4/doorbell.c
@@ -64,8 +64,8 @@ int mlx4_ib_db_map_user(struct ib_udata *udata, unsigned long virt,
 
 	page->user_virt = (virt & PAGE_MASK);
 	page->refcnt    = 0;
-	page->umem = ib_umem_get(context->ibucontext.device, virt & PAGE_MASK,
-				 PAGE_SIZE, 0);
+	page->umem = ib_umem_get_va(context->ibucontext.device,
+				    virt & PAGE_MASK, PAGE_SIZE, 0);
 	if (IS_ERR(page->umem)) {
 		err = PTR_ERR(page->umem);
 		kfree(page);
diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index 650b4a9121ff..027ffb6f79d3 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -110,7 +110,7 @@ static struct ib_umem *mlx4_get_umem_mr(struct ib_device *device, u64 start,
 	/*
 	 * Force registering the memory as writable if the underlying pages
 	 * are writable.  This is so rereg can change the access permissions
-	 * from readable to writable without having to run through ib_umem_get
+	 * from readable to writable without having to run through ib_umem_get_va
 	 * again
 	 */
 	if (!ib_access_writable(access_flags)) {
@@ -135,7 +135,7 @@ static struct ib_umem *mlx4_get_umem_mr(struct ib_device *device, u64 start,
 		mmap_read_unlock(current->mm);
 	}
 
-	return ib_umem_get(device, start, length, access_flags);
+	return ib_umem_get_va(device, start, length, access_flags);
 }
 
 struct ib_mr *mlx4_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 790be09d985a..491bcaed9eca 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -897,7 +897,7 @@ static int create_rq(struct ib_pd *pd, struct ib_qp_init_attr *init_attr,
 	qp->buf_size = (qp->rq.wqe_cnt << qp->rq.wqe_shift) +
 		       (qp->sq.wqe_cnt << qp->sq.wqe_shift);
 
-	qp->umem = ib_umem_get(pd->device, wq.buf_addr, qp->buf_size, 0);
+	qp->umem = ib_umem_get_va(pd->device, wq.buf_addr, qp->buf_size, 0);
 	if (IS_ERR(qp->umem)) {
 		err = PTR_ERR(qp->umem);
 		goto err;
@@ -1080,7 +1080,7 @@ static int create_qp_common(struct ib_pd *pd, struct ib_qp_init_attr *init_attr,
 			goto err;
 
 		qp->umem =
-			ib_umem_get(pd->device, ucmd.buf_addr, qp->buf_size, 0);
+			ib_umem_get_va(pd->device, ucmd.buf_addr, qp->buf_size, 0);
 		if (IS_ERR(qp->umem)) {
 			err = PTR_ERR(qp->umem);
 			goto err;
diff --git a/drivers/infiniband/hw/mlx4/srq.c b/drivers/infiniband/hw/mlx4/srq.c
index 5b23e5f8b84a..4c13355e14ce 100644
--- a/drivers/infiniband/hw/mlx4/srq.c
+++ b/drivers/infiniband/hw/mlx4/srq.c
@@ -116,7 +116,7 @@ int mlx4_ib_create_srq(struct ib_srq *ib_srq,
 			return err;
 
 		srq->umem =
-			ib_umem_get(ib_srq->device, ucmd.buf_addr, buf_size, 0);
+			ib_umem_get_va(ib_srq->device, ucmd.buf_addr, buf_size, 0);
 		if (IS_ERR(srq->umem))
 			return PTR_ERR(srq->umem);
 
diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index ae20d11f04fc..39d51f294bcd 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -747,9 +747,9 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	*cqe_size = ucmd.cqe_size;
 
 	if (!cq->ibcq.umem)
-		cq->ibcq.umem = ib_umem_get(&dev->ib_dev, ucmd.buf_addr,
-					    entries * ucmd.cqe_size,
-					    IB_ACCESS_LOCAL_WRITE);
+		cq->ibcq.umem = ib_umem_get_va(&dev->ib_dev, ucmd.buf_addr,
+					       entries * ucmd.cqe_size,
+					       IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(cq->ibcq.umem))
 		return PTR_ERR(cq->ibcq.umem);
 
@@ -1241,9 +1241,9 @@ static int resize_user(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *cq,
 	if (ucmd.cqe_size && SIZE_MAX / ucmd.cqe_size <= entries - 1)
 		return -EINVAL;
 
-	umem = ib_umem_get(&dev->ib_dev, ucmd.buf_addr,
-			   (size_t)ucmd.cqe_size * entries,
-			   IB_ACCESS_LOCAL_WRITE);
+	umem = ib_umem_get_va(&dev->ib_dev, ucmd.buf_addr,
+			      (size_t)ucmd.cqe_size * entries,
+			      IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(umem)) {
 		err = PTR_ERR(umem);
 		return err;
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index c5929d023ee3..fc6f793dcc65 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2287,7 +2287,7 @@ static int devx_umem_get(struct mlx5_ib_dev *dev, struct ib_ucontext *ucontext,
 			return PTR_ERR(umem_dmabuf);
 		obj->umem = &umem_dmabuf->umem;
 	} else {
-		obj->umem = ib_umem_get(&dev->ib_dev, addr, size, access_flags);
+		obj->umem = ib_umem_get_va(&dev->ib_dev, addr, size, access_flags);
 		if (IS_ERR(obj->umem))
 			return PTR_ERR(obj->umem);
 	}
diff --git a/drivers/infiniband/hw/mlx5/doorbell.c b/drivers/infiniband/hw/mlx5/doorbell.c
index bd68fcf011f4..020c70328663 100644
--- a/drivers/infiniband/hw/mlx5/doorbell.c
+++ b/drivers/infiniband/hw/mlx5/doorbell.c
@@ -66,8 +66,8 @@ int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context, unsigned long virt,
 
 	page->user_virt = (virt & PAGE_MASK);
 	page->refcnt    = 0;
-	page->umem = ib_umem_get(context->ibucontext.device, virt & PAGE_MASK,
-				 PAGE_SIZE, 0);
+	page->umem = ib_umem_get_va(context->ibucontext.device,
+				    virt & PAGE_MASK, PAGE_SIZE, 0);
 	if (IS_ERR(page->umem)) {
 		err = PTR_ERR(page->umem);
 		kfree(page);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 3b6da45061a5..fe26b3d24a75 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -874,7 +874,7 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (access_flags & IB_ACCESS_ON_DEMAND)
 		return create_user_odp_mr(pd, start, length, iova, access_flags,
 					  udata);
-	umem = ib_umem_get(&dev->ib_dev, start, length, access_flags);
+	umem = ib_umem_get_va(&dev->ib_dev, start, length, access_flags);
 	if (IS_ERR(umem))
 		return ERR_CAST(umem);
 	return create_real_mr(pd, umem, iova, access_flags, dmah);
@@ -1227,8 +1227,8 @@ struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 		struct ib_umem *new_umem;
 		unsigned long page_size;
 
-		new_umem = ib_umem_get(&dev->ib_dev, start, length,
-				       new_access_flags);
+		new_umem = ib_umem_get_va(&dev->ib_dev, start, length,
+					  new_access_flags);
 		if (IS_ERR(new_umem))
 			return ERR_CAST(new_umem);
 
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 3048d2d273d7..a982cea45f3b 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -886,7 +886,7 @@ static int create_user_rq(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	if (!ucmd->buf_addr)
 		return -EINVAL;
 
-	rwq->umem = ib_umem_get(&dev->ib_dev, ucmd->buf_addr, rwq->buf_size, 0);
+	rwq->umem = ib_umem_get_va(&dev->ib_dev, ucmd->buf_addr, rwq->buf_size, 0);
 	if (IS_ERR(rwq->umem)) {
 		mlx5_ib_dbg(dev, "umem_get failed\n");
 		err = PTR_ERR(rwq->umem);
@@ -996,8 +996,8 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 
 	if (ucmd->buf_addr && ubuffer->buf_size) {
 		ubuffer->buf_addr = ucmd->buf_addr;
-		ubuffer->umem = ib_umem_get(&dev->ib_dev, ubuffer->buf_addr,
-					    ubuffer->buf_size, 0);
+		ubuffer->umem = ib_umem_get_va(&dev->ib_dev, ubuffer->buf_addr,
+					       ubuffer->buf_size, 0);
 		if (IS_ERR(ubuffer->umem)) {
 			err = PTR_ERR(ubuffer->umem);
 			goto err_bfreg;
@@ -1348,8 +1348,8 @@ static int create_raw_packet_qp_sq(struct mlx5_ib_dev *dev,
 	if (ts_format < 0)
 		return ts_format;
 
-	sq->ubuffer.umem = ib_umem_get(&dev->ib_dev, ubuffer->buf_addr,
-				       ubuffer->buf_size, 0);
+	sq->ubuffer.umem = ib_umem_get_va(&dev->ib_dev, ubuffer->buf_addr,
+					  ubuffer->buf_size, 0);
 	if (IS_ERR(sq->ubuffer.umem))
 		return PTR_ERR(sq->ubuffer.umem);
 	page_size = mlx5_umem_find_best_quantized_pgoff(
diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index 852f6f502d14..bc22036d7e80 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -66,7 +66,7 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 
 	srq->wq_sig = !!(ucmd.flags & MLX5_SRQ_FLAG_SIGNATURE);
 
-	srq->umem = ib_umem_get(pd->device, ucmd.buf_addr, buf_size, 0);
+	srq->umem = ib_umem_get_va(pd->device, ucmd.buf_addr, buf_size, 0);
 	if (IS_ERR(srq->umem)) {
 		mlx5_ib_dbg(dev, "failed umem get, size %d\n", buf_size);
 		err = PTR_ERR(srq->umem);
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index e8d5d865c1f1..b099857dca16 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -864,7 +864,7 @@ static struct ib_mr *mthca_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
-	mr->umem = ib_umem_get(pd->device, start, length, acc);
+	mr->umem = ib_umem_get_va(pd->device, start, length, acc);
 	if (IS_ERR(mr->umem)) {
 		err = PTR_ERR(mr->umem);
 		goto err;
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index c17e2a54dbca..7ac0480edcec 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -865,7 +865,7 @@ struct ib_mr *ocrdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 	mr = kzalloc_obj(*mr);
 	if (!mr)
 		return ERR_PTR(status);
-	mr->umem = ib_umem_get(ibpd->device, start, len, acc);
+	mr->umem = ib_umem_get_va(ibpd->device, start, len, acc);
 	if (IS_ERR(mr->umem)) {
 		status = -EFAULT;
 		goto umem_err;
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 679aa6f3a63b..56d2c3d41ef4 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -796,9 +796,9 @@ static inline int qedr_init_user_queue(struct ib_udata *udata,
 
 	q->buf_addr = buf_addr;
 	q->buf_len = buf_len;
-	q->umem = ib_umem_get(&dev->ibdev, q->buf_addr, q->buf_len, access);
+	q->umem = ib_umem_get_va(&dev->ibdev, q->buf_addr, q->buf_len, access);
 	if (IS_ERR(q->umem)) {
-		DP_ERR(dev, "create user queue: failed ib_umem_get, got %ld\n",
+		DP_ERR(dev, "create user queue: failed ib_umem_get_va, got %ld\n",
 		       PTR_ERR(q->umem));
 		return PTR_ERR(q->umem);
 	}
@@ -1471,13 +1471,14 @@ static int qedr_init_srq_user_params(struct ib_udata *udata,
 	if (rc)
 		return rc;
 
-	srq->prod_umem = ib_umem_get(srq->ibsrq.device, ureq->prod_pair_addr,
-				     sizeof(struct rdma_srq_producers), access);
+	srq->prod_umem = ib_umem_get_va(srq->ibsrq.device, ureq->prod_pair_addr,
+					sizeof(struct rdma_srq_producers),
+					access);
 	if (IS_ERR(srq->prod_umem)) {
 		qedr_free_pbl(srq->dev, &srq->usrq.pbl_info, srq->usrq.pbl_tbl);
 		ib_umem_release(srq->usrq.umem);
 		DP_ERR(srq->dev,
-		       "create srq: failed ib_umem_get for producer, got %ld\n",
+		       "create srq: failed ib_umem_get_va for producer, got %ld\n",
 		       PTR_ERR(srq->prod_umem));
 		return PTR_ERR(srq->prod_umem);
 	}
@@ -2964,7 +2965,7 @@ struct ib_mr *qedr_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 
 	mr->type = QEDR_MR_USER;
 
-	mr->umem = ib_umem_get(ibpd->device, start, len, acc);
+	mr->umem = ib_umem_get_va(ibpd->device, start, len, acc);
 	if (IS_ERR(mr->umem)) {
 		rc = -EFAULT;
 		goto err0;
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
index bc3adcc1ae67..5712d40d7211 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
@@ -138,8 +138,8 @@ int pvrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		if (ret)
 			goto err_cq;
 
-		cq->umem = ib_umem_get(ibdev, ucmd.buf_addr, ucmd.buf_size,
-				       IB_ACCESS_LOCAL_WRITE);
+		cq->umem = ib_umem_get_va(ibdev, ucmd.buf_addr, ucmd.buf_size,
+					  IB_ACCESS_LOCAL_WRITE);
 		if (IS_ERR(cq->umem)) {
 			ret = PTR_ERR(cq->umem);
 			goto err_cq;
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
index 05a6bd991502..942381ab0367 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
@@ -131,7 +131,7 @@ struct ib_mr *pvrdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 		return ERR_PTR(-EINVAL);
 	}
 
-	umem = ib_umem_get(pd->device, start, length, access_flags);
+	umem = ib_umem_get_va(pd->device, start, length, access_flags);
 	if (IS_ERR(umem)) {
 		dev_warn(&dev->pdev->dev,
 			 "could not get umem for mem region\n");
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
index 16aab967a203..5689bf51a7ef 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
@@ -268,9 +268,9 @@ int pvrdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 
 			if (!is_srq) {
 				/* set qp->sq.wqe_cnt, shift, buf_size.. */
-				qp->rumem = ib_umem_get(ibqp->device,
-							ucmd.rbuf_addr,
-							ucmd.rbuf_size, 0);
+				qp->rumem = ib_umem_get_va(ibqp->device,
+							   ucmd.rbuf_addr,
+							   ucmd.rbuf_size, 0);
 				if (IS_ERR(qp->rumem)) {
 					ret = PTR_ERR(qp->rumem);
 					goto err_qp;
@@ -281,8 +281,8 @@ int pvrdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 				qp->srq = to_vsrq(init_attr->srq);
 			}
 
-			qp->sumem = ib_umem_get(ibqp->device, ucmd.sbuf_addr,
-						ucmd.sbuf_size, 0);
+			qp->sumem = ib_umem_get_va(ibqp->device, ucmd.sbuf_addr,
+						   ucmd.sbuf_size, 0);
 			if (IS_ERR(qp->sumem)) {
 				if (!is_srq)
 					ib_umem_release(qp->rumem);
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
index d31fb692fcaa..fa35a0d73ad0 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
@@ -146,7 +146,7 @@ int pvrdma_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init_attr,
 	if (ret)
 		goto err_srq;
 
-	srq->umem = ib_umem_get(ibsrq->device, ucmd.buf_addr, ucmd.buf_size, 0);
+	srq->umem = ib_umem_get_va(ibsrq->device, ucmd.buf_addr, ucmd.buf_size, 0);
 	if (IS_ERR(srq->umem)) {
 		ret = PTR_ERR(srq->umem);
 		goto err_srq;
diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdmavt/mr.c
index 15f1ff917d6c..3266129e63e7 100644
--- a/drivers/infiniband/sw/rdmavt/mr.c
+++ b/drivers/infiniband/sw/rdmavt/mr.c
@@ -351,7 +351,7 @@ struct ib_mr *rvt_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (length == 0)
 		return ERR_PTR(-EINVAL);
 
-	umem = ib_umem_get(pd->device, start, length, mr_access_flags);
+	umem = ib_umem_get_va(pd->device, start, length, mr_access_flags);
 	if (IS_ERR(umem))
 		return ERR_CAST(umem);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index c696ff874980..875eceb55fdf 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -197,7 +197,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 
 	rxe_mr_init(access, mr);
 
-	umem = ib_umem_get(&rxe->ib_dev, start, length, access);
+	umem = ib_umem_get_va(&rxe->ib_dev, start, length, access);
 	if (IS_ERR(umem)) {
 		rxe_dbg_mr(mr, "Unable to pin memory region err = %d\n",
 			(int)PTR_ERR(umem));
diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index 35f9f0513cfa..fb6a72ac21a6 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -350,7 +350,7 @@ struct siw_umem *siw_umem_get(struct ib_device *base_dev, u64 start,
 	if (!umem)
 		return ERR_PTR(-ENOMEM);
 
-	base_mem = ib_umem_get(base_dev, start, len, rights);
+	base_mem = ib_umem_get_va(base_dev, start, len, rights);
 	if (IS_ERR(base_mem)) {
 		rv = PTR_ERR(base_mem);
 		siw_dbg(base_dev, "Cannot pin user memory: %d\n", rv);
@@ -384,7 +384,7 @@ struct siw_umem *siw_umem_get(struct ib_device *base_dev, u64 start,
 
 	if (num_pages) {
 		/*
-		 * Unexpected size of sg list provided by ib_umem_get()
+		 * Unexpected size of sg list provided by ib_umem_get_va()
 		 */
 		siw_dbg(base_dev, "Short SG list, missing %u pages\n",
 			num_pages);
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 2ad52cc1d52b..25e90766892e 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -75,8 +75,8 @@ static inline size_t ib_umem_num_pages(struct ib_umem *umem)
 }
 #ifdef CONFIG_INFINIBAND_USER_MEM
 
-struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
-			    size_t size, int access);
+struct ib_umem *ib_umem_get_va(struct ib_device *device, unsigned long addr,
+			       size_t size, int access);
 void ib_umem_release(struct ib_umem *umem);
 int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 		      size_t length);
@@ -160,9 +160,9 @@ void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf);
 
 #include <linux/err.h>
 
-static inline struct ib_umem *ib_umem_get(struct ib_device *device,
-					  unsigned long addr, size_t size,
-					  int access)
+static inline struct ib_umem *ib_umem_get_va(struct ib_device *device,
+					     unsigned long addr, size_t size,
+					     int access)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
-- 
2.54.0


