Return-Path: <linux-rdma+bounces-14010-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB13C00382
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 11:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3063B0445
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 09:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF093054E3;
	Thu, 23 Oct 2025 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xxy3QOUc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013034.outbound.protection.outlook.com [40.93.196.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C014B2FD69D;
	Thu, 23 Oct 2025 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761211098; cv=fail; b=cOL/q0hk2S4HObE9o1aVy4Pfz3VLtel+7UhNcxt6cXQ74uEdjmnkpgLdAoYGbNZd31i+Hq+eFRyfw5TrAgJ9+nwBaDP6WpOoWJKGwj19WXYKSqgjorVt8hR5gSMVUZ/8XoVpMsbLA5o0syaHtVF/CEQSSuBH7ZPa/jk2Tz9VCOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761211098; c=relaxed/simple;
	bh=reGdWMpEUnkYHkraXym/2KHUGmWnK1tYLDmSZvb7jt8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgxAznDNZ7faY5HVr01bygZK6xRt9WPD+57M+TcSK+6O/NKLAELUzdLG3Pw+neJi0Z4sonLh99GOfnrTIfEoBKYMspMoXLhmv6o+HpJ6pdmeKQ1Ozun/aVs5AiAcNjJz/8sCW7i6V0AQG77WU+0CVXJk1aKzbgsUfXoWqCbxeqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xxy3QOUc; arc=fail smtp.client-ip=40.93.196.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBQQFyP2XIC51TSWGtGjinrd+Uh3x7wTuBdlQcddus+14snTLm100y/yucfzLJTC4xfGgqWF+Tj+oViAuf1oMwKgBKPcAkXLyHjSYwjGhqZNEHoR3lVEysUdpM5Gy4McZW8iL69k0g5+Eq49gl/1J1poCTRNkhhIVuH7HdZEbNNe7PrBci0O0HDE39RRbuR+CJfXGI8IxYPPix45Cgg5EmvYiICbEINLmtCsT3+Y8YURXHur30epGB5oYUSCZ2dWGVDIJZmNkuiLDGjnt/yho3QyaMk8coo8yZLz196ziWBhgW9cM+J2Ok+abP/30v70dkxBosPR+fR94NFvdGz6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfdeAM4BQKA15F7TE9b10BYOmZsoj/T+r01MZ4dOlxI=;
 b=BEN5B8d6QBLC0s65OE3iYA6HBL6afypJDMTDcRmmFCTKkwNtjwH60q7J2/EaQbC5aUVXTYrUM0ueaRsyb4BsID3E1rs+Z7iaTd6GUdkjZN04x3LHbd59Hu4krK23qIFplk+nysO6J/LWvnyYul//qX6sp2q4xcyIKHhU8JAFqsPtVI7a2Pn63PfV0W8/Kbs3aAaQ7HSeqCa2LdQZQlL4TjNolwd7afwMHDdd+aS/Pwx6VyhArAcybsWueULjqqpSjKqGwQHM+pafzaY2dyNAlBeddSWBTABzHrhHqXrJ2L2SfBh7WQBhOKiMOlNW9+e4wEpWZLOqhw+zPrEl460kAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfdeAM4BQKA15F7TE9b10BYOmZsoj/T+r01MZ4dOlxI=;
 b=Xxy3QOUcej6VHpaDuKu+YLP5TrdK6kAbyKBr9ANb5TFg4nrbZk+CvR9Keg+4Y1dZ5Ox+9xf2rFJ0345TAt0/6mOKNGkoIGXSsQhqvrweYOaHSYrs1oFlambUH8oYEWs9oK1VHDVtWc9l1SVuKmpRIflkIufc+iMayNGLNq2ENJ7dHuHEsw7Gt4RAUnWfzq7zz89I4JnVxZ++zXKU9CQKm+nOCAdZUB96xnSxzreuPh9iObgUcja/SUwjNBLEzwrI2wcm1Q2G79Z1Q0i/p3Te6czjnBSZEkdnVEGWxW4bS8lMSqpIAULmJcSq8uCQBHEphsEhKpNmoNGphlkeCtVqAA==
Received: from BLAP220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::11)
 by BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 09:18:09 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::2c) by BLAP220CA0006.outlook.office365.com
 (2603:10b6:208:32c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Thu,
 23 Oct 2025 09:18:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 09:18:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 23 Oct
 2025 02:17:53 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Oct
 2025 02:17:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 23
 Oct 2025 02:17:49 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Shay Drori <shayd@nvidia.com>
Subject: [PATCH net-next 5/5] net/mlx5: Add balance ID support for LAG multiplane groups
Date: Thu, 23 Oct 2025 12:17:00 +0300
Message-ID: <1761211020-925651-6-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|BL3PR12MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: 418bdeb1-c3d0-462c-e0bb-08de12151587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hIr9h2FtRdFmz5tj1rO2tkQnhzyKiRoVo8rr5zmd9khriycDkxvWx9gI503B?=
 =?us-ascii?Q?EA5/z2lvQV0//kgbG19u11i13DRxZHPJ0/j86wWsKqv2jg445ypKAypMm3S9?=
 =?us-ascii?Q?zyAZdtuBZhsV2eRLhbVnnV4JPRtejqgciBMXqPVMh+t4wEarNsMX5cdVFNj2?=
 =?us-ascii?Q?oRjnCar5aGFhjvRZZpVAYy5JdWZfYZXXfDrFwGfAs4iL+QqgLLaNwAP20gdS?=
 =?us-ascii?Q?uerxm46venB60G5LNcHKvlYTK1yCEymCfLriE2+S+HMA5+nhj/UtDUFUV3LE?=
 =?us-ascii?Q?1d1Qz2/3vDIxrLidS7Cy1ELKWyagNVh4S+ZI1EvwVsSWIQwSUKbhX37LfbOQ?=
 =?us-ascii?Q?uKuRNTjXhZmokINg6jKnxq0T5VhzED6rtzQkABAb9Byku4TBiLNbNzAsgzRH?=
 =?us-ascii?Q?IQ8srZIYJFgyIMUIAdOrQ6PmsE8Nqhq4mN/ypj2+C8gHC7ogAN2BLgjaVH95?=
 =?us-ascii?Q?SgBK20Yqzqy6+Oj9iykpbd/dl1TIEB7nhrLlF6gYnzTeYgNfF9mSlMdbtMWh?=
 =?us-ascii?Q?uRNbnAeTX4QIPosnW5akD0FyLEO2lBcvx0DIw/O8KcH1p8njgRfWfX9uIugA?=
 =?us-ascii?Q?BuXPON9RXbVT1zaPKDn/jgwqKu/wWWPERID9+srwlGMUYkLMOe6GK7bv2ReO?=
 =?us-ascii?Q?2vyaZtSClE8sWCTRyhFJrdL4V0mfigSmSBOZYrZDjM+YZMXc3ApfUsHCMp88?=
 =?us-ascii?Q?qoftmIoKWG6CDIyTO5gL+dCWVcykMBU++N5qaQ8ff8AhXcStlFCJrgu9/Mm6?=
 =?us-ascii?Q?h5+ws2UX6WlGiw6xg3vNNTjhLEV75a5L1N8w9lPmrz1/Q1rMHpRIrLbDdje1?=
 =?us-ascii?Q?Cq/A4NPEbNr90NVIFo9GSFUoNQzlY4oWX6lGWHEZ4wIqHD5iWtaWMLVR0rke?=
 =?us-ascii?Q?ZpO/Ke+vghm+2YnWePWYDoER4CLmDwQJ+xjbknTHgS/vXgNh0xijrzuQcc3c?=
 =?us-ascii?Q?7LSI1FKWoHnT1Jh3YPKdLdXBSiqJN02vy7/PJThXT6HkYYsMT/rfDPsjLAPT?=
 =?us-ascii?Q?Na1DFleOk0KEvuGytxNcvV73j9MDc/Lf7rp/qgqUT6eTlOocUPUeWo+Tp+4g?=
 =?us-ascii?Q?ozNj2SMRi+A1hgCCVcJ08V4DdwmE3S3HJb7PyyYjKVNV3SVihlyXwdv+Rs8C?=
 =?us-ascii?Q?rwUNbdcZk7E6x+Sz3tPpN9yd87tG1jZYw6xZfQPSeFD5V4xiVhk0AN8x+CWP?=
 =?us-ascii?Q?ztG6xqO14d4AIAaQcIJASWna9VwVDp4ZXD27rTaS+0iurifTy8Cxp+5dJt5i?=
 =?us-ascii?Q?FqGbLC0iwjRSq2bEEQ01U7zv+sh92RtUn9bTmDe3Gx7ThvX/g9O6TCLgMFH0?=
 =?us-ascii?Q?H3xLqliDQY0QrQe4JZh+ntBodjkDZFfl7H8ylOsQSIVpXGn3RFF8PUaSjV0C?=
 =?us-ascii?Q?83/Ck8SRiy2UQ+t8J6Vsk1yxd+xCEf+XDAJL+UktyBg6Gfie2eOKdGG4GSej?=
 =?us-ascii?Q?/9Yblka2V4iuRNfRd38ersMkzct5CDu/p1JVLJ286cElzLZ8CoMFG/l9Mxxc?=
 =?us-ascii?Q?Q5aEohhixMRA3a4QJtrOSzTcFOa80ADL4AqiTla2RAoAYFAfL2adPdfdqt0j?=
 =?us-ascii?Q?pM5Ght6W+eZmUJmtdcA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 09:18:09.6226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 418bdeb1-c3d0-462c-e0bb-08de12151587
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569

From: Mark Bloch <mbloch@nvidia.com>

Implement balance ID support for multiplane LAG configurations. This
feature enables per-multiplane group load balancing by extending the
software system image GUID with a balance ID component.

Key implementations:
- Enable lag_per_mp_group capability when supported by hardware.
- Append load_balance_id to software system image GUID when conditions
  are met.
- Increase MLX5_SW_IMAGE_GUID_MAX_BYTES from 8 to 9 to accommodate the
  extra byte.

The balance ID is appended to the system image GUID only when both
load_balance_id and lag_per_mp_group capabilities are available, ensuring
backward compatibility while enabling enhanced LAG functionality.

This enhancement allows for more granular load balancing control in complex
multi-plane LAG deployments, improving network performance and flexibility.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c  | 5 +++++
 drivers/net/ethernet/mellanox/mlx5/core/vport.c | 4 ++++
 include/linux/mlx5/driver.h                     | 2 +-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 1126e4db0318..cc6374b4e0b8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -575,6 +575,11 @@ static int handle_hca_cap_2(struct mlx5_core_dev *dev, void *set_ctx)
 		do_set = true;
 	}
 
