Return-Path: <linux-rdma+bounces-10448-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF676ABE312
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 20:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5753B3C2F
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 18:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E5A2580F7;
	Tue, 20 May 2025 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CeZ/0ZjE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A0F1BD9F0;
	Tue, 20 May 2025 18:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747766850; cv=fail; b=P//IneQrcMznJ0fiSbSn2D57t+/gAD+A56TeP0Mj9j1mtxcfqujxGY+ODnSAS17WwvbB3fF0Rtf9AJIWWFfH2QNFDXTUrncm66bkAjaUiDcU/knwBYfp2hSzvt6Of8HevCc6bMTItuEuJhY5FmxB1KPzOfPIOcuSLqvmQw1048s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747766850; c=relaxed/simple;
	bh=n8YMGbuWzVhwVbdmDNQ+HDTtXLR9phPXX9tCAPPuEG0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d+BrrBg7bNcBTVCxiZZCgVBTxkzMM4w0f5ivdyArI6XtXI3Sm7JuuOZ9PppHVFxDb5XwTVZfsXuH6ejKzGY9akBIlX2HP76n3M44jRn9dopPA/TP50TG2OyZ76IUcKTW1geWfU9WoPgq6gFhatdAkwcUHtatCBVGIzavM0isw38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CeZ/0ZjE; arc=fail smtp.client-ip=40.107.212.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHiBNJ4Y2Yb7e/L5pyrzR/h/zx2aeG4L4bDrm9E1Y+2mRIR2Dna/iG5Esdrg1/aOhuWpXUprNDF6wmTGgaWUqjhETO62+KPz5a/CMoOHQK+kvtmf3c7uSBotzsJLg0dYobNuWZlJr6sdT2o4XnyaszIemv1Ebh8k+Pf9aE1TAWU1mid/u8W5HVq1iGT0UPrqk8QwhgJnSdwe6myBIsC8fl6NXMtjrLzMqfuTUDG/3NPy++LwDZMRCYV2CN9rzpF6XS9F9Eyam3wutiLzjofUK5SZFzqi5jThpfplD/wGMDJ/SMOdB+7K5+jftXJGltS7wISR3t7pya0vnz235uJuNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOegZuYxHgqRjIyzAC4qvPa6YAFO3jcRYj37v0GiGeY=;
 b=ovIqp8gQdpKhrZiDAe4KziJ04qd/lsZue0hbxIhwqqB2yFruel0QBOwEAJH4mkt/FcD8oLMzurqwKdUArOUSiaFkHQliEo6KQPfPA/CwfM7J2eTMP3IzP0iCNXgvS6mjiI8tEr2nz6zw8oqieobDTLf2doqafjDXvMy/UQ+qYXAqUT35ZDw1gh0g4KAAeZTD3oUC5rMtKDAb6PZD1kp7K+twA1wC0Wqj/mxRXDyYbzishw9ntahaFSlMrs3KI/Yqag/frDruFl85gdiOV+oWwfkQUbiARchVVy++ktNBY4wOGewIvaWefumZtZVuLKnNriZ3QKosnqDn/JN95uhXaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOegZuYxHgqRjIyzAC4qvPa6YAFO3jcRYj37v0GiGeY=;
 b=CeZ/0ZjECCG3XyI/KnegS6DL8ZS7cSVQ2eY0F/1QNVVBgugkszmlbIS1xmoidOm/+laJ7Qj1NcJsnlsVOSzOiXcrDzbpAL+VM0uuwJL/BSeUD68u4h/zfDrF9cFjCz7Mo+BdSDNS7uZVM9DP8Ww79oBkEvfPke0Vws6/xPYmAi5/lZGqXbJ2MMwhQJh6o8sdfvvVzpTd4/s7rjBCIte35YcFDnJfXHqnbnJOwOu8TMCXqeTzDpjbj5h5778mwNxh483lTrRT27uLLUyV/A+vkNAg0CPfPE1PdTDBSBMBQRaiTuMPj2kcpYW7881vIxddSQdOrg2UglnNGM5LcDK0eQ==
Received: from MN2PR22CA0008.namprd22.prod.outlook.com (2603:10b6:208:238::13)
 by SA5PPF530AE3851.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Tue, 20 May
 2025 18:47:25 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::92) by MN2PR22CA0008.outlook.office365.com
 (2603:10b6:208:238::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Tue,
 20 May 2025 18:47:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Tue, 20 May 2025 18:47:24 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 20 May
 2025 11:47:02 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 20 May
 2025 11:47:01 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 20
 May 2025 11:46:58 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next 0/4] net/mlx5: HWS, set of fixes and adjustments
