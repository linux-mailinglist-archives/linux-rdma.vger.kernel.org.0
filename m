Return-Path: <linux-rdma+bounces-17694-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LQnMgwerWnoyQEAu9opvQ
	(envelope-from <linux-rdma+bounces-17694-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 07:58:20 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3061522ED40
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 07:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D38D304022F
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 06:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE111314A95;
	Sun,  8 Mar 2026 06:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WZyubT6U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013037.outbound.protection.outlook.com [40.93.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DB13164AA;
	Sun,  8 Mar 2026 06:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772953016; cv=fail; b=rxFh0Otl54UZJfN4FhCbeOxtfhGvxTciqQzmtFG5unPLukIhxuRTIu6Zc5RaLSHLslppHZeMdMG4FxzS/MA24nCGzeDxhMYNlJHV9hsXrZh8YNpQRJo8O3NTt1UB+vixpCwfwDGwNjypy+J9+K+qtqVtGs7F04A3fnh1euJKWqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772953016; c=relaxed/simple;
	bh=+Rgr7mKNr8GnoeOClpy8SsmLjBqXsZHNa1p6QZ8tRO0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BrXHf2HId/WjM00GuvLzWJ3BVSyLj9h0C9+LHKQpouNtE4htwsHK8XRrAIvUbGDHKAcHa2qVC7fgg/0uZCNd8QI319XqxLqYMIkM1QnprwhkmU//5LlJ1xJZ6II4SoJOKhQFVvT4q9QSBcfyR63VKeIIPR7Lk/Ml955in/tuBZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WZyubT6U; arc=fail smtp.client-ip=40.93.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFUMXKquIBGAkX3/IIz/R7A/MbX4inQpwVq+VrS9niHDUAKtfF535fsGZtBPAV8fRX+lwDGB7P3UIMTpOaEsb66OpmIkp5eFq9m7EIIayfKYMlVzP8sZZRtHmDG9Fq+bwSIMHYBGk/9QHOSnwR6j7VsW34b/g7EXln8kljIMmsQ6dIl9zDNFTx8JfwjelZhC8bsmhkFiicC5jpPHq+fTkhMIW5WnZGp+UvE6ieWz9+kyCqYX9O2euKDNuI+/K0OXN3p75pShA81xk1Pcar2WkIG9Yxoi1OXsuf1kY/9xslxTxcsEc8cGdpPIe0p4QmtxvQVqKYfsXeYBeFG17lezMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3kYmlXsnpzfJ0iEobweDJAkgO3f8Pv/HfCZpDv9koM=;
 b=P4qEXwwLUUYySz9ienZ79RzADnZh0KiDqbt/Yr3g2DmO6kDAubc7J77zTA2PGX9vXTFvWBZBiW1dgkL3A4me+aJLV6YRvenwjaQMiwEQXInMwnLHB2p6/JD4GpYbgFoY7lVjR0OfXWNIKBJeT6n98PuVGJpc5OPvSScg9SiGOHj+nrJUJqCL2jzn4Za+Gka6Grt1ZXRyKtSir/RBWwSme6GRZHDPgtFClsy6IdwH5pv4kJ+kQ76GjGt7hmxZMsaYxxNJaBzlvBuVlgJT9YNQn7vtI9CsVjJZAbLeSzHyXpOMUDobaThHy6A2qLfXCo78IrgOKBsKGPV0p8IQutvFhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3kYmlXsnpzfJ0iEobweDJAkgO3f8Pv/HfCZpDv9koM=;
 b=WZyubT6UZtalPXRSLPemVuY4LzNfJVs1FPihYkpJDjv3iex2JoZQUpd/zMg1dVlvVYh97QgRgYkUPM96H5ok5OxGiFLXRh1A7/sDSuPF7E1ry8gCyCcZZLglyP1PHo2e7RpQEi/cbv2OON4kxOySwfl1W2aeudJ1b3OhkyR7O7X/TSWZBrhJeIYAEB5gKhJrxkqMVkzBPT2HpFx/cmVoPWA0e1wBPVDH263jemQMrEDwRElRlRr0G0p6v5Eum5lSgTxRVAyGVfE0VLQ47+W23dVnZYFrznB2N4swlOTgAvnyspumkcUleyTP+O99mHjFfLzbdA9izkFAnxMvcJGqHQ==
Received: from SJ0PR13CA0028.namprd13.prod.outlook.com (2603:10b6:a03:2c0::33)
 by SJ1PR12MB6171.namprd12.prod.outlook.com (2603:10b6:a03:45a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Sun, 8 Mar
 2026 06:56:49 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::2) by SJ0PR13CA0028.outlook.office365.com
 (2603:10b6:a03:2c0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.20 via Frontend Transport; Sun,
 8 Mar 2026 06:56:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sun, 8 Mar 2026 06:56:49 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 7 Mar
 2026 22:56:35 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 7 Mar 2026 22:56:34 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 7 Mar 2026 22:56:30 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Alexei Lazar <alazar@nvidia.com>
Subject: [PATCH mlx5-next 2/8] net/mlx5: Add silent mode set/query and VHCA RX IFC bits
Date: Sun, 8 Mar 2026 08:55:53 +0200
Message-ID: <20260308065559.1837449-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260308065559.1837449-1-tariqt@nvidia.com>
References: <20260308065559.1837449-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|SJ1PR12MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: 73af0f03-bbee-4da0-5802-08de7cdfdf02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700016;
X-Microsoft-Antispam-Message-Info:
	o83s+72hN25sOfw5a3IpXHe7c/azeSjDrIV7ADjZSJSVQupR+Gyjn6gPgaQh6SY1Gh0zymMVq5sQVAdRfz0dqUWXrvn76Sld3RbyezmdXTZd2kiIScZ9NHsTWc/BYNbNl+58uNFeCFnQoiJAC4PeQlKZsSujXOOA4jwv5FAlnob1atLC8JV1tKOnsKyJMHLqHWksm4u2HRF8A5W1/E0OQ7j297RnVyIqSf5IEbJ+Tevgy7ggRRIaj7BWQpKJQmTsXheTIMYvSv+FkXFHMTe8G0D42VYYbHEBbfuAtUb9ZkSjxabOGemv6myhk55JpxDT3/PQfCC2Oxnhof6WExfKt1vki24rD8qPEC328t6vC0EndQWc/+eGRwQvjCdX1DaQ1Se3Eorkx11vs4JY/a7NYbUpmyVRFk9xmE01POiNqb2aGk5uEKOXvSxXCn01Y5CaSaohnX8Cu0ozGOUdSU8Y3WkUmiKldfwMc8xvYNuOEywLepfbuk31gXiF1phjHcMaIF1gBYxFLIvee5P2KcjfEevDzkxfIFVqSOJ6zPf3M0mceL8UWwZzq02DyGAuEW7HkRALdaCIFqRzHzVMY87E/3RMGQ9cb7Ss8fNbjnMaYAXAKPKE0OTCuFxoi9W7WQk6p+WrEfzhK3Wipdn6PRxHpN1XALPOWk1mDpkUUnOSM7LW+GOfY+Pbovurq12Czg2XQSCa+5/mkkie3xB327hCr+T5LWdFsbvn0ARRbESY0UO2eAzGzBbuzJzWlczTAIBKha7ZYeyyxflfxsi0QjaRfg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DUHZSV22qnHT122zrbpughNQeOkjN9MvNuVJg2/kryG3aOXhQH/wM2oTh16MeVqNy05TuWR2UrF2sEEbc9CwpsxJeoZ2oduUue6teEHiCkHywxQuJo+GdmN3iujnP9zISHCBJ1PXlviTNc6Z0HB5ySFU3qfCOzxy5mYKZeVRDAej/flzO+6cCfeklxA2HKziZDXqKZNcjarmK8IZd73CEIN79TGZ6Xe1C6bHZrJNzwlhiQQlLixuaS5DO8iNVxgG49XBeLlf87SZ1fnmm0FfkNh3HjqtprU7UA+YZC6ApIEUBjOqfC72j6FR12riZjF6DJO9BAK8bqUwhhXTgSOMMH/oi0hgEH7T1x+sRyDPL5WwqT9lT/sMgab4aFwrdGfXZJ52Ean5JHQ+Xp/n1+bVmtMXKthxJVV/NNKLxg/cqR96GwmeCT2Z6LflIR2DumwA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 06:56:49.3980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73af0f03-bbee-4da0-5802-08de7cdfdf02
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6171
X-Rspamd-Queue-Id: 3061522ED40
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17694-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Shay Drory <shayd@nvidia.com>

Update the mlx5 IFC headers with newly defined capability and
command-layout bits:

- Add silent_mode_query and rename silent_mode to silent_mode_set cap
  fields.
- Add forward_vhca_rx and MLX5_IFC_FLOW_DESTINATION_TYPE_VHCA_RX.
- Expose silent mode fields in the L2 table query command structures.

Update the SD support check to use the new capability name
(silent_mode_set) to match the updated IFC definition.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.c  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  |  2 +-
 include/linux/mlx5/mlx5_ifc.h                 | 19 ++++++++++++++-----
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
index c348ee62cd3a..16b28028609d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -1183,7 +1183,7 @@ int mlx5_fs_cmd_set_l2table_entry_silent(struct mlx5_core_dev *dev, u8 silent_mo
 {
 	u32 in[MLX5_ST_SZ_DW(set_l2_table_entry_in)] = {};
 
-	if (silent_mode && !MLX5_CAP_GEN(dev, silent_mode))
+	if (silent_mode && !MLX5_CAP_GEN(dev, silent_mode_set))
 		return -EOPNOTSUPP;
 
 	MLX5_SET(set_l2_table_entry_in, in, opcode, MLX5_CMD_OP_SET_L2_TABLE_ENTRY);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 954942ad93c5..762c783156b4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -107,7 +107,7 @@ static bool mlx5_sd_is_supported(struct mlx5_core_dev *dev, u8 host_buses)
 	/* Disconnect secondaries from the network */
 	if (!MLX5_CAP_GEN(dev, eswitch_manager))
 		return false;
-	if (!MLX5_CAP_GEN(dev, silent_mode))
+	if (!MLX5_CAP_GEN(dev, silent_mode_set))
 		return false;
 
 	/* RX steering from primary to secondaries */
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index a76c54bf1927..8fa4fb3d36cf 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -469,7 +469,8 @@ struct mlx5_ifc_flow_table_prop_layout_bits {
 	u8	   table_miss_action_domain[0x1];
 	u8         termination_table[0x1];
 	u8         reformat_and_fwd_to_table[0x1];
-	u8         reserved_at_1a[0x2];
+	u8         forward_vhca_rx[0x1];
+	u8         reserved_at_1b[0x1];
 	u8         ipsec_encrypt[0x1];
 	u8         ipsec_decrypt[0x1];
 	u8         sw_owner_v2[0x1];
@@ -2012,12 +2013,14 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         disable_local_lb_mc[0x1];
 	u8         log_min_hairpin_wq_data_sz[0x5];
 	u8         reserved_at_3e8[0x1];
-	u8         silent_mode[0x1];
+	u8         silent_mode_set[0x1];
 	u8         vhca_state[0x1];
 	u8         log_max_vlan_list[0x5];
 	u8         reserved_at_3f0[0x3];
 	u8         log_max_current_mc_list[0x5];
-	u8         reserved_at_3f8[0x3];
+	u8         reserved_at_3f8[0x1];
+	u8         silent_mode_query[0x1];
+	u8         reserved_at_3fa[0x1];
 	u8         log_max_current_uc_list[0x5];
 
 	u8         general_obj_types[0x40];
@@ -2279,6 +2282,7 @@ enum mlx5_ifc_flow_destination_type {
 	MLX5_IFC_FLOW_DESTINATION_TYPE_VPORT        = 0x0,
 	MLX5_IFC_FLOW_DESTINATION_TYPE_FLOW_TABLE   = 0x1,
 	MLX5_IFC_FLOW_DESTINATION_TYPE_TIR          = 0x2,
+	MLX5_IFC_FLOW_DESTINATION_TYPE_VHCA_RX	    = 0x4,
 	MLX5_IFC_FLOW_DESTINATION_TYPE_FLOW_SAMPLER = 0x6,
 	MLX5_IFC_FLOW_DESTINATION_TYPE_UPLINK       = 0x8,
 	MLX5_IFC_FLOW_DESTINATION_TYPE_TABLE_TYPE   = 0xA,
@@ -6265,7 +6269,9 @@ struct mlx5_ifc_query_l2_table_entry_out_bits {
 
 	u8         reserved_at_40[0xa0];
 
-	u8         reserved_at_e0[0x13];
+	u8         reserved_at_e0[0x11];
+	u8         silent_mode[0x1];
+	u8         reserved_at_f2[0x1];
 	u8         vlan_valid[0x1];
 	u8         vlan[0xc];
 
@@ -6281,7 +6287,10 @@ struct mlx5_ifc_query_l2_table_entry_in_bits {
 	u8         reserved_at_20[0x10];
 	u8         op_mod[0x10];
 
-	u8         reserved_at_40[0x60];
+	u8         reserved_at_40[0x40];
+
+	u8         silent_mode_query[0x1];
+	u8         reserved_at_81[0x1f];
 
 	u8         reserved_at_a0[0x8];
 	u8         table_index[0x18];
-- 
2.44.0


