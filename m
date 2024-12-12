Return-Path: <linux-rdma+bounces-6495-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DEA9EFF1D
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 23:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49CF02871FB
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 22:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE41E1DE3BD;
	Thu, 12 Dec 2024 22:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m7qKsvr5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BE61DE3A7;
	Thu, 12 Dec 2024 22:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734041742; cv=fail; b=XQQwmXGfuO1b2IuqPx8dGme4CjVmMUxq0JKOcCKuC7cLSrCB8STYO3DOA1imC+2kVtClaeSRiRl2ETyTqRBY/Xb2+PuJS71WhaTWQQVy/pGwi2cJRnynxhiiuStczeT4/8+LLRvBY9LrU1Y6jK2jR3ukYgFoDTy7vrDO6wiRTOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734041742; c=relaxed/simple;
	bh=aWKf5/Q6RnlbgvQFNKB5VuTrt2h+npwPoKmkNPJF+dc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+9AyA7cp0BQ4TyCEN1GEOqnby1ALyzCdYGdbpkZaPNeUYJb3C6dIl0ykPREmb0m1ROV7Ab3ZTGr9lgd9iplZl3L3UnoQTbnups9Q44lMGJBaaaLpJVf/r41ZdPhnQh0HwXVtk+QED6hahEPsyjfcPgqqp/JJUp2r/IZsHdnc4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m7qKsvr5; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pf5WYFWuXdv3JrSshGw0wLuMSRC2qWI8T/0s/z47nCaiz5AOyQKKD+PQyLrKUXJ+oPv7i42BsvPs01ceWd9uJT++YKnyja2bS9SQs+rzvZg5XbzxocWaw+SeQf3PzVZFUJANBfquQjB6jGWPN22qpi3yTx8EQ7KKAFS1r9ZrAjD9HQjkZfRR0ckNMDBpFf4Yk7uX1Tc6xrqxMVOc/kyWVttNAkNQdOSPag2LTR0IAgDeF2uRlMhDWLlpSbvOZkL6M0iMwP/SSlwWpIMkM9+gSLn80VXcWYbBVobTacezqK1YB0bezAMJcp+P22Dw9DIYQA8pBW7imBU/xLgxSg9wNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cpo7erPFocH51Ue6EtyETfLULcHuF9tgK7tlzC9NL3s=;
 b=C1+ZYWJ0VJb3+Obijw9n3PSyjMdn1Te2aS2TK0fD9boVP6BSLHbWY6Sdzef8nfxvNCB15vKUJYELTVsviDtxrvXUP07wB8YAMCe+6X/LoOKVTukkFUKeSlPatu9l1a+zpE56zFIIdtQEPzuwElZhXhq5pvl+L1QnSE3U3GFpcYm6Jh0im9e5hXZ3P7Uksuw23UJMGSEhDHCXucBzk70mf8y0uB4KLWq2PSMiUa2xw0NDbylo27mtrFu6GPcovlaPIeIGUtOTgrPZ72cs2ooIEIna0/WABLOfYFAPEKsEKwvJFfH1iflC56ZFK+RAjOz45JVwwUg1jb/ExuP7dUeg4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cpo7erPFocH51Ue6EtyETfLULcHuF9tgK7tlzC9NL3s=;
 b=m7qKsvr5hXZy3skQvdXx/WwiaeaQdrsD87ztukS95ZWbzisuNxCHok/VZm3EaR0M6kOZrBiLud2jJV3BpxPbqwvuU/urPpwjFGKPaSkkuNbRlKahHd9T4vLSdXtnjHaty+OXBq0Zz3BXeBpGoN5w28b2lpvX3fPDTZwlzBMbenxqFi9CdR28a+R37a41iv627POrF/hMvcCzeygK5RIQ/4Lc3WRtZKSjZYeiKR6MPLMOFD4rYyk151OeFcAv9+3ZmZaiPMvjOA2JEd9Bjb5vNM2+HxA7FEXg+zu+/VFqIEYofLHJLQXtx25oIewDMXEA5MtmL9m8KC1yQlFu2Qmrow==
Received: from SJ0PR03CA0386.namprd03.prod.outlook.com (2603:10b6:a03:3a1::31)
 by PH7PR12MB5928.namprd12.prod.outlook.com (2603:10b6:510:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 22:15:34 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::d2) by SJ0PR03CA0386.outlook.office365.com
 (2603:10b6:a03:3a1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 22:15:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 22:15:33 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 14:15:16 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 12 Dec 2024 14:15:16 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Dec 2024 14:15:13 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 09/10] net/mlx5: Remove PTM support log message
