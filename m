Return-Path: <linux-rdma+bounces-12101-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4788BB0360C
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 07:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705063B119A
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 05:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205681FFC5C;
	Mon, 14 Jul 2025 05:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TN82vm4D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A1A1E9906;
	Mon, 14 Jul 2025 05:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752471655; cv=fail; b=EtUbpZAx/UBfRfxQt1OWSkN4ysH+bjVhxYdAQCeEbqScdDp75ebZsWkasHxZoc96RTiOVWoySNNgRySPAWcJPHL9ubhsZSpoOgwUsVbgfaz64v5dVZPTE1NhZyBdKZz6v8fDfLkrdhgvlt+xhBHcJWwHPOBGcI/2P1DTfOK2S+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752471655; c=relaxed/simple;
	bh=Ncv0T9y1aXLf/MscKUZ4koAeSJv9uhu0WZCbqgOHl00=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JzpJvzxxlghj26/5eaT2t5T3vDMdYRWwHrVBPkdB5OHRfpjClUP/ljSoX6f4SfF8xFIieSjE2FeU8x8HA1ttuii8EEwHNlX5s+hA8e5LQCP2WjtJYW2YDD5eDGKozLuGnKeRZVZdBP1wuFWXe+uiitoRNru5gAOl8CBn9nTFAi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TN82vm4D; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7MRKiV3kXZ12N1AQScwGIxIro0W6aXRcJgLoqbi+mNPkDr2mq5NGOklYCwVyszDcNm2OP7ifOGgkTLn2yv21AE9Tw/kT6HmViQRVU7NMue6bPKvOJ55BBTDKPxHMJfMyu2OmtqCCzr6qAyG2X7VjCt9dBph0GrVzPuZO6OrFWKWcPXB5PvvUas56kSEOWFLN1fnOzV9qBBrGdRP46LFIolRoekRNU3Fq0N7w+ytNwmKbZ3M1lAUJteP9v14FwSvvjJf0xgspVJRlM7zwyclV9DBvzgvcYzyL99TZi1ORKVQZbFO0oV4nipvDqfHRCGSWgjhc4appruD4WsskyhKfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKpUeH6u760FZOwDML2WxgUGF8LJIt0dYxt01yjFnk4=;
 b=pdz8gCdiUCmen73eTLtvUIRPJDh/za93YIF64w9Mc2jO2AZrwLMpWcEBsrOod5iv2L9Lz9NG2EGhnBrbLVAwmK3sW0ISzOHn+f56IlWL3wzRGO37FH3oldc+C2w4fwZf4PfWfyvX1aFZx34sCT79+sNbqGM/pbyEuSd69TNY0AfQcLvMtkg3hB5HP9JG3/9pq3thd95Ck0AavolHVP6oeefH1oUV1JktK3JgrdnutQUX12x1XyCK6WPw9mm0uwHWB4eNcLZe1YjovtJUkTVLih1fMIq24KEgt9JVwTLC2U2Eyu+orEY4jILe1KVRG1dPzbqnv8zPcMVw8aHqr0pAJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKpUeH6u760FZOwDML2WxgUGF8LJIt0dYxt01yjFnk4=;
 b=TN82vm4DtLqk7XFsFXDjU6ja0inbt1IzzwAOjAt/5uGuUV/9JbBhWMWML13KwzBJ5SY2aNy1EyKaT0U6B+dNWNjFsgCf9iWIUh29vlZhEwP9C1KqUjRzrmY4APtDqkPOvMqeMDSM597Bh0poxmKAz3EiYJd1uIz6GmiGXlgrBPeuYbFmLPkMzpNwtPadeUws2bb+lht3nvDWTobmULkjTyqHLpMeQuekcENkfh6zWBOfiw6d1/OYdaUQUIJghdAWC1fpKY7jRabQZ1WlRHlgwAWFmgurX5LhWFpwk+R6mS/dGdnrDV4KoZ+tAaRGW6yke+PsO9RUDKGSEHu9XUgLGw==
Received: from CH2PR03CA0011.namprd03.prod.outlook.com (2603:10b6:610:59::21)
 by PH7PR12MB7113.namprd12.prod.outlook.com (2603:10b6:510:1ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 14 Jul
 2025 05:40:50 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::3b) by CH2PR03CA0011.outlook.office365.com
 (2603:10b6:610:59::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.30 via Frontend Transport; Mon,
 14 Jul 2025 05:40:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 05:40:49 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 13 Jul
 2025 22:40:36 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 13 Jul 2025 22:40:35 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 13 Jul 2025 22:40:32 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/6] net/mlx5: misc changes 2025-07-14
