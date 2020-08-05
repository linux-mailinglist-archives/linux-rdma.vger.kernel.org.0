Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B4523CD99
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Aug 2020 19:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgHERjm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Aug 2020 13:39:42 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:55677 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728825AbgHERjV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Aug 2020 13:39:21 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with SMTP; 5 Aug 2020 15:12:31 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 075CCVFe023402;
        Wed, 5 Aug 2020 15:12:31 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     sagi@grimberg.me, linux-rdma@vger.kernel.org, jgg@nvidia.com,
        jgg@mellanox.com, dledford@redhat.com, leonro@mellanox.com
Cc:     oren@mellanox.com, Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH 2/2] IB/isert: remove duplicated error prints
Date:   Wed,  5 Aug 2020 15:12:31 +0300
Message-Id: <20200805121231.166162-2-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200805121231.166162-1-maxg@mellanox.com>
References: <20200805121231.166162-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The isert_post_recv function prints an error in case of failures, so no
need for the callers to add another print.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index c818eebe6538..58c2a6ca5a5e 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -1243,12 +1243,7 @@ isert_handle_iscsi_dataout(struct isert_conn *isert_conn,
 	 * multiple data-outs on the same command can arrive -
 	 * so post the buffer before hand
 	 */
-	rc = isert_post_recv(isert_conn, rx_desc);
-	if (rc) {
-		isert_err("ib_post_recv failed with %d\n", rc);
-		return rc;
-	}
-	return 0;
+	return isert_post_recv(isert_conn, rx_desc);
 }
 
 static int
@@ -1825,10 +1820,8 @@ isert_post_response(struct isert_conn *isert_conn, struct isert_cmd *isert_cmd)
 	int ret;
 
 	ret = isert_post_recv(isert_conn, isert_cmd->rx_desc);
-	if (ret) {
-		isert_err("ib_post_recv failed with %d\n", ret);
+	if (ret)
 		return ret;
-	}
 
 	ret = ib_post_send(isert_conn->qp, &isert_cmd->tx_desc.send_wr, NULL);
 	if (unlikely(ret)) {
@@ -2200,10 +2193,8 @@ isert_put_datain(struct iscsi_conn *conn, struct iscsi_cmd *cmd)
 				   &isert_cmd->tx_desc.send_wr);
 
 		rc = isert_post_recv(isert_conn, isert_cmd->rx_desc);
-		if (rc) {
-			isert_err("ib_post_recv failed with %d\n", rc);
+		if (rc)
 			return rc;
-		}
 
 		chain_wr = &isert_cmd->tx_desc.send_wr;
 	}
-- 
2.18.1

