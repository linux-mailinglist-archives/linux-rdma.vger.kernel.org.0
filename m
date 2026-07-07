Return-Path: <linux-rdma+bounces-22846-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 47I5CmQ8TWrYxAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22846-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 19:50:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 853EF71E6AF
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 19:50:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=aivXDhDB;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22846-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22846-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B2EE30347ED
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 17:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B38043F4B1;
	Tue,  7 Jul 2026 17:46:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010011.outbound.protection.outlook.com [52.101.85.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819EF43DA40;
	Tue,  7 Jul 2026 17:46:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446384; cv=fail; b=qccUWahexmW2/tnm0ehzKFUkN7jXCeVYxVFj0q2U/mFuks8DnDCCydIDH+Epihm8lfQ27Oo/BS3naStmaBMpbOuUz5V5JbwDed7OuCGpPd708GJ3M6Dj4e0+ENljZV5TDd2P+BXYr7TyXo7lQ1sPyp5hT9kR0e2K3pGAkO7V59g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446384; c=relaxed/simple;
	bh=73rUuUUC9yJI5sO9kWDmu3xt4X0nSrOU3H4QG8K05PE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UyUMiayzpG+6vw3GMeV8u5Fn4/3Ryw+4B1sjYASEEYhVoZTnAKePIH3UUbuMA45lkS+ETZjr3yzMXOq2LKgOBxNcSKZ6iWXgrTEqVIX/VaT9wJqiFmBaeV0JPjTnpixDZZ6k2ugiyh49w8LtUx84uZwi1ED0L1bG2gBn+CE1AYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aivXDhDB; arc=fail smtp.client-ip=52.101.85.11
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myfp6i+Ed2xU9xcXTi4Ybo1en5Uuu4z3wGVT9GifIgvcgCcRMuqRl1bh0nUofYJ5Ro3tPyxNmAemlDpKtQXAW2y6gSd8nmdrzYTYg+O3RAwHGXWUsxR0dwnnnrIHzFGfobDe6+Nd8fEAm2bdslNsFDzWoFVhjpeHwK0dXCP/+KgCH+XuPuKKAlGr/UUe/9Nv1ZxZGUBdJANUbOu8a6VGTjmAapvuDjglpA8VhNVKcVD8abuMpHTDctoYYfgKZB3TG2vXMAZaKEI4LkiNSRyqPBO4N6XRIlbvs8Up06f/waEP2SDYRMusNAjXJ0CfcOxHU9gp6rECXX/eBNIE5dpsPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIxJIDCifKOkqTScZ2Y9mSm3JkiKa6OQDmW/5pAszX0=;
 b=cqQKQUsmUIxpRw7m+Z6XFxn6gcokTuzalQo/+yKgSO+azcJPTZgNUD66ROZ8MEDHu0H/YYClfdGkhiVNYLTwgMH7L6V+87Tl3yc754a9unZzinZhbJi8ulxdNs7jJ3+kGJpFu76lnKqj4n02nt6yrh4CmBQYF03ECY0Rp9XBbb81l31HIfh4suSFCRTzEIF8ksD2imQq+1+mZqKhn70TwPJCGrkeXQ+/ktOTRW+Mt0DoQrBdgrgRNqgFnz3s4ojrJYIvNYrOyQ9syqouAgt1K3aoquLdgLvmdYREeprKYw4od8jKjTNd3VvWcwQJEH4PoLjts1e3kXSgZl1Fu6mZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=resnulli.us smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIxJIDCifKOkqTScZ2Y9mSm3JkiKa6OQDmW/5pAszX0=;
 b=aivXDhDBWLTsILWPBo0PbE7Br81iCSyJAsN4Zfv/cXXEGEBm7lCEpfvvbR0qf4EHOLS7xULxK+pkQ0f1bH2TznnZaUE5mwwOEEpi0eR0Wo2/457BfvgNcumPWYVLObx27Pu/Jktad8U785F45xE8mf9b6ZY6Rs40LP6TjECJ/fl5XbmImrQl/i6u48y4hW/PRoKYIisiP84MaE1ZtOrY5wr3JImUqisabuckBxuHWPPKyG6J0GLcaKvsx1Dz/w4YL6ftWEPO5W6Nm3qKZyOzjPqF6XidNy6CLL6GCeBB/T+nO2IDdoo9O7LX8UWenBMeX1wbZy4Yq5BcVsNPixtFlw==
Received: from DS1P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:453::9) by
 SN7PR12MB7107.namprd12.prod.outlook.com (2603:10b6:806:2a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Tue, 7 Jul
 2026 17:46:13 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:8:453:cafe::6a) by DS1P223CA0013.outlook.office365.com
 (2603:10b6:8:453::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 17:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 17:46:13 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 7 Jul
 2026 10:45:52 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 7 Jul 2026 10:45:52 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 7 Jul 2026 10:45:48 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next V5 4/6] devlink: Apply eswitch mode boot defaults
