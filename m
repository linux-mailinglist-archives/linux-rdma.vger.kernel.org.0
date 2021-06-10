Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8883A258C
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 09:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhFJHgd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 03:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230026AbhFJHgb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Jun 2021 03:36:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F08561359;
        Thu, 10 Jun 2021 07:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623310476;
        bh=LvQH9UKOo3fG8EAeI18MC2nbv4GeeR6qf4jQISR3Y28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A5lMfUeq3bmxqnq1B2fIg9OYHMs3EoWI8yUbSlBPREIHSwVJvAbzTvm6RTeUwZf9K
         fzoqqTBQTSC2ZEEu1WF9H0KVDW8j2nxtOTEysbnzAnEDyFwDK8AofBCt8gfX4kTidr
         R4UFMoRMhxQeSlf/s52oCdYnsYu35ZmBNW7R19+gQS9JS4qaEfCB9oGL6P5kkduF0O
         6cAPJmz5i0jaIjmYrklZfG/LtbUoiJ08ePW4FB9z+fkfrsp4gVQNCW/O/afA3Et0jB
         EfyrCbxJAdKNecUFYkK3pLAMFiw1dC+0i5ISzMzhoP2BUa6K4Rj5DueL1kqdytl4m6
         +VU8Klx45Pexw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>,
        Alaa Hleihel <alaa@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Bloch <markb@mellanox.com>
Subject: [PATCH rdma-rc 1/3] RDMA: Verify port when creating flow rule
Date:   Thu, 10 Jun 2021 10:34:25 +0300
Message-Id: <faad30dc5219a01727f47db3dc2f029d07c82c00.1623309971.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623309971.git.leonro@nvidia.com>
References: <cover.1623309971.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

Validate port value provided by the user and with that remove no
longer needed validation by the driver.
The missing check in the mlx5_ib driver could cause to the below oops.

Call trace:
  _create_flow_rule+0x2d4/0xf28 [mlx5_ib]
  mlx5_ib_create_flow+0x2d0/0x5b0 [mlx5_ib]
  ib_uverbs_ex_create_flow+0x4cc/0x624 [ib_uverbs]
  ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0xd4/0x150 [ib_uverbs]
  ib_uverbs_cmd_verbs.isra.7+0xb28/0xc50 [ib_uverbs]
  ib_uverbs_ioctl+0x158/0x1d0 [ib_uverbs]
  do_vfs_ioctl+0xd0/0xaf0
  ksys_ioctl+0x84/0xb4
  __arm64_sys_ioctl+0x28/0xc4
  el0_svc_common.constprop.3+0xa4/0x254
  el0_svc_handler+0x84/0xa0
  el0_svc+0x10/0x26c
 Code: b9401260 f9615681 51000400 8b001c20 (f9403c1a)
 ---[ end trace 1b5ffb34e3a14d2b ]---

Fixes: 436f2ad05a0b ("IB/core: Export ib_create/destroy_flow through uverbs")
Reviewed-by: Mark Bloch <markb@mellanox.com>
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
This is new version of previously posted patch here
https://lore.kernel.org/linux-rdma/07ddc8516a0e53e54e3cf5cbbff19cac6cda3d82.1623129061.git.leonro@nvidia.com
---
 drivers/infiniband/core/uverbs_cmd.c | 5 +++++
 drivers/infiniband/hw/mlx4/main.c    | 3 ---
 drivers/infiniband/hw/mlx5/fs.c      | 5 ++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index d5e15a8c870d..64e4be1cbec7 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3248,6 +3248,11 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 		goto err_free_attr;
 	}
 
+	if (!rdma_is_port_valid(uobj->context->device, cmd.flow_attr.port)) {
+		err = -EINVAL;
+		goto err_uobj;
+	}
+
 	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
 	if (!qp) {
 		err = -EINVAL;
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 16704262fc3a..230a6ae0ab5a 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1699,9 +1699,6 @@ static struct ib_flow *mlx4_ib_create_flow(struct ib_qp *qp,
 	struct mlx4_dev *dev = (to_mdev(qp->device))->dev;
 	int is_bonded = mlx4_is_bonded(dev);
 
-	if (!rdma_is_port_valid(qp->device, flow_attr->port))
-		return ERR_PTR(-EINVAL);
-
 	if (flow_attr->flags & ~IB_FLOW_ATTR_FLAGS_DONT_TRAP)
 		return ERR_PTR(-EOPNOTSUPP);
 
diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index f84441ff0c81..18ee2f293825 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -1194,9 +1194,8 @@ static struct ib_flow *mlx5_ib_create_flow(struct ib_qp *qp,
 		goto free_ucmd;
 	}
 
-	if (flow_attr->port > dev->num_ports ||
-	    (flow_attr->flags &
-	     ~(IB_FLOW_ATTR_FLAGS_DONT_TRAP | IB_FLOW_ATTR_FLAGS_EGRESS))) {
+	if (flow_attr->flags &
+	    ~(IB_FLOW_ATTR_FLAGS_DONT_TRAP | IB_FLOW_ATTR_FLAGS_EGRESS)) {
 		err = -EINVAL;
 		goto free_ucmd;
 	}
-- 
2.31.1

