Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0D7649344
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Dec 2022 10:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiLKJIk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Dec 2022 04:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiLKJIj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Dec 2022 04:08:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA57C77B
        for <linux-rdma@vger.kernel.org>; Sun, 11 Dec 2022 01:08:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C33760C95
        for <linux-rdma@vger.kernel.org>; Sun, 11 Dec 2022 09:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF457C433F0;
        Sun, 11 Dec 2022 09:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670749716;
        bh=AySFuOXSZ7CAT3uZJjE8fZT2CLBT78jaBMm123BUG3I=;
        h=From:To:Cc:Subject:Date:From;
        b=e7N7A3YO4SBaAR1EhNSz/nZofn+nA+rSR6O/hlMXUZXIYpYtGI9G3hnFhCXaN+Lr7
         Ybxk5yw4e29xpLMkJbwgyu60ZBpVAk+n1lg5Cm+OVHu4LlXDu5ED8AKQdMmJKb0IEs
         SaavweASGYD6Yq0mWRQ9rB13SEZF5Pkc221pbs497UxlrAeIdWq7sfXMc4gv1o91Nt
         oEoRc6V7iQb6O5dC+y+avDvjv8vc47SlL7oMJTcZXT2vfqiToAgbr/REkLT66DmUJO
         nQY591MQGqWXlSiAMcZ4bu+Z0aAP0MwLt7TDECexuE7otrx+4q+wMwiyMQMCW3mH7b
         zTNoB1FGU0inw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Wei Chen <harperchen1110@gmail.com>
Subject: [PATCH rdma-next] RDMA/core: Fix resolve_prepare_src error cleanup
Date:   Sun, 11 Dec 2022 11:08:30 +0200
Message-Id: <ec81a9d50462d9b9303966176b17b85f7dfbb96a.1670749660.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.38.1
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

From: Patrisious Haddad <phaddad@nvidia.com>

resolve_prepare_src() changes the destination address of the id,
regardless of success, and on failure zeroes it out.

Instead on function failure keep the original destination address
of the id.

Since the id could have been already added to the cm id tree and
zeroing its destination address, could result in a key mismatch or
multiple ids having the same key(zero) in the tree which could lead to:

BUG: KASAN: slab-out-of-bounds in compare_netdev_and_ip.isra.0+0x25/0x120 drivers/infiniband/core/cma.c:473
Read of size 4 at addr ffff88800920d9e4 by task syz-executor.4/14865

CPU: 2 PID: 14865 Comm: syz-executor.4 Not tainted 5.19.0-rc2 #21
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x6e/0x91 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:313 [inline]
 print_report.cold+0xff/0x68e mm/kasan/report.c:429
 kasan_report+0xa8/0x130 mm/kasan/report.c:491
 compare_netdev_and_ip.isra.0+0x25/0x120 drivers/infiniband/core/cma.c:473
 cma_add_id_to_tree drivers/infiniband/core/cma.c:506 [inline]
 rdma_resolve_route+0xbc4/0x1560 drivers/infiniband/core/cma.c:3303
 ucma_resolve_route+0xe4/0x150 drivers/infiniband/core/ucma.c:746
 ucma_write+0x19f/0x280 drivers/infiniband/core/ucma.c:1744
 vfs_write fs/read_write.c:589 [inline]
 vfs_write+0x181/0x580 fs/read_write.c:571
 ksys_write+0x1a1/0x1e0 fs/read_write.c:644
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f2afbe8c89d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2afcf1ec28 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f2afbfabf60 RCX: 00007f2afbe8c89d
RDX: 0000000000000010 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 00007f2afbef910d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcdc77c66f R14: 00007f2afbfabf60 R15: 00007f2afcf1edc0
 </TASK>

Fixes: 19b752a19dce ("IB/cma: Allow port reuse for rdma_id")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Reported-by: Wei Chen <harperchen1110@gmail.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 1fca0a24f30f..2d4c391e36a9 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3584,8 +3584,11 @@ static int resolve_prepare_src(struct rdma_id_private *id_priv,
 			       struct sockaddr *src_addr,
 			       const struct sockaddr *dst_addr)
 {
+	struct sockaddr org_addr = {};
 	int ret;
 
+	memcpy(&org_addr, cma_dst_addr(id_priv),
+	       rdma_addr_size(cma_dst_addr(id_priv)));
 	memcpy(cma_dst_addr(id_priv), dst_addr, rdma_addr_size(dst_addr));
 	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND, RDMA_CM_ADDR_QUERY)) {
 		/* For a well behaved ULP state will be RDMA_CM_IDLE */
@@ -3608,7 +3611,7 @@ static int resolve_prepare_src(struct rdma_id_private *id_priv,
 err_state:
 	cma_comp_exch(id_priv, RDMA_CM_ADDR_QUERY, RDMA_CM_ADDR_BOUND);
 err_dst:
-	memset(cma_dst_addr(id_priv), 0, rdma_addr_size(dst_addr));
+	memcpy(cma_dst_addr(id_priv), &org_addr, rdma_addr_size(&org_addr));
 	return ret;
 }
 
-- 
2.38.1

