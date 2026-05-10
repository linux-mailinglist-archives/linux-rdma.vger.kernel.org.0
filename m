Return-Path: <linux-rdma+bounces-20314-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCkTNIXUAGp8NAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20314-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 20:55:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB63505CEB
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 20:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD883300CCB0
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 18:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD5131E842;
	Sun, 10 May 2026 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZQUnDwel"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010020.outbound.protection.outlook.com [52.101.85.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217BD318ED6;
	Sun, 10 May 2026 18:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778439291; cv=fail; b=SpX3IpEIveTKtODheZKhx72u+NDnAtrE+NCKtwfdddtpQUyhKWZp12UcZVAh2G3U383EGiFWmkAyjzOiM6PvOm2EM6grwFHMSSY44LwmqR1bA972ggt0vDFw16DTFCDAthv4j0lJBv9v8V7P5CNYDcPGND7/sW5iEnCiREWVLzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778439291; c=relaxed/simple;
	bh=h5BuznI1TGuQ0wmr6Bynz0+gIKut36M/TXEnZaHMg9w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L2HlLDkB0diNgUk14brHlc+2ii89eOyQC+ZcsIRzou+A6GiTEKJY3fT1k7hO2udZJFE68M/ouZbbXekKJQT9enuSoVAxtE4v0DWl1xfEjU9j6TnMxraWPwRfDLsALfkEF1B6akwEQVcxXk1ds2la6f4lsY7FLcToRRlv9O7Rd9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZQUnDwel; arc=fail smtp.client-ip=52.101.85.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0oPVoCUHB9oP88+hfsc9uCHlds0vzJpG8s1frCyHMBwpLt37vdO+Q6qmTbTKv8nB1MdOtyStMZNhnNuOspSj454efRBF39ubQgTeJbTh4ucw78UXuoWvymIsmvKAVX7nwu+UxbRXyKDb/w+LpTlYE5l5CEUpuZCtlHmS66nIi/kGHSP6x7ZTmaP3fCT5Z/UjBBpDPOi2Qs7TujYfNlOVIpo/rf0w/knI1HqAgNx1MrpMW7czGJW3p3jbSzu+yVdTHiwWy0MvCUDb6kG6ZAqVTcrGJUr/MFHhiyY6tUtDnc1BFwb6rztx8dhHIEOdVPbmxjhRqeJOZu0PaegBJqWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpSkAlDnDbNRxCUXd6vFh3fq2MrsWd4HZxUvUxvcwCE=;
 b=gTzdjsc6O410bJgHF4pwkN7zrGb8bxj5HUeaOnySTc8paG/J4eNjqzDcU5f4HkQ7vC5yPr0qytxNFmWpWL4lNBspTAcEPtDJMJq5KaW31gInG8NYISFh6aQlH77kUMte8QpOTxGub5PswT5s8vbdLezqAbsfe8Umjz4/abtcuxX4E06Nn0ml6fdRnGNrvMvLBkYSSQqDF1VKxTkZYuldEKzZoDgOUuyt5lqkkYpkOVh8hkxjKLl+mRNCoqG0VGHN+X6fTug99Hj9ZzaRZIpxlfuQev6e2/N0txmwbAKFi6m0uuz64nM/7A20JbF/SUJQoUWhL5txX0/dm1gHEQ1N5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpSkAlDnDbNRxCUXd6vFh3fq2MrsWd4HZxUvUxvcwCE=;
 b=ZQUnDwel/3qncRoBSlm03AVloTY4a6B1kDC1oPDHepxNgAOgtujuTdw/45gZfykvbZB8cFkAXIhuzkjEVTMXBoUjb8ZWKMx71SdFl40TLfVe1pzkOSxQAqbVrlAyS82O2HRitgJ5oXMpY0xgye8do8WuTWUfek7MHAEef4BfzjYhR5hLlrD/sf15QEdyLhIkXASkO9ZV077RGWaGG3PaYXy3dG7I57SUwFT/dzrh+1KkmA+QpQw0xfhkVac0N5C/E/sVvK70vL08G8kSysp6L6mQsKG1t0HuQB7J2k4zT1F6H+XAMeE6oEj4qMnsJ0F5ZBFbOrLsknXUKSXxRRzKHQ==
