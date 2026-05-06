Return-Path: <linux-rdma+bounces-20068-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADWsD1Y2+2nUXwMAu9opvQ
	(envelope-from <linux-rdma+bounces-20068-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 14:38:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD734DA511
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 14:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E96A4301A517
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 12:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EEB44CF45;
	Wed,  6 May 2026 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oC0B5Cq6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B9444CAEA;
	Wed,  6 May 2026 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071103; cv=fail; b=tFCjGUjtysmcE+uXZU0ETs+3XsF7tUSGePQTCVKUep8R8fPARx5ZhvfX3Og2b6EnyfV6Y++A8TUldtwZKKhkAAHytlxIMdaSstuCHJGj0XHuDN/uxig9QAEphtDKGYubK8dH0t39Ranl93oSHIAmnf800SjZ/8eIl5IFifqLtak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071103; c=relaxed/simple;
	bh=jp3dwMf6lSr5WmW7GBvzVTX06EQKAgTwrXGIAFOqYRc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NCrMLDZWHurpsHFj2zSBPmnv+/TLDTb283/y3pqqyJEHAWHgw/ti6qHiyaqCEPZQGuWOTLmlJSbwrRYcIW7mGF7ZI78AG3m/9I+Ts2uyEy+ME+HQ4q7yrIT0Ty5eogNkWCf6LSLSZhv7rjIgShpslZJ+TzxPvh/ikGo6l7+HYRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oC0B5Cq6; arc=fail smtp.client-ip=52.101.56.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UG5N+eWec44sOt6Po1tDmuOB7A2T3366Dyd57jJBh1P8VRrRFI/Y+af3cq4HdOU1OTFEirqthBWUFs3mIGm0oU2PhKZNbmZF9RIro2l65kVefDhzf13JfHcAasttRD+jm7SPBNw+TlZMb+YqlJsprkuNnjZyp9SioQHXAM9i2KeEPr1RMbdP8k25PDWXaietIimjs0m9H6JH8iI51GZAgC/DTnkbJqEZYxoXfEexWBQ6hDJTBWLiylROw4xE1L/d74+ZmUp0KexHkJTFSFXn5FJ73AURrZLnTYsuWwnh7PJPu4txOows7ZFYkU37jmEWCRgS+jxfwSrPXvazIYInaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCFjqirzR/MVwFdeN3qYegdm+mHUEGji9uAHiU6AaRw=;
 b=qsOrZtkrmUEvhSQin+M4c4Ql8nKJB2gS1DSsTpeufK1HdKXluLlDbIvNbLC4AoVOQgwyTi3jP3ixuYLgVP00DWEk/lUU9hARp5LhDZwbKZmmC6VQ2xOCihTTuAEQOID9DugBt/ESkE2vf5FUOvJSRXUol8hOPL2C4G4vshh2x6K2jyNHd+DQRMLQJ5UE5Ka7FCUIHACWndB1xAsdw/lV+SKCd0GyxIc2XTFPa9EQfFdDb4ayS0NBpHfYorkrJKYey5T/oDwf6ro4cas+LOzRnxHR5KOQ4Od2CRKgp7zMmrXST/2gCwX4TKaoViIAJt+2n29mxW53+3wC7RZEwQ7cVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCFjqirzR/MVwFdeN3qYegdm+mHUEGji9uAHiU6AaRw=;
 b=oC0B5Cq60dcrLapUYCUKo/gNlE4oxu6rWTsJhPoQ3lZ7cFlr9MMNcfHf5nhm/xF9kBHlh0gcZCN9IaGe2Vc9lK4pHvm8d4NxCIudwQdMVtX9OG9rN9Zfs0qYSX8oF1B3J3rozaCM2JHl/Q4zvvhA5tynwAXKIaC8jr9JVTIWpqTHnXa1uOGJP5fznH/MuAUZAYmv33fOyJfQOSq2ANDut3Y1g+73K0MFuo0rbXYMqlZK+XkZxekrPxr+OZVMqmKsNpAS1fwSYMhtXBOcx44B+ghXOIzQBOHaIRK7f2KtqUSNAQ/gsUpFXAkjmckuWp/kkMFTej5VvkxnvVpsHt59PA==
Received: from SJ0PR03CA0275.namprd03.prod.outlook.com (2603:10b6:a03:39e::10)
 by SA0PR12MB4350.namprd12.prod.outlook.com (2603:10b6:806:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 12:38:11 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::18) by SJ0PR03CA0275.outlook.office365.com
 (2603:10b6:a03:39e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 12:38:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 12:38:10 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 05:37:58 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 6 May 2026 05:37:58 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 6 May 2026 05:37:50 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew Morton
	<akpm@linux-foundation.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, "Randy
 Dunlap" <rdunlap@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>, Petr Mladek <pmladek@suse.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Thomas Gleixner
	<tglx@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>, Marco Elver
	<elver@google.com>, Eric Biggers <ebiggers@kernel.org>, Li RongQing
	<lirongqing@baidu.com>, "Paul E. McKenney" <paulmck@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: [RFC net-next 1/4] devlink: Add infrastructure for boot-time defaults
Date: Wed, 6 May 2026 15:37:36 +0300
Message-ID: <20260506123739.1959770-2-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506123739.1959770-1-mbloch@nvidia.com>
References: <20260506123739.1959770-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|SA0PR12MB4350:EE_
X-MS-Office365-Filtering-Correlation-Id: 94108739-7db3-4fff-5ab2-08deab6c553f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	5fIa3Pu30YSNurz7Sk8t67S623EWmTBWmcoZAIpm8NTgRP/R2tqUbLkM6n+mWydy00z2lTMHUDFVlWaZHkNFZ2kMi64DCrARbecAQcEIoDYssS2XInCOalpBZp5niD1EU/b1Ns8zIAFBYB14LKqKGEALuzXwXq0vAxA3Iw2Vfsmlqlc85K3/6M9n1u471rmUp947vXTx7DTQmfdroBnikRwMLr9Ara0pJBtdk5uLTje7oGaqiNn2XY1JlWceDhh4z+6pSwh6HTFx2e6YgJnqDza6bruvb155n7XTs0M7USeW+ogDWZ0nli5wq8dkX2sRnT7vc3v1llRoT2RrY1PGyeEVZ5RjlH+6rx9TiftMER3vhvRGe7vINVWlJ1gOINIsTP4rg8XaeRfnHGB7tO9+MVc7mq2TSKVPLhv/T5W9R+sUE+/kPCEv0beR8r96gruKNKB01nI46SGWjUG8Q8AK9ECQm0J5bkrD1kprHtQvFTMKhM+OISq3QOXINa1c83PZkzb1Xq5Gym3Ty6UY33WWYcCjdL2bkw8Z+g4U4kjQWo/tAXSKlCeVpdgVSRrfV4YyXV8oybIEvGo+woyzDTpCXF8ImpvXaBcM4Aqpse805ue2o8w2IG8ZkdrshGNLykJV3DQRwFGzJ1/tx/IWdztzLtSh/swIiwgjqPzWJQtzmj1Yt0JU2T+2oWM2bj0TY43kQpkNN203wniOgkmGrvnRcH8d84aoCc1DnsofjYuUGcw=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	89GB8LUm0gLten7MUEJSp8PxfDHznspb0tmgvF131n7BQRd0g/JmSnq2cJd8ztZdL6cCNp6fQ4edRZ1aSkZpaWt1tUKVQaJuCk83/pgrOIRFbwqXZrL0eBYT4CPwHKlSiwtdW0QV3Hazh4gvrr4kx0KmPwYUdBllFE0Wd/uj94MuL2jS1PgPe7ooV6tnCerqpLbTH9ReptznWSkCJqFaKGdHgGo5BQZd+OcsMEqgIY6RGDXBQgv77a6m7/NZHM11AU34W2lXp+h109Id7LFi4WDbNHjZ8cEbSMZ4TVE9ZpdmhCMOubJUeDc7w26nqxCRQfrDY6Q0w4cj2lN06ec7E2UViBcwKUe2DaCnvGu3p4MRzYmBMk+aQZ/IVxa5DOYjwruap7mkT2ALur9Pnsukn3MLf9Q/hli2T7wxd9drdLxT+1o9S6PAZznhpvP/ClAG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 12:38:10.7639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94108739-7db3-4fff-5ab2-08deab6c553f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4350
X-Rspamd-Queue-Id: 3AD734DA511
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20068-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mellanox.com:email,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

Add generic devlink boot-default infrastructure driven by the
devlink= kernel command line parameter.

The parser stores defaults per devlink handle using the same
bus/device handle format exposed by devlink. Each handle keeps an
ordered list of parsed commands so that defaults can later be applied
in command-line order when the matching devlink instance is initialized.

This commit only adds the generic parsing, storage, duplicate handling
and devl_apply_defaults() API. Concrete default commands are added in
later commits.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 include/net/devlink.h |   1 +
 net/devlink/core.c    | 441 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 442 insertions(+)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index bcd31de1f890..058654d6800f 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1622,6 +1622,7 @@ int devl_trylock(struct devlink *devlink);
 void devl_unlock(struct devlink *devlink);
 void devl_assert_locked(struct devlink *devlink);
 bool devl_lock_is_held(struct devlink *devlink);
+int devl_apply_defaults(struct devlink *devlink);
 DEFINE_GUARD(devl, struct devlink *, devl_lock(_T), devl_unlock(_T));
 
 struct ib_device;
diff --git a/net/devlink/core.c b/net/devlink/core.c
index eeb6a71f5f56..2421a1f8dbb7 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -4,6 +4,11 @@
  * Copyright (c) 2016 Jiri Pirko <jiri@mellanox.com>
  */
 
+#include <linux/ctype.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 #include <net/genetlink.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/devlink.h>
@@ -16,6 +21,418 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_trap_report);
 
 DEFINE_XARRAY_FLAGS(devlinks, XA_FLAGS_ALLOC);
 
+static char *devlink_default;
+static LIST_HEAD(devlink_default_nodes);
+
+struct devlink_default_attr_item {
+	enum devlink_attr attr;
+	union {
+		enum devlink_eswitch_mode eswitch_mode;
+		struct {
+			char *name;
+			char *value;
+		} param;
+	} value;
+};
+
+struct devlink_default_cmd_item {
+	struct list_head list;
+	enum devlink_command cmd;
+	int (*run)(struct devlink *devlink,
+		   const struct devlink_default_attr_item *attr);
+	struct devlink_default_attr_item attr;
+};
+
+struct devlink_default_node {
+	struct list_head list;
+	char *bus_name;
+	char *dev_name;
+	struct list_head cmd_list;
+};
+
+struct devlink_default_cmd_spec {
+	const char *name;
+	enum devlink_command cmd;
+	int (*run)(struct devlink *devlink,
+		   const struct devlink_default_attr_item *attr);
+	int (*attr_parse)(char *str,
+			  struct devlink_default_attr_item *attr_item);
+};
+
+static int __init
+devlink_default_node_add(const char *bus_name, const char *dev_name,
+			 const char *cmd);
+
+static void __init
+devlink_default_attr_free(struct devlink_default_attr_item *attr)
+{
+	if (attr->attr != DEVLINK_ATTR_PARAM)
+		return;
+
+	kfree(attr->value.param.name);
+	kfree(attr->value.param.value);
+}
+
+static const struct devlink_default_cmd_spec *__init
+devlink_default_cmd_spec_find(const char *name)
+{
+	return NULL;
+}
+
+static int __init
+devlink_default_cmd_parse(char *str,
+			  struct devlink_default_cmd_item *cmd_item)
+{
+	const struct devlink_default_cmd_spec *spec;
+	struct devlink_default_attr_item attr_item = {};
+	char *cmd_name;
+	int err;
+
+	cmd_name = strsep(&str, ":");
+	if (!cmd_name || !*cmd_name || !str || !*str)
+		return -EINVAL;
+
+	spec = devlink_default_cmd_spec_find(cmd_name);
+	if (!spec)
+		return -EINVAL;
+
+	err = spec->attr_parse(str, &attr_item);
+	if (err) {
+		devlink_default_attr_free(&attr_item);
+		return err;
+	}
+	if (cmd_item) {
+		cmd_item->cmd = spec->cmd;
+		cmd_item->run = spec->run;
+		cmd_item->attr = attr_item;
+	} else {
+		devlink_default_attr_free(&attr_item);
+	}
+
+	return 0;
+}
+
+static int __init
+devlink_default_cmd_parse_copy(const char *str,
+			       struct devlink_default_cmd_item *cmd_item)
+{
+	char *cmd;
+	int err;
+
+	cmd = kstrdup(str, GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	err = devlink_default_cmd_parse(cmd, cmd_item);
+	kfree(cmd);
+	return err;
+}
+
+static int __init
+devlink_default_handle_parse(char *handle, char **bus_name, char **dev_name)
+{
+	char *slash;
+	char *p;
+
+	if (!handle || !*handle)
+		return -EINVAL;
+
+	for (p = handle; *p; p++) {
+		if (isspace(*p))
+			return -EINVAL;
+		if (*p == '[' || *p == ']')
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
+static int __init
+devlink_default_entry_parse(char *entry, bool store)
+{
+	char *handles_end;
+	char *handles;
+	char *handle;
+	char *cmd;
+	int err;
+
+	if (!entry || *entry != '[')
+		return -EINVAL;
+
+	handles = entry + 1;
+	handles_end = strchr(handles, ']');
+	if (!handles_end || handles_end[1] != ':' || !handles_end[2])
+		return -EINVAL;
+
+	*handles_end = '\0';
+	cmd = handles_end + 2;
+	if (!*handles)
+		return -EINVAL;
+
+	while ((handle = strsep(&handles, ",")) != NULL) {
+		char *bus_name;
+		char *dev_name;
+
+		err = devlink_default_handle_parse(handle, &bus_name,
+						   &dev_name);
+		if (err)
+			return err;
+
+		if (!store)
+			continue;
+
+		err = devlink_default_node_add(bus_name, dev_name, cmd);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static void __init
+devlink_default_cmd_item_free(struct devlink_default_cmd_item *cmd)
+{
+	devlink_default_attr_free(&cmd->attr);
+	kfree(cmd);
+}
+
+static void __init devlink_default_node_free(struct devlink_default_node *node)
+{
+	struct devlink_default_cmd_item *cmd;
+	struct devlink_default_cmd_item *cmd_tmp;
+
+	list_for_each_entry_safe(cmd, cmd_tmp, &node->cmd_list, list) {
+		list_del(&cmd->list);
+		devlink_default_cmd_item_free(cmd);
+	}
+
+	kfree(node->bus_name);
+	kfree(node->dev_name);
+	kfree(node);
+}
+
+static void __init devlink_default_nodes_clear(void)
+{
+	struct devlink_default_node *node;
+	struct devlink_default_node *node_tmp;
+
+	list_for_each_entry_safe(node, node_tmp, &devlink_default_nodes, list) {
+		list_del(&node->list);
+		devlink_default_node_free(node);
+	}
+}
+
+static struct devlink_default_node *__init
+devlink_default_node_find(const char *bus_name, const char *dev_name)
+{
+	struct devlink_default_node *node;
+
+	list_for_each_entry(node, &devlink_default_nodes, list) {
+		if (!strcmp(node->bus_name, bus_name) &&
+		    !strcmp(node->dev_name, dev_name))
+			return node;
+	}
+
+	return NULL;
+}
+
+static bool __init
+devlink_default_cmd_equal(const struct devlink_default_cmd_item *a,
+			  const struct devlink_default_cmd_item *b)
+{
+	if (a->cmd != b->cmd || a->attr.attr != b->attr.attr)
+		return false;
+
+	return true;
+}
+
+static bool __init
+devlink_default_cmd_exists(struct devlink_default_node *node,
+			   const struct devlink_default_cmd_item *cmd)
+{
+	struct devlink_default_cmd_item *cmd_item;
+
+	list_for_each_entry(cmd_item, &node->cmd_list, list) {
+		if (devlink_default_cmd_equal(cmd_item, cmd))
+			return true;
+	}
+
+	return false;
+}
+
+static int __init
+devlink_default_cmd_item_add(struct devlink_default_node *node,
+			     const char *cmd_str)
+{
+	struct devlink_default_cmd_item *cmd;
+	int err;
+
+	cmd = kzalloc_obj(*cmd);
+	if (!cmd)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&cmd->list);
+	err = devlink_default_cmd_parse_copy(cmd_str, cmd);
+	if (err) {
+		devlink_default_cmd_item_free(cmd);
+		return err;
+	}
+
+	if (devlink_default_cmd_exists(node, cmd)) {
+		devlink_default_cmd_item_free(cmd);
+		return -EEXIST;
+	}
+
+	list_add_tail(&cmd->list, &node->cmd_list);
+	return 0;
+}
+
+static int __init
+devlink_default_node_add(const char *bus_name, const char *dev_name,
+			 const char *cmd_str)
+{
+	struct devlink_default_node *node;
+	int err;
+
+	node = devlink_default_node_find(bus_name, dev_name);
+	if (node)
+		return devlink_default_cmd_item_add(node, cmd_str);
+
+	node = kzalloc_obj(*node);
+	if (!node)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&node->list);
+	INIT_LIST_HEAD(&node->cmd_list);
+	node->bus_name = kstrdup(bus_name, GFP_KERNEL);
+	node->dev_name = kstrdup(dev_name, GFP_KERNEL);
+	if (!node->bus_name || !node->dev_name) {
+		err = -ENOMEM;
+		goto err_free_node;
+	}
+
+	err = devlink_default_cmd_item_add(node, cmd_str);
+	if (err)
+		goto err_free_node;
+
+	list_add_tail(&node->list, &devlink_default_nodes);
+	return 0;
+
+err_free_node:
+	devlink_default_node_free(node);
+	return err;
+}
+
+static int __init devlink_default_parse(char *str, bool store)
+{
+	char *entry = str;
+	int err;
+
+	if (!str || !*str)
+		return -EINVAL;
+
+	while (entry) {
+		char *handles_end;
+		char *cmd_start;
+		char *entry_end;
+
+		if (*entry != '[') {
+			err = -EINVAL;
+			goto err_clear;
+		}
+
+		handles_end = strchr(entry + 1, ']');
+		if (!handles_end || handles_end[1] != ':') {
+			err = -EINVAL;
+			goto err_clear;
+		}
+
+		cmd_start = handles_end + 2;
+		entry_end = strchr(cmd_start, ',');
+		if (entry_end)
+			*entry_end = '\0';
+
+		err = devlink_default_entry_parse(entry, store);
+		if (err)
+			goto err_clear;
+		if (!entry_end)
+			return 0;
+
+		entry = entry_end + 1;
+		if (!*entry) {
+			err = -EINVAL;
+			goto err_clear;
+		}
+	}
+
+	return 0;
+
+err_clear:
+	if (store)
+		devlink_default_nodes_clear();
+	return err;
+}
+
+static int devlink_default_node_apply(struct devlink *devlink,
+				      const struct devlink_default_node *node)
+{
+	const struct devlink_default_cmd_item *cmd;
+	int err;
+
+	list_for_each_entry(cmd, &node->cmd_list, list) {
+		err = cmd->run(devlink, &cmd->attr);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+/**
+ * devl_apply_defaults - Apply defaults matching the devlink instance
+ * @devlink: devlink
+ *
+ * The caller must hold the devlink instance lock.
+ */
+int devl_apply_defaults(struct devlink *devlink)
+{
+	const char *bus_name = devlink_bus_name(devlink);
+	const char *dev_name = devlink_dev_name(devlink);
+	struct devlink_default_node *node;
+
+	devl_assert_locked(devlink);
+
+	list_for_each_entry(node, &devlink_default_nodes, list) {
+		if (strcmp(node->bus_name, bus_name) ||
+		    strcmp(node->dev_name, dev_name))
+			continue;
+
+		return devlink_default_node_apply(devlink, node);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devl_apply_defaults);
+
+static int __init devlink_default_setup(char *str)
+{
+	devlink_default = str;
+	return 1;
+}
+__setup("devlink=", devlink_default_setup);
+
 static struct devlink *devlinks_xa_get(unsigned long index)
 {
 	struct devlink *devlink;
@@ -578,6 +995,27 @@ static int __init devlink_init(void)
 {
 	int err;
 
+	if (devlink_default) {
+		char *def;
+
+		def = kstrdup(devlink_default, GFP_KERNEL);
+		if (!def) {
+			err = -ENOMEM;
+			goto out;
+		}
+		err = devlink_default_parse(def, true);
+		kfree(def);
+		if (err == -EEXIST) {
+			devlink_default = NULL;
+			pr_warn("devlink: duplicate defaults ignored\n");
+		} else if (err == -EINVAL) {
+			devlink_default = NULL;
+			pr_warn("devlink: invalid command line parameter ignored\n");
+		} else if (err) {
+			goto out;
+		}
+	}
+
 	err = register_pernet_subsys(&devlink_pernet_ops);
 	if (err)
 		goto out;
@@ -593,7 +1031,10 @@ static int __init devlink_init(void)
 out_unreg_pernet_subsys:
 	unregister_pernet_subsys(&devlink_pernet_ops);
 out:
+	if (err)
+		devlink_default_nodes_clear();
 	WARN_ON(err);
+
 	return err;
 }
 
-- 
2.34.1


