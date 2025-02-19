Return-Path: <linux-rdma+bounces-7826-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BDCA3BD2C
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 12:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09EF9189921C
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 11:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE921DF251;
	Wed, 19 Feb 2025 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k7Cobr4+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D831B85CC;
	Wed, 19 Feb 2025 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965369; cv=fail; b=EdmCRLYIK0Rj4znbMaVHN0wYXdmqi/WrzYvXaIH4FUdHBIexfTjl5SH9mxj0EhD/MX8FwUtape7jHrcNUpfTDDgV8SARWSC7kLuExzfJvxetmmLdSWmM8qnxp/ZONIN4cddbA54FrqteX1DLsYvLuM08U8vnJuDSJKTYKuYwx+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965369; c=relaxed/simple;
	bh=GkPUwfjadBGGo2twl5mPl0ywJ5f2EyfRfLCLEXFilyQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ePHF/rChKJw5ASTJ/E1B/jwl1IrnI4CJlPPxPHTHXgzyunkbYKXgSApu80BwZPgwvkPgRFNnrEWs9FTwx9TXGSHbEbSxFIsXhv2j83jL8SKAGd5Vw1E0zFEE80mLfJ7q3jyIVntBYHmgCDAG5PHq/itmrybYd5ri3e3zm+rTdGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k7Cobr4+; arc=fail smtp.client-ip=40.107.101.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbQxBf9p1y/F11UC1f3rjZa3b1MGTmOTDzWANpgpJ53x8sIrBOUEeTu05bWccOU0j1nluk3ibPuw8kTRM20kKLdi5eGYH9HagGYDTcGaCdaklMoSVs2rrDu9upPP+5DjBkd/U2xUfk507YmUJq3XvUZhBRHdswHrmEXfCP2MMUzlJyUrZba5PGikZoT7MltLGHT9KNqmgZVcGvn4Jv6iG45DEFvTgDKJlY6qpCyFe4ipTg4U68HD+3FhKqWgL1U61DOFqrCxvmyTPi6lha9QKUVFKbKd+hUzKNgInhG6Auj7s8DJKIMts94iw5uXvFxNBYDUFyC0mfMIEr7H3g0Duw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U25dTNYwh2Re/q0Pk9AnbqGJzho36MNKBy3e58oJ5z0=;
 b=lOEkODsk0VepKlmX7ap4xWxwzQziz+3t4AuXxnsR/AkBt9TNujIi83HOJkYka3x9scKcJU+TdfvbGmh9l00yxnRdATcl0mvZBUR9xNAb5Z9Ft0FMUr98iHoryIoHQwOZPHRuwqUaV/QY2/a7RY4LFaeOQLIbDr2+NCmRzcUbfOxsTiduVVmY8K00uCcedIXx3suKOxXXJb11o354EDgUYTFw49sHmT2JSDi7n2uvfts03M4SuP+MLxIAs7dOV6w0aeIzqzLVq8w2pw0D754sTtcoArjY24oI0hf0W7jAGASq4eqFGlSRQOR8jqlDQfn1tj+c+sYrVpcwrNqbxX8zRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U25dTNYwh2Re/q0Pk9AnbqGJzho36MNKBy3e58oJ5z0=;
 b=k7Cobr4+t4D2M+4deot8pXRI1nWvGnZdjqN9h7Hnw1yJvHHC8jTi3KhHUHBMwr0e+7YxXKS+bc4EU93UJK79Ev3jOt2L3j3HD1JE9C7GYE5oPrulbw3675suloI73d/UD+Ieoqjrhxw51Qli5QzQmaeWq5cQjtVkJYguMqJTdM1BAWNfr+HKs0dPN02fVjtYr1t3SptRUpwRfcW7LV+8fdCJwx+GD4ndMr5yf+NYwr5AlEZjV6nZ1NA7dVsZ2Mp6ZyZBEbS4MxeBQupETMJ2lcYMTPR98o4ptq76N0A5zG/I5Uod16a/MY8vc2iywkG/6zFgPgfqnxiNKjywG2092A==
Received: from SA0PR12CA0024.namprd12.prod.outlook.com (2603:10b6:806:6f::29)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 11:42:44 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:6f:cafe::f5) by SA0PR12CA0024.outlook.office365.com
 (2603:10b6:806:6f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Wed,
 19 Feb 2025 11:42:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 11:42:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 03:42:31 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 03:42:30 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 19
 Feb 2025 03:42:27 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/5] mlx5 misc enhancements 2025-02-19
