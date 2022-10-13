Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BD95FD3AB
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Oct 2022 06:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJMEDr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Oct 2022 00:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiJMEDq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Oct 2022 00:03:46 -0400
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8657A12572A;
        Wed, 12 Oct 2022 21:03:44 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="91960174"
X-IronPort-AV: E=Sophos;i="5.95,180,1661785200"; 
   d="scan'208";a="91960174"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP; 13 Oct 2022 13:03:42 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id DCBFFD5030;
        Thu, 13 Oct 2022 13:03:40 +0900 (JST)
Received: from aks-ab2.gw.nic.fujitsu.com (aks-ab2.gw.nic.fujitsu.com [192.51.207.12])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 1568AD9C03;
        Thu, 13 Oct 2022 13:03:40 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by aks-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id C2BDF87048;
        Thu, 13 Oct 2022 13:03:37 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Fix mr leak in RESPST_ERR_RNR
Date:   Thu, 13 Oct 2022 12:03:33 +0800
Message-Id: <20221013040333.21097-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27198.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27198.004
X-TMASE-Result: 10-0.562800-10.000000
X-TMASE-MatchedRID: mkGkedb7C37yAV/ow31xq+9kW9mxCQvtndls9F9zmi2jEIt+uIPPOIre
        5xUTEbm3PnkLz0tiKhf4k1dYqOhY3WYeY1r5+Sd7hdD+G7U5X/Sc/8UYyRuho3yL2uleGLJnvwU
        evDt+uW5BOd+wdG/d+4uaJ190E6oxsQJKRUFJrtWeAiCmPx4NwJuJ+Pb8n/VxSnQ4MjwaO9cqtq
        5d3cxkNX/QRe2mNLkbCHJyZUrnVkbKPpz2FyiIpTJEZfUHhIY966G52LtJf1QOFZncc6xK02tCz
        w6OQAYZJe/4x0k9v5sh49dGb9sr6f8jyjqYHnMRFcUQf3Yp/ridO0/GUi4gFb0fOPzpgdcEKeJ/
        HkAZ8Is=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe_recheck_mr() will increase mr's ref_cnt, so we should call rxe_put(mr)
to drop mr's ref_cnt in RESPST_ERR_RNR to avoid below warning:
[  633.447883] WARNING: CPU: 0 PID: 4156 at drivers/infiniband/sw/rxe/rxe_pool.c:259 __rxe_cleanup+0x1df/0x240 [rdma_rxe]
...
[  633.509482] Call Trace:
[  633.510246]  <TASK>
[  633.510962]  rxe_dereg_mr+0x4c/0x60 [rdma_rxe]
[  633.512123]  ib_dereg_mr_user+0xa8/0x200 [ib_core]
[  633.513444]  ib_mr_pool_destroy+0x77/0xb0 [ib_core]
[  633.514763]  nvme_rdma_destroy_queue_ib+0x89/0x240 [nvme_rdma]
[  633.516230]  nvme_rdma_free_queue+0x40/0x50 [nvme_rdma]
[  633.517577]  nvme_rdma_teardown_io_queues.part.0+0xc3/0x120 [nvme_rdma]
[  633.519204]  nvme_rdma_error_recovery_work+0x4d/0xf0 [nvme_rdma]
[  633.520695]  process_one_work+0x582/0xa40
[  633.522987]  ? pwq_dec_nr_in_flight+0x100/0x100
[  633.524227]  ? rwlock_bug.part.0+0x60/0x60
[  633.525372]  worker_thread+0x2a9/0x700
[  633.526437]  ? process_one_work+0xa40/0xa40
[  633.527589]  kthread+0x168/0x1a0
[  633.528518]  ? kthread_complete_and_exit+0x20/0x20
[  633.529792]  ret_from_fork+0x22/0x30

CC: Bob Pearson <rpearsonhpe@gmail.com>
Fixes: 8a1a0be894da ("RDMA/rxe: Replace mr by rkey in responder resources")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index ed5a09e86417..bbb9665c64ad 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -806,8 +806,11 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 
 	skb = prepare_ack_packet(qp, &ack_pkt, opcode, payload,
 				 res->cur_psn, AETH_ACK_UNLIMITED);
-	if (!skb)
+	if (!skb) {
+		if (mr)
+			rxe_put(mr);
 		return RESPST_ERR_RNR;
+	}
 
 	rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
 		    payload, RXE_FROM_MR_OBJ);
-- 
2.31.1