Received: from BN0PR10CA0021.namprd10.prod.outlook.com (2603:10b6:408:143::24)
 by IA0PR12MB8226.namprd12.prod.outlook.com (2603:10b6:208:403::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Sun, 10 May
 2026 18:54:43 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::e3) by BN0PR10CA0021.outlook.office365.com
 (2603:10b6:408:143::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.22 via Frontend Transport; Sun,
 10 May 2026 18:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sun, 10 May 2026 18:54:43 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 10 May
 2026 11:54:35 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 10 May
 2026 11:54:34 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 10
 May 2026 11:54:27 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>
CC: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, "Borislav
 Petkov (AMD)" <bp@alien8.de>, Randy Dunlap <rdunlap@infradead.org>, "Petr
 Mladek" <pmladek@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Christian Brauner <brauner@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>, "Marco
 Elver" <elver@google.com>, Li RongQing <lirongqing@baidu.com>, Eric Biggers
	<ebiggers@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: [RFC V2 net-next 0/2] devlink: Add boot-time defaults
Date: Sun, 10 May 2026 21:54:22 +0300
Message-ID: <20260510185424.2041415-1-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|IA0PR12MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 7178ae40-8aff-4fdc-14cd-08deaec59923
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|18002099003|56012099003|13003099007|3023799003;
X-Microsoft-Antispam-Message-Info:
	BgNaYCR+yriBHY9XcI51vIEiaUnBGeTBhM/5EQ5G3X0ySKRObZDgCS+tCRTy3rOHYiOyGQTCQXbisX94LvL/o3BGcTa5vTNI2s50gHEVDXvm0EXbYnNl4xJ8QCPnpbLlaa0YGfmEZ/YhihovI9arvOGtKt/1iYkxpMIce4Ptd9k38smFVLzcmpTfLUjB7ob7e6v4D3Qe/a6ecrb2/pUHcE4lPmUq52rbKJzriBlPtpPf1lp5LOcSnYqF7zyw457pW4dr+MGht/x+nv9c8raoBD3cHU3QfMoMG1OS5ndq2FFEs4mvAnC1d7kdCZ2TyWEbjVMWOOKEjkq2pLmJUXL2wEk1HlwOxp6JzqtBlYn5nuAELx8HSurdOlCM20EMHfV15gUktUrdSEjwf4NBcOQni6o/1VDLnth8dlSt5KhOP1IaLqq+ZunRDr3VoMW6NqMAlwQffRqhwXp28qrtjNmPi6kVNsRBubtpmKe3GZchYrczVRGZVnSMGWXNHY3lLDwI7118uY0EYpW6FMrnZ3CTz46MsVNgbOIGUos5alyxZol8bC1wZ7ebftywyYDaz1NzU01J1JdnGoQRW1X5uZl6GB0ugMoSN4+vLx7ExdLf3eJgyLT4s6I7linqn/6H5QnRPhsFJ3s82twimKeGLqoLWWeajZqgJEqrpZR9NXZ74R4siqsthR0NPm+1skWind1yNQr0pmqvxa14reFWfJZbXGY2tb4JqA4MWtOr+OJEn2LhOrd0yFJL3JPFV+Y55U1G
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003)(13003099007)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iTboHuDGQJXsY8vZL+kscEp/m+JIuw8PM1LPh5qW8HtQaEvbso4qNZSwFD+JBxrTdvqdqu2qmkYHL6cwcaWDRHv7LwaWqf3RbN+sM9Q2KjHd6P6wNeuEN04jlwu7IfUmQTeDgsYuRkfMXWwm/avl3TOpJqbiWQGZP0GIIwyoX/NSPcpKTYpV0UINcXJSMkheW2J9OMLjBFDnaBnT6s/qJ/2x2R7t1ejGlQEpDT+05dKT14O08f/3/ZeacrspckjAyL9PLI+rStfCs537SH/d2jtZ3aI34hvF/p6RUrI0hOr2nOGYahTqy/cM9S723bSzMokESS1quNWB7KzvkrHVP+BplciztmBzxoObW0DYQOTt29nENd1MlaTDDxp+Sz1D1BS0dLyhG7ibbTf5bO0SObM1VFPrNQWdk2rAO43adB83ZsBgTBsNl1YeoCq4SjRb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 18:54:43.3403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7178ae40-8aff-4fdc-14cd-08deaec59923
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8226
X-Rspamd-Queue-Id: 5DB63505CEB
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20314-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

This series adds a devlink= kernel command line parameter for applying
selected devlink settings during device initialization.

Following a discussion with Jakub[1], I am sending this RFC to get the
conversation moving. I started from Jakub's example/request and extended
it to cover requirements from production systems and configurations that
customers use. The implementation is intended to support the following
properties:

- A system may have multiple devlink devices that usually need the same
configuration. For a configuration such as eswitch mode switchdev, a user
can specify either all devlink devices or an explicit list of devices to
which that configuration applies.

- Deployments can set devlink defaults before normal userspace
orchestration runs, while still using devlink concepts and driver callbacks
rather than adding driver-specific module parameters.

A default is scoped to either all devlink handles or to a comma-separated
list of devlink handles, for example:

devlink=[*]:esw:mode:switchdev
devlink=[pci/0000:08:00.0,pci/0000:09:00.1]:esw:mode:switchdev_inactive

The first supported command is eswitch mode configuration.

mlx5 wires this into device initialization after the devlink instance is
registered and after mlx5 devlink operations are available, so eswitch mode
defaults can be applied to matching PCI devlink devices.

Patch 1 adds the devlink boot-default parser, storage,
devl_apply_defaults() API, eswitch mode default support and documentation
for the devlink= syntax.

Patch 2 calls devl_apply_defaults() from mlx5 device initialization.

Changelog:

V1 -> V2

- Reduced the series from 4 patches to 2 patches by folding the generic
boot default infrastructure and eswitch mode support into one devlink
patch.

- Narrowed the scope to eswitch mode defaults only. Dropped runtime
devlink parameter boot defaults and simplified parser.

- Added [*] selector support to apply the same eswitch mode default to all
devlink instances.

- Removed support for multiple comma-separated default groups and for
assigning different defaults to different handles in the same devlink=
parameter.

[1] https://lore.kernel.org/all/20260502184153.4fd8d06f@kernel.org/
V1 : https://lore.kernel.org/all/20260506123739.1959770-1-mbloch@nvidia.com/

Mark Bloch (2):
  devlink: Add eswitch mode boot defaults
  net/mlx5: Apply devlink boot defaults during init

 .../admin-guide/kernel-parameters.txt         |  24 ++
 .../networking/devlink/devlink-defaults.rst   |  93 ++++++
 Documentation/networking/devlink/index.rst    |   1 +
 .../net/ethernet/mellanox/mlx5/core/main.c    |   2 +
 include/net/devlink.h                         |   1 +
 net/devlink/core.c                            | 269 ++++++++++++++++++
 6 files changed, 390 insertions(+)
 create mode 100644 Documentation/networking/devlink/devlink-defaults.rst


base-commit: a93245816556ba03549bb626de48ea2b11c7f9d2
-- 
2.34.1


