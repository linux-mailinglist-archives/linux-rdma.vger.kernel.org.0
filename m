Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB9D2050C1
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 13:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbgFWLb1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 07:31:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732191AbgFWLbW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jun 2020 07:31:22 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D63C120702;
        Tue, 23 Jun 2020 11:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592911881;
        bh=sic7/FYFapc2qvpuSOyNna9wmAzHTunNfgVEhbFCCBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RA0EHEPduntvL3A7g6bO/pjd9xztI8bibgJxDsWkx4tWAFaXqIDY+nJRE+3eTz4Xn
         wIpiBuys1f+csUffqSn4PTTBMS9pd/kk5AdFKz6zAzShe6ig5diCaEvBlB3XHYVDMM
         WZRlmbZIAG1bfxwqO414sVwNpwiA5i3gATdccluc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v3 10/11] RDMA/mlx5: Add support to get CQ resource in RAW format
Date:   Tue, 23 Jun 2020 14:30:42 +0300
Message-Id: <20200623113043.1228482-11-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623113043.1228482-1-leon@kernel.org>
References: <20200623113043.1228482-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

Add support to get CQ resource dump in RAW format.

Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c     | 1 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h  | 1 +
 drivers/infiniband/hw/mlx5/restrack.c | 8 ++++++++
 3 files changed, 10 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 7ac75935d3c2..30e0645ca3ba 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6598,6 +6598,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.drain_rq = mlx5_ib_drain_rq,
 	.drain_sq = mlx5_ib_drain_sq,
 	.enable_driver = mlx5_ib_enable_driver,
+	.fill_res_cq_entry_raw = mlx5_ib_fill_res_cq_entry_raw,
 	.fill_res_mr_entry = mlx5_ib_fill_res_mr_entry,
 	.fill_res_qp_entry_raw = mlx5_ib_fill_res_qp_entry_raw,
 	.fill_stat_mr_entry = mlx5_ib_fill_stat_mr_entry,
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 7285c00e474d..c6b2102a5a09 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1377,6 +1377,7 @@ void mlx5_ib_put_native_port_mdev(struct mlx5_ib_dev *dev,
 				  u8 port_num);
 int mlx5_ib_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr);
 int mlx5_ib_fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ibqp);
+int mlx5_ib_fill_res_cq_entry_raw(struct sk_buff *msg, struct ib_cq *ibcq);
 int mlx5_ib_fill_stat_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr);
 
 extern const struct uapi_definition mlx5_ib_devx_defs[];
diff --git a/drivers/infiniband/hw/mlx5/restrack.c b/drivers/infiniband/hw/mlx5/restrack.c
index c8b91d8e0f42..7db49650a2b6 100644
--- a/drivers/infiniband/hw/mlx5/restrack.c
+++ b/drivers/infiniband/hw/mlx5/restrack.c
@@ -138,6 +138,14 @@ int mlx5_ib_fill_res_mr_entry(struct sk_buff *msg,
 	return -EMSGSIZE;
 }
 
+int mlx5_ib_fill_res_cq_entry_raw(struct sk_buff *msg, struct ib_cq *ibcq)
+{
+	struct mlx5_ib_dev *dev = to_mdev(ibcq->device);
+	struct mlx5_ib_cq *cq = to_mcq(ibcq);
+
+	return fill_res_raw(msg, dev, MLX5_SGMT_TYPE_PRM_QUERY_CQ, cq->mcq.cqn);
+}
+
 int mlx5_ib_fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ibqp)
 {
 	struct mlx5_ib_dev *dev = to_mdev(ibqp->device);
-- 
2.26.2

