Return-Path: <linux-rdma+bounces-16989-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFQWLIBqlWkzQwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16989-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 08:30:08 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59758153AE0
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 08:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2504C3010B79
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 07:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D41427F010;
	Wed, 18 Feb 2026 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="seJuerZ/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012029.outbound.protection.outlook.com [40.93.195.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EE63112B0;
	Wed, 18 Feb 2026 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771399805; cv=fail; b=uT5/s75eCS8x0EhSvCugULpvdAim7bKeHS42FcGjaYGVBSkxW2Oi2hgNolRIrrI9t+B4hEG9slTwW2eHHV4+dJB021HhgTXO24IV+z9r2bxK9cCBNxh6fW/gYtMDVEToqThIN6XDEEZN49BIaS6o6v9yrMIhYn5CLUyeZdca8aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771399805; c=relaxed/simple;
	bh=WWWThDdihHK/FCNimkD6tKtl3H0QJYYPAAv7e2oy/R4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VHJ49nZ2GCvtqAy2w3xceH1EQtog3L6JBbYvrMAzk+r+C4ObGVAN4W5YP9dMc73ixCyXs1Ydj+stGRIFZuHuF8BKE8gjAeNx5niJhlOWWNrdJT5+s2dNw2ginggs/J9u8PGNcE/TqDfIrcnfq/lte88iT4P/IC5pi01DoOKzo3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=seJuerZ/; arc=fail smtp.client-ip=40.93.195.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACwVdb0eX7VuxL8RB4argR2q5hD0ZVSHfFHU6ezjlymAk4VmETaIMFqUil6Dakm1u7vPGnrhNBJKJhahqFLDBIQR5Rw/ZdWU6N6XUxBACNVIgUhUmofPEzLglXX8Z82KG0oMjcL4Y4BIDiHLOoVjkX0JQFx9fFk4mWH8kgxXoiWxwPqfK8DJrlr4W+A7kZEfiKKxr/bsWgyu24PUfjDXOF1MDaHa0ksfwKiXWdOiqDOkhLCFo7gmYodM52trefJeD4iLbx4d7gDtSm7VjW5JTYz4mtapf46/5qTsTqK2MMga+aBxhDZPp+gNz60C419j/fW+/7RfP4yelGExj3tIAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZB/7iCf8oLTvLJvv/PqL17rlCXV1SWNkrfe2spFdnQ=;
 b=eWI1Bo2W7ik0awlpTaYLciP3KKPu6T0MuaXPp6mIXeUxYXXqc/UDHgagFdTjdh3XJHmn1cBx+MRpkMkcn64imuFmkGm8ZRC5GjXNIsfqe8+RXZFOFrmAj0hZGy9t+i3bHXJihsZC5RaOIgMSoi7mNHUfd9DeP5yBLi9KWcFlf/Xr0ilSWEpAm6/lcwly6vgJqV74uqtd9RFnrZx1f25X09FBPrndpPBjDeFg+LP9+1eMG9pKZDhZMY6us/hQDsaRDD+KZ+kA0Qk6AZXT72882h978Ora5VBiV4X8ObKDHxZha/ZPqDAvMY/9V1Iq0yMaeW24lF4NgZ5s2rKGenqOXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZB/7iCf8oLTvLJvv/PqL17rlCXV1SWNkrfe2spFdnQ=;
 b=seJuerZ/f9fUi/PWS25gJpndpdzfBIp8Jmvn2hHVy+6ywzCMqOa0QX1EdMCyFavkPo0LNRs8B6WT7y0r4jM8oThQmHlsc4EkqV6Yk7oYwe5B7ndyczMU6IXhYzm4P+A2IfWtLhkh7FRmBqCb0/tuvOmmPA/gbZpEe006y6V2Pe32km4aGg4AoLHBYk/fLz4pfidQSAqryYLzp2MYrNSIG+bfxJZjtycTa0Cq9WgRhwgQhRFmRC21bQdvDoQNascMGSzU3tkiWhwSofULzoIusCxJI+P8XU9pM66LUjrtRxOcEln2vuHbpFTaaSDSiWSNUotK+SfG3tKdKLi+1Mej1w==
