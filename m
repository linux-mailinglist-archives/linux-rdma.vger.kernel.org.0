Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3829C63F30D
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 15:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiLAOkG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 09:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiLAOkE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 09:40:04 -0500
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9576EA8FFA
        for <linux-rdma@vger.kernel.org>; Thu,  1 Dec 2022 06:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669905591; i=@fujitsu.com;
        bh=JmG4wZ5AyF4x51pIlbVvVPfwcnt4AWGQwutpzYZLRG4=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=dWpYZY8SbgRr+xgOWt2EVopuKZiJnBRix2ECLpFI+CU6sVvnf/xWXacogvRH5CjfU
         DpAodq8CkuGhrosyASU2QuPdNbTWJmkeRhklrgPQOQIo1j4Jq0vKviekBCtLXiVBea
         PjN5PQunb1cyzjMz09AgDKaPj9Y4ZKPHiwVHmcWwEvfDB34UiyFh9C+svGyetJu+Ky
         LAGlyjmnUm54EdLOsdFsSPB7lfx5HLgpzhBOs+RUWLbd85cAoFnRSeCI5aLQG78Ijm
         EcuZZhmYImZH287+T62/it+azRWx08sBwedTb3VGQOzaEsLgZdF8Wrm12Nh68UPUnT
         Q4ZFB3YoaYBSA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRWlGSWpSXmKPExsViZ8ORqLt+T0e
  yweR90hZX/u1htJjyaymzxbNDvSwWX6ZOY7Y4f6yf3YHVY+esu+wem1Z1snn0Nr9j8/i8SS6A
  JYo1My8pvyKBNeP4iXfMBVP1K6ZtbGZsYPyh1sXIxSEksIVR4s/VDSxdjJxAznImiXsngyAS+
  xgl7h29zAySYBNQk9g5/SVYkYiAt8SOGyfA4swC9RKHj25i7GLk4BAWCJaY8pMTJMwioCIxpe
  01WAmvgKPEolvfwVolBBQkpjx8DxbnFHCSuP9zElirEFBN559IiHJBiZMzn7BATJeQOPjiBTN
  Eq6JE25J/7BB2hcSsWW1MELaaxNVzm5gnMArOQtI+C0n7AkamVYymxalFZalFuoZ6SUWZ6Rkl
  uYmZOXqJVbqJeqmluuWpxSVAmcTyYr3U4mK94src5JwUvbzUkk2MwNBPKWZn3cH4YskfvUOMk
  hxMSqK81Z0dyUJ8SfkplRmJxRnxRaU5qcWHGGU4OJQkeE/uBMoJFqWmp1akZeYA4xAmLcHBoy
  TCy7seKM1bXJCYW5yZDpE6xajLcX7n/r3MQix5+XmpUuK8dbuBigRAijJK8+BGwFLCJUZZKWF
  eRgYGBiGegtSi3MwSVPlXjOIcjErCvNu2AU3hycwrgdv0CugIJqAjIsXaQI4oSURISTUwpfeY
  KjvIZoh5n17HEt6yvFIsY+WqU5cKw2Yqym80YTwSfnjyyU4Tsd99Xd5TzKRlGy8ui50vkcHP0
  /g/bnn47Et19cpVr1v25Prx5OZ6bKudouLluv50s9nkuUkJHjWth7Yt0/r79c87iYdinFrzRB
  NshWqiueaGWBxYwM5lHxuStVbik8GzFqn2NRK+H1d9Sg79VacmeKov4HL2DKEK36BJD6ceNNS
  pCJ22l9959leZoOMrZy3defDsV83v4iV35+z6N+HzQv62PYfYdgjknnW6ufCh+Id8Vbb2Find
  w/HL7fw8XZ8nr/31rXXdMr605643W807spbkW3aIHzy26WYya+2pgCufIj6s3ZepxFKckWiox
  VxUnAgAzTH1BIQDAAA=
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-8.tower-585.messagelabs.com!1669905583!37561!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12039 invoked from network); 1 Dec 2022 14:39:43 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-8.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Dec 2022 14:39:43 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id F22681001A4;
        Thu,  1 Dec 2022 14:39:42 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id E595B10019E;
        Thu,  1 Dec 2022 14:39:42 +0000 (GMT)
