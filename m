Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B8A40B32E
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 17:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbhINPdr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 11:33:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:41503 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233969AbhINPdq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Sep 2021 11:33:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="222087411"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="222087411"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 08:27:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="697701729"
Received: from unknown (HELO intel-173.bj.intel.com) ([10.238.154.173])
  by fmsmga006.fm.intel.com with ESMTP; 14 Sep 2021 08:27:43 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        leonro@nvidia.com
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH 1/1] RDMA/rxe: remove the unnecessary variable
Date:   Wed, 15 Sep 2021 03:51:28 -0400
Message-Id: <20210915075128.482919-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <zyjzyj2000@gmail.com>

In the struct rxe_qp, the variable send_pkts is never used.
So remove it.

Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c    | 2 --
 drivers/infiniband/sw/rxe/rxe_verbs.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 1ab6af7ddb25..fa97ce9eaea3 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -190,8 +190,6 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	INIT_LIST_HEAD(&qp->grp_list);
 
-	skb_queue_head_init(&qp->send_pkts);
-
 	spin_lock_init(&qp->grp_lock);
 	spin_lock_init(&qp->state_lock);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index ac2a2148027f..1fd53fb3a4b3 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -240,7 +240,6 @@ struct rxe_qp {
 
 	struct sk_buff_head	req_pkts;
 	struct sk_buff_head	resp_pkts;
-	struct sk_buff_head	send_pkts;
 
 	struct rxe_req_info	req;
 	struct rxe_comp_info	comp;
-- 
2.27.0

