Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CC3610CB2
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 11:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiJ1JFA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 05:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJ1JE7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 05:04:59 -0400
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8E45B9F3
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 02:04:56 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="73566152"
X-IronPort-AV: E=Sophos;i="5.95,220,1661785200"; 
   d="scan'208";a="73566152"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP; 28 Oct 2022 18:04:53 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id B8F6CD3EAF
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 18:04:53 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (m3003.s.css.fujitsu.com [10.128.233.114])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 197F6FEBE
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 18:04:53 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3003.s.css.fujitsu.com (Postfix) with ESMTP id ED96C203EF1A;
        Fri, 28 Oct 2022 18:04:52 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     leonro@nvidia.com, jgg@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH] RDMA/rxe: Implement packet length validation on responder
Date:   Fri, 28 Oct 2022 18:04:38 +0900
Message-Id: <20221028090438.2685345-1-matsuda-daisuke@fujitsu.com>
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

 drivers/infiniband/sw/rxe/rxe_resp.c | 36 ++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index ed5a09e86417..62e3a8195072 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -390,16 +390,38 @@ static enum resp_states check_resource(struct rxe_qp *qp,
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
+
+	} else if ((pkt->opcode & RXE_START_MASK) ||
+		   (pkt->opcode & RXE_MIDDLE_MASK)) {
+		/* "first" or "middle" packets */
+		if (payload != mtu)
+			return RESPST_ERR_LENGTH;
+
+	} else if (pkt->opcode & RXE_END_MASK) {
+		/* "last" packets */
+		if ((pkt->paylen == 0) || (pkt->paylen > mtu))
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

