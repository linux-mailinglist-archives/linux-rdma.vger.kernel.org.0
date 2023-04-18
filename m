Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4562B6E5D07
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Apr 2023 11:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjDRJJl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Apr 2023 05:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjDRJJf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Apr 2023 05:09:35 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Apr 2023 02:09:16 PDT
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604F14EE9
        for <linux-rdma@vger.kernel.org>; Tue, 18 Apr 2023 02:09:16 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="93274021"
X-IronPort-AV: E=Sophos;i="5.99,206,1677510000"; 
   d="scan'208";a="93274021"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 18:07:52 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id D3663D3EA5
        for <linux-rdma@vger.kernel.org>; Tue, 18 Apr 2023 18:07:50 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 1D2D2D67AC
        for <linux-rdma@vger.kernel.org>; Tue, 18 Apr 2023 18:07:50 +0900 (JST)
Received: from localhost.localdomain (unknown [10.118.237.106])
        by m3002.s.css.fujitsu.com (Postfix) with ESMTP id E84CF200B33D;
        Tue, 18 Apr 2023 18:07:49 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, jgg@nvidia.com, rpearsonhpe@gmail.com
Cc:     leonro@nvidia.com, zyjzyj2000@gmail.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH jgg-for-next] RDMA/rxe: Fix spinlock recursion deadlock on requester
Date:   Tue, 18 Apr 2023 18:06:42 +0900
Message-Id: <20230418090642.1849358-1-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

After applying commit f605f26ea196, the following deadlock is observed:
 Call Trace:
  <IRQ>
  _raw_spin_lock_bh+0x29/0x30
  check_type_state.constprop.0+0x4e/0xc0 [rdma_rxe]
  rxe_rcv+0x173/0x3d0 [rdma_rxe]
  rxe_udp_encap_recv+0x69/0xd0 [rdma_rxe]
  ? __pfx_rxe_udp_encap_recv+0x10/0x10 [rdma_rxe]
  udp_queue_rcv_one_skb+0x258/0x520
  udp_unicast_rcv_skb+0x75/0x90
  __udp4_lib_rcv+0x364/0x5c0
  ip_protocol_deliver_rcu+0xa7/0x160
  ip_local_deliver_finish+0x73/0xa0
  ip_sublist_rcv_finish+0x80/0x90
  ip_sublist_rcv+0x191/0x220
  ip_list_rcv+0x132/0x160
  __netif_receive_skb_list_core+0x297/0x2c0
  netif_receive_skb_list_internal+0x1c5/0x300
  napi_complete_done+0x6f/0x1b0
  virtnet_poll+0x1f4/0x2d0 [virtio_net]
  __napi_poll+0x2c/0x1b0
  net_rx_action+0x293/0x350
  ? __napi_schedule+0x79/0x90
  __do_softirq+0xcb/0x2ab
  __irq_exit_rcu+0xb9/0xf0
  common_interrupt+0x80/0xa0
  </IRQ>
  <TASK>
  asm_common_interrupt+0x22/0x40
  RIP: 0010:_raw_spin_lock+0x17/0x30
  rxe_requester+0xe4/0x8f0 [rdma_rxe]
  ? xas_load+0x9/0xa0
  ? xa_load+0x70/0xb0
  do_task+0x64/0x1f0 [rdma_rxe]
  rxe_post_send+0x54/0x110 [rdma_rxe]
  ib_uverbs_post_send+0x5f8/0x680 [ib_uverbs]
  ? netif_receive_skb_list_internal+0x1e3/0x300
  ib_uverbs_write+0x3c8/0x500 [ib_uverbs]
  vfs_write+0xc5/0x3b0
  ksys_write+0xab/0xe0
  ? syscall_trace_enter.constprop.0+0x126/0x1a0
  do_syscall_64+0x3b/0x90
  entry_SYSCALL_64_after_hwframe+0x72/0xdc
  </TASK>

The deadlock is easily reproducible with perftest. Fix it by disabling
softirq when acquiring the lock in process context.

Fixes: f605f26ea196 ("RDMA/rxe: Protect QP state with qp->state_lock")
Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 8e50d116d273..65134a9aefe7 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -180,13 +180,13 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
 	if (wqe == NULL)
 		return NULL;
 
-	spin_lock(&qp->state_lock);
+	spin_lock_bh(&qp->state_lock);
 	if (unlikely((qp_state(qp) == IB_QPS_SQD) &&
 		     (wqe->state != wqe_state_processing))) {
-		spin_unlock(&qp->state_lock);
+		spin_unlock_bh(&qp->state_lock);
 		return NULL;
 	}
-	spin_unlock(&qp->state_lock);
+	spin_unlock_bh(&qp->state_lock);
 
 	wqe->mask = wr_opcode_mask(wqe->wr.opcode, qp);
 	return wqe;
-- 
2.39.1

