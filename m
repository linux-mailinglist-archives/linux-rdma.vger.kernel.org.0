Return-Path: <linux-rdma+bounces-11133-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AABCEAD3790
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 14:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB3318856EF
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 12:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7522D193A;
	Tue, 10 Jun 2025 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CFuxgRQB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8F72D191E;
	Tue, 10 Jun 2025 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559724; cv=none; b=M6N7B6zpTkMbKNovLDo5BLVZKLY5/tWbj9KkdCFeqCpu0mKx4YpTkJXvTt2VegL1MW+IyES2l8Uv4nxbUZExtLOz9UcgBVDQI5rSY5/+aNeSf8ZkEpQANwGC+CBoVwQbt87mN9y6PUEOUpbQuoSA5ishDNjWgPdRm4e04iZFHto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559724; c=relaxed/simple;
	bh=H38PEnqYX1zBonTD6z/k7CR//vjPX5WNAMviV5TZQV0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=IsMqyZTM2w1ol1Duj4abfs1g0PWDFK1fDKq9CsT3V0XkQ19uS2LyVR9dXAkqDqVySXvSeOld7Br0CPMf0FG0L+Yjnk+cMFBGdPSeBrQozIb4mcMWP9R2G2FBtSw5pBs3nYeS/YUSRDtAn5bQa8NJelVepMQgN7hwqp/sVpap3RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CFuxgRQB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id 55BB52113A7A; Tue, 10 Jun 2025 05:48:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 55BB52113A7A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749559717;
	bh=GvhzL3BwnlGLWPOctudhuUlIMzOARt1SSLltYeve8Kc=;
	h=From:To:Cc:Subject:Date:From;
	b=CFuxgRQB6utcdgeMX4BoS6VFwWNMevdGHK/73JPyPcHLGs9Ng128Rz+KOM7w/nj/o
	 rVIr1v5t/deSvsqrQqkyGnBqFwVvczCf+g9RVd9Zi674HkvOaru46Jr4KQy/eKu2Kv
	 fQCCUTbOZafyGJ3ToAZRhbxVnzMBT5kzh1b8+qWI=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: Add device statistics support
Date: Tue, 10 Jun 2025 05:48:37 -0700
Message-Id: <1749559717-3424-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Shiraz Saleem <shirazsaleem@microsoft.com>

Add support for mana device level statistics.

Co-developed-by: Solom Tamawy <solom.tamawy@microsoft.com>
Signed-off-by: Solom Tamawy <solom.tamawy@microsoft.com>
Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/counters.c | 60 ++++++++++++++++++++++++++-
 drivers/infiniband/hw/mana/counters.h | 10 +++++
 drivers/infiniband/hw/mana/device.c   |  6 +++
 drivers/infiniband/hw/mana/mana_ib.h  | 19 +++++++++
 4 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mana/counters.c b/drivers/infiniband/hw/mana/counters.c
index e533ce2..6a81365 100644
--- a/drivers/infiniband/hw/mana/counters.c
+++ b/drivers/infiniband/hw/mana/counters.c
@@ -34,6 +34,22 @@ static const struct rdma_stat_desc mana_ib_port_stats_desc[] = {
 	[MANA_IB_CURRENT_RATE].name = "current_rate",
 };
 
+static const struct rdma_stat_desc mana_ib_device_stats_desc[] = {
+	[MANA_IB_SENT_CNPS].name = "sent_cnps",
+	[MANA_IB_RECEIVED_ECNS].name = "received_ecns",
+	[MANA_IB_RECEIVED_CNP_COUNT].name = "received_cnp_count",
+	[MANA_IB_QP_CONGESTED_EVENTS].name = "qp_congested_events",
+	[MANA_IB_QP_RECOVERED_EVENTS].name = "qp_recovered_events",
+	[MANA_IB_DEV_RATE_INC_EVENTS].name = "rate_inc_events",
+};
+
+struct rdma_hw_stats *mana_ib_alloc_hw_device_stats(struct ib_device *ibdev)
+{
+	return rdma_alloc_hw_stats_struct(mana_ib_device_stats_desc,
+					  ARRAY_SIZE(mana_ib_device_stats_desc),
+					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
+}
+
 struct rdma_hw_stats *mana_ib_alloc_hw_port_stats(struct ib_device *ibdev,
 						  u32 port_num)
 {
@@ -42,8 +58,39 @@ struct rdma_hw_stats *mana_ib_alloc_hw_port_stats(struct ib_device *ibdev,
 					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
 }
 
-int mana_ib_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
-			 u32 port_num, int index)
+static int mana_ib_get_hw_device_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats)
+{
+	struct mana_ib_dev *mdev = container_of(ibdev, struct mana_ib_dev,
+						ib_dev);
+	struct mana_rnic_query_device_cntrs_resp resp = {};
+	struct mana_rnic_query_device_cntrs_req req = {};
+	int err;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_IB_QUERY_DEVICE_COUNTERS,
+			     sizeof(req), sizeof(resp));
+	req.hdr.dev_id = mdev->gdma_dev->dev_id;
+	req.adapter = mdev->adapter_handle;
+
+	err = mana_gd_send_request(mdev_to_gc(mdev), sizeof(req), &req,
+				   sizeof(resp), &resp);
+	if (err) {
+		ibdev_err(&mdev->ib_dev, "Failed to query device counters err %d",
+			  err);
+		return err;
+	}
+
+	stats->value[MANA_IB_SENT_CNPS] = resp.sent_cnps;
+	stats->value[MANA_IB_RECEIVED_ECNS] = resp.received_ecns;
+	stats->value[MANA_IB_RECEIVED_CNP_COUNT] = resp.received_cnp_count;
+	stats->value[MANA_IB_QP_CONGESTED_EVENTS] = resp.qp_congested_events;
+	stats->value[MANA_IB_QP_RECOVERED_EVENTS] = resp.qp_recovered_events;
+	stats->value[MANA_IB_DEV_RATE_INC_EVENTS] = resp.rate_inc_events;
+
+	return ARRAY_SIZE(mana_ib_device_stats_desc);
+}
+
+static int mana_ib_get_hw_port_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
+				     u32 port_num)
 {
 	struct mana_ib_dev *mdev = container_of(ibdev, struct mana_ib_dev,
 						ib_dev);
@@ -103,3 +150,12 @@ int mana_ib_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
 
 	return ARRAY_SIZE(mana_ib_port_stats_desc);
 }
