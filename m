Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E028A3DF48A
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Aug 2021 20:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbhHCSU7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 14:20:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239000AbhHCSU6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Aug 2021 14:20:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2102C61029;
        Tue,  3 Aug 2021 18:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628014846;
        bh=Mq9Lyit/rS/pWQeUYyPnS73CPPvgoNfWe3rE8aWTde8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qssHuvbxkZz67iFE6H3EkHR1h7VTJprgfomAglNba1QU66UVUotLhjWwnqqD5Qdhx
         e/Z4TEUmxNecRHl/3kw/g6fKv2v7vpUmGUPbS3hwMcadyvUzOPJA9JB2dU5PYIyzVo
         qXnVD/9Mvl2h6PJMGnqBXPXWuspIUu5Csv30WgTmtxNGyDik9YLES6GD2XRiCeYK9O
         IkS8h97v6duE/Ni75qUzAN1IjocwJpf6fMI/zqvO3Oy8abC5XazXbwfRveSzTzWtOB
         D1Kbw7E8SJ/M1mZwLvRfuBBntnCUNSufGwSHmL5WZj4MgEaG6x/mOPGRUrlJ7NaUNy
         7Q5zx7ryCiyKA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next v2 1/7] RDMA/mlx5: Delete not-available udata check
Date:   Tue,  3 Aug 2021 21:20:32 +0300
Message-Id: <b68228597e730675020aa5162745390a2d39d3a2.1628014762.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628014762.git.leonro@nvidia.com>
References: <cover.1628014762.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

XRC_TGT QPs are created through kernel verbs and don't have udata at all.

Fixes: 6eefa839c4dd ("RDMA/mlx5: Protect from kernel crash if XRC_TGT doesn't have udata")
Fixes: e383085c2425 ("RDMA/mlx5: Set ECE options during QP create")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 9d20c838974f..556b5e7acd46 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1906,7 +1906,6 @@ static int get_atomic_mode(struct mlx5_ib_dev *dev,
 static int create_xrc_tgt_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 			     struct mlx5_create_qp_params *params)
 {
-	struct mlx5_ib_create_qp *ucmd = params->ucmd;
 	struct ib_qp_init_attr *attr = params->attr;
 	u32 uidx = params->uidx;
 	struct mlx5_ib_resources *devr = &dev->devr;
@@ -1926,8 +1925,6 @@ static int create_xrc_tgt_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	if (!in)
 		return -ENOMEM;
 
-	if (MLX5_CAP_GEN(mdev, ece_support) && ucmd)
-		MLX5_SET(create_qp_in, in, ece, ucmd->ece_options);
 	qpc = MLX5_ADDR_OF(create_qp_in, in, qpc);
 
 	MLX5_SET(qpc, qpc, st, MLX5_QP_ST_XRC);
-- 
2.31.1

