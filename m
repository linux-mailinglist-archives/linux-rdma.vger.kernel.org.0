Return-Path: <linux-rdma+bounces-13513-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D39B8963B
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Sep 2025 14:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0251D3A90AD
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Sep 2025 12:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1475B30E820;
	Fri, 19 Sep 2025 12:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jg6lgA9+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5275B3093C9;
	Fri, 19 Sep 2025 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758283995; cv=fail; b=tVrPG+ADP1PGSgfua4RVLsjmDOrBEHUD2QAupLNGelJ30YNrf16ULPhRdr74MyOCoFRObgmjwwOLp4RGch7EMzb+xYbQ7bALznn68FMSkO8p2DqlaLAMP9VsxS5XK3ZzPHrCIIQGNSIsPu1+s8Ujfl0qz45szSPC08RwQPONeJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758283995; c=relaxed/simple;
	bh=N5c/07c8Alew8ydzs6rIhrGTU7Tx29E1ZFpPuNHMiFU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h0iG4IISha7o0qYsLelDqLGZoDW0I8LI07r3T2SicC+dA9fb9kz4aOyWQZbRb9VcPk/UowFDTMdN9Cl9k4dtWJKYWO5pXhTTeGKagyqRDcKxPzoh5nU2THqV9XYiXQwl63KR5PaP/XK7oFeLzMebnyoJ31FNin9siMHfKpDdeE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jg6lgA9+; arc=fail smtp.client-ip=52.101.48.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2UFSau6QcWEkN3R9nVEp9ShK/fS/zXZnKS4ezi2IuEQgxAV9Jgv+E9yOYZNkwJyp8bNlfZTdqgp5WAbTo1Xx9gTx/fif9F7m2p/FB5LToh4Ep6SYls6e+jx/cgvVtzRoEKAJod/Cdz5poj3tMqQnTQecDL9uN6epzEIbtQe4r+SkfKwD6crgSmb4kf76DJD7EzdhfVv3crEcBoI5SnHYV9A1L88Ag2I2Z6vksUCaI3zNKVlSv2WWEvn7ksEI6vMRXc/l7IC+5RMr016WAoyh8ddlqr/4faS1egPORQT626ahJcBypl1XtZnhbcvY0l9Ybv1tL726vs4f0HO4+PZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zV3rLMBMWQxxWOftzPhWzNDvxA51oIWG1MZfCH5hq0=;
 b=wqBI4a/UvFJi1u8GxPAMrE4ZKjrf/x8VhUccAHY+aNxg0fJ4pcFk/wpK2EGAQiwhDEc2alOQSsu5Zg/kTem3TAFnTvnTDfyeVvfGRFynGQaQsMa4jK7qsSuXC0Xno437b0XvqOuBtHE9jrAbkLkkE52gvmzYpwy6ZpQpQnkLBJYFmTo83mV2LV8j5IOhgaeduew+4Ue8QtdBmdoeXOsDBItki454EcA/nfP5X+pkuUYH4xP49L6AVM6444/UQJvG8BZOhFNgEIs+fIqJnYhtzuasv678dpYzELw3MUUg+etxV+cTFYBsnn2DIZaoQ8FmwXSaTv6sTMwhvQauyv98mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zV3rLMBMWQxxWOftzPhWzNDvxA51oIWG1MZfCH5hq0=;
 b=jg6lgA9+DYLK8mQPerq3KcQ4b4gFKHv1z3JDbRkTderuQ0X+wVYxM8+FVxd/2ngBO8u5QfH7ccHM6H+u+CldrWHM4D2NwvcS89wdyqcE/wAHHUgS1u8k34+KZjDEOT/OSg2kkniQvc6E4hFdMoQ2zZWImRxAFTTPTIs9ZjFVKQA=
