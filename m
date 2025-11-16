Return-Path: <linux-rdma+bounces-14499-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A64C61B46
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 20:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FE744E3B53
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 19:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB89246BD8;
	Sun, 16 Nov 2025 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XiARZO/X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825B123AB87;
	Sun, 16 Nov 2025 19:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763320321; cv=fail; b=KWFac4gnXlnh1xhdAKlnI+pfAqE6iYb4qArJuKqn/HBJoB1f8bKYXs4AlHp68hOGQp+Or3hppbT7xxWXh0G11pfLm9dTnFOXafnUjLFL1iq5jsvX0+qYfOvtnhFbQBx75yM1tLdOut9segRRtba/LptXZHl1MyeH1STW9pYN1aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763320321; c=relaxed/simple;
	bh=HZS8CUzCrTDneadJFGtrARf1sHkQKTR3X7WJJ5Dl5n8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rkeIOSmhIOqPzk4X+wLEthzO6IKlzG21y0/MGLP6Go7Od2H+SpzTU5JnYVWdjliZW3+eSApQbxP2LjabGp0XCeYh0kEnq52STQjEFyY+HWaCePBVeurSMNUvxg75ur9HtV7hWKme/POn9Ams7ByA6kxRegddzQz+D7dy2JQIYVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XiARZO/X; arc=fail smtp.client-ip=52.101.48.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgN0k0jz0AkakmkXCut/lF5sZhe04uQiwHly9zAbUbA/r0u1kazS6Fth3+wBhULldfXBMHaMneemek5Ta4u6LsDUgUaJ2qIrsqZuUEMiQmw/hogNdqw4uh1wryQWbLCCphotbVwO7vPCpjzBv06zn0zTuxOBd1wYXCDt5oL8VLlz2uyQZ2RnsZ0zxysmQU0ZYF4OEdpKJHfd+nnJ5cSVBBODuWdPlA8Il/1pEgx9retcjPkJuzKZX0Mv3YxwIVHMHEsK1y8Q3QbrBz9DUOjcYANHfEctVK3W8bkXp0OeLCsoHU8UqSScjDCAwD6iNEIF2pnJMCDI7l+vxAfXhJg4hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S66BFgehDCuGj3gMIzzuSLMVDkXKYeG7Ln+tPAHFpx4=;
 b=MLFbkoXePA6jCVVihOLlWSbs349GvV5G6uDjCkSgr1+xJpz+NhduQGhOtarSniy+ZY/H5mE6oBUGPmIbob0I5CUyhbTUSmmFxpUELLM7JuWfOVVvOtsluvZLpNN6BakLgTxPr6tfTSkIb7C3l1AwK49dXJIAm0YQpCQPOUhNH4nIIC51EDh0nu3hl0UEJR9/Madx837ZzdpSRhZx8qD+fxNH3PzbXbldvd76NmvyRaLv75+elBP69R9WgreT5D9UKZzzqoqDvprMq3K/KKhUKNQYXJf3SgJxnoj3g3oGBjT6MUjPN8iR6+yDQJXvWScbwnrHJ0Nz3Z98CoYZOTek6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S66BFgehDCuGj3gMIzzuSLMVDkXKYeG7Ln+tPAHFpx4=;
 b=XiARZO/XYN0TF10gGKVDk2JywPd//9gX8X26PIkk1QXDjz5VMYo3D4ggFZ8E7zhhkoPdL9lC24G6C9uJcPbv9x0OVEwLPFwi0AKh4Ie4W1XpH91dKStwySgn1x4HiVvo1WgHWqPAr6XYbK6QPvjOUV3K3yXmF2utPD8p14xCH4qxcWvBq+bennD13XMXlmM2zmWChCQPYKYB8Qp32hdB7CvI10XJg8Yn8go1aJejVMLpOh/2r5WISI+IOSoMe8tP2IRWi1n8PIZur8Q+VblgqFYqlpkfbMOYQxO8UN8pweWwsFK+7Pll5Rzal/ar9IXbXqP8JBk9k4Uqv06Pr0vfdg==
