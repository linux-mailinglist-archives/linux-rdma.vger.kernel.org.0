Return-Path: <linux-rdma+bounces-22563-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /dYbCvm3QmqEAAoAu9opvQ
	(envelope-from <linux-rdma+bounces-22563-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 20:22:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E916DDFCD
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 20:22:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=oBmaLTBr;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22563-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22563-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED5483010646
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 18:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B111387371;
	Mon, 29 Jun 2026 18:22:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC30383C6B;
	Mon, 29 Jun 2026 18:22:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757327; cv=fail; b=plflzYerCCcz2R5YgnaVRe1W3YWjWmqKgm1ELxYeD6+iP5CTYSB15/01iHCGhrvcY/jU6ktn5opOqSqvAPRkqTULWbo/co/GfNIn06iNd9Rd0uIXMcBgvA//jWDFs5xjPnNVJvg05iYAnXbPvzOQf1a7BXkD9FdS+ux0ewl6HsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757327; c=relaxed/simple;
	bh=JUtAOnR9VfJV9jLBRcasTVngrt061ltE8KhyPPeJPp0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQ+PD9ugxwfyu133sjKntS12M+WbCOKKom7GVooNFKWixgP0joQ6VsZ/HlFYr2yvz9mzPvoAp0QneJW3nzl9u0O8sijfWE3ML0jEs4tlBk04S2UxY6SQ+cy55ibjI3CL68D5lTsUG33Cb6Z5JrJk9X7FOkZhpzxft8PXfIVJI60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oBmaLTBr; arc=fail smtp.client-ip=52.101.62.46
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wI54icUvxlh2JXtzGYP4kAHbpDflihgAwNBhe92EoIdVwCIOrw2SkEHcLqYFVJWj2xcVfbCqfT4iSkpQeSNmdObjIjJy/6zBa1agW6eC8o7I1YZhNub3imA63l0boa8W3fc84ZcC2+8W5FhlM+0xpDc6GffcpRHVJP/k3kGLwaot52qgsVsBzCD/CjtCVvHSXRU/a2ZLijocbaZRIqQ3f9lZSc8ahOXN4n5eionwmAM+hgCXqDh3xJMh92l2pTl8SHFm5dtKkQgaV4EDrZGorLCIlZVE8hJ2eJdpEZB+fIEAWmN+wAdln4pQQ0pLyUgmh7d6V39ec2Btq6bvCZCWng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfIsXLBuLCj6nV63Cdh0fszNwhzyH885/WY7zWKpIlM=;
 b=BCLs/6f9M++VnBr00cAsrD3iBLA4KqtDtuzgUp/10UuWh4DkQ0KbaQK1e+PEczVCTkF4rG0x0DdY9j92e/Nm28MmF+ZsoMLtRUm0HLuY20J0XqeRDAM+tutPjqPEa08axtnYzTn86I4C1k+W1hSI/f9CxHNWq83YYYuJcB9jXFRlfcxYSFh8Ev6glrrX2EqY6dNrcJOMWBEzDLKzS1AtVVNQ/VUB5oiBNtDS685/L/ulKWwkq+XTd2xw/G/899WF0sqXrxKZj3KoN1aCIS9BzkIQ7hKNngV6hjk4AFQFDZ8gO9gqnhuQbTXRit8cd3tDReGYiQxenYd5Q2S+LwY7/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=resnulli.us smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfIsXLBuLCj6nV63Cdh0fszNwhzyH885/WY7zWKpIlM=;
 b=oBmaLTBrwX80/RnWPMRJ6JtD4hun/XLfEWoNEYCptIN6N5rhuyrZXo3Zwd0iWeYT49znvTSxP/EuWYLNh1KbSGOC6NPQaZWaU6ahsECSn1QlcW4j9ZY880sZJ79KihEg7dGegEFRasmAC3hpRDEWNeK97iCamB21YgNMX0l7kSbzFl2JcKoaf0+tzfdKFIzFXmfQxabm6VSHsXcRjxau6MfagUIFhrjC3J7q/39bYGFaq1QGJGFrlkWLfbpvF/MNcsqeTLpCSbBI3Y7C4RWqgtA7sY/3+qIbKhMi3BOhBHgsz1vJ1Mdlxj1XLLMSjBp7MuIdU5WtNS3UIwInF4FCgA==
Received: from CH0P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::26)
 by DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 18:21:53 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::ad) by CH0P220CA0019.outlook.office365.com
 (2603:10b6:610:ef::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 18:21:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 18:21:53 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 11:21:21 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 11:21:20 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 29
 Jun 2026 11:21:16 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next V4 3/6] devlink: Parse eswitch mode boot defaults
