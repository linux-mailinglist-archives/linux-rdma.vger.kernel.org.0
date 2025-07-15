Return-Path: <linux-rdma+bounces-12173-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1151B050B9
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 07:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F6E4A6E56
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 05:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8A12D3734;
	Tue, 15 Jul 2025 05:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DjAm0m9C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112061B85FD;
	Tue, 15 Jul 2025 05:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752556614; cv=fail; b=GBEaJdeLK9qhuQp+4fezEMOKRgy7JXUzm0RbytoHEwGj7/FLtnQY5D4iy9z28+b+3QUrgLZEdvdtCNn3hxeVwQFzIuqpf4UTF4OPZ8LFo8cfWcZxmqbHnH0cMnNYX6/109GMvVz2ispCA4WUuGPZBf523cwlmhBtp6Qgr1vmwfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752556614; c=relaxed/simple;
	bh=fm9aDgODGoBHEOMKX/5sxSKrMdy3XWourhfKI+5oyu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=drt/Z+xXx6uGHCAYk3dPbLQ+RFJfRCwajCRxZ/edV7FMghrvoNOQHSaXom6x0kUMMjJX5bNkGbEoXaEEmXMBGTlUEXAOr5+U2uy5Cic/szMPGmV8VX79Kdg9y2UCQQZWXkD67dFXjiscGSCdjOO0wJV5FxZSh+zKm8Ld6dERINc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DjAm0m9C; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wo/CCK3WCjQL0Zjg4q2w9+ceHFj4CSOpQo8jsZXqV32gbSfpuyc5t6i8Ftbg3XZGd7reHH2q7CMTC5aIO62NclItp0Q+HUTbzdrDFQk8n9i9ek/Jrxdv2x8oSbR6WFa0DujAJh9FQz4KFZuN4MNHYeoIdr+G//ZxmBa894MGKdDcD/eT3AaerE8jvJjGywAucLmAm+y0Mhay6MY8x60nVvMjIXylsODOkwDubYwWd1I+sxAbFk2vpOQYksUNK5ESHJf/6fhv5Fihk/tRMh618xSmLvtkjcAIGjXOiiUJejKny4jfw4pK4McolrS7KwuHbKmUerTaLPGSI2bb9kio9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Bqf4OYCmRwnkgtTilA4+7vuX61Mb20IffwZRDIMMpk=;
 b=qVvXTs0VDk/6w+f+9YAOA1t84ge8vkHN0Tvj/p7hYfy8Ec5ujR74snl7K9W7IpOFUFuJBIhYZihFcgx9IvI23NT/gGRp7cxegvJNUCBr1m9ziHAvzkqBOhvytHLJnLVqQCsADrsO4Dhd4glj9vQ/g9iVAi8OuON4eY1xHbK8TfnRjr+2zTweisa6mF5bkHHLHbO6aNCYfgRAgpADCVjSCTi5sklfMp39V+UvvnHYsW+oNey5gdmrnYaE5ggjBDHhonot1IOXlVoVZ4H2rvJNpw7bSC/b+vxMIEljHSI9052Vl9sBx4zlx6dG5ZhgPBn8kRDwWt52SVj1enP0pNe31Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Bqf4OYCmRwnkgtTilA4+7vuX61Mb20IffwZRDIMMpk=;
 b=DjAm0m9CEwEQ0fCV/2fiWAs6Okm9BBfgFklOC9H2pxWhsKmejCYplVU/VjYrnu97P8/YMJr3+0HKl3iJScatGGGufdaVY5+cYkFTSdMv96pMPC2GOGndQEM9GNDcVFQw0NyyoHMVneWLJtz4HcSo5O+a1/yRqMrIyUaDgL1iJH6cJUZYUAaLOjGmYTxlWXVUYvboFqyg+NqL/Y42vNQJ6/f3hBlIJMcqlpbtKVKrz3zc7bU8jafDHxal+J07zdVxU7w09O/x4w7S6xuwH7gOXpUX0f8oVOrrwwynAss+ilTGkFESHIHjehUvJqQRsED0xuOL9YZGGZwqiPQVN1QSLw==
