Return-Path: <linux-rdma+bounces-20069-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DgZM5I2+2n2XwMAu9opvQ
	(envelope-from <linux-rdma+bounces-20069-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 14:39:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B91D4DA537
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 14:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A78483017F82
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 12:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0AB44CAEA;
	Wed,  6 May 2026 12:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TlsboGQ4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BE542188E;
	Wed,  6 May 2026 12:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071117; cv=fail; b=o4sUXvC9qGG1y6l5ILayz1zUrrdNqg11KPV401jFyooLMKzqkXdwwps0ep17VWYwfPYM+usb6DKv+k3V7Hrbr5m7RbYf5gzlepb2sl/MpRnOfAI+LyPXrEMAIFPobyCzUiTfbQXAKGCSt2W3pKZddw2WPH8AHCJnNSKEcti41ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071117; c=relaxed/simple;
	bh=0PndnJKL62sdoY3Zj5OmkE6eI7pqD0OeEGjSEyjrD7A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HB8aE8DG0XO2OwlGfojaPcMRBv9kyayNNzkB7ARGhnAYHORShVeG2syFTE/tq4OVNi6d/rc0nUxZ1G1raI4km/gHEVaLFct/xcYeOFP9PqYHt8wbu/SxjV+SymjcpQoVq5eAfxQZbRPumGE/kPrZjlEleFM9yhbQy1F9cVfJHLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TlsboGQ4; arc=fail smtp.client-ip=40.93.195.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8WQwH51Kfc0LNTZX8zNpCMoT3R9zFWepLgQiF9zQRgtXH6Ak1GOABYtpdh5z4T6IXTnmylodn7R+dl8FI5RvjA9nZMaL4nRzrhz4KvqHUe7FVo0iP4ukZ/YK5Ihl9ORpoiyN7BuXkBCwd0I7uRwAHUOx+z8mbrZ4Luo2/Q2mG9aGsl0Yq8USKKFjmO+ctiZHH9mpYqDbFWoIBxRLi1IYbBiU2qWK0AGR4DFI88lBoDH/ISHDP2kBrL0zNqyN8eKRSNie0EFCGceMUgBjrK55wG3VOQnFOE1cFiDCD4EbBfW0pBwjIPzeU2zibqAr2rSNe4OXbOM5yULrmU1Acaubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5/XPFBoilXxXUItF51S0MTXsvTro8BRqOTHCc8eu08=;
 b=hpzGyy67TaTywZl4+/Bd/jKtH1A6EQRn5soboKm6HqOChiHoOjhHPzbpkzVNhNsM+ZWUgxVJQyXOJhiltRVhvyhE4S5zRCts5sYckjOqbjA61ZHLbxXUljK2N3kg/Bs916n7QN9qzPgknV7jrj/xPJK7PtS/vLp8LsLePnYF4WZg9fa20LQKCdESmwZKCkPzc5+zOBNsCvovapGf+g9rAOc7cV1rMiCq3EP8Tvidtvl7S2E5k5sboy3dhs2WKPM3oIRmBnlyBvkwfhoMeSbsUeD5dp11UB1JKgiwGV7jW3NQNBkZsesCWtXB+K6dfYlDoYq9BA8RZEaCSvCFRk54jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5/XPFBoilXxXUItF51S0MTXsvTro8BRqOTHCc8eu08=;
 b=TlsboGQ4ug1J8cr+i1hqk/RCaoR3gV2ji4AOnaLzmHLNEGiGA/nlTA+jImfWLAJl+LhsVA4gZUhsTIaH6NR4b5rFLRHLrcXzreQgn3QA7yv+ID6jp46VOure70phoBlW0dLtAaaxV/9ypDDKErpfUcGvwJVTsGU3/cXm46ReqXPrpkYbSpuHf0Av6LWqIjegf9KAi4eXQHq2zvwJACifyFE92dAmJU5aUlWOmJXJ0bUQfapp0NMGzVppNSsObV1PhI1VBCy8cwVIEdPekgFI0bm87aVgu11blDJr0AIHoYaQT87fAYL2VuAx4cEgF2QqjtOTQRu4kU8lzsux5dQNBg==
Received: from SJ0PR03CA0096.namprd03.prod.outlook.com (2603:10b6:a03:333::11)
 by BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 12:38:23 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::df) by SJ0PR03CA0096.outlook.office365.com
 (2603:10b6:a03:333::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Wed,
 6 May 2026 12:38:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 12:38:22 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 05:38:06 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 6 May 2026 05:38:06 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 6 May 2026 05:37:58 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew Morton
	<akpm@linux-foundation.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, "Randy
 Dunlap" <rdunlap@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>, Petr Mladek <pmladek@suse.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Thomas Gleixner
	<tglx@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>, Marco Elver
	<elver@google.com>, Eric Biggers <ebiggers@kernel.org>, Li RongQing
	<lirongqing@baidu.com>, "Paul E. McKenney" <paulmck@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: [RFC net-next 2/4] devlink: Add eswitch mode boot default
Date: Wed, 6 May 2026 15:37:37 +0300
Message-ID: <20260506123739.1959770-3-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506123739.1959770-1-mbloch@nvidia.com>
References: <20260506123739.1959770-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: a8b23a8e-a182-433f-c974-08deab6c5c87
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|7416014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uF4Ve2se+7MqESP672fndbJqco/yWbBnl6JjFIgKbXXRV06MrnP0gJV+gSOGQQiWibAJQ8FoOasw6PBejbwc5/waTd6SSDsZwm7uQU7+xHM4HzL1/LN3sFomGTx9uxo1OmQX6beTR1W7V3Ammj14/1shC+KMwIQrMI8YYqEHCXTEiX9kDkHNK9KLF4gO7NceTcaEqvZFpXDMXtVy4eibJ0EEs2tBl4g80LwdKMz+YUmksfzeoOYKKMCiqefjigK/8WwO7LXvavGynxprwYF3wmCbHixzDURf3vl71lIAZEplpL3lUWY+8e5ejZiXL1HSqLKz9v6tBEI7MlWcPuNrOa3tRvzZ785O+B4UY1/pP+4JCbPrEW9Ki7XHYKk+cdkEXELvUvLwoMaSRNkgxLWAnkI07/M69tV5084r0VXc0uKVbMjQB1C+lcqvrvvyAaWw2GYeY+6/cYrccB08C0nnuKyGRR3aRGFQGn0DP7l49VSu5atqTkqpD/mlm/BMKwv2Uj0zzY+2Gx7bLuqQbxEtmOx7SRSLtaCH1c/MWiIzOJyidkKyFedGOmAQEvwbmTvCezGFtTwL2b8JeGzPRf0AzB2xU0WzeOcl488N4+b1WTiL6n97IkxbbF8+EexHQfhSh2qDU4IknPhsbhK766090E/DQnYitKeDldHN46yAj1ym4QeyrWUL/bYBmfKxX0CMSIkkIEkmJJ/NUYS5hJLkm/PymFuzfWERM3kbXh3qZFU=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mH8zhyWqHGd6jPcpwlBYGeSpIQAvfe7xRaul08m0r0QmnHt945yrSVtGAgrOUJuOE5WvR9qsndctO37NMpkoC/i0vnim2Bcfp23f0pI39hbQ9j+HYYacadxFuIRU/VoSUg4DSelFtSrO5kPWt2ji1W+RuigpesMqlHz7R4NUm5lp8mdiYa/b6fscov+ian4UqN9S5sLvphoWRooJ/KnYCq1EegFcFVJwsAOswLZ+C9UebH+N+G1hWCIER3X0vYGaS7OsqxSt+blY1LRNfZsBax4oJb6+v+bsGaDP3qkGYpM4SSg0vP2Rg5AU82nQQL9nSo+aIFBrP+THgK1UoamfcQRQc7zGhtNq6wnKOET0QLyUeod7sJA3TV3ycmTW5aQw2yQ9KXr9kcnbfgkubREosKPASkncWimfoJPSS2hguAxEJn1CboQx+b+RoMPqV+qs
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 12:38:22.9928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b23a8e-a182-433f-c974-08deab6c5c87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644
X-Rspamd-Queue-Id: 4B91D4DA537
X-Rspamd-Action: no action
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
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20069-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

Add support for configuring the devlink eswitch mode from the
devlink= kernel command line parameter.

The supported syntax is:

  devlink=[<handle>]:esw:mode:<mode>

where <mode> is one of legacy, switchdev or switchdev_inactive. The
default is applied through the existing eswitch_mode_set() devlink
operation, matching the userspace devlink eswitch set command.

Document the devlink= syntax and the eswitch mode default.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../admin-guide/kernel-parameters.txt         |  24 ++++
 .../networking/devlink/devlink-defaults.rst   |  99 +++++++++++++++
 Documentation/networking/devlink/index.rst    |   1 +
 net/devlink/core.c                            | 114 ++++++++++++++++++
 4 files changed, 238 insertions(+)
 create mode 100644 Documentation/networking/devlink/devlink-defaults.rst

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7834ee927310..150202882870 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1278,6 +1278,30 @@ Kernel parameters
 	dell_smm_hwmon.fan_max=
 			[HW] Maximum configurable fan speed.
 
+	devlink=	[NET]
+			Format:
+			<entry>[,<entry>...]
+
+			<entry>:
+			[<handle>[,<handle>...]]:<cmd>:<cmd-options>
+
+			<handle>:
+			<bus-name>/<dev-name>
+
+			Configure default devlink settings for matching
+			devlink instances during device initialization.
+
+			Currently supported settings:
+			esw:mode:{ legacy | switchdev | switchdev_inactive }
+
+			Examples:
+			devlink=[pci/0000:08:00.0]:esw:mode:switchdev
+			devlink=[pci/0000:08:00.0,pci/0000:08:00.1]:esw:mode:legacy
+			devlink=[pci/0000:08:00.0]:esw:mode:switchdev,[pci/0000:08:00.1]:esw:mode:switchdev_inactive
+
+			See Documentation/networking/devlink/devlink-defaults.rst
+			for the full syntax and duplicate handling rules.
+
 	dfltcc=		[HW,S390]
 			Format: { on | off | def_only | inf_only | always }
 			on:       s390 zlib hardware support for compression on
diff --git a/Documentation/networking/devlink/devlink-defaults.rst b/Documentation/networking/devlink/devlink-defaults.rst
new file mode 100644
index 000000000000..7d6ccaddca86
--- /dev/null
+++ b/Documentation/networking/devlink/devlink-defaults.rst
@@ -0,0 +1,99 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+Devlink Defaults
+================
+
+Devlink defaults allow selected devlink settings to be provided on the
+kernel command line and applied to matching devlink instances during device
+initialization.
+
+The devlink device is selected by its devlink handle. For PCI devices this is
+the same handle shown by ``devlink dev show``, for example
+``pci/0000:08:00.0``.
+
+Kernel command line syntax
+==========================
+
+Defaults are specified with the ``devlink=`` kernel command line parameter.
+
+The general syntax is::
+
+  devlink=<default>[,<default>...]
+
+Each default has the following form::
+
+  [<handle-list>]:<cmd>:<cmd-options>
+
+``<handle-list>`` is one or more devlink handles::
+
+  <bus-name>/<dev-name>[,<bus-name>/<dev-name>...]
+
+All handles in the same ``[]`` list receive the same command setting.
+
+Multiple defaults may be specified by separating complete defaults with a
+comma after the value::
+
+  devlink=[pci/0000:08:00.0]:esw:mode:switchdev,[pci/0000:08:00.1]:esw:mode:legacy
+
+Syntax rules
+------------
+
+The following syntax rules apply:
+
+* Specify all defaults in one ``devlink=`` parameter. Repeated ``devlink=``
+  parameters are not accumulated.
+* The ``devlink=`` value is limited by the kernel command line size.
+* Whitespace is not allowed within the parameter value.
+* ``<bus-name>`` and ``<dev-name>`` must not be empty.
+* ``<bus-name>`` must not contain ``:``.
+* ``<dev-name>`` may contain ``:``. This allows PCI names such as
+  ``0000:08:00.0``.
+* Handles must not contain whitespace, ``[``, ``]`` or more than one ``/``.
+* A comma inside ``[]`` separates handles.
+* A comma after the ``<value>`` separates defaults.
+* Defaults for the same handle are applied in command-line order.
+* The same ``esw`` attribute may be specified only once for a given devlink
+  handle.
+* Duplicate entries for the same handle are rejected and all devlink defaults
+  are ignored.
+
+Supported defaults
+==================
+
+The supported command is ``esw``:
+
+.. list-table::
+   :widths: 10 25 35
+   :header-rows: 1
+
+   * - Command
+     - Options
+     - Values
+   * - ``esw``
+     - ``mode:<mode>``
+     - ``legacy``, ``switchdev``, ``switchdev_inactive``
+
+The ``esw:mode`` default corresponds to the userspace command::
+
+  devlink dev eswitch set <handle> mode <value>
+
+
+Examples
+========
+
+Set one PCI devlink instance to switchdev mode::
+
+  devlink=[pci/0000:08:00.0]:esw:mode:switchdev
+
+Set two PCI devlink instances to legacy mode::
+
+  devlink=[pci/0000:08:00.0,pci/0000:08:00.1]:esw:mode:legacy
+
+Set different modes for different PCI devlink instances::
+
+  devlink=[pci/0000:08:00.0]:esw:mode:switchdev,[pci/0000:08:00.1]:esw:mode:switchdev_inactive
+
+The following is invalid because the same handle receives ``esw:mode`` twice::
+
+  devlink=[pci/0000:08:00.0]:esw:mode:legacy,[pci/0000:08:00.0]:esw:mode:switchdev
diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index f7ba7dcf477d..0d27a7008b14 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -56,6 +56,7 @@ general.
    :maxdepth: 1
 
    devlink-dpipe
+   devlink-defaults
    devlink-eswitch-attr
    devlink-flash
    devlink-health
diff --git a/net/devlink/core.c b/net/devlink/core.c
index 2421a1f8dbb7..4b404135181c 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -73,9 +73,123 @@ devlink_default_attr_free(struct devlink_default_attr_item *attr)
 	kfree(attr->value.param.value);
 }
 
