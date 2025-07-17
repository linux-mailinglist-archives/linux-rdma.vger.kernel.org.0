Return-Path: <linux-rdma+bounces-12273-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A21B09160
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 18:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491A717F7A0
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 16:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD342F94BA;
	Thu, 17 Jul 2025 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tt8iLjmF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEF129E0ED;
	Thu, 17 Jul 2025 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768523; cv=fail; b=vGtlZicBS4Awb1CoUIcBO/XPuBlepGyHFLGsf1e8klLWynz5IdN4gMgiqgv7XJL+gzL2Z2ys6vwM0vVLyAAMAoDrmbwKCYe1KCsJWx8y0lBlfzKBCrGWGXdQP31UQ/jJyR6incKC697HSt6v+QMAeB+JrIlLkzslOiKEAtfwiIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768523; c=relaxed/simple;
	bh=djEfupWRQre7PYToNx1j48pjAhodVKXaMyCs53GoRTw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NG+0A5h/tfGk+XumHD/7Jkesw4jUSE/PY2Ki7Y1f8yZMvcKogg9Ez4l1kXZ2583poZ2/IQhm7lntzL/qOdQ0OrQ0P2Spg3AqyY7Gud6SZNOO8+vcxhuvyw5eobX8lxeYxYxc0UQBOYBMzmQ4KLdpziH6+lVmAQJv6oGj+2zYexI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tt8iLjmF; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUBMzVTL8hHMsvF47lBJY7v0geGsATuj2O2CsdfCfYkF80rksI+lCp34lSd3sRToY7gJlOYv7A/CQKW8r6tnboSHLHTJ/KmEdv7JARw8xrk42PCARew5elLkyLVfCSmVohf5xYSZb5WDa1C569L+1nA1aN2dK1ARQxBO5LY3kZCdrq9GZVV59BwZYcJSrby9oO7xAiVllwax13PDI6aL0J+eh1IeDJDpJT8Mjk4ejXJI3FQKo/5kz1kpUnqQpYXJ4VJ6lX/tAsyI0eiGWOQIsl4Z7lF9MAG6rkHbr9DqRsxEQH0peufeasnHCSj6NrTSO+ZDzv6XVTu92btpGdXGEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KOPuCd8eutcgbxve+/zRhFajZqGa2hG++hMTMX7NUo=;
 b=zQ5juYimuoFGHlq7g6+tTCsfagn2Lc2iFF/lU/a6Oo0uxG71cabe6SMuy3xysHTAWu2tnwkD6Z+2bZuXPLwMyfc5E60d9YusEHZrIc96QzyglXERsaHH2q3YCjv5ZwrI0wXTtPVoSyIDRt08Zt2jWwtCB1f6q6yTAZWBPISSAoS4CuyQBEQH9irhQ7Y4ZeRE5qWUsJB7mtT/e6Jx9ebbJOUZfl+kQm2LNT5VBFfPv4/XXU/ybfCwPQbU06DbGMtttLDqV0qezEJPuUGXJkapsILei/gQLUIRZhxdV8xn+2b5rCrGNjFWLHFRf4qff0Rcmk2vF/LL/vzZOsEI/K1gCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KOPuCd8eutcgbxve+/zRhFajZqGa2hG++hMTMX7NUo=;
 b=Tt8iLjmF1JhEYMeftTHpocaaoBntId7xtJalcSMvak8J8iUVAyzKZb4Na+gf/AMkdH+BJAaZAQi3xjuu7bCx23BfadbXvNXAcByA/dQm67P/YyXzwQIMc3IjKpVzx73o4Ep+R/j7ruZwqDF/4HGxkCktECkD9hAQ8zmKTe2gTShf0rPfmvfLr725DTlIg92DY7VrBkHxJpRBHGFjk8DXC8qo+QUTCnNsg8AZ7euJcMpPqmdl8gJDjhA8ETfR2sIq6z4nf00yr9d1CbAiC+NqUw27IMr3TFt23ApnmW5Um7HWiUc1+qDq9PnjKTiu6Tcf4XMfZYrBw1TD6pNzSBsKOQ==