Received: from DS7PR05CA0020.namprd05.prod.outlook.com (2603:10b6:5:3b9::25)
 by MW4PR12MB6801.namprd12.prod.outlook.com (2603:10b6:303:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Fri, 19 Sep
 2025 12:13:11 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::b1) by DS7PR05CA0020.outlook.office365.com
 (2603:10b6:5:3b9::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Fri,
 19 Sep 2025 12:13:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 12:13:10 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Sep
 2025 05:13:10 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Sep
 2025 05:13:09 -0700
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 19 Sep 2025 05:13:07 -0700
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <allen.hubbe@amd.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH rdma-next 1/2] RDMA/ionic: Fix build failure on SPARC due to xchg() operand size
Date: Fri, 19 Sep 2025 17:43:00 +0530
Message-ID: <20250919121301.1113759-1-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|MW4PR12MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: 63339ad6-810d-4584-1cf4-08ddf775e6a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LBloDdcyqtd7AG+OB1dfWzUNKPgiWzRFTIgRkTtAAHl+AntpxWcXQ38cdBTm?=
 =?us-ascii?Q?tRl/BHpwHwWq3wyeOKtKeinQFZs7E66qIkBJUN2nIZzl0K9Zoh4OtzM4nPbN?=
 =?us-ascii?Q?JPh9qKaGcsnwseJ+RKwFfSvZlRftEjP2bfwuquRK7/WcU8wWWPu5KB2CXC3c?=
 =?us-ascii?Q?Ts3gFCPjyCzkQTlL0EOEANNHn56bBKHGwe5by6OhYQ1LHxETF6u/YfI2tW6Q?=
 =?us-ascii?Q?tw6IEwwFabYgUuOuhSSeIR19KpWgDU5vevLBbmgzES4uof8Zs2jkTG4Fek8D?=
 =?us-ascii?Q?i6hifh+ZGiK/2vQBUuCILFu6EFWp3xdsc82PoC+/xeNIUfFT6Wk66bvH6xLV?=
 =?us-ascii?Q?sI1CKf7trv8GvG4MZcb+j03rZPm7yodEmUPhrD2bUUfJTd5LBZUZsR0cUjo9?=
 =?us-ascii?Q?2ZXfafGYrRMKdFkORa3PwHVirziqtK4hDn0WcCgbA9DOnRyBZJnyJIzYrCsf?=
 =?us-ascii?Q?wM27zFCl08hlIewqQXJ76j3W5o1OrbgCPoGEGy9+m6QCwmrK1dMpwnJrv27B?=
 =?us-ascii?Q?llN3U2d1Ounbbuq8RGOCF0Rg5iLA6sf5s4RmMpOu7RC7wJc/D47dH4s+Ehid?=
 =?us-ascii?Q?FtbMZNk57bm2d5jwaiu8rvGLW8n8gelhvbXAdzvC0wpnQHRJy9UK/3M0Oonj?=
 =?us-ascii?Q?+WMgIRcyEWn6UxT2Hbg/EpwcTuDf54hqWlV4yc3KBt1lBOG8FWvSpeCH00ug?=
 =?us-ascii?Q?lTGaAdJtgeEHie8adfd55VDzWkvmfqKuD/5MjdEAWgkq3+ia+GZMPA1Q/B9x?=
 =?us-ascii?Q?TJFvlyvtiR5Qabd7EGwevjGBUnHHcm2VAkR4AuOMiBc+iKpp+r2/Zd8RqrJy?=
 =?us-ascii?Q?8e3i4RrDL0mRnxBBauaWvV2WZKY/l7PCPPLS7+c8dDjY446fGq+KWWK7YnwA?=
 =?us-ascii?Q?FyTCAORujyVSzAh48+s6ODAYfinxpUrOOLTigBa+VYQxezg0E18hovqeChLG?=
 =?us-ascii?Q?67tD99kYls7xLA2uS3sMUezGYQSvtgoK3u25umxf60ZqjIY/dHAwaNuT41Rj?=
 =?us-ascii?Q?3HJcsGxYdRQY1cFo8WUZp4t57brX6phs47Y72jp24HzELRHS0MssTEiZMtch?=
 =?us-ascii?Q?G7D2VD51K/x3W0MMq6Ax38+6ejRT2eDMhYdMNFYxyy2iaQ5wYItcYQBkjBap?=
 =?us-ascii?Q?V5IzUSqjaNMgk6hsN8LtmAJiG6wz4RM/IRnRM1HEggbiqQMM6UOBEQ583mC1?=
 =?us-ascii?Q?CAewByQcl9XvjM4BY6/zdcX1YDsx0nLFbUNyKEKMjzYhw+POVck7JnshwAfM?=
 =?us-ascii?Q?zx1asnSdviu4XAiRoFC7RxUZ+iAX6biUx5bGtGrPHHxNHJeSzyiYA6m0eslo?=
 =?us-ascii?Q?9jgM2s44ggy2z3mj5Cu+b4vMJhw2ceGAPf1K4RjmbS0mQjXccSFq9Y0GCrRd?=
 =?us-ascii?Q?OFX82BQdHtLUx5XRIXHsUUty0Zk8t/+0OGKl2LWfOJT3mZiLsu5sXSdYN1GW?=
 =?us-ascii?Q?tGxcRbvNrkKWzMxUZubEeO6Lp7QZlIEfkYxlz7gVt7gIkCSDyMerCw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 12:13:10.8759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63339ad6-810d-4584-1cf4-08ddf775e6a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6801

