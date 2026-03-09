Return-Path: <linux-rdma+bounces-17761-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJqwE6+VrmnqGQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17761-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:41:03 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B65236593
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F855302DA06
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 09:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D550D37AA77;
	Mon,  9 Mar 2026 09:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aRJ504JP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012030.outbound.protection.outlook.com [40.93.195.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711E6361664;
	Mon,  9 Mar 2026 09:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048964; cv=fail; b=GYMESd4NYKJT/hkq6ed9bQyiA+yUzmsBOw5u/uSG3CXwjtJmG6PuJdyRCk/VAEwJYnKY0FTpDsdC7MBAjINt27C7qipntatS3WHjUI8cRT1yDuRa/8aX/1VnM/03KccliNaVBQ6Q+RMXhBmzdpTCM3AmPcpx6n2Mz77u75WdzjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048964; c=relaxed/simple;
	bh=MQGIqNzMVz4MSrUkytS7HiuTPkdsKO92SAuJeonImwI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKinjerpOYAcLpJuI23y0LUDSLuZRXwUAsis6d33M6WcIM8/L8dWPAcGQldsNvK0GV2N3aVquJ6B53A7kHt7KhORHn5YA6uKXg1lsBBtuY4e9vNsx+dOOXjwPXAfsVb9OErgXTJddHo9XFXMTuSeVkSyR1+FY8RtdyDcW/jrVYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aRJ504JP; arc=fail smtp.client-ip=40.93.195.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csdbBjbSOoRTIb6alkq6bPtXk20/KnZ471F5U69ZSFAEkRulNK87le4ndWCZkWpf94Abf/52euzzAmoo3DTAAyb8pA4pvZs0RMobt4jDXTc5KrzbW8VYASCsDbl5KybngUXA2SHMv5kYBMRZzVIRZ45Fci5Eyf7HDyw8An1oIOkWLvTI+hG/KdNDOoHZ3l96BbwPAS1k5Y8OH/xtEzyv03vSKe86WQ1OjGihlHgwaCbsFX/Yd6SHSRaXsagNbG/VuPeeyzHk4lG2Zf4pn5M/M2rXprYHxQauDxVjPjIgGhQUzuM5kcq/O3MKIg0l4Y+8VlB3iS9eAFSjc4dPqoe64Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCDI4qpi0uUUpoGrr4BGmS1qhDxn4mhsdCPrWXJM5J0=;
 b=yXRX0jse7aaqDMMXjKOJKgG7dLTGYJh9tlULjp2LtMzYqs9HJ/s/Dbg+6p4nbSLqzsWgJasLRFoR+IvAzHttMFxuyz8Zh0Qf0XyTBB3bynOfjbgvxmnRo8Y8CeKNTbOxGDobAZ5pV2W7+f2c4ZS+2wNc/sjlXQx/S25I6d72uWIIjee+/OxyR1pFqZyP+7Efw+6fEcORbMk91sJmqtWC17vXsFx9B2i/hIFsZjK/j9EOGITusEfGpvNVDRU+qPkKwAlPg5DUw9IdKytht6ytEFZJ3ukMKuAur0dZ7camaaYLKRpy/3XdnP1orTyV3e/02geqZfmfV+R/2b1PtcC3aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCDI4qpi0uUUpoGrr4BGmS1qhDxn4mhsdCPrWXJM5J0=;
 b=aRJ504JPrVBBlixFqqC7PJ7BZSc3CK5oF1XFWJyTzAULy0QaWmd9TuV4F66vyIVrUX+sCt5E2ei8Lk+9FsUbV/xgl5mLIJ9s8wHWQOVBj2dZehCG6yyUpuiKyA+EWf5Ops26ioeo2sSZibM9xIKUVgSEfIsQ+Dh2nfodRfuxxb2VOL2EJAdFG/d9X3oLqFLBYmrE7OXGobq51eQovrT1lRukGsULxq/HebEGEMiDa6zJ+Ht1os8QTkhOGmP50gT07zCeF6NS0kotYOk7QKqHAnjkD3E8IYooAa+KKT5imVgirhFV8wG4aGzo5jleJakWIAo7mWFyMvwn+BS07X5DcQ==
Received: from BY3PR04CA0027.namprd04.prod.outlook.com (2603:10b6:a03:217::32)
 by PH7PR12MB8427.namprd12.prod.outlook.com (2603:10b6:510:242::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Mon, 9 Mar
 2026 09:35:55 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:217:cafe::25) by BY3PR04CA0027.outlook.office365.com
 (2603:10b6:a03:217::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 09:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 09:35:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 02:35:26 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 9 Mar 2026 02:35:26 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Mar 2026 02:35:21 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Alexei Lazar <alazar@nvidia.com>
Subject: [PATCH mlx5-next V2 7/9] net/mlx5: Add VHCA RX flow destination support for FW steering
Date: Mon, 9 Mar 2026 11:34:33 +0200
Message-ID: <20260309093435.1850724-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260309093435.1850724-1-tariqt@nvidia.com>
References: <20260309093435.1850724-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|PH7PR12MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: 375e877c-7fdc-4473-c934-08de7dbf42d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700016;
X-Microsoft-Antispam-Message-Info:
	GMsSV+EO9Y9PvEzMCyHUXoXshWCvzZJddIubgY6QDK2CmILWdHFpyjHL0WFCRjPtgPg0hWtFIp3ApC+PgWxC8Zv6q0Pi4HUgrA5nY8VMB6PUAp0Fs+0HOYE07ihwy6AI9ewNNBYLM4DNhvKiLA+UUFxoBKFk9kT4ky3uvSCWy2zlaMM9MCbRfXb4Ibik4wTKBOGG4ZpKztPFHnBHIM9V+13Dn04M8hLghCZ3dcMXd62N+SyHEwKaAOzd5pqdCPnCuHtD0nn2o0yGxCWyWOcXp3VsQats28Jt/r2LlNy6t0H2VBFZmU1i/62HBYrWcqdjGQmXugO0S593hX6ekSuOAEveOKOPAgnfrXufmGKrp6vRN7hrqIatPOOMibf67a9WuLAz3Du+Q0bYtuWpDVr63YU5Z8odP4aTi/iZPQ232+wwHP/lfD0UkoU/VOrQpc7IH0h29kl/o8DpoVPkP2AHAPJV8oQScFgheuK3z4CjklBmf6hjB4rtd0MYqKj8BIXarsB052ad6mly1MeCXIzkWlpKN9AZFxhPO43u0Nqv2vfeGvi7o3GSunnM5KhoaP3Y0VylfJDr3dKDd6zak8nmCbYckNxtXBkwGA/A1FKoSEseOKzEQ7LWqipE8lswRPRu31zKSf2Tjkl4PeAbWvUFVGj/6wnMqbkxDMQ8gwqi8s6T5HLOawolUoQKq1Dn5zT4HetIC3D5z5NvqYayP8Mu1PUI1g5cvT99Y8+203iA097jbK5DBPW9d3UFkykyiiGLlgnVeRE+Nk2w1YeXw4HQqQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0O+lzkshZw5rBkgCTrJFjxeeu46tRVHp9L7EhXENIRAoJ31y3R+dEcMrPAcKNYWlFJolY/W0QuQ5zzA/SH14Xh9efDIFFx0WFXYfSn8SBzqX69uLpBJiLMfJFie0rJkBm0ErtR0wCaX4kJpxMdRqJc28hOPuEBbH95Qv2nSmNwhYPKJ93SitLvsPD8RxeMxC6zpNqaqotLOD11voRxUlg39bSIg60RKPZLszTqUwk5fPJMoP/IbG+xaSnqEgacV9nwyoDbgOLSf7DdgiOqF/g2sUMM7QUv3cGRVZZs8LA14PJ6HuxjfFxcdEvz9laULynR+ZnfPnq3ct+2RyL5U0buRqTUvZqN/FFH+s1xnnM68x1yNLK4zfe78gg4izLzNuxtmVSqN/Qjm2KcEg9Dmg0JOdssUGOvFq51OFpdpg1q4cWOjY0fk1yI9sfblhw9M6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 09:35:54.5481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 375e877c-7fdc-4473-c934-08de7dbf42d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8427
X-Rspamd-Queue-Id: E1B65236593
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17761-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Shay Drory <shayd@nvidia.com>

Introduce MLX5_FLOW_DESTINATION_TYPE_VHCA_RX as a new flow steering
destination type.

Wire the new destination through flow steering command setup by mapping
it to MLX5_IFC_FLOW_DESTINATION_TYPE_VHCA_RX and passing the vhca id,
extend forward-destination validation to accept it, and teach the flow
steering tracepoint formatter to print rx_vhca_id.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/diag/fs_tracepoint.c   | 3 +++
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c           | 4 ++++
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c          | 7 +++++--
 include/linux/mlx5/fs.h                                    | 4 ++++
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/fs_tracepoint.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/fs_tracepoint.c
index 6d73127b7217..2cf1d3825def 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/fs_tracepoint.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/fs_tracepoint.c
@@ -282,6 +282,9 @@ const char *parse_fs_dst(struct trace_seq *p,
 	case MLX5_FLOW_DESTINATION_TYPE_NONE:
 		trace_seq_printf(p, "none\n");
 		break;
+	case MLX5_FLOW_DESTINATION_TYPE_VHCA_RX:
+		trace_seq_printf(p, "rx_vhca_id=%u\n", dst->vhca.id);
+		break;
 	}
 
 	trace_seq_putc(p, 0);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
index 16b28028609d..1cd4cd898ec2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -716,6 +716,10 @@ static int mlx5_cmd_set_fte(struct mlx5_core_dev *dev,
 				id = dst->dest_attr.ft->id;
 				ifc_type = MLX5_IFC_FLOW_DESTINATION_TYPE_TABLE_TYPE;
 				break;
+			case MLX5_FLOW_DESTINATION_TYPE_VHCA_RX:
+				id = dst->dest_attr.vhca.id;
+				ifc_type = MLX5_IFC_FLOW_DESTINATION_TYPE_VHCA_RX;
+				break;
 			default:
 				id = dst->dest_attr.tir_num;
 				ifc_type = MLX5_IFC_FLOW_DESTINATION_TYPE_TIR;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 2c3544880a30..003d211306a7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -503,7 +503,8 @@ static bool is_fwd_dest_type(enum mlx5_flow_destination_type type)
 		type == MLX5_FLOW_DESTINATION_TYPE_FLOW_SAMPLER ||
 		type == MLX5_FLOW_DESTINATION_TYPE_TIR ||
 		type == MLX5_FLOW_DESTINATION_TYPE_RANGE ||
-		type == MLX5_FLOW_DESTINATION_TYPE_TABLE_TYPE;
+		type == MLX5_FLOW_DESTINATION_TYPE_TABLE_TYPE ||
+		type == MLX5_FLOW_DESTINATION_TYPE_VHCA_RX;
 }
 
 static bool check_valid_spec(const struct mlx5_flow_spec *spec)
@@ -1890,7 +1891,9 @@ static bool mlx5_flow_dests_cmp(struct mlx5_flow_destination *d1,
 		     d1->range.hit_ft == d2->range.hit_ft &&
 		     d1->range.miss_ft == d2->range.miss_ft &&
 		     d1->range.min == d2->range.min &&
-		     d1->range.max == d2->range.max))
+		     d1->range.max == d2->range.max) ||
+		    (d1->type == MLX5_FLOW_DESTINATION_TYPE_VHCA_RX &&
+		     d1->vhca.id == d2->vhca.id))
 			return true;
 	}
 
diff --git a/include/linux/mlx5/fs.h b/include/linux/mlx5/fs.h
index 9cadb1d5e6df..02064424e868 100644
--- a/include/linux/mlx5/fs.h
+++ b/include/linux/mlx5/fs.h
@@ -55,6 +55,7 @@ enum mlx5_flow_destination_type {
 	MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE_NUM,
 	MLX5_FLOW_DESTINATION_TYPE_RANGE,
 	MLX5_FLOW_DESTINATION_TYPE_TABLE_TYPE,
+	MLX5_FLOW_DESTINATION_TYPE_VHCA_RX,
 };
 
 enum {
@@ -189,6 +190,9 @@ struct mlx5_flow_destination {
 		u32			ft_num;
 		struct mlx5_flow_table	*ft;
 		struct mlx5_fc          *counter;
+		struct {
+			u16		id;
+		} vhca;
 		struct {
 			u16		num;
 			u16		vhca_id;
-- 
2.44.0


