Return-Path: <linux-rdma+bounces-15155-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE34CD60DE
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 13:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A264E3035267
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 12:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D541D2D6E72;
	Mon, 22 Dec 2025 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oond5alb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012066.outbound.protection.outlook.com [52.101.53.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B802D028A;
	Mon, 22 Dec 2025 12:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766407325; cv=fail; b=GRtbQaLEA6R3Rmw+zbGlwHVhUSdULr4HpmZHfV4vK9C9LzzEvr4zJVXa4QP2V3nDiNsQXS/7SGkMmJIKtQeqzcYibEMHW9UAGwqh1wBN3nsXjtnrcKZSwYC9nF1+nEPNfouIzYhBvLRGmdtEn3GT6pcql+2N01imWK86mnBCEuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766407325; c=relaxed/simple;
	bh=G7R8DNywy8VfnS1ZxzU6wkmVN9H392BSw/FQiF1NOKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KVw7eJ5f+k5zOMX+IqfyZ63/MjHk4mFT4v17BGB4eCbGp9mWdUQ7amCiRhtoumWe9RordziGKzSOJbby2+S9eQAxcHBUJXzng3GWNQXXXeX2gEFXmSNsBe4J14vUbeM792RgK+b2k26gpAZX4JXyuGyD5KPsRTx+QLfvxzAlCRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oond5alb; arc=fail smtp.client-ip=52.101.53.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PArFuypEXQ6pIhgFr/vq/CxNZvUrpFlPhWgi2oPjcoNsO6lGuMiMjgnAzL8vwDK4DRcZJtS/Rim51Npj+t1Aw6iQCXbwuy6DvKsnAhH57PS4bB46H2ChOxg6d+Herd0S/YntVBPTTR4jRga3rVIxIYTvU2u9np7GhpJcOD3qdUAkM6OhfzHusI5tzxLZwBm5hWuwEQXf/WNzIm03g234J2d8nzkTEad59gxf0wSQ7clC68+y7+qztarc/GnDQiLxkfgXbVTLowebbU3iIC2WHEerxu5km279zMSIIXG2n+42oVNql0rAHIthCscDuvCOjPx8r6TrRBB3hZkdvBnMQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZPRjZdOF49xgAciLcVUPgdB1JcvSkF0yyRRCGkox0M=;
 b=lE9SGPBg+YwZFmNEZgY6XAPFYE+vot8/Z9ia9JQuWYy0Rt7XKS+3TVjGKkXuRCoKguzcRcWm92YdF8sQURKqb4zv2TX3e+C6JYpsLHMdPAw5DPf3zbtgwiGS7lvwQpiIeIZIMSgezqDbI6LH42VSsiPpgtWRgXyEj9lrnTyw9Eq6Ri/3X13I62TaYygkP+eeorNhwyo/JZYgYI1RenHcEExYpDW+OM7H9QO1OEXKowSSi8StTQtnaV05Qh3NV5Os1K3hCgSaO31eW+JlLY0Vwv/Ds5SjJ8ix/pefcLuBVc4iGYAHrzyBt/TIWUG0iwIOAt28sPi1wLKDHOzHc3b1wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZPRjZdOF49xgAciLcVUPgdB1JcvSkF0yyRRCGkox0M=;
 b=oond5albagu2PclVdsbOZx1rorzLi5fcpQ43qG3+du8EwV6mI+UqhT/0QX+WLEBZgS+duOILCGb3ZepY0gEsMhcI9AsqBWAOVuGGO5w6YkWy8TxYe7vvqTLgxRztmNNe4lhXK880E80DOpS9cyXzgA3DMx6Iy4Wa71kvdy/oMslVQiXY2uvAU16gPjtEwpj9a47pco5Wv01isAV30hpM19ZEWqS+z4H+qvPPOHFT2HKv0J0ZoBcUkzBmOCckN8aIpS4TvmTz4kvKI266QMzx3237x+0PHHmbQ8EUYbV1EDbE8UfUzpdZLwKQPB3UvT69nH4+ap9aXtXUux15AU9OrA==
Received: from DM6PR08CA0031.namprd08.prod.outlook.com (2603:10b6:5:80::44) by
 SN7PR12MB6670.namprd12.prod.outlook.com (2603:10b6:806:26e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 12:41:43 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:80:cafe::9b) by DM6PR08CA0031.outlook.office365.com
 (2603:10b6:5:80::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Mon,
 22 Dec 2025 12:41:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 22 Dec 2025 12:41:42 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 04:41:33 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 04:41:32 -0800
Received: from c-237-150-60-063.mtl.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Dec 2025 04:41:27 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 22 Dec 2025 14:40:44 +0200
Subject: [PATCH rdma-next v2 09/11] RDMA/core: Add netlink command to
 modify FRMR aging
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251222-frmr_pools-v2-9-f06a99caa538@nvidia.com>
References: <20251222-frmr_pools-v2-0-f06a99caa538@nvidia.com>
In-Reply-To: <20251222-frmr_pools-v2-0-f06a99caa538@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766407244; l=6377;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=r9C3A+JFfXoQa9P9KVuIVt38E32lQcFggjz/EPcMBpg=;
 b=KinftLieYsyaobYCmWH20bZp1b3rcOXHTQgEbu0zQLnNlMLON3GTEfg0iVQTlnsHj36D6lBmo
 kropYG4WgMsDz/+iaFsp7MZYBL4IX9BPo20aBjEYqp32nCeFW/crZL3
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|SN7PR12MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc4bc94-cfd1-46ae-7c1b-08de415775ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MU93eUxiRmpoZXNnL0xiY2cvNStNdm1CQktqR0N3bitqd2xib2loTnZJYmVs?=
 =?utf-8?B?WmJaaU1xSE02SWtady82dm5VUm11dXh5cVkydWZ1dkJibUVyRE9SQUd1Rysz?=
 =?utf-8?B?cU1vSEUrYmtoeG54dkdWYm4raW40WitXbm5jaWRjVVFTNFlvV2o2UnNiamdC?=
 =?utf-8?B?RENmUGhidk12L1RZTHR0a3RkTkhVZDh5eHVLU0RiYUIvVm84ZFFFZW9IeTl6?=
 =?utf-8?B?Qk5ad0RDWkpvNW9oaFl1M1pDM2NNb0o2TDlRVDJ5b2dHaFVMY2oyaW5zSExt?=
 =?utf-8?B?dWtZd0dRUnY4Rm1aQzM4aHcvUElpbzkweWxRSzlDOC92VmtPREdNY2pHKzBp?=
 =?utf-8?B?QTBmYWovMjVyWGJpd3I3WGZ5dGZxaXA1a3NZZ2FKeWVIZytabFlpTC9jZDR1?=
 =?utf-8?B?MmhEMzY3YjlvVnBQb015WWVCZmQ5VDVuYURZSVhYLytZdmp5QnFNck1SUldu?=
 =?utf-8?B?L0I2WU82T0J5UHY2aWJrTDNMQnRoMzZ5cCtrZ2tKS0E1V0gxelJoSnRNUDQ3?=
 =?utf-8?B?QjRac21wVnE2SjFHdjIyNmVGQlhPOTMvbEwvajI5L1hUZ3VmcnhGNXpqSER2?=
 =?utf-8?B?Z2ZmR0RXODduYlJ4bzVodTZCVnFGaUJxUzNjSXdzd0w4bGJNK21jNnFpeG1S?=
 =?utf-8?B?TDVmVWswZkZyYTJsSnFVMEVsQzkzQkhuYkZwUmZaY3VXc1VHZU4rWHFIUE5L?=
 =?utf-8?B?K2FWWGVUMXlYMncxazMvbTZremZnR20xcGFBOThEcjhHY1hvSWlDM24zR0ts?=
 =?utf-8?B?Y3p0MExQMUpzb3cyVDBuL2owcUpUTktaS1E4VjRrMWR6QVUzYml2RmFpSkdj?=
 =?utf-8?B?MXNHZHhrMnlIU2xjcU5veXVKZHMzcUkwTHFRajJOMHJKclRwU0k2dE9aTWRu?=
 =?utf-8?B?OW1KZXlCeElYSndCQ04xM1F0T1M2TkRmOTFBd3JBRFF0V3NMd0hvNTNTNE1S?=
 =?utf-8?B?YzNEWmRob0tLRExBcjFpRWZ0akRweDFlbWtoVHJRTFg0amFjL28veWM0OENU?=
 =?utf-8?B?TThaU2FVWDdlQ0tYaGRhVVNPT0FVTzFKQkw5L0hONXFxQUxZazRqQWlmdmE1?=
 =?utf-8?B?cW5hczE4dnRJNzVoMEdLN0ROdWpTQmJsTUpFWmc5RlJRaTE1aGErend0Rkxi?=
 =?utf-8?B?dExHeXI5ejNNMWY2eGRTSExyRUlVZXNnRWEvcW5LSk9YMkwvYUFxcU5VbGUv?=
 =?utf-8?B?YmxhajRuOEo1N2dIZUtRZTZPT0xLdU5CNmM0K0JPSXpJcEMwbzFKaHY4WHoz?=
 =?utf-8?B?WHdwekVNcmhDaWRQditQOWZ0QTJqcllYQ3lyZVNQSHVNZ3pYR3J1Vjh0VHV1?=
 =?utf-8?B?bGNzaEhGTzRmRlo5U25GdHhteFB4OEJab3ZTUW0yZXU5WGhCV3pQT2MrT1dy?=
 =?utf-8?B?SittTjJpL0ovNnBqNFpJZ3p5NG9GNStEQVg3L24rOUEvWnRmT2FmdHJ5dkZ3?=
 =?utf-8?B?S3RCRU1uWmpvUUlMdHc3Sy9RQi9GZSt4a2dwQ3gzMmlVcWRYNW1ocWFYZiti?=
 =?utf-8?B?UEsyYTM0R292MDZJam95eEpIK0tuR1dMcG5RejJSVTJsdVJYbjNpYzUxODVT?=
 =?utf-8?B?NCtaMk05VEVIZmdUaWtiQXFiVXB6L3VSUlI1ZnY4TnUxOXl6NDh4RHgzZGlv?=
 =?utf-8?B?Unk1Z1ZHcWd0VUROYnZtbGFMbkxkMVI3L01makQvcFNXUVU5SWFUQXBzMXM2?=
 =?utf-8?B?VG9BRVNhN2RJeXFwa3BrZDIvSnNVZVhaS0RlQW05UkRJQ3VLWFdlVEdXejVV?=
 =?utf-8?B?MjJaVjl0dHE2WmZNc28wMDFQdEJBNUQvQlExQmh6M1djdVlUMzZZY1MwazNj?=
 =?utf-8?B?R1haOGU4eVhoS3p0TjFwQnhUZ05CbFBLdHdVdHZUbkVJMi9SL1JCVEg1Unk1?=
 =?utf-8?B?Zm40cWtIY3pmb1daRFEwRVdLVjdpMTFLdmxqOWd4UTNSSVh1VjhQbXQraWhZ?=
 =?utf-8?B?QU1SQTU2L1ZmUFNHZWdzNy9wOEFOQzdJUnpaeStmaFo2RkRqaHVIdktXMWsz?=
 =?utf-8?B?eHZyaG9pS2E4Wjdrc0FzRVFzazd1eklEZkh6Y2o1eVhSMk16eVNwamY3QUQ4?=
 =?utf-8?B?QTVTN0N4amNIWXR1bTRTT0VDS1hEdExlb0dPQXdCaUErRXVTWVgwOU45U0JX?=
 =?utf-8?Q?SpiceAc8YwH/KY603I7FhYFgA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 12:41:42.7888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc4bc94-cfd1-46ae-7c1b-08de415775ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6670

From: Michael Guralnik <michaelgur@nvidia.com>

Allow users to set FRMR pools aging timer through netlink.
This functionality will allow user to control how long handles reside in
the kernel before being destroyed, thus being able to tune the tradeoff
between memory and HW object consumption and memory registration
optimization.
Since FRMR pools is highly beneficial for application restart scenarios,
this command allows users to modify the aging timer to their application
restart time, making sure the FRMR handles deregistered on application
teardown are kept for long enough in the pools for reuse in the
application startup.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/frmr_pools.c | 31 ++++++++++++++++++++++++++++--
 drivers/infiniband/core/frmr_pools.h |  2 ++
 drivers/infiniband/core/nldev.c      | 37 ++++++++++++++++++++++++++++++++++++
 include/uapi/rdma/rdma_netlink.h     |  3 +++
 4 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
index febe23920f56..c688529a16d8 100644
--- a/drivers/infiniband/core/frmr_pools.c
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -174,7 +174,7 @@ static void pool_aging_work(struct work_struct *work)
 	if (has_work)
 		queue_delayed_work(
 			pools->aging_wq, &pool->aging_work,
-			secs_to_jiffies(FRMR_POOLS_DEFAULT_AGING_PERIOD_SECS));
+			secs_to_jiffies(READ_ONCE(pools->aging_period_sec)));
 }
 
 static void destroy_frmr_pool(struct ib_device *device,
@@ -214,6 +214,8 @@ int ib_frmr_pools_init(struct ib_device *device,
 		return -ENOMEM;
 	}
 
+	pools->aging_period_sec = FRMR_POOLS_DEFAULT_AGING_PERIOD_SECS;
+
 	device->frmr_pools = pools;
 	return 0;
 }
