Return-Path: <linux-rdma+bounces-16408-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L96HrGfgWkoIAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16408-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 08:11:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 278DAD58E6
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 08:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4B4C300AC8D
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 07:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74AC3921C4;
	Tue,  3 Feb 2026 07:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o0s05xlF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BFC38F955;
	Tue,  3 Feb 2026 07:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770102692; cv=fail; b=re7EUHDZQATt5ZpXa3eFbMGqX7w2Yyednqk7KUsTxX6qGrT8/zO7la3xgX5lXYXXQTMuGqCQ/kQsvjP0SWsarT6UFq07BqA48GTng0XT+hrqELQNi2UO0eZt7Kqi/Mk5DCFFbYWpLEl17Ei2OmNEx1TKeAEDcTN6uS65vIjw0dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770102692; c=relaxed/simple;
	bh=kZ6vVf3VXWpzJ4LHLOJ4JcURxXS/OE/gdj49ylhf/a0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bicYqJFck77IwsafUy5Evnubw1MPv35JuptyE60sQV0KZbxg1JzB7syMczlYAoz3BvFhJF+Y2YpX1LOlaLRWDMXHQgbI9xaQpkyYJN/q0pQ51fSQ6TDh+ofru1pTdoW8OhFYNB08Xup0QsfOoBOlBzzmKuUby67qwmLEZn0SE7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o0s05xlF; arc=fail smtp.client-ip=52.101.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWmRB8zMLEm5P86+XOAitdD4oz1VZyUNdGYEiZ5BfOZKj0g4uVCBaGpZflYVMBFx5JnV/8LmjDppgEs1s+SJJv6/nf65lEzwYRbrSdpGnIIVFz2CA5isodfHvudxhPy0kpTYVvDgA5S8DUEs/Kf0u6Cpkmx3w+rR5tK1nTjiQ+EFW0VIra0U5p7nr4JS49FreTWgqC2f4SAIt/HAe9GRHBvF+SdVyhlo36WD7q4cRYxyzuS4A45rBFE8TVDC+Z0HwHx4QGy0ltuOlJamVrUl3doECnXsHSknL82UZrjNOen1o8vXEpiKiubETJ6jUf8bu03udMP4FLJ75k2ml1q6Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuvXm9+yLWMXjQ/n45T0AMevBkJtOMMhUznw5FBYFu4=;
 b=o8FLg2a6gj+OPSDHxhhHTwXaFjTIck7gMQTMroux6V5zUOLvX0qIbFQCk2YOVBiH8GYSsK4E4H1WinIu8dJRcSmIiI/lK5wX6I/heq93WV5Lc5cvKw+QPNqfOsey9kolV0HLZZOvWT4+6ZbuzBBujrjTim1SREeTwhvK71CofZxPkeyiu9FzXLEPhlAr/PSZHRUFcS5oZyxpmxgVzenMRWbt+K68knKTFi+MDFQOoJrSp1mfn0rcjYdyNYbZ0GgiBFQKZKv4hQW1cGs4F/xFQADyJOctKjZcfU/50mLHSoryhZ8UzEJwB5Ro8rN7mrSBpabyHtt2pw3XZU38LWKLLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuvXm9+yLWMXjQ/n45T0AMevBkJtOMMhUznw5FBYFu4=;
 b=o0s05xlFaVHPvRg026GsXWoobePiItYTz/H6elKiiD69bAjsnhNRbcAYwWTlBc9l58aIepzWYM6A/v+AtIE6aXdulgDAxZ8PWduZpdeHXeM3j+VCgnp/QaUjaiI6vY1OKV0HfI5otjkIHkxQp2TGGN5l5FivYGAmiQGW/Jqr3j9kAkwGQGW0NXURpIMeTD5ZV0/sfDftXRReDsljbSgCzU1rdrGMtybGt40Q3nImVFI1wLNgtuYfnHpYkEs7fBYlLqkuMPfBglYwZl77PmD8Yx477gHhRXpIJPY4MEcgBx6AHrW19ycaWFlgZTH1Xhys+B6hD/XtccanPSZpy4IbdA==
Received: from CH5PR05CA0002.namprd05.prod.outlook.com (2603:10b6:610:1f0::8)
 by PH7PR12MB8055.namprd12.prod.outlook.com (2603:10b6:510:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 07:11:26 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::f7) by CH5PR05CA0002.outlook.office365.com
 (2603:10b6:610:1f0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 07:11:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 07:11:26 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 23:11:09 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 23:11:08 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 2 Feb
 2026 23:11:03 -0800
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
	<shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 0/5] devlink: add per-port resource support
