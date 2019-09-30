Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72EAFC1C2C
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Sep 2019 09:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfI3HlB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Sep 2019 03:41:01 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:57110 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfI3HlB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Sep 2019 03:41:01 -0400
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x8U7epJn001955;
        Mon, 30 Sep 2019 00:40:56 -0700
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com
Subject: [PATCH for-rc] iw_cxgb4: fix ECN check on the passive accept
Date:   Mon, 30 Sep 2019 13:10:48 +0530
Message-Id: <20190930074048.19995-1-bharat@chelsio.com>
X-Mailer: git-send-email 2.18.0.232.gb7bd9486b055
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

pass_accept_req() is using the same skb for handling accept request and
sending accept reply to HW. Here req and rpl structures are pointing to
same skb->data which is over written by INIT_TP_WR() and leads to
accessing corrupt req fields in accept_cr() while checking for ECN flags.
Reordered code in accept_cr() to fetch correct req fields.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/infiniband/hw/cxgb4/cm.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index e87fc0408470..9e8eca7b613c 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -2424,20 +2424,6 @@ static int accept_cr(struct c4iw_ep *ep, struct sk_buff *skb,
 	enum chip_type adapter_type = ep->com.dev->rdev.lldi.adapter_type;
 
 	pr_debug("ep %p tid %u\n", ep, ep->hwtid);
-
-	skb_get(skb);
-	rpl = cplhdr(skb);
-	if (!is_t4(adapter_type)) {
-		skb_trim(skb, roundup(sizeof(*rpl5), 16));
-		rpl5 = (void *)rpl;
-		INIT_TP_WR(rpl5, ep->hwtid);
-	} else {
-		skb_trim(skb, sizeof(*rpl));
-		INIT_TP_WR(rpl, ep->hwtid);
-	}
-	OPCODE_TID(rpl) = cpu_to_be32(MK_OPCODE_TID(CPL_PASS_ACCEPT_RPL,
-						    ep->hwtid));
-
 	cxgb_best_mtu(ep->com.dev->rdev.lldi.mtus, ep->mtu, &mtu_idx,
 		      enable_tcp_timestamps && req->tcpopt.tstamp,
 		      (ep->com.remote_addr.ss_family == AF_INET) ? 0 : 1);
@@ -2483,6 +2469,20 @@ static int accept_cr(struct c4iw_ep *ep, struct sk_buff *skb,
 		if (tcph->ece && tcph->cwr)
 			opt2 |= CCTRL_ECN_V(1);
 	}
+
+	skb_get(skb);
+	rpl = cplhdr(skb);
+	if (!is_t4(adapter_type)) {
+		skb_trim(skb, roundup(sizeof(*rpl5), 16));
+		rpl5 = (void *)rpl;
+		INIT_TP_WR(rpl5, ep->hwtid);
+	} else {
+		skb_trim(skb, sizeof(*rpl));
+		INIT_TP_WR(rpl, ep->hwtid);
+	}
+	OPCODE_TID(rpl) = cpu_to_be32(MK_OPCODE_TID(CPL_PASS_ACCEPT_RPL,
+						    ep->hwtid));
+
 	if (CHELSIO_CHIP_VERSION(adapter_type) > CHELSIO_T4) {
 		u32 isn = (prandom_u32() & ~7UL) - 1;
 		opt2 |= T5_OPT_2_VALID_F;
-- 
2.18.0.232.gb7bd9486b055

