Return-Path: <linux-rdma+bounces-18920-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPOaNKNqzWkkdQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18920-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:57:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9153337F857
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B47031165FC
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 18:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD58647DF99;
	Wed,  1 Apr 2026 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G1iWyU5s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3209847DF95;
	Wed,  1 Apr 2026 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069539; cv=fail; b=uudYE2VjFCDo02cquMHszFKDa/ikwRXDY9XkIRmHG5Pid+ubDNsTPzAoPDvKnYLOnXcV7+1w0brsm41RA2u3WCi88gdj/ubgCTYi3EWDWDVeqQZcfst+7NKLZthLKXUbLHVd2RN2gn0M7b3zb3Z8KAC/UjWhyPMIFzLtqlD8feo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069539; c=relaxed/simple;
	bh=iaoFaIRTGdFZ6zfjnZnKHDn3rj+UaQwHftcwH5UQIJs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OICmqTUajrsw6AK0DG26Y/71tqCUdnonlfM06aC6XoDl64uV7N9TrHI6z0/+xH8vx3kJrJ/Gf27bkABlM8lCUFCQupsJXiCpuHewn44TXpIW5zTRuGfSOZ9aKvOi66ZSB8CTDPMNBYLtvjb/eEdKD6rdLjux+Me1P4sVBRT09XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G1iWyU5s; arc=fail smtp.client-ip=52.101.43.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfNQtvOG26bagbQuSVE1SfQ4U65830uOaLQ2ynit+ThjrGuIWMRoSOhjrFbnrfg4yKadEHZLFZLu3afZPGbMZImI5QP5bNktKv+dD2AGucLUY4HuyyRKc2iBMjU4PwXfA3jtvXx2jJ0s0TSAycQpGPntEWC+DnN3FM1ufgW4YmXizJofVqdbpEEd6L7u3GLbCOXTm6sFIt1Q/TjhS43dZyOcFbqxzKSLr3T+9ITNe/1cOgG6KnyvcWVCw09DgiHK7wTdSYD9o/5fgUxwjJ8mSukf/h6IIaJv5k6Jg9Rmxduh+TVgWBJP91AWswptohHqkKMv+vHh5aqTJfuK68Osvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8zIiZ5CNVhLhvbJ2/rn/cPb/+1e8MsF/yuXTRzwdUA=;
 b=eWswH+BQ/SsPVSUdEaX1vPjWxFnChvFTpZhukLg49y+CFFzsQPqYWmdBmjvLz8cX+VLftGDIKwgiU9FrsXJqreNl4648PAgnN1z/dn98mOp3Lk0CRfWPC03c9InUPrHv8vo7tY/W2Rbp7oqqlH5Pp2H8xLsP9lDfRucMjoh8L0MoI8Bsh4PdGd6EFNDoxQPVxFQKgaXqkgRjgRnc5ByKfM+1JTBFWU3ZUlNGIBDnqC+nl7mjeyzZmsF3Dn8spCyBglo3REGmPaJm6K+GoLLGe1olAWBbWxSwZaVDGSPP3CoIR7XWQSoiSp1BLvrptvSGq1oFQZaI4kztX4b9pLx7DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8zIiZ5CNVhLhvbJ2/rn/cPb/+1e8MsF/yuXTRzwdUA=;
 b=G1iWyU5svl/5MOCF4D1mkkEzNWeItHBqsKt9vQVMHBs+ocmlO162JnsY3GIw63sdMUrvjhoTvLWYMczvcdUpNlz4TBGUWc/pNwueotJY2avW1FqPjBwWg0GEEbSyzJKI15V1fx5TzyvySFZQWG2R6gBT3jdrN82lEw2AW7XxlMYGifYVkSxwQ1bDm3znYy3hkI6od+aPlDJCahjnupwZnPIJOuBfYUkiFSYsi6gBshUB80VX9qFhJls2f5TSWs5f3YWk6VRCm1/Dau17HkgBuKcpHj6UqO3STwu21MIw4m6Yrrd6dgwm3IWTCCd1H0Hm8V65VzhFlgLW23pDCjNj1A==
