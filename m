Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6738B5F8E0
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2019 15:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfGDNJp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jul 2019 09:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbfGDNJp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Jul 2019 09:09:45 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F33DD218A6;
        Thu,  4 Jul 2019 13:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562245784;
        bh=pUG09UF0OY+eEOCKnenHq38XwXbGc686vfzXR6Zxp+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DmNBGkmN8XVikKUM2nvNA201J7jZ7JHkBLuc7KX7PhPioetqPhwYguf16f9q4Jf9s
         x4tY9RiSmdg2GllBIuw5CdVlZjpXVNSe1kgWvWYk6n9e2M39mucjRPwYIkuAgDOnfP
         wwGO7sJFN7zL9/Rf28NHjEKkJJ1oCAvgxL2t4wMU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 2/2] RDMA/mlx4: Annotate boolean arguments as bool and not int
Date:   Thu,  4 Jul 2019 16:09:36 +0300
Message-Id: <20190704130936.8705-3-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190704130936.8705-1-leon@kernel.org>
References: <20190704130936.8705-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Information provided by qp_has_rq() and used latter is boolean,
so update callers to proper type.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx4/qp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index e409adac4e2e..bd4aa04416c6 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -325,7 +325,7 @@ static int send_wqe_overhead(enum mlx4_ib_qp_type type, u32 flags)
 }
 
 static int set_rq_size(struct mlx4_ib_dev *dev, struct ib_qp_cap *cap,
-		       bool is_user, int has_rq, struct mlx4_ib_qp *qp,
+		       bool is_user, bool has_rq, struct mlx4_ib_qp *qp,
 		       u32 inl_recv_sz)
 {
 	/* Sanity check RQ size before proceeding */
@@ -506,10 +506,10 @@ static void free_proxy_bufs(struct ib_device *dev, struct mlx4_ib_qp *qp)
 	kfree(qp->sqp_proxy_rcv);
 }
 
-static int qp_has_rq(struct ib_qp_init_attr *attr)
+static bool qp_has_rq(struct ib_qp_init_attr *attr)
 {
 	if (attr->qp_type == IB_QPT_XRC_INI || attr->qp_type == IB_QPT_XRC_TGT)
-		return 0;
+		return false;
 
 	return !attr->srq;
 }
@@ -906,7 +906,7 @@ static int create_rq(struct ib_pd *pd, struct ib_qp_init_attr *init_attr,
 	if (init_attr->create_flags & IB_QP_CREATE_SCATTER_FCS)
 		qp->flags |= MLX4_IB_QP_SCATTER_FCS;
 
-	err = set_rq_size(dev, &init_attr->cap, true, 1, qp, qp->inl_recv_sz);
+	err = set_rq_size(dev, &init_attr->cap, true, true, qp, qp->inl_recv_sz);
 	if (err)
 		goto err;
 
-- 
2.20.1

