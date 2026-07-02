Return-Path: <linux-rdma+bounces-22683-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xJ1KLGBJRmonNwsAu9opvQ
	(envelope-from <linux-rdma+bounces-22683-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 13:20:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B24F6F6958
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 13:20:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=JPmnnA1s;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22683-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22683-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ACFCB3011051
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 11:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C073EDE73;
	Thu,  2 Jul 2026 11:19:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50E1431E7D;
	Thu,  2 Jul 2026 11:19:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782991156; cv=fail; b=kv5GEilM5zl8cFoER3gexJfSnZRk8b9AtfMG/LyY7ych/D4E1zTYy/3no4i7n9pKyZ+C/JDfdFaQDCZMjl9voBcyQdGxSrYBtrczrS/grRUyFUdMMiCU0kWTpL+vaD+64YxyxKTyoZRwJE3y6w0RzWLyLnqdY4gVbXQEnqa14fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782991156; c=relaxed/simple;
	bh=iYESMUYS/KGNxNLJd1dRwji1nFIgAEM4tCbJm1n7Jeg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sB01+aen77Gc8u0WI9CcxoqXi0Evn6eohR4Iw8KAvkw0HbEHEPyTcusqiiP+mM3G+kPca7esjvIwzXKMRaal+EYaVe0XvewGUEtYdYMrEePKBFuBrV/nQyMes2zhr/7lgxbD7KtxgRCn2r3JC2Rg1H6BRh0y+G476GM+/C0PxKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JPmnnA1s; arc=fail smtp.client-ip=52.101.53.64
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2FTA560+ntZd0oBbI00B9UyeD+3wFjGc7SAgOsb7vN4zVmlIpn16OTjdH7kCSM5+AnX+r++f8yT0WYsZsTkB3NIp0Qfd7EDVZVHRvtNlhwcQYybQOglrePFbupUjRYchIPBm3NzWT1UP5haHbUVb3iXtDwD5oSAuTN1CXj22plcGANs0lv1EsQ1ozHLeheYByKBcSA6BcTX3zfdchc2UfzMKZpDrd9G4TncjVmw/3ybkQ64z43ZSfDG2nMNojUQg6DOA84HuLN1eLvg7RDe7gbE6BCdZcVtGdaKl4V0I6Zj2tb2wGP57+rnE/k9rmg1Jed1UkUfu26qQfXWE0O+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0i6p3RtcxGaoPB1RGGNJs9Xw5jZx+a0YeG3jyuRrw8w=;
 b=kflHYV4mizluoLCIepzsymPHA2ZiEtuwDYg29BfNyOx4wHZ8/kgZOGe/u+R4ZqGlFazPbhCkelXKmNNA7rdQwYU+9KjnoosAP9VFZxsZ7m5oCMHvcxqTMu/WmURo9lrlKZeAEGgHGpvosjMa6j9xtUBhWkamL6GgFgK92Go6/yv5g0fMIdrS4Y4aBGOAfN+yibxlUliZfj21bSpgJPNYxHqI7pglwU90hoF9lmw63mW4TOtFQcjPeqtNjLZNDNfAvkjguv7/zen3wU/iKsNcRQWZeysjuB0PQTAx+xRqf8RAk0tEniMJulg6WMD0tWvzcn/d3oduWyF5XCPXGPVakA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0i6p3RtcxGaoPB1RGGNJs9Xw5jZx+a0YeG3jyuRrw8w=;
 b=JPmnnA1suUwuRav7IPem67hl2ptHWUl6aFtXKe5V1Ku4xLrcOQjvD2dc2eAioYLWzezpozrh10LnGpfZEdXQ8MCbj89/Iy2QWxTWoNSPMnfdb0YvY2TR76ByrR/Uk0+440fOH7lQLOyLkw6WXe1rmPAj+iwb9jFToUgLp74SRt0irMgATf1TTj5g/HFxezl2z7L6LFNLUhCzeJzd9MNIuKm/PZDR968+HCEpF9HPmrMDI7DgmlcgWSxZCPLHdyqaUSYZw6jFyjps6Fnjiony5VmC4mZR/rqoJOjvrbvfWgQK/aIBYIumxZtQFwTFJFcVTevS5Y7nGglVZnOJoY0XTA==
Received: from PH7P221CA0057.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::20)
 by PH0PR12MB7905.namprd12.prod.outlook.com (2603:10b6:510:28b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 11:19:10 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::23) by PH7P221CA0057.outlook.office365.com
 (2603:10b6:510:33c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 11:19:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 11:19:09 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 04:18:48 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 04:18:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 2 Jul
 2026 04:18:42 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Adithya Jayachandran <ajayachandra@nvidia.com>, Chris Mi <cmi@nvidia.com>,
	Daniel Jurgens <danielj@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, "Jonathan
 Corbet" <corbet@lwn.net>, Kees Cook <kees@kernel.org>, Leon Romanovsky
	<leon@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>, Parav Pandit <parav@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Shay Drori <shayd@nvidia.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 2/2] net/mlx5: Set satellite PF devlink ports as non-external