Date: Tue, 7 Jul 2026 20:45:25 +0300
Message-ID: <20260707174527.425134-5-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|SN7PR12MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f533d39-e741-4dd7-cb8a-08dedc4fa373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|23010399003|82310400026|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6JsG32zd0EPlZQ41FR2uQZy4sZ+7GyLacPVML4FnSad22IGzmrtCZn8HVxg+UNar16i5EQjcl17bzvgb4zjyHcpL3VJN+FYBvaMrA+pcCZbw/U8okfDn9f2OEX0Y4i1tQJro9j8cyRn3VtVzKL08VP8s08KPbr/0oHbBRYfqIUZBeMpGHUArduqE0ZAr0C9gAb0+cwaBUAtsFYFvR+OB+9FMez5m9amvVX9lIF1ICbPPjk9af5pK/05RewOledgvdvXrS0FYiP5M+zUFlekfwq+2Ts63A/wxF0gWC4LKp3l/Yb3szq/6K2Ladqu0rHOCmwNuQoNF9aBmhn4k8xADOuWGDDGD37exCELdfhJmVSHfCYJ6sH8UYkhPvTEQj/rEyrUk+KgKmufNCmUkNGccNYr4nMDFFYaFmFvu94RIlPzPlRzcVTDBYCug/UXxAwXQkRtmXE/mickrbOUubrIyolF/4Hz085cD+dMHPil7qEm1gA+QqpaAwvE2KnBUPHqxEQW4AoYiLSkYpafVrTW5QR9iBc1iF5VAtxj3MZKcwtEF8wX+X0OFVpnKKbNwpJFGyyPVaI4ClXUrUk3hWxEwc8PCTUbkWT0C5r1OavEo2oK47ctMvSdhhtm8QWGeBv4fBDMblbJnwh8vo+ZvHgtnD3eMU5M+NUkbH5wnGKbZtotLN9rkjTmbvoyhGO6rmBcGV1bT4dBE1MYLi9JW1JTIWg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	54Kk2QJ8mcrAiqIE7+8w6ORJjCRfiX3tZqk42R4uhQzCzpdoWq5+PwKb/txeEoXZiNuQwiPSXbGPM6MUbeiap/QaWX/dJCPr7+3huA4Kmp4tI3CQ3m+SR0By0iQG4xdvetB9mPQzNMtD6EPcRqCkIGqiK5dTQ8A9Z6rw2HAMnV+zigxuvMRJoN1urjMEgosnzBOp9TmWVmgs8RynWzIOkvIccWqhvLVPIkfpk9bRje55CzAEXomPaiJdwiyFK2JNlK+z8TrcTOPXMNx0JyBghspHgDSXUY0aVV4irCf8i6LgK/LKx88iD72Q+6fHuapd4O2X13nXo9eFcB0IshriuziOaQ6ih6frOh9vJlkN0EfX3df0kXOHLxUMIuR0PMYIat3TWV4/5qiowAAYQzF4cy9oRtiaYFTAOJHJ2PVveo7uOzWdsfhIX7VXNLwEEuRn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 17:46:13.4687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f533d39-e741-4dd7-cb8a-08dedc4fa373
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7107
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
	TAGGED_FROM(0.00)[bounces-22846-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 853EF71E6AF

Apply parsed devlink_eswitch_mode= defaults after devlink registration
and after successful reload.

devl_register() may still be called before the device is ready for an
eswitch mode change. Keep the registration path passive and let the
regular devl_unlock() path queue the async apply work once the instance
is registered and the default is still pending.

The queueing path runs while the devlink instance lock is held, so the
queued work gets its devlink reference before the caller drops the lock.
The worker then takes the devlink instance lock normally and applies the
default only if the instance is still registered and the default is still
pending.

For successful reloads that performed DRIVER_REINIT, devlink_reload()
already holds the devlink instance lock and the driver has completed
reload_up(). Clear pending work and apply the default directly from the
reload path instead of queueing work.

Preserve the user configured mode when it is set before devlink applies
the default.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 net/devlink/core.c          |   6 ++
 net/devlink/default.c       | 112 +++++++++++++++++++++++++++++++++++-
 net/devlink/dev.c           |   6 ++
 net/devlink/devl_internal.h |   7 +++
 4 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index fc14ee5d9dcf..9d9cc40626fc 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -317,6 +317,7 @@ EXPORT_SYMBOL_GPL(devl_trylock);
 
 void devl_unlock(struct devlink *devlink)
 {
+	devlink_default_esw_mode_queue_apply_work(devlink);
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
@@ -537,6 +540,9 @@ void devlink_free(struct devlink *devlink)
 	devl_lock(devlink);
 	WARN_ON(devlink_rates_check(devlink, NULL, NULL));
 	devl_unlock(devlink);
+
+	devlink_default_esw_mode_instance_cleanup(devlink);
+
 	devlink_rel_put(devlink);
 
 	WARN_ON(!list_empty(&devlink->trap_policer_list));
diff --git a/net/devlink/default.c b/net/devlink/default.c
index 8434af83ea69..896146d1b8e7 100644
--- a/net/devlink/default.c
+++ b/net/devlink/default.c
@@ -10,8 +10,10 @@
 
 static char *devlink_default_esw_mode_param;
 static bool devlink_default_esw_mode_match_all;
+static bool devlink_default_esw_mode_enabled;
 static enum devlink_eswitch_mode devlink_default_esw_mode;
 static LIST_HEAD(devlink_default_esw_mode_nodes);
+static struct workqueue_struct *devlink_default_esw_mode_wq;
 
 struct devlink_default_esw_mode_node {
 	struct list_head list;
@@ -154,6 +156,7 @@ static void __init devlink_default_esw_mode_nodes_clear(void)
 	}
 
 	devlink_default_esw_mode_match_all = false;
+	devlink_default_esw_mode_enabled = false;
 }
 
 static int __init devlink_default_esw_mode_parse(char *str)
@@ -180,14 +183,108 @@ static int __init devlink_default_esw_mode_parse(char *str)
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
+void devlink_default_esw_mode_queue_apply_work(struct devlink *devlink)
+{
+	devl_assert_locked(devlink);
+
+	if (!devlink_default_esw_mode_enabled || !devlink_default_esw_mode_wq)
+		return;
+	if (!devlink->default_esw_mode_apply_pending ||
+	    !__devl_is_registered(devlink))
+		return;
+	if (!devlink_try_get(devlink))
+		return;
+	if (!queue_work(devlink_default_esw_mode_wq,
+			&devlink->default_esw_mode_apply_work))
+		devlink_put(devlink);
+}
+
+static void devlink_default_esw_mode_apply_work(struct work_struct *work)
+{
+	struct devlink *devlink;
+
+	devlink = container_of(work, struct devlink,
+			       default_esw_mode_apply_work);
+
+	devl_lock(devlink);
+
+	if (devl_is_registered(devlink) &&
+	    devlink->default_esw_mode_apply_pending) {
+		devlink_default_esw_mode_apply_locked(devlink);
+		devlink->default_esw_mode_apply_pending = false;
+	}
+
+	devl_unlock(devlink);
+	devlink_put(devlink);
+}
+
+void devlink_default_esw_mode_instance_init(struct devlink *devlink)
+{
+	INIT_WORK(&devlink->default_esw_mode_apply_work,
+		  devlink_default_esw_mode_apply_work);
+	devlink->default_esw_mode_apply_pending = true;
+}
+
+void devlink_default_esw_mode_apply_pending_clear(struct devlink *devlink)
+{
+	devl_assert_locked(devlink);
+
+	devlink->default_esw_mode_apply_pending = false;
+}
+
+void devlink_default_esw_mode_instance_cleanup(struct devlink *devlink)
+{
+	if (cancel_work_sync(&devlink->default_esw_mode_apply_work))
+		devlink_put(devlink);
+}
+
 static int __init devlink_default_esw_mode_setup(char *str)
 {
 	devlink_default_esw_mode_param = str;
@@ -228,10 +325,21 @@ int __init devlink_default_esw_mode_init(void)
 		return err;
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
 	return 0;
 }
 
 void __init devlink_default_esw_mode_cleanup(void)
 {
+	if (devlink_default_esw_mode_wq)
+		destroy_workqueue(devlink_default_esw_mode_wq);
 	devlink_default_esw_mode_nodes_clear();
 }
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
index fe9ad58515d4..c2bee5aabd49 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -58,8 +58,10 @@ struct devlink {
 	struct mutex lock;
 	struct lock_class_key lock_key;
 	u8 reload_failed:1;
+	u8 default_esw_mode_apply_pending:1;
 	refcount_t refcount;
 	struct rcu_work rwork;
+	struct work_struct default_esw_mode_apply_work;
 	struct devlink_rel *rel;
 	struct xarray nested_rels;
 	char priv[] __aligned(NETDEV_ALIGN);
@@ -73,6 +75,11 @@ struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
 				const struct device_driver *dev_driver);
 int devlink_default_esw_mode_init(void);
 void devlink_default_esw_mode_cleanup(void);
+void devlink_default_esw_mode_instance_init(struct devlink *devlink);
+void devlink_default_esw_mode_apply_locked(struct devlink *devlink);
+void devlink_default_esw_mode_queue_apply_work(struct devlink *devlink);
+void devlink_default_esw_mode_apply_pending_clear(struct devlink *devlink);
+void devlink_default_esw_mode_instance_cleanup(struct devlink *devlink);
 
 #define devl_warn(devlink, format, args...)				\
 	do {								\
-- 
2.43.0