Received: from MW4PR03CA0066.namprd03.prod.outlook.com (2603:10b6:303:b6::11)
 by PH8PR12MB7181.namprd12.prod.outlook.com (2603:10b6:510:22a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 05:16:48 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::b0) by MW4PR03CA0066.outlook.office365.com
 (2603:10b6:303:b6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.28 via Frontend Transport; Tue,
 15 Jul 2025 05:16:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 05:16:47 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Jul
 2025 22:16:33 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Jul
 2025 22:16:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 14
 Jul 2025 22:16:29 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>
Subject: [PATCH net-next 1/3] ptp: Add ioctl commands to expose raw cycle counter values
Date: Tue, 15 Jul 2025 08:15:31 +0300
Message-ID: <1752556533-39218-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752556533-39218-1-git-send-email-tariqt@nvidia.com>
References: <1752556533-39218-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|PH8PR12MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: ffc6299f-26a5-4073-54cc-08ddc35ecc49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WAHyvlxQ8toKHMFnXHAyRIquYcqIcFGkO+byLORh6P5UtgVCENm2WnbR0BUT?=
 =?us-ascii?Q?yYX5lFfJO2YfF86r9JXUSBGykbZ0kPinL0hNZwoAlQDr5Y5UFwt22Bs58V0W?=
 =?us-ascii?Q?euY9lMCqP29kTkVBCcQjaDGsw4t+mLnHj5YeI9CJbdhdTG0+15MqqYmXivFB?=
 =?us-ascii?Q?n/Sp+TB3b+abmofYko3lwIpG6C8k+4qyUrBZJdqQLSS983bzXEaqZfIn0SVX?=
 =?us-ascii?Q?T5tlKf8nlm0KZHomBUh6H3p/cd87PErBYsW8OTE2SOBty2DzatMgsnmi48bx?=
 =?us-ascii?Q?2qr4dRblSRMIgntfubqk1uair3XbCwKH9JwclH9/jlemGFG2FDukUezK1yFT?=
 =?us-ascii?Q?XGVCcVE+wGhnHa9ca2Y5EfqXhnLk/eig4xB0Ht1TNKCASdiqmyY7Kv0/OQxE?=
 =?us-ascii?Q?jYShzk2I4eb2HgO8i4yiFcAPdn3n4sx40lsNP1TPle6uiNbntC/S4HST+DbN?=
 =?us-ascii?Q?xOEC59iiJ0nVz6yTXrHuEDDJG8PaMbXBhzLiCV8DbuGmubjqkvOg6deyEWRg?=
 =?us-ascii?Q?uxAEII6VjlFPt2uR5aM60SB9NeAR8YwYVhFIeMlivfRhj5a83LNRL/c3GnPL?=
 =?us-ascii?Q?/sIh6iEeH/opDcGdIm2D5elCzzJJup6UiqN9go3VmFR0Nooum9csc1BaVq3J?=
 =?us-ascii?Q?vtxPnaMyX5jxZkC420CMQQvNXWGbakB9dXYiMR6xzODYioYzUPR7lsnSvnrY?=
 =?us-ascii?Q?E8qA7vSozscblxtyD8LdF0rWMv2bbwIS861qkZeamNUfjNN16hF/hVhz42DS?=
 =?us-ascii?Q?Mf+RAgsdorp9k9u++F7XFujPzFTvRtLCtu2uxEz5gwwcgNy9jvIZ3NmfJW+s?=
 =?us-ascii?Q?9NgliP34duDVi+HARKsiekDw3CtW1o2eaEZwDYX3GgLKE8FuCiQl6aRIn3Ll?=
 =?us-ascii?Q?QyALCBVtXdCBisM5XwdmObqRvXmes6CUX+l6JTLMnxI4H//p/Cp5EUdKmaIl?=
 =?us-ascii?Q?gddDT2uCq0BD9Y7E5/HB2rxSzCoUEv76zNmSzemOJddjxU+8BX22VYGDH1ek?=
 =?us-ascii?Q?1VDfhK7O3kFawGYU0pNS0GCdoaF52qC6Ma1jKoC4Ybzu9Fse2fAhU9Q1gy1a?=
 =?us-ascii?Q?4Eu4cE2xXsDsBoQKRbB65iySxCE1Kzq3vbCFZmIeDqgs378BIvIWyov9hDzg?=
 =?us-ascii?Q?D/tVp1FUUt+YmiS/VsZ1PYkKHOmkgOvjCdMG9NiViA3ISoHDlHhV4ILriK8v?=
 =?us-ascii?Q?rcFyl+FNX9B8JfSNaNJ0K8N2H3by4wfLS8vAxi7TE4+ZtOupJ59Ryyx91nLv?=
 =?us-ascii?Q?OZQLvr4zv3Gglo9ud27NjZST2UNL/74t7txMhlKVF0aYV8C6BEwHN8/i1eTT?=
 =?us-ascii?Q?nKqHBy6y2HisxdV2EnQzKlNUToNj26wOxfElUMorZXJZI0dQvCYdB/AdyAT3?=
 =?us-ascii?Q?e0IkoWaWXASupUgFEh5RGTT1/dJUO3AkQVQ6fdsvOHEMu9h/GZLL9uH8BxGg?=
 =?us-ascii?Q?TtZpdWfHR7w3xpnMKu93BGJDub0EvBU2kKRKosaNsuOCJtECO8WCoq+p/Myr?=
 =?us-ascii?Q?179ax7io7N08CiPZtNTqrDNu0G8tb0wJ/7gs?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 05:16:47.6688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc6299f-26a5-4073-54cc-08ddc35ecc49
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7181

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
2.31.1


