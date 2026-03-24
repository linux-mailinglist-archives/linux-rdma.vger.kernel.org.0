Return-Path: <linux-rdma+bounces-18575-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMGYF5aGwmkAegQAu9opvQ
	(envelope-from <linux-rdma+bounces-18575-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 13:41:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B0E30878A
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 13:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60F3130A1D1C
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 12:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225193F8DEA;
	Tue, 24 Mar 2026 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iuFCUlq0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012025.outbound.protection.outlook.com [40.107.200.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580953F8E15;
	Tue, 24 Mar 2026 12:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355509; cv=fail; b=H+9IkauYmVwzYdEp3L5hd3Qht+dpWCpyn8p4LSKPJlAKbtsjYcmrOFsAFVlxyXdIw8IFPoM0BcM+gtklnNyY6EZMZSmcpeNNIbnYPIQ8aEFZDV1xXME6a5kiwrCfAvFviTkq/BqfEbbqxlPtYXwR44474J/WUblzQ3oZTgsQyg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355509; c=relaxed/simple;
	bh=o+gY58pq2GMa4kpw1jTicVi1NHBLffH3v/8gMZZsM1I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/x+FaTiLQuGpdeBZNyn0yntJoyZwKvB8hNLUouI20q3DTWKYNNIfdeH/nUsp3/YeFVUxfbA+gRo9RjarNLtDA8Z2p9bRgx2FxfXhGmMROD2gmtWiu+U830QtjSqwUFhDb46zwHThlCIN+Jjd0+jnIpFCbhEqVQg/Ir+asgUNHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iuFCUlq0; arc=fail smtp.client-ip=40.107.200.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6rSxyWPHbjANRVGJoN5bGhiFI6AyoUWzEf2ri1T+U/Cs3RW9Vx4HAjyiVq+nU6b7CndN2KRxk4+BDt1h3KOEVs270wt1MJVrNOo8wmXZ8P+qFCWrStsISu/XggKBVCaMoH3ky86fBWS0Bphq13HMr8O9JcNfcY2uVTA0yqTOGJKr8wLhkSn5WglCI4pkt8wVsxiOout2VILnwQWK2AfDVjq2l+MP68H8ZirFB9GN7onlciyD7a+5orvDogytT8A9DhhQyfyMjg8x8dQGftZHNV6E1/Vay06/OZvg+vbGFsA4NjjbttdlBW2rOp50n/Ir4K6pgr+XG99AI1bw2J1Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D05SEwBJ7FTOhFnS/qJDc6W+UOU/3PJmxbOOoAMQX4c=;
 b=E/6IEvVGeEYCbl0HQLNobcBK4kDTDx5Pnll/Uqtz3o06yhs3Sg1Vw32szqLA08Y0+RU90P7wDl/Fl3fKn3C7PSHuSMO5vsAPPQdW73+P2DGkYiKmyOe5RcTmR7JxzGo6uKw3jaGvFKQ4XuyZ7kYseuhFoC5847A+5xb9Y1o+hRU2aJeIKruCIiqBz4yKVVecCBR0/AbYiyiyAs3o3V1B4OuduBTAqods4sY1Va7gah8UOj2UGLRUWY9RiNnswcTUwKD+EUOfxWGmrhq3C1AJgsgA8ETwNX+ZS3NfsAYHxOEsKq/mo5OatUx/lXTfyf0jqZEqqbtUODr9OFHKMHrehQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D05SEwBJ7FTOhFnS/qJDc6W+UOU/3PJmxbOOoAMQX4c=;
 b=iuFCUlq0N6LrrEG1w6mq6lhhHSIAM7gmzHFtG4jpQpzwZltHLYFG6ME5uCuywYHn8bqhpq/N2z/8KwcqOVa07uBbUXFvVeaBbY1EbH7cCCvfHsAaOsQuW+meje+CmOEWT9WaFka51GxXZMREl46Yb24Q0aqurqnlWZtesNeiXJqcRIzZyqKrk04FfCLL/xcRCcXMWNQrtmVeJnSnvulwjhmvBT63JOz3LbH6vJBmMQpz5Q4EeIL1TAsmOQaL1DzCSUtX8SmHRkPDXCnxk0c8hZevshJG+iOi6Jz5GvpYPy5/qzT1EAFZ2G8oFvxqfugucFwRN9GlSoDlnW3/qSgWBA==
Received: from BL1P221CA0038.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::9)
 by LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.19; Tue, 24 Mar
 2026 12:31:39 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:5b5:cafe::ec) by BL1P221CA0038.outlook.office365.com
 (2603:10b6:208:5b5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 12:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 12:31:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:31:15 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:31:15 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 24
 Mar 2026 05:31:06 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Chuck Lever <chuck.lever@oracle.com>, "Matthieu Baerts
 (NGI0)" <matttbe@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, "Shay
 Drory" <shayd@nvidia.com>, Kees Cook <kees@kernel.org>, Daniel Jurgens
	<danielj@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Adithya Jayachandran
	<ajayachandra@nvidia.com>, Willem de Bruijn <willemb@google.com>, David Wei
	<dw@davidwei.uk>, Petr Machata <petrm@nvidia.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>
Subject: [PATCH net-next V8 12/14] net/mlx5: qos: Support cross-device tx scheduling
Date: Tue, 24 Mar 2026 14:28:46 +0200
Message-ID: <20260324122848.36731-13-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260324122848.36731-1-tariqt@nvidia.com>
References: <20260324122848.36731-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|LV2PR12MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf23edc-7e18-4337-9f8f-08de89a14bfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iXEvWqoRtteHb5s43aEs+POa5An1HxB31UO0Ucmhv1hMNih/imyDJ3BhNQxJwjIm1HVKx66NSo5NG1KLL/h6EPxSbUDCOW2q99H4eG6eDZq8wZBTSerzLX9r9LoXp/hDm3e5eJswCfqC/t9fi0OJj93lJ8Wxtjix6ycR5fY1GRRueyRoK4bVgIp5/WTo6uloN+5x7zG4y5w3fTWLwYeeMLTA2hXsbCfErKYXqBtDeNXPID6AaiTdSgxseZ0EYBq2u9bMdcP/zdLIR/kI8dut4e55D5n+c1LdksEPeDD9tVqVnv+DIZMTKNn5igRBowHFvU7047TmkA6T3PANuT8TiQTbvjVbcTvouKR5Ff0lLJ0tu7thLKFQOa2Fr5wa+OQTMnd2beH+2H3nNfx0E2iGfn6oUrbH7EPX3G0Jyf1cDehdBRnXA5e9CB3PkjnCw06NLmNJ+YM9wuneEA4KlAwQT+E2LzTily8T9+mJaO1+bqS3+7bb68bvRazvW/Tk3OJjzIHAIXKcgj2jNpDq5eMeSmi4JTWaA7G905CjjAadQXjkqEd6clcw9Objnhsrg752vEgK2WbkLuG6P8Fn4fkmEfySw4s12mk2Vl+nGMv5lfoKbAg6C29qCERMcVQLyaeo7LMy0V+oiiI0JMLxPczIfFKrlcg0p2fN7pScJbKlZWwWf6Yj/MNufnm8RuV8EgQjeXOpfYpDlNv8Km1AabMeCZUMTp8a2xCcP8YxiB2koKax8pCaQCOrBbpor8+UCYZ/P9nvvrAai5wXyPlJtSpA3g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Xe28uehj5xRtOZ2tlCfa6GMUCRdysuvEQOdhXKK5MO7QEfeQjNq1qSu1P6veEhvi247jXZlAxhuq6Uto+PSJSbQ4GiV0HQtv8O9Lq+DMS4HVtEdbs0n+SizChS8UoJXMgFAisyZjSsjxSM5rp0GDjcQa4xEvLOXBOz2n5BA8CEKDPVnRIonYg5aayxieBAqAmC0uTvNQXM6/cKuFvNvtJo7JZagThMifSN6n1iLOUjeS79Ql1mfaBpGBWjJfF891ibaU3y4mDWecXnOyINliQMBfsEl1ECJTrPr3/usVjqpIaqafbqVfb7NuFVHQ//LRb5IkDNK5iKTgkkAd452ejmtG6SQdU8WdVmkVDc8EeZ9wYYCYXSjB/wIh6k+7ZUbQ6nwkOXbrDhVnlgyM180CzmIRxaXRvmJHfhW1vL1CMI7Mm/9c4G14Q17yrQvp4EF9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:31:38.8848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf23edc-7e18-4337-9f8f-08de89a14bfa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,google.com,davidwei.uk,fomichev.me,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18575-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 02B0E30878A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cosmin Ratiu <cratiu@nvidia.com>

Up to now, rate groups could only contain vports from the same E-Switch.
This patch relaxes that restriction if the device supports it
(HCA_CAP.esw_cross_esw_sched == true) and the right conditions are met:
- Link Aggregation (LAG) is enabled.
- The E-Switches are from the same shared devlink device.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 117 +++++++++++++-----
 1 file changed, 83 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index c4ea0eea7106..d6bf7a8e1c9f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -50,7 +50,9 @@ struct mlx5_esw_sched_node {
 	enum sched_node_type type;
 	/* The eswitch this node belongs to. */
 	struct mlx5_eswitch *esw;
-	/* The children nodes of this node, empty list for leaf nodes. */
+	/* The children nodes of this node, empty list for leaf nodes.
+	 * Can be from multiple E-Switches.
+	 */
 	struct list_head children;
 	/* Valid only if this node is associated with a vport. */
 	struct mlx5_vport *vport;
@@ -393,6 +395,7 @@ esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_node,
 	struct mlx5_esw_sched_node *parent = vport_node->parent;
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_core_dev *dev = vport_node->esw->dev;
+	struct mlx5_vport *vport = vport_node->vport;
 	void *attr;
 
 	if (!mlx5_qos_element_type_supported(
@@ -404,10 +407,17 @@ esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_node,
 	MLX5_SET(scheduling_context, sched_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT);
 	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
-	MLX5_SET(vport_element, attr, vport_number, vport_node->vport->vport);
+	MLX5_SET(vport_element, attr, vport_number, vport->vport);
 	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, parent->ix);
 	MLX5_SET(scheduling_context, sched_ctx, max_average_bw,
 		 vport_node->max_rate);
+	if (vport->dev != dev) {
+		/* The port is assigned to a node on another eswitch. */
+		MLX5_SET(vport_element, attr, eswitch_owner_vhca_id_valid,
+			 true);
+		MLX5_SET(vport_element, attr, eswitch_owner_vhca_id,
+			 MLX5_CAP_GEN(vport->dev, vhca_id));
+	}
 
 	return esw_qos_node_create_sched_element(vport_node, sched_ctx, extack);
 }
@@ -419,6 +429,7 @@ esw_qos_vport_tc_create_sched_element(struct mlx5_esw_sched_node *vport_tc_node,
 {
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_core_dev *dev = vport_tc_node->esw->dev;
+	struct mlx5_vport *vport = vport_tc_node->vport;
 	void *attr;
 
 	if (!mlx5_qos_element_type_supported(
@@ -430,8 +441,7 @@ esw_qos_vport_tc_create_sched_element(struct mlx5_esw_sched_node *vport_tc_node,
 	MLX5_SET(scheduling_context, sched_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT_TC);
 	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
-	MLX5_SET(vport_tc_element, attr, vport_number,
-		 vport_tc_node->vport->vport);
+	MLX5_SET(vport_tc_element, attr, vport_number, vport->vport);
 	MLX5_SET(vport_tc_element, attr, traffic_class, vport_tc_node->tc);
 	MLX5_SET(scheduling_context, sched_ctx, max_bw_obj_id,
 		 rate_limit_elem_ix);
@@ -439,6 +449,13 @@ esw_qos_vport_tc_create_sched_element(struct mlx5_esw_sched_node *vport_tc_node,
 		 vport_tc_node->parent->ix);
 	MLX5_SET(scheduling_context, sched_ctx, bw_share,
 		 vport_tc_node->bw_share);
+	if (vport->dev != dev) {
+		/* The port is assigned to a node on another eswitch. */
+		MLX5_SET(vport_tc_element, attr, eswitch_owner_vhca_id_valid,
+			 true);
+		MLX5_SET(vport_tc_element, attr, eswitch_owner_vhca_id,
+			 MLX5_CAP_GEN(vport->dev, vhca_id));
+	}
 
 	return esw_qos_node_create_sched_element(vport_tc_node, sched_ctx,
 						 extack);
@@ -1160,6 +1177,29 @@ static int esw_qos_vport_tc_check_type(enum sched_node_type curr_type,
 	return 0;
 }
 
+static bool esw_qos_validate_unsupported_tc_bw(struct mlx5_eswitch *esw,
+					       u32 *tc_bw)
+{
+	int i, num_tcs = esw_qos_num_tcs(esw->dev);
+
+	for (i = num_tcs; i < DEVLINK_RATE_TCS_MAX; i++)
+		if (tc_bw[i])
+			return false;
+
+	return true;
+}
+
+static bool esw_qos_vport_validate_unsupported_tc_bw(struct mlx5_vport *vport,
+						     u32 *tc_bw)
+{
+	struct mlx5_esw_sched_node *node = vport->qos.sched_node;
+	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
+
+	esw = (node && node->parent) ? node->parent->esw : esw;
+
+	return esw_qos_validate_unsupported_tc_bw(esw, tc_bw);
+}
+
 static int esw_qos_vport_update(struct mlx5_vport *vport,
 				enum sched_node_type type,
 				struct mlx5_esw_sched_node *parent,
@@ -1179,8 +1219,15 @@ static int esw_qos_vport_update(struct mlx5_vport *vport,
 	if (err)
 		return err;
 
-	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type)
+	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type) {
 		esw_qos_tc_arbiter_get_bw_shares(vport_node, curr_tc_bw);
+		if (!esw_qos_validate_unsupported_tc_bw(parent->esw,
+							curr_tc_bw)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Unsupported traffic classes on the new device");
+			return -EOPNOTSUPP;
+		}
+	}
 
 	esw_qos_vport_disable(vport, extack);
 
@@ -1510,30 +1557,6 @@ static int esw_qos_devlink_rate_to_mbps(struct mlx5_core_dev *mdev, const char *
 	return 0;
 }
 
-static bool esw_qos_validate_unsupported_tc_bw(struct mlx5_eswitch *esw,
-					       u32 *tc_bw)
-{
-	int i, num_tcs = esw_qos_num_tcs(esw->dev);
-
-	for (i = num_tcs; i < DEVLINK_RATE_TCS_MAX; i++) {
-		if (tc_bw[i])
-			return false;
-	}
-
-	return true;
-}
-
-static bool esw_qos_vport_validate_unsupported_tc_bw(struct mlx5_vport *vport,
-						     u32 *tc_bw)
-{
-	struct mlx5_esw_sched_node *node = vport->qos.sched_node;
-	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
-
-	esw = (node && node->parent) ? node->parent->esw : esw;
-
-	return esw_qos_validate_unsupported_tc_bw(esw, tc_bw);
-}
-
 static bool esw_qos_tc_bw_disabled(u32 *tc_bw)
 {
 	int i;
@@ -1738,18 +1761,44 @@ int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
 	return 0;
 }
 
+static int
+mlx5_esw_validate_cross_esw_scheduling(struct mlx5_eswitch *esw,
+				       struct mlx5_esw_sched_node *parent,
+				       struct netlink_ext_ack *extack)
+{
+	if (!parent || esw == parent->esw)
+		return 0;
+
+	if (!MLX5_CAP_QOS(esw->dev, esw_cross_esw_sched)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cross E-Switch scheduling is not supported");
+		return -EOPNOTSUPP;
+	}
+	if (esw->dev->shd != parent->esw->dev->shd) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot add vport to a parent belonging to a different device");
+		return -EOPNOTSUPP;
+	}
+	if (!mlx5_lag_is_active(esw->dev)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cross E-Switch scheduling requires LAG to be activated");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static int
 mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport,
 				 struct mlx5_esw_sched_node *parent,
 				 struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
-	int err = 0;
+	int err;
 
-	if (parent && parent->esw != esw) {
-		NL_SET_ERR_MSG_MOD(extack, "Cross E-Switch scheduling is not supported");
-		return -EOPNOTSUPP;
-	}
+	err = mlx5_esw_validate_cross_esw_scheduling(esw, parent, extack);
+	if (err)
+		return err;
 
 	if (!vport->qos.sched_node && parent) {
 		enum sched_node_type type;
-- 
2.44.0


