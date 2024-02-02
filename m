Return-Path: <linux-rdma+bounces-874-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D46F8472A4
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 16:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE1E290B0B
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 15:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F6C1474B7;
	Fri,  2 Feb 2024 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nvzo2Fa2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD3D145328;
	Fri,  2 Feb 2024 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886415; cv=none; b=dw0GDQd4PEU4u7l7x31G2bVfkg+x2aQ8x4OknyKdPr8huxPhSpnNFuGuzCrTIksFV44Y2qhAPrZcFEtENsck15cMTi6P8CCfDsO0Ug1IxkKKTtbqHuy4gO8bhtmuqLjyzvPXrb9WR7Uosu1NVQUp9xhp/A/FG2V15U0KijeclY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886415; c=relaxed/simple;
	bh=lwkOSAnGEnMRxgE2eYpnXuty91szYnqPYwpQeHF0pik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=g6rtHq2AojjGiR1ro85PYueNJv7xoQhUadm2xJBnApRmptJKWeyrwaYsNCWtbKMSPKZm/KhCfkNkBIrjJjPE2uShy69LdosKvyGliP3zChGLnewmYNOjZCgSlT7I0w1P4QqZy9imJ5MxmHUe4ibBQ5l2MwfApWL7vmXmaUJ2ir8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nvzo2Fa2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 844B920B2003;
	Fri,  2 Feb 2024 07:06:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 844B920B2003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706886405;
	bh=5yXFaEp9vKBshRa+NgGc9Zh0uI+t9u7kQk3cCqXTndQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nvzo2Fa2Rg1awmzVwTn0wIOcljM+JpU0PKlle5AKjZb6CxMHAGHFTNIrkzVcuuEtJ
	 rW/WM72KzuHfZTLakJH+fKzIe2+0jzjVWJfqMJOfdI1ytTg/qEOdnsW5JEp6P6eGbn
	 2Qz2fHvakTs+x1g7fmiA//2l0PUfZ01E5ebca/H4=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 3/5] RDMA/mana_ib: Implement port parameters
Date: Fri,  2 Feb 2024 07:06:35 -0800
Message-Id: <1706886397-16600-4-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1706886397-16600-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1706886397-16600-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Implement port parameters for RNIC. Only port 1 is RoCEv2 capable.

Signed-off-by: Konstantin Taranov <kotaranov@linux.microsoft.com>
---
 drivers/infiniband/hw/mana/device.c  |  2 ++
 drivers/infiniband/hw/mana/main.c    | 37 +++++++++++++++++++++++++++++++++++-
 drivers/infiniband/hw/mana/mana_ib.h |  4 ++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index d8e8b10..11b0410 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -29,12 +29,14 @@
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
index 33cd69e..3e05a62 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -492,7 +492,42 @@ int mana_ib_query_device(struct ib_device *ibdev, struct ib_device_attr *props,
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
index 96454cf..196f3c8 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -262,4 +262,8 @@ int mana_ib_query_gid(struct ib_device *ibdev, u32 port, int index,
 void mana_ib_gd_create_rnic_adapter(struct mana_ib_dev *mdev);
 
 void mana_ib_gd_destroy_rnic_adapter(struct mana_ib_dev *mdev);
+
+int mana_ib_query_pkey(struct ib_device *ibdev, u32 port, u16 index, u16 *pkey);
+
+enum rdma_link_layer mana_ib_get_link_layer(struct ib_device *device, u32 port_num);
 #endif
-- 
1.8.3.1


