Return-Path: <linux-rdma+bounces-11907-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDD2AFA362
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Jul 2025 09:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050E9189E4F9
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Jul 2025 07:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FDB1D63C2;
	Sun,  6 Jul 2025 07:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="oDnmfane"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F71B610D
	for <linux-rdma@vger.kernel.org>; Sun,  6 Jul 2025 07:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751785689; cv=none; b=l0JKgCgX6CjrW8k3XZve3fC6+xY8HawxSI4Jw/QWxZmOT32f3Ga5kKsw5KXi/dVvkAINhwOnhlc5mAIufWZ3ICBM8WUpWuFb1tx9Ht/4HAI2zumQk38SqoLn2/dS9Zsn284G5ZVwmY5g/vupAZR1B0is2F6QRtQ9c4848s9B9kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751785689; c=relaxed/simple;
	bh=gIrWZBkAvbbKH61Tlyegliy2bQhzN5UeHEZuh4uzD2U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E+YuzWoeKW1zOxefvZSPsLA+WMcVXWB59whjExDqhB+MvMeahCHL4tZDNpt3r2vptPpSfCKaVfMqqOfULvk7C2OPPYUIVtSGDpFbpeELiV+9TpLmAv/+OO/hlCD9/j1ZHBPQ3GP+Rjpg973llIIA/xMMtFkQ45aNrDA86rMMK9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=oDnmfane; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1751785688; x=1783321688;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cYJZ8mc3minjzPTfsJQxkEbTntbDfQE9nOubqKDzSt8=;
  b=oDnmfaneiTgupzRT2X9OR3mqlkR+jfoBCMeMEBxI/HL/wzq83ooY2C2w
   GTfbcYyiTWoPyICqKGO/bICWa1d7mSm7UCnngw/uozv9LOU5zgVpk8f/C
   1capEa/z7Rcmq8N6E/u2i9GWmgKoZxwGRYrHT0H1kEVRFX/x0MLSAzB/m
   BR1zn+tmLV6/d8RYCL0rHp1SwYCH6X5KzAGK1wHvc/oSMyxwiB1tLm9Wj
   CA/xMjtkTmtbgh3zxsGHhII3ES4RHso8WOcTgrPsmK8TdDpw727WXSCgU
   sKBmAUK9IgtvK4LhoeNxcgmehU7Z4hNAzu8p/GFUwKynQdnfA9byPtZEW
   w==;
X-IronPort-AV: E=Sophos;i="6.16,291,1744070400"; 
   d="scan'208";a="536539183"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2025 07:08:03 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:53494]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.32.240:2525] with esmtp (Farcaster)
 id dff9af7f-d76e-46dc-88c1-80da4635b553; Sun, 6 Jul 2025 07:07:52 +0000 (UTC)
X-Farcaster-Flow-ID: dff9af7f-d76e-46dc-88c1-80da4635b553
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 6 Jul 2025 07:07:51 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D031EUB003.ant.amazon.com (10.252.61.88) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Sun, 6 Jul 2025
 07:07:48 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Basel
 Nassar" <baselna@amazon.com>, David Shoolman <shoolman@amazon.com>, "Yonatan
 Nachum" <ynachum@amazon.com>
Subject: [PATCH for-next] RDMA/efa: Add Network HW statistics counters
Date: Sun, 6 Jul 2025 07:07:40 +0000
Message-ID: <20250706070740.22534-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)

From: Basel Nassar <baselna@amazon.com>

Update device API and request network counters. Expose newly added
counters through ib core counters mechanism.

Reviewed-by: David Shoolman <shoolman@amazon.com>
Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Basel Nassar <baselna@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 17 +++++-
 drivers/infiniband/hw/efa/efa_com_cmd.c       | 53 ++++++++++++-------
 drivers/infiniband/hw/efa/efa_com_cmd.h       | 11 +++-
 drivers/infiniband/hw/efa/efa_verbs.c         | 18 +++++++
 4 files changed, 79 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index fe0b6aec7839..57178dad5eb7 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
