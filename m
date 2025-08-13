Return-Path: <linux-rdma+bounces-12711-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C41B24BF4
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 16:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C7A1C209D0
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 14:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FAE3C33;
	Wed, 13 Aug 2025 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QuBuYccl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F50E552;
	Wed, 13 Aug 2025 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095520; cv=fail; b=hs5TdvGcAxoJxcsJgHrEtfoSgoeMVKA60Xv7vuCv8iamWTPz+0T1Qx8KujKlw8sNzphgkQQmMFd1iAaM0OLRD7+MzgQCVTi6KhRKIZ0Mgoy0yGSHw85/DVr2pu4FqkkYmxPR+HNN8ht4ghSsbKw3qvBeCTxkXIcFJNoeckAX8pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095520; c=relaxed/simple;
	bh=oWrhW7Z6CSL9+xEDcytcsAKxpdaPnMD/2g9Rj6jckfw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KzsL7+zspvX4J2v//gsbIhoqJldbFzQWp9CiwNsj1UB1sF1XgTZHM3K88ddCHNdIdBxRMtF8PSZdvs1Asg5gBcCDUvx55RWjsjEi5PMY0m/71RT9Z2bZ/VRkVHqwP8cOahmZIkcogE5SjX0BeOwZs00xt4QaO9R2fWozGlOGROQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QuBuYccl; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFH0Mi+tdIcmuY8e2okE3q1xwu+gyC2FVMe081zey91NUCrhAPJaj9Qu7VIUbkP5Xc5pLCOKNI4Hgr8fE9JnTGkSuNrexBKRpKdJWC6VZ31nECNxHDEjLUed19pZKQjh4YeMAan6bdeZEbw3lr3mQ2VOyTMOXqmz1sBasjkpk4hW07QHy4HggNX9PRVTbdvpHbmyAVZQusT3HoKXX7dgmK8yDCXrtile5IW/88F80jNO9NyTOdkdwG39dDv64dhOSNWD8RA3EN+TKk5e0f78oK6aIOvoQXxFbHvyzzPBcPfzdDYAYLP20IrdeRS0bC9zvxscoKd0/MLzvGSG2ihgag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RLE7AT2NLoKCxHgiNLHL8LW32EZsMgfQN+dE+J/00c=;
 b=LQGDdsXVh/HCsR3fK3YM3L32tM5QtMT2WX87l9opgRKDzISDejrovU2hv3xkhn9DlAvol0hlN7gwdc49/MifUpINIdfFoFVHOZ+on0s7lg0BYbn/5VAskCdzzm9N1fiz0EFYiZsJwvNz/zPMfe1Ibs0KqDmZqtwYEmwEoLY1GNLNRZO9GvdYTZfPV9quHmpwdB4UDNkr8Vy9+evq2LkrGMb7x436DvdJiVF6c0Osmj6o0mleqeB5Q2HTSpMAvqTlMJAahm3SWgg/BSbkfqUtsrBbUuTGAjnoa5QE/o0Mq+no1o8tqDSsp3rVb5S1XREdSpm5lo55Nca8fMZhgKihEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RLE7AT2NLoKCxHgiNLHL8LW32EZsMgfQN+dE+J/00c=;
 b=QuBuYccl9/fEODh5opdQEujkFTNadfK5gKkvqrvnrSxyeRyBduBBtQHA4aSJZ6bBZrD24ubp1KTlZAqqMhGTPLAsX6rDunPhJVJxGjzbMIl9UJgTF192et6Rz6wVHVZFnC05j/BK/xR+m3zXqhigPaMPYEUjnnuxPTxX3r57JQ8cnHqxIho9+ZiUGzWSZgX3p7YU4+xFUrOMOVQ1YMaFBDJHHJJNMSAaFKGTMpn9fDgpaFxbSz1vngj3YnQxLcAjqqyYD9q9R4D2eroFc4QXsXhs/tTNRYEPs+1QwzsDFEsTkUXWm/ZMsWgjF6fuyHpE123BPJVZ/NAiROd2vHFV2A==
Received: from SA9PR10CA0029.namprd10.prod.outlook.com (2603:10b6:806:a7::34)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 13 Aug
 2025 14:31:55 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::b0) by SA9PR10CA0029.outlook.office365.com
 (2603:10b6:806:a7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Wed,
 13 Aug 2025 14:31:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 14:31:55 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 07:31:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 13 Aug 2025 07:31:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 13 Aug 2025 07:31:37 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net 0/6] mlx5 misc fixes 2025-08-13
