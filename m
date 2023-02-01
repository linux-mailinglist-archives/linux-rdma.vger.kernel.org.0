Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E49685DE4
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Feb 2023 04:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjBADXI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Jan 2023 22:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjBADXH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Jan 2023 22:23:07 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D5F42BF1
        for <linux-rdma@vger.kernel.org>; Tue, 31 Jan 2023 19:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675221786; x=1706757786;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3CkFTteUmKkC4yTgmZZbzcDOKiQH8cOHLROGARprfhw=;
  b=Npr6o32a+3xABqLXkaW8PfCLxCPCZ1jhlMO1GCIzM4vnVsMXWcl43JSD
   7cfssGh4NjqJl+LMlj1t+LG1DrIZc6gn8i0LWbliqJduQuYsxaDNoLJqI
   86oqoitGaoGRiTjqDEUZUbEoTEGaj3XJSFbNG11mjzURG+yXGXDMwajzG
   G5u1uhtxiYp4tInM4d1LElKNUtVH+SWRBTzaaNi+F2Yyz6uJmyw7pw9km
   Kiz6Ne+oAEEHO41L/kGxEHXgNK7PDTHOEf8hW0PqA4OibYHpiAICmNkda
   R3Ankh74jzKBtlyVE2ONiYpVQE7DIz6fK9T38EtOX8zyIzX+jx6b29xpB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="328036841"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="328036841"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 19:23:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="614693767"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="614693767"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga003.jf.intel.com with ESMTP; 31 Jan 2023 19:23:00 -0800
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCHv3 for-next 1/1] RDMA/irdma: Add support for dmabuf pin memory regions
Date:   Wed,  1 Feb 2023 11:21:15 +0800
Message-Id: <20230201032115.631656-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
V2->V3: Remove unnecessary variable initialization;
        Use error handler;
V1->V2: Thanks Shiraz Saleem, he gave me a lot of good suggestions.
        This commit is based on the shared functions from refactored
        irdma_reg_user_mr.
---
 drivers/infiniband/hw/irdma/verbs.c | 45 +++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 6982f38596c8..7525f4cdf6fb 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2977,6 +2977,50 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	return ERR_PTR(err);
 }
 
+static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
+					      u64 len, u64 virt,
+					      int fd, int access,
+					      struct ib_udata *udata)
+{
+	struct irdma_device *iwdev = to_iwdev(pd->device);
+	struct ib_umem_dmabuf *umem_dmabuf;
+	struct irdma_mr *iwmr;
+	int err;
+
+	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
+		return ERR_PTR(-EINVAL);
+
+	if (udata->inlen < IRDMA_MEM_REG_MIN_REQ_LEN)
+		return ERR_PTR(-EINVAL);
+
+	umem_dmabuf = ib_umem_dmabuf_get_pinned(pd->device, start, len, fd, access);
+	if (IS_ERR(umem_dmabuf)) {
+		err = PTR_ERR(umem_dmabuf);
+		ibdev_dbg(&iwdev->ibdev, "Failed to get dmabuf umem[%d]\n", err);
+		return ERR_PTR(err);
+	}
+
+	iwmr = irdma_alloc_iwmr(&umem_dmabuf->umem, pd, virt, IRDMA_MEMREG_TYPE_MEM);
+	if (IS_ERR(iwmr)) {
+		err = PTR_ERR(iwmr);
+		goto err_release;
+	}
+
+	err = irdma_reg_user_mr_type_mem(iwmr, access);
+	if (err)
+		goto err_iwmr;
+
+	return &iwmr->ibmr;
+
+err_iwmr:
+	irdma_free_iwmr(iwmr);
+
+err_release:
+	ib_umem_release(&umem_dmabuf->umem);
+
+	return ERR_PTR(err);
+}
+
 /**
  * irdma_reg_phys_mr - register kernel physical memory
  * @pd: ibpd pointer
@@ -4483,6 +4527,7 @@ static const struct ib_device_ops irdma_dev_ops = {
 	.query_port = irdma_query_port,
 	.query_qp = irdma_query_qp,
 	.reg_user_mr = irdma_reg_user_mr,
+	.reg_user_mr_dmabuf = irdma_reg_user_mr_dmabuf,
 	.req_notify_cq = irdma_req_notify_cq,
 	.resize_cq = irdma_resize_cq,
 	INIT_RDMA_OBJ_SIZE(ib_pd, irdma_pd, ibpd),
-- 
2.27.0

