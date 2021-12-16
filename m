Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEEF475994
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 14:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242820AbhLONY5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Dec 2021 08:24:57 -0500
Received: from mga11.intel.com ([192.55.52.93]:5004 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237419AbhLONYz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Dec 2021 08:24:55 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="236761512"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="236761512"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 05:24:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="505799356"
Received: from intel-obmc.bj.intel.com (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga007.jf.intel.com with ESMTP; 15 Dec 2021 05:24:51 -0800
From:   yanjun.zhu@linux.dev
To:     zyjzyj2000@gmail.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, leon@kernel.org, yanjun.zhu@linux.dev
Subject: [PATCH 1/1] RDMA/rxe: Remove the unused variable
Date:   Thu, 16 Dec 2021 00:48:42 -0500
Message-Id: <20211216054842.1099428-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

The member variable xmit_errors can be replaced with
rxe_counter_inc(rxe, RXE_CNT_SEND_ERR) totally. So
remove it.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_net.c   | 1 -
 drivers/infiniband/sw/rxe/rxe_verbs.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 2cb810cb890a..112506c31b37 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -444,7 +444,6 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	else
 		err = rxe_send(skb, pkt);
 	if (err) {
-		rxe->xmit_errors++;
 		rxe_counter_inc(rxe, RXE_CNT_SEND_ERR);
 		return err;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 35e041450090..af0117710175 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -392,8 +392,6 @@ struct rxe_dev {
 
 	struct net_device	*ndev;
 
-	int			xmit_errors;
-
 	struct rxe_pool		uc_pool;
 	struct rxe_pool		pd_pool;
 	struct rxe_pool		ah_pool;
-- 
2.27.0

