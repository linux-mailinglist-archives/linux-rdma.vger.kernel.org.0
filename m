Return-Path: <linux-rdma+bounces-15086-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E87BCCCC22
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 17:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BBA830F6F52
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 16:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A07536B041;
	Thu, 18 Dec 2025 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bz+2FQDs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011041.outbound.protection.outlook.com [52.101.52.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7D436A01B;
	Thu, 18 Dec 2025 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073575; cv=fail; b=IPbW/koQB0MbAOdaaHMOBFKKYjOUBLxN5M2m0tYqfVbWoJmKvUlSdYGusyqdOca7VRb0tlaFlGsMM4iAubpccEBQR2HIrSuklJjZkA4SeeaW2bBnAKs9bhll33vPYmhkqERe8sw3+Kfllntdat/bgOtaRCRa9znWnbiMQQC0G1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073575; c=relaxed/simple;
	bh=ENYr5pw+joLouTqrr+/uT5B4b4fjUFeyMfBhuGda2WY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FisAnk+ovVkpjabfgypwgEP3zWiA70nK0qScnCwg9dsxRM+982RF4LTQSyQXKq4XRAOuLwgJRlw1lzvmyfWL1UiRtKIP6641FZp9repHrWTjp0cfNOYXYwEfiwdd9u2h0Y2Jg7PHyiWC5z2ddvNKsfu/iHJfzI3CmTI9SxB9FRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bz+2FQDs; arc=fail smtp.client-ip=52.101.52.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuHWgDLKVD+QTb+9JQ2B9Pjy0+t17gaVdpwaVLd8Pzcsd1Ysaj5TgpWytUZBgKbn2w1/dyi10X31A4c6lsJa+KEn+Gs783DLHugetphXoxHk5X8TdeQ+s5GuHlLzTdQUA9o0h5cYA5wKu9Zg9NrSKdZ897KDf66bJcl28zkr7lvMW/b+T3X0X20t84TPrvA7VOz9VVc9j1ocM5+XgbNQFb5XMCazSLcGxamL3QPEk1ylHh9MAlsU7UT43DuYCWuaOfY3iZPX5stgQUekNvAjhsrdZU+QWC3gf3bkc26yxuabydO04ErelDU8C33KCQ3rFhqkCDeBkKmBmm3lae4fZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEnqbVHqGiR2mX2DC3Jcw48a5MzhknsfHEAAivfqaNc=;
 b=aFFdxNH703vmAkSg1UvwvWS7P+ZOUz8LULmRUuUHCq+j+CQR/leOtJC7AVfE70XFchb5YwYgHfLzWj770gaLbtwUdRQfPVC3WJxgw9iT8QQBjIhrXkGjxfWDgpUdJ+twf/TGZF2HK7Q+tFjQjhDLAqME446QdO6WNtg7CnM5Av/ytuBqGhZmLlultEEJvKxtPaJkxraNwfgwxQtwJPeXOS4FRVeZouLW7FmZ98rwV2QOWsEyx8/8wDebUtU8eW1oOkm/uGK3lTOllYCnEPnQbi1qQDCXDuZTyKHzTHxEWL9Yb9j0nRCgYrFHMdm2AUpJjzalL/y45z1EZR2TNtE7UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEnqbVHqGiR2mX2DC3Jcw48a5MzhknsfHEAAivfqaNc=;
 b=bz+2FQDsPHC/GsOIJgeiA61UcEExW/rEZQ/IC1ebWFUy6TC89Q/PpeeRgKKMPAKYgFcL8w53LmkwzKcfCnDrknEULH8CF8/aCyWu7PKtKRVJ/SAfJTytq7r1RrJgsb+gcUfqG+tstpwQB9+/MQI/xy0ZUoFucGqLeW5+nmWBB/EKJrxlnGE2dvEgArMAgvYBDZmdVc1K6dCHsGjSKeijoD11YPrsl+wGLOyDPryYadmzhKH+ChtX7wn1CtHxXBr1rdqQ4bBdlWtx3rPOs1mge8SRN58qvTSP4xYaKjkHuGPD/MdJZ9vCGnvN9CX6C1JZBfqYDtjD0C6c+3HUvZVdOw==
Received: from SJ0PR05CA0080.namprd05.prod.outlook.com (2603:10b6:a03:332::25)
 by SA5PPF8ECEC29A9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 15:59:25 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::e4) by SJ0PR05CA0080.outlook.office365.com
 (2603:10b6:a03:332::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.5 via Frontend Transport; Thu,
 18 Dec 2025 15:59:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 15:59:25 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 07:59:05 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 18 Dec 2025 07:59:05 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Dec 2025 07:59:01 -0800
From: Edward Srouji <edwards@nvidia.com>
To: <edwards@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jason Gunthorpe
	<jgg@ziepe.ca>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Or Har-Toov <ohartoov@nvidia.com>
Subject: [PATCH rdma-next 10/10] RDMA/mlx5: Implement query_port_speed callback
Date: Thu, 18 Dec 2025 17:59:00 +0200
Message-ID: <20251218-vf-bw-lag-mode-v1-10-7d8ed4368bea@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251218-vf-bw-lag-mode-v1-0-7d8ed4368bea@nvidia.com>
References: <20251218-vf-bw-lag-mode-v1-0-7d8ed4368bea@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766069544; l=5304; i=edwards@nvidia.com; s=20251029; h=from:subject:message-id; bh=/2jKTjIK0B9x/5XD4kSB6Q2ua3AVH4sYJDVpEnBfGAg=; b=pWXaHqsEmknMl55d289fPrNL7Y/w0/cQlclEhIHO+htqxN0oubX6GTtvkpWOszZmPFoXxCPAV FLfOvDqwGRbCp6374jbhOSIgXB9bmZL8ct0R7Khy6S5zc2AabfZ5TWz
X-Developer-Key: i=edwards@nvidia.com; a=ed25519; pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|SA5PPF8ECEC29A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 2351f487-860a-45c6-face-08de3e4e6aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yy8yZ1AvSnJ3MXEyNHFjeC9CNDh4dlB2cEcxWXVtbzFUOXd4anY5ZzZ5Y0tp?=
 =?utf-8?B?QkhPRWZtLy9KaW1KaitEdFhyTERzNjJPNGlSSXJzTHNoK3gyZW03V1ByWlIy?=
 =?utf-8?B?VEk1d21zU1hJN2VUYlFkbEx0WmZ3d3l2dDRudFd4TEY4N2xjQmUwNHQ2Rnlh?=
 =?utf-8?B?aXhJOXhEbEFuQUNuVTkxK1duTnNCMHBQMWZPSU55aXJ1Q1ZzcCtTcUtvbEZk?=
 =?utf-8?B?TGllQkczY2lnTzRsU3ZLSDgvcFFTRUFYZGVDY2NtMmI5YTEvalhMZ1BxNExI?=
 =?utf-8?B?RjBhekdBNlBRcFkyWFFwSVVKV3FDNDRPcW5wNjNvb04wSlBzcHdEY2ZqZW1W?=
 =?utf-8?B?YnRRb1d4VWJJOUFXQnN0dE1MbDBMQklzZnd4UGhYazNYcHJ3Tkh3dDFjN05M?=
 =?utf-8?B?TlRRODVCazhOVTZ0cFNBTm1HWEhUNDZRbFhmTnZOREpjbUdBYzYweXZaeW1O?=
 =?utf-8?B?Vk5BaXliVEVaUHA4Zk9OTFFXMlhOQzJUL2YxRTdMUkRzaGhyQnRuM3c0ejhG?=
 =?utf-8?B?WWV1OXhjM3RXYnVPNU9xbUlHaEdQb09kaG1pVHl3d1BwcmNXUzN0d0kvTVd6?=
 =?utf-8?B?Yk5GWEJxcDNsSlc5bUdkMHkwQmRCbDRzWTIySzkwYVZCQUVyQU1XSC9nMm1a?=
 =?utf-8?B?TUtKNDhRUWczaGF3dE5zK292MXpJbFV2SXZNRVdGc054cXlHLzdaSDAvMmxt?=
 =?utf-8?B?Vm96YWJ3bzJmalpjRjZoM0g2R0FMVmZNOEI4TFQ3MnBFemxObktKSWl5clNr?=
 =?utf-8?B?aTd4YjR1STJYUzZ5Z2Nyb0g5L0ZSUzlaVjcxMmF4Q05qbTVua1E4YkUrWjI1?=
 =?utf-8?B?aUw0Wlp1cWZvdisvc1RsYkFyM0xES05HZ1hqTFJ5TUJxcEF3Y1Ric0FWa0ZH?=
 =?utf-8?B?Y2wySVlBck9DV1k2cXhCV2ZLNGFRVWZ0UnhzTlhXdnVhU0VmdUNLa01XZXkx?=
 =?utf-8?B?UVpXczBCUTZhU0FraVpNSXlCcnRvNEQvRGptd1RweTBKd0ZrcXQyMGRiL3Jl?=
 =?utf-8?B?N1h0SE1KbGc0OWVtNTNsUFdUZ25Ob3VKQVdwRGpNeTY1allpL3VHU1FTSFFv?=
 =?utf-8?B?am9MNlBzTERmWndDTXNDZ3VlaEVJa2Q1cjZKVGpobW14clJwK2hydmV0ZXhC?=
 =?utf-8?B?MTBNbEpGZ1V4YmJEVGt5NHdoWWJOQTBrQWdCcnJpUTNPcG1SbWFTWHA3L3dj?=
 =?utf-8?B?YXdOWUt5OWgzN0dIcDNWZE9iQ2N1QmdaVTJaOUJDWmlLV2Q2VmFBOW5tL1U5?=
 =?utf-8?B?dWJYV2FyUlV0d0EwKzU5eFNGL1BBMUZmeTUrMldLL0FRMFpiRlB3REtFWnpk?=
 =?utf-8?B?N05EVE90NzFjWGhmcmNiSGRvWVdJTGlUcXc2WjY3YWhyTStVems4MnZXN25X?=
 =?utf-8?B?d0R4dUcyeWFVRW8wWnRDNmRpS0dzUmo1WkVwaVlVbXJhNmdDUFUzYUFGVXJx?=
 =?utf-8?B?d3ZFa0NSU2NwZkVJaXd6VEgvTUNTWWw2WUdjZFlsMkM2RG1reFRCd0s4YW9v?=
 =?utf-8?B?ZS9mc1pGbDZIZEFjYmhlYzNrY3ZpSXJQRURpaEhVSVhlVGVzRmdSWFMyTktT?=
 =?utf-8?B?K2tJMDhQL2NGWE1aaWNXQWJuNGtla3JQbWsyTHFJbVJrWUR0ME5ZMWE0Tk8x?=
 =?utf-8?B?Y0dFc29QL29sZElpUnJnOEpsVkFLNEdXS1l6TjZVaUlhdFhzTWJCVFQ4cXRj?=
 =?utf-8?B?cHNKZEdKaVYyQ2NQcjVwT09mdUVYUTNMN0NxVE9vdVNBMk5wTG1LZ0g1dksw?=
 =?utf-8?B?NnNiN3lsT2dRM0ExZ2dzTis2OGkvODRTZjV4QjN1aEVKM3ZsQnVqNlhMbUhH?=
 =?utf-8?B?T3lva1J2aVd1UlNsNjd4NFZHd0kvbFJLQW96czc2UlptNDJxZlVTZnVPdHNH?=
 =?utf-8?B?bi96K0tCLzlveEduSHd0OGhDTVBTTjhiQTNOMVhmY1VyVVlMQ3dTaG9iQWdv?=
 =?utf-8?B?OUpDV2FQaTJwaDBDSWQ0cWF5YXVvdHB0OThhcExiUlY5MHBIMktqM2pLNS9K?=
 =?utf-8?B?eU1Ja0FxYWxCaW9GY2JzZWdzRlByM1Fvamg2L0FRemJ4bVAwZ0p1WmJOSmpF?=
 =?utf-8?B?ZnpyVEYzZzM3ZmRhVDQzcmUzbHJGMmxmMVQ3SU9YRmw0OVkxRi9ua0JkYVN4?=
 =?utf-8?Q?qp7W7gp1BLMt4s1Cs5UDwj5RA?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 15:59:25.0725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2351f487-860a-45c6-face-08de3e4e6aa6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8ECEC29A9

From: Or Har-Toov <ohartoov@nvidia.com>

Implement the query_port_speed callback for mlx5 driver to support
querying effective port bandwidth.

For LAG configurations, query the aggregated speed from the LAG layer
or from the modified vport max_tx_speed.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c    | 124 +++++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   2 +
 2 files changed, 126 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index bea42acbeaad..47c19d527fa2 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1581,6 +1581,129 @@ static int mlx5_ib_rep_query_pkey(struct ib_device *ibdev, u32 port, u16 index,
 	return 0;
 }
 
+static int mlx5_ib_query_port_speed_from_port(struct mlx5_ib_dev *dev,
+					      u32 port_num, u64 *speed)
+{
+	struct ib_port_speed_info speed_info;
+	struct ib_port_attr attr = {};
+	int err;
+
+	err = mlx5_ib_query_port(&dev->ib_dev, port_num, &attr);
+	if (err)
+		return err;
+
+	if (attr.state == IB_PORT_DOWN) {
+		*speed = 0;
+		return 0;
+	}
+
+	err = ib_port_attr_to_speed_info(&attr, &speed_info);
+	if (err)
+		return err;
+
+	*speed = speed_info.rate;
+	return 0;
+}
+
+static int mlx5_ib_query_port_speed_from_vport(struct mlx5_core_dev *mdev,
+					       u8 op_mod, u16 vport,
+					       u8 other_vport, u64 *speed,
+					       struct mlx5_ib_dev *dev,
+					       u32 port_num)
+{
+	u32 max_tx_speed;
+	int err;
+
+	err = mlx5_query_vport_max_tx_speed(mdev, op_mod, vport, other_vport,
+					    &max_tx_speed);
+	if (err)
+		return err;
+
+	if (max_tx_speed == 0)
+		/* Value 0 indicates field not supported, fallback */
+		return mlx5_ib_query_port_speed_from_port(dev, port_num,
+							  speed);
+
+	*speed = max_tx_speed;
+	return 0;
+}
+
+static int mlx5_ib_query_port_speed_from_bond(struct mlx5_ib_dev *dev,
+					      u32 port_num, u64 *speed)
+{
+	struct mlx5_core_dev *mdev = dev->mdev;
+	u32 bond_speed;
+	int err;
+
+	err = mlx5_lag_query_bond_speed(mdev, &bond_speed);
+	if (err)
+		return err;
+
+	*speed = bond_speed / MLX5_MAX_TX_SPEED_UNIT;
+
+	return 0;
+}
+
+static int mlx5_ib_query_port_speed_non_rep(struct mlx5_ib_dev *dev,
+					    u32 port_num, u64 *speed)
+{
+	u16 op_mod = MLX5_VPORT_STATE_OP_MOD_VNIC_VPORT;
+
+	if (mlx5_lag_is_roce(dev->mdev))
+		return mlx5_ib_query_port_speed_from_bond(dev, port_num,
+							  speed);
+
+	return mlx5_ib_query_port_speed_from_vport(dev->mdev, op_mod, 0, false,
+						   speed, dev, port_num);
+}
+
+static int mlx5_ib_query_port_speed_rep(struct mlx5_ib_dev *dev, u32 port_num,
+					u64 *speed)
+{
+	struct mlx5_eswitch_rep *rep;
+	struct mlx5_core_dev *mdev;
+	u16 op_mod;
+
+	if (!dev->port[port_num - 1].rep) {
+		mlx5_ib_warn(dev, "Representor doesn't exist for port %u\n",
+			     port_num);
+		return -EINVAL;
+	}
+
+	rep = dev->port[port_num - 1].rep;
+	mdev = mlx5_eswitch_get_core_dev(rep->esw);
+	if (!mdev)
+		return -ENODEV;
+
+	if (rep->vport == MLX5_VPORT_UPLINK) {
+		if (mlx5_lag_is_sriov(mdev))
+			return mlx5_ib_query_port_speed_from_bond(dev,
+								  port_num,
+								  speed);
+
+		return mlx5_ib_query_port_speed_from_port(dev, port_num,
+							  speed);
+	}
+
+	op_mod = MLX5_VPORT_STATE_OP_MOD_ESW_VPORT;
+	return mlx5_ib_query_port_speed_from_vport(dev->mdev, op_mod,
+						   rep->vport, true, speed, dev,
+						   port_num);
+}
+
+int mlx5_ib_query_port_speed(struct ib_device *ibdev, u32 port_num, u64 *speed)
+{
+	struct mlx5_ib_dev *dev = to_mdev(ibdev);
+
+	if (mlx5_ib_port_link_layer(ibdev, port_num) ==
+	    IB_LINK_LAYER_INFINIBAND || mlx5_core_mp_enabled(dev->mdev))
+		return mlx5_ib_query_port_speed_from_port(dev, port_num, speed);
+	else if (!dev->is_rep)
+		return mlx5_ib_query_port_speed_non_rep(dev, port_num, speed);
+	else
+		return mlx5_ib_query_port_speed_rep(dev, port_num, speed);
+}
+
 static int mlx5_ib_query_gid(struct ib_device *ibdev, u32 port, int index,
 			     union ib_gid *gid)
 {
@@ -4305,6 +4428,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.query_device = mlx5_ib_query_device,
 	.query_gid = mlx5_ib_query_gid,
 	.query_pkey = mlx5_ib_query_pkey,
+	.query_port_speed = mlx5_ib_query_port_speed,
 	.query_qp = mlx5_ib_query_qp,
 	.query_srq = mlx5_ib_query_srq,
 	.query_ucontext = mlx5_ib_query_ucontext,
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 09d82d5f95e3..cc6b3b6c713c 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1435,6 +1435,8 @@ int mlx5_query_mad_ifc_port(struct ib_device *ibdev, u32 port,
 			    struct ib_port_attr *props);
 int mlx5_ib_query_port(struct ib_device *ibdev, u32 port,
 		       struct ib_port_attr *props);
+int mlx5_ib_query_port_speed(struct ib_device *ibdev, u32 port_num,
+			      u64 *speed);
 void mlx5_ib_populate_pas(struct ib_umem *umem, size_t page_size, __be64 *pas,
 			  u64 access_flags);
 int mlx5_ib_get_cqe_size(struct ib_cq *ibcq);

-- 
2.47.1


