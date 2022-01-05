Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6FC484EFA
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 09:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbiAEIFH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 03:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiAEIFG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 03:05:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BA2C061761;
        Wed,  5 Jan 2022 00:05:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8B398CE1B19;
        Wed,  5 Jan 2022 08:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3DEC36AE9;
        Wed,  5 Jan 2022 08:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641369901;
        bh=+yrla173Hc+EeGA2WY+vT2jwEipKTidLid3MuTj5K7I=;
        h=From:To:Cc:Subject:Date:From;
        b=JcEhWAW+Mczv4haLtAbYbBjIQpEXg/qs+qzeCctReW57+z/NtnOV4LAZ1HCF3lZR/
         2z60n5NqzVsc9uk1zNrfN9DTGcrDHIh1wSRVCy+T+svS9fNJW5Ns4XtMuWF6Nx9+iy
         eQyMLQF+wvdxCniLhtE/I7ECij46ILoxmK1zyQZDgJJ81MQcsEb7hbpQF+Y1zU8NyR
         QyMXEXrTV7qmVazQ3XAO+RoChbnkVabBbIiAcBoiOXZAXZZx+TfLUAM8yOE8piwBHU
         squjFAaXduGZn82GU6k3FlQDuUulkir0NhqJ3T/oSjIFOtOWUDQhbIJCyz9UwuLzsd
         klejVFNWcBYcw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/mad: Delete duplicated init_query_mad functions