+struct devlink_default_attr_spec {
+	const char *name;
+	enum devlink_attr attr;
+	int (*value_parse)(const char *value,
+			   struct devlink_default_attr_item *attr_item);
+};
+
+static int __init
+devlink_default_attr_parse(char *str,
+			   const struct devlink_default_attr_spec *attrs,
+			   size_t attrs_count,
+			   struct devlink_default_attr_item *attr_item)
+{
+	char *attr_name;
+	char *value;
+	size_t i;
+
+	attr_name = strsep(&str, ":");
+	if (!attr_name || !*attr_name || !str || !*str)
+		return -EINVAL;
+
+	value = str;
+	for (i = 0; i < attrs_count; i++) {
+		if (!strcmp(attr_name, attrs[i].name)) {
+			attr_item->attr = attrs[i].attr;
+			return attrs[i].value_parse(value, attr_item);
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int __init
+devlink_default_esw_mode_to_value(const char *str,
+				  enum devlink_eswitch_mode *mode)
+{
+	if (!strcmp(str, "legacy")) {
+		*mode = DEVLINK_ESWITCH_MODE_LEGACY;
+		return 0;
+	}
+	if (!strcmp(str, "switchdev")) {
+		*mode = DEVLINK_ESWITCH_MODE_SWITCHDEV;
+		return 0;
+	}
+	if (!strcmp(str, "switchdev_inactive")) {
+		*mode = DEVLINK_ESWITCH_MODE_SWITCHDEV_INACTIVE;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int __init
+devlink_default_esw_mode_parse(const char *str,
+			       struct devlink_default_attr_item *attr_item)
+{
+	enum devlink_eswitch_mode mode;
+	int err;
+
+	err = devlink_default_esw_mode_to_value(str, &mode);
+	if (err)
+		return err;
+
+	attr_item->value.eswitch_mode = mode;
+	return 0;
+}
+
+static const struct devlink_default_attr_spec devlink_default_esw_attrs[] __initconst = {
+	{ "mode", DEVLINK_ATTR_ESWITCH_MODE, devlink_default_esw_mode_parse },
+};
+
+static int __init
+devlink_default_esw_attr_parse(char *str,
+			       struct devlink_default_attr_item *attr_item)
+{
+	return devlink_default_attr_parse(str, devlink_default_esw_attrs,
+					  ARRAY_SIZE(devlink_default_esw_attrs),
+					  attr_item);
+}
+
+static int
+devlink_default_eswitch_apply(struct devlink *devlink,
+			      const struct devlink_default_attr_item *attr)
+{
+	const struct devlink_ops *ops = devlink->ops;
+
+	switch (attr->attr) {
+	case DEVLINK_ATTR_ESWITCH_MODE:
+		if (!ops->eswitch_mode_set)
+			return -EOPNOTSUPP;
+
+		return ops->eswitch_mode_set(devlink, attr->value.eswitch_mode,
+					     NULL);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static const struct devlink_default_cmd_spec devlink_default_cmds[] __initconst = {
+	{
+		.name = "esw",
+		.cmd = DEVLINK_CMD_ESWITCH_SET,
+		.run = devlink_default_eswitch_apply,
+		.attr_parse = devlink_default_esw_attr_parse,
+	},
+};
+
 static const struct devlink_default_cmd_spec *__init
 devlink_default_cmd_spec_find(const char *name)
 {
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(devlink_default_cmds); i++) {
+		if (!strcmp(name, devlink_default_cmds[i].name))
+			return &devlink_default_cmds[i];
+	}
+
 	return NULL;
 }
 
-- 
2.34.1


