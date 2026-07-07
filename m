Return-Path: <linux-rdma+bounces-22822-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id McrTMB/7TGrQswEAu9opvQ
	(envelope-from <linux-rdma+bounces-22822-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:11:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 997F271BB85
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:11:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="r381ElQ/";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22822-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22822-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B18293019FF8
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 13:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED269417375;
	Tue,  7 Jul 2026 13:10:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010034.outbound.protection.outlook.com [40.93.198.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FC6416132;
	Tue,  7 Jul 2026 13:10:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429856; cv=fail; b=NwLNewiPODv7OBiH9ygRO0uGYLz1hc3wXwjipwC/ddlSHhjE1qmsnev6zGl25ZRFlafyh7KZBdlvt195sWAfmmR2YO2ifU9WFWbUESGMMhrNvQiCVVkAqkUWKLrlWGsjqNAI16oZH4oIPTfkpL9w/X3csotGbVqQ8bUFn40im3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429856; c=relaxed/simple;
	bh=ieSKJFBhBDBAiMMWa8H6HvDmg0wROlfkYgH7GUsvb6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jiinHDlOaq4wyAmduDAYY9MYh3zUeTykPUAD8rL63IPXQBVUHCTm+yBU/wTcgy5Ez86szBEgp6MqdGjaoibUmgp61GiBLmRLA9ET+c87A2B51ONRVZO4REmegrLTWL3BkP/vaIb9IgX5YewQWN3c+42A+ME5FjQ7mbSzqvgRatE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r381ElQ/; arc=fail smtp.client-ip=40.93.198.34
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHRu79P1QSVaLWrCNuUy7+p1dFfVDLlmTTqGxuse5BsO36av18+qK4hoVgw2dywxyOm0mL4ubnRsS57FoZREKHcIY9zQIch01PXpWkeB/EW6cZU05jlhUC4wO9tZoobRHvIPAEvuAkQhSOFg8VIuZg0/AkhE8E5paYyp7X3zDf6I5z2NL5gwRY3TAZXdDUYDe/x7UsExlr8L5OgWNbiyhMeagXJf/CkIGgUhXsDUJcSrVA1XMkTZHFqS3ChINlOa8WyXRe9MSOynQ1MobKlMVpRC1wBYVW1JOMLReHESCCiIAXDCae3H83RM8U+wV8ll9D/ca14SmA3UIMvOZr8yYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8Eg+UkJetZdgCsm9smHLDds6qbXOiWtCQrhxKaJsyQ=;
 b=V34c89+Q7T8VkGSvFWutM8cjOZ8V2Unn/KgGhXIxbfZ1dY7GZVJbRuQT1cyaEk/EoTBLh5gNwOrYkr6c13uzGV0tnFrr3ptkQj2UeFTYjMztGFp8+Tluggi3jlq5Z2Mn4dttObo25aZ+0SgxnQANmNaZ3n2jrQSu7wgq4lF5gEExPBaIbbwpoHhsIkxcOrFXIu1w5Mmv/DoiVvmMg91b0RYBpHhSLjY9d4V0qSuUlxunJBm5zoh3arnpHwvkGLDkOdOTZzTTzxZUkJCWhB4dFMfs1mj45UKsvdxNX5BsJdPyOwawgdXjm7XaUWo1AKstfiYCf4ysuP6rq9S6eqzP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8Eg+UkJetZdgCsm9smHLDds6qbXOiWtCQrhxKaJsyQ=;
 b=r381ElQ/C+sD35FrstqbeH5iiyAKIIE7bTp62mgZLYnwgnBxLBkiFhejaHbTLm8paTdzw/O67gNSPLhdvynLMwujOAsKKBkDPxJkTnbirzggOeH3Ipt8934HA7nVNbMn9TfsX/eliM4PPOSAEcodtXYs6qD8TrpkZ8Dj7NwN1wm0nLnnljtz9UhrWUQZ/MptMmdzgT23BgB/KqmH6gzO0RWJnpwPDxPZj9oxe0Iwxub4obRRe1DMk6jEllNsHMGOjXewY5um8ar0aS+LEy70ZhKH3kLMM+AXlPBBmKUUMFz6ZgQ1wL8FFYBE2kzNpYpPx6YoW27sYLGwjEj1Jcz+Rg==
Received: from MW4PR03CA0124.namprd03.prod.outlook.com (2603:10b6:303:8c::9)
 by LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 13:10:47 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:303:8c:cafe::15) by MW4PR03CA0124.outlook.office365.com
 (2603:10b6:303:8c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.12 via Frontend Transport; Tue, 7
 Jul 2026 13:10:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.0 via Frontend Transport; Tue, 7 Jul 2026 13:10:47 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:10:27 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:10:27 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Jul
 2026 06:10:20 -0700
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
Subject: [PATCH net-next 03/15] net/mlx5e: psp: Remove unneeded ref counting for PSP steering
Date: Tue, 7 Jul 2026 16:08:46 +0300
Message-ID: <20260707130858.969928-4-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|LV2PR12MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 294380da-4f84-459d-ec9e-08dedc2928d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|7416014|1800799024|82310400026|56012099006|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FFSTS4+S3Pew26J3waDLZPIQDrBbGVXq6WZ1OpGnXyy7kF3lTDU6F/wmrhp+jzuA+JiajqOhc2QMKIcuLgwJvQ8mKNO3RZFO7R9VjeDV0Xfyf8cXz20SklsU7gJm8CFsxaIoxO/KUserRLttFK/93G93VO2OcuvvDX6T6Z2aVKweRmVxuPW0kAYFCzlz+C6H+Gc07BEN/ghFJwk9UOe9X8SHCS4WiD8eClH/IxiFHp2D/UCsSCRMwctzPthkizGH+PZ9VF0Cj4zmX1JDh5yQegE2EUrnd6pgSPqYn/jtnjvehGICO9Z0TqkTckxv3r8jZ04EZv/Q49/o3oFoj1kfVr9LlxfazJNvt4FD9YMB9La3vCDiYXJOHT1fgaL1Hhl9pWimt0ZN+VvSnBz6jJoGyBc1MvrsZszkMjcPXGIGnXTGhAl/fUsC5I/jLZCR0Ev29z1QYrKJpx3zYN2k1OHBFBOLDJ4VO8diXWHz5N0SbBdS8LIhHI7cNU3hNK1L9F9a+5T2+2/BBa5I0uc75AtxQqG2/i3X76RD23i50B1/h7ADSEN53qvEFCwLUcMpIre5tBdA8dyMOt81iJdxnfdpf9a+Jbp7TkE0wiVoRFvA8BEs12XHuNUkm+QG25VDvO4nOT5EKsIAc2zVbBGsShwqIC6R8atg0m/7RxnCWzAxyYO4LN3WBalslf+zFerDIsga0vDoryu7fqwFT25k9daNsQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(7416014)(1800799024)(82310400026)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6FdmTb+7iT2aW3PYzHEmhVDqkZca1k9CfSK4oDXYRwPqHzvnFu1uzWQ84Qwe9lwW4wxodhMqoMnuTV4NTqGQMim/Fl448ElkM071I9UHEZoa3SzBKyAfOqrnD32AlT+tZE1DC9e0K0Y7xJ2rIgYphT27C5R02HnHiNKdtuKrM2F7+ql8qvche8XpOl46bIWK/3egY9D3zhxDXQ1b50/ELS6AS6PspnZxjw0bHtR0ZwX6LLmNz9dLlzdjPMeMcuFDLzuDuNIOtyhe95AFQ+Nqo2magWzQXLB6wpY3osCGG5R5gZCtiWpQxchDOFz+l1AHP7NLsFYSwLPITnl7LBPamK54WvPHHURiu2xRJEWk+NSA55vHy4sD4PsjLbJ4cghHN3uhlkD+KQO06appRnik25cwPGh+9RNEme2Hx362UG/nDRyZRuWW4Yq2sHQBJ0Yp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:10:47.0045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 294380da-4f84-459d-ec9e-08dedc2928d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5990
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
	TAGGED_FROM(0.00)[bounces-22822-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 997F271BB85

From: Cosmin Ratiu <cratiu@nvidia.com>

PSP steering uses reference counting for TX and RX steering tables, but
there's only a single reference for each acquired and thus the reference
counting is unnecessary.

Remove it and consolidate functions to simplify the code.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/psp.c         | 129 +++++-------------
 1 file changed, 33 insertions(+), 96 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index d4686b5af776..a69c4e2821e9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -26,7 +26,6 @@ struct mlx5e_psp_tx {
 	struct mlx5_flow_table *ft;
 	struct mlx5_flow_group *fg;
 	struct mlx5_flow_handle *rule;
-	u32 refcnt;
 	struct mlx5_fc *tx_counter;
 };
 
@@ -46,7 +45,6 @@ struct mlx5e_accel_fs_psp_prot {
 	struct mlx5_modify_hdr *rx_modify_hdr;
 	struct mlx5_flow_destination default_dest;
 	struct mlx5e_psp_rx_err rx_err;
-	u32 refcnt;
 	struct mlx5_flow_handle *def_rule;
 };
 
@@ -469,75 +467,18 @@ static int accel_psp_fs_rx_create(struct mlx5e_psp_fs *fs, enum accel_fs_psp_typ
 	return err;
 }
 
-static int accel_psp_fs_rx_ft_get(struct mlx5e_psp_fs *fs, enum accel_fs_psp_type type)
-{
-	struct mlx5e_accel_fs_psp_prot *fs_prot;
-	struct mlx5_flow_destination dest = {};
-	struct mlx5e_accel_fs_psp *accel_psp;
-	struct mlx5_ttc_table *ttc;
-	int err = 0;
-
-	if (!fs || !fs->rx_fs)
-		return -EINVAL;
-
-	ttc = mlx5e_fs_get_ttc(fs->fs, false);
-	accel_psp = fs->rx_fs;
-	fs_prot = &accel_psp->fs_prot[type];
-	if (fs_prot->refcnt++)
-		return 0;
-
-	/* create FT */
-	err = accel_psp_fs_rx_create(fs, type);
-	if (err) {
-		fs_prot->refcnt--;
-		return err;
-	}
-
-	/* connect */
-	dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
-	dest.ft = fs_prot->ft;
-	mlx5_ttc_fwd_dest(ttc, fs_psp2tt(type), &dest);
-
-	return 0;
-}
-
-static void accel_psp_fs_rx_ft_put(struct mlx5e_psp_fs *fs, enum accel_fs_psp_type type)
-{
-	struct mlx5_ttc_table *ttc = mlx5e_fs_get_ttc(fs->fs, false);
-	struct mlx5e_accel_fs_psp_prot *fs_prot;
-	struct mlx5e_accel_fs_psp *accel_psp;
-
-	accel_psp = fs->rx_fs;
-	fs_prot = &accel_psp->fs_prot[type];
-	if (--fs_prot->refcnt)
-		return;
-
-	/* disconnect */
-	mlx5_ttc_fwd_default_dest(ttc, fs_psp2tt(type));
-
-	/* remove FT */
-	accel_psp_fs_rx_destroy(fs, type);
-}
-
 static void accel_psp_fs_cleanup_rx(struct mlx5e_psp_fs *fs)
 {
-	struct mlx5e_accel_fs_psp_prot *fs_prot;
-	struct mlx5e_accel_fs_psp *accel_psp;
-	enum accel_fs_psp_type i;
+	struct mlx5e_accel_fs_psp *accel_psp = fs->rx_fs;
 
-	if (!fs->rx_fs)
+	if (!accel_psp)
 		return;
 
-	accel_psp = fs->rx_fs;
 	mlx5_fc_destroy(fs->mdev, accel_psp->rx_bad_counter);
 	mlx5_fc_destroy(fs->mdev, accel_psp->rx_err_counter);
 	mlx5_fc_destroy(fs->mdev, accel_psp->rx_auth_fail_counter);
 	mlx5_fc_destroy(fs->mdev, accel_psp->rx_counter);
-	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
-		fs_prot = &accel_psp->fs_prot[i];
-		WARN_ON(fs_prot->refcnt);
-	}
-	kfree(fs->rx_fs);
+	kfree(accel_psp);
 	fs->rx_fs = NULL;
 }
 
@@ -614,17 +555,27 @@ static int accel_psp_fs_init_rx(struct mlx5e_psp_fs *fs)
 
 void mlx5_accel_psp_fs_cleanup_rx_tables(struct mlx5e_priv *priv)
 {
+	struct mlx5_ttc_table *ttc;
+	struct mlx5e_psp_fs *fs;
 	int i;
 
 	if (!priv->psp)
 		return;
 
-	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++)
-		accel_psp_fs_rx_ft_put(priv->psp->fs, i);
+	fs = priv->psp->fs;
+	ttc = mlx5e_fs_get_ttc(fs->fs, false);
+	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
+		/* disconnect */
+		mlx5_ttc_fwd_default_dest(ttc, fs_psp2tt(i));
+
+		/* remove FT */
+		accel_psp_fs_rx_destroy(fs, i);
+	}
 }
 
 int mlx5_accel_psp_fs_init_rx_tables(struct mlx5e_priv *priv)
 {
+	struct mlx5_ttc_table *ttc;
 	struct mlx5e_psp_fs *fs;
 	int err, i;
 
@@ -632,19 +583,30 @@ int mlx5_accel_psp_fs_init_rx_tables(struct mlx5e_priv *priv)
 		return 0;
 
 	fs = priv->psp->fs;
+	ttc = mlx5e_fs_get_ttc(fs->fs, false);
+
 	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
-		err = accel_psp_fs_rx_ft_get(fs, i);
+		struct mlx5e_accel_fs_psp_prot *fs_prot;
+		struct mlx5_flow_destination dest = {};
+
+		/* create FT */
+		err = accel_psp_fs_rx_create(fs, i);
 		if (err)
 			goto out_err;
+
+		/* connect */
+		dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
+		fs_prot = &fs->rx_fs->fs_prot[i];
+		dest.ft = fs_prot->ft;
+		mlx5_ttc_fwd_dest(ttc, fs_psp2tt(i), &dest);
 	}
 
 	return 0;
 
 out_err:
