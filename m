Return-Path: <linux-rdma+bounces-1883-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE1E89EDD6
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Apr 2024 10:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC821C20FEB
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Apr 2024 08:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E24D154C0D;
	Wed, 10 Apr 2024 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VI4G85Vb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5AD154C0B;
	Wed, 10 Apr 2024 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738560; cv=none; b=EBzXObd4H5pMOEGHofy/+EO3nrOksT/PDfUaKqEKauuGwCeTjXmT79/xV7x6mzNU1/yIFqiZInZHlr1Pw8+CWPz73m3FC0lvB6XcWaiZoytJeffn+E3GmgmO1qLOCiGfuUQbrAhRh3hoVem8F/Y/amXM4I/71BiFu9aIr8/j6QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738560; c=relaxed/simple;
	bh=hbSVyZ3kKFZF5CHaA43SBpkQYfyXXseK4sm8AXa/AJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZJXFcr6Rqxngc/7lzO01mirhXD7DWmxR3Y8IqljDDxpuyLSGuErLAxym0+QeTp18PAUBDPNNgW7Xgw+VjF1vnehVYKTHrruKzwQbF5WQ4CzEze8WBcajkEN1i37hjKKhKpRn1C1p7jM7Nmg84RxDOo0b8VxBRwf0mPkRitK1Tik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VI4G85Vb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id B08BE20EB201;
	Wed, 10 Apr 2024 01:42:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B08BE20EB201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712738557;
	bh=9N4q+oLGK9k6KLGhVJcDkPU1rDuX/lRFIqa9J41UoxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VI4G85VbGDC9o117uSNLkvhdifyvvZzkc4AwKwiMcQ3nQZxE+5AQ35yPL60SqsdVL
	 VdM/oVtAcSvKVqbPZ7zz6j0+Ehvl9JmV9QGZOtpfDa4Lv4Y3zLTCYSWXD7fFaXsStj
	 uj6+KYzQtmC9vqwQJ3rxEBbkZf+Q0yKRX3ZVIKVc=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v3 3/6] RDMA/mana_ib: implement port parameters
Date: Wed, 10 Apr 2024 01:42:28 -0700
Message-Id: <1712738551-22075-4-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712738551-22075-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1712738551-22075-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Implement port parameters for RNIC:
1) extend query_port() method
2) implement get_link_layer()
3) implement query_pkey()

Only port 1 can store GIDs.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c  |  2 ++
 drivers/infiniband/hw/mana/main.c    | 37 +++++++++++++++++++++++++++-
 drivers/infiniband/hw/mana/mana_ib.h |  4 +++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index a98a04ff92e5..47547a962b19 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -29,12 +29,14 @@ static const struct ib_device_ops mana_ib_dev_ops = {
 	.destroy_rwq_ind_table = mana_ib_destroy_rwq_ind_table,
 	.destroy_wq = mana_ib_destroy_wq,
 	.disassociate_ucontext = mana_ib_disassociate_ucontext,
+	.get_link_layer = mana_ib_get_link_layer,
 	.get_port_immutable = mana_ib_get_port_immutable,
 	.mmap = mana_ib_mmap,
 	.modify_qp = mana_ib_modify_qp,
 	.modify_wq = mana_ib_modify_wq,
 	.query_device = mana_ib_query_device,
 	.query_gid = mana_ib_query_gid,
+	.query_pkey = mana_ib_query_pkey,
 	.query_port = mana_ib_query_port,
 	.reg_user_mr = mana_ib_reg_user_mr,
 
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index aa3cac8d3edb..29550f2173ff 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -557,7 +557,42 @@ int mana_ib_query_device(struct ib_device *ibdev, struct ib_device_attr *props,
 int mana_ib_query_port(struct ib_device *ibdev, u32 port,
 		       struct ib_port_attr *props)
 {
-	/* This version doesn't return port properties */
+	struct net_device *ndev = mana_ib_get_netdev(ibdev, port);
+
+	if (!ndev)
+		return -EINVAL;
+
+	memset(props, 0, sizeof(*props));
+	props->max_mtu = IB_MTU_4096;
+	props->active_mtu = ib_mtu_int_to_enum(ndev->mtu);
+
+	if (netif_carrier_ok(ndev) && netif_running(ndev)) {
+		props->state = IB_PORT_ACTIVE;
+		props->phys_state = IB_PORT_PHYS_STATE_LINK_UP;
+	} else {
+		props->state = IB_PORT_DOWN;
+		props->phys_state = IB_PORT_PHYS_STATE_DISABLED;
+	}
+
+	props->active_width = IB_WIDTH_4X;
+	props->active_speed = IB_SPEED_EDR;
+	props->pkey_tbl_len = 1;
+	if (port == 1)
+		props->gid_tbl_len = 16;
+
+	return 0;
+}
+
+enum rdma_link_layer mana_ib_get_link_layer(struct ib_device *device, u32 port_num)
+{
+	return IB_LINK_LAYER_ETHERNET;
+}
+
+int mana_ib_query_pkey(struct ib_device *ibdev, u32 port, u16 index, u16 *pkey)
+{
+	if (index != 0)
+		return -EINVAL;
+	*pkey = IB_DEFAULT_PKEY_FULL;
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 842f9c63a495..b9117cbc7629 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -266,4 +266,8 @@ void mana_ib_destroy_eqs(struct mana_ib_dev *mdev);
 int mana_ib_gd_create_rnic_adapter(struct mana_ib_dev *mdev);
 
 int mana_ib_gd_destroy_rnic_adapter(struct mana_ib_dev *mdev);
+
+int mana_ib_query_pkey(struct ib_device *ibdev, u32 port, u16 index, u16 *pkey);
+
+enum rdma_link_layer mana_ib_get_link_layer(struct ib_device *device, u32 port_num);
 #endif
-- 
2.43.0