@@ -249,6 +251,31 @@ void ib_frmr_pools_cleanup(struct ib_device *device)
 }
 EXPORT_SYMBOL(ib_frmr_pools_cleanup);
 
+int ib_frmr_pools_set_aging_period(struct ib_device *device, u32 period_sec)
+{
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	struct ib_frmr_pool *pool;
+	struct rb_node *node;
+
+	if (!pools)
+		return -EINVAL;
+
+	if (period_sec == 0)
+		return -EINVAL;
+
+	WRITE_ONCE(pools->aging_period_sec, period_sec);
+
+	read_lock(&pools->rb_lock);
+	for (node = rb_first(&pools->rb_root); node; node = rb_next(node)) {
+		pool = rb_entry(node, struct ib_frmr_pool, node);
+		mod_delayed_work(pools->aging_wq, &pool->aging_work,
+				 secs_to_jiffies(period_sec));
+	}
+	read_unlock(&pools->rb_lock);
+
+	return 0;
+}
+
 static int compare_keys(struct ib_frmr_key *key1, struct ib_frmr_key *key2)
 {
 	int res;
@@ -523,7 +550,7 @@ int ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr)
 
 	if (ret == 0 && schedule_aging)
 		queue_delayed_work(pools->aging_wq, &pool->aging_work,
-			secs_to_jiffies(FRMR_POOLS_DEFAULT_AGING_PERIOD_SECS));
+			secs_to_jiffies(READ_ONCE(pools->aging_period_sec)));
 
 	return ret;
 }