Received: from BY3PR04CA0029.namprd04.prod.outlook.com (2603:10b6:a03:217::34)
 by PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 18:52:12 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::c7) by BY3PR04CA0029.outlook.office365.com
 (2603:10b6:a03:217::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 18:52:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 18:52:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 11:51:51 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 11:51:50 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Apr
 2026 11:51:42 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, Chuck Lever
	<chuck.lever@oracle.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Carolina Jubran <cjubran@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	Shahar Shitrit <shshitrit@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, Shay Drori <shayd@nvidia.com>, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, Kees Cook <kees@kernel.org>, "Daniel
 Jurgens" <danielj@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next V4 10/12] devlink: Add resource scope filtering to resource dump
Date: Wed, 1 Apr 2026 21:49:45 +0300
Message-ID: <20260401184947.135205-11-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260401184947.135205-1-tariqt@nvidia.com>
References: <20260401184947.135205-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 79461663-72b0-46b9-bbe0-08de901fc8f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	gvdhSQrv7rvJwvcTH3Zb6zR5l2pi568cA8ciODcsa2ioLP6DEsLtvtpO6qB1cadsxToCraw3n+6VOjoElFAJZIEQbEoBmORpe7OlhPWGma9DmpqDbk2zOKWfdyed4+l4tXlEbMPOGM4NshFRmBClGY7q04ODQ9J1zupExcGeij4G2eUJ5vOhCdiPuVl7kUTgWmCO7wfKJir09SXdJpJGVJP9Sw0sWDdrcyLfAF11k03QMRdXJQoJNOaeSA6f1aqrCPU+Zf+wJLdKiPypC5VD+p2VYg/BMwZudbIRdUmr62BHnh2er8fSYpc6gCUj/sh9hqU1kUfGZ4GZ/PzZKvf6eSlZiOTpRB8Rmi12Aoo1s80GPx2oagk3BY1mAIrRRCOs4RN8BIqX1p0qhet7o1H7racNhS4cy3hfjIh1YrDM91KUMII9H7ESyfEHf/i3HUZBUZhtAwgREnACXjnncmtMZ8dcJ8cMewh5Z7TNbN3Of3zhPupSy4L1bTQiejBBIBcPw6QkbWejGOd8c2oSpVbsaJf731YlOLO3SFTni49wUAbMWd4W9AWLSUZHHVmNaJpUj6+qwAVm2ZMZ77orw+nm47ZWHged1p2xBijVK898uaLtIgsXrMoxvzVksQ/Z7mXlsosw3j/ybIpbJNQV3OcZTFpvqZGmJESRA99BjmfYbqR7pJpU2eUTC7SbGromixu3cpvWQZrEhn/SoT/+l3q0oIygtYtrEvSdotOphuKlXl6Q9shLYm250nnymFtb+ZkaiPicWjFct94IfwEoc28slw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WCLveJODaFSvRZaA87z2wUJW81yj6RyCXCj5X9UWPLS3OZ+jl5mIypFM0MI0hKqWYtRUaWWTMOL5XAa/a4MAO9HEE4e3LE5H4F3JNfnE+jaCjiRdEFEDncqgb2SvLnOJLfamiZ5e/JPIqMsfIv+qPETcniR0rcx7wnTdrknZno9DFy8TgaRrXFmSlv4jv6uQyrStUEWfYwzXlnSl9BJr+GrcaJAJEJQBErBCXIuXVG4TKR6pc0dagU6c5eLHl+zNxG+MAgQJxsE4xpOlFUt6F0SukzbblvuA+1rNrvhf+H8ANd2Blp4/V6nBbVJtbuQ63pSNxPREIGTspSllMJTk1FUlLy0at/RoE8UNy+B/kMXJKgCidwGTP1LLZbvpj8N+jZQ2mN2CjrnouK96m6/CQssh6wf32dV6ZKmUcqz9Or7gBrgwEJFUMEn9ihffZTzs
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 18:52:12.1887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79461663-72b0-46b9-bbe0-08de901fc8f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18920-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9153337F857
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Or Har-Toov <ohartoov@nvidia.com>

Allow filtering the resource dump to device-level or port-level
resources using the 'scope' option.

Example - dump only device-level resources:

  $ devlink resource show scope dev
  pci/0000:03:00.0:
    name max_local_SFs size 128 unit entry dpipe_tables none
    name max_external_SFs size 128 unit entry dpipe_tables none
  pci/0000:03:00.1:
    name max_local_SFs size 128 unit entry dpipe_tables none
    name max_external_SFs size 128 unit entry dpipe_tables none

Example - dump only port-level resources:

  $ devlink resource show scope port
  pci/0000:03:00.0/196608:
    name max_SFs size 128 unit entry dpipe_tables none
  pci/0000:03:00.0/196609:
    name max_SFs size 128 unit entry dpipe_tables none
  pci/0000:03:00.1/196708:
    name max_SFs size 128 unit entry dpipe_tables none
  pci/0000:03:00.1/196709:
    name max_SFs size 128 unit entry dpipe_tables none

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 24 +++++++++++++++++-
 include/uapi/linux/devlink.h             | 17 +++++++++++++
 net/devlink/netlink_gen.c                |  5 ++--
 net/devlink/resource.c                   | 32 ++++++++++++++++++++++--
 4 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 34aa81ba689e..b7d0490fc49d 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -157,6 +157,14 @@ definitions:
     entries:
       -
         name: entry
+  -
+    type: enum
+    name: resource-scope
+    entries:
+      -
+        name: dev
+      -
+        name: port
   -
     type: enum
     name: reload-action
@@ -873,6 +881,16 @@ attribute-sets:
         doc: Unique devlink instance index.
         checks:
           max: u32-max
+      -
+        name: resource-scope-mask
+        type: bitfield32
+        enum: resource-scope
+        enum-as-flags: true
+        doc: |
+          Bitmask selecting which resource classes to include in a
+          resource-dump response. Bit 0 (dev) selects device-level
+          resources; bit 1 (port) selects port-level resources.
+          When absent all classes are returned.
   -
     name: dl-dev-stats
     subset-of: devlink
@@ -1775,7 +1793,11 @@ operations:
             - resource-list
       dump:
         request:
-          attributes: *dev-id-attrs
+          attributes:
+            - bus-name
+            - dev-name
+            - index
+            - resource-scope-mask
         reply: *resource-dump-reply
 
     -
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 7de2d8cc862f..e0a0b523ce5c 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -645,6 +645,7 @@ enum devlink_attr {
 	DEVLINK_ATTR_PARAM_RESET_DEFAULT,	/* flag */
 
 	DEVLINK_ATTR_INDEX,			/* uint */
+	DEVLINK_ATTR_RESOURCE_SCOPE_MASK,	/* bitfield32 */
 
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
@@ -704,6 +705,22 @@ enum devlink_resource_unit {
 	DEVLINK_RESOURCE_UNIT_ENTRY,
 };
 
+enum devlink_resource_scope {
+	DEVLINK_RESOURCE_SCOPE_DEV_BIT,
+	DEVLINK_RESOURCE_SCOPE_PORT_BIT,
+
+	__DEVLINK_RESOURCE_SCOPE_MAX_BIT,
+	DEVLINK_RESOURCE_SCOPE_MAX_BIT =
+		__DEVLINK_RESOURCE_SCOPE_MAX_BIT - 1
+};
+
+#define DEVLINK_RESOURCE_SCOPE_DEV \
+	_BITUL(DEVLINK_RESOURCE_SCOPE_DEV_BIT)
+#define DEVLINK_RESOURCE_SCOPE_PORT \
+	_BITUL(DEVLINK_RESOURCE_SCOPE_PORT_BIT)
+#define DEVLINK_RESOURCE_SCOPE_VALID_MASK \
+	(_BITUL(__DEVLINK_RESOURCE_SCOPE_MAX_BIT) - 1)
+
 enum devlink_port_fn_attr_cap {
 	DEVLINK_PORT_FN_ATTR_CAP_ROCE_BIT,
 	DEVLINK_PORT_FN_ATTR_CAP_MIGRATABLE_BIT,
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index 9cc372d9ee41..6d4abd8b828d 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -313,10 +313,11 @@ static const struct nla_policy devlink_resource_dump_do_nl_policy[DEVLINK_ATTR_I
 };
 
 /* DEVLINK_CMD_RESOURCE_DUMP - dump */
-static const struct nla_policy devlink_resource_dump_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
+static const struct nla_policy devlink_resource_dump_dump_nl_policy[DEVLINK_ATTR_RESOURCE_SCOPE_MASK + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
+	[DEVLINK_ATTR_RESOURCE_SCOPE_MASK] = NLA_POLICY_BITFIELD32(3),
 };
 
 /* DEVLINK_CMD_RELOAD - do */
@@ -974,7 +975,7 @@ const struct genl_split_ops devlink_nl_ops[75] = {
 		.cmd		= DEVLINK_CMD_RESOURCE_DUMP,
 		.dumpit		= devlink_nl_resource_dump_dumpit,
 		.policy		= devlink_resource_dump_dump_nl_policy,
-		.maxattr	= DEVLINK_ATTR_INDEX,
+		.maxattr	= DEVLINK_ATTR_RESOURCE_SCOPE_MASK,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index 0f1d90bc4b09..c22338b2571d 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -341,6 +341,22 @@ int devlink_nl_resource_dump_doit(struct sk_buff *skb, struct genl_info *info)
 	return devlink_resource_fill(info, DEVLINK_CMD_RESOURCE_DUMP, 0);
 }
 
+static u32 devlink_resource_scope_get(struct nlattr **attrs, int *flags)
+{
+	struct nla_bitfield32 scope;
+	u32 value;
+
+	if (!attrs || !attrs[DEVLINK_ATTR_RESOURCE_SCOPE_MASK])
+		return DEVLINK_RESOURCE_SCOPE_VALID_MASK;
+
+	scope = nla_get_bitfield32(attrs[DEVLINK_ATTR_RESOURCE_SCOPE_MASK]);
+	value = scope.value & scope.selector;
+	if (value != DEVLINK_RESOURCE_SCOPE_VALID_MASK)
+		*flags |= NLM_F_DUMP_FILTERED;
+
+	return value;
+}
+
 static int
 devlink_resource_dump_fill_one(struct sk_buff *skb, struct devlink *devlink,
 			       struct devlink_port *devlink_port,
@@ -400,16 +416,27 @@ devlink_nl_resource_dump_one(struct sk_buff *skb, struct devlink *devlink,
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_port *devlink_port;
 	unsigned long port_idx;
+	u32 scope;
 	int err;
 
-	if (!state->port_number) {
+	scope = devlink_resource_scope_get(genl_info_dump(cb)->attrs, &flags);
+	if (!scope) {
+		NL_SET_ERR_MSG_ATTR(genl_info_dump(cb)->extack,
+				    genl_info_dump(cb)->attrs[DEVLINK_ATTR_RESOURCE_SCOPE_MASK],
+				    "empty resource scope selection");
+		return -EINVAL;
+	}
+	if (!state->port_number && (scope & DEVLINK_RESOURCE_SCOPE_DEV)) {
 		err = devlink_resource_dump_fill_one(skb, devlink, NULL,
-						     cb, flags, &state->idx);
+						     cb, flags,
+						     &state->idx);
 		if (err)
 			return err;
 		state->idx = 0;
 	}
 
+	if (!(scope & DEVLINK_RESOURCE_SCOPE_PORT))
+		goto out;
 	xa_for_each_start(&devlink->ports, port_idx, devlink_port,
 			  state->port_number ? state->port_number - 1 : 0) {
 		err = devlink_resource_dump_fill_one(skb, devlink, devlink_port,
@@ -420,6 +447,7 @@ devlink_nl_resource_dump_one(struct sk_buff *skb, struct devlink *devlink,
 		}
 		state->idx = 0;
 	}
+out:
 	state->port_number = 0;
 	return 0;
 }
-- 
2.44.0


