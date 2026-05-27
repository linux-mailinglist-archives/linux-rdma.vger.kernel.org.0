Return-Path: <linux-rdma+bounces-21381-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGICCIolF2qu6wcAu9opvQ
	(envelope-from <linux-rdma+bounces-21381-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:10:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A25D85E82FF
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5F333022548
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 17:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B33444CAC2;
	Wed, 27 May 2026 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="wXhXtl6P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD20E3BE632
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901799; cv=none; b=PVdlMBm7PTlL0U3F9Q2l0CYJl0fD3NPmE8juKbA4jGzP9t8YbszTmJwFVeESaQux4AzlTKOp77Nuq9yD1xukS/SKqvr6ANacl+2tTau4Zo5aoDtGrsqqToclbkKLQ02NQJjlV28fLrmVMpYvQ5IAUHvLr+EfE6v+5GLZegRn4r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901799; c=relaxed/simple;
	bh=M03W68GBW1gVmDIV2vBJaSnNBpeyOgNA4UuLGQ9gKp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/0TiskaW1ZEaIkfY0wdw5P6GdtCf3z/lU8FHmuvVIbk7Hsbl8PqU4TBJTbCG9WIEOArphIKstXptxa4h4jT7iMKtyJyzB0fKQcOt2QqSmi0JSKgy62l1GZoVTPzGIMCcHKVl7vT0ItKq2RLW7eYq50NmtWJ0RBvV4kVMTgdVLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=wXhXtl6P; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso82523385e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 10:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779901795; x=1780506595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzC47m+zxcp0TncTRjJRol3VD2WgXOe3CsOtdMQE9dw=;
        b=wXhXtl6PpMrXYTDFhARAyB6qss49A4JnBQ+6XfmokdEY5g1Vg5HeEU06XU/bbUkQKu
         d8gyMPxIK4P5tV4hwquT/iC4XVEIo1hYc3u395ZqQNTqJ/bE3wrAnHZkWW8UGRDJPDKf
         jfKPgjNEdkr8xU5mVpvaZ1RcQiW3omB+HKcmfJEe3KmKxyXF3TLKBrS+yYAEVfbaAgu4
         UqGSOfYKTVxLR2ptscjHsScy/PFZDyaRX9Cggr9qqT7qxVZHwQafrZysxSt+p8W5+FYO
         JzdDSzWYcbVLDxF/S+uF0LCqZN/ks3yNpnWZd6/bIFg46osWTzqxitQJvLMaZM8GNa/q
         93HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901795; x=1780506595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lzC47m+zxcp0TncTRjJRol3VD2WgXOe3CsOtdMQE9dw=;
        b=rEf+Ujhup7/AQGuy0mwLGR02nk/xrfHt5FkBGAkK+xM3KTbYcaJcfP6jyjj8EL+paj
         7ud76MkTXkh7dtstCKu8e1omWcUTwUTEa8Sjnt0JMFj45eiHOTLwO5vRfXAdrfcnq7mP
         VIrUYZHyuKpxRDbdaoAbGkFCIRu1y9nFl1CDi2goUFadvyjv6mnLYRi+m/EMHbrR/U7+
         czg8yEQKcuZD+rLjxjfCb0GnWNu0Zu4PSk8o9shq7kfHeqrYdYl6teYm8MCKeFZ43SZR
         Lx9VZz8K2OWXe4ndooROI4BONa/qAqH9GonT2dgJ6xrzTJtpdxYzUG7saetcUcg5yKnq
         OkDA==
X-Gm-Message-State: AOJu0YxRpuAW016ZsoWbywIOYLxuhZyXLVikctknNNM3UuaeCVNrBh3N
	S2QWlUJuKHASEP7FKWnBc7OV0OZ4CtZMJhLjX03ypMLpciyv/+tDJHADCXzCIw/kEDxg/8enWde
	bGKb+tc+ETQ==
X-Gm-Gg: Acq92OGWp3/0tcQik5y/HMWYxDouqS5WUj7Sejzxnl/58+zja4Hr/Vl108KkuVv6Xb8
	CKMMYudLXWB8oLZ4CxAfMPYO6lorOlWJpsgxPyATvqAk1wDgxYOcHPmnFULAb1uRCYX1BomtN42
	ZDG/rAt5ewlGlqCGhaelAzdTs9/bLQQKuB0xUER028AJsLYVieFJkuKIIS1iik+5WUYomW5vD6u
	npA6+FtrwqDkyjDdWabbmxaYcgIwtSYCm58hKv0ePH/XgX99xHsv+O2uE5cp28JyDEz4a2PUaj3
	1TZuO7dJ5vq/cUqi1ELQRS85CAmOUo6Z9oHa9jlUNRqo1O8O0jObrKt3Yud/LdJWZej4ijWIU+0
	2w2vygBANa+x8QoWGY31Y4sjNSdiyjuzVoqZcM6lrISUJAqH4elsFPwjbLU1QWcIr8FiGUEEWha
	q4+/jhfGH769OFvRByjGaHVtjcYK3+2J4=
X-Received: by 2002:a05:600c:a410:b0:48e:8741:fd3d with SMTP id 5b1f17b1804b1-490426ab78dmr366011075e9.14.1779901795163;
        Wed, 27 May 2026 10:09:55 -0700 (PDT)
Received: from localhost ([128.77.52.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49059fb42dasm300588965e9.7.2026.05.27.10.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:09:54 -0700 (PDT)
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
Subject: [PATCH rdma-next v8 01/15] RDMA/umem: Rename ib_umem_get() to ib_umem_get_va()
Date: Wed, 27 May 2026 19:09:34 +0200
Message-ID: <20260527170948.2017439-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527170948.2017439-1-jiri@resnulli.us>
References: <20260527170948.2017439-1-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-21381-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: A25D85E82FF
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
v6->v7:
- rebased on top of bnxt_re changes
v4->v5:
- rebased on top of siw changes
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
index 94aa06e3b828..5e8fa7bf99cb 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1210,8 +1210,8 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 		bytes += bnxt_re_get_psn_bytes(rdev, cntx, qplib_qp, ureq, fixed_que_attr);
 
 	bytes = PAGE_ALIGN(bytes);
-	umem = ib_umem_get(&rdev->ibdev, ureq->qpsva, bytes,
-			   IB_ACCESS_LOCAL_WRITE);
+	umem = ib_umem_get_va(&rdev->ibdev, ureq->qpsva, bytes,
+			      IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(umem))
 		return PTR_ERR(umem);
 
@@ -1225,8 +1225,8 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 
 	bytes = (qplib_qp->rq.max_wqe * qplib_qp->rq.wqe_size);
 	bytes = PAGE_ALIGN(bytes);
-	umem = ib_umem_get(&rdev->ibdev, ureq->qprva, bytes,
-			   IB_ACCESS_LOCAL_WRITE);
+	umem = ib_umem_get_va(&rdev->ibdev, ureq->qprva, bytes,
+			      IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(umem)) {
 		rc = PTR_ERR(umem);
 		goto fail;
@@ -2171,8 +2171,8 @@ static int bnxt_re_init_user_srq(struct bnxt_re_dev *rdev,
 
 	bytes = (qplib_srq->max_wqe * qplib_srq->wqe_size);
 	bytes = PAGE_ALIGN(bytes);
-	umem = ib_umem_get(&rdev->ibdev, ureq.srqva, bytes,
-			   IB_ACCESS_LOCAL_WRITE);
+	umem = ib_umem_get_va(&rdev->ibdev, ureq.srqva, bytes,
+			      IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(umem))
 		return PTR_ERR(umem);
 
@@ -3496,9 +3496,9 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
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
@@ -3655,12 +3655,12 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, unsigned int cqe,
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
@@ -4670,7 +4670,7 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
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
index e8a9e7d8f267..01818a679d0a 100644
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
index 3f4811bb5514..baee48df5fdf 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3527,7 +3527,7 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	if (udata->inlen < IRDMA_MEM_REG_MIN_REQ_LEN)
 		return ERR_PTR(-EINVAL);
 
-	region = ib_umem_get(pd->device, start, len, access);
+	region = ib_umem_get_va(pd->device, start, len, access);
 
 	if (IS_ERR(region)) {
 		ibdev_dbg(&iwdev->ibdev,
@@ -3729,7 +3729,7 @@ static int irdma_rereg_mr_trans(struct irdma_mr *iwmr, u64 start, u64 len,
 	struct ib_umem *region;
 	int err;
 
-	region = ib_umem_get(pd->device, start, len, iwmr->access);
+	region = ib_umem_get_va(pd->device, start, len, iwmr->access);
 	if (IS_ERR(region))
 		return PTR_ERR(region);
 
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 307ae01bf26f..1e93df6455f5 100644
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
index dd868f9b893d..7bcb7e225662 100644
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
index 043b12cf7c1f..dc5e6e3e5a64 100644
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
index 383f1d9c15d1..69caadcff810 100644
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


