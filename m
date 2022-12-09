Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB7A647D1F
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Dec 2022 06:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiLIFBV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Dec 2022 00:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLIFBU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Dec 2022 00:01:20 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Dec 2022 21:01:18 PST
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E608F728
        for <linux-rdma@vger.kernel.org>; Thu,  8 Dec 2022 21:01:17 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="78810568"
X-IronPort-AV: E=Sophos;i="5.96,230,1665414000"; 
   d="scan'208";a="78810568"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP; 09 Dec 2022 14:00:12 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 66A67D647E
        for <linux-rdma@vger.kernel.org>; Fri,  9 Dec 2022 14:00:11 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 90E62BF4B0
        for <linux-rdma@vger.kernel.org>; Fri,  9 Dec 2022 14:00:10 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 5516A2020A42;
        Fri,  9 Dec 2022 14:00:10 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     lizhijian@fujitsu.com, rpearsonhpe@gmail.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v2] Revert "RDMA/rxe: Remove unnecessary mr testing"
Date:   Fri,  9 Dec 2022 13:59:26 +0900
Message-Id: <20221209045926.531689-1-matsuda-daisuke@fujitsu.com>
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
is not set in check_rkey() [1]. The mr is NULL in this case, and a NULL
pointer dereference occurs as shown below.

 BUG: kernel NULL pointer dereference, address: 0000000000000010
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 PGD 0 P4D 0
 Oops: 0002 [#1] PREEMPT SMP PTI
 CPU: 2 PID: 3622 Comm: python3 Kdump: loaded Not tainted 6.1.0-rc3+ #34
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
 RIP: 0010:__rxe_put+0xc/0x60 [rdma_rxe]
 Code: cc cc cc 31 f6 e8 64 36 1b d3 41 b8 01 00 00 00 44 89 c0 c3 cc cc cc cc 41 89 c0 eb c1 90 0f 1f 44 00 00 41 54 b8 ff ff ff ff <f0> 0f c1 47 10 83 f8 01 74 11 45 31 e4 85 c0 7e 20 44 89 e0 41 5c
 RSP: 0018:ffffb27bc012ce78 EFLAGS: 00010246
 RAX: 00000000ffffffff RBX: ffff9790857b0580 RCX: 0000000000000000
 RDX: ffff979080fe145a RSI: 000055560e3e0000 RDI: 0000000000000000
 RBP: ffff97909c7dd800 R08: 0000000000000001 R09: e7ce43d97f7bed0f
 R10: ffff97908b29c300 R11: 0000000000000000 R12: 0000000000000000
 R13: 0000000000000000 R14: ffff97908b29c300 R15: 0000000000000000
 FS:  00007f276f7bd740(0000) GS:ffff9792b5c80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000010 CR3: 0000000114230002 CR4: 0000000000060ee0
 Call Trace:
  <IRQ>
  read_reply+0xda/0x310 [rdma_rxe]
  rxe_responder+0x82d/0xe50 [rdma_rxe]
  do_task+0x84/0x170 [rdma_rxe]
  tasklet_action_common.constprop.0+0xa7/0x120
  __do_softirq+0xcb/0x2ac
  do_softirq+0x63/0x90
  </IRQ>

[1] InfiniBand Architecture Specification Volume 1, Release 1.5, C9-88.
    Available from https://www.infinibandta.org/

Link: https://lore.kernel.org/lkml/1666582315-2-1-git-send-email-lizhijian@fujitsu.com/
Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
---
v2:
  Modified the commit message:
  - Removed timestamps from the calltrace.
  - Added a reference to IBA spec [1].

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

