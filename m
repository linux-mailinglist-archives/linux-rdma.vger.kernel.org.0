Return-Path: <linux-rdma+bounces-1770-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EB4897811
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 20:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 725ABB3BD5B
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 17:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9535F158863;
	Wed,  3 Apr 2024 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dwXEnT5z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709B3155A2B;
	Wed,  3 Apr 2024 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712166134; cv=fail; b=fHhcbtL+/c2QcMSnTDLqLtScFGQ9JaN6XB3DFAAdiI5JvWc0+vNe3CEzrnMacJ0ql+Id6gxWGmbURaf7EtW76roGqhazyTHukeKcah8TQDXyz9emU4W4DiAbVhrqPDgLzgkwYVARdyLOmQogjkRp9T28DBOEIinfYQxeMlPLY/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712166134; c=relaxed/simple;
	bh=U89P/O4O5kl0+Fr6I+RyEJ6WGze1g3PD9B0psEuK6qA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/RovsIIOK6/sK41vGSrcYgaWjxBa9KoGhhtgUvs7err0IUXZAd6rGbW3S2SP1+7r4fXkub3ObHMWGqsVJkQ0OJBZjzL1q4Z1oPUjRQ0QrBJFmA5xzjwwzP1AfUQmZ5xDYDYCImORH/BQ6Eiext1c7Z9FeEugVoUuymedMCUkmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dwXEnT5z; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnt7p0SqnSVrBNWGhAN8Pl+bXMqDROvh5pu98ymUbcDPO1SeKbXWCgro7kQrZEU0BQUoVGoBxd8HCx2awYhqq07ZGivkKtPBUZMN5ah9t5iWkvTq4ywvcmIvOmHXCvJzvwoZWebuHgdw17sRM5fIAyCtnbqq+ttSlB7Q1LqQoiIM8pDbbZBiQzKHURKE3R1Sl4bLTJt6gDvzjVjqVbm+Rx6ZErvzCSeXHNvQ2/XtDs5kMIn8sgwWyIu+HkhxXDN9wyF/Ue/NyUZ6mG7Q/JNQEg41Drpr6gK+Pinz9wpR8pXXnw9waXCpjyD5UR1rO3zCYS+NjV6tUmEUc+ophcGxiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUZoypeGY62HJ9VV1/TPKAk8PBXIXSy6JZnrYASJZQg=;
 b=mRiRMrKY1iLgpEHViTMfNnJBSzQu+R9DDn3iGI5/nWVoexvuYwxZ1UXLbrkr7A0yKluRU6pt5pHVV2t8jSH3ixCK+TL0L+bpa+XfstT5VuNJGZwe+L8R9f2KFMmUmXwPY6263sAImGJFQ5WBVtu3jNMKheIA9qrjhuvyTj7xo5eDaysx85WqR1JeMqP6u/31V+eWPwpJxiIGjVoeIz6QAyin48cTj3WRp7kVBtdtvevUykM+Kub/VgR19qHt6ktR4W8L9JpRY9eweL/h8ObkODp+O841D606etd5nQAv8hhgtNkBKHPG3F3S+DczKfHEo0zeCUoBYN0sS6omlWAZAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUZoypeGY62HJ9VV1/TPKAk8PBXIXSy6JZnrYASJZQg=;
 b=dwXEnT5zD8xxYzFwMaA9zFR4j5xd87M5D+RQXqtS4i0v+0ij4RKvKG2rzf4n3O+qlXKY6mQ/335ViTxlu9Rrkrwc6fpgUjTzPZ5jdveZmdPpNhoZUwhklxzkejOaf0MZIBQt13n6yzNzYkqNWx82RbTW9gsPogv6uF3k19E/gX3dOIGU7aF5cCfSZN8g5gqpnOz0HyyIKThjGsWK32kl0EJsOUGzukkd0EKN957mhoNiIl52wK+8vrbUzmClbfKE4DOe8EmmHeU1suCRcC3Ae8twZhFJgchP4ufnwpG5o5Z8Z1civCv1COBrcHPBvNt0HRsbUJJ6RLyew8JAHqeSnQ==
