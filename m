Return-Path: <linux-rdma+bounces-7424-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1ABA28814
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 11:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80323A7D68
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 10:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7964F22A805;
	Wed,  5 Feb 2025 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KvhsXj1J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A96A2063D8;
	Wed,  5 Feb 2025 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738751534; cv=none; b=I9GtQoaSXRPDGXNg8CzcZr0mSjfj9uJMM21fgh8sJnkQeTbgmJFwwGazMHQvlretu2earSGwIwwWjiSSecSGMcZFiH+qyT8J+0sdUuOM114f5oneoIKp6KcyyvVB49830vx+l2iY0jKHa96reNzJWpmb+znK0rse+0YjKj5hNpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738751534; c=relaxed/simple;
	bh=8wp1OPYQGw6FomN5MXEl7gFqhfeHV6yuD89+xS+3Btc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=pguvxNHzWVN/x8Rg4ExB9mHkSSbgjIgsSvSRWvzgm0Viz/f2nXcltpz4UTeOaV+ZCw/+f8G4lIHtMBlju2WtwMNbpCttuQARKZVtvv4FRAAobjfHzxPkDoNA/LRnozzIfJJtS0ff1pLwYoh91zDzJ03w9WY3IToWv76K+ozH48A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KvhsXj1J; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 35070203F5BB;
	Wed,  5 Feb 2025 02:32:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 35070203F5BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738751532;
	bh=zx/u/PCgx533qIb4W1cQPLwrqpmaoYrSRIXXdjph2zo=;
	h=From:To:Cc:Subject:Date:From;
	b=KvhsXj1JSgY/J97hZ+fMCRk+ikAc2v0XugllaQTUTIl1dtE0WCLPtS3tY58ScT4Tv
	 UI4cr9nsrkirHjn/rUmLyJ1V8RWCc33H2nEnF7Og3HGiDU7t/194qrSUxgaR+wFBaW
	 Do5qjIdu4QwQKESHWMTmsJPoPZiR1wRHRsHhTWRY=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: Add port statistics support
Date: Wed,  5 Feb 2025 02:32:07 -0800
Message-Id: <1738751527-15517-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Shiraz Saleem <shirazsaleem@microsoft.com>

Implement alloc_hw_port_stats and get_hw_stats APIs to support querying
MANA VF port level statistics from rdma stat tool.

Example output from rdma stat tool:

$rdma statistic show link mana_0/1 -p
link mana_0/1
    requester_timeout 45
    requester_oos_nak 0
    requester_rnr_nak 0
    responder_rnr_nak 0
    responder_oos 0
    responder_dup_request 0
    requester_implicit_nak 0
    requester_readresp_psn_mismatch 0
    nak_inv_req 0
    nak_access_error 0
    nak_opp_error 0
    nak_inv_read 0
    responder_local_len_error 0
    requestor_local_prot_error 0
    responder_rem_access_error 0
    responder_local_qp_error 0
    responder_malformed_wqe 0
    general_hw_error 6
    requester_rnr_nak_retries_exceeded 0
    requester_retries_exceeded 5
    total_fatal_error 6
    received_cnps 0
    num_qps_congested 0
    rate_inc_events 0
    num_qps_recovered 0
    current_rate 100000

Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/Makefile   |   2 +-
 drivers/infiniband/hw/mana/counters.c | 105 ++++++++++++++++++++++++++
 drivers/infiniband/hw/mana/counters.h |  44 +++++++++++
 drivers/infiniband/hw/mana/device.c   |   7 ++
 drivers/infiniband/hw/mana/mana_ib.h  |  61 ++++++++++++---
 5 files changed, 206 insertions(+), 13 deletions(-)
 create mode 100644 drivers/infiniband/hw/mana/counters.c
 create mode 100644 drivers/infiniband/hw/mana/counters.h

diff --git a/drivers/infiniband/hw/mana/Makefile b/drivers/infiniband/hw/mana/Makefile
index 79426e7..921c05e 100644
--- a/drivers/infiniband/hw/mana/Makefile
+++ b/drivers/infiniband/hw/mana/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_MANA_INFINIBAND) += mana_ib.o
 
