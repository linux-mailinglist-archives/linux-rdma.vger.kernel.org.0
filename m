Return-Path: <linux-rdma+bounces-15150-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 219D9CD6067
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 13:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 627A530DDA3F
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 12:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63382BE7BB;
	Mon, 22 Dec 2025 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E/Lu7nWQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012069.outbound.protection.outlook.com [40.93.195.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDC52C028B;
	Mon, 22 Dec 2025 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766407292; cv=fail; b=W71r4zAZJUFuu5u7Gcwfrrb+Y3o6WvjQlVZe2Tt/1EdiHbKHeqBYWRyKQ3e+hru+HI3vWc9BhH2jKXyHz7WmE/h6ZAU8JBRnd7Ing4Y0giycU7hC/o3Mle8bePDNItmSQ5IIyJgBGGYOYa3eEKmh1wEvqPuyYAQqS1moeBy86QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766407292; c=relaxed/simple;
	bh=BCju5ncJmhD7oBamod7XQKV6eCitpRZH5OQKgYFsNgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Qd+vLS/puk5GCn0xUMh2jT4hKX+4+XknAQqzf8kim0CkvcFt4szCDFnFab6Zv6pcuMAlvhFafYBb2qvPInAVuG0P/4kuWGLSUQHoeJ95ja8EYUHGY/X2kpwPvhqNcaRKp7jyjVsYW0Smmrf+Yd0WM0dccYMJQgRdxtuusVHhvRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E/Lu7nWQ; arc=fail smtp.client-ip=40.93.195.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePlhfcR71Xzgi1+lB4iW7rhOfgOnkCnrlF9USg368MAmukunrEZ2jqrSq57hl8WUYFGEoD7R2GYrRLPxW5nxRAIoVsdhiBr14hZ+LAA+RSJhRGPE9rUBpnidGjDLzp5VEWNJZd2O5grmQqARNXP9UfJvCEL3HDRaCa0Wcqk8N8EWLhg60ELKUyYxxTU1CEI0CAjuQC82FnYSW2zAagoeBe3+s3DwCQQqI8Srm/ZqTl3BmJH3pj7wYzeYr8DWCkZigWhvNj+PDJ8mVaIPz0iw36+8654fJME3wV6AZRPqVA9UPHI6og2bvZUhC+rEh5i8LPkxbx2ZDPZX14eoT2DTpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7k6LE1Vg7YfVO0DVg8imXQT1V+7RCVG7k00Q+aEVc0=;
 b=bMzP5Vad4edYUz53mNXYkRH8hazBh8OTbvcBTklXGY0l5yt6JkjcrWG67miFXk2JtbhVk9UzHcBax7wg2XOjOFi8nbeKiXPp/4oMMItZAvrVZsxFDswQiakLQMs8zFLehv4r2h0xmOsXiGp4QqFuLPG0TyLoeZlMjGzip3uTZR/daHWkU41MFjXXa6ds/3m2D7nIE3RJHx227jlksPL/zXtxdGPqaU7bZOACYZHgjC7dt4axPRZTtC8PhXFovtbpunHWk6tqHfLS3kyWHymIM2k5y/CcB86SPhebVqdOM8FtJbL9nKuEXw7jcx1chC1jGxDfHYtnp7zLYzxGjkqoyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7k6LE1Vg7YfVO0DVg8imXQT1V+7RCVG7k00Q+aEVc0=;
 b=E/Lu7nWQ3NisvSiP6k1qY9231eJfcWx4XwCCxbO8fsZlIuSE3yVScCvXHZ0K6D6kk0OkhXFkH43d6v59JELWoIu562tzwM/Ix4+rscxcwhOWZp/VO3Zj6/O4DSjhtQHCe3b/kA0JJbEC67bqJBSl1eKcX3+BPhGc5lGTZ1EIFPNaJ0fdgkgRRuFMLoPX/0PX1/P+lELI5qrR3ZbzhCtnCMBTA4zz4XVOGn1uG88Bl2rQg8JN+USK8eHC5b0K7uZHXLKnplTKjvss2skQDnPZWSsDkACVLq7vvmi9lPLLURvDHVVLALeVmElX63pqoy0C8mt0H/EDw/fc92Q/OfSPOA==
Received: from BY5PR04CA0024.namprd04.prod.outlook.com (2603:10b6:a03:1d0::34)
 by BL3PR12MB6452.namprd12.prod.outlook.com (2603:10b6:208:3bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 12:41:24 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::23) by BY5PR04CA0024.outlook.office365.com
 (2603:10b6:a03:1d0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Mon,
 22 Dec 2025 12:41:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 22 Dec 2025 12:41:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 04:41:13 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 04:41:13 -0800
Received: from c-237-150-60-063.mtl.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Dec 2025 04:41:08 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 22 Dec 2025 14:40:40 +0200
Subject: [PATCH rdma-next v2 05/11] RDMA/core: Add pinned handles to FRMR
 pools
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251222-frmr_pools-v2-5-f06a99caa538@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766407244; l=6544;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=Pcz1Rtok9eIqgQEJ1c3b6DWOdE/Hzy34UQfFknfJSnU=;
 b=oTc/6BETqGSUvk+1sca7Ucc5Vcx8cwPNyzkL3Yn4fH+ioVzWbvT7fEjVVWsTBq/IESOp1laBs
 4sQsZtOHmJOAtBo7ncLspGWbbUBvImrquaxtBISnPqL1KrvLV+q6Skk
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|BL3PR12MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab985d7-7062-4c67-f6ca-08de41576aac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWpTM2dZd1ZIdHV0YnU3bUpJd1hPclR2eW1uOVFOM1JCVFVBNHRETU9wVmQ3?=
 =?utf-8?B?K2RCcUovcjlTUDhWcjVvWFJZSFQxdWI2dlMzVHlaS1VJTTFyMUh4OTFrWjQ4?=
 =?utf-8?B?NDViZ2RaNTIyd1dFWlk5S05xUWdFaWlpdWYvK0ZTNE9MQ0dobVRPZVRVRVkx?=
 =?utf-8?B?WHdQa09HZVVRc05tRmlqcElBYUY4VkgvdDBGcnZua2tKSkhQVUpYMkR5dVdi?=
 =?utf-8?B?QVFNejlDRjlIbE45U0ZRMldSbjRuaTNDWDEyOWVnTlY1OVl0VG5GQ2NFREpM?=
 =?utf-8?B?TG44S1cvZkxuQXN4TTgvRnVEWlBmMldoelFJYjlDajdzM3FwQnY0ZHJoU3Zt?=
 =?utf-8?B?cVVjWW55ajdPUzBSak4xN05ZeUc3QzdYMGNjWGNVaGwralBwR3dXRUIzdzdP?=
 =?utf-8?B?K2ovay92N205bk5KTksvRFpNYk1OYVpWRmswNjFHNUVwMFVLYnZqNFI2MURm?=
 =?utf-8?B?ZnRjZFBHSDhlbngzNUo0bUJ2bi9Cb3B0TnYwZU9Cdy9sdW1xUmdmdUlWYm1z?=
 =?utf-8?B?NEI5djF0bDZYWVM3MjhHbElqcm45dHRnc3V5c09wNzUycmFVbHRremN1OWdy?=
 =?utf-8?B?SE0wQ2tjUm5yUXp1SDB5N1hpN3c4eWJlb2gzS0xNalA5WjlJMG9UR2t6L05L?=
 =?utf-8?B?aWpzcWlmN1NFV1RBSTBua2VyVVM0Qk5FYU9iUnB1aFdDT2srZ2hHd09jQjJE?=
 =?utf-8?B?aTFwYmlybjJmVTB5WmZBV0k4Qm5mVW5DL2FLajFZenhXdFBtS0NMalpZRFFz?=
 =?utf-8?B?SVJHdkNDbVNJSWp6NElXQXUycExrL1R3Sm1EK1R0MXZCa3AyeDZCSlVVcGVy?=
 =?utf-8?B?aTVISVBrcXQrTWxPb0t2d3BzTGpYYXAxbXNEMkttSWR6Sk5jeW0rSDVVc0xz?=
 =?utf-8?B?VlNCRHF2eldEdEdJNTltRlBtVXBVSVh0ci9UKzQrVFpETXN6d0FGZWhPVWJ0?=
 =?utf-8?B?aTllc0RaeVMyRDFGUmtla1BXcm9BNWhJZUFzKy9lTHZBNldDa2l5YTJQMVF3?=
 =?utf-8?B?bFZOUTlxU2xva1c4V3dhRlRiWjQxd2ZmazhTVmhEWWV2dHhpUE9obngvRE1O?=
 =?utf-8?B?Ui83clJ2azJMbjdsL0N5b1NCTnNUTXdGZ1JSMmRLU3lxSHM4MjNrTi9oRzRl?=
 =?utf-8?B?aG9yNHUrNDdJS0NiVVlzUjYwTzN3dXZ5djI3Wno4SW4rQ2cvOHE2NDZTeWJr?=
 =?utf-8?B?VkJBZnByZGlJSmRHQzBkazR6NldzOVJXV0c2Zi9UeUtsN0VrMnNVVmQ1QXpS?=
 =?utf-8?B?MFhMOVJaT0QxeTRBTDMvaEJjMW5WdmtRQTZyUUhzZG5mMWJpYjNOU25PL0VV?=
 =?utf-8?B?bjlJd2o2aWRWc3d6ZkNoeXBvNHlZT0JEWVhvZkxFUXZsaW4zYjFmeGN0UHIx?=
 =?utf-8?B?RTNwTk9qTVF0blhrU21NZW9nd1NzV3hCSmRYaFRKWC93KzIzc2JGY2QrcXl3?=
 =?utf-8?B?bDRGZGdnblFMVkNScTFhQ0JwRHJ0Nm1FajRsczNDWFdlS2NVTFpPVTNnYlMv?=
 =?utf-8?B?d2NZSWtjMU5wOTh3bGdEMWJqankvTzlVSC84NzJtSHhyRjhDcGw4c3UwQmc0?=
 =?utf-8?B?SFRtckhaQUI0cjhMMEd6ZHZUU2FxdHVzdTZmQzdwWnBFSHRURDVWVTN1KzlU?=
 =?utf-8?B?MEdMa3BBanNCRy9PWkd6V2VaZjRlU1hlNVhFNk1nai9NWGlkRVlHMkxOS1ky?=
 =?utf-8?B?NC9NSWFSWjFNOXVDbHdOQWJpd3l1TmY3Q3duUXNudUhHVi8yUkJEK0taclpO?=
 =?utf-8?B?Z0pHVkVoQnkrUGtwRUU1NkVEQXg3dHdzTGRUVmRhOGJTaUc0L1lIbUZsRHB3?=
 =?utf-8?B?TXNnQkR2Y1VOQ2orN2VHQ3M3cjM4Qm40SHd2RjByZVVOZ2dPdFZBZEFNZHd1?=
 =?utf-8?B?M0tSeGRUd3I0bTNmZnVnYzFCanB6NDVITTVPTVZnQTErdjV4RVA1d2NFWWtK?=
 =?utf-8?B?RS9tRG80NVFtVUFpUlFLQ1FyazEwYW56eFptbEo5VEhuaFhrNGVoQ3ZGQm5C?=
 =?utf-8?B?S0w4bDhxc3o3cVQxdFliWkpaTFdIUW1LOHl1TThFR09ORDRFRnoxTmlwZ0VU?=
 =?utf-8?B?bzhpQjlZSmtnOUdhb1pUM21lT2NZSlpxdUdEc3ZZM3B1YXlYeUc1NkNMbXZ0?=
 =?utf-8?Q?ajTfMecWG9oRtVyiy1fncj/90?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 12:41:24.0583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab985d7-7062-4c67-f6ca-08de41576aac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6452

From: Michael Guralnik <michaelgur@nvidia.com>

Add a configuration of pinned handles on a specific FRMR pool.
The configured amount of pinned handles will not be aged and will stay
available for users to claim.

Upon setting the amount of pinned handles to an FRMR pool, we will make
sure we have at least the pinned amount of handles associated with the
pool and create more, if necessary.
The count for pinned handles take into account handles that are used by
user MRs and handles in the queue.

Introduce a new FRMR operation of build_key that allows drivers to
manipulate FRMR keys supplied by the user, allowing failing for
unsupported properties and masking of properties that are modifiable.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/frmr_pools.c | 128 +++++++++++++++++++++++++++++++++++
 drivers/infiniband/core/frmr_pools.h |   3 +
 include/rdma/frmr_pools.h            |   2 +
 3 files changed, 133 insertions(+)

diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
index 9af2f6aa6c06..febe23920f56 100644
--- a/drivers/infiniband/core/frmr_pools.c
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -96,6 +96,51 @@ static void destroy_all_handles_in_queue(struct ib_device *device,
 	}
 }
 
+static bool age_pinned_pool(struct ib_device *device, struct ib_frmr_pool *pool)
+{
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	u32 total, to_destroy, destroyed = 0;
+	bool has_work = false;
+	u32 *handles;
+	u32 handle;
+
+	spin_lock(&pool->lock);
+	total = pool->queue.ci + pool->inactive_queue.ci + pool->in_use;
+	if (total <= pool->pinned_handles) {
+		spin_unlock(&pool->lock);
+		return false;
+	}
+
+	to_destroy = total - pool->pinned_handles;
+
+	handles = kcalloc(to_destroy, sizeof(*handles), GFP_ATOMIC);
+	if (!handles) {
+		spin_unlock(&pool->lock);
+		return true;
+	}
+
+	/* Destroy all excess handles in the inactive queue */
+	while (pool->inactive_queue.ci && destroyed < to_destroy) {
+		handles[destroyed++] = pop_handle_from_queue_locked(
+			&pool->inactive_queue);
+	}
+
+	/* Move all handles from regular queue to inactive queue */
+	while (pool->queue.ci) {
+		handle = pop_handle_from_queue_locked(&pool->queue);
+		push_handle_to_queue_locked(&pool->inactive_queue,
+					    handle);
+		has_work = true;
+	}
+
+	spin_unlock(&pool->lock);
+
+	if (destroyed)
+		pools->pool_ops->destroy_frmrs(device, handles, destroyed);
+	kfree(handles);
+	return has_work;
+}
+
 static void pool_aging_work(struct work_struct *work)
 {
 	struct ib_frmr_pool *pool = container_of(
@@ -103,6 +148,11 @@ static void pool_aging_work(struct work_struct *work)
 	struct ib_frmr_pools *pools = pool->device->frmr_pools;
 	bool has_work = false;
 
+	if (pool->pinned_handles) {
+		has_work = age_pinned_pool(pool->device, pool);
+		goto out;
+	}
+
 	destroy_all_handles_in_queue(pool->device, pool, &pool->inactive_queue);
 
 	/* Move all pages from regular queue to inactive queue */
@@ -119,6 +169,7 @@ static void pool_aging_work(struct work_struct *work)
 	}
 	spin_unlock(&pool->lock);
 
+out:
 	/* Reschedule if there are handles to age in next aging period */
 	if (has_work)
 		queue_delayed_work(
@@ -307,6 +358,83 @@ static struct ib_frmr_pool *create_frmr_pool(struct ib_device *device,
 	return pool;
 }
 
+int ib_frmr_pools_set_pinned(struct ib_device *device, struct ib_frmr_key *key,
+			     u32 pinned_handles)
+{
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	struct ib_frmr_key driver_key = {};
+	struct ib_frmr_pool *pool;
+	u32 needed_handles;
+	u32 current_total;
+	int i, ret = 0;
+	u32 *handles;
+
+	if (!pools)
+		return -EINVAL;
+
+	ret = ib_check_mr_access(device, key->access_flags);
+	if (ret)
+		return ret;
+
+	if (pools->pool_ops->build_key) {
+		ret = pools->pool_ops->build_key(device, key, &driver_key);
+		if (ret)
+			return ret;
+	} else {
+		memcpy(&driver_key, key, sizeof(*key));
+	}
+
+	pool = ib_frmr_pool_find(pools, &driver_key);
+	if (!pool) {
+		pool = create_frmr_pool(device, &driver_key);
+		if (IS_ERR(pool))
+			return PTR_ERR(pool);
+	}
+
+	spin_lock(&pool->lock);
+	current_total = pool->in_use + pool->queue.ci + pool->inactive_queue.ci;
+
+	if (current_total < pinned_handles)
+		needed_handles = pinned_handles - current_total;
+	else
+		needed_handles = 0;
+
+	pool->pinned_handles = pinned_handles;
+	spin_unlock(&pool->lock);
+
+	if (!needed_handles)
+		goto schedule_aging;
+
+	handles = kcalloc(needed_handles, sizeof(*handles), GFP_KERNEL);
+	if (!handles)
+		return -ENOMEM;
+
+	ret = pools->pool_ops->create_frmrs(device, key, handles,
+					    needed_handles);
+	if (ret) {
+		kfree(handles);
+		return ret;
+	}
+
+	spin_lock(&pool->lock);
+	for (i = 0; i < needed_handles; i++) {
+		ret = push_handle_to_queue_locked(&pool->queue,
+						  handles[i]);
+		if (ret)
+			goto end;
+	}
+
+end:
+	spin_unlock(&pool->lock);
+	kfree(handles);
+
+schedule_aging:
+	/* Ensure aging is scheduled to adjust to new pinned handles count */
+	mod_delayed_work(pools->aging_wq, &pool->aging_work, 0);
+
+	return ret;
+}
+
 static int get_frmr_from_pool(struct ib_device *device,
 			      struct ib_frmr_pool *pool, struct ib_mr *mr)
 {
diff --git a/drivers/infiniband/core/frmr_pools.h b/drivers/infiniband/core/frmr_pools.h
index 814d8a2106c2..b144273ee347 100644
--- a/drivers/infiniband/core/frmr_pools.h
+++ b/drivers/infiniband/core/frmr_pools.h
@@ -45,6 +45,7 @@ struct ib_frmr_pool {
 
 	u32 max_in_use;
 	u32 in_use;
+	u32 pinned_handles;
 };
 
 struct ib_frmr_pools {
@@ -55,4 +56,6 @@ struct ib_frmr_pools {
 	struct workqueue_struct *aging_wq;
 };
 
+int ib_frmr_pools_set_pinned(struct ib_device *device, struct ib_frmr_key *key,
+			     u32 pinned_handles);
 #endif /* RDMA_CORE_FRMR_POOLS_H */
diff --git a/include/rdma/frmr_pools.h b/include/rdma/frmr_pools.h
index da92ef4d7310..333ce31fc762 100644
--- a/include/rdma/frmr_pools.h
+++ b/include/rdma/frmr_pools.h
@@ -26,6 +26,8 @@ struct ib_frmr_pool_ops {
 			    u32 *handles, u32 count);
 	void (*destroy_frmrs)(struct ib_device *device, u32 *handles,
 			      u32 count);
+	int (*build_key)(struct ib_device *device, const struct ib_frmr_key *in,
+			 struct ib_frmr_key *out);
 };
 
 int ib_frmr_pools_init(struct ib_device *device,

-- 
2.49.0


