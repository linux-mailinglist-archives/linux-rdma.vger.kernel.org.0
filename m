Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E6F40A767
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 09:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240692AbhINHcm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 03:32:42 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:27973 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240665AbhINHcm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Sep 2021 03:32:42 -0400
IronPort-Data: =?us-ascii?q?A9a23=3A5vCtX6gNtMlZxWHScFcRsSorX161WBIKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkUBzGQZWGGCPKrbZWGmedokaom2pB8Gv5OHztJgQAFtpHw8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOi8xZVA/fvQHOOkWbe?=
 =?us-ascii?q?YYnkZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14MREs5OgD?=
 =?us-ascii?q?wU4FqPRmuUBSAQeGCZ7VUFD0OaefSTi75PPlSUqdFOpmZ2CFnoeL5wa6Pd1Wzk?=
 =?us-ascii?q?WrdQXLTkMalaIgOfe6La6TPR8w94vKcDDIowSoDdjwCvfAPJgRorMK43I6tBwz?=
 =?us-ascii?q?jY9ns0IFv+2WiazQVKDdzyZO1sWZAhRU8l4wY+VarDEW2UwgDqoSWAfugA/FDB?=
 =?us-ascii?q?M7YU=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AeDBKbqDpnUiY4oHlHeg/sceALOsnbusQ8zAX?=
 =?us-ascii?q?Ph9KJyC9I/b2qynxppgmPH/P6Ar4WBkb6La90Y27MA7hHPlOkPUs1NaZLXPbUQ?=
 =?us-ascii?q?6TTb2KgrGSpgEIdxeOktK1kJ0QDJSWa+eAfWSS7/yKmDVQeuxIqLLsndHK9IWu?=
 =?us-ascii?q?vEuFDzsaEJ2Ihz0JezpzeXcGPTWua6BJc6Z1saF81kSdkDksH4iGL0hAe9KGi8?=
 =?us-ascii?q?zAlZrgbxJDLxk76DOWhTftzLLhCRCX0joXTjsKmN4ZgCb4uj28wp/mn+Cwyxfa?=
 =?us-ascii?q?2WOWx5NKmOH5wt8GIMCXkMAaJhjllw7tToV8XL+puiwzvYiUmRkXueiJhy1lE9?=
 =?us-ascii?q?V46nvXcG3wiRzx2zP42DJr0HPmwU/wuwqpneXJABYBT+ZRj4NQdRXUr2A6ustn?=
 =?us-ascii?q?7a5N12WF87JKEBLphk3Glpv1fiAvsnDxjWspkOYVgXAae5AZcqVtoYsW+14QOI?=
 =?us-ascii?q?scHRj99JssHIBVfYHhDc5tABanhk3izy1SKITGZAV1Iv7GeDlChiWt6UkVoJgj?=
 =?us-ascii?q?pHFogvD2nR87hdoAotd/lr352gkBrsA4ciYsV9MJOA42e7r/NoX8e2O/DIusGy?=
 =?us-ascii?q?WSKEgmAQOGl3el2sR52AmVEKZ4uqfa3q6xCG9liQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.85,292,1624291200"; 
   d="scan'208";a="114456742"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Sep 2021 15:31:24 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 396284D0DC76;
        Tue, 14 Sep 2021 15:31:22 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 14 Sep 2021 15:31:21 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 14 Sep 2021 15:31:21 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <zyjzyj2000@gmail.com>, <jgg@ziepe.ca>,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH 2/3] RDMA/rxe: Add MASK suffix for RXE_READ_OR_ATOMIC and RXE_WRITE_OR_SEND
Date:   Tue, 14 Sep 2021 16:02:52 +0800
Message-ID: <20210914080253.1145353-3-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210914080253.1145353-1-yangx.jy@fujitsu.com>
References: <20210914080253.1145353-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 396284D0DC76.A7199
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_opcode.h | 4 ++--
 drivers/infiniband/sw/rxe/rxe_req.c    | 6 +++---
 drivers/infiniband/sw/rxe/rxe_resp.c   | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.h b/drivers/infiniband/sw/rxe/rxe_opcode.h
index bbeccb1dcec7..e3a46b287c15 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.h
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.h
@@ -82,8 +82,8 @@ enum rxe_hdr_mask {
 
 	RXE_LOOPBACK_MASK	= BIT(NUM_HDR_TYPES + 12),
 
-	RXE_READ_OR_ATOMIC	= (RXE_READ_MASK | RXE_ATOMIC_MASK),
-	RXE_WRITE_OR_SEND	= (RXE_WRITE_MASK | RXE_SEND_MASK),
+	RXE_READ_OR_ATOMIC_MASK	= (RXE_READ_MASK | RXE_ATOMIC_MASK),
+	RXE_WRITE_OR_SEND_MASK	= (RXE_WRITE_MASK | RXE_SEND_MASK),
 	RXE_READ_OR_WRITE_MASK	= (RXE_READ_MASK | RXE_WRITE_MASK),
 };
 
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 3894197a82f6..3e9309a0555e 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -472,7 +472,7 @@ static int finish_packet(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 	if (err)
 		return err;
 
-	if (pkt->mask & RXE_WRITE_OR_SEND) {
+	if (pkt->mask & RXE_WRITE_OR_SEND_MASK) {
 		if (wqe->wr.send_flags & IB_SEND_INLINE) {
 			u8 *tmp = &wqe->dma.inline_data[wqe->dma.sge_offset];
 
@@ -691,13 +691,13 @@ int rxe_requester(void *arg)
 	}
 
 	mask = rxe_opcode[opcode].mask;
-	if (unlikely(mask & RXE_READ_OR_ATOMIC)) {
+	if (unlikely(mask & RXE_READ_OR_ATOMIC_MASK)) {
 		if (check_init_depth(qp, wqe))
 			goto exit;
 	}
 
 	mtu = get_mtu(qp);
-	payload = (mask & RXE_WRITE_OR_SEND) ? wqe->dma.resid : 0;
+	payload = (mask & RXE_WRITE_OR_SEND_MASK) ? wqe->dma.resid : 0;
 	if (payload > mtu) {
 		if (qp_type(qp) == IB_QPT_UD) {
 			/* C10-93.1.1: If the total sum of all the buffer lengths specified for a
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 74fb06df4c6c..7237d4aa6d8a 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -374,7 +374,7 @@ static enum resp_states check_resource(struct rxe_qp *qp,
 		}
 	}
 
-	if (pkt->mask & RXE_READ_OR_ATOMIC) {
+	if (pkt->mask & RXE_READ_OR_ATOMIC_MASK) {
 		/* it is the requesters job to not send
 		 * too many read/atomic ops, we just
 		 * recycle the responder resource queue
-- 
2.23.0