Date: Tue, 3 Feb 2026 09:10:28 +0200
Message-ID: <20260203071033.1709445-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|PH7PR12MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: d1edb1e8-2007-4911-0eda-08de62f37212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I4oaQGTqTiQHY9zy7khpYEHX7MQXrt8tgQqMZAP977qvjieNEot5faKFaV0A?=
 =?us-ascii?Q?K6EAbJbahRnUjbg9m47GMsxUjhESq3pZSnbfUeM/pA6Y3MwglBS7IDnodW3z?=
 =?us-ascii?Q?SRX0VGfgLQahP9CjbtGPkm9ZO44k6v2XftwwVd+huQAZwbmKTRQVxbE0oBd6?=
 =?us-ascii?Q?lF0+6cIxcAp/4+eDIsL12KMAXE0EtD9DhaD7mL/KHsL5AjBKcDJXNHKRQh3Z?=
 =?us-ascii?Q?bDUOr1zNOKiloiW1o2Uow9RTgCaw0shrsoeI/qG+GyHQqz/4lD8RPaPGcGz9?=
 =?us-ascii?Q?b711SZH7R67Q1Rrd1fba59o5RMvQYDxOzNvQw5vS7+MklzfHJk9F+MpToACB?=
 =?us-ascii?Q?Vsj1xNk+iaMP52S3RWaA4bsAqqc+eR4LEFluAWxCJC4vVhAABxI/AiAPROZS?=
 =?us-ascii?Q?Xh5gY92e4Va0hNiLjnuc7kxWqwQPs+wRijnxhr2Fo+ufBVhZ1Q4i7YC+YicN?=
 =?us-ascii?Q?HSBsDDVLiW/r3DkFXWZI/QYujcbACtHQ6yPx0sy76xLB90lpu7tHb9mJ0mQS?=
 =?us-ascii?Q?6m9nhq+2VJBP3s4wbcDKPM7D5bFBrVILRPFjuBkS3gtj0f1oepqf9N0dxP21?=
 =?us-ascii?Q?Wvv223ZRFCPxrrfpT3otmfJ3C7zF4VoWZQ1befwGzrn/mHmwGUzf228XAvsE?=
 =?us-ascii?Q?8zoO0XTwB8AYa3vYXyr2WZrKzUiyEzP5ho4wXsfCodpvN+8GFVdyt72sa6FE?=
 =?us-ascii?Q?LaSG71i5kJPhdB2NThMhuE/nsjtn+ZnKo8wNd/isOXDHj8yKwueSlO8FN35D?=
 =?us-ascii?Q?k5zAhz0UiH3CVDwjvHvEv97oPV9QIGpMflPqj5DZXF8gHWa+tsmv95u7gkBe?=
 =?us-ascii?Q?7FBYviiS/9cjMCzhjG6308P3jQHhylWodLIbJTAdqAwD2avPeNJTDkbRuXB6?=
 =?us-ascii?Q?gnsHMHwsD46GjRgFt+Jx/6tbogTGyV3QlTJ+dloagKlyZcOfQYGJ6OCXoGXp?=
 =?us-ascii?Q?y+5YAVFIUqqNGu3M2ztRJ6WusvaEpKLOz/FLxDA0MHFHG3vM3nJY5a/J6Vf+?=
 =?us-ascii?Q?o+/m9R+CVhZiH4pTombcP2tvB3IH3HdGlAeO9Db7DU44txzaXAkEATE3tXHD?=
 =?us-ascii?Q?63QomY6YKPCeF/PLXtS4jQfvLEbHga2olXA5qqIBifbMRJArjlh5kkj4NlbI?=
 =?us-ascii?Q?VAzetT4XDDX69/OxUHDSMg9fTBWz2ivBJffxWTw/Eex5+Muico7nVj4NPYb5?=
 =?us-ascii?Q?QKz4SgzZ8yz78eqzXoY+nmGvIZaU7AEmtF3ptX1NvS3vYuKHhiHNbnqctThw?=
 =?us-ascii?Q?u/mNJaMUAo8BXSx0y092UmBjSSO66MHBv31qkc/LjW56So7EVt4OJD+NGxhm?=
 =?us-ascii?Q?bC60T9fJgx90PhXahk91kKQds9Ena/3Yb4PvRKTkovvXC6DN9DlGiwMPaerI?=
 =?us-ascii?Q?4K6vkeqJcc4xnBhPeNQ0kXnHPWCkNSOWYQgUBD5rjOxQrAeZ8W253tVJYxKH?=
 =?us-ascii?Q?PiUQ360LIJ1HdrmHs+p6uhQ6RCaVR8RtSLPoAtZs3jm401Xf33kJNdOjgDUH?=
 =?us-ascii?Q?KFYy7BS59Di3UZ1LdBaISiwvaKnDi+mW+wgeqWzUvL7bTjj/upi/6qa6PAta?=
 =?us-ascii?Q?IgJEEb/N19Pbpvwbk4t6Nmcvm610QB/QEuv1JdLJrskIcGcKzOyRbgOfwv0V?=
 =?us-ascii?Q?h1fOPGn4CManlevvvWA1nxTx47iMyhIPGg9KVSCdTeBhyNs04de9XEqNjrrJ?=
 =?us-ascii?Q?tYcGuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	51GzDrn+IWcsJFJ3XMi0zz7kFA4elZurXMtxCnlArgtHVi/dibHuT5tIDQWer/7ovDfv90Q3RkbI13Y4sYu/PsIWDo30AtZJk8TbEcUUwhl5oIq1HIRI2j4lAOABcGyOqjiOD3YbSe4lvnXmYCHuJfmg3KJHVdtKGADhcTl6KgjXd3Yh9JTNP4RKNyheEoamTZzo1N5PkRlMpR7w67XQKemXZ05f6+PbYDvUE63x1+/x0ohBalDTAPCXRPyd/CBy53Bd36tef7RAzf38Ipa+wiQMRBDjmy8BjS5KiVBymLfcEHxivzaBvlt4oTsQnVpnrqNBJBXe0iZ0Uofq1NLQSbd7WiGCJA6cuUf2G0TEg/dz4jN1w0uPXpatHbpEP/1kvoddWAOGzTxWD06QNIC3fDLXtcQkyfS/EBKiMQN8k2c0zj3XbTyJPFFZ+ZO9symE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:11:26.2064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1edb1e8-2007-4911-0eda-08de62f37212
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8055
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16408-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 278DAD58E6
X-Rspamd-Action: no action

