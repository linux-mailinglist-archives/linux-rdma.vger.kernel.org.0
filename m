Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652BA1B0F98
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2020 17:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbgDTPMB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Apr 2020 11:12:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730165AbgDTPL7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Apr 2020 11:11:59 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 278E520857;
        Mon, 20 Apr 2020 15:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587395518;
        bh=TXJ01mgeO51w7h1+8j7unxL4WiD5WYhfX+xZdypCYZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=laiO8uAJuWlqGqgulJLFryromCpdzq8USmH12RfTVn9PztT/HvhSu5HpLLdJJulMz
         NMwpv7dyol9Ytftolu4/h2UydLLws0Mr8ufxuBC2r8mrVYLFEgy4syY0JATpwe8ziN
         6kZG0n65ySB3w6daYjl5FtNCFf/pRe2+QqrpWePU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 08/18] RDMA/mlx5: Split scatter CQE configuration for DCT QP
Date:   Mon, 20 Apr 2020 18:10:55 +0300
Message-Id: <20200420151105.282848-9-leon@kernel.org>
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

DCT QPs have separate creation flow and can be easily extracted
from configure_responder_scat_cqe(), this makes both updated
functions more clear.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 3b10fa5c6db8..3d19adc7c260 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1907,13 +1907,6 @@ static void configure_responder_scat_cqe(struct ib_qp_init_attr *init_attr,
 
 	rcqe_sz = mlx5_ib_get_cqe_size(init_attr->recv_cq);
 
-	if (init_attr->qp_type == MLX5_IB_QPT_DCT) {
-		if (rcqe_sz == 128)
-			MLX5_SET(dctc, qpc, cs_res, MLX5_RES_SCAT_DATA64_CQE);
-
-		return;
-	}
-
 	MLX5_SET(qpc, qpc, cs_res,
 		 rcqe_sz == 128 ? MLX5_RES_SCAT_DATA64_CQE :
 				  MLX5_RES_SCAT_DATA32_CQE);
@@ -2583,8 +2576,12 @@ static int create_dct(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 	MLX5_SET64(dctc, dctc, dc_access_key, ucmd->access_key);
 	MLX5_SET(dctc, dctc, user_index, uidx);
 
-	if (ucmd->flags & MLX5_QP_FLAG_SCATTER_CQE)
-		configure_responder_scat_cqe(attr, dctc);
+	if (ucmd->flags & MLX5_QP_FLAG_SCATTER_CQE) {
+		int rcqe_sz = mlx5_ib_get_cqe_size(attr->recv_cq);
+
+		if (rcqe_sz == 128)
+			MLX5_SET(dctc, dctc, cs_res, MLX5_RES_SCAT_DATA64_CQE);
+	}
 
 	qp->state = IB_QPS_RESET;
 
-- 
2.25.2

