Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFB53F46E7
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 10:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbhHWIwA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 04:52:00 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:5179 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235577AbhHWIwA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Aug 2021 04:52:00 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AwekCDas7vhbDd//IZg2lTs7h7skDStV00zEX?=
 =?us-ascii?q?/kB9WHVpm62j5qSTdZEguCMc5wx+ZJheo7q90cW7IE80lqQFhLX5X43SPzUO0V?=
 =?us-ascii?q?HARO5fBODZsl/d8kPFltJ15ONJdqhSLJnKB0FmsMCS2mKFOudl7N6Z0K3Av4vj?=
 =?us-ascii?q?80s=3D?=
X-IronPort-AV: E=Sophos;i="5.84,344,1620662400"; 
   d="scan'208";a="113319383"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Aug 2021 16:51:16 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 146B04D0DC81;
        Mon, 23 Aug 2021 16:51:16 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 23 Aug 2021 16:51:04 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 23 Aug 2021 16:51:04 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <rpearsonhpe@gmail.com>, <zyjzyj2000@gmail.com>, <jgg@nvidia.com>,
        <leon@kernel.org>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH 3/3] RDMA/rxe: Change the is_user member of struct rxe_cq to bool
Date:   Mon, 23 Aug 2021 17:22:56 +0800
Message-ID: <20210823092256.287154-4-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210823092256.287154-1-yangx.jy@fujitsu.com>
References: <20210823092256.287154-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 146B04D0DC81.A7655
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make all is_user members of struct rxe_sq/rxe_cq/rxe_srq/rxe_cq
has the same type.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_cq.c    | 3 +--
 drivers/infiniband/sw/rxe/rxe_verbs.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index aef288f164fd..fd655e41d621 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -81,8 +81,7 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 		return err;
 	}
 
-	if (uresp)
-		cq->is_user = 1;
+	cq->is_user = uresp ? true : false;
 
 	cq->is_dying = false;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index bb5fb157d073..645eaea564ca 100644
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



