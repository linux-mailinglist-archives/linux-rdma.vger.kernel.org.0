Return-Path: <linux-rdma+bounces-19947-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOljNNjn+Gmt2wIAu9opvQ
	(envelope-from <linux-rdma+bounces-19947-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:39:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFB34C2AD9
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E9793033198
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 18:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE5E3E716F;
	Mon,  4 May 2026 18:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bk8lBWCf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012053.outbound.protection.outlook.com [40.107.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BCE3E63A5;
	Mon,  4 May 2026 18:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919906; cv=fail; b=G1Acg967WiPLTZ52CXDwDWwkVhUaswhp1yv7hQ7EPKvu8vU19zbf6rXxRV8Qzwg7iSDNkWQLtDBVHvS1F7+w154nMOZQP1OedbKq8N33264dOy+Llg+DOMPQl8TFrdmIeX7CK+AAJFPJ9uTwdzLqlRN+XCSCOZhG3+e78YLKeoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919906; c=relaxed/simple;
	bh=lNoGR0OcMqfkq2HaNHm4HxBLvmsnkngzYsTY2W+dOqE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ke8IBfhISX2dIicixcFLuZ6juUP6xTsr0NgFFheHFjHSVbGtLc8A+d9iX9M22sfzoh6KhHKUFrdyJYn7q11qlbpwE4A37oBsQUnuyrSxWse4q7y5Cl8i1WYqazJ4tS9XlXrEvZKKSg745rYBl6bkKcAltk6WO7swZfob+YaXARw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bk8lBWCf; arc=fail smtp.client-ip=40.107.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aiyEEBVV9HkXPGAcp9dvGyG2a26MxUcsWnnH3m7nkA3wIuahh27muhg9eyGR2rw5D6Sh+3IOpXLEL2GW/DLxU3oFEacenCCZsI+x3Fe0q3pAMaBSgmOnrKvMM/wWP7i0GSsniaWXZx8ArfavLcKViR5yyNzhX2r3q4AjgtBu551nBKstaXNdu0nzZQa8tM1ZQNCQMNO8hV0ppeRQqNEQcJXskUZQa419WJfjg5k/6t+nIsdlLpohjGO6h8l5HhABKi+z+8Rl6m19bUNWXpdN0YfhD6n9FuiKfsGogqZhDSTV+eMf7a3at4akU7YqV+RaL1JUirAZS84siLhg5+Z7+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9QE5OnUPAxNQAcBHVbiROTvQ+JNjwxUf85gh60nDBc=;
 b=dr21WvRUJYqMLDfQGty5InMMsvvVgRKr8TiZMH9hlPkZwtGhZTObpV0/5e8/l6+hM4PdIvp03zhPWEyji/TRIljTdQHIs2LfOxjIH7K4Ysy2O43uO8QYtX3klimIOBFQPpZu4QtON+ooSheWMQcm8qU5j5Pdpv3EcgA8B3EGv5Lx0heHKSPws83xlBOzM8zlO7GTArCSmVSVVZ/mhoDawbM106NUZ9YOD9csykW/HDmA40fOgUzfMnxG/JX9jAhR+CzySO+mCmsXqwUzCl0nB54tT3n7v5D44mnbVR86WBoVU/MDgv/oCnXDav9o0fi8/eGGtdmJDWQ3MDul8aD+Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9QE5OnUPAxNQAcBHVbiROTvQ+JNjwxUf85gh60nDBc=;
 b=bk8lBWCfz+gXj0fSuW8lg1UsiVmZyZYFevEFIm39F/ti0mrY8IETzWX5J8M/5QizrbLsJTM5pJa0bL5hOqzca6694BrSJLIojlQ83h0fbmQx0WeHwgjo2DzWONSXweJhrLbbGfcn5tfIv76qirh82FcTbAFGDGmTFikzwju5YBgfhNQLcHreHWk8hV2KHPehGahB8gMJ2ItvWshsKqVmZjqHR/5N/Hn27hxhky7qZL/GwsVNaN3ULlUPYeXQs9DTg8ZTKFcBRz1vHyyhiEuUDpygUz4NQt1/Vp3+tGhNIR/CGPsDB1qqmdbaVJ7PQy2CGpf7qKd/P6cmnqheV2MpwQ==
Received: from BL1PR13CA0207.namprd13.prod.outlook.com (2603:10b6:208:2be::32)
 by CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:38:10 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2be:cafe::95) by BL1PR13CA0207.outlook.office365.com
 (2603:10b6:208:2be::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.14 via Frontend Transport; Mon,
 4 May 2026 18:38:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 18:38:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:37:43 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:37:42 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 4 May
 2026 11:37:39 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next V3 1/5] net/mlx5e: Count full skb length in TSO byte counters
Date: Mon, 4 May 2026 21:37:00 +0300
Message-ID: <20260504183704.272322-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260504183704.272322-1-tariqt@nvidia.com>
References: <20260504183704.272322-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|CY1PR12MB9601:EE_
X-MS-Office365-Filtering-Correlation-Id: e6aa0169-835a-4d5a-d235-08deaa0c4aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/MdtsphqVoLsZax9RddYeJpIQo4tmhvvqkSjUp3ZmVPe0jQM0hrHtRcNRhbrZD1kqDXKJEff3viTrfiBDlYz7/JQSv7hbTuT9A72NVj7dc3gSIXseidfMOFShYUYTWkSz64FWAjcJ3atHvro+LwM95S5uw7vdE+WX1oIZvs0WOh1q8hoRwb0Wu/nsCMd6cafb6Ci+gYlkD+r7cd95vkG+/8n/WaFL76+VewRPgdN7gf/jPIlRNSV8eflVe/dvAw9v65HBwf2RMqSCdIPDeAnO+n4HKJ/Y4A6ZINWtIMxobrHNToR412Qzv0fsPlXvECOc5/zse7VKgAxenCMhnsDwFUvoAjYc1Nx/3uDPK1QWN+uhYuPZ/KMJUMTjnb7vghpe/1i+Z76/bAr/VdyMQyy+Ypw+C78VWdTdHumxGl43d2Gl8H9UCUwTaz9wFAAP00ZWRDn4RMG3w0zLRa9xSdZRoc38yb4dvCsaImmVdsnVs4/hvs3lHTrBzgI7dMkBnPhWz1wGGjvJco2L9AxuxQeD1yGo15pX98+QPcSwBkeYtYFR4cZIAFM940+lOS3l0PwMdNmWmp53mvAp47dBG6wNCfPCY8ktWPHTvWSDp/3rZOtMWNpT7J9rL/2Z+FNSr7L64G0nUjpO2PU50yoedfsdzahqE9wZfoK95CT/2Keuniy//iHJVuYN78hVtBaB/DG8tKKEMGEl0Mi0WQ9OvLc95NffBNWCzp74FRQzapYIhI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OiSsji3uJ/UXzgl5LRsgF5T+S8+2aizuMCdwBVRtzhkslKWTQ1Y3OR0hqQhn/h/P1uVdoUE9RenkLVcn/YtqdFjZr7Q29q85bs7VFdJCxU4qUVnMldlmSHplkhn+GkdMzTssiBo4ZgtWt7MjtabagarpavEI8jvDIB1BekOKfc4u8vq/jMjcVLT1ybE99Zvf9utguo+KUK6352ajwJ2YQVGBW/rRyESz6QzkuPelGz814hUXrIweMQ83NvVkL/Rj1nKgScoB5upnqD86SDNg+OnYV5eke0ZTfeI6sRBUh46U8WKqUNjf0vtza9BE0iz58lkIx112Mvxzc9zub6IYdH7y0lBJ28rrug3pdjiah5GL8idwSvp+bUuZYnu9fYRgihT0suHH+hKedL0c0No8/xCN535k5UcWYOZbme9fOuUyOc+EFaGA6eCx5ux24nB0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:38:09.9891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6aa0169-835a-4d5a-d235-08deaa0c4aa5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9601
X-Rspamd-Queue-Id: 6EFB34C2AD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19947-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Gal Pressman <gal@nvidia.com>

The tso_bytes and tso_inner_bytes counters currently subtract the header
length from skb->len, counting only the payload. This is confusing and
doesn't align with the behavior of other _bytes counters in the driver.

Report the full skb length to align with this expectation.

This also makes our behavior consistent with the netdev stats API and
virtio spec definition.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 9f0272649fa1..0b5e600e4a6a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -164,14 +164,14 @@ mlx5e_tx_get_gso_ihs(struct mlx5e_txqsq *sq, struct sk_buff *skb)
 		else
 			ihs = skb_inner_tcp_all_headers(skb);
 		stats->tso_inner_packets++;
-		stats->tso_inner_bytes += skb->len - ihs;
+		stats->tso_inner_bytes += skb->len;
 	} else {
 		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
 			ihs = skb_transport_offset(skb) + sizeof(struct udphdr);
 		else
 			ihs = skb_tcp_all_headers(skb);
 		stats->tso_packets++;
-		stats->tso_bytes += skb->len - ihs;
+		stats->tso_bytes += skb->len;
 	}
 
 	return ihs;
-- 
2.44.0


