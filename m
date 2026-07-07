Return-Path: <linux-rdma+bounces-22834-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WmYnHrz9TGqCtAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22834-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:23:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0F171BD82
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:23:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=LHSw1CmA;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22834-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22834-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 980B930788C6
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 13:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3195741A77B;
	Tue,  7 Jul 2026 13:12:33 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3F641A76F;
	Tue,  7 Jul 2026 13:12:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429953; cv=fail; b=ErbNPno5H01YtFhbBiEYglrUym4HGjQloDPL2YU34h71vhZhpbffLk6qyXA/KTT2L1vPafVmcctFlxv61f+Pp+urnaEYp8Ttd/Lqn7G5fGO5mRNzeTfHXMjtV+W9Mk8q7lCr4KmSarLruwUZOkT4uV1n9T4zImMkuFOo4poc35Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429953; c=relaxed/simple;
	bh=p9/I/r5tMHksJPeYsfUkWQqo0HAyGHh50xhrqIN7ljU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4b+x1aJTNjKLGlmVz9Fm1Hc5uAPv31eDJuaWtZsnkjt4r5FDFO5NTs2defl8fE46PtLLv8lobo4z+jgmxK8ffmHhYi6szD93x44sFN1M/SQaZRluZyg3eHRFLQ1/vFtjsuVtHsOUmvZGJwoWJv1in6xkva7+mgpIMjjmv4l2Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LHSw1CmA; arc=fail smtp.client-ip=52.101.62.2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6QIsubai6GI4vhG395Dnmbr9F9f2lndY+Ek3/Rx4NPB9GCL9W7ZjQsCp+Hs3bcdaHtzX7k5IJCgkQo+ngnJz8I5zdVm3ib2d/kPKZzF9sMIm6h6NqyTaSuvqni5J0Z5xaRFcn6zUZrgyfYfZ9IZXVpx98PdkTef6QVsg9eeDZSGgUo5/jeSwIYWpZNzxLVo3mH5JNBxY2l2WKAcharuC8ZAAJftOEdS6rzab9zlCx1HZuvVxpS6ur2eQTgFnCpj0cZGS5/2KGNXlFghrxTvm8gfqWtIGsvg5qfMtlMH9jGKV3oIvCJkgBRKVExxLJTqlff95bk4LzHxX7RXGGGRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPX1vR3XFoxQt4xdeV0fs29o6QQsAVreu/ejKgLl+hQ=;
 b=fnXD5hFQY5kmMv5N8d8D/xUCJOHroo9oCwqJfVP9v3wC75k2bfds7D4oNq41gJVkuYUEC3fvJuO6x23DXGXsufavwPqXyFzDjLDx7pMeQFI2Z2xBq8lgWH4SBaO0/ux6LbdrlGX4+P9UwkqYV9yXl9lH2/T9QF9Xj+NbUblOypq14TnviCFAGP9Rzfl2l6xuhb9/IQRBYEJ9MbrktJsr0JImOf61hneWRJ7m/5XP2xgsfbv3GgdbJP4kpVMgxxXTYBn70zdXsjRUOMCFQw7FaCkV4EUh8Z0OI12G4b9rOn8Vt1o4RCF82oNK+HqIuNj88u6v5TpLFh49HjMTLoawrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPX1vR3XFoxQt4xdeV0fs29o6QQsAVreu/ejKgLl+hQ=;
 b=LHSw1CmAfAHu2FontJKxHnE8/MleUJYw+IAEso3BM4jdWoTCNBT55rMqnggw+w+5AMN1qYCZmCSYSLfPgwHVOVdZ7FyBU1pfGfCEkBCjiK4cOn5xJjLcQQDVa4O627qa2jT1xgMmO0Fua+DG1fqWxvPEKHALgOWcz5iAVkwmx+cZvq9BJACGu519SBQd7gbM2zcat24Ei04uKFYjgB7vnNqsbfgGt2lb9Ec/73ZRuWZk0++dUcpdt9d/n6H0KV/HWOcVFvvpE7VNP6k6FPONs1wAIjAul1zk1uUXybufiLx9MUCF64SuL3MPNgB51lCeo6yDVYg2MPl4TF6C6OhAZg==