Received: from BN9PR03CA0496.namprd03.prod.outlook.com (2603:10b6:408:130::21)
 by BL3PR12MB6643.namprd12.prod.outlook.com (2603:10b6:208:38f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 07:29:55 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::3b) by BN9PR03CA0496.outlook.office365.com
 (2603:10b6:408:130::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Wed,
 18 Feb 2026 07:29:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 07:29:54 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 23:29:43 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 23:29:42 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 17
 Feb 2026 23:29:38 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net V2 5/6] net/mlx5e: Fix deadlocks between devlink and netdev instance locks
Date: Wed, 18 Feb 2026 09:29:03 +0200
Message-ID: <20260218072904.1764634-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260218072904.1764634-1-tariqt@nvidia.com>
References: <20260218072904.1764634-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|BL3PR12MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: 8219a132-475a-4730-b396-08de6ebf8304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k0j7BKg+qL+xRIMQ3dWxCZwxqQAZkjMdq5ihlXarQdM5zNOpQtJC8xDiZB4B?=
 =?us-ascii?Q?cnHBt5wriJ7diwLDH4p6nZolX5wUmOEQcB4fVgGDKRHyT5MLPxz0RqLQw3IC?=
 =?us-ascii?Q?v4Ayyrx7fgGK3ijAyInsAWGI6UOEUinMmX8jP9DkrVEF2gP8CaQ/+p1ufk34?=
 =?us-ascii?Q?C/FnZ+xJs2YLqCifoPR0j1HXck/1rR+eRw7tpq5naKvNTA3TSYb1zHieLa40?=
 =?us-ascii?Q?6d96NSmkkEDxYEB8NMau2H1JY4zu1QJEV7teCypQj+WosaDcRZlmSPPyLQhD?=
 =?us-ascii?Q?dZ8/NkeMXRVzW/ok7k8Dei5KgRcMOPRofAf+G+B7bfbOdNy6QUrFEZrpq0Zz?=
 =?us-ascii?Q?l2dZ6/JBE5HZ0K9i/3Ivu0GUg46FZrN1WNJ7/P5ll3dNC4VJ8nD5Tein423H?=
 =?us-ascii?Q?po7N7v+FGZeu0HjCdmRtIxXDTZXqw3480hLYwsmRK3C0xm6qGcZ1fGeb82sM?=
 =?us-ascii?Q?3lra1TDPtvYrpKxM6JQQn4wjGraucD2q6TxHt7KAF7Wc9iv5/2JoV1nDFGD6?=
 =?us-ascii?Q?OmFs0XZDi5RVgQBALbEphYQfwqQB3A9zXTk7NF7OUCNaj/J2an0oKRT+uRjs?=
 =?us-ascii?Q?d4IfiR7qSGmw9RGg2ph5RertFaYSiq9IO5Kgb4JWg9M5A0COUkoSdU5QV6Zz?=
 =?us-ascii?Q?+Wywg9O4brJozoMsibQ6tMnuM2hWAv5FyaKdUYaiM/ieKtbOYsxy9TEcC6xP?=
 =?us-ascii?Q?ptJ5uMQx3AJgB43TPdHuxYAKpD3Msdg5Wc8WcKDavJJZsyiT4wbMD3VjaQQ1?=
 =?us-ascii?Q?WWsO9vB/ib7MnDfZHQ/U/uzzUH5fbf9++6Qa3SkmaTvdKv4wRcBBvkH+r1Cb?=
 =?us-ascii?Q?OWCFjmGruEiVlAw60gueQ+J4qRnHq55s52v+JeFNLLGBt1BBZo/eM3DlH63O?=
 =?us-ascii?Q?FNmWcrTxiwpSozKC3a5DCuNawbqRA6ZjZMDZh0JIxFBN09BRNTAop1mL7hA0?=
 =?us-ascii?Q?pmg8rMRkwKDwuG6FBY2LQ/njrfFKf6ROIsqlSb5YHPpuSrpapxLy0nfQusrk?=
 =?us-ascii?Q?CbZWOwamawT5FVCQL3MQjZQIZKXdHSEuRtKDtC9j1V1raKw1OlEq7pL5lJBG?=
 =?us-ascii?Q?zUyoyVBl6WUJqspVjsh0v6ZxEpk/v9G5ta1DvSD3idvlyWOAbBC+P9mMABjO?=
 =?us-ascii?Q?n75R24uHEs//kIi8KGJaB94/oSgDrUWKe0QDH/Nk7W0NHAdmWRBRpDQceIdN?=
 =?us-ascii?Q?84HPCmeZqYuWuoJ89odAIqPEHRUuhqmzs633Avow4o74qmK26JFGMYA1nRCe?=
 =?us-ascii?Q?Mqvm8YKe/M5e5WuWRESTl/ycfkzLX4ivyLBGJvKcQZpEX+uxIJaOHScnRfO6?=
 =?us-ascii?Q?3tP67M2Cc8Z38JZ9LEMZFwM3Myso2wDj5lpQ82XuG6H2/Bx+b3Aj8z3og0Q3?=
 =?us-ascii?Q?VcNVsUfmTJRf7+ITxowRq6R1omWzo2jauFKUnKRswfDzdBdBQwMOSbhdnDG4?=
 =?us-ascii?Q?C4zk1HjMi8mRHXAaVj6Yon23PTcmxLLM8i65kI/qdTzOlV+SlC3ZMTPM6tTn?=
 =?us-ascii?Q?/R01e6u/au1+tUZtagfygOEiGiyF92qW4HmXgTLaLJ7CI/OqbginTVhJ9Iy4?=
 =?us-ascii?Q?o5JC1uLBmKi4F/i+gt3msMlQ9gajhHt+EEylM1aeRDz7JbvZlxfeMMFGMl3C?=
 =?us-ascii?Q?+9DPCLfvPM6CXwToS3FRWsXkX4csJn9gxM/8VmxdY7jkjBFLiHLZJ+6KoIq0?=
 =?us-ascii?Q?1Zk7TQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TGfVqjpacVpcGMUy7xl30ZAZUgbEdXMF27ezeC3NbVNXqWm3TV2T3f0tyaGEyNPXpm28Vz1vi22gQTfbGZdpVgI4m1MrBRAWVNYHCsbnOXuSBfcAdXkusXilybGPXablrjxUhD+XHHD0MFOf9RUznV6V/ApQCgIX/H6fVgWIA+5Bix0o55UoQNVXBpLzQzpyIkw+6ir+3wunZlh4Vne77Ec/ufKla+l3xVIQ3UV+8X9x0JaGu3/g+jC3xWhc4OOtBfb/8NWTW5ttIois61UcfaRQXy9lJc3ms4ESYeIO9S+Hm2nwu85rd2KEw14Za3i1bxNBfTWDWGNSTh8uRxvPS5D+NFilCYAwerSokA1x/1kryywQZnFH2mpVWsGq5ZswMCcZ2lCcb6NMNXPyhUq0z6BWy6NfofYh13blH4qcc69JMXD7u4AKSIXVEdyOgtKm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 07:29:54.7320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8219a132-475a-4730-b396-08de6ebf8304
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6643
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16989-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 59758153AE0
X-Rspamd-Action: no action

