Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F362922E9A4
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jul 2020 11:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgG0J5w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jul 2020 05:57:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgG0J5w (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Jul 2020 05:57:52 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F31972075D;
        Mon, 27 Jul 2020 09:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595843871;
        bh=ez9hoRPQ0ZdT29gaRYQfEL7Q5XXGTn3qpsU34mYeCKY=;
        h=From:To:Cc:Subject:Date:From;
        b=MqK9ksdDtRCOgNJtEsT5RQqxT/G72TVT+8w8XOh+LFamxw3Hls2k4ljRkLmjnHVPP
         GWrAUf3PfD6+AiAQSMeViLIdfpP47U6g2VJMKJud/k9dP5r/lnmXeGPzNlO/gDSBmN
         1u9PaL0JaGMw1FzboOUAM5BdWTKuahf1me+3gFHE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/mlx5: Delete unreachable code
Date:   Mon, 27 Jul 2020 12:57:46 +0300
Message-Id: <20200727095746.495915-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Delete two occurrences of unreachable code discovered by the Coverity.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c |  3 ---
 drivers/infiniband/hw/mlx5/qp.c   | 10 ++++------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index b730297b4d69..a973008286fd 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -287,9 +287,6 @@ struct mlx5_core_dev *mlx5_ib_get_native_port_mdev(struct mlx5_ib_dev *ibdev,
 		*native_port_num = 1;
 
 	port = &ibdev->port[ib_port_num - 1];
-	if (!port)
-		return NULL;
-
 	spin_lock(&port->mp.mpi_lock);
 	mpi = ibdev->port[ib_port_num - 1].mp.mpi;
 	if (mpi && !mpi->unaffiliate) {
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index fb803b58ee8f..786df9d39724 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4135,9 +4135,9 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	struct mlx5_ib_qp *qp = to_mqp(ibqp);
 	struct mlx5_ib_dev *dev = to_mdev(ibqp->device);
 	enum ib_qp_state cur_state, new_state;
-	int err = 0;
 	int required = IB_QP_STATE;
 	void *dctc;
+	int err;
 
 	if (!(attr_mask & IB_QP_STATE))
 		return -EINVAL;
@@ -4233,11 +4233,9 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		mlx5_ib_warn(dev, "Modify DCT: Invalid transition from %d to %d\n", cur_state, new_state);
 		return -EINVAL;
 	}
-	if (err)
-		qp->state = IB_QPS_ERR;
-	else
-		qp->state = new_state;
-	return err;
+
+	qp->state = new_state;
+	return 0;
 }
 
 int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
-- 
2.26.2

