Return-Path: <linux-rdma+bounces-22319-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Tx0OJgiqMmqn3QUAu9opvQ
	(envelope-from <linux-rdma+bounces-22319-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 16:07:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4B069A699
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 16:07:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=OXJmQ9LL;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22319-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22319-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1429B31BAC3A
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 14:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D036F42EEA1;
	Wed, 17 Jun 2026 14:02:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011064.outbound.protection.outlook.com [52.101.62.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F88041C307;
	Wed, 17 Jun 2026 14:02:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704966; cv=fail; b=LVyQXa/0SYjql7x55Zrk8SRfQcEYnkQnsT2RqpdYamUyKxJt5Reg4Qa2fRVJgKxaHFC6u3vLttKJgQhVIO5fLMKqM9u/U9XiXwy4mcUSRPVYG72xHijT8f4TE7E61tHAxVWL7OkoZAx+C7yKH9ApZgUBMviIJps4KomuqrvSPR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704966; c=relaxed/simple;
	bh=LpdaMvFNnPJLVeWUSoSb8fviGJQA+wM27clxRxKX3oE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHUrtHlVKqEGnGId+qRdQH3ARKtxLFZrp/ujD0FJiDMaDv7v2fgiYeCyf/2K2+IvYycqxojTMrJtR1V+r9/I40v7nuiRzO83b6n3wm8yhFVTU2vjdDw+KR7qVM05DMfpUGSHAR8M1hmTk0bDChepX+oysdQtKfCyG6btH/UPSkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OXJmQ9LL; arc=fail smtp.client-ip=52.101.62.64
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWDF2B4cNQ71gAwVI0fFKqkSFr7wFTD75Vr3ntoWOFOEZAxFFqo1yJsocJVMSWFsFSpBmfTawOUq/CuLKNQn4c28uhfgSlX2c+U964q+55B1KNaZlORUibzi66xo6KBnZBqhab3f9ttbPtwHPYD6aqU7krG8ZgF8EofLrkqslEDNy0pHQGUHPCR3fBKnlWVK5Oy3x5Q6aRZKuj8fPl1TbydXISMVZRXEffUUgsJP6DbfyOK0/eC58lzR+yseE7A7Ay4PqGYsmeSEWo4eBAsnzvNXnpk7xy+OhHpeXcLMPQujH46Hm0TYKYK1dvmwcr7TjFCVlZ0hDKYJlYPrvTSb9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0K5e4mrUgNtQo4YqNdaChmxqWfZZ+KtHkOqkA6VdPA=;
 b=c/U9Q8SU4kn2cuQ9gtssHsHRqyaW4IUhd4bEi4oXxAVllMVh7pdfmOIurhgcOv+iShvDTpY3DGIj0iLO+Df/G/N9thG5mEf1WH2t5tlzXoPb+eJN/HPCUo6eXGaKIak8kGE1EiWHg91r3NKAk/981/6Mr35/B9xevHLxHjiuH2Sl0DDmzY+JkbWX6xW0VDjtaNI9BmdojrIqSCi05D3pbtpcF4yRlX3pghF0ezaDglF2fPq3XNx5TweC3UZ2zLHaAz0zCTOTVZ8bSiUYp/jTrnaIZ5zDhafvDAUOH2XunKbkknOX1qBRi6zlQana6DGw5P8KVEZXKxWWq1dvXNMvqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0K5e4mrUgNtQo4YqNdaChmxqWfZZ+KtHkOqkA6VdPA=;
 b=OXJmQ9LLhxPKq+yGD8IBqLelOM36l5s0UROna2qoWryEb9MzJv80pMmTjRcF1GtAe9J48RAuwy49krkSlZwSYkpGYTruBLMKxA3voSFFZy3EEnDP+HO9BMDX2HzfXavW+TNpOndG4qlX+Y1mBeuezrua80J0XY2jqU6bcR9q3H2+bboyvbPojuJsqqKeS2KTZxUPslppN7zzbgKYNHw0dDwK46pSNQ2/feEAAYTPYJoPqMxrDD9sHP5eYSzeLGA97zRhwtApTfYF5tsgPUrb1iptgSq7V69EegysRMdVEbeNkxQtTpDMUqbUoUQP0DGvQm1iRP3KcgjEDj7kAAtUYw==
Received: from CH5P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::21)
 by SJ2PR12MB8806.namprd12.prod.outlook.com (2603:10b6:a03:4d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 14:02:40 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::5e) by CH5P222CA0017.outlook.office365.com
 (2603:10b6:610:1ee::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Wed,
 17 Jun 2026 14:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 14:02:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Jun
 2026 07:02:11 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Jun
 2026 07:02:10 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 17
 Jun 2026 07:02:06 -0700
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
Subject: [PATCH net V2 2/3] net/mlx5e: Fix HV VHCA stats agent registration race
Date: Wed, 17 Jun 2026 17:01:26 +0300
Message-ID: <20260617140127.573117-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260617140127.573117-1-tariqt@nvidia.com>
References: <20260617140127.573117-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|SJ2PR12MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e789254-471b-4b58-91e9-08decc7915b6
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|23010399003|36860700016|3023799007|22082099003|18002099003|56012099006|11063799006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	eW5F96cXcdUAwXzsx53evaMHsaMojuqP9bg8Z9FVY+L99edfFACtFbLNh/SQArgzsVQtebHOxDQgQ5Ozggk0bhivszAFPhEsouGnIoTE/SrsQcXD7aFZytwRT//DJsN+ZoE9Ca3KVN/vo7Lv2vIfksVFMGWR96oGRup3Bhr3KsV7bXEl6zqIQCY4vQ4tyfgfP9Kv4TYfe76MM1NRs3eLu0rYGmwC6OFuGDo8GiHFs0Mrh8w0hPrz9t04kSumuL+I878EPX+p3UVLXSjPIY03zmYA9OeuynltL5ydZePmtxdeL5QwpzcT3S0zCP3G6WvFS3Fhtv4XLY/Gk7zTB+vNZ0CfVvArBt5rx9ijF9hiAh5mSO6UXfsNSFTRBFJeOs+1FGL+1ykhz9yoR8w11TCL6ovba8N3vzqtaNlBFXRdIXSuJMh0wWExhaUne2M9HmIFIJaEhGgpwj+4Yl8dNAngh3mBTAVKTLHvg7Z2UoNbD1TbKK7bT97tlpavajkF1cF4yNMgsW4pseD6n03jaGB2AW5d2AB47qXs9fxqZr4OZNNWCTpnSG7VF0ZeoQVpWNTfUvOYGv0j/mzdgDAMKek4IoSuP5vFwrN2rEz/Nh0ZghIc4/GT6OI2Mn0w+M5k+ubSxWv9DAmYbOXTmRZUdBGIQkqwgj9LXFHPpkqP8DpZN6YXgdg0lpZxfKVhtUhV9mwq+SM4EUSRQ08lR5YWkzhavfuIK7I1BJE1/1TRF+0Mtko=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(23010399003)(36860700016)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RkarkTfWjFxFCJngd/o31e7UQKqrcENcnYsq2ENy2L1aebEuLn63YEZuKSbBcoZOLGn9q0IBMGEKqRr3TH0NiNhuzjE0ooa834Bmhi9pWiQ/MhYAlC9y/9guLTQGoF8LZvHVue53LJ+huznVbinS8HSI2QGORZHZ6SKMZADFTv/aU+AQzjdvfejlIr+rKuME+c/WSMc8bTyRcBfRRgODA3moPzKK1OT19a6WYT67D1zQIqbs6DC7aNti8SJFGV0v4IPlUJq1F2CH0x7oe+W0G9ayDjkTxewC90A1Luhe1m/c7ILXNOQvhf/H55RmilmF4LpnZEg8ygHFEjGDfMGYrjuRuM6s4wyATsIvbmXoB12WEd9bwPqwtrftjBOaantX0EM9JUmSoknnqwBWn1DjidV2vIHMQf5qtIxjQXdlzrw3gAob8mPzKUBiRy018gT6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 14:02:35.8883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e789254-471b-4b58-91e9-08decc7915b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8806
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22319-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F4B069A699

From: Feng Liu <feliu@nvidia.com>

mlx5e_hv_vhca_stats_create() registers the stats agent through
mlx5_hv_vhca_agent_create(). The helper publishes the agent in
hv_vhca->agents[type] under agents_lock and immediately schedules an
asynchronous control invalidation on the HV VHCA workqueue before
returning to mlx5e.

The asynchronous invalidation invokes the control agent's invalidate
callback, which reads the hypervisor control block and forwards the
command to mlx5e_hv_vhca_stats_control(). That callback may either:

  - call cancel_delayed_work_sync(&priv->stats_agent.work), or
  - call queue_delayed_work(priv->wq, &sagent->work, sagent->delay).

However, the delayed_work and priv->stats_agent.agent are only
initialized after mlx5_hv_vhca_agent_create() returns to mlx5e:

    agent = mlx5_hv_vhca_agent_create(...);   /* publish + invalidate */
    ...
    priv->stats_agent.agent = agent;          /* too late */
    INIT_DELAYED_WORK(&priv->stats_agent.work, ...); /* too late */

If the asynchronous control path runs before the two assignments
above, it can:

  - Operate on an uninitialized delayed_work whose timer.function is
    NULL. queue_delayed_work() calls add_timer() unconditionally, so
    when the timer expires the timer softirq invokes a NULL function
    pointer.
  - Re-initialize the timer later through INIT_DELAYED_WORK() while
    the timer is already enqueued in the timer wheel, corrupting the
    hlist (entry.pprev cleared while the previous bucket node still
    points at this entry).
  - When the worker eventually runs, mlx5e_hv_vhca_stats_work() reads
    sagent->agent (NULL) and dereferences it inside
    mlx5_hv_vhca_agent_write().

Fix this by:

  - Initializing priv->stats_agent.work before invoking
    mlx5_hv_vhca_agent_create(), so the work is always in a valid
    state when the control callback observes it.
  - Adding a struct mlx5_hv_vhca_agent **ctx_update out-parameter
    to mlx5_hv_vhca_agent_create(). The helper writes the agent
    pointer to *ctx_update before publishing into hv_vhca->agents[]
    and triggering the agents_update flow, so any callback
    subsequently invoked from that flow already sees a valid
    priv->stats_agent.agent. This avoids having the control
    callback participate in agent initialization.

While at it, clear priv->stats_agent.{agent,buf} after teardown and
on the agent_create() failure path. Without this, an enable/disable
cycle hitting an early-return in create can lead to a UAF or
double-destroy of stale pointers from the previous cycle.

Fixes: cef35af34d6d ("net/mlx5e: Add mlx5e HV VHCA stats agent")
Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Eran Ben Elisha <eranbe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en/hv_vhca_stats.c     | 22 ++++++++++++-------
 .../ethernet/mellanox/mlx5/core/lib/hv_vhca.c |  8 +++++--
 .../ethernet/mellanox/mlx5/core/lib/hv_vhca.h |  6 +++--
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
index 06cbd49d4e98..2e495442a547 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
@@ -73,7 +73,7 @@ static void mlx5e_hv_vhca_stats_work(struct work_struct *work)
 	sagent = container_of(dwork, struct mlx5e_hv_vhca_stats_agent, work);
 	priv = container_of(sagent, struct mlx5e_priv, stats_agent);
 	buf_len = mlx5e_hv_vhca_stats_buf_size(priv);
-	agent = sagent->agent;
+	agent = READ_ONCE(sagent->agent);
 	buf = sagent->buf;
 
 	memset(buf, 0, buf_len);
@@ -135,11 +135,14 @@ void mlx5e_hv_vhca_stats_create(struct mlx5e_priv *priv)
 	if (!priv->stats_agent.buf)
 		return;
 
+	INIT_DELAYED_WORK(&priv->stats_agent.work, mlx5e_hv_vhca_stats_work);
+
 	agent = mlx5_hv_vhca_agent_create(priv->mdev->hv_vhca,
 					  MLX5_HV_VHCA_AGENT_STATS,
 					  mlx5e_hv_vhca_stats_control, NULL,
 					  mlx5e_hv_vhca_stats_cleanup,
-					  priv);
+					  priv,
+					  &priv->stats_agent.agent);
 
 	if (IS_ERR_OR_NULL(agent)) {
 		if (IS_ERR(agent))
@@ -148,18 +151,21 @@ void mlx5e_hv_vhca_stats_create(struct mlx5e_priv *priv)
 				    agent);
 
 		kvfree(priv->stats_agent.buf);
-		return;
+		priv->stats_agent.buf = NULL;
 	}