Received: from SJ0PR13CA0072.namprd13.prod.outlook.com (2603:10b6:a03:2c4::17)
 by SA1PR12MB5639.namprd12.prod.outlook.com (2603:10b6:806:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Sun, 16 Nov
 2025 19:11:54 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::5f) by SJ0PR13CA0072.outlook.office365.com
 (2603:10b6:a03:2c4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Sun,
 16 Nov 2025 19:11:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Sun, 16 Nov 2025 19:11:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 11:11:46 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 16 Nov 2025 11:11:46 -0800
Received: from c-237-169-180-182.mtl.labs.mlnx (10.127.8.13) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Sun, 16 Nov 2025 11:11:41 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Sun, 16 Nov 2025 21:10:23 +0200
Subject: [PATCH rdma-next 2/9] RDMA/core: Add aging to FRMR pools
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251116-frmr_pools-v1-2-5eb3c8f5c9c4@nvidia.com>
References: <20251116-frmr_pools-v1-0-5eb3c8f5c9c4@nvidia.com>
In-Reply-To: <20251116-frmr_pools-v1-0-5eb3c8f5c9c4@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763320291; l=6977;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=rJ7RYVNjeLG9rK4QuGSikClc06agmvcyuyIckptX9PU=;
 b=HB00Lf8clXrFXBJ15+i5VQisnRfjWYWXXAuWNmrq8wxwzXuWEv8Y4Of+gvOTkcAJWJvsKpgjK
 6Zbr0KP8+y+DG3P2BzAG30bPkHYKY11CYXEqF6SOnsDsde2XMyva61d
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|SA1PR12MB5639:EE_
X-MS-Office365-Filtering-Correlation-Id: 90cef015-7f7e-45d6-86e4-08de25440142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUx5dE9SWS9OTjhGQUIyRFhpRGgveXM1ajVTODZIZXFKM3FYOXlycGtCQkEw?=
 =?utf-8?B?UjdRWHhYUXFLS3BZaTc2V0FKaFhjb1pBdm9NTngxUysrZjhPWU9DQWJ5Vk8x?=
 =?utf-8?B?ODVES3I4M1p6bklwN1N5S2FKd2NwclgyUkFjZ3FtTmcwUTBob1RTOXJCQytO?=
 =?utf-8?B?alZHMUxEY0lvLzl5VlpHRFIyczJRWHlOckFxTUdCN2hUeGhmUWQ4T0Z0ZDZO?=
 =?utf-8?B?d0tzZVdNQ2pENjVsSlNNQ3BSOCszVG1RNEtHVS9ldEFyRFk2b1o3eTFQTGNX?=
 =?utf-8?B?eEdXSWxXZUxVbkNRNEREZTFGWkpiWVdPTC9paWp4UnVGT3pSanNuL1NNbEdB?=
 =?utf-8?B?ZXc4a1ZrdzBRTUxmL08wRkd5ZE9CSlJDWURwNHpoTEdrbkZRWTBQeDJJd2Zm?=
 =?utf-8?B?NGVocmFBbmRvcVF6LzlJMHMrV0ZROHVtcDl3b2x6REdNc25vWDhRQUJvSG56?=
 =?utf-8?B?a2s4Z2loY3laNmYrN2ttcGZ0NmUvQ3g3eGFiWDFNcHlIc1owY0VNRUo3UW9h?=
 =?utf-8?B?SUpCZGRXMFE2UVh2bVBJaDM4NWFwQlBHTXprQXpoSUdwT3RXYjBHWXY3UUdN?=
 =?utf-8?B?VFNCSExaMDR3dmR5QU84V29rcjdWSERkc2kxMVU1akVKWEZEakp0V2dWNWdH?=
 =?utf-8?B?RDkweVZ2TXMveEYyRXpUa1pKNlA1Ylc3dGRsOHlhdXZnNTdzb2kxSUR4MnNO?=
 =?utf-8?B?OTIzRU41WVZGaVVKQ0t3L0ZCZnhVZkFEYU8yY3h2YjlYeDI5dWx3R2lRUXZu?=
 =?utf-8?B?aEJucXhTNmVLWUlNa1NnckxmbGt3bVNTTXBFQVgrVkJLY3VkQmZ0QW1tVTVr?=
 =?utf-8?B?Z20rdXNZdDRxc2FJTVhLSERha1NXd2NUbDdWTGROeW4yYVRRMUw2Si9mNzlX?=
 =?utf-8?B?ZktGM0lobFk0clg2ME9nNzVvaU1SMlhKNXBQSS9YQ0hObTBPeC9XZnhaZ1Y2?=
 =?utf-8?B?eEVUSVh5c2Y1NmROSXdiRmVlVmZhRVhodTg0Sm1saDZzKzFsUVRmSnE5cERU?=
 =?utf-8?B?cUZ5dnVORGFKalhzQ2kzZUt1Z2tMV0w1V1lDNFRTWVZ5Y0ZlTGczM2w0L00w?=
 =?utf-8?B?bDBJbzdzVmo4RGVZdFVHQjJWcTM2Z05LaXIvb0xiOVhDdmxiQ1M1WG16S3pW?=
 =?utf-8?B?cTNWK2R0QWxtVEVSNlppWlZndys3Vk9HMW1YYzRRSGwvTDZXazQ3NEI4eTQv?=
 =?utf-8?B?bDhBQmxDdUNWSjNUYW15TnZVTi85alpuWU9XbThqNG93NnlaZGQ2a1FpNTFH?=
 =?utf-8?B?dnZMS2c0a0NsOXJHeExCMWNwLzRveXFITjFvdUJZNEwwRUZTZ08xK29hN2Ju?=
 =?utf-8?B?aTZWNjVZaEhYSHZqTktGMytDSlZLSmhhb1lKeGcySnRWSTQvdTZxN25aNC9k?=
 =?utf-8?B?NUVJOW5GVWFhU3d6NDUwVXdkUzF6dVNwT3dEOTRkUnEwSWtzUGpvdEdiRytB?=
 =?utf-8?B?bHo1TXU0Q091WjMzNENyRWtQQnQ5TkpiV01OL2J4MDRhUmFiN1NPWVZiNTln?=
 =?utf-8?B?Mm5WOTA2d0FROFYxRW4wNVJSSjd1aSs1MHVYV1N4SXNLd05vQkZOVkZaZE1E?=
 =?utf-8?B?Smh1Y0Irbkt3NWNuZG9UbVYxSUcyWW11RjJpL3l5N2dsT3kvc2tFRW1vMk9J?=
 =?utf-8?B?bFI1WDQ0Y0IrcmFWWjgreFVTSjd1THZ4Q3pNVitUNHl5Sjd6WEJTM0VkeXhr?=
 =?utf-8?B?c3RSZnF6SUlMNWRCdmFpTjBlbVhoSHJGeUJ5bU1DbDd4VW85alJhUXpxR21t?=
 =?utf-8?B?dnJwWU5VZ2E2Zk9UQ0xOc0pjMDhIVEM1UWpGczhaNml6SUN1SGhqTWZUenhv?=
 =?utf-8?B?c056YzZQTm91U2wyaEZVakFuL3BPc0ZaVWpzR21lZEZHWm9tTHpPaUk2TXVC?=
 =?utf-8?B?Q2c5V29PM0VuZUdWL2VFRmhmYzdabjZ6cUtURkFjbHJUb2d3WUVwVE9mN1hs?=
 =?utf-8?B?dVdKc2RnWFV0dGdsOWMvcXpCaCt1bkxmby9kWTNpbUluUWlENUZlbWxOZllB?=
 =?utf-8?B?aFNFdm1abnNORDRxczdIWVVjazFEY2pGTzhXL09NNDlZSzNBdHE2ZWpic29h?=
 =?utf-8?B?V3JJMXY2bWtPTW9JU0ZVelA1QjRqZWk5ZksvN09wMjl2ZXVTVlhkaFVxNzUz?=
 =?utf-8?Q?HV1MyG9wkfZ5vR9mhSrbw7yT0?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 19:11:54.2049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cef015-7f7e-45d6-86e4-08de25440142
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5639

From: Michael Guralnik <michaelgur@nvidia.com>

Add aging mechanism to handles of FRMR pools.
Keep the handles stored in FRMR pools for at least 1 minute for
application to reuse, destroy all handles which were not reused.

Add a new queue to each pool to accomplish that.
Upon aging trigger, destroy all FRMR handles from the new 'inactive'
queue and move all handles from the 'active' pool to the 'inactive' pool.
This ensures all destroyed handles were not reused for at least one aging
time period and were not held longer than 2 aging time periods.
Handles from the inactive queue will be popped only if the active queue is
empty.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/frmr_pools.c | 84 ++++++++++++++++++++++++++++++++----
 drivers/infiniband/core/frmr_pools.h |  7 +++
 2 files changed, 82 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
index 073b2fcfb2cc7d466fedfba14ad04f1e2d7edf65..406664a6e2099b2a7827e12a40820ecab75cb59c 100644
--- a/drivers/infiniband/core/frmr_pools.c
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -7,9 +7,12 @@
 #include <linux/rbtree.h>
 #include <linux/spinlock.h>
 #include <rdma/ib_verbs.h>
+#include <linux/timer.h>
 
 #include "frmr_pools.h"
 
+#define FRMR_POOLS_DEFAULT_AGING_PERIOD_SECS 60
+
 static int push_handle_to_queue_locked(struct frmr_queue *queue, u32 handle)
 {
 	u32 tmp = queue->ci % NUM_HANDLES_PER_PAGE;
@@ -79,19 +82,58 @@ static bool pop_frmr_handles_page(struct ib_frmr_pool *pool,
 	return true;
 }
 
-static void destroy_frmr_pool(struct ib_device *device,
-			      struct ib_frmr_pool *pool)
+static void destroy_all_handles_in_queue(struct ib_device *device,
+					 struct ib_frmr_pool *pool,
+					 struct frmr_queue *queue)
 {
 	struct ib_frmr_pools *pools = device->frmr_pools;
 	struct frmr_handles_page *page;
 	u32 count;
 
-	while (pop_frmr_handles_page(pool, &pool->queue, &page, &count)) {
+	while (pop_frmr_handles_page(pool, queue, &page, &count)) {
 		pools->pool_ops->destroy_frmrs(device, page->handles, count);
 		kfree(page);
 	}
+}
+
+static void pool_aging_work(struct work_struct *work)
+{
+	struct ib_frmr_pool *pool = container_of(
+		to_delayed_work(work), struct ib_frmr_pool, aging_work);
+	struct ib_frmr_pools *pools = pool->device->frmr_pools;
+	bool has_work = false;
+
+	destroy_all_handles_in_queue(pool->device, pool, &pool->inactive_queue);
+
+	/* Move all pages from regular queue to inactive queue */
+	spin_lock(&pool->lock);
+	if (pool->queue.ci > 0) {
+		list_splice_tail_init(&pool->queue.pages_list,
+				      &pool->inactive_queue.pages_list);
+		pool->inactive_queue.num_pages = pool->queue.num_pages;
+		pool->inactive_queue.ci = pool->queue.ci;
+
+		pool->queue.num_pages = 0;
+		pool->queue.ci = 0;
+		has_work = true;
+	}
+	spin_unlock(&pool->lock);
+
+	/* Reschedule if there are handles to age in next aging period */
+	if (has_work)
+		queue_delayed_work(
+			pools->aging_wq, &pool->aging_work,
+			secs_to_jiffies(FRMR_POOLS_DEFAULT_AGING_PERIOD_SECS));
+}
+
+static void destroy_frmr_pool(struct ib_device *device,
+			      struct ib_frmr_pool *pool)
+{
+	cancel_delayed_work_sync(&pool->aging_work);
+	destroy_all_handles_in_queue(device, pool, &pool->queue);
+	destroy_all_handles_in_queue(device, pool, &pool->inactive_queue);
 
-	rb_erase(&pool->node, &pools->rb_root);
+	rb_erase(&pool->node, &device->frmr_pools->rb_root);
 	kfree(pool);
 }
 
@@ -115,6 +157,11 @@ int ib_frmr_pools_init(struct ib_device *device,
 	pools->rb_root = RB_ROOT;
 	rwlock_init(&pools->rb_lock);
 	pools->pool_ops = pool_ops;
+	pools->aging_wq = create_singlethread_workqueue("frmr_aging_wq");
+	if (!pools->aging_wq) {
+		kfree(pools);
+		return -ENOMEM;
+	}
 
 	device->frmr_pools = pools;
 	return 0;
@@ -145,6 +192,7 @@ void ib_frmr_pools_cleanup(struct ib_device *device)
 		node = next;
 	}
 
+	destroy_workqueue(pools->aging_wq);
 	kfree(pools);
 	device->frmr_pools = NULL;
 }
@@ -226,7 +274,10 @@ static struct ib_frmr_pool *create_frmr_pool(struct ib_device *device,
 
 	memcpy(&pool->key, key, sizeof(*key));
 	INIT_LIST_HEAD(&pool->queue.pages_list);
+	INIT_LIST_HEAD(&pool->inactive_queue.pages_list);
 	spin_lock_init(&pool->lock);
+	INIT_DELAYED_WORK(&pool->aging_work, pool_aging_work);
+	pool->device = device;
 
 	write_lock(&pools->rb_lock);
 	while (*new) {
@@ -265,11 +316,17 @@ static int get_frmr_from_pool(struct ib_device *device,
 
 	spin_lock(&pool->lock);
 	if (pool->queue.ci == 0) {
-		spin_unlock(&pool->lock);
-		err = pools->pool_ops->create_frmrs(device, &pool->key, &handle,
-						    1);
-		if (err)
-			return err;
+		if (pool->inactive_queue.ci > 0) {
+			handle = pop_handle_from_queue_locked(
+				&pool->inactive_queue);
+			spin_unlock(&pool->lock);
+		} else {
+			spin_unlock(&pool->lock);
+			err = pools->pool_ops->create_frmrs(device, &pool->key,
+							    &handle, 1);
+			if (err)
+				return err;
+		}
 	} else {
 		handle = pop_handle_from_queue_locked(&pool->queue);
 		spin_unlock(&pool->lock);
@@ -317,12 +374,21 @@ EXPORT_SYMBOL(ib_frmr_pool_pop);
 int ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr)
 {
 	struct ib_frmr_pool *pool = mr->frmr.pool;
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	bool schedule_aging = false;
 	int ret;
 
 	spin_lock(&pool->lock);
+	/* Schedule aging every time an empty pool becomes non-empty */
+	if (pool->queue.ci == 0)
+		schedule_aging = true;
 	ret = push_handle_to_queue_locked(&pool->queue, mr->frmr.handle);
 	spin_unlock(&pool->lock);
 
+	if (ret == 0 && schedule_aging)
+		queue_delayed_work(pools->aging_wq, &pool->aging_work,
+			secs_to_jiffies(FRMR_POOLS_DEFAULT_AGING_PERIOD_SECS));
+
 	return ret;
 }
 EXPORT_SYMBOL(ib_frmr_pool_push);
diff --git a/drivers/infiniband/core/frmr_pools.h b/drivers/infiniband/core/frmr_pools.h
index 5a4d03b3d86f431c3f2091dd5ab27292547c2030..a20323e03e3f446856dda921811e2359232e0b82 100644
--- a/drivers/infiniband/core/frmr_pools.h
+++ b/drivers/infiniband/core/frmr_pools.h
@@ -11,6 +11,7 @@
 #include <linux/spinlock_types.h>
 #include <linux/types.h>
 #include <asm/page.h>
+#include <linux/workqueue.h>
 
 #define NUM_HANDLES_PER_PAGE \
 	((PAGE_SIZE - sizeof(struct list_head)) / sizeof(u32))
@@ -37,12 +38,18 @@ struct ib_frmr_pool {
 	/* Protect access to the queue */
 	spinlock_t lock;
 	struct frmr_queue queue;
+	struct frmr_queue inactive_queue;
+
+	struct delayed_work aging_work;
+	struct ib_device *device;
 };
 
 struct ib_frmr_pools {
 	struct rb_root rb_root;
 	rwlock_t rb_lock;
 	const struct ib_frmr_pool_ops *pool_ops;
+
+	struct workqueue_struct *aging_wq;
 };
 
 #endif /* RDMA_CORE_FRMR_POOLS_H */

-- 
2.47.1