From: Cosmin Ratiu <cratiu@nvidia.com>

In the mentioned "Fixes" commit, various work tasks triggering devlink
health reporter recovery were switched to use netdev_trylock to protect
against concurrent tear down of the channels being recovered. But this
had the side effect of introducing potential deadlocks because of
incorrect lock ordering.

The correct lock order is described by the init flow:
probe_one -> mlx5_init_one (acquires devlink lock)
-> mlx5_init_one_devl_locked -> mlx5_register_device
-> mlx5_rescan_drivers_locked -...-> mlx5e_probe -> _mlx5e_probe
-> register_netdev (acquires rtnl lock)
-> register_netdevice (acquires netdev lock)
=> devlink lock -> rtnl lock -> netdev lock.

But in the current recovery flow, the order is wrong:
mlx5e_tx_err_cqe_work (acquires netdev lock)
-> mlx5e_reporter_tx_err_cqe -> mlx5e_health_report
-> devlink_health_report (acquires devlink lock => boom!)
-> devlink_health_reporter_recover
-> mlx5e_tx_reporter_recover -> mlx5e_tx_reporter_recover_from_ctx
-> mlx5e_tx_reporter_err_cqe_recover

The same pattern exists in:
mlx5e_reporter_rx_timeout
mlx5e_reporter_tx_ptpsq_unhealthy
mlx5e_reporter_tx_timeout

