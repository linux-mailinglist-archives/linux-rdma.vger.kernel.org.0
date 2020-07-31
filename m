Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC14233EE2
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jul 2020 08:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbgGaGFB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jul 2020 02:05:01 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:20944 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbgGaGFB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 Jul 2020 02:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1596175499; x=1627711499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SjOOPqulE67BNppe5UsIngCrGQLi3nDvkWL0yaVhSog=;
  b=O4RdaP20gmL66TDJUAd7R85H1dujciVBBcFOKnmwY3Foc3q0kPURNCd2
   VwJCONCLCPfmAHzq0bx317ezJgrHhoNMNWEUPz++mC8ykQLrTw1ZVGm0d
   L5ffz70XHgB5Zig5biaf89jONzw57x0YnuZMuBtxMaUb26A2kjWq8T46m
   4=;
IronPort-SDR: a41snJjXG11XNFTw9VDYTaI74FdXizlUpZuCnjdZNxNLsJHBU7mHEgghc4O0cB//KCWTwgD2+H
 mK7NPPCTPYaw==
X-IronPort-AV: E=Sophos;i="5.75,417,1589241600"; 
   d="scan'208";a="63210169"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 31 Jul 2020 06:04:55 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id 8B8F6A1232;
        Fri, 31 Jul 2020 06:04:54 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 31 Jul 2020 06:04:53 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 31 Jul 2020 06:04:52 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.212.6) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 31 Jul 2020 06:04:50 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        "Yossi Leybovich" <sleybo@amazon.com>
Subject: [PATCH for-next 4/4] RDMA/efa: Introduce SRD RNR retry
Date:   Fri, 31 Jul 2020 09:04:20 +0300
Message-ID: <20200731060420.17053-5-galpress@amazon.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200731060420.17053-1-galpress@amazon.com>
References: <20200731060420.17053-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch introduces the ability to configure SRD QPs with the RNR
retry parameter when issuing a modify QP command.

