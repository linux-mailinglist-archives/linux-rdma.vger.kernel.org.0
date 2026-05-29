Return-Path: <linux-rdma+bounces-21480-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IG2pHmwjGWqVqwgAu9opvQ
	(envelope-from <linux-rdma+bounces-21480-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 07:26:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDD55FD562
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 07:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBE63310175E
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 05:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20243A1CEA;
	Fri, 29 May 2026 05:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="md+1w4R2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012045.outbound.protection.outlook.com [52.101.53.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6D3351C2D;
	Fri, 29 May 2026 05:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780032306; cv=fail; b=nWeiZFFT1RnoH7uhziZfokEEiGuO6WO24ssLJmSosYsoQjIfI5woKKYMkl7+0rWMz43OZ5aopn808SrWnZsthmpggMFT41G2iwmfziJa+IVrmETta9LFUBT+kue6CnyHMwsDyBGD6gkKwRCQASex8Sqxpn7Np5x6TMgvPvs5FHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780032306; c=relaxed/simple;
	bh=SvIUNuqnoP/sEx9nRr85K6kUDAaA6ksxOy1m6lI4i7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTbLI2kUSddvHB+Dpkat4NcK6cjenqicmBDMP36AzItgvrXXzQEcJapFtPzEG2y3dqtOY1LkwDQJ4VJSuzt19rFGaufDRKdKOV7DrPBErp8jEzGS1YlXBI9wGGpVMNBN7KB2spmiqQhvVX1F2p38NFBwQhIgyoKS3Ciuo781eNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=md+1w4R2; arc=fail smtp.client-ip=52.101.53.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOjylx/VaupaOO3I294F8m0E5WjZ+Wr4a2+EHJ4+ST7OrxuZ44hw0VpuAiLkEV61d+1buX0ZQgC5S5if7/KW0g9H4kIE1gJD8Hq2Ok5pzPx3WlV5vAl2YhDIKReTEY0anS9rKmYQ3Xql1Z7ofHxa1mMsloaV2y4k1+p6fjsf2N7ZYnePcbkahB3pNAXyCtIDsMC+j7d4NME0itoeppPEK52ZNCGKGAdLSNFux1mbDfA1Eu2Lh/70OdkBCYLkmlJ9YotVSC2AgrMUdH4cT9JPuTOpPDMaD5pDFsRqBpDTgrkMJskHwQN+8HcAnGOv1q474X3u05af84Q4p1748ewLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZFwl4aXF/4hhnaImOV+rSV8cbFMjJp+yccgUmP/tBs=;
 b=qSvhNGF9lPF8+LyqFMI3dPW9KyAOO98qO3PXZ9TOb+JXWiEEGVHbdmGQgaC1nkNQ3iWjIG6C+0fs4mNZlx6ZvtW1xI5bIjNJ9KgabVpxb3FrL65KBJjYuIOhinV9dKJbWUQ3A93yIELuUJAQya99xR7YFtCTw048A+E5LBam5E2sT+OBZ9RcsQ3NgmrsJB59hlJC+rrI739v47PR0KsNHIiSfhC42hX+oZ6SkSho73fcJiyb228BvHwC5RNRPSJ8neGK1n6wkJMkplJfUHvsdRiSWhga0/wvwv3aqbP9yQffmY+HSkjF6FLKMKVyJd6Aovv3aHbMx/PDzStNdiLdvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZFwl4aXF/4hhnaImOV+rSV8cbFMjJp+yccgUmP/tBs=;
 b=md+1w4R2kdrK2fFtnCa9aq/K7+sIg+gniZUN4/p9DM+/JDJ0RPGeZrolUaiZacZ8nTKI1U93AwcI13iNZgex7bP6QVlqZ56bKDk4LdVm723OBMpR5oAUO/zfr9tdpslYrZ+GcI8Bwe8SMGAqxi3Eu84ebFhNw60u73N1UV3kkHqBRD6Q+qpGI7FD+vd5GDcXoU2YxGPdibkwrNKf1I3JnVXoeEEAyTIUajyB9CV8gvE5bvB+fKfvrgYwNzCJmh7PglbRNXRoz4bc7ojJlkONtgwDkm6wK/uhLA3qBgczMOH1rmtvsWbH01YfqmIx/eK8PQY8DD1PV4Ttia06YIy7eA==
Received: from PH8P221CA0057.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::12)
 by PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 05:24:58 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:510:349:cafe::65) by PH8P221CA0057.outlook.office365.com
 (2603:10b6:510:349::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 05:24:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Fri, 29 May 2026 05:24:57 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 22:24:37 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 22:24:37 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 28
 May 2026 22:24:33 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>
Subject: [PATCH mlx5-next 1/2] net/mlx5: Update IFC allowed_list_size field bits
Date: Fri, 29 May 2026 08:23:58 +0300
Message-ID: <20260529052359.389413-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260529052359.389413-1-tariqt@nvidia.com>
References: <20260529052359.389413-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|PH7PR12MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a67b95-ed55-406b-e0ea-08debd429fe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700016|82310400026|22082099003|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	v+W7O8ARqB/9aaJgVX0jL2or9s5A71Vx/nYjqHUBdu2TgyHK4U1MOD0LfId33oRAd+3o0DkbfmJOaY1LKmsQ1qrRxx91dsvFlSMMH3eGAKoHQxY688ZulCR+EPH9F2IKVGtVL6dxVc3ayAeTOfzmYfOuO50P7n6YzuVs5TAVoiCB8yloJ8q2xyfd+npKKF7LDhh024M7rOcUU0FRy96bLXP5tFWeLYUlpHI1mvZWpoG+pa/IzIhtMAmUB2WzEx3bz7QoFbK0C6e4RWvS6Qy02b81SOfODw5UQ6l6TCBkhJRYKMovNxPc8duJ4jSsYau4pk/HJ2e/Mo+kVvTmzKcy/x9xXxb51c+JqgX17nX1NuaX4meWQ/fzcj6nCRo1H2QeZoWyEXTW8iRnqsiISG+tamW7gMPX/hSIQf4F74Os/y0p1Hon9oRTgKGXdAi9667aw65rxERbkv4E+FvhK57ctcZumFomusUMZpdQSe5mg0aNB6ELRKgTX4gTL018EzPkiDYLB/dOklcCXrfLJDtIsWRm15LSAcaeRjJGnw2gBFiEx5fmbnWTssQAmM6tE2wtFss2fH/oKOnfmmlyRIzgd3a1P7wxHk2Jrl5NUECeT6fJ9LZmeizYS6HrOFEDFx/NhvhKhuvrrbX+7yKzzOofYpxR3KvN3HMblKEHU/HnAzXRc3/hrmMRKwfblhUuyHAgrBObv/ThF2R9+rikFoOvSOZfHWaqd/XNJiE6BbY5Dp8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(6133799003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Gnoo8cKV2hIIqKErLEviwlGMu1Au0272ClK5U+/ECXcGG+4EBdNyEhr8IIQvJ0nDVSCgl9AJ7mrqVeYgApDQT1sZzxZbvzULdDsifl5GEyPfXu6e6SUlSceGnWqd41Q82AHxeFrEiCXPiLy2+UtGx37IB2vXp2Qs7oN8C5ymTjzfXb/hCKkuitkxJm/Iz8YY5sufMTnqzO0hdwc2s3TptzMlPslS6rQ5w7ixBCnlzGeMJHmp4YMw5Kh3hy/SNcU1ey9ODtU2mWK75PtLYU8F1LQGK78/4I/WBJognIs2dNHOw71wHgQ3jt+zGihOgiNDzJOVKJ+dAIbs+8GhgbuHuQ2nlrUYbQIz6EvDyKZnH60zFapomUAjvfcW6B+y+YRw521CmUM0RFBhvrQYtmriuwzyZIJ8XR4ExYqG04WSFMH7km83BTacxOMewZt+Y9sC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 05:24:57.9883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a67b95-ed55-406b-e0ea-08debd429fe4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7794
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21480-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CFDD55FD562
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dragos Tatulea <dtatulea@nvidia.com>

The vport context allowed_list_size was increased from 12 to 16 bits.

Writing to this field is protected by the log_max_current_uc/mc_list
capabilities. On older FW versions these capabilities are limited
to < 2K and only the high bits of the field are extended. This means
that the change is backward compatible with older FW versions.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 6a675f918c40..d23332cdd9b3 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -4487,8 +4487,8 @@ struct mlx5_ifc_nic_vport_context_bits {
 	u8         promisc_all[0x1];
 	u8         reserved_at_783[0x2];
 	u8         allowed_list_type[0x3];
-	u8         reserved_at_788[0xc];
-	u8         allowed_list_size[0xc];
+	u8         reserved_at_788[0x8];
+	u8         allowed_list_size[0x10];
 
 	struct mlx5_ifc_mac_address_layout_bits permanent_address;
 
-- 
2.44.0


