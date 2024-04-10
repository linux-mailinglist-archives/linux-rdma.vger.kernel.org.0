Return-Path: <linux-rdma+bounces-1885-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC2189EDDB
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Apr 2024 10:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2881C210BF
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Apr 2024 08:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECEA156F2F;
	Wed, 10 Apr 2024 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pHA+oDmN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FD61552E0;
	Wed, 10 Apr 2024 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738561; cv=none; b=GeVPRBo4x6+xCMpT0eGehLNpuFmWgGH1AhsfUAuW73xnqMMJhknsXcGmaJqtbMZG4NwcJfRD6RnXECyp9pDd6NnSwU/6UhlJYseKzU++lPc18nyh3kLIEkWbYA1e1cq86iGhdYoXFiiIMu/6eaLSp46F4XjE7Xh8gGE0rPMHG2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738561; c=relaxed/simple;
	bh=GxnRshZh9WZkXubgMMIL1n/ZbJJvJKRdJCKprRUQy8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kaucAKEMp0FJDjdeKXo/H7dZiETHJ5l8awdWtcIaa6JekjZeBBruXWtAksTZxEmhQAtTBF/z4zpYGklo98apu1FqnXzE7InSoZuYhpZNWus+v9hcOSf8R27lzB17b7svv+qeSOyUaiNd5c16qlVd97doVy97zeAA72TaVkJYt9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pHA+oDmN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id E08C420EB20C;
	Wed, 10 Apr 2024 01:42:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E08C420EB20C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712738557;
	bh=hiUI2aSDmIHRfpVyjNUQnQXlBEtJ/Ym2Wo0DfMPjY70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pHA+oDmNQy9E3ylBF5mOu7BU+46SlG7E+WGogXOwETgfsbBSdLS5nlbzh2ijYqA9t
	 uSs4HNpvGxu1oHAznVeKeYf1pMvJ3SNX5Rwx1wy6SreNZSAvrKMf609pN4CdwGiTjs
	 68biA8Eg91JkwlPfz2zFVJ/VKTn3HJ7vHOTQNQXs=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v3 5/6] RDMA/mana_ib: adding and deleting GIDs
Date: Wed, 10 Apr 2024 01:42:30 -0700
Message-Id: <1712738551-22075-6-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712738551-22075-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1712738551-22075-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Implement add_gid and del_gid for RNIC.
IPv4 and IPv6 addresses are supported.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c  |  2 +
 drivers/infiniband/hw/mana/main.c    | 60 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/mana/mana_ib.h | 35 ++++++++++++++++
 3 files changed, 97 insertions(+)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index e7981301d10b..71923e5d0570 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -15,6 +15,7 @@ static const struct ib_device_ops mana_ib_dev_ops = {
 	.driver_id = RDMA_DRIVER_MANA,
 	.uverbs_abi_ver = MANA_IB_UVERBS_ABI_VERSION,
 
+	.add_gid = mana_ib_gd_add_gid,
 	.alloc_pd = mana_ib_alloc_pd,
 	.alloc_ucontext = mana_ib_alloc_ucontext,
 	.create_cq = mana_ib_create_cq,
@@ -23,6 +24,7 @@ static const struct ib_device_ops mana_ib_dev_ops = {
 	.create_wq = mana_ib_create_wq,
 	.dealloc_pd = mana_ib_dealloc_pd,
 	.dealloc_ucontext = mana_ib_dealloc_ucontext,
+	.del_gid = mana_ib_gd_del_gid,
 	.dereg_mr = mana_ib_dereg_mr,
 	.destroy_cq = mana_ib_destroy_cq,
 	.destroy_qp = mana_ib_destroy_qp,
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 7a9d7e13b7b1..09d29cf538dc 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -724,3 +724,63 @@ int mana_ib_gd_destroy_rnic_adapter(struct mana_ib_dev *mdev)
 
 	return 0;
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
index b9117cbc7629..89ac5b39dbce 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -116,6 +116,7 @@ enum mana_ib_command_code {
 	MANA_IB_GET_ADAPTER_CAP = 0x30001,
 	MANA_IB_CREATE_ADAPTER  = 0x30002,
 	MANA_IB_DESTROY_ADAPTER = 0x30003,
+	MANA_IB_CONFIG_IP_ADDR	= 0x30004,
 };
 
 struct mana_ib_query_adapter_caps_req {
@@ -165,6 +166,28 @@ struct mana_rnic_destroy_adapter_resp {
 	struct gdma_resp_hdr hdr;
 }; /* HW Data */
 
+enum mana_ib_addr_op {
+	ADDR_OP_ADD = 1,
+	ADDR_OP_REMOVE = 2,
+};
+
+enum sgid_entry_type {
+	SGID_TYPE_IPV4 = 1,
+	SGID_TYPE_IPV6 = 2,
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
 static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev *mdev)
 {
 	return mdev->gdma_dev->gdma_context;
@@ -181,6 +204,14 @@ static inline struct net_device *mana_ib_get_netdev(struct ib_device *ibdev, u32
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
 
 int mana_ib_create_zero_offset_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
@@ -270,4 +301,8 @@ int mana_ib_gd_destroy_rnic_adapter(struct mana_ib_dev *mdev);
 int mana_ib_query_pkey(struct ib_device *ibdev, u32 port, u16 index, u16 *pkey);
 
 enum rdma_link_layer mana_ib_get_link_layer(struct ib_device *device, u32 port_num);
+
+int mana_ib_gd_add_gid(const struct ib_gid_attr *attr, void **context);
+
+int mana_ib_gd_del_gid(const struct ib_gid_attr *attr, void **context);
 #endif
-- 
2.43.0


