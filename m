Return-Path: <linux-rdma+bounces-22832-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FKWmAhf8TGoNtAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22832-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:16:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9348571BC4B
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:16:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=awXAibWY;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22832-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22832-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65C6C30BD512
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 13:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540ED41A79E;
	Tue,  7 Jul 2026 13:12:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013011.outbound.protection.outlook.com [40.93.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81606416122;
	Tue,  7 Jul 2026 13:12:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429945; cv=fail; b=sMRWvVCcwX+Oy23mJeeWo2FydvUPVaCZVC5EMxKnRiUq7rTDVu41RUx07C5kKWctMtHdjgbCufN5QX5Nxh1Ezvqnv45lpTWhXzlRfNnc8RWprhURmMvqRgTQPWnm8px5GMFdl056DDoI4+E5DfWcDRJSyLWe8MRjUwz2Xgc0fdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429945; c=relaxed/simple;
	bh=QBYIekV/pepOYq8TmuuWEtmrMOyai/B2MmBlm3iTEo8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6tu2dkieUJgR0/3hNyIKaierId8g3Dr0EFJA8bTEgQpRlyw639TAPE4EtC0U3UEmaQme6wNHxdoI7jVVUNKGlQvq3/GdeI0eiXD7vLaTyb0jkRVzZRXPl8mvV6Bw+NfFcTNLK1l61QfClroOo41h/6P79ElTOy8QFfPE8fUozI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=awXAibWY; arc=fail smtp.client-ip=40.93.201.11
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJDEmLQj8pRhW3TDauyBHu3zdfboFKjN/wgkmZp7+OmhWiYAzfB+H2JMNPNQrfoyOEXxx/IppBsOvQyrTULoS5kgHHIEXKJsbQoBxUIVE9/fNA6wCGvsVTuoINWa5DRcBEa190jq+RYWMO+gPD0o3/B+UK/Ud2CQfYc0GppdEhYkHqmg8GF7ViT/y2Fb2niMXtn0jxoiF+yA1I+V/mtgIbfOaQuYOiyhyAaqJhp7ILVRKn13lEr+PPb5XbaIrzr96O6RuW01bGuXBdZILWr6Z3QGXSpyUVfloxnSma6ezQWEaTDqdqhUG4EbP3rUzzCvsND9Rb4EIDODdklJv8HsUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6jMChCpw0PShbOf80ByhkJwLo6E5R8UVQwhW1yH6b0=;
 b=EGATKqoM20THNbOusIKmteyT0q1SjgCXEUmVQBlPxzjuxYYUwpvrFwiO8LQ4hVcQ+LKF0bMbZi3z3XZ1nyMyhFLmtmNzI0tRU/a+NM003IvTbhzXCZYywAEd17NNJwazlSIdOjWiD06BOhWKLUql/zha1l/jRl7dwDWI2j0XOlPaHRskM94QsgrLcmP8YDl94cVn6goabvvuEc1tOZYu3ExqBjhrDj19pxzWW37LSSLEXtYmxf/lhF1/CGVA5naPzZjfJIfOiMNRU5eegvJzgFcbQUKiDmLEFkU8CScDbNMRkKkp4l91T4iSRQb2HobMLX/4nk9ArZEamSxO9U112g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6jMChCpw0PShbOf80ByhkJwLo6E5R8UVQwhW1yH6b0=;
 b=awXAibWYv5S7IaE0kO993jp/IrZ8QGAyCOaNHq5J5p53kmGxd2aVG7IQROx5bRarcCodYArLoIuGeAjkjDzMdm0+4GnKFH7hOJRkTA6bnMPf2tcdd3ONMbH+g/nLltHjI25CBBdGAENGJKvbKQjbn92l/OXQwwiAYoJA32JJd+ZTu8AVoj5hSHyxpipRF0fb3NsxYnnmco5THr6gWVl6VHNRibOB1iqhqj4a4GiLYRALO/CdF9Emme/UMay0wpK1rLQcMb5NMGgLmvCY6mbjAMZ96rmbXboG8uF01MDf+7WvQxOgIjF+CdvaU7fUCRTcWrrEq5xlt+33q+0O15a7vg==
Received: from BN9PR03CA0896.namprd03.prod.outlook.com (2603:10b6:408:13c::31)
 by DS3PR12MB999239.namprd12.prod.outlook.com (2603:10b6:8:38c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 13:12:15 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::20) by BN9PR03CA0896.outlook.office365.com
 (2603:10b6:408:13c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 13:12:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 13:12:14 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:11:37 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:11:37 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Jul
 2026 06:11:30 -0700
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
Subject: [PATCH net-next 13/15] net/mlx5e: psp: Make PSP steering config dynamic
Date: Tue, 7 Jul 2026 16:08:56 +0300
Message-ID: <20260707130858.969928-14-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|DS3PR12MB999239:EE_
X-MS-Office365-Filtering-Correlation-Id: fa1c36f6-1d3c-40b6-9928-08dedc295d2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|1800799024|23010399003|82310400026|376014|56012099006|5023799004|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	qgl9FRdzlswZZGAL0OyaixyfL6FW5rLEhvzD2Qs8JYwkqtG10+rlrTZgNNnc0dcIh/c6BkBpvEXXvCgkKcUHdKJhL99MuJOdu8nnc2/HiESMU9AonSM6irJSZnxBh2K9iS3FPTDhzrkB8Ec6BFBmSMORp539avXfrZ2CmBQVcllsJWp1TNsG4ypAJ1STazBhHvRU7NOu6usQl9CZILQHyk1aPiY3c0jTa8MSayRNwUvNFjvG9m3f7D9xeEEObiJ6JSIJPUVMKP149bs5ZVZ/cfe/kLN57ogfdTtxhsv7u8l3nTS+a2G76YqBsWlJ5PwqRE3360f0AWvE6++2CZrRcZeV1t0u8rXay0tjWwkcqglzW9lYAsXI1RsI5XFq0pUdG2gu8XNPII6W5k5cqIWQo+tiooj+Z3VsvdjXGA2nI0/qLiJ2mdyunjMZABsIq2dwcCnIuk4up5X833F+Y6bav6EQFo+Sfs1jAhGPB3ZDog8pdOzhuajzlUQ+x1Dyi0D4vq/mCV9d3osPVv5RryA53OpUd4XNcodS5tigloC8aESYY/MInq/pBPmmEhwxm3/0ehkuLO7fEKvrli4AR3Ny3AwxjEL5fJ8F1ltbhYJEPJodVtLK/eAp7aW0qnVPOyzekynhsO1ZctCyINhjB+MeDReo6Tt0gAr1vbNGaAKe3i2JM439/C1SrsnEjk662+AdgMqtRd7iptjCDikfoyNITA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	13S1yZ9W/6c/Lg0Si9dwOhLig1zx/+lw7E2mNYVUHNL1vx9PFB4BhxXwFKfseFY0lcNgeVd+IA3NtcWelLiQFDnIpH7R7gq50Ygl2MhjRPYxYCCN9GAFgUNNGUsC754+/1W9grgK8DGlok3sAZnUZWxme6lVyUfE05/xkGm9SMOF2P17dV8wHgi87lHw2t9g8MD908r1yTPaPPLc4ViOErywkSLHOEPjMO0CAsShj8KBeW5UBowdCPaogxzIDd3wOck8xN0ebV4QKfCCA7Q+HZo5B7atGHxkGMeo2+P5Te+u5spuvF9PYZ4yvFTgRxwWM40vzyvnYYAzOFeX7+iu8tEI8KEP9MQhShquoRr71EhL20a1DQUOdJlzgjf1JIWqXd6hIGmblegPf7nQX7yyQv0788NK1yCKcTC0GPFrO3z4pNWTix/7A4CwusNbpwj2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:12:14.6714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1c36f6-1d3c-40b6-9928-08dedc295d2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999239
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
	TAGGED_FROM(0.00)[bounces-22832-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9348571BC4B

From: Cosmin Ratiu <cratiu@nvidia.com>

Only create PSP steering tables when PSP configuration is enabled on a
PSP device.

Previously, mlx5e_psp_set_config (== .set_config on the PSP device) did
nothing. Steering was created and hooked up to incoming traffic at
device initialization time, via mlx5e_init_nic_rx -> mlx5e_accel_init_rx
-> mlx5_accel_psp_fs_init_rx_tables. Similarly, TX tables were created
and hooked to egress traffic at mlx5e_init_nic_tx -> mlx5e_accel_init_tx
-> mlx5_accel_psp_fs_init_tx_tables

Doing this means both ingress and egress UDP packets go through the
PSP steering tables, causing extra latency and overhead.
A better solution is to let the incoming encrypted PSP packets get
dropped by SW and not impose an overhead on all UDP packets which have
to traverse the PSP steering rules when PSP isn't used.

Additionally, upcoming changes to support HW-GRO need to reconfigure PSP
steering dynamically and this patch is a necessary step in that
direction.

Two new functions are defined:
- accel_psp_fs_create: Creates steering tables and connects RX UDP v4/v6
  traffic to PSP RX tables.
- accel_psp_fs_destroy: Disconnects incoming RX traffic from PSP
  steering and destroys steering tables.

PSP steering cleanup, which happens independently from PSP device
configuration, is unchanged. When the device is going away, steering
tables are destroyed as well.

The netdev lock is now used for proper synchronization between the new
set_config flow and device steering init/cleanup. This will be important
in future patches, when PSP will be able to reconfigure itself
dynamically upon netdev feature changes.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/en_accel.h    | 19 +----
 .../mellanox/mlx5/core/en_accel/psp.c         | 73 +++++++++++++------
 .../mellanox/mlx5/core/en_accel/psp.h         | 12 ---
 3 files changed, 53 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
index b526b3898c22..3f212e46fc2f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
@@ -220,18 +220,7 @@ static inline void mlx5e_accel_tx_finish(struct mlx5e_txqsq *sq,
 
 static inline int mlx5e_accel_init_rx(struct mlx5e_priv *priv)
 {
-	int err;
-
-	err = mlx5_accel_psp_fs_init_rx_tables(priv);
-	if (err)
-		goto out;
-
-	err = mlx5e_ktls_init_rx(priv);
-	if (err)
-		mlx5_accel_psp_fs_cleanup_rx_tables(priv);
-
-out:
-	return err;
+	return mlx5e_ktls_init_rx(priv);
 }
 
 static inline void mlx5e_accel_cleanup_rx(struct mlx5e_priv *priv)
@@ -242,12 +231,6 @@ static inline void mlx5e_accel_cleanup_rx(struct mlx5e_priv *priv)
 
 static inline int mlx5e_accel_init_tx(struct mlx5e_priv *priv)
 {
-	int err;
-
-	err = mlx5_accel_psp_fs_init_tx_tables(priv);
-	if (err)
-		return err;
-
 	return mlx5e_ktls_init_tx(priv);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index b713f235a0f7..b3521c3861f6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -537,18 +537,24 @@ static void accel_psp_fs_rx_destroy(struct mlx5e_psp_fs *fs)
 	accel_psp_fs_rx_ft_destroy(&fs->rx);
 }
 
-static int accel_psp_fs_rx_create(struct mlx5e_psp_fs *fs)
+static int accel_psp_fs_rx_create(struct mlx5e_psp_fs *fs,
+				  struct netlink_ext_ack *extack)
 {
 	struct mlx5_ttc_table *ttc = mlx5e_fs_get_ttc(fs->fs, false);
 	int i, err;
 
 	err = accel_psp_fs_rx_ft_create(fs, &fs->rx);
-	if (err)
+	if (err) {
+		NL_SET_ERR_MSG(extack, "Failed creating RX steering table");
 		return err;
+	}
 
 	err = accel_psp_fs_rx_check_ft_create(fs, &fs->check);
-	if (err)
+	if (err) {
+		NL_SET_ERR_MSG(extack,
+			       "Failed creating RX check steering table");
 		goto err_ft;
+	}
 
 	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
 		struct mlx5_flow_destination dest;
@@ -556,8 +562,11 @@ static int accel_psp_fs_rx_create(struct mlx5e_psp_fs *fs)
 		dest = mlx5_ttc_get_default_dest(ttc, fs_psp2tt(i));
 		err = accel_psp_fs_rx_decrypt_ft_create(fs, &fs->decrypt[i],
 							&dest);
-		if (err)
+		if (err) {
+			NL_SET_ERR_MSG(extack,
+				       "Failed creating RX decrypt steering table");
 			goto err_decrypt_ft;
+		}
 
 		dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
 		dest.ft = fs->decrypt[i].ft;
@@ -634,15 +643,9 @@ void mlx5_accel_psp_fs_cleanup_rx_tables(struct mlx5e_priv *priv)
 	if (!priv->psp)
 		return;
 
+	netdev_lock(priv->netdev);
 	accel_psp_fs_rx_destroy(priv->psp->fs);
-}
-
-int mlx5_accel_psp_fs_init_rx_tables(struct mlx5e_priv *priv)
-{
-	if (!priv->psp)
-		return 0;
-
-	return accel_psp_fs_rx_create(priv->psp->fs);
+	netdev_unlock(priv->netdev);
 }
 
 static int accel_psp_fs_tx_ft_create(struct mlx5e_psp_fs *fs,
@@ -791,15 +794,9 @@ void mlx5_accel_psp_fs_cleanup_tx_tables(struct mlx5e_priv *priv)
 	if (!priv->psp)
 		return;
 
+	netdev_lock(priv->netdev);
 	accel_psp_fs_tx_ft_destroy(&priv->psp->fs->tx);
-}
-
-int mlx5_accel_psp_fs_init_tx_tables(struct mlx5e_priv *priv)
-{
-	if (!priv->psp)
-		return 0;
-
-	return accel_psp_fs_tx_ft_create(priv->psp->fs, &priv->psp->fs->tx);
+	netdev_unlock(priv->netdev);
 }
 
 static void mlx5e_accel_psp_fs_cleanup(struct mlx5e_psp_fs *fs)
@@ -837,11 +834,45 @@ static struct mlx5e_psp_fs *mlx5e_accel_psp_fs_init(struct mlx5e_priv *priv)
 	return ERR_PTR(err);
 }
 
+static int accel_psp_fs_create(struct mlx5e_priv *priv,
+			       struct netlink_ext_ack *extack)
+{
+	int err;
+
+	err = accel_psp_fs_rx_create(priv->psp->fs, extack);
+	if (err)
+		return err;
+
+	err = accel_psp_fs_tx_ft_create(priv->psp->fs, &priv->psp->fs->tx);
+	if (err) {
+		NL_SET_ERR_MSG(extack, "Failed creating TX steering table");
+		accel_psp_fs_rx_destroy(priv->psp->fs);
+	}
+	return err;
+}
+
+static void accel_psp_fs_destroy(struct mlx5e_priv *priv)
+{
+	accel_psp_fs_tx_ft_destroy(&priv->psp->fs->tx);
+	accel_psp_fs_rx_destroy(priv->psp->fs);
+}
+
 static int
 mlx5e_psp_set_config(struct psp_dev *psd, struct psp_dev_config *conf,
 		     struct netlink_ext_ack *extack)
 {
-	return 0; /* TODO: this should actually do things to the device */
+	struct mlx5e_priv *priv = netdev_priv(psd->main_netdev);
+	bool psp_enabled = psd->config.versions;
+	bool enable_psp = conf->versions;
+	int err = 0;
+
+	netdev_lock(priv->netdev);
+	if (!psp_enabled && enable_psp)
+		err = accel_psp_fs_create(priv, extack);
+	else if (psp_enabled && !enable_psp)
+		accel_psp_fs_destroy(priv);
+	netdev_unlock(priv->netdev);
+	return err;
 }
 
 static int
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
index a53f90f7c341..57fffcf4a62c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
@@ -43,26 +43,14 @@ static inline bool mlx5_is_psp_device(struct mlx5_core_dev *mdev)
 	return true;
 }
 
-int mlx5_accel_psp_fs_init_rx_tables(struct mlx5e_priv *priv);
 void mlx5_accel_psp_fs_cleanup_rx_tables(struct mlx5e_priv *priv);
-int mlx5_accel_psp_fs_init_tx_tables(struct mlx5e_priv *priv);
 void mlx5_accel_psp_fs_cleanup_tx_tables(struct mlx5e_priv *priv);
 void mlx5e_psp_register(struct mlx5e_priv *priv);
 void mlx5e_psp_unregister(struct mlx5e_priv *priv);
 int mlx5e_psp_init(struct mlx5e_priv *priv);
 void mlx5e_psp_cleanup(struct mlx5e_priv *priv);
 #else
-static inline int mlx5_accel_psp_fs_init_rx_tables(struct mlx5e_priv *priv)
-{
-	return 0;
-}
-
 static inline void mlx5_accel_psp_fs_cleanup_rx_tables(struct mlx5e_priv *priv) { }
-static inline int mlx5_accel_psp_fs_init_tx_tables(struct mlx5e_priv *priv)
-{
-	return 0;
-}
-
 static inline void mlx5_accel_psp_fs_cleanup_tx_tables(struct mlx5e_priv *priv) { }
 static inline bool mlx5_is_psp_device(struct mlx5_core_dev *mdev)
 {
-- 
2.44.0


