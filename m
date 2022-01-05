Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34743484F91
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 09:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbiAEIup (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 03:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238631AbiAEIup (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 03:50:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99E9C061761;
        Wed,  5 Jan 2022 00:50:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B3F6B81897;
        Wed,  5 Jan 2022 08:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AA7C36AEB;
        Wed,  5 Jan 2022 08:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641372641;
        bh=NWItqzRosP/nfGacRSd56C+VNit3vn5P+K8pXexOoHM=;
        h=From:To:Cc:Subject:Date:From;
        b=X2SIQg4Ak/VA0+68DfEc2+k1WAkF50yUnJF9TaYshb/CjkHzIe/NF3bZU5/2miHv4
         ers6wzY3F5ZIzrJRvnV7PEuYpenXe4oqxSvRk0EB9u08Ynus63glO+WC9v1qqXPZNM
         jVASwXIdA8ytucCzD8JlHsta5oq1g5BIiNdzEXgVV9nRWiVj22pyVE3mA+T/Qj8B7m
         fKbF5KNMMZTixJnPYePeMC1Kb8LfEk+d3FFB6/hylX8TgxG3NeYl/bLYWFezXRot81
         Vnl/UPfEFiCiEcnBcq/rM+fPJJyV++z6HhhBXT2Ave9m1rjpyTQbTTraYuhJLgm9DM
         UnvHJCiXtGg3Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next] RDMA/rxe: Delete deprecated module parameters interface
Date:   Wed,  5 Jan 2022 10:50:35 +0200
Message-Id: <c8376d7517aebe7cc851f0baaeef7b13707cf767.1641372460.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Starting from the commit 66920e1b2586 ("rdma_rxe: Use netlink messages
to add/delete links") from the 2019, the RXE modules parameters are marked
as deprecated in favour of rdmatool. So remove the kernel code too.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/sw/rxe/Makefile    |   1 -
 drivers/infiniband/sw/rxe/rxe.c       |   4 -
 drivers/infiniband/sw/rxe/rxe.h       |   2 -
 drivers/infiniband/sw/rxe/rxe_sysfs.c | 119 --------------------------
 4 files changed, 126 deletions(-)
 delete mode 100644 drivers/infiniband/sw/rxe/rxe_sysfs.c

diff --git a/drivers/infiniband/sw/rxe/Makefile b/drivers/infiniband/sw/rxe/Makefile
index 1e24673e9318..5395a581f4bb 100644
--- a/drivers/infiniband/sw/rxe/Makefile
+++ b/drivers/infiniband/sw/rxe/Makefile
@@ -22,5 +22,4 @@ rdma_rxe-y := \
 	rxe_mcast.o \
 	rxe_task.o \
 	rxe_net.o \
-	rxe_sysfs.o \
 	rxe_hw_counters.o
diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 8e0f9c489cab..fab291245366 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -13,8 +13,6 @@ MODULE_AUTHOR("Bob Pearson, Frank Zago, John Groves, Kamal Heib");
 MODULE_DESCRIPTION("Soft RDMA transport");
 MODULE_LICENSE("Dual BSD/GPL");
 
-bool rxe_initialized;
-
 /* free resources for a rxe device all objects created for this device must
  * have been destroyed
  */
@@ -290,7 +288,6 @@ static int __init rxe_module_init(void)
 		return err;
 
 	rdma_link_register(&rxe_link_ops);
-	rxe_initialized = true;
 	pr_info("loaded\n");
 	return 0;
 }
@@ -301,7 +298,6 @@ static void __exit rxe_module_exit(void)
 	ib_unregister_driver(RDMA_DRIVER_RXE);
 	rxe_net_exit();
 
-	rxe_initialized = false;
 	pr_info("unloaded\n");
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index 1bb3fb618bf5..fb9066e6f5f0 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -39,8 +39,6 @@
 
 #define RXE_ROCE_V2_SPORT		(0xc000)
 
-extern bool rxe_initialized;
-
 void rxe_set_mtu(struct rxe_dev *rxe, unsigned int dev_mtu);
 
 int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name);
