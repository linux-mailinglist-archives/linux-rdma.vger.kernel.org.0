Return-Path: <linux-rdma+bounces-22823-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tnLPFjn7TGrVswEAu9opvQ
	(envelope-from <linux-rdma+bounces-22823-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:12:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A6D71BBA1
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:12:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=RqEt2qav;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22823-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22823-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFE343088C23
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 13:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BBB414DD3;
	Tue,  7 Jul 2026 13:11:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A5C40A95F;
	Tue,  7 Jul 2026 13:11:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429871; cv=fail; b=EG2XJxvDtbbdiE7BL9guu14P/XKIFPjtb/Hw9cKdRetl62pTendOofxxC4qvu4xX3/0cIvkTtkUeU27X9n/pbJCPZhnlDcS9ZrWrULc+Hjhsf2+O91EGKpM4hqog831Pk/gXP2JTBq9ouHs23HvVSJaFcYk5FEhjJqO66UREAWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429871; c=relaxed/simple;
	bh=6lIAi0A6RudSvtJc9ZB2ihK7jML4SQjY/ySxuFSFysg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGg8DUVe+/egFTh+1UU5ddR4T7lSoJWFC9h+eetVDtmXJb/6IUeF3DLM3k44ElucK+yXrzsq7iv1iAuCXugOJbpY4MvfQM2Qeqp+wpEvnpp1ToDRjvsnyXh5AKt5ixoSclcLmdxxC96cnbqXTdS1WaDLC8Fd1x3JULXidZKdsDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RqEt2qav; arc=fail smtp.client-ip=40.93.198.62
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d39yYJjS1TLjraWiimZfbgJ/0ANJfntN5/MHjXgkQzCAYVUp2JF1RIlSf2lhxKRxE1mQVy1C4YoUKOufLAvMmWiyfzuVkv4t9DbKTizzH9zL0jVPSZOXVjllXmDNQ3fIzlektOs9ka6ob1p1gIhZkOly8vXSOWci0xH9qtRQ/gcpExlqD6lKhhHLYuoupKggHuG66gZo5t0z9G5Gz+jSi0nOGgckPeDkHqBhidw7qkJ9vUrhuc2BBZrtq5vR6WCyCnUeSwSlePXarz+YxMebmgbD+dOTpF1h8uaZ+i1h9wLZaC1og/uZlFk620GsZc/tVf66GJC68Nk4RHqjxsQdCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QzBxDWh2EP+91QPUfqtynfkzBfpB6kcOpN6gOccF1I=;
 b=qd5JFzzbFIR4Y5Z1KAGoIkaiHG3inQ7sUNFf/QXelQ83qAKmnbGbjPmz0kx5ojx3rYO37G6nm3jAVAytBfAiId6zOKdXXOM22MSUoDYywi7fQaQOLq+BzRzUTROQ6fCFnc3d3P8VofGeYfm68nWnz/+T6+0d2g1QtJso/+A+SQdzRA78Zpk2pgriSh/j/USjBdbwggAMyuDty1Kg9EwbkR61N08YGOHnBR4RQlRlB37RB2Nz2hM/OUlbuZso2eRKk8TF2AClukW3UWwTyl3xXeThFP14P1lWwTLRzqRBTQy5B8GpzJRdtGC0FRw+IsF9+QrqH/M6bEXafPPmyOosdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QzBxDWh2EP+91QPUfqtynfkzBfpB6kcOpN6gOccF1I=;
 b=RqEt2qavg1xPy3vDt6VBrn09iut7xI7Ry6KdtwYXL/YAnEdXzaBdv8737fT3Efk9U3GGncV+/hjtJmyv4a9rgiWegCqiWSeNUWSYVMpQAFPeBsWga/RpcT9bjBba2+2dMqNbOzaB4Ie2aNe06JLYYfq8CwuFyRuf/lOSgcWFBJj+WLkb/Mr927PTM5yTSAmnn60v/1orYxpB1jdb5eWjAqwLI4XSEFjFR1nZej/qda4EXMmq5s6KxzGJLAjjMULpqzhOW45pE8CQl/LJxL7u/NkbGZLuMpCeikghLwHb/yUuTl4ZwdT4ju5FFhdk/M0HJeFoHBkaVKzZG5LOQTQbYQ==
Received: from SJ0PR03CA0158.namprd03.prod.outlook.com (2603:10b6:a03:338::13)
 by DM4PR12MB6206.namprd12.prod.outlook.com (2603:10b6:8:a7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Tue, 7 Jul 2026 13:10:54 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:338:cafe::6b) by SJ0PR03CA0158.outlook.office365.com
 (2603:10b6:a03:338::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue, 7
 Jul 2026 13:10:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.0 via Frontend Transport; Tue, 7 Jul 2026 13:10:54 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:10:34 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:10:34 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Jul
 2026 06:10:27 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Boris Pismenny
	<borisp@nvidia.com>, Chris Mi <cmi@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Jianbo Liu <jianbol@nvidia.com>, Lama Kayal
	<lkayal@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Raed Salem <raeds@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, Stanislav Fomichev <sdf.kernel@gmail.com>,
	"Tariq Toukan" <tariqt@nvidia.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next 04/15] net/mlx5e: psp: Merge rx_err rule add/delete with ft create/delete
Date: Tue, 7 Jul 2026 16:08:47 +0300
Message-ID: <20260707130858.969928-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260707130858.969928-1-tariqt@nvidia.com>
References: <20260707130858.969928-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|DM4PR12MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: acbdfb9e-e75c-4888-cc2a-08dedc292d41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700016|23010399003|18002099003|6133799003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	UdkllrWC+FxToHXMw/A/XGliZYBeVzh4wLfwVA3ywbdgnmiTj3Co2OCBPg8n0BObI9isOk4bfvlqvga66ERHiTmbcVj/qjJ/K/LngI49zlfnBIYfvPo0iEw80HVnijPbV+Ini+0KIo1DTg5plDQCK1zyT441G86GvP0Ui1H50nW5g6EIwHl9y3hp8eabrZCNoOWaRRpbsOK/cUAnXOjHNAQVwGOaPKOQWcGOhxrnpx5593E7krw5oFJLWVw5ncVCzQY7ox9tp+xQJOOEj12fLIJO2qF0HGLQnDvA0gf89s0vcXuQnkD60udmhhaj5492cHCKXk8msb3mSnO8x+7yg0w2FGSjlZuZ03EjlF+/Xb1ZvmJTcIjChN4uhmVRT0HMF/lf44wleX+2IoMFvb6nG8uk/digkZTPgHHbKwmbZiWpMabHHEOBqaU8sfJiWKm+SrXMndMb1rx2HqqbTNp/jGJJRDuef/mQ5MniGQvFzuDOqIVkEcUWgB2SqzhKgu8rHXERbJ6xFqKvxSUUtD7x37WZLA3yjU93RMaVk4L2JNezUJzxJ20YdJOAKZdMEQ35WIE41y9lAt7acRPq4Gi1pkfHIfoQWWaPZAZskLl1scVU5ZNSM37SClz1Mhcagf7f09ByAgjPG7I6eN7Pv81ev6HNTVqsuKHAFTvvLQwEkBOaY4W9NsEhfEYDlaVFNJBY8XOTJ6PGUz5X88mn6HCw9Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(18002099003)(6133799003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SNwMOF0HeZDijXMalmEiH7bUO1YAbnUoqz5YCGoFI1spFYO+kTvVRtGvNqKIBqq0sJEOA01Nrv51lQ58RncjKv659E6EhO1AJMEezUuLTZbosTFDCDxpLJE8fwP2rRnkLpPa4LXOpz4lmi7ptF3vIWFc/U4Zvzt8Q+UozibUcEzNrh2ywN9jL984dLZ7NFjDdtupcvXY2hY/49YAYOF1dG4gYW6a6yWjCh9X9pZmDU/Y/uC+dvIexnB7/UswweV6EKgi/HUKUzmzGKBfY1NDuTauuvJYCz+YJgmZgoAfQKWNmr0g5+yiaN3v+91GSt3ZlFS5748FK85z37Ynub08rMnamIZlr0rqh+jyrMN9/ujGIGeYsfiLKeS8lHufMdSXfdgPx/Dao59VcL7Y7i5sF/1ARbuwKo85NSwDRA86VON7ca8LPo11SdWNvpwKqEao
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:10:54.4094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acbdfb9e-e75c-4888-cc2a-08dedc292d41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6206
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:aleksandr.loktionov@intel.com,m:borisp@nvidia.com,m:cmi@nvidia.com,m:cratiu@nvidia.com,m:daniel.zahka@gmail.com,m:dtatulea@nvidia.com,m:gal@nvidia.com,m:jacob.e.keller@intel.com,m:jianbol@nvidia.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:raeds@nvidia.com,m:rrameshbabu@nvidia.com,m:saeedm@nvidia.com,m:sdf@fomichev.me,m:sdf.kernel@gmail.com,m:tariqt@nvidia.com,m:willemdebruijn.kernel@gmail.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:sdfkernel@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22823-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,nvidia.com,gmail.com,kernel.org,vger.kernel.org,fomichev.me];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3A6D71BBA1

From: Cosmin Ratiu <cratiu@nvidia.com>

The rx_err table is different than the others, having separate functions
to create the flow rules in addition to the flow table.
Merge the add/delete rules functions with the ft create/delete functions
for consistency.

Noop change.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/psp.c         | 78 +++++++------------
 1 file changed, 30 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index a69c4e2821e9..5c34c0be997a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -73,8 +73,8 @@ static enum mlx5_traffic_types fs_psp2tt(enum accel_fs_psp_type i)
 	return MLX5_TT_IPV6_UDP;
 }
 
