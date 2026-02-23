Return-Path: <linux-rdma+bounces-17071-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEmfLoa9nGlSKAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17071-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:50:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C6917D2FC
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 21A6F307701E
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 20:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60A137AA9C;
	Mon, 23 Feb 2026 20:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q0khoKMR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012032.outbound.protection.outlook.com [40.107.200.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429A03783D1;
	Mon, 23 Feb 2026 20:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879419; cv=fail; b=bzn5eCbZtyDGeomVLCVi3ASznPrGch701BzebhqJCF/JF3SZ4qv6I//gO7TwoPbgMe+9EgpElfSIxnNPQlDgjOtft7yGsXFJn7TlUxf5NrKWy/nSRsw8AUE+Fj2o55iIfH5c0sTmdr3DSsaf6n2wKvaOs5fEWZDyUnxH361jW6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879419; c=relaxed/simple;
	bh=W96tCSykDAsDD4Ilzss7Jbiu6m9AN4qAqGlbunkHt68=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/iM51R5EzilMkRh+qlEnccxYxmuaXlF0VDKQqf+/Mohykx4Pi4wEcqnLz113NYgQ6YNzuMB/10vO+IaIX1c1Szmcz0HuCwAMmAWzGFwnZAeFWNkopqYbH/3YQrpCCebt44By+d2yRAe0qlAqX012Fxa6PNmxAbTVjubWqJ74dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q0khoKMR; arc=fail smtp.client-ip=40.107.200.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epW+7NBKh1RJl5TD7oB6O4S3c2NWSyCEhBY0IeLjas22J2wMoxupHlmM6vBqnLTXrIFqLvy6eL5ovOHI+RYGhQJq04EYQLg9j4+4v8qUxCZx+SV7Qf7Dz0jXyOY9jKvY3v04wyF4rOoH1VEQwbewTITTjfJ7wLlBxvI7191TXjfsQ6JO15OwdA4EmLebZNPye7b0TAMXsBAcbxpPk+PLKcraixaQ8RU8E9Fg19gPLwK6hIOrBC3F2VcMJAnRkRu8SWi7sip3k55HYm4zduZmUfA5KA+XSj7iIwD/D00knB4vRCp4E8od9n7vsJGqxelIudE8xF1nVtdNN1boNUCC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOkiEMrSIUPPN0JlMxWyk4CrqSZSYP+t2v2OA6Fa/XI=;
 b=Jz4VJ+fxdjrCeDpVAmM8cevBIPh5vhxB+T7a2++oqoLQL8LoNHb6VHcyoxvKkOYx0KRP2WAd4X6BoSGUeSrILWqNwiynIZmRhjVIcW0noZScWt5cL5AxdYk2hV2hnKqjq3MiIQv+SWmymTdwfJkWrY9MaEjA/dg9ow+oVWvnZHr04Q9ShnJzNctEzpGEn0ln4t1lxmEJlRFLVIbR0nK/6kE54AXuCumJL9m+IlRb910+DmySMalvyeTlbfNXwNLwiFXipeLtLdMMI1kIDSMsrhIsxk1jfO62ZMDc7iBeg7PPB8uTnDNPpcOYPQmQKcMjmEgByvXfoml3z0HFm97IaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOkiEMrSIUPPN0JlMxWyk4CrqSZSYP+t2v2OA6Fa/XI=;
 b=q0khoKMRMJW2oS7qAhHAdEg6vWz08npLOdzXDyXeNcQdlva1UZpB1sH5XbtZxw8J2leh3Wo/9luc+XnmxBurjXI+aI4JPT/CZ0JWEzLLgJ/2Vu3uhRLQzF42FxjzMRyrHADckA5kcuiTVYU6xgwmOBnpi6ziEO4STSqGLnRPPaLE4IpaKjlv2ymnqzt7ls419eXIZs0+B4klicoXhbqyGgqoOcWmWrVTud57qS2hqyoX73f8YyUxmvqniwvUfv/c38dzuzxiEZMiRdPaOYjVlkFKjDyEN7K6FkcfjxZqPDbXx3TUnNC2uSfcNDgKA8VaqQcfO5c8lmPdBbsa/Cn/MQ==
Received: from SJ0PR05CA0190.namprd05.prod.outlook.com (2603:10b6:a03:330::15)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 20:43:33 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::63) by SJ0PR05CA0190.outlook.office365.com
 (2603:10b6:a03:330::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 20:43:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 20:43:32 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:43:23 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:43:23 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 23
 Feb 2026 12:43:17 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Pavel Begunkov <asml.silence@gmail.com>, David Wei
	<dw@davidwei.uk>
Subject: [PATCH net-next 07/15] net/mlx5e: Drop unused channel parameters
Date: Mon, 23 Feb 2026 22:41:47 +0200
Message-ID: <20260223204155.1783580-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260223204155.1783580-1-tariqt@nvidia.com>
References: <20260223204155.1783580-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|DM6PR12MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: 162db9d8-a52f-448e-f0b8-08de731c359e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F64GokU378kFHeIsMlu78a4cyxRQlpDuUGD/BRqdeXRVjz65zIXmTSnYj6nU?=
 =?us-ascii?Q?aihDt6QSpsUU3Sc5moMbWX+wuDiByV8zdJ797cF/W7mSe2rUDqH3tVB0ihOA?=
 =?us-ascii?Q?udZx2tDbDpWzd0ZDBrAr4juJRfvXc8yJSW3V3s8a2FBHj0MJye1EIXEe9s/n?=
 =?us-ascii?Q?m8uWFnOA4ywexlzVCzMPxxfpE1owzEDr/wDvkCT+aaMfLQquCxHNlkYAC9HL?=
 =?us-ascii?Q?X8OixSB7w+361drtGPmYnuaLsP/L0l1jomGL3cIQGOpUqZNV42KdlMVu5BPW?=
 =?us-ascii?Q?eCH/esL6xLvaTfUJjvqIjXLAvrwu9p1cv1BghjkbAyhTK6dUeHJ/k8EPJ6z1?=
 =?us-ascii?Q?lcZcG2J5uRciaBltFd9NSSaRBiroG4oP/M7rwVEGpzO5KLBjePfelXMXrz74?=
 =?us-ascii?Q?iI9OcoXeJ2BUrS25q1LnmJIlSKB8CxaLDTFsfwQbGlRodV1+HhosYlZ2uCrR?=
 =?us-ascii?Q?n32mGTjyrwHZMeRQRvKfxlo2ZkSGAPIwQM4sJjpLxTUiHR7h63cKi0VJ4wsr?=
 =?us-ascii?Q?OfzC0yS4wn13Oze4tT8XpggSoZ39X9E+4eqSRCh1/bOvqJq75deM5C6W1Hf5?=
 =?us-ascii?Q?C1I0PS03Y+FtApNu+ChcPyxXXvIPIO0Q2II3z9JOte75fDHsvTKzjfK59S0k?=
 =?us-ascii?Q?85ykMJn+353jFALz+Xkkq9hvQknRjGZT0fk59I7tsDxywF5xDfDv9H71bX+B?=
 =?us-ascii?Q?Ke/RNB2QKnp8Fiekbshm87+F8Ju909ATseH48D1GvaMWiA64LDJd9Z4x7wq9?=
 =?us-ascii?Q?nZfyGt2t7uEZ54CdtPdqH6yUkEWiaHZo2OLVNa6Susb1IzG6NyfeaZqEEtIp?=
 =?us-ascii?Q?+CvqLElryrOCscBMZQNJlYKCseQyOavztgWDoPRSH43ZG889ZRW7mG95fU49?=
 =?us-ascii?Q?7Vav3BnFX7UUFlu8tVSQvUYOLkkZ3QpHwzNpAl4T4zQV2pcHFEFtDDWiPQc8?=
 =?us-ascii?Q?w2A1Xp7LmAne9WsxNM7x2VYjupyn5WMRU8mUQ/teYozSG9LAo4px8Fg/XX4/?=
 =?us-ascii?Q?wVxVvDkclJHZY5DM1KCY0nBOana9uGmFAnHnrNR5m65D45OdBWhrzpGx+MFo?=
 =?us-ascii?Q?yJ6b0iei6Hg5zyC1UrxHGchz6xnJXkuf9FHFOB0KepAbGH/d5TArJeYy5aqL?=
 =?us-ascii?Q?wo+liFAyfOWgdQ6UziHFDbSG8t6CNa38L1Zi+7oIRZKDL2Vd+FXPTWxJKE8K?=
 =?us-ascii?Q?+8sOC7Vwxi15nwYARy70DJ14E07ilVv4T36q/CIjzPGu7DxcEcqL7QQiKUL2?=
 =?us-ascii?Q?FiWxnvLkPqBB9X1KsBuP3dupahiezH3QBm5cAGwZCdk0rD/uN5FsO30W8rTf?=
 =?us-ascii?Q?6FvjMWGaiGi+3hxuoFLDpC+apSwTsVIrRqL2gBU/xhqA8uoyx8blktKiDiet?=
 =?us-ascii?Q?c3tui33cZVIcuQV0EGwzcBiWFeldqS61pA0bXxH7vQ6n/4Zs6mIsNeP1hpzz?=
 =?us-ascii?Q?+zMCMG1pEpvj2wqyZFwsIZgT3N/SA2D4j9/PL3YnVw6iPg7NpoXaqMDq3EXI?=
 =?us-ascii?Q?N6Gg3xsV/ZF12KYU/sHDqfTdLGU+p8JkjuM3hHzi0pvusZjk+NBcox7hy9cz?=
 =?us-ascii?Q?dSXIMCFFV3sVEye72Av6cHgBhGi5xuMa3+mmlqlRLi51LQO41ild3/XvbsVe?=
 =?us-ascii?Q?xEb2vsLnXiALmcVcNUdK5S9H4EPKM1+T7o47eVRYrXf5tpbpyy9SHufxRJdn?=
 =?us-ascii?Q?mXLnAw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FUU8Zw1dBUOS5+9guUfjQ1iu7dtOTHRQbSbHNJI9euk5qON+bWfSW4KucQOzn33LBT45O3g9DsJBnQDS/dM+NuihNV+ZhrrdgtD6B0l1K//MQ+400LZ/RZZYRMCSKZpOAvIEJpF/42vEWPES6+vq3EdGsnpRd3cS0lmkG11i6lo+QEgNsKh3bJiqgp7aUr/T/n4OTA3gABt/GX5mqUZbIclVW2Pa1NViOHOPrDc+zH0/4eV5PsTDrjyS8bYFRptffj7WYZ9okPz5xkj93K9HFv1Gqx9B2mWLrwzrp3Pe+yXrmEQ6ywsDlPqkVRahjXt7i+QKp/Tj+KuKkAayEXWrZvog54XOT4t/kmehmT34xe2xdVQ5JPBwv7XysFdY7OqF2v2A8jcw/E7HY+LdxsOdk1PGklcTkg/9H9QFD+kEqV5Hs8SPuZBnyhq+WjACA0SW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 20:43:32.8707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 162db9d8-a52f-448e-f0b8-08de731c359e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369
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
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,davidwei.uk];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17071-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E6C6917D2FC
X-Rspamd-Action: no action

