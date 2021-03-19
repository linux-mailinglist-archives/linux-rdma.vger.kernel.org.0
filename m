Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337DF342675
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 20:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhCSTrv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 15:47:51 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:6439 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhCSTrn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Mar 2021 15:47:43 -0400
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 12JJlU54029808;
        Fri, 19 Mar 2021 12:47:31 -0700
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     jgg@nvidia.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, bharat@chelsio.com
Subject: [PATCH for-rc] RDMA/cxgb4: Fix adapter LE hash errors while destroying ipv6 listening server
Date:   Sat, 20 Mar 2021 01:17:21 +0530
Message-Id: <20210319194721.3597-1-bharat@chelsio.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

While destroying ipv6 listening servers, set ipv6 field to '1' and pass it
down to the HW.

Fixes: 830662f6f032 ("RDMA/cxgb4: Add support for active and passive open connection with IPv6 address")
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/infiniband/hw/cxgb4/cm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index 8769e7aa097f..76faba892f00 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -3599,8 +3599,9 @@ int c4iw_create_listen(struct iw_cm_id *cm_id, int backlog)
 
 int c4iw_destroy_listen(struct iw_cm_id *cm_id)
 {
-	int err;
 	struct c4iw_listen_ep *ep = to_listen_ep(cm_id);
+	bool ipv6 = false;
+	int err;
 
 	pr_debug("ep %p\n", ep);
 
@@ -3610,13 +3611,14 @@ int c4iw_destroy_listen(struct iw_cm_id *cm_id)
 	    ep->com.local_addr.ss_family == AF_INET) {
 		err = cxgb4_remove_server_filter(
 			ep->com.dev->rdev.lldi.ports[0], ep->stid,
-			ep->com.dev->rdev.lldi.rxq_ids[0], 0);
+			ep->com.dev->rdev.lldi.rxq_ids[0], ipv6);
 	} else {
 		struct sockaddr_in6 *sin6;
+		ipv6 = true;
 		c4iw_init_wr_wait(ep->com.wr_waitp);
 		err = cxgb4_remove_server(
 				ep->com.dev->rdev.lldi.ports[0], ep->stid,
-				ep->com.dev->rdev.lldi.rxq_ids[0], 0);
+				ep->com.dev->rdev.lldi.rxq_ids[0], ipv6);
 		if (err)
 			goto done;
 		err = c4iw_wait_for_reply(&ep->com.dev->rdev, ep->com.wr_waitp,
-- 
2.24.0

