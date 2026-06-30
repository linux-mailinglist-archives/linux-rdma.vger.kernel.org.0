Return-Path: <linux-rdma+bounces-22589-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SKE2EVWpQ2rseQoAu9opvQ
	(envelope-from <linux-rdma+bounces-22589-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 13:32:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E66DB6E3A25
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 13:32:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=OcRnhG5y;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22589-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22589-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14C14304DA2F
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 11:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA1A3FE674;
	Tue, 30 Jun 2026 11:30:39 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012014.outbound.protection.outlook.com [40.107.200.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACC135E1CD;
	Tue, 30 Jun 2026 11:30:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819039; cv=fail; b=n1KHZ55fahtD0YDQa3yi2tkuoEYuJjnyXCOu3ZQ85y1WexZvvG5rFp/GRdGnVtsutLwSRG6EhhnchwoMd7YORKPBgwQJ7Vl580QUuYkAmeGRGXCt3UHlmhGNskNUbkd1F85iqS/8EGN2G4LrHpGQrzYnoOXEPch6SKIAymXBSzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819039; c=relaxed/simple;
	bh=sfXKr8l40hKI+HFFQlbcW1lJJ9cXbCxexwXGbKn5X9Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXp3Tfm/+BDuqGeFQ6aeZpxhD2MSBDrfVfxrMsT7p4RCpRlfm9ZPoXY31a/FFl/9XERShEG7yQ6Z3SLiPjAbFQ3nbbgJNuLWPvxNEFuhmaLvNkXiruLO2b6Kuaaoy2WqjJlNAQcCzITATey86ZfLyEzDdiSbahvzUjS2k+//KPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OcRnhG5y; arc=fail smtp.client-ip=40.107.200.14
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jsm05a/4eBnMnHytjzjspHEhjX3FsurkEprpQ8voxcwJVLRdXjZVbADqzENjtzuxLYWf7yACoXDJLE9aV3OUp5JLaoNkijJCGDIngLy7Flt6PDpvoUu3C6pMA6owHgX/YnEpyG/TPYzpktNoT7UhOuSewg7Dp+45PJmI7QgHVHMkJmVlr68OlFjQfZQtgMUMGBAKzbX3MtQbRX7vteFJWSEdBSPr/4dWQY265OeUXAUQwZ5j4NxNSh7+UUt2dp+VUD5xjBd1+fRy3K+MkxPWosKTXA2nKxabQw2V+glBh897QTMct6sNOsfVIZprKyaY+e6e1bIVgs/Q5rK3ng3egA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEzu26uBfJ7BZXauI1nbshGZuPRaqYpN9AnXnHSX+Ns=;
 b=cqWN1XhtUb0t3E4U0UeXwWP/fmG6Kj2/GZ7cmHxDXZVISsnbcRr2z66ONdGC4QtNNlK3QwMHoK9mGKSzwZPie8FdpPXRLdUFnMYEFk8rYxxwntEtGCctj00/Nd7gyaas5Vj+jHFZOO29QkInKHjjiSB5XRWuV80HUOrXC9r7y01dmsB6M78FJo9dDTFBf5brdxWwZl9YGnHbJeX85IIC7j6ZDcugCePEfeNMh2wsdYigh4pTOdEDFO6I11Pud94/OQPr1IIUT1pAOwgJvd9cSvif7FJ1aHOWSL/G1S/1hR3jjA8S7QHjtx9a5ub1SRatdE0gLQTVLtWkPk5keGrGYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEzu26uBfJ7BZXauI1nbshGZuPRaqYpN9AnXnHSX+Ns=;
 b=OcRnhG5y+ncHroFbqMZ1wPEOSsXJhe0XtiV1jQ+MZEh7FXqoyoBA9RYvUDesH9GaOrGhCl0ZsTaShhMJ3bbEcZyk4pFp7jiR/coR8bpNfFjNFcybdUbCbds7P8pe4QIs5eXBB/QODuMwwcamSW1cgJxPUEdhGOSoQX1JhO3vqXqF6vFeRaaYstB3pjCjhIebsI2Ut9exqI+4NW6QOiWzmdSAjcKY9Sfo2LQzGKsSlH9aKjnTnBbeLfdWxTR7jO87Ek59sAATjsMDL9c5GoNQJmExThEEwxCz9jAawbkS8mconfa5cpzD9DzbZuYcnpPNh8+SbXevZFqWotSOG7yzZg==
Received: from SJ0PR13CA0147.namprd13.prod.outlook.com (2603:10b6:a03:2c6::32)
 by LV3PR12MB9331.namprd12.prod.outlook.com (2603:10b6:408:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 11:30:33 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::81) by SJ0PR13CA0147.outlook.office365.com
 (2603:10b6:a03:2c6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 11:30:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 11:30:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Jun
 2026 04:30:14 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Jun
 2026 04:30:14 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 30
 Jun 2026 04:30:08 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Edward Srouji <edwards@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Kees Cook <kees@kernel.org>, Leon Romanovsky
	<leon@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Maher Sanalla <msanalla@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>, Rongwei Liu <rongweil@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Shay Drori <shayd@nvidia.com>, Simon Horman
	<horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net V2 1/3] net/mlx5: LAG, Fix off-by-one in single-FDB error rollback
Date: Tue, 30 Jun 2026 14:29:15 +0300
Message-ID: <20260630112917.698313-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260630112917.698313-1-tariqt@nvidia.com>
References: <20260630112917.698313-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|LV3PR12MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: 7476c853-6b84-464e-eace-08ded69afeb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|376014|82310400026|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	W568H0X8/HUxIEixwoomE86TUPk/uwtF47ocg89LxK1QapY1f4bowwuXY12oPFCugHpGtpMBaqxm8MfVlyUvOao7cFDsZIpL9yQmr1z7CUPBObsnGKfJID0mUCX+MxokkmrqC4roiRVv72W37RZI28h2d4s9WKJOlBao/v0OO7xA+GqOObTAls9uOAqMAo9wM020r5GwRxe9dQtM2OBbz4dfBjYlIe54qA5DMdhVdQTWzdlEH8UgyPFnnc6gNeHQVM32ky6cMg09mDMYdBMv1E/zQ6IEgqJEv7h5Xsk5LeLvzRj6rNiYyPQBKHsEH2fajj0kjwEuSoBIFPCkGroDzFaySPAERSdsU9lKb+ZLo4hX5m9XgY23jidmB50DutC66xawp4h2v0uMiALNUFGhy4gJ2JnXGLoNKW++AF0kOZzr/qI/PhrXq//l0Qaf56CYYwY1zCJLRnz3SFghXme+f1Mgiq3Csp8G322xJmRXyTmfxirz7b/nnlmCPq82A9hVtR5dzYYli/AYeZlkazq7i3SBYBgfVW77pUQbiBPEjst57W0xFNWipA34s9Qub17G6ySuP1BFU/54Dt9fVbq8XHs2QgPSFHIT+eu3T8CK9oDTybEYGzz7e950yYJLbYK35a6eIvLxHh3CoR8PlR10V7s6vWlGjIJWUPNZL95G91r/q+uK5Hl7KJLR2tzqE5f0NviMLNTu1LyVTerQxnNN3Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c6lcQ0aXTxE3CLR3mogrgf3OFLTW6WSEXazk7l3FcB4yaaDAnyfO6l86mLG2+KcLUmqNz4JkAX6Y6cYDv9Qx6MpgSrVSr1U4IJI5rNBMy4kh7mgbP7GqEbjq/+kNACl/4KPn68vyVD0c7s9j5CM01OucMsulqebeE7qOb5mYPCfTTktpulzR+R4/N6EtNpKYxCVyLMF57Gnowou/kL5EsjMUHddJ+LZlxB2VJo8HGiHCKvaqVfuWI5+jfMJirDPqJ7NJOMYG+uJg8Spg0RfoWovfSLuUCBs0S7lNU8JLdFkEaGcrC8ruvKz3MIMHiGYQXGbu4RAS4dc0gU5becsNIkzlIupyTMr/tIgIlXaPttPmJgS6rkxBY6/HlxtSaS+dzuPLHC2ehaTAx36NPMhi98Q5EnmZBrTYCUX7ewbOtB6qUdaHic1tf9g395QH3B37
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 11:30:31.9216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7476c853-6b84-464e-eace-08ded69afeb2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9331
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
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22589-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:edwards@nvidia.com,m:jacob.e.keller@intel.com,m:kees@kernel.org,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:msanalla@nvidia.com,m:mbloch@nvidia.com,m:moshe@nvidia.com,m:ohartoov@nvidia.com,m:rongweil@nvidia.com,m:saeedm@nvidia.com,m:shayd@nvidia.com,m:horms@kernel.org,m:tariqt@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E66DB6E3A25

From: Shay Drory <shayd@nvidia.com>

On failure at index i, the reverse cleanup loop in
mlx5_lag_create_single_fdb() starts from i, so the failed index
itself is rolled back. That can operate on uninitialized state or
double-tear-down a rule the add_one path already self-rolled-back.

Start the rollback from i - 1 so only successfully-installed entries
are undone.

Fixes: ddbb5ddc43ad ("net/mlx5: LAG, Refactor lag logic")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
index 113866494d16..6b4ad3c53f2f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
@@ -78,7 +78,7 @@ static int mlx5_lag_create_single_fdb_filter(struct mlx5_lag *ldev, u32 filter)
 	}
 	return 0;
 err:
-	mlx5_lag_for_each_reverse(j, i, 0, ldev, filter) {
+	mlx5_lag_for_each_reverse(j, i - 1, 0, ldev, filter) {
 		struct mlx5_eswitch *slave_esw;
 
 		if (j == master_idx)
-- 
2.44.0


