Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F46D43663A
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 17:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhJUP3h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 11:29:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:22512 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231958AbhJUP3g (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Oct 2021 11:29:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="209858820"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="209858820"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 08:27:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="484248298"
Received: from unknown (HELO intel-73.bj.intel.com) ([10.238.154.73])
  by orsmga007.jf.intel.com with ESMTP; 21 Oct 2021 08:27:13 -0700
From:   yanjun.zhu@linux.dev
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev, leon@kernel.org
Subject: [PATCH 1/1] RDMA/irdma: remove the unused spin lock in struct irdma_qp_uk
Date:   Thu, 21 Oct 2021 19:06:12 -0400
Message-Id: <20211021230612.153812-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

The spin lock in struct irdma_qp_uk is not used. So remove it.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/user.h  | 1 -
 drivers/infiniband/hw/irdma/verbs.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/user.h b/drivers/infiniband/hw/irdma/user.h
index 3dcbb1fbf2c6..e0e9512ad3d5 100644
--- a/drivers/infiniband/hw/irdma/user.h
+++ b/drivers/infiniband/hw/irdma/user.h
@@ -369,7 +369,6 @@ struct irdma_qp_uk {
 	bool rq_flush_complete:1; /* Indicates flush was seen and RQ was empty after the flush */
 	bool destroy_pending:1; /* Indicates the QP is being destroyed */
 	void *back_qp;
-	spinlock_t *lock;
 	u8 dbg_rq_flushed;
 	u8 sq_flush_seen;
 	u8 rq_flush_seen;
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 7110ebf834f9..02ca1f80968e 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -833,7 +833,6 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 
 	qp = &iwqp->sc_qp;
 	qp->qp_uk.back_qp = iwqp;
-	qp->qp_uk.lock = &iwqp->lock;
 	qp->push_idx = IRDMA_INVALID_PUSH_PAGE_INDEX;
 
 	iwqp->iwdev = iwdev;
-- 
2.27.0

