Return-Path: <linux-rdma+bounces-15148-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D11CD6058
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 13:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4500308D755
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 12:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2B42BE05A;
	Mon, 22 Dec 2025 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oxB6/glO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E8F2BE620;
	Mon, 22 Dec 2025 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766407285; cv=fail; b=UuhOIQH3rUp6aA3E4jTUKx9HY0NNdZP1cQ5cOx0tGFngNgWDL4yBV2oFAHoxdJwe+8bMQZV6DwNiiTtx0TPxYMiwJce6G76lzSwBT34MbZY7TxU1XaYKcKbMtIjWqYOUaBG3srGk00M00WTEiSQIF5PR+qBoGYZpWCxnLt0MrY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766407285; c=relaxed/simple;
	bh=pmC5acd5+5V0g4E/p7qYYwNtF3hwdk48yArVT/v4yhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lI6VNXadbD0TMu80lS/TkftA7vPlseQqnEzDTQj5fQcVpGIUdsKOlbKopAUudlTqMOPye/3rQuaQcE2tFTfpE4RemHW4Ho4p5IQIRh2sGxhX/iJ99p/4ohjG24edAvQwDs0WpSqM0nAC2UvCtpKO3OFvGjG3TqCfRYcRQQ9eOpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oxB6/glO; arc=fail smtp.client-ip=52.101.85.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xj6uMwNApjBJDcVYWjTtMA/l5idX4KcfHUKGAzqu6/wZeo4L6dlvfNXia1Gz23e/3h3OS6gz2pJPw+UcgDAc8SDR5PL8+YrrH9V8T8wKXYHKD/SFi2TUWD3RSy72g3dUj+pLKLpgEb96gjidLi69xAuLbmzUR1Fp+f85FqTAjmjHuLzfGH1kqOxzoO2MUakrkEJtVDK9+eHMKE65PUKgKgIqGKvMmqrGAIwxYpnbujciSMHufu6e11pEntkEDibH4kPW+IIvuQ0MkdkBLk8q3vd3yFaDHNTRRj+FgErKY/LDLpfym7oFplK1vGF6dxebhhtK/zFEPDigJ37/NTh1Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMoUAcRfLaicdAzm8im0WsqlRRUpJeTU49uKvWWsNTA=;
 b=scPP4hh1qiBEzpVO7clI6WceP+RbxaN4KdUJ6QF6EPjt/uL94cFldEhzh3VTLFPpHw1VzhX274UnxAG5sF1Uv7SH1VINPOw1k0kFtEKGUqWGRjFsfhBenPXJuCxADqDR/nqvwub88sgEvNaMy27WB40Mm3oRiWsuLtea/9Ld/Sx19O04Z0hr6gUrn40A50TKI6FSg3lePWn+koJE/ayFpaAZxKho7zbYQh6UQUTZ9QZSRGHlKZoqxtbiswLvwRyEV9uBrF3MqM/c4QhWFxB/joH5KcbUcf4dCaqd6+uUBjxSKm54RrD19nEMX3FNqmZsHtj/lRNF5V/7XWP5uy7JPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMoUAcRfLaicdAzm8im0WsqlRRUpJeTU49uKvWWsNTA=;
 b=oxB6/glOZBzwvxdb2q1d5EjKtteXzVwve4t1ykM5DmTccd2qmAsKHIS/zzklIbClAlW0uCHwqGGOgCQpzLCyBNByNPqCpurOTCcYDcYh182y5TnVnlV4zUTX6wa+3dvCh8DkRUlSkyqZ2QfK6jrs/LFagBk7YGITOlOLbGpybFV+RDFvNgNrnMG/PTPiUN+xr669tNzuyc8qgdIO4+KNh/NijR4wkYU/R4njb+oTseiweSRQx1aYDxOBItufGN3VU7T0ezDHxEL5/4ThY1bZgDhA7HhitbwBPxzgbyV2fhvbVoyhihz7EabDmgBZGqYnhz+31vEYqi1LMTJBBuL9pw==