-mana_ib-y := device.o main.o wq.o qp.o cq.o mr.o ah.o wr.o
+mana_ib-y := device.o main.o wq.o qp.o cq.o mr.o ah.o wr.o counters.o
diff --git a/drivers/infiniband/hw/mana/counters.c b/drivers/infiniband/hw/mana/counters.c
new file mode 100644
index 0000000..e533ce2
--- /dev/null
+++ b/drivers/infiniband/hw/mana/counters.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, Microsoft Corporation. All rights reserved.
+ */
+
+#include "counters.h"
+
+static const struct rdma_stat_desc mana_ib_port_stats_desc[] = {
+	[MANA_IB_REQUESTER_TIMEOUT].name = "requester_timeout",
+	[MANA_IB_REQUESTER_OOS_NAK].name = "requester_oos_nak",
+	[MANA_IB_REQUESTER_RNR_NAK].name = "requester_rnr_nak",
+	[MANA_IB_RESPONDER_RNR_NAK].name = "responder_rnr_nak",
+	[MANA_IB_RESPONDER_OOS].name = "responder_oos",
+	[MANA_IB_RESPONDER_DUP_REQUEST].name = "responder_dup_request",
+	[MANA_IB_REQUESTER_IMPLICIT_NAK].name = "requester_implicit_nak",
+	[MANA_IB_REQUESTER_READRESP_PSN_MISMATCH].name = "requester_readresp_psn_mismatch",
+	[MANA_IB_NAK_INV_REQ].name = "nak_inv_req",
+	[MANA_IB_NAK_ACCESS_ERR].name = "nak_access_error",
+	[MANA_IB_NAK_OPP_ERR].name = "nak_opp_error",
+	[MANA_IB_NAK_INV_READ].name = "nak_inv_read",
+	[MANA_IB_RESPONDER_LOCAL_LEN_ERR].name = "responder_local_len_error",
+	[MANA_IB_REQUESTOR_LOCAL_PROT_ERR].name = "requestor_local_prot_error",
+	[MANA_IB_RESPONDER_REM_ACCESS_ERR].name = "responder_rem_access_error",
+	[MANA_IB_RESPONDER_LOCAL_QP_ERR].name = "responder_local_qp_error",
+	[MANA_IB_RESPONDER_MALFORMED_WQE].name = "responder_malformed_wqe",
+	[MANA_IB_GENERAL_HW_ERR].name = "general_hw_error",
+	[MANA_IB_REQUESTER_RNR_NAK_RETRIES_EXCEEDED].name = "requester_rnr_nak_retries_exceeded",
+	[MANA_IB_REQUESTER_RETRIES_EXCEEDED].name = "requester_retries_exceeded",
+	[MANA_IB_TOTAL_FATAL_ERR].name = "total_fatal_error",
+	[MANA_IB_RECEIVED_CNPS].name = "received_cnps",
+	[MANA_IB_NUM_QPS_CONGESTED].name = "num_qps_congested",
+	[MANA_IB_RATE_INC_EVENTS].name = "rate_inc_events",
+	[MANA_IB_NUM_QPS_RECOVERED].name = "num_qps_recovered",
+	[MANA_IB_CURRENT_RATE].name = "current_rate",
+};
+
+struct rdma_hw_stats *mana_ib_alloc_hw_port_stats(struct ib_device *ibdev,
+						  u32 port_num)
+{
+	return rdma_alloc_hw_stats_struct(mana_ib_port_stats_desc,
+					  ARRAY_SIZE(mana_ib_port_stats_desc),
+					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
+}
+
+int mana_ib_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
+			 u32 port_num, int index)
+{
+	struct mana_ib_dev *mdev = container_of(ibdev, struct mana_ib_dev,
+						ib_dev);
+	struct mana_rnic_query_vf_cntrs_resp resp = {};
+	struct mana_rnic_query_vf_cntrs_req req = {};
+	int err;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_IB_QUERY_VF_COUNTERS,
+			     sizeof(req), sizeof(resp));
+	req.hdr.dev_id = mdev->gdma_dev->dev_id;
+	req.adapter = mdev->adapter_handle;
+
+	err = mana_gd_send_request(mdev_to_gc(mdev), sizeof(req), &req,
+				   sizeof(resp), &resp);
+	if (err) {
+		ibdev_err(&mdev->ib_dev, "Failed to query vf counters err %d",
+			  err);
+		return err;
+	}
+
+	stats->value[MANA_IB_REQUESTER_TIMEOUT] = resp.requester_timeout;
+	stats->value[MANA_IB_REQUESTER_OOS_NAK] = resp.requester_oos_nak;
+	stats->value[MANA_IB_REQUESTER_RNR_NAK] = resp.requester_rnr_nak;
+	stats->value[MANA_IB_RESPONDER_RNR_NAK] = resp.responder_rnr_nak;
+	stats->value[MANA_IB_RESPONDER_OOS] = resp.responder_oos;
+	stats->value[MANA_IB_RESPONDER_DUP_REQUEST] = resp.responder_dup_request;
+	stats->value[MANA_IB_REQUESTER_IMPLICIT_NAK] =
+					resp.requester_implicit_nak;
+	stats->value[MANA_IB_REQUESTER_READRESP_PSN_MISMATCH] =
+					resp.requester_readresp_psn_mismatch;
+	stats->value[MANA_IB_NAK_INV_REQ] = resp.nak_inv_req;
+	stats->value[MANA_IB_NAK_ACCESS_ERR] = resp.nak_access_err;
+	stats->value[MANA_IB_NAK_OPP_ERR] = resp.nak_opp_err;
+	stats->value[MANA_IB_NAK_INV_READ] = resp.nak_inv_read;
+	stats->value[MANA_IB_RESPONDER_LOCAL_LEN_ERR] =
+					resp.responder_local_len_err;
+	stats->value[MANA_IB_REQUESTOR_LOCAL_PROT_ERR] =
+					resp.requestor_local_prot_err;
+	stats->value[MANA_IB_RESPONDER_REM_ACCESS_ERR] =
+					resp.responder_rem_access_err;
+	stats->value[MANA_IB_RESPONDER_LOCAL_QP_ERR] =
+					resp.responder_local_qp_err;
+	stats->value[MANA_IB_RESPONDER_MALFORMED_WQE] =
+					resp.responder_malformed_wqe;
+	stats->value[MANA_IB_GENERAL_HW_ERR] = resp.general_hw_err;
+	stats->value[MANA_IB_REQUESTER_RNR_NAK_RETRIES_EXCEEDED] =
+					resp.requester_rnr_nak_retries_exceeded;
+	stats->value[MANA_IB_REQUESTER_RETRIES_EXCEEDED] =
+					resp.requester_retries_exceeded;
+	stats->value[MANA_IB_TOTAL_FATAL_ERR] = resp.total_fatal_err;
+
+	stats->value[MANA_IB_RECEIVED_CNPS] = resp.received_cnps;
+	stats->value[MANA_IB_NUM_QPS_CONGESTED] = resp.num_qps_congested;
+	stats->value[MANA_IB_RATE_INC_EVENTS] = resp.rate_inc_events;
+	stats->value[MANA_IB_NUM_QPS_RECOVERED] = resp.num_qps_recovered;
+	stats->value[MANA_IB_CURRENT_RATE] = resp.current_rate;
+
+	return ARRAY_SIZE(mana_ib_port_stats_desc);
+}
diff --git a/drivers/infiniband/hw/mana/counters.h b/drivers/infiniband/hw/mana/counters.h
new file mode 100644
index 0000000..7ff92d2
--- /dev/null
+++ b/drivers/infiniband/hw/mana/counters.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024 Microsoft Corporation. All rights reserved.
+ */
+
+#ifndef _COUNTERS_H_
+#define _COUNTERS_H_
+
+#include "mana_ib.h"
+
+enum mana_ib_port_counters {
+	MANA_IB_REQUESTER_TIMEOUT,
+	MANA_IB_REQUESTER_OOS_NAK,
+	MANA_IB_REQUESTER_RNR_NAK,
+	MANA_IB_RESPONDER_RNR_NAK,
+	MANA_IB_RESPONDER_OOS,
+	MANA_IB_RESPONDER_DUP_REQUEST,
+	MANA_IB_REQUESTER_IMPLICIT_NAK,
+	MANA_IB_REQUESTER_READRESP_PSN_MISMATCH,
+	MANA_IB_NAK_INV_REQ,
+	MANA_IB_NAK_ACCESS_ERR,
+	MANA_IB_NAK_OPP_ERR,
+	MANA_IB_NAK_INV_READ,
+	MANA_IB_RESPONDER_LOCAL_LEN_ERR,
+	MANA_IB_REQUESTOR_LOCAL_PROT_ERR,
+	MANA_IB_RESPONDER_REM_ACCESS_ERR,
+	MANA_IB_RESPONDER_LOCAL_QP_ERR,
+	MANA_IB_RESPONDER_MALFORMED_WQE,
+	MANA_IB_GENERAL_HW_ERR,
+	MANA_IB_REQUESTER_RNR_NAK_RETRIES_EXCEEDED,
+	MANA_IB_REQUESTER_RETRIES_EXCEEDED,
+	MANA_IB_TOTAL_FATAL_ERR,
+	MANA_IB_RECEIVED_CNPS,
+	MANA_IB_NUM_QPS_CONGESTED,
+	MANA_IB_RATE_INC_EVENTS,
+	MANA_IB_NUM_QPS_RECOVERED,
+	MANA_IB_CURRENT_RATE,
+};
+
+struct rdma_hw_stats *mana_ib_alloc_hw_port_stats(struct ib_device *ibdev,
+						  u32 port_num);
+int mana_ib_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
+			 u32 port_num, int index);
+#endif /* _COUNTERS_H_ */
diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 97502bc..fd8efc9 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -59,6 +59,11 @@ static const struct ib_device_ops mana_ib_dev_ops = {
 			   ib_ind_table),
 };
 
