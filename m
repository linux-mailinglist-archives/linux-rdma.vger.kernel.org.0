Return-Path: <linux-rdma+bounces-14751-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0ADC83A8F
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 08:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF6C434212D
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 07:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71332D662F;
	Tue, 25 Nov 2025 07:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GaLQuQrc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012064.outbound.protection.outlook.com [52.101.48.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0630B2D2391;
	Tue, 25 Nov 2025 07:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764054809; cv=fail; b=rkrREDUF4EAlzZnZoiqpJN117IssdMf8RoIzKqSGQVIwW1Nhj4HWPnJSDvewzQsOBcuSEmnTQvlAKK2Yk/0mamrFnhQQUA2fSZZF1YFojke1qNAcoGbQDmK+2TOqCqWih4LadrnbKBPPmC3bSGbtnGSOX4YOugxtsEKBI9EzMOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764054809; c=relaxed/simple;
	bh=H/pi6C3Qkjc3fotcPHqm44LsHiwHGJ80+4CPTTmZlLg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dAyikMMefdNmubmiFgNMTKX48cVTk108vE04U1cJdj7eAKHm18VSJD/s63uckBEarfrgqNlV3CrBtP+Jbp7lskjFZWyMIZyOIO+gYTl0wzopeJlH5kRKiA6bVzWeJNKrIDP9rPQ32s6Oz9gP5DZ6R9iuaTQfJgyh4uhtfkZgauw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GaLQuQrc; arc=fail smtp.client-ip=52.101.48.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUIWdPy7x2Ri6sFPZP0EhkC3QKt0xjHxor115FuuQaeF4qJa3/oo7JHSqJzsJnUgfpCL/pSPC60ykHcAEYPSnvW8XNS14mBKZK2xqXDkdmyROCBUBobOhyGkEtxvrMvbAKAZIPHOy/FHalodg+oOj5R8zQjgAAbN/13EQXC2A7bMdg3Nuvy7UId21+hROlfk+fNFt4JI5+NOxEd/ST/hG8FIIf5MWCArWha/B0suUSL/cF8aq0677H/Hc5niJgVLIChItG3PchGwCKE6XcEMkvvm94BgyBwCf6gLIFnLRI5GLZCUwmaLbSfzuCaADRRHrwzkcplV5yc9+ppEVYslVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkntJJTIdhxb+IPSh2D1vtBoEfL/DXtFthRKZtE082k=;
 b=WKB2moaBziuZFkxkThDBN5mHw7Fgh0W9qsrtb6cfqqRqL3Prkpp1a3P7FoWDs0QcEMNIq9rfpqUXj1TchFKU4N8YC/hv10KTNtiuyTuUdZLw85b11wVdZNquCM81PcA9WQNEhDBFf0Usu0Clxf5U8UKGdPfHuoiOtkD6dyInHj5AuGmnmRL5Ksn6Jlz6BX8wR0aVkM4kjLjA8fveCP7EovdUFDGHRrj/UYb2cAA71EWUMaoj9AT4/i86zoFwD0lonv7UrmwUzT7yOSUOZhgQXghYcOCQQnVYAjJt/mCajKLu3r/EdmylHPGQZGeJxpT3vLmiB+S7EEExs2B9u77sMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkntJJTIdhxb+IPSh2D1vtBoEfL/DXtFthRKZtE082k=;
 b=GaLQuQrchxj0VsvKBa9P0WndWA4LjrWkIjzO8q5bq9m3nMCYdeKv2jY7n9aTG1m6oW1OLc2pkQ2QXJSEO02lwpnTsh/I589v4XiQmBPJrNntm6HcgDQ4QiJSxyxSWlXfGfEyXSGVMYpsPzZjihcIH7o8mjGfiR08Iepsw4aN9DvBGTM21yU8cmhz/mgJeKktQi+ImK/Rx6UkoeafgA70AfEohVPF+ONXS+UM8qvsYttSa2BBtWsEj8qCZrNQvUafTHyWmU+FlMEyHYZPOKQhRfFIRYOhhKBrWRKAyu4fgaHu+kdb+u0A66bg1s/+DXs03hrbd2tut5O0ReaJA7K6hg==
Received: from SJ0PR13CA0196.namprd13.prod.outlook.com (2603:10b6:a03:2c3::21)
 by MN0PR12MB5860.namprd12.prod.outlook.com (2603:10b6:208:37b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 07:13:23 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::6) by SJ0PR13CA0196.outlook.office365.com
 (2603:10b6:a03:2c3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Tue,
 25 Nov 2025 07:13:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 07:13:23 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 23:13:10 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 23:13:10 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 24
 Nov 2025 23:13:04 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
	<xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>
Subject: [PATCH net-next 0/3] Introduce and use netif_xmit_timeout_ms() helper
Date: Tue, 25 Nov 2025 09:12:53 +0200
Message-ID: <1764054776-1308696-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|MN0PR12MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: ce1aa396-acb5-4e9d-c1c8-08de2bf21ece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVlicC9vM1cwZDdXTXg1d2djZ1ZwV0hmdHJhcnY0ME1XUWl4bE1EUnAwd0NW?=
 =?utf-8?B?U3gwZFN5ZmRpV0QwSGl4VDdOWUUxMG5obXpKeUR1UnZ5bFhzZUJkUDhUcER3?=
 =?utf-8?B?SEc5L1RJTm9lRk9JUjlxL25ZdDJIYWZRQ2V5T2Z5Zy9RSDExK0d4ejc1dk1j?=
 =?utf-8?B?VWFqNTZnMlYwN3FZa211UEV1YVlpaEg4ano5c05PekdPUFNSb0E4N3cwTitU?=
 =?utf-8?B?WkZIVnFhVEI4TnYzT1FkcStKS09lZ1U1QnZwN0RDcm14U2RPODdZOGV3MkZh?=
 =?utf-8?B?ZjdVWE82bElHaGdJVFRVVFdReUlTWFdpMFhlK0tCSGhaOERFaVdabXQzNTJL?=
 =?utf-8?B?MHpKaitJY0hoU3o4aGVhOWdKYVFQcHVVQUZIeXREQVhrbWlEY2duOEZLRlJr?=
 =?utf-8?B?UGRwbDBwUmlMTzBGelNOS3d4R240ZEZKOFc1TUh5d0l3SVhhY2pEMERDcGVm?=
 =?utf-8?B?UURPSUxKSFhQZmsxejhiYlM1S3prQ0IxTGllRVAxK1JSUG5saVdLZFZUWTVY?=
 =?utf-8?B?eDcrWThCem43ajlkUC9ZVmZLOVN3U2pPMEoxdlFSQVRwOWh4L1h1TTc4aVlI?=
 =?utf-8?B?dkRtY2NtOEs2VWRIYU4wbFQrUDdpTEFYeUNPMXBNZWNHYzRzY0JMOXMwOGhI?=
 =?utf-8?B?a2p0MDVqMUtEc2NVNVRSTTZBV2xvL0l5L3puTEMvU0E3SWliS1VkYWFjdnRv?=
 =?utf-8?B?VXlDY3pyVEJyRmpoZXNxMytERDNETGJCOG9rWXNxNlR1TXdhUlZKQWlUOFFx?=
 =?utf-8?B?Ny9YYWtlN3YzUk1hYm5RMHlwdkowU1I2c0FaVmw5dndkSzloSEJtVjU4WFVC?=
 =?utf-8?B?b0YyOXlHbFJJT3c5RmZnYm9hNDZ2ZTU1cm80Mm1XOStISVNTSjV0b29ybkJz?=
 =?utf-8?B?ZzdyMjJMeGJzM2wxeVJLRit2SjJUMkRRc2J4dWM2dW9mM0ZDZklYeWtTUmRo?=
 =?utf-8?B?djBuRm9IWnJLNGQrT01lSE16a1R3ZThrTWJOelQveXd2U201MjlTVWVLQXFT?=
 =?utf-8?B?UFFXVTJLZmJlbjFuOTJXa0lhbzBQNmxqNGErUDVYT3NhNUpBdlFWdHFyR0o4?=
 =?utf-8?B?Rjl6UGU4Y0Y0SktyZ1cxaDMyd0dFdW43emJpYkFQRldiQ0pxL3Nvc1hnYUFy?=
 =?utf-8?B?NjZnZDdZL3RaZE1NeERTU25nNTJJSzZVc1FLQWd4ZUljLzhzQ2J5ZVdkNG5i?=
 =?utf-8?B?c2ZoMkpUVHhXclVWT3RyNW1RRjE1cWdEMzMydXN6WXVYV3RpbE5UM0hVcWF1?=
 =?utf-8?B?blppV01MVGVjVU4vYnBXYkJqMElnUWV3eEV3ejJVaDFrUDhBWmR5WW9kenB6?=
 =?utf-8?B?Z0ZCTXh1VUovSmFwazhvY3dzWS8zOTIyVDN4b0FBWTVyYjRjUktNWE1qTjJa?=
 =?utf-8?B?eVJOVDJoQ3dmNDdieUlWTzliYkNvT3N4WmhUYmozVmpPeVBvOUtWU1RJSnBE?=
 =?utf-8?B?a1dmM0VEdUpkbHZqdlFWdFFsWEpCK09mRDF3QmdSQm9FckpNbXV0a1FYL2tt?=
 =?utf-8?B?aU5QOFdYN0wyRHV5b2cvUjE3M2M2ZWhPclVJWEFxbW5MWkNEOGdDWjR6M2pQ?=
 =?utf-8?B?VCs4cGQzVkgvWnRPQ1RrczVmYTJzZTcxN29HYzJtRWxFWnVtNXZudTc2SEZl?=
 =?utf-8?B?RWpNV2k0Q25VQ3hpdkxLZzJKN3FmcWZkZGFsckJiSEJXbk54TU5aV01yZDBN?=
 =?utf-8?B?a2wzWEgzWmlnZ2pMVnpveXJLKzgvUjFWajFXNWgxTzRDUXFHblp2dGsyYTJW?=
 =?utf-8?B?WTk0d1M2MzRXbHdMY3l6N1pmaEhPMjZzNHNzR0hPdXBLbkllbFVISE5zc2Z6?=
 =?utf-8?B?TGdhVXpOVDFkckdiRmFMZGhMNGdJK2twaUNTNHdQY1pBL2NpK1k3dkYrQ1pQ?=
 =?utf-8?B?bnlyb054NzJOVWpCUXloMHg1bTNlRG0wczVtTmVIUjlkMXlmd3JoNjhjOVIy?=
 =?utf-8?B?TnBTK1dFYllRTXpyQjFHT3lXWUVhRnE5SC9RVjNBb2w4SkxUZVVhV3VYQXlP?=
 =?utf-8?B?VWFvanZuZCszeS8vT3hUY21DU0hZbXdyUlFzN3h6eWhFKyt0RGFwUTExL1Ni?=
 =?utf-8?B?aXY0TlZTQkZ4ZFkyTjdkbzgxTUZHU0w2ditVNnlBaGt3cnhGcTFIQUlCMi9O?=
 =?utf-8?Q?nqFU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 07:13:23.1870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1aa396-acb5-4e9d-c1c8-08de2bf21ece
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5860

Hi,

This series by Shahar introduces a new helper function
netif_xmit_timeout_ms() to check if a TX queue has timed out and report
the timeout duration.

Replace open-coded timeout checks in dev_watchdog() and the hns3 driver
with the new helper.

For mlx5e, refine the TX timeout recovery flow to act only on SQs whose
transmit timestamp indicates an actual timeout, as determined by the
helper. This prevents unnecessary channel reopen events caused by
attempting recovery on queues that are merely stopped but not truly
timed out.

Regards,
Tariq

Shahar Shitrit (3):
  net: Introduce netif_xmit_time_out_duration() helper
  net: hns3: Use netif_xmit_timeout_ms() helper
  net/mlx5e: Refine TX timeout handling to skip non-timed-out SQ

 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c   |  5 +----
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |  2 +-
 include/linux/netdevice.h                         | 15 +++++++++++++++
 net/sched/sch_generic.c                           |  7 +++----
 4 files changed, 20 insertions(+), 9 deletions(-)


base-commit: e05021a829b834fecbd42b173e55382416571b2c
-- 
2.31.1


