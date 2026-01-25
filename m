Return-Path: <linux-rdma+bounces-15975-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPDOOOwAdmmMKQEAu9opvQ
	(envelope-from <linux-rdma+bounces-15975-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:39:24 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E2B80611
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4008300A50C
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 11:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257D9322B81;
	Sun, 25 Jan 2026 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dyGaYigP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012064.outbound.protection.outlook.com [52.101.43.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D41C31D730;
	Sun, 25 Jan 2026 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769340842; cv=fail; b=AQT2omyvNuS0DaKItsJuSAAMsACgPHkIJhMDvxcA46mKdKiUYGYMtElnkDoXreilmuueOdoi6IPQJXLNeMCO+VgMDyKIFXgnGaXQCnwrPl/7Bv1ethqUW6QSf6q1WatO4INJF+tn7MWRzfudipV5WBr5+Yqqay0PeziqPr0nAVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769340842; c=relaxed/simple;
	bh=ZqN2/i/xAyqMrMlEFho9nkeCjhRbEtiwujdTqjBFGhA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ax+yUUNN0IqFehqlJ2uFXI9R2aS7Qi70iw63g0AFZKcGMcD0K+BIqy+EkN9QBFUQ/pF7G+hXAmgVPx+7Gp1a/QRHHerbVDVNGK0OKOtaS/pSPBJyWs5ysQE4OOnix9HV5IJYys9ZtLlq169LnWqVa5oTx+pcqZRrd73rf6LDabk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dyGaYigP; arc=fail smtp.client-ip=52.101.43.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EB5dVbofHOOHOafxuRjPjd9zUOum+kohUYb4+Y2PzA7NtoobmChTFeTgonfInT0WjcNfWbcM1xLh5mX4R6SHr8WeF1A0gxDb3RqHvOgV4m4qLEluUaCIiGPXAEQShkcVvlNiX7C0HsioQDcHzAevQ/VYVUSXfl2KPapRFYRRzqTudKsm5BZ102ziSzLc7wluTMxMWM1yzSMMw35P4zExwowJhh9pCJQnMDWsLkeC3gXnJd059a1uMF5/Q8BtWzxbN/K/xPwHy3/N6K4YF4e3dcntcStFLhC4Wrm+vKiJ+96rPXAD1MPgaXJ45a5pAnIsWPQcuL8ezegz5ozDXLsA3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91pvQJtCkOYBQvDYlNcmUfcgleoMpL4U+OBizuLAUtI=;
 b=v002Fl2IU5dV7dJmeWVDBULk8HUQUxkqe0NoHLrY9+P/u7zLQllLlrdGoVK93zY+IkI2mjhEXf2nHb7qHFjRcb4fVEH+IDt5oso7hO3Oc7jpE7IhbhNZe+uWBklbIkMaO8z8GERmrnrfJOMwBUL1XVk1cznUPxeqrtpPWplrgN6NxwsZkEIpqy9jDjvD3Zk5/y6bT16xtu8FqHA8amAdBjLwB1WXQ3oItDSMfzUMNSpTzReLcYgRC37ooPj8yg6eh5mbVMzsvAZbVDH6PtzAqLHBrspG+dYJYEEpWkqlIm275/J0eBS373oV+UY1BtjcXrTRSaPHyyqHAN0lIChbeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91pvQJtCkOYBQvDYlNcmUfcgleoMpL4U+OBizuLAUtI=;
 b=dyGaYigPbR0uvK4op1mKHb+ngn2hzA0ecflf9gwC721qR/pkbCxG6DUs8r0FSkyLTw40MpEYQeEJuOi16dqXHc7prSB9Sdu1zpPlty5id9KybIvi9sAq6uF45u+DGqrLq2G4Q+ylEQ+sedu99iR2PhHmdVLIY/wL6QvZ9QHoNqtyLwgUmjGnLgPAMB4th80fL9jCAzw8eUIo2UI7kwPct5kxYOjPmEuw94T9ryZrHvhbNvpMt0y36EVFgpvpOAO/9WrOGlTDqGvLBUaZ9Bb4davABcMXYzVfQc0bAklNz1ZpA83XINh1lZTTYsodZFfr4OGZE2G9xcxzMvIeGlQtyA==
Received: from SN7PR04CA0157.namprd04.prod.outlook.com (2603:10b6:806:125::12)
 by CY3PR12MB9629.namprd12.prod.outlook.com (2603:10b6:930:101::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sun, 25 Jan
 2026 11:33:57 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:125:cafe::4c) by SN7PR04CA0157.outlook.office365.com
 (2603:10b6:806:125::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.14 via Frontend Transport; Sun,
 25 Jan 2026 11:33:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Sun, 25 Jan 2026 11:33:56 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 03:33:42 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 03:33:42 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 25
 Jan 2026 03:33:37 -0800
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
Subject: [PATCH net-next V6 10/14] net/mlx5: Add a shared devlink instance for PFs on same chip
Date: Sun, 25 Jan 2026 13:31:59 +0200
Message-ID: <1769340723-14199-11-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|CY3PR12MB9629:EE_
X-MS-Office365-Filtering-Correlation-Id: 85347287-596e-40c0-327e-08de5c05a002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sNDsiM57YD+TXDreysszFkp3qfWKEaTAiuIm1uzc1DYDIweVemm0+C1Re3NF?=
 =?us-ascii?Q?hXaXIDeAuEy5dRgIYrLJGN8VCnZFSaGbOQRicdzkhu0UDRtgD0HGD861XY3z?=
 =?us-ascii?Q?O3JH7N45VaOKqgg2fZPqkVJhUg/tdHoGrK0ACusADeW39Futviicieiyz7+/?=
 =?us-ascii?Q?JGcsdqUjyWycQlOVDZwkAycB5B85qIA4IGWqXvFgXVFvBPt+WYGGW9mQEmBO?=
 =?us-ascii?Q?j1guhZlvPFJEEQAPmbDm42ZgulrA+V1ZgwZHa5PO6Q0+l5U+pCzgopUmlyQI?=
 =?us-ascii?Q?4RfjvtZ2Q+/WtHX8WlQukR6vuVOEEzOm5UuHXAzvCDSWMYYkc7Y1AlvFBv07?=
 =?us-ascii?Q?9cZKkkQh8n+c2HOg6GLnzKHGksC1gifJC0YWCsGJ+y7QbPihThvWIcGtudEv?=
 =?us-ascii?Q?9+CtsTYePMxBmKJEfoB9GLPQcRLyMOMbWy8AdmFwttg7Xxbu7QVaczVZ9iys?=
 =?us-ascii?Q?So2JIkVpeSq0TxkcA/1Tg4fJnSFUhL+5I5IjQsI8+oS5adaVSG+KBK2bJZG+?=
 =?us-ascii?Q?DpGGRuybJmugZ0X2FSCadW2H2oiuJ6u2/DlnY6QRdzMeRH5NMGoWXZoSrLwb?=
 =?us-ascii?Q?N0JWtM+k0VUhlXuhC4ubIrXciWrxRCPVlq4VIUcNiDpurmnNy8jcdrmv/KaF?=
 =?us-ascii?Q?yDRcP0AIaM8pw5jLLAlDFaGDMqQEDcvEe1kFXTMa/LynvCzmQNxt/qPXN3rS?=
 =?us-ascii?Q?Btv9+OcYGydHcyRsMELzhAwYSqnG6Y8OzigAHKZeBpomKf/IQj2NSwAFeRTR?=
 =?us-ascii?Q?MTE1dis15nKyuk052jSLaOfxT8S6R8vv80p4p1Lvl3Pk2eBqwfF8n42by13x?=
 =?us-ascii?Q?zIBGm+V6I+VDOJrtcoEYr3AmjL1YfHrrTnvr7FSTto3woq45B8nEPtLHVqzk?=
 =?us-ascii?Q?Mtmo3JsjgmhgeYQw9ewSP5UckDFeKniL0DogpDoc/ouppnbofzAhN+p03Oj0?=
 =?us-ascii?Q?ce/v3DgF6rVRXnL8QAgoJ8ZF6qLMguWBY2FKZTcdVYOCV8GNDZbseQqwI5Ym?=
 =?us-ascii?Q?qMWEh799mRqzqxWqsvC6dpvKueCP66CATxFAods8SNljO3i/eEc6YfTbUlO6?=
 =?us-ascii?Q?7h2vBrYvRSQ9Zh1xB2vl+UwWLWo7MQs8cvQ49/oa0j29i58x+jc+jTuGH4gk?=
 =?us-ascii?Q?e6r26LiveBuB5SISqrO+rNNbMNqcDAN6VR4UcjdE6VbIj2nnmnUFzykoxril?=
 =?us-ascii?Q?hLXXp1tI9f0q8e6rNw1EtN2O5isMRyR50gcFY8HNdFo6qlsPeUdpGx4IdSXI?=
 =?us-ascii?Q?NmCkHJ9wZ4zpqFCSl8MRJsz+TkBJ6vqQPjfZCNVnYaJD3nCfxHH5+t+xSR0L?=
 =?us-ascii?Q?LYXNW/Z7D8lGsPq0hHNb/Hn3NypMK4T1hIuIC0ThdIJaCPf1bGwKKts5Twpj?=
 =?us-ascii?Q?n+hpvZiSgL+dJm3LwS+pfZ4apGe7UHgqy6d37vRxUr00iHqH0VnCxjGsZFdb?=
 =?us-ascii?Q?gwzrxAm1Dv3XZDDgtGE+qHIDrPLGgSywMKr+Ey29NTY1Cn7870qYunMtUG4z?=
 =?us-ascii?Q?28Qb42gXTRBcNkNQQNhXFEsj1PRYfCHWvHNvMFP59V1cQA//zU0s3X7zG7j5?=
 =?us-ascii?Q?EPDHZ0Ib/uc479hm1tKf1OmwGehwH6D2g6Q1OVNRRflmoyCgORA04HRIkJ3f?=
 =?us-ascii?Q?1jefJncki2NjnvKt3Bfr4eSQX6L17BOns5txnJ1821AKZF7EuBUTb5b+dOrV?=
 =?us-ascii?Q?Qk6XKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 11:33:56.0945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85347287-596e-40c0-327e-08de5c05a002
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9629
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15975-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,mellanox.com:email,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A3E2B80611
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Use the previously introduced shared devlink infrastructure to create
a shared devlink instance for mlx5 PFs that reside on the same physical
chip. The shared instance is identified by the chip's serial number
extracted from PCI VPD (V3 keyword, with fallback to serial number
for older devices).

Each PF that probes calls mlx5_shd_init() which extracts the chip serial
number and uses devlink_shd_get() to get or create the shared instance.
When a PF removes, mlx5_shd_uninit() calls devlink_shd_put() to release
the reference. The shared instance is automatically destroyed when the
last PF removes.

Make the PF devlink instances nested in this shared devlink instance,
allowing userspace to identify which PFs belong to the same physical
chip.

Example:

$ devlink dev
pci/0000:08:00.0:
  nested_devlink:
    auxiliary/mlx5_core.eth.0
faux/mlx5_core_83013c12b77faa1a30000c82a1045c91:
  nested_devlink:
    pci/0000:08:00.0
    pci/0000:08:00.1
auxiliary/mlx5_core.eth.0
pci/0000:08:00.1:
  nested_devlink:
    auxiliary/mlx5_core.eth.1
auxiliary/mlx5_core.eth.1

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |  5 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    | 17 +++++
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  | 71 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/sh_devlink.h  | 12 ++++
 include/linux/mlx5/driver.h                   |  1 +
 5 files changed, 104 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 8ffa286a18f5..d39fe9c4a87c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -16,8 +16,9 @@ mlx5_core-y :=	main.o cmd.o debugfs.o fw.o eq.o uar.o pagealloc.o \
 		transobj.o vport.o sriov.o fs_cmd.o fs_core.o pci_irq.o \
 		fs_counters.o fs_ft_pool.o rl.o lag/debugfs.o lag/lag.o dev.o events.o wq.o lib/gid.o \
 		lib/devcom.o lib/pci_vsc.o lib/dm.o lib/fs_ttc.o diag/fs_tracepoint.o \
-		diag/fw_tracer.o diag/crdump.o devlink.o diag/rsc_dump.o diag/reporter_vnic.o \
-		fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o lib/nv_param.o
+		diag/fw_tracer.o diag/crdump.o devlink.o sh_devlink.o diag/rsc_dump.o \
+		diag/reporter_vnic.o fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o \
+		lib/nv_param.o
 
 #
 # Netdev basic
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 4209da722f9a..9cd8361ca00e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -74,6 +74,7 @@
 #include "mlx5_irq.h"
 #include "hwmon.h"
 #include "lag/lag.h"
+#include "sh_devlink.h"
 
 MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
 MODULE_DESCRIPTION("Mellanox 5th generation network adapters (ConnectX series) core driver");
@@ -1520,10 +1521,16 @@ int mlx5_init_one(struct mlx5_core_dev *dev)
 	int err;
 
 	devl_lock(devlink);
+	if (dev->shd) {
+		err = devl_nested_devlink_set(dev->shd, devlink);
+		if (err)
+			goto unlock;
+	}
 	devl_register(devlink);
 	err = mlx5_init_one_devl_locked(dev);
 	if (err)
 		devl_unregister(devlink);
+unlock:
 	devl_unlock(devlink);
 	return err;
 }
@@ -2015,6 +2022,13 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto pci_init_err;
 	}
 
+	err = mlx5_shd_init(dev);
+	if (err) {
+		mlx5_core_err(dev, "mlx5_shd_init failed with error code %d\n",
+			      err);
+		goto shd_init_err;
+	}
+
 	err = mlx5_init_one(dev);
 	if (err) {
 		mlx5_core_err(dev, "mlx5_init_one failed with error code %d\n",
@@ -2026,6 +2040,8 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err_init_one:
+	mlx5_shd_uninit(dev);
+shd_init_err:
 	mlx5_pci_close(dev);
 pci_init_err:
 	mlx5_mdev_uninit(dev);
@@ -2047,6 +2063,7 @@ static void remove_one(struct pci_dev *pdev)
 	mlx5_drain_health_wq(dev);
 	mlx5_sriov_disable(pdev, false);
 	mlx5_uninit_one(dev);
+	mlx5_shd_uninit(dev);
 	mlx5_pci_close(dev);
 	mlx5_mdev_uninit(dev);
 	mlx5_adev_idx_free(dev->priv.adev_idx);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
new file mode 100644
index 000000000000..202f4ae99fa9
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include <linux/mlx5/driver.h>
+#include <net/devlink.h>
+
+#include "sh_devlink.h"
+
+static const struct devlink_ops mlx5_shd_ops = {
+};
+
+int mlx5_shd_init(struct mlx5_core_dev *dev)
+{
+	struct pci_dev *pdev = dev->pdev;
+	unsigned int vpd_size, kw_len;
+	struct devlink *devlink;
+	const char *sn;
+	u8 *vpd_data;
+	int err = 0;
+	char *end;
+	int start;
+
+	if (!mlx5_core_is_pf(dev))
+		return 0;
+
+	vpd_data = pci_vpd_alloc(pdev, &vpd_size);
+	if (IS_ERR(vpd_data)) {
+		err = PTR_ERR(vpd_data);
+		return err == -ENODEV ? 0 : err;
+	}
+	start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size, "V3", &kw_len);
+	if (start < 0) {
+		/* Fall-back to SN for older devices. */
+		start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
+						     PCI_VPD_RO_KEYWORD_SERIALNO,
+						     &kw_len);
+		if (start < 0) {
+			err = -ENOENT;
+			goto out;
+		}
+	}
+	sn = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
+	if (!sn) {
+		err = -ENOMEM;
+		goto out;
+	}
+	/* Firmware may return spaces at the end of the string, strip it. */
+	end = strchrnul(sn, ' ');
+	*end = '\0';
+
+	/* Get or create shared devlink instance */
+	devlink = devlink_shd_get(sn, &mlx5_shd_ops, 0);
+	kfree(sn);
+	if (!devlink) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	dev->shd = devlink;
+out:
+	kfree(vpd_data);
+	return err;
+}
+
+void mlx5_shd_uninit(struct mlx5_core_dev *dev)
+{
+	if (!dev->shd)
+		return;
+
+	devlink_shd_put(dev->shd);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
new file mode 100644
index 000000000000..8ab8d6940227
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5_SH_DEVLINK_H__
+#define __MLX5_SH_DEVLINK_H__
+
+#include <linux/mlx5/driver.h>
+
+int mlx5_shd_init(struct mlx5_core_dev *dev);
+void mlx5_shd_uninit(struct mlx5_core_dev *dev);
+
+#endif /* __MLX5_SH_DEVLINK_H__ */
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index e2d067b1e67b..3657cedc89b1 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -798,6 +798,7 @@ struct mlx5_core_dev {
 	enum mlx5_wc_state wc_state;
 	/* sync write combining state */
 	struct mutex wc_state_lock;
+	struct devlink *shd;
 };
 
 struct mlx5_db {
-- 
2.40.1


