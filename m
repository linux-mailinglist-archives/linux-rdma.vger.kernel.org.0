Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C46B522998
	for <lists+linux-rdma@lfdr.de>; Wed, 11 May 2022 04:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239385AbiEKCXk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 May 2022 22:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbiEKCXh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 May 2022 22:23:37 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 978BC15A747;
        Tue, 10 May 2022 19:23:36 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AYsxpea8N60b4liqVHXTFDrUDWXyTJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUp2gTYGzWFOWG2EOv7ZZDOmfd0jPoq29hhX6pCDx4IyHldlrnsFo1Bi8?=
 =?us-ascii?q?5ScXYvDRqvT04J+FuWaFQQ/qZx2huDodKjYdVeB4Ef9WlTdhSMkj/vQHOKlULe?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YTdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?ulPD1b08LXqXPewOJjxK6WYD72l4b+HN0if19aZLwam8O49mNt9Rw2tVMt525T?=
 =?us-ascii?q?y8nI6/NhP8AFRJfFkmSOIUfouOefSLj6pf7I0ruNiGEL+9VJFMnP58J+LwvWTl?=
 =?us-ascii?q?m+vkRKTRLZReG78qywbSmWqxvi94lIc3DIowSoDdjwCvfAPJgRorMK43O5NlFz?=
 =?us-ascii?q?HIqisVHNejRatBfajd1ahnEJRpVNT8/Cp0xtPWpi2HyNTZRwG95D4JfD3P7lVQ?=
 =?us-ascii?q?3ieaydoGOPIHieCmcpW7AzkquwogzKkty2ASj9Ae4?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AWlayW6jrwaR9bVuBQuUQZAHsg3BQXuYji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHLoB1/73LJYVkqNk3I5urrBEDtexLhHP1OkOws1NWZLWrbUQ?=
 =?us-ascii?q?KTRekM0WKI+UyDJ8SRzI5g/JYlW61/Jfm1NlJikPv9iTPSL/8QhPWB74Ck7N2z?=
 =?us-ascii?q?80tQ?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124142433"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 May 2022 10:23:32 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id B12624D1718C;
        Wed, 11 May 2022 10:23:27 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 11 May 2022 10:23:27 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 11 May 2022 10:23:25 +0800
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2 1/2] RDMA/rxe: Update wqe_index for each wqe error completion
Date:   Wed, 11 May 2022 10:30:29 +0800
Message-ID: <20220511023030.229212-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220511023030.229212-1-lizhijian@fujitsu.com>
References: <20220511023030.229212-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: B12624D1718C.AAF3E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
V2: Fix typos in commit logs

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



