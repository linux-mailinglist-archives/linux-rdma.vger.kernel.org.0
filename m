Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0B4722396
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jun 2023 12:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjFEKeU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jun 2023 06:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjFEKeP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jun 2023 06:34:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0BE11A
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 03:33:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B0D260F07
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 10:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2854EC433D2;
        Mon,  5 Jun 2023 10:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685961237;
        bh=ghakADF3Do4ns/JpwVP8ei3W2KNCAGymf7RU8bSQmHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mcz3CJifsxpGR6k90e+zzYwBgUXQuD7X5DPMT5nAhS2k7gfLm4mabf1X23pTeQUQL
         xPK0Z7T+ia3uzfa56M7gxfq0e/FYY8quef0gULrH4FXDd8euH9zHrDqkDw66AePnhF
         C+AmrNCfBRoO5DIF0Kuzvr8fFXKM0+tcV9nQwQ8Nd2S24oJSYhQnh/a5vZGxUwvKgs
         pD2JsqgV6GasHEYLJ5+jKJEfWXfWOXeSVsZ7mxa6sbPw4UL6c1qaQ4EFzVjmvKtIYM
         hJqiTHnCo2TClxui7FIfXKnbHZoenVK0aZm2E526IvPj3+NESj3CtS9oZ/QJXjXLGU
         hk87YIKqR5WVw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-rc 04/10] RDMA/mlx5: Remove vport Q-counters dependency on normal Q-counters
Date:   Mon,  5 Jun 2023 13:33:20 +0300
Message-Id: <016777b7f16eb6bb178999ff59097d0c0f91f68a.1685960567.git.leon@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685960567.git.leon@kernel.org>
References: <cover.1685960567.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrisious Haddad <phaddad@nvidia.com>

Previously the Q-counters initialization assumed that the vport Q-counters
structures and the normal Q-counters structures are identical in size,
and hence when a Q-counter was added to normal Q-counters structure but
not to the vport Q-counters struct it would lead to that counter name
being NULL in switchdev mode, which could cause the kernel crash below.

