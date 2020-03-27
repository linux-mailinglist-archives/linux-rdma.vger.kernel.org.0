Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4F07195C46
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2020 18:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgC0RPx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Mar 2020 13:15:53 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:44788 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727423AbgC0RPw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Mar 2020 13:15:52 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 27 Mar 2020 20:15:47 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02RHFjjA004869;
        Fri, 27 Mar 2020 20:15:47 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, martin.petersen@oracle.com, jsmart2021@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     idanb@mellanox.com, axboe@kernel.dk, maxg@mellanox.com,
        vladimirk@mellanox.com, oren@mellanox.com, shlomin@mellanox.com,
        israelr@mellanox.com, jgg@mellanox.com
Subject: [PATCH 07/17] nvme-rdma: Introduce nvme_rdma_sgl structure
Date:   Fri, 27 Mar 2020 20:15:35 +0300
Message-Id: <20200327171545.98970-9-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200327171545.98970-1-maxg@mellanox.com>
References: <20200327171545.98970-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Israel Rukshin <israelr@mellanox.com>

Remove first_sgl pointer from struct nvme_rdma_request and use pointer
arithmetic instead. The inline scatterlist, if exists, will be located
right after the nvme_rdma_request. This patch is needed as a preparation
for adding PI support.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/host/rdma.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3ae3011..e38f8f7 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -48,6 +48,11 @@ struct nvme_rdma_qe {
 	u64			dma;
 };
 
+struct nvme_rdma_sgl {
+	int			nents;
+	struct sg_table		sg_table;
+};
+
 struct nvme_rdma_queue;
 struct nvme_rdma_request {
 	struct nvme_request	req;
@@ -58,12 +63,10 @@ struct nvme_rdma_request {
 	refcount_t		ref;
 	struct ib_sge		sge[1 + NVME_RDMA_MAX_INLINE_SEGMENTS];
 	u32			num_sge;
-	int			nents;
 	struct ib_reg_wr	reg_wr;
 	struct ib_cqe		reg_cqe;
 	struct nvme_rdma_queue  *queue;
-	struct sg_table		sg_table;
-	struct scatterlist	first_sgl[];
+	struct nvme_rdma_sgl	data_sgl;
 };
 
 enum nvme_rdma_queue_flags {
@@ -1164,8 +1167,9 @@ static void nvme_rdma_unmap_data(struct nvme_rdma_queue *queue,
 		req->mr = NULL;
 	}
 
-	ib_dma_unmap_sg(ibdev, req->sg_table.sgl, req->nents, rq_dma_dir(rq));
-	sg_free_table_chained(&req->sg_table, NVME_INLINE_SG_CNT);
+	ib_dma_unmap_sg(ibdev, req->data_sgl.sg_table.sgl, req->data_sgl.nents,
+			rq_dma_dir(rq));
+	sg_free_table_chained(&req->data_sgl.sg_table, NVME_INLINE_SG_CNT);
 }
 
 static int nvme_rdma_set_sg_null(struct nvme_command *c)
@@ -1184,7 +1188,7 @@ static int nvme_rdma_map_sg_inline(struct nvme_rdma_queue *queue,
 		int count)
 {
 	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
-	struct scatterlist *sgl = req->sg_table.sgl;
+	struct scatterlist *sgl = req->data_sgl.sg_table.sgl;
 	struct ib_sge *sge = &req->sge[1];
 	u32 len = 0;
 	int i;
@@ -1209,8 +1213,8 @@ static int nvme_rdma_map_sg_single(struct nvme_rdma_queue *queue,
 {
 	struct nvme_keyed_sgl_desc *sg = &c->common.dptr.ksgl;
 
-	sg->addr = cpu_to_le64(sg_dma_address(req->sg_table.sgl));
-	put_unaligned_le24(sg_dma_len(req->sg_table.sgl), sg->length);
+	sg->addr = cpu_to_le64(sg_dma_address(req->data_sgl.sg_table.sgl));
+	put_unaligned_le24(sg_dma_len(req->data_sgl.sg_table.sgl), sg->length);
 	put_unaligned_le32(queue->device->pd->unsafe_global_rkey, sg->key);
 	sg->type = NVME_KEY_SGL_FMT_DATA_DESC << 4;
 	return 0;
@@ -1231,7 +1235,8 @@ static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
 	 * Align the MR to a 4K page size to match the ctrl page size and
 	 * the block virtual boundary.
 	 */
-	nr = ib_map_mr_sg(req->mr, req->sg_table.sgl, count, NULL, SZ_4K);
+	nr = ib_map_mr_sg(req->mr, req->data_sgl.sg_table.sgl, count, NULL,
+			  SZ_4K);
 	if (unlikely(nr < count)) {
 		ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, req->mr);
 		req->mr = NULL;
@@ -1278,17 +1283,18 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 	if (!blk_rq_nr_phys_segments(rq))
 		return nvme_rdma_set_sg_null(c);
 
-	req->sg_table.sgl = req->first_sgl;
-	ret = sg_alloc_table_chained(&req->sg_table,
-			blk_rq_nr_phys_segments(rq), req->sg_table.sgl,
+	req->data_sgl.sg_table.sgl = (struct scatterlist *)(req + 1);
+	ret = sg_alloc_table_chained(&req->data_sgl.sg_table,
+			blk_rq_nr_phys_segments(rq), req->data_sgl.sg_table.sgl,
 			NVME_INLINE_SG_CNT);
 	if (ret)
 		return -ENOMEM;
 
-	req->nents = blk_rq_map_sg(rq->q, rq, req->sg_table.sgl);
+	req->data_sgl.nents = blk_rq_map_sg(rq->q, rq,
+					    req->data_sgl.sg_table.sgl);
 
-	count = ib_dma_map_sg(ibdev, req->sg_table.sgl, req->nents,
-			      rq_dma_dir(rq));
+	count = ib_dma_map_sg(ibdev, req->data_sgl.sg_table.sgl,
+			      req->data_sgl.nents, rq_dma_dir(rq));
 	if (unlikely(count <= 0)) {
 		ret = -EIO;
 		goto out_free_table;
@@ -1317,9 +1323,10 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 	return 0;
 
 out_unmap_sg:
-	ib_dma_unmap_sg(ibdev, req->sg_table.sgl, req->nents, rq_dma_dir(rq));
+	ib_dma_unmap_sg(ibdev, req->data_sgl.sg_table.sgl, req->data_sgl.nents,
+			rq_dma_dir(rq));
 out_free_table:
-	sg_free_table_chained(&req->sg_table, NVME_INLINE_SG_CNT);
+	sg_free_table_chained(&req->data_sgl.sg_table, NVME_INLINE_SG_CNT);
 	return ret;
 }
 
-- 
1.8.3.1

