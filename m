Return-Path: <linux-rdma+bounces-19107-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF7KNodf1WkF5gcAu9opvQ
	(envelope-from <linux-rdma+bounces-19107-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 21:48:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 801C43B3FC0
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 21:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AF8D30BB31B
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 19:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BDA37883E;
	Tue,  7 Apr 2026 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="go93LNc4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012015.outbound.protection.outlook.com [40.107.209.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819CA378D82;
	Tue,  7 Apr 2026 19:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775590977; cv=fail; b=gEf8gp92/gd7lETMYWdyEOlLXFtmmgV4qLkRaTFBluQxxfPCutoe5JFHCfffG4PeZBENMgRFZK+/pEHFsUPBr5DGAg4Ql+wAsM4EABIciz67hvPwoZWcnlMpNiaUMJ4ACy0bYIwBhua2wdIkYkaEId9PUueVjYOO0KzYlciDtgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775590977; c=relaxed/simple;
	bh=WsVfRnsevZyeTX/B+eZW+LkTKCQspGR8OwM+N/Tkggc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZgYecArJhr1FjieJBe8zqCPQNwVjzp9zQJM30y7BNxUBlqlAfCcUF5/nRhy2k2i1K3jFTP3v+baiISFWKXDJ6BHG8WQzjXlcgIQj87adBCzgkD9yCJl1I3gUY4d3a0m96DoZEkAiveHxUZnz8qB6taO4BsGa8NXkJiGTWmQnhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=go93LNc4; arc=fail smtp.client-ip=40.107.209.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIqqNRtR6kSxzgo6A5QhRQZgPe/krhz+h9xkokhHrYj65eL1ulpflJKmRhgXLyrUqonUNOVy5z4eBdp1K4GONACmBhflv0KAtWrEzu7GJ3P9Bnrfpc8/ezMQK1FXbdPTWcGN2eec26KhWKv1v0v/F36oEkSZS6ye45sREriWsCh9h3lQ5ADpjOl4AUl/toLmEYEZQMW8jdhDEuU1brgReJQNssia/3tBZjfRgxVOWEYTasTxCzSKlb3W+5EKKZgj4jr7CPMgNi3Na+bPxj2DRIXmmri0XTHK6bqx4c/ld6gaL7gT5EixK8+8MwuEYDroYSjux7TT9FxRBdhPuqYnwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCWZgKj4j+y2nm+qJu4BtYoh+ItqKFfUow5gcRMo5Qc=;
 b=ZH7985aPNfBR1s2Chl8lwyXOVQ1WvmXcOdgq+EuBlj4wj9+1eZsVq3Z/I3zyXCGA4pd2kYv8L9TZBPqv+Hsu1FGNUxhZ0lMrcFr/wY4sGKa+uSLvTV5tSjZYj5a87MCBRhL2khL6nXpqdx1UywYRuKeMxgVnDFyhyJ1WsjyL8CwvuNSqxiBxF7QWS+Qpo8uWijWV/LdskS+dmA429zYcTN7V7JK1835fQfNt2TO3GlDST1+kFjcMQ/BxBve5Od+fyQS7iUSHOejGxk3xDblIvqbfDyFvQtGBnbYo4cGc0Sr/Kqbxnl+dVNf9FoxO90xa+WDdT0ESPCnYmMEPEce8zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCWZgKj4j+y2nm+qJu4BtYoh+ItqKFfUow5gcRMo5Qc=;
 b=go93LNc4HkDIA0r50R61xUVY9kGbkdQOkw5/NN62fT+M9wru0wgTbRsdxzF5xwGhhRd9CwW/2U/sK8nGn/GpLrPKW9Ox1wMEQ/MK7MWDlRzQDNFZtcsXRXt4tbkFg3QM50S9v6h+AKOa4DB1NxC3Hiw+ToAku4XJ1SLqiHhS5ELq+KX4zVX3yW0aPq8jCDJyI1CNhxxeYYgs7V7Q1DdVxt6b8ObBLMpOGzemB1PMa0Aorkf+koEVKFakoN+6rzFs7G9DoftyHrjyvflqH23Rw4YzDPxjdzlaYfgck3C59iTDzW+gIkGmOBQHZc32f8Xaa3Zi2INmk14q7wtbhFl3Vg==
Received: from BN9PR03CA0706.namprd03.prod.outlook.com (2603:10b6:408:ef::21)
 by PH0PR12MB999111.namprd12.prod.outlook.com (2603:10b6:510:38d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 19:42:50 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:ef:cafe::90) by BN9PR03CA0706.outlook.office365.com
 (2603:10b6:408:ef::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Tue,
 7 Apr 2026 19:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.0 via Frontend Transport; Tue, 7 Apr 2026 19:42:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:42:30 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:42:29 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Apr
 2026 12:42:21 -0700
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
	<gal@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V5 05/12] devlink: Add dump support for device-level resources
Date: Tue, 7 Apr 2026 22:41:00 +0300
Message-ID: <20260407194107.148063-6-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|PH0PR12MB999111:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ae497a-2cd0-46d6-16af-08de94ddd9ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	1Hg2WVD2zO/lN6BjpnbZx1NjdtfeDwHK7X4jDn6GlN3eSErAHzDq3Z8Y5XPXlDLPK2Pk2FDXmURJRB24PS9wpj2EH7ROfctNoVIiuRR6h/HyuZeXLIXT2JuK50C/EuqMu7dCoFC23eD1RCQu+drLcVYnPsWcg9VSfpFV2/AMtSS9CL6wGpL+HM9DVSmcMJy6Cdt/QS8zKzdSjNHgfcnFBkvmcqi0p5BWhYQSBpIl824krhLGMFfoaoykQQ4iOjT3p1KNr3ZSd1CPHA573zkvnQKkEdNdVFEcqCSVpWhyfpJZbt0r0sfxD0thKyRw1Ck3PjL+JxMn8cMY21tymqVeFJUKFmzYnM03wjjeGzszc1y6k+bOtC542EI0yDyV/5lFnvtDMPZVpRVDDUJDIgFPQz18LCiYsbqSA6sD0n+fntKWnHYnO4RZDzrCSES8izxZg5+ih3vBorZ4W7+aQVhWP26FqLWnyJJYn1Lt93ppSm52k1OB0+LTLMvxqe+Bv70PhVrqWCK2sN1EqnqTrh+6g1tpszOpgfCC485TChUco+qFMNBPvvhCZ+XKC26NAzon9wlFPZ+w9ZdLFwi1nVOc9lv+o44+hMIyhf3HgX1UPVaurfmJxlQZSRDfNG0u2SK2XpalZxHloiV/5/FoWJRn0dwOmLjCZoYZSwDt8c067bI8/1WX1FG6JmWxlncmRJtIzLLPjdV3/4erZsrhV1VlcahOPbZfmvWRND1c2n3SXxwSWBOOa8TS6saiEp8trrlZKELyC4HsswUJCnjAoxNlXw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0U/KSoadBmLqGZpKX9/61CdzHZ7yOGxV1DMVaAoHJuSTsY7UbJvKxUUnfGNWhcEAF6iZzA8plvjTKtFDIZip+nt3hD2HV5v0usp8nhWVdiT95JeT3WHAOGpJDKNh56OeqN8MaHrH8FNI7p8IG+FpjmiMzsI5F5B+tyAVw+T1oFf+gfBXQ/MXDndty7e/HJr0Hepf+NU1QOHJkCTLlJpOAa3zsSvYJ6t6bjZf40TwLUwlJ2UTEJ25DvWIrKjjB81tRpjTzfHNsXMw7sDHb0MF17zmsqH/pqP9SEwmsoJTwnlFfYVbY6icPS28n9/k98rD+FZxT9xGFLJHtpC0AEWISEd692fLpxpydW+d/P+BfNMj1jdL9yR76SbcLXGLDGBkA9E8WIp8zKCkGn7GIkSmXqwqLoO+kcSjKjcSLKbYXp0zw0lDsSg6wEjCGqnj9Rbt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 19:42:49.5993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ae497a-2cd0-46d6-16af-08de94ddd9ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999111
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19107-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 801C43B3FC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Or Har-Toov <ohartoov@nvidia.com>

Add dumpit handler for resource-dump command to iterate over all devlink
devices and show their resources.

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
 net/devlink/netlink_gen.c                | 20 +++++-
 net/devlink/netlink_gen.h                |  4 +-
 net/devlink/resource.c                   | 77 ++++++++++++++++++++++++
 4 files changed, 102 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index b495d56b9137..c423e049c7bd 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -1764,13 +1764,17 @@ operations:
             - bus-name
             - dev-name
             - index
-        reply:
+        reply: &resource-dump-reply
           value: 36
           attributes:
             - bus-name
             - dev-name
             - index
             - resource-list
+      dump:
+        request:
+          attributes: *dev-id-attrs
+        reply: *resource-dump-reply
 
     -
       name: reload
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index eb35e80e01d1..a5a47a4c6de8 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -305,7 +305,14 @@ static const struct nla_policy devlink_resource_set_nl_policy[DEVLINK_ATTR_INDEX
 };
 
 /* DEVLINK_CMD_RESOURCE_DUMP - do */
-static const struct nla_policy devlink_resource_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
+static const struct nla_policy devlink_resource_dump_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
+};
+
+/* DEVLINK_CMD_RESOURCE_DUMP - dump */
+static const struct nla_policy devlink_resource_dump_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
@@ -680,7 +687,7 @@ static const struct nla_policy devlink_notify_filter_set_nl_policy[DEVLINK_ATTR_
 };
 
 /* Ops table for devlink */
