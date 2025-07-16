Return-Path: <linux-rdma+bounces-12215-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 796F5B077CC
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 16:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A385083B7
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 14:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571A8245006;
	Wed, 16 Jul 2025 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DYygtr42"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAB623C50C;
	Wed, 16 Jul 2025 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675531; cv=fail; b=HrNEu1WK3YqZFPS/1OSpSYs/s9OWUlXB/wW+9ox098aD61NlPSGCAWbt3t3grIEmBHF1QAgdI3M09b/zJatZmKs2N9RC7f1W4pxUgNpDJA8YeNhd1p0lSINqzoa/z3DR5hCH4xKP7Ylg64fL/yurCXrSIQ5PPGF1e2wlCXujaK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675531; c=relaxed/simple;
	bh=wMf1MiYuVqfGscNPNd8Fzwl/R1nHqnsxQdOxtuUgSQI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XVJET4C1CnqwtexlTLCR3uBU1b54jxwe9UwvnnqjCHoGOKyHvq2/RasMNsODq2YwI4HpRCXAkX+CVWfFLhvnk1ufpFkbWMvGv4hdtQ4Uxa81LwOLYThfM6iBE49IHABTSZSsjqDyCqrbVS6oIdmUiywGGndhfuqYF+kJr8xNZw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DYygtr42; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlEKmajMwP1rkxXbO0BYz/BwqLLnvXLXgqY40891SbjYRGD4XNNyhmSQZe1veWX1wRin0/XSlO/z9c+nkfFb6W/LvmdS8nuugEa3cUnF1lNrl86AK0jq3dNodQ7csqx8x5VPMoz6eSoRoTcMuUzoixguaCtwZIA4AD7hf8SauYEnGs+1qBcWu0MbeszQ9GzS0CPAq9j9b7ajkuzAp0wtxm2FFT67N9dPQlkjuatyzAxgOn8dPLEANni3x1E4IufTlzU60gUR5KBycRIJ8dObJGZ5385BR3qRYPRUR7qo1533hA0Wi7YmI3HbyGLZbzICBkUmlrd9sBta4p9z8vAu2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ko6Sl0Y9dlePdJkj+GrBmp/GMdG+llMqiqTsnEIEmt8=;
 b=T4U9INVyJBV4bACQn6Rgas9BzNsLrgB/ITFJ+91oANmsnVoliekr5+zxCQMC+yEtpDU6cT0Dw8gNWd4uxVe1b+8fLEJShgEvVWTyNPOjG0imjEEERleWRnkLjcjMAohpRjuUpSUxtwdRdZvKVUXeoz46sr8P2FSWyZcJG9saBBHEzM38LtVz3N/+uuQ/Hv4H9UXXCdFEIHeoje+6CL6ywwL1p8MpwWRE+CXgzwCE8Oek/4A7XV7DYqnaY6FNRUNqNbxESpqA94DOsP4cV1lP8sfbKsv+OlSvtTTpXCApk8UKPzEpUSq68gnAAI/gdOIkRVxC7H4O5BJsOGTh7fMUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ko6Sl0Y9dlePdJkj+GrBmp/GMdG+llMqiqTsnEIEmt8=;
 b=DYygtr42ZdILd/wWiGhS9qhx19UG7ib2cPARFXvaYZSF6LGi/D2FkjQIFwROIezO4LoqMAf7de+Rv/akVJ7+/nMMiQT3OBRZqA7KiMPm/qdSmTF1/SF+d1xxNj7tNImQRRrYZNJIFl1hJERSeJKGaiJItzgI1i9Adda5tMOuefpt15K+vt8+Lz5uLcNKeH4tBvLvgg7xWKpxsoEFNrPnBjWNw87bbX1ItS+/IadsQBOVdkEyI8BGi09eNV0XPzUFeVqkZdbLLsInWnNgRvYqw7dfGY8uY3ZTJ1Zihb8H62CVe43aLpkqY0QBApzLJUCXdqr20OBqD3P2yb61huMQig==
