Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68C79164C0
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 15:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfEGNi4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 09:38:56 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:40432 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726506AbfEGNi4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 09:38:56 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 7 May 2019 16:38:41 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x47DcdFD021865;
        Tue, 7 May 2019 16:38:41 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com, maxg@mellanox.com
Subject: [PATCH 13/25] IB/iser: Unwind WR union at iser_tx_desc
Date:   Tue,  7 May 2019 16:38:27 +0300
Message-Id: <1557236319-9986-14-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Israel Rukshin <israelr@mellanox.com>

After decreasing WRs array size from 7 to 3 it is more
readable to give each WR a descriptive name.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/ulp/iser/iscsi_iser.c  |  3 ++-
 drivers/infiniband/ulp/iser/iscsi_iser.h  | 34 ++++++-------------------------
 drivers/infiniband/ulp/iser/iser_memory.c | 16 ++++++++-------
 drivers/infiniband/ulp/iser/iser_verbs.c  | 12 +++++++++--
 4 files changed, 27 insertions(+), 38 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
index a78e219a2297..285dded073b4 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -205,7 +205,8 @@ iser_initialize_task_headers(struct iscsi_task *task,
 		goto out;
 	}
 
-	tx_desc->wr_idx = 0;
+	tx_desc->inv_wr.next = NULL;
+	tx_desc->reg_wr.wr.next = NULL;
 	tx_desc->mapped = true;
 	tx_desc->dma_addr = dma_addr;
 	tx_desc->tx_sg[0].addr   = tx_desc->dma_addr;
diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
index 8ae77770c962..ea250289bc26 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.h
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
@@ -225,12 +225,6 @@ enum iser_desc_type {
 	ISCSI_TX_DATAOUT
 };
 