-	i--;
-	while (i >= 0) {
-		accel_psp_fs_rx_ft_put(fs, i);
-		--i;
+	while (--i >= 0) {
+		mlx5_ttc_fwd_default_dest(ttc, fs_psp2tt(i));
+		accel_psp_fs_rx_destroy(fs, i);
 	}
 
 	return err;
@@ -739,30 +701,6 @@ static void accel_psp_fs_tx_destroy(struct mlx5e_psp_tx *tx_fs)
 	mlx5_destroy_flow_table(tx_fs->ft);
 }
 
-static int accel_psp_fs_tx_ft_get(struct mlx5e_psp_fs *fs)
-{
-	struct mlx5e_psp_tx *tx_fs = fs->tx_fs;
-	int err;
-
-	if (tx_fs->refcnt++)
-		return 0;
-
-	err = accel_psp_fs_tx_create_ft_table(fs);
-	if (err)
-		tx_fs->refcnt--;
-	return err;
-}
-
-static void accel_psp_fs_tx_ft_put(struct mlx5e_psp_fs *fs)
-{
-	struct mlx5e_psp_tx *tx_fs = fs->tx_fs;
-
-	if (--tx_fs->refcnt)
-		return;
-
-	accel_psp_fs_tx_destroy(tx_fs);
-}
-
 static void accel_psp_fs_cleanup_tx(struct mlx5e_psp_fs *fs)
 {
 	struct mlx5e_psp_tx *tx_fs = fs->tx_fs;
@@ -771,7 +709,6 @@ static void accel_psp_fs_cleanup_tx(struct mlx5e_psp_fs *fs)
 		return;
 
 	mlx5_fc_destroy(fs->mdev, tx_fs->tx_counter);
-	WARN_ON(tx_fs->refcnt);
 	kfree(tx_fs);
 	fs->tx_fs = NULL;
 }
@@ -844,7 +781,7 @@ void mlx5_accel_psp_fs_cleanup_tx_tables(struct mlx5e_priv *priv)
 	if (!priv->psp)
 		return;
 
-	accel_psp_fs_tx_ft_put(priv->psp->fs);
+	accel_psp_fs_tx_destroy(priv->psp->fs->tx_fs);
 }
 
 int mlx5_accel_psp_fs_init_tx_tables(struct mlx5e_priv *priv)
@@ -852,7 +789,7 @@ int mlx5_accel_psp_fs_init_tx_tables(struct mlx5e_priv *priv)
 	if (!priv->psp)
 		return 0;
 
-	return accel_psp_fs_tx_ft_get(priv->psp->fs);
+	return accel_psp_fs_tx_create_ft_table(priv->psp->fs);
 }
 
 static void mlx5e_accel_psp_fs_cleanup(struct mlx5e_psp_fs *fs)
-- 
2.44.0