From: Dragos Tatulea <dtatulea@nvidia.com>

The channel parameters from struct mlx5_qmgmt_data are
built in mlx5e_queue_mem_alloc() but are not used.

mlx5e_open_channel() builds the channel parameters internally and those
parameters will be the ones that are used when opening the queue.

This patch drops the unused parameters.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 9e406275e243..aca88fed2ac7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5555,7 +5555,6 @@ static const struct netdev_stat_ops mlx5e_stat_ops = {
 
 struct mlx5_qmgmt_data {
 	struct mlx5e_channel *c;
-	struct mlx5e_channel_param cparam;
 };
 
 static int mlx5e_queue_mem_alloc(struct net_device *dev,
@@ -5566,7 +5565,6 @@ static int mlx5e_queue_mem_alloc(struct net_device *dev,
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	struct mlx5e_channels *chs = &priv->channels;
 	struct mlx5e_params params = chs->params;
-	struct mlx5_core_dev *mdev;
 	int err;
 
 	mutex_lock(&priv->state_lock);
@@ -5590,11 +5588,6 @@ static int mlx5e_queue_mem_alloc(struct net_device *dev,
 		goto unlock;
 	}
 
-	mdev = mlx5_sd_ch_ix_get_dev(priv->mdev, queue_index);
-	err = mlx5e_build_channel_param(mdev, &params, &new->cparam);
-	if (err)
-		goto unlock;
-
 	err = mlx5e_open_channel(priv, queue_index, &params, NULL, &new->c);
 unlock:
 	mutex_unlock(&priv->state_lock);
-- 
2.44.0


