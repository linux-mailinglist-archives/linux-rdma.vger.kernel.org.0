Return-Path: <linux-rdma+bounces-13549-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AB7B8F3C5
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 09:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F8027ADFF4
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 07:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59C72F5338;
	Mon, 22 Sep 2025 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j4u+x2Rz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3DA2F4A11;
	Mon, 22 Sep 2025 07:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525139; cv=fail; b=KerZxea/DH6cdSi7fV+nYd0iuFbgIIh52w7jzuRY3+HlnlWjqhkLjz5DUQGmFditlABG06O6UNjQlh+qnOrWGRSQABe90jtDLUyNWjtjl15qNS6ftFM1z8o1kNTTtLGxJWPgwteZrAidRE1vQOF5S6Yg2T5NHjXbjpOtHlaetUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525139; c=relaxed/simple;
	bh=SkX8Jo1HwznnRXR+yXh2LUHlLVTtZDjxa0SJ37c6ODY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AdBcKYyBKyBHDW0ptZfJ4ZVDpWwazyW2x/LemUB1kBsCyQdWUTqELSNvunUTIJGFSQP0v3f/WC9kD0iGP8SnkjODtOgqhjfSBx9yQDTEzeAs2XCD2D4/v0DQYLHGK0uinRwZnPyfB/8Njb1/7ZbHmvf75TioGnylBBwgyqxMtbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j4u+x2Rz; arc=fail smtp.client-ip=52.101.85.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vd+X8M/Br8VPeyr95GDrNhQcO1y+gPByYB3qPQXUzHSmK0rluATjWgnpDsLNFx6veVqH82BL9mBcM0mdbVv2fJUjCzK1SGEpOzCPdz1gtO77YEyT9e3bKU8OSRGid+YdZwSng/AJSAAn9PRk4ZHQrkIWJFQJVEgM4P73nKw9sqUf6YiWRVTml4wvPCBtlAeSLKgJPWo4vDDTA/n1K45Lu1f6mh2tmqZ/xoZCA2FucE9ToJYBLd1EBQQYxWOr/cxTN7dkKs4ugggB12iUr4umZ73XrxvEdjj6n+nKo7taXcggObOM8T2AdrfiJXRir9+/M/x6nPEPUxq55cMk2fCmYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrHOkMm+WVkII1dtJ4A4XInJycLNTSfF7DXG6m+M2i8=;
 b=Ebmunuf2yJuvgYIKHd8Hv6QPhDHhKvmBgg8blwqLOafky/hYwRuynF1emglPtpoTZpNZeZnNWwtjnmNtTe8K7/TnJOs+qVEmTQUBaAalB96aYAf/km+A5R8zPJjpOBuIOySwuLA6Z+OoMsqNHA8kWYmeEQ/+huxNby9iCHKi5PeT8lELzojmJQz/H+73tXYQlL7mnLC1AZiLzJfh5FWfFMQlQpBy9s4+g8XPQ+AXUzNdYqM2bbCgP8jy/pmZceMJfVSLcjWzLitbpI+dll5MTKmYzy5uILDksYH9zaNnvPByZByqQeLKqV+vkV3UXSsOi9eTnXJQw/KDBv7jOLnZ3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrHOkMm+WVkII1dtJ4A4XInJycLNTSfF7DXG6m+M2i8=;
 b=j4u+x2RzS3GjFd+LF+33ZNoHZOvDO2TynwKfpJAfkdJGRSl8SyZrEL41uw9gtWLZUGJeDbOa8nMpttM9aidoifJ6l2hW27mk9RSlEDiyQzvLjtQUaQ+GqWyRv80+sfDqPSyYPnIAflP5NwgYMu46LmJY3N4Ftrf+hBFZbm5lQs+Aq/FCIGL/gDi4UzCsce95B2fMXYgcjGeIu10NVR9juNsvuynYGOHHOh7XFaA5+S4+A/4VCAaimrx25VYZ3c9hEfCGqNpU86Q0AuYqZLiHDUZj2rXZMViQmAQOCw1DoRDhb6YWE4MQNOIR5lo81hZ67RmWNt39lW7n0gIYfyxeSA==
Received: from SJ0PR03CA0032.namprd03.prod.outlook.com (2603:10b6:a03:33e::7)
 by MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Mon, 22 Sep
 2025 07:12:14 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:a03:33e:cafe::cd) by SJ0PR03CA0032.outlook.office365.com
 (2603:10b6:a03:33e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 07:12:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.0 via Frontend Transport; Mon, 22 Sep 2025 07:12:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 22 Sep
 2025 00:12:04 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 22 Sep
 2025 00:12:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 22
 Sep 2025 00:11:59 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net 3/3] net/mlx5e: Fix missing FEC RS stats for RS_544_514_INTERLEAVED_QUAD