Date:   Wed,  5 Jan 2022 10:04:56 +0200
Message-Id: <af6f35c590ff5ef56d0137351b8b295af0f7c13c.1641369858.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Several drivers used same function to initialize query MAD,
so move that function to global header file.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx4/main.c            | 24 +++++++-------------
 drivers/infiniband/hw/mlx5/mad.c             | 18 +++++++--------
 drivers/infiniband/hw/mlx5/mlx5_ib.h         |  8 -------
 drivers/infiniband/hw/mthca/mthca_provider.c | 20 +++++-----------
 include/rdma/ib_smi.h                        | 12 +++++++++-
 5 files changed, 34 insertions(+), 48 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index d66ce7694bbe..1c3d97229988 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -85,14 +85,6 @@ static enum rdma_link_layer mlx4_ib_port_link_layer(struct ib_device *device,
 
 static struct workqueue_struct *wq;
 
-static void init_query_mad(struct ib_smp *mad)
-{
-	mad->base_version  = 1;
-	mad->mgmt_class    = IB_MGMT_CLASS_SUBN_LID_ROUTED;
-	mad->class_version = 1;
-	mad->method	   = IB_MGMT_METHOD_GET;
-}
-
 static int check_flow_steering_support(struct mlx4_dev *dev)
 {
 	int eth_num_ports = 0;
@@ -471,7 +463,7 @@ static int mlx4_ib_query_device(struct ib_device *ibdev,
 	if (!in_mad || !out_mad)
 		goto out;
 
-	init_query_mad(in_mad);
+	ib_init_query_mad(in_mad);
 	in_mad->attr_id = IB_SMP_ATTR_NODE_INFO;
 
 	err = mlx4_MAD_IFC(to_mdev(ibdev), MLX4_MAD_IFC_IGNORE_KEYS,
@@ -669,7 +661,7 @@ static int ib_link_query_port(struct ib_device *ibdev, u32 port,
 	if (!in_mad || !out_mad)
 		goto out;
 
-	init_query_mad(in_mad);
+	ib_init_query_mad(in_mad);
 	in_mad->attr_id  = IB_SMP_ATTR_PORT_INFO;
 	in_mad->attr_mod = cpu_to_be32(port);
 
@@ -721,7 +713,7 @@ static int ib_link_query_port(struct ib_device *ibdev, u32 port,
 
 	/* If reported active speed is QDR, check if is FDR-10 */
 	if (props->active_speed == IB_SPEED_QDR) {
-		init_query_mad(in_mad);
+		ib_init_query_mad(in_mad);
 		in_mad->attr_id = MLX4_ATTR_EXTENDED_PORT_INFO;
 		in_mad->attr_mod = cpu_to_be32(port);
 
@@ -848,7 +840,7 @@ int __mlx4_ib_query_gid(struct ib_device *ibdev, u32 port, int index,
 	if (!in_mad || !out_mad)
 		goto out;
 
-	init_query_mad(in_mad);
+	ib_init_query_mad(in_mad);
 	in_mad->attr_id  = IB_SMP_ATTR_PORT_INFO;
 	in_mad->attr_mod = cpu_to_be32(port);
 
@@ -870,7 +862,7 @@ int __mlx4_ib_query_gid(struct ib_device *ibdev, u32 port, int index,
 		}
 	}
 
-	init_query_mad(in_mad);
+	ib_init_query_mad(in_mad);
 	in_mad->attr_id  = IB_SMP_ATTR_GUID_INFO;
 	in_mad->attr_mod = cpu_to_be32(index / 8);
 
@@ -917,7 +909,7 @@ static int mlx4_ib_query_sl2vl(struct ib_device *ibdev, u32 port,
 	if (!in_mad || !out_mad)
 		goto out;
 
-	init_query_mad(in_mad);
+	ib_init_query_mad(in_mad);
 	in_mad->attr_id  = IB_SMP_ATTR_SL_TO_VL_TABLE;
 	in_mad->attr_mod = 0;
 
@@ -971,7 +963,7 @@ int __mlx4_ib_query_pkey(struct ib_device *ibdev, u32 port, u16 index,
 	if (!in_mad || !out_mad)
 		goto out;
 
-	init_query_mad(in_mad);
+	ib_init_query_mad(in_mad);
 	in_mad->attr_id  = IB_SMP_ATTR_PKEY_TABLE;
 	in_mad->attr_mod = cpu_to_be32(index / 32);
 
@@ -1990,7 +1982,7 @@ static int init_node_data(struct mlx4_ib_dev *dev)
 	if (!in_mad || !out_mad)
 		goto out;
 
-	init_query_mad(in_mad);
+	ib_init_query_mad(in_mad);
 	in_mad->attr_id = IB_SMP_ATTR_NODE_DESC;
 	if (mlx4_is_master(dev->dev))
 		mad_ifc_flags |= MLX4_MAD_IFC_NET_VIEW;
diff --git a/drivers/infiniband/hw/mlx5/mad.c b/drivers/infiniband/hw/mlx5/mad.c
index 29a888b22789..293ed709e5ed 100644
--- a/drivers/infiniband/hw/mlx5/mad.c
+++ b/drivers/infiniband/hw/mlx5/mad.c
@@ -291,7 +291,7 @@ int mlx5_query_ext_port_caps(struct mlx5_ib_dev *dev, unsigned int port)
 	if (!in_mad || !out_mad)
 		goto out;
 
-	init_query_mad(in_mad);
+	ib_init_query_mad(in_mad);
 	in_mad->attr_id = MLX5_ATTR_EXTENDED_PORT_INFO;
 	in_mad->attr_mod = cpu_to_be32(port);
 
@@ -318,7 +318,7 @@ static int mlx5_query_mad_ifc_smp_attr_node_info(struct ib_device *ibdev,
 	if (!in_mad)
 		return -ENOMEM;
 
-	init_query_mad(in_mad);
+	ib_init_query_mad(in_mad);
 	in_mad->attr_id = IB_SMP_ATTR_NODE_INFO;
 
 	err = mlx5_MAD_IFC(to_mdev(ibdev), 1, 1, 1, NULL, NULL, in_mad,
@@ -405,7 +405,7 @@ int mlx5_query_mad_ifc_node_desc(struct mlx5_ib_dev *dev, char *node_desc)
 	if (!in_mad || !out_mad)
 		goto out;
 
-	init_query_mad(in_mad);
+	ib_init_query_mad(in_mad);
 	in_mad->attr_id = IB_SMP_ATTR_NODE_DESC;
 
 	err = mlx5_MAD_IFC(dev, 1, 1, 1, NULL, NULL, in_mad, out_mad);
@@ -430,7 +430,7 @@ int mlx5_query_mad_ifc_node_guid(struct mlx5_ib_dev *dev, __be64 *node_guid)
 	if (!in_mad || !out_mad)
 		goto out;
 
-	init_query_mad(in_mad);
+	ib_init_query_mad(in_mad);
 	in_mad->attr_id = IB_SMP_ATTR_NODE_INFO;
 
 	err = mlx5_MAD_IFC(dev, 1, 1, 1, NULL, NULL, in_mad, out_mad);
@@ -456,7 +456,7 @@ int mlx5_query_mad_ifc_pkey(struct ib_device *ibdev, u32 port, u16 index,
 	if (!in_mad || !out_mad)
 		goto out;
 
-	init_query_mad(in_mad);
+	ib_init_query_mad(in_mad);
 	in_mad->attr_id  = IB_SMP_ATTR_PKEY_TABLE;
 	in_mad->attr_mod = cpu_to_be32(index / 32);
 
@@ -485,7 +485,7 @@ int mlx5_query_mad_ifc_gids(struct ib_device *ibdev, u32 port, int index,
 	if (!in_mad || !out_mad)
 		goto out;
 
-	init_query_mad(in_mad);
+	ib_init_query_mad(in_mad);
 	in_mad->attr_id  = IB_SMP_ATTR_PORT_INFO;
 	in_mad->attr_mod = cpu_to_be32(port);
 
@@ -496,7 +496,7 @@ int mlx5_query_mad_ifc_gids(struct ib_device *ibdev, u32 port, int index,
 
 	memcpy(gid->raw, out_mad->data + 8, 8);
 
-	init_query_mad(in_mad);
+	ib_init_query_mad(in_mad);
 	in_mad->attr_id  = IB_SMP_ATTR_GUID_INFO;
 	in_mad->attr_mod = cpu_to_be32(index / 8);
 
@@ -530,7 +530,7 @@ int mlx5_query_mad_ifc_port(struct ib_device *ibdev, u32 port,
 
 	/* props being zeroed by the caller, avoid zeroing it here */
 
-	init_query_mad(in_mad);
+	ib_init_query_mad(in_mad);
 	in_mad->attr_id  = IB_SMP_ATTR_PORT_INFO;
 	in_mad->attr_mod = cpu_to_be32(port);
 
@@ -596,7 +596,7 @@ int mlx5_query_mad_ifc_port(struct ib_device *ibdev, u32 port,
 	if (props->active_speed == 4) {
 		if (dev->port_caps[port - 1].ext_port_cap &
 		    MLX_EXT_PORT_CAP_FLAG_EXTENDED_PORT_INFO) {
-			init_query_mad(in_mad);
+			ib_init_query_mad(in_mad);
 			in_mad->attr_id = MLX5_ATTR_EXTENDED_PORT_INFO;
 			in_mad->attr_mod = cpu_to_be32(port);
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 93065492dcb8..8c6cbf7ec7ec 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1456,14 +1456,6 @@ extern const struct uapi_definition mlx5_ib_flow_defs[];
 extern const struct uapi_definition mlx5_ib_qos_defs[];
 extern const struct uapi_definition mlx5_ib_std_types_defs[];
 
-static inline void init_query_mad(struct ib_smp *mad)
-{
-	mad->base_version  = 1;
-	mad->mgmt_class    = IB_MGMT_CLASS_SUBN_LID_ROUTED;
-	mad->class_version = 1;
-	mad->method	   = IB_MGMT_METHOD_GET;
-}
-
 static inline int is_qp1(enum ib_qp_type qp_type)
 {
 	return qp_type == MLX5_IB_QPT_HW_GSI || qp_type == IB_QPT_GSI;
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index ceee23ebc0f2..c46df53f26cf 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -50,14 +50,6 @@
 #include <rdma/mthca-abi.h>
 #include "mthca_memfree.h"
 
-static void init_query_mad(struct ib_smp *mad)
-{
-	mad->base_version  = 1;
-	mad->mgmt_class    = IB_MGMT_CLASS_SUBN_LID_ROUTED;
-	mad->class_version = 1;
-	mad->method    	   = IB_MGMT_METHOD_GET;
-}
-
 static int mthca_query_device(struct ib_device *ibdev, struct ib_device_attr *props,
 			      struct ib_udata *uhw)
 {
@@ -78,7 +70,7 @@ static int mthca_query_device(struct ib_device *ibdev, struct ib_device_attr *pr
 
 	props->fw_ver              = mdev->fw_ver;
 
-	init_query_mad(in_mad);
+	ib_init_query_mad(in_mad);
 	in_mad->attr_id = IB_SMP_ATTR_NODE_INFO;
 
 	err = mthca_MAD_IFC(mdev, 1, 1,
@@ -140,7 +132,7 @@ static int mthca_query_port(struct ib_device *ibdev,
 
 	/* props being zeroed by the caller, avoid zeroing it here */
 
-	init_query_mad(in_mad);
+	ib_init_query_mad(in_mad);
 	in_mad->attr_id  = IB_SMP_ATTR_PORT_INFO;
 	in_mad->attr_mod = cpu_to_be32(port);
 
@@ -234,7 +226,7 @@ static int mthca_query_pkey(struct ib_device *ibdev,
 	if (!in_mad || !out_mad)
 		goto out;
 
-	init_query_mad(in_mad);
+	ib_init_query_mad(in_mad);
 	in_mad->attr_id  = IB_SMP_ATTR_PKEY_TABLE;
 	in_mad->attr_mod = cpu_to_be32(index / 32);
 
@@ -263,7 +255,7 @@ static int mthca_query_gid(struct ib_device *ibdev, u32 port,
 	if (!in_mad || !out_mad)
 		goto out;
 
-	init_query_mad(in_mad);
+	ib_init_query_mad(in_mad);
 	in_mad->attr_id  = IB_SMP_ATTR_PORT_INFO;
 	in_mad->attr_mod = cpu_to_be32(port);
 
@@ -274,7 +266,7 @@ static int mthca_query_gid(struct ib_device *ibdev, u32 port,
 
 	memcpy(gid->raw, out_mad->data + 8, 8);
 
-	init_query_mad(in_mad);
+	ib_init_query_mad(in_mad);
 	in_mad->attr_id  = IB_SMP_ATTR_GUID_INFO;
 	in_mad->attr_mod = cpu_to_be32(index / 8);
 
@@ -1006,7 +998,7 @@ static int mthca_init_node_data(struct mthca_dev *dev)
 	if (!in_mad || !out_mad)
 		goto out;
 
-	init_query_mad(in_mad);
+	ib_init_query_mad(in_mad);
 	in_mad->attr_id = IB_SMP_ATTR_NODE_DESC;
 
 	err = mthca_MAD_IFC(dev, 1, 1,
diff --git a/include/rdma/ib_smi.h b/include/rdma/ib_smi.h
index fdb8633cbaff..fc16b826b2c1 100644
--- a/include/rdma/ib_smi.h
+++ b/include/rdma/ib_smi.h
@@ -144,5 +144,15 @@ ib_get_smp_direction(struct ib_smp *smp)
 #define IB_NOTICE_TRAP_DR_NOTICE	0x80
 #define IB_NOTICE_TRAP_DR_TRUNC		0x40
 
-
+/**
+ * ib_init_query_mad - Initialize query MAD.
+ * @mad: MAD to initialize.
+ */
+static inline void ib_init_query_mad(struct ib_smp *mad)
+{
+	mad->base_version = IB_MGMT_BASE_VERSION;
+	mad->mgmt_class = IB_MGMT_CLASS_SUBN_LID_ROUTED;
+	mad->class_version = 1;
+	mad->method = IB_MGMT_METHOD_GET;
+}
 #endif /* IB_SMI_H */
-- 
2.33.1

