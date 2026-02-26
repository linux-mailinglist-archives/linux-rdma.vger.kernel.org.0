Return-Path: <linux-rdma+bounces-17220-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGYpN5JSoGnriAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17220-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:02:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8361A7280
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5EE831E2D6E
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 13:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608043AE705;
	Thu, 26 Feb 2026 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QYCJNNO1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010018.outbound.protection.outlook.com [40.93.198.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9282E3ACF07;
	Thu, 26 Feb 2026 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113977; cv=fail; b=KW7mt1fRmGrN1fRZlzXVd84fVc8g0oKUF39zLKJSwGlF1M/KgUxFBbptnGE0y0lLEvFgCQJOeMLG+k9s/BINo0C1PivMWRxNpio7JE5pcc4l9eV0ct/6kI5h65jc/+bxv5Fw2af9AYxHNBcx5Q0nOt7UkeSpfsYa8pSjWpShcHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113977; c=relaxed/simple;
	bh=qo8x1xeUj/FcfzmHvSStlGzyuTfU4Bg5lEPxMAOzrXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tbK/2Ji/vOnfFVBKmViB6XeVtXTBQnVYlOjgn6P8LsAnWyIw1aIWXVg2Kv5R8xeoXvbMTUX6curiC923hikgIukwr4KosrwEk3hdn3IkpEcUCQ6REZBqxQxW6/UHJ4xlKoGseCzFoh9wpOtzVRi/M7l8XS0edfNwkAiYJr261tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QYCJNNO1; arc=fail smtp.client-ip=40.93.198.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRV1eZEqalX4vCKQpAgoQfjoCQd2gwLTmoqMenNC3mF0lVodVoVdAWQCYhsc3VxXx/mE/Lg65v4vzDdZR+/im0DkFIMPIWGvlbm7QObuDUnWoiyNc2/d3WNSIBs0PsogSeliAtIWy/PyOivacfmpHvx5f1/QGRVFDE33ImcK2f7QVYF30ucLolC9bysiDWNGhlAwoS0wVvX5DJ7hkiZz0k37zKgZ1uVFLnSLyXoEaQGQcL8z0erejPYOaFsXrtPXpXRlUsaEx+jnCkuN1+KCozX27MDVu3PA5q3+MWpv+PaNZsW9kMiwT+jO4IKi2FuWKkry2mY7jkljBMsaRzpA4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9crmiXYlDrFzx2ogh0VQImby/vANqg3aTlJInd5b9f4=;
 b=yWcQS/gMmQJvzW85fmZG6qhBRq6WLm1Z2JuVe6CvQ23RChy6lKx++XaNcHf0sfPy8CYdSLbBDcivDEb1UGzDQMZWcvRK74xMkfjGf9J0kV2AhkjCPZ9oEBx5S6uR2Szat77bm/ERRaPXXljKdowV/miFZLA2xF4TZnRBwB/Plx2k/7i/7vWP7cY3TNUWIj4raQv7x1uAXEOFW7acM4pnsDsHjBGzqWLuNPIcWaTJ5uvKuoMPRYD2gm0e4wY7z1eqcGFSLz6nvZSMwWQZgHBRBElbte8qt7/vFRUnitUzzJhr9nSg0jXlV0U4Xz3XlVDps5IfAoQYhv8updyZbee8ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9crmiXYlDrFzx2ogh0VQImby/vANqg3aTlJInd5b9f4=;
 b=QYCJNNO1PtZcXIKFyEmPEr2k7/Dn7GjhjRTXjAuRWSe2K6QSUGEF4aJpbw4McXqciDbeYMkOAbi9PyEIhSqCuVDiMuRRBPmyUsX0K++MoJEKQEw1yHeq2MbLlkwBx5EzlDyaMysogPJjDTU9YiIM/151X+AYWkrDW/39EQa1PgWj0YpEs+xI6Oc/PzAg0nxHD+hlo4jsAhALhLHSNw2N0u9ExrSJCOEZn41O1Y9beNCUkida1HbLS05pKcOUEmfURMjhiiVc6tD0D1X3i+a//3CEXBZDZ11ojUm/wYJBz6qn3ynWuj6vyBqKdXMo6t5wLX2TjI0kRa5BPxomojqZpQ==
Received: from PH8P221CA0060.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::9)
 by CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 13:52:51 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:510:349:cafe::74) by PH8P221CA0060.outlook.office365.com
 (2603:10b6:510:349::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Thu,
 26 Feb 2026 13:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 13:52:50 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 05:52:35 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Feb 2026 05:52:35 -0800
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 26
 Feb 2026 05:52:31 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Thu, 26 Feb 2026 15:52:08 +0200
Subject: [PATCH rdma-next v4 03/11] RDMA/core: Add aging to FRMR pools
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260226-frmr_pools-v4-3-95360b54f15e@nvidia.com>
References: <20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com>
In-Reply-To: <20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772113939; l=7021;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=81TnH9UkvCkiyuEhxk8EIktQYxKGHnAIkxR6u0qZkWs=;
 b=7rQSQ0UvW0s4fPOSB1UM5mTLORS+eN3FcGo20dgjT4BfrRWKxq/4FXW+QMtDojXbHBzrz0S3t
 RfcGlCfikPvDkvWfpfQxKTF0csqzLjaykX+HhkB7jBS3n7Igrz1pgjt
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|CY8PR12MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: e45686d0-7c60-4026-3b86-08de753e5515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	c0C6wq0dFJ8ozqpEDfQ0ug1+vMCuH6qoMbdLgxYg1snLCsNBi+B+Jd2fCmPHkdn3TR5T/yqa3m1rZA8nK+UvkYYwFVtu6zmLKx9eWoW36BWNu8Jw8dSo6WNAGwGuTdurdvyADcyNPjJQjoojOpUbIiBL7pEwIH3gAhxHXF6mSWWlFIRQCDcsuJC/nOhFFIAvUprplk72QUaN8v0AX7Wkmi54fwsXkwdFzRzBJJRvnmhEt2FJNnZvAdpo2MzeMvk0RgOU4ikNl19qMiwiNeCHpOdpf7vQSvZhB3mECnlsHGIiZjOftSEGP0ODo63O18alpZv/pgc6O35Tunr1X/JNhJNFJkeeRvCRjm8M/+2EqFxn7Lf58+q4HH2gcGAGzTOCDCSCP08KI9/tdXCDGe2yPQab6oziXcy3Eh0vHunx7BOncVaA8Nu61uTIl4eTEZlp8aacel8aPK90PrbrAcXlI27YJPJzhfCxtctcmn1A0LNsMFNxgM6buXWrjD7vmhlYp6YWmOgz1scPw6HNi5LDiT7ZshVew1rNDlVjAvpiU1CXVGE/k9yiFV7tNIZXP8XBem5zth4LEGeXD08P5ponE0pvqC4HHZ5ot/QhReWLLa2aTHzsHzFgYtJR7GpGfJ84Jgt9H4cfwblmpt1JXG4BbsRP45N9uLzBfLlWv2butHUtuabXUexLCc9CRTVj1tPD5aj8DHCfGwSvhbrYaIL1X0MHdiTG6R2At5wtyXVBIyLyTgh7pYkFTkbro2oKefr+5DbqqYLpb169eA2F/jOyHiGo+ON9v0xgi6KYF37PmIQS1Jwos+KXkNbgTKnApqzIO3304YKztKh3TN6BfP+p6S3iNMTDvsKQPFOz8j5MjhM=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nuTiD1tIWrFLLvhW9lGYAXkmg6Je8b+D1YWyyZh88qVisKYyl7dweyX+Mf5GiF6zsV64gwsg9BL1GVo0NEddZGqSB0pCR6ic9XdD7whMyjWdKO5F6WjPerdxPJ1iXJbrwGn/capIXWtZw8H5XCCvRt1kAxb08nobIVCPvpHQIz3xI9XTCj6Xs1BG3tehFX58v+5PHgXjPEnSEm1qmRv1PAJrzpnzOGtzfziGI1kxZmdDkLwupf0HyVVqpb8k6mTiqziSDy/Qf/3Txo/cAOpe377mZpmEx+WJ+BTdReXUXldNi1AeZqBTlg6EjgxRI2fQGTYN3BHZyuedx1Piz4AH9PwV2vneVQGJ+lhT2i2QmLvdotYy/yorRzqQ5rl4+1DrEedxP+XNg55rVs1uO1SEYMHOHr8mmDg2VNB+hevLWpoUD+TghcH0pIidLrNjjQCZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:52:50.8040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e45686d0-7c60-4026-3b86-08de753e5515
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7657
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-17220-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2A8361A7280
X-Rspamd-Action: no action

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
 drivers/infiniband/core/frmr_pools.c | 82 ++++++++++++++++++++++++++++++++----
 drivers/infiniband/core/frmr_pools.h |  7 +++
 2 files changed, 81 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
index f2612f5a0a43105abde9e845eb7ec233a52001ed..7bfa001b2c731df2de24ebc61cfc8e419ae0de5d 100644
--- a/drivers/infiniband/core/frmr_pools.c
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -8,9 +8,12 @@
 #include <linux/sort.h>
 #include <linux/spinlock.h>
 #include <rdma/ib_verbs.h>
+#include <linux/timer.h>
 
 #include "frmr_pools.h"
 
+#define FRMR_POOLS_DEFAULT_AGING_PERIOD_SECS 60
+
 static int push_handle_to_queue_locked(struct frmr_queue *queue, u32 handle)
 {
 	u32 tmp = queue->ci % NUM_HANDLES_PER_PAGE;
@@ -80,17 +83,56 @@ static bool pop_frmr_handles_page(struct ib_frmr_pool *pool,
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
@@ -142,6 +189,7 @@ void ib_frmr_pools_cleanup(struct ib_device *device)
 	rbtree_postorder_for_each_entry_safe(pool, next, &pools->rb_root, node)
 		destroy_frmr_pool(device, pool);
 
+	destroy_workqueue(pools->aging_wq);
 	kfree(pools);
 	device->frmr_pools = NULL;
 }
@@ -229,7 +277,10 @@ static struct ib_frmr_pool *create_frmr_pool(struct ib_device *device,
 
 	memcpy(&pool->key, key, sizeof(*key));
 	INIT_LIST_HEAD(&pool->queue.pages_list);
+	INIT_LIST_HEAD(&pool->inactive_queue.pages_list);
 	spin_lock_init(&pool->lock);
+	INIT_DELAYED_WORK(&pool->aging_work, pool_aging_work);
+	pool->device = device;
 
 	write_lock(&pools->rb_lock);
 	existing = rb_find_add(&pool->node, &pools->rb_root, frmr_pool_cmp_add);
@@ -256,11 +307,17 @@ static int get_frmr_from_pool(struct ib_device *device,
 
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
@@ -308,12 +365,21 @@ EXPORT_SYMBOL(ib_frmr_pool_pop);
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
2.49.0


