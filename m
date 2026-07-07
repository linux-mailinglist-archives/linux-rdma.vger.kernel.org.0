Return-Path: <linux-rdma+bounces-22826-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ha74AlD8TGoltAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22826-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:17:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DD271BC87
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:17:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="Ec/V/Wk3";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22826-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22826-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6765630B0CFB
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 13:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5229C416132;
	Tue,  7 Jul 2026 13:11:27 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25BA414DD0;
	Tue,  7 Jul 2026 13:11:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429887; cv=fail; b=bx9vpWrvFSQzgtKUfx+zz9PfnHL9sHqj8TPT9MRPxR7+Ae6xa7s/u/IYsAadl8nwhDJFZfc9JdvFJOHn3kko3BO1MFm+LimAaeSvmOIQ1nb8ZKcEFajftUxlcw+oqZug2oaNTIcljUkoQmtvXS2g3GjgAKRDmTSBjcA7ulxMmvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429887; c=relaxed/simple;
	bh=UEiUQl8jYFb40YTI5Uywvkj4oHtOxXPeLMy8vhm8F90=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YcepIc6gQsa8H/MCSESF36lHKtVcMyUOajDkOnxHm9wQsszJKRiGDHgVODK5XXOamTn7pxS7g83Zy7BMYkbLJYRvVDQExwduibYv8w705FkEXEfiHF6Y6dlsEhzt821NleOv7YGkwXpNT3y7JUUwkpb63Ga7urOz8qtFCMA3GhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ec/V/Wk3; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICWURQpTHvDEGYjWYYifVNy0Vn0dd5OFJehKVtJeBpo9UH30DB/4nj8XhIkXsG9/ad+Jl6FbWIWDpV3bIhk9Eo+uk6i2/kP4xET3j7w0DpqkW6bUGk5i3ZjyGEKPHJA9+iz03PamREwLdJkzX/S4dvbYpjAZsQFAq7CDxnInc0ZITDLAUNODayhrs41fu0z4dSEbFFFH4niZwaOK6meUKndfEh8AzEbkYBMvSa5iVY7ZUCcqltv5Akv5JR4HdwiXNak6TWrbnN8HXpuWLkssmF7OyXfDZ9C/EP/JEFazos+vtB2kYn7+OAXXxW5+kAl/ipw27baUMbETdPm4dHJuhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrn0TmnRpJ1swbwnngILHQMZZvKrRgZ826qGwtgEYqk=;
 b=sd8jO/iqZZDRa2NNjKkiVvRWPAQ995JmgrHyvqAuE9cKS7C5j27HrSAJFSj6g0McQnrQarDGgvm8IF5qRQBUSkXg17v7RJo9iJGU39YN1gBj50LfH9UfAB32Nqxeyfm4gfFct+TURLHYm70s9CHFFOtkXjzjkknFX9hVY89Up6BiIb7ymZmvha5k8R/iamQsIeOt55XjO/wsCjMGXW2QVveOe1EKdLLgh2GxvT0KIqzyoH06N0WN8GZEP/QXyqD7gaASycl66XvstLjwjXgsJis0+2z5zRgvfw6Y9QQ0w4P3L3V/5zBOrWa9eqP3BD9zyRY0/+l79QlLTM/su/xoHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrn0TmnRpJ1swbwnngILHQMZZvKrRgZ826qGwtgEYqk=;
 b=Ec/V/Wk3M57FZXblhlKQqnTGLoBPeTzzXgZKwv6534rBpwQUhjvvnTofPcsUKyskm7ALrAq1h/+MwIMFpgb1WKMus6/ovNmyXpG7RJJAPFlShOoqmfMqCQHqRpWcBJv7lgF11V8A5rOjB/F8gcaf4/Efi/Ym/VN2ZKV+AgFbh2SVJGfVR7u/SV5w/BTxu+NuDh3ZSK3q8Ano8th/FjJjGv41NLarQ+v0Evnih/wSntR4r7mex4Web4wsC1CaukuBb8qC1I2yQdGXCJeBKQ3Bp+e9OUjDYtDy8hak7KgolCtwg8NGrbIasXAgSSNCtslaPW4nWH50nCZamaiQmI3HoA==
