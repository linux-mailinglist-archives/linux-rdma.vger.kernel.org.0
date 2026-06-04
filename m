Return-Path: <linux-rdma+bounces-21780-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b5OXDN6HIWrvIAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21780-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 16:12:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D8A640B8D
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 16:12:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Q1Y1Bsxh;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21780-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21780-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A7BA3192847
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 13:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F43647F2C6;
	Thu,  4 Jun 2026 13:52:13 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C699147ECCB;
	Thu,  4 Jun 2026 13:52:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581133; cv=fail; b=u4X+dEjvogh4raiEKodiWM51xquqFw8DwM0a/u1wnRl0XS2fcHpEj/cpAsl14vLlcmYxANoi8tq48rwTEUyByGypmqAhnpQhKjGSECSkYuXPA/Ktkvee1t2TueL9SQLEJlbzJUQJfluNk+cZS3+INA9stcvg7/Dpp8lzCUVlvNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581133; c=relaxed/simple;
	bh=LpdaMvFNnPJLVeWUSoSb8fviGJQA+wM27clxRxKX3oE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DvINDevMknuAbO2VOPbfIdxdTBVpJZ+LYFKxhtPnZamF9xtQXfHN+CMk/CCb37CLyvU2V+OBIP6h8n4zvCZWtbR+JMrZLYFBS4qI9e2NS1HTQU+Sqhz3NG5WAyOvthse3+Q4s2ZjryE6XIPeSf5JNlCG8CUcs5a/cZoe75qssls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q1Y1Bsxh; arc=fail smtp.client-ip=40.107.209.11
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBSAACv0sBuhXlMoJF4sNgHHcGNsRBytTdRAz/ZYmweZwfABSEgHFGA52sdHXInutlZktQJJ4S/nnyC12KrSX3RhRWstk41X8Rc5+0zXMF5NBSgWcEX7Wzx/8aUFlkFiSCzxr2egfGnvWJc0OVxMkaWGKnpeNB+fPSx4DaQ9RYnmQ6Akh1UwfrN2Y8Se86iH5vH7rdCHFmPjulrp29eAybVw4CbmOeTIj/T8odzaufGc1IVqSrByWOHoLqYlbZ/Mu2w8x/ECHj8hVdBsdTGtoN9ADHqe4aGDM4yopKH8cSU9qqoLj6YBbKg9tWLbyqcIwiC7Y1qdNs1yLX5ymm2L5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0K5e4mrUgNtQo4YqNdaChmxqWfZZ+KtHkOqkA6VdPA=;
 b=PCTXmQbkX7oZB2ZzdMjIYiNz8d1GXi/Ytf42XSjaYMvDMeVnSkURb11dHPyNQ9q9Z0gQtQlT77Xc31OgB4pX3r9ghvR60TTul6WLrLKvIhTxRXA/LafGTkhZRkWGf4narRq8BCdJc29U8dMyiN+GGOZuCdd7r1gv0QT1YLV34H2+RecxAPlbNsis9FsmI06J+NJgRQYQmwgNAZW1JSOZzXec6UWBqMt1akrNpq+fQp2OY+XdyaldomKQ6ScgB5dCiic5xqhWlq3nZIyQ3wXCZ4BMdG0cITW4goSWVH7RnhpG3JblkiRyTUdMSY8etKo+LV4syOIz7TAxgNM7Ac4kfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0K5e4mrUgNtQo4YqNdaChmxqWfZZ+KtHkOqkA6VdPA=;
 b=Q1Y1Bsxh5DGroNMXs+VMz9oJczix50OF/uDD1RMQ+O2P4XWCe2bketl75yXsYtiERRvjFzFuTvL4hQ+00n57eS8eRcBcjSBtTF9MMu/pMxahoTV+f6G8DvvEwZssHlNhyv+Zz/9ptmOhF5zg7r+2ZPVPpr7CfjxRc84n4y4+z0IPfFWdxHqtRO1zQVQfQUuv5VLe5KJGgtEo+Rn+RBWWY7p/17HVLveaTHQEXbWXATJG+m465hqm5sCmGw5jhIfbxdYsvvd6SXvDFRz5oVrQ4vDsK7B2i1036SVKnmfK+ZiKeyfiYgYv7EbLxX3j0wFMlIh2HkkJZE39wp/ld3gdZQ==