- * Copyright 2018-2024 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef _EFA_ADMIN_CMDS_H_
@@ -68,6 +68,7 @@ enum efa_admin_get_stats_type {
 	EFA_ADMIN_GET_STATS_TYPE_MESSAGES           = 1,
 	EFA_ADMIN_GET_STATS_TYPE_RDMA_READ          = 2,
 	EFA_ADMIN_GET_STATS_TYPE_RDMA_WRITE         = 3,
+	EFA_ADMIN_GET_STATS_TYPE_NETWORK            = 4,
 };
 
 enum efa_admin_get_stats_scope {
@@ -651,6 +652,18 @@ struct efa_admin_rdma_write_stats {
 	u64 write_recv_bytes;
 };
 
+struct efa_admin_network_stats {
+	u64 retrans_bytes;
+
+	u64 retrans_pkts;
+
+	u64 retrans_timeout_events;
+
+	u64 unresponsive_remote_events;
+
+	u64 impaired_remote_conn_events;
+};
+
 struct efa_admin_acq_get_stats_resp {
 	struct efa_admin_acq_common_desc acq_common_desc;
 
@@ -662,6 +675,8 @@ struct efa_admin_acq_get_stats_resp {
 		struct efa_admin_rdma_read_stats rdma_read_stats;
 
 		struct efa_admin_rdma_write_stats rdma_write_stats;
+
+		struct efa_admin_network_stats network_stats;
 	} u;
 };
 
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index c6b89c45fdc9..9ead02800ac7 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
- * Copyright 2018-2024 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #include "efa_com.h"
@@ -769,6 +769,11 @@ int efa_com_get_stats(struct efa_com_dev *edev,
 	struct efa_com_admin_queue *aq = &edev->aq;
 	struct efa_admin_aq_get_stats_cmd cmd = {};
 	struct efa_admin_acq_get_stats_resp resp;
+	struct efa_admin_rdma_write_stats *rws;
+	struct efa_admin_rdma_read_stats *rrs;
+	struct efa_admin_messages_stats *ms;
+	struct efa_admin_network_stats *ns;
+	struct efa_admin_basic_stats *bs;
 	int err;
 
 	cmd.aq_common_descriptor.opcode = EFA_ADMIN_GET_STATS;
@@ -791,29 +796,41 @@ int efa_com_get_stats(struct efa_com_dev *edev,
 
 	switch (cmd.type) {
 	case EFA_ADMIN_GET_STATS_TYPE_BASIC:
-		result->basic_stats.tx_bytes = resp.u.basic_stats.tx_bytes;
-		result->basic_stats.tx_pkts = resp.u.basic_stats.tx_pkts;
-		result->basic_stats.rx_bytes = resp.u.basic_stats.rx_bytes;
-		result->basic_stats.rx_pkts = resp.u.basic_stats.rx_pkts;
-		result->basic_stats.rx_drops = resp.u.basic_stats.rx_drops;
+		bs = &resp.u.basic_stats;
+		result->basic_stats.tx_bytes = bs->tx_bytes;
+		result->basic_stats.tx_pkts = bs->tx_pkts;
+		result->basic_stats.rx_bytes = bs->rx_bytes;
+		result->basic_stats.rx_pkts = bs->rx_pkts;
+		result->basic_stats.rx_drops = bs->rx_drops;
 		break;
 	case EFA_ADMIN_GET_STATS_TYPE_MESSAGES:
-		result->messages_stats.send_bytes = resp.u.messages_stats.send_bytes;
-		result->messages_stats.send_wrs = resp.u.messages_stats.send_wrs;
-		result->messages_stats.recv_bytes = resp.u.messages_stats.recv_bytes;
-		result->messages_stats.recv_wrs = resp.u.messages_stats.recv_wrs;
+		ms = &resp.u.messages_stats;
+		result->messages_stats.send_bytes = ms->send_bytes;
+		result->messages_stats.send_wrs = ms->send_wrs;
+		result->messages_stats.recv_bytes = ms->recv_bytes;
+		result->messages_stats.recv_wrs = ms->recv_wrs;
 		break;
 	case EFA_ADMIN_GET_STATS_TYPE_RDMA_READ:
-		result->rdma_read_stats.read_wrs = resp.u.rdma_read_stats.read_wrs;
-		result->rdma_read_stats.read_bytes = resp.u.rdma_read_stats.read_bytes;
-		result->rdma_read_stats.read_wr_err = resp.u.rdma_read_stats.read_wr_err;
-		result->rdma_read_stats.read_resp_bytes = resp.u.rdma_read_stats.read_resp_bytes;
+		rrs = &resp.u.rdma_read_stats;
+		result->rdma_read_stats.read_wrs = rrs->read_wrs;
+		result->rdma_read_stats.read_bytes = rrs->read_bytes;
+		result->rdma_read_stats.read_wr_err = rrs->read_wr_err;
+		result->rdma_read_stats.read_resp_bytes = rrs->read_resp_bytes;
 		break;
 	case EFA_ADMIN_GET_STATS_TYPE_RDMA_WRITE:
-		result->rdma_write_stats.write_wrs = resp.u.rdma_write_stats.write_wrs;
-		result->rdma_write_stats.write_bytes = resp.u.rdma_write_stats.write_bytes;
-		result->rdma_write_stats.write_wr_err = resp.u.rdma_write_stats.write_wr_err;
-		result->rdma_write_stats.write_recv_bytes = resp.u.rdma_write_stats.write_recv_bytes;
+		rws = &resp.u.rdma_write_stats;
+		result->rdma_write_stats.write_wrs = rws->write_wrs;
+		result->rdma_write_stats.write_bytes = rws->write_bytes;
+		result->rdma_write_stats.write_wr_err = rws->write_wr_err;
+		result->rdma_write_stats.write_recv_bytes = rws->write_recv_bytes;
+		break;
+	case EFA_ADMIN_GET_STATS_TYPE_NETWORK:
+		ns = &resp.u.network_stats;
+		result->network_stats.retrans_bytes = ns->retrans_bytes;
+		result->network_stats.retrans_pkts = ns->retrans_pkts;
+		result->network_stats.retrans_timeout_events = ns->retrans_timeout_events;
+		result->network_stats.unresponsive_remote_events = ns->unresponsive_remote_events;
+		result->network_stats.impaired_remote_conn_events = ns->impaired_remote_conn_events;
 		break;
 	}
 
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
index 5511355b700d..3ac2686abba1 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.h
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
- * Copyright 2018-2024 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef _EFA_COM_CMD_H_
@@ -283,11 +283,20 @@ struct efa_com_rdma_write_stats {
 	u64 write_recv_bytes;
 };
 
+struct efa_com_network_stats {
+	u64 retrans_bytes;
+	u64 retrans_pkts;
+	u64 retrans_timeout_events;
+	u64 unresponsive_remote_events;
+	u64 impaired_remote_conn_events;
+};
+
 union efa_com_get_stats_result {
 	struct efa_com_basic_stats basic_stats;
 	struct efa_com_messages_stats messages_stats;
 	struct efa_com_rdma_read_stats rdma_read_stats;
 	struct efa_com_rdma_write_stats rdma_write_stats;
+	struct efa_com_network_stats network_stats;
 };
 
 int efa_com_create_qp(struct efa_com_dev *edev,
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index a8645a40730f..7c708029b4b4 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -64,6 +64,11 @@ struct efa_user_mmap_entry {
 	op(EFA_RDMA_WRITE_BYTES, "rdma_write_bytes") \
 	op(EFA_RDMA_WRITE_WR_ERR, "rdma_write_wr_err") \
 	op(EFA_RDMA_WRITE_RECV_BYTES, "rdma_write_recv_bytes") \
+	op(EFA_RETRANS_BYTES, "retrans_bytes") \
+	op(EFA_RETRANS_PKTS, "retrans_pkts") \
+	op(EFA_RETRANS_TIMEOUT_EVENS, "retrans_timeout_events") \
+	op(EFA_UNRESPONSIVE_REMOTE_EVENTS, "unresponsive_remote_events") \
+	op(EFA_IMPAIRED_REMOTE_CONN_EVENTS, "impaired_remote_conn_events") \
 
 #define EFA_STATS_ENUM(ename, name) ename,
 #define EFA_STATS_STR(ename, nam) \
@@ -2186,6 +2191,7 @@ static int efa_fill_port_stats(struct efa_dev *dev, struct rdma_hw_stats *stats,
 	struct efa_com_rdma_write_stats *rws;
 	struct efa_com_rdma_read_stats *rrs;
 	struct efa_com_messages_stats *ms;
+	struct efa_com_network_stats *ns;
 	struct efa_com_basic_stats *bs;
 	int err;
 
@@ -2238,6 +2244,18 @@ static int efa_fill_port_stats(struct efa_dev *dev, struct rdma_hw_stats *stats,
 		stats->value[EFA_RDMA_WRITE_RECV_BYTES] = rws->write_recv_bytes;
 	}
 
+	params.type = EFA_ADMIN_GET_STATS_TYPE_NETWORK;
+	err = efa_com_get_stats(&dev->edev, &params, &result);
+	if (err)
+		return err;
+
+	ns = &result.network_stats;
+	stats->value[EFA_RETRANS_BYTES] = ns->retrans_bytes;
+	stats->value[EFA_RETRANS_PKTS] = ns->retrans_pkts;
+	stats->value[EFA_RETRANS_TIMEOUT_EVENS] = ns->retrans_timeout_events;
+	stats->value[EFA_UNRESPONSIVE_REMOTE_EVENTS] = ns->unresponsive_remote_events;
+	stats->value[EFA_IMPAIRED_REMOTE_CONN_EVENTS] = ns->impaired_remote_conn_events;
+
 	return ARRAY_SIZE(efa_port_stats_descs);
 }
 
-- 
2.47.1


