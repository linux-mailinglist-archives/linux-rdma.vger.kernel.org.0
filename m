Return-Path: <linux-rdma+bounces-14723-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0627C82A6C
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 23:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFD53ACFB0
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 22:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7BE334C33;
	Mon, 24 Nov 2025 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hpb0OsCj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF1D32E68D;
	Mon, 24 Nov 2025 22:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023337; cv=fail; b=rzhOd9tjPOjZ4CsY0U5b74uA7uA35vzyrhiWSVSxlu67dRYkhvxyYse0HGFhiVYBi+t/ECoP6BVP2qorTl96IfqncQNMnFlIUwYlLkmja6dTrEPVCy7V6JPQocZTGcIAVNqMxrRQUMBczIuQYJ+OMOzLGkgwvedndBY48Qhxidw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023337; c=relaxed/simple;
	bh=P8W0FIsXR1/VWMEyIG4knFrRhHdsOvI7EcP/vxGKWms=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tets499YZBuNzBAK1bd+XhCGD/+KePvDi0A2EQ90VV6Xs+vUg8FhdfPues182bqrnQG0GRG5yU/cIu2iZWZR+bhEeiVTQ6dXtIwdVJbX0JWpylgJp50swhLS8NwsrY7sqqe589o8GWkF0OHlZ58zpGOj8wKBWp3NWlSO/wbak5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hpb0OsCj; arc=fail smtp.client-ip=52.101.48.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEyZsQlqhALOSGehGBSnisUvVH0n29ati1syhtBs9+fj98azkXby/I9/Ira97v7SQCp4itdQJ1dJN+0/k+LSvxwExBQI2SdpwE5Y53iadIIMvquDh8ZPNXIN/pYgM/z9xjCvcQ9HoRddL8G4NFfabVrkxheAW3ozdPknOb1RHJj3DwJys4t3BZd6VoBi23dcbRc9qaXl/cnV4bdOprzBkdxlRbCqmyGdHjH/6Th5X2ngtar2KeqYBxP2cRH4+LIkWbx8SReF2y6yeDRhtfww6H15rOZLtKa9+aSfE2PzcN8sOYKBbkZDD/tYKYV3XhBB8GReMG5VJqgFYRKAdqIkEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kglGhXi4BWERJc11i4b/YsEsnv0Fea8SDE586jjlVTY=;
 b=uzCQdWFA8u9cxmXCPfnFS1yEogWJ0OokgDYquI2RHj72JaRek/yREp9kcSt/iAB4HfYl6tO41YpcN98lWTCKZqTqB+KHpXZvn4833cqqw0iqyiKxLBTNF7P5tHvju3dZiC0qjimRyJkYjytuitu3bjBfRhusppLON9UPTEB3xLjyk0ZQJsPIlGrIPkHdvKeprpMKPXeWEdHlIxHEySojL+reHO9YLZIhesSx4q9dHyt/CPBth9o1KlkMlmbIpnvdBImEyKmJYjopLOEBpvf+BB/KH6baXk5Hoaz52q3uRx3/YcicnD/WCoN+P0p4aNS+Oa5Afs7D2CQnc+vbU6JuQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kglGhXi4BWERJc11i4b/YsEsnv0Fea8SDE586jjlVTY=;
 b=Hpb0OsCj+C2cozVbMyzv966UcedGrwHBHMCzriscCqacHakqDPSxeBRBPJFuKlq9WpxCMyRZjqnZGX93kp5kW+7y3j7Z2u/IXs+1O7trhN3TN8qjebHJ7g6V5sf9sioa8WaoJBvFy2ToER18okg/iKfTGhBAtDnnOH0U5Gs6QcHtAjJPX8vgIu0VeS/HkXOnTJlR0Vb8I7hzqKGZT8h9pYPEJZh6WGjHpvPQeSFamSSZSQ9W+vSUhnBXoo90M/SnIEUZAiGxJ1hV4F0oPIr1GBH8MtSdWGrVmOqatQl/5ZqiBlm/5KL/Rb0GH0D+EvxcO+Oeyb7vn92JaFWr1LF13A==