Received: from SJ0PR03CA0227.namprd03.prod.outlook.com (2603:10b6:a03:39f::22)
 by IA1PR12MB6554.namprd12.prod.outlook.com (2603:10b6:208:3a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Thu, 17 Jul
 2025 16:08:37 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::2d) by SJ0PR03CA0227.outlook.office365.com
 (2603:10b6:a03:39f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Thu,
 17 Jul 2025 16:08:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 16:08:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Jul
 2025 09:08:16 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 17 Jul
 2025 09:08:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 17
 Jul 2025 09:08:08 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>, Jiri Pirko
	<jiri@nvidia.com>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Shahar Shitrit <shshitrit@nvidia.com>, "Donald
 Hunter" <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, "Brett
 Creeley" <brett.creeley@amd.com>, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Cai Huoqing
	<cai.huoqing@linux.dev>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Sunil Goutham
	<sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad
	<hkelam@marvell.com>, "Subbaraya Sundeep" <sbhatta@marvell.com>, Saeed
 Mahameed <saeedm@nvidia.com>, "Tariq Toukan" <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, Manish Chopra <manishc@marvell.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<linux-rdma@vger.kernel.org>
Subject: [PATCH net-next 2/5] devlink: Move health reporter recovery abort logic to a separate function
Date: Thu, 17 Jul 2025 19:07:19 +0300
Message-ID: <1752768442-264413-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752768442-264413-1-git-send-email-tariqt@nvidia.com>
References: <1752768442-264413-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|IA1PR12MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: f3a5c4c2-0bf3-4101-653a-08ddc54c2ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4sEIRsKDfVrmruYXwFxcmfzxvqtQ61/JmwKFl3fvutEtbWGs8A8a/MZ5/ggg?=
 =?us-ascii?Q?fxeHf5+tIHxBnIQWnfZMhWt4KovCmorB83mLbZ40tuajc2VxIKU1goGc/M91?=
 =?us-ascii?Q?duFdx2ycQJkw4pO2Tl9gfv5mt3f7ZaJkTyJmzeJclKFsCOtDnx1QWwsZYV/k?=
 =?us-ascii?Q?/M8KfxjtzIHgUtpjq6DVk5NMayyjjz/11qrWOJUWrqlvpZGZ7STK26bju8Q/?=
 =?us-ascii?Q?aVN1wQ/8dOPr6xprvrm0UlRmUHHA+aH4k3macZ8LyClRAIDWGyJmZEj11hxH?=
 =?us-ascii?Q?TJ0UvjcSr8CpV3Nl9rl+esST0BKtWSbJE9o0VUftkgjadKtpUVrZW+9uC4ju?=
 =?us-ascii?Q?tNsNDjl7B9mUGdLqmlaH8E1J9Duuj0hYt6BiOXqSsoyLjf3D5Pc+7VHpdTwF?=
 =?us-ascii?Q?Tjl+lNifzMAFX/r2lBPU56tFgJp6rbkI7zXDUoVM5rdhWhKUq0falbrCho7j?=
 =?us-ascii?Q?xd24D56RTiGNC0YaIAHVUfs8PYB7nJRTGiVxH2iW8Ad9Obed0Umx4ZnP7e8F?=
 =?us-ascii?Q?/Pf+dch21eJLjX+/v/v5+i9rRDjm55SAlsVajw8Fbx5LcmrQ7ecxEI9cVbbN?=
 =?us-ascii?Q?O7i1MX4CfHSo4PAy24BFtW0NwQPzr+kTS+9uhniZ61ovNsHqthG1Cwcn64JU?=
 =?us-ascii?Q?ch3wgwgtGfLJWEnwcRZj/pCU7dlojRAOrHyvJHvu6llR7q2vLE2HWClIeBHz?=
 =?us-ascii?Q?1bFmbF2y76UsJBaOT383gs0uYBcMNHYtAvL5Ont48f4PviY6koGtyn8wf9eE?=
 =?us-ascii?Q?PB0QdAemlCplIVgxNDK6P000HsK3zZCtuyx98bIaR5Ih6EIhUXCuvQqzSgh4?=
 =?us-ascii?Q?D1FU44lYkedLRyO0G4C9INznrTLfzWEQUmAA4ht8G4b8f4jPRxzZVI2IoQeZ?=
 =?us-ascii?Q?Ms7xqS2mRiLELRQ8ZVJbNoHDOI6umb/K4+7HHSMD441PnY/p/6tnB5m37cir?=
 =?us-ascii?Q?fhT4skBkyvE9/ens7gqQU0VszoriKT1+yCdMvwiYoL1Icp+bT0nPIu/xgepF?=
 =?us-ascii?Q?ZvQBMEgbKdr+g+PT2MZhXlDJwWq1PRRrb6ULRei2CguQaD6TVohhJJtjyEBS?=
 =?us-ascii?Q?RINk6CsA1ElQf7bvFrimfV/jYzK4OKrCGff0LpZDSOd12kkgUhLKjXOmUeoZ?=
 =?us-ascii?Q?QmeC2giMNLrtohIB0Szz9eMKpyYGALSQTSkLV8nenN3RjQqxaVFpHUsCzQS+?=
 =?us-ascii?Q?vzG+Xzwz7u6W2rJazGdkJeELWwAnOxHT9CwUvOhH3263hsDEuEHkq1Mts2qX?=
 =?us-ascii?Q?+Y5LjYD28eKKLjGZ9lciaScGT/t3r8d49aD9CoZYh6ttT0EtjOBuEXcL4fK9?=
 =?us-ascii?Q?2nvsaAJ4+m6d17xfS0ogZSzbBSfBBeSt0Pci7VY9PtIV51eQBfJUZf22Rxas?=
 =?us-ascii?Q?41DKBnqdhgqTUlY95okYF526/l43iLXFlwJoFUswBG+sb/+A/dae3kS6M+Vx?=
 =?us-ascii?Q?eBm+q6NbzGmfNOoVeSCBw32qpKMUwCnFTQBW4S8WLwhmOmK/jRS4hJcjLE3G?=
 =?us-ascii?Q?Gnx1TUrri3/5/ZkaqZQ6lzRuGuqnYgYobkYX?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 16:08:36.8592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a5c4c2-0bf3-4101-653a-08ddc54c2ffb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6554

From: Shahar Shitrit <shshitrit@nvidia.com>

Extract the health reporter recovery abort logic into a separate
function devlink_health_recover_abort().
The function encapsulates the conditions for aborting recovery:
- When auto-recovery is disabled
- When previous error wasn't recovered
- When within the grace period after last recovery

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/devlink/health.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/net/devlink/health.c b/net/devlink/health.c
index ba144b7426fa..9d0d4a9face7 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -586,12 +586,33 @@ static int devlink_health_do_dump(struct devlink_health_reporter *reporter,
 	return err;
 }
 
+static bool
+devlink_health_recover_abort(struct devlink_health_reporter *reporter,
+			     enum devlink_health_reporter_state prev_state)
+{
+	unsigned long recover_ts_threshold;
+
+	if (!reporter->auto_recover)
+		return false;
+
+	/* abort if the previous error wasn't recovered */
+	if (prev_state != DEVLINK_HEALTH_REPORTER_STATE_HEALTHY)
+		return true;
+
+	recover_ts_threshold = reporter->last_recovery_ts +
+		msecs_to_jiffies(reporter->graceful_period);
+	if (reporter->last_recovery_ts && reporter->recovery_count &&
+	    time_is_after_jiffies(recover_ts_threshold))
+		return true;
+
+	return false;
+}
+
 int devlink_health_report(struct devlink_health_reporter *reporter,
 			  const char *msg, void *priv_ctx)
 {
 	enum devlink_health_reporter_state prev_health_state;
 	struct devlink *devlink = reporter->devlink;
-	unsigned long recover_ts_threshold;
 	int ret;
 
 	/* write a log message of the current error */
@@ -602,13 +623,7 @@ int devlink_health_report(struct devlink_health_reporter *reporter,
 	reporter->health_state = DEVLINK_HEALTH_REPORTER_STATE_ERROR;
 	devlink_recover_notify(reporter, DEVLINK_CMD_HEALTH_REPORTER_RECOVER);
 
-	/* abort if the previous error wasn't recovered */
-	recover_ts_threshold = reporter->last_recovery_ts +
-			       msecs_to_jiffies(reporter->graceful_period);
-	if (reporter->auto_recover &&
-	    (prev_health_state != DEVLINK_HEALTH_REPORTER_STATE_HEALTHY ||
-	     (reporter->last_recovery_ts && reporter->recovery_count &&
-	      time_is_after_jiffies(recover_ts_threshold)))) {
+	if (devlink_health_recover_abort(reporter, prev_health_state)) {
 		trace_devlink_health_recover_aborted(devlink,
 						     reporter->ops->name,
 						     reporter->health_state,
-- 
2.31.1


