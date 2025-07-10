Return-Path: <linux-rdma+bounces-12032-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8EDAFFF51
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 12:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA57A7BEA0F
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 10:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEC32D8DDC;
	Thu, 10 Jul 2025 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j4Ax0g4K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F20B2D877E;
	Thu, 10 Jul 2025 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143397; cv=none; b=YeKwAsIfZHf6u6CPXVqFFMNzMGJvDaEH8zKDLLR79x2dZxfDtRyXhvcmoiYr2101RwtWDz60RBKjpwch9STnK7wE+0CgySkesz5yUXDRHLg4flswozVqaw9asBk1YUi89UqzGZdxcCWxSMZkXbSwH5G9dHWBVBtC/GkRZP8QdEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143397; c=relaxed/simple;
	bh=kNj4q4Pl/Mw5FwKejCBifWxAHj7KBA2jTR+vCAm8jTE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=XQ6HgS0U4qgn2Q19S8S7BUMpWEzb1zY0+zDKVkZj9rzb86QRLWZ9NW+nwFhr29r+f5SoKs4IexdqIH862mQ4YpzABDwCVNcTTvau3uPvvhAHgpmbirC1EYRVSiorgZAm5zvcjyiekmvjTPREpPRq6nMZXLhb12MY86DQroZx+Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j4Ax0g4K; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id BC0872016571; Thu, 10 Jul 2025 03:29:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BC0872016571
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752143395;
	bh=Od0E656iepPf3Vw4kzLjK8LKuTKlY+/mkRehGg6GqMo=;
	h=From:To:Cc:Subject:Date:From;
	b=j4Ax0g4KTdNk5hrfqUsliwTUfqbQ6xkRrYigCcXUeSjBTK8DTInhQD+iY4HOmMwCO
	 PJhChDdSEdbBCHIn3MUSTCpMB/YFT9+tEsp1iSha3314oInJ6oYd/YeoqGIMb2NwV4
	 czIPRp9fm0zZTuTFhPKPVPxw86yv1vsxSNBYb4X8=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	zhiyueqiu@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: add additional port counters
Date: Thu, 10 Jul 2025 03:29:55 -0700
Message-Id: <1752143395-5324-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Zhiyue Qiu <zhiyueqiu@microsoft.com>

Add packet and request port counters to mana_ib.

Signed-off-by: Zhiyue Qiu <zhiyueqiu@microsoft.com>
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/counters.c | 18 ++++++++++++++++++
 drivers/infiniband/hw/mana/counters.h |  8 ++++++++
 drivers/infiniband/hw/mana/mana_ib.h  |  8 ++++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/infiniband/hw/mana/counters.c b/drivers/infiniband/hw/mana/counters.c
index 6a81365..e964e74 100644
--- a/drivers/infiniband/hw/mana/counters.c
+++ b/drivers/infiniband/hw/mana/counters.c
@@ -32,6 +32,14 @@
 	[MANA_IB_RATE_INC_EVENTS].name = "rate_inc_events",
 	[MANA_IB_NUM_QPS_RECOVERED].name = "num_qps_recovered",
 	[MANA_IB_CURRENT_RATE].name = "current_rate",
+	[MANA_IB_DUP_RX_REQ].name = "dup_rx_requests",
+	[MANA_IB_TX_BYTES].name = "tx_bytes",
+	[MANA_IB_RX_BYTES].name = "rx_bytes",
+	[MANA_IB_RX_SEND_REQ].name = "rx_send_requests",
+	[MANA_IB_RX_WRITE_REQ].name = "rx_write_requests",
+	[MANA_IB_RX_READ_REQ].name = "rx_read_requests",
+	[MANA_IB_TX_PKT].name = "tx_packets",
+	[MANA_IB_RX_PKT].name = "rx_packets",
 };
 
 static const struct rdma_stat_desc mana_ib_device_stats_desc[] = {
@@ -100,6 +108,7 @@ static int mana_ib_get_hw_port_stats(struct ib_device *ibdev, struct rdma_hw_sta
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_QUERY_VF_COUNTERS,
 			     sizeof(req), sizeof(resp));
+	req.hdr.resp.msg_version = GDMA_MESSAGE_V2;
 	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.adapter = mdev->adapter_handle;
 
@@ -148,6 +157,15 @@ static int mana_ib_get_hw_port_stats(struct ib_device *ibdev, struct rdma_hw_sta
 	stats->value[MANA_IB_NUM_QPS_RECOVERED] = resp.num_qps_recovered;
 	stats->value[MANA_IB_CURRENT_RATE] = resp.current_rate;
 
+	stats->value[MANA_IB_DUP_RX_REQ] = resp.dup_rx_req;
+	stats->value[MANA_IB_TX_BYTES] = resp.tx_bytes;
+	stats->value[MANA_IB_RX_BYTES] = resp.rx_bytes;
+	stats->value[MANA_IB_RX_SEND_REQ] = resp.rx_send_req;
+	stats->value[MANA_IB_RX_WRITE_REQ] = resp.rx_write_req;
+	stats->value[MANA_IB_RX_READ_REQ] = resp.rx_read_req;
+	stats->value[MANA_IB_TX_PKT] = resp.tx_pkt;
+	stats->value[MANA_IB_RX_PKT] = resp.rx_pkt;
+
 	return ARRAY_SIZE(mana_ib_port_stats_desc);
 }
 
diff --git a/drivers/infiniband/hw/mana/counters.h b/drivers/infiniband/hw/mana/counters.h
index 987a6fe..f68e776 100644
--- a/drivers/infiniband/hw/mana/counters.h
+++ b/drivers/infiniband/hw/mana/counters.h
@@ -35,6 +35,14 @@ enum mana_ib_port_counters {
 	MANA_IB_RATE_INC_EVENTS,
 	MANA_IB_NUM_QPS_RECOVERED,
 	MANA_IB_CURRENT_RATE,
+	MANA_IB_DUP_RX_REQ,
+	MANA_IB_TX_BYTES,
+	MANA_IB_RX_BYTES,
+	MANA_IB_RX_SEND_REQ,
+	MANA_IB_RX_WRITE_REQ,
+	MANA_IB_RX_READ_REQ,
+	MANA_IB_TX_PKT,
+	MANA_IB_RX_PKT,
 };
 
 enum mana_ib_device_counters {
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index eddd0a8..369825f 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -516,6 +516,14 @@ struct mana_rnic_query_vf_cntrs_resp {
 	u64 rate_inc_events;
 	u64 num_qps_recovered;
 	u64 current_rate;
+	u64 dup_rx_req;
+	u64 tx_bytes;
+	u64 rx_bytes;
+	u64 rx_send_req;
+	u64 rx_write_req;
+	u64 rx_read_req;
+	u64 tx_pkt;
+	u64 rx_pkt;
 }; /* HW Data */
 
 struct mana_rnic_query_device_cntrs_req {
-- 
1.8.3.1