+static const struct ib_device_ops mana_ib_stats_ops = {
+	.alloc_hw_port_stats = mana_ib_alloc_hw_port_stats,
+	.get_hw_stats = mana_ib_get_hw_stats,
+};
+
 static int mana_ib_probe(struct auxiliary_device *adev,
 			 const struct auxiliary_device_id *id)
 {
@@ -124,6 +129,8 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 		goto deregister_device;
 	}
 
+	ib_set_device_ops(&dev->ib_dev, &mana_ib_stats_ops);
+
 	ret = mana_ib_create_eqs(dev);
 	if (ret) {
 		ibdev_err(&dev->ib_dev, "Failed to create EQs, ret %d", ret);
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index cd771af..4660dab 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -15,6 +15,7 @@
 
 #include <net/mana/mana.h>
 #include "shadow_queue.h"
+#include "counters.h"
 
 #define PAGE_SZ_BM                                                             \
 	(SZ_4K | SZ_8K | SZ_16K | SZ_32K | SZ_64K | SZ_128K | SZ_256K |        \
@@ -192,18 +193,19 @@ struct mana_ib_rwq_ind_table {
 };
 
 enum mana_ib_command_code {
-	MANA_IB_GET_ADAPTER_CAP = 0x30001,
-	MANA_IB_CREATE_ADAPTER  = 0x30002,
-	MANA_IB_DESTROY_ADAPTER = 0x30003,
-	MANA_IB_CONFIG_IP_ADDR	= 0x30004,
-	MANA_IB_CONFIG_MAC_ADDR	= 0x30005,
-	MANA_IB_CREATE_UD_QP	= 0x30006,
-	MANA_IB_DESTROY_UD_QP	= 0x30007,
-	MANA_IB_CREATE_CQ       = 0x30008,
-	MANA_IB_DESTROY_CQ      = 0x30009,
-	MANA_IB_CREATE_RC_QP    = 0x3000a,
-	MANA_IB_DESTROY_RC_QP   = 0x3000b,
-	MANA_IB_SET_QP_STATE	= 0x3000d,
+	MANA_IB_GET_ADAPTER_CAP		= 0x30001,
+	MANA_IB_CREATE_ADAPTER		= 0x30002,
+	MANA_IB_DESTROY_ADAPTER		= 0x30003,
+	MANA_IB_CONFIG_IP_ADDR		= 0x30004,
+	MANA_IB_CONFIG_MAC_ADDR		= 0x30005,
+	MANA_IB_CREATE_UD_QP		= 0x30006,
+	MANA_IB_DESTROY_UD_QP		= 0x30007,
+	MANA_IB_CREATE_CQ		= 0x30008,
+	MANA_IB_DESTROY_CQ		= 0x30009,
+	MANA_IB_CREATE_RC_QP		= 0x3000a,
+	MANA_IB_DESTROY_RC_QP		= 0x3000b,
+	MANA_IB_SET_QP_STATE		= 0x3000d,
+	MANA_IB_QUERY_VF_COUNTERS	= 0x30022,
 };
 
 struct mana_ib_query_adapter_caps_req {
@@ -466,6 +468,41 @@ struct mana_rdma_cqe {
 	};
 }; /* HW DATA */
 
+struct mana_rnic_query_vf_cntrs_req {
+	struct gdma_req_hdr hdr;
+	mana_handle_t adapter;
+}; /* HW Data */
+
+struct mana_rnic_query_vf_cntrs_resp {
+	struct gdma_resp_hdr hdr;
+	u64 requester_timeout;
+	u64 requester_oos_nak;
+	u64 requester_rnr_nak;
+	u64 responder_rnr_nak;
+	u64 responder_oos;
+	u64 responder_dup_request;
+	u64 requester_implicit_nak;
+	u64 requester_readresp_psn_mismatch;
+	u64 nak_inv_req;
+	u64 nak_access_err;
+	u64 nak_opp_err;
+	u64 nak_inv_read;
+	u64 responder_local_len_err;
+	u64 requestor_local_prot_err;
+	u64 responder_rem_access_err;
+	u64 responder_local_qp_err;
+	u64 responder_malformed_wqe;
+	u64 general_hw_err;
+	u64 requester_rnr_nak_retries_exceeded;
+	u64 requester_retries_exceeded;
+	u64 total_fatal_err;
+	u64 received_cnps;
+	u64 num_qps_congested;
+	u64 rate_inc_events;
+	u64 num_qps_recovered;
+	u64 current_rate;
+}; /* HW Data */
+
 static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev *mdev)
 {
 	return mdev->gdma_dev->gdma_context;
-- 
2.43.0


