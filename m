Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088F34FCC4F
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 04:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiDLCYv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Apr 2022 22:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242867AbiDLCYu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Apr 2022 22:24:50 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 348042E6AC;
        Mon, 11 Apr 2022 19:22:34 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AZrcepaxftCmDi76JAIt6t+fuxCrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApD0g3mZWn2sdDGGDOfuKZzD8f4hwbN7ipEoG6sDXzoViHQtv/xmBbVoQ9?=
 =?us-ascii?q?5OdWo7xwmQcns+qBpSaChohtq3yU/GYRCwPZiKa9kfF3oTJ9yEmj/nSHuOkUYY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWGULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIti?=
 =?us-ascii?q?j1LjmcEwWWaOUNg+L4pZUc/H6xEEc+WppieBmXBYfQR4/ZzGhm9FjyNRPtJW2Y?=
 =?us-ascii?q?Qk0PKzQg/lbWB5de817FfQco+OXcSTl4KR/yGWDKRMA2c5GHlA0L5waoL4vWUl?=
 =?us-ascii?q?B8PUZLHYGaRXrr+a3xq+rD+phnMIuKOH1M44F/HJt1zfUCbAhW5+ra6HL48JIm?=
 =?us-ascii?q?S08g8lmA/nTfYwaZCBpYRCGZAdAUn8VB50WjualnnS5eDQwlb4/jcLb+ECKlEo?=
 =?us-ascii?q?ojuera4GTJ7S3qQxuth7wjgr7E67RXnn27OCi9Ac=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A6Vz3O6O+rII0NMBcTv2jsMiBIKoaSvp037BL?=
 =?us-ascii?q?7TEUdfUxSKGlfq+V8sjzqiWftN98YhAdcLO7Scy9qBHnhP1ICOAqVN/MYOCMgh?=
 =?us-ascii?q?rLEGgN1+vf6gylMyj/28oY7q14bpV5YeeaMXFKyer8/ym0euxN/OW6?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123488429"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 12 Apr 2022 10:22:31 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id DA88E4D17165;
        Tue, 12 Apr 2022 10:22:28 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 12 Apr 2022 10:22:27 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 12 Apr 2022 10:22:27 +0800
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <zyjzyj2000@gmail.com>, <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 3/3] RDMA/rxe: Generate error completion for error requester state
Date:   Tue, 12 Apr 2022 10:29:03 +0800
Message-ID: <20220412022903.574238-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220412022903.574238-1-lizhijian@fujitsu.com>
References: <20220412022903.574238-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: DA88E4D17165.AE8A7
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SoftRoCE always returns success when user space is posting a new wqe where
it usually just euqueues a wqe.

Once requester state becomes QP_STATE_ERROR, we should generate error
completion for all subsequent wqe. So user is able to poll the completion
event to check if the former wqe is handled correctly.

Here we check QP_STATE_ERROR after req_next_wqe() so that the completion
can associate with its wqe.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index c369bebaf02e..9b35f6528d73 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -611,7 +611,7 @@ int rxe_requester(void *arg)
 	rxe_get(qp);
 
 next_wqe:
-	if (unlikely(!qp->valid || qp->req.state == QP_STATE_ERROR))
+	if (unlikely(!qp->valid))
 		goto exit;
 
 	if (unlikely(qp->req.state == QP_STATE_RESET)) {
@@ -633,6 +633,14 @@ int rxe_requester(void *arg)
 	if (unlikely(!wqe))
 		goto exit;
 
+	if (qp->req.state == QP_STATE_ERROR) {
+		/*
+		 * Generate an error completion so that user space is able to
+		 * poll this completion.
+		 */
+		goto err;
+	}
+
 	if (wqe->mask & WR_LOCAL_OP_MASK) {
 		ret = rxe_do_local_ops(qp, wqe);
 		if (unlikely(ret))
-- 
2.31.1



