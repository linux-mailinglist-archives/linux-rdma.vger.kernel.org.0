Return-Path: <linux-rdma+bounces-14501-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C0CC61B65
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 20:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1CC2B35F097
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 19:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B4625785E;
	Sun, 16 Nov 2025 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eHUINyGW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFB0239E9E;
	Sun, 16 Nov 2025 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763320332; cv=fail; b=qN+68lKvWWUiZeg6DO99P3LIB+lJK+P+vBK16nSR4qIBCiLpTeprbiIxEC1DTw61i25dDpMF4whgAucQ0P3C8CgKSi+urQCcgvHJfv+J19pJUrzIP2YkEU6uc4QUDIsMc4/HrYI7nlwqiAaQkl3RUe7x8lM873nV6eZt/ZKeE0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763320332; c=relaxed/simple;
	bh=pGDAyNIbAa6jllD7AGGcL4/yaiHnWrqSkpO/ANj0u5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=T0JlvodEuQxbqYRXMvPuxEheDfti2rMthwJZ4rZ0bAHW4l1X0j010eyOqsYSeSjLVs2mwNHYA/N4sErXclH9pD1/CvlXilHGj3gzeqACPKUARBBmzKAUzVnMFlFq1KD8LerPS/L0EzE3X76JTOYGuOgiNuRSCbvfjh5zV4LraHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eHUINyGW; arc=fail smtp.client-ip=52.101.56.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvzvmQtrs9WlKISUx2ZSbAHNjAJB8WCFSW/Rj9BDW1uq2yQE4CmKTZG7dn7KnlN1uxw/mgbvDi5FODVTX2WpPvBuEu9EN3jJ+kcSh0K+sfYyZ1R/GYqRA81qWN6HuMDlTq/u49UYZ8CrWjLQZ4y5mh204E/FOudOc9V5YzAzxXSXn1sC8omiyWnKWIjdlgLqnAXl0oh4fkQxSFZLLmTQu2UOqGejoSgD7ybyLGNK8anxh3DgISUxgM7bjkrwz/8hjpagRCvJqi8tSt0mj1qvlBy3V/zPJar9A430VVHheJch3l9gBaNEKDwipWKdBTHlH9a0/anJO46crUSJFYkx2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/u/WIOSrZXSMPjuiPzcyBIMv1I89hE7emrZd9npUw0o=;
 b=iBjeWsCuu2SI3nCaOq6JykcHaEfR3aeeWKa6S+jYqWwF0UKzz3HmtNsUdRlF13cwO0WE7voTFWDksvbCD0WMXqWzwg7p1iHAXf//T3cOduHJHwvymGM4qrUu8V1BdyY65O7kC9c20zzre3z4Z9yfIewLbfKSxpWLbQiXQOuiHcNFFX7iYMpwOdo19ufQgFsUNEMCJ+OkvWD6JjQ7yHiQzj9T31UJTCSEzGJPJXBq9rEBQxZ+0IWuDhDmU0Can/HjBDnIpOTjvQTqV4+9jIzvAcAoQdVa/spVCwR895IsySd0zzgfnKvsDlSpkCFlbSPKWpdBwOaImefYxH3zUyG9ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/u/WIOSrZXSMPjuiPzcyBIMv1I89hE7emrZd9npUw0o=;
 b=eHUINyGWxryIffxqj1zsrH0g4YAwCRnDyJlj1P1iUGB32HqDoBAFy+62mPphJQsIbW5fTrsnUObU4zf+UptOhqlUGyf8JKcyivEjdeTtBCnendp0EropzdX1gvIQE8a19iPpkrZiEOja/AKrEUQaTbNfF8TYBEN0vARTtTA08KjRQPP4KeWkwrZUOVB7N4AjDrxhbNAnnDpOYtYcmqYeKxDiqufLfnReByLvRr5P82lRuJd5OUKyLelL+h6XRlOtmLZa7rk4dZKNVOzjrjPIyfhLHZOgQAnONju65Iw5bEON3iJ3yzihj9pRdVAlRH+Beb/Jk684rHjn0XCLyytaZg==
