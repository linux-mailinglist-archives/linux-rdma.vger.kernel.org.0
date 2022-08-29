Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5D35A4393
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 09:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiH2HMx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 03:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiH2HMw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 03:12:52 -0400
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95E44D819
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 00:12:50 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="87022106"
X-IronPort-AV: E=Sophos;i="5.93,272,1654527600"; 
   d="scan'208";a="87022106"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP; 29 Aug 2022 16:12:48 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 70712D5026
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 16:12:47 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (m3003.s.css.fujitsu.com [10.128.233.114])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id B5C54D35E3
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 16:12:46 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 8E5782026133;
        Mon, 29 Aug 2022 16:12:46 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     leonro@nvidia.com, jgg@nvidia.com, zyjzyj2000@gmail.com
Cc:     linux-rdma@vger.kernel.org,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH v2] RDMA/rxe: Delete error messages triggered by incoming Read requests
Date:   Mon, 29 Aug 2022 16:12:18 +0900
Message-Id: <20220829071218.1639065-1-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.31.1
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

An incoming Read request causes multiple Read responses. If a user MR to
copy data from is unavailable or responder cannot send a reply, then the
error messages can be printed for each response attempt, resulting in
message overflow.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
v2
  Stop passing unused value to 'err', as commented by Cheng Xu

 drivers/infiniband/sw/rxe/rxe_resp.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index b36ec5c4d5e0..7c336db5cb54 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -809,10 +809,8 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	if (!skb)
 		return RESPST_ERR_RNR;
 
-	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
-			  payload, RXE_FROM_MR_OBJ);
-	if (err)
-		pr_err("Failed copying memory\n");
+	rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
+		    payload, RXE_FROM_MR_OBJ);
 	if (mr)
 		rxe_put(mr);
 
@@ -823,10 +821,8 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	}
 
 	err = rxe_xmit_packet(qp, &ack_pkt, skb);
-	if (err) {
-		pr_err("Failed sending RDMA reply.\n");
+	if (err)
 		return RESPST_ERR_RNR;
-	}
 
 	res->read.va += payload;
 	res->read.resid -= payload;
-- 
2.31.1

