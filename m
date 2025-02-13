Return-Path: <linux-rdma+bounces-7709-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 145D2A33B9A
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 10:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF36188C60C
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 09:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24022139BF;
	Thu, 13 Feb 2025 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qxEGE7zS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265732139A1;
	Thu, 13 Feb 2025 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440072; cv=fail; b=FXJ7+jMzn9CL6xiXqUu/vmBkIhKYQaSugl51LZ7sNK4VVUNP3G+JRvxDnnqbf+gN6+hmv8wmjPENS0CmQ2W7ouQn9hLlGaZqYrpUHC1QTgRga0HC75iy3YoemIr/Wv5wjpCRiNQzhRVWbD811szRExw530NNEXxouxHleQcpgUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440072; c=relaxed/simple;
	bh=FdleLgEDA57m8xFfOrOpnwcyYNwX3TO9Dg1ulFaRrLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HGK73tSkLzmFM3jlyQ3AaR3MdeqSCDSgBNPiBDEfMjw5P2x18yuofH4CINLDbj3p2nuCY5Q8eT2sUtMU3yd7TUGYgq75z4LMa78aYxNTQxV8VwCoWwbDcRroHDWSSnd9acQXFUHU1K9AgNw4RxSkfkbG/G2f+O9tkBlpjxgshZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qxEGE7zS; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDSBC8TqbCeJMMuaOnULoLUeFTTN/nh68oGNS9KbAL8T2ypXlw75Oen+ZecRtKORgt7OjYniN1pi5O5bJd7aKK/dCWJm5tn6tBIyYPUevi/mnMahcoSKV/0hMZcJycJBRmMnPDJVktXjfEqjjBCYH0bNDwyFkH5Ty7LvLcK7t9magITHLPQBZSXit15EcnI7nGPID4FWsl6SwYCJBAicwTbvutXVfNOG/izP7Awq4a4czdvpQ/T8k2CSAiWCnTnIlIQGQ/xR29oy7flPFkiFwKaYz4UNDB0h5DNuZVtByyprBqKC+H1D523/Jv//2HZ36mHntHrvq3u25525ms45VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+iJq6x/BL/SwQe/784QG1uY+/R1l2AiOXI7sl5uj9I=;
 b=qH8d1ox6rmpr5vY3BrLuoT7l3bA++FftdlDw4YqgHyywVeRP+yqAg6BWnqbsI75Qix7w1z4EoV5mY23uOgn9/oymJ5UlUyJtt7Q96hC9V3CIjnLY+A9ckq+6YPExmlIbZFxQ+rbIiFhZi95Fa4U+PZoELQSqAo/OZVstNf8n/eJnP5txNWlmvAfatm97aoz9/PrxQyP1ROK//M7eQL8X58iQ+IZ/kUh3e/dOo0fIXVfKtRSFJJz+K5l7iInHzAL0aOit/je/VplI5iFVRwWKtCKcekc8DsCU1PdRpmuCiC8fL68kbDtipV2v4E2i2yNPEmmu/tce4730eVEgAvkFNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+iJq6x/BL/SwQe/784QG1uY+/R1l2AiOXI7sl5uj9I=;
 b=qxEGE7zSI9tdRwwWO87T8XFgwPsSb7Auqqkfu2naxGaa884hbinu0KsGmG8XMM5XhNiH+xOldruX6LNjnjAcD33uXV7EPg8kdiHWasr93yM4QVmpWefXAFteFDut7L61IHgZvWHYAhdGvOD4WpoQw3RBxoeoV1cu5i3vTz3XkVlwkZEL45Gt6h+RVujfYo4UbmNPLeF4Lm+NRDFyx8UhlP3qaE5iN3dM6YE/wEz/k17ZD1cssGbiEOzPXzfpMxmTJwUhBYfkBCa/Ltf1SaEUyEw2rzjzvTPxr0DM7IusY8sgJrl2ocbJKNt0ppzvAx6iPKv7QdX9FhHnKaV7iY8/bA==
Received: from BY1P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::7)
 by DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.16; Thu, 13 Feb 2025 09:47:45 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:59d:cafe::5d) by BY1P220CA0009.outlook.office365.com
 (2603:10b6:a03:59d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Thu,
 13 Feb 2025 09:47:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 09:47:45 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 01:47:33 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Feb 2025 01:47:32 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 13 Feb 2025 01:47:30 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Shahar Shitrit <shshitrit@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 3/4] net/mlx5: Modify LSB bitmask in temperature event to include only the first bit
