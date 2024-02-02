Return-Path: <linux-rdma+bounces-873-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90858472A1
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 16:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E70DB2B5AF
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 15:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0677B14690E;
	Fri,  2 Feb 2024 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DtJMLrQD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D58D145B0A;
	Fri,  2 Feb 2024 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886414; cv=none; b=KfgprhXRjLcUqyDEn5luWJvcDeMgG72zSspuTzdo3+xzlOoTclQhklX2/E5+fDbVk1f07HxRvMPGX5Z0bMCMjqxAoULh9vpcAW6NK8IvoAkNP148d0v+eqIQ3hWsGXqbR6pr+17//sXBd8JV/yQjS4mrP+S7Oen0I19Co2YpwQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886414; c=relaxed/simple;
	bh=9qFJEo1gG8jmdM1WliqaxN63JvvNL0jjXCrWGwgRnmg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OddUFNQQA8VUleygSyuO/+nfhGvvOrouw+MlUXgPp8/K/lUKhZKa/wLCSwQkNXdCco1erCAj/KolEITzh7JYWWFdSMTFKfsMhIaXqA4V7NLd9/jmX+bOHXS9XQv8HZwvOO8fpG8g7sRa9GSTUkks6DiH/fQsjBrZljUk3ZpIAVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DtJMLrQD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id B47C320B2005;
	Fri,  2 Feb 2024 07:06:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B47C320B2005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706886405;
	bh=KFGjzl3gNK7i8STIUzlk+L5uIQAXSRDUsl59ComKeIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DtJMLrQDIHdR4PR5uueY/9AZnTSN6NF1ihRxYdQyffltLgof1sF8DHNHdPLC1FDPx
	 op31XLCkKQtg3kJzYkRkNCky2jtrGXAWARr4icPGuajr4kzW89y7XT6xdqZ/DHUstx
	 u4fFStqQ0PXwqj2RjMi6VqYYgBBzIILUbktKwhVM=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 5/5] RDMA/mana_ib: Adding and deleting GIDs
Date: Fri,  2 Feb 2024 07:06:37 -0800
Message-Id: <1706886397-16600-6-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1706886397-16600-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1706886397-16600-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Implement add_gid and del_gid for RNIC.
We support ipv4 and ipv6 addresses.

Signed-off-by: Konstantin Taranov <kotaranov@linux.microsoft.com>
---
 drivers/infiniband/hw/mana/device.c  |  2 ++
 drivers/infiniband/hw/mana/main.c    | 66 ++++++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/mana/mana_ib.h | 37 ++++++++++++++++++++
 3 files changed, 105 insertions(+)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 2b362f5..9fb515b 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -15,6 +15,7 @@
 	.driver_id = RDMA_DRIVER_MANA,
 	.uverbs_abi_ver = MANA_IB_UVERBS_ABI_VERSION,
 
+	.add_gid = mana_ib_gd_add_gid,
 	.alloc_pd = mana_ib_alloc_pd,
 	.alloc_ucontext = mana_ib_alloc_ucontext,
 	.create_cq = mana_ib_create_cq,
@@ -23,6 +24,7 @@
 	.create_wq = mana_ib_create_wq,
 	.dealloc_pd = mana_ib_dealloc_pd,
 	.dealloc_ucontext = mana_ib_dealloc_ucontext,
+	.del_gid = mana_ib_gd_del_gid,
 	.dereg_mr = mana_ib_dereg_mr,
 	.destroy_cq = mana_ib_destroy_cq,
 	.destroy_qp = mana_ib_destroy_qp,
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 645abf3..282c024 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -675,3 +675,69 @@ void mana_ib_gd_destroy_rnic_adapter(struct mana_ib_dev *mdev)
 	mdev->adapter_handle = INVALID_MANA_HANDLE;
 	mana_ib_destroy_eqs(mdev);
 }
