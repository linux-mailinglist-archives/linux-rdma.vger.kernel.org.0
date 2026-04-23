Return-Path: <linux-rdma+bounces-19497-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBCsDJIR6mn4sgIAu9opvQ
	(envelope-from <linux-rdma+bounces-19497-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 14:33:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91595452025
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 14:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8275304A88B
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 12:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD2B3ED5B5;
	Thu, 23 Apr 2026 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VoVLMWzC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35CE3EB81D;
	Thu, 23 Apr 2026 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776947520; cv=fail; b=CWawrLyQ0obFcNn8Mi3yZk3oGlUgOfR3K35q6wi3gRTrTVbvG6hU4a+U+377+KhV+c1E9xFEKHYcGl9osncpyU3U+/1gUOgwAoUrDAMr3g3IpvHTewtPiMzrwzw+tX0ZRwNAQFwrsvs269f6shgjvyr5TV0qYoe1VmyWUHcg9lU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776947520; c=relaxed/simple;
	bh=rXd0/887Nj5qJ3YJrm12k8PGV+nmex3xUQvjk/W9Cz0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u828SBAML7tBzE0N6B8vIm+cjygliWzFQkloj6IF+dU4BH1WlfP50CAZy0yIj3kdtxXHl9eJN4ILL4WtXI02s6fXwf/pnrjCWlutQeqZMy+I3Og/ptd5SdCVEejJXGTTRgsTS4yEZaX+cZKRpX6r5SlHqvs7v28+LLXcTfHDhNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VoVLMWzC; arc=fail smtp.client-ip=40.107.208.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bi6IPZ3oeTG1YDhYXu1tC1URxq6EblUb5/3RGkpyxrDyF0fv/OrTHcrafffurz0Id+QfeMB/zWVIAUyD0MzaeMhdoTYkZAuxHk11MwIIGyHkJKXMKhkbaKo2UC9lKcbZn2/l8NX553n4yhNNqRT4/wyORKATAZOw5vq4TknMo02JMymHxddeeDYLwGUjhcA4IZSjuR//WVL5d94rsB51LixsW0viKy9pLwApw9ZxshgeAoYEwDpo1fQ98IEDWg37XT9lznVFEyv926o7coWppDQSZ/vCGxxXx1tdvHhKTRYTGgR9KL9q/zabqSh3kRZqcVlhMb+8h9XPkFAq+lpLuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXu6T7aL8q0VfAEat8pFvep0F/wl3NtfjevYMAJ0rWs=;
 b=DDEbMVrJ3MmkAhERl75MEYqsJgYDRcY6pdUhenUuy0XVqE04sHfB6xUDiaFAAGYeieauS/XqJb6E8jx3bPu+UQxxD1GCjsuSJydVKgTN+YYIztWihpuU47hVQZjWKzrKLLwxy2vYWoBH8v4FVgw+3tK8r+a/uaIHTCbNl9MxsuryfEfKQc526aVYWb+AkKUvMWWx4EBEwNHsxhFV9kS4PtIbWuqhMami9fqZpZbu+BklplPl7s6r+AIASjV4Rfm/4CZhWm2qx9vzYQPiFv7Eppgq0oAGf3tpIYPM/DW6sS5NKdoPBzkJncnyTKfOrjG+Xerwvn9I4b4vu5NyyFM9ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXu6T7aL8q0VfAEat8pFvep0F/wl3NtfjevYMAJ0rWs=;
 b=VoVLMWzCwhDgqzKMYr5v+vex8Yg9F4x0Cij24TyJkbDhH/i9nlOONzr0aYgo6c5H2+/y0bNRw0MJaLEmlq73dFcCIEUT7t+/FjnO5Cjkq2i+/UP9DpvQnlySIHwBDfu/iZP1VRv1NxEoK9k08umeW0w6smIcnMpqi1DhW108F91ugLdP9hY2vJ95rPHU1x4CnRluYfv7yE9ylh0vDONGMOlkoO1Su0KR4Kh3r4QxLMG9IMNpIxGhTVrsnddPWE+ks4mUMCQA3Fi5aUWmS6LSuacj8upCxGzhTx/GB7ufr8An0e+j4hRTMJE4XH+A1hLh5GHZPTaaqH5SbpA7WSx7hg==
Received: from BN8PR04CA0044.namprd04.prod.outlook.com (2603:10b6:408:d4::18)
 by PH0PR12MB999112.namprd12.prod.outlook.com (2603:10b6:510:38c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Thu, 23 Apr
 2026 12:31:55 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:d4:cafe::de) by BN8PR04CA0044.outlook.office365.com
 (2603:10b6:408:d4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Thu,
 23 Apr 2026 12:31:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.4 via Frontend Transport; Thu, 23 Apr 2026 12:31:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Apr
 2026 05:31:35 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 23 Apr 2026 05:31:34 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Apr 2026 05:31:30 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shay
 Drory <shayd@nvidia.com>, Simon Horman <horms@kernel.org>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Gal Pressman <gal@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net V3 0/4] net/mlx5: Fixes for Socket-Direct
Date: Thu, 23 Apr 2026 15:31:00 +0300
Message-ID: <20260423123104.201552-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|PH0PR12MB999112:EE_
X-MS-Office365-Filtering-Correlation-Id: df2b4c5e-9578-4e87-5e7d-08dea1344e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|7416014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2YJHbzOZwt8d+ccmObm1MUB4LmcDxJK9w0psHafmwUZGspCi8MDgKw608PJJEWmSqZs+OnrT+9rCXHVxZ8kBWTTZ8uZpa36/GvK6yIXvDO0z53bNoj3Otg/yr5jRvEIMRaR8c2CqbT1Hv8/WtUiLLHs8ozBr198ot8JyOv/6YM+UGSXrcVo7CNjjB7JpxOYsrJGbMEbUQ2X1sa0SvInba6SbjopJWxfNZLs2uLvH/qzeI3wZizq4Pu4MpNZv0Qb4rCGw6sBR2fTDVfGmUcjQA/zUfp0u6ZWXvV9Vit2JLKRpn6iatBy3M14FS5tBFUWh8mgBo2VAR49CThWyEJ895nbz13UBGCLm3gx1gpqj0+2JUNLlxK+QdoP39cGJAGVF4OyCg78eqh2FMnLkUSN+KlW7zYc46I1/lsESPndK12p8zJPjlQsf4LXXTFMPy2VJbjZPbp4nbglRf5XXKuI7I2hiAAZaEk3DtrZgPIMmx5UDjaxiFAkfEwwqEd3lBVft3O1iurc3VJkMYhZJInL5BxFUYBLbfdUleHRpw1sBnzWRLc8dGoZQIfkK3GbDefHAho1TPN657aUrB6HwR5yiQp7jW8+PGLMcVVr8ZbcZLrlqEQiJ2skgCxRhFJmB2GjMtF3tMooXWZV/cmq6w1zkf+cJtFTgtpY3EfNMzGcyKIpnxzi1wlOpbSLEu25+fIhBwAegzpwjOO0ttR4FN8PsvIXjoOct1XOZBQyqHfW9rj+z2mLcw3FM7R1h1+2zDTC8EoraE0ntsFk3+o22XKan3Q==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(7416014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	q2IoRZ4znstZQLul5IDLuBrzQRRyqJeVicWwHOdjcy0I9VDM6YE7faRdMhzklK7rZaInnLQEI4Tg4H8G8yI52/rVhIQ+nDSZAkk/n0sYrJePavbgF1ElmJrs9DkQTmSlRdTbt+HDSQW7Y5vV0QJ8JswcJ7p/yZ46DLEUw+I/39JfjY01NOSmkkN53b7eS+yJd+4AiSrjxCKpUIi+PBf2HuLkubwAq6ddC7sclSnDhy4Aj+nFg68kZ25XXCZeZ7U9XPFx6T1hO0NtOS1TkxxWoM3nWLmv7yX55hl0QUJx+GRqfJFMjfjmVL909lJYMAYRzeofkuRKy33mFwzkLYrnMywbh+OiMNG4HMazhmRJIoldBJ9WQv4DC6JcDexIR2UZF5Keb9ZhD9T/zY/v0DvhutpYncEmm8gTvpd//y9brxaejWslJH1BsUSAwIvajZA+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 12:31:55.1991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df2b4c5e-9578-4e87-5e7d-08dea1344e12
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999112
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-19497-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MAILSPIKE_FAIL(0.00)[172.105.105.114:server fail];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 91595452025
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series fixes several race conditions and bugs in the mlx5
Socket-Direct (SD) single netdev flow.

Patch 1 serializes mlx5_sd_init()/mlx5_sd_cleanup() with
mlx5_devcom_comp_lock() and tracks the SD group state on the primary
device, preventing concurrent or duplicate bring-up/tear-down.

Patch 2 fixes the debugfs "multi-pf" directory being stored on the
calling device's sd struct instead of the primary's, which caused
memory leaks and recreation errors when cleanup ran from a different PF.

Patch 3 fixes a race where a secondary PF could access the primary's
auxiliary device after it had been unbound, by holding the primary's
device lock while operating on its auxiliary device.

Patch 4 fixes missing cleanup on ETH probe/resume errors.

Regards,
Tariq

V3:
- Link to V2:
  https://lore.kernel.org/all/20260413105323.186411-1-tariqt@nvidia.com/
- Added "net/mlx5e: SD, Fix missing cleanup on probe/resume error"
  patch to solve missing cleanup bug. (Sashiko)
- remove MLX5_SD_STATE_DESTROYING and move
  mlx5_devcom_comp_set_ready(false) to mlx5_sd_cleanup(), simplify the
  locking around SD state. (Sashiko)

Shay Drory (4):
  net/mlx5: SD: Serialize init/cleanup
  net/mlx5: SD, Keep multi-pf debugfs entries on primary
  net/mlx5e: SD, Fix missing cleanup on probe/resume error
  net/mlx5e: SD, Fix race condition in secondary device probe/remove

 .../net/ethernet/mellanox/mlx5/core/en_main.c | 32 +++++++--
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 68 +++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/lib/sd.h  |  2 +
 3 files changed, 86 insertions(+), 16 deletions(-)


base-commit: d40831b016b4986e70d20d0ad14e6a0c62318986
-- 
2.44.0