Date: Thu, 13 Feb 2025 11:46:40 +0200
Message-ID: <20250213094641.226501-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250213094641.226501-1-tariqt@nvidia.com>
References: <20250213094641.226501-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|DS7PR12MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce576ed-9d36-4a8d-d7e6-08dd4c1377ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xf3ruOfYj4DekhBUDEMRYiRu4BnruCRh4QFHBd+SKMlSk5IELdHgIVAtdm32?=
 =?us-ascii?Q?vMMxvZ8oOKrJZ8/JdNYE9SGHnMFPOmy8MZd3NBafG10sppg7w0Vyd6FXmb7B?=
 =?us-ascii?Q?Fqxujl7WsklyJ+Y3pHOOOfe9YsM9lWwfW6C0Mb6beq2P7cWmXhRruloFcbmK?=
 =?us-ascii?Q?rWhJfScsaCdEN+sTYXwK5oteBxUUj4akEGxtVvXfLnuJTNG1k2sEGwHVGLgf?=
 =?us-ascii?Q?R0ovdJqQeXW7R/UakUYP0ru4sTpIwbmqNSlZwulIEKTTxw0Vbz/mhywCfknT?=
 =?us-ascii?Q?qF11LwLkTjwMQb4PyZxq21aR/dZSgTFRtzCmfAr6Ua/7vi1wuaRJH1UvUiLR?=
 =?us-ascii?Q?tVRUlWN5neVznCTcYUIzEEhtToDGsQOmUuftmRp26kMUOxgicoGgqSTHa0AU?=
 =?us-ascii?Q?/6+tWNWKzG/lxGY9TYGDQhNDCxqAk9Koc7XaCoP4zMJ7l4es8/uMLbx9nVlw?=
 =?us-ascii?Q?+UBpOpKXHKIEJiUfFeyhgiPL0UTV42mxLbFCXtknffAPCn2R1Tr7WDmmdXLF?=
 =?us-ascii?Q?KsoIPigKUTcQmCjh9SwrJ2VgQaKfFn7BCyFYl5pIS0HlHPknCg1W0CqQRR3r?=
 =?us-ascii?Q?mbKUU69tGHFg60aYbtDcENyPMYLA+rtvsUcB1zzIotJPXtaZaqKYmor60PDw?=
 =?us-ascii?Q?XcXOQlmrFPFjn41gal2Pmc7ByxjREZ42NZh/e2vSV7I+r8wtY/vHPD+6RcOZ?=
 =?us-ascii?Q?ezMAgA+yTCujeSlHl0x+2cjwChWuFlpcZPbn6liWLZ0DTzHIGHDtzCOLy9sK?=
 =?us-ascii?Q?9uI/VTrnstSPfnglBpYhyD3aIorIT0M1sdfrv3BAF4a3bACimEcQN04MifX1?=
 =?us-ascii?Q?4p17scf0n4Z2nX0bh+Dv2BTPHZ+wX4rKWHSIfTjiuW1feCLoMuWGFvM5Kh1X?=
 =?us-ascii?Q?0tAM7lNnEoHxKRoMZLIUMf9n/xL+aThYdNbjI0ekaDj6rEXaDm2jqSImxkEN?=
 =?us-ascii?Q?GsP0F17ZeTR/tLeq6fqHe2Hu+j0MEXhL8Qzfwu+HMswRlRCnwWAan/H3Uila?=
 =?us-ascii?Q?vk/h9F+KdD1Rs79lmgntfn/PHHeAjEMhdX0xU7onG7KOMMWtSm7BdxCKQZVf?=
 =?us-ascii?Q?AGIxnYxBh0EupBvVajJSNWeYxcOyHsnCxSq6bQix1OVXjiK5c3FVmYCm981U?=
 =?us-ascii?Q?wj1bYmUS9khH9a8+o4RqspP3RWTP+n0pM7VaMY4ylsddeRJd3N3GxR5y3tmS?=
 =?us-ascii?Q?LjaBfB7B+KuqTgtcpS1SJGeh9DL3PVdto0PQj5Ir9A0oHOnxWdSRd2bQT7DB?=
 =?us-ascii?Q?B6zQFYcfUPKyDcZ2I8NXNDsqcFAbbxbdoGUm6Zf054ezR0gl602BZ2GKa1P9?=
 =?us-ascii?Q?932KjVWi6rkb1iIUsCLSJvsWJ5HXZgwD8Ayt53JHfOWezlT8dr7cEESmzVjb?=
 =?us-ascii?Q?Ghquw9n3Jpxe7YgHpsbW2pA/DjyVjApMYXq+h21rY9GPhrhSWj3Q2MjwC2E2?=
 =?us-ascii?Q?vUMTvxt82SWdhCnt/J2ZqKBYk6JM5w9ZVPQlnHYjFVSKO5i1BZsLZAKlN/Vp?=
 =?us-ascii?Q?D+7R4aZ5aQTy22Q=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 09:47:45.3831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce576ed-9d36-4a8d-d7e6-08dd4c1377ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119

From: Shahar Shitrit <shshitrit@nvidia.com>

In the sensor_count field of the MTEWE register, bits 1-62 are
supported only for unmanaged switches, not for NICs, and bit 63
is reserved for internal use.

To prevent confusing output that may include set bits that are
not relevant to NIC sensors, we update the bitmask to retain only
the first bit, which corresponds to the sensor ASIC.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/events.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/events.c b/drivers/net/ethernet/mellanox/mlx5/core/events.c
index a661aa522a9a..e85a9042e3c2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/events.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/events.c
@@ -163,6 +163,10 @@ static int temp_warn(struct notifier_block *nb, unsigned long type, void *data)
 	u64 value_msb;
 
 	value_lsb = be64_to_cpu(eqe->data.temp_warning.sensor_warning_lsb);
+	/* bit 1-63 are not supported for NICs,
+	 * hence read only bit 0 (asic) from lsb.
+	 */
+	value_lsb &= 0x1;
 	value_msb = be64_to_cpu(eqe->data.temp_warning.sensor_warning_msb);
 
 	if (net_ratelimit())
-- 
2.45.0


