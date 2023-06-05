Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BEA722391
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jun 2023 12:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjFEKdy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jun 2023 06:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjFEKdx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jun 2023 06:33:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A90109
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 03:33:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3839615DA
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 10:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA26C433D2;
        Mon,  5 Jun 2023 10:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685961229;
        bh=PPWTLbpL+f2ai/TredqX3MVrh/oL0bBE+3aIDie/Yqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WAbZBkS5vQ+fQ6WApAcbDnx83JpxnMnBWE36My1gj7CtkP7cR2JVxbBSjInKD8+f5
         bC6EtmyO++rop/cnJr9+eQZvY1wd89BNSrGBAa2hstOks/mHy7aqJc4idRMoq7kLtP
         IyCbwxixNEMnmw6aD4fGgfudKXr617hMrOWWjCe5i+t+r7fsa7hFUnW/jBuNlsIfa/
         xg1m0/kxDvgj/TSoLKovLI/aCZZdWWmq52ebY78Zd6+ZN1jxZnzwDWjVmPgngOzX+M
         K01spuDL0eRFXEm/oS2RybJvSLa+Y8kZAYA/n6kYtYPgDvROWIJk8j1Vpvn9aIFcvp
         bznK0qZ6jsJxQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-rc 03/10] RDMA/mlx5: Fix Q-counters per vport allocation
Date:   Mon,  5 Jun 2023 13:33:19 +0300
Message-Id: <f54671df16e2227a069b229b33b62cd9ee24c475.1685960567.git.leon@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685960567.git.leon@kernel.org>
References: <cover.1685960567.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrisious Haddad <phaddad@nvidia.com>

Previously Q-counters data was being allocated over the PF for all of
the available vports, however that isn't necessary.

Since each VF or SF has a Q-counter allocated for itself.

So we only need to allocate two counters data structures, one for the
device counters, and one for all the other vports to expose the
representors, since they only need to read from it in order to
determine mainly counters numbers and names, so they can all share.

This in turn also solves a bug we previously had where we couldn't
switch the device to switchdev mode when there were more than 128 SF/VFs
configured, since that is the maximum amount of Q-counters available for
a single port

Fixes: d22467a71ebe ("RDMA/mlx5: Expand switchdev Q-counters to expose representor statistics")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/counters.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index 1c06920505d2..3d7ef81a50b8 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -209,7 +209,8 @@ static const struct mlx5_ib_counters *get_counters(struct mlx5_ib_dev *dev,
 	     !vport_qcounters_supported(dev)) || !port_num)
 		return &dev->port[0].cnts;
 
-	return &dev->port[port_num - 1].cnts;
+	return is_mdev_switchdev_mode(dev->mdev) ?
+	       &dev->port[1].cnts : &dev->port[port_num - 1].cnts;
 }
 
 /**
@@ -262,7 +263,7 @@ static struct rdma_hw_stats *
 mlx5_ib_alloc_hw_port_stats(struct ib_device *ibdev, u32 port_num)
 {
 	struct mlx5_ib_dev *dev = to_mdev(ibdev);
-	const struct mlx5_ib_counters *cnts = &dev->port[port_num - 1].cnts;
+	const struct mlx5_ib_counters *cnts = get_counters(dev, port_num);
 
 	return do_alloc_stats(cnts);
 }
@@ -725,11 +726,11 @@ static int __mlx5_ib_alloc_counters(struct mlx5_ib_dev *dev,
 static void mlx5_ib_dealloc_counters(struct mlx5_ib_dev *dev)
 {
 	u32 in[MLX5_ST_SZ_DW(dealloc_q_counter_in)] = {};
-	int num_cnt_ports;
+	int num_cnt_ports = dev->num_ports;
 	int i, j;
 
-	num_cnt_ports = (!is_mdev_switchdev_mode(dev->mdev) ||
-			 vport_qcounters_supported(dev)) ? dev->num_ports : 1;
+	if (is_mdev_switchdev_mode(dev->mdev))
+		num_cnt_ports = min(2, num_cnt_ports);
 
 	MLX5_SET(dealloc_q_counter_in, in, opcode,
 		 MLX5_CMD_OP_DEALLOC_Q_COUNTER);
@@ -761,15 +762,22 @@ static int mlx5_ib_alloc_counters(struct mlx5_ib_dev *dev)
 {
 	u32 out[MLX5_ST_SZ_DW(alloc_q_counter_out)] = {};
 	u32 in[MLX5_ST_SZ_DW(alloc_q_counter_in)] = {};
-	int num_cnt_ports;
+	int num_cnt_ports = dev->num_ports;
 	int err = 0;
 	int i;
 	bool is_shared;
 
 	MLX5_SET(alloc_q_counter_in, in, opcode, MLX5_CMD_OP_ALLOC_Q_COUNTER);
 	is_shared = MLX5_CAP_GEN(dev->mdev, log_max_uctx) != 0;
-	num_cnt_ports = (!is_mdev_switchdev_mode(dev->mdev) ||
-			 vport_qcounters_supported(dev)) ? dev->num_ports : 1;
+
+	/*
+	 * In switchdev we need to allocate two ports, one that is used for
+	 * the device Q_counters and it is essentially the real Q_counters of
+	 * this device, while the other is used as a helper for PF to be able to
+	 * query all other vports.
+	 */
+	if (is_mdev_switchdev_mode(dev->mdev))
+		num_cnt_ports = min(2, num_cnt_ports);
 
 	for (i = 0; i < num_cnt_ports; i++) {
 		err = __mlx5_ib_alloc_counters(dev, &dev->port[i].cnts, i);
-- 
2.40.1