Received: from DM6PR02CA0085.namprd02.prod.outlook.com (2603:10b6:5:1f4::26)
 by CH2PR12MB4053.namprd12.prod.outlook.com (2603:10b6:610:7c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 22:28:51 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:1f4:cafe::5e) by DM6PR02CA0085.outlook.office365.com
 (2603:10b6:5:1f4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 22:28:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 22:28:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 14:28:44 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 24 Nov 2025 14:28:43 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 14:28:38 -0800
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
Subject: [PATCH net-next V3 01/14] devlink: Reverse locking order for nested instances
Date: Tue, 25 Nov 2025 00:27:26 +0200
Message-ID: <1764023259-1305453-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764023259-1305453-1-git-send-email-tariqt@nvidia.com>
References: <1764023259-1305453-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|CH2PR12MB4053:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d606ad-ed3d-4390-0b76-08de2ba8d829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qUXhHbIdPbzZGadAH5wBzm/WtZFUxVs3/8LS+O+pEoNl9ETrLqnDmJ/ZJpFU?=
 =?us-ascii?Q?Sco2qwqQj48taOrVSctz1DX6kNlXTbJAxg1nnWFXFpKS3/e6YnbMTzFl1OKU?=
 =?us-ascii?Q?wYcbNevpN/VXsD98L9lD/t4Pd9DVZBSZDRqhQ2z86XEquREt5SjuAZPph7Ts?=
 =?us-ascii?Q?Gc/jGmjUkXbVVvfa8SlY4dp0VVNwrArEpW4GwpDuB6Ss7C/We4t3XoxYjpTo?=
 =?us-ascii?Q?NEX7ggh+5mpz6awZkj06DC4XBFko7USyrnj8SDrCf9yNgxGEwG9unbrcPvNz?=
 =?us-ascii?Q?fGVXGcqtVN8esSsSP35uZe0wuglMfQaKg31eieiSEN2RFCjAqxwvAN2CgAn2?=
 =?us-ascii?Q?yFBZQNMQyUO6NSwEYU0zQMp5PK0OeHWTHVorC64EZvjnG5Sw7AGpyQbYhwrL?=
 =?us-ascii?Q?Ix2Bq/4a6ES8IYDTVYYQFXG8HvK9sCZBqZcwLGtvba3ICpMIFT+SXGggUJOe?=
 =?us-ascii?Q?pHFVfgbofamQ6s4MaVv73cij2NSJJb15F1Wu64eE1mE2FTmeKqcfA9wVIzmG?=
 =?us-ascii?Q?8jPllFDrWeT/IMZOyxYpvZ+m6oItLT13aKdIwK5+uOYv6cjr5WdHztIu6Mqo?=
 =?us-ascii?Q?Ah6AmtwKtymIXlkoW3M4l6F3/iHkCNtRVWct9k2gaQstFlx6LM4CNEx8eFd/?=
 =?us-ascii?Q?AeT4XXyzxgCb5hCzbrE6vVxN2DSdl3dC26QP9XEt+j50PqNKB3XwD9TfMMyO?=
 =?us-ascii?Q?FEf0xb7MoVe1ZLXHCQYptLcQZh0nRiyTJe7wZmpu5n4+JwFMiGWeRDflf3dG?=
 =?us-ascii?Q?dwDQnp3cCDWTUsI5R/sGyfxPlF1vYbH8UCrjnJwdo+YPy8i5MjOfTjTY3Unb?=
 =?us-ascii?Q?OJARKPTKyS/VI1lUoGx7mO4FOJ0kQTnc/4/Dry2KuUJwOZU3FFRqzKuTe9nD?=
 =?us-ascii?Q?rkZZWhey5GsQRVbDyid1CwueDA3ZLH3j/n05f4dRX/5HcFhknDix/Dd0DIg4?=
 =?us-ascii?Q?39HmmcuuEayHo5wq2qpccLL6Wz9I/GuGAYJSRjzJn5v337YtRnVUUnWjbr1t?=
 =?us-ascii?Q?1CFyTNlb5jqbOsiqaeqJp6IUgzRldbVLViaCyarZ9MkeFep6g7R84XZc+Ghb?=
 =?us-ascii?Q?Doc3VGa3yMq5o0vzGVcFS44jAPgeSW3s2QOdcnB/SKXDl1/U1quGQTEHGUz7?=
 =?us-ascii?Q?Q+3dJp9QYl8TTGorjilVENfoxKPmRn1VhEaHq0Pnoz+MTV/7ZbxfVfNOhcAd?=
 =?us-ascii?Q?YuzZzRir8D60QVHXh4k3cFdZqpWAVAV+lSXLe/arNk9OP0YrZYXicKJQjNo5?=
 =?us-ascii?Q?tX42LCtXpBZNocCPdc3GZk/g6gFM+CM1BFqttxaXO35/jQRVfBMy6W1mrzUO?=
 =?us-ascii?Q?Rk3zFCdKqsMb9h3Y4pJDTbUYPZ4weWMfNcVliYKZMzNVgv94ge6iDHq7fQ16?=
 =?us-ascii?Q?nvub5DzssNf6DPHCWPNzdYwuVbi1O5/h8WOp6dxIyv44FYwdcrshJoGfGaTU?=
 =?us-ascii?Q?63ZgVe5bBdnm+vgKjduZOAP/jIi6sqQlJFoM2yafA3FdeV5cjGC+8UZLMqKi?=
 =?us-ascii?Q?6KDZgqqGkWGe7GVutLyZjDLdOW18ElV/YLL54GZTm45c9WMHWA2D34bigA3/?=
 =?us-ascii?Q?+wERds6btqMEzd9DYH8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 22:28:51.2666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d606ad-ed3d-4390-0b76-08de2ba8d829
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053

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