Received: from SA1P222CA0092.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::12)
 by DM4PR12MB6352.namprd12.prod.outlook.com (2603:10b6:8:a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 13:52:00 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:35e:cafe::11) by SA1P222CA0092.outlook.office365.com
 (2603:10b6:806:35e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 13:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 13:51:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 06:51:41 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 06:51:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 4 Jun
 2026 06:51:35 -0700
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
Subject: [PATCH net 2/4] net/mlx5e: Fix HV VHCA stats agent registration race
Date: Thu, 4 Jun 2026 16:50:39 +0300
Message-ID: <20260604135041.455754-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260604135041.455754-1-tariqt@nvidia.com>
References: <20260604135041.455754-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|DM4PR12MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: 059b32bb-20af-48a7-a77c-08dec240731a
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700016|6133799003|3023799007|56012099006|5023799004|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	GRGKG3p7X0A82dcy1b/eJWhMgJCLAHtJQ0h80EzYenvYop5kIeVHfKFBz+rfC6DKjvGKX55Tz/1LkQc6eLH/sl0lSsXJYGKqu/ZMpRJetvAdGHlqPfYsSOqVd9TvQQ2SolFoxh6dxyMwgc8PzJp71dLYqIKYs0L/T2p5FkP1O65cVfStLDUS2i5M8lc+C3tCkdvK0GFhw7fvB1+H8jFjleyf4sTvz4oHBcACr2tFGJcgjwdnRUTqmrs+GxU3pN/9jT57Rg6NENKvTlrcoDZHrIQPCSvQMw8Zm3wfKqE2Qluad7mWn8TjZeeV8ZP1pj/NM4rg+F2O+dKVpDuDL+Oa3kE7nN0yHF9SYgs2bBw97bMPkoAKoAJq8CGPr7DeGeKvPA9yvgpxUC9z4xak/J78uy6EAOisM45LFqK1+12jxze0/9Z758lH1qqX2f1rZTlnlNp59ZRrHGs17A805d7WqGow9Y1R+cDFWr4UctQ+deJ4k1SwDNSWQeBgdSoaCPrDc126Zj88D9kGgiAK3Ojr4xDsPOz/9JYiFg4jpWqN5hM5leCAVYGtiPGwYs2HUJn6RPlQJGQzYnovxePhSdx/sYWyfT5rDjQxKD8AM19us34CHT8RkIXiwClftDIzGbUETPh1Sa/IDuOVUIkTXrDLnIcPe86GWLgFGVqCoGb++Vtkv1sjiyNILZiXz96q6zUU+osTHZL0CYx2ef+R9i1ECb/UTP+O/RIUKJN9iGCDka4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700016)(6133799003)(3023799007)(56012099006)(5023799004)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2PnfmvjleszzMFlI9v0ZiuoRuwXNQezoyRnXjC182ZsjTtmd0rsWcGfDU7R07FZLDUamLpvA71hd6IZbvHxFmWRqQU1tIVLY2lClUhOzj8aY0u/qJtIo0zHOa6GoqClkd8ESORNzLhTTG5WDlxXil87/C9WmTRum5GkBnhx1rfx6UlSSvMbwNaQSOqpmDVTNPYkjGVJfoTHg9MbM0ZB4mkWbvIPWeuKPA8fns/hvSETuC3InzgHHt4eleOAengcpuYzB3YNEK2s9OLq05xHesaysgKnDRJRE7jIo7m5zsdjQI+qZInWuspD722jIsU4MWQ2aG3BsnvR9RDG1v/mRXSw3Ql6jCoRbnch5cvNZyD6BWylRoQqUJxN/R0+qij+vjg6V/weh07hEM0LYYCf4w3gSDoEI3rt4r+8ghVgGB+qtud2ibwuUWTqEsYbqK0e3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 13:51:59.6704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 059b32bb-20af-48a7-a77c-08dec240731a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6352
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-21780-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84D8A640B8D

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


