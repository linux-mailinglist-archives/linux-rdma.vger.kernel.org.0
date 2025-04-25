Return-Path: <linux-rdma+bounces-9794-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7D0A9CA64
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 15:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4533F3A072B
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 13:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5058F25A2BB;
	Fri, 25 Apr 2025 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fe8tiqcN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B86253943;
	Fri, 25 Apr 2025 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745587780; cv=none; b=mEPHnf1hIn1FmvJcgg5YqcPRbL4l7i+sywlTHtop1DPpyWWNza7VKQvMeoZPJIK4mzqJ8UNgMBFc6D4bbK4nP9LUzgev27Oy74M2eLE9THcG+X/5ZohaY53pxVJbcNMYqIXzYThMnu6O+doWBWN4wFvRVouzG7eKarZ6t22nNnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745587780; c=relaxed/simple;
	bh=E1idcDuk9MsOfiF1oxTIQO+Hqn72sK3N44VUmd3AvCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pM7crW80qkCpNFQljrzVlucS4qhjMuF0SFBifu99JW2lTsleorEaL0a22CuXALGjiPYEHAO0L0lnXw33FATFaQy24la7mOawWIhl1WN8/VJRftK1RNHE8j7hdnZGgRXH2HTzXZBjgbprtwUz3PAotQcsGi9V3FCVt6iA1vodK1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fe8tiqcN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id AD9732020959; Fri, 25 Apr 2025 06:29:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AD9732020959
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745587777;
	bh=MSEuotBL3/m+uhTL+K7LqG4no9aEbMTtU37sxkRSwRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fe8tiqcNuYRdZGfhiUcGE8YsolSFltobFdKHWo2myhi/S3fhmKuJvKmjTCXG55G0o
	 I4mh5J65kGRnptIf2YUaj1jK5hAKeFOU533H+u6DbrFmCMGXMgth59pbp1b66fj4mK
	 ACmIAq23j61wG23t0HSiU6qM9+bsO68t3wwiahJs=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	pabeni@redhat.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	edumazet@google.com,
	kuba@kernel.org,
	davem@davemloft.net,
	decui@microsoft.com,
	wei.liu@kernel.org,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH rdma-next v2 2/4] RDMA/mana_ib: Add support of mana_ib for RNIC and ETH nic
