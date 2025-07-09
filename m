Return-Path: <linux-rdma+bounces-12001-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3773AFE931
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 14:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5E71C81663
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 12:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4172DAFC8;
	Wed,  9 Jul 2025 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lzq/9oH3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13DA2DAFAB;
	Wed,  9 Jul 2025 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064962; cv=fail; b=LBHGqQmROIeIwQhuEHqKpbVBZ/cvu7nfFZMg/hwumbikUv5JxQE+EAuAFf3KDWK2Rsn2GSSvbPowYftZ2BWsa7zoKbiA6RqnWGLfY4mFO8BWklHTumBIwWqAdsC7ltuIQv/smLKSP6BjKTA+EB71E2JizBX5Mm1s8cI6YC/UJgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064962; c=relaxed/simple;
	bh=0X6ABIbJTJGfish9roIxAgG/hbLBRLsoazpAjPuSS3E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BYo02IiRgWjq+XDfkguvVS0i+xKya+rl8EANUodTyXnCOmxbkBYz+P4a6xWPdmDwZCmeIwCFVqhGtFJNXp5QmJbrDA2OPTpAS//spMiZ/fnZBCFZbNzV1r0bZXcFc01VaahnXTlcS0b0AnT8gDun5RBmnn0L83fbqafAGIKLQW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lzq/9oH3; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkRCtku18SIJSGHIcMDQIpcf8vjGKbqTGYts3pqQAZVKfLHIbipedCoyHQui+ghcnG8V15puE34JNBrKve7n81mxzbidBG6M1XbOxzRDquW+08Fvog+NarHWhZ//ST3uKSC7T6bNoPY4ny51GMGrL3mq8IGx/RPMQKwm+Bmfs9+7wGnhTCAvt4L64nBrkvRNFLjtvZaUapJdSHNgp8rBcR+2r+HCWPBoEA461nNqesrsGkcJ03c2VuPH7BOELTuUmu5HWwf4Du/ElRnDKSvCMyV2DVkJvZAg2MtDGeg5sFV1dnQMiQe1NFGp0ku3X5yKZzJQvvtVig3eb8KNcgmTPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcuPvtThsVLMo7pEIesAX0lEBEldE2vK5LfwGbFJkuA=;
 b=JsaYYLy870xsvJljMkbqA0VRhqkDVmjy6hfSuYDbZJAIXN5ZyeZyQNDhmILgS4YzyS672SUU+BA4Zg3bSShEqdaZ9PgX/xak0gMaTygNX+m9zt75Vfx68wmhEqL51/Ta90jHPTZ0FhTu20ENlpWE8ZM44lHmyqLf3vvqIeoFI7sfnqn0hpbJktiRnHvEcaFOSqBguSALxri01ypnpltETjsMjQ/2SL858lAVK0MmUZ+kQMOS3DWnZeIQPrSCy40LM6qBZkMcQ4S4d891iJrh5Nbk8Svl+B+xlV5vu7qTKx6eMhnjJ8j6ULv02T4kfGZbTUMVqKKFm6Wp+iootOFZ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcuPvtThsVLMo7pEIesAX0lEBEldE2vK5LfwGbFJkuA=;
 b=lzq/9oH3BKCwBjA7aOhZv1LmgFmkCMWauIkwUJUoQMZBFKLiqjcVTLAeyme0SCgiI5k5lXxttphhNCch2KuNGFATcxEXQBNPzcq1pwmkRE8zy0Yqvmc0k897fOCkmQZHeyxA+xlJjtKMn6Jb+MVtnxRo+J4t4w/h/ZOWZT9J2OOx7U0/a3azjlvyuGYuowE4d4ZT4f525zQJOXIC/CI0fXETrITN2dDY8/oqkiyc4/hUZxt7aGoY2NpkzAKKX7C1Pi6m1K/kTRpWGz5brjKtZZ/M0in4QOD2SSbCFAVYgkCqsCWfy2vaNvUrB6655nSWe+Ht2L9ejCT5RqIiorgjVg==
Received: from BN9PR03CA0892.namprd03.prod.outlook.com (2603:10b6:408:13c::27)
 by CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 12:42:37 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:13c:cafe::a8) by BN9PR03CA0892.outlook.office365.com
 (2603:10b6:408:13c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Wed,
 9 Jul 2025 12:42:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 12:42:36 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 05:42:25 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Jul 2025 05:42:24 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 05:42:21 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Saeed Mahameed <saeed@kernel.org>, Leon Romanovsky <leon@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Gal Pressman <gal@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH mlx5-next 0/2] mlx5-next updates 2025-07-09
