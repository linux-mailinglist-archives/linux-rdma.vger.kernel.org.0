Return-Path: <linux-rdma+bounces-16548-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COQiGaWhg2mJqwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16548-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 20:44:37 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE9AEC337
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 20:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 867A0301A14F
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 19:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225B1428823;
	Wed,  4 Feb 2026 19:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QGRDLl3K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB125280024;
	Wed,  4 Feb 2026 19:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770234252; cv=fail; b=BUodQu42KEoyeqJxTDQrWF6A78iGwq/6inVTrkonEwSnai7jXOz7iWVBUEEp9wv88S0ezs0r9PDmZrejaddcFWwuVSkyst6NXZ8kjYNuYVs0AEkAGPCvvZfWryWcJlmDyXbhxJggjgV3xHmc/UBxQWfu3QUznt7DtAf161IauCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770234252; c=relaxed/simple;
	bh=U4jZgRdyDthFsh+xNPcQRKGzBl/7sKcew7m0SNVxuMY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FMvSkPkCV0mW5MMwrbfBMkmD88kfXvlcA2gx10gvMVs6bK6+VbJXJX8xB96cGj15DHHTfSGhPcm8aCtq0tCNeDXkSoS/92F1zo8xg48Gq0ZJW2Bmw1UzevOi0nVt+FDjrH9Yh7wq6QnD7EeEh7ehLzew19m9QBRLxJs+UzoEqQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QGRDLl3K; arc=fail smtp.client-ip=52.101.48.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTNOoLT0oL9bc1RX33IOIV0WPxsI7mCHKUoxMVNX+fvDuxhikHh9/LaCsbP2xGK+Zg+MESjYDIQ5snI12EZAlErcxBEci9ZevzmkH1Z8QQxO70FzfI290src3wVTDIxAMtWzuiFZrMTjgFL6obUbWQX8u8LSRGSpF4PVKBhhzzPSYae3X05WBrGDK4h/5EHAeK/r/OPy8ifhNn+EKPuO5JMmTsRlIlwAwVA9v/nKq58OkI+yGVQWyC+2qZxF1h5XdFMYsAjxINo1X875w9e36Tse9IO8YJos16DPFb7OqNG9HEJ3ZzmiZvknpmPeVCPGit+ZFr8m6sf8IQzkSbWpkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/L3zi8M60V+VBWcx0O2jBKqGS+IF5toqcxKKXbpc9NA=;
 b=fGdZX5oEboB5vKNZ3Hwj/QnYmFrgxQIKLVCD/llf5bnSbnWjIOQ3e8fUCTemsYJzXnX0ExQTOlgtTz+n2GD11Xkm0eALMkEbsM2uowd4VdzxUglJybMAQL0AKcAWSdV7emsUhdtDA8ch3NacttONaTgfgiMNxk8Ez4dhUNCmochPo0f4hsoUWhLAEGDOEeFRTZoTPTfH3dVZOnxD9KiMnyTmG4rWxLTQgpSmb7fh08e05RLVeuK0YEg8yKwr+c2EutyjAbkejZjw9BbRpjDTU4JX/uCXFFQrk91YWQBOrjrvoKVOW83ovrnOTchRcrLGNvFHM1im6WEx4T1LyRqIBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/L3zi8M60V+VBWcx0O2jBKqGS+IF5toqcxKKXbpc9NA=;
 b=QGRDLl3Kl2lhRD87GHTPCa5QAaMIUMQm0Llim/V2XP+pEu/bXi8CMeGm0iyRbUWKGgiwF9OTQ1xMb3lP3fS3vx5yy7ULWtKfYYwAP9XB2GTZeMHgjH9xeSQ9WRhfXacanykLDWrnyT878TujVVFxtvbl4OQ64EkKZ4ySL+EfFOVNLKxQeBM8YrqytULv15zrOQtBYKDeTJ0k8NWJnEwsjN5IMbLLJRCe3O4K+2GgtTgrBsjTwIf9KrnKONdMmXv7+oJ/RJW5S+gkb+KeuwX1Yn/VEHSFAxRylBLV/TERonsojgqpq2cReC++TongnGk4emSo1EeYAp+TuSstWONLpg==