Received: from MN0PR02CA0005.namprd02.prod.outlook.com (2603:10b6:208:530::26)
 by CY3PR12MB9606.namprd12.prod.outlook.com (2603:10b6:930:102::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Tue, 7 Jul
 2026 13:12:21 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:530:cafe::68) by MN0PR02CA0005.outlook.office365.com
 (2603:10b6:208:530::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Tue, 7
 Jul 2026 13:12:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 13:12:20 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:11:51 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:11:51 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Jul
 2026 06:11:45 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Boris Pismenny
	<borisp@nvidia.com>, Chris Mi <cmi@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Jianbo Liu <jianbol@nvidia.com>, Lama Kayal
	<lkayal@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Raed Salem <raeds@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, Stanislav Fomichev <sdf.kernel@gmail.com>,
	"Tariq Toukan" <tariqt@nvidia.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next 15/15] net/mlx5e: psp: Report PSP dev registration errors
Date: Tue, 7 Jul 2026 16:08:58 +0300
Message-ID: <20260707130858.969928-16-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260707130858.969928-1-tariqt@nvidia.com>
References: <20260707130858.969928-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|CY3PR12MB9606:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c99158-2252-4973-1430-08dedc2960ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|1800799024|82310400026|376014|23010399003|56012099006|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	QzJ5fqNAKSQQfdIRL0bA5zi3V0CG9ElRvxv+YIniMw+lmFqQ3o819myxTGXTfPZ/qTEW4Peq7E4sza9sg2+ctx1e6pY3Tr+DT19U7s3SXl63+5LlR/MWFYcVibpY3e4JKqWgH6HV81xdjSzsejsgeOPzM81bnY+b3zmNXOg9061JGl0uQVz7TQmVAmnz1RO9tFIj7rW7KHjbD/DFsb3O+qJ/dCI1FCDEJbmpQS9Tj+vKkojMNq93WLOQAP1tYh5Tqvd6RFsgFUIlFI1CEIFi4xCqbgL1Pdw/OBcZILv8X1aK4jUj8vz2WdCxowZfy40XJpU7CcVJ9BCv1DEnDj47iHWA3jEs93ij7Ws/N0rLGxStdti9xRoV0sa0byA8T+1KOmJhmiliJk/8stYVWpsmhfH/8B6OR3GJ70us/+YSvIF1y6fMoUrHpuSV6fvUScreWohYmGJDTHDFEf0QM+j0ao7QyaNkuKq83DD/m2M9h6UdcB9w1kCCzjWdKV6ciPO7aDwTj9TY2ItoeUu6+7jLSehcYQBjLQX4xrI2QyVlL3vxk0l/u1gPl1avNnrrWon4h6I/CNkPwGv5bqztrSHoUVOfX8LNOLan//xAWdHO4Cs9YWsTxllUbXUQc3UguSZE0oEygLHIxUKVMS2TTXaHoMgPo7VrJnFYPN2V5BkNEFWBMSItThm0Jwtltp8halbTC2kFmU5/0IC3LWnSRq6E2Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(56012099006)(18002099003)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	V6KDvJMgs2z7HWPZVE/pjdKm3AoMkzrwu1IxPUDzKCQImQoUJ6NBuP+uIBjqFExXwQlxErcMXV/Vf5hRuabptCd4SungMPPL1Y+Oeju/TZwqNfA2XfHl4JhpR0Wl3qPiC4r9ecbrCCAnbu6OYtFKlQIgTryl5WmV/AsIL14Ni/7mSeP8b1qRqInAtL/Xtsj9R2sILmkLNHV75V12+wvTlBJp0x2uH1YCvoinlbsgmKus6BYy6TfnI0sfmAHyE0gyUw/lnwN06F/EuxRhB5hVpImyE7pKGLf9gwxZSTBgAjMYmo5p+MpGjBqXdSPJ6BQqeiFaOimwOZZ+FnTCPSiScUGpOM4a6l2uNzibxXWc8ySSoG/ghHaALhr+KRRIDiWxMEijQbihSqGqJ6+EzxmRdW9iZxis97V57uZq8isqViJtC6UPbLwzJT92UbD+Qrs0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:12:20.7518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c99158-2252-4973-1430-08dedc2960ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9606
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:aleksandr.loktionov@intel.com,m:borisp@nvidia.com,m:cmi@nvidia.com,m:cratiu@nvidia.com,m:daniel.zahka@gmail.com,m:dtatulea@nvidia.com,m:gal@nvidia.com,m:jacob.e.keller@intel.com,m:jianbol@nvidia.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:raeds@nvidia.com,m:rrameshbabu@nvidia.com,m:saeedm@nvidia.com,m:sdf@fomichev.me,m:sdf.kernel@gmail.com,m:tariqt@nvidia.com,m:willemdebruijn.kernel@gmail.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:sdfkernel@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22834-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,nvidia.com,gmail.com,kernel.org,vger.kernel.org,fomichev.me];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA0F171BD82