Date: Wed, 9 Jul 2025 15:41:05 +0300
Message-ID: <1752064867-16874-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|CH2PR12MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: 0569cb9f-28bc-4c05-5477-08ddbee6155f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1ZxMjJTWis3N0hNU1BoYXVQTUZBYTlJazJab2tIMm9peUI5aXpmYkpmU05H?=
 =?utf-8?B?UUwwZDUyRDJDRFF6UW9RUVNUYkVhT3VJWkVDOVRwZDBjK3J0UlZ5Z0pXWVJV?=
 =?utf-8?B?L1ZSY2pqNC9mcS9xZzZIbzJsQjU1ZFZFbFEvWlA3TWpaYm9TeC9uNXhHUWtI?=
 =?utf-8?B?M1pQMzR2aVRvcVpXNzRFWEJDWFdaR0E4cE1KK3d6Mjdxc3cwUjAvbnV5cVR0?=
 =?utf-8?B?N1R2QktPMWs5WDFRMWRqa2o0bWNmelZwaS9oTDRLWWZnTlFVTjdMOXpnK3hP?=
 =?utf-8?B?Q1pTK1lXMVlhVUlzUjRmT2RDTW5nVTVwWEhCN0s4c252RzFkQ0JxamF5ZDZT?=
 =?utf-8?B?MUF6YVUzME95NTgxekpzQ1paNXNQNkhRR0ttZzJVQUpHZzdDVzA5ck9iMGh5?=
 =?utf-8?B?Yk9pMW1tSEhoc2hoRHNabEszbUFXZzhxVnhYTG1Ed2dSa1V1VnQxMmVlVnJF?=
 =?utf-8?B?MkpNRUJBTlB4UENkNm1KWGxWODlZT00rek1leHhvV3p1LzN0NmFqcHNyWnZ3?=
 =?utf-8?B?WGQ1TW01YmpKVHErUXgwZDBac2FWbGFKRFM4NE1wUGJGckl5RU8rYlVMeEFF?=
 =?utf-8?B?R1JoOHJVNkl1RzhDc3ZFRnlaVitseVBvSnUrWXU0QWxzWmlGNE5xcHBaSGNh?=
 =?utf-8?B?eXRjcURIRlJaQXZJQzR0ZDJBVGRLTm90eTVuazNUM0VxU3hLaXF0KzFoOE9z?=
 =?utf-8?B?VGYvME5OM3o1Uld0b3B6Q2dyV3I0Q2Y3Y0Y2TEswUGVPN1FLUVhxeldwRHBh?=
 =?utf-8?B?RFVvQzBOcnRvS0RMZkduQXF4NmxWRFdmVmdaaldHZlIxUHEzb2hkMDMyMzA5?=
 =?utf-8?B?N2ZyV053WmJLallhaHlWWDVmYzIxdFVVTFplaWFFL1BQd2pBS1lYbmZveGJr?=
 =?utf-8?B?WitZLzRrY1NyTjIvM0tKbzhwdGoxWU9TWS9JaHFNY0tGUi9LYkN4emlEbkVr?=
 =?utf-8?B?VEtNWXpSWkptb2VMWFNpQzk4VExSVmtNTXpXcnlnZWN6MnBEbU1uRTliSldx?=
 =?utf-8?B?NHR0dnJFWVZrWkxldFZydldqV28xakZMUENaS0RZRk1UeVRqZmlFamJ2dUxB?=
 =?utf-8?B?ZFRjekRFQ3pweWo1L2VDWkI2MmxxVkNGZkpvRVpDdWwvbFlwUUtDT3Z3NjhJ?=
 =?utf-8?B?R2VMdU96bWNSbWVWREgwZGg5d29jckt0L1FqRmNDOTlnd0VVeUo0MWNFQTQ3?=
 =?utf-8?B?bTB3OUFmbWQxS0ptN0xZL3ZmVFVwbTBkYWk1QWZUbnJXc2p1UlBpN0phSWgr?=
 =?utf-8?B?cFRxSi81Nk9QaGQwTFh2VU0vMVZqMlZKOXZleHQ4amYyb1Fvc0U0SUZ6ME55?=
 =?utf-8?B?Vjl6emw2Q0ZIZzY1eUdFZS9xWU1WSTBOUjdwK3RGdE9EZmEydjFvMDA1czBr?=
 =?utf-8?B?V3FZUXAxRTFvcE5Pc2UrWmRTRTIrY0hZWEQ2ekoveGtRdlkwdWo1ZW9Jam8v?=
 =?utf-8?B?RWE1Mm9rVDdPWVJuSytZb3hKS1NBUHdQWHlWcFlaeGw0ZFNtMU5qUHl4bzNp?=
 =?utf-8?B?SkNWY08wNU1lTFN5YmRXbDN0OEFGRUxSdU42MFYwSG5rUWtjM0JqNXkzOEpO?=
 =?utf-8?B?Q3psbEprRm9aTjJlWkRzWHBpODVJa3Y5QVVLNVdyYjNlQjEvZ0pNL0pLTlFx?=
 =?utf-8?B?emwvNTRqc1NFSVlyU0gvaElhM0lpbWxtWmZSYllaemU5Z1NQd0J2VGZIUjB0?=
 =?utf-8?B?RmlrUm40UXNqWXNoUWV3U2l2YWQ3VjBaMEhKa3p4RXkycVJkUkcyYjVlWVVV?=
 =?utf-8?B?MmhnV1ZyREdOa1BvYno1aGxRSkhaTWhTNWp4Y3hOVmZWM1pwa2tTWVVpTjM4?=
 =?utf-8?B?M21rTGZvYlhDRXVUWFNGVnBEamxNaU5WYWUxemw2ZTYwNGxyL2pDa3dQc2lm?=
 =?utf-8?B?VVJuS2JDZ0VoUUNDNnJ3a2lEM3ZMWnpmUTh6ZGxMWHJQRUNBRmE4RzF1UWhV?=
 =?utf-8?B?cTFqUjA5SUxJanl0VWZWVTNXZGF1QnorTFJsWWtPZ3JDc2RJRlpKMWJSdmpx?=
 =?utf-8?B?NGZoQjlyemxEZVJaRHlnNkxBdENYR01ieTdwdVZjd3ZvMXo1YWZTclVtLzJQ?=
 =?utf-8?Q?38eAzi?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 12:42:36.4892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0569cb9f-28bc-4c05-5477-08ddbee6155f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103

Hi,

This series contains mlx5 shared updates as preparation for upcoming
features.

Regards,
Tariq

Carolina Jubran (1):
  net/mlx5: Expose disciplined_fr_counter through HCA capabilities in
    mlx5_ifc

Daniel Jurgens (1):
  net/mlx5: IFC updates for disabled host PF

 include/linux/mlx5/mlx5_ifc.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)


base-commit: 70f238c902b8c0461ae6fbb8d1a0bbddc4350eea
-- 
2.31.1


