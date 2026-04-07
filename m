Return-Path: <linux-rdma+bounces-19112-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMUjDMFe1WnU5QcAu9opvQ
	(envelope-from <linux-rdma+bounces-19112-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 21:45:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 155393B3EA1
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 21:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 880DA3035B2A
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 19:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5B6379989;
	Tue,  7 Apr 2026 19:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P6+SRL5g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011026.outbound.protection.outlook.com [52.101.57.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E093368B2;
	Tue,  7 Apr 2026 19:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775591019; cv=fail; b=hPAXwYYryxiQaIWcYkxOR3XrQmYJGtz4XJOLMLNmw86JDUl70ag25Dqraug5S4x0EaZfhishSLJ49F83VX3D325vvkEX40MwTyeXYxxOiwW2YPzSRh48p1IbHHCxthLhC1UKM7HfH895SoIR50VYApvzTxg11W0uRr8B2eNXF34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775591019; c=relaxed/simple;
	bh=uMltVMxkcsObmUU6RL33wlbljy6WMHPxu9oA3vjFULM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sjr+RBbSpP8POyLLoitZF6igX0/V2iAcSSM84csHyDlb2Mh6o79BkuBsW9XiRu4SyLYTronLjtiG5tXViJBUGzlUxlw1JbSinvD8Fv+Rxi9JpDrhdbGj5DW/YJLhRMbLs4yHgelWAfoURMUQWQmNjXkL96H6xigJbwXtho6GLmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P6+SRL5g; arc=fail smtp.client-ip=52.101.57.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yau1HPPNEAYuJJxhZLEjuWI/yuNgxUFjJbaJSmPAkwFtCO1DRZzWj1ZZksWLz/N5CGNGxi6gCU2XNtWy1USI7LssWNj8l2TAr2MTekvj367FXFtLv9wxGg2Rsv+nqx7C4LePMxtV62ZX9w4BsPnqFiVTreHyuCrUB9eBGj1brFc8ujEnEqTyXrkoq86ECzLKTog0wixbTKyRN7hqGt+55Zk0dNBxB1njCtkVgTjp62LS1L2rK/404G/jwnkqiaFQFhL5o2kOXmosdohAks9TxmruSKwPYTi35nQ42189CikaiK3+uZR+pJnWSQ49YqlBh1iMQIafs2IHeTw/q9d5xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DN8e3Pf2McqbnqAlK3W7nK7pJnya/7OhdTLvv7ousGA=;
 b=dXv9ExBOcT5BsXfeIK9JpbRHx3m/Djz3DiZUg2PQZ3K6wEEtWoO7ceVTl1dQ54z+6kI2GXzJeFT3GTn18zGdG70iVf/zWFbHsBDQ7xS/d9amf76NYt6zjdIaECjCmvpDw1UH2wGcz51EOKY0IcuNlbJF1d8KJVQRRvRTxuyK2ohv1/U1eBSA2xWzZSD4MifydEOcqA4zeVSwXBXjJP2DlIfZrkh/TpBGws9l145RnOkKwZu26ST6SYWz5eoWuLvm7aCUGqB5PxPYBHwAMHRw4dwr84Ldw9UWm3AxZsDUAshvfl4XUXUG4FN6LR0F9K9CtoyYfO8RMv49A14/YYui7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DN8e3Pf2McqbnqAlK3W7nK7pJnya/7OhdTLvv7ousGA=;
 b=P6+SRL5g80AEHHOY8fhdUOZx+Yt3f6hgjLNe6PTiaXNTbZpJepBwRbGXaULOV/7nhJf/yQXR6hx11eVORPc4nAv5SXk53NrLMyOHMFDWX7w1qQhIYoh4SKLJC8nDoHID+WObGC++aaahObJziCcDjEM9NNxMWM4wTQsF7TyZ6rH8t5kFfH9Ehscp3kg6lWuyoNd1S1zkRCv7p86oh7NODrhh5lkPG9oSVBggD/zTSHnu7EZfOcc2xkkxIGrONxRgIctOoD7mn1dELSK9lxOe9nv64ropbKQYzfInacgLjRw2IVDxt1H/b6w48z6S+kL8xYIpsMmlbUZVR/7WCrcorg==
Received: from BN9PR03CA0713.namprd03.prod.outlook.com (2603:10b6:408:ef::28)
 by CY8PR12MB8243.namprd12.prod.outlook.com (2603:10b6:930:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 19:43:32 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:ef:cafe::42) by BN9PR03CA0713.outlook.office365.com
 (2603:10b6:408:ef::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Tue,
 7 Apr 2026 19:43:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.0 via Frontend Transport; Tue, 7 Apr 2026 19:43:32 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:43:15 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:43:14 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Apr
 2026 12:43:06 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, "Matthieu Baerts (NGI0)"
	<matttbe@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Carolina Jubran
	<cjubran@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Daniel Zahka
	<daniel.zahka@gmail.com>, Shahar Shitrit <shshitrit@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>, Parav Pandit
	<parav@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, "Shay
 Drori" <shayd@nvidia.com>, Kees Cook <kees@kernel.org>, Daniel Jurgens
	<danielj@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next V5 10/12] devlink: Add resource scope filtering to resource dump
Date: Tue, 7 Apr 2026 22:41:05 +0300
Message-ID: <20260407194107.148063-11-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260407194107.148063-1-tariqt@nvidia.com>
References: <20260407194107.148063-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|CY8PR12MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: fca85cd4-38d2-447f-ec21-08de94ddf350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	h2Lml6ECyDve3mb5m8IJcWvSgjBn7id5s03yfJRzm73PfXqGajV5li39gGnqRCApU84OJC4vd7OjmXxZqHlo1xkPt0aeenKGGBEcorZCWBZ3S4NwN0yluMOGvJfrVFifjck5lw3Qv0vnDmpCnUyI93Ap3bvni9pLTmuysLD4MvVnPLLCFfLoHU2L7RSSUoQfBVTx3zYfDC2AVHRV3Gh+F+POHi6TNUDlzFKd46oUfvyntbrIRvlit6WxCbtOxhv+2kIRrjVudDMnMdHJH0uRTDuEtM4VpQDesGH8N2LpfyYRbeeu/+lcJjDiz+7CyE9PCbNSNXadRpY0mhLguvhcgB+A9Ig+9FASPb3ozgZh03uaYnxsdQ50d+N+zcvkvNinOjlHdeqNI7k84bXUc5FMBhRT0j8YXOuby14fMvHncEHh/dwzjmXxCAVshu8gIYZFIjOFgY3iEcekO6pZK0km8ldwokwS4URYZNFUmFt9AQs0tmqsZQ4+qZuTPupurLVwBskBh5abGctlibHG8Y9jfAShpUEJjJRqfE/s5Ygmx58Eb1yKpCfUB4UgYPxXF30bBRfZ33LuB4Um1Kyekc9Fux8OvtP1ub47yng9Oj4O979yZVHVNjqH8EU0KG9UIyhY+X+SkjraHD/d4/7V0/ZiudjwLaqKaVWrkBszvIgN54FsYikQZeLHvzy5vMbYtYo0trEMnrhMJfnDTuoO8KVLV35zhy9nvXsSMPLaGuPq/KWhHUypPXWWOfN62wokjrm2XjOxl7dTMelK2mpymgCADA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XC7K6lmr2+IneAOcsKR0UZCwBhXokw3b4mMlc9ycZx1iR/tm6m5PmEgNHB6sF46mSs2Or3QzQXtmuiqLBjI5KqWLzxNOewwmLfVVMGw6Zu3t37vGBj3KIQ/2+M3rEWSESd96yk7F+Fja7WCp6dqGWF5hl1N3+7rbe4+BpXdZkPc3z/z6VGa1sGfpgUB8BrURq+IBhBY55u8H84MyrJZefZvwiFC4hCpo5Ndwf2T0MG8sTaz5Z7bp1PuANdlXz2LtP8714G3omRZ+u4qO5ccHZjz1fs/4k0WYK4hzq+pHa18gPKb0xN0O/MxDXQMOPtaVjEF8BIsq3FBGxEyHNvUvgl3LUQB2xUh6EJRd0povkbJGHo7aacsz2CIwuQlJ+CfF8Mzv/mJp+4YJyJXwREqJhgo7sVNjRGsREkvEu+YyL1N/EQraqexleh65ChgjY7q7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 19:43:32.2126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fca85cd4-38d2-447f-ec21-08de94ddf350
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8243
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19112-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 155393B3EA1
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
 Documentation/netlink/specs/devlink.yaml | 24 +++++++++++++++++++++++-
 include/uapi/linux/devlink.h             | 11 +++++++++++
 net/devlink/netlink_gen.c                |  5 +++--
 net/devlink/resource.c                   | 19 ++++++++++++++++++-
 4 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 34aa81ba689e..247b147d689f 100644
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
+        type: u32
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
index 7de2d8cc862f..0b165eac7619 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -645,6 +645,7 @@ enum devlink_attr {
 	DEVLINK_ATTR_PARAM_RESET_DEFAULT,	/* flag */
 
 	DEVLINK_ATTR_INDEX,			/* uint */
+	DEVLINK_ATTR_RESOURCE_SCOPE_MASK,	/* u32 */
 
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
@@ -704,6 +705,16 @@ enum devlink_resource_unit {
 	DEVLINK_RESOURCE_UNIT_ENTRY,
 };
 
+enum devlink_resource_scope {
+	DEVLINK_RESOURCE_SCOPE_DEV_BIT,
+	DEVLINK_RESOURCE_SCOPE_PORT_BIT,
+};
+
+#define DEVLINK_RESOURCE_SCOPE_DEV \
+	_BITUL(DEVLINK_RESOURCE_SCOPE_DEV_BIT)
+#define DEVLINK_RESOURCE_SCOPE_PORT \
+	_BITUL(DEVLINK_RESOURCE_SCOPE_PORT_BIT)
+
 enum devlink_port_fn_attr_cap {
 	DEVLINK_PORT_FN_ATTR_CAP_ROCE_BIT,
 	DEVLINK_PORT_FN_ATTR_CAP_MIGRATABLE_BIT,
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index 9cc372d9ee41..81899786fd98 100644
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
+	[DEVLINK_ATTR_RESOURCE_SCOPE_MASK] = NLA_POLICY_MASK(NLA_U32, 0x3),
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
index bf5221fb3e64..3d2f42bc2fb5 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -398,11 +398,25 @@ devlink_nl_resource_dump_one(struct sk_buff *skb, struct devlink *devlink,
 			     struct netlink_callback *cb, int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
+	const struct genl_info *info = genl_info_dump(cb);
 	struct devlink_port *devlink_port;
+	struct nlattr *scope_attr = NULL;
 	unsigned long port_idx;
+	u32 scope = 0;
 	int err;
 
-	if (!state->port_ctx.index_valid) {
+	if (info->attrs && info->attrs[DEVLINK_ATTR_RESOURCE_SCOPE_MASK]) {
+		scope_attr = info->attrs[DEVLINK_ATTR_RESOURCE_SCOPE_MASK];
+		scope = nla_get_u32(scope_attr);
+		if (!scope) {
+			NL_SET_ERR_MSG_ATTR(info->extack, scope_attr,
+					    "empty resource scope selection");
+			return -EINVAL;
+		}
+	}
+
+	if (!state->port_ctx.index_valid &&
+	    (!scope || (scope & DEVLINK_RESOURCE_SCOPE_DEV))) {
 		err = devlink_resource_dump_fill_one(skb, devlink, NULL,
 						     cb, flags, &state->idx);
 		if (err)
@@ -410,6 +424,8 @@ devlink_nl_resource_dump_one(struct sk_buff *skb, struct devlink *devlink,
 		state->idx = 0;
 	}
 
+	if (scope && !(scope & DEVLINK_RESOURCE_SCOPE_PORT))
+		goto out;
 	/* Check in case port was removed between dump callbacks. */
 	if (state->port_ctx.index_valid &&
 	    !xa_load(&devlink->ports, state->port_ctx.index))
@@ -425,6 +441,7 @@ devlink_nl_resource_dump_one(struct sk_buff *skb, struct devlink *devlink,
 		}
 		state->idx = 0;
 	}
+out:
 	state->port_ctx.index_valid = false;
 	state->port_ctx.index = 0;
 	return 0;
-- 
2.44.0


