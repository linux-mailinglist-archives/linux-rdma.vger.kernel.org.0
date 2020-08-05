Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40A723CD97
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Aug 2020 19:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgHERjj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Aug 2020 13:39:39 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:55676 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728103AbgHERjV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Aug 2020 13:39:21 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with SMTP; 5 Aug 2020 15:12:31 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 075CCVFd023402;
        Wed, 5 Aug 2020 15:12:31 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     sagi@grimberg.me, linux-rdma@vger.kernel.org, jgg@nvidia.com,
        jgg@mellanox.com, dledford@redhat.com, leonro@mellanox.com
Cc:     oren@mellanox.com, Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH 1/2] IB/isert: use unlikely macro in the fast path
Date:   Wed,  5 Aug 2020 15:12:30 +0300
Message-Id: <20200805121231.166162-1-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add performance optimization that might slightly improve small IO sizes
benchmarks.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index b7df38ee8ae0..c818eebe6538 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -847,7 +847,7 @@ isert_post_recv(struct isert_conn *isert_conn, struct iser_rx_desc *rx_desc)
 	rx_wr.next = NULL;
 
 	ret = ib_post_recv(isert_conn->qp, &rx_wr, NULL);
-	if (ret)
+	if (unlikely(ret))
 		isert_err("ib_post_recv() failed with ret: %d\n", ret);
 
 	return ret;
@@ -1831,7 +1831,7 @@ isert_post_response(struct isert_conn *isert_conn, struct isert_cmd *isert_cmd)
 	}
 
 	ret = ib_post_send(isert_conn->qp, &isert_cmd->tx_desc.send_wr, NULL);
-	if (ret) {
+	if (unlikely(ret)) {
 		isert_err("ib_post_send failed with %d\n", ret);
 		return ret;
 	}
-- 
2.18.1