Date: Fri, 25 Apr 2025 06:29:35 -0700
Message-Id: <1745587777-15716-3-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1745587777-15716-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1745587777-15716-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Allow mana_ib to be created over ethernet gdma device and
over rnic gdma device. The HW has two devices with different
capabilities and different use-cases. Initialize required
resources depending on the used gdma device.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c  | 174 +++++++++++++++++------------------
 drivers/infiniband/hw/mana/main.c    |  49 +++++++++-
 drivers/infiniband/hw/mana/mana_ib.h |   6 ++
 3 files changed, 134 insertions(+), 95 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index b310893..165c0a1 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -101,103 +101,95 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 			 const struct auxiliary_device_id *id)
 {
 	struct mana_adev *madev = container_of(adev, struct mana_adev, adev);
+	struct gdma_context *gc = madev->mdev->gdma_context;
+	struct mana_context *mc = gc->mana.driver_data;
 	struct gdma_dev *mdev = madev->mdev;
 	struct net_device *ndev;
-	struct mana_context *mc;
 	struct mana_ib_dev *dev;
 	u8 mac_addr[ETH_ALEN];
 	int ret;
 
-	mc = mdev->driver_data;
-
 	dev = ib_alloc_device(mana_ib_dev, ib_dev);
 	if (!dev)
 		return -ENOMEM;
 
 	ib_set_device_ops(&dev->ib_dev, &mana_ib_dev_ops);
-
-	dev->ib_dev.phys_port_cnt = mc->num_ports;
-
-	ibdev_dbg(&dev->ib_dev, "mdev=%p id=%d num_ports=%d\n", mdev,
-		  mdev->dev_id.as_uint32, dev->ib_dev.phys_port_cnt);
-
 	dev->ib_dev.node_type = RDMA_NODE_IB_CA;
-
-	/*
-	 * num_comp_vectors needs to set to the max MSIX index
-	 * when interrupts and event queues are implemented
-	 */
-	dev->ib_dev.num_comp_vectors = mdev->gdma_context->max_num_queues;
-	dev->ib_dev.dev.parent = mdev->gdma_context->dev;
-
-	ndev = mana_get_primary_netdev(mc, 0, &dev->dev_tracker);
-	if (!ndev) {
-		ret = -ENODEV;
-		ibdev_err(&dev->ib_dev, "Failed to get netdev for IB port 1");
-		goto free_ib_device;
-	}
-	ether_addr_copy(mac_addr, ndev->dev_addr);
-	addrconf_addr_eui48((u8 *)&dev->ib_dev.node_guid, ndev->dev_addr);
-	ret = ib_device_set_netdev(&dev->ib_dev, ndev, 1);
-	/* mana_get_primary_netdev() returns ndev with refcount held */
-	netdev_put(ndev, &dev->dev_tracker);
-	if (ret) {
-		ibdev_err(&dev->ib_dev, "Failed to set ib netdev, ret %d", ret);
-		goto free_ib_device;
-	}
-
-	ret = mana_gd_register_device(&mdev->gdma_context->mana_ib);
-	if (ret) {
-		ibdev_err(&dev->ib_dev, "Failed to register device, ret %d",
-			  ret);
-		goto free_ib_device;
-	}
-	dev->gdma_dev = &mdev->gdma_context->mana_ib;
-
-	dev->nb.notifier_call = mana_ib_netdev_event;
-	ret = register_netdevice_notifier(&dev->nb);
-	if (ret) {
-		ibdev_err(&dev->ib_dev, "Failed to register net notifier, %d",
-			  ret);
-		goto deregister_device;
-	}
-
-	ret = mana_ib_gd_query_adapter_caps(dev);
-	if (ret) {
-		ibdev_err(&dev->ib_dev, "Failed to query device caps, ret %d",
-			  ret);
-		goto deregister_net_notifier;
-	}
-
-	ib_set_device_ops(&dev->ib_dev, &mana_ib_stats_ops);
-
-	ret = mana_ib_create_eqs(dev);
-	if (ret) {
-		ibdev_err(&dev->ib_dev, "Failed to create EQs, ret %d", ret);
-		goto deregister_net_notifier;
-	}
-
-	ret = mana_ib_gd_create_rnic_adapter(dev);
-	if (ret)
-		goto destroy_eqs;
-
+	dev->ib_dev.num_comp_vectors = gc->max_num_queues;
+	dev->ib_dev.dev.parent = gc->dev;
+	dev->gdma_dev = mdev;
 	xa_init_flags(&dev->qp_table_wq, XA_FLAGS_LOCK_IRQ);
-	ret = mana_ib_gd_config_mac(dev, ADDR_OP_ADD, mac_addr);
-	if (ret) {
-		ibdev_err(&dev->ib_dev, "Failed to add Mac address, ret %d",
-			  ret);
-		goto destroy_rnic;
+
+	if (mana_ib_is_rnic(dev)) {
+		dev->ib_dev.phys_port_cnt = 1;
+		ndev = mana_get_primary_netdev(mc, 0, &dev->dev_tracker);
+		if (!ndev) {
+			ret = -ENODEV;
+			ibdev_err(&dev->ib_dev, "Failed to get netdev for IB port 1");
+			goto free_ib_device;
+		}
+		ether_addr_copy(mac_addr, ndev->dev_addr);
+		addrconf_addr_eui48((u8 *)&dev->ib_dev.node_guid, ndev->dev_addr);
+		ret = ib_device_set_netdev(&dev->ib_dev, ndev, 1);
+		/* mana_get_primary_netdev() returns ndev with refcount held */
+		netdev_put(ndev, &dev->dev_tracker);
+		if (ret) {
+			ibdev_err(&dev->ib_dev, "Failed to set ib netdev, ret %d", ret);
+			goto free_ib_device;
+		}
+
+		dev->nb.notifier_call = mana_ib_netdev_event;
+		ret = register_netdevice_notifier(&dev->nb);
+		if (ret) {
+			ibdev_err(&dev->ib_dev, "Failed to register net notifier, %d",
+				  ret);
+			goto free_ib_device;
+		}
+
+		ret = mana_ib_gd_query_adapter_caps(dev);
+		if (ret) {
+			ibdev_err(&dev->ib_dev, "Failed to query device caps, ret %d", ret);
+			goto deregister_net_notifier;
+		}
+
+		ib_set_device_ops(&dev->ib_dev, &mana_ib_stats_ops);
+
+		ret = mana_ib_create_eqs(dev);
+		if (ret) {
+			ibdev_err(&dev->ib_dev, "Failed to create EQs, ret %d", ret);
+			goto deregister_net_notifier;
+		}
+
+		ret = mana_ib_gd_create_rnic_adapter(dev);
+		if (ret)
+			goto destroy_eqs;
+
+		ret = mana_ib_gd_config_mac(dev, ADDR_OP_ADD, mac_addr);
+		if (ret) {
+			ibdev_err(&dev->ib_dev, "Failed to add Mac address, ret %d", ret);
+			goto destroy_rnic;
+		}
+	} else {
+		dev->ib_dev.phys_port_cnt = mc->num_ports;
+		ret = mana_eth_query_adapter_caps(dev);
+		if (ret) {
+			ibdev_err(&dev->ib_dev, "Failed to query ETH device caps, ret %d", ret);
+			goto free_ib_device;
+		}
 	}
 
-	dev->av_pool = dma_pool_create("mana_ib_av", mdev->gdma_context->dev,
-				       MANA_AV_BUFFER_SIZE, MANA_AV_BUFFER_SIZE, 0);
+	dev->av_pool = dma_pool_create("mana_ib_av", gc->dev, MANA_AV_BUFFER_SIZE,
+				       MANA_AV_BUFFER_SIZE, 0);
 	if (!dev->av_pool) {
 		ret = -ENOMEM;
 		goto destroy_rnic;
 	}
 
-	ret = ib_register_device(&dev->ib_dev, "mana_%d",
-				 mdev->gdma_context->dev);
+	ibdev_dbg(&dev->ib_dev, "mdev=%p id=%d num_ports=%d\n", mdev,
+		  mdev->dev_id.as_uint32, dev->ib_dev.phys_port_cnt);
+
+	ret = ib_register_device(&dev->ib_dev, mana_ib_is_rnic(dev) ? "mana_%d" : "manae_%d",
+				 gc->dev);
 	if (ret)
 		goto deallocate_pool;
 
@@ -208,15 +200,16 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 deallocate_pool:
 	dma_pool_destroy(dev->av_pool);
 destroy_rnic:
-	xa_destroy(&dev->qp_table_wq);
-	mana_ib_gd_destroy_rnic_adapter(dev);
+	if (mana_ib_is_rnic(dev))
+		mana_ib_gd_destroy_rnic_adapter(dev);
 destroy_eqs:
-	mana_ib_destroy_eqs(dev);
+	if (mana_ib_is_rnic(dev))
+		mana_ib_destroy_eqs(dev);
 deregister_net_notifier:
-	unregister_netdevice_notifier(&dev->nb);
-deregister_device:
-	mana_gd_deregister_device(dev->gdma_dev);
+	if (mana_ib_is_rnic(dev))
+		unregister_netdevice_notifier(&dev->nb);
 free_ib_device:
+	xa_destroy(&dev->qp_table_wq);
 	ib_dealloc_device(&dev->ib_dev);
 	return ret;
 }
@@ -227,25 +220,24 @@ static void mana_ib_remove(struct auxiliary_device *adev)
 
 	ib_unregister_device(&dev->ib_dev);
 	dma_pool_destroy(dev->av_pool);
+	if (mana_ib_is_rnic(dev)) {
+		mana_ib_gd_destroy_rnic_adapter(dev);
+		mana_ib_destroy_eqs(dev);
+		unregister_netdevice_notifier(&dev->nb);
+	}
 	xa_destroy(&dev->qp_table_wq);
-	mana_ib_gd_destroy_rnic_adapter(dev);
-	mana_ib_destroy_eqs(dev);
-	unregister_netdevice_notifier(&dev->nb);
-	mana_gd_deregister_device(dev->gdma_dev);
 	ib_dealloc_device(&dev->ib_dev);
 }
 
 static const struct auxiliary_device_id mana_id_table[] = {
-	{
-		.name = "mana.rdma",
-	},
+	{ .name = "mana.rdma", },
+	{ .name = "mana.eth", },
 	{},
 };
 
 MODULE_DEVICE_TABLE(auxiliary, mana_id_table);
 
 static struct auxiliary_driver mana_driver = {
-	.name = "rdma",
 	.probe = mana_ib_probe,
 	.remove = mana_ib_remove,
 	.id_table = mana_id_table,
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index a28b712..64526b8 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -551,6 +551,7 @@ int mana_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vma)
 int mana_ib_get_port_immutable(struct ib_device *ibdev, u32 port_num,
 			       struct ib_port_immutable *immutable)
 {
+	struct mana_ib_dev *dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 	struct ib_port_attr attr;
 	int err;
 
@@ -560,10 +561,12 @@ int mana_ib_get_port_immutable(struct ib_device *ibdev, u32 port_num,
 
 	immutable->pkey_tbl_len = attr.pkey_tbl_len;
 	immutable->gid_tbl_len = attr.gid_tbl_len;
-	immutable->core_cap_flags = RDMA_CORE_PORT_RAW_PACKET;
-	if (port_num == 1) {
-		immutable->core_cap_flags |= RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP;
+
+	if (mana_ib_is_rnic(dev)) {
+		immutable->core_cap_flags = RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP;
 		immutable->max_mad_size = IB_MGMT_MAD_SIZE;
+	} else {
+		immutable->core_cap_flags = RDMA_CORE_PORT_RAW_PACKET;
 	}
 
 	return 0;
@@ -597,12 +600,17 @@ int mana_ib_query_device(struct ib_device *ibdev, struct ib_device_attr *props,
 	props->max_pkeys = 1;
 	props->local_ca_ack_delay = MANA_CA_ACK_DELAY;
 
+	if (!mana_ib_is_rnic(dev)) {
+		props->raw_packet_caps = IB_RAW_PACKET_CAP_CVLAN_STRIPPING | IB_RAW_PACKET_CAP_IP_CSUM;
+	}
+
 	return 0;
 }
 
 int mana_ib_query_port(struct ib_device *ibdev, u32 port,
 		       struct ib_port_attr *props)
 {
+	struct mana_ib_dev *dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 	struct net_device *ndev = mana_ib_get_netdev(ibdev, port);
 
 	if (!ndev)
@@ -623,7 +631,7 @@ int mana_ib_query_port(struct ib_device *ibdev, u32 port,
 	props->active_width = IB_WIDTH_4X;
 	props->active_speed = IB_SPEED_EDR;
 	props->pkey_tbl_len = 1;
-	if (port == 1) {
+	if (mana_ib_is_rnic(dev)) {
 		props->gid_tbl_len = 16;
 		props->port_cap_flags = IB_PORT_CM_SUP;
 		props->ip_gids = true;
@@ -703,6 +711,36 @@ int mana_ib_gd_query_adapter_caps(struct mana_ib_dev *dev)
 	return 0;
 }
 
+int mana_eth_query_adapter_caps(struct mana_ib_dev *dev)
+{
+	struct mana_ib_adapter_caps *caps = &dev->adapter_caps;
+	struct gdma_query_max_resources_resp resp = {};
+	struct gdma_general_req req = {};
+	int err;
+
+	mana_gd_init_req_hdr(&req.hdr, GDMA_QUERY_MAX_RESOURCES,
+			     sizeof(req), sizeof(resp));
+
+	err = mana_gd_send_request(mdev_to_gc(dev), sizeof(req), &req, sizeof(resp), &resp);
+	if (err) {
+		ibdev_err(&dev->ib_dev,
+			  "Failed to query adapter caps err %d", err);
+		return err;
+	}
+
+	caps->max_qp_count = min_t(u32, resp.max_sq, resp.max_rq);
+	caps->max_cq_count = resp.max_cq;
+	caps->max_mr_count = resp.max_mst;
+	caps->max_pd_count = 0x6000;
+	caps->max_qp_wr = min_t(u32,
+				0x100000 / GDMA_MAX_SQE_SIZE,
+				0x100000 / GDMA_MAX_RQE_SIZE);
+	caps->max_send_sge_count = 30;
+	caps->max_recv_sge_count = 15;
+
+	return 0;
+}
+
 static void
 mana_ib_event_handler(void *ctx, struct gdma_queue *q, struct gdma_event *event)
 {
@@ -921,6 +959,9 @@ int mana_ib_gd_create_cq(struct mana_ib_dev *mdev, struct mana_ib_cq *cq, u32 do
 	struct mana_rnic_create_cq_req req = {};
 	int err;
 
+	if (!mdev->eqs)
+		return -EINVAL;
+
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_CQ, sizeof(req), sizeof(resp));
 	req.hdr.dev_id = gc->mana_ib.dev_id;
 	req.adapter = mdev->adapter_handle;
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index f0dbd90..42bebd6 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -544,6 +544,11 @@ static inline void mana_put_qp_ref(struct mana_ib_qp *qp)
 		complete(&qp->free);
 }
 
+static inline bool mana_ib_is_rnic(struct mana_ib_dev *mdev)
+{
+	return mdev->gdma_dev->dev_id.type == GDMA_DEVICE_MANA_IB;
+}
+
 static inline struct net_device *mana_ib_get_netdev(struct ib_device *ibdev, u32 port)
 {
 	struct mana_ib_dev *mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
@@ -643,6 +648,7 @@ int mana_ib_query_gid(struct ib_device *ibdev, u32 port, int index,
 void mana_ib_disassociate_ucontext(struct ib_ucontext *ibcontext);
 
 int mana_ib_gd_query_adapter_caps(struct mana_ib_dev *mdev);
+int mana_eth_query_adapter_caps(struct mana_ib_dev *mdev);
 
 int mana_ib_create_eqs(struct mana_ib_dev *mdev);
 
-- 
1.8.3.1


