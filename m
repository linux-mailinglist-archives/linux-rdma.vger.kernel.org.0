Return-Path: <linux-rdma+bounces-16592-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KfwGXKqhGk14QMAu9opvQ
	(envelope-from <linux-rdma+bounces-16592-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:34:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B312F4133
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B923305A94C
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 14:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C4940B6D8;
	Thu,  5 Feb 2026 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oxhSzlQh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012061.outbound.protection.outlook.com [40.107.200.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E21407577;
	Thu,  5 Feb 2026 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770301898; cv=fail; b=uv0Ck7kN5JA4lnNUMfJXui9LoBAoxaqzEKNnkqSb0yismOthwrgvweL0wSicMjbfetXmZh9lmmlhQTIdUNuRTcqCwgzrPzZHhYfo81C/XQcSPQ3oZwy8O7W6kaaIcLUFhV7GRV/5kt9acMZYIDUZ9KzWQ7HXoE9hhMC96MaaLWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770301898; c=relaxed/simple;
	bh=gDtiOaJwuZAU+PZSgyhrwa5fGwikyZpA9VUbto1Fzlo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgKpc/QmM0jIJk0RdKpp0Jhdow2dzrhQsn8bqNKggj1thZpQhms3E8em/q/Rrsxj5NqlC1KHDCa0MOcm/cnDg7ORmIQg/pUhnEUfTvG23S4RjDo0No1ZWtd+FyjCdHiBGBREfnFtx5ns2SYE3prW5KA30h+xP/5bJ9Dr90ohxlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oxhSzlQh; arc=fail smtp.client-ip=40.107.200.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wATj/EBQMzBiZaKy/YJXq5gF25AVJB24suyvPcZFdQTQ+RGJt/3Qng+0Sh9F3AOLPw79RgMRIxpWwtdwoNLOwy79/jzBq3J4Y/5KW0j1gefn8Ol42ejSggKQFWYRQRhmu7HG8/nRzdiVs1FyKI99aHZdFyXyNJcQACp7pZNKvfWZ9Z5RzuHqo05lp+UxM8Q5EDrx3KNrAg6yTmc+uLZ5XWkkFrXykAGz4QJWJ8X36gqLgnuYC4l22cv+ubnIEjzfPeS/D72kkCXsrRgbOVkat6nc9ij8BBjPu8FTC7NyKgY0wLk1R0w+y2Z686p7S1R0BplzRxmrxZdaRKfLrDDSVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASeIQy4HjyVP9hpBmOjNaOqss51rjP8rhuQZdKnCGzI=;
 b=W5S7iGmI7lKcBK6bHoMOB33oQl3TL3fhnjneVlQvJ4mo1zQ+A1pvrmBdKSZY09phEGyQya5831bOvkllJimtKm5iWaK8zHMT8ChdN0tWDeqZBeSH2e8SZYLHr+nAMTYjw8u0UfIvQZpTPvrlJZV7Bk+FuZnt/UJcwkrj8bc6FysYDOvIcrGSO+OP1TqrEmt9SsyXILN2hI7Zis2lvO87YtXtsimgdoPxWlTOgReKh6xHIa49uf5MtYpuSU1KgYHWXp+bZf1vJc7LAhkKkydERizF27UQhhNYSYv/VSEPo22Hyg/QJSaT7XmFpeDUf/8kZKqvYxxqThlBJQrGEcPfIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASeIQy4HjyVP9hpBmOjNaOqss51rjP8rhuQZdKnCGzI=;
 b=oxhSzlQhqVQ8wAfDO9X7AbThQqiRP0+N9NrmEfKCz/L5SF4evn/exjw7XCECdU/aF23ZclSLg3VQErHXnWuJuXzt8zJDPKksqZ6/9+qvv6Yhw8+cXV8NkIQJE5craTp9MvIlRRCkW/061x3YO2NXOb3Id5GPQ5EzfW31swZGw+0UYbWF248TURu8MO5h60Nm5uGW/6FiD3nE6fGNMOzXUspmqwUiJvg/sri9hJquoZOpG7zEsuaE5htCY+hw4p1QQn0aC30ZFbJ0BByT3Xg16jES7EiX+U9xD6xfVChpenO/In/5rbLKUpUzYQ+uny902ipC8zd0d1U7akhRyVM4vg==
Received: from BN9PR03CA0384.namprd03.prod.outlook.com (2603:10b6:408:f7::29)
 by IA1PR12MB8333.namprd12.prod.outlook.com (2603:10b6:208:3fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 14:31:34 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:f7:cafe::a4) by BN9PR03CA0384.outlook.office365.com
 (2603:10b6:408:f7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 14:31:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.0 via Frontend Transport; Thu, 5 Feb 2026 14:31:34 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 06:31:15 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Feb 2026 06:31:14 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 06:31:09 -0800
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
Subject: [PATCH net-next V2 6/7] selftest: netdevsim: Add devlink port resource test
Date: Thu, 5 Feb 2026 16:28:32 +0200
Message-ID: <20260205142833.1727929-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260205142833.1727929-1-tariqt@nvidia.com>
References: <20260205142833.1727929-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|IA1PR12MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: c6918f9e-b76a-4c04-0223-08de64c34344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?epoM4Dy7SC1ngixgy4Hyl/cBx0up4tAlsiaX8ZVuFX3EYLZpGpFN6HZ8sgz8?=
 =?us-ascii?Q?ecwQmd6fuVIWzTvQSmRBoI0Omdn6jaKh4BeL7rgj0wsoUzwyayjf8PnDLJ6W?=
 =?us-ascii?Q?dskhhx+wzuFMIUdB0iZPXwy3FeHR7JKO2g9NaJfW2PXeW12usk/GZ2seIz2y?=
 =?us-ascii?Q?nLoKPCnhBcDeXyo6KtBCuDuYWKJFFX//jc4Lfr1nWhM7VfuF0a8WzACrs1KU?=
 =?us-ascii?Q?jxDdzOwwoAzM/CDGICXOHzPwnymljgPUZRO1mbXos+iBfUjs1XYENf9bt7Ow?=
 =?us-ascii?Q?6YNnoSPCXqGoOxkUH6FexFDPALpFxlVtH7steho9j4jKq5rOmyv/n6Kijh3X?=
 =?us-ascii?Q?Vlsa6vA0rxHNDmjRhxHzDfGAPQdBeAC0M52YT9wpDZ2fTWBKM0YsXd8PfKaW?=
 =?us-ascii?Q?mU+sRhhch5hEr+CFNbgEJIzHkTY3gCnNOh/jEv1JMI+zpay98yRt8IuTl+95?=
 =?us-ascii?Q?kxjb7Y21P499rfcCTqgBaE3u7dTS+ZYHjgxVj9wyFFKTUvIMClwlkB+IHFrH?=
 =?us-ascii?Q?7tsDKRLVvyqxz2z0tv98ut6EYhGoPs5LgB6CGyw+z9w+VlTnLkP/roOb5ifZ?=
 =?us-ascii?Q?kpprEItat0mO6DIBduXKDj/qbxuEK+IaaJMUZztALeDCLfqvXodmE/hZSP1U?=
 =?us-ascii?Q?O3DonH9w9hWpt6xbpH03nzK/aMjNpgGfjomXHECkb0f9KSS3mFiE2nM1DToN?=
 =?us-ascii?Q?96SU3kikg5XdA0+bA94p2baeYdKYXvp5p8UjKGPud/DhCCG1nJiDFpUwSYM7?=
 =?us-ascii?Q?yXQiA5D2b8VisnU/V4NxVLa7heyQig/tAjKP4aZNeOtRbQw3iKeuGVTfSW9D?=
 =?us-ascii?Q?gv+Nd30xeyi04O3Q0Q4H397QQbGuelBVro8Q1lFSmNqYB9jLxUEZahFokP0F?=
 =?us-ascii?Q?X2Y1U5XGzmM6VhSZPaxMRgmKb85RqFmQYLFVLeFh8+3QJD9oC5Ty6bV6d+QB?=
 =?us-ascii?Q?Pj1f8UKSsTOcloWCTRwT+DD9UyaXuR6Qwam+D4qwjM1XI5aRr3+WGWrA1D4S?=
 =?us-ascii?Q?UaRhx+PjyP79Ydnns9AT5lQm3kaTAvIUuRu9ZdM0WGXYn9c1hZ8X3qo6pdpy?=
 =?us-ascii?Q?J/vxkn7r/L4uW6PO79r5aMOqPSjMNIZFTuKOEOxucZcD2vxdK7KITahrvr5a?=
 =?us-ascii?Q?IodetpLcF78E1raq3b495SY5J+DkVEIwS/xwAkHcjr3gR+/5oShpzICbAZa0?=
 =?us-ascii?Q?xv8R1WUjQ2U2taZWZNV6RuZUEhTFhz/LsdnzpUyxXT7aAg4b0cQ41BOKJuKy?=
 =?us-ascii?Q?lRucMGdR8SI9fIn8s6HizKZwgA2ZXZahZw19DvkMZVf4+vnYw2M3fdatlmZi?=
 =?us-ascii?Q?m2Ys95I+eC7UU4VMuKiXZlSIb8Y8hHt4tvzXL2jbEQ5OitzhMe7rDHoEOc17?=
 =?us-ascii?Q?3SmzYVsduPlvOSkbYaoC0DeKq4kBOIPksKMirj5+9D1OzbGmtVrJzApt0ZdX?=
 =?us-ascii?Q?Xak+V8e/DTZdwFe5JDyG0EnDxdiQ1vLPRHko1zLsw9rCPWHK5XgMqvcbYApM?=
 =?us-ascii?Q?mZhkBS5MPGdXLjHPo1Wf3B2sIzsdHR309RiMtJBNUeJHdjndM5onlGxs3hge?=
 =?us-ascii?Q?Zk5GOe9cqJP+dphEgV/su83bTkdXhx1GKgHW0K5U9GHuTM+ZSLEy6ttAlS+B?=
 =?us-ascii?Q?QHREeHY/NCACDhzAJjsyvQo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wziobLz3p2+hqQ+qhqP2D8v510OCgSDZ/WpW3DB1YEUpLK+2Tg93joapfZbHdF3NnqSwRiyKAvqOYBI7fE8SPGXVV+tG6ZZM/MCGx6dAeeCxUSX1KGe7eSWyrp8RKt8f+kJMbXP+9uVVSyZVRlm6/cgsdBj8spBalqSHW2yPXjQvcYmI9cCZNsXpeZUBnNneOReqKhtJHbHj8XEFq08QF0oFQh5KOzMsgaEtQM44zPacmuyL6WvCsEFIvBmjRU1JaMbQAovy7MH0q41SBCpFDJlKK9WmceNItLVHaFtdaN0EMYx7MB/8nCIL7gJfSKV9JAHYu6M1VnzPlL/ra9+OI7QriiQHINBbRoJ0N437iRld9dBz2qvIElox71Qmhj4wJqxqPlg+GYgKaLJkeNxLIsA8042EKnca5W/6UWCc9iYh3iAhcegCHCKXWHH0p7ez
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:31:34.1234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6918f9e-b76a-4c04-0223-08de64c34344
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8333
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
	TAGGED_FROM(0.00)[bounces-16592-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 1B312F4133
X-Rspamd-Action: no action

From: Or Har-Toov <ohartoov@nvidia.com>

Add selftest to verify port-level resource functionality using netdevsim.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../drivers/net/netdevsim/devlink.sh          | 37 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
index 1b529ccaf050..272e60eb7bfe 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
@@ -5,7 +5,7 @@ lib_dir=$(dirname $0)/../../../net/forwarding
 
 ALL_TESTS="fw_flash_test params_test  \
 	   params_default_test regions_test reload_test \
-	   netns_reload_test resource_test dev_info_test \
+	   netns_reload_test resource_test port_resource_test dev_info_test \
 	   empty_reporter_test dummy_reporter_test rate_test"
 NUM_NETIFS=0
 source $lib_dir/lib.sh
@@ -856,6 +856,41 @@ rate_test()
 	log_test "rate test"
 }
 
+port_resource_test()
+{
+	RET=0
+
+	if ! devlink port help 2>&1 | grep -q resource; then
+		echo "SKIP: missing devlink port resource support"
+		return
+	fi
+
+	local first_port="${DL_HANDLE}/0"
+	local name
+	local size
+
+	devlink port resource show "$first_port" > /dev/null 2>&1
+	check_err $? "Failed to show port resource for $first_port"
+
+	name=$(cmd_jq "devlink port resource show $first_port -j" \
+		      ".[][][].name")
+	[ "$name" == "max_sfs" ]
+	check_err $? "Unexpected resource name $name (expected max_sfs)"
+
+	size=$(cmd_jq "devlink port resource show $first_port -j" \
+		      ".[][][].size")
+	[ "$size" == "20" ]
+	check_err $? "Unexpected resource size $size (expected 20)"
+
+	devlink port resource show "$DL_HANDLE" > /dev/null 2>&1
+	check_err $? "Failed to show port resources for $DL_HANDLE"
+
+	devlink port resource show > /dev/null 2>&1
+	check_err $? "Failed to dump all port resources"
+
+	log_test "port resource test"
+}
+
 setup_prepare()
 {
 	modprobe netdevsim
-- 
2.44.0


