Return-Path: <linux-rdma+bounces-14507-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6EAC61C6E
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 21:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF503A4844
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 20:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2786D2550AD;
	Sun, 16 Nov 2025 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BVbP44aM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013004.outbound.protection.outlook.com [40.93.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9A5214A97;
	Sun, 16 Nov 2025 20:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763326024; cv=fail; b=oBUQ0xr4ki/Hs6LWp6bB2O/pxpx5WH9OLFxJJehJqTSx11A/Bd+Rook5ZvDFmtpnqTDfBA4x15Bl82nYqIBNY+KgQHDmkKhmKB2ABErpHsKebZYh3Z1FVBLhRmxbqMJsJTpVWQK5OrGksK2oWL5KbbOR0oib0ohlGqaHA1KVsP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763326024; c=relaxed/simple;
	bh=63xEq9SPsJ94EtgYQ+pKpNy03ebonMowNJnmOaTyA7M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LkT1zJjsxTGoWQubv3ytg6Z2ZeAvytb1AgHa0E0h4awq5FwXsvlcCQA6XqJH7XbeytKBAO0GsGNyJ8PM0oWeL9nx/gZ/4JEFh8scIfLbTQ1vKSegNnaj2Dw58JTqAEdaGAyBb1Yx7mJP7Rfvdj8k11bSqveRZAcx6u0mBtDMEGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BVbP44aM; arc=fail smtp.client-ip=40.93.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSd321ffwwub5JqgNQOD3eE/o9I+5tws5FUvizAbYcLjoJtF8gOlb/fhZIDjr9UicfAKCU59KgPwx0V0j3Fr2O00JftojP3megDZQVD5Q5FL/wxQ7gPZjquIduRDJaw6PEvcZQG6VuljIJIk/M5XEc1K2Qe53FVRlMyemMMxrYpZQB5hu6uMXpSBXExlS0zaMccEK2Fqk5Zn6Q8XUQf4/dT9SskkRRwaJYwULw/VzLgHS5GB1eWJJusu4ZrPK4SrfTfbgSdwiBNPGCPI5PYCIfu8TaDbnFI6zfwJlw0c+qkfzsEARqlVFd+6qEVTlPJ1gs6wx/3Vfms8Gn9/nuZm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNOxmQs/uSLZP82RrYRLL9+8KcygxfIRnJIcZzBJdc4=;
 b=AH0gEaBj1eo+Y1ZDf2Uowv0nWhVMxMsdd1Oz+fGgdFO/ax+FA1c3nPqMK+97dol320CpB9bczkbf8pxRZ/c7OXTkZjoTTSZajaVfXhUK+RA6RmogYE82SkqWaRzXaQw2UZqz+oWLsLFSQjQTGhavyxoT5DrqyDucOo8P4ngao8INyXb31zbml7AzKBZxwg6vkecGJiBQ7oAIGKsktk0VJ4BfaflQznidQ9VzTBNrulWtbro+uHY546yyCs7klByHGBMQOw2PcWjYk4CrNt67sgt9nyLhY/G8++7DR/KUmKXWPIK8JzKgYklS9sNruO7vHhZWfZI+j0NGpxexD8CZLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNOxmQs/uSLZP82RrYRLL9+8KcygxfIRnJIcZzBJdc4=;
 b=BVbP44aMXzxZe+TB5TY4/v5JsryYVcSum7PlCZ6n8ZOk8lBF88XRZU/oBpKd2BVCjJgTKy0MpQ7kTbAbhuTMX5mpz1Z6Cd0xaQ0M4pBj5OoIQEd0d5r/UK2mGOHjkteBqvAKxWteVZGHE+ZE4AA38mhUiRNdNvdq0xvsDm5lsTbUB8tX3PvxRUJIdF9LemJgw+jZeGdD2wtpQ2iFGd/N9kyffkURXeeY8b8Udv8aEdDB3RsUSsHHxthowIwM/96yK5XtwOH41grrytzpw9J5zgq94bDYaVPwMhjigrxmf8iA1N2EmJ2pTIRFybgu+0bWl1D86Dp/YqcWBdpKnQ/XLA==
Received: from BY1P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::7)
 by MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Sun, 16 Nov
 2025 20:46:58 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::d8) by BY1P220CA0009.outlook.office365.com
 (2603:10b6:a03:59d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Sun,
 16 Nov 2025 20:47:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Sun, 16 Nov 2025 20:46:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 12:46:57 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 16 Nov 2025 12:46:56 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 16 Nov 2025 12:46:52 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 0/6] net/mlx5: Move notifiers outside the devlink lock