-
-	priv->stats_agent.agent = agent;
-	INIT_DELAYED_WORK(&priv->stats_agent.work, mlx5e_hv_vhca_stats_work);
 }
 
 void mlx5e_hv_vhca_stats_destroy(struct mlx5e_priv *priv)
 {
-	if (IS_ERR_OR_NULL(priv->stats_agent.agent))
+	struct mlx5_hv_vhca_agent *agent;
+
+	agent = READ_ONCE(priv->stats_agent.agent);
+	if (IS_ERR_OR_NULL(agent))
 		return;
 
-	mlx5_hv_vhca_agent_destroy(priv->stats_agent.agent);
+	mlx5_hv_vhca_agent_destroy(agent);
 	kvfree(priv->stats_agent.buf);
+
+	WRITE_ONCE(priv->stats_agent.agent, NULL);
+	priv->stats_agent.buf = NULL;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c
index d6dc7bce855e..305752dab7bd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c
@@ -190,7 +190,7 @@ mlx5_hv_vhca_control_agent_create(struct mlx5_hv_vhca *hv_vhca)
 	return mlx5_hv_vhca_agent_create(hv_vhca, MLX5_HV_VHCA_AGENT_CONTROL,
 					 NULL,
 					 mlx5_hv_vhca_control_agent_invalidate,
-					 NULL, NULL);
+					 NULL, NULL, NULL);
 }
 
 static void mlx5_hv_vhca_control_agent_destroy(struct mlx5_hv_vhca_agent *agent)
