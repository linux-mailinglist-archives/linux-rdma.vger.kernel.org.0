Return-Path: <linux-rdma+bounces-1807-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E8889A818
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Apr 2024 03:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2011F2446E
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Apr 2024 01:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757BE947E;
	Sat,  6 Apr 2024 01:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JldtosWd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F76184D;
	Sat,  6 Apr 2024 01:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712365598; cv=fail; b=PZrDSOceIxXdC7ykhDX1YZirbzj4mBTp141upl0PUTBAaU2VYjA5ubDwMg1l2z7L/ZtPWEnaX1aYq1+XazIXjAdSF52Tz8S4bEhj89cbYn1Kq6exdJG/ZQmhKlkDdkksQ2KKUq8E8lm1Ynpr7+k2Eo6I75viKSK4Vzb9g2wTmaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712365598; c=relaxed/simple;
	bh=Q98nJcrOU8w1Ys2DC1fEdMg+32haoRrWHNZVCINt74Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dYddTSikCkf/PQ9M0GnhLMQsYItWL0aa4EFioVrsPa6pSAonncWegUlTjnPGqrMKz+ID687g1ja5RrUJwbBLgHCtkMJ95AQfWBtWhqXYuNe7DJwBVilryA8QZPOYgzdx7hSIVWbT1qhqN3NEVpzbTtXJNrzdpdqKQ7FCymurmkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JldtosWd; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LD2DCmSqHfWmyL00KgLHd9Th7KBzeH0ju9GYiVqNufihdGCMyMzmf/yjoz3HjvT5TeDVjd+M5Df7mkend1rLeCIaj9pK/fa58XxJrSqqLrzs4ZWQy9z4QQHfSzSnS6tM71A4R4FdZGCJP/cOBHGiIytVPXjsCBVrONpgHnCscmuWHLthRBF6apRIpx/1EXme0N6imq+UP/5ff4riFg6kNazMpDoH3gWIQi80l8KU/l3ClZc0HkotSQI+4UblAldUx9/cucBukjG4au+lSJU1XqshKMa9jPFUeovzx4eYQlTmXTT+IhOp2iebzlSnHK+Il2wfIfW2DnwpKez1lugZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Guri8Bagzrph7AfWs8WdAOa8h5QlUtR9J6DS5sdH9Y=;
 b=RfT/+q/kIFS5ObF9Df8AjbnV6J2XNsm7qcu5016qAqUG42EXpWo4Q2yzwNrzStNC2s7dSIjGNzXwfQ3saIzowsNGHJmqOcOt9elqawmpaYY3HyoX7VLYnmJjVyYRLTfR0/D2lYksZ9icN7rHimT1DXdteBG22dVBsVWwvmRgVPBrJt0aledzMMaxJ4B6kWmXfqJIKAILf0suMGmizO6UEctQItdAXUAz52szCnUt19CaEN0yhc438vWAx/RToLzuPDbx92PrzQlZGH8WzGnJYYcA3cCrSXxXf9b3fw2DjFmG5yNVAN65ShBkktJlKKZf0A88Z1Vyc5tH4Qm/diGXLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Guri8Bagzrph7AfWs8WdAOa8h5QlUtR9J6DS5sdH9Y=;
 b=JldtosWdhLJSX8B7o/8SlKWrBZfro+smVINX0kCd5VeaKC55a9IkViSBxT3CHnjUoGRfy3dC5FUUxTRdRxuBSKqt+bl36kExRn1kI5OT9xC6zZBPSOmGJckNgk256EDGKBpavOZfnKh0iLPbhDEHIKQOUwcgXMjqUACjJqkKq+zk9FQb8Kx/g2LVT14+UKmB9XuMVvg5bZIjvgqNDZic09V3HI1OMuQv2CdUnW4B6b0Y8UiBpS+nvx0SKKxu03VZt71FZEQTCQLui23WZPyUCDPA1sFqBOHZ6eDYrYeXqFzCJIY9V6q6eJvxqkhCJY2JZAzqLlko+v1fawVRELtoeg==
