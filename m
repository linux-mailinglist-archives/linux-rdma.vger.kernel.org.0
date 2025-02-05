Return-Path: <linux-rdma+bounces-7426-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE2EA2881E
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 11:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2DB18880A0
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 10:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E66D22B590;
	Wed,  5 Feb 2025 10:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HKvBCvOE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867A322A805;
	Wed,  5 Feb 2025 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738751723; cv=none; b=Qy5g2NtFeghS+Q+eDIg6vgzB305md7ozeeCf/elB1DH6le8Yfrc2QxgO4x/wvwlMmiZsa5MqkhQsh2d9MApzbVuiGnuhyp54t3PdAGWtP0LfjFrqxYL29GHYdeDlXi784ygFe4mkeuK65VSLd1/NWynzwAQIBGWswmkYKvOdc3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738751723; c=relaxed/simple;
	bh=lSw4UWDH8iSi65xYKCTk15tuoPTtKNBGDKT4Pmf5p24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GyGQgp/tc2aKMhpqXgANL8EZ73PfzsUyR0iqLPPNfF3+KcxtIiM97oN2zD0Inidi/yrUpkEU0/H2ZE6Ve5UzqC2IyHYIKDCfTNtDQN/YFX8mzFHaCspIpn3NSQ9oAztWfLdMdNlZK2vhMXsyuehY2OiIimj5yttbW71LKNe5uvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HKvBCvOE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1EF34203F58C;
	Wed,  5 Feb 2025 02:35:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1EF34203F58C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738751722;
	bh=C7/UEa9VKEJtG/t/pEwk9Ij8oxWe+D6imt/kWE7BFxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HKvBCvOEojZ6o1St9XqEBvtw5BO6dsYKd2sF7jUzuzpULovJTVGU5gPTUclCseoh6
	 xp4PaLvVa6oLn6B+XXIKniyGhg5Q/JFp8bjOx/aS+YucxwMXm9Doyewp1euAL1b6L7
	 qoi5bklDrCr9igLkZ0dGV69xUasODoraZ6qzd23w=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/2] RDMA/mana_ib: Query feature_flags bitmask from FW
Date: Wed,  5 Feb 2025 02:35:12 -0800
Message-Id: <1738751713-16169-2-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738751713-16169-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1738751713-16169-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Shiraz Saleem <shirazsaleem@microsoft.com>

Extend the mana_ib_gd_query_adapter_caps function to retrieve and store
the feature_flags from the firmware response.

Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c    | 3 ++-
 drivers/infiniband/hw/mana/mana_ib.h | 2 ++
 include/net/mana/gdma.h              | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index ae1fb69..3d4b8e2 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -665,7 +665,7 @@ int mana_ib_gd_query_adapter_caps(struct mana_ib_dev *dev)
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_GET_ADAPTER_CAP, sizeof(req),
 			     sizeof(resp));
-	req.hdr.resp.msg_version = GDMA_MESSAGE_V3;
+	req.hdr.resp.msg_version = GDMA_MESSAGE_V4;
 	req.hdr.dev_id = dev->gdma_dev->dev_id;
 
 	err = mana_gd_send_request(mdev_to_gc(dev), sizeof(req),
@@ -694,6 +694,7 @@ int mana_ib_gd_query_adapter_caps(struct mana_ib_dev *dev)
 	caps->max_inline_data_size = resp.max_inline_data_size;
 	caps->max_send_sge_count = resp.max_send_sge_count;
 	caps->max_recv_sge_count = resp.max_recv_sge_count;
+	caps->feature_flags = resp.feature_flags;
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index cd771af..baaeef0 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -58,6 +58,7 @@ struct mana_ib_adapter_caps {
 	u32 max_send_sge_count;
 	u32 max_recv_sge_count;
 	u32 max_inline_data_size;
+	u64 feature_flags;
 };
 
 struct mana_ib_queue {
@@ -230,6 +231,7 @@ struct mana_ib_query_adapter_caps_resp {
 	u32 max_send_sge_count;
 	u32 max_recv_sge_count;
 	u32 max_inline_data_size;
+	u64 feature_flags;
 }; /* HW Data */
 
 struct mana_rnic_create_adapter_req {
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index a94b04e..50ffbc4 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -152,6 +152,7 @@ struct gdma_general_req {
 #define GDMA_MESSAGE_V1 1
 #define GDMA_MESSAGE_V2 2
 #define GDMA_MESSAGE_V3 3
+#define GDMA_MESSAGE_V4 4
 
 struct gdma_general_resp {
 	struct gdma_resp_hdr hdr;
-- 
2.43.0