Currently break the dependency between those two structure and always
use the appropriate struct size, in order to remove the assumption
that both structure sizes are equal.

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 20c64a067 P4D 20c64a067 PUD 20152b067 PMD 0
 Oops: 0000 [#1] SMP
 CPU: 19 PID: 11717 Comm: devlink Tainted: G           OE      6.2.0_mlnx #1
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 RIP: 0010:strlen+0x0/0x20
 Code: 66 2e 0f 1f 84 00 00 00 00 00 48 01 fe eb 0f 0f b6 07 38 d0 74 10 48 83 c7 01 84 c0 74 05 48 39 f7 75 ec 31 c0 c3 48 89 f8 c3 <80> 3f 00 48 89 f8 74 10 48 83 c7 01 80 3f 00 75 f7 48 29 c7 48 89
 RSP: 0018:ffffc9000318b618 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000002c00
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
 RBP: 0000000000000000 R08: ffff888211918110 R09: ffff888211918000
 R10: 000000000000001e R11: ffff888211918000 R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000000 R15: ffff8881038ec250
 FS:  00007fa53342fe80(0000) GS:ffff88885fcc0000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 00000002042b2003 CR4: 0000000000770ee0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  <TASK>
  kernfs_name_hash+0x12/0x80
  kernfs_find_ns+0x35/0xb0
  kernfs_remove_by_name_ns+0x46/0xc0
  remove_files.isra.1+0x30/0x70
  internal_create_group+0x253/0x380
  internal_create_groups.part.4+0x3e/0xa0
  setup_port+0x27a/0x8c0 [ib_core]
  ib_setup_port_attrs+0x9d/0x300 [ib_core]
  ib_register_device+0x48e/0x550 [ib_core]
  __mlx5_ib_add+0x2b/0x80 [mlx5_ib]
  mlx5_ib_vport_rep_load+0x141/0x360 [mlx5_ib]
  mlx5_esw_offloads_rep_load+0x48/0xa0 [mlx5_core]
  esw_offloads_enable+0x41e/0xd10 [mlx5_core]
  mlx5_eswitch_enable_locked+0x1e3/0x340 [mlx5_core]
  ? __cond_resched+0x15/0x30
  mlx5_devlink_eswitch_mode_set+0x204/0x3c0 [mlx5_core]
  devlink_nl_cmd_eswitch_set_doit+0x8d/0x100
  genl_family_rcv_msg_doit.isra.19+0xea/0x110
  genl_rcv_msg+0x19b/0x290
  ? devlink_nl_cmd_region_read_dumpit+0x760/0x760
  ? devlink_nl_cmd_port_param_get_doit+0x30/0x30
  ? devlink_put+0x50/0x50
  ? genl_get_cmd_both+0x60/0x60
  netlink_rcv_skb+0x54/0x100
  genl_rcv+0x24/0x40
  netlink_unicast+0x1be/0x2a0
  netlink_sendmsg+0x361/0x4d0
  sock_sendmsg+0x30/0x40
  __sys_sendto+0x11a/0x150
  ? handle_mm_fault+0x101/0x2b0
  ? do_user_addr_fault+0x21d/0x720
  __x64_sys_sendto+0x24/0x30
  do_syscall_64+0x34/0x80
  entry_SYSCALL_64_after_hwframe+0x46/0xb0
 RIP: 0033:0x7fa533611cba
 Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 76 c3 0f 1f 44 00 00 55 48 83 ec 30 44 89 4c
 RSP: 002b:00007ffdb6a898a8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
 RAX: ffffffffffffffda RBX: 0000000000daab00 RCX: 00007fa533611cba
 RDX: 0000000000000038 RSI: 0000000000daab00 RDI: 0000000000000003
 RBP: 0000000000daa910 R08: 00007fa533822000 R09: 000000000000000c
 R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
  </TASK>
 Modules linked in: rdma_ucm(OE) rdma_cm(OE) iw_cm(OE) ib_ipoib(OE) ib_cm(OE) ib_umad(OE) mlx5_ib(OE) mlx5_core(OE) mlxdevm(OE) ib_uverbs(OE) ib_core(OE) mlx_compat(OE) mlxfw(OE) memtrack(OE) pci_hyperv_intf nfsv3 nfs_acl rpcsec_gss_krb5 auth_rpcgss nfsv4 xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_filter iptable_nat dns_resolver nf_nat br_netfilter nfs bridge stp llc lockd grace fscache netfs rfkill overlay iTCO_wdt iTCO_vendor_support kvm_intel kvm irqbypass crc32_pclmul ghash_clmulni_intel i2c_i801 sunrpc lpc_ich sha512_ssse3 pcspkr i2c_smbus mfd_core drm sch_fq_codel i2c_core ip_tables fuse crc32c_intel serio_raw virtio_net net_failover failover [last unloaded: mlxfw]
 CR2: 0000000000000000
 ---[ end trace 0000000000000000 ]---
 RIP: 0010:strlen+0x0/0x20
 Code: 66 2e 0f 1f 84 00 00 00 00 00 48 01 fe eb 0f 0f b6 07 38 d0 74 10 48 83 c7 01 84 c0 74 05 48 39 f7 75 ec 31 c0 c3 48 89 f8 c3 <80> 3f 00 48 89 f8 74 10 48 83 c7 01 80 3f 00 75 f7 48 29 c7 48 89
 RSP: 0018:ffffc9000318b618 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000002c00
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
 RBP: 0000000000000000 R08: ffff888211918110 R09: ffff888211918000
 R10: 000000000000001e R11: ffff888211918000 R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000000 R15: ffff8881038ec250
 FS:  00007fa53342fe80(0000) GS:ffff88885fcc0000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 00000002042b2003 CR4: 0000000000770ee0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Kernel panic - not syncing: Fatal exception
 Kernel Offset: disabled
 ---[ end Kernel panic - not syncing: Fatal exception ]---

Fixes: d22467a71ebe ("RDMA/mlx5: Expand switchdev Q-counters to expose representor statistics")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/counters.c | 58 ++++++++++++++++++---------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index 3d7ef81a50b8..f40d9c61e30b 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -576,43 +576,53 @@ static void mlx5_ib_fill_counters(struct mlx5_ib_dev *dev,
 	bool is_vport = is_mdev_switchdev_mode(dev->mdev) &&
 			port_num != MLX5_VPORT_PF;
 	const struct mlx5_ib_counter *names;
-	int j = 0, i;
+	int j = 0, i, size;
 
 	names = is_vport ? vport_basic_q_cnts : basic_q_cnts;
-	for (i = 0; i < ARRAY_SIZE(basic_q_cnts); i++, j++) {
+	size = is_vport ? ARRAY_SIZE(vport_basic_q_cnts) :
+			  ARRAY_SIZE(basic_q_cnts);
+	for (i = 0; i < size; i++, j++) {
 		descs[j].name = names[i].name;
-		offsets[j] = basic_q_cnts[i].offset;
+		offsets[j] = names[i].offset;
 	}
 
 	names = is_vport ? vport_out_of_seq_q_cnts : out_of_seq_q_cnts;
+	size = is_vport ? ARRAY_SIZE(vport_out_of_seq_q_cnts) :
+			  ARRAY_SIZE(out_of_seq_q_cnts);
 	if (MLX5_CAP_GEN(dev->mdev, out_of_seq_cnt)) {
-		for (i = 0; i < ARRAY_SIZE(out_of_seq_q_cnts); i++, j++) {
+		for (i = 0; i < size; i++, j++) {
 			descs[j].name = names[i].name;
-			offsets[j] = out_of_seq_q_cnts[i].offset;
+			offsets[j] = names[i].offset;
 		}
 	}
 
 	names = is_vport ? vport_retrans_q_cnts : retrans_q_cnts;
+	size = is_vport ? ARRAY_SIZE(vport_retrans_q_cnts) :
+			  ARRAY_SIZE(retrans_q_cnts);
 	if (MLX5_CAP_GEN(dev->mdev, retransmission_q_counters)) {
-		for (i = 0; i < ARRAY_SIZE(retrans_q_cnts); i++, j++) {
+		for (i = 0; i < size; i++, j++) {
 			descs[j].name = names[i].name;
-			offsets[j] = retrans_q_cnts[i].offset;
+			offsets[j] = names[i].offset;
 		}
 	}
 
 	names = is_vport ? vport_extended_err_cnts : extended_err_cnts;
+	size = is_vport ? ARRAY_SIZE(vport_extended_err_cnts) :
+			  ARRAY_SIZE(extended_err_cnts);
 	if (MLX5_CAP_GEN(dev->mdev, enhanced_error_q_counters)) {
-		for (i = 0; i < ARRAY_SIZE(extended_err_cnts); i++, j++) {
+		for (i = 0; i < size; i++, j++) {
 			descs[j].name = names[i].name;
-			offsets[j] = extended_err_cnts[i].offset;
+			offsets[j] = names[i].offset;
 		}
 	}
 
 	names = is_vport ? vport_roce_accl_cnts : roce_accl_cnts;
+	size = is_vport ? ARRAY_SIZE(vport_roce_accl_cnts) :
+			  ARRAY_SIZE(roce_accl_cnts);
 	if (MLX5_CAP_GEN(dev->mdev, roce_accl)) {
-		for (i = 0; i < ARRAY_SIZE(roce_accl_cnts); i++, j++) {
+		for (i = 0; i < size; i++, j++) {
 			descs[j].name = names[i].name;
-			offsets[j] = roce_accl_cnts[i].offset;
+			offsets[j] = names[i].offset;
 		}
 	}
 
@@ -662,25 +672,37 @@ static void mlx5_ib_fill_counters(struct mlx5_ib_dev *dev,
 static int __mlx5_ib_alloc_counters(struct mlx5_ib_dev *dev,
 				    struct mlx5_ib_counters *cnts, u32 port_num)
 {
-	u32 num_counters, num_op_counters = 0;
+	bool is_vport = is_mdev_switchdev_mode(dev->mdev) &&
+			port_num != MLX5_VPORT_PF;
+	u32 num_counters, num_op_counters = 0, size;
 
-	num_counters = ARRAY_SIZE(basic_q_cnts);
+	size = is_vport ? ARRAY_SIZE(vport_basic_q_cnts) :
+			  ARRAY_SIZE(basic_q_cnts);
+	num_counters = size;
 
+	size = is_vport ? ARRAY_SIZE(vport_out_of_seq_q_cnts) :
+			  ARRAY_SIZE(out_of_seq_q_cnts);
 	if (MLX5_CAP_GEN(dev->mdev, out_of_seq_cnt))
-		num_counters += ARRAY_SIZE(out_of_seq_q_cnts);
+		num_counters += size;
 
+	size = is_vport ? ARRAY_SIZE(vport_retrans_q_cnts) :
+			  ARRAY_SIZE(retrans_q_cnts);
 	if (MLX5_CAP_GEN(dev->mdev, retransmission_q_counters))
-		num_counters += ARRAY_SIZE(retrans_q_cnts);
+		num_counters += size;
 
+	size = is_vport ? ARRAY_SIZE(vport_extended_err_cnts) :
+			  ARRAY_SIZE(extended_err_cnts);
 	if (MLX5_CAP_GEN(dev->mdev, enhanced_error_q_counters))
-		num_counters += ARRAY_SIZE(extended_err_cnts);
+		num_counters += size;
 
+	size = is_vport ? ARRAY_SIZE(vport_roce_accl_cnts) :
+			  ARRAY_SIZE(roce_accl_cnts);
 	if (MLX5_CAP_GEN(dev->mdev, roce_accl))
-		num_counters += ARRAY_SIZE(roce_accl_cnts);
+		num_counters += size;
 
 	cnts->num_q_counters = num_counters;
 
-	if (is_mdev_switchdev_mode(dev->mdev) && port_num != MLX5_VPORT_PF)
+	if (is_vport)
 		goto skip_non_qcounters;
 
 	if (MLX5_CAP_GEN(dev->mdev, cc_query_allowed)) {
-- 
2.40.1

