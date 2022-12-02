Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B332F6408D1
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Dec 2022 15:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiLBO53 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Dec 2022 09:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbiLBO52 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Dec 2022 09:57:28 -0500
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9A3D2D91;
        Fri,  2 Dec 2022 06:57:27 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="99289891"
X-IronPort-AV: E=Sophos;i="5.96,212,1665414000"; 
   d="scan'208";a="99289891"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP; 02 Dec 2022 23:57:25 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id C9AC9D6193;
        Fri,  2 Dec 2022 23:57:23 +0900 (JST)
Received: from kws-ab1.gw.nic.fujitsu.com (kws-ab1.gw.nic.fujitsu.com [192.51.206.11])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 162DACFF8B;
        Fri,  2 Dec 2022 23:57:23 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 235551145976;
        Fri,  2 Dec 2022 23:57:22 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     jgg@ziepe.ca, leon@kernel.org, zyjzyj2000@gmail.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li Zhijian <lizhijian@fujitsu.com>,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH] RDMA/rxe: fix possible NULL MR dereference
Date:   Fri,  2 Dec 2022 22:57:13 +0800
Message-Id: <20221202145713.13152-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27298.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27298.007
X-TMASE-Result: 10--12.569700-10.000000
X-TMASE-MatchedRID: RcbL0cMaxCeojsVP+osNyPZOZ2c2VQUgBGvINcfHqhe7N2IdiDgmMz3v
        MQJZlrWjEVJBHBQKSgYU7ziK1wlLgV4bwANKTm+izYK5U+QI3O5kcZ9Vcvq377+7SLqdnJMRR5O
        2+B+mEplpMDrWrGKemg9iGlH7LPmcLTVVeVyNwJRDRebSlZYuShtuGFXrmRpjeGHkpR2WBaKSYe
        mGnZHs7YBFT0BUMcai+H3jVLHvYoGhhjsqgSuNbxF4zyLyne+ATJDl9FKHbrloRLyhTK5EM6PFj
        JEFr+ol+3r/YeB8iANXKaQsz6vtVDsAVzN+Ov/sqdtoVYpmp2B6zXcnCyJP7f8+Jelck17CNskR
        vP0wkBy31MhdPaq1QQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Daisuke mentioned that:
If responder get a zero-byte RDMA Read request, qp->resp.mr
is not set in check_rkey(). The mr is NULL in this case, and a NULL pointer
dereference occurs as shown below.

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

Test mr before dereference it to avoid this problem.

Fixes: b5f9a01fae42 ("RDMA/rxe: Fix mr leak in RESPST_ERR_RNR")
Reported-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
Hope we can catch up with 6.1
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 693081e813ec..bbb9665c64ad 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -807,7 +807,8 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	skb = prepare_ack_packet(qp, &ack_pkt, opcode, payload,
 				 res->cur_psn, AETH_ACK_UNLIMITED);
 	if (!skb) {
-		rxe_put(mr);
+		if (mr)
+			rxe_put(mr);
 		return RESPST_ERR_RNR;
 	}
 
-- 
2.38.1

