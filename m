Return-Path: <linux-rdma+bounces-17768-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFvlG2KZrmnFGgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17768-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:56:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 792B0236A08
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F0EA430028ED
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 09:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EF03859F1;
	Mon,  9 Mar 2026 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h92lQtEf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011002.outbound.protection.outlook.com [40.93.194.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79F43806A5;
	Mon,  9 Mar 2026 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773050163; cv=fail; b=cR1XwznaF3Z9e7lPVVKY/JJdTs5Uhonq9fp4qERHV0Avig0TwvYW6+FynUzgRzAcjVYuj8ZUzFr2aiIZ7QUq2vLAKn/9LWbZQ2gcD8R0YEFju/xUPh1FvkdMeRfp9MsmOI4NrBtqwQVg3sMmpdT05cx1718tnFGLb+eyJISCfD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773050163; c=relaxed/simple;
	bh=9nZu+ivnMxcDmNQeGIzD6U3IWoMaXcKfgeBc17ERfYM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXvPidy6nNAIyz4IHfOuspKQfCs5chBE5NFVZwWISQar0BxnSQaJ1kBoMSvhnSRaXvpH/nHzu55Esax7XuZHLj2jqvRaIzz453fSNkKNjsU5tnJem9FeVFDPTL/5adUpThkItuEtnh5baiV5oSytKJXm/1KxCZRx4tCOrBjPGmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h92lQtEf; arc=fail smtp.client-ip=40.93.194.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrvUnNa3W7qgODE+1ZI1W99LF94sTGYyUQzUAIMB8GFEE2DfrtmO+z1VW7uccvQRmTOgz6ajVtTzwwS+2uWp2eXqvBd4IljcCXsCwNTs+AEDb5AqnYPcTgxE6vuTnJKNdDyE3dFGJnjRZPw4YoHpnpHs5P7DIjgaCL4gqeVzvLSvHohbHH/HjLE47P2OHuD+zMnMRn56ibgVDcumBvNJLVo5l9j4MreGQwBYgP/DZp363juOquhk5W7YXGPw6En0QL1Opl47wT8FsOSKlcJ6kN7EtEIBoI7dVLKFdbp91Da/gLNiPK4uk5xd8jdhqbLAr6uoGl/MQOjtCj6F5MH4nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/ZfLG1mfHG4X2cWdy8KHbXU0TodgBZutqpwhDlG634=;
 b=LjiYGjVOrzUlnv+W8zOON/RdQ6cxZPchhI3fKv9SrIRpLDPAVg3x8mviwO/UpDcTrWKxhMpHZIsedQl2uHeRAxNb//qxwmptncv4uoWBwKB7sbHbZwgZVJBBUu2a/8n1fQ70mt8zxdPdH7PtHSdwN25dLGWq8iOI8Pr8ZYspnZez2YXpP1eXtscypT2Dczhhx9rn8PwyvZmO7Nh8MTJ6PbP771oGqbsYmm8SE87gRo43kc0VsOKNpBKs9SJpntPvXY9W0OpWqDHugwZHOPGG7rix7epNW11BgBv8ULCahaj5LJU+Iujb6M6jMuy5AkR8/EnSbatmCiITEbAna1QXbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/ZfLG1mfHG4X2cWdy8KHbXU0TodgBZutqpwhDlG634=;
 b=h92lQtEfdAdBWeZ1yHQzcHJ01TCCAfcRHkarOaxT7ZBbbyoz3JLiscE+KcWDgxrk9snAfYNA2atbXHgbERSn8rIIUK96KOTysPatqueuCIylj++pyqacCxKz2LUv00AvYIppZoFZqxjNNUr5V7LFBo5PUMzRiXGPAMrBwXVcoEBK1I/PlnIGpAGX6F1t7LGTO/77mT85YP1GGNYgb5TGVq4RJ9U0cvCXdS2i1nouM5XIxksMKnJFUiE3bdO7ZbYUKEaccnMZztZWXC0J24WQyGUT7ja+EXaWtkNcvxE3utBmQK4GtcPyPlW54JIvbJhBOZ51ru3hJWLgtPPShB3C5w==
Received: from BY3PR05CA0012.namprd05.prod.outlook.com (2603:10b6:a03:254::17)
 by DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Mon, 9 Mar
 2026 09:55:56 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::73) by BY3PR05CA0012.outlook.office365.com
 (2603:10b6:a03:254::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.23 via Frontend Transport; Mon,
 9 Mar 2026 09:55:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 09:55:56 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 02:55:46 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 02:55:45 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 9 Mar
 2026 02:55:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V2 3/5] net/mlx5e: Report TX csum netdev stats
