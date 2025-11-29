Return-Path: <linux-rdma+bounces-14820-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAEEC93562
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Nov 2025 01:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64983A9302
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Nov 2025 00:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCF214F125;
	Sat, 29 Nov 2025 00:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kl61N4qq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17737169AD2;
	Sat, 29 Nov 2025 00:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764377606; cv=fail; b=Axpuwdd/U97fB8qKp7DvjxoPsnKJloDsN6JMVNGki9HIVwZhBivMg1gYiMakMqhpyVVFMb3f5FKUwUj5nXMnoDBvKweJkUSVxmw182T8rT0JiQLr3YqkeACPOxLZZp0YGaOjA0qvPNpX6SDvtA3ObCTgOSmiDnobVuWwmP2XMxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764377606; c=relaxed/simple;
	bh=jAEU3ArMgiG1Bk56p/tiA+IWxK2RuxBE3kFcAnUDtHo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tQG+BAwC9lNEbXdJ769mu3e4/8q0ojfml262bqiV2V1oGGTwJGAeYqV3HJAn8orAgf12n+fA4fDvFvTTWnF6oqRcYk1kN/LGDEjMyV5pQnFsqgt74n6OlCxOpliI1eyUh/DBkV7++grOSeGgij+QEXS2gdxjxNQpGGUuZ/JVKSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kl61N4qq; arc=fail smtp.client-ip=52.101.61.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONHbtQsCevdEKyF6Xa4qf+2UZFKR5NFLmJ5g7fcy/4GfWtmLJgqbeWh+qm7CVno3rwBCYSC3bSJECnp9EWvTYsz9lQtV5miej6zCjGVLKGwrxPTTnMjnC95xQPB1b3s9jljPSTxSKPuSBTHETFfhqT4RepCim7spWl9g2l0t4+iCh5y2xgetI3E4S8OPuuYn1Ic/kex5833HwosxWipRHTvb5SU6aE2w4Yo1OgHib0+qoDxnrFsGcqDpaMZBrblxiTLd1UKiKXddLWDhhBpF5yj3OwSlXRiMVW/RfMI9f+kLTpt457a8IMAKFynMVKG5jIa5c6tvC8AQICNixA5Y6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ePAzX5xSBA4FxTCFy7Ha0ttlgHbb3nLBSLgcJcL6NY=;
 b=vu/E4dR+4XRizIFBaEzDkwRhMZgCdNayBpydFnm5GiTo8dpu9Yvq1qbJhw+0q7UgMzV+V59DgBSQvNEBusSkTvZvrcM2NIELlSUITnqjauXJLvGECfjvkcKSCYYPC9806ABDyzlzNfBzWv4wjL6u8oWGncA+B8SzCegf943gxIY/Kf4+lFNri1hr3igwI5NvPpxCYwcrjKzTIFS+ASoAdHZxbPzfkvRR33LVus40Wo2cqY4orWDCZYE34AfR7oCYHOSejzpdhJLEeQ/0+DHdFs/sYLwY8DThddaMkHKO+QZ6ujCv4NvNwUHbYPoBJghE0DClNFvvf132OcOQBWf9qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ePAzX5xSBA4FxTCFy7Ha0ttlgHbb3nLBSLgcJcL6NY=;
 b=kl61N4qqrr3lQdppnwgnj7rfJtELfEzS4rLeftizxRUCMVNiNtjQeXPUEqkuc+r1CAKLEhqVkbM3nLYuoD/lFWY6gLYXt3U20Qfi58gDb9uweSpXGyUsd7cTqBsEpWqMkiFT46NQVxorjPF/a6eo4YrRHUF6Bf5dc9I+1YWboTiSXiet5ov981mcVpwghUAgd9ez89nC2r9CfT5d735OQqhB4UXfF6IiaYc7XwDRnXEbVbGV5SpaAn3aj92TtCsasfbk/GQMa2KpXtgUNxxsKG3H1h9eg2z4scWFoVn4b7VNvjvBJpAlYCxSQacGfbqAketkYHncmsD96+o+4bqgsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 00:53:22 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 00:53:22 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Avihai Horon <avihaih@nvidia.com>,
	Eli Cohen <eli@mellanox.co.il>,
	Leon Romanovsky <leonro@nvidia.com>,
	Amit Matityahu <mitm@nvidia.com>,
	patches@lists.linux.dev,
	Roland Dreier <rolandd@cisco.com>,
	stable@vger.kernel.org,
	syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
