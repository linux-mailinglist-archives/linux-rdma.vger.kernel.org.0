Return-Path: <linux-rdma+bounces-8842-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8809DA69931
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 20:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96209839D7
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 19:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF94B1E0B86;
	Wed, 19 Mar 2025 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V/CPBIkL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB21211A1D;
	Wed, 19 Mar 2025 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412281; cv=fail; b=ZIxzgwSAG3IKHwn5gmlHqIrrAJSXSdFo5VH6U9vWBM05wzNECprBF58qBU3a0/cG5fnKZOmEVvJeXuIwAEX+i4iAv4+Gm6fqPlLiW5gKcksIV0DJsRpg7EmywcBsAtQfzwNmMTZbjlUQDAtHytk3Z35WpkayCEGpMGmdt4zETzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412281; c=relaxed/simple;
	bh=NKjqzl7pj094YVynHRf2UyOjAkKJgDHKhgc7RkVzRlw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=owZJkhs1UHOKkrPf/gMAVauwjCQ9w6bBf9YhtV+cX/NdjxCl/mQlQ/WxEjHca/BeAtdGiW+FbO52Gh3ts7oiGRapH+5spJuSKuMdLv7AnIfKTSPRCR8NnPnhw1QkXcf3qe4tyDlUnZD/mO9FSNMtY5Vh7uD8tYvWKAFQ2bujvDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V/CPBIkL; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFO0C+E9BLnejTNIMdzXUssuYQLgup27j4WgQT7C0Y2xvt61zl0BGeZZzRltMQitN98ayFPif3M0rhKUsKiXqj7Owdg7HM2sB+09wm+/HxTUhUtjh6l7LFWPqPtR8YzfVnFurJ6notrhlCNxm4oy/9898as937EwfrrQkKOcqvjftVPnpYfBuKMM+23SqEasNh3pBwe43IPk+KjUfHW/Kd7RxQlVyPWdJImUli/zgbYgC8Qdku8xzoxXjoQrWwqstP3L+rFo+c6mcKNzYtEDl3yiYvNLFdjveZpNym8O/BgL9l1MIS/g56EjKhjiiO+27KUy5x+NqqVC482ozHPwcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mjryttbSq6/LR0V8Y8TB/3Njux/tzXsX53ABAIqHC0=;
 b=P5W8hPPR/JicCMVvObDZ4wFOiLbo1BURu0KnFqO3EiuXp5ejPaR32d/ZkzdDmGWtjNX8ae9QukvDB9Oq1LOAUtiPdFqybx9hhX2GDBmrdBdbQ4MgCGh0FXaw9h0jWdN2x6eu190ZWehdUX/OHVdH4MrlK51K1mJDeTgUNfEtSJqm4rDuQDcVexH4CeoF02qigOwnookUgDpi0TWHvxlCruzN/H6Qm1T3IqwgxwVDQpYNxrY2puE7eMQYix2eqMWtrrYVEtz03fE12zv6agOXWvJLeXOvlKJuBDx21iwQJMAEfruhYggBw0DDyM7Q4O+vdmrXNaR9erxwZWvWQ7iSUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mjryttbSq6/LR0V8Y8TB/3Njux/tzXsX53ABAIqHC0=;
 b=V/CPBIkLmH1JaGVO3X1+Imn6StU9CbBHagaz/A7N1JJUKBaqK3kRQRBKAX5sycZ+NYVkv34EO7g/0GdMnomStKwOdJQf0uhs+ddMTNFbWiQnsMExA+bUN+S8vKvwCBVL1oleVAdgIMgiMo9OgpxUdCcVPY+CXV0l3uOA0iP47KkM1WMVGoNh5G7hnrTG3FfOqFgehHoNobh8BdoPWxMmob+8i3Q9gQON3DVB4WNMNy9n+niNzzY9pXicYTAN5qfeDfKBDTsxj7hPHce2DtpVW9W5I8RVPmPviPosBjzL/EHxYdo1oW3PFIIuclkB0Ies3EpMftFbuV+/RkyCtTtzhQ==
Received: from BN9PR03CA0402.namprd03.prod.outlook.com (2603:10b6:408:111::17)
 by CY8PR12MB8266.namprd12.prod.outlook.com (2603:10b6:930:79::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:24:35 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::bd) by BN9PR03CA0402.outlook.office365.com
 (2603:10b6:408:111::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 19:24:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:24:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Mar
 2025 12:24:25 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Mar
 2025 12:24:24 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 19
 Mar 2025 12:24:21 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next 0/3] mlx5 cleanups 2025-03-19
