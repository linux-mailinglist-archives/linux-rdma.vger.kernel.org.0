Return-Path: <linux-rdma+bounces-12684-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E41B22A1D
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Aug 2025 16:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9A3C7B6543
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Aug 2025 14:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAE52ECE82;
	Tue, 12 Aug 2025 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rciboPxo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559E328726E;
	Tue, 12 Aug 2025 14:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755008307; cv=fail; b=aR2MfdxlnFrFufY1uGNhLvwgnbDr4WGIxBcXinvl0HL1uPqz3O5VTJ/orI8a/iPLwUIp16lkXsjga+KNraSq/lCeOpgilytwvTok2vj5RD0Aon68sdGs87LdivZ0boWBMgu9KlRZAblyjPiGcJpUj93ZHC80Envw362WDdUsjQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755008307; c=relaxed/simple;
	bh=GLxZaZWrFLGeascMwr6acO34Wz2tc67aeb/ElDGi/wQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6MUkisBtLE47XS7O8binl36zXVR2sRVSz6kTiPby8NQWGvfu/2ggEofuRq0zDWMR7hOPVtPsAAVFG6GmOmPw5wSYGZWSj8KswHV72q6c8m7DF+GCOLCtGBOZhZ4/Wn7Fqra4eROxJbIoiJbFiVLZEGvLBc3RvNiWaiJv8kMuwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rciboPxo; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPwt8NDYg3a+Qbb5JApK+lsfMCGxo4vOYPaTXHPZorqxn5KWOeIDltOrnr5yRE8bsypFySoeHMo97cUQqAwqIpz0gZIAXD83/rRaoGscTvp7wZODQ92LXM24Mbw3DB7RGLlsubEyhCuaOc1szXfBY41xF3skkMYIBW1XuOSXap+ugDFkQslSyuPUrkU3tGQPfipGV9pIOzdYwP2Nt9/O31vkU/LHBG2e3Ngxncl6UCRmZ5etvJlWVPpsyjp39YKBINP/n6BKfJzs6MVEkL1YRCfquHue8jxAF9TBk70z05aGknyscnGsIVwkG3jPMvPCyE256smTq7cvHAO6U9N4zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+txULCYVpWSA6nlYhMYpxxPu7vpwKmo/WlLTU2upKE=;
 b=qWygAhd9CW+N7q65C43XEVkpXae0EH+FH2867/F/CbXBudj/LoPESitFwtXto4u2I2/6Xf9tYgLUtRg1F4y29U3a/8TJepu8i6j23w4XP+Wt4L7mmCc9DLacPAd8LxEKSEBEcO6OoDdopSIlUOo0xRYE8A6JcFZW7iQRMqZ+nNVmssf+FheO5vAj5Jli3j45kNepBc8wK1YO5a5FY50Dl1b66xRrro1E4Tgd11pJpp4fCVqOEGj3SvINS89r0GczHOqIB3IMIPa40jR4KAi5fCP2FbLrjrX1cz/10F3lMEQWoPNpCb/USPdihElBOdyFYVw6MW7R4lYECdgwAF2kmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+txULCYVpWSA6nlYhMYpxxPu7vpwKmo/WlLTU2upKE=;
 b=rciboPxomVLsWjQg+YMjgB8bz2dv74lUABTnr6ObkpDewDWjECcvwJmgfWb5IHCDEZNAlobPOEjmKe4rHPQ4Ml/a/3RN1ghpT59npFCN63EHhzlt0M8BjSZyKZB0ZT2mNsQQydhFe7bsiAClqDtrd+mSdPvWCarE56sn3Kwomjla37ViYjKs2uVf+P/k0riSIxYTiqx66VWEFEa9zFXgXoWug0oYA4Kd8y/aU7NRWiSyFII7rz3XavHC9mhW92plptZeFR9gFAgeQdmbbCRVpS7ZEzRa4kEUWW2ODEohVfm8TB2WOz+yae0GLogxgAuKQxEYVBUDVZy+wEDP70nJkA==
