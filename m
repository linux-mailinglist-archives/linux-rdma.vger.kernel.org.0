Return-Path: <linux-rdma+bounces-15974-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /e6EMRcAdmm3KQEAu9opvQ
	(envelope-from <linux-rdma+bounces-15974-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:35:51 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4870D80529
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E6E673014F48
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 11:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E05A31B130;
	Sun, 25 Jan 2026 11:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GWTW31DF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013035.outbound.protection.outlook.com [40.107.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A447931AF36;
	Sun, 25 Jan 2026 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769340837; cv=fail; b=U6/ebWMSehh9AKa3/Qxo529AEJDg7GFpAguym0LIjjb0cFdlE2+wgDR48kT2ks4Um4CFEuz0p173UTiMbomKJVVKk3DqodAC7h1xQbPITPWrhFpk/SIw2bJGUfQWMwK0ssJaEOnmd6+0Cmb55Hj5FRq0LQC6xNTcZXTtqpYEqtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769340837; c=relaxed/simple;
	bh=CoOX0QahYJJhr6dkWPa5fID6RpGcjaiCKmqnB829i34=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WOglmf5neqlMOrA2k6WiUW6iJkG8M52VZTualGUeB7hGwq15w/csXzM4PMLA2NYgt2ZEm8L2S/4mrrekjbzL36y+l1NGDA2MpAN2R1uISR81g+K8qyvaiWWNK8DjjeUKur5hPG9CARCL1X1JW4J0iGrI8qfIPajKZCpiKsOCPVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GWTW31DF; arc=fail smtp.client-ip=40.107.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1CPJkOxnoijntHg+zcIG6l5vN6Yb0fJ6nQ5/bMfBpXPR7S0JtqMzkOh1O0MY0UsHBqPxbquNqajHU8BvtZYJaKiUrZyriXPtRLDfP4SdRlMkg4PKwLZrZZ35cHvpCvqhrc3U078SJVUALSUNj3q8QbY6IYPWENk/6F5gfJd+Ax8YCHgB/+0+hFk9joleEr6XrFZ5raNUBrgWaLPS0YbD+1w8HlFj7ZGOCaxuXvPTsCWmws7V+2Vcyzhc73U4P63fB4tnATdOe83IfDtqPnFjZ9kFAEqZFUZoLH4p1dDdlNi/SVyKUXmnS0notl1wQHO5msmyUl5G8MeA92Hg/C0cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehQXVbEGwOm3+uh1wi9aVSWmGjCNyf/+uuOmBmq8Y24=;
 b=mkoIctYEcYnAxHHFmQC4ZCaDrXoC+akZZ1w8jzqhSqvgE5lBNPwACmBB68KPmit1QiPBA6eQUeO/4SbIYhhAZ0cMFLiYztD2LUa4TspfGzKTmJL5Ui4wNVwk0pffIlsYJVlivaDmxBnetBUcZKl9l7jvhdj9Dho9T4SaUMYvkSl+sGflOwK0moKIIKG3z4z3Ey8UYH/wuGPUrnsjQ7lmd+gofsiqykM+7OmXigNIxFETsMqy46UbbaIu06NbZrQEpI2vT9eimLFftTpIuaTUw8xs5xI2SQQ2qymene3HsQFBfOwm/oj3WIlSb2jYR4TzfUi/XCDbeRbtEmxtxXR+Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehQXVbEGwOm3+uh1wi9aVSWmGjCNyf/+uuOmBmq8Y24=;
 b=GWTW31DFcQZJndBBKUmiZDP6B91ij8TyxuhBU84aGcsVRR6MHQG60L2DqAFV0FgbkXmEgh6hgPJLS1aohe3U/2/gfPkr6aDAXVO9pzzJR6GfdSFTvZfBqlbVEAWT9s7+I8KrrO+0ITu/kqWY4voiHIiLnQsiIm/FfdGRs7K6a5uvpcyq3cTPXL+GHILi3ECNKa4qTToAH/a2q6Vn4/VCKbW8njnNzYyvhCnvwy4Gep1ysXcelNP82d4IQo1QD/a5XCXmZcmM0Nfi4/hqEfu4P9drbtT+BwLDe7hI3plBOUrt45cZI3vcMjZnq3c5ifevtX1g4nCTaaSGMJd6JfgYfA==
Received: from SN6PR16CA0065.namprd16.prod.outlook.com (2603:10b6:805:ca::42)
 by CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Sun, 25 Jan
 2026 11:33:49 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:805:ca:cafe::64) by SN6PR16CA0065.outlook.office365.com
 (2603:10b6:805:ca::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.14 via Frontend Transport; Sun,
 25 Jan 2026 11:33:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Sun, 25 Jan 2026 11:33:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 03:33:36 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 03:33:36 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 25
 Jan 2026 03:33:31 -0800
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
Subject: [PATCH net-next V6 09/14] devlink: Allow rate node parents from other devlinks
Date: Sun, 25 Jan 2026 13:31:58 +0200
Message-ID: <1769340723-14199-10-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|CH2PR12MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: 0955e640-7007-4725-fad1-08de5c059bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E45hiVxJT/Qt0FRoakrbjkThKj8ynL1YS4ttz7bs0hUkc+iAA6rrEt5Pba6Q?=
 =?us-ascii?Q?tAbIkaOWUuCvKLFudMFPFiJP8sVfdfPsMlz0EC+jVSgLl3vuq10bUaMlKkoZ?=
 =?us-ascii?Q?9JECtzDh6IgGTaTrEXnkXd11DTk643T/qz6eV1ZDTEUl6dUW9hM8zSWsbQLE?=
 =?us-ascii?Q?Ro+/XMJspaXXisBt8eDutyOKLtmHORsQRWEsvYXM4FjTa1FiQjz3nxARtETJ?=
 =?us-ascii?Q?8KOKtx8hKA++krv/PzgFYWOT1Hr7PnQ3zhws12OOL7SncHCARtaQ34UhRk83?=
 =?us-ascii?Q?99puSEUCodIx+bz3s4rYRmVZPBulAYD8nuLWiSo7n+huDu+VCTDRvStC20DW?=
 =?us-ascii?Q?ZonVvtk9jtsiNBydOQ62YnQhmVsXWqfGhhO/Hki5JW3lcvS2Rkt4aSb8Uc59?=
 =?us-ascii?Q?CNrg4U7yXkQZHVk+G8OV3Rl6eJVv8C9alDc9w8xtYSBy1XxfGSGVXJxSKJZU?=
 =?us-ascii?Q?AqrB/Mfy7Ed2caGzyJTBrT3ahYLATfxNM9JL10IccR4YdfLNo4+rTY/CFIFB?=
 =?us-ascii?Q?Oozj4h3OdVQcP44rFPCWyavSMNw2atWNSk9FhMZd3U0dFTD6XtBopfWsFMch?=
 =?us-ascii?Q?9BBbmtp7C03veT6cyQ6QpW3+7xf0WGPo/ck1b7ztyI7U1efuEwQQXx7vtjHp?=
 =?us-ascii?Q?xa2iMoMdxQaYt3OSP6o1vWASO1Z4Q6KNRiBLvReYKhqkNv30DXFVQIU8mB1t?=
 =?us-ascii?Q?vW/0bi2GubDd/Rm2VKYowIYwqhHwimOupIwJQ5hnIzwlMA1NXSM5D6xGSH5i?=
 =?us-ascii?Q?fpAr6JznhOUSHx6k48TKw/7Ey0ea7YFJcvO9MNZu5I6oPIH+GPwhHT5Hu0mF?=
 =?us-ascii?Q?cdYi6KmE84F6nNfe2RTOB0yFL+UJ1UoizbvVKh2wfy8i0CkTt7D92L9N/nQX?=
 =?us-ascii?Q?2PRVFu9ll5OqXZHQ344Sh1fVIQZShHoZpQ4jQNpfMjvmS7SnQg99kitNwVb3?=
 =?us-ascii?Q?d9d0Nzpd4Rh+nMxORkmOV+Ndo8tWyZ1dhE+49r8x8eOKfE0JNo7SpVrDVQdh?=
 =?us-ascii?Q?dX5ZXdY1Wvm2oE0H1nGTqJp4N0uyQMDhdQU/hNnHgLsiIS2kCnDrT+uT9em8?=
 =?us-ascii?Q?TT7tBhGXxV83+P3H1SF8pATwNMSyzVBODBWMYqjpr4011izR3oqC89/zj2py?=
 =?us-ascii?Q?qG3K3JJiTy91Z32/lvLFj2pSKIak2R7LAuD/lOt4cn+Bx6/y6c1R1L+vSFta?=
 =?us-ascii?Q?kFlMiX/rA6E96Ua6VX8IrGzUqllnvViEgi9SWGVr0RlhZ9K6K9HE7d7BYk5g?=
 =?us-ascii?Q?10eT2ZDdVs0vcPcZ9DsiYFywCTE9UiNs2FdY7HO/DiU3rGo3gMMPvPSYmErg?=
 =?us-ascii?Q?Go11jsSr9uSJSLGGQMpeGj28NlilMggwuiTuk0AJmuDT2UT7iCXdQBq6xhef?=
 =?us-ascii?Q?P+cHK4JGTIIMbHEjhYadUW/tNw4ruMz8vDHxpopiJabYy0hJ+OFgICI4wKMM?=
 =?us-ascii?Q?jl/GG/WJxbkyxmGH7NSVjltQkRu6AhjahmTY3FqFV1cwGL6/zlU3w5j29+El?=
 =?us-ascii?Q?3M9+xnQZb9IL6dz9TLEejMvNOItiDsWwx6wGkgkhdjievjIW+eBEfH1sB8LT?=
 =?us-ascii?Q?/bN5ieVfuyb2C0+uZR7ugus26CdoV+v0Rw7VuPdwb1zemgmldlVcGiaHDMSj?=
 =?us-ascii?Q?Gf8Y28OSai1JT4uiPE5wX5unH+zRx8J8875nfIVdEYYkweQlTs8dgMtaTV4E?=
 =?us-ascii?Q?F871jA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 11:33:49.1429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0955e640-7007-4725-fad1-08de5c059bde
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
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
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15974-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4870D80529
X-Rspamd-Action: no action

From: Cosmin Ratiu <cratiu@nvidia.com>

This commit makes use of the building blocks previously added to
implement cross-device rate nodes.

A new 'supported_cross_device_rate_nodes' bool is added to devlink_ops
which lets drivers advertise support for cross-device rate objects.
If enabled and if there is a common shared devlink instance, then:
- all rate objects will be stored in the top-most common nested instance
  and
- rate objects can have parents from other devices sharing the same
  common instance.

The parent devlink from info->user_ptr[1] is not locked, so none of its
mutable fields can be used. But parent setting only requires comparing
devlink pointer comparisons. Additionally, since the shared devlink is
locked, other rate operations cannot concurrently happen.

The rate lock/unlock functions are now exported, so that drivers
implementing this can protect against concurrent modifications on any
shared device structures.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../networking/devlink/devlink-port.rst       |  2 +
 include/net/devlink.h                         |  5 +
 net/devlink/rate.c                            | 91 +++++++++++++++++--
 3 files changed, 90 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/devlink/devlink-port.rst b/Documentation/networking/devlink/devlink-port.rst
index 5e397798a402..976bc5ca0962 100644
--- a/Documentation/networking/devlink/devlink-port.rst
+++ b/Documentation/networking/devlink/devlink-port.rst
@@ -417,6 +417,8 @@ API allows to configure following rate object's parameters:
   Parent node name. Parent node rate limits are considered as additional limits
   to all node children limits. ``tx_max`` is an upper limit for children.
   ``tx_share`` is a total bandwidth distributed among children.
+  If the device supports cross-function scheduling, the parent can be from a
+  different function of the same underlying device.
 
 ``tc_bw``
   Allow users to set the bandwidth allocation per traffic class on rate
diff --git a/include/net/devlink.h b/include/net/devlink.h
index fbb434185a67..1165dc1ae165 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1585,6 +1585,11 @@ struct devlink_ops {
 				    struct devlink_rate *parent,
 				    void *priv_child, void *priv_parent,
 				    struct netlink_ext_ack *extack);
+	/* Indicates if cross-device rate nodes are supported.
+	 * This also requires a shared common ancestor object all devices that
+	 * could share rate nodes are nested in.
+	 */
+	bool supported_cross_device_rate_nodes;
 	/**
 	 * selftests_check() - queries if selftest is supported
 	 * @devlink: devlink instance
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index c062fd8a6c36..3d28a4c5bb5f 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -30,20 +30,56 @@ devlink_rate_leaf_get_from_info(struct devlink *devlink, struct genl_info *info)
 	return devlink_rate ?: ERR_PTR(-ENODEV);
 }
 
+/* Repeatedly locks the nested-in devlink instances while cross device rate
+ * nodes are supported. Returns the devlink instance where rates should be
+ * stored.
+ */
 struct devlink *devl_rate_lock(struct devlink *devlink)
 {
-	return devlink;
+	struct devlink *rate_devlink = devlink;
+
+	while (rate_devlink->ops &&
+	       rate_devlink->ops->supported_cross_device_rate_nodes) {
+		devlink = devlink_nested_in_get_lock(rate_devlink->rel);
+		if (!devlink)
+			break;
+		rate_devlink = devlink;
+	}
+	return rate_devlink;
 }
+EXPORT_SYMBOL_GPL(devl_rate_lock);
 
+/* Variant of the above for when the nested-in devlink instances are already
+ * locked.
+ */
 static struct devlink *
 devl_get_rate_node_instance_locked(struct devlink *devlink)
 {
-	return devlink;
+	struct devlink *rate_devlink = devlink;
+
+	while (rate_devlink->ops &&
+	       rate_devlink->ops->supported_cross_device_rate_nodes) {
+		devlink = devlink_nested_in_get_locked(rate_devlink->rel);
+		if (!devlink)
+			break;
+		rate_devlink = devlink;
+	}
+	return rate_devlink;
 }
 
+/* Repeatedly unlocks the nested-in devlink instances of 'devlink' while cross
+ * device nodes are supported.
+ */
 void devl_rate_unlock(struct devlink *devlink)
 {
+	if (!devlink || !devlink->ops ||
+	    !devlink->ops->supported_cross_device_rate_nodes)
+		return;
+
+	devl_rate_unlock(devlink_nested_in_get_locked(devlink->rel));
+	devlink_nested_in_put_unlock(devlink->rel);
 }
+EXPORT_SYMBOL_GPL(devl_rate_unlock);
 
 static struct devlink_rate *
 devlink_rate_node_get_by_name(struct devlink *devlink, const char *node_name)
@@ -120,6 +156,24 @@ static int devlink_rate_put_tc_bws(struct sk_buff *msg, u32 *tc_bw)
 	return -EMSGSIZE;
 }
 
+static int devlink_nl_rate_parent_fill(struct sk_buff *msg,
+				       struct devlink_rate *devlink_rate)
+{
+	struct devlink_rate *parent = devlink_rate->parent;
+	struct devlink *devlink = parent->devlink;
+
+	if (nla_put_string(msg, DEVLINK_ATTR_RATE_PARENT_NODE_NAME,
+			   parent->name))
+		return -EMSGSIZE;
+
+	if (devlink != devlink_rate->devlink &&
+	    devlink_nl_put_nested_handle(msg, devlink_net(devlink), devlink,
+					 DEVLINK_ATTR_PARENT_DEV))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 static int devlink_nl_rate_fill(struct sk_buff *msg,
 				struct devlink_rate *devlink_rate,
 				enum devlink_command cmd, u32 portid, u32 seq,
@@ -164,10 +218,9 @@ static int devlink_nl_rate_fill(struct sk_buff *msg,
 			devlink_rate->tx_weight))
 		goto nla_put_failure;
 
-	if (devlink_rate->parent)
-		if (nla_put_string(msg, DEVLINK_ATTR_RATE_PARENT_NODE_NAME,
-				   devlink_rate->parent->name))
-			goto nla_put_failure;
+	if (devlink_rate->parent &&
+	    devlink_nl_rate_parent_fill(msg, devlink_rate))
+		goto nla_put_failure;
 
 	if (devlink_rate_put_tc_bws(msg, devlink_rate->tc_bw))
 		goto nla_put_failure;
@@ -320,13 +373,14 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
 				struct genl_info *info,
 				struct nlattr *nla_parent)
 {
-	struct devlink *devlink = devlink_rate->devlink;
+	struct devlink *devlink = devlink_rate->devlink, *parent_devlink;
 	const char *parent_name = nla_data(nla_parent);
 	const struct devlink_ops *ops = devlink->ops;
 	size_t len = strlen(parent_name);
 	struct devlink_rate *parent;
 	int err = -EOPNOTSUPP;
 
+	parent_devlink = info->user_ptr[1] ? : devlink;
 	parent = devlink_rate->parent;
 
 	if (parent && !len) {
@@ -344,7 +398,13 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
 		refcount_dec(&parent->refcnt);
 		devlink_rate->parent = NULL;
 	} else if (len) {
-		parent = devlink_rate_node_get_by_name(devlink, parent_name);
+		/* parent_devlink (when different than devlink) isn't locked,
+		 * but the rate node devlink instance is, so nobody from the
+		 * same group of devices sharing rates could change the used
+		 * fields or unregister the parent.
+		 */
+		parent = devlink_rate_node_get_by_name(parent_devlink,
+						       parent_name);
 		if (IS_ERR(parent))
 			return -ENODEV;
 
@@ -644,6 +704,14 @@ int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
 		goto unlock;
 	}
 
+	if (info->user_ptr[1] && info->user_ptr[1] != devlink &&
+	    !ops->supported_cross_device_rate_nodes) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Cross-device rate parents aren't supported");
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
+
 	err = devlink_nl_rate_set(devlink_rate, ops, info);
 
 	if (!err)
@@ -669,6 +737,13 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!devlink_rate_set_ops_supported(ops, info, DEVLINK_RATE_TYPE_NODE))
 		return -EOPNOTSUPP;
 
+	if (info->user_ptr[1] && info->user_ptr[1] != devlink &&
+	    !ops->supported_cross_device_rate_nodes) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Cross-device rate parents aren't supported");
+		return -EOPNOTSUPP;
+	}
+
 	rate_devlink = devl_rate_lock(devlink);
 	rate_node = devlink_rate_node_get_from_attrs(devlink, info->attrs);
 	if (!IS_ERR(rate_node)) {
-- 
2.40.1


