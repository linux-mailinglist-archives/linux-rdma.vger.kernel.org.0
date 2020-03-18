Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 820B71897C5
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 10:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgCRJRC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 05:17:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgCRJRC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Mar 2020 05:17:02 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 732F32076D;
        Wed, 18 Mar 2020 09:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584523021;
        bh=Wwb560/aFMVajFF172zHTmlWXSAMVE9BuOx9pxY4CBw=;
        h=From:To:Cc:Subject:Date:From;
        b=ExIWDFiyJFa4Klf7CH5QxLUSG3DCXDEvhVKmDV3CpJRBDXCFrXGUFyt638IEo4V6J
         xQ5aIUhd5zEwpPaw+hR9HoA3M3tB3EKrTyNM+Eff5dBEoACx5BcI+mBw3tqg3I1UOp
         1LvUc8wwy5zC5yWKdAH3ON9Gkgr7I7ULh+ijzK88=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] RDMA/mlx5: Fix access to wrong pointer while performing flush due to error
Date:   Wed, 18 Mar 2020 11:16:40 +0200
Message-Id: <20200318091640.44069-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The main difference between send and receive SW completions is related
to separate treatment of WQ queue. For receive completions, the initial
index to be flushed is stored in "tail", while for send completions, it
is in deleted "last_poll".

[62954.657039] CPU: 54 PID: 53405 Comm: kworker/u161:0 Kdump: loaded Tainted: G           OE    --------- -t - 4.18.0-147.el8.ppc64le #1
[62954.657170] Workqueue: ib-comp-unb-wq ib_cq_poll_work [ib_core]
[62954.657234] NIP:  c000003c7c00a000 LR: c00800000e586af4 CTR: c000003c7c00a000
[62954.657307] REGS: c0000036cc9db940 TRAP: 0400   Tainted: G           OE    --------- -t -  (4.18.0-147.el8.ppc64le)
[62954.657403] MSR:  9000000010009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 24004488  XER: 20040000
[62954.657481] CFAR: c00800000e586af0 IRQMASK: 0
GPR00: c00800000e586ab4 c0000036cc9dbbc0 c00800000e5f1a00 c0000037d8433800
GPR04: c000003895a26800 c0000037293f2000 0000000000000201 0000000000000011
GPR08: c000003895a26c80 c000003c7c00a000 0000000000000000 c00800000ed30438
GPR12: c000003c7c00a000 c000003fff684b80 c00000000017c388 c00000396ec4be40
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR20: c00000000151e498 0000000000000010 c000003895a26848 0000000000000010
GPR24: 0000000000000010 0000000000010000 c000003895a26800 0000000000000000
GPR28: 0000000000000010 c0000037d8433800 c000003895a26c80 c000003895a26800
[62954.658513] NIP [c000003c7c00a000] 0xc000003c7c00a000
[62954.658634] LR [c00800000e586af4] __ib_process_cq+0xec/0x1b0 [ib_core]
[62954.658750] Call Trace:
[62954.658806] [c0000036cc9dbbc0] [c00800000e586ab4] __ib_process_cq+0xac/0x1b0 [ib_core] (unreliable)
[62954.658974] [c0000036cc9dbc40] [c00800000e586c88] ib_cq_poll_work+0x40/0xb0 [ib_core]
[62954.659114] [c0000036cc9dbc70] [c000000000171f44] process_one_work+0x2f4/0x5c0
[62954.659256] [c0000036cc9dbd10] [c000000000172a0c] worker_thread+0xcc/0x760
[62954.659388] [c0000036cc9dbdc0] [c00000000017c52c] kthread+0x1ac/0x1c0
[62954.659521] [c0000036cc9dbe30] [c00000000000b75c] ret_from_kernel_thread+0x5c/0x80
[62954.659660] Instruction dump:
[62954.659735] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
[62954.659886] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
[62954.660040] ---[ end trace cece1d14044f024d ]---
[62954.678250]
[62954.678335] Sending IPI to other CPUs
[62955.479581] IPI complete

