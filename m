Return-Path: <linux-rdma+bounces-23173-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8qwqHL/UVWpUuAAAu9opvQ
	(envelope-from <linux-rdma+bounces-23173-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 08:18:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB6F751691
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 08:18:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=pBiueKCa;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23173-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23173-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C94B300EBBD
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 06:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4BA382F2F;
	Tue, 14 Jul 2026 06:18:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835FC34CFDD;
	Tue, 14 Jul 2026 06:18:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784009896; cv=fail; b=L+V/SKA8bVuik5KGtGpQBQl8TUmKhEwETIDCZ5Cq5APxTyRVtedoSnjwFuReKAOl0yNd3X5meX2whxjJxNrb81gccy0hWjqlZTpjGF5LoOLWFA/KNZB4v04CfBKyUZwvovtqtaRR96VtEBkYc3nwD6ArHCZtEH7Sge+e3xf1O28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784009896; c=relaxed/simple;
	bh=T5UuhGUfRZJaKHwuurEbTHaDftkl3tnkKWoHKgPLbr0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=neBnNV6vff3/cLD5k3QNk6CzSNPsTP4GFTtJFln22QEou6+krVYNHx/6QJBCHCAXPc/DMPdYN7Rwm/Uva/jTbLoXI5ValRZkwSzNQPh5Efem+7mB4VgA9ZyxP1fg4R3tzhXP0Cq78QL0bxMRSGwntvDxKAvU0nsKlo3nl8jziQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pBiueKCa; arc=fail smtp.client-ip=52.101.43.19
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWCDBiZ8CxRGqQOfgXhsiLTDIbaS5jvjD0Jtj07W2tN8q8Pr76Un4qs2Nmj0uRk5SDsD/EWzotGAUIpzJp5nyLfClZyLfKFVMxLrM9s3W5RbsZygrmzjTmDnQtiN1eWd4t/uPBTPQF/A0LZ+CzaOhKzOAXlpkOnQeuEqOgEtrE/DOKsee7ynl3HVBG/lE+RL5LM5UsCpWXPm9NXHUnEB6f61tZmOF/9ZCBzcwZJr+auevpsMD8d1CezN7uz6eeFtnmCfgqB5ezwTtUrRKB2RkmCgR5eoun+IOA91sD3YFmY0TH3aLL0omiF5jjq1XAOD8f72nMnMnYTMs3+lDEof6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97txnW0wTXK1t5dnbyghN/+PbF6wSpa2Sm/JjKywOlM=;
 b=ST2R4Y26vSlif88l/TbdKCJOfSJhBzkm0iOklVplVXTFu4IT2PnHZNaXb4O+4pyf5YxDbSzKX8TkJD9p1aqTq/QhsmBjBBAnuG5IhazDSUZOdMT9X7bHXcm/KLDi4NGh9GK/KAFLTDI+92iPDn+p9m5NCNLVRnd8c5JNjpsvuXLxX9xjPtmMdznLWRCa3gihiPoTenj7ayLS6jIIRb/etQx7R5HFNajMoXdNIHsW/WxR6YJG8KhXorqWlNc0YSWKtzwnUBQdNlPr9n3KU/o4GDYS8u0Mru7NAfohgwNOJOKzKRUNPIDzlII/sIe7jwb11fEA5VsLUuBcoWFG9vd4xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=resnulli.us smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97txnW0wTXK1t5dnbyghN/+PbF6wSpa2Sm/JjKywOlM=;
 b=pBiueKCaZhbiyr8QTSnmRNDjW3VcfuvWLTbqzsNl20RR1j1txrsLZYwr3wHExLaozFmDEh74hO1wrGMYyDjF/Blnq9pe4bt2ia7Wk7xIddierfxyqUoolG7iIz6ebdUWLfoY8efiWMOYig7GPJcIzgpqA/OnGu5/8tk/aBWiPE8dox/e+5rMunKIOciezZ63ap6KLYE8Jh1tLU5GfOzCTxLBA/c2Cj1VEJX2n7Bmk7LaSj+4svDW0KR8OAQXq1XnDIREHy9loj8qgh8DbzpcyqgRY091BPOzvMHcCVx+hqz3pGc/NbaHDEBjk/+JQhy8ieuk4QO+ot+YxZmg3uXquA==
Received: from BY3PR03CA0028.namprd03.prod.outlook.com (2603:10b6:a03:39a::33)
 by IA0PR12MB7651.namprd12.prod.outlook.com (2603:10b6:208:435::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 06:18:06 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::1c) by BY3PR03CA0028.outlook.office365.com
 (2603:10b6:a03:39a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Tue,
 14 Jul 2026 06:18:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 06:18:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 23:17:50 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 23:17:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 13
 Jul 2026 23:17:46 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next V6 3/4] devlink: Parse eswitch mode boot defaults
Date: Tue, 14 Jul 2026 09:17:29 +0300
Message-ID: <20260714061731.531849-4-mbloch@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714061731.531849-1-mbloch@nvidia.com>
References: <20260714061731.531849-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|IA0PR12MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f419856-4c27-4df6-3fc7-08dee16fab57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|82310400026|1800799024|36860700016|3023799007|22082099003|18002099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	aKaBezMJ3xfJO2aCuI7N4SkI4wsnTRaA31kP0Z4WciZ1n7o1zq7uWH4KPQ0fqtjA/4c877cYg0WWLr4fiTT0WPZi3PhAJpFtlo6r+o+sKWkTv0RsWlxVd9EP41XYISTIBia0rK43oWv833MbxnPSuMaG2zvhr7yOHLpvhV4wgxP/DqMBl/Sr21Vm+eQSD4kIDCT1qtIis4Ps1qu5GBOM1SHLSFbOGSqRsP6A3B29QnkGBXa2AYgX5s5ItOcmSPxKiZHOWxVpbWTNrsOzXKLA3RJH3I/Hhdqw9i1QwjlAqm6IqOU7ldjBvSGtLrFDU48OekjYvlZaROIMD6LBwEpdqTNi1e5+N301AyICwQzas/NbH0GpIfPOU7YyNXh2psZKN4O+23ieCp4b1qZJd8jflDctsP1TWoXOXID/j+YktkblUKBIFFvK29pHQDCuhpyHJjPqb9MBYkfpJrjJZH1jHAzUtHvVCRxDkYlM8+JP/X4eYqMnf4SfR7ePCWeVBtlWvY6ICyLkQidChVqncSGXVbhKBR21ZHtj/Ci3kwOsHSLefQtLwzlCKx0FXl0m2bPKgo10gM8T7agG2Vz59pwC53yA2BIODE9VC+TAAbe9blzUDj4C6xsZ3YbyK9P4WDHa/Njx/9tGKiba0Wzah2+BKd2KQfs64w+JhItMD4CJ+YP5TtUnJMUBKM7HZV219xFC2fyV5IHcn0GaaV/YCg4uvA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(82310400026)(1800799024)(36860700016)(3023799007)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y7Rf1O250P8tAN9Zm553wz4PWvmEOkLn4mH9dmX/BrWK+D9a62TZw/8PVPxHL+9QnDOk6V1c1zbu6oNi62BPJLFY9mwmJl3xJk2KZG/s8T5BRPwbil8TvvSu/oEyJAEpPMjlA6j9n5M0PAnlwdYhQ8+sztOdUimdNLtBwkppy36pawV+LEbEf10MvL+Z+J1iVOkOZKt0Tt2evb89hGEQPRF/bAtlBTNYmz9jNFWncbe1qRigjeP0kZmyunzZ7CwGIEdp5/m3EWzeML+3DwKfkDUAYqPYQ+wYyBbTClk6bMA327yQb8CNsAhkFoBiwi6rPr24S6TbOnmKc+8pZEarGjqCxtUj6MNaAyP+QkzPeH+RmKbzII8kWZxWCKef8gL6+6LF0ZbWjnAl077WB6beXq6K6zbqKsgUL5v9G3WFbOzSKirwQ7gexxx94+6uMb20
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 06:18:06.5171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f419856-4c27-4df6-3fc7-08dee16fab57
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7651
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23173-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AAB6F751691

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
 net/devlink/Makefile                          |   2 +-
 net/devlink/core.c                            |   7 +
 net/devlink/default.c                         | 237 ++++++++++++++++++
 net/devlink/devl_internal.h                   |   2 +
 7 files changed, 351 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/networking/devlink/devlink-defaults.rst
 create mode 100644 net/devlink/default.c

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
index 4745148fecf4..134d2f319922 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -56,6 +56,7 @@ general.
    :maxdepth: 1
 
    devlink-dpipe
+   devlink-defaults
    devlink-eswitch-attr
    devlink-flash
    devlink-health
diff --git a/net/devlink/Makefile b/net/devlink/Makefile
index 8f2adb5e5836..99ca0ef7cf1e 100644
--- a/net/devlink/Makefile
+++ b/net/devlink/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y := core.o netlink.o netlink_gen.o dev.o port.o sb.o dpipe.o \
+obj-y := core.o netlink.o netlink_gen.o dev.o default.o port.o sb.o dpipe.o \
 	 resource.o param.o region.o health.o trap.o rate.o linecard.o sh_dev.o
diff --git a/net/devlink/core.c b/net/devlink/core.c
index c53a42e17a58..fc14ee5d9dcf 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -598,6 +598,10 @@ static int __init devlink_init(void)
 {
 	int err;
 
+	err = devlink_default_esw_mode_init();
+	if (err)
+		goto out;
+
 	err = register_pernet_subsys(&devlink_pernet_ops);
 	if (err)
 		goto out;
@@ -613,7 +617,10 @@ static int __init devlink_init(void)
 out_unreg_pernet_subsys:
 	unregister_pernet_subsys(&devlink_pernet_ops);
 out:
+	if (err)
+		devlink_default_esw_mode_cleanup();
 	WARN_ON(err);
+
 	return err;
 }
 
diff --git a/net/devlink/default.c b/net/devlink/default.c
new file mode 100644
index 000000000000..8434af83ea69
--- /dev/null
+++ b/net/devlink/default.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "devl_internal.h"
+
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
+	struct devlink_default_esw_mode_node *node_tmp;
+	struct devlink_default_esw_mode_node *node;
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
+	enum devlink_eswitch_mode esw_mode;
+	char *separator;
+	char *handles;
+	char *mode;
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
+int __init devlink_default_esw_mode_init(void)
+{
+	char *def;
+	int err;
+
+	if (!devlink_default_esw_mode_param)
+		return 0;
+
+	def = kstrdup(devlink_default_esw_mode_param, GFP_KERNEL);
+	if (!def) {
+		devlink_default_esw_mode_param = NULL;
+		pr_warn("devlink: devlink_eswitch_mode parameter ignored, failed to allocate memory\n");
+		return 0;
+	}
+
+	err = devlink_default_esw_mode_parse(def);
+	kfree(def);
+	if (err == -EEXIST) {
+		devlink_default_esw_mode_param = NULL;
+		pr_warn("devlink: duplicate eswitch mode handles ignored\n");
+		return 0;
+	} else if (err == -EINVAL) {
+		devlink_default_esw_mode_param = NULL;
+		pr_warn("devlink: invalid devlink_eswitch_mode parameter ignored\n");
+		return 0;
+	} else if (err == -ENOMEM) {
+		devlink_default_esw_mode_param = NULL;
+		pr_warn("devlink: devlink_eswitch_mode parameter ignored, failed to allocate memory\n");
+		return 0;
+	} else if (err) {
+		return err;
+	}
+
+	return 0;
+}
+
+void __init devlink_default_esw_mode_cleanup(void)
+{
+	devlink_default_esw_mode_nodes_clear();
+}
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index af43b7163f78..fe9ad58515d4 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -71,6 +71,8 @@ extern struct genl_family devlink_nl_family;
 struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
 				struct net *net, struct device *dev,
 				const struct device_driver *dev_driver);
+int devlink_default_esw_mode_init(void);
+void devlink_default_esw_mode_cleanup(void);
 
 #define devl_warn(devlink, format, args...)				\
 	do {								\
-- 
2.43.0


