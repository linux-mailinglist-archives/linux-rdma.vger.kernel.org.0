Return-Path: <linux-rdma+bounces-22831-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sNe+Jfz7TGoGtAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22831-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:15:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 448F271BC30
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:15:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=XKwy6Abl;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22831-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22831-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FC0430BA0FC
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 13:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B45E416123;
	Tue,  7 Jul 2026 13:12:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010047.outbound.protection.outlook.com [52.101.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D283F3F5BE7;
	Tue,  7 Jul 2026 13:12:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429940; cv=fail; b=FbE2sbQUmvfbY6/iDSiBt3cE+TNz5Sz59jDUqLCS8Htzor8zFkTTSXuEt8JdtJXydPQkxzqOu2PqXmHZOBFtel1/JZDPKQ81X7aHnU/kEjtxxOkKR7wdWRBkBBOazkHotMesz5gSUMEiHNLrCYnXJvVsZyHiIZMzEzjy7atZQAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429940; c=relaxed/simple;
	bh=LqibuMjkhTMQg9Y0eX0kS9tK7yb/ASaKuNLqJ1yz3so=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o5OtRLUOqUr6xnfZhQ8ikWI7Xwxe5wQAaP+rY4jIpGcRfS0FrRYm8xQ65c0YempWGgEwd1VfJ+4ABG+bBO813uy+xljbAtfovoFHp7y2FRxj3OFxtE7UY0/rqUa2HrokmX7CPBGK9YHaqL0hTt69y/Nd9R6ubD5PB/gh/f0sQjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XKwy6Abl; arc=fail smtp.client-ip=52.101.201.47
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YicshTiemaYuYXcWMd8w1+EIQOyAJqh6By/koAyjmtZREGNeHFq+Yd/cIprbb0nTz+UMeJFfJMvwIkkLaRCfnesUoseDpZGdeoOyP9IKMWERKiUOctG+L5llXm4okpnJHlG5N0zmAMjwameOcwGAycc9PCqiDP/EcJsu2T6pVdG9xJ1CEDQLyGVmkmuCeoC/dJdA0ZtkUzB8/eXl0kdYZippc0elny/an0i4Ev0a9qZcL81iNCObS/P127hCZm8m6qKqBiTrncwLnNoEueF6vxy36pXX1TBcP4EiJXjNOyqkyfk0LUMs6dp5478bI7VBssmmYN35gRFT73QBq55r9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZNoFv+NMVvGF2XcBptSm3H67B6lyTbPosQBHS+mYUs=;
 b=ZQiriaGKI2/o8P3ZX/jJI+inT/ZUEFtghHzmiV7ROSIGdwQKOzXMibeogH5lzZVIc+skK2ZXaJ53WepRVel2QvT60ExW1EdFuT6xRTfFPB+OULFh7VT6HmryKe3+U2c/P+YMw5LoLyWxBbWAlVOhCo/B+dBKZ0LrkfEW9z8hHwRYt2S2oCR3JgfJhSG/Csahv1BOBDKMS9PKqd6rJRXb8U2awlrVLlvI1lzuRCYnk/LvcP+EBxCSTo1mwbKurC+lcPFYfzlk94IVk8XFoWTIJFPQGotx4dJ7bFao731WYzzeTLTubmSMeADHiuqkrWyCpqsJIPVjC8WVfUjUCa2eEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZNoFv+NMVvGF2XcBptSm3H67B6lyTbPosQBHS+mYUs=;
 b=XKwy6Abl5j+saG724oTy41hE5lQ17yX2HT36GWLUlf+9SykE+FoNZuoEzG/wMuKoJp8rXNQK9KZMc/cMmW4v503uKuYWwhnmeQG3Xk9ksOW5DBIAv1AHIhCqFb8nVdv2xYLXRuwnwbg/SJLBbIuCufR9aU3HTNdIZQbUqkuXh+7rF+lvj+BByBnR4f+tXec31oxByrlA92/PBH4fM7XQdRkGkxOE67tAB5U1m61Q22EHa3VPyCKoSloW8Cg5sm9bFMUePFoKqbYp04duYzWKI5HP6v++ckXkn7TKuNLp74lxsYrvF+QdwH9LwN5yNQlerar88ZT2FIySeJz1t8G6oQ==
Received: from MN0PR02CA0014.namprd02.prod.outlook.com (2603:10b6:208:530::19)
 by BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 13:12:12 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:530:cafe::24) by MN0PR02CA0014.outlook.office365.com
 (2603:10b6:208:530::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Tue, 7
 Jul 2026 13:12:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 13:12:12 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:11:30 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:11:30 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Jul
 2026 06:11:24 -0700
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
Subject: [PATCH net-next 12/15] net/mlx5e: psp: Flatten steering structures
Date: Tue, 7 Jul 2026 16:08:55 +0300
Message-ID: <20260707130858.969928-13-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 998d6f3d-a903-4bc4-a82c-08dedc295bb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|7416014|18002099003|6133799003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	32LBhnQwkCQ8n342nL9pylYtVip77Dl3UfbvSJdpBDnl6jD0MOIHubeCcxq9z26iez8vMw7waxrNo05RMVhjg9JoQvWyd7q75KkrPEEah0onrkItlMZ15tluxaavMg4nAMPNdDBOZykLlrb1sa99RJhyxFhQOiHHvfuMZXM4/HCpwuIWCMSGIo3cajniq7x6J6xApYniau94DlamDNdAzMDRUa0qghMJvr0SBeEwM3GwofkR1xgleesN2lMs9+SudmTOSUI67fJAx/6tBXDl+M8mSEmHLh9Zpoo8/IQ0LycONsIug6qGPNvvv+2jPcJYMhZ+U3/FMn0G5MruktoLqkH70xpIEOaKIOXvqPmKWmaXhnj/aQ83NBFZnuDHcpfL6lDKueT79rXit3lkAMxM1Ee9FsW9dAosrKlMma+000n0d4TccFUduCVL5ga6UdIPfokWgBsBkERJovt0UBHtVzmMfletxEIeqvwoT3tYoLlac7wl/9tAyesLCnjoFshOH1+XCQ5iymLO3LJzWOz50uEoDmnh2iecCP8FqWscyJSVOn53LCdTdZvz8umkbZ+laE5h1Ed3YjjaLouLOytIfECm2/VAwB3Cd1hPrPU+URDu9SITL+XrbNFGfBf3eRr/uo98+B5Qbcqcn0b1ukaOPUTIX8bd4QRwaTiviCidEkhixJmE+au1swS2T5DG58xcjc66Da5rqF5cIZQavHvPTA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(7416014)(18002099003)(6133799003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F19DOftKoB/DMXZYoaix4PwiuFniQRS63Bv4s8SOiVSakuxdYmjXhnKumYGoD3I7hG5EG0xFyXP7EEda16+qzNtAZZneQKnr2USlG8yw77dJTQ03CGnq32p2qA+n2HSnnhSmTWLkiOIcqFnBWKpwsTRmiEPupaMlVQQXyLhFVh3moeUfPj6+CQhfwCjk/LfUtxzmdW3bo/klMjNpT6C2MAiGfUQFWXc7McKl+iDppyrDWegaZ3R8PVveQbA1QP8lbmDEcgU3lQJ5GCIrHPIRg3rGNu4/rY7dhvuz/0hLTlRib3t6gDUhq9BWOTFyMiDMue6CJqD1z6hLK6b11EItQoEsAnfNT2S+Uf1zGzIdzBy/0N58ZjE3lYSW5ExioitiKzgdL+geBuClKTBR7cGTNYy13Ijqwzk8eGt4yRWOlHPvVLmCz4zGJjpsfg3ElUZ9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:12:12.1882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 998d6f3d-a903-4bc4-a82c-08dedc295bb8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:aleksandr.loktionov@intel.com,m:borisp@nvidia.com,m:cmi@nvidia.com,m:cratiu@nvidia.com,m:daniel.zahka@gmail.com,m:dtatulea@nvidia.com,m:gal@nvidia.com,m:jacob.e.keller@intel.com,m:jianbol@nvidia.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:raeds@nvidia.com,m:rrameshbabu@nvidia.com,m:saeedm@nvidia.com,m:sdf@fomichev.me,m:sdf.kernel@gmail.com,m:tariqt@nvidia.com,m:willemdebruijn.kernel@gmail.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:sdfkernel@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22831-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 448F271BC30

From: Cosmin Ratiu <cratiu@nvidia.com>

PSP steering code has two dynamically allocated structures to store RX
and TX steering structs. Remove those and flatten out everything into
the parent mlx5e_psp_fs.
The tx_counter was moved out of the TX table as well, because the table
doesn't own it, it outlives TX table destruction.

All table creation/destruction now happens in
accel_psp_fs_{rx,tx}_{create,destroy}. This will be used in subsequent
patches to make PSP configuration dynamic.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/psp.c         | 257 +++++++-----------
 1 file changed, 97 insertions(+), 160 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index 48bc59045dfe..b713f235a0f7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -26,7 +26,6 @@ struct mlx5e_psp_tx_table {
 	struct mlx5_flow_table *ft;
 	struct mlx5_flow_group *fg;
 	struct mlx5_flow_handle *rule;
-	struct mlx5_fc *tx_counter;
 };
 
 struct mlx5e_psp_rx_check_table {
@@ -46,14 +45,6 @@ struct mlx5e_psp_rx_decrypt_table {
 	struct mlx5_flow_handle *rule;
 };
 
-struct mlx5e_psp_rx {
-	struct mlx5e_psp_rx_decrypt_table decrypt[ACCEL_FS_PSP_NUM_TYPES];
-	struct mlx5_fc *rx_counter;
-	struct mlx5_fc *rx_auth_fail_counter;
-	struct mlx5_fc *rx_err_counter;
-	struct mlx5_fc *rx_bad_counter;
-};
-
 struct mlx5e_psp_rx_table {
 	struct mlx5_flow_table *ft;
 	struct mlx5_flow_group *miss_group;
@@ -63,11 +54,17 @@ struct mlx5e_psp_rx_table {
 
 struct mlx5e_psp_fs {
 	struct mlx5_core_dev *mdev;
-	struct mlx5e_psp_tx_table *tx_fs;
-	/* Rx manage */
+	struct mlx5_fc *tx_counter;
+	struct mlx5e_psp_tx_table tx;
+
+	/* Rx */
 	struct mlx5e_flow_steering *fs;
-	struct mlx5e_psp_rx *rx_fs;
+	struct mlx5_fc *rx_counter;
+	struct mlx5_fc *rx_auth_fail_counter;
+	struct mlx5_fc *rx_err_counter;
+	struct mlx5_fc *rx_bad_counter;
 
+	struct mlx5e_psp_rx_decrypt_table decrypt[ACCEL_FS_PSP_NUM_TYPES];
 	struct mlx5e_psp_rx_check_table check;
 	struct mlx5e_psp_rx_table rx;
 };
@@ -217,7 +214,7 @@ static int accel_psp_fs_rx_ft_create(struct mlx5e_psp_fs *fs,
 	dest[0].type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
 	dest[0].ft = mlx5_get_ttc_flow_table(ttc);
 	dest[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-	dest[1].counter = fs->rx_fs->rx_counter;
+	dest[1].counter = fs->rx_counter;
 	rule = mlx5_add_flow_rules(rx->ft, NULL, &flow_act, dest, 2);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
@@ -245,7 +242,7 @@ static int accel_psp_fs_rx_ft_create(struct mlx5e_psp_fs *fs,
 			 outer_headers.ip_version, version);
 		dest[0] = mlx5_ttc_get_default_dest(ttc, fs_psp2tt(i));
 		dest[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-		dest[1].counter = fs->rx_fs->rx_counter;
+		dest[1].counter = fs->rx_counter;
 		rule = mlx5_add_flow_rules(rx->ft, spec, &flow_act, dest,
 					   2);
 		if (IS_ERR(rule)) {
@@ -364,7 +361,7 @@ int accel_psp_fs_rx_check_ft_create(struct mlx5e_psp_fs *fs,
 	memset(spec, 0, sizeof(*spec));
 	accel_psp_setup_syndrome_match(spec, PSP_ICV_FAIL);
 	err = accel_psp_add_drop_rule(check->ft, spec,
-				      fs->rx_fs->rx_auth_fail_counter,
+				      fs->rx_auth_fail_counter,
 				      &check->auth_fail_rule);
 	if (err) {
 		mlx5_core_err(mdev,
@@ -376,8 +373,7 @@ int accel_psp_fs_rx_check_ft_create(struct mlx5e_psp_fs *fs,
 	/* add framing drop rule */
 	memset(spec, 0, sizeof(*spec));
 	accel_psp_setup_syndrome_match(spec, PSP_BAD_TRAILER);
-	err = accel_psp_add_drop_rule(check->ft, spec,
-				      fs->rx_fs->rx_err_counter,
+	err = accel_psp_add_drop_rule(check->ft, spec, fs->rx_err_counter,
 				      &check->err_rule);
 	if (err) {
 		mlx5_core_err(mdev,
@@ -388,8 +384,7 @@ int accel_psp_fs_rx_check_ft_create(struct mlx5e_psp_fs *fs,
 
 	/* add misc. errors drop rule */
 	memset(spec, 0, sizeof(*spec));
-	err = accel_psp_add_drop_rule(check->ft, spec,
-				      fs->rx_fs->rx_bad_counter,
+	err = accel_psp_add_drop_rule(check->ft, spec, fs->rx_bad_counter,
 				      &check->bad_rule);
 	if (err) {
 		mlx5_core_err(mdev,
@@ -528,46 +523,66 @@ accel_psp_fs_rx_decrypt_ft_create(struct mlx5e_psp_fs *fs,
 	return err;
 }
 
-static int accel_psp_fs_rx_destroy(struct mlx5e_psp_fs *fs,
-				   enum accel_fs_psp_type type)
+static void accel_psp_fs_rx_destroy(struct mlx5e_psp_fs *fs)
 {
-	struct mlx5e_psp_rx_decrypt_table *decrypt;
-	struct mlx5e_psp_rx *rx_fs = fs->rx_fs;
-
-	/* The netdev unreg already happened, so all offloaded rule are already removed */
-	decrypt = &rx_fs->decrypt[type];
-
-	accel_psp_fs_rx_decrypt_ft_destroy(fs, decrypt);
+	struct mlx5_ttc_table *ttc = mlx5e_fs_get_ttc(fs->fs, false);
+	int i;
 
-	return 0;
+	/* disconnect */
+	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
+		mlx5_ttc_fwd_default_dest(ttc, fs_psp2tt(i));
+		accel_psp_fs_rx_decrypt_ft_destroy(fs, &fs->decrypt[i]);
+	}
+	accel_psp_fs_rx_check_ft_destroy(&fs->check);
+	accel_psp_fs_rx_ft_destroy(&fs->rx);
 }
 
-static int accel_psp_fs_rx_create(struct mlx5e_psp_fs *fs, enum accel_fs_psp_type type)
+static int accel_psp_fs_rx_create(struct mlx5e_psp_fs *fs)
 {
 	struct mlx5_ttc_table *ttc = mlx5e_fs_get_ttc(fs->fs, false);
-	struct mlx5e_psp_rx_decrypt_table *decrypt;
-	struct mlx5e_psp_rx *rx_fs = fs->rx_fs;
-	struct mlx5_flow_destination dest = {};
+	int i, err;
+
+	err = accel_psp_fs_rx_ft_create(fs, &fs->rx);
+	if (err)
+		return err;
+
+	err = accel_psp_fs_rx_check_ft_create(fs, &fs->check);
+	if (err)
+		goto err_ft;
+
+	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
+		struct mlx5_flow_destination dest;
 
-	decrypt = &rx_fs->decrypt[type];
+		dest = mlx5_ttc_get_default_dest(ttc, fs_psp2tt(i));
+		err = accel_psp_fs_rx_decrypt_ft_create(fs, &fs->decrypt[i],
+							&dest);
+		if (err)
+			goto err_decrypt_ft;
+
+		dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
+		dest.ft = fs->decrypt[i].ft;
+		mlx5_ttc_fwd_dest(ttc, fs_psp2tt(i), &dest);
+	}
+
+	return 0;
 
-	dest = mlx5_ttc_get_default_dest(ttc, fs_psp2tt(type));
-	return accel_psp_fs_rx_decrypt_ft_create(fs, decrypt, &dest);
+err_decrypt_ft:
+	while (--i >= 0) {
+		mlx5_ttc_fwd_default_dest(ttc, fs_psp2tt(i));
+		accel_psp_fs_rx_decrypt_ft_destroy(fs, &fs->decrypt[i]);
+	}
+	accel_psp_fs_rx_check_ft_destroy(&fs->check);
+err_ft:
+	accel_psp_fs_rx_ft_destroy(&fs->rx);
+	return err;
 }
 
 static void accel_psp_fs_rx_cleanup(struct mlx5e_psp_fs *fs)
 {
-	struct mlx5e_psp_rx *rx_fs = fs->rx_fs;
-
-	if (!rx_fs)
-		return;
-
-	accel_psp_fs_destroy_counter(fs->mdev, &rx_fs->rx_bad_counter);
-	accel_psp_fs_destroy_counter(fs->mdev, &rx_fs->rx_err_counter);
-	accel_psp_fs_destroy_counter(fs->mdev, &rx_fs->rx_auth_fail_counter);
-	accel_psp_fs_destroy_counter(fs->mdev, &rx_fs->rx_counter);
-	kfree(rx_fs);
-	fs->rx_fs = NULL;
+	accel_psp_fs_destroy_counter(fs->mdev, &fs->rx_bad_counter);
+	accel_psp_fs_destroy_counter(fs->mdev, &fs->rx_err_counter);
+	accel_psp_fs_destroy_counter(fs->mdev, &fs->rx_auth_fail_counter);
+	accel_psp_fs_destroy_counter(fs->mdev, &fs->rx_counter);
 }
 
 static int accel_psp_fs_rx_init(struct mlx5e_psp_fs *fs)
@@ -575,11 +590,7 @@ static int accel_psp_fs_rx_init(struct mlx5e_psp_fs *fs)
 	struct mlx5_core_dev *mdev = fs->mdev;
 	int err;
 
-	fs->rx_fs = kzalloc_obj(*fs->rx_fs);
-	if (!fs->rx_fs)
-		return -ENOMEM;
-
-	err = accel_psp_fs_create_counter(mdev, &fs->rx_fs->rx_counter);
+	err = accel_psp_fs_create_counter(mdev, &fs->rx_counter);
 	if (err) {
 		mlx5_core_warn(mdev,
 			       "fail to create psp rx flow counter err=%d\n",
@@ -587,8 +598,7 @@ static int accel_psp_fs_rx_init(struct mlx5e_psp_fs *fs)
 		goto out_err;
 	}
 
-	err = accel_psp_fs_create_counter(mdev,
-					  &fs->rx_fs->rx_auth_fail_counter);
+	err = accel_psp_fs_create_counter(mdev, &fs->rx_auth_fail_counter);
 	if (err) {
 		mlx5_core_warn(mdev,
 			       "fail to create psp rx auth fail flow counter err=%d\n",
@@ -596,7 +606,7 @@ static int accel_psp_fs_rx_init(struct mlx5e_psp_fs *fs)
 		goto out_err;
 	}
 
-	err = accel_psp_fs_create_counter(mdev, &fs->rx_fs->rx_err_counter);
+	err = accel_psp_fs_create_counter(mdev, &fs->rx_err_counter);
 	if (err) {
 		mlx5_core_warn(mdev,
 			       "fail to create psp rx error flow counter err=%d\n",
@@ -604,7 +614,7 @@ static int accel_psp_fs_rx_init(struct mlx5e_psp_fs *fs)
 		goto out_err;
 	}
 
-	err = accel_psp_fs_create_counter(mdev, &fs->rx_fs->rx_bad_counter);
+	err = accel_psp_fs_create_counter(mdev, &fs->rx_bad_counter);
 	if (err) {
 		mlx5_core_warn(mdev,
 			       "fail to create psp rx bad flow counter err=%d\n",
@@ -621,84 +631,28 @@ static int accel_psp_fs_rx_init(struct mlx5e_psp_fs *fs)
 
 void mlx5_accel_psp_fs_cleanup_rx_tables(struct mlx5e_priv *priv)
 {
-	struct mlx5_ttc_table *ttc;
-	struct mlx5e_psp_fs *fs;
-	int i;
-
 	if (!priv->psp)
 		return;
 
-	fs = priv->psp->fs;
-	ttc = mlx5e_fs_get_ttc(fs->fs, false);
-	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
-		/* disconnect */
-		mlx5_ttc_fwd_default_dest(ttc, fs_psp2tt(i));
-
-		/* remove FT */
-		accel_psp_fs_rx_destroy(fs, i);
-	}
-	accel_psp_fs_rx_check_ft_destroy(&fs->check);
-	accel_psp_fs_rx_ft_destroy(&priv->psp->fs->rx);
+	accel_psp_fs_rx_destroy(priv->psp->fs);
 }
 
 int mlx5_accel_psp_fs_init_rx_tables(struct mlx5e_priv *priv)
 {
-	struct mlx5_ttc_table *ttc;
-	struct mlx5e_psp_fs *fs;
-	int err, i;
-
 	if (!priv->psp)
 		return 0;
 
-	fs = priv->psp->fs;
-	ttc = mlx5e_fs_get_ttc(fs->fs, false);
-
-	err = accel_psp_fs_rx_ft_create(fs, &fs->rx);
-	if (err)
-		return err;
-
-	err = accel_psp_fs_rx_check_ft_create(fs, &fs->check);
-	if (err)
-		goto err_ft;
-
-	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
-		struct mlx5e_psp_rx_decrypt_table *decrypt;
-		struct mlx5_flow_destination dest = {};
-
-		/* create FT */
-		err = accel_psp_fs_rx_create(fs, i);
-		if (err)
-			goto out_err;
-
-		/* connect */
-		dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
-		decrypt = &fs->rx_fs->decrypt[i];
-		dest.ft = decrypt->ft;
-		mlx5_ttc_fwd_dest(ttc, fs_psp2tt(i), &dest);
-	}
-
-	return 0;
-
-out_err:
-	while (--i >= 0) {
-		mlx5_ttc_fwd_default_dest(ttc, fs_psp2tt(i));
-		accel_psp_fs_rx_destroy(fs, i);
-	}
-	accel_psp_fs_rx_check_ft_destroy(&fs->check);
-err_ft:
-	accel_psp_fs_rx_ft_destroy(&fs->rx);
-
-	return err;
+	return accel_psp_fs_rx_create(priv->psp->fs);
 }
 
-static int accel_psp_fs_tx_ft_create(struct mlx5e_psp_fs *fs)
+static int accel_psp_fs_tx_ft_create(struct mlx5e_psp_fs *fs,
+				     struct mlx5e_psp_tx_table *tx)
 {
 	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
 	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_flow_destination dest = {};
 	struct mlx5_core_dev *mdev = fs->mdev;
 	struct mlx5_flow_act flow_act = {};
-	struct mlx5e_psp_tx_table *tx_fs;
 	u32 *in, *mc, *outer_headers_c;
 	struct mlx5_flow_handle *rule;
 	struct mlx5_flow_spec *spec;
@@ -720,8 +674,7 @@ static int accel_psp_fs_tx_ft_create(struct mlx5e_psp_fs *fs)
 	ft_attr.level = MLX5E_PSP_LEVEL;
 	ft_attr.autogroup.max_num_groups = 1;
 
-	tx_fs = fs->tx_fs;
-	ft = mlx5_create_flow_table(tx_fs->ns, &ft_attr);
+	ft = mlx5_create_flow_table(tx->ns, &ft_attr);
 	if (IS_ERR(ft)) {
 		err = PTR_ERR(ft);
 		mlx5_core_err(mdev, "PSP: fail to add psp tx flow table, err = %d\n", err);
@@ -747,7 +700,7 @@ static int accel_psp_fs_tx_ft_create(struct mlx5e_psp_fs *fs)
 			  MLX5_FLOW_CONTEXT_ACTION_CRYPTO_ENCRYPT |
 			  MLX5_FLOW_CONTEXT_ACTION_COUNT;
 	dest.type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-	dest.counter = tx_fs->tx_counter;
+	dest.counter = fs->tx_counter;
 	rule = mlx5_add_flow_rules(ft, spec, &flow_act, &dest, 1);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
@@ -755,9 +708,9 @@ static int accel_psp_fs_tx_ft_create(struct mlx5e_psp_fs *fs)
 		goto err_add_flow_rule;
 	}
 
-	tx_fs->ft = ft;
-	tx_fs->fg = fg;
-	tx_fs->rule = rule;
+	tx->ft = ft;
+	tx->fg = fg;
+	tx->rule = rule;
 	goto out;
 
 err_add_flow_rule:
@@ -770,50 +723,35 @@ static int accel_psp_fs_tx_ft_create(struct mlx5e_psp_fs *fs)
 	return err;
 }
 
-static void accel_psp_fs_tx_ft_destroy(struct mlx5e_psp_tx_table *tx_fs)
+static void accel_psp_fs_tx_ft_destroy(struct mlx5e_psp_tx_table *tx)
 {
-	accel_psp_fs_del_flow_rule(&tx_fs->rule);
-	accel_psp_fs_destroy_flow_group(&tx_fs->fg);
-	accel_psp_fs_destroy_ft(&tx_fs->ft);
+	accel_psp_fs_del_flow_rule(&tx->rule);
+	accel_psp_fs_destroy_flow_group(&tx->fg);
+	accel_psp_fs_destroy_ft(&tx->ft);
 }
 
 static void accel_psp_fs_tx_cleanup(struct mlx5e_psp_fs *fs)
 {
-	struct mlx5e_psp_tx_table *tx_fs = fs->tx_fs;
-
-	if (!tx_fs)
-		return;
-
-	accel_psp_fs_destroy_counter(fs->mdev, &tx_fs->tx_counter);
-	kfree(tx_fs);
-	fs->tx_fs = NULL;
+	accel_psp_fs_destroy_counter(fs->mdev, &fs->tx_counter);
 }
 
 static int accel_psp_fs_tx_init(struct mlx5e_psp_fs *fs)
 {
 	struct mlx5_core_dev *mdev = fs->mdev;
-	struct mlx5e_psp_tx_table *tx_fs;
-	struct mlx5_flow_namespace *ns;
 	int err;
 
-	ns = mlx5_get_flow_namespace(mdev, MLX5_FLOW_NAMESPACE_EGRESS_IPSEC);
-	if (!ns)
+	fs->tx.ns = mlx5_get_flow_namespace(mdev,
+					    MLX5_FLOW_NAMESPACE_EGRESS_IPSEC);
+	if (!fs->tx.ns)
 		return -EOPNOTSUPP;
 
-	tx_fs = kzalloc_obj(*tx_fs);
-	if (!tx_fs)
-		return -ENOMEM;
-
-	err = accel_psp_fs_create_counter(mdev, &tx_fs->tx_counter);
+	err = accel_psp_fs_create_counter(mdev, &fs->tx_counter);
 	if (err) {
 		mlx5_core_warn(mdev,
 			       "fail to create psp tx flow counter err=%d\n",
 			       err);
-		kfree(tx_fs);
 		return err;
 	}
-	tx_fs->ns = ns;
-	fs->tx_fs = tx_fs;
 	return 0;
 }
 
@@ -821,30 +759,29 @@ static void
 mlx5e_accel_psp_fs_get_stats_fill(struct mlx5e_priv *priv,
 				  struct mlx5e_psp_stats *stats)
 {
-	struct mlx5e_psp_tx_table *tx_fs = priv->psp->fs->tx_fs;
-	struct mlx5e_psp_rx *rx_fs = priv->psp->fs->rx_fs;
+	struct mlx5e_psp_fs *fs = priv->psp->fs;
 	struct mlx5_core_dev *mdev = priv->mdev;
 
-	if (tx_fs->tx_counter)
-		mlx5_fc_query(mdev, tx_fs->tx_counter, &stats->psp_tx_pkts,
+	if (fs->tx_counter)
+		mlx5_fc_query(mdev, fs->tx_counter, &stats->psp_tx_pkts,
 			      &stats->psp_tx_bytes);
 
-	if (rx_fs->rx_counter)
-		mlx5_fc_query(mdev, rx_fs->rx_counter, &stats->psp_rx_pkts,
+	if (fs->rx_counter)
+		mlx5_fc_query(mdev, fs->rx_counter, &stats->psp_rx_pkts,
 			      &stats->psp_rx_bytes);
 
-	if (rx_fs->rx_auth_fail_counter)
-		mlx5_fc_query(mdev, rx_fs->rx_auth_fail_counter,
+	if (fs->rx_auth_fail_counter)
+		mlx5_fc_query(mdev, fs->rx_auth_fail_counter,
 			      &stats->psp_rx_pkts_auth_fail,
 			      &stats->psp_rx_bytes_auth_fail);
 
-	if (rx_fs->rx_err_counter)
-		mlx5_fc_query(mdev, rx_fs->rx_err_counter,
+	if (fs->rx_err_counter)
+		mlx5_fc_query(mdev, fs->rx_err_counter,
 			      &stats->psp_rx_pkts_frame_err,
 			      &stats->psp_rx_bytes_frame_err);
 
-	if (rx_fs->rx_bad_counter)
-		mlx5_fc_query(mdev, rx_fs->rx_bad_counter,
+	if (fs->rx_bad_counter)
+		mlx5_fc_query(mdev, fs->rx_bad_counter,
 			      &stats->psp_rx_pkts_drop,
 			      &stats->psp_rx_bytes_drop);
 }
@@ -854,7 +791,7 @@ void mlx5_accel_psp_fs_cleanup_tx_tables(struct mlx5e_priv *priv)
 	if (!priv->psp)
 		return;
 
-	accel_psp_fs_tx_ft_destroy(priv->psp->fs->tx_fs);
+	accel_psp_fs_tx_ft_destroy(&priv->psp->fs->tx);
 }
 
 int mlx5_accel_psp_fs_init_tx_tables(struct mlx5e_priv *priv)
@@ -862,7 +799,7 @@ int mlx5_accel_psp_fs_init_tx_tables(struct mlx5e_priv *priv)
 	if (!priv->psp)
 		return 0;
 
-	return accel_psp_fs_tx_ft_create(priv->psp->fs);
+	return accel_psp_fs_tx_ft_create(priv->psp->fs, &priv->psp->fs->tx);
 }
 
 static void mlx5e_accel_psp_fs_cleanup(struct mlx5e_psp_fs *fs)
-- 
2.44.0


