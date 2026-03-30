Return-Path: <linux-rdma+bounces-18806-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKNSGOTRymmsAQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18806-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 21:41:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC04F3608E6
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 21:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18DB830205D2
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 19:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BEF39A807;
	Mon, 30 Mar 2026 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ke21T3QE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010041.outbound.protection.outlook.com [52.101.193.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDFE39935D;
	Mon, 30 Mar 2026 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899680; cv=fail; b=M9kO1FfqFqoaRO+W4aN1l5AYUHIEuIIm5FZYowbP0OBqAqcHg/ZRuyRY+lN1qjb6XexkhRJeeJaaQ88i9FEZFq6U3VXFF0TOaY8DibgBPwRQhu5+y3zVaiEw/P6M3vk2+S0ZjMSyZEd0rqYNbZsE2EVPLrJCXW8m+oZGhAPXmqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899680; c=relaxed/simple;
	bh=SXko9bEHTageMCG1mQmZ09NbM/reDCT4zWeJhw/JAuU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bOJEOrrIsHhRbqWPfy7Zv0rhXDYfawIO1alvgzHzlMQXxaR7sL7yawBS+J52I+lCJcm+UgmMeKfbWxz+X+nnPdvTFHbMRKA4/pqeVCjKeKu6mo6TAAraEF0OQ+g2zCWxgJq+LldzxgywUb3i2LDJLHnSX7QVVYNJSx8g+LBnmGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ke21T3QE; arc=fail smtp.client-ip=52.101.193.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzBOULJSw7yNGUPvM/PcVDJHS6JLIJhMBppOXEBz53YmWSn1jEc9X58SKjTwX33P3p4zN+CoGWvUCWo6a3rUBfY9KfpLg0Nx8KGaJ/ugacIUcOCsnMlCX1ORycElaKElyERusyHP3w1og8Wg3RrG72BuBvIpshKx9dSwzk7ii8Ezb88LiTFcloz/QJO29Y63YQFScZ5ZX89HLpW/UTbcNmky9SAnyyLCZEc/VG/mwml2r3YIgQfqNDDMgQ4hkaKkz9r7J8nyFwrVoTTdXVQSb+lcTrcW6u2zG8cpcQ5RPGvW7ppieNS4RH8E05tG26YD9OmBPiEmJ1djr3HmUBABXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yf0RxKMx+m59KsZCvyCeqxihoHFtAiNftYEbwN4oDTs=;
 b=a//v7YogKyumz9ZMSp1m/ow87tyPdOObeMZz4yvJzC+hEuxN61mh8eROV/CVBS+VWHkIAYfEmVeGiwdXa6alqCg7ZhBq1y3i9Z5sGJjVATcpDSTeKnCKfgr0tjK2nXb452ujUo+YgUJpB/ZaYaw0Cto7yRP25nhix7sKbOI0jk/rhYrS/U5ROsFQGr/XfKpwavlDJeGZYw5DIIO93eVqMdvmIKaTW9mdNN2SZUsAdXrwiydRXJgcw6RP+PDkhUy4au5nG6neJGD8TKv4vGzLsRtuFtky3TveRjn1LyglzO48NZGsIN/9mfU0vfjZL73wenZL0pFmObH0CopluO70rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yf0RxKMx+m59KsZCvyCeqxihoHFtAiNftYEbwN4oDTs=;
 b=ke21T3QE9qTYxptig0WiuQvYlTMFcBnB3r8FNNKtDOxAFQE+YdHBDusJGnQsfdoTJIqnAd2Zlk3jzQrhi9bABUgO+P3yA7OXYmf/hxuiOWV7xZ+hawITYGFvOJ4h4Bac8Pyglj+trb/KXQJEF0FLXbHaf5qSG7X85BzNJ+NKr0tEF6hg02DFl93XnEpqcGqosB2SOjH+w376Edpv+0lBa1RumBdoD/6aXfaMZDHF8bc2RQVId15i2hjItmicO4e4GpfETXm1RI9EuwokBIwG0G58/p/OR3hhZvlXIQjsIfZLtsRzglRGHJurzseuIywIlK1H/Ue6ug5O3spXuFDN2A==
Received: from BYAPR08CA0023.namprd08.prod.outlook.com (2603:10b6:a03:100::36)
 by IA0PR12MB7752.namprd12.prod.outlook.com (2603:10b6:208:442::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 19:41:12 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::32) by BYAPR08CA0023.outlook.office365.com
 (2603:10b6:a03:100::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 19:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 19:41:12 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 12:40:57 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 30 Mar 2026 12:40:56 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 12:40:53 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Shay Agroskin <shayag@mellanox.com>, Saeed Mahameed
	<saeedm@mellanox.com>, Jianbo Liu <jianbol@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net 0/3] mlx5 misc fixes 2026-03-30
Date: Mon, 30 Mar 2026 22:40:12 +0300
Message-ID: <20260330194015.53585-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|IA0PR12MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: f41afd81-d653-4aa0-39c6-08de8e944c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	pfcgDLMsnbFZYP00KKAOryRe4OMwqANQoCl6GDDyLyimpkd3IsONE0UbAMbTpsBQHJJ9fw2Bi3r5QJlwLs6mQw8nX3xPBfZotHeWv08WhZVtrEi9MlBKtcCli5Twpp9ESyDWXC1n3EJSFeibvGpv7qjbH51I6PdkDCnFOt57hsM5R/cc6aTPGLXmFZ0184LTyQ9iPpVP/KpqdMr4t5eqQUi6H7yBkbMeytw3RMYYLwXHIcE1CYVrWuneWFnjomPPHkj3djzb+DUfM++Uear0pKVXMxvqyfef4mLgLw+aOsEf2OUI8xVOnDT/Rrwc3N277fKqGykmMFc9csnnUnpJ6I/rQHo7DBjHKBN4Pc/2u+t6D72wwUlfK3uGJKIDcA6Dvyjx4o1648w13hNGY056vU2UzYFc1cO9ghRnYSYFQhIcYGUEv8E7q7otaPi+UP1NvJ4zT51LDwQ+PU6h4JS3PPKIKZ7EhR5Aen3K6hvdekOzjyJwY0FdQzfFjwWuaGo/1JSzfhhfJ7YXZ01n3h8CA8aschWn6mr1uM2jhUAD71xsFD7TglrWG0Bxr7d0p7oZsa6bqQPnd9aeQS+RC/n0Kx5/1d9LgBLTsgnKM3QOZ/1RgvBIF0U/zdyn8STiQ4Pw7m8WMTEzgnUTMbu7L6t7AJ/5wygYrRgFZCk0Gc3ekW4ip/MCrxV4nP6wW1/vcdARlAmaiFrpdTP24cq5xULp8YVqb0lJ/+WSSxYNzqF4hPWt25z8FvRW560nVoC135WV7YUvh/4iWKJjuiMoT7OSPQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Tu/A4/pSwYVI4fTNUvQjk4dLV8X7vli9gHJ0iWZvX6IYlArF3kG+hPeInQ5mDMyIqztv/yGYqBscE78/Tea4AsCJ4nY8aZG6ETq5UOBl37P8OZrs1JuRgLg5vBcClRvcHmeOEPm1QB88nUWGFF47wT3Y+SZUew0jgBtp9ClRyQYcj7Pa2zE6Tgmss9cTfI+lDywGK2rsQSMN6XfZ2XvMmaYQAMJa0E1DLAa0ctSZZVkZ/o0643lfsXUZz+cYJLB12w0RqoLIAbmQomZEzQQ/EslsXaMaTijyG0c2lyByTWWoKVRyxe8/ANVFhkvfUlNFZ6ujozCbBH/uSvLtcdL753cgu6G1LTyg7/w70cWPvFOckZqTq0siR45eeyg8wf0ep4OHUKYNp0Af9vcO65gSB184Zcbud+/eZG0MkuHdzwvVq7q/dJlpRZTtI+ffWwQ0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 19:41:12.2452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f41afd81-d653-4aa0-39c6-08de8e944c7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7752
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18806-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CC04F3608E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This patchset provides misc bug fixes from the team to the mlx5
core driver.

Thanks,
Tariq.

Saeed Mahameed (2):
  net/mlx5: Avoid "No data available" when FW version queries fail
  net/mlx5: Fix switchdev mode rollback in case of failure

Shay Drory (1):
  net/mlx5: lag: Check for LAG device before creating debugfs

 .../net/ethernet/mellanox/mlx5/core/devlink.c |  4 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |  2 +
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  | 53 ++++++++++++-------
 .../ethernet/mellanox/mlx5/core/lag/debugfs.c |  3 ++
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  4 +-
 5 files changed, 42 insertions(+), 24 deletions(-)


base-commit: d9c2a509c96378d77435e5845561c4afd3eaedad
-- 
2.44.0


