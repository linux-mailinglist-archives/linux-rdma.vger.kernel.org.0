Return-Path: <linux-rdma+bounces-14053-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27946C0B193
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Oct 2025 21:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400D818988C8
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Oct 2025 20:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CDF22068A;
	Sun, 26 Oct 2025 20:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f9UcBSlL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507802B9A4;
	Sun, 26 Oct 2025 20:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761509033; cv=fail; b=UqEuuBIkk/wdk8QIMuXnlvlQ3JZ07NOLUpJVnGkQFDbKw16QfTzMTnOlSuXJgJd/8/iVWo6dv9jDod517t5HKFZj1nR6ocwVCT2XLW81U3PtjQwAKlW889Lxi1aQAR6VTaE/cqJ0f0LQ/cunt9jXoX1O9evDJLkLE1TiqsgTb0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761509033; c=relaxed/simple;
	bh=nJDmo66qKZALu3MRTHTELOhdpLu/5IVRQa+hjws/FQU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cVW0Kup/nYovKkomI/5hfY5zqRqKam5lYlULo7Db+DKxhqQ/lsNtLzxzVhXNWmQ2efW30YftXKiNifckH02UhLm1P6p0qBtnTxKROvWsyH3DiFnh0GipvcrecJWhEdKmb0S69IVB2MSRTedx9uDjDrSIxq1TO1kN5+kxC4eqTRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f9UcBSlL; arc=fail smtp.client-ip=52.101.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpZpwN33XZu3k0qmF2Sz8A1La1sPliWyfnaAhVunSuaoW9SOJe9UqTu1BmrnJAWiC7HDCCU4XWakIg+eGgzM21LaPmj2cAPFWWVJFWH7YHV2RKcv7ke7Bt2w3CEVlBr7LFwMNu7YWoQUGZjgBNSZgV/MgeygcyGaK79MByT6RXTkGJIr6eTQoNP9dNye7TJQkegxefLjZ6ylLYq0OljQoJkLp/F89xx6qQwS2QpyUh5o4GJby8UerZlkoovL6CKFGeg/XV7defLEMR8f9LgwaqEVS8TkVMvo/X0ExMkVl1+L+QInQlr8+WhzemqCSTe4dk2vhsKwmZjYK/uNOFo/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnzeElriFN1Rb5VYfgK48SnzrfoM/SA/eNHSWHhGD1E=;
 b=oBySnLStZO2jK4JmqJQaiAu5hN601sZLYO4AsAHFBToa4m8SUNtgTJLGN6bqV0EGaCkW6deMvx6iv9fb31K9xxDmx9Y52qegBrRFXM6hGJ1A8LB3U8kEtQXyGjuiv6p1QHeCxl8dodGd5o+TdeCtQsB8iBVKUe1Wz/MLdQR/BBdGMR8cANpuJpUJIJx8RLfI0Msqfhn5Asnhf2/vfWkxc0Vg+LR2FVYZQx6vXh/5liCbIaMKpJHA5Mf6tOJIcVXdOWP2aWgoBNed878/Ga5XW1gnHiI8LS63Ov86DVWz+lVKCp3Gq17NZNz2t2xpjhT5/h/dkPxqqeTIHqQMdqtndw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=queasysnail.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnzeElriFN1Rb5VYfgK48SnzrfoM/SA/eNHSWHhGD1E=;
 b=f9UcBSlLgNBjnKkNMY/kwTEsfU7xkEdx+Ix5F+c++oFWnP9NxvEpqegHG5uGKGqtyNZBDMjkDte2ov+WRcSdLM2LibG4k2DXZADWFyUXS2ZHRjFxTN6hjiC12v4w1lGQkhCTUAYb+VaeHbXu1H8hUvzh5JjSb6LMES7QSYRZJYTu9kbKW69B6e5hM4+tRIc5y9kD1TZjtyX6So4zcH5m9kFd8Ps8LegTagv+Q3ZU0/b9WPTkQLrqQFbzIZ8Dt4OrMIsV2Q1TWITt/lbE3z0J6SvJpvvjKcIeeKJ6NomRXlxj1K5dswUfp7eMPx4UyT70DV1fNFkKYJcAG/AXkaIM+w==
