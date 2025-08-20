Return-Path: <linux-rdma+bounces-12838-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E52E4B2DE0B
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 15:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9BB1BC63BD
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 13:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B615B322DDE;
	Wed, 20 Aug 2025 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J4IeVQYn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB492322DCB;
	Wed, 20 Aug 2025 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696819; cv=fail; b=dDY/8+UWfqo2Mu/B6rfimZlzsFeAzMWJ8pxONzxnjtRr6T4nPBOugI7G1TMV8F3v5pQDUOm2BvmH/v5aD1uQbv600PxdTZC+L39yAluzXx84Nc6RiE5AG9Z16WFUHuImbRfF0mv/63e6ZxwOn6F4cDAXVY3yyNnMe8MGWL6sRAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696819; c=relaxed/simple;
	bh=XduI2BsUpLO4Z9VMNwcENZSYfmVoijEjWqzHUFYGzts=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qiEGCHVFS0fUhl3b4lFpGZF1tClA88QhLS2sQPII8SaJjldPF76G5gxPZDBgtQSbi7UpKThVOD6RIwz/YxJefJRFDmD/VaB5HnAd0vjQQh0cZYjbuTi+kVnTa+83q4FEKMpyEk9SIclwTm2scxdTfqYjHtZiy1Qsm5B1pqgrri8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J4IeVQYn; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbnS3JeliP7FrC1UuNros5GLDq4tb0ThSfSojWMsTu12MCBi9tWXtZWlJtVPbj+WrdGhYnWl2uok7O9OyNLRYZgdH5lTT66LaoF7gjJh6sW1dqkiUSk6ARk+kPWCrVUwrQ9qj5wEi6Dv+vyfWV+4oQGC+eKuIObW5Oqnu0Dei32X1ayl/7UtHk3LQrTY6Kp/5u3Q2B+XBbyfi9O1hlEDvMfBg9f1j4v8niaYg+rnKurlYoYMgyjKLqxNrKPyiscWk/aOSmpbXjQaDzbQCXhD91HX4uP+nx7P3TIsmzliHHG56WP4Hki5EZvnXBssD5DIBadOS/p4IKbj4u5dGoPGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRcud7PpQo+6fSJRtkjHVzFyMZer1xoclqr3CNUq2xQ=;
 b=p0iVRjOmg/9dPBnju6tvGPa7ZiEO4lcADWvIk1FsQSYX65md77EOfk2CoOEYoplAi5NG0cUl744tqbuifliIVtZCy5LlvjTCfi0va4hGj/JFlrE5WOO/4ebQUuBhS4C5ivHSrMsbe/16M9n18Phdef5u+JCbl/y/56pgbiAhzrwov0NSfpn8fLUp+E5eYJOKiluPxZe8ift+2BD+eJX0XzJwGn7R8sgsWPRZSqggLB0GDxnMbX5R8La4lYbnpz6MO04u/Um7Irk6WLaZkXHD8zNn6CsGpMnG3XX9ahN9nunoKDjrgFgj/YqEsE+KXFL1pj2Sfq8tDv/kCrWiZ5mlNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRcud7PpQo+6fSJRtkjHVzFyMZer1xoclqr3CNUq2xQ=;
 b=J4IeVQYnKrxXxqC1znJZcH4OLhnNn99b/8UgLBQocx9HTj5vuxUcRn3o6eJsP7qk0xqKR7q+YJNDpRC8Ho8BYWugGyahCAtSMiD6eXY5uq9ci478bEfqJ1S0EB2e6t4tBLFn8kmhVY+SOA2Sz063hJ6FCud2wv9K4LKZtPlT35aSLrCBrD+DXlOzCW3rWIeYImq+/z3bLPt8+s7xx2h35zkEMwz8LbXDZ1R2679YF4vTEAPgBE683Guh0YJJDa4wKyiQWzIaJ5i3v282DiflCJj39YuUsxbMipo3DlldDdbr5DtQt0szyZKB2p+TECGyybMrChI6GHfGuXnqQOUgfA==
