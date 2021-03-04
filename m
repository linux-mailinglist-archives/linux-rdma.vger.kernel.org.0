Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F8532D37D
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Mar 2021 13:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhCDMqK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Mar 2021 07:46:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:39834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231272AbhCDMqG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Mar 2021 07:46:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16C0964EE1;
        Thu,  4 Mar 2021 12:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614861925;
        bh=MM5KvIq+yS7a0VoyiGg43VWuXPoh2WyHvklJ4/KD3Jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dh7d1RhdlTM1Vd3zPlSVssbD3/e3Zjyu3Aln/JkDWGQizH5PXUBmePpWLsYLm42Um
         iYncL1nME95tgErRMFxAJvyi6DHvZA0/qbUr2iC9rRZ+wuH1BvVf7o1nbzRpEEdauD
         WZnEiiklRe5qsCKAatt8uJb4bmeF7GXoVdoQCF1ilnxb35kuE0mmxhfBSregwv+C8O
         2H7JgUGvcspZqF/NEK65/WjkvkNA1xAIb/PaYKZJWMvYrzApT9tMPfdt8WClpS8Gy5
         gnT8M8ynZ7zjzcyfJ+24iZ1oMHpEy20+7sqC6wSQvpu93JK25HgAcum6ahfPDEpejY
         y/Mr+r5BV5QjA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 1/3] RDMA/mlx5: Fix query RoCE port
Date:   Thu,  4 Mar 2021 14:45:15 +0200
Message-Id: <20210304124517.1100608-2-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304124517.1100608-1-leon@kernel.org>
References: <20210304124517.1100608-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

mlx5_is_roce_enabled returns the devlink RoCE init value, therefore
it should be used only when driver is loaded.
Instead we just need to read the roce_en field.

In addition, rename mlx5_is_roce_enabled to mlx5_is_roce_init_enabled.

Fixes: 7a58779edd75 ("IB/mlx5: Improve query port for representor port")
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 6 +++---
 include/linux/mlx5/driver.h       | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index b42b5d39a88e..aa3e90594a88 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -499,7 +499,7 @@ static int mlx5_query_port_roce(struct ib_device *device, u32 port_num,
 	translate_eth_proto_oper(eth_prot_oper, &props->active_speed,
 				 &props->active_width, ext);

-	if (!dev->is_rep && mlx5_is_roce_enabled(mdev)) {
+	if (!dev->is_rep && dev->mdev->roce.roce_en) {
 		u16 qkey_viol_cntr;

 		props->port_cap_flags |= IB_PORT_CM_SUP;
@@ -4175,7 +4175,7 @@ static int mlx5_ib_roce_init(struct mlx5_ib_dev *dev)

 		/* Register only for native ports */
 		err = mlx5_add_netdev_notifier(dev, port_num);
-		if (err || dev->is_rep || !mlx5_is_roce_enabled(mdev))
+		if (err || dev->is_rep || !mlx5_is_roce_init_enabled(mdev))
 			/*
 			 * We don't enable ETH interface for
 			 * 1. IB representors
@@ -4712,7 +4712,7 @@ static int mlx5r_probe(struct auxiliary_device *adev,
 	dev->mdev = mdev;
 	dev->num_ports = num_ports;

-	if (ll == IB_LINK_LAYER_ETHERNET && !mlx5_is_roce_enabled(mdev))
+	if (ll == IB_LINK_LAYER_ETHERNET && !mlx5_is_roce_init_enabled(mdev))
 		profile = &raw_eth_profile;
 	else
 		profile = &pf_profile;
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 53b89631a1d9..ab07f09f2bad 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1226,7 +1226,7 @@ enum {
 	MLX5_TRIGGERED_CMD_COMP = (u64)1 << 32,
 };

-static inline bool mlx5_is_roce_enabled(struct mlx5_core_dev *dev)
+static inline bool mlx5_is_roce_init_enabled(struct mlx5_core_dev *dev)
 {
 	struct devlink *devlink = priv_to_devlink(dev);
 	union devlink_param_value val;
--
2.29.2

