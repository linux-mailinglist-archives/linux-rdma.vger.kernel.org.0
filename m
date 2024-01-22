Return-Path: <linux-rdma+bounces-700-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0418377B1
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jan 2024 00:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2751C23491
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 23:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C745C4D13D;
	Mon, 22 Jan 2024 23:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="G6g1O0ZA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16424CE0D;
	Mon, 22 Jan 2024 23:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705965793; cv=none; b=JEvfnQGrwycOjUfv/zUCQH3vtbXehhQMts+hSiMo25wgREfiAH6AdQq6PW6Ssbl8L9jm7j29NtNqDfpSqSwsOYmE+LMQbnM+VArRWXv6dqId2241BhEDEZ83PeFjSiXlkGNmrUO2hJWCTSsQGYINjXR0djd2ofTLSC7bz401d2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705965793; c=relaxed/simple;
	bh=0LFsgCOEAKQuUhPYaH18UHRI+EXA5/9whqnOJwq764w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=iONj1FS06RUxYGp9IRHs4LbJM8kRbm1BJNPKzJIlMWVF34ooFp6wvAqZfyMrZ+mudZ7eEzlvlYoaWaquH5i/76D+OWoP9Jx1uY7aM3NZlfqI5OA+MoM/IVekZi4imnSIb2+gcDG6TMoUBVsOoBtptgTCLE7SkpuBpObsar3bZHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=G6g1O0ZA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8D86420E2C27;
	Mon, 22 Jan 2024 15:23:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8D86420E2C27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1705965790;
	bh=w9zdnuTxkmqxVLuXq4ixPdoQsRbzumRtRMxFJfk7Hs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G6g1O0ZAOHL1JxMnIVL9JtMJEquFsPw7kQEswo5O0vTTBy7YETy8fKi8+2N3DkvSM
	 KfPcFhhdTzoIrXhrVx7yKX+ub7qa3TyVAaRiCAzMqDVMJBcAsorvyNvvpy8zJ2y02i
	 QT1GMFkdKlU8KiUW8nUM19zTVzflVhM3Rw+qXztQ=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v1 1/3] RDMA/mana_ib: introduce mdev_to_gc helper function
Date: Mon, 22 Jan 2024 15:22:59 -0800
Message-Id: <1705965781-3235-2-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1705965781-3235-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1705965781-3235-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Use a helper function to access gdma_context from mana_ib_dev.
This patch removes code repetitions as well as removes the need
to explicitly use gdma_dev, which was error-prone.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c      |  4 ++--
 drivers/infiniband/hw/mana/main.c    | 30 +++++++++++-----------------
 drivers/infiniband/hw/mana/mana_ib.h |  5 +++++
 drivers/infiniband/hw/mana/mr.c      | 13 +++---------
 drivers/infiniband/hw/mana/qp.c      | 12 +++++------
 5 files changed, 27 insertions(+), 37 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index 83ebd070535a..3369e7b665f9 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -16,7 +16,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	int err;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	gc = mdev->gdma_dev->gdma_context;
+	gc = mdev_to_gc(mdev);
 
 	if (udata->inlen < sizeof(ucmd))
 		return -EINVAL;
@@ -81,7 +81,7 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	int err;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	gc = mdev->gdma_dev->gdma_context;
+	gc = mdev_to_gc(mdev);
 
 	err = mana_ib_gd_destroy_dma_region(mdev, cq->gdma_region);
 	if (err) {
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index faca092456fa..e0f5138ca088 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -79,17 +79,17 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct gdma_create_pd_req req = {};
 	enum gdma_pd_flags flags = 0;
 	struct mana_ib_dev *dev;
-	struct gdma_dev *mdev;
+	struct gdma_context *gc;
 	int err;
 
 	dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	mdev = dev->gdma_dev;
+	gc = mdev_to_gc(dev);
 
 	mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_PD, sizeof(req),
 			     sizeof(resp));
 
 	req.flags = flags;
