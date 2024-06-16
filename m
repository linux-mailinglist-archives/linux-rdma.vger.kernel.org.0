Return-Path: <linux-rdma+bounces-3180-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BCB909E6B
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 18:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC5D1F20F9B
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 16:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC347224D5;
	Sun, 16 Jun 2024 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFrBgG9x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A7818030;
	Sun, 16 Jun 2024 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718554177; cv=none; b=qNih8R2e6xiFnToAKzyyc/VbX9jpAXTX7OOhI1g5dg5Qltd53XMMRd145yZNLsEBRvbu0J/DPoNqSbbP7DkReZRs/Ne0XqQ5bPFr4fZvok357H8IYehCIgpATEQVHDaIPTm/eyZT9UKPP8OUXgHpAojEpggzFKmOhHTAh/URiAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718554177; c=relaxed/simple;
	bh=BcAOvhHt/iwGHK2MCoJWqWPVLuUNnam/AYSMx0Y4g8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dl0/RI/Jq1VsZx1Wk/uBeFp8NkmUTQh1zhvj6QyqNJoh9+V8/nN8T3NVCCN9mR1Fk+1CdQrdNfyADT40V1WZZrNrqVYxMQPfq51jfcPQR3XDbxFleO1cgkkhrQj5/MMEOax6UuVh27hqQdcaA5hGFtDNTgCjx34A8273wr8JIBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFrBgG9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C65C2BBFC;
	Sun, 16 Jun 2024 16:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718554177;
	bh=BcAOvhHt/iwGHK2MCoJWqWPVLuUNnam/AYSMx0Y4g8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cFrBgG9xCMtoN+LgA+adm4tKuqVRHoby4WS8WcFsXyhXe+l7FtWToXJmpREI+m4Gs
	 s2ZigN+vz5Qf54yub3ivISaK5y1K07DR6aXNLqGa+AelnjcdS+zvPVyj0fp3y0hpsB
	 Q1yQwV9A7NVKWZ0zpu3zeUdQkS74ukzA/1HXEhe9Hd1Q/ByKTWlo/dHaAPUYLiQFes
	 llvfCSiJ8hcmDLowWdiyV+zufBr3TIclbVaEpOo7BhWSMyCOVhSRxTWSD1RfrMqyg9
	 3uIecfgopBI82CO09gn3JeUIEbLVfQrPX7lPz57Jh8OrHCWIkXRgOVtiKTonfPNL+/
	 KtNJQDX88Aokg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Zhang <markzhang@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next 12/12] RDMA/mlx5: Support per-plane port IB counters by querying PPCNT register
Date: Sun, 16 Jun 2024 19:08:44 +0300
Message-ID: <06ffb582d67159b7def4654c8272d3d6e8bd2f2f.1718553901.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718553901.git.leon@kernel.org>
References: <cover.1718553901.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Zhang <markzhang@nvidia.com>

Supports per-plane port counters by querying PPCNT register with the
"extended port counters" group, as the query_vport_counter command
doesn't support plane ports.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mad.c | 69 +++++++++++++++++++++++++++-----
 include/linux/mlx5/device.h      |  1 +
 2 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mad.c b/drivers/infiniband/hw/mlx5/mad.c
index ead836d159d3..1b6c5e37d169 100644
--- a/drivers/infiniband/hw/mlx5/mad.c
+++ b/drivers/infiniband/hw/mlx5/mad.c
@@ -147,8 +147,39 @@ static void pma_cnt_assign(struct ib_pma_portcounters *pma_cnt,
 			     vl_15_dropped);
 }
 