Hi,

This series adds devlink per-port resource support.
See detailed description by Or below [1].

Regards,
Tariq

[1]
Currently, devlink resources are only available at the device level.
However, some resources are inherently per-port, such as the maximum
number of subfunctions (SFs) that can be created on a specific PF port.
This limitation prevents user space from obtaining accurate per-port
capacity information.
This series adds infrastructure for per-port resources in devlink core
and implements it in the mlx5 driver to expose the max_SFs resource
on PF devlink ports.

Patch #1 adds devlink core infrastructure for per-port resources
Patch #2 registers SF resource on PF port representor in mlx5
         support dump
Patch #3 adds port resource registration to netdevsim for testing
Patch #4 adds selftest for devlink port resources
Patch #5 adds documentation for port-level resources

With this series (and upcoming userspace patches), users can query
per-port resources:

$ devlink port resource show pci/0000:03:00.0/196608
pci/0000:03:00.0/196608:
  name max_SFs size 20 unit entry

$ devlink port resource show
pci/0000:03:00.0/196608:
  name max_SFs size 20 unit entry
pci/0000:03:00.1/262144:
  name max_SFs size 20 unit entry

Or Har-Toov (5):
  devlink: Add port-level resource infrastructure
  net/mlx5: Register SF resource on PF port representor
  netdevsim: Add devlink port resource registration
  selftest: netdevsim: Add devlink port resource test
  devlink: Document port-level resources

 Documentation/netlink/specs/devlink.yaml      |  23 ++
 .../networking/devlink/devlink-resource.rst   |  36 +++
 .../net/ethernet/mellanox/mlx5/core/devlink.h |   4 +
 .../mellanox/mlx5/core/esw/devlink_port.c     |  37 +++
 drivers/net/netdevsim/dev.c                   |  22 +-
 drivers/net/netdevsim/netdevsim.h             |   4 +
 include/net/devlink.h                         |   8 +
 include/uapi/linux/devlink.h                  |   2 +
 net/devlink/netlink.c                         |   2 +-
 net/devlink/netlink_gen.c                     |  32 +-
 net/devlink/netlink_gen.h                     |   6 +-
 net/devlink/port.c                            |   3 +
 net/devlink/resource.c                        | 282 ++++++++++++++----
 .../drivers/net/netdevsim/devlink.sh          |  32 +-
 14 files changed, 434 insertions(+), 59 deletions(-)


base-commit: a22f57757f7e88c890499265c383ecb32900b645
-- 
2.40.1


