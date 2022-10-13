Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C3D5FD2F7
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Oct 2022 03:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJMBt0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Oct 2022 21:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiJMBtZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Oct 2022 21:49:25 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Oct 2022 18:49:24 PDT
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3157712C882
        for <linux-rdma@vger.kernel.org>; Wed, 12 Oct 2022 18:49:23 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="71572157"
X-IronPort-AV: E=Sophos;i="5.95,180,1661785200"; 
   d="scan'208";a="71572157"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP; 13 Oct 2022 10:48:18 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 43938AB655
        for <linux-rdma@vger.kernel.org>; Thu, 13 Oct 2022 10:48:18 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7AE6DD9BFD
        for <linux-rdma@vger.kernel.org>; Thu, 13 Oct 2022 10:48:17 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 5E675200B3B4;
        Thu, 13 Oct 2022 10:48:17 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH 2/2] RDMA/rxe: Handle remote errors in the midst of a Read reply sequence
Date:   Thu, 13 Oct 2022 10:47:24 +0900
Message-Id: <20221013014724.3786212-2-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221013014724.3786212-1-matsuda-daisuke@fujitsu.com>
References: <20221013014724.3786212-1-matsuda-daisuke@fujitsu.com>
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

Requesting nodes do not handle a reported error correctly if it is
generated in the middle of multi-packet Read responses, and the node tries
to resend the request endlessly. Let completer terminate the connection in
that case.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
FOR REVIEWERS:
  I referred to IB Specification Vol 1-Revision-1.5 to make this patch.
  Please see Ch.9.9.2.2, Ch.9.9.2.4.2 and Table 59.

 drivers/infiniband/sw/rxe/rxe_comp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index fb0c008af78c..c9170dd99f3a 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -200,6 +200,10 @@ static inline enum comp_state check_psn(struct rxe_qp *qp,
 		 */
 		if (pkt->psn == wqe->last_psn)
 			return COMPST_COMP_ACK;
+		else if (pkt->opcode == IB_OPCODE_RC_ACKNOWLEDGE &&
+			 (qp->comp.opcode == IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST ||
+			  qp->comp.opcode == IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE))
+			return COMPST_CHECK_ACK;
 		else
 			return COMPST_DONE;
 	} else if ((diff > 0) && (wqe->mask & WR_ATOMIC_OR_READ_MASK)) {
@@ -228,6 +232,10 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 
 	case IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST:
 	case IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE:
+		/* Check NAK code to handle a remote error */
+		if (pkt->opcode == IB_OPCODE_RC_ACKNOWLEDGE)
+			break;
+
 		if (pkt->opcode != IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE &&
 		    pkt->opcode != IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST) {
 			/* read retries of partial data may restart from
-- 
2.31.1

