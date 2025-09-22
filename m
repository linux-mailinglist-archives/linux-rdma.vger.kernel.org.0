Return-Path: <linux-rdma+bounces-13564-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6000FB8FBA0
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 11:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BABB7A97A2
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 09:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F9F2D94AC;
	Mon, 22 Sep 2025 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mj9a3zA8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011061.outbound.protection.outlook.com [52.101.52.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEA71419A9;
	Mon, 22 Sep 2025 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758532773; cv=fail; b=KFXq/1jdO6rLm62QNg0QV6B9yvUAKd4LTo5XivU5vSE6dMfIiOPmn/3jiqetdrArZXGbvrzskv5vsx6Q72RZ+S+kucSx5/UahBHVToFIlXQjLlY/xHzZwHtNWNL2Jh785t9m3DQmhtdUk8Z9wm5TR0WZTP2Sw7W4oeZJiC7SOXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758532773; c=relaxed/simple;
	bh=n098kY3gWZOVGu5AtJ1ief7zW7Su2ZTeBeznetG4rQQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MaTYPWoe7xI1RuKph8crNeWcB0hwuIWRcjIN3L6aq2f9n0rL1DrdTZ9u27OTs1F94rOMkwZUGlJ9mV66DzIB2+ovEgoqSFT2NQF4AoQPfMPM1m4Q3+RUYbMF5+Luqjxd9pvUIuogCAdAkG24lxZzqcEvGEQP/QxBWzDV36KNPL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mj9a3zA8; arc=fail smtp.client-ip=52.101.52.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVqRXZvmr/aNdraDkV6+uudZBiSiDR3ha3vmRn9NFIgFcqPg+xlekG7a7lckCS1NVoUhvyu6bFcMCrxLOOMw3at1FPNuO616kCk0hpRgoFDt75gfY91Ilo0PmSXJeEr0MV1vSnqKQFu0g1traeoUC27qDVHsuk4qwczgMBHt2J69s4sun7af3gbLeAfvmgLB4cpp1R3q8byNPIJO4o5pYi40ZLJeZ7e73xE/aHndRt8CiXWRxqnZ+Tm8y+b90LPT0xHZvhyMqCIMgojbDM+JMrlGYtt/sMRTZArn9fN/dinUbanbcA0qI5GMrjG7VARp08MIuHMghmEpA1XPmYMcOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNlEBFP3TcgRR3V815DR4RW7fjsg8CucXUxchjqllgw=;
 b=ekGQxpuUrP2uvftc8yF5xCKRvtJA+edpMDlvFHDgpKndgz5BmuseHCz6k2ZXhm8THVUW9S2XE0tVoG67mo52RCvyLInMxWBMKLRERiQRG6OjxWFTgWQFbIvz6D4MT11MmaS+kqiV5xT005GQvGWL4h+tsf7nG6prenZ5MVd4F2hCVdGOP1NZVWIDI9OaD1LR4tguMP8YF0Mwhq5rVLp6YOtOdsEvKmKRCX13Tb+kP8PsdfnLK6QoSaB8jL98JZoiajVAAef9v8da1Ye18jtmwCCSogsba9aRc008r4HtMQfpfrcwDaqGLVqnT6wMqQDE8usV3nxKMI4xdbT245+EPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNlEBFP3TcgRR3V815DR4RW7fjsg8CucXUxchjqllgw=;
 b=Mj9a3zA8JOr8+I8KupNmJKT/TdQVIhLY5gCyCeEHMzrsNvDYLq8hL7M4mqZc07IzHnzqRhFYlTGESul9vWW2C5PL22R2kR16vKJOOE7t5bg6nsT+91+8XkV14+XrsYFRtgoxALLrcHzxGyvL+N502RT6JYymNbZtAVdSlsqJRxrmhjvoLOpL6S6z7EzrGULd8ed8dZQ7ybamqXOjMC3A4kVR1UWwjmj2NeEa3eASLXN/JkEdALGC8bfKm4ZOMju3eFWI80YLuYQBFSgWVKud0qBSqnokW7U1vnG7vYhAbxLNQ65UeCLx7k4y2pT/Nlhhou9hzQcodiX2Rjx90XQplQ==
Received: from CH0P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::22)
 by PH8PR12MB7374.namprd12.prod.outlook.com (2603:10b6:510:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Mon, 22 Sep
 2025 09:19:25 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::56) by CH0P220CA0026.outlook.office365.com
 (2603:10b6:610:ef::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 09:19:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 09:19:25 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 22 Sep
 2025 02:19:13 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 22 Sep 2025 02:19:13 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Sep 2025 02:19:09 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 2/2] net/mlx5e: Clamp page_pool size to max
