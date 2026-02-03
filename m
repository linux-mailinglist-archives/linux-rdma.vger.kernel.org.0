Return-Path: <linux-rdma+bounces-16413-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA8DC3eggWkoIAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16413-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 08:15:03 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFC2D59FF
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 08:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C9C930976E7
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 07:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317CA392C2A;
	Tue,  3 Feb 2026 07:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RmnPPfXA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012066.outbound.protection.outlook.com [40.107.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB82C392838;
	Tue,  3 Feb 2026 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770102724; cv=fail; b=t+pqDxJ+IGUn2PfdP06ctzqTdicngt/djleNZCmbdDZN/9gAtClZDhNbuhJEO06QY/fSST0tX5/csp473C0psnDKHFlNl+/BEGWV+IuKFySkhj1UEGDvXCuqxRfd1rfVzxBIJ7wFzsoQU1e3h0bQ9NO62fqlx9VryOdCxyAyZxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770102724; c=relaxed/simple;
	bh=IeDfjw48HmZ3YdMpG3r21iM0qs71h8hcjNaJ+NF4vL8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhlXsXYAfwKMn3mLVA+F2c1kLiC7RDMZ6qCdEafC92cwHGD0JkZ4tUz54cMy8aLCykB5fU64ETRByP93Kmdxj+AXT+q5PMcjw2yJn8LlKD/X3k2U7zN2fq5XEy6jE+lKT4/kT9ibeRW49F950kyQKpsVPHnanXA8OTlH5GIXGdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RmnPPfXA; arc=fail smtp.client-ip=40.107.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSSqjRZj5ygLpzDR2hKsOTuKhj5V1SGEbzOfUmkNi/+3u8M5ig/znR3Vv8AzZchViukz6ZOrCdyfW70a3stra9WleXQsmj68DNgZogu/tGrjdgv3V0ffVYV8hZfgWtyhKm4KWmSylc2DwIg8gYz1ezslT6Snx2xDSUVaFvSuDy93AGQcak6XeCLOiOVI501PDc2m64UCG/ytPA0LdmrQGwW4+3HIqi1jVn1nDzdoCCVz6da3/BxHFNY+LiyOKgU+kXEAvcySVIvLCV4+8OeJkWdB+N+Gp2biL4+wHNY8hs2JP0fDG6CLF3QFTqN0ABsY8fwage194PfEH+ytvT71cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoWkJA/x1MYMhZqgwhvoRYJPhCcqdNZBLJ/u6wfJcyY=;
 b=JwrhCC0TqpQEHTfa0o819AnViSzSQpnKcgtacz/JTPFEN/EesdWeqcRekl4YxcTxxsfjUz+7K/Nc+ssaPH5dppOQfgw54QsZx3GBlQ6/v1Cg8Ju8ZkfRBq36gXDjYQy+8Px9cbo0aULZwraeGKQcEVonFO2CVN5gavHi0eJf9lkV0Vo2KC4RSboYjBdq+itFisDvpfnvtYJLG0bn5Tit4c/KyO+Pty2CyzzVSN3ioi3rrse2b0vuPmKtSB19sjUZPpOehXpYQvoA5IEFixAJzEoLppV3C+8zDZVKpM7kND0Tn4rjcz+ICg9VnVodUk2EtWfCrTqtapcG6vEHJ2AbLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoWkJA/x1MYMhZqgwhvoRYJPhCcqdNZBLJ/u6wfJcyY=;
 b=RmnPPfXALHniL1WNtx0FKJNUD1LDgRONyry29zO9umpCQkUIcNFbDA/MB7zb2LEshOrmepnNdXe+7Rc/LZYceGwwj8gVlnjwNFqNquQBWfc4bzoKy+F624lPZ/ANB4+UUmOzQTBHYjyJsJcmDFEy9bLw+3zJwuVeS5Odz8ndnUCOkj4uGHMuOhN1uoAOdgDVt2Ksu/948/DIg7Gx9a+1COM+obvavbvf5b78fn3hpSkVJQ9jURRPEIxbzsD5cmIuPhVz5mq1LliAHr0nASvBVA4uyqaWs3wa11mlKtQP2xIid3k3eNUeX1v0ntPRS0pqdQOHB7IK0U+7RqGeaXCVMg==
Received: from DS7PR05CA0070.namprd05.prod.outlook.com (2603:10b6:8:57::28) by
 BN5PR12MB9488.namprd12.prod.outlook.com (2603:10b6:408:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 3 Feb
 2026 07:11:56 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:8:57:cafe::28) by DS7PR05CA0070.outlook.office365.com
 (2603:10b6:8:57::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 07:11:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 07:11:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 23:11:39 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 23:11:38 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 2 Feb
 2026 23:11:33 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drori
	<shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>
Subject: [PATCH net-next 5/5] devlink: Document port-level resources
Date: Tue, 3 Feb 2026 09:10:33 +0200
Message-ID: <20260203071033.1709445-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260203071033.1709445-1-tariqt@nvidia.com>
References: <20260203071033.1709445-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|BN5PR12MB9488:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb59586-862d-4a99-d6dd-08de62f3840f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GDg2vsJO3riCoRsWPwBJ7TUU90kHMTfH5qrdnLrfgmnRbTPkMswTMr1hI1Zx?=
 =?us-ascii?Q?mqZzyq3q3UhZpCEw5fuTRVzp79AGgb0zSkvTcmQCHfrYSOzU8/bciz43ix2Q?=
 =?us-ascii?Q?yer19ldZIW4JDCmidwjSRapqqAkvf3axmGjqPT+S1SySMFLHxyQXk5/CVopn?=
 =?us-ascii?Q?96w9Aoitle35tgYWXrOR6M5PKaG7QafW+G/LhJrAzbAieUK0XyH4f444D5Jw?=
 =?us-ascii?Q?3v8urHjQYQpHPzKcuzvv0uqJFULwkcZcZhZxeac2cIcmFcpHz0iEsYitSkCL?=
 =?us-ascii?Q?VAwzDn6iHSZzqVwaAos/Ho4si0UUcmn+F+ZMrhcRfTQxbx914WipyGn8qOI9?=
 =?us-ascii?Q?kkGAjvIVHhcf2fPRudHSqIr39Lova4j62+8cynK5Soen/xLo3Q2N7kL+1r1b?=
 =?us-ascii?Q?t/r5mBMGchlkc5+N8ZkPlbgswXPVR2tnA/bokc448UFYZsh1ONxGM0vQsPhU?=
 =?us-ascii?Q?V8jAXSyQ5Ifo3eweRO71XTXoFuezdEhgBxnYGOSgnvfBKxoVsLEJlVSnPPJz?=
 =?us-ascii?Q?StVLv+VPJgLvjhbjNidF7QioDRcJzt+xURhnvV2oIRZ5uvyI+L/pG13Xy1C+?=
 =?us-ascii?Q?zyjjuxr3mDSivQaetYgBGZaW+KHEpJ9LFoQPmfDuNDO9mW3k0OnxICv1KcLk?=
 =?us-ascii?Q?Rmx63hfWu8lP5jg3LxxXlbYWDu7kX8Cj5gfRhHvEsdura2KzzmPQIWTO3C94?=
 =?us-ascii?Q?d0JegEKN6aRt0mDigWFXNqGjh7DBMWwI648SR5h2HM5iEqe2NyTs8LR7GkRe?=
 =?us-ascii?Q?zLH6qlVBrKCL24MUY/F80VHx32xCHUgEDYZcjCODTICfyaereDaYDrYPO0Gu?=
 =?us-ascii?Q?HNqm2npw8yp3YypQhtW1RedfCTRN8OYw16EbOXRAF+vlb+nC91PbLU5yworf?=
 =?us-ascii?Q?rwT0wjDJa3afqpZdsvNTS7QeyvkQpdv0rKiN+eEA8vUowdW00nLgDKrT6ys7?=
 =?us-ascii?Q?W3//Ko79UkjEfeeqvUaeOU2DQeE8f1T0yw6xqj/0m/zbZCqovlG29hvXSeL5?=
 =?us-ascii?Q?lwAPB/ATo09W1UWw0YfLdoP5L3qUBqvR/gZxBhfUJUItGQM3WMDhBfPfYla6?=
 =?us-ascii?Q?okSBQLQ2gE+xooJA7GqsTCFX47JXCcw4skJA96plVWy05PwWGiThzgtuo+Ka?=
 =?us-ascii?Q?WxSS/m7wslSva9ljytEWcqjNycwQiDe59y8uxW4yjnu0Zqa2/cpn/+UY24k3?=
 =?us-ascii?Q?+s7qN48k8rNbRQCsxHEkMT08CkJ0/fVi1qTOqYs79tNPU3PaJhXvUCPmZGe8?=
 =?us-ascii?Q?tawPjZYGmyjYUghS30g8FcirYl6LqqjLxLxq4PBkjT0oel+5Au/OEy5C/a4+?=
 =?us-ascii?Q?mTdr3oTH6aLkY5Be+J/3HRT3y/O3rBJonAlI8uiZoT0HAyJnsBuKo0v4t24Y?=
 =?us-ascii?Q?x1gE0vpCRVYLXT+UqE8ZwNl5BM7Dp/NEFrnSnuff1YURJUrlIK8xI1woLpwq?=
 =?us-ascii?Q?MQI1Yab3YXmIR3zq9Qz1ATiU6RdLcM50do3A7sgrcL2SK+pzC5bN/4lVkYCB?=
 =?us-ascii?Q?FhdfE9THpuqBD8cC0QwHf0+19HiJz4FA5qB+PRLJ2vBRMMTLiyYuK26sHfTJ?=
 =?us-ascii?Q?wPIBYNeUiI0r2mAbdzIoZolSuwThaFlJsUA4YddOasetfYDofJuRYsqYevQP?=
 =?us-ascii?Q?g+k9zyHeNxTj7vHEkudVD9P+7XNHw7ag4Bts2k0dC6zg0q6JjjTuZqHSEV3j?=
 =?us-ascii?Q?BCo2JQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NhEuXjaJBTQ0ajlLVh2cqNMv4erVuNtr/u07pHndinOjaF5tiaDs4uJzAUXJoR85UCfZoLYggcncbVNHvH2Q45Kr3p+eESia8JSONG2k05PcYAacvFVLiOZwHrUlO6WWhp09d3Df6zcJXDPzbNQrReQWogkVv/GaQhu9wlJWxYNP9Y0RFU/IPjAkiKRepsYoObkOF6cseF9jfHBza9UCPKsLxnhHz370MkWKCeRQilXU1OqTRfd09x9Da6pBtA//cq7KXWzaej8JGn7nqZuowLXchW4qfL55Xt3mCpYiU2xZBI2gA9EHJwmqGn/LdYngZiNK2xUNxG7JrfJfTSRT6MwFzTMKwg/hh5qhhPeK0bBxBPDLiETXvDkr5kayJHkM73DDm6g5r1+hEml1HT6UDOf2SVUxUUNqAGBPgqlTgqw5FRtJU8nRPedN/lLa0Tuu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:11:56.3963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb59586-862d-4a99-d6dd-08de62f3840f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9488
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16413-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DFFC2D59FF
X-Rspamd-Action: no action

From: Or Har-Toov <ohartoov@nvidia.com>

Add documentation for the port-level resource feature to
devlink-resource.rst. Port-level resources allow viewing resources
associated with specific devlink ports.

Currently, port-level resources only support the show command for
viewing resource information.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../networking/devlink/devlink-resource.rst   | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-resource.rst b/Documentation/networking/devlink/devlink-resource.rst
index 3d5ae51e65a2..4cdfc1dce180 100644
--- a/Documentation/networking/devlink/devlink-resource.rst
+++ b/Documentation/networking/devlink/devlink-resource.rst
@@ -74,3 +74,39 @@ attribute, which represents the pending change in size. For example:
 
 Note that changes in resource size may require a device reload to properly
 take effect.
+
+Port-level Resources
+====================
+
+In addition to device-level resources, ``devlink`` also supports port-level
+resources. These resources are associated with a specific devlink port rather
+than the device as a whole.
+
+Currently, port-level resources only support the ``show`` command for viewing
+resource information.
+
+Port-level resources can be viewed for a specific port:
+
+.. code:: shell
+
+    $ devlink port resource show pci/0000:03:00.0/196608
+      pci/0000:03:00.0/196608:
+        name max_sfs size 20 unit entry
+
+Or for ports of a specific device:
+
+.. code:: shell
+
+    $ devlink port resource show pci/0000:03:00.0
+      pci/0000:03:00.0/196608:
+        name max_sfs size 20 unit entry
+
+Or for all ports across all devices:
+
+.. code:: shell
+
+    $ devlink port resource show
+      pci/0000:03:00.0/196608:
+        name max_sfs size 20 unit entry
+      pci/0000:03:00.1/262144:
+        name max_SFs size 20 unit entry
-- 
2.40.1


