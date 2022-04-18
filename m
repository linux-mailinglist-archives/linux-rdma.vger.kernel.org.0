Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960EB504C7C
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Apr 2022 08:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbiDRGPa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Apr 2022 02:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiDRGP2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Apr 2022 02:15:28 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF58817AB7
        for <linux-rdma@vger.kernel.org>; Sun, 17 Apr 2022 23:12:50 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AnOnyLKkmD8/PHoNPAhdfj7Ho5gwDJERdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bp2NRzTdOXm+AaKyKZWv1f9wlady28UgD7JTVzoRrQQc5+CA2RRqmi?=
 =?us-ascii?q?+KfW43BcR2Y0wB+jyH7ZBs+qZ1YM7EsFehsJpPnjkrrYuiJQUVUj/nSHOKmULe?=
 =?us-ascii?q?cY0ideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf8s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kur39NEMXQL/OJhXIgX1TM0SgqkEa4HVsjeBgb7xBAatUo2zhc9RZ2dxLuoz2S?=
 =?us-ascii?q?xYBMLDOmfgGTl9TFCQW0ahuoeWcfyTj65zPp6HBWz62qxl0N2ksJYAR4P1wB2F?=
 =?us-ascii?q?W+NQXLTkMalaIgOfe6LOhQ69zi8UlPeHqOp8SvjdryjSxJeohRJnYUePF/9hd1?=
 =?us-ascii?q?TsihcFmHPDCas5fYj1qBDzRahtNJ1FRGpIjtOOpgGTvNTFVtjq9p6U4y27NzQB?=
 =?us-ascii?q?w2f7mN9+9UtiLQ9hF21yUo2vu4Wv0GFcZOcaZxD7D9Wij7tIjNwuTtJk6TeX+r?=
 =?us-ascii?q?6A1xgbIgDF7NfHfbnPjydHRt6J0c4s3x5QoxxcT?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ac/7s56+KwF6EN0KVQLluk+A8I+orL9Y04lQ7?=
 =?us-ascii?q?vn2YSXRuHPBw8Pre+sjztCWE8Qr5N0tBpTntAsW9qDbnhPtICOoqTNCftWvdyQ?=
 =?us-ascii?q?iVxehZhOOIqVDd8m/Fh4pgPMxbEpSWZueeMbEDt7eZ3OCnKadc/PC3tLCvmfzF?=
 =?us-ascii?q?z2pgCSVja6Rb5Q9/DQqBe3cGPzVuNN4oEoaG/Mpbq36FcXQTVM6yAX4IRKztvN?=
 =?us-ascii?q?vO/aiWGyIuNlo27hWUlzO05PrfGxic5B0XVDRC2vMD3AH+4nTE2pk=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123644284"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Apr 2022 14:12:48 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 8B83C4D16FF2;
        Mon, 18 Apr 2022 14:12:47 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 18 Apr 2022 14:12:45 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 18 Apr 2022 14:12:49 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <yanjun.zhu@linux.dev>, <rpearsonhpe@gmail.com>, <jgg@nvidia.com>,
        <y-goto@fujitsu.com>, <lizhijian@fujitsu.com>,
        <tomasz.gromadzki@intel.com>, <ira.weiny@intel.com>,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v4 1/3] RDMA/rxe: Rename send_atomic_ack() and atomic member of struct resp_res
Date:   Mon, 18 Apr 2022 14:12:42 +0800
Message-ID: <20220418061244.89025-2-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220418061244.89025-1-yangx.jy@fujitsu.com>
References: <20220418061244.89025-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 8B83C4D16FF2.A8FD6
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

send_atomic_ack() and atomic member of struct resp_res will be common
in the future so rename them.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c    |  2 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  | 10 +++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.h |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index ff58f76347c9..c9e382bc4a66 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -130,7 +130,7 @@ static void free_rd_atomic_resources(struct rxe_qp *qp)
 void free_rd_atomic_resource(struct rxe_qp *qp, struct resp_res *res)
 {
 	if (res->type == RXE_ATOMIC_MASK)
-		kfree_skb(res->atomic.skb);
+		kfree_skb(res->resp.skb);
 	res->type = 0;
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index e2653a8721fe..4ee923352056 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1004,7 +1004,7 @@ static int send_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	return err;
 }
 
-static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
+static int send_resp(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 			   u8 syndrome)
 {
 	int rc = 0;
@@ -1026,7 +1026,7 @@ static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 
 	skb_get(skb);
 	res->type = RXE_ATOMIC_MASK;
-	res->atomic.skb = skb;
+	res->resp.skb = skb;
 	res->first_psn = ack_pkt.psn;
 	res->last_psn  = ack_pkt.psn;
 	res->cur_psn   = ack_pkt.psn;
@@ -1049,7 +1049,7 @@ static enum resp_states acknowledge(struct rxe_qp *qp,
 	if (qp->resp.aeth_syndrome != AETH_ACK_UNLIMITED)
 		send_ack(qp, pkt, qp->resp.aeth_syndrome, pkt->psn);
 	else if (pkt->mask & RXE_ATOMIC_MASK)
-		send_atomic_ack(qp, pkt, AETH_ACK_UNLIMITED);
+		send_resp(qp, pkt, AETH_ACK_UNLIMITED);
 	else if (bth_ack(pkt))
 		send_ack(qp, pkt, AETH_ACK_UNLIMITED, pkt->psn);
 
@@ -1158,9 +1158,9 @@ static enum resp_states duplicate_request(struct rxe_qp *qp,
 		/* Find the operation in our list of responder resources. */
 		res = find_resource(qp, pkt->psn);
 		if (res) {
-			skb_get(res->atomic.skb);
+			skb_get(res->resp.skb);
 			/* Resend the result. */
-			rc = rxe_xmit_packet(qp, pkt, res->atomic.skb);
+			rc = rxe_xmit_packet(qp, pkt, res->resp.skb);
 			if (rc) {
 				pr_err("Failed resending result. This flow is not handled - skb ignored\n");
 				rc = RESPST_CLEANUP;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 86068d70cd95..20be40c42294 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -155,7 +155,7 @@ struct resp_res {
 	union {
 		struct {
 			struct sk_buff	*skb;
-		} atomic;
+		} resp;
 		struct {
 			u64		va_org;
 			u32		rkey;
-- 
2.34.1