Received: from BL1PR13CA0073.namprd13.prod.outlook.com (2603:10b6:208:2b8::18)
 by CH3PR12MB9024.namprd12.prod.outlook.com (2603:10b6:610:176::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 13:11:17 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::2d) by BL1PR13CA0073.outlook.office365.com
 (2603:10b6:208:2b8::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 13:11:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 13:11:16 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:10:55 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:10:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Jul
 2026 06:10:48 -0700
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
Subject: [PATCH net-next 07/15] net/mlx5e: psp: Remove unused PSP syndrome copy action
Date: Tue, 7 Jul 2026 16:08:50 +0300
Message-ID: <20260707130858.969928-8-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|CH3PR12MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: b9afcec6-2181-44d9-b2a0-08dedc293a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|82310400026|36860700016|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	SHAQrXYOmrZBVAyFb7q0Ir0X3CcWlKTcAKO+0nZS16E1sKNZgjIS8y7E2ozKDjr+UOOWXqiUNldG54I0d3xATpElIAjANUsLZZrbEFToNtzfkhdIqKh5qMnC9Kl9caHLFna7lTQZSA9g8AO9CnPH8OueRiz/CgGu8lrcvXq194KV8kkJCfpwgDuwt5cqzP3FEV7alDoF9WKtbokYoCJBMLSQHYf7JwedU6NnzlTlOu5UZo/sVX6fIbyv4SFD82xRnzMHirRJbPjFx2BKP8x4FULh7Ss0Y5AAjC2pFvIiim124e60UsbX6mLIggifvmHYuZ9ttOdPKXlvdC7Aek5R3qY9NHn+fVakeRwLBlGzxBCT5K4VPX6h0CxUiuJR5wPENHbP2wa40ITLH3RHWODSW2GiCrw+ZejusP82imnyNdFMROOiVYVRQE/rj7AYwqlNRSavCIt3Z0Z3NsY6WjUmbxu7aNehjhBowmAhSeUvBC72YwOyn/vnHZwR8FP28j9TIftMSP9ww0WXICvvd7K8PKdlx8lzzXeDGvMtmrrAjru/Z+bMAp+Gx9oBM3aKThNGq9UGwPW43RQOLfyf9HNa5/EpvGLNxoJcXsDYNdguEwMQVp/eUsrsNitVIGaABTuCGvErISiHR5/0Vc3mzzR/anZDlvgM7GO88stOIJzwNoZoHB6ENTV9a1O4oQ1JgHf8ms0hHR715/cM21KgJnH/0Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(18002099003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SYDynlDxPk1Fta19zEy2ftxaqkZxOd2ptRv+mfyege4Kms9jv8B8O96X5/6GIVBArJeR0O0OdKDINHfdxPKRRJ1IrYWVbvxYcnUZ8pXC+hjsv/l2q4ZsEdDIPdEEsWKPSCgMx3nbjhBkP1pZiOtowZBzc7BLAwVIeUhvSQeaYw7Mo1U5m0xR/nOi/0fSOh4HwxCblGRal5m2MrwZJH0WUR7wQ3m4dq0jn/vgatfOdx7i1247v6iZ0QG9vUYh1l0zFu4pXGVM8llmuy8qE+s+RTr9kW0pKYA6VE9yjUleXZVF9Pzq2tqSe/zZsyB5A5Wr0ygD0Bjs9hDS9VQQPt/1b8npvDu9x14pzfEfrwGRe2tZTnglquS3bwiQRL2MfuJG5FTg2g94D8E0yHI4KxKlY/zYXQy/SiaSumsadffJzqSTLiATqyigmrVKgEajrw31
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:11:16.3229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9afcec6-2181-44d9-b2a0-08dedc293a6c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9024
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:aleksandr.loktionov@intel.com,m:borisp@nvidia.com,m:cmi@nvidia.com,m:cratiu@nvidia.com,m:daniel.zahka@gmail.com,m:dtatulea@nvidia.com,m:gal@nvidia.com,m:jacob.e.keller@intel.com,m:jianbol@nvidia.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:raeds@nvidia.com,m:rrameshbabu@nvidia.com,m:saeedm@nvidia.com,m:sdf@fomichev.me,m:sdf.kernel@gmail.com,m:tariqt@nvidia.com,m:willemdebruijn.kernel@gmail.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:sdfkernel@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22826-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0DD271BC87

From: Cosmin Ratiu <cratiu@nvidia.com>

The PSP error flow table copies the HW syndrome to metadata register B,
but this value is never used in the RX path. Bad packets (auth fail,
bad trailer) are dropped by HW via explicit drop rules before reaching
software.

Remove the syndrome copy action, the syndrome macro, and the dead
syndrome check in the RX handler.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/psp.c         | 30 +------------------
 .../mellanox/mlx5/core/en_accel/psp_rxtx.c    | 11 -------
 .../mellanox/mlx5/core/en_accel/psp_rxtx.h    |  3 +-
 3 files changed, 2 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index bdf97e373b42..534dba678761 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -35,7 +35,6 @@ struct mlx5e_psp_rx_err {
 	struct mlx5_flow_handle *auth_fail_rule;
 	struct mlx5_flow_handle *err_rule;
 	struct mlx5_flow_handle *bad_rule;
-	struct mlx5_modify_hdr *copy_modify_hdr;
 };
 
 struct mlx5e_accel_fs_psp_prot {
@@ -165,10 +164,6 @@ static void accel_psp_fs_rx_err_destroy_ft(struct mlx5e_psp_fs *fs,
 	accel_psp_fs_del_flow_rule(&rx_err->err_rule);
 	accel_psp_fs_del_flow_rule(&rx_err->auth_fail_rule);
 	accel_psp_fs_del_flow_rule(&rx_err->rule);
-	if (rx_err->copy_modify_hdr) {
-		mlx5_modify_header_dealloc(fs->mdev, rx_err->copy_modify_hdr);
-		rx_err->copy_modify_hdr = NULL;
-	}
 	accel_psp_fs_destroy_ft(&rx_err->ft);
 }
 
@@ -210,12 +205,10 @@ int accel_psp_fs_rx_err_create_ft(struct mlx5e_psp_fs *fs,
 				  struct mlx5e_accel_fs_psp_prot *fs_prot,
 				  struct mlx5e_psp_rx_err *rx_err)
 {
-	u8 action[MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto)] = {};
 	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_core_dev *mdev = fs->mdev;
 	struct mlx5_flow_destination dest[2];
 	struct mlx5_flow_act flow_act = {};
-	struct mlx5_modify_hdr *modify_hdr;
 	struct mlx5_flow_handle *fte;
 	struct mlx5_flow_spec *spec;
 	int err = 0;
@@ -235,30 +228,10 @@ int accel_psp_fs_rx_err_create_ft(struct mlx5e_psp_fs *fs,
 		goto out_err;
 	}
 
-	/* Action to copy 7 bit psp_syndrome to regB[23:29] */
-	MLX5_SET(copy_action_in, action, action_type, MLX5_ACTION_TYPE_COPY);
-	MLX5_SET(copy_action_in, action, src_field, MLX5_ACTION_IN_FIELD_PSP_SYNDROME);
-	MLX5_SET(copy_action_in, action, src_offset, 0);
-	MLX5_SET(copy_action_in, action, length, 7);
-	MLX5_SET(copy_action_in, action, dst_field, MLX5_ACTION_IN_FIELD_METADATA_REG_B);
-	MLX5_SET(copy_action_in, action, dst_offset, 23);
-
-	modify_hdr = mlx5_modify_header_alloc(mdev, MLX5_FLOW_NAMESPACE_KERNEL,
-					      1, action);
-	if (IS_ERR(modify_hdr)) {
-		err = PTR_ERR(modify_hdr);
-		mlx5_core_err(mdev,
-			      "fail to alloc psp copy modify_header_id err=%d\n", err);
-		goto out_err;
-	}
-	rx_err->copy_modify_hdr = modify_hdr;
-
 	accel_psp_setup_syndrome_match(spec, PSP_OK);
 	/* create fte */
-	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_MOD_HDR |
-			  MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
 			  MLX5_FLOW_CONTEXT_ACTION_COUNT;
-	flow_act.modify_hdr = modify_hdr;
 	dest[0].type = fs_prot->default_dest.type;
 	dest[0].ft = fs_prot->default_dest.ft;
 	dest[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
@@ -389,7 +362,6 @@ static int accel_psp_fs_rx_create_ft(struct mlx5e_psp_fs *fs,
 	setup_fte_udp_psp(spec, PSP_DEFAULT_UDP_PORT);
 	flow_act.crypto.type = MLX5_FLOW_CONTEXT_ENCRYPT_DECRYPT_TYPE_PSP;
 	/* Set bit[31, 30] PSP marker */
-	/* Set bit[29-23] psp_syndrome is set in error FT */
 #define MLX5E_PSP_MARKER_BIT (BIT(30) | BIT(31))
 	MLX5_SET(set_action_in, action, action_type, MLX5_ACTION_TYPE_SET);
 	MLX5_SET(set_action_in, action, field, MLX5_ACTION_IN_FIELD_METADATA_REG_B);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
index c2f9899d23a5..348fd7a96261 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
@@ -14,12 +14,6 @@
 #include "en_accel/psp_rxtx.h"
 #include "en_accel/psp.h"
 
-enum {
-	MLX5E_PSP_OFFLOAD_RX_SYNDROME_DECRYPTED,
-	MLX5E_PSP_OFFLOAD_RX_SYNDROME_AUTH_FAILED,
-	MLX5E_PSP_OFFLOAD_RX_SYNDROME_BAD_TRAILER,
-};
-
 static void mlx5e_psp_set_swp(struct sk_buff *skb,
 			      struct mlx5e_accel_tx_psp_state *psp_st,
 			      struct mlx5_wqe_eth_seg *eseg)
@@ -122,16 +116,11 @@ static bool mlx5e_psp_set_state(struct mlx5e_priv *priv,
 bool mlx5e_psp_offload_handle_rx_skb(struct net_device *netdev, struct sk_buff *skb,
 				     struct mlx5_cqe64 *cqe)
 {
-	u32 psp_meta_data = be32_to_cpu(cqe->ft_metadata);
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	u16 dev_id = priv->psp->psd->id;
 	bool strip_icv = true;
 	u8 generation = 0;
 
-	/* TBD: report errors as SW counters to ethtool, any further handling ? */
-	if (MLX5_PSP_METADATA_SYNDROME(psp_meta_data) != MLX5E_PSP_OFFLOAD_RX_SYNDROME_DECRYPTED)
-		goto drop;
-
 	if (psp_dev_rcv(skb, dev_id, generation, strip_icv))
 		goto drop;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.h
index 70289c921bd6..2b080c39cc37 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.h
@@ -10,9 +10,8 @@
 #include "en.h"
 #include "en/txrx.h"
 
-/* Bit30: PSP marker, Bit29-23: PSP syndrome, Bit22-0: PSP obj id */
+/* Bit30: PSP marker, Bit22-0: PSP obj id */
 #define MLX5_PSP_METADATA_MARKER(metadata)  ((((metadata) >> 30) & 0x3) == 0x3)
-#define MLX5_PSP_METADATA_SYNDROME(metadata) (((metadata) >> 23) & GENMASK(6, 0))
 #define MLX5_PSP_METADATA_HANDLE(metadata)  ((metadata) & GENMASK(22, 0))
 
 struct mlx5e_accel_tx_psp_state {
-- 
2.44.0