-	err = mana_gd_send_request(mdev->gdma_context, sizeof(req), &req,
+	err = mana_gd_send_request(gc, sizeof(req), &req,
 				   sizeof(resp), &resp);
 
 	if (err || resp.hdr.status) {
@@ -119,17 +119,17 @@ int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct gdma_destory_pd_resp resp = {};
 	struct gdma_destroy_pd_req req = {};
 	struct mana_ib_dev *dev;
-	struct gdma_dev *mdev;
+	struct gdma_context *gc;
 	int err;
 
 	dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	mdev = dev->gdma_dev;
+	gc = mdev_to_gc(dev);
 
 	mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_PD, sizeof(req),
 			     sizeof(resp));
 
 	req.pd_handle = pd->pd_handle;
-	err = mana_gd_send_request(mdev->gdma_context, sizeof(req), &req,
+	err = mana_gd_send_request(gc, sizeof(req), &req,
 				   sizeof(resp), &resp);
 
 	if (err || resp.hdr.status) {
@@ -206,13 +206,11 @@ int mana_ib_alloc_ucontext(struct ib_ucontext *ibcontext,
 	struct ib_device *ibdev = ibcontext->device;
 	struct mana_ib_dev *mdev;
 	struct gdma_context *gc;
-	struct gdma_dev *dev;
 	int doorbell_page;
 	int ret;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	dev = mdev->gdma_dev;
-	gc = dev->gdma_context;
+	gc = mdev_to_gc(mdev);
 
 	/* Allocate a doorbell page index */
 	ret = mana_gd_allocate_doorbell_page(gc, &doorbell_page);
@@ -238,7 +236,7 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
 	int ret;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	gc = mdev->gdma_dev->gdma_context;
+	gc = mdev_to_gc(mdev);
 
 	ret = mana_gd_destroy_doorbell_page(gc, mana_ucontext->doorbell);
 	if (ret)
@@ -322,15 +320,13 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 	size_t max_pgs_create_cmd;
 	struct gdma_context *gc;
 	size_t num_pages_total;
-	struct gdma_dev *mdev;
 	unsigned long page_sz;
 	unsigned int tail = 0;
 	u64 *page_addr_list;
 	void *request_buf;
 	int err;
 
-	mdev = dev->gdma_dev;
-	gc = mdev->gdma_context;
+	gc = mdev_to_gc(dev);
 	hwc = gc->hwc.driver_data;
 
 	/* Hardware requires dma region to align to chosen page size */
@@ -426,10 +422,8 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 
 int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev, u64 gdma_region)
 {
-	struct gdma_dev *mdev = dev->gdma_dev;
-	struct gdma_context *gc;
+	struct gdma_context *gc = mdev_to_gc(dev);
 
-	gc = mdev->gdma_context;
 	ibdev_dbg(&dev->ib_dev, "destroy dma region 0x%llx\n", gdma_region);
 
 	return mana_gd_destroy_dma_region(gc, gdma_region);
@@ -447,7 +441,7 @@ int mana_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vma)
 	int ret;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	gc = mdev->gdma_dev->gdma_context;
+	gc = mdev_to_gc(mdev);
 
 	if (vma->vm_pgoff != 0) {
 		ibdev_dbg(ibdev, "Unexpected vm_pgoff %lu\n", vma->vm_pgoff);
@@ -531,7 +525,7 @@ int mana_ib_gd_query_adapter_caps(struct mana_ib_dev *dev)
 	req.hdr.resp.msg_version = GDMA_MESSAGE_V3;
 	req.hdr.dev_id = dev->gdma_dev->dev_id;
 
-	err = mana_gd_send_request(dev->gdma_dev->gdma_context, sizeof(req),
+	err = mana_gd_send_request(mdev_to_gc(dev), sizeof(req),
 				   &req, sizeof(resp), &resp);
 
 	if (err) {
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 6bdc0f5498d5..ebb6537620ee 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -142,6 +142,11 @@ struct mana_ib_query_adapter_caps_resp {
 	u32 max_inline_data_size;
 }; /* HW Data */
 
+static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev *mdev)
+{
+	return mdev->gdma_dev->gdma_context;
+}
+
 int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 				 mana_handle_t *gdma_region);
 
diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index 351207c60eb6..ee4d4f83467c 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -30,12 +30,9 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev *dev, struct mana_ib_mr *mr,
 {
 	struct gdma_create_mr_response resp = {};
 	struct gdma_create_mr_request req = {};
-	struct gdma_dev *mdev = dev->gdma_dev;
-	struct gdma_context *gc;
+	struct gdma_context *gc = mdev_to_gc(dev);
 	int err;
 
-	gc = mdev->gdma_context;
-
 	mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_MR, sizeof(req),
 			     sizeof(resp));
 	req.pd_handle = mr_params->pd_handle;
@@ -77,12 +74,9 @@ static int mana_ib_gd_destroy_mr(struct mana_ib_dev *dev, u64 mr_handle)
 {
 	struct gdma_destroy_mr_response resp = {};
 	struct gdma_destroy_mr_request req = {};
-	struct gdma_dev *mdev = dev->gdma_dev;
-	struct gdma_context *gc;
+	struct gdma_context *gc = mdev_to_gc(dev);
 	int err;
 
-	gc = mdev->gdma_context;
-
 	mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_MR, sizeof(req),
 			     sizeof(resp));
 
@@ -164,8 +158,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	return &mr->ibmr;
 
 err_dma_region:
-	mana_gd_destroy_dma_region(dev->gdma_dev->gdma_context,
-				   dma_region_handle);
+	mana_gd_destroy_dma_region(mdev_to_gc(dev), dma_region_handle);
 
 err_umem:
 	ib_umem_release(mr->umem);
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 21ac9fcadf3f..0c8d6ecfbb2a 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -17,12 +17,10 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
 	struct mana_cfg_rx_steer_resp resp = {};
 	mana_handle_t *req_indir_tab;
 	struct gdma_context *gc;
-	struct gdma_dev *mdev;
 	u32 req_buf_size;
 	int i, err;
 
-	gc = dev->gdma_dev->gdma_context;
-	mdev = &gc->mana;
+	gc = mdev_to_gc(dev);
 
 	req_buf_size =
 		sizeof(*req) + sizeof(mana_handle_t) * MANA_INDIRECT_TABLE_SIZE;
@@ -39,7 +37,7 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
 	req->rx_enable = 1;
 	req->update_default_rxobj = 1;
 	req->default_rxobj = default_rxobj;
-	req->hdr.dev_id = mdev->dev_id;
+	req->hdr.dev_id = gc->mana.dev_id;
 
 	/* If there are more than 1 entries in indirection table, enable RSS */
 	if (log_ind_tbl_size)
@@ -99,6 +97,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 	struct mana_ib_qp *qp = container_of(ibqp, struct mana_ib_qp, ibqp);
 	struct mana_ib_dev *mdev =
 		container_of(pd->device, struct mana_ib_dev, ib_dev);
+	struct gdma_context *gc = mdev_to_gc(mdev);
 	struct ib_rwq_ind_table *ind_tbl = attr->rwq_ind_tbl;
 	struct mana_ib_create_qp_rss_resp resp = {};
 	struct mana_ib_create_qp_rss ucmd = {};
@@ -109,7 +108,6 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 	unsigned int ind_tbl_size;
 	struct mana_context *mc;
 	struct net_device *ndev;
-	struct gdma_context *gc;
 	struct mana_ib_cq *cq;
 	struct mana_ib_wq *wq;
 	struct gdma_dev *gd;
@@ -120,7 +118,6 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 	u32 port;
 	int ret;
 
-	gc = mdev->gdma_dev->gdma_context;
 	gd = &gc->mana;
 	mc = gd->driver_data;
 
@@ -307,6 +304,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 		rdma_udata_to_drv_context(udata, struct mana_ib_ucontext,
 					  ibucontext);
 	struct gdma_dev *gd = &mdev->gdma_dev->gdma_context->mana;
+	struct gdma_context *gc = mdev_to_gc(mdev);
 	struct mana_ib_create_qp_resp resp = {};
 	struct mana_ib_create_qp ucmd = {};
 	struct gdma_queue *gdma_cq = NULL;
@@ -450,7 +448,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 
 err_release_gdma_cq:
 	kfree(gdma_cq);
-	gd->gdma_context->cq_table[send_cq->id] = NULL;
+	gc->cq_table[send_cq->id] = NULL;
 
 err_destroy_wq_obj:
 	mana_destroy_wq_obj(mpc, GDMA_SQ, qp->tx_object);
-- 
2.43.0


