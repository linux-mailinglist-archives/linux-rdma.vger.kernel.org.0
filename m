Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3151B6437
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 21:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgDWTEK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 15:04:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728200AbgDWTEK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 15:04:10 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A53A20767;
        Thu, 23 Apr 2020 19:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587668649;
        bh=ArveDoHWT4lAz5+VyrcfSb31mwoUIfUC0s4dbYTbeWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V3RnUMyafxAGhHaLzhV1Rr9jxAWiPRhQF6fj5UX8gQyzKhzxPgHf/aCJvTIf3Eghv
         TNBoBJoMoRh1coY3qjsRLnlZaXx/52dz/ySVLVXDROGeIUTb6mpWqlBAifQklO1wA8
         dqI+DW7URF+DTFnFn0X4uE5huwinL4gpyevlGyRc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 16/18] RDMA/mlx5: Remove redundant destroy QP call
Date:   Thu, 23 Apr 2020 22:03:01 +0300
Message-Id: <20200423190303.12856-17-leon@kernel.org>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200423190303.12856-1-leon@kernel.org>
References: <20200423190303.12856-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

After major refactoring in create QP flow, it is no needed to call
to destroy QP in XRC_TGT flow.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 8e94a824e29f..0612663868dd 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1887,7 +1887,6 @@ static int create_xrc_tgt_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 			     struct mlx5_create_qp_params *params)
 {
 	struct ib_qp_init_attr *attr = params->attr;
-	struct ib_udata *udata = params->udata;
 	u32 uidx = params->uidx;
 	struct mlx5_ib_resources *devr = &dev->devr;
 	int inlen = MLX5_ST_SZ_BYTES(create_qp_in);
@@ -1944,10 +1943,8 @@ static int create_xrc_tgt_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	base = &qp->trans_qp.base;
 	err = mlx5_core_create_qp(dev, &base->mqp, in, inlen);
 	kvfree(in);
-	if (err) {
-		destroy_qp(dev, qp, base, udata);
+	if (err)
 		return err;
-	}
 
 	base->container_mibqp = qp;
 	base->mqp.event = mlx5_ib_qp_event;
-- 
2.25.3

