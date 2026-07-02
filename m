Return-Path: <linux-rdma+bounces-22684-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zUMyA2xLRmrnNwsAu9opvQ
	(envelope-from <linux-rdma+bounces-22684-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 13:28:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFBA6F6B2E
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 13:28:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="AAR/+Y/R";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22684-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22684-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA6E2313A84C
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 11:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAF64189C4;
	Thu,  2 Jul 2026 11:19:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012020.outbound.protection.outlook.com [52.101.48.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3C84189A2;
	Thu,  2 Jul 2026 11:19:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782991158; cv=fail; b=E0AGOKGgD8XkAYwgHLnWMohlLFX5dc6tcXMpFIufE/+vg7UuKLpdYgTU8ZT/vNHjsh59KOtqimhZSXIzziu9iC6lHBnsh0eRbX7IGzXJH8h/OD9YyNEUP8sNRAJ34X7PO+nXlIjPf07ftjmQIy76rhDqK1AKWot3+4sJofMgHOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782991158; c=relaxed/simple;
	bh=cq1mzWCUR+LNr0PhjE4WVg//32tSzb4dEj1F7GFkals=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GXq5WexRyNSjyGOk8w0rifd/51g5/JzjklF92lwdGLQ+XocLlDEotCKY7PBFVfhVnUo0FAMf49A0tFO8uaykkntSXa2qs6aevRCqCahJaN2+SZrgoDg2yklMvWRL6+6VhRcXu1v2wnVprm2tS3P/vjxeQN2F7Xb/H4CLzDzsA70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AAR/+Y/R; arc=fail smtp.client-ip=52.101.48.20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7oCoUbWEuCg2IlMzBKlS7NS5zHq2Rt+YWCt50AeLMguxFWzivjaR6JoUGs5U9d+py6WjiykJbOWlW3k8b3t+5SEBbhicfBYDwUKcHjVloEcYlXnsDWVBiqgkBdqKUW3efAy8ufCjGyG9xwR4LE+gi94+RyccagsoW2xd3/upquBdgXYmytUSxSFxCBvFSRg+ppiux+wWkaSHXclKLp7nFwnQRAXhqKvHb+mUqcdKdR4FTwyjx0jaXQBNqeme/27qLwtzgktig9/Q+51E9nwc5ZF55SKtcJiM/1Ubu3/AisJfHZ7iQf1tp9mJtFYq6u7sYdcEpm1B7TBMg6SZlMC9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQNqTgDinXUTk4yyH2luKGTuA50HU7vexB7Qe6aV7LA=;
 b=JKBLAzWhUYx+NAspB/hs969RQVp0HQZvAl9kn0poRZmTWesxyxZm8S+q1J7udoZ9BkmSsLgZLFCOGmyxIxdAqJqsWnZC9zBAAlGID0LfSOFBBBvNlHlBmGeYoaJ5NI2FMHu6cR7vVEJeqOzf0NLjrGRWn1O3H6tYkxBDovFovuYS5WU8sRoJXBCG+eKGOlZ7wm0cmtKnvrffS6k2LQtm6rXNKWUzmTTPPYCWfbCdQNiZWQh6UCry+acdLhX9Ix00GEDSl5f+88bsWrCff9OyUj34MfP2Ch0PhvA61f0Oy6Wv0FHbro7phEJC1N81/2E/RIckQw+GIcIr0vhLLaYVMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQNqTgDinXUTk4yyH2luKGTuA50HU7vexB7Qe6aV7LA=;
 b=AAR/+Y/R3YZuerLk1soahfs58NF8UVcILbzyr3gPH4hmMNO+RMU+FaZ1w/y8RktbT6Tg+zEoyeUYB8qcfx/8v9tBM5edpQXf+ePC6wrs9OaR64zoT84sgzDkaJngkmbAlXhprmAvhpCvBqyCva4+UMdi8Ulk1aUOjEniQfWPK1xx7ZsC0rhqIzxhRq9v1iaohy1ypSJEViWOdgbvSyvSHRlPVmR03YNh95ZX+aI3IMLYxG+V0vE098MmlzLjYngzBDaQY6aaA8za+l2uIltPJ6ngwlunASjEXHOeY3g0bWQP2wJ6SM/YwOnP/xCjrxda97n73YsMnNVfpV6ajsxecw==
Received: from SA0PR11CA0046.namprd11.prod.outlook.com (2603:10b6:806:d0::21)
 by CY5PR12MB6599.namprd12.prod.outlook.com (2603:10b6:930:41::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 11:19:05 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:d0:cafe::28) by SA0PR11CA0046.outlook.office365.com
 (2603:10b6:806:d0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Thu, 2
 Jul 2026 11:19:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 11:19:04 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 04:18:42 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 04:18:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 2 Jul
 2026 04:18:35 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Adithya Jayachandran <ajayachandra@nvidia.com>, Chris Mi <cmi@nvidia.com>,
	Daniel Jurgens <danielj@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, "Jonathan
 Corbet" <corbet@lwn.net>, Kees Cook <kees@kernel.org>, Leon Romanovsky
	<leon@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>, Parav Pandit <parav@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Shay Drori <shayd@nvidia.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 1/2] devlink: print controller prefix for non-zero controller
Date: Thu, 2 Jul 2026 14:17:25 +0300
Message-ID: <20260702111726.816985-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260702111726.816985-1-tariqt@nvidia.com>
References: <20260702111726.816985-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|CY5PR12MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b38b78c-c748-4769-9e1f-08ded82bba0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|82310400026|36860700016|1800799024|18002099003|56012099006|11063799006|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	N0Wc2Wk+FZLtuUtdLyT1lQmxFkiByA+AfF2uA4iBKwEJlZ9o77T5jViiz+TRdP/b4aIhliCpz1JGw+dAy5S+ZLHf8aKDDImNKIhFUwpC/FTTTR3i7+YahMsaGF9I3EOFzcdWCy8I+WYaou3XbKz+juXlefY8onXDi9S0L3mCQ8BUoYhm1A8LyV6eqtII6tEQbD1VjkypBQ7kbbkTPySm0/f7Ul4ms8ikCZ4BrTG3/LX5eS10yKzqPuJcqXYx3WX+erSMR43Prwp+iKpgzAcFwUtJe8VkCiPHjID1tV9RRSRsyCLLO6Nncbn6/Jr0qB/4GdmSy/ZoXhwbK0GwUsNB8LWmoYri4MfdR8mOuUSjvVqx1JiOvxv9tzoD6Xoc2fY1q3Vx8DNeV77Mzp6GYmnbjv2c7Mezinu+iJNO2DbxLNfBnD4/uPqXD1RWQBjiKymDQEwE3knOjlGiFJZCb8G8LO837B1o3dAwS8REdlEPnTuaByWMYh0lO9esDGbR3El1NKr5OPvN3avNuhzw3GLKCJ4AmkqRwtavtvCUt69+LJaTUQyN2jtR0WKSAIEyATCtWRuoZxUzP1/9zd/ETaLTW9VpEQ5agaYybKV9MSOoKMmhoZdWB/vYhjDiiNqnoC8pV278HBXl1KBby/5q9IQ9h73t19Z1yN/o59hnDKHIbCxdeGvJMaIKlps4fxXEmEJHpsNMo58qfIz3RY8FU+QWAA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(18002099003)(56012099006)(11063799006)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fc6frH4Xs1UJCTYh7xh3bYJYz+HVcXWuwL0vE3gGZ8wD06gqf8auWmP34Np3p3NRTAS+NQ3elxGk5V25u0ehxwpVCXm9GulTd7ub4GnSYh+c/UcHNnQMlPnoUDDKxg2tLOhnT1GhgRu7l8eQOqLu9DDNMKWvBu1UKVIIwSQC9Cc2Xxiyn3tUbF46PIB+At3WtJcL322oqptfXCuwKQR2dIRkmTFtr45EAKUOgahMqoJeH5NB73rwHR+bChVJ7y8uLViHJ5JNTn6eGHrM54QvZUQ0/NWk8ufy83yzb6h/J/2UbI9TvK6Uh9KjjxkCpYt9HqCq8m14Xc7ct+CSPGwSjv4H73oc4WMW9qKvhjCF7NeHjgsGjO4G2sfVgX8jO3XSycDl92IM0rFrGVyVtnL7XBl0xxZbhu/bpODXlFaRGeu6DdGA6X7QNopM1fBqt5CQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 11:19:04.8156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b38b78c-c748-4769-9e1f-08ded82bba0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6599
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22684-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:ajayachandra@nvidia.com,m:cmi@nvidia.com,m:danielj@nvidia.com,m:jiri@resnulli.us,m:corbet@lwn.net,m:kees@kernel.org,m:leon@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:moshe@nvidia.com,m:ohartoov@nvidia.com,m:parav@nvidia.com,m:saeedm@nvidia.com,m:shayd@nvidia.com,m:skhan@linuxfoundation.org,m:horms@kernel.org,m:tariqt@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CFBA6F6B2E

From: Moshe Shemesh <moshe@nvidia.com>

The controller prefix (c<N>) in phys_port_name is currently restricted
to external host controllers. This layout sufficed when DPUs only had a
single local controller and one or more external host controllers.

However, newer devices can have multiple controllers within the DPU
itself, even within a single host environment. To support these
topologies, allow drivers to report the controller number regardless of
the "external" flag status. Any non-zero controller number will now be
explicitly reported, even for single-host or local DPU controllers.
Existing ports with controller=0 are unaffected.

Update documentation and kdoc to clarify that a non-zero controller
number does not require the external flag to be set.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/networking/devlink/devlink-port.rst | 9 +++++++++
 include/net/devlink.h                             | 6 +++---
 net/devlink/port.c                                | 6 +++---
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/devlink/devlink-port.rst b/Documentation/networking/devlink/devlink-port.rst
index 9374ebe70f48..4211322d488b 100644
--- a/Documentation/networking/devlink/devlink-port.rst
+++ b/Documentation/networking/devlink/devlink-port.rst
@@ -107,6 +107,15 @@ doesn't have the eswitch. Local controller (identified by controller number = 0)
 has the eswitch. The Devlink instance on the local controller has eswitch
 devlink ports for both the controllers.
 
+A non-zero controller number may also be used for ports that are not external.
+For example, a SmartNIC may have additional local PCI physical functions
+that are managed by the eswitch but are not on an external host. These
+ports use a non-zero controller number to distinguish them from the eswitch
+manager's own functions, while the external flag remains unset.
+
+The ``phys_port_name`` includes the controller prefix (``c<controller_num>``)
+whenever the controller number is non-zero, regardless of the external flag.
+
 Function configuration
 ======================
 
diff --git a/include/net/devlink.h b/include/net/devlink.h
index dd546dbd57cf..35bfdceeab9f 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -36,7 +36,7 @@ struct devlink_port_phys_attrs {
  * struct devlink_port_pci_pf_attrs - devlink port's PCI PF attributes
  * @controller: Associated controller number
  * @pf: associated PCI function number for the devlink port instance
- * @external: when set, indicates if a port is for an external controller
+ * @external: when set, indicates if a port is for an external host controller.
  */
 struct devlink_port_pci_pf_attrs {
 	u32 controller;
@@ -50,7 +50,7 @@ struct devlink_port_pci_pf_attrs {
  * @pf: associated PCI function number for the devlink port instance
  * @vf: associated PCI VF number of a PF for the devlink port instance;
  *	VF number starts from 0 for the first PCI virtual function
- * @external: when set, indicates if a port is for an external controller
+ * @external: when set, indicates if a port is for an external host controller.
  */
 struct devlink_port_pci_vf_attrs {
 	u32 controller;
@@ -64,7 +64,7 @@ struct devlink_port_pci_vf_attrs {
  * @controller: Associated controller number
  * @sf: associated SF number of a PF for the devlink port instance
  * @pf: associated PCI function number for the devlink port instance
- * @external: when set, indicates if a port is for an external controller
+ * @external: when set, indicates if a port is for an external host controller.
  */
 struct devlink_port_pci_sf_attrs {
 	u32 controller;
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 485029d43428..bde6d4125725 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -1529,7 +1529,7 @@ static int __devlink_port_phys_port_name_get(struct devlink_port *devlink_port,
 		WARN_ON(1);
 		return -EINVAL;
 	case DEVLINK_PORT_FLAVOUR_PCI_PF:
-		if (attrs->pci_pf.external) {
+		if (attrs->pci_pf.external || attrs->pci_pf.controller) {
 			n = snprintf(name, len, "c%u", attrs->pci_pf.controller);
 			if (n >= len)
 				return -EINVAL;
@@ -1539,7 +1539,7 @@ static int __devlink_port_phys_port_name_get(struct devlink_port *devlink_port,
 		n = snprintf(name, len, "pf%u", attrs->pci_pf.pf);
 		break;
 	case DEVLINK_PORT_FLAVOUR_PCI_VF:
-		if (attrs->pci_vf.external) {
+		if (attrs->pci_vf.external || attrs->pci_vf.controller) {
 			n = snprintf(name, len, "c%u", attrs->pci_vf.controller);
 			if (n >= len)
 				return -EINVAL;
@@ -1550,7 +1550,7 @@ static int __devlink_port_phys_port_name_get(struct devlink_port *devlink_port,
 			     attrs->pci_vf.pf, attrs->pci_vf.vf);
 		break;
 	case DEVLINK_PORT_FLAVOUR_PCI_SF:
-		if (attrs->pci_sf.external) {
+		if (attrs->pci_sf.external || attrs->pci_sf.controller) {
 			n = snprintf(name, len, "c%u", attrs->pci_sf.controller);
 			if (n >= len)
 				return -EINVAL;
-- 
2.44.0


