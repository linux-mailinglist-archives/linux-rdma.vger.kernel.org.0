Return-Path: <linux-rdma+bounces-15445-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB0AD11748
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 10:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2346E306A92D
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 09:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E450340286;
	Mon, 12 Jan 2026 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uC0mouJV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013026.outbound.protection.outlook.com [40.93.196.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83BC3254B5;
	Mon, 12 Jan 2026 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768209474; cv=fail; b=PRUgAiE+cgiVcioHE+/WHzqJR2oEdQO/E9FMAhG5K4CCVsN2MGDi5e8GNBm36KR4KDHqt2mPylpu+1n0IirzPOCShY98q3CUga1fSefJGJfwjMebOJU87MH/SLR1OYQ/uGV3aYTsxEIqb1ehkoA8NRdzkXQlUGG7cbFp8yBQ9HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768209474; c=relaxed/simple;
	bh=6yc94fLBSIgLCeh0omiW65WfHSLtb6xSbSz7nlh4hy8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGuyEdDTxXVfSNt/mPkA7v4s+YQ8Z8GUfgjjxTcCXD684Dskq0GaqXIWiCi9VlhHvu/v5F8cfuwH0u0ro4iQNouPMewcGIeBPyOI5pO3FeA24y9YXN9K5LdYi9/nQpTC9WcXYelGZcTBIxVrW5YdO6xquOB33FMxoPcPPeRvJOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uC0mouJV; arc=fail smtp.client-ip=40.93.196.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+cMHjPN9gHWYbqCoGeSpgDqKAsqtmFkf6MEKffMzbSaeZ9UHzRlPdKztIMC6ae32JAmQ8J1gnan+1xY5xKv1mVFjDQtI09EheMLWlknWM51E4rNYdCEWMs5rITAUGarCA2BuS5ciBk1mVl6IVpL3MMNz1dC8a1cB33JQNCv9s0rWP7zSPRulGJC0vXRghFXeiiuTXqIpUTO0HmP9AyyCuDYxnUaso2Sn0/n6xCLpzJwgCrAiP/YD3D1MlyvZw/7zhCUhSVpaRYIbdYQ++QOsSfx8h3tNjjlawtke7JGXwG67aOue2uuaOQRgkXQZVpEgUlcHa7QrWRVC8iIy0sOsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOYo6+zQJmkhCMdubdMkP5ZAj4WEkdGu/y5HNNh46Mc=;
 b=U7st98qcbp+paQwZCsdiFTrX442yHj59Nt5jJLkadLH8MgkK6ibXaeermN6D24EXvXSEQ7d2C7aMDmb2aH8Ah7QyF2xc1dplVq8wz6l7t6GOvKgX1GfEMFJiIFs0jZufAWtyxFPlkocge4tt/f8kwx+DsBNXjjaTusl4WXldHnEr5pfooNX8bveIIExEy8ZTkOvAGUm2N/hCO7qUzhVR800XoRGJf9FE1f7mRMVr2/6EC4E0XLGkJtXBnigRDKkUdWuifl4fRji5qBO8ZgJEK6j1T5tmf8YJGwHX3WF4jEY8ywAPR8gaKJfzqFpoBLwK2Kw333ke/ZTbMHyf3QNWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOYo6+zQJmkhCMdubdMkP5ZAj4WEkdGu/y5HNNh46Mc=;
 b=uC0mouJVlCfmp2/JOigC2JkS3i8MOjvsThvgfLbNZQKPQH5agGmipNXd9XKvTaUwqob4ZuAycPJFcK0ftcDk6AptJvBdClyiRQyLIt2gvV0yoYK4Zh6QVc42YiLdJSFS1sLQw9MYj7bxbE9s06rH9ky82CkIRktxv5OyjRKeSMrsLRIIWGenl0ow65fKEr2LbrAJyGEruaMqqCaATTjs6gZwBmr9XQyIL9kQAg9mFN///ur+ZmnFF+FJvtH+U5eqFSW+v4zHlYF7+hUuRbPq6m1dIZ1QGn+6KoVP76E8f9LPL+QDu7Z4/Z5CZnDM8towCbYzUqDzNHTSwcw8OjHuWQ==
Received: from BN9PR03CA0107.namprd03.prod.outlook.com (2603:10b6:408:fd::22)
 by CY1PR12MB9699.namprd12.prod.outlook.com (2603:10b6:930:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:17:48 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::f4) by BN9PR03CA0107.outlook.office365.com
 (2603:10b6:408:fd::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 09:17:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 09:17:48 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 01:17:37 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 01:17:37 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 12
 Jan 2026 01:17:32 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>, Yael Chemla
	<ychemla@nvidia.com>, Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net-next V2 1/3] net: Introduce netif_xmit_timeout_ms() helper
Date: Mon, 12 Jan 2026 11:16:21 +0200
Message-ID: <1768209383-1546791-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1768209383-1546791-1-git-send-email-tariqt@nvidia.com>
References: <1768209383-1546791-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|CY1PR12MB9699:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f303eb8-0ac5-46b2-9038-08de51bb7437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VH73Uml378JtJtaioMUl+dnOQEqk59esEwxayxdaGnYF3JiK+k+iXCZHrcc6?=
 =?us-ascii?Q?U1ybth7LB4PNg8OGu2NfF6p59oNoZX6luhzaiNhGEJn9XJeLxMRQaAtfxA9k?=
 =?us-ascii?Q?eOMfcYBS5Y2VevgpjXfv3DZD8P9K9unQYob+f1AnwOUz8Nv7Y/EA/yksWccN?=
 =?us-ascii?Q?CTUjac3M6czzersZHcl4cCT6Z9xSVPxJRpXd5wn+OusPudN2ablQxjCTJZmQ?=
 =?us-ascii?Q?0NI9nqA1tWMV+yAWHilEVNObsR+NqIiK4O9zQd2VEuialXiwpdKmAT6y0TmT?=
 =?us-ascii?Q?VxGvzqhk8I92vsQt4s2kNoXizao3XCIjLHh5V1AhCDULqEviRJcwkZhQi0Vh?=
 =?us-ascii?Q?nGrtyhmLTpcD0X/p7vop5no4T9K4KPTpxNfiwK0X1wASGISE01U/G6jNubzq?=
 =?us-ascii?Q?8BTCgyj+PM5/lDzPhQyG6wN3yjgMxNgh+2KjQPoFIiWfiWL0AIcQxLlJqAFD?=
 =?us-ascii?Q?Li7FbGWkHq2OTl/fsa9h+lRkE8Frf7CTdmnPjYs90RfivGjh2jz5LU/BwmAF?=
 =?us-ascii?Q?c8jd3HQyvSb8UvaJoRYNczecsJSHELxI0/kXRHsjMBXqyY0htpfa/gVgaihy?=
 =?us-ascii?Q?aWRcnDEdMDCxEQVdehY1jhZGbObm1WUwwjCmsQckTFk7Y+f7A6fnCIHkgjpY?=
 =?us-ascii?Q?WvfFHrMXxSIenKA+5xPVQ4a4DgVKuqnefQKDmo3xkylwmJ+eVYdE7Pi7TcJH?=
 =?us-ascii?Q?bKInzwfvOpMsSS7ADnLkkdfu1K2p2hXW8E224FQDJqudJ++bHiUU2iVl0DxN?=
 =?us-ascii?Q?0VRN+jbF5k+NIOsxV+pMEckf3rHel14zfhwYIjm/Zq4WbCzVYjkpWPJuRlGA?=
 =?us-ascii?Q?EAcO+HNg6M7mNIOUuZai205C/YnchUDeMrjyrMwPGMtnuPCBJMQi+cLsdo/g?=
 =?us-ascii?Q?lyeistCzDzljUavALrJQnRtkgnLo1LXHk2ujDgmfTs3o3SkrKK2HLZKBd6cA?=
 =?us-ascii?Q?7glb+mc0MmSVOosjxLBE0zGSpV/UwU1ebrpGTUIAK6jdECkDRQ4RnGsX14V0?=
 =?us-ascii?Q?3PVevrPkjJ5VrpcLDjCUvye+x2empSJn7Q25UQ5DC/oePtbRMOCWk5DV3TF2?=
 =?us-ascii?Q?WErF33ctbpUUbTySsPxVYuntq5QPhm0jfagrXiX6D4nDwmQLKTkd5LmCkcrv?=
 =?us-ascii?Q?jv8yX4cIbJeFU6pXIF05XSvtSaj9imIMrRJUsGuBlfj+x0jK/PG0S/nkczuA?=
 =?us-ascii?Q?kw5R5goGdKIFnYCf1viq7iqdoRj35rKDzslIAI63aItr0f0T6BfffqKB9OHX?=
 =?us-ascii?Q?vdFYzOHr5+3F2VFlBR2EGwhMpEgbonDxU3KBoJpJBZV2oc4eHcZjSA/PnIwD?=
 =?us-ascii?Q?1vewZh884EdMO4t7a2b4IemkTSRoLd9sA/HqTzqE80bFEKLskttcIvvkHrJk?=
 =?us-ascii?Q?YiWW1X8V4A75xPjDhjAk7KpGWJ1wSpB0x21haxg1LQXInO6jNuDYqzukv7X2?=
 =?us-ascii?Q?UE3ngJx8FiK6/GWujqs8hMTsWIelnfIwpv5uc3qEJusOmWngtK8YL2fvwoYb?=
 =?us-ascii?Q?OB00crHIiIet6zxGPNARMTY63jMjAC+tZKWr+iOQXzxWnUHDGCpGLI0vnQt3?=
 =?us-ascii?Q?Gj0HVsOvsuRXJtbBorc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:17:48.1847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f303eb8-0ac5-46b2-9038-08de51bb7437
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9699

From: Shahar Shitrit <shshitrit@nvidia.com>

Introduce a new helper function netif_xmit_timeout_ms() to check
if a TX queue is stopped and has timed out and report the timeout
duration. This makes the timeout logic reusable, and will be used
in several places in subsequent patches.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/net/netdev_queues.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index cd00e0406cf4..b55d3b9cb9c2 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -310,6 +310,17 @@ static inline void netif_subqueue_sent(const struct net_device *dev,
 	netdev_tx_sent_queue(txq, bytes);
 }
 
+static inline unsigned int netif_xmit_timeout_ms(struct netdev_queue *txq)
+{
+	unsigned long trans_start = READ_ONCE(txq->trans_start);
+
+	if (netif_xmit_stopped(txq) &&
+	    time_after(jiffies, trans_start + txq->dev->watchdog_timeo))
+		return jiffies_to_msecs(jiffies - trans_start);
+
+	return 0;
+}
+
 #define netif_subqueue_maybe_stop(dev, idx, get_desc, stop_thrs, start_thrs) \
 	({								\
 		struct netdev_queue *_txq;				\
-- 
2.31.1


