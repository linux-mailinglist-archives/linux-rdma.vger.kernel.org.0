Return-Path: <linux-rdma+bounces-17254-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLSHCxXIoGnImQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17254-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 23:24:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D613F1B05C6
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 23:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3CFC306786A
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 22:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9E13A1A4B;
	Thu, 26 Feb 2026 22:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cgdR1rvs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010041.outbound.protection.outlook.com [40.93.198.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6993612FE;
	Thu, 26 Feb 2026 22:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772144433; cv=fail; b=BQ4mvY/j7GLMuNlreuSpyBvo2Bhg7G3YpJzsKDyoM2f/X72ly8R8wRQ9W6kptBqX4/ra6A4/zDDnU+vntd1R+qNRqATzT8/5+gUJrJZe1+mMjowQ+xCrnp/AcQlQXO0Fk0gRiV2+Ng76mfAm9CWINBr+Yztd8EjoKkTlunTq7cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772144433; c=relaxed/simple;
	bh=nah+EFKV75B/4526ToydUmqqNZKPXIShDDrX4XybIRo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCkbp4GkSjympkRRCmISIlNp/CBanBw5dFgBSKUIOni3/Mz270tNAjrp2hWQ7WBwXPPbXpviM2p2VZmD6GRD+DugFYxhVQuzuKdmPc6lM3LF11LfWuUKqOO8Am6sJMSoq+e1r8NFa7almpdPdJzaH/F/gvO2G9Rlr1Xl0TnokNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cgdR1rvs; arc=fail smtp.client-ip=40.93.198.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gz77V7nPQlsOeKmltKpHzi11Jv+yq96DgN9Oe4mg/a2QRQ1ODfcZ9vtHuyB0AkIzlXZhJPso7Gs6DSNIiO5vHfne1/E7T0+NrLUDUq5D126MWrZr/z8X0Lpu7nCYoa6u5ug4VbvfmpvQQbBmkNcwGtslQy3GpmWjU42vLzXiQ+PYBD782c9LsLR/L4RmXvdSri/HZOmulG8PCe6x7YH4fZEXY11gsT5ePjGsajRPppjHrxCIHn7OkhmD0Fl7HECL75uPo/fiR7t1lBGj1HAcVLmGCHC85hERuhURLOx3pKShw0WnJD47Phe3tP7xteF9WPahVJsuosA+iiRnfLGuEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6tDMMEKE3c9dL06lT/WMIqQOKJ7J0tKLmuZqlPcDcc=;
 b=b5W5tZlbkAbEWblFQHC+3VwjmSbjPgQLnwa8tjdY3fLNmKCtBF7/vFoaFu5W9Y3o6ZRe3a9ZTbuUWBPRcaxnyGL54C3L71gmO3cWUIB9aFLoRoPmxKjUkFiCGgRI4y9HGD+7O50CmcT5JD7Jwbd/8fQMNG41RrSauwUAJ3568xwyzvqwNe9655Y31gG/PUHek16nv+/zjnE4KlM6Q3UCtAAd/bURe9k11pDuAXQ2MHLiqL66mxTAYMDeDI9AvwqiKKiw86KCSLQoWoesXL0ib9N9Mxi10MumR96Fh7d/B2QHNGCyaPcJjvfi+zs7S//v15YggAx/azllOPOM2K9CVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6tDMMEKE3c9dL06lT/WMIqQOKJ7J0tKLmuZqlPcDcc=;
 b=cgdR1rvsy2SCssfvWOm4q8kCCFmqaQqlG5OanrPpgSiLmlfDRqJs5nL+s4DCYpQkplbC7d3rxjXfiZc0o5bYUbjzk0qKt5FqFWu3/BIwDMNIc/tsdtwMKE27WH2wKq/37BasFjRi/8dnsJ7nta0+0r4b1jfj+sgkVsIe060PampwmEiNoGxztAIQM7Wa3CqIsWVjP/NRWjFEQLC8eBN/WTcw9gfm1QdF0F9XZAFLSXgSs09EPbvq4sBMQtjeRYHi3KbE/sXHGuJ+deIjtuWP7FHiRf+FEkpo2ZKbxELB5omeBN2Mt6iQRTvR+2VISIJT54AOgw8iBaY7SXnrtX7STw==
Received: from BN9PR03CA0227.namprd03.prod.outlook.com (2603:10b6:408:f8::22)
 by CH3PR12MB9022.namprd12.prod.outlook.com (2603:10b6:610:171::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 22:20:17 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::b1) by BN9PR03CA0227.outlook.office365.com
 (2603:10b6:408:f8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 22:19:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Thu, 26 Feb 2026 22:20:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 14:20:02 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 14:20:01 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 26
 Feb 2026 14:19:56 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>
Subject: [PATCH net-next V3 06/10] devlink: Add port resource netlink command
Date: Fri, 27 Feb 2026 00:19:12 +0200
Message-ID: <20260226221916.1800227-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260226221916.1800227-1-tariqt@nvidia.com>
References: <20260226221916.1800227-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|CH3PR12MB9022:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a9c359-5307-4ddd-c6ca-08de7585387f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	Ei2uld4UD3ix2hConVRw49j/TmKZBgRw+DIfi7Z6PR6xghe9kY1CKRg5fBeD484aHRlNwtmTJOK3k2g1/E82FavvySLrdYU41BAoaGQR7gNmY43pMMxM0RwzGQEGOyY1pdiP9CEjPIiJw7qrhJh89dKC2On/VmPukAqrkO1kLTmRn2oifu7aaaROQoI/maS2xERxygZITfMPyXACwrYYXKumBvWs4y2kj4xHpbP09S8VKxAXBtF/S0TdgS9fJOXTlVRxq+4O2gd/4k4fgxy+k0yheV9/mMOauI6ubDloyQLxfHYu44srpiSguSuJZFdaA2Nw4wYP79jACA9NqvAreEwGX3kWkBl7lVF3z0H2ZYCXwZiE5wzTL1VgrUt8CUFDAVV8vE0WrFuz9vwLWKf+7GB5HV8Ro2Or+WRk8iwEvE6TbBPWcYGOyZkI0fT3hUpmhUT60D5XJDNG9UeTY9WwMMadoA7MeMbnsi4BZ/aV/LePWZvooyX9/5ijvmRvMMgB6GtAjUk64yh3MlP7y0/3tYR31nx8i6soNm5zTXmSMVWS6A2Jm5D1WPkYDbQqva+UsEwqs4mrCgOgPdym5Dq2TehTZ9ErkKjfnhrp1D0iLAsBVC9SZhtnfQMRc9gW2+o4Nv+W+eL1aZzPgHZG/erGXit565qDe8iqgYjuimo9FMhg/vXp6KPNnDOAHyPZFlL5ujAl//3ZWlGeL8Am4gbJ0ugJo6GRtpILkrMTwuvN6WB4KPks7lqgwcWdj0FhA7bW8jdd/ykrIqsUga5HwAvMpI79VEexTtWbsO57FUk97eNfEUSE62pSLrNoNS3sQahfY1DZYX7UFPFUgI2T6uL0RA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	v9c3uUmbBiV+VVAYFPGuQjAUYvTZBAfEpsKtbsGGGw6uK222V9/A+OI4I7z9iV6Y+IMl7kAD0TlmeNF8xpZ2Qglc/FJAA2yQohBT2CX7y/fOxWipMiZNgHQ0mPiO/9jW75A3J0BXtmbAJwKWX6XFy+/g+r3Kyr8qn1L8uOr6gWtqnU/kTXMFcS+lmuzoMzmuNJ2nA3lTwlCwsdtTKr8VFI8VHfZ331aENY12PXHMJOHzc0M9RQ7ESofHVHg58as86j2ESVHsn0JGbv5yywyUixJT/fI7aCirSXpkcveZBv3tVaGeDqiFu5CFHmU3fTGNgytSAybnPvXkc3Ls6KyeuBGrwNsKuyZWOpBcts+oxohRcDDzL0vyjDxYvpx99e5NDszHC96UhvfbjK2fO7fWvPGpiRxuQ/KjEG9Cv0MGoWSxKIlLAXPD3kQad34b/4w/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 22:20:17.0282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a9c359-5307-4ddd-c6ca-08de7585387f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9022
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17254-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.979];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D613F1B05C6
X-Rspamd-Action: no action

From: Or Har-Toov <ohartoov@nvidia.com>

Add support for userspace to query resources registered on devlink
ports, allowing drivers to expose per-port resource limits and usage.

Example output:

  $ devlink port resource show
  pci/0000:03:00.0/196608:
    name max_SFs size 20 unit entry
  pci/0000:03:00.1/262144:
    name max_SFs size 20 unit entry

  $ devlink port resource show pci/0000:03:00.0/196608
  pci/0000:03:00.0/196608:
    name max_SFs size 20 unit entry

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 23 ++++++
 include/uapi/linux/devlink.h             |  3 +
 net/devlink/devl_internal.h              |  4 ++
 net/devlink/netlink.c                    |  2 +-
 net/devlink/netlink_gen.c                | 32 ++++++++-
 net/devlink/netlink_gen.h                |  6 +-
 net/devlink/resource.c                   | 90 +++++++++++++++++++++++-
 7 files changed, 155 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index ee679ac14261..9b813f5fc51c 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -2340,3 +2340,26 @@ operations:
             - bus-name
             - dev-name
             - port-index
+
+    -
+      name: port-resource-get
+      doc: Get port resources.
+      attribute-set: devlink
+      dont-validate: [strict]
+      do:
+        pre: devlink-nl-pre-doit-port
+        post: devlink-nl-post-doit
+        request:
+          value: 85
+          attributes: *port-id-attrs
+        reply: &port-resource-get-reply
+          value: 85
+          attributes:
+            - bus-name
+            - dev-name
+            - port-index
+            - resource-list
+      dump:
+        request:
+          attributes: *dev-id-attrs
+        reply: *port-resource-get-reply
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index e7d6b6d13470..1cabd1f6cba0 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -141,6 +141,9 @@ enum devlink_command {
 
 	DEVLINK_CMD_NOTIFY_FILTER_SET,
 
+	DEVLINK_CMD_PORT_RESOURCE_GET,	/* can dump */
+	DEVLINK_CMD_PORT_RESOURCE_SET,
+
 	/* add new commands above here */
 	__DEVLINK_CMD_MAX,
 	DEVLINK_CMD_MAX = __DEVLINK_CMD_MAX - 1
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 1377864383bc..ddf855bc893f 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -148,6 +148,10 @@ struct devlink_nl_dump_state {
 		struct {
 			u64 dump_ts;
 		};
+		/* DEVLINK_CMD_PORT_RESOURCE_GET - dump */
+		struct {
+			unsigned long port_index;
+		};
 	};
 };
 
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 593605c1b1ef..c78c31779622 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -367,7 +367,7 @@ struct genl_family devlink_nl_family __ro_after_init = {
 	.module		= THIS_MODULE,
 	.split_ops	= devlink_nl_ops,
 	.n_split_ops	= ARRAY_SIZE(devlink_nl_ops),
-	.resv_start_op	= DEVLINK_CMD_SELFTESTS_RUN + 1,
+	.resv_start_op	= DEVLINK_CMD_PORT_RESOURCE_GET + 1,
 	.mcgrps		= devlink_nl_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(devlink_nl_mcgrps),
 	.sock_priv_size		= sizeof(struct devlink_nl_sock_priv),
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index d6667a3f87a0..a235748d0688 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -610,8 +610,21 @@ static const struct nla_policy devlink_notify_filter_set_nl_policy[DEVLINK_ATTR_
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 };
 
+/* DEVLINK_CMD_PORT_RESOURCE_GET - do */
+static const struct nla_policy devlink_port_resource_get_do_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
+};
+
+/* DEVLINK_CMD_PORT_RESOURCE_GET - dump */
+static const struct nla_policy devlink_port_resource_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
 /* Ops table for devlink */
-const struct genl_split_ops devlink_nl_ops[75] = {
+const struct genl_split_ops devlink_nl_ops[77] = {
 	{
 		.cmd		= DEVLINK_CMD_GET,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
@@ -1297,4 +1310,21 @@ const struct genl_split_ops devlink_nl_ops[75] = {
 		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= DEVLINK_CMD_PORT_RESOURCE_GET,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.pre_doit	= devlink_nl_pre_doit_port,
+		.doit		= devlink_nl_port_resource_get_doit,
+		.post_doit	= devlink_nl_post_doit,
+		.policy		= devlink_port_resource_get_do_nl_policy,
+		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DEVLINK_CMD_PORT_RESOURCE_GET,
+		.dumpit		= devlink_nl_port_resource_get_dumpit,
+		.policy		= devlink_port_resource_get_dump_nl_policy,
+		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
 };
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index d79f6a0888f6..cab9d30e913a 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -18,7 +18,7 @@ extern const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_RATE_TC_
 extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
 
 /* Ops table for devlink */
-extern const struct genl_split_ops devlink_nl_ops[75];
+extern const struct genl_split_ops devlink_nl_ops[77];
 
 int devlink_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 			struct genl_info *info);
@@ -148,5 +148,9 @@ int devlink_nl_selftests_get_dumpit(struct sk_buff *skb,
 int devlink_nl_selftests_run_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
 				      struct genl_info *info);
+int devlink_nl_port_resource_get_doit(struct sk_buff *skb,
+				      struct genl_info *info);
+int devlink_nl_port_resource_get_dumpit(struct sk_buff *skb,
+					struct netlink_callback *cb);
 
 #endif /* _LINUX_DEVLINK_GEN_H */
diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index 71f00e580f59..0a1d1610ff67 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -252,6 +252,7 @@ static int __devlink_resource_fill(struct genl_info *info,
 				   struct list_head *resource_list_head,
 				   enum devlink_command cmd, int flags)
 {
+	struct devlink_port *devlink_port = info->user_ptr[1];
 	struct devlink *devlink = info->user_ptr[0];
 	struct nlattr *resources_attr;
 	struct sk_buff *skb = NULL;
@@ -279,9 +280,13 @@ static int __devlink_resource_fill(struct genl_info *info,
 
 	if (devlink_nl_put_handle(skb, devlink))
 		goto nla_put_failure;
+	if (devlink_port) {
+		if (nla_put_u32(skb, DEVLINK_ATTR_PORT_INDEX,
+				devlink_port->index))
+			goto nla_put_failure;
+	}
 
-	resources_attr = nla_nest_start_noflag(skb,
-					       DEVLINK_ATTR_RESOURCE_LIST);
+	resources_attr = nla_nest_start_noflag(skb, DEVLINK_ATTR_RESOURCE_LIST);
 	if (!resources_attr)
 		goto nla_put_failure;
 
@@ -656,3 +661,84 @@ void devl_port_resources_unregister(struct devlink_port *devlink_port)
 				    &devlink_port->resource_list);
 }
 EXPORT_SYMBOL_GPL(devl_port_resources_unregister);
+
+int devlink_nl_port_resource_get_doit(struct sk_buff *skb,
+				      struct genl_info *info)
+{
+	struct devlink_port *devlink_port = info->user_ptr[1];
+
+	return __devlink_resource_fill(info, &devlink_port->resource_list,
+				       DEVLINK_CMD_PORT_RESOURCE_GET, 0);
+}
+
+static int
+devlink_nl_port_resource_get_dump_one(struct sk_buff *skb,
+				      struct devlink *devlink,
+				      struct netlink_callback *cb, int flags)
+{
+	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
+	struct devlink_port *devlink_port;
+	struct list_head *resource_list;
+	struct nlattr *resources_attr;
+	int resource_idx, start_idx;
+	unsigned long port_idx;
+	void *hdr;
+	int err;
+
+	xa_for_each_start(&devlink->ports, port_idx, devlink_port,
+			  state->port_index) {
+		if (list_empty(&devlink_port->resource_list))
+			continue;
+
+		resource_idx = (port_idx == state->port_index) ? state->idx : 0;
+		start_idx = resource_idx;
+		err = -EMSGSIZE;
+
+		hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
+				  cb->nlh->nlmsg_seq, &devlink_nl_family, flags,
+				  DEVLINK_CMD_PORT_RESOURCE_GET);
+		if (!hdr)
+			return err;
+
+		if (devlink_nl_put_handle(skb, devlink) ||
+		    nla_put_u32(skb, DEVLINK_ATTR_PORT_INDEX,
+				devlink_port->index))
+			goto nla_put_failure;
+
+		resources_attr =
+			nla_nest_start_noflag(skb, DEVLINK_ATTR_RESOURCE_LIST);
+		if (!resources_attr)
+			goto nla_put_failure;
+
+		resource_list = &devlink_port->resource_list;
+		err = devlink_resource_list_fill(skb, devlink, resource_list,
+						 &resource_idx);
+		if (err) {
+			state->port_index = port_idx;
+			state->idx = resource_idx;
+			if (resource_idx == start_idx)
+				goto nla_put_failure_unwind;
+			nla_nest_end(skb, resources_attr);
+			genlmsg_end(skb, hdr);
+			return err;
+		}
+		nla_nest_end(skb, resources_attr);
+		genlmsg_end(skb, hdr);
+	}
+	state->port_index = 0;
+	state->idx = 0;
+	return 0;
+
+nla_put_failure_unwind:
+	nla_nest_cancel(skb, resources_attr);
+nla_put_failure:
+	genlmsg_cancel(skb, hdr);
+	return err;
+}
+
+int devlink_nl_port_resource_get_dumpit(struct sk_buff *skb,
+					struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb,
+				 devlink_nl_port_resource_get_dump_one);
+}
-- 
2.44.0


