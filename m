Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F9742858F
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Oct 2021 05:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbhJKDYU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Oct 2021 23:24:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:47094 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233841AbhJKDYT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 10 Oct 2021 23:24:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10133"; a="226688608"
X-IronPort-AV: E=Sophos;i="5.85,363,1624345200"; 
   d="scan'208";a="226688608"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2021 20:22:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,363,1624345200"; 
   d="scan'208";a="479677465"
Received: from unknown (HELO intel-73.bj.intel.com) ([10.238.154.73])
  by orsmga007.jf.intel.com with ESMTP; 10 Oct 2021 20:22:18 -0700
From:   yanjun.zhu@linux.dev
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        leonro@nvidia.com, yanjun.zhu@linux.dev
Subject: [PATCH 4/4] RDMA/irdma: compact the file uk.c
Date:   Mon, 11 Oct 2021 07:01:28 -0400
Message-Id: <20211011110128.4057-5-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211011110128.4057-1-yanjun.zhu@linux.dev>
References: <20211011110128.4057-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

The function irdma_cqp_up_map_cmd is not used. So remove it.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/protos.h |  2 --
 drivers/infiniband/hw/irdma/utils.c  | 34 ----------------------------
 2 files changed, 36 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/protos.h b/drivers/infiniband/hw/irdma/protos.h
index 78f598fdbccf..a17c0ffb0cc8 100644
--- a/drivers/infiniband/hw/irdma/protos.h
+++ b/drivers/infiniband/hw/irdma/protos.h
@@ -37,8 +37,6 @@ void irdma_hw_stats_read_all(struct irdma_vsi_pestat *stats,
 enum irdma_status_code
 irdma_cqp_ws_node_cmd(struct irdma_sc_dev *dev, u8 cmd,
 		      struct irdma_ws_node_info *node_info);
-enum irdma_status_code irdma_cqp_up_map_cmd(struct irdma_sc_dev *dev, u8 cmd,
-					    struct irdma_up_info *map_info);
 enum irdma_status_code irdma_cqp_ceq_cmd(struct irdma_sc_dev *dev,
 					 struct irdma_sc_ceq *sc_ceq, u8 op);
 enum irdma_status_code irdma_cqp_aeq_cmd(struct irdma_sc_dev *dev,
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 84bc7b659d76..0ebce57e8756 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -2048,40 +2048,6 @@ irdma_cqp_ws_node_cmd(struct irdma_sc_dev *dev, u8 cmd,
 	return status;
 }
 
-/**
- * irdma_cqp_up_map_cmd - Set the up-up mapping
- * @dev: pointer to device structure
- * @cmd: map command
- * @map_info: pointer to up map info
- */
-enum irdma_status_code irdma_cqp_up_map_cmd(struct irdma_sc_dev *dev, u8 cmd,
-					    struct irdma_up_info *map_info)
-{
-	struct irdma_pci_f *rf = dev_to_rf(dev);
-	struct irdma_cqp *iwcqp = &rf->cqp;
-	struct irdma_sc_cqp *cqp = &iwcqp->sc_cqp;
-	struct irdma_cqp_request *cqp_request;
-	struct cqp_cmds_info *cqp_info;
-	enum irdma_status_code status;
-
-	cqp_request = irdma_alloc_and_get_cqp_request(iwcqp, false);
-	if (!cqp_request)
-		return IRDMA_ERR_NO_MEMORY;
-
-	cqp_info = &cqp_request->info;
-	memset(cqp_info, 0, sizeof(*cqp_info));
-	cqp_info->cqp_cmd = cmd;
-	cqp_info->post_sq = 1;
-	cqp_info->in.u.up_map.info = *map_info;
-	cqp_info->in.u.up_map.cqp = cqp;
-	cqp_info->in.u.up_map.scratch = (uintptr_t)cqp_request;
-
-	status = irdma_handle_cqp_op(rf, cqp_request);
-	irdma_put_cqp_request(&rf->cqp, cqp_request);
-
-	return status;
-}
-
 /**
  * irdma_ah_cqp_op - perform an AH cqp operation
  * @rf: RDMA PCI function
-- 
2.27.0

