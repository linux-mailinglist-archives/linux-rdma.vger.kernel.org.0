Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 680C310F4F9
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2019 03:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfLCCa7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Dec 2019 21:30:59 -0500
Received: from linode.aoot.com ([69.164.194.13]:59736 "EHLO linode.aoot.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfLCCa6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Dec 2019 21:30:58 -0500
X-Greylist: delayed 1733 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Dec 2019 21:30:58 EST
Received: from work.aoot.com.com (li1110-136.members.linode.com [45.79.11.136])
        by linode.aoot.com (Postfix) with ESMTP id 3A0998772;
        Mon,  2 Dec 2019 20:02:46 -0600 (CST)
From:   Steve Wise <larrystevenwise@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Steve Wise <larrystevenwise@gmail.com>, bvanassche@acm.org
Subject: [PATCH 2/2] rxe: correctly calculate iCRC for unaligned payloads
Date:   Mon,  2 Dec 2019 20:03:20 -0600
Message-Id: <20191203020319.15036-2-larrystevenwise@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191203020319.15036-1-larrystevenwise@gmail.com>
References: <20191203020319.15036-1-larrystevenwise@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If RoCE PDUs being sent or received contain pad bytes, then the iCRC
is miscalculated resulting PDUs being emitted by RXE with an incorrect
iCRC, as well as ingress PDUs being dropped due to erroneously detecting
a bad iCRC in the PDU.  The fix is to include the pad bytes, if any,
in iCRC computations.

CC: bvanassche@acm.org,3100102071@zju.edu.cn,leon@kernel.org
Signed-off-by: Steve Wise <larrystevenwise@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_recv.c | 2 +-
 drivers/infiniband/sw/rxe/rxe_req.c  | 6 ++++++
 drivers/infiniband/sw/rxe/rxe_resp.c | 7 +++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index f9a492ed900b..831ad578a7b2 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -389,7 +389,7 @@ void rxe_rcv(struct sk_buff *skb)
 
 	calc_icrc = rxe_icrc_hdr(pkt, skb);
 	calc_icrc = rxe_crc32(rxe, calc_icrc, (u8 *)payload_addr(pkt),
-			      payload_size(pkt));
+			      payload_size(pkt) + bth_pad(pkt));
 	calc_icrc = (__force u32)cpu_to_be32(~calc_icrc);
 	if (unlikely(calc_icrc != pack_icrc)) {
 		if (skb->protocol == htons(ETH_P_IPV6))
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index c5d9b558fa90..e5031172c019 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -500,6 +500,12 @@ static int fill_packet(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 			if (err)
 				return err;
 		}
+		if (bth_pad(pkt)) {
+			u8 *pad = payload_addr(pkt) + paylen;
+
+			memset(pad, 0, bth_pad(pkt));
+			crc = rxe_crc32(rxe, crc, pad, bth_pad(pkt));
+		}
 	}
 	p = payload_addr(pkt) + paylen + bth_pad(pkt);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 1cbfbd98eb22..c4a8195bf670 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -732,6 +732,13 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	if (err)
 		pr_err("Failed copying memory\n");
 
+	if (bth_pad(&ack_pkt)) {
+		struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+		u8 *pad = payload_addr(&ack_pkt) + payload;
+
+		memset(pad, 0, bth_pad(&ack_pkt));
+		icrc = rxe_crc32(rxe, icrc, pad, bth_pad(&ack_pkt));
+	}
 	p = payload_addr(&ack_pkt) + payload + bth_pad(&ack_pkt);
 	*p = ~icrc;
 
-- 
2.20.1

