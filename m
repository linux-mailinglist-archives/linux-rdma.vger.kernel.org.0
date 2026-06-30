Return-Path: <linux-rdma+bounces-22594-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HprcNm2uQ2r9ewoAu9opvQ
	(envelope-from <linux-rdma+bounces-22594-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 13:54:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEBC6E3DD5
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 13:54:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Lm8JkuOp;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22594-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22594-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A4073075021
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 11:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FF5406834;
	Tue, 30 Jun 2026 11:52:51 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011050.outbound.protection.outlook.com [40.93.194.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809F7407CC6;
	Tue, 30 Jun 2026 11:52:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820371; cv=fail; b=RU9O85eMYhEZkUye455akpLdF9RvTasIDch+7bFF8KeROyis3Qy0dhi5zG4wn3nm5/5FNSEK8Muyouq+EbYKY+7PdhpL3CyKw6AZuGOrmwdw6LvyCL05gP1YPmXLnskISQ5jVNxKFp1/17d3j/daaV6bdJc5VHEjrH6X94lWeS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820371; c=relaxed/simple;
	bh=q77cIEl0nDSFJwmGQ/F5mmBh4DlAJrzgXxALUwjXrfY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQXHXjJghvi1zt9PmFAbRKbYUJEIu/z5H4pJOGWXpkoSXw2wK5pu5HiZPSZpBJ6MuKuBe9FBblWbKhlJ3SASD8XVv/I4P/a0GbC/9g1HeaRo7EmNUEx+CWZ53WZsz5m3VQIUNTXg835PY0diE/hGLcJNUwAqyu+6EbFGjdVw9lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lm8JkuOp; arc=fail smtp.client-ip=40.93.194.50
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nh4KTHJgQy8l5GA8aoRE93zFzFrsdhX22A68AX278+Kd7aWxERo5JTnoKwEprCGPnT6m15xWfEkIiQT+ZV/FpuZHU9Zk0NaLT1l4+Rx8i1W4rUJqIIi+hw8J5ffW98SKJgImLI1nZO2ty+DRwxBTQWv75E/JgHc/5POaKPciapC01bG5B1FjabWaQj/iNLn+7G3MNYYg4tobAclAm7yV4oaEisPt8YMmXckeRFogQwFoi1bYtEat5QmCU+FqwKnsNcJdo22y2lhIrGsd8BAsSVi3f9Sx/wY01+2e9XYnPL5/y2Lcbfa2em0kVIE3/N+sQNrLbECWqaCQXsXrx+UZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okYk04eA5G791Rz8gL/eJeuPzTc4cv56rPMXaDaxqGw=;
 b=Y33+OJ9+zukL/ssgcBN+DbI7W2eGYOXCONR52faWZ7YG3yWGzxxisez6wlDAJ5ofNJnPZCd/SXpd/BIWFC1at7vyNE7J46FzwTf5DSWDZk1UEw3oZq6kQrEOLbGNV0+y2sT965HbmNvKw8r8ESArj0y2Nd0QuIlOdBgfv0XKtdYQyAcYT0zHaeEJP5fTtYOvj96pWw6x3Us0oSwpwNdzD9+TPkOpmjMtDJy5WkiPu9WhI5Y5NbXvCJNFKihQzX6rCQM6/k/C6DCp6RCW3utqt9wD2+Midb3au4C3FNMHrWgHDjVsvhFkqreumexZOFMXw6zAsJkyaTCnr+EBoGuYiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okYk04eA5G791Rz8gL/eJeuPzTc4cv56rPMXaDaxqGw=;
 b=Lm8JkuOpQzXHhMmP4DHb6aR6In8FYh+JoHiE09K64e0DP1qlKP9kmLD2Rfw6XFSEnO4FVOmDDBTryiRFLR308Yt36mIsdpBmJab7kgNm8YmiFeih7uiQsUTT7Al43Hc/VvRZDl2lyRa/DRFwtmaoMuhpdl2IOaXX+aTnvxsLBjjGEAG5Ha9c44n2kyvn2wSidRrR5nb4QkBf1BjAoAdBrJFCNbR0HZmsOYjVMRmESnNMxRSE4rUfd5Km10hjl25AfkUEeetIopsUaZS2AQSzypUFloWCB+MIshNptAoctrLJucGX2V6VzGl4jm0BP3GzZ18As4/QbFFd5LgnxK+aHQ==
Received: from BN9PR03CA0597.namprd03.prod.outlook.com (2603:10b6:408:10d::32)
 by SJ0PR12MB7460.namprd12.prod.outlook.com (2603:10b6:a03:48d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 11:52:44 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::8) by BN9PR03CA0597.outlook.office365.com
 (2603:10b6:408:10d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 11:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 11:52:44 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Jun
 2026 04:52:24 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Jun
 2026 04:52:23 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 30
 Jun 2026 04:52:17 -0700
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
Subject: [PATCH net V4 2/3] net/mlx5e: Fix HV VHCA stats agent registration race
Date: Tue, 30 Jun 2026 14:51:50 +0300
Message-ID: <20260630115151.729219-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260630115151.729219-1-tariqt@nvidia.com>
References: <20260630115151.729219-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|SJ0PR12MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: c690a960-ed65-4593-7e49-08ded69e18d8
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|7416014|376014|18002099003|22082099003|3023799007|6133799003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	+eqcNXRo+koLkImV16MlBhe/xbLdU9gXCNLKDuF7oCHm3ghAg2FYgtivSS0Xb29UI17wtZ4K80inIbVSPcsrCWA5Ywyg+xZ3kloJK2+K6GAZwQdFfpZRT34PmGR3XhtpSa5a4WxEK8NU2B3KAH2RLmpgvSoKlJ5V4YRh135M7lfgB5DAxHo/FQh0g+qyqoiAn9MEZgbfcAyNvan+UQcB7ZQBg38h4uJ1AZHvXlv5hIWUy/rlDIrx2OfS9oSkCAJrcq6zFnpYxcRZYWda0oNisURzhT5sEpJtHbWDAmkTTb2tX5+fHm2Qrjqs0D3QGX4lqPSjX5gvSzwWoLAHPbRFWScF8h7/6hX1YQQMbD42jAvfoc9nKdbvaIVISwtCqnQzEoNEoxiP7rUyaIKk/s4S+agQW92etfJ7o70XiQM00xNsWGO2+VfySlPK/Y3HEWrMDNY2Z8wSzqB0fgNixZBGbAUsPmy5E41+aFyb2GEwimFMtvvhEkfiQvUDJRlnHEiBsJe8s0SAOH80rfnmZK24Y4RWixDo3LvK9dRUVkz8ha7H/hiwLTxsZdhEvokhH1kX/UuxVxSIEkWZrDNlOqU0XnyZ1cVJ8ErQmqhipDhfl5kgM1FnXPodng6M/t7BFG9wD1nlTLZ2OZv+Gd0gGNS8O4F08yLoaf6wwe8sE//q7Vx5iqdtyMQVRx4DHT4sh2DFfji/pgpuywmqtms3nAjBZQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(7416014)(376014)(18002099003)(22082099003)(3023799007)(6133799003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yKspUAvzVyCoj5ut6HVhpvx/risbo+TbDEXYu5K5qUZNzYKNmEaqyGyijOgPYh40ISb7x0BidkiSxmFdDzT/T+49ZgSbpVf0eoskVW62mf9i5SnHxzxro/mpKi1MAZ9mj5ABZgaLSx/Ku4D4iD/VdPvAWf3Kx0OPZ9Mpy8tdEyz3Toc6YQkD1FMhdrJ0R96gBJvJ3QInq1JwC7bbR8fY7AwveZDC9U0QJwhinBpRCK27ciEY8eXO20+rVawYFVPIyW7VQDHSE5YoOGWJ31RV34iU4Jb/yj2TeSe33GlVPpH2i79+yQ5WFtbZ3/mj1xlJ6B5JWsoNfxTD2UHUGmmsgVBNjXcJHVCe5C6tiwIO2NGAADxsffjyHwwBQCndkG7YcAjecgDq3R2uws+Eplq2wagIFyrHTljp1FiGTT3Z2FBhyskfbuGATet/uCti3QRY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 11:52:44.1357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c690a960-ed65-4593-7e49-08ded69e18d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7460
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,tor.lore.kernel.org:server fail,Nvidia.com:server fail,nvidia.com:server fail];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22594-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:cratiu@nvidia.com,m:eranbe@nvidia.com,m:feliu@nvidia.com,m:haiyangz@microsoft.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:noren@nvidia.com,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:gal@nvidia.com,m:alazar@nvidia.com,m:horms@kernel.org,m:cjubran@nvidia.com,m:kees@kernel.org,m:eranbe@mellanox.com,m:saeedm@mellanox.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CEBC6E3DD5

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

While at it, access priv->stats_agent.agent with
READ_ONCE()/WRITE_ONCE() for the cross-CPU access with the worker, and
clear priv->stats_agent.buf on the agent_create() failure path.

Fixes: cef35af34d6d ("net/mlx5e: Add mlx5e HV VHCA stats agent")
Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Eran Ben Elisha <eranbe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en/hv_vhca_stats.c     | 21 +++++++++++--------
 .../ethernet/mellanox/mlx5/core/lib/hv_vhca.c |  8 +++++--
 .../ethernet/mellanox/mlx5/core/lib/hv_vhca.h |  6 ++++--
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
index 72f3ca4dd076..cdaf77650164 100644
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
@@ -148,20 +151,20 @@ void mlx5e_hv_vhca_stats_create(struct mlx5e_priv *priv)
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
-	priv->stats_agent.agent = NULL;
+	mlx5_hv_vhca_agent_destroy(agent);
+	WRITE_ONCE(priv->stats_agent.agent, NULL);
 	kvfree(priv->stats_agent.buf);
 	priv->stats_agent.buf = NULL;
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


