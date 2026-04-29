Return-Path: <linux-rdma+bounces-19744-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBoLJ/hm8mkBqwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19744-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 22:15:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B5549A067
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 22:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3AA2E300AC97
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 20:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0556390222;
	Wed, 29 Apr 2026 20:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i9SMuwNJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1494F28CF4A;
	Wed, 29 Apr 2026 20:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777493749; cv=fail; b=Xz7BAYwgaaPVkhT2CpEwxQVUkvpCprm37zTarEQbrA+LNX9IvNB6vrnr/olUQuLi6Yu8bYkGO1it0uH39tttnM71yW6scY3uPzSlkYjUi8JmMFLMnfP+8bskzAq2hEoPXExWBAD7RlDaoB9dF9jpLIly0EmMM5V/KuP4df4IFFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777493749; c=relaxed/simple;
	bh=BBnTewlG8JTakZFrtX8ZaYan/JpUBt9dAAUwK3zPe7M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MG2wMpTNZPIZwxzhrbyXP7jILqoiw5R75ecoVFj4EUV601yFle4lUZbEleAhdYkWr2HV75SEAwoLFi7DeZGGg7mxq87wYSaT8rxzQI0PZPYtBW5yK2bRn+hVPmuzfgdCfFv8e3GZvfUfiv9Pq98TN0tKlDbPkyk+XrvnGwi9SLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i9SMuwNJ; arc=fail smtp.client-ip=52.101.52.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHFMJjjwCMO8VrebLlSlNlXg5l4i6rw4KVsacCnjaKqQE21y1Qra1JXkTcR7L+YdFJKVy78hzSO0jfqDgDtPdLluneCrv2V8xQdYMZtSoJ+rTtJIGuYmwKISxNgn/J6Sl5T+oRgK58j86nDUvQgMBIzVanzEYZAX0tCV2h8Bg1eb5V93R6Zj+ye7m2Ee7TJKDu5SSGr9HPwza03rML4/6LayiWiEwIjPTf2bt9buth/Gy5DCwwwZ1V6IUCTabasizde0JKq8xfTh7ike+HjY/TR5GTxhliqVdLxBdy+UjPbDfqUV4nOcaBhAF9HG+Uqo7fdnErnz1gbE3EuUsFTeXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R58Z+yoWVgX4lP6i9cdXzijnv5c1nvkGRagJeHl7MM0=;
 b=yV8sFsWHXcrcYe7BuCjo88YCSGX5tX+DbMoJ2sYylcVBVLhNXK8LCK9ir6IssPMawC3wAjoLGpX3K86NJqsmk0PqVw7KC5pJTmMwnZomijDYZqRHsYsCPB0Xqx5xJzfuzSwxCUVCKV4BdzKdOPNbDEIOJnmGThXZyJe0IWJB5yd8Aw2nyhMAPbt2DYErdG4Ll+ZVRSEeEyE0+nepP6GI41E9vTi249psHiIQrP6Kwwq+y/mCXVix//lmolUKDHkvOt36UfMWFPcMxLrQvwXO1cLlZgjlGEApq7KX5/cgLQNvk11Q8kc78tbeMi7JKuXc1ylaGws0e2ap1xsmkuBAFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R58Z+yoWVgX4lP6i9cdXzijnv5c1nvkGRagJeHl7MM0=;
 b=i9SMuwNJlQawcylRUkVc+QL3ZP9NjBeUyi7/5TRSm+YBN8y/cpfq/4rJacNc6QvjJDCdXVcg49nleyImElkSZ11ejZ+sQ3e3i1cS3Tt9xnt6IJkFxqrcaJTyyO/jT0cIZjJxsHEWnAljg5pkycsoMLMdO8w/KUpKoSj/xsQqMqFIfc1YPPJhTTG+xweP3Dy+aZnk3QoilPEJSCL4Tt5BljG1aajWo3Q65PIE38nvz2MNwc7bqpXiTttdCwwPIGOCrzm+xD1OQYBJxOF5SEcUV7DyxvceBHpKcpzsPRcMMFY8PLCWMZDZy9z7TPSea1lVAioPwoNffeQWi4+Yd7/1SQ==
