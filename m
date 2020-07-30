Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F8F232DB9
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jul 2020 10:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgG3IOL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jul 2020 04:14:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730091AbgG3IMx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Jul 2020 04:12:53 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AEB322CBE;
        Thu, 30 Jul 2020 08:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096773;
        bh=MJxrwSg4D05dkXA9FyjDwWO/N3lMNm/mBwtzucQT2rc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=usSMjvcxRr0ZM3UUplbuDeLATqHbzmiNiPDvNa2GJM8/RL9StJbOccox3OdCV6Lq1
         f319lBhzRhmpOyYYuIy37wKdk2V46Aec0d1b7f/2R+/dVQ1N7S28hq6SRgADsYrmoo
         7ctcGfAwmB+kWDbERAgLRMOZh5kiXmiqDB3WclaM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-next 3/3] RDMA: Remove constant domain argument from flow creation call
Date:   Thu, 30 Jul 2020 11:12:35 +0300
Message-Id: <20200730081235.1581127-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200730081235.1581127-1-leon@kernel.org>
References: <20200730081235.1581127-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The "domain" argument is constant and modern device (mlx5) doesn't
support anything except IB_FLOW_DOMAIN_USER, so delete this extra
parameter and simplify code.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/uverbs_cmd.c |  4 ++--
 drivers/infiniband/hw/mlx4/main.c    | 31 +++++++---------------------
 drivers/infiniband/hw/mlx5/fs.c      |  9 +++-----
 include/rdma/ib_verbs.h              | 13 +-----------
 4 files changed, 14 insertions(+), 43 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 2fbc583d5bdd..0f359f8ae4db 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3232,8 +3232,8 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 		goto err_free;
 	}
 
