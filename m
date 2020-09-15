Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2389026B786
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 02:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgIOORu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Sep 2020 10:17:50 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:34964 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgIOOQL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Sep 2020 10:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600179370; x=1631715370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aKLGuICAyxG+/Wbi5SMa8mwfjXQI6xI80NwlrtPtfSw=;
  b=kTBJ2KfcqrTHQFgP3DVLFnBxE1JYrTKKEBXhZoGstinpqvhT8+O3Aogb
   3YvujchHb5wz2ZWuIlkN4LTlkLf8XJBtS1/kck1i665VEaQIRaAnx+r3x
   kOU+XnWYmHBANMnajb3jubGbpQG1hRH3CcZ3rYOkUiVYLMA59/bVDMCy7
   0=;
X-IronPort-AV: E=Sophos;i="5.76,430,1592870400"; 
   d="scan'208";a="53890716"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 15 Sep 2020 14:15:03 +0000
Received: from EX13D02EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id A422EA22F8;
        Tue, 15 Sep 2020 14:15:01 +0000 (UTC)
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D02EUB003.ant.amazon.com (10.43.166.172) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 15 Sep 2020 14:15:00 +0000
Received: from 8c85908914bf.ant.amazon.com.com (10.85.91.6) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 15 Sep 2020 14:14:58 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Daniel Kranzdorf <dkkranzd@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next 2/2] RDMA/efa: Add messages and RDMA read work requests HW stats
Date:   Tue, 15 Sep 2020 17:14:49 +0300
Message-ID: <20200915141449.8428-3-galpress@amazon.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915141449.8428-1-galpress@amazon.com>
References: <20200915141449.8428-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Daniel Kranzdorf <dkkranzd@amazon.com>

Add separate stats types for send messages and RDMA read work requests.

