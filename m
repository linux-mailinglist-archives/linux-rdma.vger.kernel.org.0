Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2933C5B1E
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jul 2021 13:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbhGLLDm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jul 2021 07:03:42 -0400
Received: from smtp-fw-80006.amazon.com ([99.78.197.217]:35926 "EHLO
        smtp-fw-80006.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbhGLLDl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jul 2021 07:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1626087654; x=1657623654;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O5DavsvV+97OzMq9TAXEWE+szCdoViUVEtx3lhUrhA8=;
  b=OApS79/FzUOobZjuOzNO2F/EEQ445rosUAZKsCwnAJRYkQcnY2QZAeYI
   Gnk1ehwZHmrlP/op7uJ5me8kzS/wYZUFkMOYqbWnoQul7fGtPFe0Q6bHC
   oehtkSWaP9awhyZACEH69kTonwj8VhOJS4R+Tbzk+JFpqcTojdRRoOsBx
   0=;
X-IronPort-AV: E=Sophos;i="5.84,232,1620691200"; 
   d="scan'208";a="11559834"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP; 12 Jul 2021 10:59:41 +0000
Received: from EX13D19EUB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id CA075A2010;
        Mon, 12 Jul 2021 10:59:38 +0000 (UTC)
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Mon, 12 Jul 2021 10:59:37 +0000
Received: from 8c85908914bf.ant.amazon.com.com (10.218.69.140) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.18 via Frontend Transport; Mon, 12 Jul 2021 10:59:34 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-next] RDMA/efa: Split hardware stats to device and port stats
Date:   Mon, 12 Jul 2021 13:59:23 +0300
Message-ID: <20210712105923.17389-1-galpress@amazon.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The hardware stats API distinguishes between device and port statistics,
split the EFA stats accordingly instead of always dumping everything.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 120 +++++++++++++++-----------
 1 file changed, 71 insertions(+), 49 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index be6d3ff0f1be..b4cfb656ddd5 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
- * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2021 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #include <linux/vmalloc.h>
@@ -30,20 +30,7 @@ struct efa_user_mmap_entry {
 	u8 mmap_flag;
 };
 
-#define EFA_DEFINE_STATS(op) \
-	op(EFA_TX_BYTES, "tx_bytes") \
-	op(EFA_TX_PKTS, "tx_pkts") \
-	op(EFA_RX_BYTES, "rx_bytes") \
-	op(EFA_RX_PKTS, "rx_pkts") \
-	op(EFA_RX_DROPS, "rx_drops") \
-	op(EFA_SEND_BYTES, "send_bytes") \
-	op(EFA_SEND_WRS, "send_wrs") \
-	op(EFA_RECV_BYTES, "recv_bytes") \
-	op(EFA_RECV_WRS, "recv_wrs") \
-	op(EFA_RDMA_READ_WRS, "rdma_read_wrs") \
-	op(EFA_RDMA_READ_BYTES, "rdma_read_bytes") \
-	op(EFA_RDMA_READ_WR_ERR, "rdma_read_wr_err") \
-	op(EFA_RDMA_READ_RESP_BYTES, "rdma_read_resp_bytes") \
+#define EFA_DEFINE_DEVICE_STATS(op) \
 	op(EFA_SUBMITTED_CMDS, "submitted_cmds") \
 	op(EFA_COMPLETED_CMDS, "completed_cmds") \
 	op(EFA_CMDS_ERR, "cmds_err") \