Date: Mon, 14 Jul 2025 08:39:39 +0300
Message-ID: <1752471585-18053-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|PH7PR12MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: 19abb78f-e64b-4792-72ee-08ddc298fd78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+X5pHtWjljtag48IVFIZSvXr+kA0LZumwutWxUNrJpycSspPY3D9ffW8jcir?=
 =?us-ascii?Q?vLnRIWCTyHi4TclKKineXfoyyhnHnejdpnZLoAfe+EExnFIUM9HSJVbv0cOJ?=
 =?us-ascii?Q?9GSbeiW5HPKmVjw+u+kDnw0OADUBzRQuC04xOzkc+kggfVC85sn5S5YoqJpW?=
 =?us-ascii?Q?qFZIukdJN89mxR4cLByj2FfjXYh4WLTBIWK9DXvcmRTb68itXjIg1hJFbWnl?=
 =?us-ascii?Q?pBTF2M/auAFD+v4bZyAja3mSRDnPAJZnaW7VNS/LkkLe+PPMwDP231o82mm6?=
 =?us-ascii?Q?HA0VGO7qVrmLIgM2OT7BjbBZvWkajT0ocq5WMuJxwLM1D9rMG8y0BhsMbvOR?=
 =?us-ascii?Q?txnefeUtXERUgtpUCESw/EDATMXXcbxupH8mym1Zr3ZpDtg6cPyQym7VO3kT?=
 =?us-ascii?Q?O/3uHOGK7tHH8oC9d2jgumLseU7QwKmYu6uRsI0UXDLQkjTU7JeeiB/fjA8j?=
 =?us-ascii?Q?y52sYjpRQdQyMLSfZCR38oZqXE7TW6IUJ/Zy/2J3Vz8IYXVGWNYThHtMhyfi?=
 =?us-ascii?Q?g4Jg4yO6O2TSUR+c+90pP6vfaJLRAAtHXWcPuJWA0hNSJ4vU1rJXwpDV5l9q?=
 =?us-ascii?Q?OdHnaO5iapV4RVp3ENXJ3jrqZgGBe3JS+4nC+49IuOxZJRk6NI7B05WaNSB2?=
 =?us-ascii?Q?r2AvdGtEj+ROInZdhjm6HMJe2kJ4wjapMJfJ37yl8UR5wZiEhsdtRVS+B41a?=
 =?us-ascii?Q?yWLWNAL4JyfIrzf4ciSM+rBNMw69rxxkCgEO2Loua36iaCJ5Afx8UdTmmKD6?=
 =?us-ascii?Q?zE6ClEUmlw1+cSSkQFyhJnscwZViZcOi0NRfF4XAxSxSA6nqw+RN0Kgrrvh8?=
 =?us-ascii?Q?2wYOs5nlX2q1s8VT9+z71keh8SrhytDpMXEHHQfoxhbY+v85vjaRxDThO05k?=
 =?us-ascii?Q?xSLh4FilPojzBQGw7SL46nwzOAOZgJfr69+fK9fov0A2LpOJCgsBLY9Eme56?=
 =?us-ascii?Q?qoS0b72y/rH7o+mK1sBfn0vRRy7/W36FJDH8MQv4apXGkmhZB9Ixj/Bpg+Zt?=
 =?us-ascii?Q?68rh9SEbG8PvG+EJlgHMtEVf5c3ryZjDpBYG/6zYhgdjNW7Ow526WiYspQ2l?=
 =?us-ascii?Q?alpo6wiGwEMVUypMIQ19nNDcxAnlGRqlz56A8iEZn951+zE5eWo7/Cw5qpRL?=
 =?us-ascii?Q?jmoSG/lJLzKD/0jtlYjVL2B6Vy90XY3i4aBTukHo0JxmtDzFz2Q+X7n+dcHo?=
 =?us-ascii?Q?3J2yIlYiVK3gCuemkmz8zOcsOqPeM9fz3piBzgOj8buK4T2Wsbfu4KcwWWK7?=
 =?us-ascii?Q?RWo4hfDKFkcWV2spGVX78K9Sx+lWijXKk5k/nUkZRl4viGjLFw3eDZ+QFqKG?=
 =?us-ascii?Q?CncyNDUXFCqoA641LYx6Ccsabcc+FajypNk/XSvw2GlzLiacIrOvdWc4oqx9?=
 =?us-ascii?Q?TZsHswBAHg/CrZHw8fFcUCp9ICOqHcMJIUi7KMrSUPLCIY9FpkJB00QCSbre?=
 =?us-ascii?Q?qJ6WiZ0mx3fVC+st06cxAicpVyKms0St64nEqsZe79jn7ebxcIz1QmXO13B9?=
 =?us-ascii?Q?lpHR7MehFuf/PD6+DEPkiFe0gOwfIrSNbRsc?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 05:40:49.8776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19abb78f-e64b-4792-72ee-08ddc298fd78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7113

Hi,

This series contains misc enhancements to the mlx5 driver.

Regards,
Tariq


Lama Kayal (4):
  net/mlx5: HWS, Enable IPSec hardware offload in legacy mode
  net/mlx5e: SHAMPO, Cleanup reservation size formula
  net/mlx5e: SHAMPO, Remove mlx5e_shampo_get_log_hd_entry_size()
  net/mlx5e: Remove duplicate mkey from SHAMPO header

Leon Romanovsky (1):
  net/mlx5e: Properly access RCU protected qdisc_sleeping variable

Moshe Shemesh (1):
  net/mlx5e: fix kdoc warning on eswitch.h

 drivers/net/ethernet/mellanox/mlx5/core/en.h  | 10 ++---
 .../ethernet/mellanox/mlx5/core/en/params.c   | 43 ++++++-------------
 .../ethernet/mellanox/mlx5/core/en/params.h   |  6 ---
 .../net/ethernet/mellanox/mlx5/core/en/qos.c  |  2 +-
 .../mlx5/core/en_accel/ipsec_offload.c        |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 27 ++++++++----
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  2 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  2 +-
 8 files changed, 41 insertions(+), 54 deletions(-)


base-commit: a52f9f0d77f20efc285908a28b5697603b6597c7
-- 
2.40.1