Date: Thu, 2 Jul 2026 14:17:26 +0300
Message-ID: <20260702111726.816985-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260702111726.816985-1-tariqt@nvidia.com>
References: <20260702111726.816985-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|PH0PR12MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e6b823b-23a9-411d-9730-08ded82bbcc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|7416014|23010399003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	9ciBjS2yLbhXUEqXT4Of20810V1Kpo0m+jMGiPSx6IiXmVTgGMN1fNwwUv1UE5qQsYAe8S0YvkNy601EjO3RAvhNWK+rtwkajP9pHdQ5NeVReEkqsuW2Pgn89HJoW+VDCLjJsqzf5qKJ3xbe25vqX+kgZ3pa2T77cR/aW6OH7s/fSvub/xKMMe0AaBQ6wgcYW0RjC6MmAx8M5RsJU2SygBEElIpqzSCCKQWJg5RHCuDvG/bt6n98YJamI+UXbNHZqExU2+0SlZXKlSix8IZ7Wip5l7ek3t8EkIfk0BPsLzT/17luZw/SVsMmAgJuXNep25E0Jlq5L3sBPvQnjYLYRONnwToCgsqmHVxy6TWaO9bHDbMPXkBeakvBwp6GPJaeNNf3rPuwHGL6ChzPMKnMSbOcWsDGWoKtH1f2klrNClaa4Q4Pl1thu/4GWR97rNvDJPzdgTzfhnwfLRL0Etal631SGYh7x289+9F81Cwb4sBIedxPaelnFd+fr5NJCGMOueyFlCJcTyqk82pXnBNXIgorIUHCSdgOcD3KXQX/sxi8Fj/AUgkhiZGDbhhCR9GEoXIDoI44d65Odum8pUi8tKVh/GfLFUqLVEwcxvUT3nmJXLL/f498rMbZxlTZwAIV50M60gvPeQjmRhvOj1n6HWLVcUHgAqTqmpHmJa4XilwaWtQPyUMVp/ufl0HSM/nYwx6nRT8MBqHIhhN214rjMQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(7416014)(23010399003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5/Ydn2oAIs9wXTVT4pYpCtxG+0enCN3KLCa+obghV+IcFjRlTNECUaSyO0cm7HyKjMWPp/n7a2qYeon6jr6qVN57yXbS2P+rBBBCF5biK/kNo5XZb5zpfDP9MzCvktJv+J63WjaSvmE8wlJgIL5Z0fkmj1G7g7Pw1TVi0ltvaLAjND2dKSV/tom2lJr/eTUzccrlX9Xaj4DG7OvvHfdfaaZFDIvi7A/UOreD4NjbAVqlwvQev1EBR/ZA+LOc+UW0NRaNoD/LDCaLWYjSVSQGuQhBedcYKjftZfC9fznxVIrqm+T1CTZ9fyIjbgM89CvghcjovmY8t9bqSCRjdOgytFqfl5tsjkfm9WvyLM3oHf8sbSBLYkQSmjH+chJwwMJ4kH+tcrHNCBfR6K/7LLEM7v0ddWxikfYO5Xg52dk9RmWxYjbwZYmP0gRBJ64PggRm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 11:19:09.3989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6b823b-23a9-411d-9730-08ded82bbcc6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7905
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22683-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:ajayachandra@nvidia.com,m:cmi@nvidia.com,m:danielj@nvidia.com,m:jiri@resnulli.us,m:corbet@lwn.net,m:kees@kernel.org,m:leon@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:moshe@nvidia.com,m:ohartoov@nvidia.com,m:parav@nvidia.com,m:saeedm@nvidia.com,m:shayd@nvidia.com,m:skhan@linuxfoundation.org,m:horms@kernel.org,m:tariqt@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B24F6F6958

From: Moshe Shemesh <moshe@nvidia.com>

Satellite PFs are local to the DPU and are not on an external host.
Set their devlink port external attribute to false to reflect this.

For satellite PF SFs, distinguish them from host PF SFs by comparing
the SF controller number against the host PF controller
(hpf_host_number + 1). Only SFs whose controller matches the host PF
are marked external, since their PF resides on an external host.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 6e50311faa27..4fcad15e7eb6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -74,7 +74,7 @@ static void mlx5_esw_offloads_pf_vf_devlink_port_attrs_set(struct mlx5_eswitch *
 		memcpy(dl_port->attrs.switch_id.id, ppid.id, ppid.id_len);
 		dl_port->attrs.switch_id.id_len = ppid.id_len;
 		devlink_port_attrs_pci_pf_set(dl_port, controller_num, pfnum,
-					      true);
+					      false);
 	}
 }
 
@@ -134,13 +134,16 @@ static void mlx5_esw_offloads_sf_devlink_port_attrs_set(struct mlx5_eswitch *esw
 {
 	struct mlx5_core_dev *dev = esw->dev;
 	struct netdev_phys_item_id ppid = {};
+	u32 hpf_ctrl;
 	u16 pfnum;
 
 	pfnum = mlx5_esw_sf_controller_to_pfnum(dev, controller);
+	hpf_ctrl = mlx5_esw_get_hpf_host_number(dev) + 1;
 	mlx5_esw_get_port_parent_id(dev, &ppid);
 	memcpy(dl_port->attrs.switch_id.id, &ppid.id[0], ppid.id_len);
 	dl_port->attrs.switch_id.id_len = ppid.id_len;
-	devlink_port_attrs_pci_sf_set(dl_port, controller, pfnum, sfnum, !!controller);
+	devlink_port_attrs_pci_sf_set(dl_port, controller, pfnum, sfnum,
+				      controller == hpf_ctrl);
 }
 
 int mlx5_esw_offloads_sf_devlink_port_init(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
-- 
2.44.0


