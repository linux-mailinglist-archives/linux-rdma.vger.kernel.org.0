Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01497B8356
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Oct 2023 17:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243238AbjJDPPE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Oct 2023 11:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243240AbjJDPPA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Oct 2023 11:15:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610E9191
        for <linux-rdma@vger.kernel.org>; Wed,  4 Oct 2023 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696432485; x=1727968485;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vW3HqQV4oJNpueKDor83qkbeoMXMLFWDeNLohPdv/aw=;
  b=iwYkVwkwJJAZtzLOj1BZeK2MnAvvpxNAoSnPdiEe6l/gy8BgxUJkkqDO
   wwKqSD42LTNmvEIfJ61wkGDwHaK+RkxDRlcuTD2Jju8ynWBMZjBo3XMEM
   mRZjxg+7zZTHZj1ZO0HnxXLP1YMLrxh44ADzJQzXh4P9gR5E16DDloLUz
   orE+u8pYhKu1WnpmpmKdR73v8mEJXjr6FyLbYujZdCxO9EIpc6afhuLN4
   QeTTigXty7AgCPw+KBmvI7w3aJ2WdZ3i/AvOrlUCV9i4awK0y+IbNMYmx
   auNz5CKxcveQU8WmiFU85jHR8xDkuGt9FeZ8R1zoawBqFWjG4SSl70YmZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="383099928"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="383099928"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 08:13:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="745005292"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="745005292"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.93.52.50])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 08:13:20 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     nex.sw.ncis.nat.hpm.dev@intel.com, jgg@nvidia.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Sindhu Devale <sindhu.devale@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next v1] RDMA/irdma: Add support to re-register a memory region
Date:   Wed,  4 Oct 2023 10:13:06 -0500
Message-Id: <20231004151306.228-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Sindhu Devale <sindhu.devale@intel.com>

Add support for reregister MR verb API by doing a de-register
followed by a register MR with the new attributes. Reuse resources
like iwmr handle and HW stag where possible.

Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
v0->v1: return int for irdma_rereg_mr_trans()

 drivers/infiniband/hw/irdma/verbs.c | 232 +++++++++++++++++++++++++++++-------
 drivers/infiniband/hw/irdma/verbs.h |   2 +
 2 files changed, 192 insertions(+), 42 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 15ea2f3d48f2..cd68f57d0108 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2649,6 +2649,8 @@ static int irdma_hw_alloc_stag(struct irdma_device *iwdev,
 	cqp_info->in.u.alloc_stag.scratch = (uintptr_t)cqp_request;
 	status = irdma_handle_cqp_op(iwdev->rf, cqp_request);
 	irdma_put_cqp_request(&iwdev->rf->cqp, cqp_request);
+	if (!status)
+		iwmr->is_hwreg = 1;
 
 	return status;
 }
@@ -2816,14 +2818,18 @@ static int irdma_hwreg_mr(struct irdma_device *iwdev, struct irdma_mr *iwmr,
 	ret = irdma_handle_cqp_op(iwdev->rf, cqp_request);
 	irdma_put_cqp_request(&iwdev->rf->cqp, cqp_request);
 
+	if (!ret)
+		iwmr->is_hwreg = 1;
+
 	return ret;
 }
 
-static int irdma_reg_user_mr_type_mem(struct irdma_mr *iwmr, int access)
+static int irdma_reg_user_mr_type_mem(struct irdma_mr *iwmr, int access,
+				      bool create_stag)
 {
 	struct irdma_device *iwdev = to_iwdev(iwmr->ibmr.device);
 	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
-	u32 stag;
+	u32 stag = 0;
 	u8 lvl;
 	int err;
 
@@ -2842,15 +2848,18 @@ static int irdma_reg_user_mr_type_mem(struct irdma_mr *iwmr, int access)
 		}
 	}
 
-	stag = irdma_create_stag(iwdev);
-	if (!stag) {
-		err = -ENOMEM;
-		goto free_pble;
+	if (create_stag) {
+		stag = irdma_create_stag(iwdev);
+		if (!stag) {
+			err = -ENOMEM;
+			goto free_pble;
+		}
+
+		iwmr->stag = stag;
+		iwmr->ibmr.rkey = stag;
+		iwmr->ibmr.lkey = stag;
 	}
 
-	iwmr->stag = stag;
-	iwmr->ibmr.rkey = stag;
-	iwmr->ibmr.lkey = stag;
 	err = irdma_hwreg_mr(iwdev, iwmr, access);
 	if (err)
 		goto err_hwreg;
@@ -2858,7 +2867,8 @@ static int irdma_reg_user_mr_type_mem(struct irdma_mr *iwmr, int access)
 	return 0;
 
 err_hwreg:
-	irdma_free_stag(iwdev, stag);
+	if (stag)
+		irdma_free_stag(iwdev, stag);
 
 free_pble:
 	if (iwpbl->pble_alloc.level != PBLE_LEVEL_0 && iwpbl->pbl_allocated)
@@ -3033,7 +3043,7 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 			goto error;
 		break;
 	case IRDMA_MEMREG_TYPE_MEM:
-		err = irdma_reg_user_mr_type_mem(iwmr, access);
+		err = irdma_reg_user_mr_type_mem(iwmr, access, true);
 		if (err)
 			goto error;
 
@@ -3077,7 +3087,7 @@ static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
 		goto err_release;
 	}
 
