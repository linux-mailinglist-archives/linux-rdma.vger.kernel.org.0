Return-Path: <linux-rdma+bounces-21034-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALT+JCaKDWpKywUAu9opvQ
	(envelope-from <linux-rdma+bounces-21034-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:17:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B6D58B917
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D0323063816
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 10:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2153D47D7;
	Wed, 20 May 2026 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="niFgDfRY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98623D47B2
	for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271899; cv=none; b=tr8yiTQnttsHV4IqJ0OtULc3ZKdI70cDRr8OiPEZuD01tRPqoxnUxbvpy1zPeJ/tCocABoPW/nT9qO6zs1DrORzi9Eybk91gS8oRc8uKT025DZMmXRgTIaTAfRoX/1CnTH+U+Xp1vsxMCQXYELJP2CsHVzAdi3rJ8LhcuR05xTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271899; c=relaxed/simple;
	bh=4QqudDHyL5duVJgTh+kTQVO6AU4uUb7qcIzP+VormwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrK9QzJhEzjs/JAfyPXaYKoYEUlLlC0+T8W8JCJRkv3T3HX1fSPvH2kGIiu1PkMDkEM1QQs3cjAGXURnDdd4i1C8SQfwgwWn9ZJx3z8vFkvaWq7Z7BBk4KlNM1IR80+C2D/j/e6yzax5btFcpka1ZGtqcbMSrFEqdMeIzOFGIk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=niFgDfRY; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43eb05b1875so2563969f8f.3
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 03:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779271894; x=1779876694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3BpN5n2FbUaUQTGfMXXxtzHYu0lQQ1V9DHybXYWiy0=;
        b=niFgDfRY1bvHLyJ330SPv6+2/3w8gsB+JN5HhSWt35/YNrdP6VL/dH3X/ClHtTxtq5
         5ntgPvJjvix7OFanaykbU10HPovzr1NxSkx37SE7nSQgavS/4G9f8etVkmMD1lGzpo8w
         97oHNEWjTc1TfI+Hzo/2F8z3jGvgMRQrWU7NSq8S5jEjOw27qIpA/j0+hb2MXe3MlGDR
         F/07s9GbZv8W1WBJS6u9DyNoQMlRBXcDPydzC5NZmQsmcWax9LR5xHKii7bsZ0pztmss
         4K982W9nGZVQ4LVi8Zh/DSnp+2S7/UhsglpMEDB3MdR3mnAndjtNE7dRpyr06IqBC40q
         1Clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779271894; x=1779876694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v3BpN5n2FbUaUQTGfMXXxtzHYu0lQQ1V9DHybXYWiy0=;
        b=ebucPFhxdqABKuYYmfUysFKQalpKi0aaRyc8EBmvqUbn1kXgiq/O3zDWstY4F0JVbm
         hXdDYKM2NyrFNjLM8WLE1HdbT/29tfqEzR8NDnV4Zl8slOPBqtYalQTpdX+P7ij4EfAJ
         Oi6JJzlUQENWSC0tvhkY6x9enGF+FRSA1TGCCcb5x0ykm6Q72D6yROycCAreKyD5ITAc
         8zjFtyWx4D206J6AHwwyAG1854kAa0WqdCIDLAznJqTWOD2EpaiDeMtNB/I2hnil312L
         hP8shmdNjqBIy3xAg8gZ+FA1DqJDP+15b2011WyHup3TYTS67TtOoFTtZcy+/maTQa3n
         ergA==
X-Gm-Message-State: AOJu0YyvRTfGGThIWNw299TIzMYJkYIt5HsJAjn50KvWJTM/zk+3tLAp
	EqMvf1dqzm1JhQ6DJEpLrRBtiXt4CDmsMsyfvrKPBacYZCDCvxByxFlxe66LORB/9TemqkgcFEJ
	7EmqkxcKgTg==
X-Gm-Gg: Acq92OHlNX0J2peznhCofhQkyxuam0SbUzzGcY0oQoAl4rWzWxjEskGdPz5BmZM7fBd
	6HIhDlOAoaOkr2snTNw+4AKgnN8qVc3OjmJ8OzBtIxk7vE+SxqwxMMdcIoe4i2oM9xua7+eP0r4
	6Jf2IFkl/LUhriLBDYW3q+rBAdncicJvNpRC183cx0sos2tj2zpKt0UrsiTSkUIcWF/VovBXjl9
	zFwgP8fWy+RE6tN6P0JYiX3vFlTGkcuLMccA+vSsCUMIWcc5YXEngCRWQp90x7NUSLGLapy92ne
	vVaIqL1v5gd474vbKyyDTUdfA59NUQPhKqk5dbtgQOwUCtlI1R2imsGyEbE0FLx2QH3iHihbJ47
	BWyaOXhsql6oWhKjZLySYDbUP/OwjpP3BYGCwvreQfnSoV8j5+5ZN1Xy9X9GF7EFPujuYn5mf2Y
	Y0HDJB3izD7TWYmjztqBM+SEFpVkIN1RqW
X-Received: by 2002:a5d:5f90:0:b0:43d:300b:2285 with SMTP id ffacd0b85a97d-45e5c5be273mr37321652f8f.11.1779271894018;
        Wed, 20 May 2026 03:11:34 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe248dsm52044487f8f.30.2026.05.20.03.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 03:11:33 -0700 (PDT)
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
Subject: [PATCH rdma-next v6 01/15] RDMA/umem: Rename ib_umem_get() to ib_umem_get_va()
Date: Wed, 20 May 2026 12:11:15 +0200
Message-ID: <20260520101129.899464-2-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21034-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,resnulli.us:mid,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: E6B6D58B917
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index ccb362d6d2e6..137240f2dcc6 100644
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
index 395290ab0584..8d97a837fa6a 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1745,7 +1745,7 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 		goto err_out;
 	}
 
