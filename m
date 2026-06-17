Return-Path: <linux-rdma+bounces-22317-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qo6DKb6pMmqX3QUAu9opvQ
	(envelope-from <linux-rdma+bounces-22317-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 16:05:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3979769A675
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 16:05:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="Fxu4/soU";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22317-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22317-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 150C4304B111
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 14:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AED74219EF;
	Wed, 17 Jun 2026 14:02:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35CC2F7EE1;
	Wed, 17 Jun 2026 14:02:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704958; cv=fail; b=m8Kf2/5tLbdvebVUnC7QMXU4AS0ZMBuR1INoZCRgPwuSDJTfsjPBHd1+Em0Fs5vMAg+I38f2Xu0ttA/IGREblANiwo5/QIxKriAeX//ZTXd1GFaKkWFN9qiUJWYj4LoK+AXTLja9ItihbFGoMmIvVnAwoGcAIaXU7ery97Rbvpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704958; c=relaxed/simple;
	bh=FG9lTPnA45MmMLRZBvvVEx5pqwrM5r6LZNGWi68qhcY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mKnqzNJ8Fhd5ob+Dfz2llbWVmc4tX5x4HPBGo8O1SY/kSXWLj5D6np3QdpCN7MhEqvZjztx0hEJBTz6mk51bUzV1Xji2dElU6aN4Xmsos69bCKLNfsleYuaT5zJt47KPE7owMp7jrBAdEOywWajomfPmG4w3zyOkghsnwllKe0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fxu4/soU; arc=fail smtp.client-ip=52.101.56.64
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ht8moQCzFaiiUY7IU3C61lZS8Qo10xYq8pQ7fbuFFc8eIO/2pe098n5igvjKMtmKn38wOlx1bIfFSa3xqBaKkec80Zr7tmvjGEmdtdT3tBlBnXe/fIfS0QrLKWGIWco7Gc1INepCi61lJEJWTZOEt+fguh4dC1Ri1SfuUmhlYJ0icjRsTBQHuRAC89tyln2SbTNvBeGcH85Q/+iQCkS7HLWQpiDIIS4N11ASOteeVmf0Z+WOLlmZNsdCpAe+66WF/LYPTbeyYNOl2vTVryKjvEuFRvEVRaKXzfNa5kXq5kqnpzTb9tbWhZJLTnF4Ef49sflj/bmxrAYPDXDdTgLlhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CtmK0Mx0/0B36QqXWC3gAn8uJixYi5NZtNAdsheJ04=;
 b=y1HeKrS+hIAstIpy7nG066CoAbFAqu8kZG7QkJj35JVyCGirUXdmSpQsCcgce7J2S0B11SsEZntDxZiKlj4YHM93yDQtapHj30gu2lAlr1v9EWWKNYW33PzAyC4bzXaOSB9UCIgGp050KrrJiZ9V5v1pxYYdYHKfzQijD8lBnlxkZV7tpw00Qed0J7HFpn52llzeMn+f8DO0NFSDHXYoFBrpbC07wtJfU0jzqdYyZan56xGIHzsab6o0bYa2+s+3+lGazNGQ9EYBER+UiAh6zLHddj9IGFDqmVTHSZ3WY7kqjXZz0mAtg79DjmGle2Y2iJfVAWKabozjMgKGpkH7ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CtmK0Mx0/0B36QqXWC3gAn8uJixYi5NZtNAdsheJ04=;
 b=Fxu4/soUtW+/K0JKKHwYF+duID3d6aADc3MQceLv3SHWSGh6zp/Rgv4gzy4B5776SmIfImiuxaME/ocwip+AeQ/+u+XOsmW1NgQLf/mu9yMtL7AP2zpZ879v4pvVuK3LSeqnnZ7Gb50h3M33QYHE11GHkgRGH0y262JTdtzlP2JoISBj14GAYERxnuVDXY6TFuF8qTYqPc9Zi61y5Mx2QejIY4MUA5CYQcNmJoJ3CHhLXDY3YzX+dccize2AfJCTtQ0WcrMjaGWjSA8FVnw9lo3OJJWN6diDuWNbEBg67beU2qMqPGKJlzXzeqCRZIQu3e/D2LB3H4D0zzbHCfhvIA==
Received: from SJ0PR13CA0027.namprd13.prod.outlook.com (2603:10b6:a03:2c0::32)
 by SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 14:02:30 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::b) by SJ0PR13CA0027.outlook.office365.com
 (2603:10b6:a03:2c0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Wed,
 17 Jun 2026 14:02:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 14:02:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Jun
 2026 07:02:01 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Jun
 2026 07:02:01 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 17
 Jun 2026 07:01:57 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Cosmin Ratiu <cratiu@nvidia.com>, Eran Ben Elisha <eranbe@nvidia.com>,
	Feng Liu <feliu@nvidia.com>, Haiyang Zhang <haiyangz@microsoft.com>, "Lama
 Kayal" <lkayal@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net V2 0/3] net/mlx5e: Fix crashes in dynamic per-channel stats and HV VHCA agent
Date: Wed, 17 Jun 2026 17:01:24 +0300
Message-ID: <20260617140127.573117-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|SJ2PR12MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b90407-6e93-4f2e-6e82-08decc79116e
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|7416014|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	mTQFsCf5rD1nANzy3eR785KvMZR3NWLysuJJMOGgS2OaU0BRsHQ/plXTBMac12tPG88X+Q2MNpTWQ9xCduJCkU7XAeQgv79ktleuNUzydpvT9KRYiCV3K605GRKVwyumpqmGgZjbV7lU9DrBKugAvv3pV7mqrk8UH8dCsT/ldaZF2T8X6drhMHpJGC204Xf+wb3keE45wEAwIQK70j0kFd7Tl45KVnQxH8f8QoU/zqnB6uQNqrL1YrA8eUrI/0Y6QCDK/hcBst9mAxqMkH9iNmoT50VVZ8pfy8klK4lrcSPazudVNQiV1bb5fXPVllxVVvncnjBjAiLz/C11k6TOX3ZI59CL+iRzUH8Am8fGOqT4W1tdWTKyy7wyJtSvynbTTcYCky1Cdb3RffEgqjljwlvWMf9NSaU8Waq62DLVjeVT9dnU8Nw74dUhEe0N8HQl0TvTukbvKUi2svxZcmIvLVefoVxz4a5k2H3jETkW/dikApIYlHw6dyJF/8NeIsL+AmjEMs+VvQEw8hIratDyMdokHKctg5TlE0WBhxU1IiKLcPuOmnO3PpdInuni9Nngsyc2id2o0TDq633N/aZk1Ra5YeZKskS4zCoFYSc9fCGgn14uY/D2XItDXIAlbczHx7PTFNMGB6+uNCRDAJPa7Hi4SvPBvlagSH9mOHdvXSMBud0iPWBGox2KzMHeOGCRJ9QF+1OgfNd815EC8ymV0QA7c7/tznM+OkRvcXtF6hToCTCRCyeAQZefDIOU6nK5
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(7416014)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XdAFAs9UzAYwLe8PJLScXEdIkZg7HgrT2WmphzIAq714Db/ENBRT541ZQV6IIqT7fLpvvt6PRW31DOw2OWeGnJKxY3IfveaN7FYUTHuUo0lDd+KIWBfCy9xKhWboBY1Mfk6/b4DeGFYjF4/Hu1I7ucfdq/YEG1DCbo2kuhDMSZpK7EwypV3/4J7SOEz5IGmqsqCJXrRNNLu4KZara3ArpX4ybtnOqaz7yWN3Siv0CWKEf3T+3O8WZuF/QVNJxLw/BCvwQU4O2QrR2En+BtPIMz8j7oShd3XL9ebWmRQKTN4jloqiq/wcx/ULAWmEt670nTSeMpo+3EWyRpHgDJDzbQ4pc1p1fQZJa2npFVDVxPo9vo4jitdqIHgzVe4+dEGPnYg5xZfde//HOl8hn8FBWLZXwTiHleB49S91t4fBG18qIUUbBqjYXoO0OU2JPhbN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 14:02:28.7316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b90407-6e93-4f2e-6e82-08decc79116e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22317-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:cratiu@nvidia.com,m:eranbe@nvidia.com,m:feliu@nvidia.com,m:haiyangz@microsoft.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:noren@nvidia.com,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3979769A675

Hi,

Since per-channel stats were converted to be allocated and published
lazily at first channel open in commit fa691d0c9c08 ("net/mlx5e:
Allocate per-channel stats dynamically at first usage"),
priv->channel_stats[] and priv->stats_nch are filled in
incrementally during interface bring-up. This opened a window in
which the various stats readers - most of them reachable from
userspace via netlink/netdev stats queries - can race with
mlx5e_open_channel() on another CPU and observe partially
initialized state. The HV VHCA stats agent, which is created
before the channels are opened, hits related problems of its own.

This series by Feng fixes the resulting crashes.

Regards,
Tariq

V2:
- Drop "Bounds-check stats_nch in mlx5e_get_queue_stats_rx()" (Jakub).

V1:
https://lore.kernel.org/all/20260604135041.455754-1-tariqt@nvidia.com

Feng Liu (3):
  net/mlx5e: Fix HV VHCA stats zero-sized buffer allocation
  net/mlx5e: Fix HV VHCA stats agent registration race
  net/mlx5e: Fix publication race for priv->channel_stats[]

 drivers/net/ethernet/mellanox/mlx5/core/en.h  | 12 ++++++
 .../mellanox/mlx5/core/en/hv_vhca_stats.c     | 38 +++++++++++++------
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 14 ++++---
 .../ethernet/mellanox/mlx5/core/en_stats.c    |  9 +++--
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.c |  3 +-
 .../ethernet/mellanox/mlx5/core/lib/hv_vhca.c |  8 +++-
 .../ethernet/mellanox/mlx5/core/lib/hv_vhca.h |  6 ++-
 7 files changed, 63 insertions(+), 27 deletions(-)


base-commit: 406e8a651a7b854c41fecd5117bb282b3a6c2c6b
-- 
2.44.0


