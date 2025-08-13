Return-Path: <linux-rdma+bounces-12713-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39915B24C06
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 16:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D97D727210
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 14:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0BB2F83B4;
	Wed, 13 Aug 2025 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xwel58V8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F3D2F5467;
	Wed, 13 Aug 2025 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095530; cv=fail; b=hlflmpsfpXCB38WbRe3ufRLyjcNw7USSh+CrTIulhlBImDk8NgXDY+OSbkayOTGd8EgSHNOu+SEXimFGCfsrQlzr6y4hQkBc0C0dovQzliifZ7AV0D7XkBXlx4ShHXrBJMwmHQi0sOFg/XE81eceatMCBrT3vIhJvVKZreQTOMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095530; c=relaxed/simple;
	bh=lOV1hJQfGfWvQKR/O4v57DzJJ2AIs0sCUIozrUJ3L1E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDXp3yYxscK5+YoiviFYLkPZdtMdrBfbOqErPsK9WJ9EuJDqmspnC+Q327PeY+O2sAMdRHFRqR1Fu3YVlp3buEyLwpgDv6BCtZmqwnq/ZbauKJsorhRrF6iJEUnjY+QmR3R8v/d4unjslqI9eqqaVC/iOWPNWiPg6J/sREoG/W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xwel58V8; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVq0gI2UKF/4eNfZ0W+gknkga51M78IxO0FvIUKZNKZYIK5DbLvX5ob47qv4R2YOrJMR6lkACJu2MrY0ahg2TpiVeBRbJ2jtxSvHJ5aa/9W8KEt4o3WmS9DQLhywQ/Kx5iNuJGIVAKcO6bLqehVpq65Bq4zaEjGgaOh5bA9aiOJUwcmIQTYOSQsZNU6lC/gd9lPpdqs1IfOE5HbM2Qq88NnBYPGT92A0Et3312QFprOlFd0GzBBRfcUTM9peFGYyVxD7vGLMlu3fcHbOgXLTdTBbHVP340KKaTAmc/7mYNRBJt0zWi5BkCkd9OdOSQV1gw6fO9UfCb4tZnS4Vcv7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVpOt6uG7AIVl4aSuVKifmtjpaTNvixXv7sfO2+ianY=;
 b=sLqA7yvrLPfKz6x1w+Rr7YbDLucFYkPhG8WWG2h36y2DaHUwRPbNlgzMD9wwiSVdMz9km/tF6lRb7Nt6rfmD4Sr5evb9mvcjQeCaueVNiA4PqbXb1FMjQQYT/jbzvo2FgMDJPNW3Ou/gXotJR9vorsfcnK2OIqr36M5qqltv6vCXTDI4W+AJlnTxr5KV6NSiWRz/143s2xmMCMCmfiMtmM3l6UVPT0eiVdYWNcjYp6hCtKFgxScF3Cn6bc92EEeDEz7L8F/KaJTLJdZQaIwLIb0nDX/2rafaLQKWqdbBhQEfineq+t4CRXulWl+9L6pxiktUftTwN4uvF5un2acxgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVpOt6uG7AIVl4aSuVKifmtjpaTNvixXv7sfO2+ianY=;
 b=Xwel58V8RSoudK45Ml0Q6osTje7o/RO4mC/XC7vGke+bCcE9XSq9Ien8s9rritOxHEMkxbTHpEmklwThj9NGMzD6h1kOggRdCmTv3n5W4dfAiUNaqfSiGjQnZFnVwMEL8lKYFeuoApu75mwo7NwiAnmWSvVh0idyb2ChwbVzquZI7oSAtRtSBdjX90O9mTc8LdlUZDbhGYUrFslBWufczoUv9hPjXhXHn8WBfL3T0pOpN9cERR0oz9LN98dRU4QArJH74BQXBPO1ZdLnKJWyVIbVB+JP+24rnwuR5fJgYYL9oC4wfZKGwAdFBP8WkxKZW1vlOXLCFhrZSvUcELxOzA==
Received: from SA0PR11CA0209.namprd11.prod.outlook.com (2603:10b6:806:1bc::34)
 by CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Wed, 13 Aug
 2025 14:32:05 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:1bc:cafe::5e) by SA0PR11CA0209.outlook.office365.com
 (2603:10b6:806:1bc::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Wed,
 13 Aug 2025 14:32:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 14:32:05 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 07:31:48 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 13 Aug 2025 07:31:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 13 Aug 2025 07:31:44 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net 2/6] net/mlx5: Fix QoS reference leak in vport enable error path