Date: Mon, 9 Mar 2026 11:55:17 +0200
Message-ID: <20260309095519.1854805-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260309095519.1854805-1-tariqt@nvidia.com>
References: <20260309095519.1854805-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|DS7PR12MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: aacfc371-a6c5-44f3-fcb8-08de7dc20f08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	NawlHAAU/3A5DZ12xMPsEwERjrmb6nn/IaclHaawLOQOd/Eb5jWcvkkYa9fG2Z0FHPmNb7bJlQyJyTCiYf9qsLCKvbGkkY6XPYJGJGK5YZK31EHUZ22kq6rOn5WIwgAvEAUV7zog0UL4zJ6LHjQI8gLc4/HVeDl85Ix4fjOGQYG/iK9z1Yrv6AMStk/R8KdR/pfSP8h4mfaHqhqLUkBYZvs39j/mx0jy8DgtkIDIy0ut/rjcv9zrrATLodXXYNwiUikujL8WoIxV9CSDEsiZR93+3AlQLOm7JhjdtLu2mPkNdxd5xBYTun9Gl2bEQFgmPL2XQhYJcLjd28uvuNbahnwD5giz3NWnq9B+Z1p7HNJ91VEYmIQG6nJH7mFdjEBppBRCPOacRWFksKdtJkCi5RtzOBNjE9NAVDu53/KmQgN6beIrXgLrFQztotJTcQ0TyzlE/j6RddbL6vHB/NrbJq0WDiTUvCX9VEXwri69+CqC0JRRZP+KkS5qDBtbDv9eVUeUJaa9i6tXz/OaHN5DC3pxHVlBlJZlmesp3drcuO6n+j5QQFXxbaMyhoM7wvMMn34EftuT+qA27wl+YAJ+v7RmZj1cR/wBZaHoEKL3ckQZP9UmMhGNjir5gTI0VE6nMPlLvbe6PJgO32WcbPgNw3VDfVTzpJzHXZDC4ephOIhY5RdrzgM7Emh2rFqy5lQqKw9TwYhL+WttI06vgLXhAHpq6d8q3KR9JGbpki70SFA8Ha224iuGUXmvdh/vOkYRramLIh+qBMFF1wgUAqEBYQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WPAAiIZF3mydPP5n9ZkLVC3Yz42rE9A7bw5K4piwdr2E4m3iPuNeq6IrsNAwo9mNmiJqFaum51HoUNdIBNH5NLeroYMeehMJLL/V8ldiGOCCdng2ILzsmZv4i0n1ClmsbK13yTqB1ndMq9mE5TSJ296cZ07k/RWbWqC5jY+8EIEvqFeBDeya+YJS0KLUDX+jfuyfwnI7+3ZG+FEuC1JckRxAsJ7xbKsBsUBiZ1N/DVtWbJm4WKe0XrGhlaEZKam2etGMsmi4UTAQturBkuwenXcxuHgSxk28e2Dmh7LnA9qqJe7LmP3iyPAvzZxU5MDQHjt5P9VOfobZ+74+vK3HLQCXIQ94sEUnvfIS3CoMcn+yltdCXmY1FX7SBdno2+qlsooK8mTtvhfy9VHAsQAEADJS3p5is1nRqggxBWNDIq4FMWzK+E9op0MH0haDOede
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 09:55:56.2204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aacfc371-a6c5-44f3-fcb8-08de7dc20f08
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765
X-Rspamd-Queue-Id: 792B0236A08
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17768-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Gal Pressman <gal@nvidia.com>

Report TX checksum statistics via the netdev queue stats API by mapping
the existing csum_none and csum_partial counters to the csum_none and
needs_csum fields.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index f20fec154d47..e2f98b1f8636 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5488,6 +5488,10 @@ static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
 	stats->hw_gso_packets =
 		sq_stats->tso_packets + sq_stats->tso_inner_packets;
 	stats->hw_gso_bytes = sq_stats->tso_bytes + sq_stats->tso_inner_bytes;
+
+	stats->csum_none = sq_stats->csum_none;
+	stats->needs_csum =
+		sq_stats->csum_partial + sq_stats->csum_partial_inner;
 }
 
 static void mlx5e_get_base_stats(struct net_device *dev,
@@ -5538,6 +5542,8 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 	tx->bytes = 0;
 	tx->hw_gso_packets = 0;
 	tx->hw_gso_bytes = 0;
+	tx->csum_none = 0;
+	tx->needs_csum = 0;
 
 	for (i = 0; i < priv->stats_nch; i++) {
 		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
@@ -5568,6 +5574,9 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 					      sq_stats->tso_inner_packets;
 			tx->hw_gso_bytes += sq_stats->tso_bytes +
 					    sq_stats->tso_inner_bytes;
+			tx->csum_none += sq_stats->csum_none;
+			tx->needs_csum += sq_stats->csum_partial +
+					  sq_stats->csum_partial_inner;
 		}
 	}
 
@@ -5590,6 +5599,9 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 					      sq_stats->tso_inner_packets;
 			tx->hw_gso_bytes += sq_stats->tso_bytes +
 					    sq_stats->tso_inner_bytes;
+			tx->csum_none += sq_stats->csum_none;
+			tx->needs_csum += sq_stats->csum_partial +
+					  sq_stats->csum_partial_inner;
 		}
 	}
 }
-- 
2.44.0