Received: from SA9PR13CA0159.namprd13.prod.outlook.com (2603:10b6:806:28::14)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Sun, 26 Oct
 2025 20:03:47 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:28:cafe::aa) by SA9PR13CA0159.outlook.office365.com
 (2603:10b6:806:28::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Sun,
 26 Oct 2025 20:03:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Sun, 26 Oct 2025 20:03:47 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Sun, 26 Oct
 2025 13:03:38 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Oct
 2025 13:03:38 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 26
 Oct 2025 13:03:34 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Sabrina Dubroca <sd@queasysnail.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "John
 Fastabend" <john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>
Subject: [PATCH net V3 0/3] tls: Introduce and use RX async resync request cancel function
Date: Sun, 26 Oct 2025 22:03:00 +0200
Message-ID: <1761508983-937977-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|MN2PR12MB4272:EE_
X-MS-Office365-Filtering-Correlation-Id: a96f660a-4746-4c51-6c6d-08de14cac616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NjHlyHouKWh0bjRxkPW8V2dEAk2DD/G4scx9be7epdu4zmDwk6wAVEDfGgKu?=
 =?us-ascii?Q?iiMJnO++ky1WQ0uuzrHqXzaR14pkBSGJg+1QK5vhLjKw89pnGYvn6LYT3+kB?=
 =?us-ascii?Q?jd1RtSQMUM6owzSqwO0nRX/waIcT9SpUfYZZNRljcliO+uG/qa/EoGJaSLX4?=
 =?us-ascii?Q?/hVvUdarms63WYAU3vC3BUqMTPLKwu5cHAGBFvmjU9zqMnK/C5qa9aKjl4wY?=
 =?us-ascii?Q?JLIcxzl3ISgHodZ+X6qd9mM1PsmpaukceTDe+sZa+20K0s2YtreBqO+sxIzt?=
 =?us-ascii?Q?uytVUxnp9V2aFy9sFdg36xPJRQ9rVzgPg7+Bbx5NWpyx3jJukmzIQ5yfgx6s?=
 =?us-ascii?Q?LiusReeWFOqwiTTgPnVZ9LB686nPatJl7mNrt/gas58vqWUP0zJWkOzzbNRp?=
 =?us-ascii?Q?TGfkK50ugM9Bb6bVkFNMesrFjQ4QprFXTHMYxjJa1yBI+rZP3fdW183iANXJ?=
 =?us-ascii?Q?SbBTT0MlXn4XKk7nk5WLqt3VcxfIV94awtQfAsIgUps61Zqne8ER4jA9IX78?=
 =?us-ascii?Q?Iu3w7cw3gSS+UtkD1oJlMdVBFgVNp0oN0yzXK+n6GV9l+2zFST91jmseoeBG?=
 =?us-ascii?Q?9FrW2J1/JY9iWOCUufavNUW6yWaqoLkD00oZ5mKUbuuqOMCNXtQm3rv8qT3r?=
 =?us-ascii?Q?FptwGA8pNc6z6m6W1wFRB+8sRwmGC8aJLILoSurfKghBT++gT6js0d3u0asz?=
 =?us-ascii?Q?BrxAzhgMTeCv2RpuUnWoI9UTxQIqdgPfmDA11mH810P4IvUt6jXOK4e4nBVc?=
 =?us-ascii?Q?sLsYjzntouXhZIs6D0miEzX0jCyuD/N7d2HSQnHkz0N8IKVkKCSAcmK0gV4H?=
 =?us-ascii?Q?0MsqrM+Z4Z7YmecJDVeGF78NrNCLY+g7neL4IDIO3WHP6czznKuRbt4aigvH?=
 =?us-ascii?Q?cpmsZg6gRu9SeFTdDhirhP2aZOXPvw0D5RJamgC0WUvOqjd0j4GKNSCzdpJs?=
 =?us-ascii?Q?HHtoAWU1nV9ZY+VNAOLZZZVnv+gq6Ajvyl63AMn9Qryqka41AOgKtqQPqM6u?=
 =?us-ascii?Q?18hZUxxD1KdNoakiszoapJTtsTT2fbNTsFPsmJF5eVvRztvQZmJDuRg04S/c?=
 =?us-ascii?Q?AwTJbjmqolevbXi1f+7MEXzzP5U7NQfavjQTb/9EY84sYzNaIqqKT1UDc04b?=
 =?us-ascii?Q?U6BtISKSVj1jUBAgwzPQmO7m/UblcVyX8J3jnmUpi7yLTGrTbX+zJvMfzCKI?=
 =?us-ascii?Q?cVzJbKquhYJpyO3KtAe5xo61dgQyViY3rgygDyE4V0bxOUTJHlh8K6ON9r5c?=
 =?us-ascii?Q?oEiRN/+MF1H7votucz7mkhMA0sRJ6QKT6CHA94Od0i44M0xLVnZKbCKcP6nq?=
 =?us-ascii?Q?gu3F/PYi8aWSHGcpgL9DIscOHF8KXvUvc3dhP1xe+Y0py+6QM+YS7T0Calgy?=
 =?us-ascii?Q?NEFYzXcNu1SfEWroxjZJPbAkOoZbHhcp8mmfbKGEEYQ7JKEuSvWsEG5ludRh?=
 =?us-ascii?Q?u+EcVDk4nCx5icspNZoVlo7hYgzx0cBCBI3Ih/pWaJqxACl/c0McovSdFTr4?=
 =?us-ascii?Q?85HgFGdJQgbBfX1ezS+ezGjeAK6soUXeNgKXNebGZEndlb5r9Ur8aHrsTNTt?=
 =?us-ascii?Q?BtdL562eR1GQwfPUiIo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2025 20:03:47.0202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a96f660a-4746-4c51-6c6d-08de14cac616
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272

Hi,

This is V3. Find previous one here:
https://lore.kernel.org/all/1760943954-909301-1-git-send-email-tariqt@nvidia.com/

This series by Shahar introduces RX async resync request cancel function
in tls module, and uses it in mlx5e driver.

For a device-offloaded TLS RX connection, the TLS module increments
rcd_delta each time a new TLS record is received, tracking the distance
from the original resync request. In the meanwhile, the device is
queried and is expected to respond, asynchronously.

However, if the device response is delayed or fails (e.g due to unstable
connection and device getting out of tracking, hardware errors, resource
exhaustion etc.), the TLS module keeps logging and incrementing
rcd_delta, which can lead to a WARN() when rcd_delta exceeds the
threshold.

This series improves this code area by canceling the resync request when
spotting an issue with the device response.

Regards,
Tariq


V3:
- Add review tags.
- Remove Fixes tag from preparation patches.
- Remove duplicated counter increase.
- Fix typo in rcd_delta.

Shahar Shitrit (3):
  net: tls: Change async resync helpers argument
  net: tls: Cancel RX async resync request on rcd_delta overflow
  net/mlx5e: kTLS, Cancel RX async resync request in error flows

 .../mellanox/mlx5/core/en_accel/ktls_rx.c     | 41 ++++++++++++++++---
 .../mellanox/mlx5/core/en_accel/ktls_txrx.h   |  4 ++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  4 ++
 include/net/tls.h                             | 25 +++++------
 net/tls/tls_device.c                          |  4 +-
 5 files changed, 59 insertions(+), 19 deletions(-)


base-commit: 84a905290cb4c3d9a71a9e3b2f2e02e031e7512f
-- 
2.31.1


