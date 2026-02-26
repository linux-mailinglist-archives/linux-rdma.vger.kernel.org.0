Return-Path: <linux-rdma+bounces-17249-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJWEDiLHoGnImQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17249-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 23:20:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A821B0490
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 23:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3DC583013240
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 22:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6403A0EAD;
	Thu, 26 Feb 2026 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LajsgwMD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013046.outbound.protection.outlook.com [40.93.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5612839C654;
	Thu, 26 Feb 2026 22:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772144406; cv=fail; b=SWWejFOBax6EpIpDas88tvc1f5+FMSanF0WwAeuG4F2cspMx6xfbDxzXYVbYqkj88ZQH+z0+VzUwgH9T+VLh579Lb9scgI/ordNHbHeJV0Se6/uOZg5U7NCK7o8JZtaRjVefAqsq87r5asg9RE0KoVoWp0cRRPN5T5bphGITV4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772144406; c=relaxed/simple;
	bh=IG+c9QczUwmOvC23bLi+XBh+0EmuDtbCTLqnHR7nC2U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onqJrqLDMFasa7FsC0Pa1/M4MYV5GEDwq+iCQiJeyrkspBUqyAjX7lZdt6oBdQxNwWP55kXxara/iuJIyPgK/z5jRshvr2RbD4XAmf5vsAuYSXE01aSAXL3SAcB+1zo6pb0beSoKW7UiXN/OZ7V2MBnuyIU4+5vAGdBKJtuVl/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LajsgwMD; arc=fail smtp.client-ip=40.93.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZNxpTJnxw1dElO1ArQNtes57uho9k6Q1yJWLjboc3MktAGuA1rI4IdRaFvhpAMjM4CW/a/52AkHQfw58Bv8Lucvyra2msQapmSO5Y8s0EfnEwPeImnexPLRkVK4YeFBO1ZdnSCsa6hcX6oxKtYSjG/MOaCAn6+B/mZvqEr+ussdD3CGg6XdEUVlzJ9hXNPMtFWRvYttw8d/t/fUpXvjOzjsTtqA976LS4658Dzp3ugDmz7ak96ss1y9AFQ1gv4Hnvl0BrVustgjijSpm9nch1OnPP8i3Dyk/MYK880pLacJi0JL9m46KUs94CtWIt/gf4ATuGjL5zRc95ZeQugzUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7bn1vbGoUIZdVJwsRh/JSmFv0Spt2IrSJdDCry+HGU=;
 b=vT5dSO/Cwk+o2pW3916qmbKNAfmDhWogVNPykIzlDD0PtrIyP/L78vUoz0tlxn7oR/x7p9DOtJWLs3KTX2uXQgHcBMYhNUUbiynBaSveENCeMbgHHP1XgJnwI9UA7vYg1w+rfDJTpjfwfMw7VlqhcfGS8uFmHcRZpDowsL67FTHzoIy4jcwqnmasU/5tKA758Fljm+KZ8iFrU0kVhzUBkooDcjDGEUf7Zs4Wqng9gI3iu2WvQFn8rS/OLgx1hf4olaxY7zSOP4J3943Giu58YBl6abTphk6r5pXI1KlqiSAXhSBXfZ+es2Xj65ja4f7tmQN4PAr5YxlVpGcoOQFM+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7bn1vbGoUIZdVJwsRh/JSmFv0Spt2IrSJdDCry+HGU=;
 b=LajsgwMD5o5W69eUSlxK7rzUb0IpmnA0Ok9UngJ9JvOS8wcY6isHLgXDOQjVkbxhPUK0jI1IT4Z/ZN+MuT/4i4sM0f6Eh3c+mTtcCDoi5FAo0CnBEeIi6hycRPsFQ6JcpmfpDQq7Awc7nAppRii5EJdQh6/JKINiw834gqmwM9LFfV7dh1jR8vbiV8Jh4qsKK80idNYRHcHZeV8VasxfSFvbHkz1GXjxuQlhfLrcxVKNzdwKcOmECMlf8MW46DmG3m+EMgUqvCoK82gv8LfLUkYBX6S7lPQdr+DNlgt/hUWQm71j6e5HKF19XD8Y9C2OBwGF4fDVMxzawW/53KRDzA==
Received: from BN9PR03CA0952.namprd03.prod.outlook.com (2603:10b6:408:108::27)
 by DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 22:19:55 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::42) by BN9PR03CA0952.outlook.office365.com
 (2603:10b6:408:108::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 22:19:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Thu, 26 Feb 2026 22:19:55 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 14:19:33 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 14:19:33 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 26
 Feb 2026 14:19:28 -0800
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
Subject: [PATCH net-next V3 01/10] devlink: Add dump support for device-level resources
Date: Fri, 27 Feb 2026 00:19:07 +0200
Message-ID: <20260226221916.1800227-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|DS0PR12MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: c8fb1cca-4487-4e88-e374-08de75852b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	+IbqadQmRo7j1kmoDuvNi2yn/l+alsqFBSlEpUMei0FBhQg+fb7dorBCD6E31X19Rr4oqd7PgyAMskdvRl+4XHAK994LNYsdb1pXldqfal/70rIxd53epilF+eQ1kwC9ZQQxo1v35IPmzc6Lpij1UUWqAoCIJgTAGlRwDWGtfjhomJCk/qGz+91J5NS427kZ+QjyILsFQKxyORGyZI41AFktTpW0aSKWsuM4R9ncg3+AGqOWplh23U/BAkRoa7oBMZLC2IxqxUBDjjOHpqmgcmyITU7/kPYCQQxpumpYGDFhBvRzMKXomnNDjPJceQyxyx8hq8kB/E3yJgb1VN+oeyg+CH9n39paLNn7BUAaOKW7Qw5B51sfez+sW0M7ut8Pfa9Oalgh1k+V1SzYPWHUDixFvx+kAydjrKvHYkTPq0S4SRXYta3Sk+LMA0Kbsmq0e6tpjn3MAQCAqPJ3StSNd/+Go/kk6yxbEf4yitHpNMCmdO3JCnMwxH1zU0m1Oq9iDFxGbVFOWp5lsXxfd6VBHZdjkXIMZMD4Mo4zv3diKW5v8JFql7swCwmA9aMOobfSgy6eBcmxjgK70vixBs88DAHLshFgTEgDj/IRbwm4ONI+fZazAxTWYapgMr7zxO1crKJAv177gCSUL4w3K8REfwj8H+eoJmUhcmmfUoqbAEr6DUHMFk99PJUItDQ24mNeJgBdPIu3SS4amq6ePBgZgTu3CH+q+MRHqEnHQXYk1IjBWv40ucy5dNLxeLteCU1zEypYZP1hvvc/2r5Y56FfPRYPjpnDuYNGZrBue4jKOu6WlrDoVc5rapNppvJTOlRH91Z/2bDB6w0yTmpdV2HIkA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	izeW/an2kQu1j6G/A4L/eoQQkpILk8EL/+KR8BCKQevbacT6yxxeaZAE7q9sM5XQyjzuykqeRj4EzfMmDzatWA+6aTZeEia+N+HMrw0SXp8VtV+GfGJ41k7k/QNyWf6M6QbWgrV+YsjBrU1jY4zBdvhueZcXHaokRHhHAcFVO4e7sCm038N7XYHV4K1hQjgmwW3xIAIK9pK+3D1odttcXWCS/pkV7qF6eH8j4TaCJkEmOOByhAojZ68IV2q1BSGSOR7ONMOdiTxSFdqvZMjo5Mb4xS9QJzxAeZgUYNlvo0LlPfT18Ddbz2ST8KrBrr2tsN9KgwdKXjmsLPF38zY+6tbxNJ4uIp5T0/g+qECuC63iCWR3YzTeFnsEqiGUdV+A/yPJ+k632uDPePCUDKcRJ3AuNCHgRHKDI9i/5ccRMnTWEma81F0fJ3HejUHimcPn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 22:19:55.1540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fb1cca-4487-4e88-e374-08de75852b74
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17249-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.978];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 21A821B0490
X-Rspamd-Action: no action