-const struct genl_split_ops devlink_nl_ops[74] = {
+const struct genl_split_ops devlink_nl_ops[75] = {
 	{
 		.cmd		= DEVLINK_CMD_GET,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
@@ -958,10 +965,17 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.pre_doit	= devlink_nl_pre_doit,
 		.doit		= devlink_nl_resource_dump_doit,
 		.post_doit	= devlink_nl_post_doit,
-		.policy		= devlink_resource_dump_nl_policy,
+		.policy		= devlink_resource_dump_do_nl_policy,
 		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= DEVLINK_CMD_RESOURCE_DUMP,
+		.dumpit		= devlink_nl_resource_dump_dumpit,
+		.policy		= devlink_resource_dump_dump_nl_policy,
+		.maxattr	= DEVLINK_ATTR_INDEX,
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
index f3014ec425c4..02fb36e25c52 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -223,6 +223,31 @@ static int devlink_resource_put(struct devlink *devlink, struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
+static int devlink_resource_list_fill(struct sk_buff *skb,
+				      struct devlink *devlink,
+				      struct list_head *resource_list_head,
+				      int *idx)
+{
+	struct devlink_resource *resource;
+	int i = 0;
+	int err;
+
+	list_for_each_entry(resource, resource_list_head, list) {
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
@@ -302,6 +327,58 @@ int devlink_nl_resource_dump_doit(struct sk_buff *skb, struct genl_info *info)
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
+	err = -EMSGSIZE;
+	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			  &devlink_nl_family, flags, DEVLINK_CMD_RESOURCE_DUMP);
+	if (!hdr)
+		return err;
+
+	if (devlink_nl_put_handle(skb, devlink))
+		goto nla_put_failure;
+
+	resources_attr = nla_nest_start_noflag(skb, DEVLINK_ATTR_RESOURCE_LIST);
+	if (!resources_attr)
+		goto nla_put_failure;
+
+	err = devlink_resource_list_fill(skb, devlink,
+					 &devlink->resource_list, &state->idx);
+	if (err) {
+		if (state->idx == start_idx)
+			goto resource_list_cancel;
+		nla_nest_end(skb, resources_attr);
+		genlmsg_end(skb, hdr);
+		return err;
+	}
+	nla_nest_end(skb, resources_attr);
+	genlmsg_end(skb, hdr);
+	return 0;
+
+resource_list_cancel:
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


