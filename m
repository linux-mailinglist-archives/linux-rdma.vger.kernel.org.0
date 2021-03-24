Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E388A348134
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Mar 2021 20:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237721AbhCXTFY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Mar 2021 15:05:24 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:38031 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237794AbhCXTFB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Mar 2021 15:05:01 -0400
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 12OJ4tl5007928;
        Wed, 24 Mar 2021 12:04:56 -0700
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     jgg@nvidia.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, bharat@chelsio.com
Subject: [PATCH v2 for-rc] RDMA/cxgb4: Fix adapter LE hash errors while destroying ipv6 listening server
Date:   Thu, 25 Mar 2021 00:34:53 +0530
Message-Id: <20210324190453.8171-1-bharat@chelsio.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Not setting ipv6 bit while destroying ipv6 listening servers may result in
potential fatal adapter errors due to lookup engine memory hash errors.
Therefore always set ipv6 field while destroying ipv6 listening servers.

Fixes: 830662f6f032 ("RDMA/cxgb4: Add support for active and passive open connection with IPv6 address")
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
Changes since v0:
- modified commit description to inform the severity of patch.
Changes since v1:
- removed extra variable as per Leon.
---
---
 drivers/infiniband/hw/cxgb4/cm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index 8769e7aa097f..81903749d241 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -3610,13 +3610,13 @@ int c4iw_destroy_listen(struct iw_cm_id *cm_id)
 	    ep->com.local_addr.ss_family == AF_INET) {
 		err = cxgb4_remove_server_filter(
 			ep->com.dev->rdev.lldi.ports[0], ep->stid,
-			ep->com.dev->rdev.lldi.rxq_ids[0], 0);
+			ep->com.dev->rdev.lldi.rxq_ids[0], false);
 	} else {
 		struct sockaddr_in6 *sin6;
 		c4iw_init_wr_wait(ep->com.wr_waitp);
 		err = cxgb4_remove_server(
 				ep->com.dev->rdev.lldi.ports[0], ep->stid,
-				ep->com.dev->rdev.lldi.rxq_ids[0], 0);
+				ep->com.dev->rdev.lldi.rxq_ids[0], true);
 		if (err)
 			goto done;
 		err = c4iw_wait_for_reply(&ep->com.dev->rdev, ep->com.wr_waitp,
-- 
2.24.0

