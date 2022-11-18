Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B0762F242
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Nov 2022 11:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbiKRKNw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Nov 2022 05:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241346AbiKRKNu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Nov 2022 05:13:50 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DDE13E39
        for <linux-rdma@vger.kernel.org>; Fri, 18 Nov 2022 02:13:48 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NDCKZ2H5Mz15MhW;
        Fri, 18 Nov 2022 18:13:22 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 18:13:46 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <linux-rdma@vger.kernel.org>, <zhangxiaoxu5@huawei.com>,
        <zyjzyj2000@gmail.com>, <jgg@ziepe.ca>, <leon@kernel.org>,
        <monis@mellanox.com>
Subject: [PATCH] RDMA/rxe: Fix double-free in __rxe_cleanup() when MR allocate failed
Date:   Fri, 18 Nov 2022 19:18:26 +0800
Message-ID: <20221118111826.3558230-1-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is a double free when mount.cifs over rdma with MR allocate failed:

  BUG: KASAN: double-free in __rxe_cleanup+0x101/0x1d0 [rdma_rxe]
  Free of addr ffff88817f8f0a20 by task mount.cifs/28201CPU: 1 PID: 28201 Comm: mount.cifs Not tainted 6.1.0-rc5+ #84
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc33 04/01/2014
  Call Trace:
   dump_stack_lvl+0x34/0x44
   print_report+0x171/0x472
   kasan_report_invalid_free+0x84/0xf0
   ____kasan_slab_free+0x166/0x1b0
   __kmem_cache_free+0xc8/0x330
   __rxe_cleanup+0x101/0x1d0 [rdma_rxe]
   rxe_alloc_mr+0x88/0x90 [rdma_rxe]
   ib_alloc_mr+0x5a/0x1d0
   _smbd_get_connection+0x1c0f/0x21a0
   smbd_get_connection+0x21/0x40
   cifs_get_tcp_session+0x8ef/0xda0
   mount_get_conns+0x60/0x750
   cifs_mount+0x103/0xd00
   cifs_smb3_do_mount+0x1dd/0xcb0
   smb3_get_tree+0x1d5/0x300
   vfs_get_tree+0x41/0xf0
   path_mount+0x9b3/0xdd0
   __x64_sys_mount+0x190/0x1d0
   do_syscall_64+0x35/0x80
   entry_SYSCALL_64_after_hwframe+0x46/0xb0

  Allocated by task 28201:
   kasan_save_stack+0x1e/0x40
   kasan_set_track+0x21/0x30
   __kasan_kmalloc+0x7a/0x90
   __kmalloc+0x5f/0x150
   rxe_mr_alloc+0x5d/0x240 [rdma_rxe]
   rxe_mr_init_fast+0xfd/0x180 [rdma_rxe]
   rxe_alloc_mr+0x64/0x90 [rdma_rxe]
   ib_alloc_mr+0x5a/0x1d0
   _smbd_get_connection+0x1c0f/0x21a0
   smbd_get_connection+0x21/0x40
   cifs_get_tcp_session+0x8ef/0xda0
   mount_get_conns+0x60/0x750
   cifs_mount+0x103/0xd00
   cifs_smb3_do_mount+0x1dd/0xcb0
   smb3_get_tree+0x1d5/0x300
   vfs_get_tree+0x41/0xf0
   path_mount+0x9b3/0xdd0
   __x64_sys_mount+0x190/0x1d0
   do_syscall_64+0x35/0x80
   entry_SYSCALL_64_after_hwframe+0x46/0xb0

  Freed by task 28201:
   kasan_save_stack+0x1e/0x40
   kasan_set_track+0x21/0x30
   kasan_save_free_info+0x2a/0x40
   ____kasan_slab_free+0x143/0x1b0
   __kmem_cache_free+0xc8/0x330
   rxe_mr_alloc+0x16d/0x240 [rdma_rxe]
   rxe_mr_init_fast+0xfd/0x180 [rdma_rxe]
   rxe_alloc_mr+0x64/0x90 [rdma_rxe]
   ib_alloc_mr+0x5a/0x1d0
   _smbd_get_connection+0x1c0f/0x21a0
   smbd_get_connection+0x21/0x40
   cifs_get_tcp_session+0x8ef/0xda0
   mount_get_conns+0x60/0x750
   cifs_mount+0x103/0xd00
   cifs_smb3_do_mount+0x1dd/0xcb0
   smb3_get_tree+0x1d5/0x300
   vfs_get_tree+0x41/0xf0
   path_mount+0x9b3/0xdd0
   __x64_sys_mount+0x190/0x1d0
   do_syscall_64+0x35/0x80
   entry_SYSCALL_64_after_hwframe+0x46/0xb0

When allocate MR failed, the MRs and the array already freed,
but in the cleanup process, free them again.

Let's set the MRs array to NULL when MRs allocate failed to
avoid cleanup process free them again.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 502e9ada99b3..82dd14654686 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -99,6 +99,7 @@ static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf)
 		kfree(mr->map[i]);
 
 	kfree(mr->map);
+	mr->map = NULL;
 err1:
 	return -ENOMEM;
 }
-- 
2.31.1

