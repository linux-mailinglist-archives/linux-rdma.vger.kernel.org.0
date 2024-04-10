Return-Path: <linux-rdma+bounces-1886-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A89B889EDDC
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Apr 2024 10:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 369B7B218A8
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Apr 2024 08:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADC815749C;
	Wed, 10 Apr 2024 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="K+kTBMS3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942331552EA;
	Wed, 10 Apr 2024 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738561; cv=none; b=mhi2bddFSHNhCfSqrG+peRgDusRZ3RTT6epyqhC34P04GEe8xKIb+lF292Bpf9drB+2Pg8PzF4qVagKUuGK8qi++YdAuIDbMZY/1G+og3hihL+7BkzjMkwce5PdWiDsGJSdYiVmDh2QDZxpQS9dZDg5GCx48cAWkt23B4V4FO0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738561; c=relaxed/simple;
	bh=bpEMSbOhGwJ4ebh+ByubSi0fOfI2vj2F9MNrLXSvGr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Um/T8qUFTRpr7dWx0SYNsds/QaTZVrhzsEiAlLujXWJHnlE8kMc4P9RZiIvWEeUDuoy+0D96IrZ/c3GgslNZkGkBV45hHw1VWMohT44zHAZ7PxF2rW5thC25vQCNEM9PifOL9gL7xnHQxErkZSEvebD5ThBCaYVQLlyGfiiqAvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=K+kTBMS3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 052FD20EB213;
	Wed, 10 Apr 2024 01:42:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 052FD20EB213
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712738558;
	bh=eb1JefW9L7KFUIuFQo6xEjsUyZIid9JjmJQnZTvCJZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+kTBMS3GdAdj8HoJJA2TwQ41p7B3xEptEz7k4wC3SjNpsP+1wMRlsl0W6mugMsb9
	 tuRuhbsx0fIw+KPC0i1TXvGbcUkJGKu7PpS9wYLIFScQBG4qrRAlOs+Vrsq3lbR5uh
	 hF4MQrj5Y+Cz1NhoDe2f2VT6ShbBTagmwKxwcByw=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v3 6/6] RDMA/mana_ib: Configure mac address in RNIC
Date: Wed, 10 Apr 2024 01:42:31 -0700
Message-Id: <1712738551-22075-7-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712738551-22075-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1712738551-22075-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Set local mac address in RNIC, which is required by the HW.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c  |  9 +++++++++
 drivers/infiniband/hw/mana/main.c    | 22 ++++++++++++++++++++++
 drivers/infiniband/hw/mana/mana_ib.h | 15 +++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 71923e5d0570..97a9f7a2d185 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -58,6 +58,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	struct net_device *upper_ndev;
 	struct mana_context *mc;
 	struct mana_ib_dev *dev;
+	u8 mac_addr[ETH_ALEN];
 	int ret;
 
 	mc = mdev->driver_data;
@@ -89,6 +90,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 		ibdev_err(&dev->ib_dev, "Failed to get master netdev");
 		goto free_ib_device;
 	}
+	ether_addr_copy(mac_addr, upper_ndev->dev_addr);
 	ret = ib_device_set_netdev(&dev->ib_dev, upper_ndev, 1);
 	rcu_read_unlock();
 	if (ret) {
@@ -121,6 +123,13 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	if (ret)
 		goto destroy_eqs;
 
+	ret = mana_ib_gd_config_mac(dev, ADDR_OP_ADD, mac_addr);
+	if (ret) {
+		ibdev_err(&dev->ib_dev, "Failed to add Mac address, ret %d",
+			  ret);
+		goto destroy_rnic;
+	}
+
 	ret = ib_register_device(&dev->ib_dev, "mana_%d",
 				 mdev->gdma_context->dev);
 	if (ret)
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 09d29cf538dc..5e037603d130 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -784,3 +784,25 @@ int mana_ib_gd_del_gid(const struct ib_gid_attr *attr, void **context)
 
 	return 0;
 }
+
+int mana_ib_gd_config_mac(struct mana_ib_dev *mdev, enum mana_ib_addr_op op, u8 *mac)
+{
+	struct mana_rnic_config_mac_addr_resp resp = {};
+	struct mana_rnic_config_mac_addr_req req = {};
+	struct gdma_context *gc = mdev_to_gc(mdev);
+	int err;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CONFIG_MAC_ADDR, sizeof(req), sizeof(resp));
+	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.adapter = mdev->adapter_handle;
+	req.op = op;
+	copy_in_reverse(req.mac_addr, mac, ETH_ALEN);
+
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+	if (err) {
+		ibdev_err(&mdev->ib_dev, "Failed to config Mac addr err %d", err);
+		return err;
+	}
+
+	return 0;
+}
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 89ac5b39dbce..4c1240da0c5f 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -117,6 +117,7 @@ enum mana_ib_command_code {
 	MANA_IB_CREATE_ADAPTER  = 0x30002,
 	MANA_IB_DESTROY_ADAPTER = 0x30003,
 	MANA_IB_CONFIG_IP_ADDR	= 0x30004,
+	MANA_IB_CONFIG_MAC_ADDR	= 0x30005,
 };
 
 struct mana_ib_query_adapter_caps_req {
@@ -188,6 +189,18 @@ struct mana_rnic_config_addr_resp {
 	struct gdma_resp_hdr hdr;
 }; /* HW Data */
 
+struct mana_rnic_config_mac_addr_req {
+	struct gdma_req_hdr hdr;
+	mana_handle_t adapter;
+	enum mana_ib_addr_op op;
+	u8 mac_addr[ETH_ALEN];
+	u8 reserved[6];
+}; /* HW Data */
+
+struct mana_rnic_config_mac_addr_resp {
+	struct gdma_resp_hdr hdr;
+}; /* HW Data */
+
 static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev *mdev)
 {
 	return mdev->gdma_dev->gdma_context;
@@ -305,4 +318,6 @@ enum rdma_link_layer mana_ib_get_link_layer(struct ib_device *device, u32 port_n
 int mana_ib_gd_add_gid(const struct ib_gid_attr *attr, void **context);
 
 int mana_ib_gd_del_gid(const struct ib_gid_attr *attr, void **context);
+
+int mana_ib_gd_config_mac(struct mana_ib_dev *mdev, enum mana_ib_addr_op op, u8 *mac);
 #endif
-- 
2.43.0