Fix these by moving the netdev_trylock calls from the work handlers
lower in the call stack, in the respective recovery functions, where
they are actually necessary.

Fixes: 8f7b00307bf1 ("net/mlx5e: Convert mlx5 netdevs to instance locking")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/ptp.c  | 14 -----
 .../mellanox/mlx5/core/en/reporter_rx.c       | 13 +++++
 .../mellanox/mlx5/core/en/reporter_tx.c       | 52 +++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 40 --------------
 4 files changed, 61 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index 424f8a2728a3..74660e7fe674 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -457,22 +457,8 @@ static void mlx5e_ptpsq_unhealthy_work(struct work_struct *work)
 {
 	struct mlx5e_ptpsq *ptpsq =
 		container_of(work, struct mlx5e_ptpsq, report_unhealthy_work);
-	struct mlx5e_txqsq *sq = &ptpsq->txqsq;
-
-	/* Recovering the PTP SQ means re-enabling NAPI, which requires the
-	 * netdev instance lock. However, SQ closing has to wait for this work
-	 * task to finish while also holding the same lock. So either get the
-	 * lock or find that the SQ is no longer enabled and thus this work is
-	 * not relevant anymore.
-	 */
-	while (!netdev_trylock(sq->netdev)) {
-		if (!test_bit(MLX5E_SQ_STATE_ENABLED, &sq->state))
-			return;
-		msleep(20);
-	}
 
 	mlx5e_reporter_tx_ptpsq_unhealthy(ptpsq);
-	netdev_unlock(sq->netdev);
 }
 
 static int mlx5e_ptp_open_txqsq(struct mlx5e_ptp *c, u32 tisn,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index 0686fbdd5a05..6efb626b5506 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Mellanox Technologies.
 
+#include <net/netdev_lock.h>
+
 #include "health.h"
 #include "params.h"
 #include "txrx.h"
@@ -177,6 +179,16 @@ static int mlx5e_rx_reporter_timeout_recover(void *ctx)
 	rq = ctx;
 	priv = rq->priv;
 
+	/* Acquire netdev instance lock to synchronize with channel close and
+	 * reopen flows. Either successfully obtain the lock, or detect that
+	 * channels are closing for another reason, making this work no longer
+	 * necessary.
+	 */
+	while (!netdev_trylock(rq->netdev)) {
+		if (!test_bit(MLX5E_STATE_CHANNELS_ACTIVE, &rq->priv->state))
+			return 0;
+		msleep(20);
+	}
 	mutex_lock(&priv->state_lock);
 
 	eq = rq->cq.mcq.eq;
@@ -186,6 +198,7 @@ static int mlx5e_rx_reporter_timeout_recover(void *ctx)
 		clear_bit(MLX5E_SQ_STATE_ENABLED, &rq->icosq->state);
 
 	mutex_unlock(&priv->state_lock);
+	netdev_unlock(rq->netdev);
 
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index 4adc1adf9897..60ba840e00fa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -1,6 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (c) 2019 Mellanox Technologies. */
 
+#include <net/netdev_lock.h>
+
 #include "health.h"
 #include "en/ptp.h"
 #include "en/devlink.h"
@@ -79,6 +81,18 @@ static int mlx5e_tx_reporter_err_cqe_recover(void *ctx)
 	if (!test_bit(MLX5E_SQ_STATE_RECOVERING, &sq->state))
 		return 0;
 
+	/* Recovering queues means re-enabling NAPI, which requires the netdev
+	 * instance lock. However, SQ closing flows have to wait for work tasks
+	 * to finish while also holding the netdev instance lock. So either get
+	 * the lock or find that the SQ is no longer enabled and thus this work
+	 * is not relevant anymore.
+	 */
+	while (!netdev_trylock(dev)) {
+		if (!test_bit(MLX5E_SQ_STATE_ENABLED, &sq->state))
+			return 0;
+		msleep(20);
+	}
+
 	err = mlx5_core_query_sq_state(mdev, sq->sqn, &state);
 	if (err) {
 		netdev_err(dev, "Failed to query SQ 0x%x state. err = %d\n",
@@ -114,9 +128,11 @@ static int mlx5e_tx_reporter_err_cqe_recover(void *ctx)
 	else
 		mlx5e_trigger_napi_sched(sq->cq.napi);
 
+	netdev_unlock(dev);
 	return 0;
 out:
 	clear_bit(MLX5E_SQ_STATE_RECOVERING, &sq->state);
+	netdev_unlock(dev);
 	return err;
 }
 
@@ -137,10 +153,24 @@ static int mlx5e_tx_reporter_timeout_recover(void *ctx)
 	sq = to_ctx->sq;
 	eq = sq->cq.mcq.eq;
 	priv = sq->priv;
+
+	/* Recovering the TX queues implies re-enabling NAPI, which requires
+	 * the netdev instance lock.
+	 * However, channel closing flows have to wait for this work to finish
+	 * while holding the same lock. So either get the lock or find that
+	 * channels are being closed for other reason and this work is not
+	 * relevant anymore.
+	 */
+	while (!netdev_trylock(sq->netdev)) {
+		if (!test_bit(MLX5E_STATE_CHANNELS_ACTIVE, &priv->state))
+			return 0;
+		msleep(20);
+	}
+
 	err = mlx5e_health_channel_eq_recover(sq->netdev, eq, sq->cq.ch_stats);
 	if (!err) {
 		to_ctx->status = 0; /* this sq recovered */
-		return err;
+		goto out;
 	}
 
 	mutex_lock(&priv->state_lock);
@@ -148,7 +178,7 @@ static int mlx5e_tx_reporter_timeout_recover(void *ctx)
 	mutex_unlock(&priv->state_lock);
 	if (!err) {
 		to_ctx->status = 1; /* all channels recovered */
-		return err;
+		goto out;
 	}
 
 	to_ctx->status = err;
@@ -156,7 +186,8 @@ static int mlx5e_tx_reporter_timeout_recover(void *ctx)
 	netdev_err(priv->netdev,
 		   "mlx5e_safe_reopen_channels failed recovering from a tx_timeout, err(%d).\n",
 		   err);
-
+out:
+	netdev_unlock(sq->netdev);
 	return err;
 }
 
@@ -173,10 +204,22 @@ static int mlx5e_tx_reporter_ptpsq_unhealthy_recover(void *ctx)
 		return 0;
 
 	priv = ptpsq->txqsq.priv;
+	netdev = priv->netdev;
+
+	/* Recovering the PTP SQ means re-enabling NAPI, which requires the
+	 * netdev instance lock. However, SQ closing has to wait for this work
+	 * task to finish while also holding the same lock. So either get the
+	 * lock or find that the SQ is no longer enabled and thus this work is
+	 * not relevant anymore.
+	 */
+	while (!netdev_trylock(netdev)) {
+		if (!test_bit(MLX5E_SQ_STATE_ENABLED, &ptpsq->txqsq.state))
+			return 0;
+		msleep(20);
+	}
 
 	mutex_lock(&priv->state_lock);
 	chs = &priv->channels;
-	netdev = priv->netdev;
 
 	carrier_ok = netif_carrier_ok(netdev);
 	netif_carrier_off(netdev);
@@ -193,6 +236,7 @@ static int mlx5e_tx_reporter_ptpsq_unhealthy_recover(void *ctx)
 		netif_carrier_on(netdev);
 
 	mutex_unlock(&priv->state_lock);
+	netdev_unlock(netdev);
 
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 4b8084420816..73f4805feac7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -631,19 +631,7 @@ static void mlx5e_rq_timeout_work(struct work_struct *timeout_work)
 					   struct mlx5e_rq,
 					   rx_timeout_work);
 