Received: from BL1PR13CA0084.namprd13.prod.outlook.com (2603:10b6:208:2b8::29)
 by SA0PR12MB7073.namprd12.prod.outlook.com (2603:10b6:806:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 17:42:09 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::5) by BL1PR13CA0084.outlook.office365.com
 (2603:10b6:208:2b8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25 via Frontend
 Transport; Wed, 3 Apr 2024 17:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 17:42:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 3 Apr 2024
 10:41:52 -0700
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 3 Apr 2024 10:41:51 -0700
From: Parav Pandit <parav@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>,
	<kalesh-anakkur.purayil@broadcom.com>
CC: <saeedm@nvidia.com>, <leon@kernel.org>, <jiri@resnulli.us>,
	<shayd@nvidia.com>, <danielj@nvidia.com>, <dchumak@nvidia.com>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Parav Pandit
	<parav@nvidia.com>
Subject: [net-next v3 2/2] mlx5/core: Support max_io_eqs for a function
Date: Wed, 3 Apr 2024 20:41:33 +0300
Message-ID: <20240403174133.37587-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240403174133.37587-1-parav@nvidia.com>
References: <20240403174133.37587-1-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|SA0PR12MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: 90838744-6756-40c3-76a4-08dc54056313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9FNA6h163D1+pnEa6tqjxaUoFtXGOVyVHDUfj85tQQGl4gV6+L4lND9O12Rock64kr8m3ZqJjA+ChC/fXmJ/47VKsyfmcIB9YtoerEw0nVf43aWL1VxvkuZbbaJNv0m8SqX/IHWr/c2eQBHAkzmHHvMgUaiyp9tsFkdgHiYnGM2JSS4qfJFB1If1C5VLMiUA35L0FQXLwpiwP7yQ5nm/5S8nFBjozsqYbK73QPqNl6p/iqi50WTKp5ydsUPNp2fZ/5g0L/6yXKaXyGWRF1O8Heu+9ytDVi8J9IJv26iG2t2bg9EjccJwgmQ5veqsd0Qf6mWnvZhXSuTRFJpn1spAunGHyIetFOIOSDdmAqiMOZukKdDXig4f2yguRsnLobtz1HWQXh3T47iXnXa7LKMFvH1IuuOMHaeagC7pHF8AZRTv9uMaE2y2HF0qahyK/bQMr+nPW6jfSzHpEPXxOMvXklvK3KiDF8WSvcfoagzCqOhpm35mKnQFxrgtlJP++HxybJyaOpfWVOf7KCq6M58JYY2Bsvv5ezSOB8ZtGOjrArKb+VKMoGtMbFX0f4I9+e6GXC7ZeonqDlhBG6VCT7qRpA6Da5qSkbIlW7kUBWPljW+vdaT4t0yLl194PTRCdHxXA4ewlxiMiAvBHPgjdfoOmZGJ+V3AtkuJN4IMcHSFSChhXiAogkPGCrHskG8falSpgehW7SrfpLRWhqD/474Y96R6YEEI47Oor9NdfV4gDmTX/rfI4Hj0RZGvWEhAfxif
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 17:42:09.1682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90838744-6756-40c3-76a4-08dc54056313
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7073

Implement get and set for the maximum IO event queues for SF and VF.
This enables administrator on the hypervisor to control the maximum
IO event queues which are typically used to derive the maximum and
default number of net device channels or rdma device completion vectors.

Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v2->v3:
- limited to 80 chars per line in devlink
- fixed comments from Jakub in mlx5 driver to fix missing mutex unlock
  on error path
v1->v2:
- fixed comments from Kalesh
- fixed missing kfree in get call
- returning error code for get cmd failure
- fixed error msg copy paste error in set on cmd failure
- limited code to 80 chars limit
- fixed set function variables for reverse christmas tree
---
 .../mellanox/mlx5/core/esw/devlink_port.c     |  4 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  7 ++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 97 +++++++++++++++++++
 3 files changed, 108 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index d8e739cbcbce..f8869c9b6802 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -98,6 +98,8 @@ static const struct devlink_port_ops mlx5_esw_pf_vf_dl_port_ops = {
 	.port_fn_ipsec_packet_get = mlx5_devlink_port_fn_ipsec_packet_get,
 	.port_fn_ipsec_packet_set = mlx5_devlink_port_fn_ipsec_packet_set,
 #endif /* CONFIG_XFRM_OFFLOAD */
+	.port_fn_max_io_eqs_get = mlx5_devlink_port_fn_max_io_eqs_get,
+	.port_fn_max_io_eqs_set = mlx5_devlink_port_fn_max_io_eqs_set,
 };
 
 static void mlx5_esw_offloads_sf_devlink_port_attrs_set(struct mlx5_eswitch *esw,
@@ -143,6 +145,8 @@ static const struct devlink_port_ops mlx5_esw_dl_sf_port_ops = {
 	.port_fn_state_get = mlx5_devlink_sf_port_fn_state_get,
 	.port_fn_state_set = mlx5_devlink_sf_port_fn_state_set,
 #endif
+	.port_fn_max_io_eqs_get = mlx5_devlink_port_fn_max_io_eqs_get,
+	.port_fn_max_io_eqs_set = mlx5_devlink_port_fn_max_io_eqs_set,
 };
 
 int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 349e28a6dd8d..50ce1ea20dd4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -573,6 +573,13 @@ int mlx5_devlink_port_fn_ipsec_packet_get(struct devlink_port *port, bool *is_en
 int mlx5_devlink_port_fn_ipsec_packet_set(struct devlink_port *port, bool enable,
 					  struct netlink_ext_ack *extack);
 #endif /* CONFIG_XFRM_OFFLOAD */
+int mlx5_devlink_port_fn_max_io_eqs_get(struct devlink_port *port,
+					u32 *max_io_eqs,
+					struct netlink_ext_ack *extack);
+int mlx5_devlink_port_fn_max_io_eqs_set(struct devlink_port *port,
+					u32 max_io_eqs,
+					struct netlink_ext_ack *extack);
+
 void *mlx5_eswitch_get_uplink_priv(struct mlx5_eswitch *esw, u8 rep_type);
 
 int __mlx5_eswitch_set_vport_vlan(struct mlx5_eswitch *esw,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index baaae628b0a0..2ad50634b401 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -66,6 +66,8 @@
 
 #define MLX5_ESW_FT_OFFLOADS_DROP_RULE (1)
 
+#define MLX5_ESW_MAX_CTRL_EQS 4
+
 static struct esw_vport_tbl_namespace mlx5_esw_vport_tbl_mirror_ns = {
 	.max_fte = MLX5_ESW_VPORT_TBL_SIZE,
 	.max_num_groups = MLX5_ESW_VPORT_TBL_NUM_GROUPS,
@@ -4557,3 +4559,98 @@ int mlx5_devlink_port_fn_ipsec_packet_set(struct devlink_port *port,
 	return err;
 }
 #endif /* CONFIG_XFRM_OFFLOAD */
+
+int
+mlx5_devlink_port_fn_max_io_eqs_get(struct devlink_port *port, u32 *max_io_eqs,
+				    struct netlink_ext_ack *extack)
+{
+	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
+	int query_out_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
+	u16 vport_num = vport->vport;
+	struct mlx5_eswitch *esw;
+	void *query_ctx;
+	void *hca_caps;
+	u32 max_eqs;
+	int err;
+
+	esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
+	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Device doesn't support VHCA management");
+		return -EOPNOTSUPP;
+	}
+
+	query_ctx = kzalloc(query_out_sz, GFP_KERNEL);
+	if (!query_ctx)
+		return -ENOMEM;
+
+	mutex_lock(&esw->state_lock);
+	err = mlx5_vport_get_other_func_cap(esw->dev, vport_num, query_ctx,
+					    MLX5_CAP_GENERAL);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed getting HCA caps");
+		goto out;
+	}
+
+	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_ctx, capability);
+	max_eqs = MLX5_GET(cmd_hca_cap, hca_caps, max_num_eqs);
+	if (max_eqs < MLX5_ESW_MAX_CTRL_EQS)
+		*max_io_eqs = 0;
+	else
+		*max_io_eqs = max_eqs - MLX5_ESW_MAX_CTRL_EQS;
+out:
+	mutex_unlock(&esw->state_lock);
+	kfree(query_ctx);
+	return err;
+}
+
+int
+mlx5_devlink_port_fn_max_io_eqs_set(struct devlink_port *port, u32 max_io_eqs,
+				    struct netlink_ext_ack *extack)
+{
+	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
+	int query_out_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
+	u16 max_eqs = max_io_eqs + MLX5_ESW_MAX_CTRL_EQS;
+	u16 vport_num = vport->vport;
+	struct mlx5_eswitch *esw;
+	void *query_ctx;
+	void *hca_caps;
+	int err;
+
+	esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
+	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Device doesn't support VHCA management");
+		return -EOPNOTSUPP;
+	}
+
+	if (max_io_eqs + MLX5_ESW_MAX_CTRL_EQS > USHRT_MAX) {
+		NL_SET_ERR_MSG_MOD(extack, "Supplied value out of range");
+		return -EINVAL;
+	}
+
+	query_ctx = kzalloc(query_out_sz, GFP_KERNEL);
+	if (!query_ctx)
+		return -ENOMEM;
+
+	mutex_lock(&esw->state_lock);
+	err = mlx5_vport_get_other_func_cap(esw->dev, vport_num, query_ctx,
+					    MLX5_CAP_GENERAL);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed getting HCA caps");
+		goto out;
+	}
+
+	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_ctx, capability);
+	MLX5_SET(cmd_hca_cap, hca_caps, max_num_eqs, max_eqs);
+
+	err = mlx5_vport_set_other_func_cap(esw->dev, hca_caps, vport_num,
+					    MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE);
+	if (err)
+		NL_SET_ERR_MSG_MOD(extack, "Failed setting HCA caps");
+
+out:
+	mutex_unlock(&esw->state_lock);
+	kfree(query_ctx);
+	return err;
+}
-- 
2.26.2


