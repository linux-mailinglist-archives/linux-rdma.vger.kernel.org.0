Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542E665AE8C
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Jan 2023 10:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjABJH0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Jan 2023 04:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjABJHZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Jan 2023 04:07:25 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C13C42
        for <linux-rdma@vger.kernel.org>; Mon,  2 Jan 2023 01:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672650443; x=1704186443;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R/Z9GaQjw3lVbfT9NMhZOOk/xckvzFgLUsq2dNNwsmw=;
  b=grNWFxvxiC6xrgF5akO6QHa+sH+xOLkL+ZuIy+3YO8zqfZedF/vh52Ew
   Valfs6qVL8f2l1FphiR/ZxVRkHFjkSS61E2cPWaaW9vx3w+YUdxpE0Z3e
   BgTXBaW3GmRxoY+OQeh2UtBs70gNaffqpiu0+cH2kRceJRy77ne5vg9aP
   pXk4cvBKII3fLDGGWDNRRG7gFkZmOQ7+BU7CmX1IVAlDNOsbhBNXQTVZ0
   QPg5/Fa3VvxevaM+ZRJONXnQpPUZVQTBIifnl9MqIddaotTBkd3dzEqDq
   0WNObzhuD8Duk1I6gyPysioHsVEl+zA7xy8mqo0RpJ091YBoUxFDmkmSC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="319155549"
X-IronPort-AV: E=Sophos;i="5.96,293,1665471600"; 
   d="scan'208";a="319155549"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 01:07:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="647868872"
X-IronPort-AV: E=Sophos;i="5.96,293,1665471600"; 
   d="scan'208";a="647868872"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga007.jf.intel.com with ESMTP; 02 Jan 2023 01:07:20 -0800
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 1/1] RDMA/irdma: Add support for dmabuf pin memory regions
Date:   Mon,  2 Jan 2023 20:34:33 -0500
Message-Id: <20230103013433.341997-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

This is a followup to the EFA dmabuf[1]. Irdma driver currently does
not support on-demand-paging(ODP). So it uses habanalabs as the
dmabuf exporter, and irdma as the importer to allow for peer2peer
access through libibverbs.

In this commit, the function ib_umem_dmabuf_get_pinned() is used.
This function is introduced in EFA dmabuf[1] which allows the driver
to get a dmabuf umem which is pinned and does not require move_notify
callback implementation. The returned umem is pinned and DMA mapped
like standard cpu umems, and is released through ib_umem_release().

[1]https://lore.kernel.org/lkml/20211007114018.GD2688930@ziepe.ca/t/

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/verbs.c | 158 ++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index f6973ea55eda..76dc6e65930a 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2912,6 +2912,163 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	return ERR_PTR(err);
 }
 
+struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
+				       u64 len, u64 virt,
+				       int fd, int access,
+				       struct ib_udata *udata)
+{
+	struct irdma_device *iwdev = to_iwdev(pd->device);
+	struct irdma_ucontext *ucontext;
+	struct irdma_pble_alloc *palloc;
+	struct irdma_pbl *iwpbl;
+	struct irdma_mr *iwmr;
+	struct irdma_mem_reg_req req;
+	u32 total, stag = 0;
+	u8 shadow_pgcnt = 1;
+	bool use_pbles = false;
+	unsigned long flags;
+	int err = -EINVAL;
+	struct ib_umem_dmabuf *umem_dmabuf;
+
+	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
+		return ERR_PTR(-EINVAL);
+
+	if (udata->inlen < IRDMA_MEM_REG_MIN_REQ_LEN)
+		return ERR_PTR(-EINVAL);
+
+	umem_dmabuf = ib_umem_dmabuf_get_pinned(pd->device, start, len, fd,
+						access);
+	if (IS_ERR(umem_dmabuf)) {
+		err = PTR_ERR(umem_dmabuf);
+		ibdev_dbg(&iwdev->ibdev, "Failed to get dmabuf umem[%d]\n", err);
+		return ERR_PTR(err);
+	}
+
+	if (ib_copy_from_udata(&req, udata, min(sizeof(req), udata->inlen))) {
+		ib_umem_release(&umem_dmabuf->umem);
+		return ERR_PTR(-EFAULT);
+	}
+
+	iwmr = kzalloc(sizeof(*iwmr), GFP_KERNEL);
+	if (!iwmr) {
+		ib_umem_release(&umem_dmabuf->umem);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	iwpbl = &iwmr->iwpbl;
+	iwpbl->iwmr = iwmr;
+	iwmr->region = &umem_dmabuf->umem;
+	iwmr->ibmr.pd = pd;
+	iwmr->ibmr.device = pd->device;
+	iwmr->ibmr.iova = virt;
+	iwmr->page_size = PAGE_SIZE;
+
+	if (req.reg_type == IRDMA_MEMREG_TYPE_MEM) {
+		iwmr->page_size = ib_umem_find_best_pgsz(iwmr->region,
+							 iwdev->rf->sc_dev.hw_attrs.page_size_cap,
+							 virt);
+		if (unlikely(!iwmr->page_size)) {
+			kfree(iwmr);
+			ib_umem_release(iwmr->region);
+			return ERR_PTR(-EOPNOTSUPP);
+		}
+	}
+	iwmr->len = iwmr->region->length;
+	iwpbl->user_base = virt;
+	palloc = &iwpbl->pble_alloc;
+	iwmr->type = req.reg_type;
+	iwmr->page_cnt = ib_umem_num_dma_blocks(iwmr->region, iwmr->page_size);
+
+	switch (req.reg_type) {
+	case IRDMA_MEMREG_TYPE_QP:
+		total = req.sq_pages + req.rq_pages + shadow_pgcnt;
+		if (total > iwmr->page_cnt) {
+			err = -EINVAL;
+			goto error;
+		}
+		total = req.sq_pages + req.rq_pages;
+		use_pbles = (total > 2);
+		err = irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
+		if (err)
+			goto error;
+
+		ucontext = rdma_udata_to_drv_context(udata, struct irdma_ucontext,
+						     ibucontext);
+		spin_lock_irqsave(&ucontext->qp_reg_mem_list_lock, flags);
+		list_add_tail(&iwpbl->list, &ucontext->qp_reg_mem_list);
+		iwpbl->on_list = true;
+		spin_unlock_irqrestore(&ucontext->qp_reg_mem_list_lock, flags);
+		break;
+	case IRDMA_MEMREG_TYPE_CQ:
+		if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_CQ_RESIZE)
+			shadow_pgcnt = 0;
+		total = req.cq_pages + shadow_pgcnt;
+		if (total > iwmr->page_cnt) {
+			err = -EINVAL;
+			goto error;
+		}
+
+		use_pbles = (req.cq_pages > 1);
+		err = irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
+		if (err)
+			goto error;
+
+		ucontext = rdma_udata_to_drv_context(udata, struct irdma_ucontext,
+						     ibucontext);
+		spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
+		list_add_tail(&iwpbl->list, &ucontext->cq_reg_mem_list);
+		iwpbl->on_list = true;
+		spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
+		break;
+	case IRDMA_MEMREG_TYPE_MEM:
+		use_pbles = (iwmr->page_cnt != 1);
+
+		err = irdma_setup_pbles(iwdev->rf, iwmr, use_pbles, false);
+		if (err)
+			goto error;
+
+		if (use_pbles) {
+			err = irdma_check_mr_contiguous(palloc,
+							iwmr->page_size);
+			if (err) {
+				irdma_free_pble(iwdev->rf->pble_rsrc, palloc);
+				iwpbl->pbl_allocated = false;
+			}
+		}
+
+		stag = irdma_create_stag(iwdev);
+		if (!stag) {
+			err = -ENOMEM;
+			goto error;
+		}
+
+		iwmr->stag = stag;
+		iwmr->ibmr.rkey = stag;
+		iwmr->ibmr.lkey = stag;
+		err = irdma_hwreg_mr(iwdev, iwmr, access);
+		if (err) {
+			irdma_free_stag(iwdev, stag);
+			goto error;
+		}
+
+		break;
+	default:
+		goto error;
+	}
+
+	iwmr->type = req.reg_type;
+
+	return &iwmr->ibmr;
+
+error:
+	if (palloc->level != PBLE_LEVEL_0 && iwpbl->pbl_allocated)
+		irdma_free_pble(iwdev->rf->pble_rsrc, palloc);
+	ib_umem_release(iwmr->region);
+	kfree(iwmr);
+
+	return ERR_PTR(err);
+}
+
 /**
  * irdma_reg_phys_mr - register kernel physical memory
  * @pd: ibpd pointer
@@ -4418,6 +4575,7 @@ static const struct ib_device_ops irdma_dev_ops = {
 	.query_port = irdma_query_port,
 	.query_qp = irdma_query_qp,
 	.reg_user_mr = irdma_reg_user_mr,
+	.reg_user_mr_dmabuf = irdma_reg_user_mr_dmabuf,
 	.req_notify_cq = irdma_req_notify_cq,
 	.resize_cq = irdma_resize_cq,
 	INIT_RDMA_OBJ_SIZE(ib_pd, irdma_pd, ibpd),
-- 
2.34.1

