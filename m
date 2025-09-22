Return-Path: <linux-rdma+bounces-13544-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE74B8F11F
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 08:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08B737AE0F4
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 06:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4A92441A0;
	Mon, 22 Sep 2025 06:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d58v58WA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012066.outbound.protection.outlook.com [52.101.53.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9493580C02;
	Mon, 22 Sep 2025 06:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758521232; cv=fail; b=TZunT4qE5nC7lAzBKjUT2ML10Da3oBK9JZOV1WhZVJXDlzFHgq/jlUwz0O5IqhtcpNezSF1w3o+V4au9rn5YS1QxnAzw7JqA3NV1abe52QX+yy4v0Wqn33Y1tDpLwMeAjFRvQm7/Zm3i8wUm06R6fmmxYwUrFBdSNbKy/fFVUM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758521232; c=relaxed/simple;
	bh=mAHuR3TgaXm0DvGJgx3y1hUH0cwEgKxwpG7gXf6jyi8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PLXp7HU+tWFMg5YffOkHMPuan3T95fNPLe40b4NbAONgTuFNlEzZ98uuO8Wrj0cFlJhhooj4QOjTtxtpj5S2yCiXj9uSnDXEuYUtepuJXykhUt78NW9Kl/lKICq3UzixBpBKcekuk3UHr7GJoMnGD5z8hWK1grVEzDqE15bn/c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d58v58WA; arc=fail smtp.client-ip=52.101.53.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ll3Rlc4I7IfSmw2IYpKoCTzr5E3qam/akeX5Ww9E/i+CofyzYv1y2FMHMYHHe+yGQ/XNDAPWuvm2Uz8DBp7H8+eCSBZFdQNJai2oHx3e6c4ya+bUKsOBN3VDa3QrOoO8nl2EQuzNNDkgeZUDo3IOFI7ibQ6V7uo3e3WVldqO2AU9B20l5vu+G2S1VdsFrINjarnL0jq1rep8IUFcbTjxRyKddRs/rvnOfcY4bghSV/tFFiaP71XPUgFReh8ECQWBVpl5ba6RKGMMaZvAPfckGkZQ6oyz+Y2H+Qx4e8IpWlMcNfRiL6GjP2EFU2bzfqm5ELk7ySYWU+IAfxNE250zvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhF54x5/JrB6pIq65PUyXxVjbisYHjOMgFw93ZIUN/4=;
 b=JrcegR7MsqRq942Ox/xtP2C3+7me4S8DUOj9cvqiZqByuryukrTyWUllVXjpEEHS4bcwM9pv1Y1F8MofwUUttsSzQukel/3T2/NXBh4me51eGrK2/MmWfrP2XX+qgeQfyZx1WnHT7g/zf01yoFUxjt5b35qXj0ARkdwHd4RAVbpV/5ZJ4oxECkVmqv1suB8TLJnExJl1LVYvRMcKHezo2smaKg42mbf3LX+UNnAxXjgtoPzc2RDgRfkcb50iJFe9yx0CXJObPbO2nvcTVqbJPftMAkyNfKTYH+nstPGUq/LFM4hPeWlpjB7jBqQ80EwnKoIdIYOVcTlkWlpfEHuwNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhF54x5/JrB6pIq65PUyXxVjbisYHjOMgFw93ZIUN/4=;
 b=d58v58WAkDyjRXSWKaeSDa+/XUidxOydo7VPJwp2xCBZdylwPa2RPQDAPmbqCJs5FYJGisHsrYN7TQcqtB8ZxZ+NQeqQRVxzcmv0RRI+RnsTsVDriFovEIlv8Z8s34JFf7KTbNg6L1HYf7bShvHBMG11O6pI9iaTnSzRZp1gV/PNd/HqmyQ3djkGO5Fwy/NtLh3XhtpMv2PgxkHTiAEvssMZ+J/FGl2eAyQHAclc9CsBUuYD7hDOpeMOFHz4m4qX/210+zBA8nB5qRae+b/bx+vpbu3jLBvJ6ZLZVZpmQSCDUVFploYJ/aPpFk9DLwJNYSqfjag4q29muvStX4p9CA==
Received: from BN0PR08CA0003.namprd08.prod.outlook.com (2603:10b6:408:142::19)
 by MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Mon, 22 Sep
 2025 06:07:05 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::d8) by BN0PR08CA0003.outlook.office365.com
 (2603:10b6:408:142::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 06:07:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 06:07:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 21 Sep
 2025 23:06:49 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Sun, 21 Sep
 2025 23:06:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 21
 Sep 2025 23:06:44 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH mlx5-next 0/2] mlx5-next updates 2025-09-22
