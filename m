Return-Path: <linux-rdma+bounces-22565-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BiWzOja4QmqgAAoAu9opvQ
	(envelope-from <linux-rdma+bounces-22565-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 20:23:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E54A6DE018
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 20:23:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Xm3BEToN;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22565-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22565-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DFA23049659
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 18:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4318A38B7A5;
	Mon, 29 Jun 2026 18:22:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010068.outbound.protection.outlook.com [52.101.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBC9383980;
	Mon, 29 Jun 2026 18:22:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757331; cv=fail; b=V117L8QMLkC4LUY3e0csxW/zfVKxVVytuRIYYpDLmAOY1dBMqlKRXztkyE5CGi6NtMLwasPhVrrVhP1aEeEjExxy5fU+CXGkN85X++FAF6vkziugQbNGOWpuEK9Akdn7qc+xcsBjScBBkYgrAOAj+t7N2G6n+wpUF3z3M8wVOc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757331; c=relaxed/simple;
	bh=yBiOuGlZ9EkRATVDre5MQfeVo2mte00PmBT1voVFPf0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Au+viu+HVga0llcVEd1w71fQfAKaD+C9PXhk+dt14Vu3Csuilyfq6zdO5WhJgaLLKoGoggQXQQQ5ilfFHpL2oxrfujS2ROziysnN18xjN9O2V8N7+vEljJmYhzVx/oZHOb+DIrjXEwmJMpIkccuEO6v9mDTIqwFuk5x+v4+9X50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xm3BEToN; arc=fail smtp.client-ip=52.101.201.68
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cq184x+vvnQvkZzvJywrkrqDagc1xRzBcfrbEel3YLmPfh3DebFOzgj6hxEcmNCybA4wGR8COpM4DUt74KmU2u0IqIyAKIop2cqT8K/kVyMD2y5O+pbE2boiSXO6VSjgsT8oqTyf84JgmxDgoFkpcHrJgKWgJzREe739stoTCKfdSZA8EmaHD0YdYEvlOU8j/poxh1ZnPQcbOhGbulgjptU13cyJetygZv/POIs9uktuwimqVXIncbKmBnnI0CfZk8t48NwITZQf8EEBt0vyB/5En5bf6wYI4IMntZKp2hHyXE9YvQXyWUZUlBY546BpSdXF/+MmM3m+fsFzvtBxJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zb3bjnWzwGUhbyL7ZI/DCfgMQuM8/W5lIFWlBzzTq18=;
 b=S5cNAW8HHh3l2JdkVMOk09PfQ1bkslkKTjvcU4Y+LbhYjiN6lWIlJ7WegfIQYC7VdpZBpjM2UPBij5T8AvGBIwz8p+A7ge8vWUthHmQOqsffDgH1aHXLByEPT/+EmKldswhMSuHcY5yI8K4a9OHmU85Cikf0vbgXu95EiQkUTsn4tRNgCElvR5K8TMEjYz9/KQ79Ymgw7Xd5OaRCKRaXsSVyz2U5DPkCXvvwx6WVfrbu5s+iGK5jIAGwaybm6NOr74kSaIK4NmOV4GikAe5y+oAHc/d+MOWDCGIFYoyv2p6c4+N5Bado326jYJH7/LL5HZ7j8/dzG7jCm1rKIGxRIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=resnulli.us smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zb3bjnWzwGUhbyL7ZI/DCfgMQuM8/W5lIFWlBzzTq18=;
 b=Xm3BEToNd0A+jpMI8LdIkaJtgOi4PZmEQQHWq4fqMQafwiN1d9rM+aENdt+4GqqzZwX1wozKI0SzPCWlzDT4cJVZsJ8zQRe98By89ho/8Vo5Ww6gCWo3Q3nhoWTI47Bb4u1iSoao0RqRgW+pQ2rGL45znulwyIGESnCCrdtt5MhRC8+Fibe65nSCPtip3yX2EMcMaokNhwPoh0F+9vivp3sg6jhdNW1VgIEnTBDGITycL2v5pzfegA8o/TeOO/B4eFJKw6QLyPQ17CAquDamrZyDPz4Sg/kI+eF6JYkv++KA0Ksa23GhGZQSxNwupFVuHcwyQ3X5AX4J0j9tZljb0g==
Received: from SJ0PR05CA0042.namprd05.prod.outlook.com (2603:10b6:a03:33f::17)
 by CH3PR12MB9429.namprd12.prod.outlook.com (2603:10b6:610:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 18:21:54 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::6a) by SJ0PR05CA0042.outlook.office365.com
 (2603:10b6:a03:33f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.7 via Frontend Transport; Mon, 29
 Jun 2026 18:21:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 18:21:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 11:21:25 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 11:21:24 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 29
 Jun 2026 11:21:21 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next V4 4/6] devlink: Apply eswitch mode boot defaults
Date: Mon, 29 Jun 2026 21:20:59 +0300
Message-ID: <20260629182102.245150-5-mbloch@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629182102.245150-1-mbloch@nvidia.com>
References: <20260629182102.245150-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|CH3PR12MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c3a3bc-a80b-4d44-e377-08ded60b4bd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|23010399003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	H51yg7DxQcc19ll/XkqUVkIoJjky2nqEjEyfGyh6eVMXPuh0JBiy2aO1fzDrDzWQI30ibOXiQBb+DZ+rw260KToyCcW0h7kGXJrLMYASZ7QypN1ZSaLJs87PgLBhMOlhR1i04wrf0b4J9YS9kPXq25/qg+00BwwBc0xoQlYuo1IFn3JJ/N2NG8JoFsUeHHzD7zJy1r70qlsJrFBzrybfvB15nGn/GoMuP+Lpy7iD/p2QpaHRWo4+Gtr0YC0OrYQVquqsv32DQwU8/6XzJsY7kry52ca36mw3xIZKwMoR+/aX85Z9hLnXO0vs3r3fisOSzNHk1MJZ5ZzEVQh9YH14x1Q17v7/ASv3Eb29M+eDim/iNMxv4/SfvmldO+jgaZn1+Z+Rp9HyZZZD0DNMZzCafHiGAHh+bI1w3HrX8Qn2axQPfB138KUxYOd7+e8dayDx/VW5yBQA8MQrhQ9KMYFoMA4/jqhyrvPwOuAuafrfnviRk2QJsiuNozIZQ9/a85Lb7BF1LsSal1JLKceuAJ/HfaYF0yrAHPUbZryr3Ptlwa6eDZhiNe99QUDvRE9A7W4T3bxXXdkl7Kj3lhQLrWTozRS71YnjTSvcrOHiMnHBhSF2YigZSD5Yrq8hIQLmVCsTx7r6fQJDP9z6DKnmhUWU3Apr3Li8NRwUnLLj9QIKRosErQaHFJD58VWT/H+x954WW+hFH04GklCBamjtIMvTHg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hMLHwOKLDGtFY2W+D4WIzLZr/b76s2mvVT9c8rQYpcazEroR8bnB0oqAihDv/ZE5OBvtq8vLVRH1M9+G6O5Z3n7fXiPKahTYtH6frEcFetrp4SRs8JHLMmszBaUQTbVVwu6UmITz0ntdwMZgFdsoNGNChjIXz4rIQ2wsI68DB2wzNomZP5YWyM2An54RmUD+JKP80ZvbDnRkAVIt69jWVTiIh6hXHbgrzoRtZwEs99/4wtyTFtABOvz/IDsW1QcbLngvg+bAqHiVtNCPLt5tJMbzQWJUnQtO+pG3WkDkuYDSdLmB5qheLXjd+RaF9Q04bsb4ByBKr0Q5IVjkmCaaKE03TBc5Rw45qaaAeKr29r22UyCWX/MnXvCVgBwwDS8wDDbHeuin78+Dsdhfn/iLNa/dBceCmx6Fwn+syvrbvPRU7p5nm8URlzQipyCZ+8B8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 18:21:53.7797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c3a3bc-a80b-4d44-e377-08ded60b4bd0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9429
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
	TAGGED_FROM(0.00)[bounces-22565-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E54A6DE018

Apply parsed devlink_eswitch_mode= defaults after devlink registration
and after successful reload.

devl_register() may still be called before the device is ready for an
eswitch mode change, so keep a per-devlink delayed work item and pending
flag for the registration path. Registration queues the work, and the
worker tries to take the devlink instance lock.

If the lock is busy, the worker requeues itself with a delay.

For successful reloads that performed DRIVER_REINIT, devlink_reload()
already holds the devlink instance lock and the driver has completed
reload_up(). Clear pending work and apply the default directly from the
reload path instead of queueing work.

If a user sets eswitch mode through netlink before the pending
registration work runs, clear the pending flag so the queued default does
not override that user request. Cancel pending default apply work when
freeing the devlink instance.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 net/devlink/core.c          | 198 +++++++++++++++++++++++++++++++-----
 net/devlink/dev.c           |   6 ++
 net/devlink/devl_internal.h |   5 +
 3 files changed, 182 insertions(+), 27 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index 5126509a9c4e..998e4ffd5dce 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/jiffies.h>
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -22,8 +23,12 @@ DEFINE_XARRAY_FLAGS(devlinks, XA_FLAGS_ALLOC);
 
 static char *devlink_default_esw_mode_param;
 static bool devlink_default_esw_mode_match_all;
+static bool devlink_default_esw_mode_enabled;
 static enum devlink_eswitch_mode devlink_default_esw_mode;
 static LIST_HEAD(devlink_default_esw_mode_nodes);
+static struct workqueue_struct *devlink_default_esw_mode_wq;
+
+#define DEVLINK_DEFAULT_ESW_MODE_APPLY_DELAY msecs_to_jiffies(100)
 
 struct devlink_default_esw_mode_node {
 	struct list_head list;
@@ -166,6 +171,7 @@ static void __init devlink_default_esw_mode_nodes_clear(void)
 	}
 
 	devlink_default_esw_mode_match_all = false;
+	devlink_default_esw_mode_enabled = false;
 }
 
 static int __init devlink_default_esw_mode_parse(char *str)
@@ -192,14 +198,113 @@ static int __init devlink_default_esw_mode_parse(char *str)
 		return err;
 
 	err = devlink_default_esw_mode_handles_parse(handles);
-	if (err)
+	if (err) {
 		devlink_default_esw_mode_nodes_clear();
-	else
+	} else {
 		devlink_default_esw_mode = esw_mode;
+		devlink_default_esw_mode_enabled = true;
+	}
 
 	return err;
 }
 
+static bool devlink_default_esw_mode_match(struct devlink *devlink)
+{
+	const char *bus_name = devlink_bus_name(devlink);
+	const char *dev_name = devlink_dev_name(devlink);
+	struct devlink_default_esw_mode_node *node;
+
+	if (devlink_default_esw_mode_match_all)
+		return true;
+
+	node = devlink_default_esw_mode_node_find(bus_name, dev_name);
+	return !!node;
+}
+
+void devlink_default_esw_mode_apply(struct devlink *devlink)
+{
+	const struct devlink_ops *ops = devlink->ops;
+	int err;
+
+	devl_assert_locked(devlink);
+
+	if (!devlink_default_esw_mode_match(devlink))
+		return;
+
+	if (!ops->eswitch_mode_set) {
+		if (!devlink_default_esw_mode_match_all)
+			devl_warn(devlink,
+				  "devlink_eswitch_mode= selected this device but eswitch mode setting is not supported\n");
+		return;
+	}
+
+	err = devlink_eswitch_mode_set(devlink, devlink_default_esw_mode, NULL);
+	if (err)
+		devl_warn(devlink,
+			  "Couldn't apply default eswitch mode, err %d\n",
+			  err);
+}
+
+static void
+devlink_default_esw_mode_apply_queue(struct devlink *devlink,
+				     unsigned long delay)
+{
+	if (!devlink_default_esw_mode_enabled || !devlink_default_esw_mode_wq)
+		return;
+	if (!devlink_try_get(devlink))
+		return;
+	if (!queue_delayed_work(devlink_default_esw_mode_wq,
+				&devlink->default_esw_mode_apply_dw,
+				delay))
+		devlink_put(devlink);
+}
+
+static void devlink_default_esw_mode_apply_work(struct work_struct *work)
+{
+	unsigned long delay = DEVLINK_DEFAULT_ESW_MODE_APPLY_DELAY;
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct devlink *devlink;
+
+	devlink = container_of(dwork, struct devlink,
+			       default_esw_mode_apply_dw);
+	if (!devl_trylock(devlink)) {
+		if (__devl_is_registered(devlink))
+			devlink_default_esw_mode_apply_queue(devlink, delay);
+		devlink_put(devlink);
+		return;
+	}
+
+	if (devl_is_registered(devlink) &&
+	    devlink->default_esw_mode_apply_pending) {
+		devlink_default_esw_mode_apply(devlink);
+		devlink->default_esw_mode_apply_pending = false;
+	}
+
+	devl_unlock(devlink);
+	devlink_put(devlink);
+}
+
+void devlink_default_esw_mode_apply_schedule(struct devlink *devlink)
+{
+	devl_assert_locked(devlink);
+
+	devlink->default_esw_mode_apply_pending = true;
+	devlink_default_esw_mode_apply_queue(devlink, 0);
+}
+
+void devlink_default_esw_mode_apply_disable(struct devlink *devlink)
+{
+	devl_assert_locked(devlink);
+
+	devlink->default_esw_mode_apply_pending = false;
+}
+
+static void devlink_default_esw_mode_apply_cancel(struct devlink *devlink)
+{
+	if (cancel_delayed_work_sync(&devlink->default_esw_mode_apply_dw))
+		devlink_put(devlink);
+}
+
 static int __init devlink_default_esw_mode_setup(char *str)
 {
 	devlink_default_esw_mode_param = str;
@@ -577,6 +682,12 @@ struct devlink *devlinks_xa_lookup_get(struct net *net, unsigned long index)
  * Make @devlink visible to userspace. Drivers must call this only after the
  * instance is fully initialized and its devlink operations can be called.
  *
+ * If a matching devlink_eswitch_mode= default was provided on the kernel
+ * command line, devlink core schedules async work to apply it after
+ * registration. Drivers implementing eswitch_mode_set() must therefore be
+ * ready to perform the same work as a userspace eswitch mode set request from
+ * this point, including creation of representors and other eswitch state.
+ *
  * Context: Caller must hold the devlink instance lock. Use devlink_register()
  * when the lock is not already held.
  *
@@ -590,6 +701,7 @@ int devl_register(struct devlink *devlink)
 	xa_set_mark(&devlinks, devlink->index, DEVLINK_REGISTERED);
 	devlink_notify_register(devlink);
 	devlink_rel_nested_in_notify(devlink);
+	devlink_default_esw_mode_apply_schedule(devlink);
 
 	return 0;
 }
@@ -612,6 +724,7 @@ void devl_unregister(struct devlink *devlink)
 	ASSERT_DEVLINK_REGISTERED(devlink);
 	devl_assert_locked(devlink);
 
+	devlink_default_esw_mode_apply_disable(devlink);
 	devlink_notify_unregister(devlink);
 	xa_clear_mark(&devlinks, devlink->index, DEVLINK_REGISTERED);
 	devlink_rel_put(devlink);
@@ -673,6 +786,9 @@ struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
 	INIT_LIST_HEAD(&devlink->trap_group_list);
 	INIT_LIST_HEAD(&devlink->trap_policer_list);
 	INIT_RCU_WORK(&devlink->rwork, devlink_release);
+	INIT_DELAYED_WORK(&devlink->default_esw_mode_apply_dw,
+			  devlink_default_esw_mode_apply_work);
+	devlink->default_esw_mode_apply_pending = true;
 	lockdep_register_key(&devlink->lock_key);
 	mutex_init(&devlink->lock);
 	lockdep_set_class(&devlink->lock, &devlink->lock_key);
@@ -716,6 +832,7 @@ EXPORT_SYMBOL_GPL(devlink_alloc_ns);
 void devlink_free(struct devlink *devlink)
 {
 	ASSERT_DEVLINK_NOT_REGISTERED(devlink);
+	devlink_default_esw_mode_apply_cancel(devlink);
 
 	devlink_rel_put(devlink);
 
@@ -775,35 +892,59 @@ static struct notifier_block devlink_port_netdevice_nb = {
 	.notifier_call = devlink_port_netdevice_event,
 };
 
-static int __init devlink_init(void)
+static int __init devlink_default_esw_mode_init(void)
 {
+	char *def;
 	int err;
 
-	if (devlink_default_esw_mode_param) {
-		char *def;
-
-		def = kstrdup(devlink_default_esw_mode_param, GFP_KERNEL);
-		if (!def) {
-			devlink_default_esw_mode_param = NULL;
-			pr_warn("devlink: devlink_eswitch_mode parameter ignored, failed to allocate memory\n");
-		} else {
-			err = devlink_default_esw_mode_parse(def);
-			kfree(def);
-			if (err == -EEXIST) {
-				devlink_default_esw_mode_param = NULL;
-				pr_warn("devlink: duplicate eswitch mode handles ignored\n");
-			} else if (err == -EINVAL) {
-				devlink_default_esw_mode_param = NULL;
-				pr_warn("devlink: invalid devlink_eswitch_mode parameter ignored\n");
-			} else if (err == -ENOMEM) {
-				devlink_default_esw_mode_param = NULL;
-				pr_warn("devlink: devlink_eswitch_mode parameter ignored, failed to allocate memory\n");
-			} else if (err) {
-				goto out;
-			}
-		}
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
 	}
 
+	devlink_default_esw_mode_wq = alloc_workqueue("devlink_default_esw_mode",
+						      WQ_UNBOUND | WQ_MEM_RECLAIM,
+						      0);
+	if (!devlink_default_esw_mode_wq) {
+		devlink_default_esw_mode_param = NULL;
+		devlink_default_esw_mode_nodes_clear();
+		pr_warn("devlink: devlink_eswitch_mode parameter ignored, failed to allocate workqueue\n");
+	}
+
+	return 0;
+}
+
+static int __init devlink_init(void)
+{
+	int err;
+
+	err = devlink_default_esw_mode_init();
+	if (err)
+		goto out;
+
 	err = register_pernet_subsys(&devlink_pernet_ops);
 	if (err)
 		goto out;
@@ -819,8 +960,11 @@ static int __init devlink_init(void)
 out_unreg_pernet_subsys:
 	unregister_pernet_subsys(&devlink_pernet_ops);
 out:
-	if (err)
+	if (err) {
+		if (devlink_default_esw_mode_wq)
+			destroy_workqueue(devlink_default_esw_mode_wq);
 		devlink_default_esw_mode_nodes_clear();
+	}
 	WARN_ON(err);
 
 	return err;
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 4fb02bb993c1..7f6ed52a5f73 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -478,6 +478,11 @@ int devlink_reload(struct devlink *devlink, struct net *dest_net,
 		return err;
 
 	WARN_ON(!(*actions_performed & BIT(action)));
+	if (*actions_performed & BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT)) {
+		devlink_default_esw_mode_apply_disable(devlink);
+		devlink_default_esw_mode_apply(devlink);
+	}
+
 	/* Catch driver on updating the remote action within devlink reload */
 	WARN_ON(memcmp(remote_reload_stats, devlink->stats.remote_reload_stats,
 		       sizeof(remote_reload_stats)));
@@ -731,6 +736,7 @@ int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
 	u16 mode;
 
 	if (info->attrs[DEVLINK_ATTR_ESWITCH_MODE]) {
+		devlink_default_esw_mode_apply_disable(devlink);
 		mode = nla_get_u16(info->attrs[DEVLINK_ATTR_ESWITCH_MODE]);
 		err = devlink_eswitch_mode_set(devlink, mode, info->extack);
 		if (err)
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 97be77d3ed42..d6ff233da974 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -58,8 +58,10 @@ struct devlink {
 	struct mutex lock;
 	struct lock_class_key lock_key;
 	u8 reload_failed:1;
+	u8 default_esw_mode_apply_pending:1;
 	refcount_t refcount;
 	struct rcu_work rwork;
+	struct delayed_work default_esw_mode_apply_dw;
 	struct devlink_rel *rel;
 	struct xarray nested_rels;
 	char priv[] __aligned(NETDEV_ALIGN);
@@ -71,6 +73,9 @@ extern struct genl_family devlink_nl_family;
 struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
 				struct net *net, struct device *dev,
 				const struct device_driver *dev_driver);
+void devlink_default_esw_mode_apply(struct devlink *devlink);
+void devlink_default_esw_mode_apply_schedule(struct devlink *devlink);
+void devlink_default_esw_mode_apply_disable(struct devlink *devlink);
 
 #define devl_warn(devlink, format, args...)				\
 	do {								\
-- 
2.43.0