+
+int mana_ib_gd_add_gid(const struct ib_gid_attr *attr, void **context)
+{
+	struct mana_ib_dev *mdev = container_of(attr->device, struct mana_ib_dev, ib_dev);
+	enum rdma_network_type ntype = rdma_gid_attr_network_type(attr);
+	struct mana_rnic_config_addr_resp resp = {};
+	struct gdma_context *gc = mdev_to_gc(mdev);
+	struct mana_rnic_config_addr_req req = {};
+	int err;
+
+	if (!rnic_is_enabled(mdev))
+		return -EINVAL;
+
+	if (ntype != RDMA_NETWORK_IPV4 && ntype != RDMA_NETWORK_IPV6) {
+		ibdev_dbg(&mdev->ib_dev, "Unsupported rdma network type %d", ntype);
+		return -EINVAL;
+	}
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CONFIG_IP_ADDR, sizeof(req), sizeof(resp));
+	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.adapter = mdev->adapter_handle;
+	req.op = ADDR_OP_ADD;
+	req.sgid_type = (ntype == RDMA_NETWORK_IPV6) ? SGID_TYPE_IPV6 : SGID_TYPE_IPV4;
+	copy_in_reverse(req.ip_addr, attr->gid.raw, sizeof(union ib_gid));
+
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+	if (err) {
+		ibdev_err(&mdev->ib_dev, "Failed to config IP addr err %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+int mana_ib_gd_del_gid(const struct ib_gid_attr *attr, void **context)
+{
+	struct mana_ib_dev *mdev = container_of(attr->device, struct mana_ib_dev, ib_dev);
+	enum rdma_network_type ntype = rdma_gid_attr_network_type(attr);
+	struct mana_rnic_config_addr_resp resp = {};
+	struct gdma_context *gc = mdev_to_gc(mdev);
+	struct mana_rnic_config_addr_req req = {};
+	int err;
+
+	if (!rnic_is_enabled(mdev))
+		return -EINVAL;
+
+	if (ntype != RDMA_NETWORK_IPV4 && ntype != RDMA_NETWORK_IPV6) {
+		ibdev_dbg(&mdev->ib_dev, "Unsupported rdma network type %d", ntype);
+		return -EINVAL;
+	}
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CONFIG_IP_ADDR, sizeof(req), sizeof(resp));
+	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.adapter = mdev->adapter_handle;
+	req.op = ADDR_OP_REMOVE;
+	req.sgid_type = (ntype == RDMA_NETWORK_IPV6) ? SGID_TYPE_IPV6 : SGID_TYPE_IPV4;
+	copy_in_reverse(req.ip_addr, attr->gid.raw, sizeof(union ib_gid));
+
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+	if (err) {
+		ibdev_err(&mdev->ib_dev, "Failed to config IP addr err %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 196f3c8..2a3e3b0 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -118,6 +118,7 @@ enum mana_ib_command_code {
 	MANA_IB_GET_ADAPTER_CAP = 0x30001,
 	MANA_IB_CREATE_ADAPTER  = 0x30002,
 	MANA_IB_DESTROY_ADAPTER = 0x30003,
+	MANA_IB_CONFIG_IP_ADDR	= 0x30004,
 };
 
 struct mana_ib_query_adapter_caps_req {
@@ -167,6 +168,30 @@ struct mana_rnic_destroy_adapter_resp {
 	struct gdma_resp_hdr hdr;
 }; /* HW Data */
 
+enum mana_ib_addr_op {
+	ADDR_OP_ADD = 1,
+	ADDR_OP_REMOVE,
+};
+
+enum sgid_entry_type {
+	SGID_TYPE_INVALID = 0,
+	SGID_TYPE_IPV4 = 1,
+	SGID_TYPE_IPV6 = 2,
+	SGID_TYPE_HYBRID = 3
+};
+
+struct mana_rnic_config_addr_req {
+	struct gdma_req_hdr hdr;
+	mana_handle_t adapter;
+	enum mana_ib_addr_op op;
+	enum sgid_entry_type sgid_type;
+	u8 ip_addr[16];
+}; /* HW Data */
+
+struct mana_rnic_config_addr_resp {
+	struct gdma_resp_hdr hdr;
+}; /* HW Data */
+
 static inline bool rnic_is_enabled(struct mana_ib_dev *mdev)
 {
 	return mdev->adapter_handle != INVALID_MANA_HANDLE;
@@ -188,6 +213,14 @@ static inline struct net_device *mana_ib_get_netdev(struct ib_device *ibdev, u32
 	return mc->ports[port - 1];
 }
 
+static inline void copy_in_reverse(u8 *dst, const u8 *src, u32 size)
+{
+	u32 i;
+
+	for (i = 0; i < size; i++)
+		dst[size - 1 - i] = src[i];
+}
+
 int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *cq);
 
 int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
@@ -266,4 +299,8 @@ int mana_ib_query_gid(struct ib_device *ibdev, u32 port, int index,
 int mana_ib_query_pkey(struct ib_device *ibdev, u32 port, u16 index, u16 *pkey);
 
 enum rdma_link_layer mana_ib_get_link_layer(struct ib_device *device, u32 port_num);
+
+int mana_ib_gd_add_gid(const struct ib_gid_attr *attr, void **context);
+
+int mana_ib_gd_del_gid(const struct ib_gid_attr *attr, void **context);
 #endif
-- 
1.8.3.1


