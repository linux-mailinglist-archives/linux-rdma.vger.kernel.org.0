Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2544298DCB
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 14:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1769952AbgJZN07 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 09:26:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1769503AbgJZN07 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Oct 2020 09:26:59 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DF01207DE;
        Mon, 26 Oct 2020 13:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603718818;
        bh=f+uVVFd3zcR7a4hBnacbpHdMLiHyJJosZLqwjZ0dfhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aEgG/RUTabWAyPZNVpdgKD7m+MWkpemPIWFxem+6QmssYmXynXxbWq8uIA80YV9Cp
         Zu8vGS0sHSAqX4CQHJI2N8N9VyypNXhubGwuAEhcmyKiPpZG5afQ/JjnQ7tgmlsWP+
         uCh/Gjz04lEhbxB70/dOYDekbWS5xdsJF58uPFUA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Haggai Abramonvsky <hagaya@mellanox.com>,
        linux-rdma@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>
Subject: [PATCH rdma-next 6/6] RDMA/mlx5: Lower setting the umem's PAS for SRQ
Date:   Mon, 26 Oct 2020 15:26:35 +0200
Message-Id: <20201026132635.1337663-7-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026132635.1337663-1-leon@kernel.org>
References: <20201026132635.1337663-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Some of the SRQ types are created using a WQ, and the WQ requires a
different parameter set to mlx5_umem_find_best_quantized_pgoff() as it has
a 5 bit page_offset.

Add the umem to the mlx5_srq_attr and defer computing the PAS data until
the code has figured out what kind of mailbox to use. Compute the PAS
directly from the umem for each of the four unique mailbox types.

This also avoids allocating memory to store the user PAS, instead it is
written directly to the mailbox as in most other cases.

Fixes: 01949d0109ee ("net/mlx5_core: Enable XRCs and SRQs when using ISSI > 0")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/srq.c     | 27 +---------
 drivers/infiniband/hw/mlx5/srq.h     |  1 +
 drivers/infiniband/hw/mlx5/srq_cmd.c | 80 ++++++++++++++++++++++++++--
 3 files changed, 79 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index 898a6cac023a..89494114ee56 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -51,8 +51,6 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 		udata, struct mlx5_ib_ucontext, ibucontext);
 	size_t ucmdlen;
 	int err;
-	unsigned int page_offset_quantized;
-	unsigned int page_size;
 	u32 uidx = MLX5_IB_DEFAULT_UIDX;
 
 	ucmdlen = min(udata->inlen, sizeof(ucmd));
@@ -84,32 +82,14 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 		err = PTR_ERR(srq->umem);
 		return err;
 	}
-
-	page_size = mlx5_umem_find_best_quantized_pgoff(
-		srq->umem, srqc, log_page_size, MLX5_ADAPTER_PAGE_SHIFT,
-		page_offset, 64, &page_offset_quantized);
-	if (!page_size) {
-		mlx5_ib_warn(dev, "bad offset\n");
-		goto err_umem;
-	}
-
-	in->pas = kvcalloc(ib_umem_num_dma_blocks(srq->umem, page_size),
-			   sizeof(*in->pas), GFP_KERNEL);
-	if (!in->pas) {
-		err = -ENOMEM;
-		goto err_umem;
-	}
-
-	mlx5_ib_populate_pas(srq->umem, page_size, in->pas, 0);
+	in->umem = srq->umem;
 
 	err = mlx5_ib_db_map_user(ucontext, udata, ucmd.db_addr, &srq->db);
 	if (err) {
 		mlx5_ib_dbg(dev, "map doorbell failed\n");
-		goto err_in;
+		goto err_umem;
 	}
 
-	in->log_page_size = order_base_2(page_size) - MLX5_ADAPTER_PAGE_SHIFT;
-	in->page_offset = page_offset_quantized;
 	in->uid = (in->type != IB_SRQT_XRC) ?  to_mpd(pd)->uid : 0;
 	if (MLX5_CAP_GEN(dev->mdev, cqe_version) == MLX5_CQE_VERSION_V1 &&
 	    in->type != IB_SRQT_BASIC)
