Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC42452299C
	for <lists+linux-rdma@lfdr.de>; Wed, 11 May 2022 04:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiEKCXh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 May 2022 22:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiEKCXf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 May 2022 22:23:35 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E991315A747;
        Tue, 10 May 2022 19:23:33 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3A2Yt6IazYVmULPJPjVhl6t+fuxCrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApGl03jQFzzFJDW/Sa/mKZWXxfop2PIS/9E0PusOAzdY1HQtv/xmBbVoQ9?=
 =?us-ascii?q?5OdWo7xwmQcns+qBpSaChohtq3yU/GYRCwPZiKa9kfF3oTJ9yEmj/nSHuOkUYY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWGULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIti?=
 =?us-ascii?q?j1LjmcEwWWaOUNg+L4pZUc/H6xEEc+WppieBmXBYfQR4/ZzGhm9FjyNRPtJW2Y?=
 =?us-ascii?q?Qk0PKzQg/lbWB5de817FfQcpOabeyTk66R/yGWDKRMA2c5GHlA0L5waoL4vWUl?=
 =?us-ascii?q?B8PUZLHYGaRXrr+a3xq+rD+phnMIuKOH1M44F/HJt1zfUCbAhW5+ra6HL48JIm?=
 =?us-ascii?q?S08g8lmA/nTfYwaZCBpYRCGZAdAUn8VB50WjualnnS5eDQwlb4/jcLb+ECKlEo?=
 =?us-ascii?q?ojuera4GTJ7S3qQxuth7wjgr7E67RW3n27OCi9Ac=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AzgUm9K3MGoEoUuCrA2BiGwqjBI4kLtp133Aq?=
 =?us-ascii?q?2lEZdPU1SL39qynKppkmPHDP5gr5J0tLpTntAsi9qBDnhPtICOsqTNSftWDd0Q?=
 =?us-ascii?q?PGEGgI1/qB/9SPIU3D398Y/aJhXow7M9foEGV95PyQ3CCIV/om3/mLmZrFudvj?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124142432"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 May 2022 10:23:32 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 3B0CD4D17192;
        Wed, 11 May 2022 10:23:28 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 11 May 2022 10:23:26 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 11 May 2022 10:23:26 +0800
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2 2/2] RDMA/rxe: Generate error completion for error requester state
Date:   Wed, 11 May 2022 10:30:30 +0800
Message-ID: <20220511023030.229212-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220511023030.229212-1-lizhijian@fujitsu.com>
References: <20220511023030.229212-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 3B0CD4D17192.AC456
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
it usually just enqueues a wqe.

Once the requester state becomes QP_STATE_ERROR, we should generate error
completion for all subsequent wqe. So the user is able to poll the
completion event to check if the former wqe is handled correctly.

Here we check QP_STATE_ERROR after req_next_wqe() so that the completion
can associate with its wqe.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 8bdd0b6b578f..ed6a486c4343 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -624,7 +624,7 @@ int rxe_requester(void *arg)
 	rxe_get(qp);
 
 next_wqe:
-	if (unlikely(!qp->valid || qp->req.state == QP_STATE_ERROR))
+	if (unlikely(!qp->valid))
 		goto exit;
 
 	if (unlikely(qp->req.state == QP_STATE_RESET)) {
@@ -646,6 +646,14 @@ int rxe_requester(void *arg)
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



