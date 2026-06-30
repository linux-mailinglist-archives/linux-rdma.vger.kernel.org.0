Return-Path: <linux-rdma+bounces-22595-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T4JKKpSuQ2oGfAoAu9opvQ
	(envelope-from <linux-rdma+bounces-22595-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 13:55:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C7E6E3DEC
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 13:55:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=TjvMSajE;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22595-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22595-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EFA1302734E
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 11:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E8A40757B;
	Tue, 30 Jun 2026 11:53:02 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB6440627B;
	Tue, 30 Jun 2026 11:53:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820382; cv=fail; b=QHOaKU2PDw8dApOsOD2y927YNLBb9JBlwSLfhlFrP8rMAB9cLVSVRqKdn6KvTnxkDNmHt6rAUrHQy+leT/XsrGgRQe8gOGPqW6KXeQGzUt5+4ZKC3qEhOhIdqyWk0KFU/FKqKAFQKwSwmgldt40Cuyx8J1sxMyX4fa2KESj0vsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820382; c=relaxed/simple;
	bh=KVzWxYlxUswrc2DqEIoIHRAkhBURE6xyUQxZyGDm8QM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DSAHZaE0h+HHIT7rZt1W+2ezd+byMri77G8JRbYrNaR9b/77FGziOgiO9Iutwy3+Le4traWp97xVXNCJSA3s54m7xXWUeJSFEv8pAVHrr8Dk4lWuxMSaakBWfKN/Pf9IvA9Vc5dvoKCT7J2zgAZUFfbDYmbWQsmK7m57+X0tITY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TjvMSajE; arc=fail smtp.client-ip=52.101.62.52
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5B/sU92culZY7PPIG8oTQrmoP4fLSECRXNSl6ntHhO/voCHBwny3u+52bg825f1gH2XEz29ddHiNZ9T6iCbjKsU39F5BStB+0onYH+v4K8y12R5Jl+f9cfti0UczeyeY5t02r0LdD4Z0Dmj5VDZ/Bq3YkMw350qR2X78t/Zvz4A5govCT7h3xGIzOEFr9X1dTwtA+jd/LM1MC922B5rg6ExMVr+bugnHAcx2oag6b2jnaEaAWcuHx7LnNQVKU1T9jJRD8QAxR+IkDeEj4D/nOrQI2VLJLh707+4QjfdKP6+2lP67ZfeT3+7RYa7txN0IRUFChR6xhqJbamN84VGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=us1Y+mnxWVewqqpzjl1joTClEAOPmfHyvJ7xiXXoWE8=;
 b=RCy4XoHkFUtAIIklx9aOkTkhWCCL3L3s2rJt335ywTvCrg9uOpVg9g5D3SG1LbCKC9Zu9TV0ef1prlQaijkQr0iDpIdsNO+huI873NfR0aJSNZZVkoWw7Pw7GRqXHd23YHMUnvxmn61auhtGeW6DXs7RhbvFI+wRbDQrgq5ZYm1tPkGZp+cReV2PIdtt7QewxjE4ihjxZ81ocyBsEfZBZXbX7OLh6yZdY3E47KG/B+aqOTIjd53tyqw2N6lI0aCowdLUdBAfli1HZJdm8ah6wXR4tOjKQV6YC2btrq587eY5gF9DyEO8Xn5RTIlK7tTEgduiYu4MJDqwJhw4x1p7jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=us1Y+mnxWVewqqpzjl1joTClEAOPmfHyvJ7xiXXoWE8=;
 b=TjvMSajEza1VTya1zwJKdkNiDp1OqtHSpPN5JxN+kWQFG7ZREK5tOgCAqkAzB1EAlJrJCiQbIlrK6gCX2hDyqEVFCvNFzGfrDZUXZpzBhQf66AAS6Qr4nhS78vmp6yq4u9oWG3ibR+KuHtcPovCsfrCIJge+dIpL9daLLAoaSYWNkyDwdGfCbf5JsWpC9naxZtXcp9i+cl/901P8MZyCR9bvg/gRHU2tIjtroXQ3sMPUC7QU5t96dQWYElsigCUTt9ucuUHtdclku4daYkutSZRSTZOQPdElf4z9Qbagws3GdTWoABguR89eZ6+SP277F5PzN1dcm7zmtb3YvnjL+Q==
Received: from BN0PR03CA0044.namprd03.prod.outlook.com (2603:10b6:408:e7::19)
 by MN0PR12MB6104.namprd12.prod.outlook.com (2603:10b6:208:3c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 11:52:53 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::5b) by BN0PR03CA0044.outlook.office365.com
 (2603:10b6:408:e7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 11:52:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 11:52:52 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Jun
 2026 04:52:30 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Jun
 2026 04:52:30 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 30
 Jun 2026 04:52:24 -0700
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
Subject: [PATCH net V4 3/3] net/mlx5e: Fix publication race for priv->channel_stats[]
Date: Tue, 30 Jun 2026 14:51:51 +0300
Message-ID: <20260630115151.729219-4-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|MN0PR12MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: bc48d82c-dc5c-4b42-0eb5-08ded69e1ddd
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|376014|1800799024|82310400026|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tjU+qv+jUzaOSKW2IoS/W/gQvYUEaaijdZXqo4U3nndKOh6Mq3jkFa9+aVBuiAtuEAiPHFAm8xhwq4Tovqx29PK5bi5pvkEZZZ6YZG6aOD6JHtBn4e1UFUOLu/ObvbUDaInt3d9LX4k2qbmgdLu6oDKjH4lMcpzFkZU9uF/Tqkd3n6yDf5uoYS8entwfz6YMm3m1sLepdYYBVd861kbqW+TB8X7ju9FUiO3LcbCmZTvvevOpcDaD4poyBRXjzv3XdnV475OykIZIJ2sA/jj4CSYFRGouu7n2DWv0c4nihuPMxfDUu4XIn+OaxQy2aDFdZNwDeUbHAdYBsUS9I3jqSUmi0OFPlYmBl+9WUFQn8sImQebthNKPesrVari/b5zaBqOpCWbhEItu5SWvGtIMkaQjeCESQ6X8gNKjG/Q1nlmO6AOx1GwPtlhvSuoeOxdGtlwkVvQJm8R3XVbx0xeWqANW30BXnM9LbU/cvImHViQaNg3usLs6llp7Supj3+6an+4SiHzmUECGxd1zGHTY/a+/o622bvAWyWvExXQouMWd338PagUVFeBTh1pRsZxHNgmZHTEDqZKps7ueUEdZjnbEz0t66/EcR6Q2FkfG/k+jHm/Atmk8bzOD8nAzoa32tOHBD16nh/aRTaonpnt9f8p5JjvqPwupuIEUUUW0RllIIhRkjY3B97lbQvs/L0JR0WKa5sPS8Z7B1CwD6Albiw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5tq/hV/ZP1DXnIR+gwsI7eO7FBlv+odYFP7rm05jb259cJMZcahzGcCB9Ha0KuEkxOVN8EVUd9pQylEfSN7lvJeIGVzMSQyP82cJRhPf/JRxig8wTEE367dXn+AilGE+FusRjPrzuTlj2rS8pu0KhNHvIwia2tfEibUoelk1CXDKLDoC0AHHpk//losnxz2ok+n6Ap/QAWIRTuRs0yn4HKI1TtpK/eD8edkePehU1HAzACEUOyZQPmueIi5Cq1/ZIJF+1PYm7iZa3qz/mbjHDFrXgh8MRXoAbSAfJ9IWHXOrUsnTJY2ftfs3qmOiibv5Pwf09cYfvL6lttjeISuoUzx85FuV3uAuRBeYQ0H1IB6XXS9+gZOcATDLfRsD7z2ClWJom1pPsxxKXdo7a9mg/QKddeY0zpSIayUt7PjpevM5DYQRz4eKvFrIMmpSC56j
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 11:52:52.5535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc48d82c-dc5c-4b42-0eb5-08ded69e1ddd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6104
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22595-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44C7E6E3DEC

From: Feng Liu <feliu@nvidia.com>

mlx5e_channel_stats_alloc() publishes a new entry to
priv->channel_stats[] and then increments priv->stats_nch as a
publication token, but neither store carries any memory barrier:

	priv->channel_stats[ix] = kvzalloc_node(...);
	if (!priv->channel_stats[ix])
		return -ENOMEM;
	priv->stats_nch++;

Concurrent readers compute the loop bound from priv->stats_nch and
then dereference priv->channel_stats[i] using plain accesses, e.g.

	for (i = 0; i < priv->stats_nch; i++) {
		struct mlx5e_channel_stats *cs = priv->channel_stats[i];
		... cs->rq.packets ...
	}

On weakly-ordered architectures (ARM, PowerPC, RISC-V) the writes to
channel_stats[ix] and stats_nch may become visible to other CPUs out
of program order. A reader can observe stats_nch == N while still
seeing channel_stats[N-1] == NULL, leading to a NULL pointer
dereference in the channel_stats loop.

This has been observed in production on BlueField-3 DPUs (arm64),
where ovs-vswitchd queries netdev statistics over netlink during NIC
bringup, racing mlx5e_open_channel() -> mlx5e_channel_stats_alloc()
on another CPU:

  Unable to handle kernel NULL pointer dereference at virtual address 0x840
  Hardware name: BlueField-3 DPU
  pc : mlx5e_fold_sw_stats64+0x30/0x180 [mlx5_core]
  Call trace:
   mlx5e_fold_sw_stats64+0x30/0x180 [mlx5_core]
   dev_get_stats+0x50/0xc0
   ovs_vport_get_stats+0x38/0xac [openvswitch]
   ovs_vport_cmd_fill_info+0x194/0x290 [openvswitch]
   ovs_vport_cmd_get+0xbc/0x10c [openvswitch]
   genl_family_rcv_msg_doit+0xd0/0x160
   genl_rcv_msg+0xec/0x1f0
   netlink_rcv_skb+0x64/0x130
   genl_rcv+0x40/0x60
   netlink_unicast+0x2fc/0x370
   netlink_sendmsg+0x1dc/0x454
   ...
   __arm64_sys_sendmsg+0x2c/0x40

Add mlx5e_stats_nch_write() and mlx5e_stats_nch_read() helpers in en.h
that wrap the smp_store_release()/smp_load_acquire() pair on stats_nch.
The release/acquire pair establishes the contract:

  stats_nch == N  =>  channel_stats[0..N-1] are visible and non-NULL.

Publish the stats_nch increment via mlx5e_stats_nch_write() in the
writer (mlx5e_channel_stats_alloc()), and read stats_nch via
mlx5e_stats_nch_read() in all readers: mlx5e RX/TX queue stats,
mlx5e_get_base_stats(), ethtool channels stats, IPoIB stats, the
sw_stats fold and the HV VHCA stats agent.

Fixes: fa691d0c9c08 ("net/mlx5e: Allocate per-channel stats dynamically at first usage")
Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Eran Ben Elisha <eranbe@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h       | 12 ++++++++++++
 .../ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c | 10 ++++++----
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  | 14 ++++++++------
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |  9 +++++----
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c  |  3 ++-
 5 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 2270e2e550dd..d507289096c2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -987,6 +987,18 @@ struct mlx5e_priv {
 	struct ethtool_fec_hist_range *fec_ranges;
 };
 
+static inline u16 mlx5e_stats_nch_read(const struct mlx5e_priv *priv)
+{
+	/* Pairs with smp_store_release in mlx5e_stats_nch_write(). */
+	return smp_load_acquire(&priv->stats_nch);
+}
+
+static inline void mlx5e_stats_nch_write(struct mlx5e_priv *priv, u16 n)
+{
+	/* Pairs with smp_load_acquire in mlx5e_stats_nch_read(). */
+	smp_store_release(&priv->stats_nch, n);
+}
+
 struct mlx5e_dev {
 	struct net_device *netdev;
 	struct devlink_port dl_port;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
index cdaf77650164..631f802105d5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
@@ -33,9 +33,10 @@ mlx5e_hv_vhca_fill_ring_stats(struct mlx5e_priv *priv, int ch,
 static void mlx5e_hv_vhca_fill_stats(struct mlx5e_priv *priv, void *data,
 				     int buf_len)
 {
+	u16 nch = mlx5e_stats_nch_read(priv);
 	int ch, i = 0;
 
-	for (ch = 0; ch < priv->stats_nch; ch++) {
+	for (ch = 0; ch < nch; ch++) {
 		void *buf = data + i;
 
 		if (WARN_ON_ONCE(buf +
@@ -50,8 +51,9 @@ static void mlx5e_hv_vhca_fill_stats(struct mlx5e_priv *priv, void *data,
 
 static int mlx5e_hv_vhca_stats_buf_size(struct mlx5e_priv *priv)
 {
-	return (sizeof(struct mlx5e_hv_vhca_per_ring_stats) *
-		priv->stats_nch);
+	u16 nch = mlx5e_stats_nch_read(priv);
+
+	return sizeof(struct mlx5e_hv_vhca_per_ring_stats) * nch;
 }
 
 static int mlx5e_hv_vhca_stats_buf_max_size(struct mlx5e_priv *priv)
@@ -106,7 +108,7 @@ static void mlx5e_hv_vhca_stats_control(struct mlx5_hv_vhca_agent *agent,
 	sagent = &priv->stats_agent;
 
 	block->version = MLX5_HV_VHCA_STATS_VERSION;
-	block->rings   = priv->stats_nch;
+	block->rings   = mlx5e_stats_nch_read(priv);
 
 	if (!block->command) {
 		cancel_delayed_work_sync(&priv->stats_agent.work);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 775f0c6e55c9..aa8610cedaa8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2773,7 +2773,7 @@ static int mlx5e_channel_stats_alloc(struct mlx5e_priv *priv, int ix, int cpu)
 						GFP_KERNEL, cpu_to_node(cpu));
 	if (!priv->channel_stats[ix])
 		return -ENOMEM;
-	priv->stats_nch++;
+	mlx5e_stats_nch_write(priv, priv->stats_nch + 1);
 
 	return 0;
 }
@@ -4040,9 +4040,10 @@ static int mlx5e_setup_tc(struct net_device *dev, enum tc_setup_type type,
 
 void mlx5e_fold_sw_stats64(struct mlx5e_priv *priv, struct rtnl_link_stats64 *s)
 {
+	u16 nch = mlx5e_stats_nch_read(priv);
 	int i;
 
-	for (i = 0; i < priv->stats_nch; i++) {
+	for (i = 0; i < nch; i++) {
 		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
 		struct mlx5e_rq_stats *xskrq_stats = &channel_stats->xskrq;
 		struct mlx5e_rq_stats *rq_stats = &channel_stats->rq;
@@ -5488,7 +5489,7 @@ static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
 	struct mlx5e_rq_stats *xskrq_stats;
 	struct mlx5e_rq_stats *rq_stats;
 
-	if (mlx5e_is_uplink_rep(priv) || !priv->stats_nch)
+	if (mlx5e_is_uplink_rep(priv) || !mlx5e_stats_nch_read(priv))
 		return;
 
 	channel_stats = priv->channel_stats[i];
@@ -5512,7 +5513,7 @@ static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	struct mlx5e_sq_stats *sq_stats;
 
-	if (!priv->stats_nch)
+	if (!mlx5e_stats_nch_read(priv))
 		return;
 
 	/* no special case needed for ptp htb etc since txq2sq_stats is kept up
@@ -5538,6 +5539,7 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 				 struct netdev_queue_stats_tx *tx)
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
+	u16 nch = mlx5e_stats_nch_read(priv);
 	struct mlx5e_ptp *ptp_channel;
 	int i, tc;
 
@@ -5549,7 +5551,7 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 		rx->hw_gro_wire_packets = 0;
 		rx->hw_gro_wire_bytes = 0;
 
-		for (i = priv->channels.params.num_channels; i < priv->stats_nch; i++) {
+		for (i = priv->channels.params.num_channels; i < nch; i++) {
 			struct netdev_queue_stats_rx rx_i = {0};
 
 			mlx5e_get_queue_stats_rx(dev, i, &rx_i);
@@ -5585,7 +5587,7 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 	tx->stop = 0;
 	tx->wake = 0;
 
-	for (i = 0; i < priv->stats_nch; i++) {
+	for (i = 0; i < nch; i++) {
 		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
 
 		/* handle two cases:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 7f33261ba655..de38b60806c2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -515,6 +515,7 @@ static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_channel *c)
 static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(sw)
 {
 	struct mlx5e_sw_stats *s = &priv->stats.sw;
+	u16 nch = mlx5e_stats_nch_read(priv);
 	int i;
 
 	memset(s, 0, sizeof(*s));
@@ -522,7 +523,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(sw)
 	for (i = 0; i < priv->channels.num; i++) /* for active channels only */
 		mlx5e_stats_update_stats_rq_page_pool(priv->channels.c[i]);
 
-	for (i = 0; i < priv->stats_nch; i++) {
+	for (i = 0; i < nch; i++) {
 		struct mlx5e_channel_stats *channel_stats =
 			priv->channel_stats[i];
 
@@ -2614,7 +2615,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(ptp) { return; }
 
 static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(channels)
 {
-	int max_nch = priv->stats_nch;
+	int max_nch = mlx5e_stats_nch_read(priv);
 
 	return (NUM_RQ_STATS * max_nch) +
 	       (NUM_CH_STATS * max_nch) +
@@ -2627,8 +2628,8 @@ static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(channels)
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(channels)
 {
+	int max_nch = mlx5e_stats_nch_read(priv);
 	bool is_xsk = priv->xsk.ever_used;
-	int max_nch = priv->stats_nch;
 	int i, j, tc;
 
 	for (i = 0; i < max_nch; i++)
@@ -2660,8 +2661,8 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(channels)
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(channels)
 {
+	int max_nch = mlx5e_stats_nch_read(priv);
 	bool is_xsk = priv->xsk.ever_used;
-	int max_nch = priv->stats_nch;
 	int i, j, tc;
 
 	for (i = 0; i < max_nch; i++)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
index 0a6003fe60e9..674bed721e63 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
@@ -135,10 +135,11 @@ void mlx5i_cleanup(struct mlx5e_priv *priv)
 
 static void mlx5i_grp_sw_update_stats(struct mlx5e_priv *priv)
 {
+	u16 nch = mlx5e_stats_nch_read(priv);
 	struct rtnl_link_stats64 s = {};
 	int i, j;
 
-	for (i = 0; i < priv->stats_nch; i++) {
+	for (i = 0; i < nch; i++) {
 		struct mlx5e_channel_stats *channel_stats;
 		struct mlx5e_rq_stats *rq_stats;
 
-- 
2.44.0