Received: from BN9PR03CA0978.namprd03.prod.outlook.com (2603:10b6:408:109::23)
 by CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 19:44:07 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:109:cafe::4c) by BN9PR03CA0978.outlook.office365.com
 (2603:10b6:408:109::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Wed,
 4 Feb 2026 19:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 19:44:06 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:43:50 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:43:50 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 4 Feb
 2026 11:43:45 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yael Chemla
	<ychemla@nvidia.com>, Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Shahar Shitrit <shshitrit@nvidia.com>
Subject: [PATCH net-next] net/mlx5: Fix 1600G link mode enum naming
Date: Wed, 4 Feb 2026 21:43:24 +0200
Message-ID: <20260204194324.1723534-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|CH3PR12MB9730:EE_
X-MS-Office365-Filtering-Correlation-Id: 9092082e-f913-43c7-f6f1-08de6425c261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1kwSCvHEELMZepf0jBIzWV8BbHhxgEDZEWyQ8Jo4+CqGkj+VfIBOJp6Ahizv?=
 =?us-ascii?Q?XXySCbMa1+2FGAIVGsW63IymkriO8WnXuBCIkzCV7rqEhttmCProbx8cdsST?=
 =?us-ascii?Q?PBs9+IvIhDWjQQtykAGGTIGpVlI0oG9CrCQz+H+tAsHuLu8BDoU60YNtecoC?=
 =?us-ascii?Q?XyEmz9OLpE0fnKiVbjXPUgwJWuD8bZI9nhgx92WNGlRaAR3hiWAGomyiqIJn?=
 =?us-ascii?Q?PyiX3SKyL67dXtbl1bU+IioM2Ed68NdbD1hb0kAyRWgT4sKG96g0luNNQeBP?=
 =?us-ascii?Q?1AmuSRh4hmwdq+lz/dS6xs/xQEzjCV70Mmcb5FnVZLItpbwo+iBv4StE4Mwt?=
 =?us-ascii?Q?CCVEzKfotKT7CGJNxvO6U31kg6ub5b+eQT8WCS6zgu2YAwhZ9T8jREx+YEmr?=
 =?us-ascii?Q?Hw64oOnKpk2qau7dzKhnJO+K1O5fzReXkkJhCyKYjPkM5Mw1uKCgARYbD8ct?=
 =?us-ascii?Q?jfAJY3kG6ZLTgLZ4t3kmxtu/cUchH2Wp7CaOC18GB/os9QoM63RbPmmV4Q03?=
 =?us-ascii?Q?H19yzrPqd+fIpz9fFklpu0dcFvhyW+bYvvQNbEkoFo3OoCQZ3T5bA2C+80x/?=
 =?us-ascii?Q?YdknezmsdBffulJe1pd9Npke5f7cBG0WG44ocyXzFWSuJayxU4Is94s4Ew/x?=
 =?us-ascii?Q?o7MHGHpAhLlY3Jl/4AKYsupGzZ5nqgXI+Hx9lKUngpFOfIukT1EOnPeicAHR?=
 =?us-ascii?Q?0VLeIa/ULBIjmUIbbOF+jwvUFA3NXi/Le7WAdHM/lRFkY9DL3GQlvukNZZKg?=
 =?us-ascii?Q?PJyd/wC9W6/bM3yiADG2LcOxGVLtnAeJPsD328Cg1+E91uGKhxN6YVVAWifk?=
 =?us-ascii?Q?B90LFdQTChGMr2c872E6ClsV3z8Mdza7S5F0wHJaRpHRzuicxPUuUT3FrPqN?=
 =?us-ascii?Q?fw9WUr6GpYBZIbG3ePPCNpm64l8OQXhzRXt5wSlx5n1TkCGYAWVIc3WR164F?=
 =?us-ascii?Q?mYOHDOzHz+gyZbqPTCQPY8Tts3nPV6IzcpBEF5sti1GGR3sT/T7criYuiPzV?=
 =?us-ascii?Q?WH2gpcv2mPy0fAGpI+6hmY0sI9qiyb33vzEJuCHPIzSzVWhU2Il1YoXkc0hp?=
 =?us-ascii?Q?53XiNDQTC6ORThNx/UEgW8ZTo2/Qe5/bjH772u/4lmFibTbMlV9zkDnctjQi?=
 =?us-ascii?Q?stKt561037ynppMW8zzJq7xEl7/vUXjHxC9iHqgMgbTc5wUVdlTWCB7pt6Nc?=
 =?us-ascii?Q?BfKxHIYNLztjYixeTjAzlkfXOvf5KFSYjsQdz8ZrWAT4V4thqN1jLCDGwSUb?=
 =?us-ascii?Q?XgtZ0ZbIJ0Tg7cBpj7Lurpt2Lxh2NMKq41kfIKI8Xz56URsTvY0SUo8+ixTD?=
 =?us-ascii?Q?OlL9Ogm2MpgI3PJS3AbwV7pv7NHM8xVBglYJWaMvhKbWakleGxGWA11h5A9B?=
 =?us-ascii?Q?8bMjrZOnhZaaqKzGsWpPmV4RpxfHAiFDVEeN6RVXMx+Z75c5acGDj5eW6BsU?=
 =?us-ascii?Q?z+iRof48FFSlzbB22Ii1qVU3Oihi8mJiz9yLM0AmvnXgmxU43y7x6T6tEJzQ?=
 =?us-ascii?Q?MyLli//wLaUVLgx0e1zJMDUHrS4BSASGDIkcunThwNdHsrd84rjy2fcambJm?=
 =?us-ascii?Q?J8e3rDh3VL0OlHeqrXHhGZfG268zMiaSkmw1t9XfJcAGTOxoqx+CgEO0QEIj?=
 =?us-ascii?Q?bP0mCVoJUd2gO+ZBUD0DIzhMNQv1ymki7/HqadX+u9kg5O2KxHVGoCeLZyZt?=
 =?us-ascii?Q?j+CLRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WI4JL8d/dybfHE+OWs7pwiKRfsUJh0vgGD6fnZxxWFCe8YBFCV8Q8nQ4DqNLlmrIavEd+fN2kjydNyP398pJiifWD3AOOIaN4ERn7IMg2BCImO3LGSTe9sEYhraYYcPKUZv4935MQzRaTFQrzV7SZQpDPQeXsva4if9UDlQppixILEa/VQ25qL6653kUlL62x4d+kIKCOczFFAA9vrqyPW1zMFDDApMozLh+YSDHmHEYMP4UmDcIB6p228dvJiwzUDFLVKupQAozl//T0G3bIPGgBSNt+/0UTJNhk2CqZ9NhAfZt47sH3icnbAvPs9SarDh7HH4an1JWwO1HjY4rlnK+96LESg1oiQnFIKODTdq5bsKFaYKx+AQP1Gi2lXPbGnI9AtnNPVDMhkrrPwmcKFFCewn4AcPY2o+8bMIMs2UEP1sXpttEpoMsP1nVoT5q
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 19:44:06.9073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9092082e-f913-43c7-f6f1-08de6425c261
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9730
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16548-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DFE9AEC337
X-Rspamd-Action: no action

From: Yael Chemla <ychemla@nvidia.com>

Rename TAUI/TBASE to GAUI/GBASE in 1600G link mode identifier and its
usage in ethtool and link-info tables.

Reported-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c                    | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/port.c       | 2 +-
 include/linux/mlx5/port.h                            | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 40284bbb45d6..947faacd75bb 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -511,7 +511,7 @@ static int translate_eth_ext_proto_oper(u32 eth_proto_oper, u16 *active_speed,
 		*active_width = IB_WIDTH_4X;
 		*active_speed = IB_SPEED_XDR;
 		break;
-	case MLX5E_PROT_MASK(MLX5E_1600TAUI_8_1600TBASE_CR8_KR8):
+	case MLX5E_PROT_MASK(MLX5E_1600GAUI_8_1600GBASE_CR8_KR8):
 		*active_width = IB_WIDTH_8X;
 		*active_speed = IB_SPEED_XDR;
 		break;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index d3fef1e7e2f7..4a8dc85d5924 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -261,7 +261,7 @@ void mlx5e_build_ptys2ethtool_map(void)
 				       ETHTOOL_LINK_MODE_800000baseDR4_2_Full_BIT,
 				       ETHTOOL_LINK_MODE_800000baseSR4_Full_BIT,
 				       ETHTOOL_LINK_MODE_800000baseVR4_Full_BIT);
-	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_1600TAUI_8_1600TBASE_CR8_KR8, ext,
+	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_1600GAUI_8_1600GBASE_CR8_KR8, ext,
 				       ETHTOOL_LINK_MODE_1600000baseCR8_Full_BIT,
 				       ETHTOOL_LINK_MODE_1600000baseKR8_Full_BIT,
 				       ETHTOOL_LINK_MODE_1600000baseDR8_Full_BIT,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index e8a0884ea477..181714d37776 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -1111,7 +1111,7 @@ mlx5e_ext_link_info[MLX5E_EXT_LINK_MODES_NUMBER] = {
 	[MLX5E_200GAUI_1_200GBASE_CR1_KR1]	= {.speed = 200000, .lanes = 1},
 	[MLX5E_400GAUI_2_400GBASE_CR2_KR2]	= {.speed = 400000, .lanes = 2},
 	[MLX5E_800GAUI_4_800GBASE_CR4_KR4]	= {.speed = 800000, .lanes = 4},
-	[MLX5E_1600TAUI_8_1600TBASE_CR8_KR8]	= {.speed = 1600000, .lanes = 8},
+	[MLX5E_1600GAUI_8_1600GBASE_CR8_KR8]	= {.speed = 1600000, .lanes = 8},
 };
 
 int mlx5_port_query_eth_proto(struct mlx5_core_dev *dev, u8 port, bool ext,
diff --git a/include/linux/mlx5/port.h b/include/linux/mlx5/port.h
index 1df9d9a57bbc..12d366b12e2e 100644
--- a/include/linux/mlx5/port.h
+++ b/include/linux/mlx5/port.h
@@ -112,7 +112,7 @@ enum mlx5e_ext_link_mode {
 	MLX5E_400GAUI_2_400GBASE_CR2_KR2	= 17,
 	MLX5E_800GAUI_8_800GBASE_CR8_KR8	= 19,
 	MLX5E_800GAUI_4_800GBASE_CR4_KR4	= 20,
-	MLX5E_1600TAUI_8_1600TBASE_CR8_KR8	= 23,
+	MLX5E_1600GAUI_8_1600GBASE_CR8_KR8	= 23,
 	MLX5E_EXT_LINK_MODES_NUMBER,
 };
 

base-commit: 9a9424c756feee9ee6e717405a9d6fa7bacdef08
-- 
2.44.0


