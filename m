Return-Path: <linux-rdma+bounces-21778-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5SVEGNWGIWqFIAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21778-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 16:08:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 51254640ADF
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 16:08:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=KW3O2COc;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21778-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21778-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F0DDE301236D
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 13:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7267847ECCB;
	Thu,  4 Jun 2026 13:51:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011046.outbound.protection.outlook.com [40.93.194.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1444847ECC3;
	Thu,  4 Jun 2026 13:51:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581113; cv=fail; b=pkFRO1RGvuDV58+2/JyM1FEN0eAeqrakIzZr0fvOFLv0RbmNk45eC1Tk+doq7Y/8sNaIrZbVUYTncjJcsCZSYziI+Hkj5nHUALjXDI9W/4iTUYLKGxRR7pBTN9sz5lOxui8kWRdecDiLufR51H4ybjpYMHCGjGVRPG7WEBy0TRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581113; c=relaxed/simple;
	bh=vYP5bbJhJPPRc1tFivncDetOzN5U1ZFMLkyzMB/76B8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q4mLIn1YOJ3KLZML/zRyxOLLP+tl9iARDD2dqfy3jQEMZpeEqtP46nqZ4pMPuCjQXQIlQmkSGdnWFatNlnJlLqa0A/pGf9ae7dacGOYmPlgQhIb9xYo0KuTfVhoP/oP845G9CVGatjgSgvqVA19glGoFpTxCcKBLjUSM1+Pul2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KW3O2COc; arc=fail smtp.client-ip=40.93.194.46
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfzquK6G5MbVp+4SDMqgd1iyzYQxXIaOV8o4jcr29bHsKImXNfnMtuM40DlZ49lw45+/EC7G2XptojS1fny5QpZHF71umrylcndDaoJWVYSZpfmTsR4Qhd7xZwKvvjPu08YALfQh743aeF2jxaHm8xBk3RDcIAadyMc//wN60Qb8+ISSUBGf2A4AAoqu2ULvezfcJkcWiMPgRh0MyYsg/+OmDOfxvVQtRntLhv8DRpr4d0ODjDtDM79oN5IZqI4zmFbBGMoyi4LNdKvSeZSbBxMVQzHc0WGJYW7k+b0aoKSmZoi5EwxmfN6F1f6Shd46T3jArc6Yi+qED2FWpwiWiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3NcWMd8mrj5ZpGwq6P+GFo1m4990m7v7hXfiMI64ZI=;
 b=Kqm6ZZC6wuWC7GzZXGEpZkJxWAekbrN5Sy09lAYV5Gl+xRifmjc4Ux6Fw3Ek94v0OI2+IfByaMaOU3FxTc0PmnHYgb756nRGXEJJDPjyPRup2qiukJxcQFJXj7etiEW1ji+xLi92fYC6VKTrbIwucF8BH+LtpKYXtJk2zZbVY9RdbRrJapO0ET3WcX7ipJwN9hzLQz11B4LmU4hfF+eSP2+ijHSFSAj2YEP/zN3FdX8Erw0e6PlbM7NPlIJmcL4tYCJDbr7eibKevmcH4NmskJpaiSGNi0sfDJfpdZg/aByZp83HAzjJjp/EN2CibCHvO5NtPra+cWHDmiXm66XdWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3NcWMd8mrj5ZpGwq6P+GFo1m4990m7v7hXfiMI64ZI=;
 b=KW3O2COccKkr+k5f2Gg+Gj6fsCs1rKLyy2Rpg7ImzvJaV7tUlihganC8Z2jtHfiqCMOJm/x1OQqahdR1zXANS8IN+jVauAX+FPOV5pjjfADQbzMmbCyFY9LMUQsJwn//ILSokyjMYEJ32+c3tpH9gP6R+upcDLYSXWWKnhLXWBkYiViqCm3lbrKxNwEqOlSa/in81oumY287AZtj51PD/weK7/jPJR/FtR2WizW/XDBuTn1Em7vK3+9jxC7dUmxvHIu7hOpqB4WZz0xcAufYsTy3v/lUFliWV4fW4yctfOqH9zf94AiQNTcJZcprcJPrImouJr7f8nVXcj1umf6tvw==
Received: from PH7PR10CA0001.namprd10.prod.outlook.com (2603:10b6:510:23d::23)
 by PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 13:51:45 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:510:23d:cafe::7) by PH7PR10CA0001.outlook.office365.com
 (2603:10b6:510:23d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 13:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.2 via Frontend Transport; Thu, 4 Jun 2026 13:51:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 06:51:28 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 06:51:27 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 4 Jun
 2026 06:51:21 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Eran Ben
 Elisha" <eranbe@nvidia.com>, Feng Liu <feliu@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Gal Pressman <gal@nvidia.com>, Simon Horman
	<horms@kernel.org>, Alexei Lazar <alazar@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Kees Cook
	<kees@kernel.org>, Lama Kayal <lkayal@nvidia.com>, Eran Ben Elisha
	<eranbe@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Joe Damato <joe@dama.to>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net 0/4] net/mlx5e: Fix crashes in dynamic per-channel stats and HV VHCA agent
