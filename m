Return-Path: <linux-rdma+bounces-22407-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y8OAA2r1OGpWkgcAu9opvQ
	(envelope-from <linux-rdma+bounces-22407-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 10:42:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A18AC6ADD2C
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 10:42:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=RDMaS0OO;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22407-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22407-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C246E305F0B0
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 08:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58DA3921C8;
	Mon, 22 Jun 2026 08:37:59 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013009.outbound.protection.outlook.com [40.107.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B21639182F;
	Mon, 22 Jun 2026 08:37:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117479; cv=fail; b=NnRGep7u1Psei1TK084CDrNMF36NrEuqxiCuv3fxT9J8P7nqIjfWYPuQXdCB/qwviF2Z/OMWwXAWdijfM+CFF6Hsn3N2oYb88y0plEpiwZs7wwMwOLdLgyx3KQU20bH0rwOs6Llcd7lNJjSjRpNpxXww/ihnUCgHdJ5lGzJJVIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117479; c=relaxed/simple;
	bh=LpdaMvFNnPJLVeWUSoSb8fviGJQA+wM27clxRxKX3oE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1zpWZuAYyUnGmNmmvolB/tDDKUWm+StwT7/ejEvK7Ye47GZxmlhzTrseH8Iywsfx4Cas8kmTmU3OBBjusFAx79BtynBg9e6ejyHobLNKAllfA/nvxQmKTZGELM7MvBNcf+rkS8vN2hGySTCxMLeK89oEq8pUULzVN3Ln7tQZYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RDMaS0OO; arc=fail smtp.client-ip=40.107.201.9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3ZXIv7SqGaUBxZmh2Jv3Nltz1xzpLXRMLUhdYYXckcm5tKm6Rm2IZAE7gxI44IbtyYJ5bc37F6h5NGikmteg9z+suzH+ygbQJMGmDo/Pquc+ZIAmIOVvx6EwCh0yJskcUx9TxucV2sOvV4Sdx5UqoVHrUYDQpoJlktGAJA33P3CFtdJX1rjEza4+eYeUZSInybXrqhrFhSdCNtvhuB1rPDbuG2+k43evSo2zs5E9fsLoLCOrNxro7fb8hlL7Au6ZAqbl37sdl4RgKu8P1e/S9sacp18U+sOI8SqgtWxtHffoTXaLNP8TTAUed7KVLSMknbbokdO9w2A76MRhi/u+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0K5e4mrUgNtQo4YqNdaChmxqWfZZ+KtHkOqkA6VdPA=;
 b=DnRTpxQ30Bt/QlOsRwvN3Sh53Bcnfdx1i+lG8hNxGT8o2++h+F07vgkx6W0r+vcInDP2LHt6ClhUlI7hgS4q2XYOEn+5q4mzqCWq4ZJlJoXXVTH4EVtPzCpKFIHtPe9kSMnPDPHtiZ874ozk7TKOLvbg3HcnDNc2MTo0HjYFCUYwRrtgpKdwLUipvvadvhwFXuKxazm+OyR61cCvMdiGFCzSat6qZQGD8VqT0dWio22vkvObvdSjz2OCSdG+AJUB95otyIicESheffxJImwkYNgpCZ3ox4+5xBZz2fhpc0YNk4VpdduEteKUK1aNJt/Vde0re8d0MCpW5Mmhjq9zyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0K5e4mrUgNtQo4YqNdaChmxqWfZZ+KtHkOqkA6VdPA=;
 b=RDMaS0OOXxly8YIKKh6npBD6x/6Z6BhmIhxLhhwYKIx+hIpMxRCxxKOQV60SAqKstR+7XthdLWoa3ybd5XZi8lj1Aem5fWBqyhOJMARVPpLCDbTie6f/eJeCqK65Ew6idpVAtU/6b+87IoNGopwVXJVcUiimLQ2HUCvBe5do7U6eIS4TtajZ+3yicsualqZZDVLwQiEkLexg7d812HQn1sRo6M/lw0PG7L5pft1/L+HH9KgK6MpxeFwn+TSMOu5CENKQl/nCBSYQUaNlrtYm3udzVNCoSgssL+tm4O6EqbFq99sSL95/iG2hiyK53BReZ4WB/Q/Cd1QgmUfrunHd3g==
Received: from DS1PR05CA0023.namprd05.prod.outlook.com (2603:10b6:8:23f::9) by
 MW3PR12MB4444.namprd12.prod.outlook.com (2603:10b6:303:5c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.20; Mon, 22 Jun 2026 08:37:48 +0000
Received: from DS2PEPF000061C2.namprd02.prod.outlook.com
 (2603:10b6:8:23f:cafe::a1) by DS1PR05CA0023.outlook.office365.com
 (2603:10b6:8:23f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Mon,
 22 Jun 2026 08:37:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C2.mail.protection.outlook.com (10.167.23.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:37:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 01:37:37 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 01:37:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 22
 Jun 2026 01:37:30 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Cosmin Ratiu <cratiu@nvidia.com>, Eran Ben Elisha <eranbe@nvidia.com>,
	Feng Liu <feliu@nvidia.com>, Haiyang Zhang <haiyangz@microsoft.com>, "Lama
 Kayal" <lkayal@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Alexei Lazar <alazar@nvidia.com>, Simon Horman
	<horms@kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Kees Cook
	<kees@kernel.org>, Eran Ben Elisha <eranbe@mellanox.com>, Saeed Mahameed
	<saeedm@mellanox.com>
Subject: [PATCH net V3 2/3] net/mlx5e: Fix HV VHCA stats agent registration race
Date: Mon, 22 Jun 2026 11:36:44 +0300
Message-ID: <20260622083646.593220-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260622083646.593220-1-tariqt@nvidia.com>
References: <20260622083646.593220-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C2:EE_|MW3PR12MB4444:EE_
X-MS-Office365-Filtering-Correlation-Id: 9319c0aa-1246-4571-f1c0-08ded0398a1e
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|23010399003|376014|82310400026|1800799024|3023799007|56012099006|5023799004|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	B560bczO9ShcHrTknByWKMTbF/jYcDrOE8izwjFD/8EUpPHRO5FT+u/c9Ham/n/ELt6Pv6r6wJ72m58Qapb43dkpYmtDw7dkyJj4cniED98IZM5pkZ9PwpY8h9GQkW/NO9v0Oap9Jd2xkpj1VDeTB3qDd/YFDyVot5lzG+rCVwpb4mFp3sTi6WrSOnxaTZ09AN1U60G2BAmAshIAPc0H82nUy2nSIwqJ6Td2iwqqijT/XEmivHtpeu3QUnqxk8KpF03MSrapmczRc9JnKVzBmyZwUJ241u/+WghiRAmJhMwLHrFjdjZ69FmCUKYu6MqSJzsSrqVJ4Hh+RIWK3u90BnAOa9c9C2GGMeVOBXgaSU7/FBapv12CGYG6M/W3D7xVTsixDJowfMIlaopWYfL2sP6hSLmZKPzZPUNaxxeuok+Fsr29KVgA+vjZaaMKUdWiXbIumtuYLmaPsKI/H7kQhe+UDXj1pJHAY/vl4kgUKaQvx5YH/pvGOie8EhLJyUnIgBo2iZjPPB/z9/+4orzAHx9oJ5zjz6hM6bSWG+OUAGmXaIh9Qc0pWnLjVXd4vdv2qK7L2P3vn6Ne/gEPJzM+eaowlEkqzWF0rlMfcQdzK8RYekJ7nIMzZurgjgvSoHuRNZfx2BhiYMxWoO7WS+RLsSHUjIgY7iCcMXGlJKHCR32yqJUjeJ87RtvcjEKcAsBGuhcEUT4fDEASFV0lqfrptg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(23010399003)(376014)(82310400026)(1800799024)(3023799007)(56012099006)(5023799004)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NyFSx/wuogLfPPoJmn7P4thnGGXTue2eidqQafzQJdZV60a85XRwRNZ6BZxaGQAOHA9idh0aA5yIh4H7J1dI+xp525KAIk0bV9ecqHGM+MuNhNliNMEijCP2cRzXjCbCcXYaBxB32QXgo6eBCril9YZkNMhg2Bj6OPU8kV8DS05b+EDjVXW+S3FyB8gC08WynkNkdWWBoo0iX+txgdl7bTresogo/78hlAS1EVvidxSNvrtECJAVvbTFKwTfuSJYQOJTl51zxAQ+2Txh9Om6x5GhVZvsJlpFQjw2DQeSLvcqQnRTFqQK6NNjRlSWyhOOnseUf379BYLtFD5d8RgTM89r4tce1qDprmhLBaNlFlhmSg4LenE7b4vq7Qs62au+LIqnvdUnfqXZNxXapEnZZr+ij2dtI46LQjjzZ2ltcWFsSaJKktv2ZYv3c/hFRI9g
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:37:48.0747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9319c0aa-1246-4571-f1c0-08ded0398a1e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4444
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
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22407-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:cratiu@nvidia.com,m:eranbe@nvidia.com,m:feliu@nvidia.com,m:haiyangz@microsoft.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:noren@nvidia.com,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:gal@nvidia.com,m:alazar@nvidia.com,m:horms@kernel.org,m:cjubran@nvidia.com,m:kees@kernel.org,m:eranbe@mellanox.com,m:saeedm@mellanox.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A18AC6ADD2C

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


