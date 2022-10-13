Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89F25FD310
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Oct 2022 03:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJMB72 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Oct 2022 21:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJMB71 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Oct 2022 21:59:27 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Oct 2022 18:59:26 PDT
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9C712C8A8
        for <linux-rdma@vger.kernel.org>; Wed, 12 Oct 2022 18:59:25 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="79798302"
X-IronPort-AV: E=Sophos;i="5.95,180,1661785200"; 
   d="scan'208";a="79798302"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP; 13 Oct 2022 10:48:01 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id D288FD432A
        for <linux-rdma@vger.kernel.org>; Thu, 13 Oct 2022 10:48:00 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0FB18D9498
        for <linux-rdma@vger.kernel.org>; Thu, 13 Oct 2022 10:48:00 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3002.s.css.fujitsu.com (Postfix) with ESMTP id C4665200B396;
        Thu, 13 Oct 2022 10:47:59 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 1/2] RDMA/rxe: Make responder handle RDMA Read failures
Date:   Thu, 13 Oct 2022 10:47:23 +0900
Message-Id: <20221013014724.3786212-1-matsuda-daisuke@fujitsu.com>
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

Currently, responder can reply packets with invalid payloads if it fails to
copy messages to the packets. Add an error handling in read_reply() to
inform a requesting node of the failure.

Suggested-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
FOR REVIEWERS:
  I referred to IB Specification Vol 1-Revision-1.5 to make this patch.
  Please see Ch.9.7.5.2.4, Ch.9.7.4.1.5 and Ch.9.7.5.1.3.

 drivers/infiniband/sw/rxe/rxe_resp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index ed5a09e86417..82b74e926e09 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -809,10 +809,14 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	if (!skb)
 		return RESPST_ERR_RNR;
 
-	rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
-		    payload, RXE_FROM_MR_OBJ);
+	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
+			  payload, RXE_FROM_MR_OBJ);
 	if (mr)
 		rxe_put(mr);
+	if (err) {
+		kfree_skb(skb);
+		return RESPST_ERR_RKEY_VIOLATION;
+	}
 
 	if (bth_pad(&ack_pkt)) {
 		u8 *pad = payload_addr(&ack_pkt) + payload;
-- 
2.31.1

