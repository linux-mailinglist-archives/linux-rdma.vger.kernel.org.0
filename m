Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BAD61EABC
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 06:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiKGFzL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Nov 2022 00:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiKGFzK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Nov 2022 00:55:10 -0500
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89990BCAF
        for <linux-rdma@vger.kernel.org>; Sun,  6 Nov 2022 21:54:56 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="83009203"
X-IronPort-AV: E=Sophos;i="5.96,143,1665414000"; 
   d="scan'208";a="83009203"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 07 Nov 2022 14:54:54 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6D65DE8520
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 14:54:53 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id C1FD8D35FF
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 14:54:52 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 97208200B285;
        Mon,  7 Nov 2022 14:54:52 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     leonro@nvidia.com, jgg@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     lizhijian@fujitsu.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH v2] RDMA/rxe: Implement packet length validation on responder
Date:   Mon,  7 Nov 2022 14:53:38 +0900
Message-Id: <20221107055338.357184-1-matsuda-daisuke@fujitsu.com>
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

The function check_length() is supposed to check the length of inbound
packets on responder, but it actually has been a stub since the driver was
born. Let it check the payload length and the DMA length.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
FOR REVIEWERS
  I referred to IB Specification Vol 1-Revision-1.5 to create this patch.
  Please see 9.7.4.1.6 (page.330).

v2: Fixed the conditional for 'last' packets. Thanks, Zhijian.

 drivers/infiniband/sw/rxe/rxe_resp.c | 34 ++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index c32bc12cc82f..382d2053db43 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -393,16 +393,36 @@ static enum resp_states check_resource(struct rxe_qp *qp,
 static enum resp_states check_length(struct rxe_qp *qp,
 				     struct rxe_pkt_info *pkt)
 {
-	switch (qp_type(qp)) {
-	case IB_QPT_RC:
-		return RESPST_CHK_RKEY;
+	int mtu = qp->mtu;
+	u32 payload = payload_size(pkt);
+	u32 dmalen = reth_len(pkt);
 
-	case IB_QPT_UC:
-		return RESPST_CHK_RKEY;
+	/* RoCEv2 packets do not have LRH.
+	 * Let's skip checking it.
+	 */
 
-	default:
-		return RESPST_CHK_RKEY;
+	if ((pkt->opcode & RXE_START_MASK) &&
+	    (pkt->opcode & RXE_END_MASK)) {
+		/* "only" packets */
+		if (payload > mtu)
+			return RESPST_ERR_LENGTH;
+	} else if ((pkt->opcode & RXE_START_MASK) ||
+		   (pkt->opcode & RXE_MIDDLE_MASK)) {
+		/* "first" or "middle" packets */
+		if (payload != mtu)
+			return RESPST_ERR_LENGTH;
+	} else if (pkt->opcode & RXE_END_MASK) {
+		/* "last" packets */
+		if ((payload == 0) || (payload > mtu))
+			return RESPST_ERR_LENGTH;
+	}
+
+	if (pkt->opcode & (RXE_WRITE_MASK | RXE_READ_MASK)) {
+		if (dmalen > (1 << 31))
+			return RESPST_ERR_LENGTH;
 	}
+
+	return RESPST_CHK_RKEY;
 }
 
 static enum resp_states check_rkey(struct rxe_qp *qp,
-- 
2.31.1