Date: Wed, 19 Mar 2025 21:23:16 +0200
Message-ID: <1742412199-159596-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|CY8PR12MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 27898d07-c516-4668-a216-08dd671baee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uZ69oekW0/babMpFbEjoVRWFbIsPp5ISBQWmggNK60BuUccxmjzInkRoOYBd?=
 =?us-ascii?Q?XLeytwYUaRVpmYpu05V+XSyRumv1bm+xzvKWHZ7bW8FfFSyY8aKWuNE1b280?=
 =?us-ascii?Q?RUvsk+eUTY9yNL3k1+mr16JhrJX1iMacbLi3ROSQvlqJAzjRHBct4MBjM+wM?=
 =?us-ascii?Q?ulixrg/GSkxrq3j3NA48oIvPTkBL9P10vlUTs7IuRdqoS89jD2FcnK7Bb14X?=
 =?us-ascii?Q?YzbMbltfVaMIygZ+GsZ3hnOrBdUbqMLTDGxYNQ5NMRZ9A16BldHBBGoX2yjw?=
 =?us-ascii?Q?R59H1YNTqJh6Hl4qaLYY9phOpSpGl8UH7D+K1agxvZOZ6jsYTUQAybnDOoZ2?=
 =?us-ascii?Q?6EjXcoRIoWxUZJ3GooH4sr/aK86yo5gMPZV6KMnl/w+GXWPtUp2RpqJ6ItVl?=
 =?us-ascii?Q?Um0xYOR9nNw1ivIET8UBv9ZIKI7Hx3R3+2YV2XNeFRQJhoSKDgu8AtkWnYST?=
 =?us-ascii?Q?+csb42qhA5usUBpRQvvaGvUFSfAt8whHIP2WFSL9If2If1VSXd7tNFLVGad7?=
 =?us-ascii?Q?99VVFcO1il/Ctb9oXYkq7sz6SPVInFbI1vZVCr517Pu9dl0vPC6NZdQxxzK+?=
 =?us-ascii?Q?QppTTJJIHdXKx96FEUkw9FDnFazhPeTBdCf/80Rxh/bkoIfZnVVB4r0vZ84w?=
 =?us-ascii?Q?Ah5JySY5WLWM2EMsHXeQ/foJap4PL/PWRTR0DGxP9YXExyLQfFL1gg7Kw4fK?=
 =?us-ascii?Q?h3xegPQVD92HplNcuS6KaQE6LTbIfrw3bQuMf6pFhUSN0H217yqrc7yQPsZ4?=
 =?us-ascii?Q?DcsVG9GRJaOjP0f/QwHkJhlIBubXS3zXdg1G5E2nQ1COwDKh7j6cWwCalkgn?=
 =?us-ascii?Q?+F56tz4czRiIGqMLXk5wVPmAxaSWaz3DBsDPrx7FFw52tHnO+yRmZkK3VTtL?=
 =?us-ascii?Q?uxrFSad4mHwZqHsmUhwWXhBhN22ZNv00wQcQJwu/MVYGeiiobnTZag6FBdW3?=
 =?us-ascii?Q?nbxnhwTZHWqv5qTh2zYnG551JovSfwMnetpU8ppOxdBLn0/VvlTcKnX+utvD?=
 =?us-ascii?Q?vTUt0Q5BICmGrBJNz7EZGf6kUP4UoZx4cV2ki0GzcNwSS3ir+uI2KwBFtNOZ?=
 =?us-ascii?Q?GU8s8nQLvlXT3Om/8DURckWvsOkFYgo5qHz7O4hAzYuNGNryfr1P/mPIyyXn?=
 =?us-ascii?Q?QriPXKCn6dn1TfWVkmWPqUhxU8FrudIA1MG5/FmFZwzPaX75ofOAjjGFkwX2?=
 =?us-ascii?Q?WQxPZ08y1GB33vnQVdW16Yeke2bg3OXoPRVIW3ybhkuUYcvVNN9OSvhReX31?=
 =?us-ascii?Q?aQ/WEM3dCuRKUGttQox9rtc4PDgpftLlS/RuZFJ9jIK6W5eyPJZRrJMeASbx?=
 =?us-ascii?Q?Q23hHIMEMv9a4eVkoaynHkZr1QY3OBj8Eq0XVuPWtLnS8jE02hYY2PHD0PYu?=
 =?us-ascii?Q?1aoJaBsXiueagIDhz70isyFm+FCZX7o61mdC6gL25aRLr2Pk8xdcvVQjAAm3?=
 =?us-ascii?Q?3ccV7nLc0LTBTKa72yeqRq4IkzAYxMIPSW6lYJ8rYVqyLYjsdYY9JMSm/T/X?=
 =?us-ascii?Q?cMFlGEdpSJtZXzM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:24:35.1291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27898d07-c516-4668-a216-08dd671baee5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8266

Hi,

This series contains small cleanups to the mlx5 core and Eth drivers.

Regards,
Tariq


Gal Pressman (1):
  net/mlx5: Remove NULL check before dev_{put, hold}

Mark Zhang (1):
  net/mlx5e: Use right API to free bitmap memory

Tariq Toukan (1):
  net/mlx5e: Always select CONFIG_PAGE_POOL_STATS

 drivers/net/ethernet/mellanox/mlx5/core/Kconfig    |  1 +
 .../net/ethernet/mellanox/mlx5/core/en/tc_tun.c    |  9 +++------
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  |  9 +++------
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c | 14 --------------
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |  4 ----
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |  3 +--
 7 files changed, 10 insertions(+), 34 deletions(-)


base-commit: 8904eeb9de86e940cb635a42453855790d53b838
-- 
2.31.1