Received: from SJ0PR03CA0246.namprd03.prod.outlook.com (2603:10b6:a03:3a0::11)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 14:18:45 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::f6) by SJ0PR03CA0246.outlook.office365.com
 (2603:10b6:a03:3a0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 14:18:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 14:18:44 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 07:18:28 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Jul 2025 07:18:27 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 16 Jul 2025 07:18:24 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>
Subject: [PATCH net-next V2 2/6] net/mlx5e: fix kdoc warning on eswitch.h
Date: Wed, 16 Jul 2025 17:17:48 +0300
Message-ID: <1752675472-201445-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752675472-201445-1-git-send-email-tariqt@nvidia.com>
References: <1752675472-201445-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: ba600238-f3a5-4ded-77d4-08ddc473ac87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sSu6vAo3C8rXcTHbq0SW7CzaW1SWTAYQUB6PntpVkg+JCnbNS/4aZxPVRPwp?=
 =?us-ascii?Q?r7pb4T9g0OcDZcTzevYypASlXd6Ljahvz+jWb0bqErF6CaYw+2ikrizOskrn?=
 =?us-ascii?Q?dQYokl7rl0IF/QAQkT3U1dyLk12j9oipj1y7b2jzdkOcMlrCJVJWUwsg+WNo?=
 =?us-ascii?Q?NrZoKExs9tk/UmVk484EJMhtpTUWtJnTShzVUlvs1ENOv7+dp9hyTY7LdFWk?=
 =?us-ascii?Q?C7TGPe22poTQC8CzeraLdmyuKMw1zjXcE2tWjwlTaiCFrjfxFt+Bn4DzIQxm?=
 =?us-ascii?Q?/NNbfsSvo4eN64MHVHGGx6k0dFnwklCY9yP5/++kILjrNcu49KxkQv5oeNqc?=
 =?us-ascii?Q?aOgBLZfN5TkuvxI1Sn2zu+DZ9RxlntJrCJk6JJ4suoGdOO1Ce905nb3CcuNq?=
 =?us-ascii?Q?nE+Pi+7klfVRZY22NImSgDD2Z6WKSGykRnZX5zXaSZinafS2BM4UQB8n0aga?=
 =?us-ascii?Q?8zJSsVyAgUf/c2XTO1bMSgAQtFRS6cDfEZ44ECay5S1uBUZLeOH0oyogaH0i?=
 =?us-ascii?Q?iLtMA+yPU0UJDdMTjzlHtp4vy26jU2rHBdkt7qMLhA0B2cLloWFyggU4YrDv?=
 =?us-ascii?Q?Dhc18j5zur6ARW6Aho+vPsA5iMixzn6mdBSKMVwZq1bhpdv9YwKF8phhD/70?=
 =?us-ascii?Q?bQNdPQJpAs02MSA1vKg2FFqMPxY8l6ZQBbEC39J6rXI11/Fb8xRDTzb0QddU?=
 =?us-ascii?Q?5glx3HOzssUk+/JlPeXR29dfwBvyR/EcY0J8JJgAkxxiQMOiBxQ7qJS6EE6V?=
 =?us-ascii?Q?nsjVqKyflocZ1VkoE5wELXBsQJbzJTiC4m0N8/FT7XSc9VnlJ4cf4SzZDHt9?=
 =?us-ascii?Q?xLwHishp/t3/+xAEcxTwTYFxWRByE+G9vdJmAJU4zw9cugXDawSaGooSlMDw?=
 =?us-ascii?Q?nIS2vYAJejnA/UDQ9p12N2hO1JoKa7w6bXO/32cxi16s1WMP1uYI0iaBaega?=
 =?us-ascii?Q?yPf7ygqrbYuHcUGa7LRP6GDx6G2l7cZKfO0ZPOiqOhqHdlbwC5tXAL341LbP?=
 =?us-ascii?Q?1OLbUEZDq++RWU/T1YS3wB24/3/xQRWwBRrcYpXhTRVhWYXvJD1rmX/mQ0r5?=
 =?us-ascii?Q?f++7fUD64L211f+hT5M/hJ1H6Fw2+muzRC2dQU2NfmvBxSV/O8Jki93L128I?=
 =?us-ascii?Q?xUwdhbSlggsoMM4TgWEuR4PRo8nYrQhEFjwXrOwCZwAewLd6zp2yL5fGKBMT?=
 =?us-ascii?Q?DjgISkXnIEMwFfu7nuay1Gp5pMe4MXYHzSjA2sm8QcWZKhzKFcFG6iPjjdIo?=
 =?us-ascii?Q?VOYq4Gj8Vo5d+r/bwvNOMXHkJIUnV+xDm+uvTTG+RmGANfYQBJpFpTVWmlOb?=
 =?us-ascii?Q?YcKwjHhXWpd2gaByCeaAPmNHuwZZB05WVBOgusTrgjUdYLCPTVUVN7h6KO6J?=
 =?us-ascii?Q?fbPicGHg/SndvE3wQEjhlaKrAdhvINvyvJpUyfxcOmsuHVcKl7G3mVtvOLwT?=
 =?us-ascii?Q?ejMCter7irPKqfi/JRqDfrI/TAs7Cvt2sVMrfPkUT6Bzd4ppkCtSlE2DIG0p?=
 =?us-ascii?Q?76fJzbb2jIA9OylX3DSBOE8jhzWniVR5KkKr?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 14:18:44.9937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba600238-f3a5-4ded-77d4-08ddc473ac87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762

From: Moshe Shemesh <moshe@nvidia.com>

Fix the following kdoc warning:
git ls-files *.[ch] | egrep drivers/net/ethernet/mellanox/mlx5/core/ |\
xargs scripts/kernel-doc --none
drivers/net/ethernet/mellanox/mlx5/core/eswitch.h:824: warning: cannot
understand function prototype: 'struct mlx5_esw_event_info '

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index d59fdcb29cb8..b0b8ef3ec3c4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -827,7 +827,7 @@ void mlx5_esw_vport_vhca_id_clear(struct mlx5_eswitch *esw, u16 vport_num);
 int mlx5_eswitch_vhca_id_to_vport(struct mlx5_eswitch *esw, u16 vhca_id, u16 *vport_num);
 
 /**
- * mlx5_esw_event_info - Indicates eswitch mode changed/changing.
+ * struct mlx5_esw_event_info - Indicates eswitch mode changed/changing.
  *
  * @new_mode: New mode of eswitch.
  */
-- 
2.31.1


