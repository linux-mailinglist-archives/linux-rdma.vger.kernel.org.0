Return-Path: <linux-rdma+bounces-19950-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJd3LC/o+GkJ3AIAu9opvQ
	(envelope-from <linux-rdma+bounces-19950-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:40:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 668894C2B24
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 008F630514BA
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 18:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2EE37C909;
	Mon,  4 May 2026 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i3whR+0q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AE93E8C72;
	Mon,  4 May 2026 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919909; cv=fail; b=OXvf5piFZCXNfyNfFlzxOxcbEbzZvDSFXQV66ss0NQMDBDWV7JqsdFeuc5+Nx2C7DDpZ7KBCSaH60mZb9aKaAZ+dLRD796WOY/knXBwdbzgb7eYmX/u0q+HZOBbbP978552uKCBqOlbN2/n8y2UDOlLr1FwXDY17g/BZqSXcpbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919909; c=relaxed/simple;
	bh=Wl2jCGOkzuU2jfo6Ly2gGLUZVOBTXTma0XmeXAIghQg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lv+BDK594/25cGWu9HtfnTx2YQ91N7Z7joBc7M2bqSOZPrNrYkAKbhrJQENUAYkDoJpYA6ZseU/Ross0mmE9QS2BRHarx4+O2alchwXc2r/ytkPd0yhwjLHoaVo6AijrJO45UZaT+0wq6Ay+Ce/olLOFhkyF3qck9HHtPeb3b/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i3whR+0q; arc=fail smtp.client-ip=52.101.46.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YK4vr7OPLJA/pk6JyCZ80G1yxK1ueq/a76mMMS4SbsDsCZF70cJ3Tz8EHVuKJKbt7Si9fwsovf9KEO+XETGe4bBeaOx3w1oApfKI7+g6hpaCdzqVXX77THRqveBkFSYfqfTFC9yMq56AIRYwvkpTroEF1YrP2NebNwuwHmbV8FaUGhsz9w21kvngDtqDk8RnS+lq2L0fHvsPsLGMLM0WS4Bm2Hxeucp/ra1TSpgmtjg18MU69F1nToDd1BAzGfDHXaW2vNauGD7EOmv8e/EpyBBmhFDiTftUegqPwJVcmQKmC/amEGvmvWQL0HHAcNL7/pnjyu2A243NKDR6M1+A2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lY/JS8f8xWMdqV53Q/IyW77dIlL2U8vdQtHDeKUr2ZU=;
 b=Ajedi22z5PcZK/2BpYdW0bih98rrY+zLQfMCQzDXOYjCcoSYc+vbgJt4Fm3m6/P0cAvWCAUJi7JPcpOd03E3yfM6iKgy529bhDX1vmMH4HMXp7KRIv/VUEC6uxBXAOQ9sjbCRvvqPM1S1ZH9D6MhssJsQ6N5u4JGZYsKQugV55ctBtLoxMDMIFl32j9vCnBwx+WLQHDz5iAJf5SFjY/arP6XLMcEVxf+ydUPgVLeAZ1V2MNF26Ujpegu2da/PqVAItvHpaFfJlW5t/5YSkgaly2stPkXQMMKzMmxV4iP9YdV+17UblkxNmz1kyNXsfhb+LBYYv8n9Pzkrr3rflWpiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lY/JS8f8xWMdqV53Q/IyW77dIlL2U8vdQtHDeKUr2ZU=;
 b=i3whR+0qb9Jb7ZcTFXNik2VuLHHvT8aHhPk/WTIgvFNHjyMTfmAWX2amOnbev2TcqhXCmfRT/Joi3uIexWTVRV1uWLTnC8JYuhaEmHWi6+vZoq7gz3W51MjD+Yt/RGtFUgcZCNeA2zuXoZASv8c8lG7kRV7jb5bqYXTDq54H8i1eJLBc9uJkRhGWWtY28xbxjwwJgIjDfYOPaCsP2sTVTuZzJKHEnL9E593Qi11AMWkrlhiyFVVdhAizJmbIx8qIVTfGCbsnpE03oJ6U1dGNgzrPWdJ5rhek1JmbCFqXVv6BAKyv2Hs2VRyNHpWB6IDlBMS6T8CplTWlclJpblc6/w==
Received: from BN9PR03CA0649.namprd03.prod.outlook.com (2603:10b6:408:13b::24)
 by BN5PR12MB9486.namprd12.prod.outlook.com (2603:10b6:408:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:38:21 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::62) by BN9PR03CA0649.outlook.office365.com
 (2603:10b6:408:13b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 18:38:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 18:38:21 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:38:00 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:37:59 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 4 May
 2026 11:37:56 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next V3 5/5] net/mlx5e: Report stop and wake TX queue stats
Date: Mon, 4 May 2026 21:37:04 +0300
Message-ID: <20260504183704.272322-6-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|BN5PR12MB9486:EE_
X-MS-Office365-Filtering-Correlation-Id: 3469305f-153a-4780-1f05-08deaa0c513c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	faUDO2GTjv2W542gIWnN1SXCFbMawQVnSB9u3jgb+74rGrBHvzjzixWUAOa1TJpbVmIYhiH5LO8iy9KuMYz+NKLOqsWD//nzni+WJUcsizCFxtJmrDDyeG5czWuCrI/LmeH+Cwb+lwQale/tSgdKtzlWYRGSNDB8B9HzpkwIsK2VVnHCefjondVYBx1FSEqbDqB5MfBzLpaAJdLJdf/F+9Xx/Zc6mCZqCYx8lkhM8mhepWb0z5ivR/GvpTtERE35+C6PZY426VGxawdG6e1dksWBaYrpBUxjVQ1ALj7+4kJokFmWMs+o3dWobsDyyYbouVlAjFwNBHjGSzPCu4JLGHSvldFIAVoPVyQj4SdA9gnmPRrJlvQAwFqsupNsPZdkKEd2sUReMTwIahJabYBhF6K1NMAhPWZRF9cWeAgJeIhz3uv9CLUjDfdRGyZaqktLc+tKiOZ+nOaxoSLicpPx3gWPAijhSwYOwwHz6pUYk6YUFkn0qROPq8ZMJw0EQBxQc4AnZDuiTdiZYS9BfKeX0CvWoeOg6RZ+CO60eE+YiGgfDEVc00tEqNeo6KSDPwfBNc2ld0+3b0DcU2Tu/fDNhYK2AVoJGJs8TXTslbbbYEd6EUv0sq+BAuLcYWoococIdEDKEzkjmiBMLQd+8Ao7gJkzlcN8QYPDS+7gropvgvs5O9z2py9T42idfI4I2W261rNXabZzrmriMFRZorAFkm5j/w/zB3dXu8eEGcOSgwE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PNmz1qVetIvgrU84fsY7/N6NSgQH0iT8IiU49cwBik6T8zDvN4vrKsYnAvPVAeSf5uaNJcdzZmTLmcz4L1ro9pew9h1lfP1U0f/vttEGX7jn4sBZuWvHSebzfZbHQIU0s70S2YHpl4QX3YAt71FNW3xUdN2cduPrpWnLO8bmMCbcQh42DSluOdv6Q/sENTH8BQpLYQnP3LWvoFg4z1XjIDJomti1Mpwt6W2WV8kTogQI28TWX6PqkYkW66wRW5bA9PbblYAwi1iNtmvFE2MiomGnOJK4jR2oCwFqX4m/ONaJ4Y7DFi/Vp9Tvuy3MnA5/afDYmqu9C488pH/xQg0abv1hJd5mo3UyfnjSGrzJASgpAfSOXDTkX7JZp7f9wLxFE6xb+TSaugKFLMHGZpbpo3rfMHeBIKXKtJav/1sEbd8wqaTv9JJKLQ6EpSGujLbL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:38:21.0497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3469305f-153a-4780-1f05-08deaa0c513c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9486
X-Rspamd-Queue-Id: 668894C2B24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19950-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Gal Pressman <gal@nvidia.com>

Report TX queue stop and wake statistics via the netdev queue stats API
by mapping the existing stopped and wake counters to the stop and wake
fields.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 6fc354a7c5c6..469e066dc432 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5529,6 +5529,9 @@ static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
 	stats->hw_gso_bytes = sq_stats->tso_bytes + sq_stats->tso_inner_bytes;
 
 	stats->csum_none = sq_stats->csum_none;
+
+	stats->stop = sq_stats->stopped;
+	stats->wake = sq_stats->wake;
 }
 
 static void mlx5e_get_base_stats(struct net_device *dev,
@@ -5580,6 +5583,8 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 	tx->hw_gso_packets = 0;
 	tx->hw_gso_bytes = 0;
 	tx->csum_none = 0;
+	tx->stop = 0;
+	tx->wake = 0;
 
 	for (i = 0; i < priv->stats_nch; i++) {
 		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
@@ -5611,6 +5616,8 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 			tx->hw_gso_bytes += sq_stats->tso_bytes +
 					    sq_stats->tso_inner_bytes;
 			tx->csum_none += sq_stats->csum_none;
+			tx->stop += sq_stats->stopped;
+			tx->wake += sq_stats->wake;
 		}
 	}
 
@@ -5634,6 +5641,8 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 			tx->hw_gso_bytes += sq_stats->tso_bytes +
 					    sq_stats->tso_inner_bytes;
 			tx->csum_none += sq_stats->csum_none;
+			tx->stop += sq_stats->stopped;
+			tx->wake += sq_stats->wake;
 		}
 	}
 }
-- 
2.44.0


