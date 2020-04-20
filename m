Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E35C1B0F69
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2020 17:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgDTPLd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Apr 2020 11:11:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbgDTPLd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Apr 2020 11:11:33 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CBB720775;
        Mon, 20 Apr 2020 15:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587395492;
        bh=8A+gTFQUza7i9c+hxdn8MnmOYsgzis0HjMpoQnvzfyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=duA892+4p656BXXye/oL7nBefioRpZ1MUwfaAmTRNsbHsaNB6MHju8P0QVB9GTtxT
         fXCc3jEsQ+Z/ZPddd0I1DyVw5sRJAEWaXOowPiIF7x6udEAqeBmW/NjbsgP1f7ONYA
         EMg0YqUpv7qQKKhic8YDSZHjYe/jvuzfWYbAmEBw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 06/18] RDMA/mlx5: Set QP subtype immediately when it is known
Date:   Mon, 20 Apr 2020 18:10:53 +0300
Message-Id: <20200420151105.282848-7-leon@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200420151105.282848-1-leon@kernel.org>
References: <20200420151105.282848-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

There is no need to delay QP subtype assignment to the end of the
create_qp() function and it is better to move it to be immediately
after it is checked so we would be able to rewrite later checks
to be based on it and not on over-written struct ib_qp_init_attr.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 2039f5391e20..35308e7ae312 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2581,7 +2581,6 @@ static struct ib_qp *mlx5_ib_create_dct(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 
 	MLX5_SET(create_dct_in, qp->dct.in, uid, to_mpd(pd)->uid);
 	dctc = MLX5_ADDR_OF(create_dct_in, qp->dct.in, dct_context_entry);
-	qp->qp_sub_type = MLX5_IB_QPT_DCT;
 	MLX5_SET(dctc, dctc, pd, to_mpd(pd)->pdn);
 	MLX5_SET(dctc, dctc, srqn_xrqn, to_msrq(attr->srq)->msrq.srqn);
 	MLX5_SET(dctc, dctc, cqn, to_mcq(attr->recv_cq)->mcq.cqn);
@@ -2765,7 +2764,9 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 				err = -EINVAL;
 				goto free_qp;
 			}
+			qp->qp_sub_type = MLX5_IB_QPT_DCI;
 		} else {
+			qp->qp_sub_type = MLX5_IB_QPT_DCT;
 			return mlx5_ib_create_dct(pd, qp, init_attr, &ucmd,
 						  udata);
 		}
@@ -2789,9 +2790,6 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 
 	qp->trans_qp.xrcdn = xrcdn;
 
-	if (verbs_init_attr->qp_type == IB_QPT_DRIVER)
-		qp->qp_sub_type = init_attr->qp_type;
-
 	return &qp->ibqp;
 
 free_qp:
-- 
2.25.2