Subject: [PATCH] RDMA/cm: Fix leaking the multicast GID table reference
Date: Fri, 28 Nov 2025 20:53:21 -0400
Message-ID: <0-v1-4285d070a6b2+20a-rdma_mc_gid_leak_syz_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:208:23a::16) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN2PR12MB4208:EE_
X-MS-Office365-Filtering-Correlation-Id: 50bc32b2-7fbd-4a7a-6fea-08de2ee1b1ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+kSdCTsS7piEoNXb/Wt6p/HNjnuW21BMQG7TQeid2sOnkP5naWwV8Hpe+RQa?=
 =?us-ascii?Q?WGu8H/7mzB4k3s84RI6uyib6dhU3w3pHs5AWfUlzD7XUHangk5QDyw9O1m+G?=
 =?us-ascii?Q?qEBsoZGT0rk8YkSVM9dbl8WTaWobHOPa9lkEAJ0dpvKPr1E4ZTA0Ap508pNW?=
 =?us-ascii?Q?/Zl7VPszvogkIavoVcHU2ld9qRnzDx6vqYnPNJtZa3wZbMMo0qLw9fZmZu9a?=
 =?us-ascii?Q?T7d9mdteOmL8YtFV3lss0daV67Q7Tik+OLag7HaIFe4kWBZhucWw+xlPzOQ4?=
 =?us-ascii?Q?+zD8xIwqSJ5WB3DOxi32qyGXX9yf2+LCMlhE7Sm17+R84OZenip5IGfXfo6c?=
 =?us-ascii?Q?UFKC9a6t+Z/vUYDevqspk8mm0qkg4S3WUT5123Kh3dUiGO2qTcjt0TzKdQcV?=
 =?us-ascii?Q?UnKeXWezeV1K6v8mn3sXEVM+WogPIyy4JZjdyntJ89Zcx+9wQF25rjApVUA4?=
 =?us-ascii?Q?5MQuId4shZ8lJKGi5m/IYV7BBQXybNDbwImm5D4KIfeyzTBvcSthxTISXxYt?=
 =?us-ascii?Q?Lfhz0GICxvwW+Qz6boeSY/oYoM74fonMHW8zb4qyaZJ07TxJ+ZIm4dYj277C?=
 =?us-ascii?Q?gBHFZVOboIVbBl7dgvdvOTtSVrSful9H7EEvwUh6uohQQTpE/tatq2Q9MIdj?=
 =?us-ascii?Q?eN0JjRzZs4EOjW/HQaGoIweqWO88jtpzTMDA6jUuglg8daDjxZw9RNVhxnma?=
 =?us-ascii?Q?bHUgwKSdoDXpvPd69U44Ep5E525O9PhrM2KxKD6c4zdBlRlLkanQnrqHsQG3?=
 =?us-ascii?Q?P1a3ivNuunqNmsY+24NEXHwigBCX26rKwycaA669aDFcKGE1bPhHlLZAA9Jg?=
 =?us-ascii?Q?+ROP66UDpSoVklAJqWEGKTNPiEDOFGiBYwjNOp3tIYFdEXqnUhEH521juxUA?=
 =?us-ascii?Q?NEuoM8OL9DzGO8PhH4QD1AMO4nB3zXY/l+qauR6n2EC/LaytplXmzgHv4IPC?=
 =?us-ascii?Q?UCCFHYyZ3j03g+akd8hB0nHNos31BvzaF+7MRxKMcpsC18I3MQ5U7phcfhvb?=
 =?us-ascii?Q?ebqwAaWolw2qvAOHl86NdqIzrYziYRhiHN6/aBM2BNEv70Uki7eLIrzBbMoe?=
 =?us-ascii?Q?ppafwnwZ/7vC/tENFSLHbK3JAGxsou28UpDM91zT8WytwWP4+zySVJqhYNrs?=
 =?us-ascii?Q?8TMJs9kooqjf+skGoKwpfSUzIBSxzS0i/Mp0AVVoSUTeG/EbWJL6jnny55es?=
 =?us-ascii?Q?cqyYXYDO0GJnXJnj1J7Zq+ibD+6/LXo5d2tw4VUhtvlXrCaktYHmhJP0nb5P?=
 =?us-ascii?Q?qnjbZkw7Lx4WslahhrVrodoY/HS+ejEMt20PCBSm6rZzDuC1E+vNDuKCXTPV?=
 =?us-ascii?Q?5OLZhNLPgtYheIFTE3XagM71r36w9XNnoDAle66lX560kEGrL+cBrtBr0Ty4?=
 =?us-ascii?Q?b3a95DusbtpNPJT1jKEvr6ClGI1RqYAitRQ6SuTcrzB0u7p0Zg2Lub319a2X?=
 =?us-ascii?Q?dcxlBum9yHoQl8exlrvmfDuv8nJ2Vp39EBRClvXlodq+Oo4eE4yFcg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JQPJ/LOSKot4UY/vrvm9B/cbUQIe6/PkKFnnvIOx+6ZVXIHqsmrhDjllQUmG?=
 =?us-ascii?Q?C/GDCavxSdr3SpR7zGBOqeVtqeFjRbWwzqupRbv9oOkxKYhI3dJHJksrOxAM?=
 =?us-ascii?Q?XPWqMFrk+KHPHrLY/PI3uaXTIlxl80MKCiR4sAWEbIHxB0bARpGGzSor2k/I?=
 =?us-ascii?Q?HTpdMQ5Sh3/sk2nwDVEsj1orQmiAcY4PMaPZgN1nXstmpCez8sbRCK+25tL+?=
 =?us-ascii?Q?wOwkJCHJinGzpMcrJ7OM+jMszlPEvbY+74cmQdJibq3cfuCIaBZ4X2K0VX1o?=
 =?us-ascii?Q?uMsHq1tOM5AXPxJSW4kx49t5EqbECtOnlG09BrCkvkYtHsltiOvDlGfcXMRQ?=
 =?us-ascii?Q?z4i1TrpS5Ic22rDK1IDLrhUdWAJ8kJkbtyh0apH2yXLFrBH3OY7SmD5wflXc?=
 =?us-ascii?Q?Gzw86UvMCVs5R94IbIpImYxsiM53AJ1LBMTJiyClvd87SwrECYo+hOs+ya0i?=
 =?us-ascii?Q?TLkZ+Box0xTAtFGw11cx7FunPHHm2ePcSHmWcKDGNgh8dfEdha35xxPrVDef?=
 =?us-ascii?Q?A8VjmDH2RiHrJxtlrTHVIS7pi4VL2mCP5aMSQnMbL4tYNnXwh0qp5eeO7NYl?=
 =?us-ascii?Q?OjX0iBXvwS6+3ew38zOSbB0oeHRn+stJqwuhJmJWUBAg2y4KYAo1H848Jpw8?=
 =?us-ascii?Q?to1I7SeLfP1FspXahF4h7tojf8qNL8z8ZtTZCFIjyhPqPU7WhU//DQKRoQ36?=
 =?us-ascii?Q?yJ0sBrywrqg7TRRcT4WAhxuh9EQwXdzpUkxzI5wrKyCpaWKQuAJpo9Pp3Uyy?=
 =?us-ascii?Q?DvLfpM3sfXIMUm6+t7b1FFu0fKFdlT3q15OeUlFhdEcQpbiQmp+i+UciXvpV?=
 =?us-ascii?Q?m3tQnzNptl1O0r8LDR8YIAscEb2fgb08RWINkreuTrjakSB7jv6Lbh+tI5D/?=
 =?us-ascii?Q?eztMhInpDIj9ls6u1fXozBXnoNaZBkVcvk3WpA8C4buZjEFWnLKXXD/pzXiU?=
 =?us-ascii?Q?4UyPG5vXtDGKibN1ZRoIDHTqBGGij8XvY5rjvJx11AAwFfo0+AoacVqb7XyB?=
 =?us-ascii?Q?te0/87iQ5xrJPI70npFZFkedXY78iAnVhErVHEf+bh6Bafz/fSY9jyxXFWTK?=
 =?us-ascii?Q?mzyNgMXlDOgV1I2p+2opWpN5psRF3MOMf4yojF8PsnPfxeTBdQJCqJhGs7eN?=
 =?us-ascii?Q?pIBww8YHuJd9WUxPvyevgs7KwFPZ8nU2n+hsZIxBZLoOd6/QoANSQNNJDllm?=
 =?us-ascii?Q?+ep9xv5FuCaun7vYGH86OdJhftqaA1u/IqHgQTQoVmb6rxZC0mOzSRZYOdFk?=
 =?us-ascii?Q?bltBHB7QD29mb5PdSUiX2mPWeEgrgOZV2L03oHxSO7KBKGi7bmrAMDpZx6QG?=
 =?us-ascii?Q?gAfsalI0BNtsjm18TPwS45xVuuhEhLRC4XoOu+H19qP2xWYGbv0Cf9hiz1k6?=
 =?us-ascii?Q?Q4ik0w5T7r5ZSS0Bd9bow+/V455KOmSai+GjNUdEHYybonsTzxCclllNBnhC?=
 =?us-ascii?Q?fvrgliy9uKaQ8UNy/qEFYOIv+h8SXW72qNVoc5KGAXMPuxBIbmUFqrMsCN/1?=
 =?us-ascii?Q?6Ux9h+EDPNl0bFq5LoADkRHl00Sorf0xbXjgU9WZMgnmNCDEhUshvDhYmAl4?=
 =?us-ascii?Q?c7vpS7AYvBWNOmwa+yY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bc32b2-7fbd-4a7a-6fea-08de2ee1b1ef
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 00:53:22.3526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onAxFSVUeTXIDrdM2gkq80HsDsSkx2emd7U8g7Px72A4Sq6a59tNzdjcTlEe2ioH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208

