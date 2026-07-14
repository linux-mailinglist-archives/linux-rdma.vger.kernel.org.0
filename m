Return-Path: <linux-rdma+bounces-23174-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mLftI+XUVWpduAAAu9opvQ
	(envelope-from <linux-rdma+bounces-23174-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 08:19:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0210A7516B4
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 08:19:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=N4HpV764;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23174-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23174-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45132304E6A8
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 06:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AD33D967A;
	Tue, 14 Jul 2026 06:18:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010050.outbound.protection.outlook.com [52.101.193.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958F8392C48;
	Tue, 14 Jul 2026 06:18:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784009903; cv=fail; b=QQg5/F8RaNLVJDYVRyEkqVEhxWF5xj7liButEvHXw3lwgVcK1yLxKLPIP97iKRRCAhf/KObv4B75ouA/FXMgiutLmaCq/kW9nRpuJJDQ4JEIlFf2NGOKAxRsTRNbS0Wtr65l5cJwiUHfkYGaHgVI8JBNQCH6Vmcp4s111LiYHn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784009903; c=relaxed/simple;
	bh=S67s0rtAaTL8aHVXt47iGr5G4WSq+lEFt3JfQC4zWtk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1Q2oFhWi2oRFrzL7XjNeLMBBdRNE1WVvVaZ6lFtAht8yQWyTHEJ8tsJkQ7QF0gl4EQInJDH24l/7pykZ3QhfeTbG9R6rVILopU5mkjFesvG0fAZPclg9U9SPPgIMTJoSqD3lnE0KcUWis8fmJL293EWmbp/YAgai6lgrw50w3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N4HpV764; arc=fail smtp.client-ip=52.101.193.50
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsJdXZ89LXvybMisZyh4IW7S5j/t7PieX5F+aEhplNcxPpgjIiHi3F3NuSFFSltsdKy9eZNnqjWDbKqpdKwFDdact2fJKxz0prc87UDPy4va+B3uwh0Rf7K4/3BvSWwD/oePtpS8WrsWZLgCuICJ43po9gB0FuK1UBWl+VZ/69G6G0GKvzgfHaCUKoUwca0K/zfXlcwUm87GT7CkJH/D3qIECywGRrv0dpvYqTwjyv1OnoVe7xwKe+2nduiiTe88lUfmDxGN2tO72GlTwmTTNGw005WIeSEKt/HdIcwCr9/XuEhe0WHIa6XWwmTtgIoefWii78oG8vFCmCZOM4QYVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACqm/CcgzpVimUpXttDR/eUO0iskxOaU48YIpGum1cs=;
 b=IszUtwoofavT9P0IPd0tGnrFDXDdle4X5wuvT8pxvUwSsZXoQWP12UYajeM4iGiFBtnj3+wccY3TUC/n9DuKHZHTLh1QuBqtI1XYEADajWLNvm/wRlOPkwiH10wWmtWIaXUPwnTHu5D6swIZak1wfBV/nQFaFMXLkrI1F059l0jnoM0grklzar8vlMtZDgtmvdIMydY6e7o4OHslPHAsRc6ETOM1Dj1bfD0/TmLeZ/UzKnnHkNSOzgud33ahIV1k9Ju99hzjk3DImkgF1Tvv9ChZIG+phk1NiqbUVEaN7X5UP7LNDI89P/qy8SNqjrAM2bAblSRC80NKWr4xTnXMDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=resnulli.us smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACqm/CcgzpVimUpXttDR/eUO0iskxOaU48YIpGum1cs=;
 b=N4HpV764N86QmTCGoSde/ABj89jTZuMDwMsDigc7TquQ0PYqq8o7nRd0+9QJBbyKqIb6UJdaAljpU75FTWxY6S1W8WxZtLMEJC6y6f5aR9HYvvUVZN9sUAZZi0Fl8xQNzRbe1Frf/7ixe+9iLPzeVjUPGJa1EO3Q4VroX3xYCEoZYsTzcydlRdNRH477MCYrun6ijZhzQRD5I0HMqCnwMCPzlwSyqZ+LkpBbhSTjsPLxiXor5GM4n7U7Xi7tTHfT9f2bwxhQgYkuB7/9Nn8uemMeeyUciZElSNnpTRdc6h2MBV3d4N/qk5Qausc4KLSiQRWzBwXb9d93PEckuEcW1g==
Received: from MN2PR18CA0011.namprd18.prod.outlook.com (2603:10b6:208:23c::16)
 by IA1PR12MB8239.namprd12.prod.outlook.com (2603:10b6:208:3f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 06:18:16 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::55) by MN2PR18CA0011.outlook.office365.com
 (2603:10b6:208:23c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Tue,
 14 Jul 2026 06:18:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 06:18:15 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 23:17:54 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 23:17:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 13
 Jul 2026 23:17:50 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next V6 4/4] devlink: Apply eswitch mode boot defaults
Date: Tue, 14 Jul 2026 09:17:30 +0300
Message-ID: <20260714061731.531849-5-mbloch@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714061731.531849-1-mbloch@nvidia.com>
References: <20260714061731.531849-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|IA1PR12MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: bef2cb12-68c9-4ebc-6522-08dee16fb108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|7416014|82310400026|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	kzxS+t7LAlwp95Oz+Tc8NervUbChPeK75ihQQFfmI0A5mI+F3ZHlrwx5AbRUYHrv2vlT/ct+XdokUihvJgrykBGjpaWeTJb5n9rw6IVr7xs7e76xzvKRNdG8gW/+/0nDPUlIpJmIJHG97mJfu7NnI75+9pJvY/sh6I/bkn2A09qY61vHdgcyIrSdAFpJYAzdxoCOv0tOs9udHFHGWL+WRsQADd0wyowGi1ezZh6gh0ytd5NBjKDAHDKsoGFfQ7Ea3UoueryPTaomS8U9/8q/9asLvkuk2WGdDrMZQVPKORpRYg7DJEAB7DCHPbqpB9/HLw5IZ6pxjV7jxo3YDNSPpIDOThu1QuGn8/5GbA3xmd1IGqT7asQhdK1zVLFeoKmWEx9MF8THZI8SC/dA9hsHtSgVFuvC+JnyNYe0PXeYQLKE68/5AblhCm+YFfyoiaHTaYZtEKIq8YMJCqqJK0SI4azC4Ff+15YL0rANOeKlx33PKXVsuzOOE8YT+etUuxSensH9r9NiQHsZ6+vB+UQeXTIlRqm2pukLTr1du0m2YTxHc9NmvbFhgOTYAm+VA5HkPd/rWBQa0FPggAFd7pTKE8eqBYn9Kct/quvCf/oZtmdUwf1zcI6Zj3zepjA2pec+u3pxgVmVr63YH5c/KQRchbGI0knatLLLlVggxXqZJruY0lG0OUuCkSAChWRr7jS7SkRWCfxwu5eoWwo8AxO/3Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(7416014)(82310400026)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KQRPIA+ZP7dmBaBcrSv/qJMk9aa386UuiFdY27UJHQHrp8J7fGYT2wvLs4A7rannKWBe/SwuOxS7+qEtrfnIS/gVNBs+PnMOIjPVKaKd0CxZvLsRIueGIBtviSiGX7Y8qzkHeLWGI1gXEJS8JBE9OyYGl/+7BjhyvlIvrxo2ozyrPtuo5au8e4kOK8gN+ooL6RGYSL4Q2/vYYsWQGC/FhxAk3X68C3Tt56TRkiznoTsu8yUCADkm+d4La7OwxBya7Bm9FHgKg9N86XgG5Qw3u4Et1XCusMosdgo0YMTXyorHZfEutaisj2JodwAMDArhktxWvHk5GLzVDtLfsxp5fQ2wTJ9d087fyiM2oY604oDdIpqJoqpE5fQeKwcVehDzNfLFq7N1FOAHjMhP6KpLJJZz4AKk8R7MtC99xc4TRCgbcWW5+ephLOw31A9zuCXB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 06:18:15.9074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bef2cb12-68c9-4ebc-6522-08dee16fb108
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8239
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23174-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0210A7516B4

Apply parsed devlink_eswitch_mode= defaults after devlink registration
and after successful reload.

Mark the default mode as pending when a devlink instance is allocated.
Before devl_unlock() releases the instance lock, apply a pending default
when the instance is registered.

Clear the pending state before calling into the driver so the boot
default remains a one-shot operation even if the mode change fails.

For successful reloads that performed DRIVER_REINIT, devlink_reload()
already holds the devlink instance lock and the driver has completed
reload_up(). Clear the pending state and apply the default directly from
the reload path.

Treat an explicit user eswitch mode request as consuming the pending
default mode.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 net/devlink/core.c          |  3 ++
 net/devlink/default.c       | 70 +++++++++++++++++++++++++++++++++++--
 net/devlink/dev.c           |  6 ++++
 net/devlink/devl_internal.h |  5 +++
 4 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index fc14ee5d9dcf..cea4afc27dd9 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -317,6 +317,7 @@ EXPORT_SYMBOL_GPL(devl_trylock);
 
 void devl_unlock(struct devlink *devlink)
 {
+	devlink_default_esw_mode_apply_pending(devlink);
 	mutex_unlock(&devlink->lock);
 }
 EXPORT_SYMBOL_GPL(devl_unlock);
@@ -429,6 +430,7 @@ void devl_unregister(struct devlink *devlink)
 	ASSERT_DEVLINK_REGISTERED(devlink);
 	devl_assert_locked(devlink);
 
+	devlink_default_esw_mode_apply_pending_clear(devlink);
 	devlink_notify_unregister(devlink);
 	xa_clear_mark(&devlinks, devlink->index, DEVLINK_REGISTERED);
 	devlink_rel_put(devlink);
@@ -490,6 +492,7 @@ struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
 	INIT_LIST_HEAD(&devlink->trap_group_list);
 	INIT_LIST_HEAD(&devlink->trap_policer_list);
 	INIT_RCU_WORK(&devlink->rwork, devlink_release);
+	devlink_default_esw_mode_instance_init(devlink);
 	lockdep_register_key(&devlink->lock_key);
 	mutex_init(&devlink->lock);
 	lockdep_set_class(&devlink->lock, &devlink->lock_key);
diff --git a/net/devlink/default.c b/net/devlink/default.c
index 8434af83ea69..77cc356dfac9 100644
--- a/net/devlink/default.c
+++ b/net/devlink/default.c
@@ -10,6 +10,7 @@
 
 static char *devlink_default_esw_mode_param;
 static bool devlink_default_esw_mode_match_all;
+static bool devlink_default_esw_mode_enabled;
 static enum devlink_eswitch_mode devlink_default_esw_mode;
 static LIST_HEAD(devlink_default_esw_mode_nodes);
 
@@ -154,6 +155,7 @@ static void __init devlink_default_esw_mode_nodes_clear(void)
 	}
 
 	devlink_default_esw_mode_match_all = false;
+	devlink_default_esw_mode_enabled = false;
 }
 
 static int __init devlink_default_esw_mode_parse(char *str)
