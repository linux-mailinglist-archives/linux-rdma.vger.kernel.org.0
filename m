Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7F63F46B4
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 10:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbhHWIgy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 04:36:54 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:46916 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235462AbhHWIgy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Aug 2021 04:36:54 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AeV3klqioeCX4rNeFeIzRli0fLXBQXr8ji2hC?=
 =?us-ascii?q?6mlwRA09TyX4raCTdZsguCMc5Ax6ZJhCo7G90cu7Lk80nKQdieIs1N+ZLWrbUQ?=
 =?us-ascii?q?CTQL2Kg7GN/wHd?=
X-IronPort-AV: E=Sophos;i="5.84,344,1620662400"; 
   d="scan'208";a="113318450"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Aug 2021 16:36:10 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id C5CCB4D0D9D0;
        Mon, 23 Aug 2021 16:36:07 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 23 Aug 2021 16:36:08 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 23 Aug 2021 16:36:06 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <rpearsonhpe@gmail.com>, <zyjzyj2000@gmail.com>, <jgg@nvidia.com>,
        <leon@kernel.org>, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH 3/3] RDMA/rxe: Change the is_user member of struct rxe_cq to bool
Date:   Mon, 23 Aug 2021 17:08:05 +0800
Message-ID: <20210823090805.286497-4-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210823090805.286497-1-yangx.jy@fujitsu.com>
References: <20210823090805.286497-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: C5CCB4D0D9D0.AC63D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xiao Yang <yangx.jy@cn.fujitsu.com>

Make all is_user members of struct rxe_sq/rxe_cq/rxe_srq/rxe_cq
has the same type.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
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