-/*
- * Maximum number of work requests per task
- * (invalidate, registration, send)
- */
-#define ISER_MAX_WRS 3
-
 /**
  * struct iser_tx_desc - iSER TX descriptor
  *
@@ -243,8 +237,9 @@ enum iser_desc_type {
  *                 unsolicited data-out or control
  * @num_sge:       number sges used on this TX task
  * @mapped:        Is the task header mapped
- * @wr_idx:        Current WR index
- * @wrs:           Array of WRs per task
+ * reg_wr:         registration WR
+ * send_wr:        send WR
+ * inv_wr:         invalidate WR
  */
 struct iser_tx_desc {
 	struct iser_ctrl             iser_header;
@@ -255,11 +250,9 @@ struct iser_tx_desc {
 	int                          num_sge;
 	struct ib_cqe		     cqe;
 	bool			     mapped;
-	u8                           wr_idx;
-	union iser_wr {
-		struct ib_send_wr		send;
-		struct ib_reg_wr		fast_reg;
-	} wrs[ISER_MAX_WRS];
+	struct ib_reg_wr	     reg_wr;
+	struct ib_send_wr	     send_wr;
+	struct ib_send_wr	     inv_wr;
 };
 
 #define ISER_RX_PAD_SIZE	(256 - (ISER_RX_PAYLOAD_SIZE + \
@@ -652,21 +645,6 @@ void
 iser_reg_desc_put_fmr(struct ib_conn *ib_conn,
 		      struct iser_fr_desc *desc);
 
-static inline struct ib_send_wr *
-iser_tx_next_wr(struct iser_tx_desc *tx_desc)
-{
-	struct ib_send_wr *cur_wr = &tx_desc->wrs[tx_desc->wr_idx].send;
-	struct ib_send_wr *last_wr;
-
-	if (tx_desc->wr_idx) {
-		last_wr = &tx_desc->wrs[tx_desc->wr_idx - 1].send;
-		last_wr->next = cur_wr;
-	}
-	tx_desc->wr_idx++;
-
-	return cur_wr;
-}
-
 static inline struct iser_conn *
 to_iser_conn(struct ib_conn *ib_conn)
 {
diff --git a/drivers/infiniband/ulp/iser/iser_memory.c b/drivers/infiniband/ulp/iser/iser_memory.c
index 51f1ebf9ed85..7b4a3a2345b1 100644
--- a/drivers/infiniband/ulp/iser/iser_memory.c
+++ b/drivers/infiniband/ulp/iser/iser_memory.c
@@ -366,13 +366,15 @@ iser_set_prot_checks(struct scsi_cmnd *sc, u8 *mask)
 static inline void
 iser_inv_rkey(struct ib_send_wr *inv_wr,
 	      struct ib_mr *mr,
-	      struct ib_cqe *cqe)
+	      struct ib_cqe *cqe,
+	      struct ib_send_wr *next_wr)
 {
 	inv_wr->opcode = IB_WR_LOCAL_INV;
 	inv_wr->wr_cqe = cqe;
 	inv_wr->ex.invalidate_rkey = mr->rkey;
 	inv_wr->send_flags = 0;
 	inv_wr->num_sge = 0;
+	inv_wr->next = next_wr;
 }
 
 static int
@@ -386,7 +388,7 @@ iser_reg_sig_mr(struct iscsi_iser_task *iser_task,
 	struct ib_cqe *cqe = &iser_task->iser_conn->ib_conn.reg_cqe;
 	struct ib_mr *mr = rsc->sig_mr;
 	struct ib_sig_attrs *sig_attrs = mr->sig_attrs;
-	struct ib_reg_wr *wr;
+	struct ib_reg_wr *wr = &tx_desc->reg_wr;
 	int ret, n;
 
 	memset(sig_attrs, 0, sizeof(*sig_attrs));
@@ -397,7 +399,7 @@ iser_reg_sig_mr(struct iscsi_iser_task *iser_task,
 	iser_set_prot_checks(iser_task->sc, &sig_attrs->check_mask);
 
 	if (rsc->mr_valid)
-		iser_inv_rkey(iser_tx_next_wr(tx_desc), mr, cqe);
+		iser_inv_rkey(&tx_desc->inv_wr, mr, cqe, &wr->wr);
 
 	ib_update_fast_reg_key(mr, ib_inc_rkey(mr->rkey));
 
@@ -409,8 +411,8 @@ iser_reg_sig_mr(struct iscsi_iser_task *iser_task,
 		return n < 0 ? n : -EINVAL;
 	}
 
-	wr = container_of(iser_tx_next_wr(tx_desc), struct ib_reg_wr, wr);
 	memset(wr, 0, sizeof(*wr));
+	wr->wr.next = &tx_desc->send_wr;
 	wr->wr.opcode = IB_WR_REG_MR_INTEGRITY;
 	wr->wr.wr_cqe = cqe;
 	wr->wr.num_sge = 0;
@@ -442,11 +444,11 @@ static int iser_fast_reg_mr(struct iscsi_iser_task *iser_task,
 	struct iser_tx_desc *tx_desc = &iser_task->desc;
 	struct ib_cqe *cqe = &iser_task->iser_conn->ib_conn.reg_cqe;
 	struct ib_mr *mr = rsc->mr;
-	struct ib_reg_wr *wr;
+	struct ib_reg_wr *wr = &tx_desc->reg_wr;
 	int n;
 
 	if (rsc->mr_valid)
-		iser_inv_rkey(iser_tx_next_wr(tx_desc), mr, cqe);
+		iser_inv_rkey(&tx_desc->inv_wr, mr, cqe, &wr->wr);
 
 	ib_update_fast_reg_key(mr, ib_inc_rkey(mr->rkey));
 
@@ -457,7 +459,7 @@ static int iser_fast_reg_mr(struct iscsi_iser_task *iser_task,
 		return n < 0 ? n : -EINVAL;
 	}
 
-	wr = container_of(iser_tx_next_wr(tx_desc), struct ib_reg_wr, wr);
+	wr->wr.next = &tx_desc->send_wr;
 	wr->wr.opcode = IB_WR_REG_MR;
 	wr->wr.wr_cqe = cqe;
 	wr->wr.send_flags = 0;
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index f7502c131b08..58dc67fe7e34 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -1054,7 +1054,8 @@ int iser_post_recvm(struct iser_conn *iser_conn, int count)
 int iser_post_send(struct ib_conn *ib_conn, struct iser_tx_desc *tx_desc,
 		   bool signal)
 {
-	struct ib_send_wr *wr = iser_tx_next_wr(tx_desc);
+	struct ib_send_wr *wr = &tx_desc->send_wr;
+	struct ib_send_wr *first_wr;
 	int ib_ret;
 
 	ib_dma_sync_single_for_device(ib_conn->device->ib_device,
@@ -1068,7 +1069,14 @@ int iser_post_send(struct ib_conn *ib_conn, struct iser_tx_desc *tx_desc,
 	wr->opcode = IB_WR_SEND;
 	wr->send_flags = signal ? IB_SEND_SIGNALED : 0;
 
-	ib_ret = ib_post_send(ib_conn->qp, &tx_desc->wrs[0].send, NULL);
+	if (tx_desc->inv_wr.next)
+		first_wr = &tx_desc->inv_wr;
+	else if (tx_desc->reg_wr.wr.next)
+		first_wr = &tx_desc->reg_wr.wr;
+	else
+		first_wr = wr;
+
+	ib_ret = ib_post_send(ib_conn->qp, first_wr, NULL);
 	if (ib_ret)
 		iser_err("ib_post_send failed, ret:%d opcode:%d\n",
 			 ib_ret, wr->opcode);
-- 
2.16.3