From: Or Har-Toov <ohartoov@nvidia.com>

Add dumpit handler for resource-dump command to iterate over all devlink
devices and show their resources. This aligns the device-level resource
command with the port-level resource command that will be added in next
patches.

  $ devlink resource show
  pci/0000:08:00.0:
    name local_max_SFs size 508 unit entry
    name external_max_SFs size 508 unit entry
  pci/0000:08:00.1:
    name local_max_SFs size 508 unit entry
    name external_max_SFs size 508 unit entry

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml |  6 +-
 net/devlink/netlink_gen.c                | 19 ++++-
 net/devlink/netlink_gen.h                |  4 +-
 net/devlink/resource.c                   | 99 ++++++++++++++++++++----
 4 files changed, 109 insertions(+), 19 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 837112da6738..ee679ac14261 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -1733,12 +1733,16 @@ operations:
           attributes:
             - bus-name
             - dev-name
-        reply:
+        reply: &resource-dump-reply
           value: 36
           attributes:
             - bus-name
             - dev-name
             - resource-list
+      dump:
+        request:
+          attributes: *dev-id-attrs
+        reply: *resource-dump-reply
 
     -
       name: reload
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index f4c61c2b4f22..d6667a3f87a0 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -272,7 +272,13 @@ static const struct nla_policy devlink_resource_set_nl_policy[DEVLINK_ATTR_RESOU
 };
 
 /* DEVLINK_CMD_RESOURCE_DUMP - do */
