Return-Path: <linux-rdma+bounces-16007-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGypEaEUd2mHbwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16007-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 08:15:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C8584BAA
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 08:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 463063002327
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 07:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D3229E0E9;
	Mon, 26 Jan 2026 07:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J0ROXMkD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010071.outbound.protection.outlook.com [52.101.56.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1227419B5A3;
	Mon, 26 Jan 2026 07:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769411740; cv=fail; b=mVpuuheNSjqGYE3Z4bazDCnOfwI6ZB9JS0rsNADFC+OLtMg/6Dytb0JOAQsZXaKeBKE2W6f0m9fIRwAEVMBv9aPrgub/fIwruwddMuBTOexD5OwT0C6I0Sb0e32XhrUtAvLg+u0pExBBYelV7QNtRApa4i7Fg07yD3XE+liNks0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769411740; c=relaxed/simple;
	bh=SzSeMWfe9ZsWlVozDE1+YUEH7HBi/EwfvPNA4gvWgAI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qZY4YDrgTakobeXf0UelTUh69ikAQJxunTKdY0k2ukC9bPnI3aVZEi+mPFpKThuma06kEBmYnNIxW1rjsOISVGljS4x77cqorpyUhNO+rPtWzh80RsSAnLgxTMYZqd2lOQc/H2SR3rxohbOH6xFFfz3tK8Pm0dn4TWXjG0Z+G7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J0ROXMkD; arc=fail smtp.client-ip=52.101.56.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i57ArjbcTjIYsOimAW+ME6Il39RVvkMq4KDHC6efGzJMmqAitdXWzWtTnF0dYmIHXEFznro39NwBgY5QqQ8k2c9ZQdcnslACGKL+m09BaM2A/OwTvP1Emskfg9kT7JapvoLZox24UEtJXU8DaM9I576DmuwfhCmdKBZAewC1ejig0xZZmIw8vbwdid24+RY+hgLMfwztNY5pkEt1q8JxxVT0SFSveCvyJP1kQXHMYQex+q91yLVa1mfC9/clj4NmhLfnPd1qd05V8brSKGqMgJBGweG0uKPZmcanucbbtMfuIrNW1+mS+45/7aA2zoxxXG4AFPsNegdRWDs3/QQa+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NzdrzjaIvhxetwaT7h3BO8bBWRm8z/285Z1FwMgOJo=;
 b=pNHPEFcfQ7IdJT/XA2mlKR2qclWdH/zA7FBTqS8LgJm2fT7sgIxEZBzNIKUWixJarLMmFI7ozGdgeQiYo2ruJ2VNtslc6ZhAjn88vS/wUhir57ECVofaw4LhNRuVNbpWuc6iqcJIXTbungKB7Ma8wSfG/uj3EiGxbDU/6PGM+TpTULf6AqTTmQmGa3fqNJqNaHZctT+JxByF5zU+Pv5vDDTQFKqrVWSvTx4DPdz+z4lygWou48xyy8fl9aCqk+Qj5CKuakUGm03Fhvb2bfXH7PaV8yGwm2yBOgymLZxQCO8rE7g/jUCQ52hwf6ZyaVmh1kokp3koMFJO8/P0UfGxvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NzdrzjaIvhxetwaT7h3BO8bBWRm8z/285Z1FwMgOJo=;
 b=J0ROXMkDQk7vpksAqW3267reXIDvk25zbENZ/Y7PbDGvbfatFyDZfECbVNUTtrcUjWiWVygkAGGlWPDIs5IvhHPjlW5dwt4qYVVF3je4Mmxmt/aNs1c0CkskA/7ZPdWP6W9fx/j0fdrNAo4BDdjhHqD2RT3MS1WgxET4ELCyDMiNfYp4dLDwC3J9tXqjiRQC8loeWWhKpbHp6DFLCn40rhyCChQEV6A5S1CRfGHZBkhSsITZEvHHpc43dsE6NXYP2DNHcVWKdwvLuH/cSZDC10gnyRXI1zZjZnCNjSRKXeTkRdKuP8+LIdHsA8lcTo/4gXfe8Zd9Oz/aJ38+AowtxA==
Received: from SJ0PR13CA0229.namprd13.prod.outlook.com (2603:10b6:a03:2c1::24)
 by SA1PR12MB9516.namprd12.prod.outlook.com (2603:10b6:806:45b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:15:35 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::f4) by SJ0PR13CA0229.outlook.office365.com
 (2603:10b6:a03:2c1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.6 via Frontend Transport; Mon,
 26 Jan 2026 07:15:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:15:35 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:15:17 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:15:17 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 25 Jan 2026 23:15:14 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>
Subject: [PATCH net 0/3] mlx5 misc fixes 2026-01-26
Date: Mon, 26 Jan 2026 09:14:52 +0200
Message-ID: <1769411695-18820-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|SA1PR12MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: fa1fabe4-93c1-486e-e01f-08de5caab32d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D2UMKDZr3x14Ks1wP0mJtTqdq2wxBsHnrVpjyNMcedjjv95Q7TzGHcgmi8ky?=
 =?us-ascii?Q?xXRwR1uoMbadIF+6N3XJiQLPmVadnyd6WmceMczEyQqvGlPbKAkk5mF+57eY?=
 =?us-ascii?Q?wG7lZ8k3MuMelvDFkMc/wjkAQKhgFpBxatdN6DPYpZiNVHvCppRBNLDaLwlM?=
 =?us-ascii?Q?BUEYq9QkLxzB9obHB0watds4iIH2B9w3H/OBQXT0W1B/LnU+X1TF4VwIv+fr?=
 =?us-ascii?Q?lpEejLWPlgTD9UVd/gJau1mRJWsS5UU7Jk/Oxo8/YVgA5/EsbIyswnu1EXgb?=
 =?us-ascii?Q?kP69P3OPgNwwpzWb7NeKCbceJGUIXKxQl+88AFHoSdrI+iMcmuhSmSlT4s0Z?=
 =?us-ascii?Q?I7OveP84KWnN4/IHeNRzQukg1rK3UWZdC2P0/mZHF2ATuQoqt+AP3SE0IkyJ?=
 =?us-ascii?Q?DgiBM8i/rUn0GgXmkiUXfBmTP6w/bpwNpwnpwNvx88q8rgbTsMlkUfLJ+dum?=
 =?us-ascii?Q?ZVnXkCSzf0Vv1v01TGvY0dgTd0D0qgpG3sj1Byp6jHsqUDd3OUp20bNSsMB8?=
 =?us-ascii?Q?GFlwk37IGFK82iayDyRAXCyyKqbLPyQJyvLk0vKFSJ/ifUArPf1sCD2/MUPk?=
 =?us-ascii?Q?Y5pJP0Cs/H0duSjyFmrQuxOO0ttr2BgynvhJvnZGLr+0DCp08VBBcgCSY5h/?=
 =?us-ascii?Q?QPCg/U1Ie7CS1q/DmnOhJZcSZ5McH6cDcOIfWDQkpLU4/dTbrn59tdU0zFBE?=
 =?us-ascii?Q?soyLgP1UhjzuunJbaXVBKQI83m7snYn3W6mQ4Fe8Gq5+kp3x+2dWg8CbzHQv?=
 =?us-ascii?Q?WcyDdUJ/cHqTe3SQqCxZUgZWlaTUvuIXlXgulD6AWCvksLvmCWJsUSbV0cEO?=
 =?us-ascii?Q?qNO6Wks1GpzS5S1ZlNWA6NhcBsa3Aet2mmCtvdjLhI7U2I2hCI7kor/RGcU3?=
 =?us-ascii?Q?cS4x2+Kw+ewGj8uWb4yZztDtuESvmc76tu2djoG+MmwuR8e+5uT4k9vLiCpY?=
 =?us-ascii?Q?RaVWSeMQ0jMK6UKaMeVxpYHWf9WMeBb9EZOSRqYux061SPkZ/Cg6FEF9Fg+K?=
 =?us-ascii?Q?uIxNvYgA/w1C/KaTZ8jSs9/ppD3Q5mGnCphCiTsVAcHleLe33lGUDfwFBjEW?=
 =?us-ascii?Q?pdJSnZYqO7lAoLbcx8F8RHtH9Onq1W+GbHHvr+u0ewJ1VjH93q2Ke2Mn+dxE?=
 =?us-ascii?Q?T0lBjcFe998+1Ne0sPvX+GYO0ZR1T6aXf9we6ogF+tj26LSqM0dC7A2z7VlQ?=
 =?us-ascii?Q?XrqU5hTJmAcwMCVF8Lhtt772nEFFIKM6yQH3eTlyX57dfGRjYxWqNEM+aQj7?=
 =?us-ascii?Q?vq8PCnDEB3QLnrphuiDvwIlNyqiH2KXBGM3bcS/k+Mh5dHEHEEW6jh4BRw2x?=
 =?us-ascii?Q?nlv1u3nHL2dOoRneequG4LnkXZgRYpqAxIcubwQbQUCStJyttbPRfhNmInLD?=
 =?us-ascii?Q?FVtrDYBhbPofk4MA1qonW/gbmXjcyH0bFqXPWncR2Nz/uX9HbXYbNymS51wE?=
 =?us-ascii?Q?Fa6RsJnXvCs9ABTQ+p4gKj3dDJxyMgWG4tLD7gJUgtZHa8OHA3hp6/YN/9Ug?=
 =?us-ascii?Q?sBMm5O/VJr84e556eXQlnvWAOpfYbtmg4pAF3e6WP3VZSlnRqEzhkswHNb/b?=
 =?us-ascii?Q?7KFFzzxt3sDhhMyEzlEKhIDyAsSksLSfK0YbqerJO2mAV4Diql0XHuTypOKr?=
 =?us-ascii?Q?XThPTtQlMb6dLDfSuXO8Apk1Pw7jeF/9UYjiJiAa1YOnwEHyBfYLZC/LMjNd?=
 =?us-ascii?Q?zmsgfg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:15:35.2845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1fabe4-93c1-486e-e01f-08de5caab32d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9516
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16007-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D2C8584BAA
X-Rspamd-Action: no action

Hi,

This patchset provides misc bug fixes from the team to the mlx5 core and
Eth drivers.

Thanks,
Tariq.


Gal Pressman (1):
  net/mlx5e: Account for netdev stats in ndo_get_stats64

Mark Bloch (1):
  net/mlx5e: TC, delete flows only for existing peers

Shay Drory (1):
  net/mlx5: Fix Unbinding uplink-netdev in switchdev mode

 drivers/net/ethernet/mellanox/mlx5/core/dev.c | 14 ++++++++++
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 21 ++++++++-------
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 19 +++++++++-----
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  4 +++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 26 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  1 +
 6 files changed, 70 insertions(+), 15 deletions(-)


base-commit: 709bbb015538dfd5c97308b77c950d41a4d95cd3
-- 
2.40.1


