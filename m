Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFBA1FCE02
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 15:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgFQNBy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 09:01:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgFQNBx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Jun 2020 09:01:53 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40C8C20786;
        Wed, 17 Jun 2020 13:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592398912;
        bh=aYt6lYGBqo3gIlAbTQXD0FeOI5o8Yi0lSYsLL0NEQM4=;
        h=From:To:Cc:Subject:Date:From;
        b=pCyS0vBU03mrnbBvAX3exEjpkH+zXhsbrCxdfx1l+jaYT12WfCAqMqKnmD342Nq3K
         KMpr64CF0L3cKsLYrDOuhW0eYE0pR1hp4MMovtJm1fnasNrTug0koh0Q/R0fhWpyQp
         jeFEQP61tDqmtq9JilAgzsBYTsy5C4DckDAsgdLw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Don't access ib_qp fields in internal destroy QP path
Date:   Wed, 17 Jun 2020 16:01:48 +0300
Message-Id: <20200617130148.2846643-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

destroy_qp_common is called for flows where QP is already created
by HW. While it is called from IB/core, the ibqp.* fields will be
fully initialized, but it is not the case if this function is called
during QP creation.

Don't rely on ibqp fields as much as possible and initialize
send_cq/recv_cq as temporal solution till all drivers will be
converted to IB/core QP allocation scheme.

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 5372 at lib/refcount.c:28 refcount_warn_saturate+0xfe/0x1a0
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 5372 Comm: syz-executor.2 Not tainted 5.5.0-rc5 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
Call Trace:
 dump_stack+0x94/0xce
 panic+0x234/0x56f
 __warn+0x1cc/0x1e1
 ? refcount_warn_saturate+0xfe/mlx: ERR-GENERAL [mlx5/mlx5_cmdif_cq.c:213] mlx5/mlx5_cmdif_cq.c:213:mlx5_opcode_CREATE_CQ: assertion failed (MLX5_ST_SZ_BYTES(create_cq_in) + (npas * MLX5_PHYSICAL_ADDRESS_SIZE) == in_size): (0x00000118 == 0x00000120)
 report_bug+0x200/0x310
 fixup_bug.part.11+0x32/0x80
 do_error_trap+0xd3/0x100
 do_invalid_op+0x31/0x40
 invalid_op+0mlx: ERR-GENERAL [mlx5/mlx5_cmdif_cq.c:213] mlx5/mlx5_cmdif_cq.c:213:mlx5_opcode_CREATE_CQ: assertion failed (MLX5_ST_SZ_BYTES(create_cq_in) + (npas * MLX5_PHYSICAL_ADDRESS_SIZE) == in_size): (0x00000118 == 0x00000120)
RIP: 0010:refcount_warn_saturate+0xfe/0x1a0
Code: 0f 0b eb 9b e8 53 e2 6d ff 80 3d 8c c6 39 03 00 75 8d e8 45 e2 6d ff 48 c7 c7 80 07 15 84 c6 05 77 c6 39 03 01 e8 b2 44 49 ff <0f> 0b e9 6e ff ff ff e8 26 e2 6d ff 80 3d 62 c6 39 03 00 0f 85 5c
RSP: 0018:ffffc9000b5976f0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88811478f134 RCX: ffffffff81248f69
RDX: 0000000000015258 RSI: ffffc900022b1000 RDI: ffff88811b1283cc
RBP: 0000000000000003 R08: ffffed10236260e3 R09: ffffed10236260e3
R13: 0000000000000246 R14: 0000000000000000 R15: 0000000000000000
 mlx5_core_put_rsc+0x70/0x80
 destroy_resource_common+0x8e/0xb0
 mlx5_core_destroy_qp+0xaf/0x1d0
 mlx5_ib_destroy_qp+0xeb0/0x1460
 ib_destroy_qp_user+0x2d5/0x7d0
 create_qp+0xed3/0x2130
 ib_uverbs_create_qp+0x13e/0x190
 ? ib_uverbs_ex_create_qp+0mlx: ERR-GENERAL [mlx5/mlx5_cmdif_cq.c:213] mlx5/mlx5_cmdif_cq.c:213:mlx5_opcode_CREATE_CQ: assertion failed (MLX5_ST_SZ_BYTES(create_cq_in) + (npas * MLX5_PHYSICAL_ADDRESS_SIZE) == in_size): (0x00000118 == 0x00000120)
 ib_uverbs_write+0xaa5/0xdf0
 __vfs_write+0x7c/0x100
 ksys_write+0xc8/0x200
 do_syscall_64+0x9c/0x390
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x465b49
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 mlx: ERR-GENERAL [mlx5/mlx5_cmdif_cq.c:213] mlx5/mlx5_cmdif_cq.c:213:mlx5_opcode_CREATE_CQ: assertion failed (MLX5_ST_SZ_BYTES(create_cq_in) + (npas * MLX5_PHYSICAL_ADDRESS_SIZE) == in_size): (0x00000118 == 0x00000120)
RSP: 002b:00007f0984e16c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000073bf00 RCX: 0000000000465b49
RDX: 0000000000000068 RSI: 0000000020000380 RDI: 0000000000000004
RBP: 00007f0984e16c70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0984e176bc
R13: 00000000004ca2ec R14: 000000000070ded0 R15: 0000000000000008
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled

