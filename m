Return-Path: <linux-rdma+bounces-17077-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WK1kDpi9nGlSKAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17077-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:50:32 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6CE17D31A
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98D1F304671E
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 20:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F2D37E316;
	Mon, 23 Feb 2026 20:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RhrzuONU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013030.outbound.protection.outlook.com [40.93.196.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7B837D131;
	Mon, 23 Feb 2026 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879472; cv=fail; b=cau4nk8Bx4PewIe7RWmcOx4+FL+S2BC6lG0ljQB0TFbDdL8Lv6Cwc+qiEujdiA/6nIycNLNUjXOKk1e/HaGul0m1MQKMMPKl+0XoW8t6t/sSYWCsbS9emWr8pbPVj2EZ6n+C2xibW15p5j4YuCqwKO/wMJX1ISTL18ft0wHJO3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879472; c=relaxed/simple;
	bh=M+4MIONH9Fv3JizrSaMOYBSk/w6PuQIXv+5Tch3dDg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WvHDz0Nc0CkbLyhZcekK40mi7ETJS/Pk7nRm93kPwKJJW3xAlu56N96g85PEPurRNTJH5Qmt1MO9tSMB2s/v/T4VFPkfCr5plr7YltZZUwzjCwK64jEourzXhC2FQfVC59cehgZ3tVT6Q50OABUn51qTSgJy+JuiNzrBrIWZNDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RhrzuONU; arc=fail smtp.client-ip=40.93.196.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1QTsa4YX1w8385rnDyAVDyge7Zp3Woev//+UFoKwgBsoJby9ZT/AIgEAWXpHpPQ17d89oaHljVipuuHArGgjIrbrHNjqZK+J9LV6FQilYRC7lpTDZS/xFr6GNa2tk95UlJ3cAS1Y5YIllpAWp0M6Yw113QemPkUyFLTAp5Ji9kS3bI0FqKDjQGfeWe2XNz3siJhjhaqMxAalFEihsKEGeyH0Ce/9EUAbTS3BXuNKys5WIf6IDSgAOEiQPO6U8aeQAp6wr8ZEz11dlB7YjLrSH82bEe826N1yd4aH8NnBos3rNrFgjDVyLyKOWINaq5azcoJI9zHbwZEfJXtxHvfXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gQoTGTjmUuOor7budbhj5SwsVrs/bnGq164O8Stp8E=;
 b=FK9GKIIo/JWWUihPmVm70jvYqYA9DRzR05D8CkPXc3rzUnDRQrtclE5v5KTsuweW4VzppG2qi0ce8QG9s4PPlEMDZn7KKa6aMPlRhOL5clT3lyBqAU69RZl+wbWi0AhQgG0LuRgtoHLkwED/Gh3edOoFRr8K+K7o96eJ/YZ0Sv31kHe2t2al3DerMGGp2+yyh+Yd/QoMCbschSZy3l7CGWygHivY36ukZWCSAIkTVcYHFFtzV2SwXeXJnGSMwgXL7jk2nafJjjhaf19uDfzQYdHR50ytVf7uduYqP0mlfHtelskv98wQD3Gv60GKU9oNknMyqy0PZPamawBOq+XWSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gQoTGTjmUuOor7budbhj5SwsVrs/bnGq164O8Stp8E=;
 b=RhrzuONUakXgNs8bkIU9cgZlclfmE2F1i74OBza8V/yZS0o6/zTGbEazQClQ9w4U5Zjji10dH5imPcFLuQMlmXvf0fgz3/zOuVYMkAd2uBgyFkdwqMDqH8FEwK5Kol8h/t5wmn7+bbjUZLk6jb2VCcdpwtrcQVZVoIjil26jPZ+/l/aaByJbj/ao/jozSQ9CAFho2KNd0WGqkKeXSw6nbbP8JiyCf+9AVybK+GGWH4wrRjY5DUH5nV04SMhRxCAnEBNp6ouPeEn5qtq8FMyMrUvinjkW/eA6aMhe30UV+c3Ewqp70wDKjXmacb2d1Czg1z5Jfahdj/WronO0xNcUGA==
Received: from BL1PR13CA0421.namprd13.prod.outlook.com (2603:10b6:208:2c3::6)
 by LV9PR12MB9806.namprd12.prod.outlook.com (2603:10b6:408:2ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 20:44:20 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:2c3:cafe::5e) by BL1PR13CA0421.outlook.office365.com
 (2603:10b6:208:2c3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 20:43:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 20:44:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:44:02 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:44:02 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 23
 Feb 2026 12:43:56 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Pavel Begunkov <asml.silence@gmail.com>, David Wei
	<dw@davidwei.uk>
Subject: [PATCH net-next 13/15] net/mlx5e: Pass netdev queue config to param calculations
Date: Mon, 23 Feb 2026 22:41:53 +0200
Message-ID: <20260223204155.1783580-14-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260223204155.1783580-1-tariqt@nvidia.com>
References: <20260223204155.1783580-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|LV9PR12MB9806:EE_
X-MS-Office365-Filtering-Correlation-Id: df7fd115-5075-4e28-7728-08de731c5170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zmKtrkmnDkn5lF7iX1BH4GjXann8WztAbFVC8EDlFcocl6iBanbj5O3JPooX?=
 =?us-ascii?Q?xXr/T8h6t1JGCkFBpC/YbDosOjHao+pLxrQ+aqK0sYPiYCeNXlmb0IZ+mj2O?=
 =?us-ascii?Q?xC6/TxI4UcOO82ntOVd7RZcuvqB9X9OhAsTv2/WkNs6TGZ0aVfR9iYBlm5i3?=
 =?us-ascii?Q?gv7P70sTmpfxCLn22HWUqPwRdpbHi0lJXwaUiIM7uoXEr7RFOYEmDwyXm0yh?=
 =?us-ascii?Q?dbJoFCJvngZe9c4e1Jy0FOWY1HmmLxNV46Pnoc+iVgOfpX0V1xHsPewUA5zN?=
 =?us-ascii?Q?slolqn0+nt6Eaajw1UKsIXzMFBI3DTUBXi6nQ5mKqMFI+Kfnpl5+/zoL4o4B?=
 =?us-ascii?Q?+rTpsOxkZACEOgOMArbUi2rZsq6faSfxVR38g2QBuNYmqIPUaGxzWGK12zg8?=
 =?us-ascii?Q?3ADkGkLFPBzqhsWPiaxCsTexHO85ATwApPgT8UPFZ61H3bd9wiS3LauZ8t/A?=
 =?us-ascii?Q?+VYUF3+QIEliv++z4IcTDngWiz4omEJRmX0wpCOyC2OS09M+AFFbuQ9v+v7r?=
 =?us-ascii?Q?+EOzbizFEv6QbZxoKcGTjWkp7z58Zz3ZFvmjJdYARXH/dWA1IvYnTnhuOLj+?=
 =?us-ascii?Q?amXeHIZOJIDrQk9bPwojZXaL3M3T1VyusDEA7lvcUSZMDkJdZNYE1eFqQMEe?=
 =?us-ascii?Q?3yFCrhlUrFocSzljkHFQ0Z0IEPShiRNp1JhB5LbSmYW214j6bE2F9BrTgHDR?=
 =?us-ascii?Q?BLj16koGpIOGTpvqXKRU1aFUwRNN7gRvCUYHSDBiMquTiAkFQPSM49cSNR6Z?=
 =?us-ascii?Q?geyY1kUDbO+0WVcmbg+rz3IEhuh4FQ3ML4e9vVH2cgPJ5mAVj+unR67xpB/T?=
 =?us-ascii?Q?gV1HpCB5VDlbn135cmfnLupPjd9O/4Y2R9WUAbETHyKR8dXMkJjyol9yKdFY?=
 =?us-ascii?Q?8R1mz3OE8FxyXwLKvVA1oQqm2AK7czIP+0I8UkRph6PZQKYJ7TOqNZ+z/det?=
 =?us-ascii?Q?nqRDhabyBwxTpZQTwHlvYrIUbYdiwulxOKP++8yDGd37wGB3lLoWF45QaqW0?=
 =?us-ascii?Q?hf+GJyxGizYuLmap5s6QP5ypiQ29JosfN94/0NRxsJsdyqFOPFe00nU3Qeyp?=
 =?us-ascii?Q?6x0bwI0nNkGXkBidptSp6Tk7Zo/AmHHTCpWYRzO8VpGEHcHzjq9dwgsUvf6Z?=
 =?us-ascii?Q?3/ZOowAIXlgwAvfBiVrsEZ/bxDMoIi1OApDqPqv/0ogMVd/m7gUXAajFr1LS?=
 =?us-ascii?Q?rALxWdta/LeaZBPWsTWLpUwSyZKqdhgFPqrmv9bZRstQy5ItE7z1WnimRzXa?=
 =?us-ascii?Q?ip6cuJZzQc/LP2HobxG2Pc4onIlp8MSMbW1N/eNziN/32/bC5KVHfKiNaDZH?=
 =?us-ascii?Q?C1NB1Ewx9/+HE+jVQoHBQb56GMvAgnjkaqHbqx/0RqMRqD1xsZnItk7LD3uS?=
 =?us-ascii?Q?U2od1q+eyTiWLDOBHkYbtO98P5iLOPtuGJW8gdNHaJDpjcjd4ZOqvAPUut6Y?=
 =?us-ascii?Q?AuKE5ywIHjpUK+efWkuvcYGMVq0gT0d3+j5znccS+i9Cnb2H0nHjecmGMlg9?=
 =?us-ascii?Q?K+19REipTW9b4D71EqNqo8ohuOvndcaMtDiUT7obkTb1T3qwXW6cTyt1rHWx?=
 =?us-ascii?Q?VFtCMl7JXLVLdLIBV+XNfglHeKeUT+7F6Dy2AhyHzzIfvXSPiklkCjZoYkVV?=
 =?us-ascii?Q?juvyx9yr9rt+X7x3cBaVO3MxjJGGlVdPQWs0KWS6y7z1KhSBGU3C03qVDxJa?=
 =?us-ascii?Q?dISC4Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l+CyuIQJ8cvBQRreE6gSdoATPkSTg6GNethE+SDuluthEmlvWzVNEx+L2Wds6FH2og35EbvNfzmoMN1cE1sMlJy3+vtBxNR1qy+GDEkHiYe4/9WWcLO6C2iM+dlPM/Yf7EecaWZsIzUj8cnDiDbo5lOLW/wFEUJBdJgzZ8TsT3kOq2/0nTLT1W4/uvJWlJuKIgoMk3byWp2SX4LYTo3T1ADL/OzXewy3I2g2YY1R2qMNGircq8a/bI+T1kQKevR45Oxe20mO42OKQGQkb4onpunamHzBDe16n1dAvCTbfpT2zycVzR/ppc56Q9NuVrfPL13z1gzfphzy31s00vZta3KQ2vlVYTSFwQptgiyWC0tQQL1heqx4IVANTljaSxm6NYRHDgv9ZpdbY7nkE2jaBsFg+pSiuqQ3fa0GUQs9BQxc4Ux0fDkRVtSMY1XPmdi5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 20:44:19.3925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df7fd115-5075-4e28-7728-08de731c5170
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9806
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,davidwei.uk];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17077-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: EA6CE17D31A
X-Rspamd-Action: no action

From: Dragos Tatulea <dtatulea@nvidia.com>

If set, take rx_page_size into consideration when calculating
the page shift in Multi Packet WQE mode.

The queue config is saved in the mlx5e_rq_opt_param struct which is
added to the mlx5e_channel_param struct. Now the configuration can be
read from the struct instead of adding it as an argument to all call
sites. For consistency, the queue config is assigned in
mlx5e_build_channel_param().

The queue configuration is read only from queue management ops
as that's the only place where it is currently useful. Furthermore,
netdev_queue_config() expects netdev->queue_mgmt_ops to be
set which is not always the case (representor netdevs).

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/params.c   | 14 ++++++++++++--
 .../ethernet/mellanox/mlx5/core/en/params.h   |  2 ++
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 19 ++++++++++++-------
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 97f5d1c2adea..304b46ecc8df 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -10,6 +10,7 @@
 #include <linux/dim.h>
 #include <net/page_pool/types.h>
 #include <net/xdp_sock_drv.h>
+#include <net/netdev_queues.h>
 
 #define MLX5_MPWRQ_MAX_LOG_WQE_SZ 18
 #define MLX5_REP_MPWRQ_MAX_LOG_WQE_SZ 17
@@ -24,11 +25,17 @@ static u8 mlx5e_mpwrq_min_page_shift(struct mlx5_core_dev *mdev)
 u8 mlx5e_mpwrq_page_shift(struct mlx5_core_dev *mdev,
 			  struct mlx5e_rq_opt_param *rqo)
 {
+	struct netdev_queue_config *qcfg = rqo ? rqo->qcfg : NULL;
 	struct mlx5e_xsk_param *xsk = mlx5e_rqo_xsk_param(rqo);
 	u8 min_page_shift = mlx5e_mpwrq_min_page_shift(mdev);
 	u8 req_page_shift;
 
-	req_page_shift = xsk ? order_base_2(xsk->chunk_size) : PAGE_SHIFT;
+	if (xsk)
+		req_page_shift = order_base_2(xsk->chunk_size);
+	else if (qcfg && qcfg->rx_page_size)
+		req_page_shift = order_base_2(qcfg->rx_page_size);
+	else
+		req_page_shift = PAGE_SHIFT;
 
 	/* Regular RQ uses order-0 pages, the NIC must be able to map them. */
 	if (WARN_ON_ONCE(!xsk && req_page_shift < min_page_shift))
@@ -1283,12 +1290,15 @@ void mlx5e_build_xdpsq_param(struct mlx5_core_dev *mdev,
 
 int mlx5e_build_channel_param(struct mlx5_core_dev *mdev,
 			      struct mlx5e_params *params,
+			      struct netdev_queue_config *qcfg,
 			      struct mlx5e_channel_param *cparam)
 {
 	u8 icosq_log_wq_sz, async_icosq_log_wq_sz;
 	int err;
 
-	err = mlx5e_build_rq_param(mdev, params, NULL, &cparam->rq);
+	cparam->rq_opt.qcfg = qcfg;
+
+	err = mlx5e_build_rq_param(mdev, params, &cparam->rq_opt, &cparam->rq);
 	if (err)
 		return err;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
index 4bce769d48ed..5b6d528bce9b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
@@ -14,6 +14,7 @@ struct mlx5e_xsk_param {
 
 struct mlx5e_rq_opt_param {
 	struct mlx5e_xsk_param *xsk;
+	struct netdev_queue_config *qcfg;
 };
 
 struct mlx5e_cq_param {
@@ -143,6 +144,7 @@ void mlx5e_build_xdpsq_param(struct mlx5_core_dev *mdev,
 			     struct mlx5e_sq_param *param);
 int mlx5e_build_channel_param(struct mlx5_core_dev *mdev,
 			      struct mlx5e_params *params,
+			      struct netdev_queue_config *qcfg,
 			      struct mlx5e_channel_param *cparam);
 
 void mlx5e_build_xsk_channel_param(struct mlx5_core_dev *mdev,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 336e384c143a..59e38e7e067e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2524,8 +2524,10 @@ static int mlx5e_set_tx_maxrate(struct net_device *dev, int index, u32 rate)
 	return err;
 }
 
-static int mlx5e_open_rxq_rq(struct mlx5e_channel *c, struct mlx5e_params *params,
-			     struct mlx5e_rq_param *rq_param)
+static int mlx5e_open_rxq_rq(struct mlx5e_channel *c,
+			     struct mlx5e_params *params,
+			     struct mlx5e_rq_param *rq_param,
+			     struct mlx5e_rq_opt_param *rqo)
 {
 	u16 q_counter = c->priv->q_counter[c->sd_ix];
 	int err;
@@ -2534,7 +2536,7 @@ static int mlx5e_open_rxq_rq(struct mlx5e_channel *c, struct mlx5e_params *param
 	if (err)
 		return err;
 
-	return mlx5e_open_rq(params, rq_param, NULL, cpu_to_node(c->cpu),
+	return mlx5e_open_rq(params, rq_param, rqo, cpu_to_node(c->cpu),
 			     q_counter, &c->rq);
 }
 
@@ -2638,7 +2640,7 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
 	if (err)
 		goto err_close_icosq;
 
-	err = mlx5e_open_rxq_rq(c, params, &cparam->rq);
+	err = mlx5e_open_rxq_rq(c, params, &cparam->rq, &cparam->rq_opt);
 	if (err)
 		goto err_close_sqs;
 
@@ -2783,6 +2785,7 @@ static void mlx5e_channel_pick_doorbell(struct mlx5e_channel *c)
 
 static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 			      struct mlx5e_params *params,
+			      struct netdev_queue_config *qcfg,
 			      struct xsk_buff_pool *xsk_pool,
 			      struct mlx5e_channel **cp)
 {
@@ -2816,7 +2819,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 		goto err_free;
 	}
 
-	err = mlx5e_build_channel_param(mdev, params, cparam);
+	err = mlx5e_build_channel_param(mdev, params, qcfg, cparam);
 	if (err)
 		goto err_free;
 
@@ -2941,7 +2944,8 @@ int mlx5e_open_channels(struct mlx5e_priv *priv,
 		if (chs->params.xdp_prog)
 			xsk_pool = mlx5e_xsk_get_pool(&chs->params, chs->params.xsk, i);
 
-		err = mlx5e_open_channel(priv, i, &chs->params, xsk_pool, &chs->c[i]);
+		err = mlx5e_open_channel(priv, i, &chs->params, NULL,
+					 xsk_pool, &chs->c[i]);
 		if (err)
 			goto err_close_channels;
 	}
@@ -5619,7 +5623,8 @@ static int mlx5e_queue_mem_alloc(struct net_device *dev,
 		goto unlock;
 	}
 
-	err = mlx5e_open_channel(priv, queue_index, &params, NULL, &new->c);
+	err = mlx5e_open_channel(priv, queue_index, &params, qcfg, NULL,
+				 &new->c);
 unlock:
 	mutex_unlock(&priv->state_lock);
 	return err;
-- 
2.44.0


