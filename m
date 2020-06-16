Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C967F1FAE6A
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 12:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgFPKqd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 06:46:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgFPKqd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Jun 2020 06:46:33 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3242020734;
        Tue, 16 Jun 2020 10:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592304392;
        bh=WakVDEaER0f08Uony9tmw1P06AdpB6xM7Z7SMIdcLWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=riayTZzcdfizetGCId5+3qnC7BEfdr2NWG3vb6fmahXKl/u9QOsaGgJWNiMx1/kis
         3IgApwxUXrRnATwakb43pHXbJCbu3uY580ZQ+hJCGdXOVzXhsIxdTQG7UnlLK27KbS
         Of16Tg+i9mpKDNFyHq4e2I7hK1stM+WqfWYxNTfg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 11/11] RDMA/mlx5: Add support to get MR resource in RAW format
Date:   Tue, 16 Jun 2020 13:40:06 +0300
Message-Id: <20200616104006.2425549-12-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200616104006.2425549-1-leon@kernel.org>
References: <20200616104006.2425549-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

Add support to get MR (mkey) resource dump in RAW format.

Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c     | 1 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h  | 1 +
 drivers/infiniband/hw/mlx5/restrack.c | 8 ++++++++
 3 files changed, 10 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 30e0645ca3ba..9dbc87c540e4 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6600,6 +6600,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.enable_driver = mlx5_ib_enable_driver,
 	.fill_res_cq_entry_raw = mlx5_ib_fill_res_cq_entry_raw,
 	.fill_res_mr_entry = mlx5_ib_fill_res_mr_entry,
+	.fill_res_mr_entry_raw = mlx5_ib_fill_res_mr_entry_raw,
 	.fill_res_qp_entry_raw = mlx5_ib_fill_res_qp_entry_raw,
 	.fill_stat_mr_entry = mlx5_ib_fill_stat_mr_entry,
 	.get_dev_fw_str = get_dev_fw_str,
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index c6b2102a5a09..2fd199c07dda 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1376,6 +1376,7 @@ struct mlx5_core_dev *mlx5_ib_get_native_port_mdev(struct mlx5_ib_dev *dev,
 void mlx5_ib_put_native_port_mdev(struct mlx5_ib_dev *dev,
 				  u8 port_num);
 int mlx5_ib_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr);
+int mlx5_ib_fill_res_mr_entry_raw(struct sk_buff *msg, struct ib_mr *ib_mr);
 int mlx5_ib_fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ibqp);
 int mlx5_ib_fill_res_cq_entry_raw(struct sk_buff *msg, struct ib_cq *ibcq);
 int mlx5_ib_fill_stat_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr);
diff --git a/drivers/infiniband/hw/mlx5/restrack.c b/drivers/infiniband/hw/mlx5/restrack.c
index 7db49650a2b6..224a63975822 100644
--- a/drivers/infiniband/hw/mlx5/restrack.c
+++ b/drivers/infiniband/hw/mlx5/restrack.c
@@ -109,6 +109,14 @@ int mlx5_ib_fill_stat_mr_entry(struct sk_buff *msg,
 	return -EMSGSIZE;
 }
 
+int mlx5_ib_fill_res_mr_entry_raw(struct sk_buff *msg, struct ib_mr *ibmr)
+{
+	struct mlx5_ib_mr *mr = to_mmr(ibmr);
+
+	return fill_res_raw(msg, mr->dev, MLX5_SGMT_TYPE_PRM_QUERY_MKEY,
+			    mlx5_mkey_to_idx(mr->mmkey.key));
+}
+
 int mlx5_ib_fill_res_mr_entry(struct sk_buff *msg,
 			      struct ib_mr *ibmr)
 {
-- 
2.26.2