Fixes: 08d53976609a ("RDMA/mlx5: Copy response to the user in one place")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 805d1c03938d..aff412b513ae 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2341,18 +2341,18 @@ static void destroy_qp_common(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	unsigned long flags;
 	int err;

-	if (qp->ibqp.rwq_ind_tbl) {
+	if (qp->is_rss) {
 		destroy_rss_raw_qp_tir(dev, qp);
 		return;
 	}

-	base = (qp->ibqp.qp_type == IB_QPT_RAW_PACKET ||
+	base = (qp->type == IB_QPT_RAW_PACKET ||
 		qp->flags & IB_QP_CREATE_SOURCE_QPN) ?
-	       &qp->raw_packet_qp.rq.base :
-	       &qp->trans_qp.base;
+		       &qp->raw_packet_qp.rq.base :
+		       &qp->trans_qp.base;

 	if (qp->state != IB_QPS_RESET) {
-		if (qp->ibqp.qp_type != IB_QPT_RAW_PACKET &&
+		if (qp->type != IB_QPT_RAW_PACKET &&
 		    !(qp->flags & IB_QP_CREATE_SOURCE_QPN)) {
 			err = mlx5_core_qp_modify(dev, MLX5_CMD_OP_2RST_QP, 0,
 						  NULL, &base->mqp, NULL);
@@ -2368,8 +2368,8 @@ static void destroy_qp_common(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 				     base->mqp.qpn);
 	}

-	get_cqs(qp->ibqp.qp_type, qp->ibqp.send_cq, qp->ibqp.recv_cq,
-		&send_cq, &recv_cq);
+	get_cqs(qp->type, qp->ibqp.send_cq, qp->ibqp.recv_cq, &send_cq,
+		&recv_cq);

 	spin_lock_irqsave(&dev->reset_flow_resource_lock, flags);
 	mlx5_ib_lock_cqs(send_cq, recv_cq);
@@ -2391,7 +2391,7 @@ static void destroy_qp_common(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	mlx5_ib_unlock_cqs(send_cq, recv_cq);
 	spin_unlock_irqrestore(&dev->reset_flow_resource_lock, flags);

-	if (qp->ibqp.qp_type == IB_QPT_RAW_PACKET ||
+	if (qp->type == IB_QPT_RAW_PACKET ||
 	    qp->flags & IB_QP_CREATE_SOURCE_QPN) {
 		destroy_raw_packet_qp(dev, qp);
 	} else {
@@ -3002,10 +3002,18 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd, struct ib_qp_init_attr *attr,
 	return &qp->ibqp;

 destroy_qp:
-	if (qp->type == MLX5_IB_QPT_DCT)
+	if (qp->type == MLX5_IB_QPT_DCT) {
 		mlx5_ib_destroy_dct(qp);
-	else
+	} else {
+		/*
+		 * The two lines below are temp solution till QP allocation
+		 * will be moved to be under IB/core responsiblity.
+		 */
+		qp->ibqp.send_cq = attr->send_cq;
+		qp->ibqp.recv_cq = attr->recv_cq;
 		destroy_qp_common(dev, qp, udata);
+	}
+
 	qp = NULL;
 free_qp:
 	kfree(qp);
--
2.26.2

