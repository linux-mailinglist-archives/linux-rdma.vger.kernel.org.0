Return-Path: <linux-rdma+bounces-14686-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B833FC7DCD8
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 08:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1EF23AA826
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 07:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3143729B8DD;
	Sun, 23 Nov 2025 07:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E5T1XH8W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011071.outbound.protection.outlook.com [40.93.194.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154C22343C0;
	Sun, 23 Nov 2025 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763882615; cv=fail; b=aTGayoh1viDFVxC62kbw5UNTEh1N8KAA84qNpmTn+ptahDM+IwKRUqfF5t0PB2H0MbjkZhh0fC6HDD1YuCSpwUP2pA78Vo/LgbhkEl8BQpR0ZRPe9NjxHWIoNurrW9p6pgG5sPkxHaTgFOKchG5RVfsXcZu4JRCbUyYLNAAvRGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763882615; c=relaxed/simple;
	bh=P8W0FIsXR1/VWMEyIG4knFrRhHdsOvI7EcP/vxGKWms=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qpARWDZX5ZnMxftv1gl3vuea0wCGaD9sH6JjqU+Ixp6yCckzrhRCK20v8PrPI1tEkdgS+m/PpUE14IkXVvohokyyvj/11LvbFed29rt3ukcF1uxGJJ3OFx8RxPYFbn6jWGlBsY15wkiVOPCNFgqUdpAhcGY3HVwuer/lh4J/uLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E5T1XH8W; arc=fail smtp.client-ip=40.93.194.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mvmh0PC2lmhpIl9n38YOi6eLk7rmiesQvOyRW32/qcnAcSOVGapKfzmdtuQCUJl7Llrl8w0tSU2eYB/SyjBpjlN8lIG4W8tMZKf6UC0GG2je+A4nlt/U8UW7Gyzj22Lh0DJhWl0NnLNcUiXN+DyFpyUKfEu1SnzgGKtJskJCE1cxqj041PDGhmuctQ6SrNIiH0aJC5YdpPqUPIJoiOSBz1YTLizFuP9q5dsw02kuBSTsto4rNfNapbhuH659EWw3ZhLckOnUk8nesaM7CguEHULg251RpbMru52C6ZyYNWJUIEhXIsE87w1dvR0WE3fiVou9KZNlu/YIuKmIcPepuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kglGhXi4BWERJc11i4b/YsEsnv0Fea8SDE586jjlVTY=;
 b=sTNXaYpmO2bEtLFSB5N2UEW+mxMA10VMbVdMUCfxSoX1lfgDPQa5ieN9xX0JeYrAl2zHaJ82IwdKl/+qeZCEjAtv8h7XAwSK446HF3IrU0+2huGZgzeJADUPF46FFIBN9U75kPa9muD4FL+lSWIOE4sM2GsFYTwYh8bHC3fwEZrFS43PYt05q42rYdYObY+y1B+8rPY9fCn/p8f8k/+cQ+TvW0kkkE5ITVLRLMDMZETri81QpBpc3iY0CkPbVnjpW/djPdCWEmZSg4l+wCX2pKxOjKj9qA+QYSy138bdt8+atcr6nJSJbcmcVWuTWMIC6cUBBL+VF1UbEZ/0ytUA5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kglGhXi4BWERJc11i4b/YsEsnv0Fea8SDE586jjlVTY=;
 b=E5T1XH8WQ/uW/q8ORe7ph2VwRnwBHiIcoY/nltknWUgE1eSrBE/CwldD6phjv/IuUMcvZvNchH0mYw11LPK0BfK8IjJ/EmFCKr1YvuAN/Fn0fiCjr0Dd2MMDtOHyJlgGuA5wXTzdVm88P7WMBXK217caahtnEnuw3WQTAI9h00gb7O7DgqS4Uu53BbtwtWkYYOFkqro3VouCtJLtUXPKahBfCfgXF6/ekaH7GR7tDk0aYU70XFrdOWk8SJ5AQQJb+MZdFzT78jZ9JYJuqyoNF+rejb6VE9c69T2uldUR5F2W+ps/OzT1j58SnkpzVwsl57jTn1UaeYFPAA6Pxtmj+A==
Received: from DM6PR02CA0142.namprd02.prod.outlook.com (2603:10b6:5:332::9) by
 BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.16; Sun, 23 Nov
 2025 07:23:27 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::2c) by DM6PR02CA0142.outlook.office365.com
 (2603:10b6:5:332::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.15 via Frontend Transport; Sun,
 23 Nov 2025 07:23:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Sun, 23 Nov 2025 07:23:26 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:23:18 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:23:17 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sat, 22
 Nov 2025 23:23:12 -0800
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
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V2 01/14] devlink: Reverse locking order for nested instances
Date: Sun, 23 Nov 2025 09:22:47 +0200
Message-ID: <1763882580-1295213-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763882580-1295213-1-git-send-email-tariqt@nvidia.com>
References: <1763882580-1295213-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: ba5ae0ca-2970-4bae-2df8-08de2a6131b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3yEDzQD/YSiOEzj3Hbj0iJqQiOokHzR+C8Kh7Fch+mAeZ+zvzW1xTzmd0skg?=
 =?us-ascii?Q?w2nRkVuimsPicstvKepx2GOcnIezxvXWafis68qw0brsBeyyRej0OY316brH?=
 =?us-ascii?Q?oVLxlD7a72gpu5hOgGNsdOSUgiZKxhiKj1NTeRC6YwAYdVICWf06UWi9AqIq?=
 =?us-ascii?Q?SmoUH1+rcnCkD4MSJTKeFH3rPsjs6/u8wv7pw8+QTwT4GeHfx1WhX4bnLxhA?=
 =?us-ascii?Q?i9+xIfXMIrpNGy7hpVZeCzgS2luJhR0rwfx0W7bRW9nrV27vqhed2OpzXJYv?=
 =?us-ascii?Q?fSd4tldUMRIyyAKd6PYN1sAZ58x1wqEPZ92ovyHwg3dXlcq/pWtGlOAnC/Y+?=
 =?us-ascii?Q?69DGhcENcfy1CBVeabeV+HaE9tG7d33QzR2fpkYhMSJJP12TA/GIWKQkvzYp?=
 =?us-ascii?Q?433kv0iskHClV6W6QqVEYOy57XsmhmbBre6VV3yUuIPUj0HgJ8/ydqiGVijE?=
 =?us-ascii?Q?S60R7DxPaG2qtHhexviN/7HEPDfOKUWCscMLHPJN6j5daPabFaWWSt+7CT+c?=
 =?us-ascii?Q?mtI8pCXsE0sB+OrbU5VK92iF6K1PoK+JMQzNQVl8t14xGn5lR3tMhGrgPGpI?=
 =?us-ascii?Q?fGmKTv1FhlMb/6GCENQhBqhq3laBwkwYz4/ksVfY+IvWQrzUsQYdB7nf1xK4?=
 =?us-ascii?Q?POVKiZ+hPC8eRZ6Q61AmE06fZWX/Vi2b+1D11WVV9FCuXTWo91M2DBCj1Bdb?=
 =?us-ascii?Q?9bLT1dwqwqumLlG4TmrDGiOLXeIGxAYEDqmKorwTekh+ts1bTrYMRX/UI347?=
 =?us-ascii?Q?7g/jnWNUdMBo4HvPjV7jp6RMrIPmexzspDi7pWo7DijQD5viQEFgk6vrv7Fk?=
 =?us-ascii?Q?xo6Z8ZNrHJMdCKQiPloq/xW91DPxAKfbwMvTWHtA/K+2DvROadB0ODa7jDgQ?=
 =?us-ascii?Q?OQJORha+ISlsGLGAn5p9Lq28AQIQrAA8L0bgRmbBTJLKC8j4oP9/AEeWA8xB?=
 =?us-ascii?Q?AEb0LTAVP4XC6jx5x6XAcSMqMWejdMAdmVluwuWg2ur3QbbOK3ipTKblrB5m?=
 =?us-ascii?Q?HBTAdyRIm0lZE6xgJxTg7IjIWcgYSksU0g3vRQEST1ePXlMKKSVO+RBz2gG9?=
 =?us-ascii?Q?pesOP2obIBI+RLCUFzIBpYe+Y1fDBD9p8NwwYdPXVOq7Pe2qJOFRTefXHJgC?=
 =?us-ascii?Q?yPqHGzXJiOlA2XAq5ZSx90YH03sWHMDACx38RtFmbBldxqOtcbF6o9JmkJ12?=
 =?us-ascii?Q?y0wHtnTOznAKXMxRmXsA1yGNvp6ypsUeZav7HeVf1AA4kUXpuUFCT7HMIU4I?=
 =?us-ascii?Q?OERj4qCNszIebwlOUe0AcgyuyoPJfbALOBKJMiVoDtdlE/NAb1jIc8Obk+8X?=
 =?us-ascii?Q?8FMylpdFSYI3KuiaWWYbotuvPSEwm71xhUo6lJU92eAoGxD7Jk2CzUMJGsSe?=
 =?us-ascii?Q?wjTTbrSDwtRxEoETCA3TQxoplb7VW9NznW5HiuFiMbdZE8sVn3w0Cc5J/Jzz?=
 =?us-ascii?Q?a4XFAeVtaY5eBLQxxnoOoLKlxyZbf2b0NkRvSWO1Td2Z0qMvn0lnp956cq7z?=
 =?us-ascii?Q?twtB9CNJbbV8uS+lWkFUPZL9MF6DzU541xqFztfWNLJluNIA3RhMncfyjILI?=
 =?us-ascii?Q?suK95AtN2lHHU9sY0H4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 07:23:26.5793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5ae0ca-2970-4bae-2df8-08de2a6131b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258

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
2.31.1