-static int query_ib_ppcnt(struct mlx5_core_dev *dev, u8 port_num, void *out,
-			  size_t sz)
+static void pma_cnt_ext_assign_ppcnt(struct ib_pma_portcounters_ext *cnt_ext,
+				     void *out)
+{
+	void *out_pma = MLX5_ADDR_OF(ppcnt_reg, out,
+				     counter_set);
+
+#define MLX5_GET_EXT_CNTR(counter_name)			\
+	MLX5_GET64(ib_ext_port_cntrs_grp_data_layout,	\
+		   out_pma, counter_name##_high)
+
+	cnt_ext->port_xmit_data =
+		cpu_to_be64(MLX5_GET_EXT_CNTR(port_xmit_data) >> 2);
+	cnt_ext->port_rcv_data =
+		cpu_to_be64(MLX5_GET_EXT_CNTR(port_rcv_data) >> 2);
+
+	cnt_ext->port_xmit_packets =
+		cpu_to_be64(MLX5_GET_EXT_CNTR(port_xmit_pkts));
+	cnt_ext->port_rcv_packets =
+		cpu_to_be64(MLX5_GET_EXT_CNTR(port_rcv_pkts));
+
+	cnt_ext->port_unicast_xmit_packets =
+		cpu_to_be64(MLX5_GET_EXT_CNTR(port_unicast_xmit_pkts));
+	cnt_ext->port_unicast_rcv_packets =
+		cpu_to_be64(MLX5_GET_EXT_CNTR(port_unicast_rcv_pkts));
+
+	cnt_ext->port_multicast_xmit_packets =
+		cpu_to_be64(MLX5_GET_EXT_CNTR(port_multicast_xmit_pkts));
+	cnt_ext->port_multicast_rcv_packets =
+		cpu_to_be64(MLX5_GET_EXT_CNTR(port_multicast_rcv_pkts));
+}
+
+static int query_ib_ppcnt(struct mlx5_core_dev *dev, u8 port_num, u8 plane_num,
+			  void *out, size_t sz, bool ext)
 {
 	u32 *in;
 	int err;
@@ -160,8 +191,14 @@ static int query_ib_ppcnt(struct mlx5_core_dev *dev, u8 port_num, void *out,
 	}
 
 	MLX5_SET(ppcnt_reg, in, local_port, port_num);
-
-	MLX5_SET(ppcnt_reg, in, grp, MLX5_INFINIBAND_PORT_COUNTERS_GROUP);
+	MLX5_SET(ppcnt_reg, in, plane_ind, plane_num);
+
+	if (ext)
+		MLX5_SET(ppcnt_reg, in, grp,
+			 MLX5_INFINIBAND_EXTENDED_PORT_COUNTERS_GROUP);
+	else
+		MLX5_SET(ppcnt_reg, in, grp,
+			 MLX5_INFINIBAND_PORT_COUNTERS_GROUP);
 	err = mlx5_core_access_reg(dev, in, sz, out,
 				   sz, MLX5_REG_PPCNT, 0, 0);
 
@@ -189,7 +226,8 @@ static int process_pma_cmd(struct mlx5_ib_dev *dev, u32 port_num,
 		mdev_port_num = 1;
 	}
 	if (MLX5_CAP_GEN(dev->mdev, num_ports) == 1 &&
-	    !mlx5_core_mp_enabled(mdev)) {
+	    !mlx5_core_mp_enabled(mdev) &&
+	    dev->ib_dev.type != RDMA_DEVICE_TYPE_SMI) {
 		/* set local port to one for Function-Per-Port HCA. */
 		mdev = dev->mdev;
 		mdev_port_num = 1;
@@ -208,7 +246,8 @@ static int process_pma_cmd(struct mlx5_ib_dev *dev, u32 port_num,
 	if (in_mad->mad_hdr.attr_id == IB_PMA_PORT_COUNTERS_EXT) {
 		struct ib_pma_portcounters_ext *pma_cnt_ext =
 			(struct ib_pma_portcounters_ext *)(out_mad->data + 40);
-		int sz = MLX5_ST_SZ_BYTES(query_vport_counter_out);
+		int sz = max(MLX5_ST_SZ_BYTES(query_vport_counter_out),
+			     MLX5_ST_SZ_BYTES(ppcnt_reg));
 
 		out_cnt = kvzalloc(sz, GFP_KERNEL);
 		if (!out_cnt) {
@@ -216,10 +255,18 @@ static int process_pma_cmd(struct mlx5_ib_dev *dev, u32 port_num,
 			goto done;
 		}
 
-		err = mlx5_core_query_vport_counter(mdev, 0, 0, mdev_port_num,
-						    out_cnt);
-		if (!err)
-			pma_cnt_ext_assign(pma_cnt_ext, out_cnt);
+		if (dev->ib_dev.type == RDMA_DEVICE_TYPE_SMI) {
+			err = query_ib_ppcnt(mdev, mdev_port_num,
+					     port_num, out_cnt, sz, 1);
+			if (!err)
+				pma_cnt_ext_assign_ppcnt(pma_cnt_ext, out_cnt);
+		} else {
+			err = mlx5_core_query_vport_counter(mdev, 0, 0,
+							    mdev_port_num,
+							    out_cnt);
+			if (!err)
+				pma_cnt_ext_assign(pma_cnt_ext, out_cnt);
+		}
 	} else {
 		struct ib_pma_portcounters *pma_cnt =
 			(struct ib_pma_portcounters *)(out_mad->data + 40);
@@ -231,7 +278,7 @@ static int process_pma_cmd(struct mlx5_ib_dev *dev, u32 port_num,
 			goto done;
 		}
 
-		err = query_ib_ppcnt(mdev, mdev_port_num, out_cnt, sz);
+		err = query_ib_ppcnt(mdev, mdev_port_num, 0, out_cnt, sz, 0);
 		if (!err)
 			pma_cnt_assign(pma_cnt, out_cnt);
 	}
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index d7bb31d9a446..68bd1b4737ea 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -1466,6 +1466,7 @@ enum {
 	MLX5_PER_TRAFFIC_CLASS_CONGESTION_GROUP = 0x13,
 	MLX5_PHYSICAL_LAYER_STATISTICAL_GROUP = 0x16,
 	MLX5_INFINIBAND_PORT_COUNTERS_GROUP   = 0x20,
+	MLX5_INFINIBAND_EXTENDED_PORT_COUNTERS_GROUP = 0x21,
 };
 
 enum {
-- 
2.45.2