@@ -256,7 +256,8 @@ mlx5_hv_vhca_agent_create(struct mlx5_hv_vhca *hv_vhca,
 			  void (*invalidate)(struct mlx5_hv_vhca_agent*,
 					     u64 block_mask),
 			  void (*cleaup)(struct mlx5_hv_vhca_agent *agent),
-			  void *priv)
+			  void *priv,
+			  struct mlx5_hv_vhca_agent **ctx_update)
 {
 	struct mlx5_hv_vhca_agent *agent;
 
@@ -284,6 +285,9 @@ mlx5_hv_vhca_agent_create(struct mlx5_hv_vhca *hv_vhca,
 	agent->invalidate = invalidate;
 	agent->cleanup   = cleaup;
 
+	if (ctx_update)
+		WRITE_ONCE(*ctx_update, agent);
+
 	mutex_lock(&hv_vhca->agents_lock);
 	hv_vhca->agents[type] = agent;
 	mutex_unlock(&hv_vhca->agents_lock);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.h
index f240ffe5116c..8b3974cf0ee4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.h
@@ -43,7 +43,8 @@ mlx5_hv_vhca_agent_create(struct mlx5_hv_vhca *hv_vhca,
 			  void (*invalidate)(struct mlx5_hv_vhca_agent*,
 					     u64 block_mask),
 			  void (*cleanup)(struct mlx5_hv_vhca_agent *agent),
-			  void *context);
+			  void *context,
+			  struct mlx5_hv_vhca_agent **ctx_update);
 
 void mlx5_hv_vhca_agent_destroy(struct mlx5_hv_vhca_agent *agent);
 int mlx5_hv_vhca_agent_write(struct mlx5_hv_vhca_agent *agent,
@@ -84,7 +85,8 @@ mlx5_hv_vhca_agent_create(struct mlx5_hv_vhca *hv_vhca,
 			  void (*invalidate)(struct mlx5_hv_vhca_agent*,
 					     u64 block_mask),
 			  void (*cleanup)(struct mlx5_hv_vhca_agent *agent),
-			  void *context)
+			  void *context,
+			  struct mlx5_hv_vhca_agent **ctx_update)
 {
 	return NULL;
 }
-- 
2.44.0


