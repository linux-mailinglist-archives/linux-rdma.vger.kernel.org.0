Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EAF3D0DE5
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 13:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbhGUK63 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 06:58:29 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:8498 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239803AbhGUKlb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jul 2021 06:41:31 -0400
Received: from potato2.blr.asicdesigners.com (potato2.blr.asicdesigners.com [10.193.80.129])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 16LBLwlr008973;
        Wed, 21 Jul 2021 04:21:59 -0700
From:   Dakshaja Uppalapati <dakshaja@chelsio.com>
To:     jgg@nvidia.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, bharat@chelsio.com,
        dakshaja@chelsio.com
Subject: [PATCH for-rc] iw_cxgb4: Fix refcount underflow while destroying cqs.
Date:   Wed, 21 Jul 2021 16:51:55 +0530
Message-Id: <1626866515-17895-1-git-send-email-dakshaja@chelsio.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Previous atomic increment decrement logic expects the atomic count
to be '0' after the final decrement. Replacing atomic count with
refcount does not allow that as refcount_dec() considers count of 1 as
underflow. Therefore fix the current refcount logic by decrementing
the refcount if one on the final deref in c4iw_destroy_cq().

Fixes: 7183451f846d (RDMA/cxgb4: Use refcount_t instead of atomic_t for reference counting")
Signed-off-by: Dakshaja Uppalapati <dakshaja@chelsio.com>
Reviewed-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/infiniband/hw/cxgb4/cq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index 6c8c910..54a5b60 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -976,8 +976,7 @@ int c4iw_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	chp = to_c4iw_cq(ib_cq);
 
 	xa_erase_irq(&chp->rhp->cqs, chp->cq.cqid);
-	refcount_dec(&chp->refcnt);
-	wait_event(chp->wait, !refcount_read(&chp->refcnt));
+	wait_event(chp->wait, refcount_dec_if_one(&chp->refcnt));
 
 	ucontext = rdma_udata_to_drv_context(udata, struct c4iw_ucontext,
 					     ibucontext);
-- 
1.8.3.1

