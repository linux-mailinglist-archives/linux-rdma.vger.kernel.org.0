Return-Path: <linux-rdma+bounces-19149-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGmVLy6I12mwPQgAu9opvQ
	(envelope-from <linux-rdma+bounces-19149-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 13:06:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4883C97FD
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 13:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6E65302EEFD
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 11:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E612D3BED01;
	Thu,  9 Apr 2026 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RlQAtCv8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010060.outbound.protection.outlook.com [52.101.85.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FF126A1AF;
	Thu,  9 Apr 2026 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775732722; cv=fail; b=d/oomJG+SBj2aHsdOI7W7xWCmL10sNJcOtaPMOm+CFGMuUT+Ng3VzBcw/x1l7cfs6MjvARmMj4RflxQuvgVjQynluN806H1ABbP7aeRpodIsBD2+NuYSRkUMSPlCnqYF/i71+sUdqFWMhKk43sV9DYH1L9qVrdF/65ZJ2NBj+IU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775732722; c=relaxed/simple;
	bh=oQOk0b4UwmWJQR22KMRXPrQvbDq3VGFQxZO1LdvUVb8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B9VQnCMoOXg3Ii5qWPYBAHdxGMq2M1jTBKvRrrm+PjkQDnES/BP/Vraqka6bYsVVJ+lnsiGi8i5peHXxvjliQXTs+bOGmlzNd9jjraRXnHDR9NUeMScqz7KEGw7F0W6OvutBf67XG1OIzKAVJPDbnbmUElF2ImHlQf1j711DPpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RlQAtCv8; arc=fail smtp.client-ip=52.101.85.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkrdSDzBVbS+Nd+jm4jXjTiEvTl+t/cK3EYX/fPBJYTNnQZz+52aouWKaoHS4BQjFnHN0OxXzoKHPvpa9n318qglTPBuicy4oXnFv57rczh363PHoC06S/UChtr+C93Pl/3mjVtwhAA6TOu30HombMhs57wh8vqRzRJo0X/twt1dHyzKyQQkhbrHXFgA33d0kp2hYTiCEDiFjjBv6u/+gCr0UyuYaPE75VrwX962Ngshk+Zck9D3aeaGX8PSinWX+YGmJ61JHMaZv3P1kld/+Pm+aBil9kAYRah7uTluJIPJuJ3K2OjcbFDGnJJSVL+Ce+3NpvUn49FnHGgxwF/t1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=go3fZK26pZg29y12swScog60XJbFhVMJHLi+eAi0uc8=;
 b=lsWYuDVaMdTsdQyVoBKu/nKMh/QDLzQkQ/C1+ZXUhdtJjRopUuTj1tpCrPSlWl5tAVEt0BjB0BgSaYjHDup4qqHLuBHHscH+DjkGPAwyUSK0oJnJGcdU5UrcC4oTi61XkeMzdJH3vlHLmNIXBPBSYbxSO0NKiB4yzwdiisp05v4HbHy5F1eUIPOEx4QwyTN7KnHvpCZAF/Zs0dVB7p+Tw6eEJsqsX3iMotgJp8KnOa5q89MwPFKIbFx4T9m49liZ/3xmNGbiziSSaxSydkOH+gzwU+GrN7CtwRbhnY//yPBucvN+Gfk4DQjTnSuXyKffuoi+r+9HPX3qKBSyqz7u3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=go3fZK26pZg29y12swScog60XJbFhVMJHLi+eAi0uc8=;
 b=RlQAtCv8mWegrnGaP2/MqVNbe+6JcnPL5U21zso4g9LornzzhyxFWbvo+6Zj1n1bl49dApglTInhcRbEKdAjBTN6GIk9ape4g7zLoHPpbYapgez1BrhHiKQDSlzaYJmmrqoy6w5vg+Qlc66N5BxhZzFkUXpR10sFFZ4XF5N1SYUAYfOk4wFqxh/eybwhT0b2vW70Ke1Xxu4l391dVfJ2O1Uru0Hj3l6kULFgHq6WNcPJXvnnVegBoTrC9tCqSkDctrj5LJ1uHQtlGRZkYzszD59aVUkCN2PHQOdWxaXx35jk7/QPb9BZHAz50Dk55fJDpjDs7rB3RkgtZ2OnqBxaCw==
Received: from SJ0PR13CA0198.namprd13.prod.outlook.com (2603:10b6:a03:2c3::23)
 by DS0PR12MB8415.namprd12.prod.outlook.com (2603:10b6:8:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 9 Apr
 2026 11:05:13 +0000
Received: from CO1PEPF00012E82.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::a6) by SJ0PR13CA0198.outlook.office365.com
 (2603:10b6:a03:2c3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 11:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E82.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 11:05:12 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 04:04:55 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 04:04:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 9 Apr
 2026 04:04:50 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shay Drori <shayd@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Joe Damato <joe@dama.to>, Simon Horman
	<horms@kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [pull-request] mlx5-next updates 2026-04-09
Date: Thu, 9 Apr 2026 14:04:31 +0300
Message-ID: <20260409110431.154894-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E82:EE_|DS0PR12MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: dcbc46d3-a73f-486b-bed5-08de9627df75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	v1fcOnL8TWV1H8wIv9hf9s7UR1DlAI+2/M+TsLxJET8wmaeOmv7TaGJMdEsqoSVC9osw2xEGuVplT46CFJo91KZAZGxi6EWC2wtgKqEqdVb9xkf1eI2UaMVK0tn0q+5wtcR6UDetnHPzoy4R1GN4F7pDokY1CYyOJxP2CqAt4uhefiVfEWpDFTkFUUmXSCwdWNxjX2amxIdgYkf5HBfTeirebZsNuKWPdheKTP9D9WrsMltKDjqvbl6/3lxedCisnk+dRfRoLXy+X8kmC5Af2591eICF46ta/Ro+21EE7NAmP7QwnlXbWWHQsbgS4IQggqsTWlizs9GQ76zyvcwrNXsDCirV+Q7Rk/80HOuwwjorreEFfgy+p1fDeMA1Y7fNa8SRI9v9Vk2gS3ASAfgbmPEWRBIpz+zbRjbrKVrOnC6eGBq4ChPo/kETkr5yQndaRtHJNjyRmnlOgFFKIz+FoK6VFZWnkwEVd34vF5W03Qz+BPc9xg2HxcnUg1+TZJqTPYHPc8HMokUUwY29pbEDBaCx8CpQsdVEoVC+ruR6B3JsC4UFzxH6fah7EabXDJ2p15ztB6tvdEL52zRgmr55O5Crf2VBGLn96CpmRg4Ot6nenhbm4696fLVmmSFLWAbOOwqESb4FOFCJNLYo044BBjm9gpUftnrtHIH4bQLrcghCMGdT+srfAU73aJpCmP+IZS+uG31N9F6k67VUw2pFH6jfL5sR+3nIZMuBb6mpmz1WxG17YctyAIPsrSZnwYHY/bJl48W39ZrU4RIjwEkGaQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jFLYhuTY+1qYJGOre4uUz9wZw33dYxLwXdSINifQ1KEkCpWZ3hIMjNmPfftCCAcZHiXOwT9fBNPD4yWRAyhdyej/6L9+Pk6u4g7CZXuF254Ee2fBGuJ8pRuGR12z254VDOXJfyYKdDdgFSQ0MsJazrxUb1ncJ4XYBHzULtwbhix5I4CqhR/vrrmLjdm/iig35fYZvY5vC6U+5GRzNF8Ulo2jV2a1wztsUQ/tH336JPtEDi5j9cQjrs8lPwSxsLgq9DcT+7ckNbh6oW06QmHSWaOuNGbYj0OxHsd3Pg8UnxAEgiEFgNIEoqCvUaOU6RY1EYWywzrkbtpmiBEqC3ej5ZLZrEkaJmOOcB519hE+Lo+G+FiP6A6UT7qArw7thoFhtMLumLWgQTPvaDBC4rNAxnbErNvPwSIkomA5Nxvvoaj5fqGvpKByY5PsB+2+y8TG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 11:05:12.9130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbc46d3-a73f-486b-bed5-08de9627df75
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E82.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8415
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19149-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3A4883C97FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

The following pull-request contains common mlx5 updates
for your *net-next* tree.
Please pull and let me know of any problem.

Regards,
Tariq

----------------------------------------------------------------
The following changes since commit 4dd2115f43594da5271a1aa34fde6719b4259047:

  net/mlx5: Expose MLX5_UMR_ALIGN definition (2026-03-16 16:23:00 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next

for you to fetch changes up to a1bac8b70ede332a05487081c7512d2947f3a912:

  net/mlx5: Add icm_mng_function_id_mode cap bit (2026-04-09 05:26:39 -0400)

----------------------------------------------------------------
Moshe Shemesh (2):
      net/mlx5: Rename MLX5_PF page counter type to MLX5_SELF
      net/mlx5: Add icm_mng_function_id_mode cap bit

Parav Pandit (1):
      mlx5: Remove redundant iseg base

Patrisious Haddad (1):
      net/mlx5: Add vhca_id_type bit to alias context

 drivers/infiniband/hw/mlx5/main.c                       |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c          |  3 +--
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c     |  3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c |  3 +--
 include/linux/mlx5/driver.h                             |  3 +--
 include/linux/mlx5/mlx5_ifc.h                           | 15 ++++++++++++---
 6 files changed, 18 insertions(+), 11 deletions(-)

