Return-Path: <linux-rdma+bounces-14500-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B8AC61B68
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 20:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9351D3B6601
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 19:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601E1242D83;
	Sun, 16 Nov 2025 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bVGA2WXe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEF7231858;
	Sun, 16 Nov 2025 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763320332; cv=fail; b=mV3ahwxFYOQ2EVtXjfGbg7xc2dYA7LQ/uXJKTXc8wAhElFk/ZJjai3hkU/HC3GqSBxaj9vx88TrQDm4u6Ph/se62qHj0xK7jym3+iVTFOAOpPyLpI662Ppc9NcMHFwpz8FnISAUdtrnnJzDpPLe7fRwVH/shsmR8rth7TGRmJ8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763320332; c=relaxed/simple;
	bh=dBfocorl/WQvv0JOFOus12s24qC+kJORvjTnqu8cOaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FBEmqU+rZ6HC2pELtYUEe507A6VW31ymncv3x7IuPR67Ul7F1JXZH9/bhkOtgrZ8iatdkkSRyTg5+pALvJjnhvNtqXUMK9n1NH6VMhiprVNtBElNhK9ZFxHpp8ZcS9bCUodwoNbscziKzwkpoATrkPiWwXyX40VFpz57mpZcKhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bVGA2WXe; arc=fail smtp.client-ip=40.107.208.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFOfjMofcPHWQbcYzabGP2qCd8+8+m0ouiJ8q46Nr3Fd0UBfn36xvhMzNaZ1off9sUfU+BnH1T1repQ+IN6oPaX6tqZIvE5NLxj/i6WJtirXjM5U0BcekeZhp0SzWHJ82+jr7z84qt9Fr1y8LPAJKe/fG0kAg6qcN3dSn2Q0GqhCtMZhnaEKSAewUXjw96hJnGUpYKWO1Oa3iGtJeFwNRw7IInZU3Xf06ZwPbNaP5GkWQwuJZIjmupbWfmQve/jCAz3gIGeJwvO2kiM1Wq8tKCQuUVEoPLr++4JNO8cKJiQNMSnVqiOmHZ81iqJ4SuMhAKFUpGv04mJsmNUhNAUsRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Xpo6xqXP5QhttrD5Fwxh5pzH+on6UuQt67nBa0pcbs=;
 b=vVszcDh8W4C0FQfDKB0q3U1mGOb4MmcLnECDE1vXXMyO9+VMa1xQdIqJvJLGlL+hswzSXBaMVHsPSetXbPPvr+xYwsTWwP4xthOhQYjFdxI3dJgRdR/OVAEnRf7yaL68OvnNJCj7kbPNwd4pjCsEM3pa9E9cBHlLXHMLAh3P9U5juBoif57DTyTyvlM0pzVciBcSQfi8Ke2wHuj6ufA+PgCXNehDJZpULnyC2GejJZfaA7lMpgnutdEQI4Eu0JIk7ngzQjxYUWrXvVB1BAmQALgB54Cptt1WINNRW/UE9SfSvhjMb7QNgCvmHJtQ5tCHj4KBZmNORueBzcwJZjhtmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Xpo6xqXP5QhttrD5Fwxh5pzH+on6UuQt67nBa0pcbs=;
 b=bVGA2WXejYSODT9T3jSVW/JFZu073NKMPyTvpJ1Xpu3nsNqnavGgE7Rsuc3G0AMC/+5dzk5Rgn8VhY/OkwahV0KQ1r2WOdxs6qQpein2bOrxTZR3+jO67f0TLABp67bRLPSCzx9c89emDfX98VivaoRTbJ3YitfR4+vG6UCPRrUMwO83ajPsh0Uzp+/2Tp32eqSDnpV9PzGWMea2OtpTy2e/eOHFfZE0mT2FZL9H5jfCKXiZ1fN9MdWtJrVTXq/+A1pUOfQUL9wwTkzbmaOftUIRxn6we4r6t58oFeE6T+LqOnRzoY4VWMhSD7oENrYq2KKnrUGbae9YW38rGIZgzQ==