Date: Mon, 29 Jun 2026 21:20:58 +0300
Message-ID: <20260629182102.245150-4-mbloch@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629182102.245150-1-mbloch@nvidia.com>
References: <20260629182102.245150-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|DM4PR12MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 71213e5f-102c-46d3-c900-08ded60b4b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|23010399003|3023799007|6133799003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	KcboJjhu6nGHcfnlDXhCooyxpVOq1X5dJ7ZdyOXBEnp89k6wd8KYvssWkM1O0S8AMAYX2eYmJ07yaqURevdxL4+U9k+eeaf8IhdYxbnWQypmoQpIEoxC5j4j+CT5axYpdt1+enUYetO5u5Rzrj2TwvuCV+DYEnvyjdetcx1wsChY8G2qL5h1TuHULM9Jd3g8Br/Wg5ueLtDvmF99p3zSQW6Q0q4iPgWIqUihYSCHTYaCJUdo+LJxha7lfQ2mZ7U+TRgKNIvF3e7cyxxB5255yPiOXa5erd8H9dghLk+259jOmQ7XzV1vN4SPkoHetkVODyUKVurVs7YpOJtqTWeHmekDWkMgSyi1OOEJbtEQT7QPIdnQnkS0IcJv7al6LOhu+xITji4c2mjRLVhsVC2ZKPyDojhRfLfJVy+iHTB5af55TuZam5wUwja42WO606/fqFNimGabHon3+K1GYqkniMphIh9j8LbqNwC3KdApxaLLtte10vuI1zsPRpu1RF3muGWmo7xCyMHtnV3lDqM0oN8jERqMaxxqoqqZjdF4ag78VRkNn2DWO3C7iC75/yh7DMpozY9EWtUf6L0kC9nmvptduWVDtHYj/XjzcFY9OUm5E4V8lbYNNS3FsM6M75zWNWiaFQfNRlbEX3lraERTXe9PiMc0aXwn9tV8YUB3pxaswaX9XqbcrnRC8/mRO9RfKppWRZa2u2/Bqpgff3hYPQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(23010399003)(3023799007)(6133799003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kg0g90eBiz7ibbrsPDDoFUuJ1raijJAqH/r8kcVuKQQuoZeHj5xpcuqinKJW6/VliQ4DHfm2jKSwWA4h+CxtwefU85MnXrp8uj3Htr5/yrMCnjUzWaKepI/E++FDayMgBZCf3XClrKYdSmz9dXH21afmcpqm8VK6tLyCYhL1hDvPEH4quV+mX95JwoIQyEM7MuDwU994zogrLxlwBgOWLnbU8cIduVE3nka6ND8BVrW/u1axiTIfGg2GBfn8bdcoHzUYbAQheJxlEyg9GvWy0qtbitpqSfdn2Lg7sKQsvmQN9TpAuz4SpUnozXwkGhPy0bdUqBdYmnRdkIALAgdvwuEeQWqFrN8lvedJ2KrhZqjQysxwyBqlNroAi8/fo4b15fNt11Wzg1ndBB7pHE+TnZ25jO3M0/h3uuT0r4o/MZ1sz8WM0q+a7wIISF+BYizm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 18:21:53.3305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71213e5f-102c-46d3-c900-08ded60b4b9e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6424
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22563-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-doc@vger.kernel.org,m:mbloch@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4E916DDFCD

Add devlink_eswitch_mode= kernel command line parsing for a default
eswitch mode.

The supported syntax selects either all devlink handles or one explicit
comma-separated handle list:

  devlink_eswitch_mode=*=<mode>

  devlink_eswitch_mode=<handle>[,<handle>...]=<mode>

where <mode> is one of legacy, switchdev or switchdev_inactive. All
selected handles receive the same mode. Assigning different modes to
different handle lists in the same parameter value is not supported.

Store the parsed selector and mode in devlink core so the default can be
applied by a downstream patch.

Document the devlink_eswitch_mode= syntax and duplicate handle handling.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../admin-guide/kernel-parameters.txt         |  25 ++
 .../networking/devlink/devlink-defaults.rst   |  78 ++++++
 Documentation/networking/devlink/index.rst    |   1 +
 net/devlink/core.c                            | 227 ++++++++++++++++++
 4 files changed, 331 insertions(+)
 create mode 100644 Documentation/networking/devlink/devlink-defaults.rst

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f22..117300dd589c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1249,6 +1249,31 @@ Kernel parameters
 	dell_smm_hwmon.fan_max=
 			[HW] Maximum configurable fan speed.
 
+	devlink_eswitch_mode=
+			[NET]
+			Format:
+			<selector>=<mode>
+
+			<selector>:
+			* | <handle>[,<handle>...]
+
+			<handle>:
+			<bus-name>/<dev-name>
+
+			Configure default devlink eswitch mode for matching
+			devlink instances during device initialization.
+
+			<mode>:
+			legacy | switchdev | switchdev_inactive
+
+			Examples:
+			devlink_eswitch_mode=*=switchdev
+			devlink_eswitch_mode=pci/0000:08:00.0=switchdev
+			devlink_eswitch_mode=pci/0000:08:00.0,pci/0000:09:00.1=switchdev_inactive
+
+			See Documentation/networking/devlink/devlink-defaults.rst
+			for the full syntax.
+
 	dfltcc=		[HW,S390]
 			Format: { on | off | def_only | inf_only | always }
 			on:       s390 zlib hardware support for compression on
diff --git a/Documentation/networking/devlink/devlink-defaults.rst b/Documentation/networking/devlink/devlink-defaults.rst
new file mode 100644
index 000000000000..380c9e99210e
--- /dev/null
+++ b/Documentation/networking/devlink/devlink-defaults.rst
@@ -0,0 +1,78 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================
+Devlink Eswitch Mode Defaults
+==============================
+
+Devlink eswitch mode defaults allow the eswitch mode to be provided on the
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
+Defaults are specified with the ``devlink_eswitch_mode=`` kernel command line
+parameter.
+
+The general syntax is::
+
+  devlink_eswitch_mode=<selector>=<mode>
+
+``<selector>`` is either ``*`` or one or more devlink handles::
+
+  * | <bus-name>/<dev-name>[,<bus-name>/<dev-name>...]
+
+``*`` applies the mode to every devlink instance. All handles in the same
+selector receive the same eswitch mode.
+
+``<mode>`` is one of ``legacy``, ``switchdev`` or ``switchdev_inactive``.
+
+Syntax rules
+------------
+
+The following syntax rules apply:
+
+* Specify the default in one ``devlink_eswitch_mode=`` parameter. Repeated
+  ``devlink_eswitch_mode=`` parameters are not accumulated.
+* The ``devlink_eswitch_mode=`` value is limited by the kernel command line
+  size.
+* Whitespace is not allowed within the parameter value.
+* ``<selector>`` must be either ``*`` or a handle list. ``*`` cannot be
+  combined with explicit handles.
+* ``<bus-name>`` and ``<dev-name>`` must not be empty.
+* ``<dev-name>`` may contain ``:``. This allows PCI names such as
+  ``0000:08:00.0``.
+* Handles must not contain whitespace, ``*``, ``=`` or more than one ``/``.
+* A comma separates handles.
+* Comma-separated default assignments are not supported.
+* Duplicate handles are rejected and the devlink eswitch mode default is
+  ignored.
+
+The eswitch mode default corresponds to the userspace command::
+
+  devlink dev eswitch set <handle> mode <value>
+
+
+Examples
+========
+
+Set all devlink instances to switchdev mode::
+
+  devlink_eswitch_mode=*=switchdev
+
+Set one PCI devlink instance to switchdev mode::
+
+  devlink_eswitch_mode=pci/0000:08:00.0=switchdev
+
+Set two PCI devlink instances to switchdev inactive mode::
+
+  devlink_eswitch_mode=pci/0000:08:00.0,pci/0000:09:00.1=switchdev_inactive
+
+The following is invalid because comma-separated default assignments are not
+supported::
+
+  devlink_eswitch_mode=pci/0000:08:00.0=switchdev,pci/0000:09:00.0=switchdev_inactive
diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 32f70879ddd0..93f09cb18c44 100644
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
index fe9f6a0a67d5..5126509a9c4e 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -4,6 +4,10 @@
  * Copyright (c) 2016 Jiri Pirko <jiri@mellanox.com>
  */
 
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 #include <net/genetlink.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/devlink.h>
@@ -16,6 +20,193 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_trap_report);
 
 DEFINE_XARRAY_FLAGS(devlinks, XA_FLAGS_ALLOC);
 