Received: from CH5P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::24)
 by SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 6 Apr
 2024 01:06:27 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::59) by CH5P220CA0012.outlook.office365.com
 (2603:10b6:610:1ef::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.33 via Frontend
 Transport; Sat, 6 Apr 2024 01:06:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Sat, 6 Apr 2024 01:06:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 5 Apr 2024
 18:06:01 -0700
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Fri, 5 Apr 2024 18:06:00 -0700
From: Parav Pandit <parav@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>, <dw@davidwei.uk>,
	<kalesh-anakkur.purayil@broadcom.com>
CC: <saeedm@nvidia.com>, <leon@kernel.org>, <jiri@resnulli.us>,
	<shayd@nvidia.com>, <danielj@nvidia.com>, <dchumak@nvidia.com>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Parav Pandit
	<parav@nvidia.com>
Subject: [net-next v4 2/2] mlx5/core: Support max_io_eqs for a function
Date: Sat, 6 Apr 2024 04:05:38 +0300
Message-ID: <20240406010538.220167-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240406010538.220167-1-parav@nvidia.com>
References: <20240406010538.220167-1-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ccbbe82-fea6-4480-8195-08dc55d5c905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RFFsvfb2KAujimqUtbW00uhLuCyJ+/rbCUlmA0IlNtALdBzWIoCzmGkVluOtc/XJkJJ8F1H3fRMX2LJZ9bS5atE3u80zDpTJ46lcWObX+8N3HpW+Zs07pLSX85xJplf9rcEZBhj4eXUk3N62HzL6UA2iETVcgEGajmx8h9DTgbasgfuovkPvFXc3OJj2Z3os+y0jsBk+3KnyCkG7nunj8bYkQuRaU75IUwuH0q6t80aEEs0ic9vvgHZJqC4WZKJiGkRQrfcfE1ObSZK0h3J1PeOS6Bx2VDK3gQ9GP7JqHCOB8dKM3kxVdEDjgEY3ixHpaFm/1nNQE6zhUK5Zrlgz8UMeHQ9JBlQCURnrCCnjT6FgiyGF68sHuNruR9FhCcS7Mw8ZOv6YKnmxs/5mqdbe1r652rcYGZKckwmZpzh33j6DDEjvTyhJ74VNaoZ/aktsHs+mBXQ7y4QhQg8mwEnzSac2s0BDW8oZ7loesjohMUqy89IZyhX+fsjAhJ0bogBpEkXyg4D9GWk6FMMXFvqAOs7+6H9mKNjnTKZGBmUHVDSV/GZrjpgkR6JTX+DVOUf7jRwWG2zEOuLkdxKPD0smfpbuGDyVYKNthKRE/jX/ueCijaejP9pq044cf6GuYOFb/ZCfvr3nIJQOQEEW6e79YFdplEpgtTpyjznGwKCT8gY6HBuyJAoept/2L75so/ukJINAGtCF7XzMMKM1w4SuGxrmnvnWSup8SMwU67O6dqKGd5CK9vyvX1EiA5fHrMgG
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(7416005)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2024 01:06:26.7181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ccbbe82-fea6-4480-8195-08dc55d5c905
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941

Implement get and set for the maximum IO event queues for SF and VF.
This enables administrator on the hypervisor to control the maximum
IO event queues which are typically used to derive the maximum and
default number of net device channels or rdma device completion vectors.

Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v3->v4:
- addressed comment from David
- replaced open coded overflow check with kernel api
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
index baaae628b0a0..20927f65ac2c 100644
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
+	u16 vport_num = vport->vport;
+	struct mlx5_eswitch *esw;
+	void *query_ctx;
+	void *hca_caps;
+	u16 max_eqs;
+	int err;
+
+	esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
+	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Device doesn't support VHCA management");
+		return -EOPNOTSUPP;
+	}
+
+	if (check_add_overflow(max_io_eqs, MLX5_ESW_MAX_CTRL_EQS, &max_eqs)) {
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


