Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 073EB15177E
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 10:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgBDJMq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Feb 2020 04:12:46 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:9961 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgBDJMq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Feb 2020 04:12:46 -0500
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 0149CY3O012734;
        Tue, 4 Feb 2020 01:12:36 -0800
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com, krishna2@chelsio.com
Subject: [PATCH for-rc] RDMA/iw_cxgb4: initiate CLOSE when entering TERM
Date:   Tue,  4 Feb 2020 14:42:30 +0530
Message-Id: <20200204091230.7210-1-krishna2@chelsio.com>
X-Mailer: git-send-email 2.23.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

- As per draft-hilland-iwarp-verbs-v1.0, sec 6.2.3,
  always initiate a CLOSE when entering into TERM state.

- In c4iw_modify_qp(), disconnect operation should only be performed
  when the modify_qp call is invoked from ib_core. And all other
  internal modify_qp calls(invoked within iw_cxgb4) that needs
  'disconnect' should call c4iw_ep_disconnect() explicitly
  after modify_qp. Otherwise, deadlocks like below can occur:

 Call Trace:
  schedule+0x2f/0xa0
  schedule_preempt_disabled+0xa/0x10
  __mutex_lock.isra.5+0x2d0/0x4a0
  c4iw_ep_disconnect+0x39/0x430    => tries to reacquire ep lock again
  c4iw_modify_qp+0x468/0x10d0
  rx_data+0x218/0x570              => acquires ep lock
  process_work+0x5f/0x70
  process_one_work+0x1a7/0x3b0
  worker_thread+0x30/0x390
  kthread+0x112/0x130
  ret_from_fork+0x35/0x40

Fixes: d2c33370ae73 ("RDMA/iw_cxgb4: Always disconnect when QP is
transitioning to TERMINATE state")
Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
---
 drivers/infiniband/hw/cxgb4/cm.c | 4 ++++
 drivers/infiniband/hw/cxgb4/qp.c | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index ee1182f9b627..d69dece3b1d5 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -3036,6 +3036,10 @@ static int terminate(struct c4iw_dev *dev, struct sk_buff *skb)
 				       C4IW_QP_ATTR_NEXT_STATE, &attrs, 1);
 		}
 
+		/* As per draft-hilland-iwarp-verbs-v1.0, sec 6.2.3,
+		 * when entering the TERM state the RNIC MUST initiate a CLOSE.
+		 */
+		c4iw_ep_disconnect(ep, 1, GFP_KERNEL);
 		c4iw_put_ep(&ep->com);
 	} else
 		pr_warn("TERM received tid %u no ep/qp\n", tid);
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index bbcac539777a..89ac2f9ae6dd 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -1948,10 +1948,10 @@ int c4iw_modify_qp(struct c4iw_dev *rhp, struct c4iw_qp *qhp,
 			qhp->attr.layer_etype = attrs->layer_etype;
 			qhp->attr.ecode = attrs->ecode;
 			ep = qhp->ep;
-			c4iw_get_ep(&ep->com);
-			disconnect = 1;
 			if (!internal) {
+				c4iw_get_ep(&ep->com);
 				terminate = 1;
+				disconnect = 1;
 			} else {
 				terminate = qhp->attr.send_term;
 				ret = rdma_fini(rhp, qhp, ep);
-- 
2.23.0.rc0

