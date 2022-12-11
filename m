Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B4C649348
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Dec 2022 10:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiLKJMK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Dec 2022 04:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiLKJMJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Dec 2022 04:12:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AEEE01E
        for <linux-rdma@vger.kernel.org>; Sun, 11 Dec 2022 01:12:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36E5BB8098E
        for <linux-rdma@vger.kernel.org>; Sun, 11 Dec 2022 09:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5997AC433EF;
        Sun, 11 Dec 2022 09:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670749922;
        bh=elQASSlUEfJsF+lbsJJ2DNKcOsUDqN7CEK5P/rjHsTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f7MID88Cqqk1jHTXMrp2k+5NJhtwp0fupLd4JgFI0EBne4CpqiX5MUsd9/JnKJOlt
         +5qnVmSCo3Wau9SyoH7m5wddyI86TU3ZBT5AdBCQtnKjfDonqd5YgvCmpjFIyMFgbO
         52oWqK6t3PpKF1NPv+T+DYOtrq1jJeyP6CZqM3CxgMkHZ7P1BvA+vOMvEtppAjQMQS
         +xUKHulfXL9bbKZ5hiZSnbmfQu0kxbBDjUb8NwifH0Gm77L5qpexjokIlxZQYg05qa
         I3tRB2gveWxZyXcApAbOntY/lYH2s+q/9lOxgvaem7gHFkBvrjUI32TrWyk2FLOirZ
         0BJdO6KdgjdNA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Shay Drory <shayd@nvidia.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        linux-rdma@vger.kernel.org, Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-next 1/2] RDMA/mlx5: Fix mlx5_ib_get_hw_stats when used for device
Date:   Sun, 11 Dec 2022 11:11:51 +0200
Message-Id: <ab402f83f04f4a41ffb177583609909c86cef52a.1670749789.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1670749789.git.leonro@nvidia.com>
References: <cover.1670749789.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shay Drory <shayd@nvidia.com>

Currently, when mlx5_ib_get_hw_stats() is used for device (port_num = 0),
there is a special handling in order to use the correct counters, but,
port_num is being passed down the stack without any change.
Also, some functions assume that port_num >=1. As a result, the
following oops can occur.

 BUG: unable to handle page fault for address: ffff89510294f1a8
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 PGD 0 P4D 0
 Oops: 0002 [#1] SMP
 CPU: 8 PID: 1382 Comm: devlink Tainted: G W          6.1.0-rc4_for_upstream_base_2022_11_10_16_12 #1
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 RIP: 0010:_raw_spin_lock+0xc/0x20
 Call Trace:
  <TASK>
  mlx5_ib_get_native_port_mdev+0x73/0xe0 [mlx5_ib]
  do_get_hw_stats.constprop.0+0x109/0x160 [mlx5_ib]
  mlx5_ib_get_hw_stats+0xad/0x180 [mlx5_ib]
  ib_setup_device_attrs+0xf0/0x290 [ib_core]
  ib_register_device+0x3bb/0x510 [ib_core]
  ? atomic_notifier_chain_register+0x67/0x80
  __mlx5_ib_add+0x2b/0x80 [mlx5_ib]
  mlx5r_probe+0xb8/0x150 [mlx5_ib]
  ? auxiliary_match_id+0x6a/0x90
  auxiliary_bus_probe+0x3c/0x70
  ? driver_sysfs_add+0x6b/0x90
  really_probe+0xcd/0x380
  __driver_probe_device+0x80/0x170
  driver_probe_device+0x1e/0x90
  __device_attach_driver+0x7d/0x100
  ? driver_allows_async_probing+0x60/0x60
  ? driver_allows_async_probing+0x60/0x60
  bus_for_each_drv+0x7b/0xc0
  __device_attach+0xbc/0x200
  bus_probe_device+0x87/0xa0
  device_add+0x404/0x940
  ? dev_set_name+0x53/0x70
  __auxiliary_device_add+0x43/0x60
  add_adev+0x99/0xe0 [mlx5_core]
  mlx5_attach_device+0xc8/0x120 [mlx5_core]
  mlx5_load_one_devl_locked+0xb2/0xe0 [mlx5_core]
  devlink_reload+0x133/0x250
  devlink_nl_cmd_reload+0x480/0x570
  ? devlink_nl_pre_doit+0x44/0x2b0
  genl_family_rcv_msg_doit.isra.0+0xc2/0x110
  genl_rcv_msg+0x180/0x2b0
  ? devlink_nl_cmd_region_read_dumpit+0x540/0x540
  ? devlink_reload+0x250/0x250
  ? devlink_put+0x50/0x50
  ? genl_family_rcv_msg_doit.isra.0+0x110/0x110
  netlink_rcv_skb+0x54/0x100
  genl_rcv+0x24/0x40
  netlink_unicast+0x1f6/0x2c0
  netlink_sendmsg+0x237/0x490
  sock_sendmsg+0x33/0x40
  __sys_sendto+0x103/0x160
  ? handle_mm_fault+0x10e/0x290
  ? do_user_addr_fault+0x1c0/0x5f0
  __x64_sys_sendto+0x25/0x30
  do_syscall_64+0x3d/0x90
  entry_SYSCALL_64_after_hwframe+0x46/0xb0

Fix it by setting port_num to 1 in order to get device status and
remove unused variable.

Fixes: aac4492ef23a ("IB/mlx5: Update counter implementation for dual port RoCE")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/counters.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index 945758f39523..3e1272695d99 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -278,7 +278,6 @@ static int do_get_hw_stats(struct ib_device *ibdev,
 	const struct mlx5_ib_counters *cnts = get_counters(dev, port_num - 1);
 	struct mlx5_core_dev *mdev;
 	int ret, num_counters;
-	u32 mdev_port_num;
 
 	if (!stats)
 		return -EINVAL;
@@ -299,8 +298,9 @@ static int do_get_hw_stats(struct ib_device *ibdev,
 	}
 
 	if (MLX5_CAP_GEN(dev->mdev, cc_query_allowed)) {
-		mdev = mlx5_ib_get_native_port_mdev(dev, port_num,
-						    &mdev_port_num);
+		if (!port_num)
+			port_num = 1;
+		mdev = mlx5_ib_get_native_port_mdev(dev, port_num, NULL);
 		if (!mdev) {
 			/* If port is not affiliated yet, its in down state
 			 * which doesn't have any counters yet, so it would be
-- 
2.38.1

