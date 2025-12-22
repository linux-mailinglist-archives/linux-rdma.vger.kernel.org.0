Return-Path: <linux-rdma+bounces-15158-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E28CCD6249
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 14:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29FBC300CAF8
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 13:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CE92E175F;
	Mon, 22 Dec 2025 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FfVsifhm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C082D73A0;
	Mon, 22 Dec 2025 13:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766409973; cv=fail; b=ZRx2gxuHRizxJF1Sse4zgWc6rsx7z0dQq3eiLXzI85S5ijH3MRWMI9C/QaZuHPmHZRuh/2xOCU5vFGWhaV+M2F93Hvg1WLjjqrF3MGAXhCJeTpce6TL7mNkwzRv0O5E36/+EA/Qw3lu5sRN+A0W8JfSTdudHynHoopBR3KaakUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766409973; c=relaxed/simple;
	bh=PMgOahPZaQtKAjCymzgRz4jQNxYlNjEmS00wsZNMiA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNmwbfvlwa4nLdAkbQhjOfRk/WFbizBj3dHdfNDk9bKZ7yPIO2GPB9qbgJVjaDsx29c9f6kxhJwf9YFzKMuceCIRoITIiDX0yZhnSY/FgoKtidMinrnIzbYv9+kcx3OjjzNKETg78CpAUxnJ7wn+x9s4zER/UCNNopt8cqhh90k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FfVsifhm; arc=fail smtp.client-ip=52.101.43.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lh8jjKe3gWL0VYAU5AHwU3UMIWoThOVyaFrqeSYD8GcGX4HVnRRAzmcNsDm6Msqlo9A5j+/fnq3XqNW+DFCydu7jxGDtBGORzMh0JZLfcFyO4TUsewjbqEWwDfFeKxnYOxsXMVton7AcMrWeqgk2F59syuBJM3FRf0iE2SEAot98kNDh683CCet4ZR3bd8n7htaD5N0HT9nOZmU8sfJxNkSQ9nUM1SRFpX13L1HJ2A7KAOA5JyOmAmUaPRUnIU4xXlR4aifQl0ZQimtTSXMK/+DOJiV0a1YFeOLSEJYypMJBO0eTymeeCdwYlA+JdPyAp0fvKc4HHu5cpARD09UYjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWbfSGgdAZyc8wPX06aExQAIK0vIfVZBlyZDhPLKtAY=;
 b=f5sbl5FYOT8UiLQpn589AJBZVFojNXht5IYLzDRJEyxDJz5vJNkHOlmOr73hOCdGw4mtIzqb2RBoPAz+m2hQz57nhgznRuZrlAa7LcUUpruqqk2db4rBCyhLIprPkdNR0NZ4kRsDAxjwRY8i3YWh/nVs9ImayM1EXVNwWGwxQsq05Kn6vkPVGRWfmzEbMZW5vLzIBeqmYP7FROAb3zzBlLSPZePcEBO1IaKwbKfkoY3phM3WQ+qyfxGIZNM1Amh5mTXRlinYM00+wSxqpmbrJpqfjKjIkPiZ8tkTkMEB1GFBex44zP7tBpn/NYPrejUHljg1Y7fTVhLlRUV7lh/rew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWbfSGgdAZyc8wPX06aExQAIK0vIfVZBlyZDhPLKtAY=;
 b=FfVsifhmqUQokiEmELZu7X6Ao6IAXadtirv9mu7HYBkBGK13x0qXKec7si7MXKru21+D7byClw321pCYK3tOT71e7782EVLgVnf7vlwJzo5LuItz+1xE6cmiUovorYv55xYnBPYwZt8UnBouFL6R4CvVFjGyrFIS2DNvcl5WX82pLu/9cTSxtwBzb448bwfTu29570Dz1olAw1u5NopGalpjmSCwEzFu7tD+krPkLX0+KT+NRGzT2TLupVemk9GJxa6JiEOWErFQf0ENZMQmE1pe6WzKA8sSHdElqcw0BvLeMaqSSxZJzxyfMr2ysNngAVBwk8RDO7E51ZxPpYueNA==
