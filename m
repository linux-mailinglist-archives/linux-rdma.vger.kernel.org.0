Return-Path: <linux-rdma+bounces-21099-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDAsEzHpDmqwDAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21099-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:14:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FD05A3D30
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 55F1C30589B7
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 11:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B970B3BED32;
	Thu, 21 May 2026 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nLemMPl/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010022.outbound.protection.outlook.com [52.101.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F7E3BB10B;
	Thu, 21 May 2026 11:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779361950; cv=fail; b=LXwA9IdFVvGzH8TcArFkgv2Kybs72oBEVEK1iZFHjbgftax1EBqKO70a6p+42t32CTSKadkb+KlJ1cOcbFv6dw1W3iIkooILVq2OCpscGutZ//iO1h/U82BGHmFh4MXySVilgn+Vg/EjKwot8LPkaog6F6ZqH3FrdRJ2N042r90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779361950; c=relaxed/simple;
	bh=rZgvxXAH6iDGkKSpNm9Xf/Z8TnqdxKKIuct0Kx72AfY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3+ZsXQQtEJNKAJJbZ6mLBLrdIVojSMfxdYY/nV6W0tXd+g844XSWJsRJjaejycAgcGXzy4FAlHUcbOl7TT56nm/gJV99cMKSaRZ0DmzomsrVVUc9Y3G7VZBRjVkpCoG8gCCeDeqWzc0UUAiiQ9mrlIb53/b9NSZELEKWWBhtrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nLemMPl/; arc=fail smtp.client-ip=52.101.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RcNTqIDe989V9OZ6Z85LbVF92DQp2tDq9okK/aAgkG3xwmQA4E3tkY6RxOZezULUqVorhcWTsyRUi3tfiz7Sy2WvnMXoa7zQRjHS9zFzZvuxKtin7u8zY2MUJYzqOMsRYGHba9QO5d3/uyx7nDu3cCk3TkpcdrY/2m1QDSpEGwyXdK2BtPjgTpCgPOEKxRwKC4R2Mqp3krw5HYQe9QF0KurrPziH24t5YHmtEuC9JiWUm5zssQUJMapsiEnup+kw0ZNQXL1fONFEPk9UMoamWpTvzlHdrlzALISuumF1n6RD86raVlL+6raQ9CTXSup2/hBwDu7HG8B2dsbSaHkJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzIO2likK9HK1dUCPXGfpNYqs4JYXW3HFsixUQLBNkU=;
 b=R9mpLUkQoCENHWaN2XLJMxx35AcY5HR36dW8PB2N3kkpVeGjjAEYpJl9bGeT3u6IQf66yJHQDQ2s2FvJtBoClgWV9D0vJhn/3p3FMIRZ6rX/gtgMWE96xypYWyLCKNPTGDfyUKNpZQMJzrHZJnjupyNffpJfRqcnwMxrrP5gkkwjWaaAZhAEv/HQialf1cvfodBTr/+eYlgs2liahnJKBkEkv2iUEULyelCNv5+vWWXq91TbGfC40YbsJ9OkOGcPx3gcbo8tF09QRasaxo6rQhm2406EE7/e4YEBJiar1u7oym3nO4e8uGzAeZECjAJgjdc+lmrh/Wb90DMHeYNfMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzIO2likK9HK1dUCPXGfpNYqs4JYXW3HFsixUQLBNkU=;
 b=nLemMPl/pn3SvGuAsdJxGduoLNgtJJN1fwin21shHAachEJ19m11Sm3NAVePJ0z/9pWt+rDUv83NJaujm/hoebYAe0o1f4DXX8DFu9ypayQowghumFUHX994tw3pzNM9n+X3ySLr5/hNOC63QJmCPV3rlWLZ/U4Oq176bju5Y/2yWUlf8bGoR6D54x5g0MkVwkzFo3CEbnYe8dxzP++MC2DXDo0hy3fut0RhEjoOvlQgLM0DJTv96mq/na99HFkpuY/KpyeOmCaBUxz6pryP8A7cCVjkh+9PgYfZaJMvkXnBUCjmvuDwWDnYocAxgVldEqe7bCqNywEWS6RvyCLa6A==
Received: from BL1P221CA0044.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::16)
 by DS0PR12MB6533.namprd12.prod.outlook.com (2603:10b6:8:c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 11:12:06 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:5b5:cafe::aa) by BL1P221CA0044.outlook.office365.com
 (2603:10b6:208:5b5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 11:12:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 11:12:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 04:11:49 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 04:11:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 21
 May 2026 04:11:43 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Simon
 Horman" <horms@kernel.org>, Adithya Jayachandran <ajayachandra@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>, Moshe Shemesh <moshe@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>, Shay Drori <shayd@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>, Kees Cook
	<kees@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 05/12] net/mlx5: Support SPF SFs in SF hardware table
