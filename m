Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1542941D61B
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 11:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348400AbhI3JTE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 05:19:04 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:31241 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1349267AbhI3JTE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 05:19:04 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AIEEXvaJZVxSDrvSrFE+RM5clxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHC+1Dsg3jdUnzEeDDyAPKmJNGD2LtEjPtzlo0kBup+HnINqS1BcGVNFFSwT8?=
 =?us-ascii?q?ZWfbTi6wuYcBwvLd4ubChsPA/w2MrEsF+hpCC+BzvuRGuK59yAkhPrQHuOU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+qUzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8mDJW?=
 =?us-ascii?q?rj7T6blYXBLXVOGBiiFIPA+773EcE/Xd0j87XN9JFAatToySAmd9hjtdcnZKtS?=
 =?us-ascii?q?wY1JbCKk+MYO/VdO3gnYPccpuKXcBBTtuTWlSUqaUDE2e1jBVstOosY4utfDmR?=
 =?us-ascii?q?H9PheIzcIBjiRluCk0bDhErE0rssmJcjveogYvxlIyTzeC94lTIrFTqGM4sVXt?=
 =?us-ascii?q?B8yic9mG+jfa8sQLzFoaXzoZxxJJ0dSEp47lc+2iXTlNT5VslSYoeww+We78eD?=
 =?us-ascii?q?b+NABK/KMIprTG5oTxR3e+wr7E63CKklyHLSiJfCtqxpAXtPyoB4=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AsOp2dKHR9ieMtehEpLqE1MeALOsnbusQ8zAX?=
 =?us-ascii?q?PiFKOHhom6mj+vxG88506faKslwssR0b+OxoW5PwJE80l6QFgrX5VI3KNGbbUQ?=
 =?us-ascii?q?CTXeNfBOXZowHIKmnX8+5x8eNaebFiNduYNzNHpPe/zA6mM9tI+rW6zJw=3D?=
X-IronPort-AV: E=Sophos;i="5.85,335,1624291200"; 
   d="scan'208";a="115226589"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Sep 2021 17:17:20 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 5BECF4D0DC7E;
        Thu, 30 Sep 2021 17:17:20 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 30 Sep 2021 17:17:19 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 30 Sep 2021 17:17:18 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>
CC:     <rpearsonhpe@gmail.com>, <zyjzyj2000@gmail.com>, <leon@kernel.org>,
        "Xiao Yang" <yangx.jy@fujitsu.com>
Subject: [PATCH v4 2/4] RDMA/rxe: Change the is_user member of struct rxe_cq to bool
Date:   Thu, 30 Sep 2021 17:48:11 +0800
Message-ID: <20210930094813.226888-3-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210930094813.226888-1-yangx.jy@fujitsu.com>
References: <20210930094813.226888-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 5BECF4D0DC7E.ABEB9
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make the is_user members of struct rxe_qp/rxe_cq has the same type.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_cq.c    | 3 +--
 drivers/infiniband/sw/rxe/rxe_verbs.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index 4eedaa0244b3..6848426c074f 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -77,8 +77,7 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 		return err;
 	}
 
-	if (uresp)
-		cq->is_user = 1;
+	cq->is_user = uresp;
 
 	cq->is_dying = false;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 962bb2481a28..098fde693dbd 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -64,7 +64,7 @@ struct rxe_cq {
 	spinlock_t		cq_lock;
 	u8			notify;
 	bool			is_dying;
-	int			is_user;
+	bool			is_user;
 	struct tasklet_struct	comp_task;
 };
 
-- 
2.25.1



