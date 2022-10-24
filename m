Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AF66099B1
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 07:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJXFVJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 01:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJXFVJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 01:21:09 -0400
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F8C61D51;
        Sun, 23 Oct 2022 22:21:04 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="72828002"
X-IronPort-AV: E=Sophos;i="5.95,207,1661785200"; 
   d="scan'208";a="72828002"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 24 Oct 2022 14:21:03 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id C80AFD66A3;
        Mon, 24 Oct 2022 14:21:01 +0900 (JST)
Received: from kws-ab1.gw.nic.fujitsu.com (kws-ab1.gw.nic.fujitsu.com [192.51.206.11])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id E998FD9691;
        Mon, 24 Oct 2022 14:21:00 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id EE42911403E8;
        Mon, 24 Oct 2022 14:20:59 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 2/2] RDMA/rxe: Fix mr leak in RESPST_ERR_RNR
Date:   Mon, 24 Oct 2022 13:20:49 +0800
Message-Id: <20221024052049.20577-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <1666582315-2-1-git-send-email-lizhijian@fujitsu.com>
References: <1666582315-2-1-git-send-email-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27220.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27220.005
X-TMASE-Result: 10-1.290000-10.000000
X-TMASE-MatchedRID: 1qs/xP9nRfnyAV/ow31xq+9kW9mxCQvtndls9F9zmi2jEIt+uIPPOIre
        5xUTEbm3PnkLz0tiKhf4k1dYqOhY3WYeY1r5+Sd7hdD+G7U5X/Sc/8UYyRuho3uaPw9VMh5j0Bh
        ZSjgdIiQi+t+0AiFaYlDzs+ptu0k3pFPA9gan8yWRgPzABkqxIH0tCKdnhB58k4rY1r+vswgXvQ
        kGi3tjz46HM5rqDwqt0PlwXS+MTWJauV6otRbPX1WTJvU4HQmnuUl9W5PYcaBtb5mbBxcqYOuhV
        ACdVr98OBHWwUnqcG0h3LeAlyCOC9RSbtOqIybrFcG3+ZRETICP9kUX1Z+buE3LumkbQiNwVCqT
        SPu8tVR7AxIEOt4h2Q==
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
V2: remove mr testing
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index b02639cf8cba..41250154a478 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -806,8 +806,10 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 
 	skb = prepare_ack_packet(qp, &ack_pkt, opcode, payload,
 				 res->cur_psn, AETH_ACK_UNLIMITED);
-	if (!skb)
+	if (!skb) {
+		rxe_put(mr);
 		return RESPST_ERR_RNR;
+	}
 
 	rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
 		    payload, RXE_FROM_MR_OBJ);
-- 
2.31.1