Date: Tue, 20 May 2025 21:46:38 +0300
Message-ID: <1747766802-958178-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|SA5PPF530AE3851:EE_
X-MS-Office365-Filtering-Correlation-Id: ae14fb8c-0de1-426b-b988-08dd97cec30e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lk4AYTg0rmRcWPrGthqE7nAJGid6TWzhigpy3eNKcACukpASA/JBJS05296k?=
 =?us-ascii?Q?2Jx5EIOhznFSbbgcbqH/XkEbHycY26oWgtAh35KNulCUtBfoPp8m6hIqmaBV?=
 =?us-ascii?Q?JVaOhgX9pEhaKqE6KRLkO8e2RYLyYIjZSNGdCPzHUG5AhcghrUFZomZ0y9zy?=
 =?us-ascii?Q?w2VC4u90JlUtiea37OHyxz+jwMSIAEcGzCrD+k7cr1+3HlilZ8aZri9YE0kI?=
 =?us-ascii?Q?bMENEY8JrpNrR0xHNfHFjZJnRNVMicQwepjRtDALOWVXobLTpxKMxifnjEPB?=
 =?us-ascii?Q?SvvInTLVUOj2rBkIlbIC+DTqrv9opZwXVeSvmWceRGUaRuaFqiyjVH31+lkf?=
 =?us-ascii?Q?ot4tRMs4PGeCPAd5f1N404srUg5EnUlJ2Rt0H8vY2hvKyT02NEdfn+tKzZUR?=
 =?us-ascii?Q?VJb1Na6wiY1wnl202xbbq+2LCzRuIqpkYAzPnuSTBYqkUrpZbzpyaL7OeQV7?=
 =?us-ascii?Q?zyeiK5v+zagBbMlNyqhB/Lv51x3ahmWTbAmzs63ftZyFQemiEYRaufYjHBxc?=
 =?us-ascii?Q?a7jAvV9N2CvPuD8+mVd/jwHgyKTSqgSYyqV/Db7xUhcWcb6cGOQWhlkTn+x5?=
 =?us-ascii?Q?T15VUCB6bMZPpxPDOYkm45FAqlipk31LGrEaxgBXsv65o4m6jdpQzj8FSGMB?=
 =?us-ascii?Q?MwK8GDbsFN1lWPDKuAhUWw6tGlpJLuNXYg/5CviagFIOQXxpA870+7LrAneI?=
 =?us-ascii?Q?O93hwGI6vChtvTNFsePoyndSy1uTHWWLQ8vFzCPsdI+HlKdbsjYpyKbg+3vz?=
 =?us-ascii?Q?c8kRV02mbMQAVpdIZPg37nDB7XdZXg+IQ1p4Iso3fileNeIKF7zFyjxEaEwB?=
 =?us-ascii?Q?U8bJvp6utUdiec29/oTkqzfZqPvyXPSSBmbO3AVM2rl+jS1YAStRyuJ9kuQS?=
 =?us-ascii?Q?MZJN9O5vH21QWxIEw6Ri/3O5rvLx6Gw4EWH24oxEE3FAmwJ7rpbnnzbmGuZe?=
 =?us-ascii?Q?QeGw58/kUK8o9hxUWScATDid8V0ewpniVriXo48uzoeL5QoSW5nRPibH3Mna?=
 =?us-ascii?Q?Gf9ZZkqQBJsdAiYK4APu3jh+0KUpV0+zYQb8JN3RdF1n76tNWNxnTk59wur/?=
 =?us-ascii?Q?/Tgy7E5UQqO97PES9DgHP5JCCYhFpJPl+deBfy8S/0QNUWQWQJnYM3aqhExk?=
 =?us-ascii?Q?WOITzClnJvaoRafnXKNjGTsMJ6/HhNcPNHutlYDn+Kx4ydByEPYvR1ahVfp+?=
 =?us-ascii?Q?7s/FhGWG/Kjw6EYDecZUMmo+DUMbb70oDxwU/Dr6Sin4OhaxxFvDk/Q++POY?=
 =?us-ascii?Q?P6K9mTnbg29c2Hz1fNF1C7LjwWESYu81NBuq+cJHtdKC0OcwWK0aHICKuVeu?=
 =?us-ascii?Q?Tw+skDxufvB+iQcygd0yHA2rrebQrQkdUDdN+BSxUqCw/Qzb0qzmWvYo335A?=
 =?us-ascii?Q?roRl65myBoj1ymNZS+DFahkRDOYHgzSQFTY9jNho7TahuuxDIrKGvjmtL349?=
 =?us-ascii?Q?4B1fX6oM01+9aqccrxiC0oW7VaYflcBHIdhsld9mJOOH0sQOf3LH234RP4yf?=
 =?us-ascii?Q?gHQGt+sD6cuc3dunMg0Cd5pm2Vr/2GAC9PNo?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 18:47:24.5851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae14fb8c-0de1-426b-b988-08dd97cec30e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF530AE3851

This patch series by Yevgeny and Vlad introduces a set of steering fixes
and adjustments.

Regards,
Tariq

Vlad Dogaru (2):
  net/mlx5: SWS, fix reformat id error handling
  net/mlx5: HWS, register reformat actions with fw

Yevgeny Kliteynik (2):
  net/mlx5: HWS, fix typo - 'nope' to 'nop'
  net/mlx5: HWS, handle modify header actions dependency

 .../net/ethernet/mellanox/mlx5/core/fs_cmd.c  | 28 ++++---
 .../net/ethernet/mellanox/mlx5/core/fs_core.c | 31 ++++++--
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |  4 +
 .../mellanox/mlx5/core/steering/hws/action.c  | 71 ++++++++++-------
 .../mellanox/mlx5/core/steering/hws/action.h  |  2 +-
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 71 +++++++++++++++--
 .../mellanox/mlx5/core/steering/hws/fs_hws.h  | 16 ++++
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h |  9 +++
 .../mellanox/mlx5/core/steering/hws/pat_arg.c | 76 ++++++++++---------
 .../mellanox/mlx5/core/steering/hws/pat_arg.h |  5 +-
 .../mellanox/mlx5/core/steering/sws/fs_dr.c   | 10 ++-
 .../mellanox/mlx5/core/steering/sws/fs_dr.h   | 10 ++-
 12 files changed, 233 insertions(+), 100 deletions(-)


base-commit: f685204c57e87d2a88b159c7525426d70ee745c9
-- 
2.31.1