@@ -180,14 +182,78 @@ static int __init devlink_default_esw_mode_parse(char *str)
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
+void devlink_default_esw_mode_apply_locked(struct devlink *devlink)
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
+void devlink_default_esw_mode_apply_pending(struct devlink *devlink)
+{
+	devl_assert_locked(devlink);
+
+	if (!devlink->default_esw_mode_apply_pending ||
+	    !__devl_is_registered(devlink))
+		return;
+
+	devlink->default_esw_mode_apply_pending = false;
+	devlink_default_esw_mode_apply_locked(devlink);
+}
+
+void devlink_default_esw_mode_instance_init(struct devlink *devlink)
+{
+	devlink->default_esw_mode_apply_pending =
+		devlink_default_esw_mode_enabled;
+}
+
+void devlink_default_esw_mode_apply_pending_clear(struct devlink *devlink)
+{
+	devl_assert_locked(devlink);
+
+	devlink->default_esw_mode_apply_pending = false;
+}
+
 static int __init devlink_default_esw_mode_setup(char *str)
 {
 	devlink_default_esw_mode_param = str;
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 119ef105d0a7..611bb6bfd492 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -478,6 +478,11 @@ int devlink_reload(struct devlink *devlink, struct net *dest_net,
 		return err;
 
 	WARN_ON(!(*actions_performed & BIT(action)));
+	if (*actions_performed & BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT)) {
+		devlink_default_esw_mode_apply_pending_clear(devlink);
+		devlink_default_esw_mode_apply_locked(devlink);
+	}
+
 	/* Catch driver on updating the remote action within devlink reload */
 	WARN_ON(memcmp(remote_reload_stats, devlink->stats.remote_reload_stats,
 		       sizeof(remote_reload_stats)));
@@ -731,6 +736,7 @@ int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
 	u16 mode;
 
 	if (info->attrs[DEVLINK_ATTR_ESWITCH_MODE]) {
+		devlink_default_esw_mode_apply_pending_clear(devlink);
 		mode = nla_get_u16(info->attrs[DEVLINK_ATTR_ESWITCH_MODE]);
 		err = devlink_eswitch_mode_set(devlink, mode, info->extack);
 		if (err)
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index fe9ad58515d4..97f53394b1c0 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -58,6 +58,7 @@ struct devlink {
 	struct mutex lock;
 	struct lock_class_key lock_key;
 	u8 reload_failed:1;
+	u8 default_esw_mode_apply_pending:1;
 	refcount_t refcount;
 	struct rcu_work rwork;
 	struct devlink_rel *rel;
@@ -73,6 +74,10 @@ struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
 				const struct device_driver *dev_driver);
 int devlink_default_esw_mode_init(void);
 void devlink_default_esw_mode_cleanup(void);
+void devlink_default_esw_mode_instance_init(struct devlink *devlink);
+void devlink_default_esw_mode_apply_locked(struct devlink *devlink);
+void devlink_default_esw_mode_apply_pending(struct devlink *devlink);
+void devlink_default_esw_mode_apply_pending_clear(struct devlink *devlink);
 
 #define devl_warn(devlink, format, args...)				\
 	do {								\
-- 
2.43.0


