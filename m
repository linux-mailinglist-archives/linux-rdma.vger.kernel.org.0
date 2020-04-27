Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BAC1BA8BC
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 17:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgD0PsH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 11:48:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728125AbgD0PsG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 11:48:06 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2294E206D4;
        Mon, 27 Apr 2020 15:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588002485;
        bh=xYw33RJEn0CXQ1KibvKFD+fKxRJ4shfPg8cXKtyw8OY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mIexS//9aizXjpbkFL2bn387zBuETJ10oFJb/sZr3Zl4ZwAKRpF4f1eBv7j9NYn/S
         mmDSJKX9Oom/m78ArdKZhMw4nmSrOjw6URhpoz7/+QPHr6dSuqkt3Mq9qTpPkp3fxQ
         ZSQ1efSd4gD4Wn1pVzhqvRXl+bbAm08px25nHQ8g=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aharon Landau <aharonl@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 23/36] RDMA/mlx5: Remove second user copy in create_user_qp
Date:   Mon, 27 Apr 2020 18:46:23 +0300
Message-Id: <20200427154636.381474-24-leon@kernel.org>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200427154636.381474-1-leon@kernel.org>
References: <20200427154636.381474-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Combine copy_from_user() from create_user_qp() and general code.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 34 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 4f69105f082b..495f03905fbf 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -914,13 +914,12 @@ static int adjust_bfregn(struct mlx5_ib_dev *dev,
 
 static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			  struct mlx5_ib_qp *qp, struct ib_udata *udata,
-			  struct ib_qp_init_attr *attr,
-			  u32 **in,
+			  struct ib_qp_init_attr *attr, u32 **in,
 			  struct mlx5_ib_create_qp_resp *resp, int *inlen,
-			  struct mlx5_ib_qp_base *base)
+			  struct mlx5_ib_qp_base *base,
+			  struct mlx5_ib_create_qp *ucmd)
 {
 	struct mlx5_ib_ucontext *context;
-	struct mlx5_ib_create_qp ucmd;
 	struct mlx5_ib_ubuffer *ubuffer = &base->ubuffer;
 	int page_shift = 0;
 	int uar_index = 0;
@@ -934,24 +933,18 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	u16 uid;
 	u32 uar_flags;
 
-	err = ib_copy_from_udata(&ucmd, udata, sizeof(ucmd));
-	if (err) {
-		mlx5_ib_dbg(dev, "copy failed\n");
-		return err;
-	}
-
 	context = rdma_udata_to_drv_context(udata, struct mlx5_ib_ucontext,
 					    ibucontext);
-	uar_flags = ucmd.flags & (MLX5_QP_FLAG_UAR_PAGE_INDEX |
-				  MLX5_QP_FLAG_BFREG_INDEX);
+	uar_flags = qp->flags_en &
+		    (MLX5_QP_FLAG_UAR_PAGE_INDEX | MLX5_QP_FLAG_BFREG_INDEX);
 	switch (uar_flags) {
 	case MLX5_QP_FLAG_UAR_PAGE_INDEX:
-		uar_index = ucmd.bfreg_index;
+		uar_index = ucmd->bfreg_index;
 		bfregn = MLX5_IB_INVALID_BFREG;
 		break;
 	case MLX5_QP_FLAG_BFREG_INDEX:
 		uar_index = bfregn_to_uar_index(dev, &context->bfregi,
-						ucmd.bfreg_index, true);
+						ucmd->bfreg_index, true);
 		if (uar_index < 0)
 			return uar_index;
 		bfregn = MLX5_IB_INVALID_BFREG;
@@ -976,12 +969,12 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	qp->sq.wqe_shift = ilog2(MLX5_SEND_WQE_BB);
 	qp->sq.offset = qp->rq.wqe_cnt << qp->rq.wqe_shift;
 
-	err = set_user_buf_size(dev, qp, &ucmd, base, attr);
+	err = set_user_buf_size(dev, qp, ucmd, base, attr);
 	if (err)
 		goto err_bfreg;
 
-	if (ucmd.buf_addr && ubuffer->buf_size) {
-		ubuffer->buf_addr = ucmd.buf_addr;
+	if (ucmd->buf_addr && ubuffer->buf_size) {
+		ubuffer->buf_addr = ucmd->buf_addr;
 		err = mlx5_ib_umem_get(dev, udata, ubuffer->buf_addr,
 				       ubuffer->buf_size, &ubuffer->umem,
 				       &npages, &page_shift, &ncont, &offset);
@@ -1018,7 +1011,7 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		resp->bfreg_index = MLX5_IB_INVALID_BFREG;
 	qp->bfregn = bfregn;
 
-	err = mlx5_ib_db_map_user(context, udata, ucmd.db_addr, &qp->db);
+	err = mlx5_ib_db_map_user(context, udata, ucmd->db_addr, &qp->db);
 	if (err) {
 		mlx5_ib_dbg(dev, "map failed\n");
 		goto err_free;
@@ -1991,7 +1984,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 				return -EINVAL;
 			}
 			err = create_user_qp(dev, pd, qp, udata, init_attr, &in,
-					     &resp, &inlen, base);
+					     &resp, &inlen, base, ucmd);
 			if (err)
 				mlx5_ib_dbg(dev, "err %d\n", err);
 		} else {
@@ -2550,6 +2543,9 @@ static int process_vendor_flags(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 				    MLX5_QP_FLAG_PACKET_BASED_CREDIT_MODE,
 				    MLX5_CAP_GEN(mdev, qp_packet_based), qp);
 
+	process_vendor_flag(dev, &flags, MLX5_QP_FLAG_BFREG_INDEX, true, qp);
+	process_vendor_flag(dev, &flags, MLX5_QP_FLAG_UAR_PAGE_INDEX, true, qp);
+
 	if (flags)
 		mlx5_ib_dbg(dev, "udata has unsupported flags 0x%X\n", flags);
 
-- 
2.25.3

