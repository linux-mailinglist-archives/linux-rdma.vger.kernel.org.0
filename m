Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEF44BA41F
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Feb 2022 16:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242283AbiBQPTT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Feb 2022 10:19:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbiBQPTS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Feb 2022 10:19:18 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885591A58E3
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 07:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645111143; x=1676647143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H3RTR0JXNPvYgP1h1HZ7KAv2w81N5adxr98fZs91wHo=;
  b=EDXqBToOINAgoPQ80Ljr9/sKAjXVIbL/KDZKFnNgdbXdCSaXwbgWo6sL
   Z361rdafN8QvSvlQIsZPey4Kn2zRSxUv17vP2FakfSgvt+sYSh1Snz/5g
   ROrr7rufzoNZUh9yimsZ15dxNKVYpsHlrarzh5bRA/HRAkMRvnhMC1L7g
   89r6m85IXNu7Ug3ISpfqWK979ZWEXVxSCB5Z/hubyW2I/FIO9ElIBWf3H
   AVo3pO7dAJlMklnkGeynge8E63ZTdvLM1pz6MwD0Ck8CSP3CKYYxu8lF2
   0RRFIPkUXqWCIEy/InA5+e5/86lhVRg53k3nnnQifmSoSzPfwIiDELc0A
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="238299021"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="238299021"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 07:19:02 -0800
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="545657268"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.255.39.128])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 07:19:02 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, linux-rdma@vger.kernel.org
Cc:     Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 3/3] RDMA/irdma: Remove excess error variables
Date:   Thu, 17 Feb 2022 09:18:51 -0600
Message-Id: <20220217151851.1518-4-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220217151851.1518-1-shiraz.saleem@intel.com>
References: <20220217151851.1518-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

As irdma_status_code is replaced with an int, there is
no need for two variables to hold error codes.

