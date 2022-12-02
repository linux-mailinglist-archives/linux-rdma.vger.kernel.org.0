Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFD264056F
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Dec 2022 12:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbiLBLCg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Dec 2022 06:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiLBLCg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Dec 2022 06:02:36 -0500
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E37B40
        for <linux-rdma@vger.kernel.org>; Fri,  2 Dec 2022 03:02:33 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="98426074"
X-IronPort-AV: E=Sophos;i="5.96,212,1665414000"; 
   d="scan'208";a="98426074"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP; 02 Dec 2022 20:02:31 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 9A989D66A2
        for <linux-rdma@vger.kernel.org>; Fri,  2 Dec 2022 20:02:29 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id EAE3A86C35
        for <linux-rdma@vger.kernel.org>; Fri,  2 Dec 2022 20:02:28 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3002.s.css.fujitsu.com (Postfix) with ESMTP id C5094200B399;
        Fri,  2 Dec 2022 20:02:28 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     lizhijian@fujitsu.com, rpearsonhpe@gmail.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH] Revert "RDMA/rxe: Remove unnecessary mr testing"
Date:   Fri,  2 Dec 2022 20:01:57 +0900
Message-Id: <20221202110157.3221952-1-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The commit 686d348476ee ("RDMA/rxe: Remove unnecessary mr testing") causes
a kernel crash. If responder get a zero-byte RDMA Read request, qp->resp.mr
is not set in check_rkey(). The mr is NULL in this case, and a NULL pointer
dereference occurs as shown below.

[  139.607580] BUG: kernel NULL pointer dereference, address: 0000000000000010
[  139.609169] #PF: supervisor write access in kernel mode
[  139.610314] #PF: error_code(0x0002) - not-present page
[  139.611434] PGD 0 P4D 0
[  139.612031] Oops: 0002 [#1] PREEMPT SMP PTI
[  139.612975] CPU: 2 PID: 3622 Comm: python3 Kdump: loaded Not tainted 6.1.0-rc3+ #34
[  139.614465] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[  139.616142] RIP: 0010:__rxe_put+0xc/0x60 [rdma_rxe]
[  139.617065] Code: cc cc cc 31 f6 e8 64 36 1b d3 41 b8 01 00 00 00 44 89 c0 c3 cc cc cc cc 41 89 c0 eb c1 90 0f 1f 44 00 00 41 54 b8 ff ff ff ff <f0> 0f c1 47 10 83 f8 01 74 11 45 31 e4 85 c0 7e 20 44 89 e0 41 5c
[  139.620451] RSP: 0018:ffffb27bc012ce78 EFLAGS: 00010246
[  139.621413] RAX: 00000000ffffffff RBX: ffff9790857b0580 RCX: 0000000000000000
[  139.622718] RDX: ffff979080fe145a RSI: 000055560e3e0000 RDI: 0000000000000000
[  139.624025] RBP: ffff97909c7dd800 R08: 0000000000000001 R09: e7ce43d97f7bed0f
[  139.625328] R10: ffff97908b29c300 R11: 0000000000000000 R12: 0000000000000000
[  139.626632] R13: 0000000000000000 R14: ffff97908b29c300 R15: 0000000000000000
[  139.627941] FS:  00007f276f7bd740(0000) GS:ffff9792b5c80000(0000) knlGS:0000000000000000
[  139.629418] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  139.630480] CR2: 0000000000000010 CR3: 0000000114230002 CR4: 0000000000060ee0
[  139.631805] Call Trace:
[  139.632288]  <IRQ>
[  139.632688]  read_reply+0xda/0x310 [rdma_rxe]
[  139.633515]  rxe_responder+0x82d/0xe50 [rdma_rxe]
[  139.634398]  do_task+0x84/0x170 [rdma_rxe]
[  139.635187]  tasklet_action_common.constprop.0+0xa7/0x120
[  139.636189]  __do_softirq+0xcb/0x2ac
[  139.636877]  do_softirq+0x63/0x90
[  139.637505]  </IRQ>

Link: https://lore.kernel.org/lkml/1666582315-2-1-git-send-email-lizhijian@fujitsu.com/
Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
NOTE:
 I think the commit 686d348476ee is not yet merged to Torvalds' tree.
 Perhaps we may just remove the patch from the for-next tree.
 I leave that to the maintainers as I am not familiar with patch reversion.

 drivers/infiniband/sw/rxe/rxe_resp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 6761bcd1d4d8..5d3a4c6f81a3 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -832,7 +832,8 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 
 	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
 			  payload, RXE_FROM_MR_OBJ);
-	rxe_put(mr);
+	if (mr)
+		rxe_put(mr);
 	if (err) {
 		kfree_skb(skb);
 		return RESPST_ERR_RKEY_VIOLATION;
-- 
2.31.1

