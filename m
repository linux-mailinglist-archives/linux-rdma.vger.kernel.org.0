Return-Path: <linux-rdma+bounces-5608-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 436E49B5ED7
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 10:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8141C210CD
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 09:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57FC1D356C;
	Wed, 30 Oct 2024 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cSQwSCZM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7632654BD4
	for <linux-rdma@vger.kernel.org>; Wed, 30 Oct 2024 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730280615; cv=none; b=G7TX/BSLAmIHpaBw3U3cDMl9Hjq1VJ1NSBnn52RkAsnqVnZfxaJm6akilb0vh9bQWSbHsiWsAMl880guGoz9OmP3mZJzKc8Zbqeu8W+Fcg+QxxXZV8q7F4rWezQshONQx0LfzXfMwJTWbZKrXDBtYY0dzanLbBKQnVu231+fE1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730280615; c=relaxed/simple;
	bh=NXIsnsTo/TMz0NoEFJO7wfu0fiKftYfpMrzFuEGbwFI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J8OmqT+9XrAk56OiRr8FcFREcZVCZgv/e+5deCSIzNRbjcFUbgX249eVeQ1cNpPHlIgpO3i7s5EGHWBkHZlnVlWxSaRtVKXVrTjVaTP7HTWAKvLMWgs+tgkc5/Q/DCZh974Hrve/sA1kICyhL31Gvk0gWBOl7QHaGjdwMRkhmUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cSQwSCZM; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730280613; x=1761816613;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ElWfAj6aESMLSaLBkYVxPy0Ox/hHP86OM4iPb7SzFj4=;
  b=cSQwSCZMn6itsi9aPd3td9XufwFdA0ztzzmFGM14LOXERplGSXWPXZv/
   i2e/5QaOxOJxlcB8LqHuwkGJM3kD/bAPsYt8pkHif0EkLYh3BfqtHOqrn
   pm4KMVALOEAt+T9VJ0oHYdQV8OdNidi//5QwZ5iOSsJiwr5KyZNGM5Sf9
   I=;
X-IronPort-AV: E=Sophos;i="6.11,244,1725321600"; 
   d="scan'208";a="243450417"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 09:30:11 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:20665]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.37.115:2525] with esmtp (Farcaster)
 id 62563341-c710-4662-9d6d-1ac014772e97; Wed, 30 Oct 2024 09:30:10 +0000 (UTC)
X-Farcaster-Flow-ID: 62563341-c710-4662-9d6d-1ac014772e97
Received: from EX19D013EUA001.ant.amazon.com (10.252.50.140) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 30 Oct 2024 09:30:09 +0000
Received: from EX19MTAUEB002.ant.amazon.com (10.252.135.47) by
 EX19D013EUA001.ant.amazon.com (10.252.50.140) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 30 Oct 2024 09:30:09 +0000
Received: from email-imr-corp-prod-pdx-all-2b-5ec155c2.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Wed, 30 Oct 2024 09:30:09 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com (dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com [10.253.103.172])
	by email-imr-corp-prod-pdx-all-2b-5ec155c2.us-west-2.amazon.com (Postfix) with ESMTP id 768FF42133;
	Wed, 30 Oct 2024 09:30:07 +0000 (UTC)
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Daniel
 Kranzdorf" <dkkranzd@amazon.com>, Firas Jahjah <firasj@amazon.com>
