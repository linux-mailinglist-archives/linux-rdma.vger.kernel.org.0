Return-Path: <linux-rdma+bounces-15968-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCarEKX/dWmMKQEAu9opvQ
	(envelope-from <linux-rdma+bounces-15968-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:33:57 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFEF80481
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F1E33008D7A
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 11:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDA131A57C;
	Sun, 25 Jan 2026 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HSAapzfJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5C731A54A;
	Sun, 25 Jan 2026 11:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769340799; cv=fail; b=sHZM3bN+u9Z/EBGzfC5SJ5P0+HQdYwn73O0g7ZciPL4fpKkeBXd/Xmf4SusVwpbggfcP9YsKgu7l3HXX5s9Bji6Q5w7Vw+7DxYWprSdakJ+1kee0utBhPf/DXxQmKpEYWXOMTHJw3m6zY/F1Jdd7OE43MpzICsJFtOLZ5rpo0B8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769340799; c=relaxed/simple;
	bh=jgaWjfKOpvdiRyNwgMlPRYV1BZBTWantfD5FyQG/1wM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJ+rv4h2lYoKaJLNWHaqGIkGMt7daaizCdrKPDoFxAssx/khK5K98ReCH1AwQQXRzNrO0ixeCkOf3okt+gM1IqMXBh8WiWuC+Db9+iX0kl/R4vsWHtABtoM6BPf3SyvMUxiV16vCDEylg6YzptCGGxtyGhELryIPakS8mN8Z9ZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HSAapzfJ; arc=fail smtp.client-ip=52.101.48.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UauIf8oJWDrmnvA5GfjufHw/ioWAtNDZHKnYo6eVBQ2l0YGNbzWw2yt0of4e9vRQ5YyD1d3wc6r58UJYnnNE0psHqjQ37KjhCLCUUsdufcOfRsNur82qaJWYcaVgB5AAEfkh+4t4EkxSnTmuWQe3EF3v5GeWVbIwEGd6TMlJd8FVD/BTDTpygPfnHOPURYHpy+9xFgF3BUeyidwR2J4iRlhGvXIVVzbsLwzZotzCVV5ZGN87lD8quNhNMMCH1V/pRaNnYMoXL0iqY5bCOstUL/v9yGNIYHAjewjEIlK9Z/aeIE1BoNaok5q/sf6dEzVrU4x6t2IaE4wd8jEn83TkXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obhvNu3YvoIyDeT5CPPId1CisN0EFCH2Janhc3bEvhg=;
 b=NLLWTo0OmOvhms8TQDkK1ufHiW2j0dGiWSDKslHgy3s6R/3lyMNREcc5Y3WI9zOz/kOdnxDYNqdZQ92rEFPu1UQ/vRzTCyMDeuzfJsFkGvpcYzF4ImkDdJByBlhS2Sdfth27UNABo+3RxIYURkz+BWO1C9+cB78xNcdrn9BMiahAtOgIO773VSW7Nq8wK/f9ira846T3rySEy9C4D/Ex5Dhlh2wlS02hsY0V4r1hdTH4FOwkM/iRa4dUu+BSDFyrIaQTtWzj8nqHeWgmTem2tEZ094l8TLiNuez0PufCB7tpL8N/bWobQMlBJMQXi6dTqNeoCC2pYSRUl0P7s3myhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obhvNu3YvoIyDeT5CPPId1CisN0EFCH2Janhc3bEvhg=;
 b=HSAapzfJCvyL4VkqYglZyO/eDOQ4nVsKHKLikWW1lVqGr8CBeV8r5A47EObNCd52PLFeqKit7ZQXB0Sx92oZBh+ij8Km8XW+LxWHyG5nT8WugqhAb3jfi+pedmwo1zXaoa3XFTpfC+Mo1a1L5SAIzCFUEIFMHDqeqrioSr1NG7NjODOj8NZEX+uMKEDhlhsku4iu6Dz0+O75TbDYRRIEi8auuO6WgOeploDtjuRvEJYdSaslMVxlDnkLGqKcPDyHWs/HR+BNo2R0qvfto0tk2PvYCRDvYmykJsq4NcjqvSVOgshG2xwqagcNKUwIl3rAFWrp/sMzVNqdT0mGx1O6Ug==
Received: from BN9PR03CA0073.namprd03.prod.outlook.com (2603:10b6:408:fc::18)
 by CY3PR12MB9606.namprd12.prod.outlook.com (2603:10b6:930:102::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sun, 25 Jan
 2026 11:33:10 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::b0) by BN9PR03CA0073.outlook.office365.com
 (2603:10b6:408:fc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.14 via Frontend Transport; Sun,
 25 Jan 2026 11:32:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Sun, 25 Jan 2026 11:33:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 03:33:01 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 03:33:01 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 25
 Jan 2026 03:32:56 -0800
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
Subject: [PATCH net-next V6 03/14] devlink: Reverse locking order for nested instances
Date: Sun, 25 Jan 2026 13:31:52 +0200
Message-ID: <1769340723-14199-4-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|CY3PR12MB9606:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c653cc-5158-4c74-cc75-08de5c05845c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eNQD79Gbz5a+hyLjQd0Cl8UR6mqnBh9VNXP2CUx1+tfB4IoyFxm1LM2JXFtd?=
 =?us-ascii?Q?auB0y/yY+WXWGsoaGDhX13N+TT1g85YI63uDsNhtMhX8RLYMimRHunSJ7xWa?=
 =?us-ascii?Q?sxeWBFzPT/jHLn7vFAvNM4ciZi5cvzTN2u559LVEYIcMU/phS2BXvr9UZINm?=
 =?us-ascii?Q?eOnzsW2xVOhSJgHrFqKAWi9Qa2zS5KyJzNZ9H6pKSorXvJoZloyij1DHHj96?=
 =?us-ascii?Q?6Uux0q59YcYd7lpkgrTHw81Q9asnarVUyZlkZ93kFc/oH4I0kpUMyRNq+nh2?=
 =?us-ascii?Q?31Pm9H7QqHfczgZt3M/NIByUmB1qF65bVlSwOjOInVrSP897wijCzlrfscv8?=
 =?us-ascii?Q?mczYnTmxlQZyGiSVSPpTP0RMzPEdP8UWq+zz8nA989JVmkVdaK87+JtAZCp8?=
 =?us-ascii?Q?m2vJXDwqnKyTDR748TBVUqYHMaIl/gsjpSlSKt+EuijUUV8fuJ9jbuzEKmWR?=
 =?us-ascii?Q?VHUFvwmqbXrK6k2F3qn1XkeTJQqmw3p1eNP/h8tgcUqULAhU8zpcoTs2PpU6?=
 =?us-ascii?Q?vj9Ba+AZMHyi8qG4zyp6VdhFUCui1RRm9mS9+jfi0WnI9J0cHdFsVZU/p7Yv?=
 =?us-ascii?Q?jcy+2qMC7WEzlBtmJE0li9Ljt982tnUVJ1eeyGonN2S+0HiqfCZVmVHsdG8g?=
 =?us-ascii?Q?7FblZkSrqt25X3+rpwLmajGgl5md7MVxvfwDmnqRCO06teYDwpRZPr+5XL8h?=
 =?us-ascii?Q?XdfkFOmT6vfMtfGbY/SdXSsySN0UakcrLaBhcqFXITtbpg/P9w0Qw2tBKvEg?=
 =?us-ascii?Q?ksiC0Aun9Ttqq6pOXs3ZNoupGns3zAennqQlBPtfM9Zc29gNi1evdNu3prt5?=
 =?us-ascii?Q?mg5q+TIKC8JPB/BO+f0gm8JLGNkeLaU0ujuePTYNiY2epQa6736v82/1bTB0?=
 =?us-ascii?Q?rcajiaPDBwCnkYJLozlQhVABXClOFgJIqmAt1iq02C2K4gsR7GxfApbB1/Hw?=
 =?us-ascii?Q?cAoPHrswkJ3JLQCZYwdItc8uKzFTl7U+7sBVaOUIHqgl08VP5ML1aatw/SrF?=
 =?us-ascii?Q?vfyDDF2gwrPl3htZAzEN+DxdKthBQ5XYpYM7hHyrqyEzLPqDcnp4e5puuDdx?=
 =?us-ascii?Q?mGfS2b83L5YI044bnIoxmg6BcmHgu8bKYgVJCep94Ql65vpCeFMaOdrfAEmy?=
 =?us-ascii?Q?9wwV/Eb0nXg79mnwP6eJBrhDylbLWcnbDA/MTuovdy4MySHC+Ug7tee/rktn?=
 =?us-ascii?Q?kiWzGsjuqi0hHQ1PIHfyI8tbJJgbTWlYPsQmxcih3IEnhbcrVrO0dHLYwyna?=
 =?us-ascii?Q?rD4//7yv7jj5FBqJ0xE1vMa9MhX2fd7UA28VN2WrIY4jIQw5kFhoeQ8MhAef?=
 =?us-ascii?Q?TAfHRuSPvDgX9G83rKXwe4mHnpZidnIRnfF2u2IChu9/A7eryXA7h1n8bn5o?=
 =?us-ascii?Q?aKQ38OhUka5fnKo35qC3a2A8sudjAv+je8ENQSqPZVvOXnzh+P/4/Cik88lE?=
 =?us-ascii?Q?dd3/dPQ+fu5v/T34lm6WhSsUrHlemQOfDWQDxaM2/wJg2PtnvInW03TDt6Eo?=
 =?us-ascii?Q?+Qk3zvOyiEfQsJKTMW9K1as/6ZS2TAlDVeupZCoxCTGYxWnnytWWB7uz+Ctp?=
 =?us-ascii?Q?dcVToCMv7K7/FaJqG0jrLk3CQ7CnjdlQsd+WJiWFnn10yT0MWAczNstlwiC9?=
 =?us-ascii?Q?WmoZ59KNRv6Q1nI0AcX2dfk8EXNtT3K+Mmbh8/fiArwbxYJrHIM81/rUq6LG?=
 =?us-ascii?Q?c0rIJg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 11:33:09.6495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c653cc-5158-4c74-cc75-08de5c05845c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9606
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
	TAGGED_FROM(0.00)[bounces-15968-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0FFEF80481
X-Rspamd-Action: no action

From: Cosmin Ratiu <cratiu@nvidia.com>

Commit [1] defined the locking expectations for nested devlink
instances: the nested-in devlink instance lock needs to be acquired
before the nested devlink instance lock. The code handling devlink rels
was architected with that assumption in mind.

There are no actual users of double locking yet but that is about to
change in the upcoming patches in the series.

Code operating on nested devlink instances will require also obtaining
the nested-in instance lock, but such code may already be called from a
variety of places with the nested devlink instance lock. Then, there's
no way to acquire the nested-in lock other than making sure that all
callers acquire it first.

Reversing the nested lock order allows incrementally acquiring the
nested-in instance lock when needed (perhaps even a chain of locks up to
the root) without affecting any caller.

The only affected use of nesting is devlink_nl_nested_fill(), which
iterates over nested devlink instances with the RCU lock, without
locking them, so there's no possibility of deadlock.

So this commit just updates a comment regarding the nested locks.

[1] commit c137743bce02b ("devlink: introduce object and nested devlink
relationship infra")

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/devlink/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index 58093f49c090..6ae62c7f2a80 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -178,9 +178,7 @@ int devlink_rel_nested_in_add(u32 *rel_index, u32 devlink_index,
  * a notification of a change of this object should be sent
  * over netlink. The parent devlink instance lock needs to be
  * taken during the notification preparation.
- * However, since the devlink lock of nested instance is held here,
- * we would end with wrong devlink instance lock ordering and
- * deadlock. Therefore the work is utilized to avoid that.
+ * Since the parent may or may not be locked, 'work' is utilized.
  */
 void devlink_rel_nested_in_notify(struct devlink *devlink)
 {
-- 
2.40.1