Date: Thu, 4 Jun 2026 16:50:37 +0300
Message-ID: <20260604135041.455754-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|PH7PR12MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 115fb58d-cf34-4dc3-ed33-08dec2406a55
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700016|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	HCUPedalXsVzimz6l4IytvznmcCtuJKLJZ+h/YNIGosiHybScBW+IdTZRmsBy2gtoXjYVybSMMqtAHQJzaNGt72r0vLLg4T9SEq59sBFGBPwO7e7KmPdE1XRkaLZB/+NCyGxbW6yzAoNKOeTDQuyeEqmpEycNc6c/qNCvDAea2amNGeVTMlCSmxJqe/R+I2QhWBuKIysumeJvG17c2kJRTXMhiRg/g/MDLE1BKaiuoD9j+2Yt4cmBU+DL5XUPiCfk27Kb5/aTvYDYWwmH6NDKQzuhoCYUkkAwDHfTCkw2XtIoTr4teHibOAkVFXMKpuS9b4RkCvo9lENYhOj+gkTE3r6/6l/PH3z69202ACg4LJRWmbE4ZnET6pvNaq/azyo1/Vt5bTslayetLBYvFxTcSt2c8MBM4wFbHT1c7moEvGauFdRz22ns3lipX9fZES/JdTNOHjR0t2lvZTs/yXK6uvfu3rJEN0gQY7TLbLKDQQoM2G7QCVk/piHH48Wtnqm4QLR+vzWjfsiUSbmjncFPt/a8Uv6/+gTZIEOZUSAoVbhmFxA7m6N2GWeKdfMbc8sytJV/0i6H6w/n8zcqEWY2sOaxE642+E6xXwsNcKOnF7j2b6dcSRI7WpzCmMPmnC9O5XuZYsfrgolCbI++XWTH6kIOI/qf9Z6/iLQsGUJb3vO4D53xACxriF2bMi7ii2INb1IrEziPxMamYvZJWEI5t/Mxy7aC7stRV8GRy6kV6o=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700016)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sOy03cHaBlFtFcgvqKlwdwUs8qOuLtG3dshqPJaQXBtjRNptETrvN0IYL6ibbIyMoQj3xHqWF9+AKedKellldn/dVjox07PP/7a7cdbkGpoU8kH3gCIghFCJQ1SYvUuXNsw9lnIIebzQ6k+9upXVvyph+bOxgZCN5BeFmU3/0uuCECNLloUmv8vptfdVK4vTUdVQFiocZhwqxqCg+Oit2uHL48jAo20Zyn3CMSKb28gKptbr78C78BtoA3g2NS+XkKPXkIaLkSth+SwHYIL8jnJP+NQgeYdXTvSKFDJ5uFuwRGxQydtUHHTYq6gmCNOOy3P4Nv6mIG0Hpq0O+dD11AB5eheaMbAC+rV/odOQLyo0m+4+tChHlO4K+P8SPG3iu5Ys18d+fjl9keeNmntFJkaRqtH3BIotkB34LtzS3H88cbfx2uUnA6BzJATE5SgP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 13:51:45.0191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 115fb58d-cf34-4dc3-ed33-08dec2406a55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-21778-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:eranbe@nvidia.com,m:feliu@nvidia.com,m:cratiu@nvidia.com,m:gal@nvidia.com,m:horms@kernel.org,m:alazar@nvidia.com,m:noren@nvidia.com,m:cjubran@nvidia.com,m:kees@kernel.org,m:lkayal@nvidia.com,m:eranbe@mellanox.com,m:saeedm@mellanox.com,m:haiyangz@microsoft.com,m:joe@dama.to,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51254640ADF

Hi,

Since per-channel stats were converted to be allocated and published
lazily at first channel open in commit fa691d0c9c08 ("net/mlx5e: Allocate
per-channel stats dynamically at first usage"), priv->channel_stats[]
and priv->stats_nch are filled in incrementally during interface
bring-up. This opened a window in which the various stats readers - most
of them reachable from userspace via netlink/netdev stats queries - can
race with mlx5e_open_channel() on another CPU and observe partially
initialized state. The HV VHCA stats agent, which is created before the
channels are opened, hits related problems of its own.

This series by Feng collects the resulting crashes and fixes them.

Regards,
Tariq

Feng Liu (4):
  net/mlx5e: Fix HV VHCA stats zero-sized buffer allocation
  net/mlx5e: Fix HV VHCA stats agent registration race
  net/mlx5e: Bounds-check stats_nch in mlx5e_get_queue_stats_rx()
  net/mlx5e: Fix publication race for priv->channel_stats[]

 drivers/net/ethernet/mellanox/mlx5/core/en.h  | 12 ++++++
 .../mellanox/mlx5/core/en/hv_vhca_stats.c     | 38 +++++++++++++------
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 15 +++++---
 .../ethernet/mellanox/mlx5/core/en_stats.c    |  9 +++--
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.c |  3 +-
 .../ethernet/mellanox/mlx5/core/lib/hv_vhca.c |  8 +++-
 .../ethernet/mellanox/mlx5/core/lib/hv_vhca.h |  6 ++-
 7 files changed, 64 insertions(+), 27 deletions(-)


base-commit: c05fa14db43ebef3bd862ca9d073981c0358b3f0
-- 
2.44.0