Signed-off-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 30 +++++++++++++++-
 drivers/infiniband/hw/efa/efa_com_cmd.c       | 26 +++++++++++---
 drivers/infiniband/hw/efa/efa_com_cmd.h       | 16 +++++++++
 drivers/infiniband/hw/efa/efa_verbs.c         | 34 ++++++++++++++++++-
 4 files changed, 99 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index d9676ca0b958..b199e4ac6cf9 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -61,6 +61,8 @@ enum efa_admin_qp_state {
 
 enum efa_admin_get_stats_type {
 	EFA_ADMIN_GET_STATS_TYPE_BASIC              = 0,
+	EFA_ADMIN_GET_STATS_TYPE_MESSAGES           = 1,
+	EFA_ADMIN_GET_STATS_TYPE_RDMA_READ          = 2,
 };
 
 enum efa_admin_get_stats_scope {
@@ -528,10 +530,36 @@ struct efa_admin_basic_stats {
 	u64 rx_drops;
 };
 
+struct efa_admin_messages_stats {
+	u64 send_bytes;
+
+	u64 send_wrs;
+
+	u64 recv_bytes;
+
+	u64 recv_wrs;
+};
+
+struct efa_admin_rdma_read_stats {
+	u64 read_wrs;
+
+	u64 read_bytes;
+
+	u64 read_wr_err;
+
+	u64 read_resp_bytes;
+};
+
 struct efa_admin_acq_get_stats_resp {
 	struct efa_admin_acq_common_desc acq_common_desc;
 
-	struct efa_admin_basic_stats basic_stats;
+	union {
+		struct efa_admin_basic_stats basic_stats;
+
+		struct efa_admin_messages_stats messages_stats;
+
+		struct efa_admin_rdma_read_stats rdma_read_stats;
+	} u;
 };
 
 struct efa_admin_get_set_feature_common_desc {
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index f24634cce1cb..f752ef64159c 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -752,11 +752,27 @@ int efa_com_get_stats(struct efa_com_dev *edev,
 		return err;
 	}
 
-	result->basic_stats.tx_bytes = resp.basic_stats.tx_bytes;
-	result->basic_stats.tx_pkts = resp.basic_stats.tx_pkts;
-	result->basic_stats.rx_bytes = resp.basic_stats.rx_bytes;
-	result->basic_stats.rx_pkts = resp.basic_stats.rx_pkts;
-	result->basic_stats.rx_drops = resp.basic_stats.rx_drops;
+	switch (cmd.type) {
+	case EFA_ADMIN_GET_STATS_TYPE_BASIC:
+		result->basic_stats.tx_bytes = resp.u.basic_stats.tx_bytes;
+		result->basic_stats.tx_pkts = resp.u.basic_stats.tx_pkts;
+		result->basic_stats.rx_bytes = resp.u.basic_stats.rx_bytes;
+		result->basic_stats.rx_pkts = resp.u.basic_stats.rx_pkts;
+		result->basic_stats.rx_drops = resp.u.basic_stats.rx_drops;
+		break;
+	case EFA_ADMIN_GET_STATS_TYPE_MESSAGES:
+		result->messages_stats.send_bytes = resp.u.messages_stats.send_bytes;
+		result->messages_stats.send_wrs = resp.u.messages_stats.send_wrs;
+		result->messages_stats.recv_bytes = resp.u.messages_stats.recv_bytes;
+		result->messages_stats.recv_wrs = resp.u.messages_stats.recv_wrs;
+		break;
+	case EFA_ADMIN_GET_STATS_TYPE_RDMA_READ:
+		result->rdma_read_stats.read_wrs = resp.u.rdma_read_stats.read_wrs;
+		result->rdma_read_stats.read_bytes = resp.u.rdma_read_stats.read_bytes;
+		result->rdma_read_stats.read_wr_err = resp.u.rdma_read_stats.read_wr_err;
+		result->rdma_read_stats.read_resp_bytes = resp.u.rdma_read_stats.read_resp_bytes;
+		break;
+	}
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
index 9ebee129f477..eea4ebfbe6ec 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.h
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
@@ -240,8 +240,24 @@ struct efa_com_basic_stats {
 	u64 rx_drops;
 };
 
+struct efa_com_messages_stats {
+	u64 send_bytes;
+	u64 send_wrs;
+	u64 recv_bytes;
+	u64 recv_wrs;
+};
+
+struct efa_com_rdma_read_stats {
+	u64 read_wrs;
+	u64 read_bytes;
+	u64 read_wr_err;
+	u64 read_resp_bytes;
+};
+
 union efa_com_get_stats_result {
 	struct efa_com_basic_stats basic_stats;
+	struct efa_com_messages_stats messages_stats;
+	struct efa_com_rdma_read_stats rdma_read_stats;
 };
 
 void efa_com_set_dma_addr(dma_addr_t addr, u32 *addr_high, u32 *addr_low);
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index c0c4eeed14cd..9ff2a837a8f9 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -36,6 +36,14 @@ struct efa_user_mmap_entry {
 	op(EFA_RX_BYTES, "rx_bytes") \
 	op(EFA_RX_PKTS, "rx_pkts") \
 	op(EFA_RX_DROPS, "rx_drops") \
+	op(EFA_SEND_BYTES, "send_bytes") \
+	op(EFA_SEND_WRS, "send_wrs") \
+	op(EFA_RECV_BYTES, "recv_bytes") \
+	op(EFA_RECV_WRS, "recv_wrs") \
+	op(EFA_RDMA_READ_WRS, "rdma_read_wrs") \
+	op(EFA_RDMA_READ_BYTES, "rdma_read_bytes") \
+	op(EFA_RDMA_READ_WR_ERR, "rdma_read_wr_err") \
+	op(EFA_RDMA_READ_RESP_BYTES, "rdma_read_resp_bytes") \
 	op(EFA_SUBMITTED_CMDS, "submitted_cmds") \
 	op(EFA_COMPLETED_CMDS, "completed_cmds") \
 	op(EFA_CMDS_ERR, "cmds_err") \
@@ -1903,13 +1911,15 @@ int efa_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
 	struct efa_com_get_stats_params params = {};
 	union efa_com_get_stats_result result;
 	struct efa_dev *dev = to_edev(ibdev);
+	struct efa_com_rdma_read_stats *rrs;
+	struct efa_com_messages_stats *ms;
 	struct efa_com_basic_stats *bs;
 	struct efa_com_stats_admin *as;
 	struct efa_stats *s;
 	int err;
 
-	params.type = EFA_ADMIN_GET_STATS_TYPE_BASIC;
 	params.scope = EFA_ADMIN_GET_STATS_SCOPE_ALL;
+	params.type = EFA_ADMIN_GET_STATS_TYPE_BASIC;
 
 	err = efa_com_get_stats(&dev->edev, &params, &result);
 	if (err)
@@ -1922,6 +1932,28 @@ int efa_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
 	stats->value[EFA_RX_PKTS] = bs->rx_pkts;
 	stats->value[EFA_RX_DROPS] = bs->rx_drops;
 
+	params.type = EFA_ADMIN_GET_STATS_TYPE_MESSAGES;
+	err = efa_com_get_stats(&dev->edev, &params, &result);
+	if (err)
+		return err;
+
+	ms = &result.messages_stats;
+	stats->value[EFA_SEND_BYTES] = ms->send_bytes;
+	stats->value[EFA_SEND_WRS] = ms->send_wrs;
+	stats->value[EFA_RECV_BYTES] = ms->recv_bytes;
+	stats->value[EFA_RECV_WRS] = ms->recv_wrs;
+
+	params.type = EFA_ADMIN_GET_STATS_TYPE_RDMA_READ;
+	err = efa_com_get_stats(&dev->edev, &params, &result);
+	if (err)
+		return err;
+
+	rrs = &result.rdma_read_stats;
+	stats->value[EFA_RDMA_READ_WRS] = rrs->read_wrs;
+	stats->value[EFA_RDMA_READ_BYTES] = rrs->read_bytes;
+	stats->value[EFA_RDMA_READ_WR_ERR] = rrs->read_wr_err;
+	stats->value[EFA_RDMA_READ_RESP_BYTES] = rrs->read_resp_bytes;
+
 	as = &dev->edev.aq.stats;
 	stats->value[EFA_SUBMITTED_CMDS] = atomic64_read(&as->submitted_cmd);
 	stats->value[EFA_COMPLETED_CMDS] = atomic64_read(&as->completed_cmd);
-- 
2.28.0

