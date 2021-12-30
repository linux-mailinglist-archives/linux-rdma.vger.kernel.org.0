Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC288481BF3
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Dec 2021 13:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239033AbhL3MRu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Dec 2021 07:17:50 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:38440 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229463AbhL3MRt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Dec 2021 07:17:49 -0500
IronPort-Data: =?us-ascii?q?A9a23=3Ad6NkaaISKR3O8JqpFE+RJpclxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHCxgDJw1mFVympKDTrTafmCYzCkft1zYYnkoBkCuJ7Xy4NqS1BcGVNFFSwT8?=
 =?us-ascii?q?ZWfbTi6wuYcBwvLd4ubChsPA/w2MrEsF+hpCC+MzvuRGuK59yAlj/rQHuCU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+qUzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8mDJW?=
 =?us-ascii?q?rj7T6blYXBLXVOGBiiFIPA+773EcE/Xd0j87XN9JFAatToySAmd9hjtdcnZKtS?=
 =?us-ascii?q?wY1JbCKk+MYO/VdO3gnbPIboOaffRBTtuTWlSUqaUDE2e1jBVstOosY4utfDmR?=
 =?us-ascii?q?H9PheIzcIBjifgOe/26D9RfNrg80vPsrqFIIZpnxkizreCJ4OUJnFQbjMo81Yw?=
 =?us-ascii?q?R80h8ZTDbDSatRxQThgYzzGfRxDO15RA5U79M+sh3/iY3hCpFecjbQ47nKVzwF?=
 =?us-ascii?q?r1rXpdt3PdbS3qW999qqDjjueuT2nXVdBb5rCoQdpO0mE3ofn9R4XkqpLfFFgy?=
 =?us-ascii?q?sNXvQ=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A58KVHqtZKoSUXBaIHtqwezSx7skDStV00zEX?=
 =?us-ascii?q?/kB9WHVpm62j5qSTdZEguCMc5wx+ZJheo7q90cW7IE80lqQFhLX5X43SPzUO0V?=
 =?us-ascii?q?HARO5fBODZsl/d8kPFltJ15ONJdqhSLJnKB0FmsMCS2mKFOudl7N6Z0K3Av4vj?=
 =?us-ascii?q?80s=3D?=
X-IronPort-AV: E=Sophos;i="5.88,248,1635177600"; 
   d="scan'208";a="119750104"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Dec 2021 20:15:25 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 5EF5B4D15A21;
        Thu, 30 Dec 2021 20:15:20 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 30 Dec 2021 20:15:22 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 30 Dec 2021 20:15:18 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <yanjun.zhu@linux.dev>, <rpearsonhpe@gmail.com>, <jgg@nvidia.com>,
        <y-goto@fujitsu.com>, <lizhijian@fujitsu.com>,
        <tomasz.gromadzki@intel.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [RFC PATCH 1/2] RDMA/rxe: Rename send_atomic_ack() and atomic member of struct resp_res
Date:   Thu, 30 Dec 2021 20:14:22 +0800
Message-ID: <20211230121423.1919550-2-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 5EF5B4D15A21.A8576
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
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
index 54b8711321c1..f3eec350f95c 100644
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
index 380934e38923..738e6b6335e5 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -959,7 +959,7 @@ static int send_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	return err;
 }
 
-static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
+static int send_resp(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 			   u8 syndrome)
 {
 	int rc = 0;
@@ -981,7 +981,7 @@ static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 
 	skb_get(skb);
 	res->type = RXE_ATOMIC_MASK;
-	res->atomic.skb = skb;
+	res->resp.skb = skb;
 	res->first_psn = ack_pkt.psn;
 	res->last_psn  = ack_pkt.psn;
 	res->cur_psn   = ack_pkt.psn;
@@ -1004,7 +1004,7 @@ static enum resp_states acknowledge(struct rxe_qp *qp,
 	if (qp->resp.aeth_syndrome != AETH_ACK_UNLIMITED)
 		send_ack(qp, pkt, qp->resp.aeth_syndrome, pkt->psn);
 	else if (pkt->mask & RXE_ATOMIC_MASK)
-		send_atomic_ack(qp, pkt, AETH_ACK_UNLIMITED);
+		send_resp(qp, pkt, AETH_ACK_UNLIMITED);
 	else if (bth_ack(pkt))
 		send_ack(qp, pkt, AETH_ACK_UNLIMITED, pkt->psn);
 
@@ -1113,9 +1113,9 @@ static enum resp_states duplicate_request(struct rxe_qp *qp,
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
index 35e041450090..e0606e5f9962 100644
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
2.23.0



