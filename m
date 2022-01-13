Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D4848D09F
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jan 2022 04:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiAMDEy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jan 2022 22:04:54 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:20061 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231833AbiAMDEv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jan 2022 22:04:51 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AbETp3610/O26V1RDxvbD5VRzkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJgjMkgWQAmmFMWmGCbPiJYGX3ftt/boi3pkoB757SytU2QQE+nZ1PZygU8?=
 =?us-ascii?q?JKaX7x1DatR0xu6d5SFFAQ+hyknQoGowPscEzmM9n9BDpC79SMmjfjRHOKnYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5S31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFAdX?=
 =?us-ascii?q?jnKv5c1ERX/jZOg3mZnh+AvDk20Yd4HdplPtT2Pk0MC+7jx2YltZ+2JNPpLS+V?=
 =?us-ascii?q?AUoIrbR3u8aVnG0FgknZ/UdoOeacCXXXcu7iheun2HX6+92AUgsJooe+v56KW5?=
 =?us-ascii?q?L/P0cbjsKa3irm+WzyampDOZ2gcEqINvoPasevG1tyXfSCvNOaYHKRafX45lK3?=
 =?us-ascii?q?CoYgsFIAOaYa8cHARJtYxvoZQNONlYeTpk5mY+Amn76WyFRrEqYtOw85G275Ah?=
 =?us-ascii?q?w1qX9dcDZf9WiW8pYhACbq3jA8mC/BQsVXOFzYxLtHmmE37eJxH2kHtlJUuDQy?=
 =?us-ascii?q?xKju3XLrkR7NfHcfQTTTSGFt3OD?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A0eYA3a8pPZ10SDTe5ANuk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,284,1635177600"; 
   d="scan'208";a="120300595"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 13 Jan 2022 11:04:48 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 8D3D64D15A5C;
        Thu, 13 Jan 2022 11:04:43 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 13 Jan 2022 11:04:44 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 13 Jan 2022 11:04:40 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>, <tom@talpey.com>
CC:     <yanjun.zhu@linux.dev>, <rpearsonhpe@gmail.com>,
        <y-goto@fujitsu.com>, <lizhijian@fujitsu.com>,
        <tomasz.gromadzki@intel.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [RFC PATCH v2 1/2] RDMA/rxe: Rename send_atomic_ack() and atomic member of struct resp_res
Date:   Thu, 13 Jan 2022 11:03:49 +0800
Message-ID: <20220113030350.2492841-2-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220113030350.2492841-1-yangx.jy@fujitsu.com>
References: <20220113030350.2492841-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 8D3D64D15A5C.A8D5E
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



