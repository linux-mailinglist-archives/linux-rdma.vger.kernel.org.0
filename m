Return-Path: <linux-rdma+bounces-22844-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RbJVDA88TWrKxAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22844-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 19:49:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BFB71E689
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 19:49:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=mfXXhdKD;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22844-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22844-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58241306971F
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 17:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEB843B6DB;
	Tue,  7 Jul 2026 17:46:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013062.outbound.protection.outlook.com [40.93.196.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFAB3859FD;
	Tue,  7 Jul 2026 17:46:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446375; cv=fail; b=PWPBEc/CSdrn/A3ECQQ2MXKmXZiC9IxWrV+ii/dGeaxsj06oZt0mSs+DKeKaOkWv2l/v2oSd1jJzPYuHquW/eQE+eYmfmNAPM2xn9fQGzM1MrN2P64lcZ/H5Tc9+GTPbCeYH4i21lE1EheGD4nvh6HNR8J/B69ZRzvJsx1Z4itc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446375; c=relaxed/simple;
	bh=T5UuhGUfRZJaKHwuurEbTHaDftkl3tnkKWoHKgPLbr0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rd27nZyAuB97RhVUamSq/9y76GqzQ1hnl+Olx32B3/gCDC0ldOzz56/tfGArn7OJHLbl423/KUMEcdsRO/jwkdjeFmWxG7486SHrE1kxebr8fVytWXJHhDQ+Nq2tn6O/plDVpp0TNkdIyog9zqNLOz4BgOiNlt0cozlDlUbsBsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mfXXhdKD; arc=fail smtp.client-ip=40.93.196.62
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kU5YM5c6eTgss+hTu7NMuj5f0Gbd+4C3HZ5LKFNbGu/jg0U6O1pPiEXWL+yUQGlDKdNVlx9QcJAQOT7aRGKMJtjqwBuN4AoL0734+MZaYZkEf2OO3VQv+D+AuLRFoV3tt37Y3Qul44BhCkvfJJzlme8ZuVgbJUT13iSD5TjWLF6zfJ4KsRWYNUQ0r/gDN0jJDb8HybZKcChJMKgjTypFhD+TyV8sIgzWUhXmd+yDxvU2fJGqwZQ2UN5Qe7/A9vilQaEj2eGc6d2kM1UJqg9AgmlW+HCaoQeglD4ps7HxglADvrPkNH2lPxJgNJhLGwdNGkHtV7BDHBXuVfwwT2lMcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97txnW0wTXK1t5dnbyghN/+PbF6wSpa2Sm/JjKywOlM=;
 b=knHMCZCDaqp5FjVjnc2zWTkfSI/qrpX+p4TNWKe3seQPaei7DKPdcIcGuprpmEw2CrRT/NRaBz8AGBzKK0AtT9KOeXmqsgIjD69h8HxdPQLa8UKIzMO1Dh88Ud3XA8XWJXi0iTW+tyD87azQK6523LNz1P9ZOyRA4Y39OIlpWDHu+haKzSj+FzyIxjbRV2GTqBWrEAlWyGquv0lZq/zZ5iRFbX11OZqlCh6rih6glyCLSHnBy6L0XBT8UNxJq/mohVFFWwfvFfwLRgYSfhjbMcyJpNPcbY8d8rFE6ahzdrUsy5i9WpvJnnu9REDa0vNjgKy5T7Jc3tEdNsUeSA6vBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=resnulli.us smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97txnW0wTXK1t5dnbyghN/+PbF6wSpa2Sm/JjKywOlM=;
 b=mfXXhdKDPAf297LyGCeYOwUH3eg+UJpqQz7iwenDoGEUj3McPwdsZf4PklOoJ2FnSMlN3Q+l4GxFUfuE+TJt9LiVFb6qDFJnnDOAPaQ0SrY5NqoUwkrSmPocWCJqSQMS+ijGnhDoyZIdPu712qfIPONFkKxJEuaw6g7QpsWRsNg7YkO8TZdbs6cDLe8nxy29N+gkpoW6J4WtFUGe8WTqO3mKnzp44H1tvaaH9+AH0vBOYjd9M92+hmTwV2ys0IQiyApbumPzPmo+Ay9SBvhYPVSk2YmyuAtYvO3Uu0WEuke/T484kX1q7gfOkRW1L2VWIwtcDE7YSqi+zPG+6PwSCg==
Received: from CH2PR20CA0030.namprd20.prod.outlook.com (2603:10b6:610:58::40)
 by MW4PR12MB5644.namprd12.prod.outlook.com (2603:10b6:303:189::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 17:46:06 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::25) by CH2PR20CA0030.outlook.office365.com
 (2603:10b6:610:58::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Tue, 7
 Jul 2026 17:46:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 17:46:05 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 10:45:48 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 7 Jul 2026 10:45:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 7 Jul 2026 10:45:44 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next V5 3/6] devlink: Parse eswitch mode boot defaults
Date: Tue, 7 Jul 2026 20:45:24 +0300
Message-ID: <20260707174527.425134-4-mbloch@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707174527.425134-1-mbloch@nvidia.com>
References: <20260707174527.425134-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|MW4PR12MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e6488b-5649-4d31-31c0-08dedc4f9ecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|23010399003|36860700016|376014|82310400026|22082099003|18002099003|6133799003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	tCnCPqX956/WU0FSqBSQj+PGNcI6uDFXPrAjtMw5OB0a9yfYnhnaWILztiQ77SjC0YqMgoKQduCONnhuKZi+6BlCL5symAcIfZhmbqiZ6bswRKgtWU4qqOnndhtAflEgnFiJTb1jGJIvWoSXzZZF3mAOa3EKlFWIEvtd0ub0ghKBsGSY/tTEmO67QKpVJyLyZOSlRYeQ0R3rEVJT3eME82VaMenKyIyU6IWYOSi7GHAXcnAsVvHcK99u94gg41a5c+V5s0WGiFaYN06weGbI2vIswm9ypr48TpVcpB9Na0jd/7JQ4r1HouU3H5bLnG3w5R7umAhAd/iszSOWqD3YDLkHMn8bO0pNszY4+qnbUrWv4z64IvJmKpf2Kwdn/oY7eZRIZcvQ075bqKak9X6iImw0pHqxlrOsNucMm3JibBuoLwlX19+XgcssnVUIk3oVsvSIZBwUDbJFiCpupsRBjlb+Wo+2U0f+FwO3BcJ9YJkLd0Zfkxua4jv50PEq4NoUN2Ijm5bq3fYaRg5zYnVhM+wOjlEbiidJ8PbWvKBUZt3fT511hZmMNYpdg0QGmpf7lDfKhkhnIb7SFPHJcldh+kp7Kp4aH7oEtH6e+A/3mLlseVLROvOhZyKlw4fup9qL7Fia2oQNmgMGqjgV/mCq8i1QuqLGpmd5xMI6hrEM8Y7UmSf/qvJdMxewgHR++j8Wg/7qy9p8GRU5juwhP0Y0kw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(6133799003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PRVN2+N30TY5ntFl86wFd4wJVRkTbWW1DcYb+gCIhRUoVFpdZm6ziGwecW4z5fN51ootrSBsfA4n4JpfRSW9nswlZjOAr7Plgy7WkP3zBxDksUvdhDNKcI7dQaYUfIwDe9O3SH3/EOmknVRFHqRwWElV/4/q3gyjf7UJLpGTqnjUcsD6UN442ohsyqP/9HjWQjsKKDHGW2dJ8qyBDpSqPUbV87T8/rZ9y7D6QfSHoMQHdfc8HUj0sVuYXccrKaauCWL65TPz+7EkXT6D1ZZDW7QCUZNHiFBDQ9a/g521fCF6an5TxHZsVd2Kqx/ZudV2SGoldEh5qcS8GsY5JlJiYk0NfFKW2ywx4+/G9wYjsQ9Afo4gQa9wr5I0nUtA4+zCGYxXWMXAoN0On2ADpz7tS+m4FVstTj1MfLlxjvQTdU8mUGRyEw8qdjOVD1qaryZ0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 17:46:05.6461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e6488b-5649-4d31-31c0-08dedc4f9ecf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5644
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22844-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99BFB71E689

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


