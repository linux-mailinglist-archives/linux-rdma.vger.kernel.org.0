Return-Path: <linux-rdma+bounces-21782-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7sX3FfiHIWr5IAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21782-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 16:13:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E65FB640BA9
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 16:13:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="QaKRd/UR";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21782-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21782-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A3BC3122E95
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 13:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4450347ECF0;
	Thu,  4 Jun 2026 13:52:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4B347DF89;
	Thu,  4 Jun 2026 13:52:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581142; cv=fail; b=Q0AJ06LHeagv1PLtbcnIhWVFZQ1o08eidysWQYBpJrSZQhHybPhYyHslFcoiLqDxvCOkAz5fLrMmEa4ram1+OZceUSvHRX70uSwCi2a1WQfA06MH48vOAeNqoJ2yO/j5FNol8jwDzpaUjtlwUqT16jkF16XnLKZepMzr3/YprIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581142; c=relaxed/simple;
	bh=GiKxY/q0cVKu5dF+b8TadOzUrDuedb5HUvQiuIRQKtA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wngp2dqYc5NEGC5A+JJw7bt9Jhp4kNj3yXCKxRA56wAkyOtRGaD0lLovHFEdx3xqzKkWR59aTI/2jq7G1u+ZweN+lKXLWBwm0MJCYPiGOz55OAuaCBAj0J+d5kKyzgQjI1Kp57MRsz/hGOh/FqrJRSkAvvwHkQuMi8cIfmu3HSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QaKRd/UR; arc=fail smtp.client-ip=40.93.195.20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9ekozg/knyKYStk0CECWAWf0OCGUVaqrWTYlJTI05TGweNZ78czFnFTIc+fQYu+s8dfPy84LpjSYNoZNhYK6h6P1uog29T1Hqb5TzFujEJqYonmmL2X+uH6j0ftpONJ6KtoHHd11p7Td5puu5enaofzbeMd+0hJAGb3lJaryh5UXKUJOv+QNvh5KHk9rY7Y/zmySyca7EJMel7PqkJ2HuURkvwhlI6PekCLXang9Rgn+fZms2AL11Ruo0xdwoatipAiy7j7Cfln9d97wh4nbDIFCFK/DgSSwfvE3ZoV8h5IpkZ3ZP+rO3/WZMixsnB62aszLlxopRbWPyMx+FdWSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7Fk0JpDN7IXmQNIaswAt5T2jcHhkibb1VJXHGALHcI=;
 b=a922X5BdCEe4AaZj13n29HVC6ddauer0n1jGXLShHFDJS8bG5v405QEztuF/Mk8BtGXQrDAFvIVFQ7WDehuAsYH35IXwQKeF3Ja6wvmWlQrdbIMa7F9UaPUL4xavwxhIDZ/XsRvTCiNsAD8qZhUAOzco5L2wKG57rkNsH3unKKpFSaTL/V4an7+yG2agmyruE7LhWIiJUqTolKTWXgzPUkt1sxYLFQ74TXoYsV1ypetL7fwhovpjN7zMZYCwMByRUFh/CWjarhUfdisn5t0N5iKC3ZHVLyvk0JGVvdqvB+C2IRwAupKjXu3o0GgQWxu+Vs/tYBfmHtqh0R3piHcRIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7Fk0JpDN7IXmQNIaswAt5T2jcHhkibb1VJXHGALHcI=;
 b=QaKRd/URcg+7CC2xFxwFPq7z7yevlTspI8vOEV70xzsymnXnun8hmCC1F726X9MCd7BtxV1bCXG2fAmOKoJm9qcF5C2QTbz1YI+eWua9ePAXxvjbc/ROUQOb4NyJnt2DAXIVIU1sr7smp7w5+NRVJHyaSio2exY+7fFo9kXd0iy5uaZeJ1Z9/rrim1gS7HIClU+jJ62484JMCaSI6nBFFtQZQiSNpVl0PcvVrw83sCSeaXi1LeqtP/OvwyUXMC7Fdf5ohKduMwskwWIO59kLwDm1ftlavSgFWZoFrrsCbNp7Xt5iFVlNHDbaMtUkprvGnVtmJ/t89YnQUX6BwOGQcw==
