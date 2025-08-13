Return-Path: <linux-rdma+bounces-12721-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C27FB25381
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 20:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F399A2BD0
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 18:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD9D3074B7;
	Wed, 13 Aug 2025 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GrpmLrxG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0829B30748D;
	Wed, 13 Aug 2025 18:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755111433; cv=fail; b=juvP+m5XHCkORTjqtkPTdYtqoDtUxMNCHEEkt9MVzRd1ebzGqRDONniYuAZTOH0xRgR+HenTZ5N2QS6jOouKn4nOhlA1lmHIKHDfJsHgdT/Doz+yPP4JQsnpPgPBvL17p/vtfB6DtKipD/mCuQ85wcLgBBPkrGYW0I9QSH4SapA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755111433; c=relaxed/simple;
	bh=TwZPPMblzIjxCnzBgEjNraazTzu+Z2j0GQjcnHgWnKo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=faZOHiQuUhkixmQqcr6iHU168rseEuiiLbUV78i/Siq9xQ85ip9z+VwfKNmbSWtSOtR38hlvWNqCfgVj7mqFD9ZqZ/kSdrn/fIxpiNvctvgPCWYErWOizOu7NZUNzCkcZScBMmhAVTdWsgUCioyjC0582mUjXUs0jhzNE9cieBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GrpmLrxG; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szuOEC+zPo7J6cgL7u237wR5gykKH6f15xWcHNmYpq5sbvLyZdnpk22T5PL8/vtLF0GD/KxPN8coVzTZC6UUg92FcxVR86oKfbysRqYJSyhyMM9ZCdEnOhInJDw8nepoWhZLKrvV84dPiDzhzm3CXXM8BIIgWDIAIJgEYysA90VAjRWvLN6xqE+boPzHZZqqr9Uu+WNuljo4xFc8zn1u0mstLcAIyq+0HmT7a3X5LoEGS2wHQbfQACiw5gixRONFXORrn6F6+x7cV/CWGl4NfPGx830c7Zd0s0JQnub0RbnxO+11pOTEYSG8gpT8UgfykU0sS0+lNvvlj8u0M31AcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2VsP58gcTBgl+B7yHn1gkPfe18/m3I0VOOzDPttrck=;
 b=dNKweBPhsn7uxLJ5nGbclREaUlu5dnCmZbng5y3FlSWV4d2d9+RPqkQ3SioTWQiyJQH/KryziXpl+BACTRWJuMyBM7DD2RM/4ikA6tO0NDzQ3DqO+yjbMsHv1W95kd61RQq7WCcSYDP5svOAEUg2oPCUWNsVzZz4+xcYloH9fap/btKUlW4aZC4GNrdV/Lv6N5A2AE3NspQpS2XwRuDEWZ8vSDAZ7+W5/R7WW7+6YzYFury/aZMEpDXB/3WRJlEJfHQCx7Qa62i9MhCH4w145gXUtZvEjZPQggdIMAMHadI9xWJ4KmDWDYogGCyW22bqvyVz6Qhtvgcc8AiBxRn5nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=marvell.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2VsP58gcTBgl+B7yHn1gkPfe18/m3I0VOOzDPttrck=;
 b=GrpmLrxG32IwIQqtm5JIBnUsro/1XZKoUkJPaBL9GoSaQXnTm6rTcHzRJPRABvrhT8KDU+qeHbqJQaWTNhu0GXukezHQVac5b+N7BC0cYSS4c29fcRPRfUusBN+TZP2PzQ4HkRDemSEr5XhYnxiwve3lHDUVw9fNWTph+UJwtYqqX21OJXiIdhEZPgXg9I0sz54+HR1WPuYGPP210UmKI/5srlG69omq7BvkaUgiQPxjkOT62CMmDXNuiVP7B9iD9toi9G1e6lSKlVijWZl3VFju4PR01UI/TgG9owaFpZnueBt/teZmDiIoDPyugOElIPXjjm+gU19RmIt3sTRZXg==
