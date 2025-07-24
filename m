Return-Path: <linux-rdma+bounces-12463-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4A7B112A2
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jul 2025 22:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4D11C24446
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jul 2025 20:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8942ECD39;
	Thu, 24 Jul 2025 20:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qd+XWY5J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C882EBDDE;
	Thu, 24 Jul 2025 20:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753390259; cv=fail; b=nRfwdEIJWwrH7eqsQdbgtueu6KpWerIEfMVotHZAgKUs9OkpSor4Ib8eukncEQ2xJZ1rkJJMLYsRYl8x41DXKbG/DcbKwHiLPHPBB5zM5df/omWDfxGKVCC7L721xru5O+POTmHrpYbXKmwvOeJUBBVow7Aw/Y1Gf9zWv1AyFqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753390259; c=relaxed/simple;
	bh=TwZPPMblzIjxCnzBgEjNraazTzu+Z2j0GQjcnHgWnKo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YqN9xD5OZx5h3geKjaroot3uQc9uw5vNEQNRBiGm/23KeDccecoZ4P/Lkl8rT6Re8DH2XmdEs3+HyHC8otV3N0LYpkAiVGLw7mdMQ+dH9HC7xhYgImEhMop05IcEs9rT0DFuIb2HcBT2WFAFqExrJfK7LghY6R2mSwfi/Ofk8aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qd+XWY5J; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAxQZh70N/O8+exfedv+kBRCARdZMzSLs2R6AdZS3vBgVTu7wcTk06Dcy3REawtKWnxNZvCyXQplheoQDhD9pBbEJyBLOBH5k2Obz0dyRUzrENFsAOOyuhCDsBt277lpDZpcMoBVWGqEjXIRY4xS3QFXYOGFAC5Zza7G4Alpl7Tofa7nhauORUo8jW3qR+g7wJMYlM7O7sFlPrRcWXykHA6l83CQanCJl5mlPMRSwhO2NbNoOofbjT8fzrVR+m+wXaTeSvSQxOertUMdhVQZM5pGUhnVJGc/b/DdyE7oztrXNcyvBR3IsE41+b/WhLl72H6WSBNpa7nzXqj4bqKmnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2VsP58gcTBgl+B7yHn1gkPfe18/m3I0VOOzDPttrck=;
 b=musdSc7kk2UWrCvDjOKmw9rjKsUUVBv/Wupx7tiCgDGizs/viOOxqIgVAjr3QNmWGL4+w2I9aMVEI+apba4YBk12jp1L2HSCQ66gcw9bhGLx9KYcFCHavimxVMKfwPLSb70aWwqKm3AcNS22lE0lOKaBm5IcB+cWrMxu3WfApkP4OO/AjHF0UBKYyQzzDEqUbhyRYzSZzmOqgSVH0Y44Rv2BEBNv9OwojclkqlPhWVXqFRzZtYBMDcOdvVqcM1U4/f5hd50Zzuee3gtxV8P3aWF26yGR86wZWk9gB8k4QYYl4NhkT8nuOukdmXo/P+T9QUuyXK2Jaj191Br8gYnu8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2VsP58gcTBgl+B7yHn1gkPfe18/m3I0VOOzDPttrck=;
 b=Qd+XWY5JGCunyvGFrHtenWQaI9MsDvYoa6BIX8Yxsbbz02tfAEv7YhPrkcR0EVAkgKSczQ6tfgqQLtcltit3D0uit4q2MUlX83gBPcqOwmvopJMlLuH1+LFwWh3wsCw/QviOt/UwfBBg10HlP+TzpgBkB3RAB7+LoTi2S/19AqMd9YzfIUYbXNFp36fSdBsDLhBFdZ0yiRvchyS9WeIGLdDp2lzu+LKgt6sgXpijW4FOsnj5vUggo9b8Pq9shBP+aV/0LAXCy/NGK+lV0VVnGbkhDsmCUnV5eblfzdYCV4dwd+7MNRHFn5PHcA8ym+18KxORK0QNZDBRkCXa2PdR4g==