Received: from BYAPR01CA0008.prod.exchangelabs.com (2603:10b6:a02:80::21) by
 PH8PR12MB6889.namprd12.prod.outlook.com (2603:10b6:510:1c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 13:33:27 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:a02:80:cafe::e) by BYAPR01CA0008.outlook.office365.com
 (2603:10b6:a02:80::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 13:34:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 13:33:26 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 06:33:03 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 06:33:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 20
 Aug 2025 06:32:58 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, <przemyslaw.kitszel@intel.com>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Armen Ratner <armeng@nvidia.com>, Maher Sanalla
	<msanalla@nvidia.com>, Alexei Lazar <alazar@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: [PATCH V2 net 8/8] net/mlx5e: Preserve shared buffer capacity during headroom updates
Date: Wed, 20 Aug 2025 16:32:09 +0300
Message-ID: <20250820133209.389065-9-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820133209.389065-1-mbloch@nvidia.com>
References: <20250820133209.389065-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|PH8PR12MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: 965c5a55-0623-4529-d87c-08dddfee24e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NIW6+gtt6E3e6SRjbPMYFlvnMRjGEDxzCWoBqNjWVq51rM7ORRzDBdfvkDzu?=
 =?us-ascii?Q?KnyjADNo35XzWRWlRIdTILyp77zdcQDeD+yWIEZkjgDjgRsibT1HvmCkUOXB?=
 =?us-ascii?Q?kWO0ZxLnkzBho5vbdATGCdjgxqtv1Lv+Ll/010CO42mMrVAVFy0cJgg3ulst?=
 =?us-ascii?Q?NzTWARMT7doT/LAZZ9WpaiDI5rL63vJqAT9jCIWZAKXQgLq/c74aEA3apC8M?=
 =?us-ascii?Q?6mW4PvwlF+eOr6b/QHBW31sDVwI2s5gjvGxQALj7Y93GZRRFWUCrTmQGsOym?=
 =?us-ascii?Q?TfWxNkSLfs/2WSYn/5FptZgMmhl+Bvxiuzv8QitF5jzc5avo/WzwPtjzMDPA?=
 =?us-ascii?Q?rvSHiVfK+DOzkL5BkhMGap69ym3Dwl/cz0IWijxhUDCetoRBtdbg0vNNbD/q?=
 =?us-ascii?Q?WoUD3J8U7HgRXYuhnyQiDNWh/gMYByRxv9hejLe/QoWZQrXYaGVplsKqrqyF?=
 =?us-ascii?Q?imn5uS3ysLbouZ/f7fJhk3qvXeZF/9uy1cTKCnCsHMDdKED3N0R5GqtPUn2K?=
 =?us-ascii?Q?HW5Fvrv6gCIz7rWZQbV3aUeYbT3uL6fruqCgAWktHWjwdwYnI8pzvBTWfk9D?=
 =?us-ascii?Q?5ELHMnpg8qxvDmC6JFvt5l6hozm6Hy3gP2Gztjo4W3ncDNoFKGYYRGjSyh5S?=
 =?us-ascii?Q?gf/KWRydauBzUXHb8ko4UMOUOKqKfFpCU2/HH6PTcLY10DXsFbd+WNv+2Ph4?=
 =?us-ascii?Q?QATku2dp+9WgI0zHoPa/cJ2itZ/6fG22a1ZPY5CCk7rZZ2VAys8zYwkj6lMe?=
 =?us-ascii?Q?jWLlzTzfbSZyZi+dOsW0NYtm/CCXIa2MY831nMzFzR7Nxb2Z7+bZqYwyQILo?=
 =?us-ascii?Q?HdlombnHsU0tn2tmoKZp0C3AcjAeFwFeG9w76ELrIls9EdZsEG91pyQ1osxF?=
 =?us-ascii?Q?bE5KchtcjYnThGaD6ibC9k0TMVvH2qY5zEBlzv7CcDR+20jWGgsHZ6zlEu9z?=
 =?us-ascii?Q?93X5AVays42yfpK+57QpiVmZCCpwaM77bLrEqgngL94IRqMN3EOnLkmsJeTw?=
 =?us-ascii?Q?qUwQ9OQ+DjT2qBpzhXoXBQJEbxR8jrxdlHIdnOPngJ30iA4UbZP/GulTeAhB?=
 =?us-ascii?Q?D2ikO95CiPZT/KZuEDx4vlmF2jegvLIHADbf5O93PPaWgXYI+7Z9UZRKCrkq?=
 =?us-ascii?Q?VHplKXWnidCEqAuUP8jk1QdFTJX5LKbY+2BUdSXkleJ7FiAPyg9pqjctwImy?=
 =?us-ascii?Q?fEXSpMwzsUvb3xxfntL8GMQmMqqZZnxR73IdslXbPI1OWqUorH2Zy51u/tHl?=
 =?us-ascii?Q?JJH1yoN2IubQigA/Zqv3pic+QAjBlnC8+yMtfGn4npza5fLz6szNB+mKnf6E?=
 =?us-ascii?Q?iO68IUXrQwlXgWS+nBzKFUBc32Y32nXeNEo4HgfbDh4CXbTSuKMlYitG0SnM?=
 =?us-ascii?Q?5Uv7Aw8BFqxmOdwy6sZYpKSiiTjODOds4iFTC3710nNq25K7aMXi9TP4wBqb?=
 =?us-ascii?Q?nUdWzxvykY66C8AaML8C7yJFpEWIRanTwQYNKBmKB0ewEspTP2nVJVBl6dCJ?=
 =?us-ascii?Q?Jlkyz6HoLbsrEYpz1jg4I5UQ5IgVZ3xQSN7B?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 13:33:26.8968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 965c5a55-0623-4529-d87c-08dddfee24e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6889

From: Armen Ratner <armeng@nvidia.com>

When port buffer headroom changes, port_update_shared_buffer()
recalculates the shared buffer size and splits it in a 3:1 ratio
(lossy:lossless) - Currently, the calculation is:
lossless = shared / 4;
lossy = (shared / 4) * 3;

Meaning, the calculation dropped the remainder of shared % 4 due to
integer division, unintentionally reducing the total shared buffer
by up to three cells on each update. Over time, this could shrink
the buffer below usable size.

Fix it by changing the calculation to:
lossless = shared / 4;
lossy = shared - lossless;

This retains all buffer cells while still approximating the
intended 3:1 split, preventing capacity loss over time.

While at it, perform headroom calculations in units of cells rather than
in bytes for more accurate calculations avoiding extra divisions.

Fixes: a440030d8946 ("net/mlx5e: Update shared buffer along with device buffer changes")
Signed-off-by: Armen Ratner <armeng@nvidia.com>
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../mellanox/mlx5/core/en/port_buffer.c        | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
index 5ae787656a7c..3efa8bf1d14e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
@@ -272,8 +272,8 @@ static int port_update_shared_buffer(struct mlx5_core_dev *mdev,
 	/* Total shared buffer size is split in a ratio of 3:1 between
 	 * lossy and lossless pools respectively.
 	 */
-	lossy_epool_size = (shared_buffer_size / 4) * 3;
 	lossless_ipool_size = shared_buffer_size / 4;
+	lossy_epool_size    = shared_buffer_size - lossless_ipool_size;
 
 	mlx5e_port_set_sbpr(mdev, 0, MLX5_EGRESS_DIR, MLX5_LOSSY_POOL, 0,
 			    lossy_epool_size);
@@ -288,14 +288,12 @@ static int port_set_buffer(struct mlx5e_priv *priv,
 	u16 port_buff_cell_sz = priv->dcbx.port_buff_cell_sz;
 	struct mlx5_core_dev *mdev = priv->mdev;
 	int sz = MLX5_ST_SZ_BYTES(pbmc_reg);
-	u32 new_headroom_size = 0;
-	u32 current_headroom_size;
+	u32 current_headroom_cells = 0;
+	u32 new_headroom_cells = 0;
 	void *in;
 	int err;
 	int i;
 
-	current_headroom_size = port_buffer->headroom_size;
-
 	in = kzalloc(sz, GFP_KERNEL);
 	if (!in)
 		return -ENOMEM;
@@ -306,12 +304,14 @@ static int port_set_buffer(struct mlx5e_priv *priv,
 
 	for (i = 0; i < MLX5E_MAX_NETWORK_BUFFER; i++) {
 		void *buffer = MLX5_ADDR_OF(pbmc_reg, in, buffer[i]);
+		current_headroom_cells += MLX5_GET(bufferx_reg, buffer, size);
+
 		u64 size = port_buffer->buffer[i].size;
 		u64 xoff = port_buffer->buffer[i].xoff;
 		u64 xon = port_buffer->buffer[i].xon;
 
-		new_headroom_size += size;
 		do_div(size, port_buff_cell_sz);
+		new_headroom_cells += size;
 		do_div(xoff, port_buff_cell_sz);
 		do_div(xon, port_buff_cell_sz);
 		MLX5_SET(bufferx_reg, buffer, size, size);
@@ -320,10 +320,8 @@ static int port_set_buffer(struct mlx5e_priv *priv,
 		MLX5_SET(bufferx_reg, buffer, xon_threshold, xon);
 	}
 
-	new_headroom_size /= port_buff_cell_sz;
-	current_headroom_size /= port_buff_cell_sz;
-	err = port_update_shared_buffer(priv->mdev, current_headroom_size,
-					new_headroom_size);
+	err = port_update_shared_buffer(priv->mdev, current_headroom_cells,
+					new_headroom_cells);
 	if (err)
 		goto out;
 
-- 
2.34.1


