Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF7E527B79
	for <lists+linux-rdma@lfdr.de>; Mon, 16 May 2022 03:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbiEPBq6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 May 2022 21:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239117AbiEPBq4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 May 2022 21:46:56 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97604389D;
        Sun, 15 May 2022 18:46:53 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AuBVEa6tABzRGI97eN2E8s4slTOfnVMJcMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3zDcZXGuPOfuKYGr1L9t1Poix/ExVvZ7UydZnTgc9/n1gHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x/RGQ6YnSHuCmULS?=
 =?us-ascii?q?cY3goLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1JtI6wS?=
 =?us-ascii?q?AUoN6vklvkfUgVDDmd1OqguFLrveCLj65HLkxOcG5fr67A0ZK0sBqUT+utxDnB?=
 =?us-ascii?q?J6NQcKTYQflaKg+O8ybiyDOJrg6wLPcDtPp4Z/GNg0BndDPA7UdbPTruizd9R1?=
 =?us-ascii?q?TQ3gIZEAPnRauIeczNkaBmGaBpKUn8TCZQjjKKri2P5fjlwtl2Yv+w07nLVwQg?=
 =?us-ascii?q?316LiWPLRe9qXVYBPkkORjnzJ8n6/ARwAMtGbjz2f/RqEhODAtTH6VZofUraxn?=
 =?us-ascii?q?sOGKnX7Knc7UUVQDAXk56LizBPWZj6WEGRMkgJGkET43BbDogHBYiCF?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ASq0e66APbnz//iHlHemQ55DYdb4zR+YMi2TD?=
 =?us-ascii?q?tnoBLSC9F/b0qynAppomPGDP4gr5NEtApTniAtjkfZq/z+8X3WB5B97LMzUO01?=
 =?us-ascii?q?HYTr2Kg7GD/xTQXwX69sN4kZxrarVCDrTLZmRSvILX5xaZHr8brOW6zA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124250462"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 May 2022 09:46:50 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 5AF6B4D68A23;
        Mon, 16 May 2022 09:46:45 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 16 May 2022 09:46:43 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 16 May 2022 09:46:46 +0800
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Haakon Bugge" <haakon.bugge@oracle.com>,
        Cheng Xu <chengyou@linux.alibaba.com>,
        <linux-rdma@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3 1/2] RDMA/rxe: Update wqe_index for each wqe error completion
Date:   Mon, 16 May 2022 09:53:28 +0800
Message-ID: <20220516015329.445474-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220516015329.445474-1-lizhijian@fujitsu.com>
References: <20220516015329.445474-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 5AF6B4D68A23.AE324
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

Previously, if user space keeps sending abnormal wqe, queue.prod will
keep increasing while queue.index doesn't. Once
queue.index==queue.prod in next round, req_next_wqe() will treat queue
as empty. In such case, no new completion would be generated.

Update wqe_index for each wqe completion so that req_next_wqe() can get
next wqe properly.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index a0d5e57f73c1..8bdd0b6b578f 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -773,6 +773,8 @@ int rxe_requester(void *arg)
 	if (ah)
 		rxe_put(ah);
 err:
+	/* update wqe_index for each wqe completion */
+	qp->req.wqe_index = queue_next_index(qp->sq.queue, qp->req.wqe_index);
 	wqe->state = wqe_state_error;
 	__rxe_do_task(&qp->comp.task);
 
-- 
2.31.1



