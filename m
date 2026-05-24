Return-Path: <linux-rdma+bounces-21210-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH2qBEccE2oE7wYAu9opvQ
	(envelope-from <linux-rdma+bounces-21210-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 17:41:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF545C2F44
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 17:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A708301C67A
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 15:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01673AA4E4;
	Sun, 24 May 2026 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L+/aUwsw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010053.outbound.protection.outlook.com [52.101.46.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4E2399019;
	Sun, 24 May 2026 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779637168; cv=fail; b=RUyrNRyDvVkrZeeEGscyWQMoGw5KCU0MsiYFd8zn/nSorYaKcRHRZzJnmdpSPJlhroBpgcd0WaSQ57pbi6YcFd2RO+o8CmP+++cfY8V0+qWavxyJjtNCeq5yA6vVnjOPIdaIzKp6W5Vl3yE271XXThu3yJ3lfNZac+Ju0qmJvWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779637168; c=relaxed/simple;
	bh=RYIxnf9DXnrEhh3acy8sg8NJJDmUPJVZUd6reMbx3Og=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Me74xjwdy1BVtc0iO2Cb0vCMd1BU6IszJXALORb1ii8QfZNVYbFuX9lCOqBC7riz48lwWBenyQIIAltL7vFh9wvqNNzhMTXJ4PpEhDADE5nVdWJsQBfQIvNci7BKYvRfpA6JizwfHfjGmM7vjhjNTpdRyhO4S8q6Jd8yF+pS3Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L+/aUwsw; arc=fail smtp.client-ip=52.101.46.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i73C3h4EG0IskcELMbXuRwiGZ8rJEAnXDqhnp3d2VMJGd9God3Yb5gce7ngfJNnMrhHOLJASJTc/b1w+aHLUcfa/RH4z6nfWN7NDGWxSCEiYaE1KREbsBu0q/outojBLgZlVnupL7mWaRjXRD4gmL6f1GcqZ8nD078X14gmw8iU1uzg0HyRHTNXJFRjpeH+iLxel+L1Qa02Lgf72pMy9aH3alOCbImw4b0PzIJ8h0TmdvOH+FVMbWGeXfXgEHGYLYckZHOMEC0vm4/eAE3T9E44W5I862PMqv4beduIjpKJz15AUiTAGPGTSHmDykbxW2NPDAH4JNwuVXuXBU73cag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FD1XRWCeQBztypRZN+bhYIJba8gTsFeBh4O+ySAHFfE=;
 b=ZtdDsnfoPLryNj+d8douD8U6SRgiXzFCewkeBWeAJthUYyLmcZ4c9G4Oz711U3INMXdWYWbVh3pp1KDXAjpHsMSw3uljZKjjCmrM9sBtmDkZImz9YJ6VTtRLUQUFe4QlhrWGZMCYXFTVX6wQMkdM9z/gm6EuUXj+sF3OpuGh+W74xFpMzPuy4CRWMyH2+qFs0Sst8YZcbgzG5aqQ6qMx6NTTjqX3ZKplccZt6Pr920dUMlgnDXwdJj/4WhPEJ/uWgj1R98cIZhOCv8NmLPkx7SzEY5ZFms+QVZC4nVYKJUeuiFw38oJzTxUuvOSchl51+hjY8aeYVrL6EG0CmigP5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FD1XRWCeQBztypRZN+bhYIJba8gTsFeBh4O+ySAHFfE=;
 b=L+/aUwsw+F4WOftLtkFNEYMxv8L0Ku8lnfI/+TMx9mFXPG8uOUx8UrFq8zfhV8zg2KAPJf4SVb4bQH4nTftBcBT3BYY5dqjOfIiqDmxOWV3CI52eCfsOwYBEq4j8K7bU2aMgIbVeb44NfTfNe34YxGq1fXspOb/eglO9H1yrVTJ/WWe8//OjM4PIil1I1SCp0KRYWQp+ipA2NjqoPeq52c9z6aXEzI0x7ZxQuPdR0lQmB5ZQr9+om+60vD21t8O6OxAxSbbwyGiIN59OKGhpWENaayh7SaVagA234mVSqYo5loXX1ct3g5hiD/WS5uZDjdXWdP7QNhSOfB7dEfveaA==
Received: from CY5PR15CA0199.namprd15.prod.outlook.com (2603:10b6:930:82::16)
 by DS0PR12MB8017.namprd12.prod.outlook.com (2603:10b6:8:146::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sun, 24 May
 2026 15:39:22 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:930:82:cafe::4e) by CY5PR15CA0199.outlook.office365.com
 (2603:10b6:930:82::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.19 via Frontend Transport; Sun, 24
 May 2026 15:39:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Sun, 24 May 2026 15:39:21 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 24 May
 2026 08:39:08 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 24 May 2026 08:39:08 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 24
 May 2026 08:39:04 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Sun, 24 May 2026 18:38:09 +0300
Subject: [PATCH rdma-next 8/8] IB/core: Delegate IB_QP_RATE_LIMIT
 validation to drivers
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260524-packet-pacing-v1-8-3d79439f8d08@nvidia.com>
References: <20260524-packet-pacing-v1-0-3d79439f8d08@nvidia.com>
In-Reply-To: <20260524-packet-pacing-v1-0-3d79439f8d08@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Selvin Xavier <selvin.xavier@broadcom.com>,
	"Kalesh AP" <kalesh-anakkur.purayil@broadcom.com>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Allen Hubbe <allen.hubbe@amd.com>
CC: <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Edward Srouji <edwards@nvidia.com>, "Maher
 Sanalla" <msanalla@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779637112; l=2883;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=H/vEYrNKcfkNSalVAkI98bNt5QiYXTFNrsGSqde6Zjg=;
 b=ZCQjIM3o7VR053BKt6WX0R/zzVzJkU00uDljKXZkMjMcQs5Oks+PQ7GypupCi5L9o1HwqeJOO
 3mFk4b8ggcbAojA75JKsHLXq5PZr6sxeQ3UQvKLR5ppKEO8XX0jkRo4
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|DS0PR12MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: 75cfd5ba-e9f9-422d-84ee-08deb9aa9fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	/3brHAQPAtFhSGNMBWXVf9capF93DWa15NsRF6gW5+kJ7yOnO0kTdpP+75xIVMQkXmocYIE67D3oSGvrHdjR4bepcrg3lg8nfOsrrp1WhgvdGljh5uT1eb7XwskJgRsw10LCZE4wGyrKNVfJ6TjlDh4/PuPgVoMmq4bpG02541/E6ovgaI0YaTZLr3Hg64PzCnGpg6XR+mtUTCy7/PdtB/p7A8R1AEYkxpqTBlCdDixYTqoAwVsKECDxEL2mi7ogqYRBsnYvJHR49lOYTuuCjT+G1IhrVv4Bv56Mh58p0A5D36V7ZtzV2COELgTszFmiorANTDMLPONbm0rcN98+DxE1A3bGJcqKAxQ5qeE49nTY2Frcer1PCxTm2Ejj/UBTU2qw+/JPuvKRUz1wZkTCPBM1rJYNEwc504cszV6F+ULLkHazsZ4QwL2ENBAnFwRAGdiugm24uldCjkRxL/vfPTQaXIcySFiXQpsQsKgF+HOHb4yj9Kqg+om7s+u4H4o+eLYlZEqb3Su8s607Xe8e/TigWYamfR2O3gcevGZnhD1aHWddJVbWYqsvVT9dnhDK49zO+LtAp2sFwgq+siOcWnVzesYICZHHZpX8KtKHLCiv58wwuM3z90cciBPFEH6TDKNaj10xKYTANMAiouEnJTYyvRGjSeXjFCITEPUy4bCEcS4ACxmbc/Ds/wumVx/+M8ney6HmaigCh+xCJTUuJBf3GHCMuodzev0fcFsFtjU=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qfWXnP4jQHVsxmgtI4l3BWLS2sLv4tx5uk+rng3yfkG5b7eiy6oIM8vXglMWfTCin2F5jtlwAXNAgr1o4GtdHz37683gfYHPQmKbm4MkxfqnP/IdatDwVasK+CH2qv1oG1HHiL9OSjvfj2C2UIvTZnVre/ZuiSGcvwYQVw8FVeYd5K4RSDjfWJW09AgXGX+uslWG9IhrvfnWfpLOqHX1S/3Q5aTna7AaqXpPaYnX9bV/HmaAhXFhXj8ALUDTV85uZO56uc5OF1PkebSEE3JUmC+NcCEBuWvs5NkfepDJbmVTtqZR425akcKjjevSao8tn0ErNz2KG+srnkWIS6gO0BETgD/xAmWg1cgcXt+M+s3v8AKM4zP+dwVBtulbqeW6tHVu4G5yi22KcZes8nSz6E/1QBe7eniZtYsWAyp45IwGUAPs4D4VcwADcvQHGGip
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 15:39:21.0123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cfd5ba-e9f9-422d-84ee-08deb9aa9fe9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8017
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21210-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: EFF545C2F44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Maher Sanalla <msanalla@nvidia.com>

Remove IB_QP_RATE_LIMIT from the qp_state_table and instead
pass it through ib_modify_qp_is_ok() unconditionally. This
delegates rate limit attribute validation to the individual
drivers that support it.

As rate limit support expands to additional QP types and transitions
across different vendors, centralizing this policy in the core becomes
impractical. Each driver is better positioned to enforce its own
supported QP types and transitions over non-standard attributes.

Future support for non-standard attributes will be handled per vendor
driver instead of in generic IB core qp_state_table.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/verbs.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index bac87de9cc6735c5d25420a7fac8facdd77d5f09..d105106fe9dc2a86001f771c0b7ab887e576642d 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1538,8 +1538,7 @@ static const struct {
 						 IB_QP_PKEY_INDEX),
 				 [IB_QPT_RC]  = (IB_QP_ALT_PATH			|
 						 IB_QP_ACCESS_FLAGS		|
-						 IB_QP_PKEY_INDEX		|
-						 IB_QP_RATE_LIMIT),
+						 IB_QP_PKEY_INDEX),
 				 [IB_QPT_XRC_INI] = (IB_QP_ALT_PATH		|
 						 IB_QP_ACCESS_FLAGS		|
 						 IB_QP_PKEY_INDEX),
@@ -1587,8 +1586,7 @@ static const struct {
 						 IB_QP_ALT_PATH			|
 						 IB_QP_ACCESS_FLAGS		|
 						 IB_QP_MIN_RNR_TIMER		|
-						 IB_QP_PATH_MIG_STATE		|
-						 IB_QP_RATE_LIMIT),
+						 IB_QP_PATH_MIG_STATE),
 				 [IB_QPT_XRC_INI] = (IB_QP_CUR_STATE		|
 						 IB_QP_ALT_PATH			|
 						 IB_QP_ACCESS_FLAGS		|
@@ -1602,7 +1600,6 @@ static const struct {
 						 IB_QP_QKEY),
 				 [IB_QPT_GSI] = (IB_QP_CUR_STATE		|
 						 IB_QP_QKEY),
-				 [IB_QPT_RAW_PACKET] = IB_QP_RATE_LIMIT,
 			 }
 		}
 	},
