Return-Path: <linux-rdma+bounces-17699-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIM8GJ0erWnoyQEAu9opvQ
	(envelope-from <linux-rdma+bounces-17699-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 08:00:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B51FB22ED91
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 08:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A23D3063619
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 06:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A25B334C05;
	Sun,  8 Mar 2026 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tf3QeOdO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010054.outbound.protection.outlook.com [52.101.193.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB30132ABF1;
	Sun,  8 Mar 2026 06:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772953030; cv=fail; b=ZVI2O+qhaTYdGCBksThVtBCv8j7r1a3NgVsnh6XkV5TdnMG7nX5n0CYiaCLR1Qrr2Td792q6AejzMOqNLie+g4q4yXZgrYe3ieda53cWK7nI9zDmgbXS0Y+6Quoh9HL7+RCq6H1DobVXs/u22I/bHWe3QBYLmmOG7R3hCSq8+kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772953030; c=relaxed/simple;
	bh=MQGIqNzMVz4MSrUkytS7HiuTPkdsKO92SAuJeonImwI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snN9+OKQ80HtE7fTEdqN6KwGAtSW5UPYz+UKQ/5qOELA6pRHpREMwbIr0iTbeLFfTyZXrwCgv8J6QEidlixgiDeD/Tv3OOc6V8h9utAKA+Xn59V7aQEM7uFj0jPxdsvXwISLO1x/rJQxmFj146L4jGQADziuY9iXnW16FK7UwUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tf3QeOdO; arc=fail smtp.client-ip=52.101.193.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/QuOrdRMOkseWbgkqHWO5Gvo7Gx0g5FIHZq45nMj8QXMiC1YXeeKKlkjs6X8lpNgRPvOOecQ6B+iU4knnfmKgQHKiGxrP3XRWUGnzAuYMXIjghD7GIDuZ60GiY+yReLSdT0DGdmdwIOkgas6s6V0PnxsTScPye94DwzPwB6NaRHoSMF/xGFZm5kk+rYQbB9at+yJV5PKY0K4k+OygQC3wsPngezUWALYeXDkgVPWKK+Jt0K1eHQ2sDApNspqVTNngWsQvjJJIu2k9dO7fY1gS/DN4XriReI+K33ExbXRysA/Rf5tlQjJW+1CQ7YVWvvsQ9h7j1m32s+ErNIwlsMdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCDI4qpi0uUUpoGrr4BGmS1qhDxn4mhsdCPrWXJM5J0=;
 b=RjFdIYzp2dym6zJn87ZSEyyDYkSXZdyvG0Zk/9I+q8GA9KWfr7WPlLYfczNb0U1+fZ4eM2JFdX0Cf3Y0t/CIEf6sh5fIM+lqWfpNttVvJ5ydiNwQGHUq3XsFEj4lcihsLT84uKbn0NtF+3rK+Jn+Q4SpEuW1G+iCuW6erMEiEa+MI4HAnh59W/i4Yl2sghjZ4GggYR4YL/RFyntL0WEzKN7JGiPnzO7JdtpYZH2GnyP4gI+EqzOsCwrjUntpWJvlJxr2tTXJHLsQezwMkM5hGZ8fPmWoIGUjdHiY4xTBHlstZfoPLIEmYxtLSvinTbIt2YS3EB2gKSGWp3jFrt6zoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCDI4qpi0uUUpoGrr4BGmS1qhDxn4mhsdCPrWXJM5J0=;
 b=tf3QeOdOsujRi6jmV01sgNIJrHr02ze48PtRmCW+TS0WypboV51YC/A+TzSAtg5VnByNyS6O3ARxTBr2TC3jfvcZIJm0d84jpLOlvbatzv+Hg0EyzULpu7LU817j9yfIc7IQ/ZWstIUPdj6ZT8bhSjt3ngwFalioViFpHEFCsfYh5flFCtb0LRx9ZRM2Ox6wnSLoyyuD2HZECKNCj2GvynCE0tbsANYAx534SYoJROU3nwKbZtqql+2eKI2PxTSzAyTpDpVBDhWogJZMz+805W1NLr8D0ZhwJe8L084APBm7LK5nHTHocYjJWXTLdbXZZTzXTOwzvN5AXmiosn7veA==
Received: from BY5PR20CA0035.namprd20.prod.outlook.com (2603:10b6:a03:1f4::48)
 by IA1PR12MB6411.namprd12.prod.outlook.com (2603:10b6:208:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Sun, 8 Mar
 2026 06:57:04 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::54) by BY5PR20CA0035.outlook.office365.com
 (2603:10b6:a03:1f4::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.20 via Frontend Transport; Sun,
 8 Mar 2026 06:57:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sun, 8 Mar 2026 06:57:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 7 Mar
 2026 22:56:56 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 7 Mar 2026 22:56:56 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 7 Mar 2026 22:56:52 -0800
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
Subject: [PATCH mlx5-next 7/8] net/mlx5: Add VHCA RX flow destination support for FW steering
Date: Sun, 8 Mar 2026 08:55:58 +0200
Message-ID: <20260308065559.1837449-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260308065559.1837449-1-tariqt@nvidia.com>
References: <20260308065559.1837449-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|IA1PR12MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: bd674abb-ebda-465d-862d-08de7cdfe7bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	ZJFI0MiTmibbruU28k39bx7F51VCSJUl9BwdDQnMVdkX9B5ZkMQn4Z48d9e/ZJO/92K03nBPkQgFHy+xSA4t6c6IctURR/B1uJ4DOlS/uwbE4l5EeGfosohRDntscfK1HoXad1YtxfHqTNvWdTMD4mUw47gjhVWl7Puh1XKxbm5OJdj+bl9K8LQH3mn+hiO3LKOLg3I/r8I8FBxFhyrru86lgpYaATTNu32pbz2CNTg7NXRLtbXsWQzjmY4Sgumh0QnrmWtBpA9Dd7MCT+8di3g7VAAGlRylROXhSjEk0XKilJBjtCdecbf8gXS++X4hr0q9c9qNgvDzoASXAUX5RI1QzuyqOWInNTXVqLZ+DINshWBD1N2bej9WGr0PtlLWilvK8QYkMG7OVERhBNR6/98rCwVf0ZUctwRv2PoOb3MobhhQRywlcIXBh4RMhWNt60y2xTn4mVYDWqzwj5GA3UnLD85HyK/IaJDY7KZIqB0HcnHVS7v6Dxpys4LTPVc3H81ztuDfk5/5mcFdl6VYaKst8wa6WVPP3gu8CzZt+Z7oroZVf8TFprxFYI38i96dDEANt/WKptOiwwCnAc9VGOt995eZoF1dGHile09EhorQ8R8bA/l7OWf7tCXtXwKNPA3owtDGpUb2e09WS9qVO4nrO0vNVqQfmm4k+OGFWGeJ+/deTSsNmLA+gX965Y3rpTdmitOxQX5ZOeaQlxWmWsR+bQeiglgJ+N/BJr6avwj7a/mOilB453wE5VloOLLmAJG9OGmBJh9PVKVMqEFDtw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WJawzv+GoPFnTA9oezsMqDmN0UWFTnZYbA5iT93DiAPJemtB6hzScYCRfWLlxLf48GMu05gSQz/nWCigWURSsNCtb4ZIjSma0ipZO1oxNRnNCuvHWUsQZ+oSEfBxFn39oFjv3Y8g4MWpjCIiktZN5iHVhtRRbvwPbjmcPKxU/D0Dde2W5Ap5i9fQuWr6iLMmie2BjWf85gS5yyX9EJvKxZu1ZcIMkcf7LF3cniXo8jqwqh1V0lXIrrQUQveMBOKLtt9Y/9I5Fu4QmrUTxl81UJ7jFB9HurL1DzG2r1a9nwUXfJezIj/QkFBJs2DcqSTKwwkSV9xZ3DXfMe3qKKklBF6WWyk0gXp4ozHsLOO6HIjIir5z+4eBeu2+ZBaK/19RczRKd9EM3lPxhqkj+I3BmBnPDKMDF1OHFt4t1PPNAXfWnhHnNY0waN9a9SOkcmG+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 06:57:04.0366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd674abb-ebda-465d-862d-08de7cdfe7bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6411
X-Rspamd-Queue-Id: B51FB22ED91
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17699-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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


