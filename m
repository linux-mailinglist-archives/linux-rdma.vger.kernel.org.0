Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC4817A56A
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 13:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgCEMk6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 07:40:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:55200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgCEMk6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 07:40:58 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D76E8208C3;
        Thu,  5 Mar 2020 12:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583412057;
        bh=nubjxxS/JY8iIHG32MorrMEV8STAYMZSC6lyCDn751Q=;
        h=From:To:Cc:Subject:Date:From;
        b=gJ/ZR/3KxxHCvmEQHEDSwJ27R/MZa8dTlmWApnlQI5ZcjQ/3azkc6PDMZ4BZ6oHld
         R9e+v7JWYtY4iRWMHxdBsf5otuQN1K79QNOKQSXLq5UgOhkZX4o6+ZmPFFLgdCD8Er
         NWBLMHvsbxv2maiKd/oJQ/l/eBtNP1mDAvjZHOhU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Mark Zhang <markz@mellanox.com>, linux-rdma@vger.kernel.org,
        Majd Dibbiny <majd@mellanox.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Fix the number of hwcounters of a dynamic counter
Date:   Thu,  5 Mar 2020 14:40:52 +0200
Message-Id: <20200305124052.196688-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markz@mellanox.com>

When read the global counter and there's any dynamic counter allocated,
the value of a hwcounter is the sum of the default counter and all
dynamic counters. So the number of hwcounters of a dynamically allocated
counter must be same as of the default counter, otherwise there will
be read violations.

This fixes the KASAN slab-out-of-bounds bug:

[ 1736.292832] ==================================================================
[ 1736.294938] BUG: KASAN: slab-out-of-bounds in rdma_counter_get_hwstat_value+0x36d/0x390 [ib_core]
[ 1736.297071] Read of size 8 at addr ffff8884192a5778 by task rdma/10138
[ 1736.298462]
[ 1736.299257] CPU: 7 PID: 10138 Comm: rdma Not tainted 5.5.0-for-upstream-dbg-2020-02-06_18-30-19-27 #1
[ 1736.301476] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[ 1736.303923] Call Trace:
[ 1736.304771]  dump_stack+0xb7/0x10b
[ 1736.305750]  print_address_description.constprop.4+0x1e2/0x400
[ 1736.307072]  ? rdma_counter_get_hwstat_value+0x36d/0x390 [ib_core]
[ 1736.308429]  __kasan_report+0x15c/0x1e0
[ 1736.309467]  ? mlx5_ib_query_q_counters+0x13f/0x270 [mlx5_ib]
[ 1736.310780]  ? rdma_counter_get_hwstat_value+0x36d/0x390 [ib_core]
[ 1736.312139]  kasan_report+0xe/0x20
[ 1736.313124]  rdma_counter_get_hwstat_value+0x36d/0x390 [ib_core]
[ 1736.314477]  ? rdma_counter_query_stats+0xd0/0xd0 [ib_core]
[ 1736.315742]  ? memcpy+0x34/0x50
[ 1736.316683]  ? nla_put+0xe2/0x170
[ 1736.317665]  nldev_stat_get_doit+0x9c7/0x14f0 [ib_core]
...
[ 1736.350888]  do_syscall_64+0x95/0x490
[ 1736.351901]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1736.353095] RIP: 0033:0x7fcc457fe65a
[ 1736.354089] Code: bb 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 8b 05 fa f1 2b 00 45 89 c9 4c 63 d1 48 63 ff 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 76 f3 c3 0f 1f 40 00 41 55 41 54 4d 89 c5 55
[ 1736.358062] RSP: 002b:00007ffc0586f868 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[ 1736.360021] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcc457fe65a
[ 1736.361490] RDX: 0000000000000020 RSI: 00000000013db920 RDI: 0000000000000003
[ 1736.362967] RBP: 00007ffc0586fa90 R08: 00007fcc45ac10e0 R09: 000000000000000c
[ 1736.364438] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004089c0
[ 1736.365909] R13: 0000000000000000 R14: 00007ffc0586fab0 R15: 00000000013dc9a0
[ 1736.367423]
[ 1736.368139] Allocated by task 9700:
[ 1736.369129]  save_stack+0x19/0x80
[ 1736.370091]  __kasan_kmalloc.constprop.7+0xa0/0xd0
[ 1736.371261]  mlx5_ib_counter_alloc_stats+0xd1/0x1d0 [mlx5_ib]
[ 1736.372557]  rdma_counter_alloc+0x16d/0x3f0 [ib_core]
[ 1736.373758]  rdma_counter_bind_qpn_alloc+0x216/0x4e0 [ib_core]
[ 1736.375067]  nldev_stat_set_doit+0x8c2/0xb10 [ib_core]
[ 1736.376283]  rdma_nl_rcv_msg+0x3d2/0x730 [ib_core]
[ 1736.377451]  rdma_nl_rcv+0x2a8/0x400 [ib_core]
[ 1736.378565]  netlink_unicast+0x448/0x620
[ 1736.379605]  netlink_sendmsg+0x731/0xd10
[ 1736.380649]  sock_sendmsg+0xb1/0xf0
[ 1736.381635]  __sys_sendto+0x25d/0x2c0
[ 1736.382647]  __x64_sys_sendto+0xdd/0x1b0
[ 1736.383694]  do_syscall_64+0x95/0x490
[ 1736.384700]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1736.385897]
...
[ 1736.409522]
[ 1736.410242] The buggy address belongs to the object at ffff8884192a5600
[ 1736.410242]  which belongs to the cache kmalloc-512 of size 512
[ 1736.412928] The buggy address is located 376 bytes inside of
[ 1736.412928]  512-byte region [ffff8884192a5600, ffff8884192a5800)
[ 1736.415511] The buggy address belongs to the page:
[ 1736.416693] page:ffffea001064a800 refcount:1 head refcount:1 mapcount:0 mapping:ffff88841c011300 index:0x0 compound_mapcount:0 compound_pincount:0
[ 1736.419474] raw: 002fffff80010200 ffffea0010173208 ffffea0010034808 ffff88841c011300
[ 1736.421472] raw: 0000000000000000 0000000000150015 00000001ffffffff 0000000000000000
[ 1736.423492] page dumped because: kasan: bad access detected
[ 1736.424787]
[ 1736.425508] Memory state around the buggy address:
[ 1736.426694]  ffff8884192a5600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 1736.428648]  ffff8884192a5680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 1736.430610] >ffff8884192a5700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc
[ 1736.432556]                                                                 ^
[ 1736.434071]  ffff8884192a5780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 1736.436027]  ffff8884192a5800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 1736.437987] ==================================================================
[ 1736.439939] Disabling lock debugging due to kernel taint

Fixes: 18d422ce8ccf ("IB/mlx5: Add counter_alloc_stats() and counter_update_stats() support")
Signed-off-by: Mark Zhang <markz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 4d0780d9114c..1279aeabf651 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -5720,9 +5720,10 @@ mlx5_ib_counter_alloc_stats(struct rdma_counter *counter)
 	const struct mlx5_ib_counters *cnts =
 		get_counters(dev, counter->port - 1);
 
-	/* Q counters are in the beginning of all counters */
 	return rdma_alloc_hw_stats_struct(cnts->names,
-					  cnts->num_q_counters,
+					  cnts->num_q_counters +
+					  cnts->num_cong_counters +
+					  cnts->num_ext_ppcnt_counters,
 					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
 }
 
-- 
2.24.1