@@ -1622,8 +1619,7 @@ static const struct {
 						IB_QP_ACCESS_FLAGS		|
 						IB_QP_ALT_PATH			|
 						IB_QP_PATH_MIG_STATE		|
-						IB_QP_MIN_RNR_TIMER		|
-						IB_QP_RATE_LIMIT),
+						IB_QP_MIN_RNR_TIMER),
 				[IB_QPT_XRC_INI] = (IB_QP_CUR_STATE		|
 						IB_QP_ACCESS_FLAGS		|
 						IB_QP_ALT_PATH			|
@@ -1637,7 +1633,6 @@ static const struct {
 						IB_QP_QKEY),
 				[IB_QPT_GSI] = (IB_QP_CUR_STATE			|
 						IB_QP_QKEY),
-				[IB_QPT_RAW_PACKET] = IB_QP_RATE_LIMIT,
 			}
 		},
 		[IB_QPS_SQD]   = {
@@ -1775,7 +1770,7 @@ bool ib_modify_qp_is_ok(enum ib_qp_state cur_state, enum ib_qp_state next_state,
 	if ((mask & req_param) != req_param)
 		return false;
 
-	if (mask & ~(req_param | opt_param | IB_QP_STATE))
+	if (mask & ~(req_param | opt_param | IB_QP_STATE | IB_QP_RATE_LIMIT))
 		return false;
 
 	return true;

-- 
2.49.0