Received: from PH0PR07CA0074.namprd07.prod.outlook.com (2603:10b6:510:f::19)
 by DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 13:52:11 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:510:f:cafe::7c) by PH0PR07CA0074.outlook.office365.com
 (2603:10b6:510:f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 13:52:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 13:52:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 06:51:55 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 06:51:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 4 Jun
 2026 06:51:48 -0700
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
Subject: [PATCH net 4/4] net/mlx5e: Fix publication race for priv->channel_stats[]
Date: Thu, 4 Jun 2026 16:50:41 +0300
Message-ID: <20260604135041.455754-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|DS7PR12MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: 3844ae9a-f032-47e1-418c-08dec2407a04
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700016|82310400026|376014|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	jpfVBxMDgG8X8iShGZNkHSRJVKZXuVHZtc5UovOvwcUVMW5XvNIBTkSGmnOsW1NOrJxTN/m426US1UWon81MidbL75M6kgqeVCH5E8t/4SiaRD8O2KSCPDy4Pg4Lm/57gyxBeQ+vuMywVjdykd+Sc0mFj3mKZfqQBcnTIte+rjW0tELG3zaFSKgA5VAq45YRFSaXmzGEEXlZDxvl3fPh3lmDjeoC/0YIzvoqRvPKS/mYxAwEdo+QgyDHheRhRaolvTxi8hagdZMv+Q3iIiqfcIjRzu/gPYcW1z8TXAlAcAwouDHHUg0eJu2Ajo7gNuh/5RSa7dKy1eQ7912i1V0Be4sCow7lrdK4KoWLccFV4Qh7IUK4K7tLm35z+croDnFZKpwUzw7knwkZGXb/4+lETFdaCFO1PFoks/J/LxUgSlgiS170KUXY+SbEUiXox7UjTU2VDET6Av6VfiiBJz6i6yPkxUZELMgTAG5DR8BkBmzrmcUYdfSzoa8J0ojo/mNDy/hhsv11VBpFaGQ7AeyHObSSwEryTrliIrwSqrZJssRT5KlcrKf2UuzgYqpe/fnB2w32q0Q/UeN9s3Le0DBZ5Wq6PEiTcOYpcoddfA1/BrqZtNImqs0jFQULfWpn4Vdqb6BED0O7OweuMaqyR0JJgzn9UY/cioTOt+BFLksUFYLui/cKxXWB1ZMVuk54lkN5bZM6DR/UIPOqnCDLBO5hNb1to8tlM3EQVrSfPx2+ZoI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700016)(82310400026)(376014)(18002099003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	s7Y7CXWMdKCTs1gA5uppskZgMXQzJJ5FDVv+HpJTgaAO/GjHJseRvQByTJlYzhH8Q0wUdnafs3t2I8sN3Ak/Te6kgDRjlX4vprcz+JdTpjRwRXreKlM/rCLPoQRElUD2UkaqGY9/+WdzcMtIyUOvtyvHdAkZ+CbeDHyiqLYb+JHO+YrBojqifiCDgVm8YapdPiGKBWk7jj/TEDIOxUjY8dhN+aim8h4LANqqcRi74h9TtJS72DU4N4nV/ldIRMkG4tX4Mpchx+Q3IpT2zmtlDYCQLCPqmGHmSZFhezs4RlwgJiiK/AF+m1uAeh+hSHYaRbLL7MK05/9Wi2AsxGI+iyqVRiRmbcrePLDCDRW4A2pbUMcsWk2KGCP3njY3MtaxsfYudBLypQQuPDRvHRQ+s4D4sX/9/LVNISCdgorl1CGX4GS7lRapZOGMcIedOc4s
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 13:52:11.2736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3844ae9a-f032-47e1-418c-08dec2407a04
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5960
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-21782-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E65FB640BA9

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

Order the stats_nch increment through smp_store_release() in the
writer, paired with smp_load_acquire() of stats_nch in every reader.
The release/acquire pair establishes the contract:

  stats_nch == N  =>  channel_stats[0..N-1] are visible and non-NULL.

Update all readers of priv->stats_nch in mlx5e RX/TX queue stats,
mlx5e_get_base_stats(), ethtool channels stats, IPoIB stats, the
sw_stats fold and the HV VHCA stats agent to use smp_load_acquire().
mlx5e_channel_stats_alloc() (the writer, serialized by state_lock)
and mlx5e_priv_cleanup() (single-owner teardown) are intentionally
not modified.

Fixes: fa691d0c9c08 ("net/mlx5e: Allocate per-channel stats dynamically at first usage")
Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Eran Ben Elisha <eranbe@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h      | 12 ++++++++++++
 .../mellanox/mlx5/core/en/hv_vhca_stats.c         | 10 ++++++----
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 15 +++++++++------
 .../net/ethernet/mellanox/mlx5/core/en_stats.c    |  9 +++++----
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c |  3 ++-
 5 files changed, 34 insertions(+), 15 deletions(-)

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
index 42a658402592..42ca7cb0eac1 100644
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
@@ -4043,9 +4043,10 @@ static int mlx5e_setup_tc(struct net_device *dev, enum tc_setup_type type,
 
 void mlx5e_fold_sw_stats64(struct mlx5e_priv *priv, struct rtnl_link_stats64 *s)
 {
+	u16 nch = mlx5e_stats_nch_read(priv);
 	int i;
 
-	for (i = 0; i < priv->stats_nch; i++) {
+	for (i = 0; i < nch; i++) {
 		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
 		struct mlx5e_rq_stats *xskrq_stats = &channel_stats->xskrq;
 		struct mlx5e_rq_stats *rq_stats = &channel_stats->rq;
@@ -5486,10 +5487,11 @@ static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	struct mlx5e_channel_stats *channel_stats;
+	u16 nch = mlx5e_stats_nch_read(priv);
 	struct mlx5e_rq_stats *xskrq_stats;
 	struct mlx5e_rq_stats *rq_stats;
 
-	if (mlx5e_is_uplink_rep(priv) || i >= priv->stats_nch)
+	if (mlx5e_is_uplink_rep(priv) || i >= nch)
 		return;
 
 	channel_stats = priv->channel_stats[i];
@@ -5508,7 +5510,7 @@ static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	struct mlx5e_sq_stats *sq_stats;
 
-	if (!priv->stats_nch)
+	if (!mlx5e_stats_nch_read(priv))
 		return;
 
 	/* no special case needed for ptp htb etc since txq2sq_stats is kept up
@@ -5525,6 +5527,7 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 				 struct netdev_queue_stats_tx *tx)
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
+	u16 nch = mlx5e_stats_nch_read(priv);
 	struct mlx5e_ptp *ptp_channel;
 	int i, tc;
 
@@ -5533,7 +5536,7 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 		rx->bytes = 0;
 		rx->alloc_fail = 0;
 
-		for (i = priv->channels.params.num_channels; i < priv->stats_nch; i++) {
+		for (i = priv->channels.params.num_channels; i < nch; i++) {
 			struct netdev_queue_stats_rx rx_i = {0};
 
 			mlx5e_get_queue_stats_rx(dev, i, &rx_i);
@@ -5558,7 +5561,7 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 	tx->packets = 0;
 	tx->bytes = 0;
 
-	for (i = 0; i < priv->stats_nch; i++) {
+	for (i = 0; i < nch; i++) {
 		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
 
 		/* handle two cases:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 1a3ecf073913..8632b73179cb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -516,6 +516,7 @@ static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_channel *c)
 static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(sw)
 {
 	struct mlx5e_sw_stats *s = &priv->stats.sw;
+	u16 nch = mlx5e_stats_nch_read(priv);
 	int i;
 
 	memset(s, 0, sizeof(*s));
@@ -523,7 +524,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(sw)
 	for (i = 0; i < priv->channels.num; i++) /* for active channels only */
 		mlx5e_stats_update_stats_rq_page_pool(priv->channels.c[i]);
 
-	for (i = 0; i < priv->stats_nch; i++) {
+	for (i = 0; i < nch; i++) {
 		struct mlx5e_channel_stats *channel_stats =
 			priv->channel_stats[i];
 
@@ -2615,7 +2616,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(ptp) { return; }
 
 static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(channels)
 {
-	int max_nch = priv->stats_nch;
+	int max_nch = mlx5e_stats_nch_read(priv);
 
 	return (NUM_RQ_STATS * max_nch) +
 	       (NUM_CH_STATS * max_nch) +
@@ -2628,8 +2629,8 @@ static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(channels)
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(channels)
 {
+	int max_nch = mlx5e_stats_nch_read(priv);
 	bool is_xsk = priv->xsk.ever_used;
-	int max_nch = priv->stats_nch;
 	int i, j, tc;
 
 	for (i = 0; i < max_nch; i++)
@@ -2661,8 +2662,8 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(channels)
 
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


