Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAF128A67C
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Oct 2020 11:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbgJKJGN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Oct 2020 05:06:13 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:51750 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387453AbgJKJGM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Oct 2020 05:06:12 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from mgurtovoy@nvidia.com)
        with SMTP; 11 Oct 2020 12:06:09 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 09B9689e014227;
        Sun, 11 Oct 2020 12:06:08 +0300
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     sagi@grimberg.me, krishna2@chelsio.com, linux-rdma@vger.kernel.org,
        jgg@nvidia.com, dledford@redhat.com
Cc:     oren@nvidia.com, maxg@mellanox.com
Subject: [PATCH 1/1] IB/isert: add module param to set sg_tablesize for IO cmd
Date:   Sun, 11 Oct 2020 12:06:08 +0300
Message-Id: <20201011090608.159333-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Max Gurtovoy <maxg@mellanox.com>

Currently, iser target support max IO size of 16MiB by default. For some
adapters, allocating this amount of resources might reduce the total
number of possible connections that can be created. For those adapters,
it's preferred to reduce the max IO size to be able to create more
connections. Since there is no handshake procedure for max IO size in
iser protocol, set the default max IO size to 1MiB and add a module
parameter for enabling the option to control it for suitable adapters.

Reported-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 27 ++++++++++++++++++++++++-
 drivers/infiniband/ulp/isert/ib_isert.h |  6 ++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 695f701dc43d..5a47f1bbca96 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -28,6 +28,18 @@ static int isert_debug_level;
 module_param_named(debug_level, isert_debug_level, int, 0644);
 MODULE_PARM_DESC(debug_level, "Enable debug tracing if > 0 (default:0)");
 
+static int isert_sg_tablesize_set(const char *val,
+				  const struct kernel_param *kp);
+static const struct kernel_param_ops sg_tablesize_ops = {
+	.set = isert_sg_tablesize_set,
+	.get = param_get_int,
+};
+
+static int isert_sg_tablesize = ISCSI_ISER_SG_TABLESIZE;
+module_param_cb(sg_tablesize, &sg_tablesize_ops, &isert_sg_tablesize, 0644);
+MODULE_PARM_DESC(sg_tablesize,
+		 "Number of gather/scatter entries in a single scsi command, should >= 128 (default: 256, max: 4096)");
+
 static DEFINE_MUTEX(device_list_mutex);
 static LIST_HEAD(device_list);
 static struct workqueue_struct *isert_comp_wq;
@@ -47,6 +59,19 @@ static void isert_send_done(struct ib_cq *cq, struct ib_wc *wc);
 static void isert_login_recv_done(struct ib_cq *cq, struct ib_wc *wc);
 static void isert_login_send_done(struct ib_cq *cq, struct ib_wc *wc);
 
+static int isert_sg_tablesize_set(const char *val, const struct kernel_param *kp)
+{
+	int n = 0, ret;
+
+	ret = kstrtoint(val, 10, &n);
+	if (ret != 0 || n < ISCSI_ISER_MIN_SG_TABLESIZE ||
+	    n > ISCSI_ISER_MAX_SG_TABLESIZE)
+		return -EINVAL;
+
+	return param_set_int(val, kp);
+}
+
+
 static inline bool
 isert_prot_cmd(struct isert_conn *conn, struct se_cmd *cmd)
 {
@@ -101,7 +126,7 @@ isert_create_qp(struct isert_conn *isert_conn,
 	attr.cap.max_send_wr = ISERT_QP_MAX_REQ_DTOS + 1;
 	attr.cap.max_recv_wr = ISERT_QP_MAX_RECV_DTOS + 1;
 	factor = rdma_rw_mr_factor(device->ib_device, cma_id->port_num,
-				   ISCSI_ISER_MAX_SG_TABLESIZE);
+				   isert_sg_tablesize);
 	attr.cap.max_rdma_ctxs = ISCSI_DEF_XMIT_CMDS_MAX * factor;
 	attr.cap.max_send_sge = device->ib_device->attrs.max_send_sge;
 	attr.cap.max_recv_sge = 1;
diff --git a/drivers/infiniband/ulp/isert/ib_isert.h b/drivers/infiniband/ulp/isert/ib_isert.h
index 7fee4a65e181..90ef215bf755 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.h
+++ b/drivers/infiniband/ulp/isert/ib_isert.h
@@ -65,6 +65,12 @@
  */
 #define ISER_RX_SIZE		(ISCSI_DEF_MAX_RECV_SEG_LEN + 1024)
 
+/* Default I/O size is 1MB */
+#define ISCSI_ISER_SG_TABLESIZE 256
+
+/* Minimum I/O size is 512KB */
+#define ISCSI_ISER_MIN_SG_TABLESIZE 128
+
 /* Maximum support is 16MB I/O size */
 #define ISCSI_ISER_MAX_SG_TABLESIZE	4096
 
-- 
2.18.1

