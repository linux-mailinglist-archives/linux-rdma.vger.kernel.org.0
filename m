Return-Path: <linux-rdma+bounces-14847-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0962C97FFB
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Dec 2025 16:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436793A4DA5
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Dec 2025 15:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69E631DD99;
	Mon,  1 Dec 2025 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N0bKFflV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011004.outbound.protection.outlook.com [40.93.194.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461A031ED9B;
	Mon,  1 Dec 2025 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764602077; cv=fail; b=AQ43yao8RV+34nZxWYkfHneIGSijQPqsjTTJMg39k3fVxPZ/bLxHf8PS/XnxSH+KnwznsmdIyDUeVUj2E+L6YbJVBfTj2kj6x7XiIfD1P2amvBsHOP5k4J434THy70DMjAdnx6NDnIWa4MDMp+s/frPxuWhfhLTyi9ZTqzh+19k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764602077; c=relaxed/simple;
	bh=BPPFN0esyzy8VHb+TOKy9+Q1NNbmoAW+1IIjIqtYDlY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=efQPPzuFsnqzIuiRaqRU3aecF+sFGmRzL8jsmsRklgpM8wqIP2RwB87CQ1vEGqoMRxEpl0OJlRwYPcBsC+YpQbMksygS5uhP2nHYsWV2pN6iPwt6E9nGTCm0KoYkQuLteklP523LKta+Fe6rv0WUwjsHrLSPwDuIgWriEhhSGt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N0bKFflV; arc=fail smtp.client-ip=40.93.194.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2YGQB98nUw94MS3P7utp3lUtoS+/8LuGunfoB5GSLmcTHl8j+tnRWzPbUrGNKUHTe4Ba4U1lB3WCInfzBRLH8H9Fspm10sMnQefgBSEbtCfQTJCEdOvQumIiXLa9MXslv2021BJNmiBYaJWXapX9ecidDVHtttSsfMKJh9M8t8Btda4rk4ZtJdz7qOJabSmoVWZ9pBC6wgMSpm19fVBs2xqH4bxhS/GTuMHHcI383xkgi2aMGfG+ut3o+hlOuFR9Ov3ddFu9BDTtEmkfOwuyqJNWb9ujUbDO2/AJGduFuBW0k3O9cgjFeNoMZjUvUkxFvdy1V7fLB9C5RClBqNl4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqngtjTB5ZNyUHF6tu/0ghodwOooj2CsBm0ipV61RSY=;
 b=T2w30/O87lSW0WREY5wCPYyO7WlJaIrNzhxzoWnJSJ3t5XZGa2R+8iW2OAci8dK/iYx12xHjSesyN2g35tBgIod37xafwdA7c/5r+mC+4V+dTCtiI021Um05/y8j779UiWbZOIno4Y2QG/BGea+3YGMtHwX+PTZ+laYZAaS/lAkVwZmv1cZ/y8FhSoLOyHwX+gsqFVz/6HK/mYhoEzFjL//zW+HfG1qA9s1oThacKcaRP4KCXKBfTnm4k/viROD54VlvxZFKAWjoRR8LK3lc5qTzhmoebR6VmLw64m5noU2/04SiIymf4EO6oKfwlak9Xp3qMyF3zfMxj1LOcbycwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqngtjTB5ZNyUHF6tu/0ghodwOooj2CsBm0ipV61RSY=;
 b=N0bKFflVdKS0Oo3kwmeTXV5Ytvbv7BY4cbMywRs2s4S/L5DjSwznlIjrbtUR4blAzS5aumIAqIcV8PdkcXdwU2yRfWhVNJNVMEaE9qBEZUi/eQXypPMdEmsjujPqmmj8WjDJxLfASraeeJ4cpX5sdZjFGADAEW6ENFg3debB04UyWz/Tebrg3aBU0C5VHTrc6LuCS04NaZ69nIOsXGRf+Xk5Wiz4icl7b9I0ar4zgluJcjD49By/M15Ntz03nmw0P0jKV8Jp0YhSms1OJ7SxFEvzYgw0V7CAtkMz4fvIlkNYgOA72TabbpqeClACM4XkztAcyPv8Ap5DymDFP1YU/Q==
Received: from CH0PR03CA0322.namprd03.prod.outlook.com (2603:10b6:610:118::27)
 by SA3PR12MB9158.namprd12.prod.outlook.com (2603:10b6:806:380::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 15:14:21 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::8d) by CH0PR03CA0322.outlook.office365.com
 (2603:10b6:610:118::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 15:14:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 15:14:21 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 07:13:57 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 07:13:57 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 1 Dec
 2025 07:13:53 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>
Subject: [PATCH net 0/2] mlx5 misc fixes 2025-12-01
Date: Mon, 1 Dec 2025 17:13:26 +0200
Message-ID: <1764602008-1334866-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|SA3PR12MB9158:EE_
X-MS-Office365-Filtering-Correlation-Id: c95e7454-17d7-476b-83e5-08de30ec4e0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tkhf4U3pH5qJt1Q3V/X2F7xDR+m7ZqC2ko97/65r1/HZixRDXQRaN0GQZai7?=
 =?us-ascii?Q?fGH+Wt1m4dlHPonh4ndmJcTQT7qSEQc4nUn0jCCOkfG6927nvgAxkHwi+pKz?=
 =?us-ascii?Q?1qJCemYREb9fDCfhTmIdRynvth+hdooce+AHMFYEMIwqMH882Z7nBIwsAcTU?=
 =?us-ascii?Q?TgCoryXFRi0umFHr9JHMSFcDxefmwb7alDrltujpy4DcLVubHL/Tm3ZZDFjI?=
 =?us-ascii?Q?+OR2yWOTTqHDMnuyyBHCP8QYv/Wj9+OlLHzp32iPYoyi0VBOGuSFfBEe+VMR?=
 =?us-ascii?Q?bEpK2ulfM+iafVb67NCSxwkTonD8W0Gyh6qKE3d17GQ8wIM8+kiTHUNin52h?=
 =?us-ascii?Q?Yymds3gsMgpcZuDChwlX0NFfkNiQi1ZObq68dUDqOSO0LJ7OywpSnskW5UdC?=
 =?us-ascii?Q?E9/MzVaiSGK2f7R20XJKN+cWst2Z0WP6SXF9zYU3dq9jTwJEs8APlQt54FNE?=
 =?us-ascii?Q?JIiWQrsNNnUTuHYasjteAbe2cfsJ/+qjTbybGnDg3jyuUCYv70Y9kjv9CM+X?=
 =?us-ascii?Q?wox8u+0AqNgGS58J3FE2+khdnxgC1j3LOb2qlxh6STseOjODAGLpXSBNIHJ8?=
 =?us-ascii?Q?JZKhEqp5KL0llZ6J9enBi87bACRgjiQ9Gojg6OXtXOb2xzEwFcJgkE3derBb?=
 =?us-ascii?Q?g4OW12AIlQGgvf98C07flIwAMbwWGf+31tz+1yBbanzRACHpr0do69y7kz43?=
 =?us-ascii?Q?BmsCee5kR28tMQJ4K2ZwpWuYAAgsE5ax+JGr5PHbUOguYAFh6nqF89jXLiaa?=
 =?us-ascii?Q?TinmVyuQRI3bjP4dTvNBBDi3/ZHqa1lNi/ZJ99ka7+3sFurPPL+1UXH5iycZ?=
 =?us-ascii?Q?D7dMN3dTw5JEqtnx7Ipi05XDNI/i9vtO52XiI5SevVxqZ0zBUasBr4OnV84W?=
 =?us-ascii?Q?0JRR1NfOiH+ZyRYUfn4U6x505RIZHwMj3+UTi+NMJjsxMgH0VjyB3R6J0/V4?=
 =?us-ascii?Q?AIt5cDzR1Zwj3a4NrZGDMDN16Xg1GcGgouMoUXyPv04fRzEEmO0uUDXQEguc?=
 =?us-ascii?Q?WpGmv/xGmoBdA5HCP4muR28nu0vYbbKOq+DOBaTWqInD8w8f2g5B/QJOZ2QF?=
 =?us-ascii?Q?H6es6Yu3lxBGr87sE4fmgSLKYXlDYsGaiCfMGecCH3h8dxQTKigV0lOdN6l2?=
 =?us-ascii?Q?Kao8YGNBaa6pPN7EvWV9sp/fXqK5dl0PRhEGzHyxaM66H4fp/lycI/rA8nx7?=
 =?us-ascii?Q?hGDj56PcqNCDUszIcgIb24a9V3FiMGRUK1zaCu2yfgcVXft3m1nlgtJU8Td8?=
 =?us-ascii?Q?NclbiJ6nznUigapqu+RRXyYx8en3YrYzJugmI+M0zIMVHQRv4AvUl3o2GeYI?=
 =?us-ascii?Q?tTFccO6KU7HzyZu5r0pvB+Y2Qky/2dmbNrnmcYtxzOI+1IOptGb0AV+iMX6s?=
 =?us-ascii?Q?sTaU+FtqH7cf1NZwnmjD+eePIkkeM1QzJALLmmgC4Y8BuZ7NR9X21j1quIVu?=
 =?us-ascii?Q?wpkQ8QL5Yho6iot4NRIpbLLTbtVa/mnVTeYNyB2b5kpmUPWQO2k9DKtB7A7c?=
 =?us-ascii?Q?8l2iXXZ+WJXM5mH06ah/4BZtB4v+waDKK1/9TKG+Y++FOhmsapkHj+aSdhZP?=
 =?us-ascii?Q?bmkTgDykkECjEYBGkmc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 15:14:21.1593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c95e7454-17d7-476b-83e5-08de30ec4e0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9158

Hi,

This small patchset provides misc bug fixes from the team to the mlx5
core and Eth drivers.

Thanks,
Tariq.

Cosmin Ratiu (1):
  net/mlx5e: Avoid unregistering PSP twice

Moshe Shemesh (1):
  net/mlx5: make enable_mpesw idempotent

 drivers/net/ethernet/mellanox/mlx5/core/en_main.c   |  1 -
 drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c | 11 +++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)


base-commit: e5235eb6cfe02a51256013a78f7b28779a7740d5
-- 
2.31.1