-static void accel_psp_fs_rx_err_del_rules(struct mlx5e_psp_fs *fs,
-					  struct mlx5e_psp_rx_err *rx_err)
+static void accel_psp_fs_rx_err_destroy_ft(struct mlx5e_psp_fs *fs,
+					   struct mlx5e_psp_rx_err *rx_err)
 {
 	if (rx_err->bad_rule) {
 		mlx5_del_flow_rules(rx_err->bad_rule);
@@ -100,12 +100,6 @@ static void accel_psp_fs_rx_err_del_rules(struct mlx5e_psp_fs *fs,
 		mlx5_modify_header_dealloc(fs->mdev, rx_err->copy_modify_hdr);
 		rx_err->copy_modify_hdr = NULL;
 	}
-}
-
-static void accel_psp_fs_rx_err_destroy_ft(struct mlx5e_psp_fs *fs,
-					   struct mlx5e_psp_rx_err *rx_err)
-{
-	accel_psp_fs_rx_err_del_rules(fs, rx_err);
 
 	if (rx_err->ft) {
 		mlx5_destroy_flow_table(rx_err->ft);
@@ -125,23 +119,40 @@ static void accel_psp_setup_syndrome_match(struct mlx5_flow_spec *spec,
 	MLX5_SET(fte_match_set_misc2, misc_params_2, psp_syndrome, syndrome);
 }
 
-static int accel_psp_fs_rx_err_add_rule(struct mlx5e_psp_fs *fs,
-					struct mlx5e_accel_fs_psp_prot *fs_prot,
-					struct mlx5e_psp_rx_err *rx_err)
+static
+int accel_psp_fs_rx_err_create_ft(struct mlx5e_psp_fs *fs,
+				  struct mlx5e_accel_fs_psp_prot *fs_prot,
+				  struct mlx5e_psp_rx_err *rx_err)
 {
+	struct mlx5_flow_namespace *ns = mlx5e_fs_get_ns(fs->fs, false);
 	u8 action[MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto)] = {};
+	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_core_dev *mdev = fs->mdev;
 	struct mlx5_flow_destination dest[2];
 	struct mlx5_flow_act flow_act = {};
 	struct mlx5_modify_hdr *modify_hdr;
 	struct mlx5_flow_handle *fte;
 	struct mlx5_flow_spec *spec;
+	struct mlx5_flow_table *ft;
 	int err = 0;
 
 	spec = kzalloc_obj(*spec);
 	if (!spec)
 		return -ENOMEM;
 
+	ft_attr.max_fte = 2;
+	ft_attr.autogroup.max_num_groups = 2;
+	ft_attr.level = MLX5E_ACCEL_FS_ESP_FT_ERR_LEVEL;
+	ft_attr.prio = MLX5E_NIC_PRIO;
+	ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
+	if (IS_ERR(ft)) {
+		err = PTR_ERR(ft);
+		mlx5_core_err(fs->mdev,
+			      "fail to create psp rx inline ft err=%d\n", err);
+		goto out_spec;
+	}
+	rx_err->ft = ft;
+
 	/* Action to copy 7 bit psp_syndrome to regB[23:29] */
 	MLX5_SET(copy_action_in, action, action_type, MLX5_ACTION_TYPE_COPY);
 	MLX5_SET(copy_action_in, action, src_field, MLX5_ACTION_IN_FIELD_PSP_SYNDROME);
@@ -156,8 +167,9 @@ static int accel_psp_fs_rx_err_add_rule(struct mlx5e_psp_fs *fs,
 		err = PTR_ERR(modify_hdr);
 		mlx5_core_err(mdev,
 			      "fail to alloc psp copy modify_header_id err=%d\n", err);
-		goto out_spec;
+		goto out_ft;
 	}
+	rx_err->copy_modify_hdr = modify_hdr;
 
 	accel_psp_setup_syndrome_match(spec, PSP_OK);
 	/* create fte */
@@ -173,7 +185,7 @@ static int accel_psp_fs_rx_err_add_rule(struct mlx5e_psp_fs *fs,
 	if (IS_ERR(fte)) {
 		err = PTR_ERR(fte);
 		mlx5_core_err(mdev, "fail to add psp rx err copy rule err=%d\n", err);
-		goto out;
+		goto out_modhdr;
 	}
 	rx_err->rule = fte;
 
@@ -230,8 +242,6 @@ static int accel_psp_fs_rx_err_add_rule(struct mlx5e_psp_fs *fs,
 	}
 	rx_err->bad_rule = fte;
 
-	rx_err->copy_modify_hdr = modify_hdr;
-
 	goto out_spec;
 
 out_drop_error_rule:
@@ -243,45 +253,17 @@ static int accel_psp_fs_rx_err_add_rule(struct mlx5e_psp_fs *fs,
 out_drop_rule:
 	mlx5_del_flow_rules(rx_err->rule);
 	rx_err->rule = NULL;
-out:
+out_modhdr:
 	mlx5_modify_header_dealloc(mdev, modify_hdr);
+	rx_err->copy_modify_hdr = NULL;
+out_ft:
+	mlx5_destroy_flow_table(rx_err->ft);
+	rx_err->ft = NULL;
 out_spec:
 	kfree(spec);
 	return err;
 }
 
-static int accel_psp_fs_rx_err_create_ft(struct mlx5e_psp_fs *fs,
-					 struct mlx5e_accel_fs_psp_prot *fs_prot,
-					 struct mlx5e_psp_rx_err *rx_err)
-{
-	struct mlx5_flow_namespace *ns = mlx5e_fs_get_ns(fs->fs, false);
-	struct mlx5_flow_table_attr ft_attr = {};
-	struct mlx5_flow_table *ft;
-	int err;
-
-	ft_attr.max_fte = 2;
-	ft_attr.autogroup.max_num_groups = 2;
-	ft_attr.level = MLX5E_ACCEL_FS_ESP_FT_ERR_LEVEL; // MLX5E_ACCEL_FS_TCP_FT_LEVEL
-	ft_attr.prio = MLX5E_NIC_PRIO;
-	ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
-	if (IS_ERR(ft)) {
-		err = PTR_ERR(ft);
-		mlx5_core_err(fs->mdev, "fail to create psp rx inline ft err=%d\n", err);
-		return err;
-	}
-
-	rx_err->ft = ft;
-	err = accel_psp_fs_rx_err_add_rule(fs, fs_prot, rx_err);
-	if (err)
-		goto out_err;
-
-	return 0;
-
-out_err:
-	mlx5_destroy_flow_table(ft);
-	rx_err->ft = NULL;
-	return err;
-}
 
 static void accel_psp_fs_rx_fs_destroy(struct mlx5e_psp_fs *fs,
 				       struct mlx5e_accel_fs_psp_prot *fs_prot)
-- 
2.44.0