Received: from BY5PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:1e0::35)
 by LV3PR12MB9257.namprd12.prod.outlook.com (2603:10b6:408:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Wed, 13 Aug
 2025 18:57:07 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::6c) by BY5PR03CA0025.outlook.office365.com
 (2603:10b6:a03:1e0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Wed,
 13 Aug 2025 18:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 18:57:07 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 11:56:49 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 11:56:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 13
 Aug 2025 11:56:40 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Jiri Pirko <jiri@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>
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
	<intel-wired-lan@lists.osuosl.org>, <linux-rdma@vger.kernel.org>, "Gal
 Pressman" <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, "Shahar
 Shitrit" <shshitrit@nvidia.com>
Subject: [PATCH net-next V3 2/5] devlink: Move health reporter recovery abort logic to a separate function
Date: Wed, 13 Aug 2025 21:55:46 +0300
Message-ID: <1755111349-416632-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1755111349-416632-1-git-send-email-tariqt@nvidia.com>
References: <1755111349-416632-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|LV3PR12MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: 875fa1f4-f4a8-47d5-3b71-08ddda9b3388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vvRIuWHITi/VNIfIY1+GF856HZ5a6BQgtaVAneyY43XYBicSsKF+JpS90Ssd?=
 =?us-ascii?Q?ADiqTDzlXhptEBcrRDbyGFzvWAGxOT8U98Uqe0bExtGrNUqzD7IMU/luxf3e?=
 =?us-ascii?Q?zzzDXyeFRRk+7PRxV9rKbDVFFphI0gJGK02iaeuBtqoC1zHSjaaMVLVzdAk3?=
 =?us-ascii?Q?9vv3bZpMfNnKnY1tc5tJGfYO7UguXk8DbO5Q4SfOm1FTK4DWNRc5TYjCNb/q?=
 =?us-ascii?Q?C2nrapo1Sc33r08wr/lsH11p7/VFyrCmvDOfRHsnSpi3sfn68+p3QQ2o35aj?=
 =?us-ascii?Q?alSCKrzbxcePloxuBq5PnIr6jUk9dg3uAsG+qyCJ8QVlipfMTD+K+Glfrhp0?=
 =?us-ascii?Q?qaKREdya1+91It2cxclehRt1InEv6qpAdzCExNBEOa7I4PKzKHz4Ed/83qfp?=
 =?us-ascii?Q?1u0aakTQKMnhfUriPQFRE+DbPcoW99sWMEKZ1zra5lqgjxMZlw61POCVV8Xc?=
 =?us-ascii?Q?SKFF+4+Lcy1Kv4mL6FEGn11rKgkx/GZW35YFjmaSLinSiGw7tSZHnnXUJaKE?=
 =?us-ascii?Q?0HLHZncBJArDt9Gd/S2BZSu7SFlb3M0Uy6Wx+jywdeDzCG9QQeO8dGyWqFMj?=
 =?us-ascii?Q?kiNNTmOC6i4ZPF+nPaAuT3GWkP3rxo09DCwOzwGfjOzceK0QgvYmAQ0XSb3R?=
 =?us-ascii?Q?aCOimT8x1SQZ4Xfmt4B42pfwUSmqIrRmkSkKwJrXJi3gaGMG6BfTNLOUd606?=
 =?us-ascii?Q?KRIeUTkSZIy7JmCQDBUZTspogB1pGVfD97pkujFbQOjZ8eVPF4dlgl2OZUPJ?=
 =?us-ascii?Q?rQGsjUPXBp21AFYsh/nW0usJ9Cs+D1EnSBRoN0LFbvgBDM2U+Ft/PNmIZMk0?=
 =?us-ascii?Q?PD86C89It/ClfEXYP4ZFsCHNFFz7mvzsFlGvKKYq/jyxIeELr6uWTMHgKEpb?=
 =?us-ascii?Q?yDktig7fronGGKX38IfVewkkGKZid+F18i7rKw7CWEhto16QmOszX61smHWW?=
 =?us-ascii?Q?SftvGqa5Vcajq5IKSxKMIRATh1tnsXEp6fMRf1bMTyUEeqnUqv72XiXTl+EL?=
 =?us-ascii?Q?25n+rJIjI5kK8UGQt9TEgACC8fYsByMQia7yzscX8okfMjwwVI0zFvk+9+uh?=
 =?us-ascii?Q?laWihT3HufZ8Vicw3t8QVyH9AXwKujSqfFx/MOHvL0hibr/mp7dWBD0+sKFf?=
 =?us-ascii?Q?XnCMT7Mj4mSZowRoUYZ5fAN5Bt37MLiHL+BMqN3qxKHoTm6P2gITBCDI+3Oy?=
 =?us-ascii?Q?C8OVbCz7aOwzUYOz+BoSOfijzBrEAVDpv4bRiu2SZ0A5rmBVaY08k5Oiq8mS?=
 =?us-ascii?Q?02xMp/LmeUU1p13K/pVoGLd66mc5tLRXFFJ6aaAdFNQNT8tGH9FHmFmQsBch?=
 =?us-ascii?Q?WPzeHkKi3SZKVnKaRfWy/fQJA4JR5MO84cDC/Q80jK5+BPIJkSuHxEkYhKLr?=
 =?us-ascii?Q?tEZ5WtdcOAc/nBf3Ul7vuiNzVS/i5vH35pdyWauHDhuxe8KUIUyX0TLvRa7U?=
 =?us-ascii?Q?DW1CJfzPnXTo9sib1DnIYK1/hEHFL3W2o2/TVnjISsokix/R5qA4YFOeTg9v?=
 =?us-ascii?Q?oLgR+IV3Vfjh8sX2e3EHPhj1pcS0HFl2YkEj?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 18:57:07.4542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 875fa1f4-f4a8-47d5-3b71-08ddda9b3388
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9257

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


