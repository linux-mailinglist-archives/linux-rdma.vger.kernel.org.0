Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288E91E44A4
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2020 15:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388977AbgE0Nyp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 May 2020 09:54:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388891AbgE0Nyo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 May 2020 09:54:44 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECDF6207D8;
        Wed, 27 May 2020 13:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590587684;
        bh=OqPRxSCL0/8bk4Ov3JbtRAkueUx1RyfK3ic761F9Aow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nr+vO2tW6FDyHL5rznwxCQdDUiADe53QZJZ8zyxC6vphJ1wt2r0MnzeQbF0fQINFC
         cCfAy5zkhh2dTihfJQctYaZUrdp6Cgg5O+K6i8MKmp2onkC8gdgEpKjAVvi3GX3+sn
         iI1Y/ucn/KNLf7YovKfJjDgTLWiRKXpTLPvxGJD0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 09/11] RDMA/mlx5: Add support to get QP resource in raw format
Date:   Wed, 27 May 2020 16:54:06 +0300
Message-Id: <20200527135408.480878-10-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527135408.480878-1-leon@kernel.org>
References: <20200527135408.480878-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

Add a generic function that use the resource dump mechanism
to get the resource data.
This patch adds the support to QP.

Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c     |  1 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h  |  2 +
 drivers/infiniband/hw/mlx5/restrack.c | 79 +++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 66f4bca1aa5d..d81cb7139e98 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6609,6 +6609,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.drain_sq = mlx5_ib_drain_sq,
 	.enable_driver = mlx5_ib_enable_driver,
 	.fill_res_mr_entry = mlx5_ib_fill_res_mr_entry,
+	.fill_res_qp_entry = mlx5_ib_fill_res_qp_entry,
 	.fill_stat_mr_entry = mlx5_ib_fill_stat_mr_entry,
 	.get_dev_fw_str = get_dev_fw_str,
 	.get_dma_mr = mlx5_ib_get_dma_mr,
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 270a9f1c92c4..8959db266a35 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1385,6 +1385,8 @@ void mlx5_ib_put_native_port_mdev(struct mlx5_ib_dev *dev,
 				  u8 port_num);
 int mlx5_ib_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr,
 			      bool raw);
+int mlx5_ib_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ibqp,
+			      bool raw);
 int mlx5_ib_fill_stat_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr);
 
 extern const struct uapi_definition mlx5_ib_devx_defs[];
diff --git a/drivers/infiniband/hw/mlx5/restrack.c b/drivers/infiniband/hw/mlx5/restrack.c
index 32b1bdf5768b..cf2322109f88 100644
--- a/drivers/infiniband/hw/mlx5/restrack.c
+++ b/drivers/infiniband/hw/mlx5/restrack.c
@@ -4,10 +4,79 @@
  */
 
 #include <uapi/rdma/rdma_netlink.h>
+#include <linux/mlx5/rsc_dump.h>
 #include <rdma/ib_umem_odp.h>
 #include <rdma/restrack.h>
 #include "mlx5_ib.h"
 
+#define MAX_DUMP_SIZE 1024
+
+static int dump_rsc(struct mlx5_core_dev *dev, enum mlx5_sgmt_type type,
+		    int index, void *data, int *data_len)
+{
+	struct mlx5_core_dev *mdev = dev;
+	struct mlx5_rsc_dump_cmd *cmd;
+	struct mlx5_rsc_key key = {};
+	struct page *page;
+	int offset = 0;
+	int err = 0;
+	int cmd_err;
+	int size;
+
+	page = alloc_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
+	key.size = PAGE_SIZE;
+	key.rsc = type;
+	key.index1 = index;
+	key.num_of_obj1 = 1;
+
+	cmd = mlx5_rsc_dump_cmd_create(mdev, &key);
+	if (IS_ERR(cmd)) {
+		err = PTR_ERR(cmd);
+		goto free_page;
+	}
+
+	do {
+		cmd_err = mlx5_rsc_dump_next(mdev, cmd, page, &size);
+		if (cmd_err < 0 || size + offset > MAX_DUMP_SIZE) {
+			err = cmd_err;
+			goto destroy_cmd;
+		}
+		memcpy(data + offset, page_address(page), size);
+		offset += size;
+	} while (cmd_err > 0);
+	*data_len = offset;
+
+destroy_cmd:
+	mlx5_rsc_dump_cmd_destroy(cmd);
+free_page:
+	__free_page(page);
+	return err;
+}
+
+static int fill_res_raw(struct sk_buff *msg, struct mlx5_ib_dev *dev,
+			enum mlx5_sgmt_type type, u32 key)
+{
+	int len = 0;
+	void *data;
+	int err;
+
+	data = kzalloc(MAX_DUMP_SIZE, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	err = dump_rsc(dev->mdev, type, key, data, &len);
+	if (err)
+		goto out;
+
+	err = nla_put(msg, RDMA_NLDEV_ATTR_RES_RAW, len, data);
+out:
+	kfree(data);
+	return err;
+}
+
 int mlx5_ib_fill_stat_mr_entry(struct sk_buff *msg,
 			       struct ib_mr *ibmr)
 {
@@ -71,3 +140,13 @@ int mlx5_ib_fill_res_mr_entry(struct sk_buff *msg,
 	nla_nest_cancel(msg, table_attr);
 	return -EMSGSIZE;
 }
+
+int mlx5_ib_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ibqp, bool raw)
+{
+	struct mlx5_ib_dev *dev = to_mdev(ibqp->device);
+
+	if (!raw)
+		return 0;
+	return fill_res_raw(msg, dev, MLX5_SGMT_TYPE_PRM_QUERY_QP,
+			    ibqp->qp_num);
+}
-- 
2.26.2