Received: from SJ0PR03CA0091.namprd03.prod.outlook.com (2603:10b6:a03:333::6)
 by IA1PR12MB8494.namprd12.prod.outlook.com (2603:10b6:208:44c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 14:18:17 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:333:cafe::ac) by SJ0PR03CA0091.outlook.office365.com
 (2603:10b6:a03:333::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Tue,
 12 Aug 2025 14:18:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.0 via Frontend Transport; Tue, 12 Aug 2025 14:18:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 12 Aug
 2025 07:18:07 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 12 Aug 2025 07:18:06 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 12 Aug 2025 07:18:02 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>, Carolina Jubran
	<cjubran@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>
Subject: [PATCH net-next V2 1/3] ptp: Add ioctl commands to expose raw cycle counter values
Date: Tue, 12 Aug 2025 17:17:06 +0300
Message-ID: <1755008228-88881-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1755008228-88881-1-git-send-email-tariqt@nvidia.com>
References: <1755008228-88881-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|IA1PR12MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f7c527-5c2f-44ed-ca7b-08ddd9ab14ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hvE/rMKONTT+ctct4hBuKZNach67PO7wSC63UYyI7K5mypU97oCWPFe85dxP?=
 =?us-ascii?Q?2BN+mkr6EEy0jEkTzH6groYLYYs3rX/pYknPIpCyLwyGzCce8PHcZLIaaRX/?=
 =?us-ascii?Q?q2Bh2LH43zfiSph+r66/npwazm8OxNCiu7var9qLOmq5UjleXp26gSRKVAKC?=
 =?us-ascii?Q?hNi9dnMASPQ8jP43BaZ3hWFQZPCw/mgkdDv8xS2G63ki5U0UqO0UqGcEFleM?=
 =?us-ascii?Q?Ldg7rRhnytDj3Pqh93VQFFi99scfecInRBqmZq5onKNy1jyA8l5Su2dEvjjH?=
 =?us-ascii?Q?5IiKdZGcJXimewr2UUxq0y9nxaC5JEO+NFvnwDb3jB16CbCiuUvXz0cIeoV9?=
 =?us-ascii?Q?qztJkFQvOaz9MF2uHXtU33NTbYFBuxQ6BtWKS7oFzJNWLpsrsnob8QgxvNf9?=
 =?us-ascii?Q?cVuso2fcGubSkx1LcC2MkiDuvZZNFcmmz88Y0cTmgIs478LeCaTLArLCLE14?=
 =?us-ascii?Q?YVKTPVQANUcdHo7MixQ8ryFu9+ww1u+z25nJh8uAYXvghevsWejO+p5VXO0w?=
 =?us-ascii?Q?YfjCQz7A1nrXy/sPr5j74srEE5OHGAjrInrqK9o4x9MLUWFebQi4f++7su6S?=
 =?us-ascii?Q?YbxLH4RFqKStuZjzS6cxwoNYrg+jbc4ppcmmAyiDOTT2iAQd63WXMLBcNFUS?=
 =?us-ascii?Q?qCXwRFmCZPj4kkBzj1H83udHy6Px7xoZ1IFPrrsTw6/OvADMyHoKSEltHN2I?=
 =?us-ascii?Q?RRtmTgiToCs4HziAnac+8iu3RdvedI1ysB2TxMXQSvmC+JMQ6w75y1+hrO7Q?=
 =?us-ascii?Q?F1QSixiJEhVLt0yRkHNc1+svGMMJx1Dwe5vdSNv8Z3SSX/xE8IavRP+WFL4E?=
 =?us-ascii?Q?+SZh5pgd9QViDvb98DRMLxLDWqciC7KqMo6VfAN6kAmTHA6KcrIA20vIIPQP?=
 =?us-ascii?Q?9VmXZd6dw+BSuURmqmCnZocmkNwCo0g53kbgP9ByyIS85Jkxh8VGWBuVtX9t?=
 =?us-ascii?Q?1G5rZkiH+TZ+sSA/HdZKQsvXuw1OPA+NHFbIw/DEb1N0PNDq09Mnbbq+CgZH?=
 =?us-ascii?Q?YEkmps36drLlilvnKQC/yfIWaXe6Pbu8OmNSQ8jYBkZd7+Sigo9RFCj7RLbv?=
 =?us-ascii?Q?myC6RfWJYweFeSzyC8Fo9XBAd7FHMEsU+VqsGvAiPPq/i9QoJcp0j9IFX8R7?=
 =?us-ascii?Q?X2XQS1aGjd/diqIKIIArX+JXjVNLC+1LHCFExYDuQh3ZoVXD+wKE1tbcPT3F?=
 =?us-ascii?Q?CL1wyg/8KmB7aHNN6htuvXxZcu3tnab1SFI1a42DIBD96I0DOugHV3q/iY/u?=
 =?us-ascii?Q?Bu3Lf9W33aV7YQd+w1e0C+FxBx4MLLo/tSKUQxzYG+Ow6z6nzDCiOG9DrT3T?=
 =?us-ascii?Q?tpncBMBfvLyjQegBxsolkaJ9hkQh15iohKpgU8YY5zEJP0EWd5vw4tdKJyuS?=
 =?us-ascii?Q?shAljBvohzVsDDgQM+fWPBM0GoReshkOaGHJ/rLSm8Qhsf30agTnxQfZ9j8W?=
 =?us-ascii?Q?HRFKKZo2MYxc4E+DqxveNgEucIzEYA6F+pi13/cfZhf5j7j2cFhyvF/KkXLf?=
 =?us-ascii?Q?ID12RtPn0cDoigjZrFb1fPX8VJypJmXzeYw/?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 14:18:17.1154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f7c527-5c2f-44ed-ca7b-08ddd9ab14ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8494

From: Carolina Jubran <cjubran@nvidia.com>

Introduce two new ioctl commands, PTP_SYS_OFFSET_PRECISE_CYCLES and
PTP_SYS_OFFSET_EXTENDED_CYCLES, to allow user space to access the
raw free-running cycle counter from PTP devices.

These ioctls are variants of the existing PRECISE and EXTENDED
offset queries, but instead of returning device time in realtime,
they return the raw cycle counter value.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/ptp/ptp_chardev.c      | 34 ++++++++++++++++++++++++++--------
 include/uapi/linux/ptp_clock.h |  4 ++++
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 4ca5a464a46a..e9719f365aab 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -285,17 +285,21 @@ static long ptp_enable_pps(struct ptp_clock *ptp, bool enable)
 		return ops->enable(ops, &req, enable);
 }
 
