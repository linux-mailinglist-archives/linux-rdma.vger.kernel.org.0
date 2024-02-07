Return-Path: <linux-rdma+bounces-955-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AE484CDB3
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 16:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ADEA2866A3
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 15:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B427F49F;
	Wed,  7 Feb 2024 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="K5AUXcxQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C437F48C;
	Wed,  7 Feb 2024 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318580; cv=none; b=N6bpS7SqTbmiMrbuxRsA2Ns5DgRhCpbCy/PsddzTKEABc51qBwycun3D4VRJ2PAWqVSD/KqxXT2bgso8EbgvOojzjkXXkY6sV3aifQA2YZa1eI3Gn4OR+CZP569h63UL777PbUk2vCPiWjdqS08URCcAUMD92F7DCe62KDUieEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318580; c=relaxed/simple;
	bh=n7jy2nTYCPBPjsSwlsWFPIf9aO2YXgMF4OPIJJOQ1o4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=SircrNCCLeWPjQWNhJfuLlbzJu9nMk2a0CkKmQQ4eHpzntzYV0hmhaLZvt84D88yKU/rZWL6YGjFrXY2Qz/whFAUA6rVc9Jc32bOGwL8/Jkyr3FhZII0cbUPEgai0MjKQ4U9/5d62p//A/SZhv+GDMUhDhvhrSxgdUToqsAMufY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=K5AUXcxQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 76A7520B2000;
	Wed,  7 Feb 2024 07:09:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 76A7520B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707318573;
	bh=D9DfkN7+KkkF6zbewlp+XiEGcytqhfnDeuYo9IZEKTY=;
	h=From:To:Cc:Subject:Date:From;
	b=K5AUXcxQ7gvu8moeVaO4Kwa0bGmyjDq8KhDUq2WNraKxQOPLfEwaxJcrcSEsgPo7+
	 U2Ie3oMqm2kyVVRUR2+Y4i9cFmvM7Wsn6LJ9dgLkvYBJild/B3DSGgRzb82be6SvWO
	 kx6VNnoy1+9x9gX93Rt6d3xKknrT9VcGxXAFLuCw=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v1 1/1] RDMA/mana_ib: Fix bug in creation of dma regions
Date: Wed,  7 Feb 2024 07:09:26 -0800
Message-Id: <1707318566-3141-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Dma registration was ignoring virtual addresses by setting it to 0.
As a result, mana_ib could only register page-aligned memory.
As well as, it could fail to produce dma regions with zero offset
for WQs and CQs (e.g., page size is 8192 but address is only 4096
bytes aligned), which is required by hardware.

This patch takes into account the virtual address, allowing to create
a dma region with any offset. For queues (e.g., WQs, CQs) that require
dma regions with zero offset we add a flag to ensure zero offset.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c      |  3 ++-
 drivers/infiniband/hw/mana/main.c    | 16 +++++++++++++---
 drivers/infiniband/hw/mana/mana_ib.h |  2 +-
 drivers/infiniband/hw/mana/mr.c      |  2 +-
 drivers/infiniband/hw/mana/qp.c      |  4 ++--
 drivers/infiniband/hw/mana/wq.c      |  3 ++-
 6 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index 83d20c3f0..e35de6b92 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -48,7 +48,8 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		return err;
 	}
 