Fixes: 8e3b68830186 ("RDMA/mlx5: Delete unreachable handle_atomic code by simplifying SW completion")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/cq.c      | 27 +++++++++++++++++++++++++--
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
 drivers/infiniband/hw/mlx5/qp.c      |  1 +
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 367a71bc5f4b..3dec3de903b7 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -330,6 +330,22 @@ static void mlx5_handle_error_cqe(struct mlx5_ib_dev *dev,
 		dump_cqe(dev, cqe);
 }

+static void handle_atomics(struct mlx5_ib_qp *qp, struct mlx5_cqe64 *cqe64,
+			   u16 tail, u16 head)
+{
+	u16 idx;
+
+	do {
+		idx = tail & (qp->sq.wqe_cnt - 1);
+		if (idx == head)
+			break;
+
+		tail = qp->sq.w_list[idx].next;
+	} while (1);
+	tail = qp->sq.w_list[idx].next;
+	qp->sq.last_poll = tail;
+}
+
 static void free_cq_buf(struct mlx5_ib_dev *dev, struct mlx5_ib_cq_buf *buf)
 {
 	mlx5_frag_buf_free(dev->mdev, &buf->frag_buf);
@@ -368,7 +384,7 @@ static void get_sig_err_item(struct mlx5_sig_err_cqe *cqe,
 }

 static void sw_comp(struct mlx5_ib_qp *qp, int num_entries, struct ib_wc *wc,
-		    int *npolled, int is_send)
+		    int *npolled, bool is_send)
 {
 	struct mlx5_ib_wq *wq;
 	unsigned int cur;
@@ -383,10 +399,16 @@ static void sw_comp(struct mlx5_ib_qp *qp, int num_entries, struct ib_wc *wc,
 		return;

 	for (i = 0;  i < cur && np < num_entries; i++) {
-		wc->wr_id = wq->wrid[wq->tail & (wq->wqe_cnt - 1)];
+		unsigned int idx;
+
+		idx = (is_send) ? wq->last_poll : wq->tail;
+		idx &= (wq->wqe_cnt - 1);
+		wc->wr_id = wq->wrid[idx];
 		wc->status = IB_WC_WR_FLUSH_ERR;
 		wc->vendor_err = MLX5_CQE_SYNDROME_WR_FLUSH_ERR;
 		wq->tail++;
+		if (is_send)
+			wq->last_poll = wq->w_list[idx].next;
 		np++;
 		wc->qp = &qp->ibqp;
 		wc++;
@@ -473,6 +495,7 @@ static int mlx5_poll_one(struct mlx5_ib_cq *cq,
 		wqe_ctr = be16_to_cpu(cqe64->wqe_counter);
 		idx = wqe_ctr & (wq->wqe_cnt - 1);
 		handle_good_req(wc, cqe64, wq, idx);
+		handle_atomics(*cur_qp, cqe64, wq->last_poll, idx);
 		wc->wr_id = wq->wrid[idx];
 		wq->tail = wq->wqe_head[idx] + 1;
 		wc->status = IB_WC_SUCCESS;
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 2be773a24dda..1263e216834f 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -287,6 +287,7 @@ struct mlx5_ib_wq {
 	unsigned		head;
 	unsigned		tail;
 	u16			cur_post;
+	u16			last_poll;
 	void			*cur_edge;
 };

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 7b4e936ad210..cc10b6021c6f 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3775,6 +3775,7 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 		qp->sq.cur_post = 0;
 		if (qp->sq.wqe_cnt)
 			qp->sq.cur_edge = get_sq_edge(&qp->sq, 0);
+		qp->sq.last_poll = 0;
 		qp->db.db[MLX5_RCV_DBR] = 0;
 		qp->db.db[MLX5_SND_DBR] = 0;
 	}
--
2.24.1

