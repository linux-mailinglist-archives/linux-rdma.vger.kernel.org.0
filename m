Return-Path: <linux-rdma+bounces-19635-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKqVOnpN8GncRQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19635-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 08:02:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9034F47DD89
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 08:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD6DB30066BF
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 06:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0AB30E0FD;
	Tue, 28 Apr 2026 06:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qI4a/GzL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013019.outbound.protection.outlook.com [40.107.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1946E22A4E9;
	Tue, 28 Apr 2026 06:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777356150; cv=fail; b=BZOTwGrbe2wdEcVJjqhZvdUcms7KLGbJ1RvNez3RZtKbLN5k06qxCY4yKIo34nWQPJdm82YrwFkzF6tVCsYmRDAOJgDxOWmOyOzI5+S1ue4ChKLm1juvH9sD62ejOfP1x9DnAzYwLIhtr/sqi31wT3dYBr/JprGxvLmrulMb2mE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777356150; c=relaxed/simple;
	bh=C7mLojFuEzZXWCw3O8ZK0TPKsw3yz5n6smzf5C3+6uc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hMR1lsgyHfszjxg806EbwidsZEix6a8nPfC5WZyY04UNOc1jgWJ8bi+AnYwYdLf8YkT/nkBkDanFqv9X/zzeOTPc9Rtnf8NCHcXC9pHRRjK1ID/ctYrM9Lyzl3NF63IcAliGRKa2W/6Tp+xi068tfHLFM+yh2XH1fqMu0XlRBJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qI4a/GzL; arc=fail smtp.client-ip=40.107.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMNrhF/tXoFGKyKsKHErLBrbHwlp7PGSWNVafIXMqfNowuRnUenJj++VmQRIO/VqHjkpJiBuXs7Y2cuipxN+smzqd5SiBaOZrfJAF/h1I9NmsogAIr31nHhblogt5rjfbxRqj202q2ao7PYdguVlb6kILEvfcsgP5BYtPl9jI+YXpLFtDxa/BCXSg/5ROP/dDITEIblEJnVrhbFFAnsME5dcQvXqTYKNK8EVcYFwoLUA7GBH5CAbhw3dJQqkcST7tN5lcayTTjdbczeM+e3fnNYlFVmT/JrK/5cfv329eMQUuuaDymsbbhf/pgX7YCougB1KTT54nZp+2BHj87aRlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyVMvuCwL1Vglw4UJ0HGLHLoqnbpu5NalBS2NQH2IOs=;
 b=TlwXdWb/HKLV3zbx3jVDRXTumOrv78UMWaXO18kbLE31WyNcC3OeUqo/nyE67QXv8b0sdpB3+zvO4KJq+sGEDYDQUOvImG1ED/0R/Xh3GB+SsKDVPrUGUBbBk9xTstd7SPJAcA4EkbtZUNFfmlUpjA/3yv9mnqseLT/4XYOAV1FWXtUDaah7bhblUzJ4/Xp8I6gIzjWQ6O54BMKN6kEsr1tXDwOZQ5chVfCC4NdDtVYZ4tvsaddaNy3zYfJoz6tQwxr0Wf3G5e/+YvjxjtZASPybr/I4klfX7litKBxVFx3T3ftLTXARXz1MVsuHh+0EKfzgJsrPKw7PfUeAvVr80w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyVMvuCwL1Vglw4UJ0HGLHLoqnbpu5NalBS2NQH2IOs=;
 b=qI4a/GzLzRif+5Yn7ktXLik7HV8o9Iv8gzstRyRhP2E2Rs97uuT+ZuKkoynZIgivTSe9LmaUMSj1jThTK4PDzbgWJvL6AA5TRC1/vMthedE1pz+g05EOd/49CKlO7vTWQKFp6cDcf00UE4J7KqcT3uuszx5E6bUnULhFohLHj1jSmlZUQT4MJdvxImv0AV0g5SiQl7kaNJU6moAwT+VfIttdnmtg1tY0sxm/cc+rOrjMW7Pyetx1p0A/dJ+50ogJ9Xm2Ql+UV1ggv05qCx6H5DaE8pcRuu343iofSWs4znvZjKcKJV8X+gA2hgdIAbfg5zT83lZGA9ShwTJ8iMaXYA==
Received: from MW4PR04CA0109.namprd04.prod.outlook.com (2603:10b6:303:83::24)
 by DS7PR12MB6117.namprd12.prod.outlook.com (2603:10b6:8:9b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.16; Tue, 28 Apr 2026 06:02:23 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::94) by MW4PR04CA0109.outlook.office365.com
 (2603:10b6:303:83::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 06:02:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 06:02:22 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 23:02:01 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 23:02:00 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Apr 2026 23:01:56 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shay
 Drory <shayd@nvidia.com>, Simon Horman <horms@kernel.org>, Patrisious Haddad
	<phaddad@nvidia.com>, Kees Cook <kees@kernel.org>, Parav Pandit
	<parav@nvidia.com>, Gal Pressman <gal@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net V4 0/4] net/mlx5: Fixes for Socket-Direct
Date: Tue, 28 Apr 2026 09:01:07 +0300
Message-ID: <20260428060111.221086-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|DS7PR12MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da45a03-1b75-48f4-5d18-08dea4ebb704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ryFjvid1/G5aWuejWG8YbeLmh7gdgt1VUp9PciyPIoCeau2KVxyCjU3mS6JjvIos5VwiOgUVR4ebsgQTQrTVM4T3I5i/Cs1Vp1mFzstnGMus9L4byXKBzJwJM7s9Pqxhdr4uXvHr71v0eZIExJTR3xAOhaUGeOoXEYd+gkBUopdGSyYgMjOav64SmpBAlDtjXfUl+sk3cUqCH5F+JRl+UkutHNCFypubGzevpigYoDahvzttXmtQFIlRiesnz3Zel7/JP/L0CEaoB0VG+Hi+n47aIz/nK1KjHBKknBkrVlUwQGV2nalN0ZgDn72D9Jg/LgouKA+9uu10bH0acBRCktucgkGZkkrFSXb9mNpPhI3bU8GEg92nH+sQBa8BRUyXOS29B2lg0D4o9J7Pq1RIJCDNvk6HjuE2zpUdv+El4aV0IEFhrxJJiF2VU1hkr3/FgOmt3bDlknEqIEmawzeAei/TA0OFnDa9OaOIhNTKeufdqyUwij/q0uwlJ/GwZ9FMuuMfT58I8eXIAJxir6fvz58opoPcIF+2G7FX7hbdlQit+pyn5unURgeNk6d9yD57jEGaCv+hnbV6fqV5Qh+umWlqWprXtsMGzO2doKQ+usE6B68+snvE0Dw/nckuKAghGfsfOYG/fU4Pk6+xqI2R/ZjLIoeEhZDNGsCd+CaeNabJ563+wvIfdYCyTNn+tXnxkBr2rOpm80lI1KK2Tgt3Y1VGQTKb+vy77dFlkQp86zoFU0arGyht4W/cYmaHhxMa5wDYSDokUke3pjeVIA0YVA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5gGj0ZTI/oArfTXXb/jpygRu1lQ9X7bL3Ig5Sr30KQ6PbCBLmT9nGrOZZC9oVghebSEP+2pZXz37sWg4swo2yJGQyNGdH8V9ZAxx63WXGZGSTpcnHkGv4lsREmvgl305BtwkBQXQKz4Ib11lmONRHY4pVUVeVwc4N23C6aUlEst2Kog6LnSuVvdtWVFXK8Xrnch17SmkW32eU+BqCKbXhtTONnYvnxdq2ls3iQExlR2AvWW+Kt7Rso1MP3l7optyri6FT6gSYT+KwIicXhTGtU/d3+758DJDqZFefjKtgFVREQfRzUosb29oK5Z82DR4rfFi1462zZra9dXeuC+BU0ylQWsWWBteoGf/9ARgp4O1pi8LnsOWOOhS+buNv4vcXjU8chpPdS9Ipu0BdX6UB/v+IpqqhShrZZqTbgWT0nV7umm3+Pjfy2s2mrnVz0hj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 06:02:22.6559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da45a03-1b75-48f4-5d18-08dea4ebb704
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6117
X-Rspamd-Queue-Id: 9034F47DD89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19635-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

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

Patch 4 fixes missing cleanup on ETH probe errors. The analogous gap on
the resume path requires introducing sd_suspend/resume APIs that only
destroy FW resources and is left for a follow-up series.

Regards,
Tariq

V4:
- Link to V3:
  https://lore.kernel.org/all/20260423123104.201552-1-tariqt@nvidia.com/
- Adjust "net/mlx5e: SD, Fix missing cleanup on probe/resume error" to
  cleanup SD only on probe; the resume gap is deferred to a follow-up
  series that will introduce sd_suspend/resume APIs.
- Fix concurrent cleanup vs. init race in
  "net/mlx5: SD: Serialize init/cleanup".
- Remove leftover sentence in commit message of
  "net/mlx5: SD: Serialize init/cleanup"

Shay Drory (4):
  net/mlx5: SD: Serialize init/cleanup
  net/mlx5: SD, Keep multi-pf debugfs entries on primary
  net/mlx5e: SD, Fix missing cleanup on probe error
  net/mlx5e: SD, Fix race condition in secondary device probe/remove

 .../net/ethernet/mellanox/mlx5/core/en_main.c | 26 +++++--
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 76 ++++++++++++++++---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.h  |  2 +
 3 files changed, 87 insertions(+), 17 deletions(-)


base-commit: 3bc179bc7146c26c9dff75d2943d10528274e301
-- 
2.44.0