-static const struct nla_policy devlink_resource_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_resource_dump_do_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
+/* DEVLINK_CMD_RESOURCE_DUMP - dump */
+static const struct nla_policy devlink_resource_dump_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 };
@@ -605,7 +611,7 @@ static const struct nla_policy devlink_notify_filter_set_nl_policy[DEVLINK_ATTR_
 };
 
 /* Ops table for devlink */
-const struct genl_split_ops devlink_nl_ops[74] = {
+const struct genl_split_ops devlink_nl_ops[75] = {
 	{
 		.cmd		= DEVLINK_CMD_GET,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
@@ -883,10 +889,17 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.pre_doit	= devlink_nl_pre_doit,
 		.doit		= devlink_nl_resource_dump_doit,
 		.post_doit	= devlink_nl_post_doit,
-		.policy		= devlink_resource_dump_nl_policy,
+		.policy		= devlink_resource_dump_do_nl_policy,
 		.maxattr	= DEVLINK_ATTR_DEV_NAME,
 		.flags		= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= DEVLINK_CMD_RESOURCE_DUMP,
+		.dumpit		= devlink_nl_resource_dump_dumpit,
+		.policy		= devlink_resource_dump_dump_nl_policy,
+		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
 	{
 		.cmd		= DEVLINK_CMD_RELOAD,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index 2817d53a0eba..d79f6a0888f6 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -18,7 +18,7 @@ extern const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_RATE_TC_
 extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
 
 /* Ops table for devlink */
-extern const struct genl_split_ops devlink_nl_ops[74];
+extern const struct genl_split_ops devlink_nl_ops[75];
 
 int devlink_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 			struct genl_info *info);
@@ -80,6 +80,8 @@ int devlink_nl_dpipe_table_counters_set_doit(struct sk_buff *skb,
 					     struct genl_info *info);
 int devlink_nl_resource_set_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_resource_dump_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_resource_dump_dumpit(struct sk_buff *skb,
+				    struct netlink_callback *cb);
 int devlink_nl_reload_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_param_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_param_get_dumpit(struct sk_buff *skb,
diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index 2d6324f3d91f..5131875482ec 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -213,21 +213,43 @@ static int devlink_resource_put(struct devlink *devlink, struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
+static int devlink_resource_list_fill(struct sk_buff *skb,
+				      struct devlink *devlink,
+				      int *idx)
+{
+	struct devlink_resource *resource;
+	int i = 0;
+	int err;
+
+	list_for_each_entry(resource, &devlink->resource_list, list) {
+		if (i < *idx) {
+			i++;
+			continue;
+		}
+		err = devlink_resource_put(devlink, skb, resource);
+		if (err) {
+			*idx = i;
+			return err;
+		}
+		i++;
+	}
+	*idx = 0;
+	return 0;
+}
+
 static int devlink_resource_fill(struct genl_info *info,
 				 enum devlink_command cmd, int flags)
 {
 	struct devlink *devlink = info->user_ptr[0];
-	struct devlink_resource *resource;
 	struct nlattr *resources_attr;
 	struct sk_buff *skb = NULL;
 	struct nlmsghdr *nlh;
 	bool incomplete;
+	int start_idx;
 	void *hdr;
-	int i;
+	int i = 0;
 	int err;
 
-	resource = list_first_entry(&devlink->resource_list,
-				    struct devlink_resource, list);
 start_again:
 	err = devlink_nl_msg_reply_and_new(&skb, info);
 	if (err)
@@ -249,16 +271,12 @@ static int devlink_resource_fill(struct genl_info *info,
 		goto nla_put_failure;
 
 	incomplete = false;
-	i = 0;
-	list_for_each_entry_from(resource, &devlink->resource_list, list) {
-		err = devlink_resource_put(devlink, skb, resource);
-		if (err) {
-			if (!i)
-				goto err_resource_put;
-			incomplete = true;
-			break;
-		}
-		i++;
+	start_idx = i;
+	err = devlink_resource_list_fill(skb, devlink, &i);
+	if (err) {
+		if (i == start_idx)
+			goto err_resource_put;
+		incomplete = true;
 	}
 	nla_nest_end(skb, resources_attr);
 	genlmsg_end(skb, hdr);
@@ -292,6 +310,59 @@ int devlink_nl_resource_dump_doit(struct sk_buff *skb, struct genl_info *info)
 	return devlink_resource_fill(info, DEVLINK_CMD_RESOURCE_DUMP, 0);
 }
 
+static int
+devlink_nl_resource_dump_one(struct sk_buff *skb, struct devlink *devlink,
+			     struct netlink_callback *cb, int flags)
+{
+	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
+	struct nlattr *resources_attr;
+	int start_idx = state->idx;
+	void *hdr;
+	int err;
+
+	if (list_empty(&devlink->resource_list))
+		return 0;
+
+	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			  &devlink_nl_family, flags, DEVLINK_CMD_RESOURCE_DUMP);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	err = devlink_nl_put_handle(skb, devlink);
+	if (err)
+		goto nla_put_failure;
+
+	resources_attr = nla_nest_start_noflag(skb, DEVLINK_ATTR_RESOURCE_LIST);
+	if (!resources_attr) {
+		err = -EMSGSIZE;
+		goto nla_put_failure;
+	}
+
+	err = devlink_resource_list_fill(skb, devlink, &state->idx);
+	if (err) {
+		if (state->idx == start_idx)
+			goto nla_put_failure_unwind;
+		nla_nest_end(skb, resources_attr);
+		genlmsg_end(skb, hdr);
+		return err;
+	}
+	nla_nest_end(skb, resources_attr);
+	genlmsg_end(skb, hdr);
+	return 0;
+
+nla_put_failure_unwind:
+	nla_nest_cancel(skb, resources_attr);
+nla_put_failure:
+	genlmsg_cancel(skb, hdr);
+	return err;
+}
+
+int devlink_nl_resource_dump_dumpit(struct sk_buff *skb,
+				    struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb, devlink_nl_resource_dump_one);
+}
+
 int devlink_resources_validate(struct devlink *devlink,
 			       struct devlink_resource *resource,
 			       struct genl_info *info)
-- 
2.44.0