diff --git a/drivers/infiniband/core/frmr_pools.h b/drivers/infiniband/core/frmr_pools.h
index b144273ee347..81149ff15e00 100644
--- a/drivers/infiniband/core/frmr_pools.h
+++ b/drivers/infiniband/core/frmr_pools.h
@@ -54,8 +54,10 @@ struct ib_frmr_pools {
 	const struct ib_frmr_pool_ops *pool_ops;
 
 	struct workqueue_struct *aging_wq;
+	u32 aging_period_sec;
 };
 
 int ib_frmr_pools_set_pinned(struct ib_device *device, struct ib_frmr_key *key,
 			     u32 pinned_handles);
+int ib_frmr_pools_set_aging_period(struct ib_device *device, u32 period_sec);
 #endif /* RDMA_CORE_FRMR_POOLS_H */
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 6637c76165be..8d004b7568b7 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -184,6 +184,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES] = { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE]	= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE]	= { .type = NLA_U64 },
+	[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD] = { .type = NLA_U32 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -2799,6 +2800,38 @@ static int nldev_frmr_pools_get_dumpit(struct sk_buff *skb,
 	return ret;
 }
 
+static int nldev_frmr_pools_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
+				     struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
+	struct ib_device *device;
+	u32 aging_period;
+	int err;
+
+	err = nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1, nldev_policy,
+			  extack);
+	if (err)
+		return err;
+
+	if (!tb[RDMA_NLDEV_ATTR_DEV_INDEX])
+		return -EINVAL;
+
+	if (!tb[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD])
+		return -EINVAL;
+
+	device = ib_device_get_by_index(
+		sock_net(skb->sk), nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]));
+	if (!device)
+		return -EINVAL;
+
+	aging_period = nla_get_u32(tb[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD]);
+
+	err = ib_frmr_pools_set_aging_period(device, aging_period);
+
+	ib_device_put(device);
+	return err;
+}
+
 static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 	[RDMA_NLDEV_CMD_GET] = {
 		.doit = nldev_get_doit,
@@ -2908,6 +2941,10 @@ static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 	[RDMA_NLDEV_CMD_FRMR_POOLS_GET] = {
 		.dump = nldev_frmr_pools_get_dumpit,
 	},
+	[RDMA_NLDEV_CMD_FRMR_POOLS_SET] = {
+		.doit = nldev_frmr_pools_set_doit,
+		.flags = RDMA_NL_ADMIN_PERM,
+	},
 };
 
 static int fill_mon_netdev_rename(struct sk_buff *msg,
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 8f17ffe0190c..f9c295caf2b1 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -310,6 +310,8 @@ enum rdma_nldev_command {
 
 	RDMA_NLDEV_CMD_FRMR_POOLS_GET, /* can dump */
 
+	RDMA_NLDEV_CMD_FRMR_POOLS_SET,
+
 	RDMA_NLDEV_NUM_OPS
 };
 
@@ -598,6 +600,7 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES,	/* u32 */
 	RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE,	/* u64 */
 	RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE,	/* u64 */
+	RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD,	/* u32 */
 
 	/*
 	 * Always the end

-- 
2.49.0


