Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A29941D61A
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 11:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349268AbhI3JTD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 05:19:03 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:46773 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348400AbhI3JTD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 05:19:03 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AvT1dWaqxC8M6FTmy7J9CRpdtrRFeBmL6ZxIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vjQfXz2EMqvYYmanLo8kO9/kpEkG7MXRnYNhSApkqSAwQiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SQUOZ2gHOKmUba?=
 =?us-ascii?q?VYXgpHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlpJW2R?=
 =?us-ascii?q?hdvPLzklvkfUgVDDmd1OqguFLrveCHi65bNkh2WG5fr67A0ZK0sBqUC4ut+G3p?=
 =?us-ascii?q?J8/wAJRgCaxmCg6S9x7fTYvt9hNYyLpOzZNs3tXRpzDWfBvEjKbjHTqLMzdxVx?=
 =?us-ascii?q?jE9goZJB/m2T8gWZhJpchXMYhQJMVASYLo6neG1ljzlfzhRgEyaqLBx4GXJygF?=
 =?us-ascii?q?1lr/3P7LolnaiLSlOth/A4DuYoCKiWVdHXOFzAAGtqhqE7tIjVwuhMG7KKICFy?=
 =?us-ascii?q?w=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ApN0zdqgFJ0oZTn6gdZVJmr+Kg3BQXuYji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHLoB1/73LJYVkqNk3I5urrBEDtexLhHP1OkOws1NWZLWrbUQ?=
 =?us-ascii?q?KTRekM0WKI+UyDJ8SRzI5g/JYlW61/Jfm1NlJikPv9iTPSL/8QhPWB74Ck7N2z?=
 =?us-ascii?q?80tQ?=
X-IronPort-AV: E=Sophos;i="5.85,335,1624291200"; 
   d="scan'208";a="115226588"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Sep 2021 17:17:19 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 74CB74D0DC7C;
        Thu, 30 Sep 2021 17:17:19 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 30 Sep 2021 17:17:19 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 30 Sep 2021 17:17:17 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>
CC:     <rpearsonhpe@gmail.com>, <zyjzyj2000@gmail.com>, <leon@kernel.org>,
        "Xiao Yang" <yangx.jy@fujitsu.com>
Subject: [PATCH v4 1/4] RDMA/rxe: Remove the is_user members of struct rxe_sq/rxe_rq/rxe_srq
Date:   Thu, 30 Sep 2021 17:48:10 +0800
Message-ID: <20210930094813.226888-2-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210930094813.226888-1-yangx.jy@fujitsu.com>
References: <20210930094813.226888-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 74CB74D0DC7C.AB634
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The is_user members of struct rxe_sq/rxe_rq/rxe_srq are unsed since
commit ae6e843fe08d ("RDMA/rxe: Add memory barriers to kernel queues").
In this case, it is fine to remove them directly.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c    | 2 --
 drivers/infiniband/sw/rxe/rxe_srq.c   | 1 -
 drivers/infiniband/sw/rxe/rxe_verbs.c | 3 ---
 drivers/infiniband/sw/rxe/rxe_verbs.h | 3 ---
 4 files changed, 9 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index c8f4790083d2..975321812c87 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -307,8 +307,6 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 	spin_lock_init(&qp->rq.producer_lock);
 	spin_lock_init(&qp->rq.consumer_lock);
 
-	qp->rq.is_user = qp->is_user;
-
 	skb_queue_head_init(&qp->resp_pkts);
 
 	rxe_init_task(rxe, &qp->resp.task, qp,
diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index a9e7817e2732..eb1c4c3b3a78 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -86,7 +86,6 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 	srq->srq_num		= srq->pelem.index;
 	srq->rq.max_wr		= init->attr.max_wr;
 	srq->rq.max_sge		= init->attr.max_sge;
-	srq->rq.is_user		= srq->is_user;
 
 	srq_wqe_size		= rcv_wqe_size(srq->rq.max_sge);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 9d0bb9aa7514..c49ba0381964 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -267,9 +267,6 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 		if (udata->outlen < sizeof(*uresp))
 			return -EINVAL;
 		uresp = udata->outbuf;
-		srq->is_user = true;
-	} else {
-		srq->is_user = false;
 	}
 
 	err = rxe_srq_chk_attr(rxe, NULL, &init->attr, IB_SRQ_INIT_MASK);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index c807639435eb..962bb2481a28 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -77,7 +77,6 @@ enum wqe_state {
 };
 
 struct rxe_sq {
-	bool			is_user;
 	int			max_wr;
 	int			max_sge;
 	int			max_inline;
@@ -86,7 +85,6 @@ struct rxe_sq {
 };
 
 struct rxe_rq {
-	bool			is_user;
 	int			max_wr;
 	int			max_sge;
 	spinlock_t		producer_lock; /* guard queue producer */
@@ -100,7 +98,6 @@ struct rxe_srq {
 	struct rxe_pd		*pd;
 	struct rxe_rq		rq;
 	u32			srq_num;
-	bool			is_user;
 
 	int			limit;
 	int			error;
-- 
2.25.1