@@ -117,9 +97,6 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 
 	return 0;
 
-err_in:
-	kvfree(in->pas);
-
 err_umem:
 	ib_umem_release(srq->umem);
 
diff --git a/drivers/infiniband/hw/mlx5/srq.h b/drivers/infiniband/hw/mlx5/srq.h
index 2c3627b2509d..a7e3dc5564ac 100644
--- a/drivers/infiniband/hw/mlx5/srq.h
+++ b/drivers/infiniband/hw/mlx5/srq.h
@@ -28,6 +28,7 @@ struct mlx5_srq_attr {
 	u32 user_index;
 	u64 db_record;
 	__be64 *pas;
+	struct ib_umem *umem;
 	u32 tm_log_list_size;
 	u32 tm_next_tag;
 	u32 tm_hw_phase_cnt;
diff --git a/drivers/infiniband/hw/mlx5/srq_cmd.c b/drivers/infiniband/hw/mlx5/srq_cmd.c
index db889ec3fd48..8b3385396599 100644
--- a/drivers/infiniband/hw/mlx5/srq_cmd.c
+++ b/drivers/infiniband/hw/mlx5/srq_cmd.c
@@ -92,6 +92,25 @@ struct mlx5_core_srq *mlx5_cmd_get_srq(struct mlx5_ib_dev *dev, u32 srqn)
 	return srq;
 }
 