-	/* Acquire netdev instance lock to synchronize with channel close and
-	 * reopen flows. Either successfully obtain the lock, or detect that
-	 * channels are closing for another reason, making this work no longer
-	 * necessary.
-	 */
-	while (!netdev_trylock(rq->netdev)) {
-		if (!test_bit(MLX5E_STATE_CHANNELS_ACTIVE, &rq->priv->state))
-			return;
-		msleep(20);
-	}
-
 	mlx5e_reporter_rx_timeout(rq);
-	netdev_unlock(rq->netdev);
 }
 
 static int mlx5e_alloc_mpwqe_rq_drop_page(struct mlx5e_rq *rq)
@@ -1952,20 +1940,7 @@ void mlx5e_tx_err_cqe_work(struct work_struct *recover_work)
 	struct mlx5e_txqsq *sq = container_of(recover_work, struct mlx5e_txqsq,
 					      recover_work);
 
-	/* Recovering queues means re-enabling NAPI, which requires the netdev
-	 * instance lock. However, SQ closing flows have to wait for work tasks
-	 * to finish while also holding the netdev instance lock. So either get
-	 * the lock or find that the SQ is no longer enabled and thus this work
-	 * is not relevant anymore.
-	 */
-	while (!netdev_trylock(sq->netdev)) {
-		if (!test_bit(MLX5E_SQ_STATE_ENABLED, &sq->state))
-			return;
-		msleep(20);
-	}
-
 	mlx5e_reporter_tx_err_cqe(sq);