Received: from fcf4c122d5e4.localdomain (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 1 Dec 2022 14:39:39 +0000
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>,
        <rpearsonhpe@gmail.com>
CC:     <leon@kernel.org>, <lizhijian@fujitsu.com>, <y-goto@fujitsu.com>,
        <zyjzyj2000@gmail.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v7 6/8] RDMA/rxe: Make responder support atomic write on RC service
Date:   Thu, 1 Dec 2022 14:39:26 +0000
Message-ID: <1669905568-62-2-git-send-email-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1669905568-62-1-git-send-email-yangx.jy@fujitsu.com>
References: <1669905568-62-1-git-send-email-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make responder process an atomic write request and send a read response
on RC service.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 84 ++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 6761bcd1d4d8..6ac544477f3f 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -22,6 +22,7 @@ enum resp_states {
 	RESPST_EXECUTE,
 	RESPST_READ_REPLY,
 	RESPST_ATOMIC_REPLY,
+	RESPST_ATOMIC_WRITE_REPLY,
 	RESPST_COMPLETE,
 	RESPST_ACKNOWLEDGE,
 	RESPST_CLEANUP,
@@ -57,6 +58,7 @@ static char *resp_state_name[] = {
 	[RESPST_EXECUTE]			= "EXECUTE",
 	[RESPST_READ_REPLY]			= "READ_REPLY",
 	[RESPST_ATOMIC_REPLY]			= "ATOMIC_REPLY",
+	[RESPST_ATOMIC_WRITE_REPLY]		= "ATOMIC_WRITE_REPLY",
 	[RESPST_COMPLETE]			= "COMPLETE",
 	[RESPST_ACKNOWLEDGE]			= "ACKNOWLEDGE",
 	[RESPST_CLEANUP]			= "CLEANUP",
@@ -263,7 +265,7 @@ static enum resp_states check_op_valid(struct rxe_qp *qp,
 	case IB_QPT_RC:
 		if (((pkt->mask & RXE_READ_MASK) &&
 		     !(qp->attr.qp_access_flags & IB_ACCESS_REMOTE_READ)) ||
-		    ((pkt->mask & RXE_WRITE_MASK) &&
+		    ((pkt->mask & (RXE_WRITE_MASK | RXE_ATOMIC_WRITE_MASK)) &&
 		     !(qp->attr.qp_access_flags & IB_ACCESS_REMOTE_WRITE)) ||
 		    ((pkt->mask & RXE_ATOMIC_MASK) &&
 		     !(qp->attr.qp_access_flags & IB_ACCESS_REMOTE_ATOMIC))) {
@@ -367,7 +369,7 @@ static enum resp_states check_resource(struct rxe_qp *qp,
 		}
 	}
 
-	if (pkt->mask & RXE_READ_OR_ATOMIC_MASK) {
+	if (pkt->mask & (RXE_READ_OR_ATOMIC_MASK | RXE_ATOMIC_WRITE_MASK)) {
 		/* it is the requesters job to not send
 		 * too many read/atomic ops, we just
 		 * recycle the responder resource queue
@@ -438,7 +440,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	enum resp_states state;
 	int access;
 
-	if (pkt->mask & RXE_READ_OR_WRITE_MASK) {
+	if (pkt->mask & (RXE_READ_OR_WRITE_MASK | RXE_ATOMIC_WRITE_MASK)) {
 		if (pkt->mask & RXE_RETH_MASK) {
 			qp->resp.va = reth_va(pkt);
 			qp->resp.offset = 0;
@@ -504,7 +506,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 		goto err;
 	}
 
-	if (pkt->mask & RXE_WRITE_MASK)	 {
+	if (pkt->mask & (RXE_WRITE_MASK | RXE_ATOMIC_WRITE_MASK)) {
 		if (resid > mtu) {
 			if (pktlen != mtu || bth_pad(pkt)) {
 				state = RESPST_ERR_LENGTH;
@@ -604,6 +606,7 @@ static struct resp_res *rxe_prepare_res(struct rxe_qp *qp,
 		res->state = rdatm_res_state_new;
 		break;
 	case RXE_ATOMIC_MASK:
+	case RXE_ATOMIC_WRITE_MASK:
 		res->first_psn = pkt->psn;
 		res->last_psn = pkt->psn;
 		res->cur_psn = pkt->psn;
@@ -673,6 +676,55 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 	return ret;
 }
 
+static enum resp_states atomic_write_reply(struct rxe_qp *qp,
+						struct rxe_pkt_info *pkt)
+{
+	u64 src, *dst;
+	struct resp_res *res = qp->resp.res;
+	struct rxe_mr *mr = qp->resp.mr;
+	int payload = payload_size(pkt);
+
+	if (!res) {
+		res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_WRITE_MASK);
+		qp->resp.res = res;
+	}
+
+	if (!res->replay) {
+#ifdef CONFIG_64BIT
+		if (mr->state != RXE_MR_STATE_VALID)
+			return RESPST_ERR_RKEY_VIOLATION;
+
+		memcpy(&src, payload_addr(pkt), payload);
+
+		dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, payload);
+		/* check vaddr is 8 bytes aligned. */
+		if (!dst || (uintptr_t)dst & 7)
+			return RESPST_ERR_MISALIGNED_ATOMIC;
+
+		/* Do atomic write after all prior operations have completed */
+		smp_store_release(dst, src);
+
+		/* decrease resp.resid to zero */
+		qp->resp.resid -= sizeof(payload);
+
+		qp->resp.msn++;
+
+		/* next expected psn, read handles this separately */
+		qp->resp.psn = (pkt->psn + 1) & BTH_PSN_MASK;
+		qp->resp.ack_psn = qp->resp.psn;
+
+		qp->resp.opcode = pkt->opcode;
+		qp->resp.status = IB_WC_SUCCESS;
+
+		return RESPST_ACKNOWLEDGE;
+#else
+		return RESPST_ERR_UNSUPPORTED_OPCODE;
+#endif /* CONFIG_64BIT */
+	}
+
+	return RESPST_ACKNOWLEDGE;
+}
+
 static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 					  struct rxe_pkt_info *ack,
 					  int opcode,
@@ -912,6 +964,8 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 		return RESPST_READ_REPLY;
 	} else if (pkt->mask & RXE_ATOMIC_MASK) {
 		return RESPST_ATOMIC_REPLY;
+	} else if (pkt->mask & RXE_ATOMIC_WRITE_MASK) {
+		return RESPST_ATOMIC_WRITE_REPLY;
 	} else {
 		/* Unreachable */
 		WARN_ON_ONCE(1);
@@ -1085,6 +1139,19 @@ static int send_atomic_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
 	return ret;
 }
 
+static int send_read_response_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
+{
+	int ret = send_common_ack(qp, syndrome, psn,
+			IB_OPCODE_RC_RDMA_READ_RESPONSE_ONLY,
+			"RDMA READ response of length zero ACK");
+
+	/* have to clear this since it is used to trigger
+	 * long read replies
+	 */
+	qp->resp.res = NULL;
+	return ret;
+}
+
 static enum resp_states acknowledge(struct rxe_qp *qp,
 				    struct rxe_pkt_info *pkt)
 {
@@ -1095,6 +1162,8 @@ static enum resp_states acknowledge(struct rxe_qp *qp,
 		send_ack(qp, qp->resp.aeth_syndrome, pkt->psn);
 	else if (pkt->mask & RXE_ATOMIC_MASK)
 		send_atomic_ack(qp, AETH_ACK_UNLIMITED, pkt->psn);
+	else if (pkt->mask & RXE_ATOMIC_WRITE_MASK)
+		send_read_response_ack(qp, AETH_ACK_UNLIMITED, pkt->psn);
 	else if (bth_ack(pkt))
 		send_ack(qp, AETH_ACK_UNLIMITED, pkt->psn);
 
@@ -1206,7 +1275,9 @@ static enum resp_states duplicate_request(struct rxe_qp *qp,
 			res->replay = 1;
 			res->cur_psn = pkt->psn;
 			qp->resp.res = res;
-			rc = RESPST_ATOMIC_REPLY;
+			rc = pkt->mask & RXE_ATOMIC_MASK ?
+					RESPST_ATOMIC_REPLY :
+					RESPST_ATOMIC_WRITE_REPLY;
 			goto out;
 		}
 
@@ -1343,6 +1414,9 @@ int rxe_responder(void *arg)
 		case RESPST_ATOMIC_REPLY:
 			state = atomic_reply(qp, pkt);
 			break;
+		case RESPST_ATOMIC_WRITE_REPLY:
+			state = atomic_write_reply(qp, pkt);
+			break;
 		case RESPST_ACKNOWLEDGE:
 			state = acknowledge(qp, pkt);
 			break;
-- 
2.34.1