In addition, a capability bit was added to report support to the
userspace library.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 17 +++++++++++------
 drivers/infiniband/hw/efa/efa_com_cmd.c       |  2 ++
 drivers/infiniband/hw/efa/efa_com_cmd.h       |  2 ++
 drivers/infiniband/hw/efa/efa_verbs.c         | 19 ++++++++++++++++---
 include/uapi/rdma/efa-abi.h                   |  3 ++-
 5 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index fadf1ad2e13a..4c6a2056aabe 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -197,7 +197,8 @@ struct efa_admin_modify_qp_cmd {
 	 * 2 : qkey
 	 * 3 : sq_psn
 	 * 4 : sq_drained_async_notify
-	 * 31:5 : reserved
+	 * 5 : rnr_retry
+	 * 31:6 : reserved
 	 */
 	u32 modify_mask;
 
@@ -219,8 +220,8 @@ struct efa_admin_modify_qp_cmd {
 	/* Enable async notification when SQ is drained */
 	u8 sq_drained_async_notify;
 
-	/* MBZ */
-	u8 reserved1;
+	/* Number of RNR retries (valid only for SRD QPs) */
+	u8 rnr_retry;
 
 	/* MBZ */
 	u16 reserved2;
@@ -255,8 +256,8 @@ struct efa_admin_query_qp_resp {
 	/* Indicates that draining is in progress */
 	u8 sq_draining;
 
-	/* MBZ */
-	u8 reserved1;
+	/* Number of RNR retries (valid only for SRD QPs) */
+	u8 rnr_retry;
 
 	/* MBZ */
 	u16 reserved2;
@@ -573,7 +574,9 @@ struct efa_admin_feature_device_attr_desc {
 	/*
 	 * 0 : rdma_read - If set, RDMA Read is supported on
 	 *    TX queues
-	 * 31:1 : reserved - MBZ
+	 * 1 : rnr_retry - If set, RNR retry is supported on
+	 *    modify QP command
+	 * 31:2 : reserved - MBZ
 	 */
 	u32 device_caps;
 
@@ -854,6 +857,7 @@ struct efa_admin_host_info {
 #define EFA_ADMIN_MODIFY_QP_CMD_QKEY_MASK                   BIT(2)
 #define EFA_ADMIN_MODIFY_QP_CMD_SQ_PSN_MASK                 BIT(3)
 #define EFA_ADMIN_MODIFY_QP_CMD_SQ_DRAINED_ASYNC_NOTIFY_MASK BIT(4)
+#define EFA_ADMIN_MODIFY_QP_CMD_RNR_RETRY_MASK              BIT(5)
 
 /* reg_mr_cmd */
 #define EFA_ADMIN_REG_MR_CMD_PHYS_PAGE_SIZE_SHIFT_MASK      GENMASK(4, 0)
@@ -871,6 +875,7 @@ struct efa_admin_host_info {
 
 /* feature_device_attr_desc */
 #define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RDMA_READ_MASK   BIT(0)
+#define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RNR_RETRY_MASK   BIT(1)
 
 /* host_info */
 #define EFA_ADMIN_HOST_INFO_DRIVER_MODULE_TYPE_MASK         GENMASK(7, 0)
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index fabd8df2e78f..e1b55eb933e0 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -76,6 +76,7 @@ int efa_com_modify_qp(struct efa_com_dev *edev,
 	cmd.qkey = params->qkey;
 	cmd.sq_psn = params->sq_psn;
 	cmd.sq_drained_async_notify = params->sq_drained_async_notify;
+	cmd.rnr_retry = params->rnr_retry;
 
 	err = efa_com_cmd_exec(aq,
 			       (struct efa_admin_aq_entry *)&cmd,
@@ -121,6 +122,7 @@ int efa_com_query_qp(struct efa_com_dev *edev,
 	result->qkey = resp.qkey;
 	result->sq_draining = resp.sq_draining;
 	result->sq_psn = resp.sq_psn;
+	result->rnr_retry = resp.rnr_retry;
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
index 41ce4a476ee6..155fa37b4e50 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.h
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
@@ -47,6 +47,7 @@ struct efa_com_modify_qp_params {
 	u32 qkey;
 	u32 sq_psn;
 	u8 sq_drained_async_notify;
+	u8 rnr_retry;
 };
 
 struct efa_com_query_qp_params {
@@ -58,6 +59,7 @@ struct efa_com_query_qp_result {
 	u32 qkey;
 	u32 sq_draining;
 	u32 sq_psn;
+	u8 rnr_retry;
 };
 
 struct efa_com_destroy_qp_params {
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 6c524cea3e9c..b8a5dfb84137 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -222,6 +222,9 @@ int efa_query_device(struct ib_device *ibdev,
 		if (EFA_DEV_CAP(dev, RDMA_READ))
 			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_RDMA_READ;
 
+		if (EFA_DEV_CAP(dev, RNR_RETRY))
+			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_RNR_RETRY;
+
 		err = ib_copy_to_udata(udata, &resp,
 				       min(sizeof(resp), udata->outlen));
 		if (err) {
@@ -267,7 +270,7 @@ int efa_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 
 #define EFA_QUERY_QP_SUPP_MASK \
 	(IB_QP_STATE | IB_QP_PKEY_INDEX | IB_QP_PORT | \
-	 IB_QP_QKEY | IB_QP_SQ_PSN | IB_QP_CAP)
+	 IB_QP_QKEY | IB_QP_SQ_PSN | IB_QP_CAP | IB_QP_RNR_RETRY)
 
 	if (qp_attr_mask & ~EFA_QUERY_QP_SUPP_MASK) {
 		ibdev_dbg(&dev->ibdev,
@@ -289,6 +292,7 @@ int efa_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	qp_attr->sq_psn = result.sq_psn;
 	qp_attr->sq_draining = result.sq_draining;
 	qp_attr->port_num = 1;
+	qp_attr->rnr_retry = result.rnr_retry;
 
 	qp_attr->cap.max_send_wr = qp->max_send_wr;
 	qp_attr->cap.max_recv_wr = qp->max_recv_wr;
@@ -775,7 +779,9 @@ static const struct {
 			.valid = 1,
 			.req_param = IB_QP_SQ_PSN,
 			.opt_param = IB_QP_CUR_STATE |
-				     IB_QP_QKEY,
+				     IB_QP_QKEY |
+				     IB_QP_RNR_RETRY,
+
 		}
 	},
 	[IB_QPS_RTS] = {
@@ -855,7 +861,8 @@ static int efa_modify_qp_validate(struct efa_dev *dev, struct efa_qp *qp,
 
 #define EFA_MODIFY_QP_SUPP_MASK \
 	(IB_QP_STATE | IB_QP_CUR_STATE | IB_QP_EN_SQD_ASYNC_NOTIFY | \
-	 IB_QP_PKEY_INDEX | IB_QP_PORT | IB_QP_QKEY | IB_QP_SQ_PSN)
+	 IB_QP_PKEY_INDEX | IB_QP_PORT | IB_QP_QKEY | IB_QP_SQ_PSN | \
+	 IB_QP_RNR_RETRY)
 
 	if (qp_attr_mask & ~EFA_MODIFY_QP_SUPP_MASK) {
 		ibdev_dbg(&dev->ibdev,
@@ -942,6 +949,12 @@ int efa_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 		params.sq_psn = qp_attr->sq_psn;
 	}
 
+	if (qp_attr_mask & IB_QP_RNR_RETRY) {
+		EFA_SET(&params.modify_mask, EFA_ADMIN_MODIFY_QP_CMD_RNR_RETRY,
+			1);
+		params.rnr_retry = qp_attr->rnr_retry;
+	}
+
 	err = efa_com_modify_qp(&dev->edev, &params);
 	if (err)
 		return err;
diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
index 53b6e2036a9b..6f3f4ebc2585 100644
--- a/include/uapi/rdma/efa-abi.h
+++ b/include/uapi/rdma/efa-abi.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
 /*
- * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef EFA_ABI_USER_H
@@ -92,6 +92,7 @@ struct efa_ibv_create_ah_resp {
 
 enum {
 	EFA_QUERY_DEVICE_CAPS_RDMA_READ = 1 << 0,
+	EFA_QUERY_DEVICE_CAPS_RNR_RETRY = 1 << 1,
 };
 
 struct efa_ibv_ex_query_device_resp {
-- 
2.27.0

