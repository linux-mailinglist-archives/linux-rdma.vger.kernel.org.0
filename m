Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1D813D16F
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 17:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391831AbfFKPxN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 11:53:13 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33148 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391834AbfFKPxM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jun 2019 11:53:12 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 11 Jun 2019 18:53:00 +0300
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x5BFqxLF023036;
        Tue, 11 Jun 2019 18:53:00 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     maxg@mellanox.com, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: [PATCH 13/21] RDMA/core: Add an integrity MR pool support
Date:   Tue, 11 Jun 2019 18:52:49 +0300
Message-Id: <1560268377-26560-14-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1560268377-26560-1-git-send-email-maxg@mellanox.com>
References: <1560268377-26560-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Israel Rukshin <israelr@mellanox.com>

This is a preparation for adding new signature API to the rw-API.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/infiniband/core/mr_pool.c | 8 ++++++--
 drivers/infiniband/core/rw.c      | 4 ++--
 drivers/nvme/host/rdma.c          | 2 +-
 include/rdma/mr_pool.h            | 2 +-
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/mr_pool.c b/drivers/infiniband/core/mr_pool.c
index d117f21ce9fd..c0e2df128b34 100644
--- a/drivers/infiniband/core/mr_pool.c
+++ b/drivers/infiniband/core/mr_pool.c
@@ -34,14 +34,18 @@ void ib_mr_pool_put(struct ib_qp *qp, struct list_head *list, struct ib_mr *mr)
 EXPORT_SYMBOL(ib_mr_pool_put);
 
 int ib_mr_pool_init(struct ib_qp *qp, struct list_head *list, int nr,
-		enum ib_mr_type type, u32 max_num_sg)
+		enum ib_mr_type type, u32 max_num_sg, u32 max_num_meta_sg)
 {
 	struct ib_mr *mr;
 	unsigned long flags;
 	int ret, i;
 
 	for (i = 0; i < nr; i++) {
-		mr = ib_alloc_mr(qp->pd, type, max_num_sg);
+		if (type == IB_MR_TYPE_INTEGRITY)
+			mr = ib_alloc_mr_integrity(qp->pd, max_num_sg,
+						   max_num_meta_sg);
+		else
+			mr = ib_alloc_mr(qp->pd, type, max_num_sg);
 		if (IS_ERR(mr)) {
 			ret = PTR_ERR(mr);
 			goto out;
diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index c68171601915..3b224f5d036a 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -711,7 +711,7 @@ int rdma_rw_init_mrs(struct ib_qp *qp, struct ib_qp_init_attr *attr)
 	if (nr_mrs) {
 		ret = ib_mr_pool_init(qp, &qp->rdma_mrs, nr_mrs,
 				IB_MR_TYPE_MEM_REG,
-				rdma_rw_fr_page_list_len(dev));
+				rdma_rw_fr_page_list_len(dev), 0);
 		if (ret) {
 			pr_err("%s: failed to allocated %d MRs\n",
 				__func__, nr_mrs);
@@ -721,7 +721,7 @@ int rdma_rw_init_mrs(struct ib_qp *qp, struct ib_qp_init_attr *attr)
 
 	if (nr_sig_mrs) {
 		ret = ib_mr_pool_init(qp, &qp->sig_mrs, nr_sig_mrs,
-				IB_MR_TYPE_SIGNATURE, 2);
+				IB_MR_TYPE_SIGNATURE, 2, 0);
 		if (ret) {
 			pr_err("%s: failed to allocated %d SIG MRs\n",
 				__func__, nr_sig_mrs);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 97f668a39ae1..f3e3a8c861d6 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -482,7 +482,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	ret = ib_mr_pool_init(queue->qp, &queue->qp->rdma_mrs,
 			      queue->queue_size,
 			      IB_MR_TYPE_MEM_REG,
-			      nvme_rdma_get_max_fr_pages(ibdev));
+			      nvme_rdma_get_max_fr_pages(ibdev), 0);
 	if (ret) {
 		dev_err(queue->ctrl->ctrl.device,
 			"failed to initialize MR pool sized %d for QID %d\n",
diff --git a/include/rdma/mr_pool.h b/include/rdma/mr_pool.h
index 83763ef82354..e77123bcb43b 100644
--- a/include/rdma/mr_pool.h
+++ b/include/rdma/mr_pool.h
@@ -11,7 +11,7 @@ struct ib_mr *ib_mr_pool_get(struct ib_qp *qp, struct list_head *list);
 void ib_mr_pool_put(struct ib_qp *qp, struct list_head *list, struct ib_mr *mr);
 
 int ib_mr_pool_init(struct ib_qp *qp, struct list_head *list, int nr,
-		enum ib_mr_type type, u32 max_num_sg);
+		enum ib_mr_type type, u32 max_num_sg, u32 max_num_meta_sg);
 void ib_mr_pool_destroy(struct ib_qp *qp, struct list_head *list);
 
 #endif /* _RDMA_MR_POOL_H */
-- 
2.16.3