From: Cosmin Ratiu <cratiu@nvidia.com>

mlx5e_psp_register() was forced to eat PSP dev registration errors as
the caller was not propagating them. Change this so PSP dev registration
failures get reported back to the caller instead.

After the recent changes in the series, PSP dev registration failures
will just leave some data structs in priv->psp (mostly counters), with
no steering rules and no means to configure them. There's no point
actively cleaning those up on failure, as they'll get removed during
profile->cleanup.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c | 8 +++++---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c      | 8 +++++++-
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index b3521c3861f6..73b232379263 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -1028,14 +1028,14 @@ void mlx5e_psp_unregister(struct mlx5e_priv *priv)
 	psp->psd = NULL;
 }
 
-void mlx5e_psp_register(struct mlx5e_priv *priv)
+int mlx5e_psp_register(struct mlx5e_priv *priv)
 {
 	struct mlx5e_psp *psp = priv->psp;
 	struct psp_dev *psd;
 
 	/* FW Caps missing */
 	if (!priv->psp)
-		return;
+		return 0;
 
 	psp->caps.assoc_drv_spc = sizeof(u32);
 	psp->caps.versions = 1 << PSP_VERSION_HDR0_AES_GCM_128;
@@ -1047,9 +1047,11 @@ void mlx5e_psp_register(struct mlx5e_priv *priv)
 	if (IS_ERR(psd)) {
 		mlx5_core_err(priv->mdev, "PSP failed to register due to %pe\n",
 			      psd);
-		return;
+		return PTR_ERR(psd);
 	}
 	psp->psd = psd;
+
+	return 0;
 }
 
 int mlx5e_psp_init(struct mlx5e_priv *priv)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
index 57fffcf4a62c..3f441e7dd55a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
@@ -45,7 +45,7 @@ static inline bool mlx5_is_psp_device(struct mlx5_core_dev *mdev)
 
 void mlx5_accel_psp_fs_cleanup_rx_tables(struct mlx5e_priv *priv);
 void mlx5_accel_psp_fs_cleanup_tx_tables(struct mlx5e_priv *priv);
-void mlx5e_psp_register(struct mlx5e_priv *priv);
+int mlx5e_psp_register(struct mlx5e_priv *priv);
 void mlx5e_psp_unregister(struct mlx5e_priv *priv);
 int mlx5e_psp_init(struct mlx5e_priv *priv);
 void mlx5e_psp_cleanup(struct mlx5e_priv *priv);
@@ -57,7 +57,7 @@ static inline bool mlx5_is_psp_device(struct mlx5_core_dev *mdev)
 	return false;
 }
 
-static inline void mlx5e_psp_register(struct mlx5e_priv *priv) { }
+static inline int mlx5e_psp_register(struct mlx5e_priv *priv) { return 0; }
 static inline void mlx5e_psp_unregister(struct mlx5e_priv *priv) { }
 static inline int mlx5e_psp_init(struct mlx5e_priv *priv) { return 0; }
 static inline void mlx5e_psp_cleanup(struct mlx5e_priv *priv) { }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 9eadd0b6f055..2cb48b24d5ea 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6199,7 +6199,9 @@ static int mlx5e_nic_enable(struct mlx5e_priv *priv)
 
 	mlx5e_fs_init_l2_addr(priv->fs, netdev);
 	mlx5e_ipsec_init(priv);
-	mlx5e_psp_register(priv);
+	err = mlx5e_psp_register(priv);
+	if (err)
+		goto out_ipsec_cleanup;
 
 	err = mlx5e_macsec_init(priv);
 	if (err)
@@ -6237,6 +6239,10 @@ static int mlx5e_nic_enable(struct mlx5e_priv *priv)
 	rtnl_unlock();
 
 	return 0;
+
+out_ipsec_cleanup:
+	mlx5e_ipsec_cleanup(priv);
+	return err;
 }
 
 static void mlx5e_nic_disable(struct mlx5e_priv *priv)
-- 
2.44.0


