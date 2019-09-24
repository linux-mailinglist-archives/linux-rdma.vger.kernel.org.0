Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16258BD405
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2019 23:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbfIXVFv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Sep 2019 17:05:51 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:46276 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727476AbfIXVFu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Sep 2019 17:05:50 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 25 Sep 2019 00:05:49 +0300
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x8OL5mKr011319;
        Wed, 25 Sep 2019 00:05:48 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     jgg@mellanox.com, linux-rdma@vger.kernel.org, dledford@redhat.com,
        leonro@mellanox.com, sagi@grimberg.me
Cc:     Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH 1/1] IB/iser: remove redundant macro definitions
Date:   Wed, 25 Sep 2019 00:05:48 +0300
Message-Id: <1569359148-12312-1-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use the general linux definition for 4K and retrieve the rest from it.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/ulp/iser/iscsi_iser.c  | 2 +-
 drivers/infiniband/ulp/iser/iscsi_iser.h  | 8 ++------
 drivers/infiniband/ulp/iser/iser_memory.c | 4 ++--
 drivers/infiniband/ulp/iser/iser_verbs.c  | 4 ++--
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
index 2e72fc5..5036155 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -652,7 +652,7 @@ static void iscsi_iser_cleanup_task(struct iscsi_task *task)
 		}
 
 		if (!(ib_dev->attrs.device_cap_flags & IB_DEVICE_SG_GAPS_REG))
-			shost->virt_boundary_mask = ~MASK_4K;
+			shost->virt_boundary_mask = SZ_4K - 1;
 
 		if (iscsi_host_add(shost, ib_dev->dev.parent)) {
 			mutex_unlock(&iser_conn->state_mutex);
diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
index 39bf213..c12950b 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.h
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
@@ -96,15 +96,11 @@
 #define iser_err(fmt, arg...) \
 	pr_err(PFX "%s: " fmt, __func__ , ## arg)
 
-#define SHIFT_4K	12
-#define SIZE_4K	(1ULL << SHIFT_4K)
-#define MASK_4K	(~(SIZE_4K-1))
-
 /* Default support is 512KB I/O size */
 #define ISER_DEF_MAX_SECTORS		1024
-#define ISCSI_ISER_DEF_SG_TABLESIZE	((ISER_DEF_MAX_SECTORS * 512) >> SHIFT_4K)
+#define ISCSI_ISER_DEF_SG_TABLESIZE ((ISER_DEF_MAX_SECTORS * 512) >> ilog2(SZ_4K))
 /* Maximum support is 8MB I/O size */
-#define ISCSI_ISER_MAX_SG_TABLESIZE	((16384 * 512) >> SHIFT_4K)
+#define ISCSI_ISER_MAX_SG_TABLESIZE	((16384 * 512) >> ilog2(SZ_4K))
 
 #define ISER_DEF_XMIT_CMDS_DEFAULT		512
 #if ISCSI_DEF_XMIT_CMDS_MAX > ISER_DEF_XMIT_CMDS_DEFAULT
diff --git a/drivers/infiniband/ulp/iser/iser_memory.c b/drivers/infiniband/ulp/iser/iser_memory.c
index 2cc89a9..db8e847 100644
--- a/drivers/infiniband/ulp/iser/iser_memory.c
+++ b/drivers/infiniband/ulp/iser/iser_memory.c
@@ -237,7 +237,7 @@ int iser_fast_reg_fmr(struct iscsi_iser_task *iser_task,
 	int ret, plen;
 
 	page_vec->npages = 0;
-	page_vec->fake_mr.page_size = SIZE_4K;
+	page_vec->fake_mr.page_size = SZ_4K;
 	plen = ib_sg_to_pages(&page_vec->fake_mr, mem->sg,
 			      mem->dma_nents, NULL, iser_set_page);
 	if (unlikely(plen < mem->dma_nents)) {
@@ -451,7 +451,7 @@ static int iser_fast_reg_mr(struct iscsi_iser_task *iser_task,
 
 	ib_update_fast_reg_key(mr, ib_inc_rkey(mr->rkey));
 
-	n = ib_map_mr_sg(mr, mem->sg, mem->dma_nents, NULL, SIZE_4K);
+	n = ib_map_mr_sg(mr, mem->sg, mem->dma_nents, NULL, SZ_4K);
 	if (unlikely(n != mem->dma_nents)) {
 		iser_err("failed to map sg (%d/%d)\n",
 			 n, mem->dma_nents);
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index a6548de..65c9755 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -180,7 +180,7 @@ int iser_alloc_fmr_pool(struct ib_conn *ib_conn,
 
 	page_vec->pages = (u64 *)(page_vec + 1);
 
-	params.page_shift        = SHIFT_4K;
+	params.page_shift        = ilog2(SZ_4K);
 	params.max_pages_per_fmr = size;
 	/* make the pool size twice the max number of SCSI commands *
 	 * the ML is expected to queue, watermark for unmap at 50%  */
@@ -670,7 +670,7 @@ static void iser_connect_error(struct rdma_cm_id *cma_id)
 	else
 		max_num_sg = attr->max_fast_reg_page_list_len;
 
-	sg_tablesize = DIV_ROUND_UP(max_sectors * 512, SIZE_4K);
+	sg_tablesize = DIV_ROUND_UP(max_sectors * SECTOR_SIZE, SZ_4K);
 	if (attr->device_cap_flags & IB_DEVICE_MEM_MGT_EXTENSIONS)
 		sup_sg_tablesize =
 			min_t(
-- 
1.8.3.1