Subject: [PATCH for-next] RDMA/efa: Report link speed according to device attributes
Date: Wed, 30 Oct 2024 09:30:06 +0000
Message-ID: <20241030093006.21352-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Set port link speed and width based on max bandwidth acquired from the
device instead of using constant 100 Gbps. Use a default value in case
the device didn't set the field.

Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Reviewed-by: Firas Jahjah <firasj@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 .../infiniband/hw/efa/efa_admin_cmds_defs.h   |  9 ++++
 drivers/infiniband/hw/efa/efa_com_cmd.c       |  1 +
 drivers/infiniband/hw/efa/efa_com_cmd.h       |  1 +
 drivers/infiniband/hw/efa/efa_verbs.c         | 45 ++++++++++++++++++-
 4 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index 88a9aee7e743..fe0b6aec7839 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -718,6 +718,15 @@ struct efa_admin_feature_device_attr_desc {
 
 	/* Unique global ID for an EFA device */
 	u64 guid;
+
+	/* The device maximum link speed in Gbit/sec */
+	u16 max_link_speed_gbps;
+
+	/* MBZ */
+	u16 reserved0;
+
+	/* MBZ */
+	u32 reserved1;
 };
 
 struct efa_admin_feature_queue_attr_desc {
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index 9e04edb9dbda..c6b89c45fdc9 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -467,6 +467,7 @@ int efa_com_get_device_attr(struct efa_com_dev *edev,
 	result->max_rdma_size = resp.u.device_attr.max_rdma_size;
 	result->device_caps = resp.u.device_attr.device_caps;
 	result->guid = resp.u.device_attr.guid;
+	result->max_link_speed_gbps = resp.u.device_attr.max_link_speed_gbps;
 
 	if (result->admin_api_version < 1) {
 		ibdev_err_ratelimited(
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
index 25f02c0d9698..5511355b700d 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.h
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
@@ -142,6 +142,7 @@ struct efa_com_get_device_attr_result {
 	u16 max_wr_rdma_sge;
 	u16 max_tx_batch;
 	u16 min_sq_depth;
+	u16 max_link_speed_gbps;
 	u8 db_bar;
 };
 
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index ca3af866a5df..a8645a40730f 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -85,6 +85,8 @@ static const struct rdma_stat_desc efa_port_stats_descs[] = {
 	EFA_DEFINE_PORT_STATS(EFA_STATS_STR)
 };
 
+#define EFA_DEFAULT_LINK_SPEED_GBPS   100
+
 #define EFA_CHUNK_PAYLOAD_SHIFT       12
 #define EFA_CHUNK_PAYLOAD_SIZE        BIT(EFA_CHUNK_PAYLOAD_SHIFT)
 #define EFA_CHUNK_PAYLOAD_PTR_SIZE    8
@@ -277,10 +279,47 @@ int efa_query_device(struct ib_device *ibdev,
 	return 0;
 }
 
+static void efa_link_gbps_to_speed_and_width(u16 gbps,
+					     enum ib_port_speed *speed,
+					     enum ib_port_width *width)
+{
+	if (gbps >= 400) {
+		*width = IB_WIDTH_8X;
+		*speed = IB_SPEED_HDR;
+	} else if (gbps >= 200) {
+		*width = IB_WIDTH_4X;
+		*speed = IB_SPEED_HDR;
+	} else if (gbps >= 120) {
+		*width = IB_WIDTH_12X;
+		*speed = IB_SPEED_FDR10;
+	} else if (gbps >= 100) {
+		*width = IB_WIDTH_4X;
+		*speed = IB_SPEED_EDR;
+	} else if (gbps >= 60) {
+		*width = IB_WIDTH_12X;
+		*speed = IB_SPEED_DDR;
+	} else if (gbps >= 50) {
+		*width = IB_WIDTH_1X;
+		*speed = IB_SPEED_HDR;
+	} else if (gbps >= 40) {
+		*width = IB_WIDTH_4X;
+		*speed = IB_SPEED_FDR10;
+	} else if (gbps >= 30) {
+		*width = IB_WIDTH_12X;
+		*speed = IB_SPEED_SDR;
+	} else {
+		*width = IB_WIDTH_1X;
+		*speed = IB_SPEED_EDR;
+	}
+}
+
 int efa_query_port(struct ib_device *ibdev, u32 port,
 		   struct ib_port_attr *props)
 {
 	struct efa_dev *dev = to_edev(ibdev);
+	enum ib_port_speed link_speed;
+	enum ib_port_width link_width;
+	u16 link_gbps;
 
 	props->lmc = 1;
 
@@ -288,8 +327,10 @@ int efa_query_port(struct ib_device *ibdev, u32 port,
 	props->phys_state = IB_PORT_PHYS_STATE_LINK_UP;
 	props->gid_tbl_len = 1;
 	props->pkey_tbl_len = 1;
-	props->active_speed = IB_SPEED_EDR;
-	props->active_width = IB_WIDTH_4X;
+	link_gbps = dev->dev_attr.max_link_speed_gbps ?: EFA_DEFAULT_LINK_SPEED_GBPS;
+	efa_link_gbps_to_speed_and_width(link_gbps, &link_speed, &link_width);
+	props->active_speed = link_speed;
+	props->active_width = link_width;
 	props->max_mtu = ib_mtu_int_to_enum(dev->dev_attr.mtu);
 	props->active_mtu = ib_mtu_int_to_enum(dev->dev_attr.mtu);
 	props->max_msg_sz = dev->dev_attr.mtu;
-- 
2.40.1