Date: Mon, 22 Sep 2025 12:18:35 +0300
Message-ID: <1758532715-820422-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1758532715-820422-1-git-send-email-tariqt@nvidia.com>
References: <1758532715-820422-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|PH8PR12MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ca2801-f769-4e27-522c-08ddf9b91fd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KXMW+9TO2pD+Hlh3+CfDGBawWWBGINfCt0Gm+MxGRJaqS4v39yMJ/LD5aMFk?=
 =?us-ascii?Q?6OWCNptMtXimZ9ekKcce7MPjuhQbJxSuVqhZUhnkRO3bY6qGw6Vwy1732NQs?=
 =?us-ascii?Q?QCYwa9vNFAGUUu5u10W/g8soyew/QfMOtAoryT08vMYTxzo4MeXrQ1YxDfVe?=
 =?us-ascii?Q?GhsrLkX07kez7UymdAAwqjxSZh33IYfa9rMQ5R9LCZ6bsfQv95572HZlzO+4?=
 =?us-ascii?Q?F3Gh6O7zSvLjl162sTbfIqeTZ1wFyIn4JX/Epr6NqXkQNlOhIbejtqebtClk?=
 =?us-ascii?Q?YOZjKW3D0EAS7Rj57KaYAZQv03jG01xTkH9QG7S7YoIludpOpQVR4B0dobnF?=
 =?us-ascii?Q?bbXpWXd6DTAIyuxa96FNZ4UW25xDOxmKkU6ruZ0yVlvrpcGo4DG8++kgdO8h?=
 =?us-ascii?Q?VaDwXXapKSbltn1JG0lJfFhBgr7l1j7Q3oIxY1E66gZRCKBK1t9UqHQnACY6?=
 =?us-ascii?Q?0oNQEFdt2Vr5hScV2oodRm4BKXT5VynkQuqAvLGe0sXHfxDHfoKXdHZx6CjG?=
 =?us-ascii?Q?KwfTespCeE97MbQhtu89MHE2Kx9hB9TEy08cefi/RJPCs4iaJ2q387/4QASZ?=
 =?us-ascii?Q?OcTc6Lqns4DHB7GsTKWlJFeF/C9OSppWBqYNZWvJR5ljdjnAXd7xf5Q9KtG9?=
 =?us-ascii?Q?iwr01WDYRH/Y14wwaNPZ8XBVNvB0D8oTu9YL+pycdIc6I3hkaRe/MSk5kA+f?=
 =?us-ascii?Q?43RvNAsfvdyJPc6BDOqFvrZEni1QyOYxlSSCxF0bFx/iuQ7okigZvdSYGv0a?=
 =?us-ascii?Q?B2PShjuYmifAGXpRsbA5qRoxKoaf4+ej9sjgf3XtDowxLE5xVQnNMkw9UG6l?=
 =?us-ascii?Q?A8e37poVYpG19CrkIHWITJoobFFLewaD+jeHu7j9hQZ0O+7ve1FuZKV6kzp8?=
 =?us-ascii?Q?BW+bclZ33YaqUc5n5Yg0qDmJkCJY9ccIJQBX9sxA9BYfshbu4ni6Fj7vNkC/?=
 =?us-ascii?Q?6D5pRoBihEthwGTLLkvnvM26kI7VsCeN1fHughi/QiFI8LPaGERHBZLE+cuW?=
 =?us-ascii?Q?NSCIyWYGV471ONW1gmnqPQxxQbhB0pWpQHP5Ho6ZyDbtb3WrBo6zyKX6OJjD?=
 =?us-ascii?Q?gGUGa9bNcG6MC9A/GznjJPSiC9zrcx5s5qypJMopY4OLL1kZD8ATvT0Db7Od?=
 =?us-ascii?Q?wWvgcPsBA+2SEXwUkjob7sobPRHKaQy27XCn3OvdPN/q4EErP+Ap6Ausd5Mw?=
 =?us-ascii?Q?hh8wcXNRpkGJPIF4VgTW5T5Fn0i7f/lYGVGcBnr4k/IzsYnpzTZDP8kDCr7M?=
 =?us-ascii?Q?lpJLKCwo4/IZ+O9aV7SmgpcUYSzIwKLPLzDgtICJZi/LtfkOKI+5iy9e7/E1?=
 =?us-ascii?Q?0M+en/WfgheZy9Shlt+kWLJZoiQf2bfbMibztZuSaMB3RnrW3tkIauI5hUlR?=
 =?us-ascii?Q?DBWhw0sbCH2+C9WKn98gLRHMYkdSXY7X53oSZ3inyt3OWICWIo6ON24nVeLg?=
 =?us-ascii?Q?KldHuB6ck2hyPS8FJw+xuiSTP6VJGFjStF6W4btKaRkAzExzeZl3TP1CGJgN?=
 =?us-ascii?Q?n1GHstRhEc0i5oy/sSw/WWhcbmp9nk43O4wx?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 09:19:25.3695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ca2801-f769-4e27-522c-08ddf9b91fd6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374

From: Dragos Tatulea <dtatulea@nvidia.com>

When the user configures a large ring size (8K) and a large MTU (9000)
in HW-GRO mode, the queue will fail to allocate due to the size of the
page_pool going above the limit.

This change clamps the pool_size to the limit.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 5e007bb3bad1..e56052895776 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -989,6 +989,8 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		/* Create a page_pool and register it with rxq */
 		struct page_pool_params pp_params = { 0 };
 
+		pool_size = min_t(u32, pool_size, PAGE_POOL_SIZE_LIMIT);
+
 		pp_params.order     = 0;
 		pp_params.flags     = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
 		pp_params.pool_size = pool_size;
-- 
2.31.1


