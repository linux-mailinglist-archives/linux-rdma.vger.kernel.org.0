Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8F6218362
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2020 11:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgGHJTO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jul 2020 05:19:14 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:46640 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726144AbgGHJTO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jul 2020 05:19:14 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with SMTP; 8 Jul 2020 12:19:08 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0689J8cf015094;
        Wed, 8 Jul 2020 12:19:08 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     sagi@grimberg.me, krishna2@chelsio.com, linux-rdma@vger.kernel.org,
        leonro@mellanox.com, jgg@mellanox.com
Cc:     israelr@mellanox.com, nirranjan@chelsio.com, bharat@chelsio.com,
        oren@mellanox.com, Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH 1/1] IB/isert: allocate RW ctxs according to max IO size
Date:   Wed,  8 Jul 2020 12:19:08 +0300
Message-Id: <20200708091908.162263-1-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Current iSER target code allocates MR pool budget based on queue size.
Since there is no handshake between iSER initiator and target on max IO
size, we'll set the iSER target to support upto 16MiB IO operations and
allocate the correct number of RDMA ctxs according to the factor of MR's
per IO operation. This would guaranty sufficient size of the MR pool for
the required IO queue depth and IO size.

Reported-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
Tested-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 6 ++++--
 drivers/infiniband/ulp/isert/ib_isert.h | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index b7df38e..49f5f05 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -119,7 +119,7 @@
 {
 	struct isert_device *device = isert_conn->device;
 	struct ib_qp_init_attr attr;
-	int ret;
+	int ret, factor;
 
 	memset(&attr, 0, sizeof(struct ib_qp_init_attr));
 	attr.event_handler = isert_qp_event_callback;
@@ -128,7 +128,9 @@
 	attr.recv_cq = comp->cq;
 	attr.cap.max_send_wr = ISERT_QP_MAX_REQ_DTOS + 1;
 	attr.cap.max_recv_wr = ISERT_QP_MAX_RECV_DTOS + 1;
-	attr.cap.max_rdma_ctxs = ISCSI_DEF_XMIT_CMDS_MAX;
+	factor = rdma_rw_mr_factor(device->ib_device, cma_id->port_num,
+				   ISCSI_ISER_MAX_SG_TABLESIZE);
+	attr.cap.max_rdma_ctxs = ISCSI_DEF_XMIT_CMDS_MAX * factor;
 	attr.cap.max_send_sge = device->ib_device->attrs.max_send_sge;
 	attr.cap.max_recv_sge = 1;
 	attr.sq_sig_type = IB_SIGNAL_REQ_WR;
diff --git a/drivers/infiniband/ulp/isert/ib_isert.h b/drivers/infiniband/ulp/isert/ib_isert.h
index 3b296ba..c9ccf1d 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.h
+++ b/drivers/infiniband/ulp/isert/ib_isert.h
@@ -63,7 +63,8 @@
 		(ISER_RX_PAYLOAD_SIZE + sizeof(u64) + sizeof(struct ib_sge) + \
 		 sizeof(struct ib_cqe) + sizeof(bool)))
 
-#define ISCSI_ISER_SG_TABLESIZE		256
+/* Maximum support is 16MB I/O size */
+#define ISCSI_ISER_MAX_SG_TABLESIZE	4096
 
 enum isert_desc_type {
 	ISCSI_TX_CONTROL,
-- 
1.8.3.1