-	err = mana_ib_gd_create_dma_region(mdev, cq->umem, &cq->gdma_region);
+	err = mana_ib_gd_create_dma_region(mdev, cq->umem, &cq->gdma_region,
+					   ucmd.buf_addr, true);
 	if (err) {
 		ibdev_dbg(ibdev,
 			  "Failed to create dma region for create cq, %d\n",
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 29dd2438d..13a4d5ab4 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -302,7 +302,7 @@ mana_ib_gd_add_dma_region(struct mana_ib_dev *dev, struct gdma_context *gc,
 }
 
 int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
-				 mana_handle_t *gdma_region)
+				 mana_handle_t *gdma_region, u64 virt, bool force_zero_offset)
 {
 	struct gdma_dma_region_add_pages_req *add_req = NULL;
 	size_t num_pages_processed = 0, num_pages_to_handle;
@@ -324,11 +324,21 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 	hwc = gc->hwc.driver_data;
 
 	/* Hardware requires dma region to align to chosen page size */
-	page_sz = ib_umem_find_best_pgsz(umem, PAGE_SZ_BM, 0);
+	page_sz = ib_umem_find_best_pgsz(umem, PAGE_SZ_BM, virt);
 	if (!page_sz) {
 		ibdev_dbg(&dev->ib_dev, "failed to find page size.\n");
 		return -ENOMEM;
 	}
+
+	if (force_zero_offset) {
+		while (ib_umem_dma_offset(umem, page_sz) && page_sz > PAGE_SIZE)
+			page_sz /= 2;
+		if (ib_umem_dma_offset(umem, page_sz) != 0) {
+			ibdev_dbg(&dev->ib_dev, "failed to find page size to force zero offset.\n");
+			return -ENOMEM;
+		}
+	}
+
 	num_pages_total = ib_umem_num_dma_blocks(umem, page_sz);
 
 	max_pgs_create_cmd =
@@ -348,7 +358,7 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 			     sizeof(struct gdma_create_dma_region_resp));
 
 	create_req->length = umem->length;
-	create_req->offset_in_page = umem->address & (page_sz - 1);
+	create_req->offset_in_page = ib_umem_dma_offset(umem, page_sz);
 	create_req->gdma_page_type = order_base_2(page_sz) - PAGE_SHIFT;
 	create_req->page_count = num_pages_total;
 
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 6a03ae645..0a5a8f3f8 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -161,7 +161,7 @@ static inline struct net_device *mana_ib_get_netdev(struct ib_device *ibdev, u32
 int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *cq);
 
 int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
-				 mana_handle_t *gdma_region);
+				 mana_handle_t *gdma_region, u64 virt, bool force_zero_offset);
 
 int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev,
 				  mana_handle_t gdma_region);
diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index ee4d4f834..856d73ea2 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -127,7 +127,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 		goto err_free;
 	}
 
-	err = mana_ib_gd_create_dma_region(dev, mr->umem, &dma_region_handle);
+	err = mana_ib_gd_create_dma_region(dev, mr->umem, &dma_region_handle, iova, false);
 	if (err) {
 		ibdev_dbg(ibdev, "Failed create dma region for user-mr, %d\n",
 			  err);
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 5d4c05dcd..02de90317 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -357,8 +357,8 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	}
 	qp->sq_umem = umem;
 
-	err = mana_ib_gd_create_dma_region(mdev, qp->sq_umem,
-					   &qp->sq_gdma_region);
+	err = mana_ib_gd_create_dma_region(mdev, qp->sq_umem, &qp->sq_gdma_region,
+					   ucmd.sq_buf_addr, true);
 	if (err) {
 		ibdev_dbg(&mdev->ib_dev,
 			  "Failed to create dma region for create qp-raw, %d\n",
diff --git a/drivers/infiniband/hw/mana/wq.c b/drivers/infiniband/hw/mana/wq.c
index 372d36151..d9c1a2d5d 100644
--- a/drivers/infiniband/hw/mana/wq.c
+++ b/drivers/infiniband/hw/mana/wq.c
@@ -46,7 +46,8 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
 	wq->wq_buf_size = ucmd.wq_buf_size;
 	wq->rx_object = INVALID_MANA_HANDLE;
 
-	err = mana_ib_gd_create_dma_region(mdev, wq->umem, &wq->gdma_region);
+	err = mana_ib_gd_create_dma_region(mdev, wq->umem, &wq->gdma_region,
+					   ucmd.wq_buf_addr, true);
 	if (err) {
 		ibdev_dbg(&mdev->ib_dev,
 			  "Failed to create dma region for create wq, %d\n",

base-commit: aafe4cc5096996873817ff4981a3744e8caf7808
-- 
2.43.0