+
+int mana_ib_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
+			 u32 port_num, int index)
+{
+	if (!port_num)
+		return mana_ib_get_hw_device_stats(ibdev, stats);
+	else
+		return mana_ib_get_hw_port_stats(ibdev, stats, port_num);
+}
diff --git a/drivers/infiniband/hw/mana/counters.h b/drivers/infiniband/hw/mana/counters.h
index 7ff92d2..987a6fe 100644
--- a/drivers/infiniband/hw/mana/counters.h
+++ b/drivers/infiniband/hw/mana/counters.h
@@ -37,8 +37,18 @@ enum mana_ib_port_counters {
 	MANA_IB_CURRENT_RATE,
 };
 
+enum mana_ib_device_counters {
+	MANA_IB_SENT_CNPS,
+	MANA_IB_RECEIVED_ECNS,
+	MANA_IB_RECEIVED_CNP_COUNT,
+	MANA_IB_QP_CONGESTED_EVENTS,
+	MANA_IB_QP_RECOVERED_EVENTS,
+	MANA_IB_DEV_RATE_INC_EVENTS,
+};
+
 struct rdma_hw_stats *mana_ib_alloc_hw_port_stats(struct ib_device *ibdev,
 						  u32 port_num);
+struct rdma_hw_stats *mana_ib_alloc_hw_device_stats(struct ib_device *ibdev);
 int mana_ib_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
 			 u32 port_num, int index);
 #endif /* _COUNTERS_H_ */
diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 165c0a1..65d0af7 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -65,6 +65,10 @@ static const struct ib_device_ops mana_ib_stats_ops = {
 	.get_hw_stats = mana_ib_get_hw_stats,
 };
 
+static const struct ib_device_ops mana_ib_device_stats_ops = {
+	.alloc_hw_device_stats = mana_ib_alloc_hw_device_stats,
+};
+
 static int mana_ib_netdev_event(struct notifier_block *this,
 				unsigned long event, void *ptr)
 {
@@ -153,6 +157,8 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 		}
 
 		ib_set_device_ops(&dev->ib_dev, &mana_ib_stats_ops);
+		if (dev->adapter_caps.feature_flags & MANA_IB_FEATURE_DEV_COUNTERS_SUPPORT)
+			ib_set_device_ops(&dev->ib_dev, &mana_ib_device_stats_ops);
 
 		ret = mana_ib_create_eqs(dev);
 		if (ret) {
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 42bebd6..eddd0a8 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -210,6 +210,7 @@ enum mana_ib_command_code {
 	MANA_IB_DESTROY_RC_QP   = 0x3000b,
 	MANA_IB_SET_QP_STATE	= 0x3000d,
 	MANA_IB_QUERY_VF_COUNTERS = 0x30022,
+	MANA_IB_QUERY_DEVICE_COUNTERS = 0x30023,
 };
 
 struct mana_ib_query_adapter_caps_req {
@@ -218,6 +219,7 @@ struct mana_ib_query_adapter_caps_req {
 
 enum mana_ib_adapter_features {
 	MANA_IB_FEATURE_CLIENT_ERROR_CQE_SUPPORT = BIT(4),
+	MANA_IB_FEATURE_DEV_COUNTERS_SUPPORT = BIT(5),
 };
 
 struct mana_ib_query_adapter_caps_resp {
@@ -516,6 +518,23 @@ struct mana_rnic_query_vf_cntrs_resp {
 	u64 current_rate;
 }; /* HW Data */
 
+struct mana_rnic_query_device_cntrs_req {
+	struct gdma_req_hdr hdr;
+	mana_handle_t adapter;
+}; /* HW Data */
+
+struct mana_rnic_query_device_cntrs_resp {
+	struct gdma_resp_hdr hdr;
+	u32 sent_cnps;
+	u32 received_ecns;
+	u32 reserved1;
+	u32 received_cnp_count;
+	u32 qp_congested_events;
+	u32 qp_recovered_events;
+	u32 rate_inc_events;
+	u32 reserved2;
+}; /* HW Data */
+
 static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev *mdev)
 {
 	return mdev->gdma_dev->gdma_context;
-- 
2.43.0