Date: Mon, 22 Sep 2025 09:06:29 +0300
Message-ID: <1758521191-814350-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|MN2PR12MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: bcfbc711-5cf5-42b9-aa20-08ddf99e418b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0lzxRYVOO8Yxo9sW4TnIiW6mTue9FTs5hrVxCo7vglOM6VmymAjfgIs8giyC?=
 =?us-ascii?Q?b3LtNI2rNtG5Xrr8/ocvEabMy6b5ncgwsQJsjaOAigVYnhqnvDkwznS/xpCq?=
 =?us-ascii?Q?BF13+VveGY6pU+a4sR+rSAlZA5zugSkC4HtXD1N03twDTw1/JsGgL/YdRtmI?=
 =?us-ascii?Q?74RZjWBQMRTNav0o41546mEFrkX14cSEtS3vMU0jEOSplB9YhSi8waZoogGp?=
 =?us-ascii?Q?XZve02G/ntuhSGas5zMJmQVYff6xIWzFv3q0lPlKDAE6bgDYg0gFgF0KHL/f?=
 =?us-ascii?Q?8r4ifq2sp+qgGDp2uzpOeRjZCMo2dGIhbvtfIHJvtJqwPlx931v3jGFk1mQ4?=
 =?us-ascii?Q?4/OG5WZ1Un/wjEfMtL3lDrU42b3PEVmsVtddiH4/u6VUg9W1d60mM5rp9Yox?=
 =?us-ascii?Q?DzbO9cGBrLN1rkzqzfP+H/nRr0UgFoIZThq2VfzUxNacMp6Cmhb1cKlhYRDa?=
 =?us-ascii?Q?eUqQwA5ZvHZQe7dVYJzesFp2QR1VPfxBGnymygSUOhj53dd3v5sohIc1zP8C?=
 =?us-ascii?Q?0yPPWHHv+hQlWNU/oy0LYxCkoK44L6ODc2SEzAXkwMwUzItO1zCSsXKsncot?=
 =?us-ascii?Q?gQO37RKYrAVOreZm44JrI0Y0ciXkIfeOyjlN0wB8EGEalBwEB3dw7c52hhlz?=
 =?us-ascii?Q?KJnxTMvDSA8bilaR5aeCYBbuKaASVGh5cEOxHyFCb0T0gjrZ8L8ZViLfnWWo?=
 =?us-ascii?Q?BpB6WeddpBYrpTlGeXQsJD/BZARoAFhMuTHSXxyrsVS2CB2e95RWvmUga6Jl?=
 =?us-ascii?Q?oG4UeMCw02DT6o43VHjBe+N851Oz2DayX50GbJsoUKOVaZRD/pm5r7Bih1Bj?=
 =?us-ascii?Q?y3hV/jGTYpHS630Am8Le41YaLbQePVMOqpEkyFcR1itPd5Kct2Y54MmkzPQ9?=
 =?us-ascii?Q?KP/YKyp+zk0ofkrvDJu+bRAUF26S1kNkybh9qhtWC18nHO8XrSUWwIcBijhh?=
 =?us-ascii?Q?Tmbh9cPb4WbkNDxvBxIXwsq2SMuKwpk3fAsTQRoqVDkehX0e96P9KaNm13gq?=
 =?us-ascii?Q?JbSMgJqhzHUOpiEVC9RaQ/hFouoav4lbE5FQ6RDMP6tWwtPNuW+vkf29L8H/?=
 =?us-ascii?Q?Sqa9Ji+AIqpVjj9L1DF/e5SCjh4CoR8jkSyutVxdn1pzC5suMZ8jombY33g8?=
 =?us-ascii?Q?mXH+aMpKiqypzj+UZ4gRx44rzXyH11QeKSt99w2OM6X4MAgT/u4QD048DWNV?=
 =?us-ascii?Q?vT8ZiOl647XkOdPXIkC2Yu2+A2RsDPgoyxNEVpa5NCARtrTExyh2cJWBlSaC?=
 =?us-ascii?Q?G1OMVuEB3TX+Yyv06i3zgb67pu42hcc/uO7JR8YegdEeKF7e4PpCe7aDF7Br?=
 =?us-ascii?Q?J1tXJubCZOuWkmORPRpEL3QvB6F2/0Lg0WlHdIsHI2/R/p8jbEMf63vhuUg0?=
 =?us-ascii?Q?U2yYD99IlsnBtWelx8tslv8fqhC0plIiSonUskI1WSAiGz3tVHAqIq16S78O?=
 =?us-ascii?Q?o2rp58E/G3rU6kSI205047AV8mShRn0L9ogffFvf+BhbjL8YS+NaCO9DzLTC?=
 =?us-ascii?Q?iFkJ/RzzJzX67wf8U20DWx+BDH2EgG6w94+w?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 06:07:05.4391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfbc711-5cf5-42b9-aa20-08ddf99e418b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127

Hi,

This series contains mlx5 shared updates as preparation for upcoming
features.

Regards,
Tariq

Mark Bloch (1):
  net/mlx5: IFC add balance ID and LAG per MP group bits

Tariq Toukan (1):
  net/mlx5: Add IFC bit for TIR/SQ order capability

 include/linux/mlx5/mlx5_ifc.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)


base-commit: a3d076b0567e729d5f21a95525c4d096b1f59e79
-- 
2.31.1


