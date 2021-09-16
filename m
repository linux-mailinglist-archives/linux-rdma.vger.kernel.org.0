Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E080040D99C
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 14:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239398AbhIPMQx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 08:16:53 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:16938 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239430AbhIPMQw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Sep 2021 08:16:52 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AFoVN8qpsDBiMT8XwpBrsK5W9evleBmL6ZxIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vmAWCmuAM/2NM2KjL953O4i+/BsAu5fVzddkTwc+qyhgQiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SQUOZ2gHOKmUba?=
 =?us-ascii?q?VY34pH2eIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlpJW2R?=
 =?us-ascii?q?hdvPLzklvkfUgVDDmd1OqguFLrveCHj7JPJlxKcG5fr67A0ZK0sBqUC4ut+G3p?=
 =?us-ascii?q?J8/wAJRgCaxmCg6S9x7fTYvt9hNYyLpOzZNs3tXRpzDWfBvEjKbjHTqLMzdxVx?=
 =?us-ascii?q?jE9goZJB/m2T8gWZhJpchXMYhQJMVASYLo6neG1ljzlfzhRgEyaqLBx4GXJygF?=
 =?us-ascii?q?1lr/3P7LolnaiLSlOth/A4DuYoCKiWVdHXOFzAAGtqhqE7tIjVwuiMG7KKICFy?=
 =?us-ascii?q?w=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AIXaC1avQuWl8aokET/025Q6e7skDE9V00zEX?=
 =?us-ascii?q?/kB9WHVpm62j9/xG88536faZslwssRIb+OxoWpPufZq0z/ccirX5VY3SPzUO01?=
 =?us-ascii?q?HFEGgN1+Xf/wE=3D?=
X-IronPort-AV: E=Sophos;i="5.85,298,1624291200"; 
   d="scan'208";a="114572072"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Sep 2021 20:15:30 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 08D914D0DC79;
        Thu, 16 Sep 2021 20:15:30 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 16 Sep 2021 20:15:24 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 16 Sep 2021 20:15:23 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>
CC:     <rpearsonhpe@gmail.com>, <zyjzyj2000@gmail.com>, <leon@kernel.org>,
        "Xiao Yang" <yangx.jy@fujitsu.com>
Subject: [PATCH v3 3/5] RDMA/rxe: Change the is_user member of struct rxe_cq to bool
Date:   Thu, 16 Sep 2021 20:46:50 +0800
Message-ID: <20210916124652.1304649-4-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916124652.1304649-1-yangx.jy@fujitsu.com>
References: <20210916124652.1304649-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 08D914D0DC79.A6B62
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
index aef288f164fd..8cc90a5424d9 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -81,8 +81,7 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 		return err;
 	}
 
-	if (uresp)
-		cq->is_user = 1;
+	cq->is_user = uresp;
 
 	cq->is_dying = false;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index ba74cedff9d1..671884514ee1 100644
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



