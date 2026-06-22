Return-Path: <linux-rdma+bounces-22405-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ArUcJK/0OGo/kgcAu9opvQ
	(envelope-from <linux-rdma+bounces-22405-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 10:39:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D93036ADCEC
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 10:39:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=FQQM83WL;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22405-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22405-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FC033028800
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 08:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537713911CE;
	Mon, 22 Jun 2026 08:37:44 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013069.outbound.protection.outlook.com [40.93.196.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED93A238159;
	Mon, 22 Jun 2026 08:37:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117464; cv=fail; b=qomz0mUFnyMPslwxMZPFojku53Numb0uv46NH6Cx66/DenYe6ya34WpkipRSD/RyFxPjtvmt23aY9sCXdKyPiwwGm3V3EJBc9+pTXoNHH0MCh568x/7hh7v1hicYFtfEFaV29ejUq0fj1VfvsDCSctcPnlkjsOH3Put6FeMznh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117464; c=relaxed/simple;
	bh=QdZCdSKyHD7H+bOblWH5s7Yq4bJ+CBvbM63Hqu1LceE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pudCGxBZKg+zLd/n3Ti2Xr865CSgeVwnC6Cq3BUR+8J8rOc8qmmAgMTMUaiQOK/sKQ+pe/89ZkbJgUglzR08ZMQdFDWgeKrOw7dJ54YOTXoIzPkIyOkZLK0bfm0m1iauqzw7zXpP+JD0U6ulXE9GEj//kQwGmTl4e6rjce6E+xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FQQM83WL; arc=fail smtp.client-ip=40.93.196.69
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNkdYZ1/RncAV68vgbONM20WJVMlK36/8+zVp6DeZjgphfAqZl0DpYjR5w1CHBSgXNGg+pU2zySCF2PEHiqOb9lj2ZO+60pWlhgalYfGDwnFILoRvt7vueWXn6DQx9mxYef9GHskWzx3WR1+8raA1iSYAgoZhW3m7xuhe21IhhhDy0AZqvhWvGkU/zEvUYTakHK7YiO+lzRS+41BZOZ+/pBXHoU4CJcBNQWGxVU+H58qaxB8zTdhkGvJ8FErClDVdLacExizu+wCZEJ7sMVT7rE22xvGOttts5ockV/cNaP4/JHopCk8YIIgtCUyJ457MH85yU52CDQEL9B48lfQIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=We10YSZ+crbmSfe3xBkAOD9Bc4SDWBk8hcW+l4bsiow=;
 b=GFmpUjC39DZ+/rDWAi8WenQ2H7sMd2D7iF5+iV8II+mdvC74c78O4Yvppr7q1kBAaJNJnAQU0M1tJJotGh66DwGeZ5xYYuc3W1Qmag9JfTHD+9TAgAqPqbOPQ8gnBAso9+u9md47xRV7WoJoB0U1WaSrmNOs6sZUx4qq075JFJNQK1GYDfZwpgAoYay9MpCGa0gB5Wmfn5heiPaC6VgPy8JB4I5XLnWxogDY+oio1VRNbCBIMxw40pvLE080OpkDzyXt8IA+TmiUSzYP7JmUTic4H9dGOHEbU2c/41bpffUqKJTq22G7RH783MQFUwdDeZASxq9qKEvyTSauKwCDcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=We10YSZ+crbmSfe3xBkAOD9Bc4SDWBk8hcW+l4bsiow=;
 b=FQQM83WLcY4rDoCOukJqdf5kr3421vm2WBzfSOGWtoKCGR+IT5kVq9FVWq3GXT3D8nkzOXq8BaZzi5iccGIAlcEGz1G2NVggvzZN/RnrDBlYY9XRde2C8sHrZa4sNRNaHy8UAzqe2Q4TrfWtDLSGhRtbwMtIKg9aV1aw26XxVGpEIWFL2NO75/u5SweiJZvv0kCGPWiYW9ow6DGosvfreoMC0b1yHZU1LbooSOR1RGz6U4BvaGY+5iY3Sd0yEkv8jCP20n64Ez6Uhvue0RFa3m8BGEvLV4GBI5s0dSefGDh2AP1df1K5MYs6GJEzgc0+3213zgJhJ7ov7wwf8kusTQ==
Received: from DS1PR02CA0012.namprd02.prod.outlook.com (2603:10b6:8:452::9) by
 SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 08:37:39 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:8:452:cafe::1b) by DS1PR02CA0012.outlook.office365.com
 (2603:10b6:8:452::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 08:37:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:37:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 01:37:23 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 01:37:22 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 22
 Jun 2026 01:37:16 -0700
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
Subject: [PATCH net V3 0/3] net/mlx5e: Fix crashes in dynamic per-channel stats and HV VHCA agent
Date: Mon, 22 Jun 2026 11:36:42 +0300
Message-ID: <20260622083646.593220-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: d65d4818-33f4-4d09-700b-08ded039845a
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|82310400026|36860700016|13003099007|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ceg03sOc/ms1FRgu/AlfgwwcN84ynLXhRUHWpdW6npyfkqLliFm7BXx90a2GMYZIqcVoaf7Ur63FjW1o/oYvWqm3bHbvCcoBfswJY4yFD2sqKFMtM5PZ4lz9au3Az1QV/AiZ2W6VP/zIf31R/kCaYVaeAOQ0a2wQD0WJkcwDWFSQ7/13XzC2dUqQxA56bFX5lSJ1yIGjV5/n6u3hC2cN+XhSp2g88Z24e7fdK13GFwRf9G7s5gFfqO01yvNBYhml7yPEXXn0P5S0Yu29ZxEZCawityIXAn0s7iYMxHYaGv87NOkrfrDFWVDgXIYw/JlHXdsjq3POMlzXUUbkZNYUoFLbEsTHUwYZ7E6bRM90Mbh5X5fPTbJEitZh3AdnNSx2pU2NajuD9z7P0VnPD0+KnZBc5Ts/CjxF7r6tP+E0lWD9MIq+CnoBeDHH3Ze6MXqGDXJUtu8qdxEQLmD58HGKH+TvwIhowSLp0OgSqaMpvlllkNS+Y3RBZCo1J+6POohjVAh3ZPbSpRtbniTxGWqZ+2tF+k6WFPMdXSB9yhZpoTf6rk3hMccCbsjUN9NT4nDbbKG1lGf9fO35FEKQxZkCUpDYogOiWWesT1Vj69dO2o6xIaY+nLwJn3RkTRbQmt8AbZeN32+Cb+CV46fnTlmha954UcvPZODgz2NulPl12baLZgw/xnnSYoYbHTqMAo2lsCa9wXzXrir4mqrpzLNNtw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(82310400026)(36860700016)(13003099007)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GMN5amI/ORFRf8pZS7I8XTiyc3YwTFDdTsxijhM2cPjCTkxm9CoBAs6lOmi0HniLXV7dBircDq8ESIvHr9CPMJHJr8noSGnGVNKTrZ8JYgt1FGdPxSnDkk254BpqiAaUSSi+BvnGj1dtbg1dpMzbZO/msrjNHV1z+1aqgaGHO0kth+02bjjGZm+ZRik2EzHlbjDwZw8PWPd/O7+n6so0Q4QHqluxHBqpVMb0Y/g+0PNbhtDrKN4uZ0YNC6tz22kYtVT5RV2OGTX6OYIvo0BcBvgtNmNv2zu7DMsRrkiX0yEe01w39xpqPZPwAzK9qJdB0ktL/QPdNfE6YjD8ZNhLMOOoNvKdW+2bJWCL6GLJDffwLoCJAxKQXipZ7nJ7tr732XeWZMyyYgTMmB8ZueGg/tYB6MDNIjfP273S5RnVBkEpYjhTnrisiHtlEpgOFgqq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:37:38.3896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d65d4818-33f4-4d09-700b-08ded039845a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766
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
	TAGGED_FROM(0.00)[bounces-22405-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D93036ADCEC

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

V3:
- Rebase on current net.

V2:
https://lore.kernel.org/all/20260617140127.573117-1-tariqt@nvidia.com/


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


base-commit: d07d80b6a129a44538cda1549b7acf95154fb197
-- 
2.44.0