-	flow_id = qp->device->ops.create_flow(
-		qp, flow_attr, IB_FLOW_DOMAIN_USER, &attrs->driver_udata);
+	flow_id = qp->device->ops.create_flow(qp, flow_attr,
+					      &attrs->driver_udata);
 
 	if (IS_ERR(flow_id)) {
 		err = PTR_ERR(flow_id);
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 5e7910a517da..2543062c0cb0 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1532,23 +1532,11 @@ static int __mlx4_ib_create_flow(struct ib_qp *qp, struct ib_flow_attr *flow_att
 	struct mlx4_net_trans_rule_hw_ctrl *ctrl;
 	int default_flow;
 
-	static const u16 __mlx4_domain[] = {
-		[IB_FLOW_DOMAIN_USER] = MLX4_DOMAIN_UVERBS,
-		[IB_FLOW_DOMAIN_ETHTOOL] = MLX4_DOMAIN_ETHTOOL,
-		[IB_FLOW_DOMAIN_RFS] = MLX4_DOMAIN_RFS,
-		[IB_FLOW_DOMAIN_NIC] = MLX4_DOMAIN_NIC,
-	};
-
 	if (flow_attr->priority > MLX4_IB_FLOW_MAX_PRIO) {
 		pr_err("Invalid priority value %d\n", flow_attr->priority);
 		return -EINVAL;
 	}
 
-	if (domain >= IB_FLOW_DOMAIN_NUM) {
-		pr_err("Invalid domain value %d\n", domain);
-		return -EINVAL;
-	}
-
 	if (mlx4_map_sw_to_hw_steering_mode(mdev->dev, flow_type) < 0)
 		return -EINVAL;
 
@@ -1557,8 +1545,7 @@ static int __mlx4_ib_create_flow(struct ib_qp *qp, struct ib_flow_attr *flow_att
 		return PTR_ERR(mailbox);
 	ctrl = mailbox->buf;
 
-	ctrl->prio = cpu_to_be16(__mlx4_domain[domain] |
-				 flow_attr->priority);
+	ctrl->prio = cpu_to_be16(domain | flow_attr->priority);
 	ctrl->type = mlx4_map_sw_to_hw_steering_mode(mdev->dev, flow_type);
 	ctrl->port = flow_attr->port;
 	ctrl->qpn = cpu_to_be32(qp->qp_num);
@@ -1700,8 +1687,8 @@ static int mlx4_ib_add_dont_trap_rule(struct mlx4_dev *dev,
 }
 
 static struct ib_flow *mlx4_ib_create_flow(struct ib_qp *qp,
-				    struct ib_flow_attr *flow_attr,
-				    int domain, struct ib_udata *udata)
+					   struct ib_flow_attr *flow_attr,
+					   struct ib_udata *udata)
 {
 	int err = 0, i = 0, j = 0;
 	struct mlx4_ib_flow *mflow;
@@ -1767,8 +1754,8 @@ static struct ib_flow *mlx4_ib_create_flow(struct ib_qp *qp,
 	}
 
 	while (i < ARRAY_SIZE(type) && type[i]) {
-		err = __mlx4_ib_create_flow(qp, flow_attr, domain, type[i],
-					    &mflow->reg_id[i].id);
+		err = __mlx4_ib_create_flow(qp, flow_attr, MLX4_DOMAIN_UVERBS,
+					    type[i], &mflow->reg_id[i].id);
 		if (err)
 			goto err_create_flow;
 		if (is_bonded) {
@@ -1777,7 +1764,7 @@ static struct ib_flow *mlx4_ib_create_flow(struct ib_qp *qp,
 			 */
 			flow_attr->port = 2;
 			err = __mlx4_ib_create_flow(qp, flow_attr,
-						    domain, type[j],
+						    MLX4_DOMAIN_UVERBS, type[j],
 						    &mflow->reg_id[j].mirror);
 			flow_attr->port = 1;
 			if (err)
@@ -2988,10 +2975,8 @@ int mlx4_ib_steer_qp_reg(struct mlx4_ib_dev *mdev, struct mlx4_ib_qp *mqp,
 		/* Add an empty rule for IB L2 */
 		memset(&ib_spec->mask, 0, sizeof(ib_spec->mask));
 
-		err = __mlx4_ib_create_flow(&mqp->ibqp, flow,
-					    IB_FLOW_DOMAIN_NIC,
-					    MLX4_FS_REGULAR,
-					    &mqp->reg_id);
+		err = __mlx4_ib_create_flow(&mqp->ibqp, flow, MLX4_DOMAIN_NIC,
+					    MLX4_FS_REGULAR, &mqp->reg_id);
 	} else {
 		err = __mlx4_ib_destroy_flow(mdev->dev, mqp->reg_id);
 	}
diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index 4182c1ab81cc..492cfe063bca 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -1143,10 +1143,8 @@ static struct mlx5_ib_flow_handler *create_sniffer_rule(struct mlx5_ib_dev *dev,
 	return ERR_PTR(err);
 }
 
-
 static struct ib_flow *mlx5_ib_create_flow(struct ib_qp *qp,
 					   struct ib_flow_attr *flow_attr,
-					   int domain,
 					   struct ib_udata *udata)
 {
 	struct mlx5_ib_dev *dev = to_mdev(qp->device);
@@ -1196,10 +1194,9 @@ static struct ib_flow *mlx5_ib_create_flow(struct ib_qp *qp,
 		goto free_ucmd;
 	}
 
-	if (domain != IB_FLOW_DOMAIN_USER ||
-	    flow_attr->port > dev->num_ports ||
-	    (flow_attr->flags & ~(IB_FLOW_ATTR_FLAGS_DONT_TRAP |
-				  IB_FLOW_ATTR_FLAGS_EGRESS))) {
+	if (flow_attr->port > dev->num_ports ||
+	    (flow_attr->flags &
+	     ~(IB_FLOW_ATTR_FLAGS_DONT_TRAP | IB_FLOW_ATTR_FLAGS_EGRESS))) {
 		err = -EINVAL;
 		goto free_ucmd;
 	}
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 3608292ca1e9..969561f6e70e 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1864,17 +1864,6 @@ enum ib_flow_spec_type {
 #define IB_FLOW_SPEC_LAYER_MASK	0xF0
 #define IB_FLOW_SPEC_SUPPORT_LAYERS 10
 
-/* Flow steering rule priority is set according to it's domain.
- * Lower domain value means higher priority.
- */
-enum ib_flow_domain {
-	IB_FLOW_DOMAIN_USER,
-	IB_FLOW_DOMAIN_ETHTOOL,
-	IB_FLOW_DOMAIN_RFS,
-	IB_FLOW_DOMAIN_NIC,
-	IB_FLOW_DOMAIN_NUM /* Must be last */
-};
-
 enum ib_flow_flags {
 	IB_FLOW_ATTR_FLAGS_DONT_TRAP = 1UL << 1, /* Continue match, no steal */
 	IB_FLOW_ATTR_FLAGS_EGRESS = 1UL << 2, /* Egress flow */
@@ -2472,7 +2461,7 @@ struct ib_device_ops {
 	void (*dealloc_xrcd)(struct ib_xrcd *xrcd, struct ib_udata *udata);
 	struct ib_flow *(*create_flow)(struct ib_qp *qp,
 				       struct ib_flow_attr *flow_attr,
-				       int domain, struct ib_udata *udata);
+				       struct ib_udata *udata);
 	int (*destroy_flow)(struct ib_flow *flow_id);
 	struct ib_flow_action *(*create_flow_action_esp)(
 		struct ib_device *device,
-- 
2.26.2