Remove the excess variable in functions where this occurs.
Also, remove any redundant initializations which are
no longer needed.

Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/hw.c    |   4 +-
 drivers/infiniband/hw/irdma/verbs.c | 100 ++++++++++--------------------------
 2 files changed, 28 insertions(+), 76 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 93b7135..58cee86 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -1298,10 +1298,10 @@ static int irdma_setup_ceqs(struct irdma_pci_f *rf, struct irdma_sc_vsi *vsi)
 
 static int irdma_create_virt_aeq(struct irdma_pci_f *rf, u32 size)
 {
-	int status = -ENOMEM;
 	struct irdma_aeq *aeq = &rf->aeq;
 	dma_addr_t *pg_arr;
 	u32 pg_cnt;
+	int status;
 
 	if (rf->rdma_ver < IRDMA_GEN_2)
 		return -EOPNOTSUPP;
@@ -1310,7 +1310,7 @@ static int irdma_create_virt_aeq(struct irdma_pci_f *rf, u32 size)
 	aeq->mem.va = vzalloc(aeq->mem.size);
 
 	if (!aeq->mem.va)
-		return status;
+		return -ENOMEM;
 
 	pg_cnt = DIV_ROUND_UP(aeq->mem.size, PAGE_SIZE);
 	status = irdma_get_pble(rf->pble_rsrc, &aeq->palloc, pg_cnt, true);
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 3a5f41b..df0a011 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -806,7 +806,6 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 	struct irdma_create_qp_req req;
 	struct irdma_create_qp_resp uresp = {};
 	u32 qp_num = 0;
-	int ret;
 	int err_code;
 	int sq_size;
 	int rq_size;
@@ -936,9 +935,8 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 	if (dev->hw_attrs.uk_attrs.hw_rev > IRDMA_GEN_1)
 		init_info.qp_uk_init_info.qp_caps |= IRDMA_PUSH_MODE;
 
-	ret = irdma_sc_qp_init(qp, &init_info);
-	if (ret) {
-		err_code = -EPROTO;
+	err_code = irdma_sc_qp_init(qp, &init_info);
+	if (err_code) {
 		ibdev_dbg(&iwdev->ibdev, "VERBS: qp_init fail\n");
 		goto error;
 	}
@@ -1792,7 +1790,6 @@ static int irdma_resize_cq(struct ib_cq *ibcq, int entries,
 	struct irdma_device *iwdev;
 	struct irdma_pci_f *rf;
 	struct irdma_cq_buf *cq_buf = NULL;
-	int status = 0;
 	unsigned long flags;
 	int ret;
 
@@ -1885,12 +1882,10 @@ static int irdma_resize_cq(struct ib_cq *ibcq, int entries,
 	cqp_info->in.u.cq_modify.cq = &iwcq->sc_cq;
 	cqp_info->in.u.cq_modify.scratch = (uintptr_t)cqp_request;
 	cqp_info->post_sq = 1;
-	status = irdma_handle_cqp_op(rf, cqp_request);
+	ret = irdma_handle_cqp_op(rf, cqp_request);
 	irdma_put_cqp_request(&rf->cqp, cqp_request);
-	if (status) {
-		ret = -EPROTO;
+	if (ret)
 		goto error;
-	}
 
 	spin_lock_irqsave(&iwcq->lock, flags);
 	if (cq_buf) {
@@ -1945,7 +1940,6 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 	struct irdma_sc_cq *cq;
 	struct irdma_sc_dev *dev = &rf->sc_dev;
 	struct irdma_cq_init_info info = {};
-	int status;
 	struct irdma_cqp_request *cqp_request;
 	struct cqp_cmds_info *cqp_info;
 	struct irdma_cq_uk_init_info *ukinfo = &info.cq_uk_init_info;
@@ -2095,12 +2089,10 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 	cqp_info->in.u.cq_create.cq = cq;
 	cqp_info->in.u.cq_create.check_overflow = true;
 	cqp_info->in.u.cq_create.scratch = (uintptr_t)cqp_request;
-	status = irdma_handle_cqp_op(rf, cqp_request);
+	err_code = irdma_handle_cqp_op(rf, cqp_request);
 	irdma_put_cqp_request(&rf->cqp, cqp_request);
-	if (status) {
-		err_code = -ENOMEM;
+	if (err_code)
 		goto cq_free_rsrc;
-	}
 
 	if (udata) {
 		struct irdma_create_cq_resp resp = {};
@@ -2534,7 +2526,6 @@ static int irdma_hw_alloc_stag(struct irdma_device *iwdev,
 	struct irdma_allocate_stag_info *info;
 	struct irdma_pd *iwpd = to_iwpd(iwmr->ibmr.pd);
 	int status;
-	int err = 0;
 	struct irdma_cqp_request *cqp_request;
 	struct cqp_cmds_info *cqp_info;
 
@@ -2556,10 +2547,8 @@ static int irdma_hw_alloc_stag(struct irdma_device *iwdev,
 	cqp_info->in.u.alloc_stag.scratch = (uintptr_t)cqp_request;
 	status = irdma_handle_cqp_op(iwdev->rf, cqp_request);
 	irdma_put_cqp_request(&iwdev->rf->cqp, cqp_request);
-	if (status)
-		err = -ENOMEM;
 
-	return err;
+	return status;
 }
 
 /**
@@ -2575,9 +2564,8 @@ static struct ib_mr *irdma_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 	struct irdma_pble_alloc *palloc;
 	struct irdma_pbl *iwpbl;
 	struct irdma_mr *iwmr;
-	int status;
 	u32 stag;
-	int err_code = -ENOMEM;
+	int err_code;
 
 	iwmr = kzalloc(sizeof(*iwmr), GFP_KERNEL);
 	if (!iwmr)
@@ -2599,9 +2587,9 @@ static struct ib_mr *irdma_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 	iwmr->type = IRDMA_MEMREG_TYPE_MEM;
 	palloc = &iwpbl->pble_alloc;
 	iwmr->page_cnt = max_num_sg;
-	status = irdma_get_pble(iwdev->rf->pble_rsrc, palloc, iwmr->page_cnt,
-				true);
-	if (status)
+	err_code = irdma_get_pble(iwdev->rf->pble_rsrc, palloc, iwmr->page_cnt,
+				  true);
+	if (err_code)
 		goto err_get_pble;
 
 	err_code = irdma_hw_alloc_stag(iwdev, iwmr);
@@ -2672,10 +2660,9 @@ static int irdma_hwreg_mr(struct irdma_device *iwdev, struct irdma_mr *iwmr,
 	struct irdma_reg_ns_stag_info *stag_info;
 	struct irdma_pd *iwpd = to_iwpd(iwmr->ibmr.pd);
 	struct irdma_pble_alloc *palloc = &iwpbl->pble_alloc;
-	int status;
-	int err = 0;
 	struct irdma_cqp_request *cqp_request;
 	struct cqp_cmds_info *cqp_info;
+	int ret;
 
 	cqp_request = irdma_alloc_and_get_cqp_request(&iwdev->rf->cqp, true);
 	if (!cqp_request)
@@ -2712,12 +2699,10 @@ static int irdma_hwreg_mr(struct irdma_device *iwdev, struct irdma_mr *iwmr,
 	cqp_info->post_sq = 1;
 	cqp_info->in.u.mr_reg_non_shared.dev = &iwdev->rf->sc_dev;
 	cqp_info->in.u.mr_reg_non_shared.scratch = (uintptr_t)cqp_request;
-	status = irdma_handle_cqp_op(iwdev->rf, cqp_request);
+	ret = irdma_handle_cqp_op(iwdev->rf, cqp_request);
 	irdma_put_cqp_request(&iwdev->rf->cqp, cqp_request);
-	if (status)
-		err = -ENOMEM;
 
-	return err;
+	return ret;
 }
 
 /**
@@ -2897,7 +2882,6 @@ struct ib_mr *irdma_reg_phys_mr(struct ib_pd *pd, u64 addr, u64 size, int access
 	struct irdma_device *iwdev = to_iwdev(pd->device);
 	struct irdma_pbl *iwpbl;
 	struct irdma_mr *iwmr;
-	int status;
 	u32 stag;
 	int ret;
 
@@ -2925,10 +2909,9 @@ struct ib_mr *irdma_reg_phys_mr(struct ib_pd *pd, u64 addr, u64 size, int access
 	iwmr->pgaddrmem[0] = addr;
 	iwmr->len = size;
 	iwmr->page_size = SZ_4K;
-	status = irdma_hwreg_mr(iwdev, iwmr, access);
-	if (status) {
+	ret = irdma_hwreg_mr(iwdev, iwmr, access);
+	if (ret) {
 		irdma_free_stag(iwdev, stag);
-		ret = -ENOMEM;
 		goto err;
 	}
 
@@ -3057,7 +3040,6 @@ static int irdma_post_send(struct ib_qp *ibqp,
 	struct irdma_qp_uk *ukqp;
 	struct irdma_sc_dev *dev;
 	struct irdma_post_sq_info info;
-	int ret;
 	int err = 0;
 	unsigned long flags;
 	bool inv_stag;
@@ -3116,7 +3098,7 @@ static int irdma_post_send(struct ib_qp *ibqp,
 					info.op.inline_send.qkey = ud_wr(ib_wr)->remote_qkey;
 					info.op.inline_send.dest_qp = ud_wr(ib_wr)->remote_qpn;
 				}
-				ret = irdma_uk_inline_send(ukqp, &info, false);
+				err = irdma_uk_inline_send(ukqp, &info, false);
 			} else {
 				info.op.send.num_sges = ib_wr->num_sge;
 				info.op.send.sg_list = ib_wr->sg_list;
@@ -3127,14 +3109,7 @@ static int irdma_post_send(struct ib_qp *ibqp,
 					info.op.send.qkey = ud_wr(ib_wr)->remote_qkey;
 					info.op.send.dest_qp = ud_wr(ib_wr)->remote_qpn;
 				}
-				ret = irdma_uk_send(ukqp, &info, false);
-			}
-
-			if (ret) {
-				if (ret == -ENOMEM)
-					err = -ENOMEM;
-				else
-					err = -EINVAL;
+				err = irdma_uk_send(ukqp, &info, false);
 			}
 			break;
 		case IB_WR_RDMA_WRITE_WITH_IMM:
@@ -3160,20 +3135,13 @@ static int irdma_post_send(struct ib_qp *ibqp,
 						rdma_wr(ib_wr)->remote_addr;
 				info.op.inline_rdma_write.rem_addr.lkey =
 						rdma_wr(ib_wr)->rkey;
-				ret = irdma_uk_inline_rdma_write(ukqp, &info, false);
+				err = irdma_uk_inline_rdma_write(ukqp, &info, false);
 			} else {
 				info.op.rdma_write.lo_sg_list = (void *)ib_wr->sg_list;
 				info.op.rdma_write.num_lo_sges = ib_wr->num_sge;
 				info.op.rdma_write.rem_addr.addr = rdma_wr(ib_wr)->remote_addr;
 				info.op.rdma_write.rem_addr.lkey = rdma_wr(ib_wr)->rkey;
-				ret = irdma_uk_rdma_write(ukqp, &info, false);
-			}
-
-			if (ret) {
-				if (ret == -ENOMEM)
-					err = -ENOMEM;
-				else
-					err = -EINVAL;
+				err = irdma_uk_rdma_write(ukqp, &info, false);
 			}
 			break;
 		case IB_WR_RDMA_READ_WITH_INV:
@@ -3190,21 +3158,12 @@ static int irdma_post_send(struct ib_qp *ibqp,
 			info.op.rdma_read.rem_addr.lkey = rdma_wr(ib_wr)->rkey;
 			info.op.rdma_read.lo_sg_list = (void *)ib_wr->sg_list;
 			info.op.rdma_read.num_lo_sges = ib_wr->num_sge;
-
-			ret = irdma_uk_rdma_read(ukqp, &info, inv_stag, false);
-			if (ret) {
-				if (ret == -ENOMEM)
-					err = -ENOMEM;
-				else
-					err = -EINVAL;
-			}
+			err = irdma_uk_rdma_read(ukqp, &info, inv_stag, false);
 			break;
 		case IB_WR_LOCAL_INV:
 			info.op_type = IRDMA_OP_TYPE_INV_STAG;
 			info.op.inv_local_stag.target_stag = ib_wr->ex.invalidate_rkey;
-			ret = irdma_uk_stag_local_invalidate(ukqp, &info, true);
-			if (ret)
-				err = -ENOMEM;
+			err = irdma_uk_stag_local_invalidate(ukqp, &info, true);
 			break;
 		case IB_WR_REG_MR: {
 			struct irdma_mr *iwmr = to_iwmr(reg_wr(ib_wr)->mr);
@@ -3226,10 +3185,8 @@ static int irdma_post_send(struct ib_qp *ibqp,
 			stag_info.local_fence = ib_wr->send_flags & IB_SEND_FENCE;
 			if (iwmr->npages > IRDMA_MIN_PAGES_PER_FMR)
 				stag_info.chunk_size = 1;
-			ret = irdma_sc_mr_fast_register(&iwqp->sc_qp, &stag_info,
+			err = irdma_sc_mr_fast_register(&iwqp->sc_qp, &stag_info,
 							true);
-			if (ret)
-				err = -ENOMEM;
 			break;
 		}
 		default:
@@ -3274,7 +3231,6 @@ static int irdma_post_recv(struct ib_qp *ibqp,
 	struct irdma_qp *iwqp;
 	struct irdma_qp_uk *ukqp;
 	struct irdma_post_rq_info post_recv = {};
-	int ret = 0;
 	unsigned long flags;
 	int err = 0;
 	bool reflush = false;
@@ -3289,14 +3245,10 @@ static int irdma_post_recv(struct ib_qp *ibqp,
 		post_recv.num_sges = ib_wr->num_sge;
 		post_recv.wr_id = ib_wr->wr_id;
 		post_recv.sg_list = ib_wr->sg_list;
-		ret = irdma_uk_post_receive(ukqp, &post_recv);
-		if (ret) {
+		err = irdma_uk_post_receive(ukqp, &post_recv);
+		if (err) {
 			ibdev_dbg(&iwqp->iwdev->ibdev,
-				  "VERBS: post_recv err %d\n", ret);
-			if (ret == -ENOMEM)
-				err = -ENOMEM;
-			else
-				err = -EINVAL;
+				  "VERBS: post_recv err %d\n", err);
 			goto out;
 		}
 
-- 
1.8.3.1