@@ -57,15 +44,38 @@ struct efa_user_mmap_entry {
 	op(EFA_CREATE_AH_ERR, "create_ah_err") \
 	op(EFA_MMAP_ERR, "mmap_err")
 
+#define EFA_DEFINE_PORT_STATS(op) \
+	op(EFA_TX_BYTES, "tx_bytes") \
+	op(EFA_TX_PKTS, "tx_pkts") \
+	op(EFA_RX_BYTES, "rx_bytes") \
+	op(EFA_RX_PKTS, "rx_pkts") \
+	op(EFA_RX_DROPS, "rx_drops") \
+	op(EFA_SEND_BYTES, "send_bytes") \
+	op(EFA_SEND_WRS, "send_wrs") \
+	op(EFA_RECV_BYTES, "recv_bytes") \
+	op(EFA_RECV_WRS, "recv_wrs") \
+	op(EFA_RDMA_READ_WRS, "rdma_read_wrs") \
+	op(EFA_RDMA_READ_BYTES, "rdma_read_bytes") \
+	op(EFA_RDMA_READ_WR_ERR, "rdma_read_wr_err") \
+	op(EFA_RDMA_READ_RESP_BYTES, "rdma_read_resp_bytes") \
+
 #define EFA_STATS_ENUM(ename, name) ename,
 #define EFA_STATS_STR(ename, name) [ename] = name,
 
-enum efa_hw_stats {
-	EFA_DEFINE_STATS(EFA_STATS_ENUM)
+enum efa_hw_device_stats {
+	EFA_DEFINE_DEVICE_STATS(EFA_STATS_ENUM)
 };
 
-static const char *const efa_stats_names[] = {
-	EFA_DEFINE_STATS(EFA_STATS_STR)
+static const char *const efa_device_stats_names[] = {
+	EFA_DEFINE_DEVICE_STATS(EFA_STATS_STR)
+};
+
+enum efa_hw_port_stats {
+	EFA_DEFINE_PORT_STATS(EFA_STATS_ENUM)
+};
+
+static const char *const efa_port_stats_names[] = {
+	EFA_DEFINE_PORT_STATS(EFA_STATS_STR)
 };
 
 #define EFA_CHUNK_PAYLOAD_SHIFT       12
@@ -1904,33 +1914,53 @@ int efa_destroy_ah(struct ib_ah *ibah, u32 flags)
 	return 0;
 }
 
-struct rdma_hw_stats *efa_alloc_hw_port_stats(struct ib_device *ibdev, u32 port_num)
+struct rdma_hw_stats *efa_alloc_hw_port_stats(struct ib_device *ibdev,
+					      u32 port_num)
 {
-	return rdma_alloc_hw_stats_struct(efa_stats_names,
-					  ARRAY_SIZE(efa_stats_names),
+	return rdma_alloc_hw_stats_struct(efa_port_stats_names,
+					  ARRAY_SIZE(efa_port_stats_names),
 					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
 }
 
 struct rdma_hw_stats *efa_alloc_hw_device_stats(struct ib_device *ibdev)
 {
-	/*
-	 * It is probably a bug that efa reports its port stats as device
-	 * stats
-	 */
-	return efa_alloc_hw_port_stats(ibdev, 0);
+	return rdma_alloc_hw_stats_struct(efa_device_stats_names,
+					  ARRAY_SIZE(efa_device_stats_names),
+					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
 }
 
-int efa_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
-		     u32 port_num, int index)
+static int efa_fill_device_stats(struct efa_dev *dev,
+				 struct rdma_hw_stats *stats)
+{
+	struct efa_com_stats_admin *as = &dev->edev.aq.stats;
+	struct efa_stats *s = &dev->stats;
+
+	stats->value[EFA_SUBMITTED_CMDS] = atomic64_read(&as->submitted_cmd);
+	stats->value[EFA_COMPLETED_CMDS] = atomic64_read(&as->completed_cmd);
+	stats->value[EFA_CMDS_ERR] = atomic64_read(&as->cmd_err);
+	stats->value[EFA_NO_COMPLETION_CMDS] = atomic64_read(&as->no_completion);
+
+	stats->value[EFA_KEEP_ALIVE_RCVD] = atomic64_read(&s->keep_alive_rcvd);
+	stats->value[EFA_ALLOC_PD_ERR] = atomic64_read(&s->alloc_pd_err);
+	stats->value[EFA_CREATE_QP_ERR] = atomic64_read(&s->create_qp_err);
+	stats->value[EFA_CREATE_CQ_ERR] = atomic64_read(&s->create_cq_err);
+	stats->value[EFA_REG_MR_ERR] = atomic64_read(&s->reg_mr_err);
+	stats->value[EFA_ALLOC_UCONTEXT_ERR] =
+		atomic64_read(&s->alloc_ucontext_err);
+	stats->value[EFA_CREATE_AH_ERR] = atomic64_read(&s->create_ah_err);
+	stats->value[EFA_MMAP_ERR] = atomic64_read(&s->mmap_err);
+
+	return ARRAY_SIZE(efa_device_stats_names);
+}
+
+static int efa_fill_port_stats(struct efa_dev *dev, struct rdma_hw_stats *stats,
+			       u32 port_num)
 {
 	struct efa_com_get_stats_params params = {};
 	union efa_com_get_stats_result result;
-	struct efa_dev *dev = to_edev(ibdev);
 	struct efa_com_rdma_read_stats *rrs;
 	struct efa_com_messages_stats *ms;
 	struct efa_com_basic_stats *bs;
-	struct efa_com_stats_admin *as;
-	struct efa_stats *s;
 	int err;
 
 	params.scope = EFA_ADMIN_GET_STATS_SCOPE_ALL;
@@ -1969,24 +1999,16 @@ int efa_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
 	stats->value[EFA_RDMA_READ_WR_ERR] = rrs->read_wr_err;
 	stats->value[EFA_RDMA_READ_RESP_BYTES] = rrs->read_resp_bytes;
 
-	as = &dev->edev.aq.stats;
-	stats->value[EFA_SUBMITTED_CMDS] = atomic64_read(&as->submitted_cmd);
-	stats->value[EFA_COMPLETED_CMDS] = atomic64_read(&as->completed_cmd);
-	stats->value[EFA_CMDS_ERR] = atomic64_read(&as->cmd_err);
-	stats->value[EFA_NO_COMPLETION_CMDS] = atomic64_read(&as->no_completion);
+	return ARRAY_SIZE(efa_port_stats_names);
+}
 
-	s = &dev->stats;
-	stats->value[EFA_KEEP_ALIVE_RCVD] = atomic64_read(&s->keep_alive_rcvd);
-	stats->value[EFA_ALLOC_PD_ERR] = atomic64_read(&s->alloc_pd_err);
-	stats->value[EFA_CREATE_QP_ERR] = atomic64_read(&s->create_qp_err);
-	stats->value[EFA_CREATE_CQ_ERR] = atomic64_read(&s->create_cq_err);
-	stats->value[EFA_REG_MR_ERR] = atomic64_read(&s->reg_mr_err);
-	stats->value[EFA_ALLOC_UCONTEXT_ERR] =
-		atomic64_read(&s->alloc_ucontext_err);
-	stats->value[EFA_CREATE_AH_ERR] = atomic64_read(&s->create_ah_err);
-	stats->value[EFA_MMAP_ERR] = atomic64_read(&s->mmap_err);
-
-	return ARRAY_SIZE(efa_stats_names);
+int efa_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
+		     u32 port_num, int index)
+{
+	if (port_num)
+		return efa_fill_port_stats(to_edev(ibdev), stats, port_num);
+	else
+		return efa_fill_device_stats(to_edev(ibdev), stats);
 }
 
 enum rdma_link_layer efa_port_link_layer(struct ib_device *ibdev,

base-commit: 3d8287544223a3d2f37981c1f9ffd94d0b5e9ffc
-- 
2.32.0

