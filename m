Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2B7216B0E
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 13:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgGGLGZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 07:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbgGGLGY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Jul 2020 07:06:24 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7344206B6;
        Tue,  7 Jul 2020 11:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594119984;
        bh=E8oXlYVkj5L/scxBk4kqVZ6RFmt6Da6h4jJqZQKWEdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j2M8Zv5S8DeLBbapPfunTGA+mmYqfmYmRrz1cU+jIQlBX+64WtBRXi0hoViTdI2jM
         faJiHWISlZek9GhYGPOHp/hOCAQ1U5QZe/GIn2Bgg+PhEq/mpsTNlRtRR7q0wQGiM9
         dOvqpxjnnxgw3fdNny799b0fwjmJcTyuk6LFgV1k=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Aya Levin <ayal@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        linux-rdma@vger.kernel.org, Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH rdma-rc 2/3] IB/mlx5: Fix 50G per lane indication
Date:   Tue,  7 Jul 2020 14:06:11 +0300
Message-Id: <20200707110612.882962-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707110612.882962-1-leon@kernel.org>
References: <20200707110612.882962-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aya Levin <ayal@mellanox.com>

Some released FW versions mistakenly don't set the capability that 50G
per lane link-modes are supported for VFs (ptys_extended_ethernet
capability bit). Use PTYS.ext_eth_proto_capability instead, as this
indication is always accurate. If PTYS.ext_eth_proto_capability is valid
(has a non-zero value) conclude that the HCA supports 50G per lane.
Otherwise, conclude that the HCA doesn't support 50G per lane.

Fixes: 08e8676f1607 ("IB/mlx5: Add support for 50Gbps per lane link modes")
Signed-off-by: Aya Levin <ayal@mellanox.com>
Reviewed-by: Eran Ben Elisha <eranbe@mellanox.com>
Reviewed-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 343a8b8361e7..6f99ed03d88e 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -511,7 +511,7 @@ static int mlx5_query_port_roce(struct ib_device *device, u8 port_num,
 					   mdev_port_num);
 	if (err)
 		goto out;
-	ext = MLX5_CAP_PCAM_FEATURE(dev->mdev, ptys_extended_ethernet);
+	ext = !!MLX5_GET_ETH_PROTO(ptys_reg, out, true, eth_proto_capability);
 	eth_prot_oper = MLX5_GET_ETH_PROTO(ptys_reg, out, ext, eth_proto_oper);
 
 	props->active_width     = IB_WIDTH_4X;
-- 
2.26.2

