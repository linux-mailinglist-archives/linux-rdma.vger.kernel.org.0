Return-Path: <linux-rdma+bounces-21075-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OO6oFwO0DmosBQYAu9opvQ
	(envelope-from <linux-rdma+bounces-21075-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 09:28:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D94C75A0189
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 09:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 598A3303AFB9
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 07:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752BF397AEF;
	Thu, 21 May 2026 07:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OF6UXpN4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C9D384CD4;
	Thu, 21 May 2026 07:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348318; cv=fail; b=FEUqpdRMs3SLXd7jn4ChyHdPpYhPpM2kKdHM2LvAKw7U+XSar38w9/Fz/v7AKkKfZX5Fjf9tYceuM9zy4p2g4Q2nJGMB86AcM+aXvzABGsswO7wp+7zXqJVDhAH68Bpm4b4KUNA92ipl8L+kg0e1b6cfZga9lxiJYRp7EFzDM50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348318; c=relaxed/simple;
	bh=a5I5JIWnhkOHjw41Bwp7G44TrGLdmusun7T90bvgOm8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BF2qVZ2XZaWLJYyxVKLaXGHo9d2BoyB10e8LnOeeePlcCvgn08Mffi3K9SnYS+u9LY/nsRapPBuoUR9KOSEHEY0aP1ZmaGwfziBGAU2PMdpE54I71LqEQgIc7uVtfbT5MWsVF/D1+kS8TkWJLZ55QzTMI1uDmIOsHi27YuO7cPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OF6UXpN4; arc=fail smtp.client-ip=52.101.48.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sv5rqz2WxIh50IcXP5n8/jTu+q9czquFynkPBoBydKVgM8t9D7Frc4MvtJ26V8IhiyOdpsEtQACnQZ4AfgPzCNk3+PrOZO2UixjltyvcHNQkpFX00SdOlrdlQMy1QPNWvYyNnbv0fFae/7xMEQKeCMM8AAUNufqSPfelomnUrZRvcJcMegASasSaisA9CtU1bSyc9EBukZNZYJznuZL7RnZe0Aj+VIn06j/C7EDAigPtNnSwVuj7fgQpy+kbBGx0nDGVafQR1P0c/ADL9YGrYfIuscYP76BP/ECgk/LBpD4XNsu2O+oCQYQvG1t8B+HHjxIZO3ZRr1hJ417uXAPQtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsZIfBfDr7pHCAmelFZUIqSFuOp49wH2mNrLscraO0I=;
 b=JKY4lNpqwLiQHd7s2lZNhrPTwpkex+bkqTri4yHzo1/3YcNy4JRSO+aQkndOI3k/np0p4I5Sv5kfkoBlaxejCPCSU41+kYqKYlXrvB5BvsS9fs1+FOpahHlxtwOiyeWlLSomzIRvKupwU8eHrC1NEBXMzi21zLg8f9BmR4g7g/JblNAAcemdKi8yvck2QFmLpbUw2zrqfg3yQJMFQyDZJf3ppxDsI5ZnwlOd0eEodCCWK9lUUhyt/Hcg/55TVQpIB3p7hR4RmqocBnTVw1/jwlbBMYpsRHBaEeaN/vExUdqU/r5rsuJWBqR7PgBjMe/eWzGMBwFlMFznI5GCu/Ne8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsZIfBfDr7pHCAmelFZUIqSFuOp49wH2mNrLscraO0I=;
 b=OF6UXpN4gUqJu6m+RxKLmfzoRFNThwbkIuXWiBilQwM679NYPX0/CG6JDsUQAprXhaZ9Fiuvtljz6qDJajgLK9sCG0ashtl5P4mzNpj98jBKwp90ktHmE9vd/a1cymy56I3SOYngTgbXIL3DsSP7F3lXn7Nqv3JSz8bf06fGbRp1DC2jMvEO5pDNCnjPkXaCfkyVtwiJuFvn3nefssfEFVjyQ1mUPMzAQ0bKbEuSZ9w/aWD9OjNwi8g7L+UzTt5d1RsLmhroqTQaP3z6bKERsTv/3VwE+TRk2ia8gmjfk6PyW02CmLOMelu3mpFOaHp99ifkUeVimChygdYAPQDmTQ==
Received: from SJ0PR03CA0075.namprd03.prod.outlook.com (2603:10b6:a03:331::20)
 by PH7PR12MB7209.namprd12.prod.outlook.com (2603:10b6:510:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 07:25:08 +0000
Received: from CO1PEPF00012E5F.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::94) by SJ0PR03CA0075.outlook.office365.com
 (2603:10b6:a03:331::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Thu, 21
 May 2026 07:25:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF00012E5F.mail.protection.outlook.com (10.167.249.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Thu, 21 May 2026 07:25:08 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 00:24:54 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 21 May 2026 00:24:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 21 May 2026 00:24:45 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Borislav Petkov
 (AMD)" <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, Randy
 Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Petr
 Mladek <pmladek@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Tejun Heo" <tj@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Feng Tang
	<feng.tang@linux.alibaba.com>, Christian Brauner <brauner@kernel.org>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>, Marco Elver
	<elver@google.com>, Li RongQing <lirongqing@baidu.com>, Eric Biggers
	<ebiggers@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>
Subject: [PATCH net-next 0/3] devlink: Add boot-time eswitch mode defaults
Date: Thu, 21 May 2026 10:24:31 +0300
Message-ID: <20260521072434.362624-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E5F:EE_|PH7PR12MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: c15df455-bdc0-4a6f-dea6-08deb70a162a
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|56012099003|18002099003|3023799007|11063799006|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	65ncr7QGZBgTWbsGY2moOmkKij2XcRDxjsLZ23a6TLcSx5rrOVkEpDTd6a1XNTmkpuL/ZVZneTQTQcuZ8PmXam5Iu7sAPT1R326tf/BBUkKBhUEMf/wQ1yIvzieAMlCZktaDLdBfGZevUHMXeerhHb2jN7R6DhXg/5VPpxfpJQBzUhkxaORu/nXdCzqm9C+ZoaxMkrD4/Z/ETBWfacDEYjKd4Yo11F3oEYoLrjs8cs98hN5DOSCMX2VV10bV4ES/zmVLHWnloEDdJmFsEDWdcX1ZrF+jR88XkPZVbaVAHLGVEL4VV8ixJAfMycon2GQPRAEMAGeJdl2PQU31H2gGvYAJaGCejJW1XQZ2yYDhPJRTwS8pfL8o2YZNciKmWdlSKO/qVVdCAp6fWSChGFWRp9tk6MvQqwgEim8OaP4nWegAWVDmIKv60SSoeuRQH735sFDZ1qrvxT1QVrkYfhjW4w5ezBSJL6EqhsGs9h1XDrLSFgr8mPn+R9CGVEMYjm1Sdsm/uPH3K6NIqcaLfyMkl5gRYmLdRV50aaajfM2XYXRDb1MU+d0H5eNye9JW8WeWC4DPe1cYhZhKd/l8OP4t9q95KWVvxSc5LtSTm8sQI6BdhVIO/X0fhl7yg4CFmiNYESGYNmGq7ZkgPBt1D8GRCpBVP1+sZIiaqtDNxUsCNEDilOVxE4bKF5eD2otMxEioKvIdkDebC6tjqX6uLTQLAalt6S76wQShMLO8gsKcqXY=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(56012099003)(18002099003)(3023799007)(11063799006)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	P495Jzb0lqkXkZM/6PesAhoMOQlcbxXRmmZQTqz7s962pPas9vODmZ9Flvy0iMYLH1DC12wwOkv9JNCuGKRn0H8LgDIeE8h3OeqOaXV0xE71Aq93N9CDOTgSxy7Mm3Z2x5eFCkLeNGZaiedzn+5mTEgjDMS1VFjtRCYj1JUtQzWI2j1UQ0vwAZ3y/eCdvXYg//jNHpwMMkpv65uV4JkH5SZKigrm1prqSAJC19OfQoYJ6WktDH2GmiTb3ux+fk/rZUqLhulHDyggVgzor23IAgtjof1mJaPYx3/74aIV5XYNMZtIRoGPw6fp1BBxsYXRSFyo+uJzu2KmJhPJxO3MBjpZED9Z/q6mcgdNOlmCR98NGrBwMYf4QlqxVd6DHvH6dffOTPnfU0ASJMcwdUT8GbP5dUFWsPE/WdcnVLObS3JeA48n3+uPOL77VuF4wJVJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 07:25:08.1976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c15df455-bdc0-4a6f-dea6-08deb70a162a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7209
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21075-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D94C75A0189
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

See detailed feature description by Mark below.

Regards,
Tariq


This series adds a devlink_eswitch_mode= kernel command line parameter
for applying a default devlink eswitch mode during device
initialization.

Following the discussion with Jakub[1] and the feedback on the RFC
postings, this version implements the direction that was agreed on: keep
the scope limited to a boot-time devlink eswitch mode default only.

The implementation is intended to support the following properties:

- A system may have multiple devlink devices that usually need the same
  configuration. For a configuration such as eswitch mode switchdev, a
  user can specify either all devlink devices or an explicit list of
  devices to which that mode applies.

- Deployments can set the devlink eswitch mode before normal userspace
  orchestration runs, while still using devlink concepts and driver
  callbacks rather than adding driver-specific module parameters.

A default is scoped to either all devlink handles or to a
comma-separated list of devlink handles, for example:

devlink_eswitch_mode=[*]:switchdev
devlink_eswitch_mode=[pci/0000:08:00.0,pci/0000:09:00.1]:switchdev_inactive

The supported modes are legacy, switchdev and switchdev_inactive.

mlx5 wires this into device initialization after the devlink instance is
registered and after mlx5 devlink operations are available, so eswitch
mode defaults can be applied to matching PCI devlink devices.

Patch 1 clears the mlx5 FW reset-in-progress bit before reloading after
a firmware reset.

Patch 2 adds the devlink eswitch mode boot-default parser, storage,
devl_apply_default_esw_mode() API and documentation for the
devlink_eswitch_mode= syntax.

Patch 3 calls devl_apply_default_esw_mode() from mlx5 device
initialization.

Changelog:

Since RFC v2:

- Replaced the generic devlink=[...]:esw:mode:<mode> command line API
  with devlink_eswitch_mode=[...]:<mode>.

- Simplified the parser to handle one eswitch mode parameter instead of
  a generic command/attribute grammar.

- Renamed devl_apply_defaults() to devl_apply_default_esw_mode().

- Added the mlx5 firmware reset cleanup as the first patch after the
  cover letter.

[1] https://lore.kernel.org/all/20260502184153.4fd8d06f@kernel.org/

RFC V1:
https://lore.kernel.org/all/20260506123739.1959770-1-mbloch@nvidia.com/

RFC V2:
https://lore.kernel.org/all/20260510185424.2041415-1-mbloch@nvidia.com/

Mark Bloch (3):
  net/mlx5: Clear FW reset-in-progress bit before reload
  devlink: Add eswitch mode boot defaults
  net/mlx5: Apply devlink default eswitch mode during init

 .../admin-guide/kernel-parameters.txt         |  25 ++
 .../networking/devlink/devlink-defaults.rst   |  80 ++++++
 Documentation/networking/devlink/index.rst    |   1 +
 .../ethernet/mellanox/mlx5/core/fw_reset.c    |  28 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  17 ++
 include/net/devlink.h                         |   1 +
 net/devlink/core.c                            | 255 ++++++++++++++++++
 7 files changed, 396 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/networking/devlink/devlink-defaults.rst


base-commit: 9bf93cb2e180a58d5984ba13daee95903ff4fc14
-- 
2.44.0


