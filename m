Return-Path: <linux-rdma+bounces-13983-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C3DBFDD16
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 20:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098A43A4C36
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 18:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC30E337B99;
	Wed, 22 Oct 2025 18:25:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D48F33FE22;
	Wed, 22 Oct 2025 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157540; cv=none; b=cU8WdKWH9iF9sN8/JmCzaiYap80IODkteF75H7Oe4T1Ri9sgqgbbgGYaOWdAFme+SJbhNkAKaBalcBIeGNUUXloemj8aI92kJlEw9wTYFVnO3FSQSPakUoD9lmvgl4bmYhUsythuq/yqEahH+e0dR0viLNC9xa92PuPBiybDWoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157540; c=relaxed/simple;
	bh=xkE2FLw+RuZ4Eyk+yxOUlF6mM+Yrv8yn88+mMUlIefc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JEyXAoCf+6Q6M75YhFS41V9n5/SCo2v9EMUD9mj2J54mW/whwSqBDI64lSfYr1e4LJSHs+2AVTCht0jNdNqV+iznTpw461MJzAHPwcgp2wb7U33sD3zwSXvhMtGwsm4OdFp4UX9iA1GKzNnwuy56ajcrf8+tfAVSOnuEdMHyeZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 0D41023374;
	Wed, 22 Oct 2025 21:25:31 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Leon Romanovsky <leon@kernel.org>,
	Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10.y] RDMA/mlx5: Fix mlx5_ib_get_hw_stats when used for device
Date: Wed, 22 Oct 2025 21:25:29 +0300
Message-Id: <20251022182529.211983-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shay Drory <shayd@nvidia.com>

commit 38b50aa44495d5eb4218f0b82fc2da76505cec53 upstream.

Currently, when mlx5_ib_get_hw_stats() is used for device (port_num = 0),
there is a special handling in order to use the correct counters, but,
port_num is being passed down the stack without any change.  Also, some
functions assume that port_num >=1. As a result, the following oops can
occur.

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

Fix it by setting port_num to 1 in order to get device status and remove
unused variable.

Fixes: aac4492ef23a ("IB/mlx5: Update counter implementation for dual port RoCE")
Link: https://lore.kernel.org/r/98b82994c3cd3fa593b8a75ed3f3901e208beb0f.1672231736.git.leonro@nvidia.com
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
[ kovalev: bp to fix CVE-2023-53393 ]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/infiniband/hw/mlx5/counters.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index 33636268d43d..29b38cf055be 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -249,7 +249,6 @@ static int mlx5_ib_get_hw_stats(struct ib_device *ibdev,
 	const struct mlx5_ib_counters *cnts = get_counters(dev, port_num - 1);
 	struct mlx5_core_dev *mdev;
 	int ret, num_counters;
-	u8 mdev_port_num;
 
 	if (!stats)
 		return -EINVAL;
@@ -270,8 +269,9 @@ static int mlx5_ib_get_hw_stats(struct ib_device *ibdev,
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
2.50.1