Date: Wed, 13 Aug 2025 17:31:12 +0300
Message-ID: <1755095476-414026-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1755095476-414026-1-git-send-email-tariqt@nvidia.com>
References: <1755095476-414026-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|CH2PR12MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: 836d612e-87bc-4d38-3ca5-08ddda762cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WMVyu+p7NilZfw09sjYQcY8h0VNDWaVVWws9JqisFpTu/SEUY3XC9Jzf2pH2?=
 =?us-ascii?Q?IUHRHhQhc/eaogD1gIIG2YM1/6EZs4I5vtX4Ewk8lzab8ui0VAHSrjk+rMNU?=
 =?us-ascii?Q?puBIyK1AGKZuDd7yaES2QbQ+aA9O+1RkBHL4dXen3WrybjQWm19i62Zq/AOG?=
 =?us-ascii?Q?veoeGaL5aPWWDL3dzj+lrNT//n2owMjE+0rxIINWIcYQwd/l9U4thxT3TCzU?=
 =?us-ascii?Q?3l8swPwLsSL8HeNWBkDfD71PCH9K+8vf+ejjDRl4koJCwEjN5ivyuhpAKhAo?=
 =?us-ascii?Q?R09ZO5MbLDnwKdHcPWqkr/GklPytgLA1Qlhs7E2pdmCxccgM97ERCUCbAmAo?=
 =?us-ascii?Q?TZX4h17LZ5GyoJuBEj036/9TcXUCSaTE1l5QMH1CJFux3QQyeU1znmi7qGge?=
 =?us-ascii?Q?e76Jb5fXxZxFdGOclhac8miSL6fP87NdjT9O0tbb8dbmKBsvaTtxmzx4iWNK?=
 =?us-ascii?Q?GThjLjm2OOJk6EA/F8VC9+9N48RArr/6Lyscdmwj0HnXoIUcy55//r6Q0JtN?=
 =?us-ascii?Q?QK59f80PPkKGYL7XglJvDkMq8fAkoRHhISw5FCsBwE9cW0QHmULL3Bu89HFh?=
 =?us-ascii?Q?QMEurtRuSxRCDBas1BszzrgqqLtNpMpD4IuHP5r+P4jAX2T8NJfSLN5LiQiN?=
 =?us-ascii?Q?GbfLUgAcnhNBvw3FRzk1ZTTYtsCfRYr9lDRF+pdrN2V5KCv4PxalxdY9HKky?=
 =?us-ascii?Q?7xGZaICw18Gy2FEOGHfb+93MpfnWwSinq3xgwIibgnFkWxfDDU33GtClvpWH?=
 =?us-ascii?Q?nSM1gxEVPVMKJa+yKVztS5Ihhh7l68d7rOGM4OMVoOjIh9aMjBKhe6meAF07?=
 =?us-ascii?Q?AVS0ktSw7OjIg4B1PCMkpMLhd/Rive8mli0nKgbNjym7qIzQYivowzz/iHde?=
 =?us-ascii?Q?uGCazHzZXGNpIQgQicQRGnbvZPZ0LPVFIAMvgTDVDIBBnXlb/oJpnCQsZNip?=
 =?us-ascii?Q?Sw8uNexYizBqQos6YInL6HBoGIj9Y61NeIrQinnz/qVaGSZNwvtdMIy2FaVO?=
 =?us-ascii?Q?aUOE0eWjHv7j5u2rHi+zZWrs8yYAntVRKFOjJNTnFtRRiP7xPgfUpyyUxG9x?=
 =?us-ascii?Q?KEu7b5CIXfl0ZKz3k+nUk2YA9Hd9hWBrT7D3WFmpNdBFnZVFYvh7upJP54LE?=
 =?us-ascii?Q?s7PmSOwJyT+BhwXzhGXlMs6iAB2FI2Dwheeo2GDivwtANjCqM/m7Ahp4BkTk?=
 =?us-ascii?Q?Z6ePVZrU5k/aAIpevgQ/WEyS8Jg83eN+DXFHPB4xYr08DCbnEPxQRFEvzFRh?=
 =?us-ascii?Q?35iS5EaK09lKiu6FhJ33XFN9LA8D4+6ySW8wxDvHstMF/cTc4Qpmt34xv3jH?=
 =?us-ascii?Q?gKDWZyF7Fabpg5T17ZIkpemiy5+GXuaAtjlscZKF8Yx7cV0z5n1JsHxBDqZ9?=
 =?us-ascii?Q?EnaUXfYv7o8loyrjltYJqgI8p5Xi02y+KOskkisOQ9mh8lSMNZT6DHSKKYfO?=
 =?us-ascii?Q?bO8SQVJh8GbU8yVfzb2wv253v2y2rH2BrGYuw6qheuJt+5Ikn6UlYVxSi7rY?=
 =?us-ascii?Q?szYcRCPBkQifgP4rubKpKLLTtsFwODeojJ1e?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 14:32:05.0000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 836d612e-87bc-4d38-3ca5-08ddda762cee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103

From: Carolina Jubran <cjubran@nvidia.com>

Add missing esw_qos_put() call when __esw_qos_alloc_node() fails in
mlx5_esw_qos_vport_enable().

Fixes: be034baba83e ("net/mlx5: Make vport QoS enablement more flexible for future extensions")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 91d863c8c152..79d6add402d7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -1141,8 +1141,10 @@ static int mlx5_esw_qos_vport_enable(struct mlx5_vport *vport, enum sched_node_t
 
 	parent = parent ?: esw->qos.node0;
 	sched_node = __esw_qos_alloc_node(parent->esw, 0, type, parent);
-	if (!sched_node)
+	if (!sched_node) {
+		esw_qos_put(esw);
 		return -ENOMEM;
+	}
 
 	sched_node->max_rate = max_rate;
 	sched_node->min_rate = min_rate;
-- 
2.31.1


