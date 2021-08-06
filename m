Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09F93E2372
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Aug 2021 08:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhHFGsB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Aug 2021 02:48:01 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:40799 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236559AbhHFGsB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Aug 2021 02:48:01 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ANvyxpaGs820JjTVXpLqFOpHXdLJyesId70hD?=
 =?us-ascii?q?6qkvc3Fom52j/fxGws5x6faVslkssRAb6LS90cy7LU80mqQFhLX5UY3SPjUO21?=
 =?us-ascii?q?HYV72Kj7GSuwEIcheWnoA9pNpdmsBFeaTN5DNB7foSjjPIcOrJl7K8gcaVbKrl?=
 =?us-ascii?q?vgNQZDAvT5slwxZyCw6dHEEzbA5aBaAhHJ7ZwsZcvTKvdVkec8z+XxA+Lp7+ju?=
 =?us-ascii?q?yOsKijTQ8NBhYh5gXLpTS06ITiGxzd+hsFSTtAzZor7GCAuQ3k4aeIte2913bn?=
 =?us-ascii?q?phjuxqUTvOGk5spIBcSKhMRQAC7rkByUaINoXKDHlCwpocm0gWxa2uXkklMFBY?=
 =?us-ascii?q?Be+nnRdma6rV/GwA/7ygsj7Hfk1BuxnWbjm8rkXzg3YvAxzr6xSiGpp3bIgesM?=
 =?us-ascii?q?n56ihwmixtRq5FL77WzADuHzJlxXfhHemwtirQZ75EYvK7f3a9dq3P8iFQ1uYd?=
 =?us-ascii?q?c99RnBmf8a+d9VfbHhDcZtAC+nhk/izxdSKfyXLwYO90S9Mz0/UvL86UkmoJkv?=
 =?us-ascii?q?9Tp++CVYpAZIyK4A?=
X-IronPort-AV: E=Sophos;i="5.84,299,1620662400"; 
   d="scan'208";a="112491910"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 06 Aug 2021 14:47:44 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 9458D4D0D4A6;
        Fri,  6 Aug 2021 14:47:37 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 6 Aug 2021 14:47:38 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 6 Aug 2021 14:47:36 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <rpearsonhpe@gmail.com>, <zyjzyj2000@gmail.com>,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATH rdma-core] providers/rxe: Set wqe->dma.resid to length for inline data
Date:   Fri, 6 Aug 2021 15:20:17 +0800
Message-ID: <20210806072017.15459-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 9458D4D0D4A6.A784A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 providers/rxe/rxe.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index 3c3ea8bb..c3b267c3 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -1004,7 +1004,7 @@ static void wr_set_inline_data(struct ibv_qp_ex *ibqp, void *addr,
 
 	memcpy(wqe->dma.inline_data, addr, length);
 	wqe->dma.length = length;
-	wqe->dma.resid = 0;
+	wqe->dma.resid = length;
 }
 
 static void wr_set_inline_data_list(struct ibv_qp_ex *ibqp, size_t num_buf,
@@ -1473,8 +1473,6 @@ static int init_send_wqe(struct rxe_qp *qp, struct rxe_wq *sq,
 	if (ibwr->send_flags & IBV_SEND_INLINE) {
 		uint8_t *inline_data = wqe->dma.inline_data;
 
-		wqe->dma.resid = 0;
-
 		for (i = 0; i < num_sge; i++) {
 			memcpy(inline_data,
 			       (uint8_t *)(long)ibwr->sg_list[i].addr,
-- 
2.25.1