Date: Fri, 13 Dec 2024 00:13:28 +0200
Message-ID: <20241212221329.961628-10-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241212221329.961628-1-tariqt@nvidia.com>
References: <20241212221329.961628-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|PH7PR12MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: 716eda8c-3812-4e36-baec-08dd1afa7f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cVSkIfdv9SyHFb6NQT4q/8CGxUypsiv4KuE2VL7JBkvYWZIuCixVCpaF7YtB?=
 =?us-ascii?Q?FYg4FoqJI/T5iG4V0Zn7NXIdZxtCGGhZxH4FBjUEpsgjPFTUAhgcogsnUpRZ?=
 =?us-ascii?Q?FT7At4Khh8aDy6kDizVdLTvPNP298Ivkic2wH6BUoA0w6I+hmbZ+KH8YGpVp?=
 =?us-ascii?Q?077VROjA++LmjpMgH3QPZcWkjqUxoYM+v5ZYiUJNIjJuqpBxx/mRBm+iM4s8?=
 =?us-ascii?Q?h9XaYJA6Ds0Al2lmvF88I023bMWF6DFJcg4+K63V0a7Yj3K0LqBNZWwHuusH?=
 =?us-ascii?Q?TNAihjmQiIPt78JQxKBl4Lg849hx9RxsIU5VdbajbhI4wxpfi+koF5BbSfnm?=
 =?us-ascii?Q?VX46wHBEv9tU5TGuA0g4Fsjh3ygWUQR3At/D4eKOJBi9PULSbSUk1L9VC+bD?=
 =?us-ascii?Q?Sh8uRb9/JiLKRsjKLf/9ZXnx7vONr4CbtL4WIL2pnHsTMKVmoabg+aNSl3/e?=
 =?us-ascii?Q?n1bRx1ek9aUgHhXji55BlS/BFcqrMY4GA2Yj6JXo5wrnVuczo6FqXiah2Ee/?=
 =?us-ascii?Q?iCkQutVtMxpV6ccgyBLlIO8ZBf4bhMuriLSjmO8SDYM+EoXEyouZLAQW1dQZ?=
 =?us-ascii?Q?/4IJNDwf+n9YPL/WAj2L03TOiC30Y780OK+R1NbDqcaUPZQ07Lx7sagQXkdH?=
 =?us-ascii?Q?u2tvxAE50vRXVqaBI2ylJgsxfN3kgZNCb0p6h5iDK7I8cJbqT3J+yGfqLG79?=
 =?us-ascii?Q?eyNCbNywv38dwCTrvRHUwZLQ93ODv5PHQnbKgW2lpwKcAaSu+oBwHprSIbay?=
 =?us-ascii?Q?7HzgZVA7ZZVANGT5FMdUzUEKHBEZWDLIM1e7R1+61LiDb3AOBacT3DvoYlqy?=
 =?us-ascii?Q?gMLEtSjL5Ju1asfw+JE44RUna0xuZyIZMOEeBgs5JeR3STbuterF/AQewCFT?=
 =?us-ascii?Q?OYy0HxQMPdwfLcjGxz2sGItv1zBgSiDFnhdJNU28/0Y8TA+m5yVcEwf9J/y6?=
 =?us-ascii?Q?02JQYXPMTCGGvVbFBMBAS50GtaEzcOqT6ADDVCQQbXGGDYIB4KHOuTvrD7iU?=
 =?us-ascii?Q?hBp3pJK/h6N1ScTqD3eg/WsFp7LGxmuDtRlFolqElL9ofJ5HZvGE3FChnwqu?=
 =?us-ascii?Q?hnWpqpHGaBlMQ6i1pDW9WoSCDrjl4FePnp3ujTqTqRszcV7+wGsMibi9OY2Y?=
 =?us-ascii?Q?ePFaGY9W4cZayDwjeEMFW19Z9/wESuMdyx3CpTaMTdOHkmRBtmES6pFBJxZb?=
 =?us-ascii?Q?f33XdTQ4HrFEKikUwxTnSn435p8ek0mbNUlvW0bkhom3Q5sO1iVmIPt3UNwr?=
 =?us-ascii?Q?/CEJrdhxoynkpP3iw0LYlIhJ4ZeGXukH7kkMBsnw0GLuSB+vqEdW8sjJMcNf?=
 =?us-ascii?Q?bhmuFgUg52EkAE9mVT86AFOOOOAdRjGtge0b93y0WYi12QJrtg39rpZfqkdA?=
 =?us-ascii?Q?SjIFptT0ou/GwiPT68ZySpAgldlSKRznead3zsLPLU4xd48u4LCiCf5y1y19?=
 =?us-ascii?Q?2TuMtL++GbhSYqDrQoIty1fQw1UFaAe6?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 22:15:33.8824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 716eda8c-3812-4e36-baec-08dd1afa7f74
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5928

From: Carolina Jubran <cjubran@nvidia.com>

The absence of Precision Time Measurement support should not emit a
message, as it can be misleading in contexts where PTM is not required.

Remove the log message indicating the lack of PCIe PTM support.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 869bfecdd8ff..a108d8c726f8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -945,9 +945,7 @@ static int mlx5_pci_init(struct mlx5_core_dev *dev, struct pci_dev *pdev,
 
 	mlx5_pci_vsc_init(dev);
 
-	err = pci_enable_ptm(pdev, NULL);
-	if (err)
-		mlx5_core_info(dev, "PTM is not supported by PCIe\n");
+	pci_enable_ptm(pdev, NULL);
 
 	return 0;
 
-- 
2.44.0