Received: from CH2PR10CA0019.namprd10.prod.outlook.com (2603:10b6:610:4c::29)
 by DM4PR12MB6544.namprd12.prod.outlook.com (2603:10b6:8:8d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.22; Thu, 24 Jul 2025 20:50:53 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:610:4c:cafe::f0) by CH2PR10CA0019.outlook.office365.com
 (2603:10b6:610:4c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Thu,
 24 Jul 2025 20:50:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Thu, 24 Jul 2025 20:50:52 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 24 Jul
 2025 13:50:37 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Jul 2025 13:50:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 24 Jul 2025 13:50:29 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Jiri Pirko <jiri@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>
CC: Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Brett Creeley <brett.creeley@amd.com>, Michael Chan
	<michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, "Cai
 Huoqing" <cai.huoqing@linux.dev>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Sunil Goutham
	<sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad
	<hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Manish Chopra
	<manishc@marvell.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-rdma@vger.kernel.org>, "Shahar
 Shitrit" <shshitrit@nvidia.com>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next V2 2/5] devlink: Move health reporter recovery abort logic to a separate function
Date: Thu, 24 Jul 2025 23:48:51 +0300
Message-ID: <1753390134-345154-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1753390134-345154-1-git-send-email-tariqt@nvidia.com>
References: <1753390134-345154-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|DM4PR12MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1d5d1d-5086-49ac-8527-08ddcaf3c751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qZL4j/LnUNMQhflhCqJATJ/wl0bSvqRw4f9cT5EA0a890tU4DSjjyRsOgjjA?=
 =?us-ascii?Q?EbqsNTJxTZ3eMh6b4p7Z4YkW2nvWiz6UXT8GJhLmtbK+X87euzsanCe2R48S?=
 =?us-ascii?Q?pwEazxbAYPDGwPmIGlyhX7veDpRljOG2sycnloPaew5VObCsy/5Lszm4ttHa?=
 =?us-ascii?Q?cS725WMKmHerf2DuB89RrniTG1h/Yuxmf7KITdBcNV0xA7V4v4ZERDUbOYck?=
 =?us-ascii?Q?1GdG83QRfoS0r/KLd2Sac0LokL4o1QmUMAvahQrZS6h+z1KbyWHB/mJLMtSh?=
 =?us-ascii?Q?XmSQJOYK8rsvMmNAA4Qmwgv67C6G2nGupE+qAda13qDBHRBz0x1B8Hz4RYfv?=
 =?us-ascii?Q?DJESJn/kU7zldmbt3rgTPh7z9QKZy0u+SWoi3O5cH1bJy2+TkEE+H9r7JBZF?=
 =?us-ascii?Q?GP0YrHtYsLjGJmv8ewU82qPYAzgTw8uZqNd+ScQqhu2qH1YV2zd69tTbh414?=
 =?us-ascii?Q?A6iZ8VmjhOgOs95ETPlAbKlk+Q2Ar9w9fOLzguilOPIH6tsWt2PtaIn81r5A?=
 =?us-ascii?Q?0hPdcUKjzAeWQ4etfa8RzDvTihPhdly3o3gq2+5o1cmABALltQ6++5Sh/rxY?=
 =?us-ascii?Q?gSEdsCRwhy9oHZKTle4iN4L+1IB30PSxS6u0wsVOvA6QfFLQ18sTi7nUdwpK?=
 =?us-ascii?Q?wWwDuWi0IJVsaFrbnYlNEMgNaxBKrqhA+5yqRq7ghkX+Bse/ufbRxcePwz/K?=
 =?us-ascii?Q?yehp8fZ1oiLo1MRjq/CQWgB/GVbhnuE3Ggs7qiIHdYg32fOagvMJR9I/kLQR?=
 =?us-ascii?Q?m39nseWye8WPltQqaQyTH5vES3olNUvlLL04sllz+mYBF1wW60KskG/hbNk8?=
 =?us-ascii?Q?ZLBZSUegNF4YBJXROZIXVXsyWvX7EbncO9jP0UWV+Zs5WgIgs6KgeJ0hLEZJ?=
 =?us-ascii?Q?nyKF64o30lHv50bUywwJvdzR0J+qc8WEXINmp7eM3ughV43kO/hon/Ce0WkP?=
 =?us-ascii?Q?4QBYodn2q+jQnMpanSqamUU7LcSUFGjnq87J4+3am8p4HL+4d/219BSxyzbi?=
 =?us-ascii?Q?wBg86G61300Z4Rk6SPteE2G9rhee4Y8jpB6WLD/Iloeek9Z5yxHYsr1N9Fh1?=
 =?us-ascii?Q?Y9LKVivTu/y1rQtxugeJm3l5EODWis8WR7XqJK7Dwpk61sLWDcSUA2hBzr+O?=
 =?us-ascii?Q?qOMtdsoULJAkbegNY1J14ElPHF5/RUaxqu/CNHiy5HO8iDpe8TEThdR+pLjx?=
 =?us-ascii?Q?92Zkujnl9Te46ImRk/9RVPBlIIZwEOhco++O9oZLiTnJ3+oqSq7rHji+GVW1?=
 =?us-ascii?Q?Sz+ephou1mkrmLsdTO2882xcfuRy/960bBsc+BXD3yUr8nAvLMY0FZjDf2W3?=
 =?us-ascii?Q?tTD+qKeJK/mCrpDFcjRyimVTRGyQsHEtaf2zFR48/nrMhbK6sQxpDjWbRnwu?=
 =?us-ascii?Q?RIKgzt3S7xEK/7WbVqgoAjxWBHpVCkRmCvAHC+lHwyQnft/5FcRu2CY9AXeE?=
 =?us-ascii?Q?7Eq1Hau2v8jDEB9xkZvSKozuz2o3TnrDEDU+lq1D4hahUkVCfalQ+b5r7VOB?=
 =?us-ascii?Q?8ESbboc5Sp6fcLlJrlH9H2Iu+nBozHvF3+9W?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 20:50:52.5319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1d5d1d-5086-49ac-8527-08ddcaf3c751
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6544

From: Shahar Shitrit <shshitrit@nvidia.com>

Extract the health reporter recovery abort logic into a separate
function devlink_health_recover_abort().
The function encapsulates the conditions for aborting recovery:
- When auto-recovery is disabled
- When previous error wasn't recovered
- When within the grace period after last recovery

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
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


