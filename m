Return-Path: <linux-rdma+bounces-21078-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OeEBL+0DmosBQYAu9opvQ
	(envelope-from <linux-rdma+bounces-21078-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 09:31:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6343B5A024C
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 09:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4967B305B5B9
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 07:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15CE39B976;
	Thu, 21 May 2026 07:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QNyWplJl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572773998BF;
	Thu, 21 May 2026 07:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348341; cv=fail; b=XCeQIV+54Vpg++8SiebDSEJCluP2alWK17NC01uQKeNjnhMFMPguH8jW/KtdSiMqOtyIlutw+ntn8+1fY1ocYz+EHddFcdwiLIyz+n8TiQOMW78Xk6mfmJlYxv6QFIIZIvdRqoo5nN8NphjS5+5ngBAfY42MScp7GpvIW80QRjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348341; c=relaxed/simple;
	bh=My/fG5WgcRD4Ri12VMJk++vtpd4CjEGpUjx4IXCCaz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1tYC6u3Go4oo69MN58JTNAqBd/sHYw+wLaRZ5W7KEewdDnWA35t5AK7UUCYI7bv0cGzBqhA5z50FtxG0/tsC367RfmNY+Odz2TeseReIOiQ2QZ1B+Tyb+MWt5Nr9qKZeWwObtcYkGm0PlfXwsjd42pBR+qcjWAxPdCrBvwE8zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QNyWplJl; arc=fail smtp.client-ip=40.93.198.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIReMncrpt7TlhhDNJNPqr/8N/EEbUx7G917rTB+IoXKZYPj9koBT+P3QHCQYDktdJSx90PQwb4QnWLxsAQ6ipJYmLg9bmgurZVSG4K/FrzhHOwK/uFX2P4Npw/UC93u45Dhaiwo7mKJOfhRAYYdMcyXyIfwjPkfVK90inO4ziZRdC6GLtpNLsVufv4GdlVXSbh+BDVvz+kukKWXUqDjXWd/sz5h5YUSXd/guXeOJywvhbKyBjq7H2C60boHiHDQaqrzNCV1LgwplUYT6syDpO9Q9lfnVrET3fiuIRBt0UO893aVoWeAjlj5aB+PmBC30ius0lSqb/xvgt5Tnj8mSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zyem9bmExX6oviomYTpcm6IjlBZWb1Icd4OUdXb3XU=;
 b=fJ5CsKOD0U+avMWZKxKwCjsy0iLcSYEbD52160ITrbuTsW8GRiBdpiWHF0Oox+NADokvqsNpiEp1DHDGdbYcgPV4QcrDXkPJef2Y10ZGPs0czn6BCVwUmC4mduS99ATnVCuLPS+L1yoMRhhuZ3J8ePHzQeV8qlUXp+chnAfMu7K6m/RRNtayZVBm5mJ+KRgziPryy+X8Xs1B7uXpgiMTTKtkOD1fUmnI9aFksbrE9v2y8a3xs4Y3VcCSYqLxtF9+8NcpLGxEr/nKpmalRQP+WUsicUPgUE6ve9E2OlmEXR0vZtA3ucViD1wmeKM/tJQUINNjEOVnTk/ZDIMNBsQTvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zyem9bmExX6oviomYTpcm6IjlBZWb1Icd4OUdXb3XU=;
 b=QNyWplJlvT6DhN4HQDb3t+hm6gRqzKAE4XfvCha+EWxVZv8B77r0qNGX6pi5FAaCLxffMjcqai8jt7ByjFCJNc57mbHzPS8TFhTjOBI8v/DiCqHIcFvPJBDrAieGYVJeG8w2BCAKUG8xLwSIFY4CUG43sz4t/lvKpCvkXw4rXGrmVoW386yb3h0/1qYXW+wBwoiD/CRnfR0Wr2FtllmgJjf2PL2RrTcsXvZ8bHbtwDjtvL0M+MldJ+dc1zi+68cO7pyK3hfXksVx+DSIHCiJLs/MUWtV7NPmmOBSu4TXevlm3hTz47E6sj9Bv1bFHuC2xrYkfFx9ULRB7sz+c94gYA==
Received: from SJ0PR13CA0053.namprd13.prod.outlook.com (2603:10b6:a03:2c2::28)
 by CY8PR12MB7267.namprd12.prod.outlook.com (2603:10b6:930:55::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 07:25:30 +0000
Received: from CO1PEPF00012E62.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::9e) by SJ0PR13CA0053.outlook.office365.com
 (2603:10b6:a03:2c2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.6 via Frontend Transport; Thu, 21
 May 2026 07:25:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF00012E62.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 07:25:30 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 00:25:12 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 21 May 2026 00:25:11 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 21 May 2026 00:25:03 -0700
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
Subject: [PATCH net-next 2/3] devlink: Add eswitch mode boot defaults
Date: Thu, 21 May 2026 10:24:33 +0300
Message-ID: <20260521072434.362624-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260521072434.362624-1-tariqt@nvidia.com>
References: <20260521072434.362624-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E62:EE_|CY8PR12MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: f587456b-6da8-4f34-b0f7-08deb70a234a
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|7416014|11063799006|6133799003|3023799007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	7xNOZAS6EHO7yDJlULd/WZPSjV1eIBKMiLo5695qKcDWSs8rpJ8Eily458SqKqELxuDgSI0HPIWuAlkZuTFZgBsIFxevKo+ydOo+7WPWO3R1SZaAh5YgKZ9nnlTpLNyGWnFHgiUFMByyHfo5tbMMXcEzX3lJFvxzZmCu9gO+YAQi7fph0tfKQUmyUC6sNjsGjA/yxQyKm6NtaYQN9eHg6+/pUSIH41HObjIP38BNGjc5pMdFW7xkHcHMoLy+izidIcgtgwEtlGgOfPdmhU2pBprNFKBabSdUGoJ/+9cL5kPQxvMZ3SO/BTZQHdxC3DodTyIsMVdfW5/uQ2V0QHpAoIFlUBNACZYsfR1Gd+07vl9edj4zW2JTh7EejqFsJzSXUFnHJzvcN/h/ln7ib5U98MQte85FXUCPWHK/lbcpu5HxEWRWG7Jfhl07qXUDPJVwA+tIKBCJ5AMAlcSKndt3wodWoUgnX7P+BoMWYm0/2czhCz2zUeP9Geq4wxZ+iR/iz1dftqssGU4/+TnuA2ezYV5zlY+lCY3slQanKm+jC6CC5BG6nC7Z8v/2AFF7IdxHypBkW+rrhGaUmgMVo+RUDeP5hK+A9HscCzqvp9fsj6568V5vsR5BvV78VWaYMLu/EBIIIXYkg99TyqlYHFzWYvbmSBQl7gEM+EnQ2bItFEsD89/ME7AYiX0ToUED/c4lcrjDBjZ9kB0omoNNenZvK4bQP9Fd2/iwMgosB3wv2zQ=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(7416014)(11063799006)(6133799003)(3023799007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1CZksGaLLbYyFHwHkDz1ZaCx6xHM+d160lMeT2ulxJnBsB+xAz/czjGliKwQ7QtZUvLkkwYtXieVdJbxJp7vuHbkqVvnpwKxp7/PXQfXZdfUJ+mTuo0kN0bbsVx1mGE5aphjvlMKnZMOvsQS0m/JEqA6XU0lg+rEYroBObcYP/TPHYP4/KupiLOzPhfXasB+cntdxmJLF8qboKqwgMdvc3GFFhrDJhr9Eo2i35ZYd5vCyYVj/BXP6C6TXizge4DhrJ5W99Y/E/5XCMzj/LR6NCyQFfYf7I0HV0l2FYucRn9jckkwvcuL7LKke9A6vKMzB81d/sKOFopcGyxF+RvbMWy3+jheK5Rt9vFec73vAt1pzb+qwk2NXpajybCr4hoHBfAP093IkNlaEYbGa84Znpbq+2wggjseb6TRrylRgDHa7sgzkdo4/uHikdqhsy4W
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 07:25:30.2148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f587456b-6da8-4f34-b0f7-08deb70a234a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7267
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21078-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,mellanox.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6343B5A024C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mark Bloch <mbloch@nvidia.com>

Add devlink_eswitch_mode= command line support for setting an eswitch
mode during device initialization.

The supported syntax selects either all devlink handles or one explicit
comma-separated handle list:

  devlink_eswitch_mode=[*]:<mode>
  devlink_eswitch_mode=[<handle>[,<handle>...]]:<mode>

where <mode> is one of legacy, switchdev or switchdev_inactive. All
selected handles receive the same mode. Assigning different modes to
different handle lists in the same parameter value is not supported.

The default is applied through the existing eswitch_mode_set() devlink
operation, matching the userspace devlink eswitch set command.

Expose devl_apply_default_esw_mode() so drivers can apply the default at
the point where their devlink instance and eswitch operations are ready.

Document the devlink_eswitch_mode= syntax and duplicate handle handling.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../admin-guide/kernel-parameters.txt         |  25 ++
 .../networking/devlink/devlink-defaults.rst   |  80 ++++++
 Documentation/networking/devlink/index.rst    |   1 +
 include/net/devlink.h                         |   1 +
 net/devlink/core.c                            | 255 ++++++++++++++++++
 5 files changed, 362 insertions(+)
 create mode 100644 Documentation/networking/devlink/devlink-defaults.rst

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7834ee927310..f87ae561c0dc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1278,6 +1278,31 @@ Kernel parameters
 	dell_smm_hwmon.fan_max=
 			[HW] Maximum configurable fan speed.
 
+	devlink_eswitch_mode=
+			[NET]
+			Format:
+			[<selector>]:<mode>
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
+			devlink_eswitch_mode=[*]:switchdev
+			devlink_eswitch_mode=[pci/0000:08:00.0]:switchdev
+			devlink_eswitch_mode=[pci/0000:08:00.0,pci/0000:09:00.1]:legacy
+
+			See Documentation/networking/devlink/devlink-defaults.rst
+			for the full syntax.
+
 	dfltcc=		[HW,S390]
 			Format: { on | off | def_only | inf_only | always }
 			on:       s390 zlib hardware support for compression on
diff --git a/Documentation/networking/devlink/devlink-defaults.rst b/Documentation/networking/devlink/devlink-defaults.rst
new file mode 100644
index 000000000000..b554e75eeeea
--- /dev/null
+++ b/Documentation/networking/devlink/devlink-defaults.rst
@@ -0,0 +1,80 @@
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
+  devlink_eswitch_mode=[<selector>]:<mode>
+
+``<selector>`` is either ``*`` or one or more devlink handles::
+
+  * | <bus-name>/<dev-name>[,<bus-name>/<dev-name>...]
+
+``*`` applies the mode to every devlink instance. All handles in the same
+``[]`` list receive the same eswitch mode.
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
+* ``<bus-name>`` must not contain ``:``.
+* ``<dev-name>`` may contain ``:``. This allows PCI names such as
+  ``0000:08:00.0``.
+* Handles must not contain whitespace, ``[``, ``]``, ``*`` or more than one
+  ``/``.
+* A comma inside ``[]`` separates handles.
+* Comma-separated default groups are not supported.
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
+  devlink_eswitch_mode=[*]:switchdev
+
+Set one PCI devlink instance to switchdev mode::
+
+  devlink_eswitch_mode=[pci/0000:08:00.0]:switchdev
+
+Set two PCI devlink instances to legacy mode::
+
+  devlink_eswitch_mode=[pci/0000:08:00.0,pci/0000:09:00.1]:legacy
+
+The following is invalid because comma-separated default groups are not
+supported::
+
+  devlink_eswitch_mode=[pci/0000:08:00.0]:switchdev,[pci/0000:09:00.0]:switchdev_inactive
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
diff --git a/include/net/devlink.h b/include/net/devlink.h
index bcd31de1f890..98885f7c6c10 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1622,6 +1622,7 @@ int devl_trylock(struct devlink *devlink);
 void devl_unlock(struct devlink *devlink);
 void devl_assert_locked(struct devlink *devlink);
 bool devl_lock_is_held(struct devlink *devlink);
+int devl_apply_default_esw_mode(struct devlink *devlink);
 DEFINE_GUARD(devl, struct devlink *, devl_lock(_T), devl_unlock(_T));
 
 struct ib_device;
diff --git a/net/devlink/core.c b/net/devlink/core.c
index eeb6a71f5f56..4bc1734878d1 100644
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
@@ -16,6 +20,233 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_trap_report);
 
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
+static int devlink_default_esw_mode_apply(struct devlink *devlink)
+{
+	const struct devlink_ops *ops = devlink->ops;
+
+	if (!ops->eswitch_mode_set)
+		return -EOPNOTSUPP;
+
+	return ops->eswitch_mode_set(devlink, devlink_default_esw_mode,
+				     NULL);
+}
+
+static int __init
+devlink_default_esw_mode_handle_parse(char *handle, char **bus_name,
+				      char **dev_name)
+{
+	char *slash;
+	char *p;
+
+	if (!handle || !*handle)
+		return -EINVAL;
+
+	for (p = handle; *p; p++) {
+		if (*p == '[' || *p == ']' || *p == '*')
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
+	if (strchr(handle, ':'))
+		return -EINVAL;
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
+	char *handles_end;
+	char *handles;
+	char *mode;
+	int err;
+
+	if (!str || *str != '[')
+		return -EINVAL;
+
+	handles = str + 1;
+	handles_end = strchr(handles, ']');
+	if (!handles_end || handles_end[1] != ':' || !handles_end[2])
+		return -EINVAL;
+
+	*handles_end = '\0';
+	mode = handles_end + 2;
+	if (!*handles)
+		return -EINVAL;
+
+	err = devlink_default_esw_mode_to_value(mode,
+						&devlink_default_esw_mode);
+	if (err)
+		return err;
+
+	err = devlink_default_esw_mode_handles_parse(handles);
+	if (err)
+		devlink_default_esw_mode_nodes_clear();
+
+	return err;
+}
+
+/**
+ * devl_apply_default_esw_mode - Apply default eswitch mode to devlink instance
+ * @devlink: devlink
+ *
+ * The caller must hold the devlink instance lock.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int devl_apply_default_esw_mode(struct devlink *devlink)
+{
+	const char *bus_name = devlink_bus_name(devlink);
+	const char *dev_name = devlink_dev_name(devlink);
+	struct devlink_default_esw_mode_node *node;
+
+	devl_assert_locked(devlink);
+
+	if (devlink_default_esw_mode_match_all)
+		return devlink_default_esw_mode_apply(devlink);
+
+	node = devlink_default_esw_mode_node_find(bus_name, dev_name);
+	if (node)
+		return devlink_default_esw_mode_apply(devlink);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devl_apply_default_esw_mode);
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
@@ -578,6 +809,27 @@ static int __init devlink_init(void)
 {
 	int err;
 
+	if (devlink_default_esw_mode_param) {
+		char *def;
+
+		def = kstrdup(devlink_default_esw_mode_param, GFP_KERNEL);
+		if (!def) {
+			err = -ENOMEM;
+			goto out;
+		}
+		err = devlink_default_esw_mode_parse(def);
+		kfree(def);
+		if (err == -EEXIST) {
+			devlink_default_esw_mode_param = NULL;
+			pr_warn("devlink: duplicate eswitch mode handles ignored\n");
+		} else if (err == -EINVAL) {
+			devlink_default_esw_mode_param = NULL;
+			pr_warn("devlink: invalid devlink_eswitch_mode parameter ignored\n");
+		} else if (err) {
+			goto out;
+		}
+	}
+
 	err = register_pernet_subsys(&devlink_pernet_ops);
 	if (err)
 		goto out;
@@ -593,7 +845,10 @@ static int __init devlink_init(void)
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
2.44.0