-static long ptp_sys_offset_precise(struct ptp_clock *ptp, void __user *arg)
+typedef int (*ptp_crosststamp_fn)(struct ptp_clock_info *,
+				  struct system_device_crosststamp *);
+
+static long ptp_sys_offset_precise(struct ptp_clock *ptp, void __user *arg,
+				   ptp_crosststamp_fn crosststamp_fn)
 {
 	struct ptp_sys_offset_precise precise_offset;
 	struct system_device_crosststamp xtstamp;
 	struct timespec64 ts;
 	int err;
 
-	if (!ptp->info->getcrosststamp)
+	if (!crosststamp_fn)
 		return -EOPNOTSUPP;
 
-	err = ptp->info->getcrosststamp(ptp->info, &xtstamp);
+	err = crosststamp_fn(ptp->info, &xtstamp);
 	if (err)
 		return err;
 
@@ -313,12 +317,17 @@ static long ptp_sys_offset_precise(struct ptp_clock *ptp, void __user *arg)
 	return copy_to_user(arg, &precise_offset, sizeof(precise_offset)) ? -EFAULT : 0;
 }
 
-static long ptp_sys_offset_extended(struct ptp_clock *ptp, void __user *arg)
+typedef int (*ptp_gettimex_fn)(struct ptp_clock_info *,
+			       struct timespec64 *,
+			       struct ptp_system_timestamp *);
+
+static long ptp_sys_offset_extended(struct ptp_clock *ptp, void __user *arg,
+				    ptp_gettimex_fn gettimex_fn)
 {
 	struct ptp_sys_offset_extended *extoff __free(kfree) = NULL;
 	struct ptp_system_timestamp sts;
 
-	if (!ptp->info->gettimex64)
+	if (!gettimex_fn)
 		return -EOPNOTSUPP;
 
 	extoff = memdup_user(arg, sizeof(*extoff));
@@ -346,7 +355,7 @@ static long ptp_sys_offset_extended(struct ptp_clock *ptp, void __user *arg)
 		struct timespec64 ts;
 		int err;
 
-		err = ptp->info->gettimex64(ptp->info, &ts, &sts);
+		err = gettimex_fn(ptp->info, &ts, &sts);
 		if (err)
 			return err;
 
@@ -497,11 +506,13 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 
 	case PTP_SYS_OFFSET_PRECISE:
 	case PTP_SYS_OFFSET_PRECISE2:
-		return ptp_sys_offset_precise(ptp, argptr);
+		return ptp_sys_offset_precise(ptp, argptr,
+					      ptp->info->getcrosststamp);
 
 	case PTP_SYS_OFFSET_EXTENDED:
 	case PTP_SYS_OFFSET_EXTENDED2:
-		return ptp_sys_offset_extended(ptp, argptr);
+		return ptp_sys_offset_extended(ptp, argptr,
+					       ptp->info->gettimex64);
 
 	case PTP_SYS_OFFSET:
 	case PTP_SYS_OFFSET2:
@@ -523,6 +534,13 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	case PTP_MASK_EN_SINGLE:
 		return ptp_mask_en_single(pccontext->private_clkdata, argptr);
 
+	case PTP_SYS_OFFSET_PRECISE_CYCLES:
+		return ptp_sys_offset_precise(ptp, argptr,
+					      ptp->info->getcrosscycles);
+
+	case PTP_SYS_OFFSET_EXTENDED_CYCLES:
+		return ptp_sys_offset_extended(ptp, argptr,
+					       ptp->info->getcyclesx64);
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index 18eefa6d93d6..65f187b5f0d0 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -245,6 +245,10 @@ struct ptp_pin_desc {
 	_IOWR(PTP_CLK_MAGIC, 18, struct ptp_sys_offset_extended)
 #define PTP_MASK_CLEAR_ALL  _IO(PTP_CLK_MAGIC, 19)
 #define PTP_MASK_EN_SINGLE  _IOW(PTP_CLK_MAGIC, 20, unsigned int)
+#define PTP_SYS_OFFSET_PRECISE_CYCLES \
+	_IOWR(PTP_CLK_MAGIC, 21, struct ptp_sys_offset_precise)
+#define PTP_SYS_OFFSET_EXTENDED_CYCLES \
+	_IOWR(PTP_CLK_MAGIC, 22, struct ptp_sys_offset_extended)
 
 struct ptp_extts_event {
 	struct ptp_clock_time t; /* Time event occurred. */
-- 
2.40.1