-	netdev_unlock(sq->netdev);
 }
 
 static struct dim_cq_moder mlx5e_get_def_tx_moderation(u8 cq_period_mode)
@@ -5105,19 +5080,6 @@ static void mlx5e_tx_timeout_work(struct work_struct *work)
 	struct net_device *netdev = priv->netdev;
 	int i;
 
-	/* Recovering the TX queues implies re-enabling NAPI, which requires
-	 * the netdev instance lock.
-	 * However, channel closing flows have to wait for this work to finish
-	 * while holding the same lock. So either get the lock or find that
-	 * channels are being closed for other reason and this work is not
-	 * relevant anymore.
-	 */
-	while (!netdev_trylock(netdev)) {
-		if (!test_bit(MLX5E_STATE_CHANNELS_ACTIVE, &priv->state))
-			return;
-		msleep(20);
-	}
-
 	for (i = 0; i < netdev->real_num_tx_queues; i++) {
 		struct netdev_queue *dev_queue =
 			netdev_get_tx_queue(netdev, i);
@@ -5130,8 +5092,6 @@ static void mlx5e_tx_timeout_work(struct work_struct *work)
 		/* break if tried to reopened channels */
 			break;
 	}
-
-	netdev_unlock(netdev);
 }
 
 static void mlx5e_tx_timeout(struct net_device *dev, unsigned int txqueue)
-- 
2.44.0


