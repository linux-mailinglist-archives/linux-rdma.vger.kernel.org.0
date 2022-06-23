Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC692557CBB
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jun 2022 15:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiFWNQe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Jun 2022 09:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiFWNQd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Jun 2022 09:16:33 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D97F37A17
        for <linux-rdma@vger.kernel.org>; Thu, 23 Jun 2022 06:16:32 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3Ax5gQwaB878OAjxVW/+Phw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fAwm+1DgihDdRyjQdXGHVM/6PZ2qjKtlxbIy08BhQsZ6Ax9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkHhcwmj/3auK79SMkjPnRLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9GgjOGj5Zz2f1DqJ6xV?=
 =?us-ascii?q?Rw0eKbLnYzxVjEBSXwjY/IfpeOvzX+X9Jb7I1f9W2H0zvx0F0YwPZUV0ulyCGB?=
 =?us-ascii?q?Ks/cfLVglah2Egcq1zai9R+0qgd4sROHvPYUCqjR6wTTQJegpTIqFQKjQ49Jcm?=
 =?us-ascii?q?jAqiahmH/nRT9gYZCJiKh/JCyCjkH9/5IkWxb/u3yegNWYD7g/9mEb+2ECLpCQ?=
 =?us-ascii?q?Z7VQnGIO9lgS2ePho?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ai/AEI6uUbNna5b6FxMrqp+ts7skDadV00zEX?=
 =?us-ascii?q?/kB9WHVpmwKj+/xG+85rtiMc6QxwZJhOo7690cW7Kk80lqQV3WB5B97LYOCBgg?=
 =?us-ascii?q?GVxepZgrcKrQeMJ8SEzJ8+6Ztd?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="125567154"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Jun 2022 21:16:31 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 031A04D1719F;
        Thu, 23 Jun 2022 21:16:29 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 23 Jun 2022 21:16:29 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 23 Jun 2022 21:16:28 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Bob Pearson" <rpearsonhpe@gmail.com>,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH] RDMA/rxe: Remove useless pkt parameters
Date:   Thu, 23 Jun 2022 21:16:27 +0800
Message-ID: <20220623131627.18903-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 031A04D1719F.A5F9B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pkt parameters in prepare_ack_packet(), send_ack() and
send_atomic_ack() have become useless by the following commits.
So remove them directly.

Fixes: bf139b58af09 ("RDMA/rxe: Remove unused pkt->offset")
Fixes: 3896bde92d03 ("RDMA/rxe: Fix extra copy in prepare_ack_packet")
Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index f4f6ee5d81fe..c45c9d954931 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -591,7 +591,6 @@ static enum resp_states process_atomic(struct rxe_qp *qp,
 }
 
 static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
-					  struct rxe_pkt_info *pkt,
 					  struct rxe_pkt_info *ack,
 					  int opcode,
 					  int payload,
@@ -771,7 +770,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 
 	payload = min_t(int, res->read.resid, mtu);
 
-	skb = prepare_ack_packet(qp, req_pkt, &ack_pkt, opcode, payload,
+	skb = prepare_ack_packet(qp, &ack_pkt, opcode, payload,
 				 res->cur_psn, AETH_ACK_UNLIMITED);
 	if (!skb)
 		return RESPST_ERR_RNR;
@@ -997,14 +996,13 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 		return RESPST_CLEANUP;
 }
 
-static int send_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
-		    u8 syndrome, u32 psn)
+static int send_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
 {
 	int err = 0;
 	struct rxe_pkt_info ack_pkt;
 	struct sk_buff *skb;
 
-	skb = prepare_ack_packet(qp, pkt, &ack_pkt, IB_OPCODE_RC_ACKNOWLEDGE,
+	skb = prepare_ack_packet(qp, &ack_pkt, IB_OPCODE_RC_ACKNOWLEDGE,
 				 0, psn, syndrome);
 	if (!skb) {
 		err = -ENOMEM;
@@ -1019,17 +1017,15 @@ static int send_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	return err;
 }
 
-static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
-			   u8 syndrome)
+static int send_atomic_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
 {
 	int rc = 0;
 	struct rxe_pkt_info ack_pkt;
 	struct sk_buff *skb;
 	struct resp_res *res;
 
-	skb = prepare_ack_packet(qp, pkt, &ack_pkt,
-				 IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE, 0, pkt->psn,
-				 syndrome);
+	skb = prepare_ack_packet(qp, &ack_pkt, IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE,
+				 0, psn, syndrome);
 	if (!skb) {
 		rc = -ENOMEM;
 		goto out;
@@ -1062,11 +1058,11 @@ static enum resp_states acknowledge(struct rxe_qp *qp,
 		return RESPST_CLEANUP;
 
 	if (qp->resp.aeth_syndrome != AETH_ACK_UNLIMITED)
-		send_ack(qp, pkt, qp->resp.aeth_syndrome, pkt->psn);
+		send_ack(qp, qp->resp.aeth_syndrome, pkt->psn);
 	else if (pkt->mask & RXE_ATOMIC_MASK)
-		send_atomic_ack(qp, pkt, AETH_ACK_UNLIMITED);
+		send_atomic_ack(qp, AETH_ACK_UNLIMITED, pkt->psn);
 	else if (bth_ack(pkt))
-		send_ack(qp, pkt, AETH_ACK_UNLIMITED, pkt->psn);
+		send_ack(qp, AETH_ACK_UNLIMITED, pkt->psn);
 
 	return RESPST_CLEANUP;
 }
@@ -1119,7 +1115,7 @@ static enum resp_states duplicate_request(struct rxe_qp *qp,
 	if (pkt->mask & RXE_SEND_MASK ||
 	    pkt->mask & RXE_WRITE_MASK) {
 		/* SEND. Ack again and cleanup. C9-105. */
-		send_ack(qp, pkt, AETH_ACK_UNLIMITED, prev_psn);
+		send_ack(qp, AETH_ACK_UNLIMITED, prev_psn);
 		return RESPST_CLEANUP;
 	} else if (pkt->mask & RXE_READ_MASK) {
 		struct resp_res *res;
@@ -1327,7 +1323,7 @@ int rxe_responder(void *arg)
 			break;
 		case RESPST_ERR_PSN_OUT_OF_SEQ:
 			/* RC only - Class B. Drop packet. */
-			send_ack(qp, pkt, AETH_NAK_PSN_SEQ_ERROR, qp->resp.psn);
+			send_ack(qp, AETH_NAK_PSN_SEQ_ERROR, qp->resp.psn);
 			state = RESPST_CLEANUP;
 			break;
 
@@ -1349,7 +1345,7 @@ int rxe_responder(void *arg)
 			if (qp_type(qp) == IB_QPT_RC) {
 				rxe_counter_inc(rxe, RXE_CNT_SND_RNR);
 				/* RC - class B */
-				send_ack(qp, pkt, AETH_RNR_NAK |
+				send_ack(qp, AETH_RNR_NAK |
 					 (~AETH_TYPE_MASK &
 					 qp->attr.min_rnr_timer),
 					 pkt->psn);
-- 
2.34.1