xchg() is used to safely handle the event queue arming.
However SPARC xchg operates only 4B of variable.
Change variable type from bool to int.

Unverified Error/Warning (likely false positive, kindly check if interested):

    ERROR: modpost: "__xchg_called_with_bad_pointer" [drivers/infiniband/hw/ionic/ionic_rdma.ko] undefined!

Error/Warning ids grouped by kconfigs:

recent_errors
`-- sparc-allmodconfig
    `-- ERROR:__xchg_called_with_bad_pointer-drivers-infiniband-hw-ionic-ionic_rdma.ko-undefined

Fixes: f3bdbd42702c ("RDMA/ionic: Create device queues to support admin operations")
Reported-by: Leon Romanovsky <leon@kernel.org>
Closes: https://lore.kernel.org/lkml/20250918180750.GA135135@unreal/
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/infiniband/hw/ionic/ionic_admin.c | 8 ++++----
 drivers/infiniband/hw/ionic/ionic_ibdev.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/ionic/ionic_admin.c b/drivers/infiniband/hw/ionic/ionic_admin.c
index 1ba7a8ecc073..d9221ef134c4 100644
--- a/drivers/infiniband/hw/ionic/ionic_admin.c
+++ b/drivers/infiniband/hw/ionic/ionic_admin.c
@@ -945,7 +945,7 @@ static void ionic_poll_eq_work(struct work_struct *work)
 				   npolled, 0);
 		queue_work(ionic_evt_workq, &eq->work);
 	} else {
-		xchg(&eq->armed, true);
+		xchg(&eq->armed, 1);
 		ionic_intr_credits(eq->dev->lif_cfg.intr_ctrl, eq->intr,
 				   0, IONIC_INTR_CRED_UNMASK);
 	}
@@ -954,10 +954,10 @@ static void ionic_poll_eq_work(struct work_struct *work)
 static irqreturn_t ionic_poll_eq_isr(int irq, void *eqptr)
 {
 	struct ionic_eq *eq = eqptr;
-	bool was_armed;
+	int was_armed;
 	u32 npolled;
 
-	was_armed = xchg(&eq->armed, false);
+	was_armed = xchg(&eq->armed, 0);
 
 	if (unlikely(!eq->enable) || !was_armed)
 		return IRQ_HANDLED;
@@ -968,7 +968,7 @@ static irqreturn_t ionic_poll_eq_isr(int irq, void *eqptr)
 				   npolled, 0);
 		queue_work(ionic_evt_workq, &eq->work);
 	} else {
-		xchg(&eq->armed, true);
+		xchg(&eq->armed, 1);
 		ionic_intr_credits(eq->dev->lif_cfg.intr_ctrl, eq->intr,
 				   0, IONIC_INTR_CRED_UNMASK);
 	}
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniband/hw/ionic/ionic_ibdev.h
index b7a1a57bae03..82fda1e3cdb6 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.h
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
@@ -126,7 +126,7 @@ struct ionic_eq {
 
 	struct ionic_queue	q;
 
-	bool			armed;
+	int			armed;
 	bool			enable;
 
 	struct work_struct	work;
-- 
2.43.0


