Return-Path: <linux-rdma+bounces-17532-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8P8SG16WqWnYAQEAu9opvQ
	(envelope-from <linux-rdma+bounces-17532-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 15:42:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C396213B18
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 15:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E57A430557E2
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 14:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D033A785F;
	Thu,  5 Mar 2026 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UGVfEwAl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012069.outbound.protection.outlook.com [40.107.200.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84908375F6D;
	Thu,  5 Mar 2026 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720905; cv=fail; b=l0zrH7781OemCIOYfuR1Q8z0nE9i7AWjSV3uFvezVG777oyNPsl3IvNd8t7+tS7ZyQiJ2WhRkz6/0wWh4WcUTX3FSn0y2hfUotqd86gYTJUGWA6mwAIq1H7R/0ReLItb+R8yBN4UoUNaa+iZgoseBnHYvmtiDcrBL+uEHQv0qtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720905; c=relaxed/simple;
	bh=ySoOcZg95SJUoVc4vzGriyxAZJqeLBzfdlrHl6kPcz0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=df3eHFLeBOn84nQ0sLZZDXM+BhF2RpOVsscoP5xwg5+3i0tTfHTFV1msSf5J04LLJVrB2WIeQJq6QrNz+lPMrI09hAf1awcIwgoHj/E1bhVBgIyPb1vyzkZXIEgbART1XoIpTPbzCvqGshJaXXQeun+WRI3DK0b2KiDDzGjJBJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UGVfEwAl; arc=fail smtp.client-ip=40.107.200.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzrJmvN0TjgnnKzksZYjah5N+Hqj1YqRvZG5q+tSsrt3hCgQLbzwv1zuuxpPphFJH3/4ypegcFfxw3misAEFCaAdkK6aUrsoL8K3eaT1NfS/vJ3eQHsh2l9BBIzmnuSh/pet03VKebPv5TUf4E3n9vZZKKUj9g8lXh5LS8ctDhdGsYtLLd0dTN9jqhQNivzCOb2u4Qs7z45kj6WX5y1ZP+ZvnY78TPsmJ+vKySt1wkrK/4eZ9zGAe0P/AfT+z6KAE2xWd6NCNSBaQJVHK8QX/GHHQO55WfeDzl5au0Nu6yqQVqye1dcVh+JV7IuBGivFBebHAPJUkbT/6BN94jXtkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKsiJIuyJHfzhQ0iOz7E5ctxHpIPNLfQ5+ENLeW6gcA=;
 b=zP++QEm3tlVYqxmkaBx9nRwIIygCrJo6x/9QNWk+g4/L9bml+Xe981g7EklLOrJVpPsr1OXWqQNXZ/i0EW6oPghHTkq+WNmLKdudTM0ENeG2YwKZiU51gv5LDy3rC0Ol3t+ESSnGlYOgxmbqFmn8WqtHMzJ6i697SQpcMw8LDXlGSjwWGIDPJK5pFo9QyHbOS2cQZ9mflBDFWM8HvJy+wV4WTPu61YfAQQlY9PGnZH8T/RiuIr0DSbsRR3F9AYJ/WzAoB2k/3wIkgzn+WMEUlfnQynDilqoyrnY+fYQc7VFzTa0dzSI1F+rWdTlXIKeWXttcd0nigug1QXaQBPTuOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKsiJIuyJHfzhQ0iOz7E5ctxHpIPNLfQ5+ENLeW6gcA=;
 b=UGVfEwAlpVmXrN2xkMuog/X/NYhzySLYbcJCSMCROSot1alVSjmH4c8HSrUzhzhBVlGQj9NLaBihaX5RVuimNZF0+qBx6mE7DbcA9H18Rym2s7vQemkchakIbmToDmHUZLwC3Yr7bKsUrctNShPFRA4JvTaIL1DjDt+Vq1lNNmfgS350QrgH+PO4C9UfgfS7tH3Had1Yay1r++4EOgmLtGoOvgmYdorXefUEu2F4urNrRZCXSHswVNczUZN4T+z8bRa2aNTP4SR5TFGjnabc6v5yIO7zJMHQkoOHBrQ8ILANq630uMlNAAPR4sit0TaGfHqzQCh3hV8C8dSGiDCvjg==
Received: from BL1PR13CA0016.namprd13.prod.outlook.com (2603:10b6:208:256::21)
 by MN0PR12MB6247.namprd12.prod.outlook.com (2603:10b6:208:3c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 14:27:08 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:256:cafe::5d) by BL1PR13CA0016.outlook.office365.com
 (2603:10b6:208:256::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.17 via Frontend Transport; Thu,
 5 Mar 2026 14:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.0 via Frontend Transport; Thu, 5 Mar 2026 14:27:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 06:26:54 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Mar 2026 06:26:54 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Mar 2026 06:26:49 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: [PATCH net 0/5] mlx5 misc fixes 2026-03-05
Date: Thu, 5 Mar 2026 16:26:29 +0200
Message-ID: <20260305142634.1813208-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|MN0PR12MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ae5a7d-9524-40a4-be02-08de7ac347f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	+R62xveS19SPPcAUNY+du7o01JNwwV/7jZuBouGPCGsNm4zLPSXxptaUIlaJt2MuxwBRJEUZSEKhK/IsjbWU8Uh2NMC7GPCWuty0n419NAi1HtZuaYzL0Y0H1NsZPBpt6fzz/ppSL9CUEH7qYc6+6XNhgjiL+OAOhKUcpI8Nsh/SLn09VCb0mp2Pwu2g2fbAc7m71ruWXev5qP99K7OaS6+kRwaJ9CSySatlFQjwBd0znns9zFL6db1OJCRgOBuxBnjSG5+XQkKLlmHBsd6xTqKfPzez376QUoL/4DnpF+hm/PhPrWIb5JSCyGFaSjen1p9rTLRW+0QpwyEO74DpiYxj2WUX7f8kwX4OI9FOW+Mkozoip/QIe2TQ/gLA4S5OXKkYIpKENsdQHJRzMqZbXvQ34mqwJkWqIk6pdfauHf66Bz4XdQP+TZRoEtk6HmGVIvuMa31oN2lqKM0JucIbL+zRyV/zlX9MOOAd2l5SWJGynezQvrdRQ96cZr0xOIDag77XOSIBk7ueL+z/mtZw8mHN0DS4xjGIpa5sOLtmfo/hjNt5B3BhdA0A7t6ghosqSH2K+Ww6gknQgD+KM+oTxnJ4+/XLsgQk/aMWWg8T5GADwYeSZO4KDnCdLKcOVVXdFcBnAwaYQTKzMMKhq4oZKpdNp35+4TLYwFqoZly6VEi2Ni5U/lg00i9NK1DI8VWHp+ng037arfncwRt1Nv4FuISxoEoKinDKyPri3E70XyJ2Z/KxHNrQ+u2ZCbAMu2HMChdySjcUyrnwbfg/97rpdA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7PQ2fdJcvAc4djc/SnQISVIvjSO9xRm92bAZt37RRDu/hMqCdbivnVKs9Rnq+FOLl2dCCcZp/gagz6Pw3A1ojAgvBhuEl8tskBu3N7yJOVNE+twxt+RH8fKLRUGAryEZ9SQSfhrRA1ZzAsjquJw+yZ4W7tLhSOmleX/Ol0J6bL5wQnGIZjyGB1rLGfC4IbCstSyW3KY1r9WTzj2XloH7+0Mgxc2G5bYx73gopKcDY5UGzdmSClBDBX6x+3SkTxEuAq017zdGbTZIXCriz9Ug9Vi3gbS4OQVdux/LAXC5Aob6Cia5yuV7vfmokgy1nZsY/NaB6IEAbTtOm4E/UWdLoBh/t7x46/YkGLO9TTEfCrxXZxJNob/fOuS4EFe4T8XeDxkk0FCBtyLyJyokD6FkfvbbfYzq4oXDbn3L3rdf322+SjlbbYgKMo7Wa+nRjU5y
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 14:27:07.5816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ae5a7d-9524-40a4-be02-08de7ac347f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6247
X-Rspamd-Queue-Id: 6C396213B18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17532-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Hi,

This patchset provides misc bug fixes from the team to the mlx5
core and Eth drivers.

Thanks,
Tariq.

Carolina Jubran (1):
  net/mlx5: Fix peer miss rules host disabled checks

Dragos Tatulea (2):
  net/mlx5e: RX, Fix XDP multi-buf frag counting for striding RQ
  net/mlx5e: RX, Fix XDP multi-buf frag counting for legacy RQ

Gal Pressman (1):
  net/mlx5e: Fix DMA FIFO desync on error CQE SQ recovery

Patrisious Haddad (1):
  net/mlx5: Fix crash when moving to switchdev mode

 .../mellanox/mlx5/core/en/reporter_tx.c       |  1 -
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 23 +++++++---------
 .../mellanox/mlx5/core/eswitch_offloads.c     | 27 +++++++++----------
 4 files changed, 22 insertions(+), 31 deletions(-)


base-commit: ae779bcb18cb0ef0da1402b9dd837e2084e23e27
-- 
2.44.0


