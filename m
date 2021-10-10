Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE2B427C39
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Oct 2021 19:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhJIRDw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 9 Oct 2021 13:03:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:65332 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231848AbhJIRDv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 9 Oct 2021 13:03:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10132"; a="224084145"
X-IronPort-AV: E=Sophos;i="5.85,360,1624345200"; 
   d="scan'208";a="224084145"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2021 10:01:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,360,1624345200"; 
   d="scan'208";a="440257533"
Received: from unknown (HELO intel-73.bj.intel.com) ([10.238.154.73])
  by orsmga006.jf.intel.com with ESMTP; 09 Oct 2021 10:01:52 -0700
From:   yanjun.zhu@linux.dev
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev, leonro@nvidia.com
Subject: [PATCH 3/4] RDMA/irdma: compat the utils.c file
Date:   Sat,  9 Oct 2021 20:41:09 -0400
Message-Id: <20211010004110.3842-4-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211010004110.3842-1-yanjun.zhu@linux.dev>
References: <20211010004110.3842-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

The function irdma_get_hw_addr is not used. So remove it.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/osdep.h |  1 -
 drivers/infiniband/hw/irdma/utils.c | 11 -----------
 2 files changed, 12 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/osdep.h b/drivers/infiniband/hw/irdma/osdep.h
index b2ab52335ca6..63d8bb3a6903 100644
--- a/drivers/infiniband/hw/irdma/osdep.h
+++ b/drivers/infiniband/hw/irdma/osdep.h
@@ -37,7 +37,6 @@ struct irdma_hw;
 struct irdma_pci_f;
 
 struct ib_device *to_ibdev(struct irdma_sc_dev *dev);
-u8 __iomem *irdma_get_hw_addr(void *dev);
 void irdma_ieq_mpa_crc_ae(struct irdma_sc_dev *dev, struct irdma_sc_qp *qp);
 enum irdma_status_code irdma_vf_wait_vchnl_resp(struct irdma_sc_dev *dev);
 bool irdma_vf_clear_to_send(struct irdma_sc_dev *dev);
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index ac91ea5296db..84bc7b659d76 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -767,17 +767,6 @@ struct ib_qp *irdma_get_qp(struct ib_device *device, int qpn)
 	return &iwdev->rf->qp_table[qpn]->ibqp;
 }
 
-/**
- * irdma_get_hw_addr - return hw addr
- * @par: points to shared dev
- */
-u8 __iomem *irdma_get_hw_addr(void *par)
-{
-	struct irdma_sc_dev *dev = par;
-
-	return dev->hw->hw_addr;
-}
-
 /**
  * irdma_remove_cqp_head - return head entry and remove
  * @dev: device
-- 
2.27.0

