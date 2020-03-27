Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8B1195C4C
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2020 18:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgC0RP6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Mar 2020 13:15:58 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:44789 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727473AbgC0RPw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Mar 2020 13:15:52 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 27 Mar 2020 20:15:47 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02RHFjjC004869;
        Fri, 27 Mar 2020 20:15:47 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, martin.petersen@oracle.com, jsmart2021@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     idanb@mellanox.com, axboe@kernel.dk, maxg@mellanox.com,
        vladimirk@mellanox.com, oren@mellanox.com, shlomin@mellanox.com,
        israelr@mellanox.com, jgg@mellanox.com
Subject: [PATCH 09/17] nvmet: prepare metadata request
Date:   Fri, 27 Mar 2020 20:15:37 +0300
Message-Id: <20200327171545.98970-11-maxg@mellanox.com>
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

Allocate the metadata SGL buffers and set metadata fields for the
request. This is a preparation for adding metadata support over the
fabrics.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/target/core.c  | 48 ++++++++++++++++++++++++++++++++++++++-------
 drivers/nvme/target/nvmet.h |  5 +++++
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b685f99d..3899b2b4 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -873,13 +873,17 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->sq = sq;
 	req->ops = ops;
 	req->sg = NULL;
+	req->md_sg = NULL;
 	req->sg_cnt = 0;
+	req->md_sg_cnt = 0;
 	req->transfer_len = 0;
+	req->md_len = 0;
 	req->cqe->status = 0;
 	req->cqe->sq_head = 0;
 	req->ns = NULL;
 	req->error_loc = NVMET_NO_ERROR_LOC;
 	req->error_slba = 0;
+	req->use_md = false;
 
 	trace_nvmet_req_init(req, req->cmd);
 
@@ -962,6 +966,7 @@ bool nvmet_check_data_len_lte(struct nvmet_req *req, size_t data_len)
 int nvmet_req_alloc_sgl(struct nvmet_req *req)
 {
 	struct pci_dev *p2p_dev = NULL;
+	int data_len = req->transfer_len - req->md_len;
 
 	if (IS_ENABLED(CONFIG_PCI_P2PDMA)) {
 		if (req->sq->ctrl && req->ns)
@@ -971,11 +976,23 @@ int nvmet_req_alloc_sgl(struct nvmet_req *req)
 		req->p2p_dev = NULL;
 		if (req->sq->qid && p2p_dev) {
 			req->sg = pci_p2pmem_alloc_sgl(p2p_dev, &req->sg_cnt,
-						       req->transfer_len);
-			if (req->sg) {
-				req->p2p_dev = p2p_dev;
-				return 0;
+						       data_len);
+			if (!req->sg)
+				goto fallback;
+
+			if (req->md_len) {
+				req->md_sg =
+					pci_p2pmem_alloc_sgl(p2p_dev,
+							     &req->md_sg_cnt,
+							     req->md_len);
+				if (!req->md_sg) {
+					pci_p2pmem_free_sgl(req->p2p_dev,
+							    req->sg);
+					goto fallback;
+				}
 			}
+			req->p2p_dev = p2p_dev;
+			return 0;
 		}
 
 		/*
@@ -984,23 +1001,40 @@ int nvmet_req_alloc_sgl(struct nvmet_req *req)
 		 */
 	}
 
-	req->sg = sgl_alloc(req->transfer_len, GFP_KERNEL, &req->sg_cnt);
+fallback:
+	req->sg = sgl_alloc(data_len, GFP_KERNEL, &req->sg_cnt);
 	if (unlikely(!req->sg))
 		return -ENOMEM;
 
+	if (req->md_len) {
+		req->md_sg = sgl_alloc(req->md_len, GFP_KERNEL,
+					 &req->md_sg_cnt);
+		if (unlikely(!req->md_sg)) {
+			sgl_free(req->sg);
+			return -ENOMEM;
+		}
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nvmet_req_alloc_sgl);
 
 void nvmet_req_free_sgl(struct nvmet_req *req)
 {
-	if (req->p2p_dev)
+	if (req->p2p_dev) {
 		pci_p2pmem_free_sgl(req->p2p_dev, req->sg);
-	else
+		if (req->md_sg)
+			pci_p2pmem_free_sgl(req->p2p_dev, req->md_sg);
+	} else {
 		sgl_free(req->sg);
+		if (req->md_sg)
+			sgl_free(req->md_sg);
+	}
 
 	req->sg = NULL;
+	req->md_sg = NULL;
 	req->sg_cnt = 0;
+	req->md_sg_cnt = 0;
 }
 EXPORT_SYMBOL_GPL(nvmet_req_free_sgl);
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 421dff3..8c75667 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -302,6 +302,7 @@ struct nvmet_req {
 	struct nvmet_cq		*cq;
 	struct nvmet_ns		*ns;
 	struct scatterlist	*sg;
+	struct scatterlist	*md_sg;
 	struct bio_vec		inline_bvec[NVMET_MAX_INLINE_BIOVEC];
 	union {
 		struct {
@@ -315,8 +316,10 @@ struct nvmet_req {
 		} f;
 	};
 	int			sg_cnt;
+	int			md_sg_cnt;
 	/* data length as parsed from the SGL descriptor: */
 	size_t			transfer_len;
+	size_t			md_len;
 
 	struct nvmet_port	*port;
 
@@ -327,6 +330,8 @@ struct nvmet_req {
 	struct device		*p2p_client;
 	u16			error_loc;
 	u64			error_slba;
+	/* Metadata support */
+	bool			use_md;
 };
 
 extern struct workqueue_struct *buffered_io_wq;
-- 
1.8.3.1