Date: Wed, 19 Feb 2025 13:41:07 +0200
Message-ID: <20250219114112.403808-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b7e4bb-152a-4522-e989-08dd50da8657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DVTVgX9ObdKup9M+8kL7KQX7s8VbYcU5Tb1c8U8jF29dkdam5XCQekak+GvI?=
 =?us-ascii?Q?F6ZFUbobdJTQnUJRn+zpfFfzhvgKTNlY+Gw2+HqoCRi15bmJRXnGOB4Y/XWg?=
 =?us-ascii?Q?ob5PFVAfrMkz7v5FGf6D8jCLL/GI/R4U45LkZLxlfQUB4TIlts/rQk8dpUEG?=
 =?us-ascii?Q?aZgyfLKPK7aGHejM7yCHysspm9CIduX1RnKbrSsY3N9mtuH371RJZ7Ghiy+3?=
 =?us-ascii?Q?cFpAWyYq87ZMq6KKJ/CWkCtWJo4hzselu9CRI4wliwYcNCv35nyyzRRKQCxB?=
 =?us-ascii?Q?0Wj5npfdBS8POQZ/8Pchk4vPaR22T3Yn5ynClIuv+/LtusR5xDf1ffBbu0Yv?=
 =?us-ascii?Q?r9y4M/nKAdChMNIsczAYcEhfKThbzsx+C7q+eMi90BEWQkmppkgJCuz9vLi7?=
 =?us-ascii?Q?2gShHth7TAx4UU3Z2rcfb879L4gy4YgkAvv58p21tLv/wmhgKD3Z3EakpJ1X?=
 =?us-ascii?Q?QNCOVJbrs8BooPXRJE1hVIX0QcDHqE0eel8nheuAmt67KWqViRII++zfqo/Q?=
 =?us-ascii?Q?haQhBugGbarKB8WQQdgrOe7aCRd/LxxXwJch2u63lS4JzbxBokj6baiPSEBI?=
 =?us-ascii?Q?fXnfEEPKet/uWTiQLR88omdIyp/Io7/nBsSLAWWBdH5W9pOq+1ygHW2WjyDD?=
 =?us-ascii?Q?6xG8LhAxh6rlVGK4N7GFzV3gBOGx8MThAh3lIpf7r45nIMo3S3qo2hH1OttM?=
 =?us-ascii?Q?FcvKARhPhD+jUR5TM3yidtBhagTAvRG+Sj6hxc4+jsEf4UM9JG0qTCMIiXR8?=
 =?us-ascii?Q?D8UR+dZZSaa0HN52hN6mKt8+cgibcm3huKRBHS5Pmt5AlNa091w0U+HCStZR?=
 =?us-ascii?Q?airP44iYLUkii+g2QtGLFbWE+OWd+/nLJpaJ03zbUSDUTxvOj4hGcW6u+7XU?=
 =?us-ascii?Q?Z/Z2sviFPeKq8oQ4ZT+Hp1eHdh3BNbhkZQGqrbmowwVT1mfwJo1Vx9++YqEw?=
 =?us-ascii?Q?/y0+vsOB0tskqaDbHsusAJ1agyOYvxrLsT0uSA98t6ACXs/yD4+xzWupGpkv?=
 =?us-ascii?Q?XXHiQXdIAu3kq3R+gE5CU31N0ylOXBn/7W2GQtf2kyNFnXitlN+8ctLw38Ar?=
 =?us-ascii?Q?1CerIEYlmrjzpXM8ziblfM9xRIJJBHCx08vaNB8l569QsU3qCFpvR/92bRRZ?=
 =?us-ascii?Q?DRkWDmJT1jXRh13yONm1AGXYJTzKhRDiKraoNue1UVxVscBPtyYLILXh8pWt?=
 =?us-ascii?Q?hOid0saTAYqCMO0oSg7DxI8vesjRnfYlAKRCk04ygj3miNXdpQIGUiIcEzUz?=
 =?us-ascii?Q?fkt5L2YL0Pb5afDX+odkJFoBuD/80kYhjftgDr12sqhh9EtZdB48cvQfCDS+?=
 =?us-ascii?Q?/lG+GaUOVkVgzY79o9juQANDZw7jcwcVDqBs4aguqbYUbqdXUoXJV1yIEw6l?=
 =?us-ascii?Q?zZZdFyCVLsuKqqUgCjfTGgzLlDJ9ApxFPGEacCAGuK7dEmFoXhBwInuGN9bb?=
 =?us-ascii?Q?eXqy8Sli5B91chGar17avnie1RN38dbcWTjwPtkBHXfn/I2irgM8R3wBaUbh?=
 =?us-ascii?Q?a4mY7syYjiVmvCo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 11:42:44.2229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b7e4bb-152a-4522-e989-08dd50da8657
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346

Hi,

This small series enhances the mlx5 ethtool link speed code (no
functional change), in addition to a Kconfig description enhancement.

Regards,
Tariq

Cosmin Ratiu (1):
  net/mlx5: Bridge, correct config option description

Shahar Shitrit (4):
  net/mlx5e: Refactor ptys2ethtool_adver_link()
  net/mlx5e: Introduce ptys2ethtool_process_link()
  net/mlx5e: Change eth_proto parameter naming
  net/mlx5e: Separate extended link modes request from link modes type
    selection

 .../net/ethernet/mellanox/mlx5/core/Kconfig   |  4 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 62 ++++++-------------
 2 files changed, 21 insertions(+), 45 deletions(-)


base-commit: aefd232de5eb2e77e3fc58c56486c7fe7426a228
-- 
2.45.0