Date: Wed, 13 Aug 2025 17:31:10 +0300
Message-ID: <1755095476-414026-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|CH2PR12MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: 039c0ac1-ee0d-4e1d-c7e4-08ddda76272a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fmtHf0LDTGYywBP40pqovsJck5zNBMzJe3ALSKLKCiyxhd5ZjZjT7D3KrWkq?=
 =?us-ascii?Q?49G3/QZdtgNfAb94GQvBBiScLakNQRxdSpg8A7jd+1/TazaxXW7J3fpRVwTl?=
 =?us-ascii?Q?BmuzCsFrPV2NGu1dIn9HfkMZfyBS7bdLjWYjFLP3f7mFuMwT3pSIKlRBgVEw?=
 =?us-ascii?Q?gXfo8QHz9zXYiHEzfC132HPbCeFYuZOIC91QozzfoUvmTE0nDifQK3UgFpEw?=
 =?us-ascii?Q?41bNy6OIiA2LqrEoG8/ixJo8BS1k+OXcheJ/C+kUPAFE3lZWre/XOW9Azzar?=
 =?us-ascii?Q?oCOaE9bbnJCul9q6qac69ofPOhTYGjW+EP2bJK+6OLjYApk6RgUlTVnmvLDk?=
 =?us-ascii?Q?V04F54UYg3J2XMC//9ROvQUDc0S9jKDwB+uEz55emqdkt+esUEzC1si+CRMT?=
 =?us-ascii?Q?zwL3HXRmmex853gTM3oHjJ2oUZULKPNDP7fmiI+lFgiupUO6HQHGDHUDAfsI?=
 =?us-ascii?Q?vWOmjpLOlMpb9X7oQ2niVoHiBdST4ioldL+tJSa+TwAsj4IzqNChyVbSuQOW?=
 =?us-ascii?Q?Pm8fSCiaKLoGcc+d0nvECpnyiI/11VEAbQO4+xCGCYDMoM3b9dEEcP7njDrC?=
 =?us-ascii?Q?LDEva46gkQnARfMfJ4rLWMujVWme9Dkl1HPTBYtc0lwkqV/5jB9PP5wS6HTl?=
 =?us-ascii?Q?0CqydaOcvyBMjN/JaKT3Wu62+b3p7fTftN820qMSX0Sh4CnJQGum8M+u5qjr?=
 =?us-ascii?Q?MyyEmErzkxT1sIIAtNeEWPxh4DA18j1Hs/aD3eGYlYcAaho8a/NypQ5nLfSw?=
 =?us-ascii?Q?7pbqT3D+QcmzAm/SYVX+iv4UDQ5QUqpD3cKvmMnLZ6MYjxtSK9LZu2hFtmLQ?=
 =?us-ascii?Q?qK1epI7b1N4Ua0l7kE8dXIXPLUuCTBsF1SYPANYOilzWma9s8gKWvO6pm9Zw?=
 =?us-ascii?Q?MCCX4zQWcFVzBzkQsQ0s0So+FJP1/VBinefbtcbA4cC9PQ9Xma+alV/KmW+k?=
 =?us-ascii?Q?MnAxK3bAhEb/FBk0hb/Em3ecyceY+qq74V7gi3uuirptrxZKs4hVzRs5XtwB?=
 =?us-ascii?Q?w5VkKL4NVwuoETNktNB8xy/0EU+jbrQBp2jT31yn2yn78YirzNsI4PYBXWf8?=
 =?us-ascii?Q?yzupPifu9FuFzi4o1qdlP++LsCOJ89CHqGegffc96iD5qup05+VLjtK2AJtl?=
 =?us-ascii?Q?mlYCxSPo4FP8mfJnjVC+7vaElT1beow+ZYYaWcRE44Tsm4uz/ErFRAZ+z3fU?=
 =?us-ascii?Q?gCWUxQBVWOBVlBI2YPjSx5xWIvUzSTo5+LHgOtEgYP7CddUyeJlTpWJs9926?=
 =?us-ascii?Q?pccn1KUUJuIiM99dSg2GucawgBz/ltW55gs9ma1ggTzclThHUuwuYxKrmi1q?=
 =?us-ascii?Q?FH3wTRSBpvykeNkiQaOK0osDH0w4CDL7IPdBnbb6VDjIfwU4fsTZgiaoFpme?=
 =?us-ascii?Q?WfysbYbYpP70DPdx+dgfyJ8zRvZAMpNli2ROHtRUtNKfRztOU0T+FJB/pW+0?=
 =?us-ascii?Q?p++uIaN9yr/fsswRXk9V9/4Nk4KNGMt0v2RH5ETXyU0jXDwWqEuul6TMkbsI?=
 =?us-ascii?Q?74bfFBcGUb/k0rXibfqOuEjfrV5kC2nZDvxM?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 14:31:55.3317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 039c0ac1-ee0d-4e1d-c7e4-08ddda76272a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231

Hi,

This patchset provides misc bug fixes from the team to the mlx5 core and
Eth drivers.

Thanks,
Tariq.


Alexei Lazar (1):
  net/mlx5e: Query FW for buffer ownership

Carolina Jubran (4):
  net/mlx5: Fix QoS reference leak in vport enable error path
  net/mlx5: Restore missing scheduling node cleanup on vport enable
    failure
  net/mlx5: Destroy vport QoS element when no configuration remains
  net/mlx5e: Preserve tc-bw during parent changes

Daniel Jurgens (1):
  net/mlx5: Base ECVF devlink port attrs from 0

 .../ethernet/mellanox/mlx5/core/en/dcbnl.h    |  1 -
 .../ethernet/mellanox/mlx5/core/en_dcbnl.c    | 12 ++-
 .../mellanox/mlx5/core/esw/devlink_port.c     |  4 +-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 78 +++++++++++++++----
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  2 +
 .../net/ethernet/mellanox/mlx5/core/port.c    | 20 +++++
 6 files changed, 98 insertions(+), 19 deletions(-)


base-commit: d7e82594a45c5cb270940ac469846e8026c7db0f
-- 
2.31.1


