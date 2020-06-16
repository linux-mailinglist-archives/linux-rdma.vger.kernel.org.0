Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F105E1FAE69
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 12:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgFPKqa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 06:46:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgFPKqa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Jun 2020 06:46:30 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E72C520767;
        Tue, 16 Jun 2020 10:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592304389;
        bh=sic7/FYFapc2qvpuSOyNna9wmAzHTunNfgVEhbFCCBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sQF1zAzMSVuZ7A0ttGwf3sJkdcOYno2iwc7L0+o2cSHC6tGd39i/zq7UDGEIDmUwD
         pb77ZaqaUPxPt/fJeVgd6OswLlQSyrRbPKUAlfNCSgwMGpsMULpYf++IRnanbiv2lk
         6p3nadyl8EJPyBxHa6UkxrA9Y67LNlJhlGVIm02M=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 10/11] RDMA/mlx5: Add support to get CQ resource in RAW format
Date:   Tue, 16 Jun 2020 13:40:05 +0300
Message-Id: <20200616104006.2425549-11-leon@kernel.org>
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