+	if (MLX5_CAP_GEN_2_MAX(dev, lag_per_mp_group)) {
+		MLX5_SET(cmd_hca_cap_2, set_hca_cap, lag_per_mp_group, 1);
+		do_set = true;
+	}
+
 	/* some FW versions that support querying MLX5_CAP_GENERAL_2
 	 * capabilities but don't support setting them.
 	 * Skip unnecessary update to hca_cap_2 when no changes were introduced
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
index 4224e2750865..992873536c1b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -1203,6 +1203,10 @@ void mlx5_query_nic_sw_system_image_guid(struct mlx5_core_dev *mdev, u8 *buf,
 
 	memcpy(buf, &fw_system_image_guid, sizeof(fw_system_image_guid));
 	*len += sizeof(fw_system_image_guid);
+
+	if (MLX5_CAP_GEN_2(mdev, load_balance_id) &&
+	    MLX5_CAP_GEN_2(mdev, lag_per_mp_group))
+		buf[(*len)++] = MLX5_CAP_GEN_2(mdev, load_balance_id);
 }
 
 static bool mlx5_vport_use_vhca_id_as_func_id(struct mlx5_core_dev *dev,
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index dcf262aa9ea6..046396269ccf 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1380,6 +1380,6 @@ static inline struct net *mlx5_core_net(struct mlx5_core_dev *dev)
 	return devlink_net(priv_to_devlink(dev));
 }
 
-#define MLX5_SW_IMAGE_GUID_MAX_BYTES 8
+#define MLX5_SW_IMAGE_GUID_MAX_BYTES 9
 
 #endif /* MLX5_DRIVER_H */
-- 
2.31.1


