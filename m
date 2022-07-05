Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A889B566A1A
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jul 2022 13:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbiGELqQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 07:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiGELqP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 07:46:15 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54BF017580
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 04:46:14 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3ACBsRuKI06jiqJQt5FE+RMZclxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHDq1Wkk3zUGm2JNDGnSOa2MYzT1L9F3Ptvkpk1S6JHVn4NqS1BcGVNFFSwT8?=
 =?us-ascii?q?ZWfbTi6wuYcBwvLd4ubChsPA/w2MrEsF+hpCC+MzvuRGuK59yMkj/nRHuOU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+qUzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8mDJW?=
 =?us-ascii?q?rj7T6blYXBLXVOGBiiFIPA+773EcE/Xd0j87XN9JFAatToySAmd9hjtdcnZKtS?=
 =?us-ascii?q?wY1JbCKk+MYO/VdO3gkYvcZpuaYcRBTtuTWlSUqaUDE2e1jBVstOosY4utfDmR?=
 =?us-ascii?q?H9PheIzcIBjiRluCk0bDhErE0rssmJcjveogYvxlIyTzeC94lTIrFTqGM4sVXt?=
 =?us-ascii?q?B80h8ZTDbPEa88QQSRgYQ6GYBBVPFoTTpUkk4+AhHbwWy9ZpUqY46E+i1U/ZiQ?=
 =?us-ascii?q?ZPKPFaYKTI4LVA54O2Bvwm44PxEyhajlyCTBV4WPtHqqQu9Ly?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ar3vscampWnxQXTClkIQBb5jGHADpDfIQ3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fw9vre+MjzsCWYtN9/Yh8dcK+7UpVoLUm8yXcX2/h1AV7BZniEhI?=
 =?us-ascii?q?LAFugLgrcKqAeQeREWmNQ86Y5QN4B6CPDVSWNxlNvG5mCDeOoI8Z2q97+JiI7l?=
 =?us-ascii?q?o0tQcQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="127276178"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Jul 2022 19:46:10 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 246EC4D17179;
        Tue,  5 Jul 2022 19:46:09 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 5 Jul 2022 19:46:10 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 5 Jul 2022 19:46:10 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <leon@kernel.org>, <jgg@ziepe.ca>, <rpearsonhpe@gmail.com>,
        <zyjzyj2000@gmail.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH 1/2] RDMA/rxe: Add common rxe_prepare_res()
Date:   Tue, 5 Jul 2022 19:46:02 +0800
Message-ID: <20220705114603.6768-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 246EC4D17179.A79E4
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

Replace rxe_prepare_atomic_res() and rxe_prepare_read_res()
with rxe_prepare_res().

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 71 +++++++++++++---------------
 1 file changed, 32 insertions(+), 39 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index ccdfc1a6b659..5536582b8fe4 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -553,27 +553,48 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
 	return rc;
 }
 
-/* Guarantee atomicity of atomic operations at the machine level. */
-static DEFINE_SPINLOCK(atomic_ops_lock);
-
-static struct resp_res *rxe_prepare_atomic_res(struct rxe_qp *qp,
-					       struct rxe_pkt_info *pkt)
+static struct resp_res *rxe_prepare_res(struct rxe_qp *qp,
+					struct rxe_pkt_info *pkt,
+					int type)
 {
 	struct resp_res *res;
+	u32 pkts;
 
 	res = &qp->resp.resources[qp->resp.res_head];
 	rxe_advance_resp_resource(qp);
 	free_rd_atomic_resource(qp, res);
 
-	res->type = RXE_ATOMIC_MASK;
-	res->first_psn = pkt->psn;
-	res->last_psn = pkt->psn;
-	res->cur_psn = pkt->psn;
+	res->type = type;
 	res->replay = 0;
 
+	switch (type) {
+	case RXE_READ_MASK:
+		res->read.va = qp->resp.va + qp->resp.offset;
+		res->read.va_org = qp->resp.va + qp->resp.offset;
+		res->read.resid = qp->resp.resid;
+		res->read.length = qp->resp.resid;
+		res->read.rkey = qp->resp.rkey;
+
+		pkts = max_t(u32, (reth_len(pkt) + qp->mtu - 1)/qp->mtu, 1);
+		res->first_psn = pkt->psn;
+		res->cur_psn = pkt->psn;
+		res->last_psn = (pkt->psn + pkts - 1) & BTH_PSN_MASK;
+
+		res->state = rdatm_res_state_new;
+		break;
+	case RXE_ATOMIC_MASK:
+		res->first_psn = pkt->psn;
+		res->last_psn = pkt->psn;
+		res->cur_psn = pkt->psn;
+		break;
+	}
+
 	return res;
 }
 
+/* Guarantee atomicity of atomic operations at the machine level. */
+static DEFINE_SPINLOCK(atomic_ops_lock);
+
 static enum resp_states rxe_atomic_reply(struct rxe_qp *qp,
 					 struct rxe_pkt_info *pkt)
 {
@@ -584,7 +605,7 @@ static enum resp_states rxe_atomic_reply(struct rxe_qp *qp,
 	u64 value;
 
 	if (!res) {
-		res = rxe_prepare_atomic_res(qp, pkt);
+		res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_MASK);
 		qp->resp.res = res;
 	}
 
@@ -680,34 +701,6 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 	return skb;
 }
 
-static struct resp_res *rxe_prepare_read_res(struct rxe_qp *qp,
-					struct rxe_pkt_info *pkt)
-{
-	struct resp_res *res;
-	u32 pkts;
-
-	res = &qp->resp.resources[qp->resp.res_head];
-	rxe_advance_resp_resource(qp);
-	free_rd_atomic_resource(qp, res);
-
-	res->type = RXE_READ_MASK;
-	res->replay = 0;
-	res->read.va = qp->resp.va + qp->resp.offset;
-	res->read.va_org = qp->resp.va + qp->resp.offset;
-	res->read.resid = qp->resp.resid;
-	res->read.length = qp->resp.resid;
-	res->read.rkey = qp->resp.rkey;
-
-	pkts = max_t(u32, (reth_len(pkt) + qp->mtu - 1)/qp->mtu, 1);
-	res->first_psn = pkt->psn;
-	res->cur_psn = pkt->psn;
-	res->last_psn = (pkt->psn + pkts - 1) & BTH_PSN_MASK;
-
-	res->state = rdatm_res_state_new;
-
-	return res;
-}
-
 /**
  * rxe_recheck_mr - revalidate MR from rkey and get a reference
  * @qp: the qp
@@ -778,7 +771,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	struct rxe_mr *mr;
 
 	if (!res) {
-		res = rxe_prepare_read_res(qp, req_pkt);
+		res = rxe_prepare_res(qp, req_pkt, RXE_READ_MASK);
 		qp->resp.res = res;
 	}
 
-- 
2.34.1