+static int __set_srq_page_size(struct mlx5_srq_attr *in,
+			       unsigned long page_size)
+{
+	if (!page_size)
+		return -EINVAL;
+	in->log_page_size = order_base_2(page_size) - MLX5_ADAPTER_PAGE_SHIFT;
+
+	if (WARN_ON(get_pas_size(in) !=
+		    ib_umem_num_dma_blocks(in->umem, page_size) * sizeof(u64)))
+		return -EINVAL;
+	return 0;
+}
+
+#define set_srq_page_size(in, typ, log_pgsz_fld)                               \
+	__set_srq_page_size(in, mlx5_umem_find_best_quantized_pgoff(           \
+					(in)->umem, typ, log_pgsz_fld,         \
+					MLX5_ADAPTER_PAGE_SHIFT, page_offset,  \
+					64, &(in)->page_offset))
+
 static int create_srq_cmd(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
 			  struct mlx5_srq_attr *in)
 {
@@ -103,6 +122,12 @@ static int create_srq_cmd(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
 	int inlen;
 	int err;
 
+	if (in->umem) {
+		err = set_srq_page_size(in, srqc, log_page_size);
+		if (err)
+			return err;
+	}
+
 	pas_size  = get_pas_size(in);
 	inlen	  = MLX5_ST_SZ_BYTES(create_srq_in) + pas_size;
 	create_in = kvzalloc(inlen, GFP_KERNEL);
@@ -114,7 +139,13 @@ static int create_srq_cmd(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
 	pas = MLX5_ADDR_OF(create_srq_in, create_in, pas);
 
 	set_srqc(srqc, in);
-	memcpy(pas, in->pas, pas_size);
+	if (in->umem)
+		mlx5_ib_populate_pas(
+			in->umem,
+			1UL << (in->log_page_size + MLX5_ADAPTER_PAGE_SHIFT),
+			pas, 0);
+	else
+		memcpy(pas, in->pas, pas_size);
 
 	MLX5_SET(create_srq_in, create_in, opcode,
 		 MLX5_CMD_OP_CREATE_SRQ);
@@ -194,6 +225,12 @@ static int create_xrc_srq_cmd(struct mlx5_ib_dev *dev,
 	int inlen;
 	int err;
 
+	if (in->umem) {
+		err = set_srq_page_size(in, xrc_srqc, log_page_size);
+		if (err)
+			return err;
+	}
+
 	pas_size  = get_pas_size(in);
 	inlen	  = MLX5_ST_SZ_BYTES(create_xrc_srq_in) + pas_size;
 	create_in = kvzalloc(inlen, GFP_KERNEL);
@@ -207,7 +244,13 @@ static int create_xrc_srq_cmd(struct mlx5_ib_dev *dev,
 
 	set_srqc(xrc_srqc, in);
 	MLX5_SET(xrc_srqc, xrc_srqc, user_index, in->user_index);
-	memcpy(pas, in->pas, pas_size);
+	if (in->umem)
+		mlx5_ib_populate_pas(
+			in->umem,
+			1UL << (in->log_page_size + MLX5_ADAPTER_PAGE_SHIFT),
+			pas, 0);
+	else
+		memcpy(pas, in->pas, pas_size);
 	MLX5_SET(create_xrc_srq_in, create_in, opcode,
 		 MLX5_CMD_OP_CREATE_XRC_SRQ);
 
@@ -289,11 +332,18 @@ static int create_rmp_cmd(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
 	void *create_in = NULL;
 	void *rmpc;
 	void *wq;
+	void *pas;
 	int pas_size;
 	int outlen;
 	int inlen;
 	int err;
 
+	if (in->umem) {
+		err = set_srq_page_size(in, wq, log_wq_pg_sz);
+		if (err)
+			return err;
+	}
+
 	pas_size = get_pas_size(in);
 	inlen = MLX5_ST_SZ_BYTES(create_rmp_in) + pas_size;
 	outlen = MLX5_ST_SZ_BYTES(create_rmp_out);
@@ -309,8 +359,16 @@ static int create_rmp_cmd(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
 
 	MLX5_SET(rmpc, rmpc, state, MLX5_RMPC_STATE_RDY);
 	MLX5_SET(create_rmp_in, create_in, uid, in->uid);
+	pas = MLX5_ADDR_OF(rmpc, rmpc, wq.pas);
+
 	set_wq(wq, in);
-	memcpy(MLX5_ADDR_OF(rmpc, rmpc, wq.pas), in->pas, pas_size);
+	if (in->umem)
+		mlx5_ib_populate_pas(
+			in->umem,
+			1UL << (in->log_page_size + MLX5_ADAPTER_PAGE_SHIFT),
+			pas, 0);
+	else
+		memcpy(pas, in->pas, pas_size);
 
 	MLX5_SET(create_rmp_in, create_in, opcode, MLX5_CMD_OP_CREATE_RMP);
 	err = mlx5_cmd_exec(dev->mdev, create_in, inlen, create_out, outlen);
@@ -421,10 +479,17 @@ static int create_xrq_cmd(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
 	void *create_in;
 	void *xrqc;
 	void *wq;
+	void *pas;
 	int pas_size;
 	int inlen;
 	int err;
 
+	if (in->umem) {
+		err = set_srq_page_size(in, wq, log_wq_pg_sz);
+		if (err)
+			return err;
+	}
+
 	pas_size = get_pas_size(in);
 	inlen = MLX5_ST_SZ_BYTES(create_xrq_in) + pas_size;
 	create_in = kvzalloc(inlen, GFP_KERNEL);
@@ -433,9 +498,16 @@ static int create_xrq_cmd(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
 
 	xrqc = MLX5_ADDR_OF(create_xrq_in, create_in, xrq_context);
 	wq = MLX5_ADDR_OF(xrqc, xrqc, wq);
+	pas = MLX5_ADDR_OF(xrqc, xrqc, wq.pas);
 
 	set_wq(wq, in);
-	memcpy(MLX5_ADDR_OF(xrqc, xrqc, wq.pas), in->pas, pas_size);
+	if (in->umem)
+		mlx5_ib_populate_pas(
+			in->umem,
+			1UL << (in->log_page_size + MLX5_ADAPTER_PAGE_SHIFT),
+			pas, 0);
+	else
+		memcpy(pas, in->pas, pas_size);
 
 	if (in->type == IB_SRQT_TM) {
 		MLX5_SET(xrqc, xrqc, topology, MLX5_XRQC_TOPOLOGY_TAG_MATCHING);
-- 
2.26.2

