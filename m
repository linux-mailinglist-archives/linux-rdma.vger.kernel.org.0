Return-Path: <linux-rdma+bounces-12685-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B266CB22A93
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Aug 2025 16:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2FE6E190E
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Aug 2025 14:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10AF2F4A03;
	Tue, 12 Aug 2025 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fC1h8H0Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8072ECEAC;
	Tue, 12 Aug 2025 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755008309; cv=fail; b=eI7hKpXN2irGcuXB5zvB++ljYvOQumV38FW/4QwEjozgQrOQH04JR8c9LYeJ82Yc8ktAe4n/HwdU3Q7lfff33xizOyCEs0oF3UwbhJl+sJlVdf2u1KmgsfUZdbdvCCnE83z2C5A/1gVL1wPtyC2cDg2k/XC8NXqm75L7HYxePS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755008309; c=relaxed/simple;
	bh=iryxkg2fEuAQ8feQKanoP+LyXfz+eFN+TUTtQrv1fD0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnHphdrdHye8V1rIt45NjXdOlRxZTGVyAjn3pY0f1hUyF3b7KmHyj+zuRYNTNddiOnXNBEXXy24bnGLxFq5nTstU5KN970vpyCtelq9jhVdSqw3KifL0Z+d5NRvS/bP7ysI2rqbPDsC5bfNlOFCmWjwZwA+Kt4np2ezVhbXLFig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fC1h8H0Q; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kn/JOpMofzuLg4BuSPBZJbGKP7XwsWgNbG17TmAfDRGjl2pJuLh+SL9u4u35iDOsIcv7tAmt3nIJCQSqo4tjEfwbolSg9iOxc3T2dVDgIqlmMfvZGj0WFf73lIYF8uuw/SXbVh3qGPOcjLZ7QFQmLRNBqJQYMXqWXO17eStCmpUhkHk9DyXZES9seL0LTBHfauBh3kPEHYHn8j/WfZQm/gMZTWQO36UhHLkO56AsCj8kPS6+QYMDvugkgiufDWxDHkypOq3z/7fjAsN1vCnIaVstbpZXJ3mTGyfB6wqOSOLUdNhAljAjYfKLzWub4TQ9I1r2zoUFkVO88udX6jTqHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aE4JfeVGz0W4UDO829hnap6vaaaAUVtk/is55BG3f4I=;
 b=cNQUt+SqI26VCpZu0mZBc9Tgm+8h8tX6E5o5sdU9MUNDJ6+jcA7eJ/lkU01CXCVlPuojxEf1yqVxr+wgWaqoq2On4F3ok0BUhlxK8Z0GzhEg/I0/XUooPn4MQCSTMKBwdFEICW0g6DZHHr49mBQF6CYCo0tj7uisOt76vK/3zqc9/KLsazdYzUbBfJJOgY7hS7ccPUkNXtqYTZfmO9zrS1RIwYSqTlP78M9YUF/kQDM3M8US4JNkZZrYawXx4ZGuXHCdLrRnKLN+W6Qrswn9Rba5TaZjBfJ4qDOmqoGAYOPhXZgL8y1NK01RepUXQGmtuRG0hflQIz2yOOLS3rF5/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aE4JfeVGz0W4UDO829hnap6vaaaAUVtk/is55BG3f4I=;
 b=fC1h8H0QdJKylVhBBC9wYyVBzeqBvo7q5MH/Pjud3i1+d4hPrRudc2IopFle15WZgUcSf8lyxSIftFoLl61QExHsifa1p+mkDAgQg9RC5dhETAcmKpH+F9Aub+NE4KENCQJwN9qfcZm2JLOKESFUX9LZzS+IgqWIBj6XvpoU7v0ZURoP+AnjHrtIPU5JX0v+nCshpgeXCD6ji8ClGASWq2HuMz72nPDi9atJZd7fzhgwbulX7nbhdTcdBb7RFZlA2aEZJ4nSWuzQZL4SuFB2Byxw40e92Tcb+5HxcVK4LJRe/JU1b9CzvRB0BrPIHR/FS96P2jM0i3jBd9HcVseg1Q==