Received: from DM6PR01CA0014.prod.exchangelabs.com (2603:10b6:5:296::19) by
 MN2PR12MB4405.namprd12.prod.outlook.com (2603:10b6:208:26d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Mon, 22 Dec
 2025 13:26:07 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::b) by DM6PR01CA0014.outlook.office365.com
 (2603:10b6:5:296::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Mon,
 22 Dec 2025 13:25:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 22 Dec 2025 13:26:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 05:25:58 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 22 Dec 2025 05:25:58 -0800
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Dec 2025 05:25:56 -0800
From: Patrisious Haddad <phaddad@nvidia.com>
To: <leon@kernel.org>, <dsahern@gmail.com>, <stephen@networkplumber.org>
CC: Michael Guralnik <michaelgur@nvidia.com>, <netdev@vger.kernel.org>,
	<jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, Patrisious Haddad
	<phaddad@nvidia.com>
Subject: [RFC iproute2-next 1/4] rdma: Update headers
Date: Mon, 22 Dec 2025 15:25:43 +0200
Message-ID: <20251222132549.995921-2-phaddad@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251222132549.995921-1-phaddad@nvidia.com>
References: <20251222132549.995921-1-phaddad@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|MN2PR12MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: 13822c24-62b8-4827-ff93-08de415da9b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f/y6avoZePTnZpfl/amzXK5iH+auCwOwVKoT0F8jEzzrs4aWIzDPAtmnE/rm?=
 =?us-ascii?Q?o44oJoo99twpusz3g+ElI2tf+VJzykcrH9yR2bdIl0R/Sts6UmuS4udptn0Y?=
 =?us-ascii?Q?Llu+mRAw2+4fcMFZiClfgdmH/D9ivWvMwzyqskB+jUZvKTv0mJOWdgpQv+BJ?=
 =?us-ascii?Q?tKCtZWhmipXr/AcDZVTEhzoageAEKQ6HI/HLsestxn6Naz/3oThqP0va0Uyj?=
 =?us-ascii?Q?aqO8pH8jmBq8Y005AV68crND9mAv6X808QHB6i8OhBbBiEXhtFZyv0xsVeKo?=
 =?us-ascii?Q?BjNGv01425OGiI/2gvbuWk6gcDynzaNWEGhoKtgZQbUtJ4tKUVTAlzmQ0WTT?=
 =?us-ascii?Q?GFdNnDPHx4kXmknMgag9vmFTgNBgu3yMMgBUOt2RxHXmkHFn5WkJQwbq2mG7?=
 =?us-ascii?Q?XWn7QzQ7lxnqvP885e2sRzOZ+rSah0uyGeEKj8dO85msl3pGfrXVzstLoFUs?=
 =?us-ascii?Q?fQ2n5KZmRvFlujrWw41lVjnbbEe+iA1isnJhwd9ClDPy+FvvS9pHeNX8TULp?=
 =?us-ascii?Q?CeUrtI9Z0AKJWYbUvlxoD9EfM6hvX0sI+2U73B3Es7YMfYFzjPOYuuo9lvDF?=
 =?us-ascii?Q?Zaj0yGoeUQ10YZmFF2iSL+niytE9rYIiLF6l3hB+pI5U0gFBjLOhjGbav57y?=
 =?us-ascii?Q?tv6mvTOVfdCYHO7xkI/PpmNug4yxEls/RKykUuHOafRxm0FSwAuOB9F6sj87?=
 =?us-ascii?Q?WrXyOnnkemQNd/2LyybZEKKVz0yNhQq8iu6yc8qRym0tt3e7yuIgaSiTXS1/?=
 =?us-ascii?Q?5aq4waYq36F7zGaByfessBgFuFg8fzREqyEjS03NLK2PYoTVIlcBLViV9dxl?=
 =?us-ascii?Q?KW47Vm7XWubC7+F/N/ozCTqLLWaOc3NOUuxRuWHvCeNuZwQj2H7v8BLqQ0OG?=
 =?us-ascii?Q?5oDK3FdvDVZqBlWs/lxMno35ZOIQBvsk1+3e+Qo23E8ZnikT2HzUNfctigTh?=
 =?us-ascii?Q?keMNvJyS8LcDrT+mieJQX5meqFwrVTqtmUnjjgmYREmi53ZZKOMk2zqcvqVT?=
 =?us-ascii?Q?ZnF+9ylagBbPiN/T2JQNYMGeogXVKBUaPeC6XlF9EI3L3QwCmhsZ7sZZSBS2?=
 =?us-ascii?Q?XvxHx+Ig19XuYnUUxlRLBmYZiHGNXseyDoyyrfh5dsmlAd8f04Bw5BJEoluz?=
 =?us-ascii?Q?DLeEXHnTLP/PCQK0IoIIuo4pPqKFPTxfbJfQQtED2aGRhng9aLjNQnuZ1+n8?=
 =?us-ascii?Q?fPnbC5XP8BYWnanrPZdV5LVAMi6J70AV1THKhzAChV7+MeWfU3ki0vVCxqK8?=
 =?us-ascii?Q?kQsXI4y92wK806w8ObvqvcJBkuC+h1St1BXDCYusfaN6+f6P2WtexiUNamR4?=
 =?us-ascii?Q?FZWBn58BxRTG06M99W7Q/wDgFlBToaOXuMcrZBX23vG2AffnEweFLYRdGdYE?=
 =?us-ascii?Q?dMl75F+n3BE3tBnVadfXf6MoOOLdIow8yg1z3zcAtxHSNKUKvhQYFb5ZrOsT?=
 =?us-ascii?Q?A+cApz27DzKV4fULFMQs2LYgwa1qrEFAiZtWcshx1VBZskmyRZQZoQ4DeH8g?=
 =?us-ascii?Q?CrQ4+tbb+cQbvU4shFiwgBvCEtqkw1+ZOISC+URGFeVuaZ1kwiTIl2TeSkgh?=
 =?us-ascii?Q?1KRsRZLF75kCBN24QIM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 13:26:06.6680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13822c24-62b8-4827-ff93-08de415da9b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4405

From: Michael Guralnik <michaelgur@nvidia.com>

Update rdma_netlink.h file up to kernel commit xxxxxxxxxxxx
("RDMA/nldev: Expose kernel-internal FRMR pools in netlink")

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
---
 rdma/include/uapi/rdma/rdma_netlink.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/rdma/include/uapi/rdma/rdma_netlink.h b/rdma/include/uapi/rdma/rdma_netlink.h
index ec8c19ca..dc958c8a 100644
--- a/rdma/include/uapi/rdma/rdma_netlink.h
+++ b/rdma/include/uapi/rdma/rdma_netlink.h
@@ -308,6 +308,10 @@ enum rdma_nldev_command {
 
 	RDMA_NLDEV_CMD_MONITOR,
 
+	RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET, /* can dump */
+
+	RDMA_NLDEV_CMD_RES_FRMR_POOLS_SET,
+
 	RDMA_NLDEV_NUM_OPS
 };
 
@@ -582,6 +586,24 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_SYS_ATTR_MONITOR_MODE,	/* u8 */
 
 	RDMA_NLDEV_ATTR_STAT_OPCOUNTER_ENABLED,	/* u8 */
+
+	/*
+	 * FRMR Pools attributes
+	 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOLS,			/* nested table */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_ENTRY,		/* nested table */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY,		/* nested table */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ATS,		/* u8 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS,	/* u32 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY,	/* u64 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_NUM_DMA_BLOCKS, /* u64 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_QUEUE_HANDLES,	/* u32 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_MAX_IN_USE,	/* u64 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_IN_USE,		/* u64 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_AGING_PERIOD,	/* u64 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED,		/* u8 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_KERNEL_VENDOR_KEY, /* u64 */
+
 	/*
 	 * Always the end
 	 */
-- 
2.47.0


