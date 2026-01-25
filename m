Return-Path: <linux-rdma+bounces-15977-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFapMKgAdmnEKQEAu9opvQ
	(envelope-from <linux-rdma+bounces-15977-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:38:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDD1805E4
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B0D09301C696
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 11:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAED631A7FD;
	Sun, 25 Jan 2026 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AocR6rLA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013007.outbound.protection.outlook.com [40.93.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFE831196C;
	Sun, 25 Jan 2026 11:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769340856; cv=fail; b=bvCT5FtftU8CR3VM7jGUP3YKOxC3AQFozG6jsVGC36/SZyxm5AsGlCmMvnB/HmioDDSGhDKYFNaMknxwqHCe8BiUQklMdoKoKs4LVHovL5zUwMV4vAjsS4drVgcsZvudSKVV/JIK5uHBxLqXdBsxj6zK79BgJBdRDHOwCqjdww8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769340856; c=relaxed/simple;
	bh=OBH3dUecXLZjYOHn08lX3mXaOV1h2u13eqIrLMk9GB8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5qR+VTqQkl5y37F/iUbxl2aKgEIjPwLEFH7elgdmECAtIesskcs8Wv12ZahyrXoGeHAdX+IAYrDfLnZdmQqD9QznHX+KsJpKHYgjIhYTWikD9T0ewe7ymaGymUopBhsL+oAXzeAma7ti53aa2SEZyehAWbwPfADW8Nvz6MngLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AocR6rLA; arc=fail smtp.client-ip=40.93.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8i3dfWmDa/J9ED7yXDvHiyWM5Dd7RH+XVAOmkpnkIrg7bEVFGWMgv157wVy4SQv9Boyef09yGHBX0LmdO1LGdn5lBnVqNPZ5MCFbgfYO5EHU30qx7FGaxQfLZ9E2IoqV2/XAnIH/ynOCBgdNm4b39d4f0DeU3e/5IKE/YMIZKR3k/U3VBDItdwQNG5TrtfCo885hitD2wdf8vDz2Iz44mI4+hGdiJ4seCJ5smTN0DdmyN0wk+TMOD34fnrJEOefHImGptFASLk3AzRjlJ0v640pXnEAJZbDO6zafUWfU6qHpTUCJvJbXTnC34KUUv/eVG4TqIxMQhiYvJw0Nc2CTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztLPoPulb6olMuY2CocR88yAAlQ4DPixu39g56ottB8=;
 b=OGEJpl9HhZ6UtGWz7ZADvdowgg7URZj4Hd1opcRi/6Zi38CGWTY0EgBJtqYBZvGiOkbz89yQ5LLJV63FhJI0tSAr+YWzD758ccXGwZGJTaGpRHasOQIYgySlZg3HDdu9GvutI49WKhDSDum+ukLP+maGYW2VYa7Vde52VV9apbrGwNpqcYzjpnay25x2H/ArDRwslHomDyPvnMob6NxSEu5zxRxRLZJQtQMXSdwItLstjLC3WLpgS5emYHCoRYtrOkri150uino2EHYTLTW5/Z/o8WahsrDekyUXUOzJxnUxPAV3reV7juTbGlD0HtowNN3jLsLDsX7BHDnOdp26Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztLPoPulb6olMuY2CocR88yAAlQ4DPixu39g56ottB8=;
 b=AocR6rLAgcNqpnNSDG4Mp3AVIWPX0hdBmcKsu2iXo6Bs2DJj9a8dx3qk29CDclIhySMHnpYsELgwvCcftNnJqekrM9kzq+05Yb5zqJPtmzfdmaDNZcXjCCQ6lO398cS3lONb6OQNInTn+oW9a8vzxkvzL1WPMGX9z1GRmlMO3C4lGzaJZP5QP3ftPwgz733+I3ch59dfl69GrxW0kxwNr46sg9SXX+l/O8bEpoQKXtLlHu4higyBK8y9lV/jjR+DreClN5oHQM06eWTRgorkvid2GJCgjfQGolIm588HTcIFwpx0gNHet11K16SVBPZc3ezJegoqRCMu5qKe5WP2ww==
Received: from SN6PR16CA0050.namprd16.prod.outlook.com (2603:10b6:805:ca::27)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.11; Sun, 25 Jan 2026 11:34:10 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:805:ca:cafe::fd) by SN6PR16CA0050.outlook.office365.com
 (2603:10b6:805:ca::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Sun,
 25 Jan 2026 11:34:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Sun, 25 Jan 2026 11:34:10 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 03:34:00 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 03:33:59 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 25
 Jan 2026 03:33:54 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Randy Dunlap
	<rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, Krzysztof Kozlowski
	<krzk@kernel.org>
Subject: [PATCH net-next V6 13/14] net/mlx5: qos: Support cross-device tx scheduling
Date: Sun, 25 Jan 2026 13:32:02 +0200
Message-ID: <1769340723-14199-14-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1769340723-14199-1-git-send-email-tariqt@nvidia.com>
References: <1769340723-14199-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: 81fb768d-289f-4c35-3adf-08de5c05a86d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oALrlTbtADC4UjgT1xljMbnl6pj81TlA1n4XQRWDjOcnmo1olpduT5h1WfQB?=
 =?us-ascii?Q?XgycyhXhN+8MRSAxsP3yXbpYNCTlB8xkq9Y6L7UlPdEWZ/+QDvZnavL8Wt2w?=
 =?us-ascii?Q?C5e9UKb9s9kVxqWg8VkDbK5uOc/xcSsmZ9Oyqxl3zisnDE9fYkd3/oH7YGdV?=
 =?us-ascii?Q?D/it4PAcfcvNLjSQ+dh03msbAPh6T/2o45xrHhqFQjEAP/VvMdhF38TIyyq8?=
 =?us-ascii?Q?vrSQqQobzirpcmka/56gvsOp8SyBJXTtgOhJOKFMluItFUg5tmHwjphNrCiQ?=
 =?us-ascii?Q?atCZ74KlPMCBXpypdiOJKhp+tJXrfewRh1osn6jvVr521+2A/rc/txINzMlA?=
 =?us-ascii?Q?sWIEzpbHiss2FAMh1B12kP7PJNxBP/Zu6MjAuuEeboU8462cdEMu6ZIOio81?=
 =?us-ascii?Q?q7WsMu2YrLQN+8JHhpKLTabwQymwOQ6sEFYHG2MpBCzW7AH7oKWxbZhiuJ3P?=
 =?us-ascii?Q?LbDS1O0QTaMZrjcG+U8kFPhfavsNMV+VdtVXjLnIsQ4PzZQvOIpaWKk3L9mm?=
 =?us-ascii?Q?5LefLjjiYcVF9Gs25HwrFyXPcwD23ttAGC2BNE9nnG7HQ6RE2Wxv/K/ZN8We?=
 =?us-ascii?Q?KV7dCo1Fkskff82o05+2joCVQ8nsUTECYj6cLccADCp1dQgXw36I8G84M91B?=
 =?us-ascii?Q?LMs+3SgrxiiKaypqqeyCNHK88ubxRl8MLzaZRnikcQu2xzfCLSDOrTCmqnkf?=
 =?us-ascii?Q?afuWZlCFoYu5rCHdTYRB/oNHbJDZQ92hTmENIr+BMCGglimSgJKcEKSOmjEd?=
 =?us-ascii?Q?b3r26/isOu+694zAMjAs9/jx+L+kC9yKAlrdSvj6BnRrQmvVgd/HwL8vZT14?=
 =?us-ascii?Q?V2KS9w9JB/0/Z35ikS5LEO/pvUDO/JN1rHdBqzJ5BuLc2Q79f6BJUG/oyqv+?=
 =?us-ascii?Q?PlU4O1OE1OSpVEGLM72s6+are8RxOZOV4UoPxMnGYZSe41WH8ttgo8sL+/rP?=
 =?us-ascii?Q?XlRb/0jFdrCS2YObkHJXJzMwZdN4smtbgstt0F7GVyOw7f9Lsa0KSRfdn7AE?=
 =?us-ascii?Q?KbvEk2f1YdHXPiBaX7eCQViVMmNpsWJTZgdfvuI1rzsHsCcruvy6dY/WjUyu?=
 =?us-ascii?Q?ravFXFkZAguegHnWRe/kF5xiZ6cvaiKeXbVQffB17GgvUtJeriJ2MVt/FBJ9?=
 =?us-ascii?Q?d3uq5R+1jA4EpC6ZB9G+e6k6HISHlOr4sTp7rEIwXD+iG8gaRKUvw+NI8nDG?=
 =?us-ascii?Q?ioS2kiFFY/Mq37qGgbqidUrAt1LymGIIdXL+SBxC7JpTw++s1//HesBxcGhi?=
 =?us-ascii?Q?5e6BBLmNd1IzfRZcg0UUq0R542UM/6btQrTTBWbscd6/51YiRoA/HSfo1DrN?=
 =?us-ascii?Q?dgh5K88xyKB5PE3ppSn8WQVtLUMtuEjRyTyos0oRKuc303hLK0g6cq48gc2x?=
 =?us-ascii?Q?ivqF7+3f8jTX57a3N0ZaS9VPWBvqsDAFi0mzX2bc9GL207MA1zyU1oqAxjb9?=
 =?us-ascii?Q?2cQMmvRuRLcNJ3DBMxpPtIaviDAXY56mSJBDp5DD90vhfasrLWA/jq6y3Ig0?=
 =?us-ascii?Q?uwTvR4YcTXqdN69qbekgVDtIUcx1wKAsl73JCYUn6PPYnQ4DxvF1WLQFh2ci?=
 =?us-ascii?Q?enP8hBoETrI/4BZmyVPLmJtLvPc6fGYP48OV1cs2Z/Jedn0koa1jpOiQWQQM?=
 =?us-ascii?Q?ttEGLWziKHULLwkEyr15sFZ1qVSVmSvCHnAiwiMhfbnf8kdQH8GRX3zeSvup?=
 =?us-ascii?Q?0HyczA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 11:34:10.1982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81fb768d-289f-4c35-3adf-08de5c05a86d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15977-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BDDD1805E4
X-Rspamd-Action: no action

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
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 122 ++++++++++++------
 1 file changed, 86 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 0d187399d846..b4abb6fa2168 100644
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
@@ -419,6 +421,7 @@ esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_node,
 	struct mlx5_esw_sched_node *parent = vport_node->parent;
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_core_dev *dev = vport_node->esw->dev;
+	struct mlx5_vport *vport = vport_node->vport;
 	void *attr;
 
 	if (!mlx5_qos_element_type_supported(
@@ -430,11 +433,18 @@ esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_node,
 	MLX5_SET(scheduling_context, sched_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT);
 	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
-	MLX5_SET(vport_element, attr, vport_number, vport_node->vport->vport);
+	MLX5_SET(vport_element, attr, vport_number, vport->vport);
 	MLX5_SET(scheduling_context, sched_ctx, parent_element_id,
 		 parent ? parent->ix : vport_node->esw->qos.root_tsar_ix);
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
@@ -446,6 +456,7 @@ esw_qos_vport_tc_create_sched_element(struct mlx5_esw_sched_node *vport_tc_node,
 {
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_core_dev *dev = vport_tc_node->esw->dev;
+	struct mlx5_vport *vport = vport_tc_node->vport;
 	void *attr;
 
 	if (!mlx5_qos_element_type_supported(
@@ -457,8 +468,7 @@ esw_qos_vport_tc_create_sched_element(struct mlx5_esw_sched_node *vport_tc_node,
 	MLX5_SET(scheduling_context, sched_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT_TC);
 	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
-	MLX5_SET(vport_tc_element, attr, vport_number,
-		 vport_tc_node->vport->vport);
+	MLX5_SET(vport_tc_element, attr, vport_number, vport->vport);
 	MLX5_SET(vport_tc_element, attr, traffic_class, vport_tc_node->tc);
 	MLX5_SET(scheduling_context, sched_ctx, max_bw_obj_id,
 		 rate_limit_elem_ix);
@@ -466,6 +476,13 @@ esw_qos_vport_tc_create_sched_element(struct mlx5_esw_sched_node *vport_tc_node,
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
@@ -1194,6 +1211,29 @@ static int esw_qos_vport_tc_check_type(enum sched_node_type curr_type,
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
@@ -1213,8 +1253,17 @@ static int esw_qos_vport_update(struct mlx5_vport *vport,
 	if (err)
 		return err;
 
-	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type)
+	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type) {
+		struct mlx5_eswitch *esw = parent ?
+			parent->esw : vport->dev->priv.eswitch;
+
 		esw_qos_tc_arbiter_get_bw_shares(vport_node, curr_tc_bw);
+		if (!esw_qos_validate_unsupported_tc_bw(esw, curr_tc_bw)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Unsupported traffic classes on the new device");
+			return -EOPNOTSUPP;
+		}
+	}
 
 	esw_qos_vport_disable(vport, extack);
 
@@ -1224,10 +1273,9 @@ static int esw_qos_vport_update(struct mlx5_vport *vport,
 		extack = NULL;
 	}
 
-	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type) {
+	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type)
 		esw_qos_set_tc_arbiter_bw_shares(vport_node, curr_tc_bw,
 						 extack);
-	}
 
 	return err;
 }
@@ -1575,30 +1623,6 @@ static int esw_qos_devlink_rate_to_mbps(struct mlx5_core_dev *mdev, const char *
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
@@ -1803,18 +1827,44 @@ int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
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
2.40.1


