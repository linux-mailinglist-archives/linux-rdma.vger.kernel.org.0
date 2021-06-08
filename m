Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E942A39EDF8
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 07:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhFHFOW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 01:14:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhFHFOW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Jun 2021 01:14:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB9136124C;
        Tue,  8 Jun 2021 05:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623129150;
        bh=Qg5XRl/cFZ+63AhQagzragxQhas4LA10w5Pay5pZPBI=;
        h=From:To:Cc:Subject:Date:From;
        b=mjtX0o1DvaPJVrpk3CKw5xIrWq0CjzRN2qhGDI16pC8ZEaTCHEsocSNaalFxKn8pq
         VYg0ctN/fSZhDMVxu1A/sWfeXtmQcxkSV9e5QMK0VbY6Fo5Dl75CGkBDXMrX0ULddq
         WucCrd65SMmguLOsgDHX8bfSY6v0xzCx9pl9ui3IzXYV29ANxLTQZoDhxZD/viIES1
         8h1obnGSZHK4MyLsrIyeOUqhfacJItvIdYhqT273nLtPscGZhzhPsBGT8RN3kXrjfy
         +ufA1sCK7HpRTqq6H07gY6w9aUSzoHKoF5rDUf5b3FJW3e25XNk5IL42s86maAWMHP
         SW0oFo2PnYANg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Bloch <markb@mellanox.com>
Subject: [PATCH rdma-rc] RDMA: Verify port when creating flow rule
Date:   Tue,  8 Jun 2021 08:12:24 +0300
Message-Id: <07ddc8516a0e53e54e3cf5cbbff19cac6cda3d82.1623129061.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
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
 drivers/infiniband/core/uverbs_cmd.c | 8 ++++++++
 drivers/infiniband/hw/mlx4/main.c    | 3 ---
 drivers/infiniband/hw/mlx5/fs.c      | 5 ++---
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index d5e15a8c870d..fe81ddfeb165 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3188,6 +3188,7 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 	struct ib_qp			  *qp;
 	struct ib_uflow_resources	  *uflow_res;
 	struct ib_uverbs_flow_spec_hdr	  *kern_spec;
+	struct ib_ucontext *ucontext;
 	struct uverbs_req_iter iter;
 	int err;
 	void *ib_spec;
@@ -3198,6 +3199,13 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 	if (err)
 		return err;
 
+	ucontext = ib_uverbs_get_ucontext(attrs);
+	if (IS_ERR(ucontext))
+		return PTR_ERR(ucontext);
+
+	if (!rdma_is_port_valid(ucontext->device, cmd.flow_attr.port))
+		return -EINVAL;
+
 	if (cmd.comp_mask)
 		return -EINVAL;
 
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
index 2fc6a60c4e77..cfb24593147c 100644
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

