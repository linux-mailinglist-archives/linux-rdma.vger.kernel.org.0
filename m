Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9455B527B7B
	for <lists+linux-rdma@lfdr.de>; Mon, 16 May 2022 03:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239125AbiEPBq5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 May 2022 21:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239111AbiEPBq4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 May 2022 21:46:56 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32886389E;
        Sun, 15 May 2022 18:46:54 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AM+o5x6/wV6F32GYsfiaPDrUDFHyTJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUp3hD0CmzdLWGjUafjca2LyKY12OYi3/BsC7ZLdx4I2GldlrnsFo1Bi8?=
 =?us-ascii?q?5ScXYvDRqvT04J+FuWaFQQ/qZx2huDodKjYdVeB4Ef9WlTdhSMkj/vQHOKlULe?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YTdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?ulPD1b08LXqXPewOJjxK6WYD72l4b+HN0if19aZLwam8O49mNt9Rw2tVMt525T?=
 =?us-ascii?q?y8nI6/NhP8AFRJfFkmSOIUfouOdfCDj75f7I0ruNiGEL+9VJEo2MIsX6+FqKWV?=
 =?us-ascii?q?P8+EIbjkJbxqKjevwy7W+IsF9j8IhMc+tLoMCknVhyyzJS/orX/jrQ6zD5them?=
 =?us-ascii?q?j0tic9DNfHEbsEdZHxkaxGoSxlOPEoHTZEzhuGlglHhfDBC7lGYv6w65y7U1gM?=
 =?us-ascii?q?Z+LzsNsfFP8aGQMx9gEmVvCTF8n7/DxVcM8aQoRKH/X2ElO7ChS69U4t6KVES3?=
 =?us-ascii?q?paGm3XKnipKVkJQDgD9/JGEZoeFc4o3AyQpFuAG98DeLHCWc+Q=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A7YLr76ph+apSaKbcm3opM9IaV5oXeYIsimQD?=
 =?us-ascii?q?101hICG9E/bo8/xG+c536faaslgssQ4b8+xoVJPgfZq+z+8R3WByB8bAYOCOgg?=
 =?us-ascii?q?LBQ72KhrGSoQEIdRefysdtkY9kc4VbTOb7FEVGi6/BizWQIpINx8am/cmT6dvj?=
 =?us-ascii?q?8w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124250463"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 May 2022 09:46:50 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id DFD334D68A24;
        Mon, 16 May 2022 09:46:45 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 16 May 2022 09:46:47 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 16 May 2022 09:46:47 +0800
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Haakon Bugge" <haakon.bugge@oracle.com>,
        Cheng Xu <chengyou@linux.alibaba.com>,
        <linux-rdma@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3 2/2] RDMA/rxe: Generate error completion for error requester QP state
Date:   Mon, 16 May 2022 09:53:29 +0800
Message-ID: <20220516015329.445474-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220516015329.445474-1-lizhijian@fujitsu.com>
References: <20220516015329.445474-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: DFD334D68A24.AF984
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

As per IBTA specification, all subsequent WQEs while QP is in error
state should be completed with a flush error.

Here we check QP_STATE_ERROR after req_next_wqe() so that rxe_completer()
has chance to be called where it will set CQ state to FLUSH ERROR and the
completion can associate with its WQE.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V3: unlikely() optimization # Cheng Xu <chengyou@linux.alibaba.com>
    update commit log # Haakon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 8bdd0b6b578f..c1f1c19f26b2 100644
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
 
+	if (unlikely(qp->req.state == QP_STATE_ERROR)) {
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



