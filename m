Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7D3480F6A
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Dec 2021 04:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbhL2Dpq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Dec 2021 22:45:46 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:32090 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233132AbhL2Dpp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Dec 2021 22:45:45 -0500
IronPort-Data: =?us-ascii?q?A9a23=3At8Y88ayTR2Ef4hv7prZ6t+fkxCrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApDIh0GNVzWRLXWDUa/aJYDChc91+Ydmw90tUvJKEyoBkHQtv/xmBbVoQ9?=
 =?us-ascii?q?5OdWo7xwmQcns+qBpSaChohtq3yU/GYRCwPZiKa9kfF3oTJ9yEmjPjSHOukUYY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWGULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIti?=
 =?us-ascii?q?j1LjmcEwWWaOUNg+L4pZUc/H6xEEc+WppieBmXBYfQR4/ZzGhjtl3x8ULt42YR?=
 =?us-ascii?q?xorP7HXhaIWVBww/yRWZPQXpu6ecCXu2SCU5wicG5f2+N10FEw/J5Yf/OZvDEl?=
 =?us-ascii?q?B8PUZLHYGaRXrr/O/xrCmTK9+htkLKMjtIZNZtnx+pRnbAvkOR47CT6TDo9Rf2?=
 =?us-ascii?q?V8YgsFIAOabfcYcYBJxYxnaJR5CIFEaDNQ5hujAu5VVW1W0s3rM/exuvTeVl1c?=
 =?us-ascii?q?3jdDQ3BPuUoTiba1ocoyw/woqJ1jEPyw=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AIHcNmKzb86UkSOqqAsgZKrPwEL1zdoMgy1kn?=
 =?us-ascii?q?xilNoH1uA6ilfqWV8cjzuiWbtN9vYhsdcLy7WZVoIkmskKKdg7NhXotKNTOO0A?=
 =?us-ascii?q?SVxepZnOnfKlPbexHWx6p00KdMV+xEAsTsMF4St63HyTj9P9E+4NTvysyVuds?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.88,244,1635177600"; 
   d="scan'208";a="119691959"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Dec 2021 11:45:44 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 289AB4D13BF7;
        Wed, 29 Dec 2021 11:45:38 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 29 Dec 2021 11:45:38 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 29 Dec 2021 11:45:36 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <yanjun.zhu@linux.dev>, <rpearsonhpe@gmail.com>, <jgg@nvidia.com>,
        "Xiao Yang" <yangx.jy@fujitsu.com>
Subject: [PATCH] RDMA/rxe: Check the last packet by RXE_END_MASK
Date:   Wed, 29 Dec 2021 11:44:38 +0800
Message-ID: <20211229034438.1854908-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 289AB4D13BF7.A9A4A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It's wrong to check the last packet by RXE_COMP_MASK because the flag
is to indicate if responder needs to generate a completion.

Fixes: 9fcd67d1772c ("IB/rxe: increment msn only when completing a request")
Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index e8f435fa6e4d..380934e38923 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -814,6 +814,10 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 			return RESPST_ERR_INVALIDATE_RKEY;
 	}
 
+	if (pkt->mask & RXE_END_MASK)
+		/* We successfully processed this new request. */
+		qp->resp.msn++;
+
 	/* next expected psn, read handles this separately */
 	qp->resp.psn = (pkt->psn + 1) & BTH_PSN_MASK;
 	qp->resp.ack_psn = qp->resp.psn;
@@ -821,11 +825,9 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 	qp->resp.opcode = pkt->opcode;
 	qp->resp.status = IB_WC_SUCCESS;
 
-	if (pkt->mask & RXE_COMP_MASK) {
-		/* We successfully processed this new request. */
-		qp->resp.msn++;
+	if (pkt->mask & RXE_COMP_MASK)
 		return RESPST_COMPLETE;
-	} else if (qp_type(qp) == IB_QPT_RC)
+	else if (qp_type(qp) == IB_QPT_RC)
 		return RESPST_ACKNOWLEDGE;
 	else
 		return RESPST_CLEANUP;
-- 
2.25.1