+static char *devlink_default_esw_mode_param;
+static bool devlink_default_esw_mode_match_all;
+static enum devlink_eswitch_mode devlink_default_esw_mode;
+static LIST_HEAD(devlink_default_esw_mode_nodes);
+
+struct devlink_default_esw_mode_node {
+	struct list_head list;
+	char *bus_name;
+	char *dev_name;
+};
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
+devlink_default_esw_mode_handle_parse(char *handle, char **bus_name,
+				      char **dev_name)
+{
+	char *slash;
+	char *p;
+
+	if (!*handle)
+		return -EINVAL;
+
+	for (p = handle; *p; p++) {
+		if (*p == '*' || *p == '=')
+			return -EINVAL;
+	}
+
+	slash = strchr(handle, '/');
+	if (!slash || slash == handle || !slash[1])
+		return -EINVAL;
+	if (strchr(slash + 1, '/'))
+		return -EINVAL;
+
+	*slash = '\0';
+
+	*bus_name = handle;
+	*dev_name = slash + 1;
+	return 0;
+}
+
+static struct devlink_default_esw_mode_node *
+devlink_default_esw_mode_node_find(const char *bus_name, const char *dev_name)
+{
+	struct devlink_default_esw_mode_node *node;
+
+	list_for_each_entry(node, &devlink_default_esw_mode_nodes, list) {
+		if (!strcmp(node->bus_name, bus_name) &&
+		    !strcmp(node->dev_name, dev_name))
+			return node;
+	}
+
+	return NULL;
+}
+
+static int __init
+devlink_default_esw_mode_node_add(const char *bus_name, const char *dev_name)
+{
+	struct devlink_default_esw_mode_node *node;
+
+	if (devlink_default_esw_mode_node_find(bus_name, dev_name))
+		return -EEXIST;
+
+	node = kzalloc_obj(*node);
+	if (!node)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&node->list);
+	node->bus_name = kstrdup(bus_name, GFP_KERNEL);
+	node->dev_name = kstrdup(dev_name, GFP_KERNEL);
+	if (!node->bus_name || !node->dev_name) {
+		kfree(node->bus_name);
+		kfree(node->dev_name);
+		kfree(node);
+		return -ENOMEM;
+	}
+
+	list_add_tail(&node->list, &devlink_default_esw_mode_nodes);
+	return 0;
+}
+
+static int __init devlink_default_esw_mode_handles_parse(char *handles)
+{
+	char *handle;
+	int err;
+
+	if (!strcmp(handles, "*")) {
+		devlink_default_esw_mode_match_all = true;
+		return 0;
+	}
+
+	while ((handle = strsep(&handles, ",")) != NULL) {
+		char *bus_name;
+		char *dev_name;
+
+		err = devlink_default_esw_mode_handle_parse(handle, &bus_name,
+							    &dev_name);
+		if (err)
+			return err;
+
+		err = devlink_default_esw_mode_node_add(bus_name, dev_name);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static void __init
+devlink_default_esw_mode_node_free(struct devlink_default_esw_mode_node *node)
+{
+	kfree(node->bus_name);
+	kfree(node->dev_name);
+	kfree(node);
+}
+
+static void __init devlink_default_esw_mode_nodes_clear(void)
+{
+	struct devlink_default_esw_mode_node *node;
+	struct devlink_default_esw_mode_node *node_tmp;
+
+	list_for_each_entry_safe(node, node_tmp,
+				 &devlink_default_esw_mode_nodes, list) {
+		list_del(&node->list);
+		devlink_default_esw_mode_node_free(node);
+	}
+
+	devlink_default_esw_mode_match_all = false;
+}
+
+static int __init devlink_default_esw_mode_parse(char *str)
+{
+	char *handles;
+	char *separator;
+	char *mode;
+	enum devlink_eswitch_mode esw_mode;
+	int err;
+
+	if (!*str)
+		return -EINVAL;
+
+	separator = strrchr(str, '=');
+	if (!separator || separator == str || !separator[1])
+		return -EINVAL;
+
+	*separator = '\0';
+	handles = str;
+	mode = separator + 1;
+
+	err = devlink_default_esw_mode_to_value(mode, &esw_mode);
+	if (err)
+		return err;
+
+	err = devlink_default_esw_mode_handles_parse(handles);
+	if (err)
+		devlink_default_esw_mode_nodes_clear();
+	else
+		devlink_default_esw_mode = esw_mode;
+
+	return err;
+}
+
+static int __init devlink_default_esw_mode_setup(char *str)
+{
+	devlink_default_esw_mode_param = str;
+	return 1;
+}
+__setup("devlink_eswitch_mode=", devlink_default_esw_mode_setup);
+
 static struct devlink *devlinks_xa_get(unsigned long index)
 {
 	struct devlink *devlink;
@@ -382,6 +573,14 @@ struct devlink *devlinks_xa_lookup_get(struct net *net, unsigned long index)
 /**
  * devl_register - Register devlink instance
  * @devlink: devlink
+ *
+ * Make @devlink visible to userspace. Drivers must call this only after the
+ * instance is fully initialized and its devlink operations can be called.
+ *
+ * Context: Caller must hold the devlink instance lock. Use devlink_register()
+ * when the lock is not already held.
+ *
+ * Return: 0 on success.
  */
 int devl_register(struct devlink *devlink)
 {
@@ -580,6 +779,31 @@ static int __init devlink_init(void)
 {
 	int err;
 
+	if (devlink_default_esw_mode_param) {
+		char *def;
+
+		def = kstrdup(devlink_default_esw_mode_param, GFP_KERNEL);
+		if (!def) {
+			devlink_default_esw_mode_param = NULL;
+			pr_warn("devlink: devlink_eswitch_mode parameter ignored, failed to allocate memory\n");
+		} else {
+			err = devlink_default_esw_mode_parse(def);
+			kfree(def);
+			if (err == -EEXIST) {
+				devlink_default_esw_mode_param = NULL;
+				pr_warn("devlink: duplicate eswitch mode handles ignored\n");
+			} else if (err == -EINVAL) {
+				devlink_default_esw_mode_param = NULL;
+				pr_warn("devlink: invalid devlink_eswitch_mode parameter ignored\n");
+			} else if (err == -ENOMEM) {
+				devlink_default_esw_mode_param = NULL;
+				pr_warn("devlink: devlink_eswitch_mode parameter ignored, failed to allocate memory\n");
+			} else if (err) {
+				goto out;
+			}
+		}
+	}
+
 	err = register_pernet_subsys(&devlink_pernet_ops);
 	if (err)
 		goto out;
@@ -595,7 +819,10 @@ static int __init devlink_init(void)
 out_unreg_pernet_subsys:
 	unregister_pernet_subsys(&devlink_pernet_ops);
 out:
+	if (err)
+		devlink_default_esw_mode_nodes_clear();
 	WARN_ON(err);
+
 	return err;
 }
 
-- 
2.43.0


