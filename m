Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C384FCC4E
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 04:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242026AbiDLCYt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Apr 2022 22:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiDLCYs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Apr 2022 22:24:48 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97C8F2E9CC;
        Mon, 11 Apr 2022 19:22:32 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3Ap4k5aK0V+0KdDT+H6fbD5Qpzkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJ1Dh302ACnDMfC2mDaanbNGf0fYh/PI+w8B4B65/Ry9U2QQE+nZ1PZygU8?=
 =?us-ascii?q?JKaX7x1DatR0xu6d5SFFAQ+hyknQoGowPscEzmM9n9BDpC79SMmjfvQH+KlYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5S31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFAdX?=
 =?us-ascii?q?jnKv5c1ERX/jZOg3mZnh+AvDk20Yd4HdplPtT2Pk0MC+7jx2NnsJxyddMvJqYR?=
 =?us-ascii?q?xorP7HXhaIWVBww/yRWZPcdpO+XfSLg2SCU5wicG5f2+N18HUMkLI9Cor4vKW5?=
 =?us-ascii?q?L/P0cbjsKa3irg+Ow3aL+SeR2gMknBNfkMZlZuXx6yzzdS/E8TvjrR6TM+M8dx?=
 =?us-ascii?q?js1j+hQEvvEIckUczxiaFLHeRInElUYB7osneqwiz/0elVlRPi9zUYsyzGLilU?=
 =?us-ascii?q?vj/62a5yIEuFmjP59xi6wzl8qNUylav3CCOGi9A=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AkC50MajHjCrR/nL6ql6SZt9JT3BQXuYji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHLoB1/73LJYVkqNk3I5urrBEDtexLhHP1OkOws1NWZLWrbUQ?=
 =?us-ascii?q?KTRekM0WKI+UyDJ8SRzI5g/JYlW61/Jfm1NlJikPv9iTPSL/8QhPWB74Ck7N2z?=
 =?us-ascii?q?80tQ?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123488427"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 12 Apr 2022 10:22:31 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 72EE44D16FCF;
        Tue, 12 Apr 2022 10:22:28 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 12 Apr 2022 10:22:29 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 12 Apr 2022 10:22:26 +0800
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <zyjzyj2000@gmail.com>, <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 2/3] RDMA/rxe: Update wqe_index for each wqe error completion
Date:   Tue, 12 Apr 2022 10:29:02 +0800
Message-ID: <20220412022903.574238-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220412022903.574238-1-lizhijian@fujitsu.com>
References: <20220412022903.574238-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 72EE44D16FCF.A0068
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

Previously, if user space keep sending abnormal wqe, qeueu.prod will
keep increasing while queue.index doesn't. Once
queue.index==qeueu.prod in next round, req_next_wqe() will treat queue
is empty. In such case, no new completion would be generated.

Update wqe_index for each wqe completion so that
req_next_wqe() can get next wqe properly.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index bf7493bab9b9..c369bebaf02e 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -760,6 +760,8 @@ int rxe_requester(void *arg)
 	if (ah)
 		rxe_put(ah);
 err:
+	/* update wqe_index for each wqe completion */
+	qp->req.wqe_index = queue_next_index(qp->sq.queue, qp->req.wqe_index);
 	wqe->state = wqe_state_error;
 	__rxe_do_task(&qp->comp.task);
 
-- 
2.31.1