Date: Mon, 22 Sep 2025 10:11:34 +0300
Message-ID: <1758525094-816583-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1758525094-816583-1-git-send-email-tariqt@nvidia.com>
References: <1758525094-816583-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|MW3PR12MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: bca3c20c-611c-43ca-ca74-08ddf9a75b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GaqOe707qThIGP8MdAqXoKEm0z1VTuRNmyb7FNKPaUY7Tsm/9i7NBi4RNKcG?=
 =?us-ascii?Q?3zLNqMurMHW2sIEMKO+ihkM2ZKar2tiv6gxgsIkVAoS/JzX9OmBICnF0fDFn?=
 =?us-ascii?Q?8j34fQdHtUXVVvGKEHTc0ueygYI/zzp8c5yH+AOEWR0CHh3qHA2rYwyeRvWm?=
 =?us-ascii?Q?rgep3gUDsg4gl3ovlDaUGIbvGJWq0I9cIsO17++RffQdaecSToo7LGn7DxUM?=
 =?us-ascii?Q?WFAfiXETnkM5TIXCPr4c3Jw42z+ejU1YaGSOP+ZO7J5WAWMOdYfd7MJ1O530?=
 =?us-ascii?Q?jhHUR4FcD9jA0j9qPMybZJQDRMCGT5NpKGo9XQTRzIs3KoVkTO5P/kPTFv5S?=
 =?us-ascii?Q?6KWMw27FpnFhGTVuCIKra9NoqE3ftqFHfaxPeEvSxBv4TGHJi+Vg539grjhm?=
 =?us-ascii?Q?dP6qe1iI3mLAmpwuKDNkE+z+AubGiHmvR/O6xosT+81JOPjLpzhy9GOfvUpq?=
 =?us-ascii?Q?gL+OtQ+J/El4ZdvQA62ZAgKmP0FpZzmG0Ja2AfKtD1VSCKoTjPb39Al2vLVP?=
 =?us-ascii?Q?slPTdBjNRlhomoejk9qRYUALQH1It6/SB6NAnMrPXvUCRZGxe+bQykzDdeQ7?=
 =?us-ascii?Q?qgNCy4lF0SJSoLQxfpBzCtIQVrafMXOfjU/Gl2Lpt83zFSE5u2vJN8FAziwX?=
 =?us-ascii?Q?gkG74dpSsu2Zy8bHL3Y4dg3Z5y8oR3Zpb4F1ccMpopQw2inz6hqhhTqCwgxI?=
 =?us-ascii?Q?c8eik+CEDpfV3gr7SPy021V/UqOorm9AQnNcg67gAyJMRM3Fy4gupXKDobez?=
 =?us-ascii?Q?1JZ3o+/ftM/IFK80lJnXOyC+9cft9Z2R1SJmxyQEKUdl9mqAhRwtqvh4Ydhh?=
 =?us-ascii?Q?kN7yqyQYDOZPhXloyUBtL2ji8JSF9wuWfpYh+Oz4mIKKcFI4J57S5qDi14QK?=
 =?us-ascii?Q?J/x3L4Yl7Rin/HLeJm7dIq1e32IUp+vMM9L9UuNDY2c/iuZ9KMqcCB+rXjTI?=
 =?us-ascii?Q?ZkcPi+MEhi7mzvPgLzkHmM3KGZaYoxMxF1u0lF64jKiQjsHfPYpByENIhZ9e?=
 =?us-ascii?Q?7qrdyx++mxmqM8ienuLHMUEWXXY7QOkvfYeYNmul7NirxEs1VR6mJlvVYf0H?=
 =?us-ascii?Q?wdRb7nuHmUx8XAHN8lzVJLaNGINI5DUb5Tkr6SaX3YjL+67yys/5mM179Pga?=
 =?us-ascii?Q?8myveCA7a8zpAZuAewxdclWQPpB6PeCbFyiG+yI0iBxqLi/04bkvP3SEXM7M?=
 =?us-ascii?Q?YjVVdLSvdNraTGy0bmfykP+PcC5V54Up2yGRgZb7Iha4NXvUdFlftxzvGcl3?=
 =?us-ascii?Q?RQvnGxEu5zvZi7sHSBJbn+yTJROXlPvM2ATwrOhYM4de7EJRM++LIjj7140K?=
 =?us-ascii?Q?ct5zXsc/MLiKhVwFdf5uBtOm4DlJjzmWVyoSfv4nUBzQH1olpG7/2J6ThZ2P?=
 =?us-ascii?Q?TV2wMdwkxXMRlpsdDSlabSdn16cSOGvAP3EPP4ttGLfV0gFzKlmobclPZKfj?=
 =?us-ascii?Q?NtGQZIHnWOcC5Pqso39XYSAr2PoAhNM/mN9YoHrPV0H4qydq+0TsJIGDHSaE?=
 =?us-ascii?Q?WrVlryUbHkClv5ZSx7oOdLyxxK5QEXNS99UZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 07:12:14.7563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bca3c20c-611c-43ca-ca74-08ddf9a75b98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442

From: Carolina Jubran <cjubran@nvidia.com>

Include MLX5E_FEC_RS_544_514_INTERLEAVED_QUAD in the FEC RS stats
handling. This addresses a gap introduced when adding support for
200G/lane link modes.

Fixes: 4e343c11efbb ("net/mlx5e: Support FEC settings for 200G per lane link modes")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 87536f158d07..c6185ddba04b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -1466,6 +1466,7 @@ static void fec_set_block_stats(struct mlx5e_priv *priv,
 	case MLX5E_FEC_RS_528_514:
 	case MLX5E_FEC_RS_544_514:
 	case MLX5E_FEC_LLRS_272_257_1:
+	case MLX5E_FEC_RS_544_514_INTERLEAVED_QUAD:
 		fec_set_rs_stats(fec_stats, out);
 		return;
 	case MLX5E_FEC_FIRECODE:
-- 
2.31.1