Received: from CH0P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::6)
 by MW4PR12MB7468.namprd12.prod.outlook.com (2603:10b6:303:212::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 12:41:15 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::ed) by CH0P223CA0030.outlook.office365.com
 (2603:10b6:610:116::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Mon,
 22 Dec 2025 12:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 22 Dec 2025 12:41:15 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 04:41:04 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 04:41:03 -0800
Received: from c-237-150-60-063.mtl.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Dec 2025 04:40:59 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 22 Dec 2025 14:40:38 +0200
Subject: [PATCH rdma-next v2 03/11] RDMA/core: Add aging to FRMR pools
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251222-frmr_pools-v2-3-f06a99caa538@nvidia.com>
References: <20251222-frmr_pools-v2-0-f06a99caa538@nvidia.com>
In-Reply-To: <20251222-frmr_pools-v2-0-f06a99caa538@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766407244; l=6865;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=y8XfKwStsnr/24NJoMk7b6PJUYpa4BeCIXbjkBuWbMg=;
 b=WmTVQ1G/PUfRTPCeoXkG4QCxDVS/8mQmUTYBXnIqsUvHFrXaOgpW4VP9Rjyu66sY8M3m/MnLM
 40itYTgHNZKBxFKMY4o9CApcc9Rl4cV3TkLwyFIyvJBlEHBpwNNX85P
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|MW4PR12MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: db24d6f1-e347-437a-c09d-08de4157659c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjFWNDhta214UXZEemlsWVB0Q3Y4Y3ZuRjVGclZFcjhBbThYMlJuM1kzYW1E?=
 =?utf-8?B?Y1pFRXJtczlGLzRMTWlGNGhKZ0NXS3VMYURDd253aVV6WThlY1lPMXIvcURI?=
 =?utf-8?B?cEJXYXhFL2hic0crNEZTMkwvUHlWV3dOS25jNnV1bXZOd1N2YlpiYkZ2RXpk?=
 =?utf-8?B?Tkt5RDE5WHE5QXZpaGJ0aUg5dXVtWGtoSmtvcU01Y1p2cmZSS3pxdTJoSWN4?=
 =?utf-8?B?aTVVeHRFQnozcXdxMXVBQzJSM2NJcXNHOTdnU0tFYk04bG5TYUErQ1NyYTM5?=
 =?utf-8?B?OGZpWjlDUDJsdzF1UnVtLzUzeHYxVE9LTGZtcENLOG5BNmtxZXRDTzM0b0ZD?=
 =?utf-8?B?MnA0UVhwTEpveEQvalJBQkxWcVZMZVR5WXFHMk5FdnFwdzZaU1lqYWlyR3Ir?=
 =?utf-8?B?a0RrNUJvcE1ZbHhsZzdCUFJlRDdlblpFQ0lESUVHSDVDcjRCdDIrc01oRHBj?=
 =?utf-8?B?Tis0VVFZdlRMVVI0L2ZpemhsMUQ0dlJ1NmJrY3RHOXVqalZKekthbkZsN0dr?=
 =?utf-8?B?UklZS3dvU0FyWlZ1ZmhWVTJkbTBlSWlLa29FcWc5QTdKK3czcng3WWNVRjFP?=
 =?utf-8?B?NENBK3JLenlJNWQweno1Sng0VkRrSzBnbklSN0x3THhRYWhqdlR1SXIyT2Nx?=
 =?utf-8?B?NTZOWGpNUVp0SXIxQWdQbDNLQlJOak5ieTZ4QUVKaUJ4RGlRNDdlckRxcDFS?=
 =?utf-8?B?T1VVMlZMZ2NIcGVRVHpKbXROUjBobmNJRWE0ZmJlc290M0N4dG9yWThtOW1T?=
 =?utf-8?B?ekxpUXRVRTVzYTMzK1FrVk10RnNDMVhGd3c5YUFySFhuUzhQWkNMd0d3NUw5?=
 =?utf-8?B?Zm9IUFJMNXlTZWlaT1IwdUFDV1EralQya3kwSDdld3luNFdZdnpqTHNXSEdL?=
 =?utf-8?B?TTkwazVMYUZnTkdING93dVAwcTZPbjRkT0FzM0xIUERlVWdmMVpCODhLdFdK?=
 =?utf-8?B?cXBJTm5oWDRTR0xKNDJ3T1kzc1BiWVFDdUtmYU1Qc204YUVUOGg4SWsyNTVK?=
 =?utf-8?B?SGJhOWhTdnRuSXBJZE1DUDlBMEpMdUhCZUJrekhCMjNYYW9xSUpDQVNyejha?=
 =?utf-8?B?MFQ3RGhrUU4wSTZCakhuLzFEdExjVW5NQSt6dmh5dElaSmljYUwzdFd2MElV?=
 =?utf-8?B?VnBDRnU5WFB2UjNjeldBSWdYSkhuRWFmMWcyRkUxTndGU25rSXJNMC9WbUsw?=
 =?utf-8?B?bVJUc1ZEQUxxaHRrOEkwSVFkZWtack5zZ1A2bXgzUDRwMFlGYk84UzBuNUJp?=
 =?utf-8?B?ZzZOODh5MXljWWtuWjExNjZnU1IxUUpNdm5JaHJZdk9vUVM4ek55UmNERmMz?=
 =?utf-8?B?ekNQMW9iK3EzVkc3dFVzdXNMRE1Vb0gwWk1DQUJia0hDYVFxWnI5VFV1ODhK?=
 =?utf-8?B?Z3NzTW42UzBlMXUzM1FZc1ZWV2hGV2wveldCcmRxQjZGemtqZWROWWt4YVY1?=
 =?utf-8?B?NUpLSXcrZUtWMWFJVXdsWXNHUlYyRHBQQjZNM040NkZ2NXdNalcyMkxiS242?=
 =?utf-8?B?U2MzdkVCUTVQZTNURE9Obmx5VC9ob3ZaOS9lNFNFcURkQ0ZqMkVtZU45RFZU?=
 =?utf-8?B?TXVmaTU1OCt3YTZ4V2EvSTNiNmhsM21DMlRhNU9VcHpCSE5tbVV4MGlvMHBw?=
 =?utf-8?B?eHc3ckdBcHRsbVgvekNQMVUzTkhreE5Eb2M4SEVxckcwRk9wU2dzQjlxMThE?=
 =?utf-8?B?NW1FOFZyNFRGVlVkbTA3Z2xaWVNiM0ZUYmZKT0lnemJYYkRJM29sVnk5dEtN?=
 =?utf-8?B?cFZWWWVPTkFTSi9KUVFzT3lwSitUUCs4cm13NXFIdVhXZmp3em9YWFRUbHhs?=
 =?utf-8?B?SXNZbkZWR2E1Ti96R1JMMEFlWVMzQTVFQnBTeXZOdURvOEhJVHR3a2xVOU96?=
 =?utf-8?B?K2hSdEx1ZFR4SHhBWDJTeUZlaE5hOFBGYTZPZk9lSEtJaVdSd0kzZUg4ajBj?=
 =?utf-8?B?d3k0blVURG1YYWdMeHhqZXp3TURGOTNIZm11Qi93OG5EOXlMQ0FjUENLZW4y?=
 =?utf-8?B?Z2EzUVlaM2ZhZ1VjbStiZlVHbk1tbEZaWk9tZU9EaGpVaXh2WHVyQm5jY29N?=
 =?utf-8?B?QWhMK1Z4RWcxeE0zdjQ1YWQ5NjZkY3JFd0YzRU96T3liR0lSTlRFc1U3bDVs?=
 =?utf-8?Q?VbKiU3cV1pG48YlmYtePXHFsk?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 12:41:15.4422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db24d6f1-e347-437a-c09d-08de4157659c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7468

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
index 073b2fcfb2cc..406664a6e209 100644
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
index 5a4d03b3d86f..a20323e03e3f 100644
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
2.49.0