-	mr->umem = ib_umem_get(ibpd->device, start, length, access_flags);
+	mr->umem = ib_umem_get_va(ibpd->device, start, length, access_flags);
 	if (IS_ERR(mr->umem)) {
 		err = PTR_ERR(mr->umem);
 		ibdev_dbg(&dev->ibdev,
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index b59c2e3a5306..9a9dc78c7ab6 100644
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
index 2b01345848dd..db18c315cc21 100644
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
index 79e72a457e79..f80732fef646 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3521,7 +3521,7 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	if (udata->inlen < IRDMA_MEM_REG_MIN_REQ_LEN)
 		return ERR_PTR(-EINVAL);
 
-	region = ib_umem_get(pd->device, start, len, access);
+	region = ib_umem_get_va(pd->device, start, len, access);
 
 	if (IS_ERR(region)) {
 		ibdev_dbg(&iwdev->ibdev,
@@ -3723,7 +3723,7 @@ static int irdma_rereg_mr_trans(struct irdma_mr *iwmr, u64 start, u64 len,
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
index 7e4505f6c78b..f9ec6917d9c9 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -180,9 +180,9 @@ int mlx4_ib_create_user_cq(struct ib_cq *ibcq,
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
@@ -344,9 +344,9 @@ static int mlx4_alloc_resize_umem(struct mlx4_ib_dev *dev, struct mlx4_ib_cq *cq
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
index 8dc4196218bf..effc6bcceb76 100644
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
index 0b4df4f48ca1..79c29a7c8724 100644
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
index 64fad78cb256..5a89676ebeb2 100644
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
 
@@ -1242,9 +1242,9 @@ static int resize_user(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *cq,
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
index d7d8f3ae8b64..254e6aa4ccaf 100644
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
index 6f88f9c52ad0..57cc3aadb8e3 100644
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
index 3fb8519a4ce0..44903015c6c9 100644
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
index afa97d3801f7..23e387dba79d 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -878,7 +878,7 @@ static struct ib_mr *mthca_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
-	mr->umem = ib_umem_get(pd->device, start, length, acc);
+	mr->umem = ib_umem_get_va(pd->device, start, length, acc);
 	if (IS_ERR(mr->umem)) {
 		err = PTR_ERR(mr->umem);
 		goto err;
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index d5fdbd7c8dea..5ac9db2edb8a 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -864,7 +864,7 @@ struct ib_mr *ocrdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 	mr = kzalloc_obj(*mr);
 	if (!mr)
 		return ERR_PTR(status);
-	mr->umem = ib_umem_get(ibpd->device, start, len, acc);
+	mr->umem = ib_umem_get_va(ibpd->device, start, len, acc);
 	if (IS_ERR(mr->umem)) {
 		status = -EFAULT;
 		goto umem_err;
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 1af908275ca7..7195eeede530 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -779,9 +779,9 @@ static inline int qedr_init_user_queue(struct ib_udata *udata,
 
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
@@ -1439,13 +1439,14 @@ static int qedr_init_srq_user_params(struct ib_udata *udata,
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
@@ -2932,7 +2933,7 @@ struct ib_mr *qedr_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 
 	mr->type = QEDR_MR_USER;
 
-	mr->umem = ib_umem_get(ibpd->device, start, len, acc);
+	mr->umem = ib_umem_get_va(ibpd->device, start, len, acc);
 	if (IS_ERR(mr->umem)) {
 		rc = -EFAULT;
 		goto err0;
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
index d5bfdbfe1376..0bdb4452d6f6 100644
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
index cefcb243c3a6..e939cd5ce40b 100644
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
index e69eadde6c26..345ec486a223 100644
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
index 4df792ebe02f..2a08817d3cce 100644
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
@@ -385,7 +385,7 @@ struct siw_umem *siw_umem_get(struct ib_device *base_dev, u64 start,
 
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


