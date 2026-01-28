Return-Path: <linux-rdma+bounces-16148-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP98L+z1eWkE1QEAu9opvQ
	(envelope-from <linux-rdma+bounces-16148-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:41:32 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F105A0A97
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D4603100C75
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 11:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2FE350A12;
	Wed, 28 Jan 2026 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rIl2ppYp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BC4350A35;
	Wed, 28 Jan 2026 11:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599748; cv=fail; b=hVRJqBFgjvRDJnM7Q6IO1RX48D4evvnQGsiHRBDenQOezjwuTdCZzpfupxyZD1ac2XS2I4w5UENIXq4D40NvP3Zw/xA8LJ9uIHYpqCxi/8WaZ4po3FTQdINakqfnldPeINDV+IZdP8WS7Gp51audTIQ/d0EvnfAgwkPBiSgzMuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599748; c=relaxed/simple;
	bh=4eeUc9RIHIgWXag318UGpUedrMXCEQ+cUkvCB4gfNTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sv43yVLja0+q2LCaVYq56zoLT7mZAzFASyTE/w7VvYvUGgzVkB0p4/8uw+6g9mZmjKYIRirsyWefpQz59aGoENweyyMsV3y8bAUzq5p9Ryj5kc3zPyULsbst0/Vq6+rl69NvO4T7hklRanlBpXl/Uhb1o+WPN+2NCNJTyiemzzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rIl2ppYp; arc=fail smtp.client-ip=52.101.46.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNqKtbGMfztUHSpHlSBjRSDrv/IUsfAq15smfoPd+wSwU5yPMYwvsDIRjlddvbur9sQZjBrPVi3Yt5hPt6lW5r0/mLqcjm+ix6QprXg7lNAXkdnUHJE8cAWxjkIJzOYXb1tJTaTxlmYwGfZmdBnaG9r1F0rqfGKDOn78Tl4LNDEhHuK5YxBq64SzP4UccWSCJahOqtnrN7cFIXu2YOlzt9pmIsuQ3JJdd0NNSSONobQGNvXzgzUZNuoIdTElO9xy98pCCCxHkf5bWsLScSsyFApiK1zl42jLq/Cr0jeH0PgLG8cHQMam6bWSqejL96x9kdDqC5cVxAMSYRO+rDigsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2unoNL8G4Xxr5VtprXpzS1NFU/fJvHFzPSMcT54g87Y=;
 b=SRz0PCDfBODDYM+X2gFBM8f9jd/RG9WoQ6JcXJtzZjdS8R6hGHscE0gjHOQSuXmj4/u7d/+rU8/qVFzwX4bnHimBm8B9qk1kkD3vrnnIXVyKaf6fGhL+CD0ABt9RPa6tBp61UI9VVt+r5+Ffh4cyCEvheyCaNgRBu16A4Cz+TYYinnnJtg/B5EQOTHSU1sfmeZH3mkGsaQLKdomSvx6W3nzlX9A/D01NOOUTbk0XDvWDcQVzZL4Y5Qnj1eZCKdUYQ+3Ip6wfuDXoyq2qMDi6+2xWuCFFSWKTGW5mjaxJJ1dxQ6zogBcRe5qPXn/2ttL8jyhNq5WZyZTe+1YUfMgtzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2unoNL8G4Xxr5VtprXpzS1NFU/fJvHFzPSMcT54g87Y=;
 b=rIl2ppYp2cfjujQeOwBzqnEfKVpYA5um+62CO6PkmrZfDjqECXTcicD9ur/fTklWsCUqewcWjD0i4L1U3v8r8Amf5BLiXNckvg/NdDL4VmO4g311IiqB7mKC9QSAONhwwAKOCuWbFh4kpRkyVQJYIuV+TUsisA3ubKSTRHQQeOLWfzoDFF6oUF2qPkjRs9S60ng+ztb/QlW3n6Z9xm0NRyLSvz9Dz0eixe2iu8ongdnK+MBR+IY8hThLEnrddYBAFltAESgy2Qr6kaMIN8+cbrjPFjGyRtbRaKiYaQ7M7tfkAdtd2OohBziyAzBj34t3n9neBd8IGnbuZHWW7XKs7A==
Received: from SA0PR11CA0047.namprd11.prod.outlook.com (2603:10b6:806:d0::22)
 by DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 11:29:01 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:d0:cafe::34) by SA0PR11CA0047.outlook.office365.com
 (2603:10b6:806:d0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Wed,
 28 Jan 2026 11:29:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 11:29:00 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:28:49 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:28:48 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 28
 Jan 2026 03:28:43 -0800
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
Subject: [PATCH net-next V7 14/14] net/mlx5: Document devlink rates
Date: Wed, 28 Jan 2026 13:25:44 +0200
Message-ID: <20260128112544.1661250-15-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260128112544.1661250-1-tariqt@nvidia.com>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|DM4PR12MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: be471104-1475-4262-6387-08de5e606f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8IRZeV+d+M7Lmw9P6vweNwL5C4I4Vs75MYChM+YZu4uRU1nRj5dEHrpf/xgu?=
 =?us-ascii?Q?9ugYIQYEioEtEIkyxyuRf4KjBfmDcXgCiv0L9labK6p2IQbs7mAFAUpEQutf?=
 =?us-ascii?Q?+Oup3Z4GanFj8ZzP7c/0o/M4jeYheNLEoU/INzsewQvDSBLqBCI5KImKDrHh?=
 =?us-ascii?Q?j80gZp7S6SoyK8Hp5yiR71JSITY3vAlnPRHUxjo+Kix4egZfOvStUn/NoioN?=
 =?us-ascii?Q?WWOnCCTSjT02V1c5FhS7Fr9IvtGM0m/eUqScOEAI4qz6ahKR8LJ3eRlbjCWv?=
 =?us-ascii?Q?2fjQOntT2VbWZKVJCjGYdTSHcr9Q0KQ5YS78KC9T5v0qlwrevumi8Y9ADNc0?=
 =?us-ascii?Q?3ggiUuzV7KNwmWEtN4jINHc3RShYIIbwfF+lNl8l+R6U7yaqY7NxrpJpLVGI?=
 =?us-ascii?Q?lz5Yz08GOOdnRm9Zr/GleZOeLR6LxXEk1DaNawkjgctGDl2CkcI+vjvCKd2k?=
 =?us-ascii?Q?UbQZ30dP6gshlqkE48B+yVifhhslZDPgoww0VMqfLoxxOT1yVNsg8M5KOJ39?=
 =?us-ascii?Q?pk+4DK1/oGV1k79YiRlUe9tHbpBo/OfolCaRNlF9lo/WUHA9WIECz41a5wx8?=
 =?us-ascii?Q?1EtIDdsF8HFFCQ7hZUKamPbgh4VEvqI2xorQAXVGoszN37FWqga8LSzQKN6g?=
 =?us-ascii?Q?3y768HyBOhve63yhvxe2i4BTwzuLQ+3SoDH0BwPeNRun2l1FTSqdqzv3VuKk?=
 =?us-ascii?Q?MhAvldMaQrZIOa6UpD0axstou1IR6JWUtXLTkj+keaQCfbDSHSrK7ONS9i/F?=
 =?us-ascii?Q?ywZJ0r5C9rSaqGYZL33uF1qUwktszCt/07lt4Cbs60wXq8a8z4JxM5LvkUIM?=
 =?us-ascii?Q?KZcWdps4yPvXNGcFceJ+jzsWSD6IBIJCVjX19V3mmz2PD6tvK6JKb3rhkEiq?=
 =?us-ascii?Q?beVr4+UwhmkbNoUQq06GEeVV90fFTjj5ZtpjJnqq2MJKUHFkkm9w/e0OqiKo?=
 =?us-ascii?Q?od6/dRUYOWIuAoOHDkQj1OLsbLQl99VzelXNtl2ac+Lk2NvWrEHvcAlz6XtU?=
 =?us-ascii?Q?VeeryN0Nh2BIcAXnpIFOe4LVPK9dwpKMWz4x2xwbvTvbJWVAde3ubbbNF/bc?=
 =?us-ascii?Q?gmcKFCja4xM1kmdWOMFncrpQFotrlRCYbV9h2GsBhqm9gnd8k7/cT8Eg89CN?=
 =?us-ascii?Q?l2Fbh7NYSGWwQLJ2GBy6IEX32u2rOO6K8n3rRg5Dx4lP9HzfTI6brSRV5N0/?=
 =?us-ascii?Q?lWng+HjbFVEFheaKR9h6Wb1qYPRw2NiUJokybY/lFO6IdF1fUUVZcp6Lf50T?=
 =?us-ascii?Q?cpy8J4hp15D+cVGOEnbI8T3BEnIWpbml55ir69Dh1ofsZKVyUUw3bkE0VZSt?=
 =?us-ascii?Q?FusqDLvAgm57umM/ypiYE5KEmhMPsAQhOm9RO2V92TxOXdiP9MM9s5PTZMSW?=
 =?us-ascii?Q?Ql5zMG/Jog7KjOfZ0VdP7vYCRW2xeITN/eb5arQp8sZzEENN5sAUUycMM8gx?=
 =?us-ascii?Q?0R+EKYfsQ6rYuxc/LAxKRQ1KdwD6OaOnQcbig61vDS7e8q6DDg3p+9GnqtZ1?=
 =?us-ascii?Q?elVCVQjjOBPqun8i+cndfQNY/u2KgYnKyKw5cCgx/NxkXCbeZfOqXc6bj0uI?=
 =?us-ascii?Q?dOf/8lczzb3mjlb/jSzZWMjrSESt7Ze83/4W7+tMjAwOKVjLu7ifQObT9kcX?=
 =?us-ascii?Q?v2zm/mrC/2KW4YHitYqWIBNygG9p9n9m6hZ3FY8Gps7YOV9LDSVafsnx6dqG?=
 =?us-ascii?Q?osFSWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 11:29:00.7225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be471104-1475-4262-6387-08de5e606f2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16148-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4F105A0A97
X-Rspamd-Action: no action

From: Cosmin Ratiu <cratiu@nvidia.com>

It seems rates were not documented in the mlx5-specific file, so add
examples on how to limit VFs and groups and also provide an example of
the intended way to achieve cross-esw scheduling.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/networking/devlink/mlx5.rst | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 4bba4d780a4a..62c4d7bf0877 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -419,3 +419,36 @@ User commands examples:
 
 .. note::
    This command can run over all interfaces such as PF/VF and representor ports.
+
+Rates
+=====
+
+mlx5 devices can limit transmission of individual VFs or a group of them via
+the devlink-rate API in switchdev mode.
+
+User commands examples:
+
+- Print the existing rates::
+
+    $ devlink port function rate show
+
+- Set a max tx limit on traffic from VF0::
+
+    $ devlink port function rate set pci/0000:82:00.0/1 tx_max 10Gbit
+
+- Create a rate group with a max tx limit and adding two VFs to it::
+
+    $ devlink port function rate add pci/0000:82:00.0/group1 tx_max 10Gbit
+    $ devlink port function rate set pci/0000:82:00.0/1 parent group1
+    $ devlink port function rate set pci/0000:82:00.0/2 parent group1
+
+- Same scenario, with a min guarantee of 20% of the bandwidth for the first VFs::
+
+    $ devlink port function rate add pci/0000:82:00.0/group1 tx_max 10Gbit
+    $ devlink port function rate set pci/0000:82:00.0/1 parent group1 tx_share 2Gbit
+    $ devlink port function rate set pci/0000:82:00.0/2 parent group1
+
+- Cross-device scheduling::
+
+    $ devlink port function rate add pci/0000:82:00.0/group1 tx_max 10Gbit
+    $ devlink port function rate set pci/0000:82:00.1/32769 parent pci/0000:82:00.0/group1
-- 
2.44.0


