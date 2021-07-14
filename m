Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FB53C6EE3
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jul 2021 12:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbhGMKvn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jul 2021 06:51:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:16175 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235390AbhGMKvm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Jul 2021 06:51:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="189823682"
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="189823682"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 03:48:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="459532935"
Received: from unknown (HELO intel-86.bj.intel.com) ([10.238.154.86])
  by orsmga008.jf.intel.com with ESMTP; 13 Jul 2021 03:48:50 -0700
From:   yanjun.zhu@linux.dev
To:     zyjzyj2000@gmail.com, yanjun.zhu@intel.com,
        mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev, leon@kernel.org
Subject: [PATCH 1/3] RDMA/irdma: change the returned type of irdma_sc_repost_aeq_entries to void
Date:   Tue, 13 Jul 2021 23:11:28 -0400
Message-Id: <20210714031130.1511109-2-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210714031130.1511109-1-yanjun.zhu@linux.dev>
References: <20210714031130.1511109-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

The function irdma_sc_repost_aeq_entries always returns zero. So
the returned type is changed to void.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/ctrl.c | 4 +---
 drivers/infiniband/hw/irdma/type.h | 3 +--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index b1023a7d0bd1..777e35620635 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -4187,11 +4187,9 @@ enum irdma_status_code irdma_sc_get_next_aeqe(struct irdma_sc_aeq *aeq,
  * @dev: sc device struct
  * @count: allocate count
  */
-enum irdma_status_code irdma_sc_repost_aeq_entries(struct irdma_sc_dev *dev, u32 count)
+void irdma_sc_repost_aeq_entries(struct irdma_sc_dev *dev, u32 count)
 {
 	writel(count, dev->hw_regs[IRDMA_AEQALLOC]);
-
-	return 0;
 }
 
 /**
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index 7387b83e826d..874bc25a938b 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -1222,8 +1222,7 @@ enum irdma_status_code irdma_sc_aeq_init(struct irdma_sc_aeq *aeq,
 					 struct irdma_aeq_init_info *info);
 enum irdma_status_code irdma_sc_get_next_aeqe(struct irdma_sc_aeq *aeq,
 					      struct irdma_aeqe_info *info);
-enum irdma_status_code irdma_sc_repost_aeq_entries(struct irdma_sc_dev *dev,
-						   u32 count);
+void irdma_sc_repost_aeq_entries(struct irdma_sc_dev *dev, u32 count);
 
 void irdma_sc_pd_init(struct irdma_sc_dev *dev, struct irdma_sc_pd *pd, u32 pd_id,
 		      int abi_ver);
-- 
2.27.0