Received: from BYAPR11CA0082.namprd11.prod.outlook.com (2603:10b6:a03:f4::23)
 by IA0PR12MB8648.namprd12.prod.outlook.com (2603:10b6:208:486::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Tue, 12 Aug
 2025 14:18:24 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:a03:f4:cafe::f2) by BYAPR11CA0082.outlook.office365.com
 (2603:10b6:a03:f4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Tue,
 12 Aug 2025 14:18:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.0 via Frontend Transport; Tue, 12 Aug 2025 14:18:24 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 12 Aug
 2025 07:18:11 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 12 Aug 2025 07:18:10 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 12 Aug 2025 07:18:06 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>, Carolina Jubran
	<cjubran@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>
Subject: [PATCH net-next V2 2/3] net/mlx5: Extract MTCTR register read logic into helper function
Date: Tue, 12 Aug 2025 17:17:07 +0300
Message-ID: <1755008228-88881-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1755008228-88881-1-git-send-email-tariqt@nvidia.com>
References: <1755008228-88881-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|IA0PR12MB8648:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ce4041-b5fd-4385-0909-08ddd9ab1928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AtIZfolHOtkQxOMc2Vgw6bcpL07OEzPEq7SwXd7ySklv6SdHRHWx/hp2EHaj?=
 =?us-ascii?Q?2LbkKkak+Mu6OxmcLByzEGbluUJSQz4jKOx5Jj/t7fw9vksJFhdE8ZUdKr+u?=
 =?us-ascii?Q?J8X8uBpTFC8pU7neRJY/p4rTTDXonUE/jHBU4AficuxkCG29IiHdraOkuXku?=
 =?us-ascii?Q?kOA7dhoU6cEIGbw6fgLgzqXYsJemeW8yzBJ+y1MXl0W8Tf0F+pVYMVZ8vOah?=
 =?us-ascii?Q?PYJxPv3xSCvvldEXfRoPeoMm7au8DFOJoAZe/2Lt0xD+JEbKFeiwmNdOBPW2?=
 =?us-ascii?Q?UnWJI6knES9CqfDzNHMdYkqGYN2IPiiDHVRNbdUOnpSvWMOnqYUEYMiQtQuF?=
 =?us-ascii?Q?do0RknBshs4CG4hLVW3u+YP5+dqUT18e7Zbo575viBKY6a+8UaSlFPheBr0U?=
 =?us-ascii?Q?2ael9sjBtLc44YJy5MOsKtcY9q6UsCyXdpHrgq3LmTDh41NmNDvi/Zdvqiu+?=
 =?us-ascii?Q?k8KE4QuEoNtL+HgnWdwb6jdbzVPudKXOAiU9y9eA/cn4X4qGICbpnR+uVf9M?=
 =?us-ascii?Q?GMvbuJ9aSWB9s4vXXYAHw5oaVeA8GNs63fCz4l5oOFBQYd6p9qdQ8D/psZzw?=
 =?us-ascii?Q?Fm8F7XoTgxZmip8M79zD3fyoM2jcaA8DgvmsQ8EqBiqZlag40fvRpfMkM9PN?=
 =?us-ascii?Q?xjHVM8t9mx9ENqksQIkCT4Y6vXZ6HZZOINk/lHwMuljs0NtPbukJMCgi2ztb?=
 =?us-ascii?Q?AgZfO/DFIVmm5gxd0l9KAldUdLtkyaubsyLFYSMayMGoRd6SotyPIq2wT91X?=
 =?us-ascii?Q?qVc6afpsrOJvCQgBavNdq69Au59fjwHIQUKtBfjKa6KvWfHyDs8DxWCCTeMJ?=
 =?us-ascii?Q?CbJIIkDFVQiCplzrkypbUTmzQKoICVEaKyahpnpQ77BL2yuHzNUzlCP9HdaB?=
 =?us-ascii?Q?NGV6NVKPAbrI3g90d2/gC3DAtQbI7Q0pBKLfCsBQn4I8dqUEZQmTuWtxPmBd?=
 =?us-ascii?Q?12xr/pwzFO6RAWAgCJxEtxlNSvqHFtWWYDXuP66TQ1i2ZyBqeM8ZgR3XcXdq?=
 =?us-ascii?Q?WcesRDrPai0b4ewz5QNHz3/a1avGGk8eKySwoKmXo9ThDEy/fgsBbNz97YwX?=
 =?us-ascii?Q?Z0FEJG6Za5T53Wn6RAJ9sY6yOU0QfaWqabrnWVBrGsHiXI+yf+oqY6GqVfTr?=
 =?us-ascii?Q?RSP6HLYpOwPeuHoyBszN3nBYjCOukAIr0d09hfcyJYIV+A32yXZC/kDNcZAX?=
 =?us-ascii?Q?MI5i2wMekxEAgpkH9R3/zihXjwjZTks1PESQO5QwQAp5zycylWH0nYSZOZDg?=
 =?us-ascii?Q?GKqH/SCenDs52wuWT1Lx3pjOyt3xDygIWF9KDfj/ilmQGHytfVCGfAVOjckF?=
 =?us-ascii?Q?sOq4HZpIMCclouUT8PBiafRUAh9AQh4d05ipCdmLc28Nb+PA4AVEhzOTXyEa?=
 =?us-ascii?Q?IyhccBAzYbZHrjNlsps9OFDbvTdKRSz25P6E3gh89MlJEVRemrwufzUNvVMj?=
 =?us-ascii?Q?EqhIcxW/WxEdvQto9wMuzmXTBsscG3hoaMFUuHoAy1bBG/xbyirN69caSs8Y?=
 =?us-ascii?Q?6LGk1kzee+XWd6wu5NG3O6qZnQSwMIPjzt8W?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 14:18:24.0548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ce4041-b5fd-4385-0909-08ddd9ab1928
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8648

From: Carolina Jubran <cjubran@nvidia.com>

Refactor the MTCTR register reading logic into a dedicated helper to
lay the groundwork for the next patch.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 39 +++++++++++++------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 214d732d18e9..9b49bdc339ad 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -247,27 +247,24 @@ static bool mlx5_is_ptm_source_time_available(struct mlx5_core_dev *dev)
 	return !!MLX5_GET(mtptm_reg, out, psta);
 }
 
