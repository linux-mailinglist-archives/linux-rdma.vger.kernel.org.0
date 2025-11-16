Return-Path: <linux-rdma+bounces-14505-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5234FC61B8C
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 20:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4893B8C2A
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 19:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E53C27056F;
	Sun, 16 Nov 2025 19:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jj94Ecrj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012024.outbound.protection.outlook.com [52.101.43.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912C4271457;
	Sun, 16 Nov 2025 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763320353; cv=fail; b=Wqlwy6eibTCng81VLwO34zKkgGnAye6OvYlZ0yh+b51bWdmLPUQgxgqFarRfH+dWCKCLuWvHAGem6fsvN5ggB4ztuMBB3voEtocj1PLvuYz0+M8UOTJKOYUsST9cXQOSAlCl+wJFRyvermgAFSXQCH05PpgbJ3mwr3NidFeP04s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763320353; c=relaxed/simple;
	bh=2H+aWiDOtSeiyxEGkbDWVBaHwUa52u3WRBwjdq6laJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=s5kPoyH8I08PUrizsnVENcJtSLBOuy1euIMKZWlMU+za0lSrt7fnWL75kglvDYDOm3X6aSFDL+YebneVLUbb+aXU7tVk6uIDCzDOHHzD07O0YnsoyhK+FUN+9Y/oDTV0Sp0z50lD7DzHYsPnkjbpZxCmroMzKrIVV96BLxsPDN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jj94Ecrj; arc=fail smtp.client-ip=52.101.43.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhrgLSPd4vGRhYCqtATeOBi5n34Y+djWIWwpM6zrdR6KxqvgXfBXwVpPD3Oc+NdL3fhSI5AYoV6oeqk3F1WkaZAQ04zyrLAnS9/WfmTuAd483UNw5W1edcugBTs4W1/GD2iGlxFe/EFc2nfhrkqHTuojoMd06SaBaJSO2p2NefuBbLE56duGd/BVBEmEmA5OENXhU7V3SBX1Do0IYMH7FVNddc5ej/JaugiIvnGxRklmNhf9dE0VX8KsWn5rz7F6qXpqbgzB+4/Fv/1+34hq5s+fpAyIGEc1psS+/yB9aZ3L26/EtwmVDVfbLVGWOGEznZmmxxaTy0bPUa1fNmM9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FG8UHWe6mJicZFDijYd9mlpuuEJI5r42MFlV1dfmK04=;
 b=JmifirXe7g5J+qpyjkoXeg/rbddvtMGaOsL5vmdmE8NvvKl+3YMmtmtKsOJHsVfdiMmeAWQ7ityoaPx30MtnWhyyPCiTBB8jvhb9e/6WW5lIjABswagF6U6G6cmSpn2UIbuLgsKgWXIgWaOmAPQZJd3/efSC9RXj+BHpkwpDAdufxleVYgVR/RR3BLEXFC6jOGtL1Qs7awvUjrM3ViFs5Lq4ZcFtwAVQoV3j4QFD5qSXdGIx7r2z4pMvrN8E7sd+Uj1vTvy4SVX3o906C+4OYfwbHBqBZcZfHqpolrVCSavG1iIctnj5zm4FOmgXU1gaAXndW0YMLGhl1ShSvSFaMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FG8UHWe6mJicZFDijYd9mlpuuEJI5r42MFlV1dfmK04=;
 b=jj94Ecrjnifhv9UhcgMkbPJQRywlUO8kfYIz4ervV7s+AtDdnc1K8Fq3Yb9f7iBwiJsXe3X9ymK96yCyc4oMSWzCJ8ZvKThYm0kdUg/72DZfDpBRo1hT1hGxx4e2C6Wkt3t2OR/wInVo5crXxvyfOlvlCKFVKzU6nNrhU+zfko50Rk+wpRG/az7xX+bcqeqmDg9ZTKsfKSsYSIi0CJ8KVMFW4yXvXq/4GRDOMloyMqbHWFl8pcK55tQKk3Lk1CnVf6kApDUqHpoBE5mdBYGGoqyER/XusXGQg+vUpno/GweR9RZSmY7KMmLErS0xDx6MPGzzyzqI1SwiAaLLpI9gQg==
Received: from BN9PR03CA0316.namprd03.prod.outlook.com (2603:10b6:408:112::21)
 by DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Sun, 16 Nov
 2025 19:12:27 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:112:cafe::ac) by BN9PR03CA0316.outlook.office365.com
 (2603:10b6:408:112::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Sun,
 16 Nov 2025 19:12:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.1 via Frontend Transport; Sun, 16 Nov 2025 19:12:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 11:12:16 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 16 Nov 2025 11:12:16 -0800
Received: from c-237-169-180-182.mtl.labs.mlnx (10.127.8.13) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Sun, 16 Nov 2025 11:12:11 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Sun, 16 Nov 2025 21:10:29 +0200
Subject: [PATCH rdma-next 8/9] RDMA/core: Add netlink command to modify
 FRMR aging
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251116-frmr_pools-v1-8-5eb3c8f5c9c4@nvidia.com>
References: <20251116-frmr_pools-v1-0-5eb3c8f5c9c4@nvidia.com>
In-Reply-To: <20251116-frmr_pools-v1-0-5eb3c8f5c9c4@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763320291; l=6601;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=bQokp/MlllEPmlUzZoAj+8KcHyrhuf1+gKxd9AJgtt8=;
 b=M+hB2tXE3U7IKAJr0mIAW2hNj+bb7O4+4tiTNIzDALJ7iUiTLCs1febz7fFZkeJ5zTlfKFO3P
 7TztROe/cgmBvziU2VM1r8bjJOp1q34KfnY+D3j9TCo1jxUMgVwqC+U
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|DM6PR12MB4092:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a63e770-6db0-4eea-603b-08de254414bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGRtQ2FoMG9oM2Yyc2lMd2xocWpCSUhpOWx1cU05TGpvS2hMeXQ4UklxMitr?=
 =?utf-8?B?SnBiVWN3bUJSN0Q1aWhDQWZBRVRKVnpPVzN0cGVFdVJEWUVPdjRFODZwR1ov?=
 =?utf-8?B?ZjczbXVuclk5SlNTb3V6UzdKZ2VrbmdzYzNBNzgvelB4ZnR6ZlkzbEhEVC9h?=
 =?utf-8?B?ZVFYdzRzZzZiNGRWUUhSYURMOG4yU3U4eWxWczAwcnlBeTZNQU05SzVOSW96?=
 =?utf-8?B?WXkwek4rdm5KUnh2K2tWQzIvWmYzYlJPS1ZLNTgzU0dEck9mb2g2b1NyNXBT?=
 =?utf-8?B?ZjhHeS9vUmZ5cUh3VDc4ejZiL3JNUFkwNzdWd0JWOGs2U2YzWmJoNWtRam1O?=
 =?utf-8?B?dW1mNnQ0aFJxcWhCcEtlSGZxaTRYM3FFWFhZTVEza1hDcEplN2l0alBYYllk?=
 =?utf-8?B?RW9nYmsyM1dscjh6M0ZIOVgrNlFrdnl3ZXd6TXhyM1VFQm1QbXdCb0FlVVdI?=
 =?utf-8?B?RjcrWmNPOXUzMXRyMmZURXFFUDRMN1MycDNQc1UwUXVWYWNOZHo2WnZya0Jy?=
 =?utf-8?B?ZUk2T0lIcUNoalpPVnE5T21KZ0E2MkI5WlhzbW9saytIeEJ4UkNoUEY4aG1U?=
 =?utf-8?B?dms3REx0NTY3bFpJOFdIdW9pdmxqb0Q4cEJIaFlYUjN2andNT2Y2TnFWelRx?=
 =?utf-8?B?MWhRR3V3ODV0UWEwdXhCc0EzMEF6aE1sL3l1VXc1VDlDSVhtRUhhMVlVYWoz?=
 =?utf-8?B?ekJWTWtlaWVKb1o5anREYUp2QXlCclFZZTB6aytnUDIyMmhXU0dCSVMxWlEr?=
 =?utf-8?B?c21FQndzelYzOWZydDhxRDJDcnhYYUozY3g5bWVFeFBTOGo3TTJ3UGg5Wlp2?=
 =?utf-8?B?QmJ1MTBNeGttTEZvYjh2SmZSbTZMVEhOMFRSNjk4VjJuZkd4RmNoNUQ1aitI?=
 =?utf-8?B?U0JTTWxsZkUyVjlGL2Y5dnVJYXlYYWEyMEoxK3ZPckt5ZjlNejR3Q1o0RExV?=
 =?utf-8?B?WENGOWgzeVRTWnU0T05lWXVJRzZTUlJrS3M1WFB1UTRaV1BiOHovU0Z4QTlZ?=
 =?utf-8?B?NjkyUlIvWENBcmltL1JGQUMrZ2tzcFFCZHNZZ0M3aExOMnhudmp4RTRZMml3?=
 =?utf-8?B?cUNXMWxSQkJEdEkyWUMzNHVxc3doaUV2eHROWFAzbFdEeEgzcVViQVpUbFF6?=
 =?utf-8?B?cE0wVnhxOHlUa3JiT2N3ZTh1MVdreEk4c0c2Q0RMWGJiMG01eDJLRk0xOENz?=
 =?utf-8?B?d3l5aCs5NEZsVHFMRk50WU1wRW1nbXVnWGtkUnVTbU5XbitIeVgzTTkwTDli?=
 =?utf-8?B?eDI5blV4Y2JkUitUZGVIeE80MlNiYU5VOEE0ZnVPK0tBanNyWEtBUFUxTXNG?=
 =?utf-8?B?MFJQSFA4V21uZ2tUdWxmdUY2Y1hYYTNZbUJVV04ySElWbjIxaXNHRGp6RGZR?=
 =?utf-8?B?VzJ0bzBSSnBGLzZTRWlReU12cGk1U3JHMHYxN3ZrQTltWFpzM3V5bmFFY0I5?=
 =?utf-8?B?a3Z4Q0cyR2JWSHE0K3hnRUhmL0plaU5MZFV5Y0ZSNGRDUGxENTlCYm82QmZV?=
 =?utf-8?B?cUJUUkRDdmxFYURqSmQ2TXB1UURzSnVORkFiUWR0aERSTU9hU2ZUR2MxVG5k?=
 =?utf-8?B?ODJyS3h3bDg1Ym9CM2Z3Unk3cjZ1Qk5LVHlBWDFMdjhxNnNsMVZtSFJTYVdw?=
 =?utf-8?B?QlhIcjVKd2RCeE03SHpvRFZBMFBKU2F5elFWYTRWNmNnNHFUR3Eya3BJY1VD?=
 =?utf-8?B?UGJ3NEcvUjZHSC9ScWtwckdmQU8xd2pkYmNuNm1uYUVnM2FJTWtVL1RyUFg1?=
 =?utf-8?B?dUR1ZC9OdUdHL0VORlpRSGF1QW81bW9ad0RIZU1UOEhaVUV5QTNad2thYVFI?=
 =?utf-8?B?YnFpUUdHSyt0T21iclZlSGl5azIvazNiV1NEMy9pdEZwMjU2K3NJNkN4RU9N?=
 =?utf-8?B?RzFZUTQzMk1LRVR1YVdSaXZvNE51bU5xSTdzeDM2RGxDejA1YXRoOU1Kcmxa?=
 =?utf-8?B?S2dVUzRVdUNYSTlpZ3YwSmlGT2lNV2VLbXQyeDludFlFUlpkaUl5SXRkb2dx?=
 =?utf-8?B?b2hPaWlvZ2Z2alFuMTA5SnB2ZUpPaHRXMXEvY29ZVlpmbnc5NG9pVlFhWVB6?=
 =?utf-8?B?U3M5T1JnNW5nR0JsMFAxa0RhVjJsMExqQWdydz09?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 19:12:26.6926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a63e770-6db0-4eea-603b-08de254414bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092

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
index 254113d2442d5d6956587a1c444dc74cd48204fb..b150bb78de3c4fd89990f7aed7874e4db94eac0a 100644
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
@@ -518,7 +545,7 @@ int ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr)
 
 	if (ret == 0 && schedule_aging)
 		queue_delayed_work(pools->aging_wq, &pool->aging_work,
-			secs_to_jiffies(FRMR_POOLS_DEFAULT_AGING_PERIOD_SECS));
+			secs_to_jiffies(READ_ONCE(pools->aging_period_sec)));
 
 	return ret;
 }
