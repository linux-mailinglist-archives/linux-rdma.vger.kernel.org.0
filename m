Return-Path: <linux-rdma+bounces-22408-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gto3CZL0OGo6kgcAu9opvQ
	(envelope-from <linux-rdma+bounces-22408-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 10:38:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CA06ADCE5
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 10:38:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=pkdcVOGp;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22408-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22408-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BE56301C6E0
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 08:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB9239280A;
	Mon, 22 Jun 2026 08:38:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013025.outbound.protection.outlook.com [40.107.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8802535E93B;
	Mon, 22 Jun 2026 08:38:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117486; cv=fail; b=QAiZt4PqNUAncY1OuMlU2IqEAupUcSx20z6wVn7FzGzimHaUOzHd0CzP+gzBzjFsGUNYnEXsUWgs3ELaSAcr3xbKada6XJOwVKBUzan+u/IX9Zvlo0M3xuqoeANjmAnKPRF53AoQ6Ls7W5au09LrfAC7Ynfe+P1UXLKuuPbJYI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117486; c=relaxed/simple;
	bh=O0na6Aua0oF2p+F+jUT0xRN3Vs8WYLOmW40maXvwQL4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oxJCL6SIO2CS0XtNS+D7rOBSHC2hcmA1KMlzsH/QovT6zO78Bj8mNzaqfzfZcdXx+CGY9hh5IN0dAiz4btg8C+4OKW7Ifvol0p17eD4O8AuvnS6LWrkBOzUSIUeTFUwbOgN0eZex0ZRW4I7KRiWLclfrq7HnDfDTee9s54uYGAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pkdcVOGp; arc=fail smtp.client-ip=40.107.201.25
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBsd57Y6UFgcvXDzyxOhMiGTcGn8QMIpfW/xUTbgytJuNAvclDuZ36EyussRAPdCdAzQXDw2vcsci8JGeLK0ksmEI9pt2HnnTi2C1oWnwzSA5zgQpLcNQDwfZosdWJKJpTK3Rb+NpojA9fnmB/GzfZK3cem1S6DHB/h7fJhBfQHBAD5pUmyvwkr6ZbVV2nQKTqXsxGpWsVouSuIJp9dkRenJUZimnFmPiaNLx56w2ZUDL88qgVFb77BjSgiMQOykFjjVbjjnvTj/Y8013JSfm+LMxO61h3VdVRpsHYiuA9BNBgezQK+nYU1WWrEMlvP6dEQ9HLBH+3Q8T9kSSIuqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wN4zhZq41/Zj9s+czB1kru67nr3o3Vm/ik1RUdDiFg=;
 b=PSQtHEiKaLMPaC9cdUZiRKP+CZwOZ8Fj1oy8YF7xR8xxyXHSpAwk+qLsv/+MaS/9qBP3O9kkgMW9B3SLbr2GA6v0aF839TORvxNpx5kdtGNmZQVMRut7dh6myddY/N2B5WpMgNNkt70QkvFYa2BWxYwXM/xwy4Od8SV+wqDMsH5KbUGJcVmqCDqA66js9hkmjKZ1ptKadB8x1QBDgwBh/1NJX+Zj6KktGVvmIvHtgEd9aNbD98Ip/ZyqDAUYMoylusktpgzqC9Ut4Mjle673cIGKPIXiBXZZZ8owZLbIAM4eNeTclNcg2XkJYX3Bh9RVEeG6wp6zFAhu2wcDam64xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wN4zhZq41/Zj9s+czB1kru67nr3o3Vm/ik1RUdDiFg=;
 b=pkdcVOGp2DiaTx1OXV1Vm4lkQ0bmjQ8aXSG4BxVYtcuhULPz9EUXQaJkCiyHnIYjS9UlY7wEcIeONO+Ch0ezwSCRjuu+Jwv+Y9nD2SN56c/uSXA3x5bsCGgyQOadvieqbtu8sc/tfphkdjvw4PoppcFZ7aShxKmxC03qP9M8JDw0zIR3sFr4PkDUn96Eae+OedAgkB8YHcQlQpqb57Z7KxRRdPwOeQyd88wCr0Rq3vFUFKAMhXsjApa98/vPuKI5vIo+nja2EkJAN6Vy5oUyZPtUCAaUzXtOjy29Rx7fOqA9dK02k0ltj3iOuAhsvVGU8j3l/EjcACIu24k5X/cn/w==
Received: from CH2PR05CA0028.namprd05.prod.outlook.com (2603:10b6:610::41) by
 IA0PR12MB8929.namprd12.prod.outlook.com (2603:10b6:208:484::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.12; Mon, 22 Jun 2026 08:37:59 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::40) by CH2PR05CA0028.outlook.office365.com
 (2603:10b6:610::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.11 via Frontend Transport; Mon,
 22 Jun 2026 08:37:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:37:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 01:37:44 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 01:37:43 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 22
 Jun 2026 01:37:37 -0700
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
Subject: [PATCH net V3 3/3] net/mlx5e: Fix publication race for priv->channel_stats[]
Date: Mon, 22 Jun 2026 11:36:45 +0300
Message-ID: <20260622083646.593220-4-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|IA0PR12MB8929:EE_
X-MS-Office365-Filtering-Correlation-Id: 923fb705-b181-444f-4e33-08ded0399038
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|36860700016|376014|82310400026|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	OCN+LO+D6XgXohZAghseLlJht/1XEIHm54szLBNr0M1IeHzAK/vtTjeyACMIGUGVTGcBKkwuUmB4U+yiP0eB8jMA3HmvFUUiUHi84nVZp9Z3JNgW7HWhZZJKoZN29zJWNaAHyJJ/Mwd5TaIxXMP0UeoHW7PVKcYjRAC2kbE0+tDGU15eqDzQh+4+sf8FA5qGL+3gD5gPuZspRV4aB2mVLuNppr7byNL8I4HZQ4IxgAixirTLcTmX3iNq7Uu9J0EBnhHUieMK0pFCsh+zfg36aYXTEo3wnN5xa+kw96VRQG8pfxQ0bQx6Gxia5diplNfojVOkXnBYqHa+W33Q06uGGO1V9iVK5lQOXOeMaI/FrDV+p9fB6Uy8PtgKTcWwiyYA1LlEAbnTl2hnjQakj520KoPwQNMQjocg8NmvGMNkWUmto73CCwsVRBL66fPTzYj3HhvKpMsTdKf7vxJx2lHT9QEd7zQCTTfZkZOTNdb3JBrub4hIBQWm99PDPLOvWiO4+WNGulIbJnpvEd6cMje/J+MvRM2yDQqiIx54RQP6DSShI5WFVE+DQVzj6F3qqSQIyxHUhLprbqu7TVZ9yci976gLZgKHwPxIHbYsCvAh3QyMzI4NV4iH/bl9XQdtGT6M2z+oPV1O4dZpBOOIbiD+2D1OLy4ku+RegKSph6bAWkcermZotS2J2FGI1YlZ8erJXCgR21wgKc0UoWKJnKVAcA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z4qISAaM0pfpMy9zuqVzs0ggiHXf3+YV6rLtaeh6vz+PAk/urDtJEmS3DHh2N4yM7dgNPDC+BbKTsTNHSNx61sW4KNNcTVovqU4bkscKH+T3349tIL/XRRMAjT1WNQKWnJP72Hhe7A5hbEJhnCTTDYmnE/7UewOwUFYCEs5Fjs88U8nSDWNQjAHF3GjJS9BHgtWBpPDtJ8EPk5t1j0Y1VzpmQWm1Xl5YezPdvH1RmgFqhEpVhtIF2uXBNdGaGWjYcbyPoZqrElV7KEEQTMgnC3V5+kFElD2o1To8Q3JpyYICLpRreSzIicWhZ3sa2JRy5Ot6x/6QlxNvMBzaDsY4cVYOl8d8RPHxmU7oHEkHnCjYkAIzvw6TxApsdNOQcPYwFckbtN5fKxtZkJlkgAd0ZY7dFMGPmU9uA/+Y451lYUcAOQOhJoBo/ls3gT6uoLK8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:37:58.2962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 923fb705-b181-444f-4e33-08ded0399038
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8929
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22408-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82CA06ADCE5

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
index 2e495442a547..9747d7736d37 100644
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