diff --git a/drivers/infiniband/sw/rxe/rxe_sysfs.c b/drivers/infiniband/sw/rxe/rxe_sysfs.c
deleted file mode 100644
index 666202ddff48..000000000000
--- a/drivers/infiniband/sw/rxe/rxe_sysfs.c
+++ /dev/null
@@ -1,119 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
-/*
- * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
- * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- */
-
-#include "rxe.h"
-#include "rxe_net.h"
-
-/* Copy argument and remove trailing CR. Return the new length. */
-static int sanitize_arg(const char *val, char *intf, int intf_len)
-{
-	int len;
-
-	if (!val)
-		return 0;
-
-	/* Remove newline. */
-	for (len = 0; len < intf_len - 1 && val[len] && val[len] != '\n'; len++)
-		intf[len] = val[len];
-	intf[len] = 0;
-
-	if (len == 0 || (val[len] != 0 && val[len] != '\n'))
-		return 0;
-
-	return len;
-}
-
-static int rxe_param_set_add(const char *val, const struct kernel_param *kp)
-{
-	int len;
-	int err = 0;
-	char intf[32];
-	struct net_device *ndev;
-	struct rxe_dev *exists;
-
-	if (!rxe_initialized) {
-		pr_err("Module parameters are not supported, use rdma link add or rxe_cfg\n");
-		return -EAGAIN;
-	}
-
-	len = sanitize_arg(val, intf, sizeof(intf));
-	if (!len) {
-		pr_err("add: invalid interface name\n");
-		return -EINVAL;
-	}
-
-	ndev = dev_get_by_name(&init_net, intf);
-	if (!ndev) {
-		pr_err("interface %s not found\n", intf);
-		return -EINVAL;
-	}
-
-	if (is_vlan_dev(ndev)) {
-		pr_err("rxe creation allowed on top of a real device only\n");
-		err = -EPERM;
-		goto err;
-	}
-
-	exists = rxe_get_dev_from_net(ndev);
-	if (exists) {
-		ib_device_put(&exists->ib_dev);
-		pr_err("already configured on %s\n", intf);
-		err = -EINVAL;
-		goto err;
-	}
-
-	err = rxe_net_add("rxe%d", ndev);
-	if (err) {
-		pr_err("failed to add %s\n", intf);
-		goto err;
-	}
-
-err:
-	dev_put(ndev);
-	return err;
-}
-
-static int rxe_param_set_remove(const char *val, const struct kernel_param *kp)
-{
-	int len;
-	char intf[32];
-	struct ib_device *ib_dev;
-
-	len = sanitize_arg(val, intf, sizeof(intf));
-	if (!len) {
-		pr_err("add: invalid interface name\n");
-		return -EINVAL;
-	}
-
-	if (strncmp("all", intf, len) == 0) {
-		pr_info("rxe_sys: remove all");
-		ib_unregister_driver(RDMA_DRIVER_RXE);
-		return 0;
-	}
-
-	ib_dev = ib_device_get_by_name(intf, RDMA_DRIVER_RXE);
-	if (!ib_dev) {
-		pr_err("not configured on %s\n", intf);
-		return -EINVAL;
-	}
-
-	ib_unregister_device_and_put(ib_dev);
-
-	return 0;
-}
-
-static const struct kernel_param_ops rxe_add_ops = {
-	.set = rxe_param_set_add,
-};
-
-static const struct kernel_param_ops rxe_remove_ops = {
-	.set = rxe_param_set_remove,
-};
-
-module_param_cb(add, &rxe_add_ops, NULL, 0200);
-MODULE_PARM_DESC(add, "DEPRECATED.  Create RXE device over network interface");
-module_param_cb(remove, &rxe_remove_ops, NULL, 0200);
-MODULE_PARM_DESC(remove, "DEPRECATED.  Remove RXE device over network interface");
-- 
2.33.1

