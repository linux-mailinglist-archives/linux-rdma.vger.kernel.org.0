Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0873E47BC
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Aug 2021 16:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbhHIOif (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Aug 2021 10:38:35 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:13564 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235300AbhHIOgI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Aug 2021 10:36:08 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AgQ9DaarzydTrZQOT/3q/1Q0aV5opeYIsimQD?=
 =?us-ascii?q?101hICG8cqSj9vxGuM5rsiMc6QxhPE3I9urtBEDtexzhHNtOkO8s1NSZLWzbUQ?=
 =?us-ascii?q?mTXeJfBOLZqlWKcUDDH6xmpMVdmsBFeaTN5DNB7foSjjPXL+od?=
X-IronPort-AV: E=Sophos;i="5.84,307,1620662400"; 
   d="scan'208";a="112637421"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Aug 2021 22:35:08 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 9762C4D0D4AD;
        Mon,  9 Aug 2021 22:35:02 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 9 Aug 2021 22:35:02 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 9 Aug 2021 22:35:01 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <leon@kernel.org>
CC:     <rpearsonhpe@gmail.com>, <zyjzyj2000@gmail.com>, <jgg@nvidia.com>,
        "Xiao Yang" <yangx.jy@fujitsu.com>
Subject: [PATCH v2] providers/rxe: Set the correct value of resid for inline data
Date:   Mon, 9 Aug 2021 23:07:38 +0800
Message-ID: <20210809150738.150596-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 9762C4D0D4AD.A9243
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Resid indicates the residual length of transmitted bytes but current
rxe sets it to zero for inline data at the beginning.  In this case,
request will transmit zero byte to responder wrongly.

Resid should be set to the total length of transmitted bytes at the
beginning.

Note:
Just remove the useless setting of resid in init_send_wqe().

Fixes: 1a894ca10105 ("Providers/rxe: Implement ibv_create_qp_ex verb")
Fixes: 8337db5df125 ("Providers/rxe: Implement memory windows")
Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 providers/rxe/rxe.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index 3c3ea8bb..3533a325 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -1004,7 +1004,7 @@ static void wr_set_inline_data(struct ibv_qp_ex *ibqp, void *addr,
 
 	memcpy(wqe->dma.inline_data, addr, length);
 	wqe->dma.length = length;
-	wqe->dma.resid = 0;
+	wqe->dma.resid = length;
 }
 
 static void wr_set_inline_data_list(struct ibv_qp_ex *ibqp, size_t num_buf,
@@ -1035,6 +1035,7 @@ static void wr_set_inline_data_list(struct ibv_qp_ex *ibqp, size_t num_buf,
 	}
 
 	wqe->dma.length = tot_length;
+	wqe->dma.resid = tot_length;
 }
 
 static void wr_set_sge(struct ibv_qp_ex *ibqp, uint32_t lkey, uint64_t addr,
@@ -1473,8 +1474,6 @@ static int init_send_wqe(struct rxe_qp *qp, struct rxe_wq *sq,
 	if (ibwr->send_flags & IBV_SEND_INLINE) {
 		uint8_t *inline_data = wqe->dma.inline_data;
 
-		wqe->dma.resid = 0;
-
 		for (i = 0; i < num_sge; i++) {
 			memcpy(inline_data,
 			       (uint8_t *)(long)ibwr->sg_list[i].addr,
-- 
2.25.1



