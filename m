Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 504DAC3AAB
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 18:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfJAQiz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 12:38:55 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:28443 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfJAQiy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 12:38:54 -0400
Received: from localhost (budha.blr.asicdesigners.com [10.193.185.4])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x91GcmZe013164;
        Tue, 1 Oct 2019 09:38:49 -0700
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     jgg@ziepe.ca, bmt@zurich.ibm.com
Cc:     linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com, bvanassche@acm.org,
        Krishnamraju Eraparaju <krishna2@chelsio.com>
Subject: [PATCH for-rc] RDMA/siw: free siw_base_qp in kref release routine
Date:   Tue,  1 Oct 2019 22:08:45 +0530
Message-Id: <20191001163845.27726-1-krishna2@chelsio.com>
X-Mailer: git-send-email 2.23.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

As siw_free_qp() is the last routine to access 'siw_base_qp' structure,
freeing this structure early in siw_destroy_qp() could cause
touch-after-free issue.
Hence, moved kfree(siw_base_qp) from siw_destroy_qp() to siw_free_qp().

Reported-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
---
 drivers/infiniband/sw/siw/siw_qp.c    | 2 ++
 drivers/infiniband/sw/siw/siw_verbs.c | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
index 430314c8abd9..c317f6e18ea8 100644
--- a/drivers/infiniband/sw/siw/siw_qp.c
+++ b/drivers/infiniband/sw/siw/siw_qp.c
@@ -1305,6 +1305,7 @@ int siw_qp_add(struct siw_device *sdev, struct siw_qp *qp)
 void siw_free_qp(struct kref *ref)
 {
 	struct siw_qp *found, *qp = container_of(ref, struct siw_qp, ref);
+	struct siw_base_qp *siw_base_qp = to_siw_base_qp(qp->ib_qp);
 	struct siw_device *sdev = qp->sdev;
 	unsigned long flags;
 
@@ -1327,4 +1328,5 @@ void siw_free_qp(struct kref *ref)
 	atomic_dec(&sdev->num_qp);
 	siw_dbg_qp(qp, "free QP\n");
 	kfree_rcu(qp, rcu);
+	kfree(siw_base_qp);
 }
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 869e02b69a01..b18a677832e1 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -604,7 +604,6 @@ int siw_verbs_modify_qp(struct ib_qp *base_qp, struct ib_qp_attr *attr,
 int siw_destroy_qp(struct ib_qp *base_qp, struct ib_udata *udata)
 {
 	struct siw_qp *qp = to_siw_qp(base_qp);
-	struct siw_base_qp *siw_base_qp = to_siw_base_qp(base_qp);
 	struct siw_ucontext *uctx =
 		rdma_udata_to_drv_context(udata, struct siw_ucontext,
 					  base_ucontext);
@@ -641,7 +640,6 @@ int siw_destroy_qp(struct ib_qp *base_qp, struct ib_udata *udata)
 	qp->scq = qp->rcq = NULL;
 
 	siw_qp_put(qp);
-	kfree(siw_base_qp);
 
 	return 0;
 }
-- 
2.23.0.rc0

