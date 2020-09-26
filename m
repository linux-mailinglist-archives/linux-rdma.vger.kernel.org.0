Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDA927985E
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Sep 2020 12:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgIZKZY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 26 Sep 2020 06:25:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgIZKZW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 26 Sep 2020 06:25:22 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70BCD238E2;
        Sat, 26 Sep 2020 10:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601115921;
        bh=du0TKGvoW78eGQ65Gu9iZLugVleImX29xdLrPV0XMj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GBAiJMoz85jTOQyYGBqcktkMTZqZiiZihpXV9Nz8KRZpw0YtDYPyeVnQKfPoIY9uj
         y3pSUmidQACPtHXtbaQ3U/d0zawzBJT9UWLBlcD7LYK1wyaIoWOKrRMpE6Vz2/XMFK
         2gX3R95K1sC7nUgWGU5TObA2VO+30DblotLhJiKQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Lijun Ou <oulijun@huawei.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next v1 08/10] RDMA/drivers: Remove udata check from special QP
Date:   Sat, 26 Sep 2020 13:24:48 +0300
Message-Id: <20200926102450.2966017-9-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200926102450.2966017-1-leon@kernel.org>
References: <20200926102450.2966017-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

GSI QP can't be created from the user space, hence the udata check is
always false (udata == NULL). Remove that check and simplify the flow.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c      | 57 +++++++-------------
 drivers/infiniband/hw/mlx4/qp.c              |  3 --
 drivers/infiniband/hw/mlx5/qp.c              | 12 -----
 drivers/infiniband/hw/mthca/mthca_provider.c |  4 --
 drivers/infiniband/hw/qedr/verbs.c           |  8 ---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c |  3 +-
 6 files changed, 19 insertions(+), 68 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 7c3b54881d46..6e06f42be5eb 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1015,53 +1015,32 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 	int ret;
 
 	switch (init_attr->qp_type) {
-	case IB_QPT_RC: {
-		hr_qp = kzalloc(sizeof(*hr_qp), GFP_KERNEL);
-		if (!hr_qp)
-			return ERR_PTR(-ENOMEM);
-
-		ret = hns_roce_create_qp_common(hr_dev, pd, init_attr, udata,
-						hr_qp);
-		if (ret) {
-			ibdev_err(ibdev, "Create QP 0x%06lx failed(%d)\n",
-				  hr_qp->qpn, ret);
-			kfree(hr_qp);
-			return ERR_PTR(ret);
-		}
-
+	case IB_QPT_RC:
+	case IB_QPT_GSI:
 		break;
+	default:
+		ibdev_err(ibdev, "not support QP type %d\n",
+			  init_attr->qp_type);
+		return ERR_PTR(-EOPNOTSUPP);
 	}
-	case IB_QPT_GSI: {
-		/* Userspace is not allowed to create special QPs: */
-		if (udata) {
-			ibdev_err(ibdev, "not support usr space GSI\n");
-			return ERR_PTR(-EINVAL);
-		}
 
-		hr_qp = kzalloc(sizeof(*hr_qp), GFP_KERNEL);
-		if (!hr_qp)
-			return ERR_PTR(-ENOMEM);
+	hr_qp = kzalloc(sizeof(*hr_qp), GFP_KERNEL);
+	if (!hr_qp)
+		return ERR_PTR(-ENOMEM);
 
+	if (init_attr->qp_type == IB_QPT_GSI) {
 		hr_qp->port = init_attr->port_num - 1;
 		hr_qp->phy_port = hr_dev->iboe.phy_port[hr_qp->port];
-
-		ret = hns_roce_create_qp_common(hr_dev, pd, init_attr, udata,
-						hr_qp);
-		if (ret) {
-			ibdev_err(ibdev, "Create GSI QP failed!\n");
-			kfree(hr_qp);
-			return ERR_PTR(ret);
-		}
-
-		break;
-	}
-	default:{
-		ibdev_err(ibdev, "not support QP type %d\n",
-			  init_attr->qp_type);
-		return ERR_PTR(-EOPNOTSUPP);
-	}
 	}
 
+	ret = hns_roce_create_qp_common(hr_dev, pd, init_attr, udata, hr_qp);
+	if (ret) {
+		ibdev_err(ibdev, "Create QP type 0x%x failed(%d)\n",
+			  init_attr->qp_type, ret);
+		ibdev_err(ibdev, "Create GSI QP failed!\n");
+		kfree(hr_qp);
+		return ERR_PTR(ret);
+	}
 	return &hr_qp->ibqp;
 }
 
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 4f003d4ca29c..ef52dd21acd9 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -1545,9 +1545,6 @@ static int _mlx4_ib_create_qp(struct ib_pd *pd, struct mlx4_ib_qp *qp,
 	{
 		int sqpn;
 
-		/* Userspace is not allowed to create special QPs: */
-		if (udata)
-			return -EINVAL;
 		if (init_attr->create_flags & MLX4_IB_QP_CREATE_ROCE_V2_GSI) {
 			int res = mlx4_qp_reserve_range(to_mdev(pd->device)->dev,
 							1, 1, &sqpn, 0,
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 7e9bf75c33e4..22f678ba1a68 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2511,18 +2511,6 @@ static int check_valid_flow(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		return -EINVAL;
 	}
 
-	switch (attr->qp_type) {
-	case IB_QPT_SMI:
-	case MLX5_IB_QPT_HW_GSI:
-	case MLX5_IB_QPT_REG_UMR:
-	case IB_QPT_GSI:
-		mlx5_ib_dbg(dev, "Kernel doesn't support QP type %d\n",
-			    attr->qp_type);
-		return -EINVAL;
-	default:
-		break;
-	}
-
 	/*
 	 * We don't need to see this warning, it means that kernel code
 	 * missing ib_pd. Placed here to catch developer's mistakes.
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 82ee252fe5aa..5dbddf8faf99 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -535,10 +535,6 @@ static struct ib_qp *mthca_create_qp(struct ib_pd *pd,
 	case IB_QPT_SMI:
 	case IB_QPT_GSI:
 	{
-		/* Don't allow userspace to create special QPs */
-		if (udata)
-			return ERR_PTR(-EINVAL);
-
 		qp = kzalloc(sizeof(struct mthca_sqp), GFP_KERNEL);
 		if (!qp)
 			return ERR_PTR(-ENOMEM);
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index da42cc70e372..23559f1fe96e 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1235,14 +1235,6 @@ static int qedr_check_qp_attrs(struct ib_pd *ibpd, struct qedr_dev *dev,
 		return -EINVAL;
 	}
 
-	/* Unprivileged user space cannot create special QP */
-	if (udata && attrs->qp_type == IB_QPT_GSI) {
-		DP_ERR(dev,
-		       "create qp: userspace can't create special QPs of type=0x%x\n",
-		       attrs->qp_type);
-		return -EINVAL;
-	}
-
 	/* verify consumer QPs are not trying to use GSI QP's CQ.
 	 * TGT QP isn't associated with RQ/SQ
 	 */
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
index 8a385acf6f0c..428256c55065 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
@@ -232,8 +232,7 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
 	switch (init_attr->qp_type) {
 	case IB_QPT_GSI:
 		if (init_attr->port_num == 0 ||
-		    init_attr->port_num > pd->device->phys_port_cnt ||
-		    udata) {
+		    init_attr->port_num > pd->device->phys_port_cnt) {
 			dev_warn(&dev->pdev->dev, "invalid queuepair attrs\n");
 			ret = -EINVAL;
 			goto err_qp;
-- 
2.26.2

