Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDE43A049F
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 21:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbhFHTq5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 15:46:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:28935 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234235AbhFHTq5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Jun 2021 15:46:57 -0400
IronPort-SDR: 4D4TSWlFOFDyBtj2YHOt3Ya5HrserseBVUjlxoyohczRPAoBWtEM3dT81wHRy0QGCtndvR1flS
 O3xPDIK5wRcQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="201903064"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="201903064"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 12:45:00 -0700
IronPort-SDR: LmLAodzbllkBkENWEWCOH2YdHSgFYJ0N/lZUSUlKLxo5nkhgEFjTlSlWamwZDlJypuitlBzauN
 cksNLABi4ERw==
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="449654890"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.212.4.48])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 12:44:58 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH rdma-next] irdma: Use list_last_entry/list_first_entry
Date:   Tue,  8 Jun 2021 14:44:14 -0500
Message-Id: <20210608194413.591-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use list_last_entry and list_first_entry instead of using prev and next
pointers.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/puda.c  | 2 +-
 drivers/infiniband/hw/irdma/utils.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/puda.c b/drivers/infiniband/hw/irdma/puda.c
index 1805713..e09d3be 100644
--- a/drivers/infiniband/hw/irdma/puda.c
+++ b/drivers/infiniband/hw/irdma/puda.c
@@ -1419,7 +1419,7 @@ static void irdma_ieq_compl_pfpdu(struct irdma_puda_rsrc *ieq,
 
 error:
 	while (!list_empty(&pbufl)) {
-		buf = (struct irdma_puda_buf *)(pbufl.prev);
+		buf = list_last_entry(&pbufl, struct irdma_puda_buf, list);
 		list_del(&buf->list);
 		list_add(&buf->list, rxlist);
 	}
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 8ce3535..81e590f 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -425,8 +425,8 @@ struct irdma_cqp_request *irdma_alloc_and_get_cqp_request(struct irdma_cqp *cqp,
 
 	spin_lock_irqsave(&cqp->req_lock, flags);
 	if (!list_empty(&cqp->cqp_avail_reqs)) {
-		cqp_request = list_entry(cqp->cqp_avail_reqs.next,
-					 struct irdma_cqp_request, list);
+		cqp_request = list_first_entry(&cqp->cqp_avail_reqs,
+					       struct irdma_cqp_request, list);
 		list_del_init(&cqp_request->list);
 	}
 	spin_unlock_irqrestore(&cqp->req_lock, flags);
-- 
1.8.3.1

