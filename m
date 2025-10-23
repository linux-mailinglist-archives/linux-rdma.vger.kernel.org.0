Return-Path: <linux-rdma+bounces-14009-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D4AC00370
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 11:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E633AFBF8
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 09:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2344306D3D;
	Thu, 23 Oct 2025 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qPsqU5M8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D02330648F;
	Thu, 23 Oct 2025 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761211089; cv=fail; b=MDfo3W+RGhlUWe3Y4BOJyfbKFSDxXBDBzQB6CRQS4e8JdbcvQ0zERtw3PfrJhpu9YJxYoN+F2xLJ1U5TJXT4A1NjtV4udQgpGENHc5TlY0rhHWzuHuqBIwYNRNpYSSmmuPM4dDpfIRtXz90adl6SCpie4e7zQYvI9foJtIV33uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761211089; c=relaxed/simple;
	bh=K56HLizxKDUJ3W80m0StkXy4iT4qj/yx403Qaq1iNrc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXlrQQlQBpPd2b66pZry0bOalPPA0JONlMPhsmkPDOk3GnUKGg8dw3vlSdStbcG//Gt+/2imcG0A7srVBarg5fzgE7F5FvPb0vi448XhZHbgqyjOigmEEJcuTezFK8mNxhmM24BuKJUq/dyRi7bYcXHjduOZwZd5clg/dLRI4fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qPsqU5M8; arc=fail smtp.client-ip=52.101.53.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIsK+NP6AK+joytq/DRRodzjehnZ3IaZ7yzL6H/flMk/T38/mE07dR3eN8h9BeGDh0MdmzBWkwZzGbiO56zBA0huhLDzad0myaBcr4QJYmW2MP1DkT6KFsuoVzR6rtmZyKNBNlTgcHy9y75NRiaZKMwCOm1XN+VSwY2D4Bbj6EFa2FWZEUVGkkxg/gJvXJBbLMpe35K2U8Yof0hoWPnorXK75tFfUb4M+FWSQO3YYd7D8axGf5X9SAh/ZCLPtnpvTMBHgAMB4RTvh/FJkEh3j0oXYtS0m1kskEc2BvOX5oDYHdqe54rdw7QsGOXwokoE5QtsWHUK6ajDRStdraDeiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1VYdDVYVFN/G8IePRgtLuB4gwO6TbJW9FZ++qiAFuQ=;
 b=ZUq72LFOAxxZ5hOBLsCvA+9gAkWs0ay7cRd8YllQ2lvLvIL0dUbORpSO75+N+xJnBfW+26pyj9mS/O6qzOa5xO0VOzeu7Xd6wlIutmlUSKddJw6YXUf7TcF1xd5N5tCEx79c7ymj4XziOXqd3q7y6wH4rPfLeuemjDWjSLkjZTzJlE0ueAFNggMppYq8Jv6JBeooTtDoEMCo3/5gnBb5KpcxGW7tYX4zKQAvnxh8A+jw/UQBBBp/UlknMJDmoEcswuoZAxIRHtCxdXLzO10NZZl0oMeyKy7KJX7nEhQKWIX4bHWL+8VLF1s8lEH0OZ3Dul8juGYbBgokWalKxxg+mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1VYdDVYVFN/G8IePRgtLuB4gwO6TbJW9FZ++qiAFuQ=;
 b=qPsqU5M85YXW+ZJ4gGgrLReuJ4ir4fhWerCgYcaBFeoeYy+NHiBYOEyfvkQo2+oiAyUYU968NRZxv2UfRWjLg2zmxJCYj3H//Nvlfa6bJcNVADQsbMlHRTGvDn7o4YBfJ+04FkxGORqn2wYlomPfpB8e/wqHF/X+n6jM4AYCnsod8W3epxByf5SNsdcbh0dF82vbrsGgo6mX6c3297aTl9ArjyF/cSji3LG0fGkTSULCDCWgTYAMm8qfs4oQYaiJEF+8isvNfStR4prZBG0zpwdaTfSUNMBX2P0BjN1if+xUS4iY9zqppVOENaxq9XhTCk0WgQcZFi3Z0avZC+rGTQ==