diff --git a/drivers/infiniband/core/frmr_pools.h b/drivers/infiniband/core/frmr_pools.h
index b144273ee34785623d2254d19f5af40869e00e83..81149ff15e003358b6d060c98fb68120c9a0e8b9 100644
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
index 6cdf6073fdf9c51ee291a63bb86ac690b094aa9f..e22c999d164120ac070b435e92f53c15f976bf5c 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -184,6 +184,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES] = { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE]	= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE]	= { .type = NLA_U64 },
+	[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD] = { .type = NLA_U32 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -2887,6 +2888,38 @@ static int nldev_frmr_pools_get_dumpit(struct sk_buff *skb,
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
@@ -2997,6 +3030,10 @@ static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 		.doit = nldev_frmr_pools_get_doit,
 		.dump = nldev_frmr_pools_get_dumpit,
 	},
+	[RDMA_NLDEV_CMD_FRMR_POOLS_SET] = {
+		.doit = nldev_frmr_pools_set_doit,
+		.flags = RDMA_NL_ADMIN_PERM,
+	},
 };
 
 static int fill_mon_netdev_rename(struct sk_buff *msg,
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 8f17ffe0190cb86131109209c45caec155ab36da..f9c295caf2b1625e3636d4279a539d481fdeb4ac 100644
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
2.47.1