If the CM ID is destroyed while the CM event for multicast creating is
still queued the cancel_work_sync() will prevent the work from running
which also prevents destroying the ah_attr. This leaks a refcount and
triggers a WARN:

   GID entry ref leak for dev syz1 index 2 ref=573
   WARNING: CPU: 1 PID: 655 at drivers/infiniband/core/cache.c:809 release_gid_table drivers/infiniband/core/cache.c:806 [inline]
   WARNING: CPU: 1 PID: 655 at drivers/infiniband/core/cache.c:809 gid_table_release_one+0x284/0x3cc drivers/infiniband/core/cache.c:886

Destroy the ah_attr after canceling the work, it is safe to call this
twice.

Cc: stable@vger.kernel.org
Fixes: fe454dc31e84 ("RDMA/ucma: Fix use-after-free bug in ucma_create_uevent")
Reported-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68232e7b.050a0220.f2294.09f6.GAE@google.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/cma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 95e89f5c147c2c..4f5fd47086ab90 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2031,6 +2031,8 @@ static void destroy_mc(struct rdma_id_private *id_priv,
 		dev_put(ndev);
 
 		cancel_work_sync(&mc->iboe_join.work);
+		if (event->event == RDMA_CM_EVENT_MULTICAST_JOIN)
+			rdma_destroy_ah_attr(&event->param.ud.ah_attr);
 	}
 	kfree(mc);
 }

base-commit: 3fbaef0942719187f3396bfd0c780d55d35e0980
-- 
2.43.0


