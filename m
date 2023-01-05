Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B8265E569
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jan 2023 07:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjAEGKJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Jan 2023 01:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjAEGKJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Jan 2023 01:10:09 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7708A2033
        for <linux-rdma@vger.kernel.org>; Wed,  4 Jan 2023 22:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672899008; x=1704435008;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qp9wu3lZ5VHt2N73ByVRc5rcdIJ3ZbWedXsieP6UPb0=;
  b=e+FLGIWJ/U/I3gkxkei04kvFajvMad52/ZkvmJUOx1jGcBAJUgo6PwRq
   igulMhBUnoxPrdTXk7tRPo8uCCpUWD1/WR4k98csYk7nmf0F1A9erNqZz
   HufnpiXI0DCYnmNx4nkg2XPGxkpgdL64dBNzMLiokJX1DwKWFNLwAd9xm
   m4MpK9PfX2qIE43UgyWUMeUz4mnGWtMI1zsd8twP6Id2viY/8KPS78lrX
   /MPRs2Sf/aVGR1OFrs4HhBbmk04a66vGxH+kHD4sUoDfVyFjfl30hSJUc
   eT6RUYaAPvfump2NaFbE3wCelN4RvWqfL22mbYapixf2SzcNEY6JmObZa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="301820041"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="301820041"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 22:10:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="779467362"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="779467362"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga004.jf.intel.com with ESMTP; 04 Jan 2023 22:10:05 -0800
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCHv3 for-next 1/1] RDMA/irdma: Add support for dmabuf pin memory regions
Date:   Thu,  5 Jan 2023 17:37:10 -0500
Message-Id: <20230105223710.973148-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
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
V2->V3: Simplify the function by removing QP and CQ handling;
V1->V2: Fix the build warning by adding a static;
---
 drivers/infiniband/hw/irdma/verbs.c | 97 +++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index f6973ea55eda..7028b8af87b9 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2912,6 +2912,102 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	return ERR_PTR(err);
 }
 
+static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
+					      u64 len, u64 virt,
+					      int fd, int access,
+					      struct ib_udata *udata)
+{
+	struct irdma_device *iwdev = to_iwdev(pd->device);
+	struct irdma_pble_alloc *palloc;
+	struct irdma_pbl *iwpbl;
+	struct irdma_mr *iwmr;
+	u32 stag = 0;
+	bool use_pbles = false;
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
+
+	iwmr->page_size = ib_umem_find_best_pgsz(iwmr->region,
+						 iwdev->rf->sc_dev.hw_attrs.page_size_cap,
+						 virt);
+	if (unlikely(!iwmr->page_size)) {
+		kfree(iwmr);
+		ib_umem_release(iwmr->region);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	iwmr->len = iwmr->region->length;
+	iwpbl->user_base = virt;
+	palloc = &iwpbl->pble_alloc;
+	iwmr->type = IRDMA_MEMREG_TYPE_MEM;
+	iwmr->page_cnt = ib_umem_num_dma_blocks(iwmr->region, iwmr->page_size);
+
+	use_pbles = (iwmr->page_cnt != 1);
+
+	err = irdma_setup_pbles(iwdev->rf, iwmr, use_pbles, false);
+	if (err)
+		goto error;
+
+	if (use_pbles) {
+		err = irdma_check_mr_contiguous(palloc,	iwmr->page_size);
+		if (err) {
+			irdma_free_pble(iwdev->rf->pble_rsrc, palloc);
+			iwpbl->pbl_allocated = false;
+		}
+	}
+
+	stag = irdma_create_stag(iwdev);
+	if (!stag) {
+		err = -ENOMEM;
+		goto error;
+	}
+
+	iwmr->stag = stag;
+	iwmr->ibmr.rkey = stag;
+	iwmr->ibmr.lkey = stag;
+	err = irdma_hwreg_mr(iwdev, iwmr, access);
+	if (err) {
+		irdma_free_stag(iwdev, stag);
+		goto error;
+	}
+
+	return &iwmr->ibmr;
+
+error:
+	if (palloc->level != PBLE_LEVEL_0 && iwpbl->pbl_allocated)
+		irdma_free_pble(iwdev->rf->pble_rsrc, palloc);
+	kfree(iwmr);
+	ib_umem_release(&umem_dmabuf->umem);
+
+	return ERR_PTR(err);
+}
+
 /**
  * irdma_reg_phys_mr - register kernel physical memory
  * @pd: ibpd pointer
@@ -4418,6 +4514,7 @@ static const struct ib_device_ops irdma_dev_ops = {
 	.query_port = irdma_query_port,
 	.query_qp = irdma_query_qp,
 	.reg_user_mr = irdma_reg_user_mr,
+	.reg_user_mr_dmabuf = irdma_reg_user_mr_dmabuf,
 	.req_notify_cq = irdma_req_notify_cq,
 	.resize_cq = irdma_resize_cq,
 	INIT_RDMA_OBJ_SIZE(ib_pd, irdma_pd, ibpd),
-- 
2.34.1

