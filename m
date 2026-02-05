Return-Path: <linux-rdma+bounces-16589-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ5+M+iphGk14QMAu9opvQ
	(envelope-from <linux-rdma+bounces-16589-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:32:08 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8618CF405A
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFA5D30358B9
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 14:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9C33F23D7;
	Thu,  5 Feb 2026 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UQbiIxbL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E303F23CD;
	Thu,  5 Feb 2026 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770301879; cv=fail; b=JiF3+ZWI7mIovVPMWgieROevXZylKMoAbsoJz0kKA9fQHV3Ks4yZE0i6iRJNsfRZ36NmLv2KHs9CsuEhvEWwqhSeAKVXX6nAQu/Mo/iRLsnSJsEZu0T0oWaXMAuYsn9Be8IKjX4FHIOpgRevK1fP9HGDN9DF5G7X21Tx/rASV6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770301879; c=relaxed/simple;
	bh=ttQg7ykIkns3IubZiLivJQ0KeiO+kkkbqAtZ33BOK7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ceuxy3h+Xnr8/Xf3W7bGKTOGG8R69g0qjTXm4nMvb5ZvI4VLZoP3Bxo1hHafJda8vFQglukcMUy+z3O27tnUFzQJjyfTER4S5ZASJpCuliadXEI8gukljSmbrc3u81feerFLBGj6TkzD5U0qBD2rRoPy7aTeUIdF3iccTmfYRzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UQbiIxbL; arc=fail smtp.client-ip=52.101.201.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOcKpBuzW8SPYSeyEiGzWNiqE+n0W8+bjr7W1l1iaJeAT2FWaSkIVUIbFHffDGxQwvJfSKcnE4edlhJ5kcgWlyQbVzPS1ZQjegx8Bkh2UQr2+lFfd5lqpL/ha1buJvQ+OMQGz5nO56g8TJfJ1o5fRHUgTuzLkrClovq8emgGDJUlau9CGVWFkYh7SYVHB+HUH1dgb/ovJ+k76HLCBe/mWnnor26g5W2Imx48yXo+SDZAGA4iigYc8ApFdGZz2yaRt/8cxFIRejhKW1tp8IWVaK9zTSMZ2OMlbBcALwYhRYEgXGMUwywdso8QGB0GWb8PtCBAgieYhQwAJ/RH0ldCSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRzCoQ8MxLqu9BPAsuuNN/dDvi+SPtSZCI/pj/D3JnU=;
 b=DvztO7MYrdspfi0ez53+mtZ88fZIYJVoua982eGr8Ffba+zNTc+UW5H4YZU8FMn3Eoao/vY67DffgKS76WUoWk1FE9BUOH6t7wnRnQ06GzS7+MMFC6api9Yz5SGvc1Asp/RWq3PYHpmtO9BnoNfaqOF0nZehC4bKATqeEEo3lcuHLvEccx5neB9EN3+fuKewb1y3Ktbi08eY0/EgMAtXNnpKRcgC9pbLWO5u3UxG/B1tdl+xb4rFvAlr32UTjRjOFSBqFiVyJ9t3QU3WXqG7diMDXSUlEujQKrNborewd3F1SO47g+ztNQeUqHZYjZlaehEHvM5VJ16dANANgOmUgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRzCoQ8MxLqu9BPAsuuNN/dDvi+SPtSZCI/pj/D3JnU=;
 b=UQbiIxbLWUB3F6zegstqgiq+WLlQsneMDkVqVMIpPkOTyUtbyXYE4KwQORj1UT6x0BAi2GxEmrm1qHavevv4WiAubRnZM731s7+rDhUVIWziEKioUBYBCH6CscpdzBRjg2vrnH1ZZgu3phlLbCpH6Bn2UH21nFArDjkSYUxU/M1nALWMWCJQWcHTsBBmWGKOObgtzzNwYMgce2XEr8ZD7pyd2pdz8KkUbVkA8O7XVq5PKARWv3MhNiMhxod7K2tSUgGm51pxbQrkVtl2kIq/602amTazfCs6xzFb8fENT3gB6qJxf5WIjK014cx7vX8D/PNgIg5NsNHcF+T+8qfvKQ==
Received: from CH5P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::9)
 by SA3PR12MB9226.namprd12.prod.outlook.com (2603:10b6:806:396::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 14:31:14 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::4f) by CH5P222CA0024.outlook.office365.com
 (2603:10b6:610:1ee::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Thu,
 5 Feb 2026 14:31:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 14:31:13 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 06:30:46 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Feb 2026 06:30:45 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 06:30:40 -0800
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
Subject: [PATCH net-next V2 1/7] devlink: Refactor resource functions to be generic
Date: Thu, 5 Feb 2026 16:28:27 +0200
Message-ID: <20260205142833.1727929-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|SA3PR12MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: f83b198a-905a-4120-039e-08de64c336e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U695fWKtPTVuayRjV3BAH5IQ20bPUCZQVKLmso5VSfNQe2usKK7u51b0CqSH?=
 =?us-ascii?Q?8QA5cl+wN7HvhgGN0Ar6Oow2c6jLXajLSL5/RHim1KdFdJewF83uNtOW51Z0?=
 =?us-ascii?Q?sqnsBuwfeZMZxiUmAjCk5TIU2ynpajkHnQRc6lA9Jfc5c5LLXqaqZtOuA3AW?=
 =?us-ascii?Q?BR6L4jggXiuGRQwB+1Rqrg5nQV/64e5BUrn/mHs2+clTFG7My0n8ZcyB+A2/?=
 =?us-ascii?Q?gGk8iRa8rh5vAs8Vq2MJ3mjWGLXMH8OPXFfn9/lcvoSGUQ1VXBvzqE0XXe/F?=
 =?us-ascii?Q?4Nh+Pc8j2zaphf7Yk0qX89nK3j6Bfnd6BivpMLPW/pCLAojVCRVOF/ibEWQ4?=
 =?us-ascii?Q?va35a6UKFCDajBo4/CCrh6SCUy/E2fq+J0QJ9G/83ae/oIdjBG6jz6PPylqt?=
 =?us-ascii?Q?B41Yw+0wrd+zEl2dHFtvUMY8HI5ycTsFxzYJMXJ/YcrjWz9d62hTYtH/agRr?=
 =?us-ascii?Q?NokdF8/KJ3azkR0+ZQChCjAZuQQvukp9Rlj+Q7aLEcsuLL2uvWFcn1UqFtQj?=
 =?us-ascii?Q?cJqKbz6D5iEjQUX/EOJdJJ1W+6YUJ0M4CJ8i/D8JXiChYJ70xNxunOElXSyL?=
 =?us-ascii?Q?SoWsIyOupeqgJhxt4W+RCbHf4ZvJwW65mqibraTBGLQ4YxcqcT9sIwyDntDE?=
 =?us-ascii?Q?1K869yF+qVc/Bw6m+oA9OGjQ2lKySlsqmzbblvw7BtII6fVD3YSuaRWD8FHe?=
 =?us-ascii?Q?W66no4qDG3WusMfKbbmH7/PZNENMX5oPXq54YCdnKpdI3SmSfuvzil1K/D9A?=
 =?us-ascii?Q?XxJWaqa+mosCr7Mxo+hweIpRKLGA5urVQuMQ2KCf5snugfRHxy0M9gTcNr/w?=
 =?us-ascii?Q?XUuTMpUluXvxjNf6kmcCbmMsecF0ACbsEV/Xliw0r/2GatlDKZzX+nSwgnw6?=
 =?us-ascii?Q?OT/gK1jOIV+ngjIqctwswQaBzAV2YcV3nFORJBwJsr7kaZIfhPs3kjHW6xe0?=
 =?us-ascii?Q?CSRNdZMiAOEGBpWjKclxRr12KjqV7BGUgHGgLYtLR9Bew7NR0MODrHwQ6eOZ?=
 =?us-ascii?Q?PjsuC/wyXfZs3OUG+gM5tIoFPHPhm0VL1PmSTbSozJinMabTexqR7yWpK0ju?=
 =?us-ascii?Q?GR/xZzMWKiwFzFbvVsHn+Q/x7pKwFZC/NlMcDNmVz+MN4OEEy5WpRM+xfGCT?=
 =?us-ascii?Q?pu2wo8IvmcfsuBKfTCppy1ydXOq2Cha5FIua/zr3c/8VGzEgeE4xDkkz6XL0?=
 =?us-ascii?Q?OTUsiQyRDRpJ92ICtUcX7bIfld7U2M1Gey3mrbCFAtZRZ2G30xfqExr34a5W?=
 =?us-ascii?Q?Gr2475HifwDrqf8V2cC1CLI5anH+Vvg4PxRHiejKrPRQ1NxAESWXllB/9LNl?=
 =?us-ascii?Q?1ecqo1Y/vU6qM7ju9QZhMxHXyrWHdp1f+4zEXXh2w+qGf9lqfaXFJ8VKqhOO?=
 =?us-ascii?Q?ZuShXZc7oBSDQqP/nHIAzdXl+aYjfae+sdp6QZJ1YGd3sWSFCqKt+vFy4l24?=
 =?us-ascii?Q?gkZaHt+BFolaL+IWBO6agBziVONctgyM30LQ/JB/PNTna/99IGgvQC46MU0n?=
 =?us-ascii?Q?Pvmiku3uSNhQVDuBXbv1UNaaMO/NC32VO9BvLuAmlBPfXUENFzoaXdxp/yvi?=
 =?us-ascii?Q?KggfOquICsDiHmNHbtD7UnsMEIJN8zIpgbn4WnAFh5x8mhwcLYejBmrx1dZG?=
 =?us-ascii?Q?GOvqKeE/gtbUSSov3qtAH02VWmhA0R4IaI5YyRKOo0SUY8MZsmFg8smKINR5?=
 =?us-ascii?Q?/0moSA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6sG5S8OBqZt/h/JLyBJAjaMSp8x/Eyy68kmpfsP0ol1uQWt9jjwBlz3AwVzGQeqYBbqrYWODnXzu+/jU/cAeGG7TvbQJn7ie1SIBNAxq1W5BPCfM+Qbp9XJizpBTHRnatQ7jByLpSV9plpF1ECaqKXl9AeQkhNhsfOagD9mDwmfBUy+H1a64O22+fVeCtBTUK0c0VgxkxxjEElTR3znpIanEdiYi7uqvxyfmRqfM9+z2tVmONbUdDoGWLkAiqwF5GG3b8jKmdj8AKy0SFsyIrtzGxZ7SSbsV40YFSfV4AqhG9NkPcWY6bnVXyGBjZ3l0Fp1dT6Lsj0YQ52qA9Q3051+wabQyfjn9Tnm5F7FT0fTXijaFVJFAl1Pz1b/Y6LILnD17om1syCl7wMWJYUrM7zGgvglKWPoAbhG/4F3pkO+n1wz4hoGTNwE5qQy+aT4u
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:31:13.3967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f83b198a-905a-4120-039e-08de64c336e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9226
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
	TAGGED_FROM(0.00)[bounces-16589-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8618CF405A
X-Rspamd-Action: no action

From: Or Har-Toov <ohartoov@nvidia.com>

Currently the resource functions take devlink pointer as parameter
and take the resource list from there.
Allows the resource functions to work with other resource lists
that will be added in next patches and not only with the devlink's
resource list.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/devlink/resource.c | 137 +++++++++++++++++++++++++----------------
 1 file changed, 84 insertions(+), 53 deletions(-)

diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index 2d6324f3d91f..2ab4f0dfe0d6 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -36,15 +36,16 @@ struct devlink_resource {
 };
 
 static struct devlink_resource *
-devlink_resource_find(struct devlink *devlink,
-		      struct devlink_resource *resource, u64 resource_id)
+__devlink_resource_find(struct list_head *resource_list_head,
+			struct devlink_resource *resource,
+			u64 resource_id)
 {
 	struct list_head *resource_list;
 
 	if (resource)
 		resource_list = &resource->resource_list;
 	else
-		resource_list = &devlink->resource_list;
+		resource_list = resource_list_head;
 
 	list_for_each_entry(resource, resource_list, list) {
 		struct devlink_resource *child_resource;
@@ -52,14 +53,23 @@ devlink_resource_find(struct devlink *devlink,
 		if (resource->id == resource_id)
 			return resource;
 
-		child_resource = devlink_resource_find(devlink, resource,
-						       resource_id);
+		child_resource = __devlink_resource_find(resource_list_head,
+							 resource,
+							 resource_id);
 		if (child_resource)
 			return child_resource;
 	}
 	return NULL;
 }
 
+static struct devlink_resource *
+devlink_resource_find(struct devlink *devlink,
+		      struct devlink_resource *resource, u64 resource_id)
+{
+	return __devlink_resource_find(&devlink->resource_list,
+				       resource, resource_id);
+}
+
 static void
 devlink_resource_validate_children(struct devlink_resource *resource)
 {
@@ -214,6 +224,7 @@ static int devlink_resource_put(struct devlink *devlink, struct sk_buff *skb,
 }
 
 static int devlink_resource_fill(struct genl_info *info,
+				 struct list_head *resource_list,
 				 enum devlink_command cmd, int flags)
 {
 	struct devlink *devlink = info->user_ptr[0];
@@ -226,8 +237,11 @@ static int devlink_resource_fill(struct genl_info *info,
 	int i;
 	int err;
 
-	resource = list_first_entry(&devlink->resource_list,
-				    struct devlink_resource, list);
+	if (list_empty(resource_list))
+		return -EOPNOTSUPP;
+
+	resource = list_first_entry(resource_list, struct devlink_resource,
+				    list);
 start_again:
 	err = devlink_nl_msg_reply_and_new(&skb, info);
 	if (err)
@@ -250,7 +264,7 @@ static int devlink_resource_fill(struct genl_info *info,
 
 	incomplete = false;
 	i = 0;
-	list_for_each_entry_from(resource, &devlink->resource_list, list) {
+	list_for_each_entry_from(resource, resource_list, list) {
 		err = devlink_resource_put(devlink, skb, resource);
 		if (err) {
 			if (!i)
@@ -286,10 +300,8 @@ int devlink_nl_resource_dump_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 
-	if (list_empty(&devlink->resource_list))
-		return -EOPNOTSUPP;
-
-	return devlink_resource_fill(info, DEVLINK_CMD_RESOURCE_DUMP, 0);
+	return devlink_resource_fill(info, &devlink->resource_list,
+				     DEVLINK_CMD_RESOURCE_DUMP, 0);
 }
 
 int devlink_resources_validate(struct devlink *devlink,
@@ -314,26 +326,12 @@ int devlink_resources_validate(struct devlink *devlink,
 	return err;
 }
 
-/**
- * devl_resource_register - devlink resource register
- *
- * @devlink: devlink
- * @resource_name: resource's name
- * @resource_size: resource's size
- * @resource_id: resource's id
- * @parent_resource_id: resource's parent id
- * @size_params: size parameters
- *
- * Generic resources should reuse the same names across drivers.
- * Please see the generic resources list at:
- * Documentation/networking/devlink/devlink-resource.rst
- */
-int devl_resource_register(struct devlink *devlink,
-			   const char *resource_name,
-			   u64 resource_size,
-			   u64 resource_id,
-			   u64 parent_resource_id,
-			   const struct devlink_resource_size_params *size_params)
+static int
+__devl_resource_register(struct devlink *devlink,
+			 struct list_head *resource_list_head,
+			 const char *resource_name, u64 resource_size,
+			 u64 resource_id, u64 parent_resource_id,
+			 const struct devlink_resource_size_params *params)
 {
 	struct devlink_resource *resource;
 	struct list_head *resource_list;
@@ -343,7 +341,8 @@ int devl_resource_register(struct devlink *devlink,
 
 	top_hierarchy = parent_resource_id == DEVLINK_RESOURCE_ID_PARENT_TOP;
 
-	resource = devlink_resource_find(devlink, NULL, resource_id);
+	resource = __devlink_resource_find(resource_list_head, NULL,
+					   resource_id);
 	if (resource)
 		return -EEXIST;
 
@@ -352,15 +351,15 @@ int devl_resource_register(struct devlink *devlink,
 		return -ENOMEM;
 
 	if (top_hierarchy) {
-		resource_list = &devlink->resource_list;
+		resource_list = resource_list_head;
 	} else {
-		struct devlink_resource *parent_resource;
+		struct devlink_resource *parent_res;
 
-		parent_resource = devlink_resource_find(devlink, NULL,
-							parent_resource_id);
-		if (parent_resource) {
-			resource_list = &parent_resource->resource_list;
-			resource->parent = parent_resource;
+		parent_res = __devlink_resource_find(resource_list_head, NULL,
+						     parent_resource_id);
+		if (parent_res) {
+			resource_list = &parent_res->resource_list;
+			resource->parent = parent_res;
 		} else {
 			kfree(resource);
 			return -EINVAL;
@@ -372,46 +371,78 @@ int devl_resource_register(struct devlink *devlink,
 	resource->size_new = resource_size;
 	resource->id = resource_id;
 	resource->size_valid = true;
-	memcpy(&resource->size_params, size_params,
-	       sizeof(resource->size_params));
+	memcpy(&resource->size_params, params, sizeof(resource->size_params));
 	INIT_LIST_HEAD(&resource->resource_list);
 	list_add_tail(&resource->list, resource_list);
 
 	return 0;
 }
+
+/**
+ * devl_resource_register - devlink resource register
+ *
+ * @devlink: devlink
+ * @resource_name: resource's name
+ * @resource_size: resource's size
+ * @resource_id: resource's id
+ * @parent_resource_id: resource's parent id
+ * @params: size parameters
+ *
+ * Generic resources should reuse the same names across drivers.
+ * Please see the generic resources list at:
+ * Documentation/networking/devlink/devlink-resource.rst
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int devl_resource_register(struct devlink *devlink, const char *resource_name,
+			   u64 resource_size, u64 resource_id,
+			   u64 parent_resource_id,
+			   const struct devlink_resource_size_params *params)
+{
+	return __devl_resource_register(devlink, &devlink->resource_list,
+					resource_name, resource_size,
+					resource_id, parent_resource_id,
+					params);
+}
 EXPORT_SYMBOL_GPL(devl_resource_register);
 
-static void devlink_resource_unregister(struct devlink *devlink,
-					struct devlink_resource *resource)
+static void devlink_resource_unregister(struct devlink_resource *resource)
 {
 	struct devlink_resource *tmp, *child_resource;
 
 	list_for_each_entry_safe(child_resource, tmp, &resource->resource_list,
 				 list) {
-		devlink_resource_unregister(devlink, child_resource);
+		devlink_resource_unregister(child_resource);
 		list_del(&child_resource->list);
 		kfree(child_resource);
 	}
 }
 
-/**
- * devl_resources_unregister - free all resources
- *
- * @devlink: devlink
- */
-void devl_resources_unregister(struct devlink *devlink)
+static void
+__devl_resources_unregister(struct devlink *devlink,
+			    struct list_head *resource_list_head)
 {
 	struct devlink_resource *tmp, *child_resource;
 
 	lockdep_assert_held(&devlink->lock);
 
-	list_for_each_entry_safe(child_resource, tmp, &devlink->resource_list,
+	list_for_each_entry_safe(child_resource, tmp, resource_list_head,
 				 list) {
-		devlink_resource_unregister(devlink, child_resource);
+		devlink_resource_unregister(child_resource);
 		list_del(&child_resource->list);
 		kfree(child_resource);
 	}
 }
+
+/**
+ * devl_resources_unregister - free all resources
+ *
+ * @devlink: devlink
+ */
+void devl_resources_unregister(struct devlink *devlink)
+{
+	__devl_resources_unregister(devlink, &devlink->resource_list);
+}
 EXPORT_SYMBOL_GPL(devl_resources_unregister);
 
 /**
-- 
2.44.0