Date: Thu, 21 May 2026 14:08:36 +0300
Message-ID: <20260521110843.367329-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260521110843.367329-1-tariqt@nvidia.com>
References: <20260521110843.367329-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|DS0PR12MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: 5da1ea2f-9648-47d4-3a28-08deb729cb30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|22082099003|56012099003|18002099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	XplOwkMheiPZIkrpCswLnRM6/qEJnNdEHWx/eRaWvbaKq5+hvjfgrisV2fcn6EbvT0/G8QpJBSGcROTHN2st8DYZa7wHZUsA5IlBpnxE6qsRpCkqtTcSvrsbZOmvVUDdb8qjXA09GfvIruESIxCoNl7SDoqXRQgmvZKVOJKvZyjkLiZRgcjYQ1JnWkYYLbp52h3qnQn8HqUGyaIX2HqLHbRdl84pPDcBy7ZIcG95yRtpILfkgruVNU4d2g3H7U11VkM59YKAoTnirgN09wug5nkQqA7UqZbaT0zt38Id1sFJ432KKRaPE63vER0xCr43VYNVO9sGSKkhLLnkspUnmEw8QNpfMxIRuLElhywgrNTWaWkcoJJKFls5k4Ks370YIIHSWIh2NqW3wV1b9hGs1EahSyob9Ttpprwtl9rls4MaTFEnwc8Zw7wXJSiDWiCM8GjlAZV7DfvyRbsIUS+yYg/RFg91hDvgC/V2isC10CYGpjnDsvuasgjAgWevHRa0gnOFUkk8OCyCJtIYvQ1Cl9Efrm5L8opE5cpF127CLSrwW9/82HUlhebfj/ew/ZIrURTLxvMX84PPbMMlUQiTPYiZPuID3lqPzGjGP6if8qG0LwVm7nOND4S0zwNoYEBWDbF8z4Ntu4GGrT3UM9qjcS4fDLBnZhQQlNGcNP4xTmHmzU9n3cCA+NDucry+p7ywUhImFBcCK9Q3J+fg+/nD/2Lac/ciwQnIsYDYsEJx1Co=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JpmT8fuV8psZT0HPPE2WlDGvkbd3S+wicc+bzZFaAhVq7MY/wEwWydaFfwNifeCpVGkbqzsYZIfkNT94OGsO0WqRuIQcp5dNVcnzXajbC+lo0ElkqWpDh42wpx7WQk6KnJ47r4IJ4Klt6+Bjy98d6QtiYz4JBBGoApxf3JEfQWG4O1zmNRYqNakluQP/4sPx+GrZFEuHhZ6AT3KrObRsvJygZiCbXKGViqkQisJp2JbugGiLXgyI0AfInn04j1Bd1R39xh2M2rj0pvxAM4a3+afB1Ln5QAI/vl0gEp6suvdO/HveO+KLgWofWnU/C6oiiKTlxTcpd/CgC4XDzZBaKLKGY3j4murCAH+oc0+qrGzS+8nS7YAR5vWmRXVmv7MdjKD4M4t4rdD/XjNyV2tlsksgEq2vi4sMOqT46PAPg0Vt+gcNvBtbYOR85nJAzgrh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 11:12:06.1724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da1ea2f-9648-47d4-3a28-08deb729cb30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6533
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21099-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E8FD05A3D30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Moshe Shemesh <moshe@nvidia.com>

Convert the SF hardware table from a fixed-size hwc array to a
dynamically allocated one, supporting satellite PF (SPF) SFs alongside
local and external host SFs. Initialize hwc entries for each SPF using
its host_number as controller. Rename MLX5_SF_HWC_EXTERNAL to
MLX5_SF_HWC_EXT_HOST and add MLX5_SF_HWC_FIRST_SPF for clarity.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/sf/hw_table.c | 89 ++++++++++++++-----
 1 file changed, 69 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/hw_table.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/hw_table.c