Received: from DM6PR07CA0083.namprd07.prod.outlook.com (2603:10b6:5:337::16)
 by DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Wed, 29 Apr
 2026 20:15:41 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::de) by DM6PR07CA0083.outlook.office365.com
 (2603:10b6:5:337::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 20:15:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 20:15:39 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Apr
 2026 13:15:23 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 29 Apr 2026 13:15:22 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Apr 2026 13:15:19 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: [PATCH net-next V2 0/3] net/mlx5: enable sub-page allocations for mlx5_frag_buf
Date: Wed, 29 Apr 2026 23:14:26 +0300
Message-ID: <20260429201429.223809-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|DS0PR12MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa71e4e-5f3e-4779-6423-08dea62c14e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|13003099007|18002099003|56012099003|20046099003;
X-Microsoft-Antispam-Message-Info:
	3UHYU++hzZuDThZfPdX+rv9znLVO37gmxxM1wrpsVd7YZYmDf4xU1JfDmwZCl2ZND1QO87YN6togI+5ixRzzRautqb4oBTcenW+jrzBeXy+NxtXSWYq2oQtTUMpZ+tm1ciyPJ/XRIMmBobr+CVWs3LPNSPtVUDrLL6gty1orqom9hAnaclvq3jpaj+Xvj3P+MMD5qFjR3r7WuASzM/wueRLnSYZhA/Gg7jAWj67dLIEqmX5ZkUHFCansFH/ABO7yCIJtsReL6QS2zX4vw7CN6fkjL5HTUTLrkNwNbBWJzSwaq0Y/AQ/QqfQumaIqOkebL39+I5LXWI+XymIlbxd+SHlPjYFKuMqUtdQD7enczi6eJT58OJwz5iocWPu5yAdLtrYxrv4eAsQEoW8vABhPDe1Us6M9RNSK/lovzX+HF7i89OTe7wgfG3HCRqWIxP7EPjrNyWEKbPVe0B1rTPmnCgDht6xh/idLkwI4BwCP7VuYMffbfozT37v+/ANQaQZt4Hz6sUAbVcliSYXqKL5Yb5NpbR/WQmqa6i/w1jv2MOeQ4KChTtC3CYriWs2M+gJqnORTv4p/7jdh08hfJGHeuo+HKfgFJx0I5Czq1oTUl4ZMhcPxkPTH07Svht9vYGvdDPPENVDOlRixz5RnASP3jqe0CHcqwsgSAw8nl1DEW46mbSdMe26sX1SUzY78s+hhqVB5rJEvvQSfGpyP3oWiw6mGRf5vcWqIcmEwhzaxoCACSx7ms/iLNhFdpcCo0nrJbS9sdZphc0HoUdBvhRA8/A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(13003099007)(18002099003)(56012099003)(20046099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wBzjqad1TNdIahkl7K9XflXow2JaHkEsIRFTGTIeLOaTSWGPq9WbABgAZ2SJJkE0PsR+4o8OC/7IOj2Shg+xKPTJqwz6hF+bZwpuc4GLsAysHvJHuq79Zt0OPuug9wtmSDrgVQmFZXNNZKBgEFCoO1sv4yZsDmpAC6HSqmlcUQG+jcdkR1Q9Ia8O8uvihDMBU+ryFe2CYd3R4s4Sm9S0FF41W7uiNvYBCkZtd6bFVuOZrfElTKlYitxmEho/8j/QrtttQRgoYYyg/YUTZ1iTmE3IpxWWC456X3J7fuLTSzbDvD1m4b/Syir6RtMVnvLP2q5Dh4trHssKsyWqOwY+lHZ1zWNeOBMOPgfwYZEyfpo4UON4MgaSK5qq5KtHuUOvu00guRKl+gto+SzA5eNv+AFKy+uhkVo+Zvk+n2e47xmHD7RNApbcXUXT5iigM4QN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 20:15:39.0999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa71e4e-5f3e-4779-6423-08dea62c14e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8442
X-Rspamd-Queue-Id: 37B5549A067
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19744-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

Hi,

See detailed description by Nimrod below [1].

Regards,
Tariq

[1]
This series aims to improve memory utilization for DMA-coherent
fragmented-buffer allocations on systems with large PAGE_SIZE.

Before this change, such allocations were page-granular, as they were
backed by full pages. On large-page systems this caused significant
internal waste for small objects. For example, a single 4K request
consumed an entire 64K page.

The common kernel solution for sub-page coherent DMA allocations is the
DMA pool API. However, those pools do not return pages to the system
until teardown. That behavior is not a good fit for mlx5_frag_buf
allocations, since they back interface resources (WQs and CQs).
Interfaces may be removed dynamically, so their memory footprint should
reflect live usage to avoid situations where large amounts of memory
remain tied up in pools.

This series introduces a lightweight mlx5-local pool implementation for
sub-page coherent DMA allocations, which immediately returns free
backing pages. It wires mlx5_frag_buf allocations to use these internal
pools, while keeping the mechanism reusable for other mlx5-internal
coherent DMA allocation users in follow-up work.

V2:
- Removed defensive WARN_ONCE() checks per Leon's review.
- Link to V1:
  https://lore.kernel.org/r/20260428052920.219201-1-tariqt@nvidia.com/

Nimrod Oren (3):
  net/mlx5: wire frag buf pools lifecycle hooks
  net/mlx5: add frag buf pools create/destroy paths
  net/mlx5: use internal dma pools for frag buf alloc

 .../net/ethernet/mellanox/mlx5/core/alloc.c   | 293 ++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/main.c    |   7 +
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |   2 +
 include/linux/mlx5/driver.h                   |   9 +-
 4 files changed, 277 insertions(+), 34 deletions(-)


base-commit: 09942ddedcb960f9e78fd817ec33f501d1040c5b
-- 
2.44.0