Received: from SJ0PR13CA0074.namprd13.prod.outlook.com (2603:10b6:a03:2c4::19)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Sun, 16 Nov
 2025 19:12:01 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::6b) by SJ0PR13CA0074.outlook.office365.com
 (2603:10b6:a03:2c4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.9 via Frontend Transport; Sun,
 16 Nov 2025 19:11:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Sun, 16 Nov 2025 19:12:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 11:11:51 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 16 Nov 2025 11:11:51 -0800
Received: from c-237-169-180-182.mtl.labs.mlnx (10.127.8.13) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Sun, 16 Nov 2025 11:11:46 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Sun, 16 Nov 2025 21:10:24 +0200
Subject: [PATCH rdma-next 3/9] RDMA/core: Add FRMR pools statistics
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251116-frmr_pools-v1-3-5eb3c8f5c9c4@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763320291; l=2288;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=gZjd0LF1NtF31gVqdjJYT1vKkdYHjiv+Rw/V4GGdr68=;
 b=SmxjH9ROmty8OMfK1O8QFftQNBL8EroPKYxu5DM0zAgApscG87R5LOneGD0V0icwZLecZuWLH
 Eqx6C4D6MgtBxRqeJMhqGtsv4r/C5/SfoBEjvUcRKuWEYC09Dvvat2j
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|BL1PR12MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: 49d50693-441e-4b06-ff1e-08de2544056f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnNPV2M1TG9uVWFnZDZpbGk2R25yNEpFM01VM0JtdWZ1NG0rbnIzb28wUmtR?=
 =?utf-8?B?aWtHVEhqMDdrVlljTHdxV2lDS1hkV2VpUndLOGVJZFlLRjd4eHdiRGZGc2xN?=
 =?utf-8?B?OWhqNGZtb2Mzc05Vb0RabGpTVEY4ZGV6RnJGdnljYjRnSytSSnc3aVVyUnNz?=
 =?utf-8?B?NjhGaXJhNS9QeG8zb0s1QkVVQU9ETzQ4M3hIMVo0T1hwVEJXelc2L21UM1R4?=
 =?utf-8?B?U3oyNEl3WjJMK1J0NEhUVTNKMHJiTlIwbE9LWUdPVWxCVU1JcXpwa3l2ZTlP?=
 =?utf-8?B?RTBKU3E0YnZUQzd0NlpPMllaM1BML1l2N3NzdmFGR0xqeXZSTVgrYVR0eFB4?=
 =?utf-8?B?Z1RWMEJoTHpPZlB1SUpUajNrTEFGd1dyVWJqNm1nRG5ocjlQeW1TMklIOHNY?=
 =?utf-8?B?WllNYUVvTWY4MVRpRlc3QVI2MVRZNHNkRFkveklrbTAxWVNleWZIK0puSXNy?=
 =?utf-8?B?YXh4eXpYK3d3RmQ3Y1JaU3RFNmxhS3dnNnhmK08rSkppRmVBclh0MEhNVjFW?=
 =?utf-8?B?TTRNSmJZRWQ3TWg0cmNURytQYW1YeW44akE5VmZIdUgyVEVvSm13MG5LSjNB?=
 =?utf-8?B?NXJUdUlhdDNVOU1DakhNZHBmNDk5WGRUUVIyNmdjUXlzRUZtcTdyT3dIM0lo?=
 =?utf-8?B?UU0yNmYzYThFdEgxOFEwNmtGUlpBbjdXYlByeTkxQnNjMGZVUThiQXI5S00r?=
 =?utf-8?B?U01RVVBJTzV4V3poK1A2MC9MWVA3eFQ0UXVXQ3VRc2NNejRxVTNQMmcrQ3d0?=
 =?utf-8?B?bDhkcjVhdnhWTzVaYXJDYTFIanhneHVzTWp0dGhHQ0tVTnBlM1FqY3pDOHor?=
 =?utf-8?B?VEhrVmZIMUNIZitEbTYrNkczODZqMFNUT3VkV25COVprRENBQjlOenYrbVhw?=
 =?utf-8?B?Q1B0cUpWS2lmdWFTR0xoVUF4eGVxdlZyMEJxTEEwdnhYSWN3VnFFTTc2WFlz?=
 =?utf-8?B?NWZSMkdPci8yKzlhOGlRaysxdVpvakU4a3k4V081ZlJ1aUFPVkFmQzFlZEsx?=
 =?utf-8?B?WWNIRTYvb2Iwa1IwcXVpbXJzWktmYnI4bTA0d2FNRVhneU11R0I2aS9sOXJu?=
 =?utf-8?B?UTFwb2FWNld3VzYwcFQ2WlVkV3AyWXg1UStUZE1OMFd5Q1hYbFljbzJWUjZP?=
 =?utf-8?B?M3JybG9CeUhQZFU0Tmk5a2x3anNCc1pNN0daTy9mTk85aDh2c0ZqRmdoQThK?=
 =?utf-8?B?N3BEOVFYeTU0QnVwMGdkV1lyckI1Vnd6UlR5b05wUnNhdm8xMndUbGFDb09Y?=
 =?utf-8?B?UWFHTWVxQUFxakR6S1hScm1IUy9XckY0UkI3UEVhYjJ6NnVSSThNbVZyRTM5?=
 =?utf-8?B?SW1RY1Q3Y1BiV01nM0VCY1dWR2dTU2RSVTM5MVMveUFMd2ZwdUhXSmhBTTJE?=
 =?utf-8?B?WjlXelE0S3doNHIrdEt6TU90dWVUNVBtOGpuU3BMUUdlWE8wbXI4R3VGOFhm?=
 =?utf-8?B?V0I3TmNITVhiOG9BMzErTytmK2lEZWJYRTlXVWwxOHlYR0t5SUF0MUF2K29V?=
 =?utf-8?B?V0cvdGdMTmtMcFFWajdvWEFDV0ZZZktOSVNhenFkWTVmUFZteGlVNjNHcGhV?=
 =?utf-8?B?MEZJbGJabERHQW9KMnFUUm96RzZwaTE4bTZoVUQydzZEQmgrSDg3Yk42TGZ2?=
 =?utf-8?B?MXNZcWozWXora3pPcG85d0RYOGw2RE5ldFI0aE1ORytHL3pYenJOMTlWRk1H?=
 =?utf-8?B?NitaMHAwQlBjVFZvMDdxU3kwYnFGSkIwbHc5UVgzKytOZ09TR05CaDQ0bVRB?=
 =?utf-8?B?TkF6bHd2QjJlT1ovdndUUlo3ZWR5MTgxM0dRMzlOV3I5UDMxUlIwYVhCZGdz?=
 =?utf-8?B?MHNUckdBcVhNMURad1dvazVSM3ZnU1VHVW5zMmxxcVRTTjh1QUswQmE1bFZV?=
 =?utf-8?B?WkxJNVZiZXM5V0ZmYWtLMkFncEJSN2VLZmtVeDVzRTJ0TUMxb0VuSWJaNXVK?=
 =?utf-8?B?Q3FoUWpvQW9GblZHTlBhcXpCWndXd04vZGl4eHlUTkVDT3NRMkRhK0NBcGtQ?=
 =?utf-8?B?S2ZXV0tnVEVxOWlGajFoU2swWWtkdVRzcWZJbmNpZW80dm1JMytmRFZsQWNs?=
 =?utf-8?B?QXpET2tTdWs5bUl2bktNbTFteEZuMW4zUlJteFRXRlhBY1ozWGlvOGgveUp1?=
 =?utf-8?Q?Owb15fhaIixBXQSNgFUCKhgDT?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 19:12:01.1566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d50693-441e-4b06-ff1e-08de2544056f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923

From: Michael Guralnik <michaelgur@nvidia.com>

Count for each pool the number of FRMR handles popped and held by user
MRs.
Also keep track of the max value of this counter.

Next patches will expose the statistics through netlink.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/frmr_pools.c | 12 ++++++++++--
 drivers/infiniband/core/frmr_pools.h |  3 +++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
index 406664a6e2099b2a7827e12a40820ecab75cb59c..9af2f6aa6c06cee8a1157aac05aa64f361451083 100644
--- a/drivers/infiniband/core/frmr_pools.c
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -319,19 +319,24 @@ static int get_frmr_from_pool(struct ib_device *device,
 		if (pool->inactive_queue.ci > 0) {
 			handle = pop_handle_from_queue_locked(
 				&pool->inactive_queue);
-			spin_unlock(&pool->lock);
 		} else {
 			spin_unlock(&pool->lock);
 			err = pools->pool_ops->create_frmrs(device, &pool->key,
 							    &handle, 1);
 			if (err)
 				return err;
+			spin_lock(&pool->lock);
 		}
 	} else {
 		handle = pop_handle_from_queue_locked(&pool->queue);
-		spin_unlock(&pool->lock);
 	}
 
+	pool->in_use++;
+	if (pool->in_use > pool->max_in_use)
+		pool->max_in_use = pool->in_use;
+
+	spin_unlock(&pool->lock);
+
 	mr->frmr.pool = pool;
 	mr->frmr.handle = handle;
 
@@ -383,6 +388,9 @@ int ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr)
 	if (pool->queue.ci == 0)
 		schedule_aging = true;
 	ret = push_handle_to_queue_locked(&pool->queue, mr->frmr.handle);
+	if (ret == 0)
+		pool->in_use--;
+
 	spin_unlock(&pool->lock);
 
 	if (ret == 0 && schedule_aging)
diff --git a/drivers/infiniband/core/frmr_pools.h b/drivers/infiniband/core/frmr_pools.h
index a20323e03e3f446856dda921811e2359232e0b82..814d8a2106c2978a1a1feca3ba50420025fca994 100644
--- a/drivers/infiniband/core/frmr_pools.h
+++ b/drivers/infiniband/core/frmr_pools.h
@@ -42,6 +42,9 @@ struct ib_frmr_pool {
 
 	struct delayed_work aging_work;
 	struct ib_device *device;
+
+	u32 max_in_use;
+	u32 in_use;
 };
 
 struct ib_frmr_pools {

-- 
2.47.1


