Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 655CF16ABED
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 17:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgBXQpy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 11:45:54 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:59539 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727895AbgBXQpy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Feb 2020 11:45:54 -0500
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 24 Feb 2020 18:45:47 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 01OGji9d013647;
        Mon, 24 Feb 2020 18:45:47 +0200
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me,
        linux-rdma@vger.kernel.org, kbusch@kernel.org, hch@lst.de,
        martin.petersen@oracle.com
Cc:     vladimirk@mellanox.com, idanb@mellanox.com, maxg@mellanox.com,
        israelr@mellanox.com, axboe@kernel.dk, shlomin@mellanox.com
Subject: [PATCH 17/19] RDMA/rw: Expose maximal page list for a device per 1 MR
Date:   Mon, 24 Feb 2020 18:45:42 +0200
Message-Id: <20200224164544.219438-19-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200224164544.219438-1-maxg@mellanox.com>
References: <20200224164544.219438-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ULP's will use this information to determine the maximal data transfer
size per IO operation.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/core/rw.c | 14 ++++++++++++--
 include/rdma/rw.h            |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 4fad732..edc9bee 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -56,8 +56,17 @@ static inline bool rdma_rw_io_needs_mr(struct ib_device *dev, u8 port_num,
 	return false;
 }
 
-static inline u32 rdma_rw_fr_page_list_len(struct ib_device *dev,
-					   bool pi_support)
+/**
+ * rdma_rw_fr_page_list_len - return the max number of pages mapped by 1 MR
+ * @dev:	RDMA device that will eventually create a PD for needed MRs
+ * @pi_support:	Whether MRs will be created for protection information offload
+ *
+ * Returns the number of pages that one MR can map for RDMA operation by the
+ * given device. One can determine the maximal data size according to the
+ * result of this function, or chose using multiple MRs for the RDMA operation
+ * as well.
+ */
+u32 rdma_rw_fr_page_list_len(struct ib_device *dev, bool pi_support)
 {
 	u32 max_pages;
 
@@ -69,6 +78,7 @@ static inline u32 rdma_rw_fr_page_list_len(struct ib_device *dev,
 	/* arbitrary limit to avoid allocating gigantic resources */
 	return min_t(u32, max_pages, 256);
 }
+EXPORT_SYMBOL(rdma_rw_fr_page_list_len);
 
 static inline int rdma_rw_inv_key(struct rdma_rw_reg_ctx *reg)
 {
diff --git a/include/rdma/rw.h b/include/rdma/rw.h
index 6ad9dc8..a9bbda7 100644
--- a/include/rdma/rw.h
+++ b/include/rdma/rw.h
@@ -69,5 +69,6 @@ unsigned int rdma_rw_mr_factor(struct ib_device *device, u8 port_num,
 void rdma_rw_init_qp(struct ib_device *dev, struct ib_qp_init_attr *attr);
 int rdma_rw_init_mrs(struct ib_qp *qp, struct ib_qp_init_attr *attr);
 void rdma_rw_cleanup_mrs(struct ib_qp *qp);
+u32 rdma_rw_fr_page_list_len(struct ib_device *dev, bool pi_support);
 
 #endif /* _RDMA_RW_H */
-- 
1.8.3.1