Received: from BL1PR13CA0401.namprd13.prod.outlook.com (2603:10b6:208:2c2::16)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 09:18:01 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::da) by BL1PR13CA0401.outlook.office365.com
 (2603:10b6:208:2c2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Thu,
 23 Oct 2025 09:18:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 09:18:00 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 23 Oct
 2025 02:17:49 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Oct
 2025 02:17:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 23
 Oct 2025 02:17:45 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Shay Drori <shayd@nvidia.com>
Subject: [PATCH net-next 4/5] net/mlx5: Refactor HCA cap 2 setting
Date: Thu, 23 Oct 2025 12:16:59 +0300
Message-ID: <1761211020-925651-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761211020-925651-1-git-send-email-tariqt@nvidia.com>
References: <1761211020-925651-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da79e27-8f0d-4487-a369-08de12151055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I0eK3iH908BVC31yzqcmOik2G/oVfmoDKGksJLuml+wdb2+lInmGUU85qF6g?=
 =?us-ascii?Q?sa++BS0DNp3n4qFOah5PjgFj5C5GN/PRoLCcPjKwru4ulrryzwkuQXrabWWH?=
 =?us-ascii?Q?3N88YYnIO/E8KOV47BcjVl1jbknuzHnyYRd08CxqCFhL5alUToik0Ga4hyo+?=
 =?us-ascii?Q?eu4YJwikopKSGsOuwhQidjcqjHNzmR0Msq/beRAFu1aw0A3DRHmJrAHszQQM?=
 =?us-ascii?Q?B28Ex00Lru/H3hMuVnclTunxoZhVV2bMGSDqzMPsumG0AItba2igiZ+ROBqR?=
 =?us-ascii?Q?oInphmE9sMdrX3EZ8yrnR0vZDvZfnV9ZWb5l7KcLiVqknKVeoEoflnyF7PnL?=
 =?us-ascii?Q?OrFY2WtA27Tum21/7kqGgITQjtVy3alJXInv1/vTRfbH2SMNYxuIT5E5aOI6?=
 =?us-ascii?Q?w8JPi0vGHOTPPtRxpl+FNw1d2++9euscqjGjbUipTdUd8qmM21q4IgtyeySP?=
 =?us-ascii?Q?rcl9DBmI+BRiQssFsh85RFwlZAsP2OQQAtM2cFkQjpM1dJAfS31axs/REOLG?=
 =?us-ascii?Q?5UEUbzsRxiwJoUHeXyCXhdoJGBRrU0IF1O5WKOyCkOWA2d35xGRaaWn1davH?=
 =?us-ascii?Q?i/3AFJaizeUEQ5NGLRHLGB4fAEak79cTTn7kTUCFNH8/N42DbCcO2tcduolp?=
 =?us-ascii?Q?fX0P5phbAWKhTCwS4oX3ylTcqGO5q+R+4jCfKuZLqZ6E45zwfgrZONdP3JXT?=
 =?us-ascii?Q?TLQIQ5mwb1A724CYKmWpNcjxLJuBUtu/l4iXdlz8nARjyuR6gBZjJtqooo0W?=
 =?us-ascii?Q?+dG731E+i4pCoCR+geVeGB+yMVsFwBh4BjxHhXqiuv/bboveHYeCmrg4H0Zl?=
 =?us-ascii?Q?4CVU6I+g7C243gJoJSvnza/3ZnBCreWgWR88u/sKyfKckeCQPS8FR/Jd1QlH?=
 =?us-ascii?Q?xonWdO7z4Pp8vP8g2RzJkrgcnIso3rChJLDg4B4KbJy5YwWTaLvXDd+6a7cz?=
 =?us-ascii?Q?b29DK9nvK6r+VR/AlpO2rK7gHBAZ0ZnyAvEri5ScP8U04pmAJnBj2DevnHew?=
 =?us-ascii?Q?bRMV16+bZ0PucKrxmIIWClF+hUM5yb5Zax3TTnyEo0DFcqyfsKbrWdHRojHr?=
 =?us-ascii?Q?8LyUkTNvpplMfnYvB1DCX4EuPUhY/PdKEDfYd7oAQ1y2azxKpw8pzs/jOn5i?=
 =?us-ascii?Q?Wk5kUsdlsParXdKrDEhMN5u47DjCeHQ5wNIJ+Yujs4NOCrbU966WGjefjiz6?=
 =?us-ascii?Q?dg4vCvH1jrAB3dzhO9ph8tFnEihbhouYqBprYXmuXr21fsJ8DXm48i+LsfwV?=
 =?us-ascii?Q?Sqp1hlFxlL6vUJsP3Ihi7Mu3iLHE2yMmnEv+NvOpHdG5aO+095iCdDwE3nH6?=
 =?us-ascii?Q?qiZ4uHgqz70trZ/NY/Z5kotfAs3njCJEFZusl64hzpB2694fbO7/yas2h4uy?=
 =?us-ascii?Q?q0IZ1NRrl+o9qD4zx+/bbyHqHunXHdx+zjpdUQCCl5UW99+twVLlSIZTnxSO?=
 =?us-ascii?Q?7tZdsvLzmp3ZQ0D2V/ZSii7BB0oKlS8SURUwZzKT1jNWuV5wEB/34qodGQ9h?=
 =?us-ascii?Q?AcUim4i/63mP3BtLxTZsmWB7WbcJD69rOCjfCuFTxy0kSFtkbTsrwFt42cEp?=
 =?us-ascii?Q?BKH9jYSjU+8JPnaeHm8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 09:18:00.9031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da79e27-8f0d-4487-a369-08de12151055
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750

From: Mark Bloch <mbloch@nvidia.com>

Refactor HCA capability 2 setting logic to be more structured and
conditional. Move the sw_vhca_id_valid setting inside proper conditional
checks and prepare the function for additional capability settings.

The refactoring:
- Always copy current capabilities to set_hca_cap buffer.
- Apply sw_vhca_id_valid setting only when conditions are met.
- Improve code readability and maintainability.

This cleanup prepares the handle_hca_cap_2() function for the upcoming
balance ID capability setting.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index df93625c9dfa..1126e4db0318 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -553,6 +553,7 @@ EXPORT_SYMBOL(mlx5_is_roce_on);
 
 static int handle_hca_cap_2(struct mlx5_core_dev *dev, void *set_ctx)
 {
+	bool do_set = false;
 	void *set_hca_cap;
 	int err;
 
@@ -563,17 +564,22 @@ static int handle_hca_cap_2(struct mlx5_core_dev *dev, void *set_ctx)
 	if (err)
 		return err;
 
-	if (!MLX5_CAP_GEN_2_MAX(dev, sw_vhca_id_valid) ||
-	    !(dev->priv.sw_vhca_id > 0))
-		return 0;
-
 	set_hca_cap = MLX5_ADDR_OF(set_hca_cap_in, set_ctx,
 				   capability);
 	memcpy(set_hca_cap, dev->caps.hca[MLX5_CAP_GENERAL_2]->cur,
 	       MLX5_ST_SZ_BYTES(cmd_hca_cap_2));
-	MLX5_SET(cmd_hca_cap_2, set_hca_cap, sw_vhca_id_valid, 1);
 
-	return set_caps(dev, set_ctx, MLX5_CAP_GENERAL_2);
+	if (MLX5_CAP_GEN_2_MAX(dev, sw_vhca_id_valid) &&
+	    dev->priv.sw_vhca_id > 0) {
+		MLX5_SET(cmd_hca_cap_2, set_hca_cap, sw_vhca_id_valid, 1);
+		do_set = true;
+	}
+
+	/* some FW versions that support querying MLX5_CAP_GENERAL_2
+	 * capabilities but don't support setting them.
+	 * Skip unnecessary update to hca_cap_2 when no changes were introduced
+	 */
+	return do_set ? set_caps(dev, set_ctx, MLX5_CAP_GENERAL_2) : 0;
 }
 
 static int handle_hca_cap(struct mlx5_core_dev *dev, void *set_ctx)
-- 
2.31.1


