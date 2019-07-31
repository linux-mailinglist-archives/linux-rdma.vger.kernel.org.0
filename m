Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A57D77C08E
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 13:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfGaL4d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 07:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbfGaL4d (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 07:56:33 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEF55206A3;
        Wed, 31 Jul 2019 11:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564574192;
        bh=1FbmUKCoXHrfNQnz73ZyxexzZoT2Pm+nyNKspzyxbXc=;
        h=From:To:Cc:Subject:Date:From;
        b=qXIIhSKbyhcOQwKbRF/AKBb9C3hi75t6OScoEVqcM2lmaOT+tuOUhclH4C74I3EAv
         AWxYxt3II39AnOVv/o/WohUaeQIdkO/sco8rqnIwI8QK+hdFCYsavX8tiWWtbbFs09
         8Us9J/T79fOUtcC+pRaBUZ5jjCSm5poHiwRMteww=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next] RDMA/mlx5: Remove DEBUG ODP code
Date:   Wed, 31 Jul 2019 14:56:27 +0300
Message-Id: <20190731115627.5433-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Delete DEBU ODP dead code which is leftover from development
stage and doesn't need to be part of the upstream kernel.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 74310d885a90..6f1de5edbe8e 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1033,9 +1033,6 @@ static int mlx5_ib_mr_initiator_pfault_handler(
 	u32 transport_caps;
 	struct mlx5_base_av *av;
 	unsigned ds, opcode;
-#if defined(DEBUG)
-	u32 ctrl_wqe_index, ctrl_qpn;
-#endif
 	u32 qpn = qp->trans_qp.base.mqp.qpn;
 
 	ds = be32_to_cpu(ctrl->qpn_ds) & MLX5_WQE_CTRL_DS_MASK;
@@ -1051,27 +1048,6 @@ static int mlx5_ib_mr_initiator_pfault_handler(
 		return -EFAULT;
 	}
 
-#if defined(DEBUG)
-	ctrl_wqe_index = (be32_to_cpu(ctrl->opmod_idx_opcode) &
-			MLX5_WQE_CTRL_WQE_INDEX_MASK) >>
-			MLX5_WQE_CTRL_WQE_INDEX_SHIFT;
-	if (wqe_index != ctrl_wqe_index) {
-		mlx5_ib_err(dev, "Got WQE with invalid wqe_index. wqe_index=0x%x, qpn=0x%x ctrl->wqe_index=0x%x\n",
-			    wqe_index, qpn,
-			    ctrl_wqe_index);
-		return -EFAULT;
-	}
-
-	ctrl_qpn = (be32_to_cpu(ctrl->qpn_ds) & MLX5_WQE_CTRL_QPN_MASK) >>
-		MLX5_WQE_CTRL_QPN_SHIFT;
-	if (qpn != ctrl_qpn) {
-		mlx5_ib_err(dev, "Got WQE with incorrect QP number. wqe_index=0x%x, qpn=0x%x ctrl->qpn=0x%x\n",
-			    wqe_index, qpn,
-			    ctrl_qpn);
-		return -EFAULT;
-	}
-#endif /* DEBUG */
-
 	*wqe_end = *wqe + ds * MLX5_WQE_DS_UNITS;
 	*wqe += sizeof(*ctrl);
 
-- 
2.20.1