Received: from BY1P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::15)
 by SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.20; Sun, 16 Nov
 2025 19:12:05 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::34) by BY1P220CA0019.outlook.office365.com
 (2603:10b6:a03:5c3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Sun,
 16 Nov 2025 19:12:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Sun, 16 Nov 2025 19:12:05 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 11:11:56 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 16 Nov 2025 11:11:56 -0800
Received: from c-237-169-180-182.mtl.labs.mlnx (10.127.8.13) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Sun, 16 Nov 2025 11:11:51 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Sun, 16 Nov 2025 21:10:25 +0200
Subject: [PATCH rdma-next 4/9] RDMA/core: Add pinned handles to FRMR pools
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251116-frmr_pools-v1-4-5eb3c8f5c9c4@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763320291; l=6552;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=rLfUNbvhwcS6kFeJ5tOrbsxeOHyLaz6/rK/msvmvUSw=;
 b=EMBvmj1e9GeKLp1gLLems2W42w5QHrQCbTW5KZ1mEO7vHtfnGZ3bBhBjjw/C/jgPuUDXsRd4K
 lIvSOiUpj2KAdw4DGQygEJxYbUMXZiGTk3k8iuSZIES4eyffQ88NiIG
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|SN7PR12MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 19400dbd-fcbb-46f0-f206-08de254407ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUVrazM3WVkrOVI1UStiNTluS1ZPSStEbXVManRlVU9LTG1OUWVicGZDVlBO?=
 =?utf-8?B?ZVJDODJZRERxdnNiWWt0MzQySCs1dVRPY29FaXJsS0psVyt4blRoM0owcXFM?=
 =?utf-8?B?SUxJT2x0dVZqUUQvaFVDR3R0VUtWck14Z21ZbzArUkk2bFphTUVXeFFzY0dX?=
 =?utf-8?B?K0ZPRzBZZi8wRDQ2ZFJ3U0lnSkpPQVBBMUVrV1h1eEQyWEFKTXJmUys3Rk8v?=
 =?utf-8?B?em1UNmNFVndQdGQzZXlFc2M4SEowR1BIMk94QVRGWm9DOW9mTm9mWkNkaFNO?=
 =?utf-8?B?OTVpeGo2RCtuVnZXVE9DdS9KZG5OYUwvYmVENHc0S05lZkdEc3RQTlJzQVlQ?=
 =?utf-8?B?WU9HblJ3Q2lsT3VLdHVmODhPRTVnd2hFcUs2blhjaUxlRW5FOHQxMkFLQXdM?=
 =?utf-8?B?OUdNT29MYm5jMGFIUGN4SlE1QmIvZnE4S2lhVzBrZENYenQrSTAzVzBSSGdh?=
 =?utf-8?B?WVlXUTd0dWoxcDR2Sys5a3pGVXBuU3ljRXh5bmZ3RHBCMVdKdHRIdWJrcGFL?=
 =?utf-8?B?RjZmai9iSzdVbVFtWllKcU1RZTMvbnRXR0pPeVhLejNHSU9FdmVONThsME1B?=
 =?utf-8?B?U28wellrMzZwU2dyOS9PV3VQK1hUZkN0MVhPTkQ0L1I2MUFpN0drUWNibHlu?=
 =?utf-8?B?SWlVZUNEcEFabWdWRXpRL2ozVXJXTE4vTjMyc0RoNHg3RjJJdWhNOE5SbEdN?=
 =?utf-8?B?M1cvRkpkT0lPbVNqY3JyYXBOQW5UTDdXMCs5QlgrdW1uTGNuMStLZTdoODRS?=
 =?utf-8?B?TE5rYVIxTGxxK01kTWhoOHJ1OXNOelBJMzhoWFNicWRHZGtmOHNIaWVueFJv?=
 =?utf-8?B?WFFCNHI1R0pzSEEzVXVuSTNCOG9OSlFXRFJJVS9INVVHcFNPOTA5anFpV2Vi?=
 =?utf-8?B?a2FXa3REZ1BkSlFuaFBYVHlvM0xHT3dneFIwVm1sZkREeWtJQXJSQzA4dVp4?=
 =?utf-8?B?dkxvanhIME1TRk4wLzlDaHZZZTFOa3BZNlJCTElvNkZSQ0dOdlU1RXpUcHFV?=
 =?utf-8?B?SlQrNW1zQmxVQ1N3cTJRMUY0NmNPaXRQU1FFOS9VZ01aU2hrb2p2SlVvbnow?=
 =?utf-8?B?dHNVYXVLQ1EzeDlGcXB2WHgxMlJkeWZ5KzBlckVjUzF0WVhCZ3dXdmwxSVJr?=
 =?utf-8?B?NmkrcjVxQzN2enFOOG1NaG1ldlljUlFld2FKM1d2M2VIcnV3UW1YM0JNSmk0?=
 =?utf-8?B?cEFVVzFydkVaUXp0bEs4elliRG8wS1hqZXFYMlVreENqYmtSek5nZzZma0Ey?=
 =?utf-8?B?aFk5dXVmcTRNS2d1YnhkWksvemFRcWMyWUVFYnE2cS9GcDllTURPY29HMWQ3?=
 =?utf-8?B?bDhNdzFqK1djQXpMaGNCMXc4bDdaWW16a0xTL2hpc041SWxNOFByRzdaUWc5?=
 =?utf-8?B?TmJMRnM3enNJdGZHZFNpSzVvVGl2dFEzWUxvSEhqS2g2ZENDdnd4S2REOXZ4?=
 =?utf-8?B?TU4rZXdPbysxSU00b2doQXdPWjMzWDN1N1RmbVgxSk9vK0Y4dGx3QUtET2ZK?=
 =?utf-8?B?Y05PVHJRN3FEdnh3VERETmdqaURUaStJMG9VSkhmT0V0TU8waXRUQmUyaHVm?=
 =?utf-8?B?b2huRXlxYzU5cmhwQWNsckRoemljNGE5QVBKbWc5MVFOei9sK25KbjRjWkxr?=
 =?utf-8?B?OG51WEVlSGVuUHJoTUxjZEZXeXpmb3kwNUQycGFqOWEvZ1Y1Q3lBd3EvZktl?=
 =?utf-8?B?SG9sSytnLzhnNXRxMGRDR3JhYWJvYXJTRjB3TUJ1ZjFWekM0MDA4RkNOV1li?=
 =?utf-8?B?WitzTkF6a1I0d2VmQWVpazNyV25qQlhOeCtkMVl1K0ZsdG9ZUGtBajdhVEM4?=
 =?utf-8?B?eVlFeC9ubmQ4OTJXKzFCb2FzNmIwbzJhMHNZZ1BIUjVBNkhUQkUzOGtTam9Y?=
 =?utf-8?B?Z2pndkxjcTFxZ1c1ejBEbWMrQi85c1BIa0pTTEJsNnF4L3JEUVlhNkJFMXZY?=
 =?utf-8?B?UGFSNDU4anY1VnZ4TmpuM05WdzJLYTlPQno0NDZwZEpMTlpwRXdkOC9PZ1c4?=
 =?utf-8?B?ZXlxQXBWNUdxSjhyT3dmTXFadFhxdnlsZW1QcTIvM1hjSThSTXJmWndlVUZs?=
 =?utf-8?B?c1dDNUhDKzVWZzBzRDVwMmJuakg3UFhrZU5UTFlBY0RpU29GU1h4NnFJWXcy?=
 =?utf-8?Q?qNoE3V4VxYVRyZE/W1XODarPX?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 19:12:05.4022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19400dbd-fcbb-46f0-f206-08de254407ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146

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
 drivers/infiniband/core/frmr_pools.c | 123 +++++++++++++++++++++++++++++++++++
 drivers/infiniband/core/frmr_pools.h |   3 +
 include/rdma/frmr_pools.h            |   2 +
 3 files changed, 128 insertions(+)

diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
index 9af2f6aa6c06cee8a1157aac05aa64f361451083..254113d2442d5d6956587a1c444dc74cd48204fb 100644
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
@@ -307,6 +358,78 @@ static struct ib_frmr_pool *create_frmr_pool(struct ib_device *device,
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
+	mod_delayed_work(pools->aging_wq, &pool->aging_work, 0);
+
+	return ret;
+}
+
 static int get_frmr_from_pool(struct ib_device *device,
 			      struct ib_frmr_pool *pool, struct ib_mr *mr)
 {
diff --git a/drivers/infiniband/core/frmr_pools.h b/drivers/infiniband/core/frmr_pools.h
index 814d8a2106c2978a1a1feca3ba50420025fca994..b144273ee34785623d2254d19f5af40869e00e83 100644
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
index da92ef4d7310c0fe0cebf937a0049f81580ad386..333ce31fc762efb786cd458711617e7ffbd971d0 100644
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
2.47.1