index 049dfd431618..0bc9146a3598 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/hw_table.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/hw_table.c
@@ -21,25 +21,33 @@ struct mlx5_sf_hwc_table {
 	struct mlx5_sf_hw *sfs;
 	int max_fn;
 	u16 start_fn_id;
+	u32 controller;
 };
 
-enum mlx5_sf_hwc_index {
+enum {
 	MLX5_SF_HWC_LOCAL,
-	MLX5_SF_HWC_EXTERNAL,
-	MLX5_SF_HWC_MAX,
+	MLX5_SF_HWC_EXT_HOST,
+	MLX5_SF_HWC_FIRST_SPF,
 };
 
 struct mlx5_sf_hw_table {
 	struct mutex table_lock; /* Serializes sf deletion and vhca state change handler. */
-	struct mlx5_sf_hwc_table hwc[MLX5_SF_HWC_MAX];
+	struct mlx5_sf_hwc_table *hwc;
+	int num_hwc;
 };
 
 static struct mlx5_sf_hwc_table *
 mlx5_sf_controller_to_hwc(struct mlx5_core_dev *dev, u32 controller)
 {
-	int idx = !!controller;
+	struct mlx5_sf_hw_table *table = dev->priv.sf_hw_table;
+	int i;
+
+	for (i = MLX5_SF_HWC_FIRST_SPF; i < table->num_hwc; i++) {
+		if (table->hwc[i].controller == controller)
+			return &table->hwc[i];
+	}
 
-	return &dev->priv.sf_hw_table->hwc[idx];
+	return &table->hwc[!!controller];
 }
 
 u16 mlx5_sf_sw_to_hw_id(struct mlx5_core_dev *dev, u32 controller, u16 sw_id)
@@ -60,7 +68,7 @@ mlx5_sf_table_fn_to_hwc(struct mlx5_sf_hw_table *table, u16 fn_id)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(table->hwc); i++) {
+	for (i = 0; i < table->num_hwc; i++) {
 		if (table->hwc[i].max_fn &&
 		    fn_id >= table->hwc[i].start_fn_id &&
 		    fn_id < (table->hwc[i].start_fn_id + table->hwc[i].max_fn))
@@ -221,9 +229,10 @@ static void mlx5_sf_hw_table_hwc_dealloc_all(struct mlx5_core_dev *dev,
 static void mlx5_sf_hw_table_dealloc_all(struct mlx5_core_dev *dev,
 					 struct mlx5_sf_hw_table *table)
 {
-	mlx5_sf_hw_table_hwc_dealloc_all(dev,
-					 &table->hwc[MLX5_SF_HWC_EXTERNAL]);
-	mlx5_sf_hw_table_hwc_dealloc_all(dev, &table->hwc[MLX5_SF_HWC_LOCAL]);
+	int i;
+
+	for (i = 0; i < table->num_hwc; i++)
+		mlx5_sf_hw_table_hwc_dealloc_all(dev, &table->hwc[i]);
 }
 
 static int mlx5_sf_hw_table_hwc_init(struct mlx5_sf_hwc_table *hwc, u16 max_fn, u16 base_id)
@@ -277,11 +286,13 @@ static int mlx5_sf_hw_table_res_register(struct mlx5_core_dev *dev, u16 max_fn,
 int mlx5_sf_hw_table_init(struct mlx5_core_dev *dev)
 {
 	struct mlx5_sf_hw_table *table;
+	int num_spfs, num_hwc;
 	u16 max_ext_fn = 0;
 	u16 ext_base_id = 0;
 	u16 base_id;
 	u16 max_fn;
 	int err;
+	int i;
 
 	if (!mlx5_vhca_event_supported(dev))
 		return 0;
@@ -295,7 +306,7 @@ int mlx5_sf_hw_table_init(struct mlx5_core_dev *dev)
 	if (mlx5_sf_hw_table_res_register(dev, max_fn, max_ext_fn))
 		mlx5_core_dbg(dev, "failed to register max SFs resources");
 
-	if (!max_fn && !max_ext_fn)
+	if (!max_fn && !max_ext_fn && !mlx5_esw_has_spf_sfs(dev))
 		return 0;
 
 	table = kzalloc_obj(*table);
@@ -304,26 +315,62 @@ int mlx5_sf_hw_table_init(struct mlx5_core_dev *dev)
 		goto alloc_err;
 	}
 
+	num_spfs = mlx5_esw_get_num_spfs(dev);
+	num_hwc = MLX5_SF_HWC_FIRST_SPF + num_spfs;
+	table->hwc = kcalloc(num_hwc, sizeof(*table->hwc), GFP_KERNEL);
+	if (!table->hwc) {
+		err = -ENOMEM;
+		goto hwc_alloc_err;
+	}
+	table->num_hwc = num_hwc;
+
 	mutex_init(&table->table_lock);
 	dev->priv.sf_hw_table = table;
 
+	table->hwc[MLX5_SF_HWC_LOCAL].controller = 0;
 	base_id = mlx5_sf_start_function_id(dev);
 	err = mlx5_sf_hw_table_hwc_init(&table->hwc[MLX5_SF_HWC_LOCAL], max_fn, base_id);
 	if (err)
-		goto table_err;
+		goto hwc_init_err;
 
-	err = mlx5_sf_hw_table_hwc_init(&table->hwc[MLX5_SF_HWC_EXTERNAL],
+	table->hwc[MLX5_SF_HWC_EXT_HOST].controller =
+		mlx5_esw_get_hpf_host_number(dev) + 1;
+	err = mlx5_sf_hw_table_hwc_init(&table->hwc[MLX5_SF_HWC_EXT_HOST],
 					max_ext_fn, ext_base_id);
 	if (err)
-		goto ext_err;
+		goto hwc_init_err;
+
+	for (i = 0; i < num_spfs; i++) {
+		u16 spf_max_sfs, spf_base_id, host_number;
+		int hwc_idx = MLX5_SF_HWC_FIRST_SPF + i;
+
+		err = mlx5_esw_spf_get_host_number(dev, i, &host_number);
+		if (err)
+			goto hwc_init_err;
+
+		err = mlx5_esw_sf_max_spf_functions(dev, i, &spf_max_sfs,
+						    &spf_base_id);
+		if (err)
+			goto hwc_init_err;
 
-	mlx5_core_dbg(dev, "SF HW table: max sfs = %d, ext sfs = %d\n", max_fn, max_ext_fn);
+		table->hwc[hwc_idx].controller = host_number + 1;
+		err = mlx5_sf_hw_table_hwc_init(&table->hwc[hwc_idx],
+						spf_max_sfs, spf_base_id);
+		if (err)
+			goto hwc_init_err;
+	}
+
+	mlx5_core_dbg(dev, "SF HW table: max sfs = %d, ext sfs = %d, num spfs = %d\n",
+		      max_fn, max_ext_fn, num_spfs);
 	return 0;
 
-ext_err:
-	mlx5_sf_hw_table_hwc_cleanup(&table->hwc[MLX5_SF_HWC_LOCAL]);
-table_err:
+hwc_init_err:
+	dev->priv.sf_hw_table = NULL;
+	for (i = 0; i < num_hwc; i++)
+		mlx5_sf_hw_table_hwc_cleanup(&table->hwc[i]);
 	mutex_destroy(&table->table_lock);
+	kfree(table->hwc);
+hwc_alloc_err:
 	kfree(table);
 alloc_err:
 	mlx5_sf_hw_table_res_unregister(dev);
@@ -333,13 +380,15 @@ int mlx5_sf_hw_table_init(struct mlx5_core_dev *dev)
 void mlx5_sf_hw_table_cleanup(struct mlx5_core_dev *dev)
 {
 	struct mlx5_sf_hw_table *table = dev->priv.sf_hw_table;
+	int i;
 
 	if (!table)
 		goto res_unregister;
 
-	mlx5_sf_hw_table_hwc_cleanup(&table->hwc[MLX5_SF_HWC_EXTERNAL]);
-	mlx5_sf_hw_table_hwc_cleanup(&table->hwc[MLX5_SF_HWC_LOCAL]);
+	for (i = 0; i < table->num_hwc; i++)
+		mlx5_sf_hw_table_hwc_cleanup(&table->hwc[i]);
 	mutex_destroy(&table->table_lock);
+	kfree(table->hwc);
 	kfree(table);
 	dev->priv.sf_hw_table = NULL;
 res_unregister:
-- 
2.44.0