Date: Sun, 16 Nov 2025 22:45:34 +0200
Message-ID: <1763325940-1231508-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|MN2PR12MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd70ea1-b4ee-4819-7548-08de255148e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VEKH8+VwKOtvHipN+bqoifD/lbd6ywWQ+asahCT6jWx6921gQGKvWe/MmRVY?=
 =?us-ascii?Q?zNbyhEtKMxyaFNKcWquEQcrjlg/MByNufExqF8qlyhv+xfWUvVXOBvT+GhQD?=
 =?us-ascii?Q?2v1GK2bKISASDoNSegZBlSbhfTmUi5VS7HJH9s1UIjKHFdQ1w/ask9AHGm2C?=
 =?us-ascii?Q?djF7h9tQr1todx4IScwL5xD7f0ingkYHRJsEEz1D6KJ3G4s6ze/fwdFfbrMW?=
 =?us-ascii?Q?X2QFwVS8URetfuWHA+oncSXOpHh17MElPPl/QFcLKNzgOr4KIAObFWYGeAVX?=
 =?us-ascii?Q?0+OVi5vp0aWfNFAzHU7c9ShQ3O1dwsyb9eGz5JKHENm7QLQn7fgxHu64tvua?=
 =?us-ascii?Q?aUlUqotD1IzJeXWSxqySW9q2mih2VonXrB8ZbxTHi79kOFCzpSWsOqFNkc/p?=
 =?us-ascii?Q?UxkQHoJWT7hTNcVTlBzZopmEYMwwn8OadLFCQlN5mGg72MTwovtDhx7oLqTD?=
 =?us-ascii?Q?jBWzL/Ua4UWShsjXi9GP9KWs1isXRuTFYU6DzoOJoS+rh2WGa/AD3ioTFpiy?=
 =?us-ascii?Q?ZS40AZqG3E2ApkPSxFwXmnvSrOis7V5ApIJSXK9PsDSwm1ocxoY31PB8b1rb?=
 =?us-ascii?Q?qL02GvXapejsNdfqQuBEMc8F8jQPzl9q1HdwpF4NlfNLU7O2/4HOTsv4MFzg?=
 =?us-ascii?Q?xhAY+VxgF4x2sYalZbpcT9fhv/RT91PKU+L5DDSsguKe8D4+pmCo6vPOA/7I?=
 =?us-ascii?Q?xtHCogh+ggyEE+LJnYWkGCDAYWCTrIkCYA8dAa4e5oFhEp8j8ADpNqHOd0O0?=
 =?us-ascii?Q?JjId4Lct1kgdcgnu8MQQmEg0rMsvTEE+egIw/L80qa7ra24RzjMKFWvrKQTO?=
 =?us-ascii?Q?U/g+fwoORpUBOzYchnVoqcIvxmcJbaOLkGhDfyPQlJ7d4vEFt9Q45SAoySbG?=
 =?us-ascii?Q?ZOJyDUNUF1NdG5rtQAfk/fcSq4802+imxU75JoGKB4OhfTED19I83pxE3lFf?=
 =?us-ascii?Q?hVu0PrmstL0Lh0s5eQ+uIn/YmB4A1oH6PM09kkcYEcnhqEsOnBTzg4JLqqFU?=
 =?us-ascii?Q?pN7p1trJvWIzwiTfvdtT1XdKxkTP/8LTTiVv0LGylBhijaEtUGzsyujnwYbC?=
 =?us-ascii?Q?QCu17RhKk8R7LaFlpIRtiwSZa/5Gza3VYNF9C8SxsQhQiMkrXWm7BDqs8TFl?=
 =?us-ascii?Q?OwYklxmXghFDwQMBwmuZatihk84hp1gDSkyxsKXhJYm5hnzQtZVvxsSlZo3a?=
 =?us-ascii?Q?oNezLSFPlE6afJLo2UWYrljH2ZtSV1lA48N/8m4GhvBfp07gGQ422y0qO13y?=
 =?us-ascii?Q?8QBETQ5KBtbgMV9O7Si2h0W9nyDY7tWMB8AFL97PnzAm8PpYQRU4S+byonKt?=
 =?us-ascii?Q?4bA9vgAxQbVgstcfcPKJIZkb29G062WFGhRkCJ74MkZPm7NmKbhtsQ1xNWjg?=
 =?us-ascii?Q?V+tqIiIsLEwDYyhwGvCXMaEi2IlEGq1ZB8qBOLFZLWrM8O856sV3yMXoc1CF?=
 =?us-ascii?Q?y6WIgUsNCOqeDTTH+KeLeSQN3jngXxJHpU/aGx47WaWEjn3jPTPYyNl30Phq?=
 =?us-ascii?Q?E61PcNXF5ne1uD843D9gEoL0+mFSLCLMxA/LEveSJcFKrRotFb7rP6+Ym892?=
 =?us-ascii?Q?mrN1LTDuIuQYeAcejg8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 20:46:57.8046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd70ea1-b4ee-4819-7548-08de255148e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127

Hi,

This series by Cosmin moves blocking notifier registration in the mlx5
driver outside the devlink lock during probe.

This is mostly a no-op refactoring that consists of multiple pieces.
It is necessary because upcoming code will introduce a potential locking
cycle between the devlink lock and the blocking notifier head mutexes,
so these notifiers must move out of the devlink-locked critical section.

Regards,
Tariq


Cosmin Ratiu (6):
  net/mlx5: Initialize events outside devlink lock
  net/mlx5: Move the esw mode notifier chain outside the devlink lock
  net/mlx5: Move the vhca event notifier outside of the devlink lock
  net/mlx5: Move the SF HW table notifier outside the devlink lock
  net/mlx5: Move the SF table notifiers outside the devlink lock
  net/mlx5: Move SF dev table notifier registration outside the PF
    devlink lock

 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 13 +--
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  7 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    | 70 +++++++++++----
 .../ethernet/mellanox/mlx5/core/sf/dev/dev.c  | 48 ++++++----
 .../ethernet/mellanox/mlx5/core/sf/dev/dev.h  | 11 +++
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  | 90 ++++++++++++-------
 .../ethernet/mellanox/mlx5/core/sf/hw_table.c | 61 ++++++++-----
 .../net/ethernet/mellanox/mlx5/core/sf/sf.h   | 20 ++++-
 .../mellanox/mlx5/core/sf/vhca_event.c        | 69 ++++++--------
 .../mellanox/mlx5/core/sf/vhca_event.h        |  5 ++
 include/linux/mlx5/driver.h                   | 10 ++-
 11 files changed, 253 insertions(+), 151 deletions(-)


base-commit: c9dfb92de0738eb7fe6a591ad1642333793e8b6e
-- 
2.31.1