-static int mlx5_mtctr_syncdevicetime(ktime_t *device_time,
-				     struct system_counterval_t *sys_counterval,
-				     void *ctx)
+static int mlx5_mtctr_read(struct mlx5_core_dev *mdev,
+			   bool real_time_mode,
+			   struct system_counterval_t *sys_counterval,
+			   u64 *device)
 {
 	u32 out[MLX5_ST_SZ_DW(mtctr_reg)] = {0};
 	u32 in[MLX5_ST_SZ_DW(mtctr_reg)] = {0};
-	struct mlx5_core_dev *mdev = ctx;
-	bool real_time_mode;
-	u64 host, device;
+	u64 host;
 	int err;
 
-	real_time_mode = mlx5_real_time_mode(mdev);
-
 	MLX5_SET(mtctr_reg, in, first_clock_timestamp_request,
 		 MLX5_MTCTR_REQUEST_PTM_ROOT_CLOCK);
 	MLX5_SET(mtctr_reg, in, second_clock_timestamp_request,
 		 real_time_mode ? MLX5_MTCTR_REQUEST_REAL_TIME_CLOCK :
-		 MLX5_MTCTR_REQUEST_FREE_RUNNING_COUNTER);
+				  MLX5_MTCTR_REQUEST_FREE_RUNNING_COUNTER);
 
-	err = mlx5_core_access_reg(mdev, in, sizeof(in), out, sizeof(out), MLX5_REG_MTCTR,
-				   0, 0);
+	err = mlx5_core_access_reg(mdev, in, sizeof(in), out, sizeof(out),
+				   MLX5_REG_MTCTR, 0, 0);
 	if (err)
 		return err;
 
@@ -281,8 +278,26 @@ static int mlx5_mtctr_syncdevicetime(ktime_t *device_time,
 			.cs_id = CSID_X86_ART,
 			.use_nsecs = true,
 	};
+	*device = MLX5_GET64(mtctr_reg, out, second_clock_timestamp);
+
+	return 0;
+}
+
+static int mlx5_mtctr_syncdevicetime(ktime_t *device_time,
+				     struct system_counterval_t *sys_counterval,
+				     void *ctx)
+{
+	struct mlx5_core_dev *mdev = ctx;
+	bool real_time_mode;
+	u64 device;
+	int err;
+
+	real_time_mode = mlx5_real_time_mode(mdev);
+
+	err = mlx5_mtctr_read(mdev, real_time_mode, sys_counterval, &device);
+	if (err)
+		return err;
 
-	device = MLX5_GET64(mtctr_reg, out, second_clock_timestamp);
 	if (real_time_mode)
 		*device_time = ns_to_ktime(REAL_TIME_TO_NS(device >> 32, device & U32_MAX));
 	else
-- 
2.40.1


