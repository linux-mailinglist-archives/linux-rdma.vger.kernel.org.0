Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8955A0EA5
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Aug 2022 13:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240635AbiHYLDk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Aug 2022 07:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiHYLDj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Aug 2022 07:03:39 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51914AC24C
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 04:03:38 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="85970233"
X-IronPort-AV: E=Sophos;i="5.93,262,1654527600"; 
   d="scan'208";a="85970233"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 25 Aug 2022 20:03:37 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 59A6FD29E5
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 20:03:35 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (m3003.s.css.fujitsu.com [10.128.233.114])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 864CED999D
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 20:03:34 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 469A1203EF2A;
        Thu, 25 Aug 2022 20:03:34 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     leonro@nvidia.com, jgg@nvidia.com, zyjzyj2000@gmail.com
Cc:     linux-rdma@vger.kernel.org,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH] RDMA/rxe: Ratelimit error messages of read_reply()
Date:   Thu, 25 Aug 2022 20:02:55 +0900
Message-Id: <20220825110255.658706-1-matsuda-daisuke@fujitsu.com>
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

When responder cannot copy data from a user MR, error messages overflow.
This is because an incoming RDMA Read request can results in multiple Read
responses. If the target MR is somehow unavailable, then the error message
is generated for every Read response.

For the same reason, the error message for packet transmission should also
be ratelimited.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index b36ec5c4d5e0..f9e9679b5e32 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -812,7 +812,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
 			  payload, RXE_FROM_MR_OBJ);
 	if (err)
-		pr_err("Failed copying memory\n");
+		pr_err_ratelimited("Failed copying memory\n");
 	if (mr)
 		rxe_put(mr);
 
@@ -824,7 +824,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 
 	err = rxe_xmit_packet(qp, &ack_pkt, skb);
 	if (err) {
-		pr_err("Failed sending RDMA reply.\n");
+		pr_err_ratelimited("Failed sending RDMA reply.\n");
 		return RESPST_ERR_RNR;
 	}
 
-- 
2.31.1