-	err = irdma_reg_user_mr_type_mem(iwmr, access);
+	err = irdma_reg_user_mr_type_mem(iwmr, access, true);
 	if (err)
 		goto err_iwmr;
 
@@ -3092,6 +3102,164 @@ static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
 	return ERR_PTR(err);
 }
 
+static int irdma_hwdereg_mr(struct ib_mr *ib_mr)
+{
+	struct irdma_device *iwdev = to_iwdev(ib_mr->device);
+	struct irdma_mr *iwmr = to_iwmr(ib_mr);
+	struct irdma_pd *iwpd = to_iwpd(ib_mr->pd);
+	struct irdma_dealloc_stag_info *info;
+	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
+	struct irdma_cqp_request *cqp_request;
+	struct cqp_cmds_info *cqp_info;
+	int status;
+
+	/* Skip HW MR de-register when it is already de-registered
+	 * during an MR re-reregister and the re-registration fails
+	 */
+	if (!iwmr->is_hwreg)
+		return 0;
+
+	cqp_request = irdma_alloc_and_get_cqp_request(&iwdev->rf->cqp, true);
+	if (!cqp_request)
+		return -ENOMEM;
+
+	cqp_info = &cqp_request->info;
+	info = &cqp_info->in.u.dealloc_stag.info;
+	memset(info, 0, sizeof(*info));
+	info->pd_id = iwpd->sc_pd.pd_id;
+	info->stag_idx = ib_mr->rkey >> IRDMA_CQPSQ_STAG_IDX_S;
+	info->mr = true;
+	if (iwpbl->pbl_allocated)
+		info->dealloc_pbl = true;
+
+	cqp_info->cqp_cmd = IRDMA_OP_DEALLOC_STAG;
+	cqp_info->post_sq = 1;
+	cqp_info->in.u.dealloc_stag.dev = &iwdev->rf->sc_dev;
+	cqp_info->in.u.dealloc_stag.scratch = (uintptr_t)cqp_request;
+	status = irdma_handle_cqp_op(iwdev->rf, cqp_request);
+	irdma_put_cqp_request(&iwdev->rf->cqp, cqp_request);
+
+	if (!status)
+		iwmr->is_hwreg = 0;
+
+	return status;
+}
+
+/*
+ * irdma_rereg_mr_trans - Re-register a user MR for a change translation.
+ * @iwmr: ptr of iwmr
+ * @start: virtual start address
+ * @len: length of mr
+ * @virt: virtual address
+ *
+ * Re-register a user memory region when a change translation is requested.
+ * Re-register a new region while reusing the stag from the original registration.
+ */
+static int irdma_rereg_mr_trans(struct irdma_mr *iwmr, u64 start, u64 len,
+				u64 virt)
+{
+	struct irdma_device *iwdev = to_iwdev(iwmr->ibmr.device);
+	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
+	struct ib_pd *pd = iwmr->ibmr.pd;
+	struct ib_umem *region;
+	int err;
+
+	region = ib_umem_get(pd->device, start, len, iwmr->access);
+	if (IS_ERR(region))
+		return PTR_ERR(region);
+
+	iwmr->region = region;
+	iwmr->ibmr.iova = virt;
+	iwmr->ibmr.pd = pd;
+	iwmr->page_size = ib_umem_find_best_pgsz(region,
+				iwdev->rf->sc_dev.hw_attrs.page_size_cap,
+				virt);
+	if (unlikely(!iwmr->page_size)) {
+		err = -EOPNOTSUPP;
+		goto err;
+	}
+
+	iwmr->len = region->length;
+	iwpbl->user_base = virt;
+	iwmr->page_cnt = ib_umem_num_dma_blocks(region, iwmr->page_size);
+
+	err = irdma_reg_user_mr_type_mem(iwmr, iwmr->access, false);
+	if (err)
+		goto err;
+
+	return 0;
+
+err:
+	ib_umem_release(region);
+	return err;
+}
+
+/*
+ *  irdma_rereg_user_mr - Re-Register a user memory region(MR)
+ *  @ibmr: ib mem to access iwarp mr pointer
+ *  @flags: bit mask to indicate which of the attr's of MR modified
+ *  @start: virtual start address
+ *  @len: length of mr
+ *  @virt: virtual address
+ *  @new_access: bit mask of access flags
+ *  @new_pd: ptr of pd
+ *  @udata: user data
+ *
+ *  Return:
+ *  NULL - Success, existing MR updated
+ *  ERR_PTR - error occurred
+ */
+static struct ib_mr *irdma_rereg_user_mr(struct ib_mr *ib_mr, int flags,
+					 u64 start, u64 len, u64 virt,
+					 int new_access, struct ib_pd *new_pd,
+					 struct ib_udata *udata)
+{
+	struct irdma_device *iwdev = to_iwdev(ib_mr->device);
+	struct irdma_mr *iwmr = to_iwmr(ib_mr);
+	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
+	int ret;
+
+	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
+		return ERR_PTR(-EINVAL);
+
+	if (flags & ~(IB_MR_REREG_TRANS | IB_MR_REREG_PD | IB_MR_REREG_ACCESS))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	ret = irdma_hwdereg_mr(ib_mr);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (flags & IB_MR_REREG_ACCESS)
+		iwmr->access = new_access;
+
+	if (flags & IB_MR_REREG_PD) {
+		iwmr->ibmr.pd = new_pd;
+		iwmr->ibmr.device = new_pd->device;
+	}
+
+	if (flags & IB_MR_REREG_TRANS) {
+		if (iwpbl->pbl_allocated) {
+			irdma_free_pble(iwdev->rf->pble_rsrc,
+					&iwpbl->pble_alloc);
+			iwpbl->pbl_allocated = false;
+		}
+		if (iwmr->region) {
+			ib_umem_release(iwmr->region);
+			iwmr->region = NULL;
+		}
+
+		ret = irdma_rereg_mr_trans(iwmr, start, len, virt);
+		if (ret)
+			return ERR_PTR(ret);
+	} else {
+		ret = irdma_hwreg_mr(iwdev, iwmr, iwmr->access);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
+	return NULL;
+}
+
 /**
  * irdma_reg_phys_mr - register kernel physical memory
  * @pd: ibpd pointer
@@ -3199,16 +3367,10 @@ static void irdma_del_memlist(struct irdma_mr *iwmr,
  */
 static int irdma_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 {
-	struct ib_pd *ibpd = ib_mr->pd;
-	struct irdma_pd *iwpd = to_iwpd(ibpd);
 	struct irdma_mr *iwmr = to_iwmr(ib_mr);
 	struct irdma_device *iwdev = to_iwdev(ib_mr->device);
-	struct irdma_dealloc_stag_info *info;
 	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
-	struct irdma_pble_alloc *palloc = &iwpbl->pble_alloc;
-	struct irdma_cqp_request *cqp_request;
-	struct cqp_cmds_info *cqp_info;
-	int status;
+	int ret;
 
 	if (iwmr->type != IRDMA_MEMREG_TYPE_MEM) {
 		if (iwmr->region) {
@@ -3222,33 +3384,18 @@ static int irdma_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 		goto done;
 	}
 
-	cqp_request = irdma_alloc_and_get_cqp_request(&iwdev->rf->cqp, true);
-	if (!cqp_request)
-		return -ENOMEM;
-
-	cqp_info = &cqp_request->info;
-	info = &cqp_info->in.u.dealloc_stag.info;
-	memset(info, 0, sizeof(*info));
-	info->pd_id = iwpd->sc_pd.pd_id;
-	info->stag_idx = ib_mr->rkey >> IRDMA_CQPSQ_STAG_IDX_S;
-	info->mr = true;
-	if (iwpbl->pbl_allocated)
-		info->dealloc_pbl = true;
-
-	cqp_info->cqp_cmd = IRDMA_OP_DEALLOC_STAG;
-	cqp_info->post_sq = 1;
-	cqp_info->in.u.dealloc_stag.dev = &iwdev->rf->sc_dev;
-	cqp_info->in.u.dealloc_stag.scratch = (uintptr_t)cqp_request;
-	status = irdma_handle_cqp_op(iwdev->rf, cqp_request);
-	irdma_put_cqp_request(&iwdev->rf->cqp, cqp_request);
-	if (status)
-		return status;
+	ret = irdma_hwdereg_mr(ib_mr);
+	if (ret)
+		return ret;
 
 	irdma_free_stag(iwdev, iwmr->stag);
 done:
 	if (iwpbl->pbl_allocated)
-		irdma_free_pble(iwdev->rf->pble_rsrc, palloc);
-	ib_umem_release(iwmr->region);
+		irdma_free_pble(iwdev->rf->pble_rsrc, &iwpbl->pble_alloc);
+
+	if (iwmr->region)
+		ib_umem_release(iwmr->region);
+
 	kfree(iwmr);
 
 	return 0;
@@ -4578,6 +4725,7 @@ static enum rdma_link_layer irdma_get_link_layer(struct ib_device *ibdev,
 	.query_qp = irdma_query_qp,
 	.reg_user_mr = irdma_reg_user_mr,
 	.reg_user_mr_dmabuf = irdma_reg_user_mr_dmabuf,
+	.rereg_user_mr = irdma_rereg_user_mr,
 	.req_notify_cq = irdma_req_notify_cq,
 	.resize_cq = irdma_resize_cq,
 	INIT_RDMA_OBJ_SIZE(ib_pd, irdma_pd, ibpd),
diff --git a/drivers/infiniband/hw/irdma/verbs.h b/drivers/infiniband/hw/irdma/verbs.h
index 2789bc973210..c42ac22de00e 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -100,6 +100,8 @@ struct irdma_mr {
 		struct ib_mw ibmw;
 	};
 	struct ib_umem *region;
+	int access;
+	u8 is_hwreg;
 	u16 type;
 	u32 page_cnt;
 	u64 page_size;
-- 
1.8.3.1

