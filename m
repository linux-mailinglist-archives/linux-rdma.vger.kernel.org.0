Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB824D6105
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Mar 2022 12:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244585AbiCKLyW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Mar 2022 06:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344712AbiCKLyV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Mar 2022 06:54:21 -0500
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1D1D10708B
        for <linux-rdma@vger.kernel.org>; Fri, 11 Mar 2022 03:53:17 -0800 (PST)
IronPort-Data: =?us-ascii?q?A9a23=3ARlKe1KAWLS9GkhVW/7vhw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fVwfshT8ghmZTmGsdXW3Tbq2LamTwedxyPYq/pEwHvsOAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkHhcwmj/3auK79SMkjPnRLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9GgjOGj5Zz2f1DqJ6xV?=
 =?us-ascii?q?Rw0eKbLnYzxVjEBSXsjYfwfpe6vzX+X9Jb7I1f9W2H0zvx0F0YwPZUV0ulyCGB?=
 =?us-ascii?q?Ks/cfLVglbwqKwf27wbSqYuhqmsknasLsOes3pnZlxCrLS/k8RpXKT7fJ5PdZ2?=
 =?us-ascii?q?is9goZFGvO2T9sQbzhyalLSYwBnPlYRFYJ4kOq27lH9fDJwrkyUqas+pWPUyWR?=
 =?us-ascii?q?ZzL/oGMbcfsSHVINemUPwjmbH+XnpRwsWMdW31zWI6DSvi/XJkCe9X5gdfIBUX?=
 =?us-ascii?q?NYCbEa7nzRVUUNJEwDg56TRt6J3YPoHQ2R8x8bkhfVaGJSXc+TA?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AtnJIaq+GqGsump4EzN5uk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="122549159"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Mar 2022 19:53:16 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 976824D169E7;
        Fri, 11 Mar 2022 19:53:10 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 11 Mar 2022 19:53:11 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 11 Mar 2022 19:52:50 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <yanjun.zhu@linux.dev>, <rpearsonhpe@gmail.com>, <jgg@nvidia.com>,
        <y-goto@fujitsu.com>, <lizhijian@fujitsu.com>,
        <tomasz.gromadzki@intel.com>, <tom@talpey.com>,
        <ira.weiny@intel.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v3 1/3] RDMA/rxe: Rename send_atomic_ack() and atomic member of struct resp_res
Date:   Fri, 11 Mar 2022 19:52:45 +0800
Message-ID: <20220311115247.23521-2-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220311115247.23521-1-yangx.jy@fujitsu.com>
References: <20220311115247.23521-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 976824D169E7.A9D56
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
index 5018b9387694..ca07e37d30a6 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -136,7 +136,7 @@ static void free_rd_atomic_resources(struct rxe_qp *qp)
 void free_rd_atomic_resource(struct rxe_qp *qp, struct resp_res *res)
 {
 	if (res->type == RXE_ATOMIC_MASK) {
-		kfree_skb(res->atomic.skb);
+		kfree_skb(res->resp.skb);
 	} else if (res->type == RXE_READ_MASK) {
 		if (res->read.mr)
 			rxe_drop_ref(res->read.mr);
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index e8f435fa6e4d..e015860e8c34 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -957,7 +957,7 @@ static int send_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	return err;
 }
 
-static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
+static int send_resp(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 			   u8 syndrome)
 {
 	int rc = 0;
@@ -979,7 +979,7 @@ static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 
 	skb_get(skb);
 	res->type = RXE_ATOMIC_MASK;
-	res->atomic.skb = skb;
+	res->resp.skb = skb;
 	res->first_psn = ack_pkt.psn;
 	res->last_psn  = ack_pkt.psn;
 	res->cur_psn   = ack_pkt.psn;
@@ -1002,7 +1002,7 @@ static enum resp_states acknowledge(struct rxe_qp *qp,
 	if (qp->resp.aeth_syndrome != AETH_ACK_UNLIMITED)
 		send_ack(qp, pkt, qp->resp.aeth_syndrome, pkt->psn);
 	else if (pkt->mask & RXE_ATOMIC_MASK)
-		send_atomic_ack(qp, pkt, AETH_ACK_UNLIMITED);
+		send_resp(qp, pkt, AETH_ACK_UNLIMITED);
 	else if (bth_ack(pkt))
 		send_ack(qp, pkt, AETH_ACK_UNLIMITED, pkt->psn);
 
@@ -1111,9 +1111,9 @@ static enum resp_states duplicate_request(struct rxe_qp *qp,
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
index e48969e8d4c8..01421286ed07 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -155,7 +155,7 @@ struct resp_res {
 	union {
 		struct {
 			struct sk_buff	*skb;
-		} atomic;
+		} resp;
 		struct {
 			struct rxe_mr	*mr;
 			u64		va_org;
-- 
2.34.1



