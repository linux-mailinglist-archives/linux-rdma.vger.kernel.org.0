Return-Path: <linux-rdma+bounces-9720-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD1BA98768
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 12:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A864444BE
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 10:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F7C26C3A3;
	Wed, 23 Apr 2025 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T6Ff3dKn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D609C26A08F;
	Wed, 23 Apr 2025 10:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745404269; cv=fail; b=X3so0nW86Cj0dvW3l5WPTQ5eCrtleip2OntAjQg+4nB74h6PBdo5ZAu1vN4nEfjVD295Uu7aWDNv1e4aH21XMDygOS+RJrm2hgXsU/hopnubs95gROl22X7SEu2d/bKjlcJoHqDvvCPZakDYOZCPxPv2dDRidieKpnf0EZP9w18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745404269; c=relaxed/simple;
	bh=UtXDpZeyYMPkC8Kp+qPF3U40YIfsqTiV/NfPa2XTxEA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SvRF6AjrQejIQLP3eWqDb99PiOEsYw+UDKQTlkA+1OKIPvCCzldOvRvJApvtllpMGRjliDSTuGkGhh6op8TQsoy6k14NKA90yKCRE9tnQ8YwhjbBUgcPqMsz76ExSTl+WndkB989OrAvAHGzE09zNU7FAXncUvi/y+/zDp3w6+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T6Ff3dKn; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmfqngTC1J9tPq9UN9KwJpwpp6Je6REqfttAaLB78m6UsFe+rgfiF3fyTrkH3S9bTAX7r0i3DAoE66hOq75tWhyI5ltq7HCTnuB9cwhjOCn4Sdi5P56X7eJvBnVFpcn0vxinHWTr9GfIDiAusjKh12BES2TpN+NZ8tqjgYjAbxNezyVo0mM5wyz32ayf4fLM9w0D0qLR3uKHHchUliauphqOxLDZZ+s9EyY4/tzAfLQhhCY+BPN4Zx5+NvZICywPM1azN3Yvm8u2lHIFdXfKNCV3wtOlntdYNj5ALy8AzOAQqI6VyA6BR/qOvuaziIuwifDSek757Jzj07gDy+aKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wgF5MsCzrWMm4EufauUR8fTvtLYro4GEVW1ZnG7EcU=;
 b=sxy5SU/PLsEGO9b45RNMetzw14ewksvwj1ZtjQIdJwsIS2br2U1/kYRGMw0d3WvNFezS8WMDwFqyIbi5zXg3pnEjnJDSwGSM2gifmnTDmD8GuyVWrEnhm1Zd1FDSKOIv6doSrhnOVBSBNSc3waqZ8k4O+Xha0iZwN7/mQwdX8EmZA9ssy+i/+ya+gG4BKdVyXbszzWgAFpHvXrqsAFuDc1nP/bmP0cqas0EVeMffKHH5Qhmbtv5rUFERKhPaPTfCVU5B+PK0OTaqq2nhwlCBpQQMHXHNtp3zc1OB0cZBmCZYmkSMA7BUqZpfWhnU536Z9ug7gKwbLG5er3Iv1BYPgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wgF5MsCzrWMm4EufauUR8fTvtLYro4GEVW1ZnG7EcU=;
 b=T6Ff3dKnHCUCaXKdOxywtpnugs4Oda9yvTRfvwV0JUJQUfKKazo+OxlUDF8jRxJITQrVr+pm9x3Q/vKL6YJpFUI7giYgaGiOzzfikcXA78nNEz7rz4/OJNDAieMKiBxG/OndX5cF7TYE5VX0NR/c6l8mzUI3uUmBzH7b1kf519c=
Received: from CH0PR07CA0030.namprd07.prod.outlook.com (2603:10b6:610:32::35)
 by PH0PR12MB7863.namprd12.prod.outlook.com (2603:10b6:510:28b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 10:30:59 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::5d) by CH0PR07CA0030.outlook.office365.com
 (2603:10b6:610:32::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 23 Apr 2025 10:30:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 10:30:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 05:30:56 -0500
Received: from xhdipdslab48.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 23 Apr 2025 05:30:49 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, =?UTF-8?q?Pablo=20Casc=C3=B3n?=
	<pablo.cascon@amd.com>
Subject: [PATCH 05/14] net: ionic: Provide doorbell and CMB region information
Date: Wed, 23 Apr 2025 15:59:04 +0530
Message-ID: <20250423102913.438027-6-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423102913.438027-1-abhijit.gangurde@amd.com>
References: <20250423102913.438027-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|PH0PR12MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: e31cb46e-a085-47d3-557b-08dd8251efc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czZUT25jTDdwYkszVEEwR1Fjc0pRZHJObnlOcS9NZVJMcUhENXF3OEpiRGdr?=
 =?utf-8?B?TTh1VTFITGFNaE4vTTA2SUpQeldHakpSaFZmZWtycnhSK25Sb08zUUlRL2o2?=
 =?utf-8?B?QkorZng4TkllejJlL01nR0FiZ0w5bm9nNmF1S3RHR2dKUFlUUUFlb0pTZ0V4?=
 =?utf-8?B?eERHMjM3SmdBbFd4VTNWNjlqM1ppUWd1cHc5WllRQmo1SzBFek5RV0JhWHRT?=
 =?utf-8?B?ajE5azdLd0pOMTdSaUdCbmR6bmxkQWpDWDRyZ2NiY0VQcHFYQlpJMWtmL3li?=
 =?utf-8?B?RzFrdVVaTEpNRDlnZ0xORWxjclBML2x5Mm5rVjVnRUJjZ2ltTm02K0VXYnFD?=
 =?utf-8?B?SElCVFg3eHM3L0wrZmVxQUI0Umh3aytwQ25xOXdzRjhvTnZIT0pnSkx6YTE2?=
 =?utf-8?B?RkdSU2pYeGZLZUl2ajkzYmJqeisvZXdIL3dLbmN2OTAzRy9GS1N6cGN4ZERM?=
 =?utf-8?B?a3Z6NUpDWHJSY0xEbVdEL3k5V2JpVDliYlRSNTFQNlhhbUpmdlV3UUZjY2M4?=
 =?utf-8?B?U1YxejRySlZiY1dMQmFVcTZrb2pGYi9FNlVabkQrVFF1OTdZaHpkR3NEQ2d0?=
 =?utf-8?B?VUpPTGlJOFBKNE1YUlpvVmhLdzVpVFVuTGlZbTJBVmlscFRUbW5DMFNKWWR0?=
 =?utf-8?B?RElkdFdKbGNHbXZ5L2pwRGpPQ25DZGVGN0NvSnI5VXE3RC9uejk5VHFaM0xu?=
 =?utf-8?B?aXd2YjNLSmlvR2trODByQnoxNWNGR0prV0tzeE5vOTNaSGl1S3d2UEdvb2Nj?=
 =?utf-8?B?czFmTlROZEQ4cWltbjFDTWgwTEhpNFdIMGFuakV6cW5xNW0vNlB6eWdxWWVD?=
 =?utf-8?B?Yy8yQmdnWTJQN2c5bzdIL2V0UGlzV2h3ZEQ5RWdvU0ZESU90MWZwY1JZakFF?=
 =?utf-8?B?cGdCcmtJQ0lubnFxL0VlaWVOQ0xmK25UV2lIWGxVUjBQQWRhVDVwL1V5YUIz?=
 =?utf-8?B?TUlEeXBwS2FYVnRaTjEyb0NMQU5TT1hNQ3pOZUREc1ppL0djMW1zblVhczRR?=
 =?utf-8?B?YkZ3L2JIWjRmcUZmdFpibkNyRElwQm5KZmV3YWtsbi92SnU0cGE4dFBFenFD?=
 =?utf-8?B?SmQyMm5PUUtsSWVqeHFzQVdhM2pCSE9icmNtcFVLcHFiNkV5L0VFMW93ZWRQ?=
 =?utf-8?B?elRFRnQrY2p0UkQrRHhhd1E0RHBJdFc0ZmIvdC91MjJ2dTJWLytzSTduWlo0?=
 =?utf-8?B?TTMzNDk2eXZYTG1qMzRhaTB0STdaU3VsREluTUxIZTlQd0dFMmtJZEUzOWFs?=
 =?utf-8?B?ZXNnWlpnaVRBeVowL0V0UlhPeUFDL0I5aFdTVzJ4VDVrOU92RW44VGlXTFFm?=
 =?utf-8?B?UWNrKzZPbmViaDN3SmF6TitRb2hPREZSV1JtdnZnWGJjUjF3dTVsQm1GV0Nj?=
 =?utf-8?B?bDZzcExSeDl5R3BHQk5tTG9zeGNya0JpeC80VXNFMmdrNmR2MlRqQTBHRldR?=
 =?utf-8?B?OWlrekR0aUhhREpJcVh4M0tHdkxCV2JnTmFMa2pEd1NPV0dMZHBGSUgyQ05O?=
 =?utf-8?B?c0pVT1dnaVlDKzRvZ2ZiLzRkRkEzTVgzcjlZK0xGa3Z3QlV5dlJoeDY3VWFu?=
 =?utf-8?B?aEZ5UkVtWHMwcTFkWWswSGZCUlpwc2VyV3ZYNDFyQmtHYTgveCtOY2hOMVh4?=
 =?utf-8?B?ZnZURlBqUTVmUDVRTzFDb1dVL0pCdDBlM2hFemdRRHp3bHVWRUJMQUNERnFU?=
 =?utf-8?B?c0VuVnc2bE9tc001WFUxRVJ4WTBMVXR5aEk0Y2RTK29OZ05NYnJaT3paVUVW?=
 =?utf-8?B?dlFjaGZ4dUtzd05PTFJDandPMWV4eTlQRFBuQUpVKzJpd3oxdDVLbUdNMjl6?=
 =?utf-8?B?WHZsZHgwRmFYTXFtV2c2T09aeVdZbll5Nk5ndTl1U3FYZUtlUmF0bTc0VjVq?=
 =?utf-8?B?TDN4L2ppeVNEY0ZlaFVVcEIycHVuaHE2dHVZUUdlaFA1czJQYXlVN2NRS1Q1?=
 =?utf-8?B?ZDQyTGtaclNiWEhMMEc4OVRzRzczWlhVQm9YNmJUMStEcXAwK1NGZ0FOdk1J?=
 =?utf-8?B?T0tRdTIyMlg4WEx4bHQ1eE9rQWNRMWFCK1czWnhXbWx5djJNUEFpSzRTN1pZ?=
 =?utf-8?B?cUxSSnZWUGxaNnBhVEhmbnFDUmhYUU9ZWkIvQT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 10:30:58.2764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e31cb46e-a085-47d3-557b-08dd8251efc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7863

The RDMA device needs information of controller memory bar and
doorbell capability to share with user context. Discover CMB regions
and express doorbell capabilities on device init.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Co-developed-by: Pablo Cascón <pablo.cascon@amd.com>
Signed-off-by: Pablo Cascón <pablo.cascon@amd.com>
Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_api.c   |  81 ++++++
 .../net/ethernet/pensando/ionic/ionic_api.h   |  78 +++++
 .../ethernet/pensando/ionic/ionic_bus_pci.c   |   2 +
 .../net/ethernet/pensando/ionic/ionic_dev.c   | 268 +++++++++++++++++-
 .../net/ethernet/pensando/ionic/ionic_dev.h   |  18 +-
 .../net/ethernet/pensando/ionic/ionic_if.h    |  89 ++++++
 .../net/ethernet/pensando/ionic/ionic_lif.c   |   2 +-
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  11 -
 8 files changed, 521 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_api.c b/drivers/net/ethernet/pensando/ionic/ionic_api.c
index 201053cf4ea8..90b4586a8ba0 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_api.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_api.c
@@ -5,6 +5,7 @@
 
 #include "ionic.h"
 #include "ionic_bus.h"
+#include "ionic_dev.h"
 #include "ionic_lif.h"
 
 struct net_device *ionic_api_get_netdev_from_handle(void *handle)
@@ -65,6 +66,33 @@ const struct ionic_devinfo *ionic_api_get_devinfo(void *handle)
 }
 EXPORT_SYMBOL_NS(ionic_api_get_devinfo, "NET_IONIC");
 
+struct ionic_qtype_info *
+ionic_api_get_queue_identity(void *handle, enum ionic_logical_qtype qtype)
+{
+	struct ionic_lif *lif = handle;
+
+	return &lif->qtype_info[qtype];
+}
+EXPORT_SYMBOL_NS(ionic_api_get_queue_identity, "NET_IONIC");
+
+u8 ionic_api_get_expdb(void *handle)
+{
+	struct ionic_lif *lif = handle;
+	u8 expdb_support = 0;
+
+	if (lif->ionic->idev.phy_cmb_expdb64_pages)
+		expdb_support |= IONIC_EXPDB_64B_WQE;
+	if (lif->ionic->idev.phy_cmb_expdb128_pages)
+		expdb_support |= IONIC_EXPDB_128B_WQE;
+	if (lif->ionic->idev.phy_cmb_expdb256_pages)
+		expdb_support |= IONIC_EXPDB_256B_WQE;
+	if (lif->ionic->idev.phy_cmb_expdb512_pages)
+		expdb_support |= IONIC_EXPDB_512B_WQE;
+
+	return expdb_support;
+}
+EXPORT_SYMBOL_NS(ionic_api_get_expdb, "NET_IONIC");
+
 int ionic_api_get_intr(void *handle, int *irq)
 {
 	struct ionic_intr_info intr_obj;
@@ -101,6 +129,19 @@ void ionic_api_put_intr(void *handle, int intr_index)
 }
 EXPORT_SYMBOL_NS(ionic_api_put_intr, "NET_IONIC");
 
+int ionic_api_get_cmb(void *handle, u32 *pgid, phys_addr_t *pgaddr, int order,
+		      u8 stride_log2, bool *expdb)
+{
+	return ionic_get_cmb(handle, pgid, pgaddr, order, stride_log2, expdb);
+}
+EXPORT_SYMBOL_NS(ionic_api_get_cmb, "NET_IONIC");
+
+void ionic_api_put_cmb(void *handle, u32 pgid, int order)
+{
+	ionic_put_cmb(handle, pgid, order);
+}
+EXPORT_SYMBOL_NS(ionic_api_put_cmb, "NET_IONIC");
+
 void ionic_api_kernel_dbpage(void *handle,
 			     struct ionic_intr __iomem **intr_ctrl,
 			     u32 *dbid, u64 __iomem **dbpage)
@@ -114,6 +155,46 @@ void ionic_api_kernel_dbpage(void *handle,
 }
 EXPORT_SYMBOL_NS(ionic_api_kernel_dbpage, "NET_IONIC");
 
+int ionic_api_get_dbid(void *handle, u32 *dbid, phys_addr_t *addr)
+{
+	struct ionic_lif *lif = handle;
+	int id, dbpage_num;
+
+	mutex_lock(&lif->dbid_inuse_lock);
+
+	if (!lif->dbid_inuse) {
+		mutex_unlock(&lif->dbid_inuse_lock);
+		return -EINVAL;
+	}
+
+	id = find_first_zero_bit(lif->dbid_inuse, lif->dbid_count);
+	if (id == lif->dbid_count) {
+		mutex_unlock(&lif->dbid_inuse_lock);
+		return -ENOMEM;
+	}
+
+	set_bit(id, lif->dbid_inuse);
+	mutex_unlock(&lif->dbid_inuse_lock);
+
+	dbpage_num = ionic_db_page_num(lif, id);
+	*dbid = id;
+	*addr = ionic_bus_phys_dbpage(lif->ionic, dbpage_num);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS(ionic_api_get_dbid, "NET_IONIC");
+
+void ionic_api_put_dbid(void *handle, int dbid)
+{
+	struct ionic_lif *lif = handle;
+
+	mutex_lock(&lif->dbid_inuse_lock);
+	if (lif->dbid_inuse)
+		clear_bit(dbid, lif->dbid_inuse);
+	mutex_unlock(&lif->dbid_inuse_lock);
+}
+EXPORT_SYMBOL_NS(ionic_api_put_dbid, "NET_IONIC");
+
 int ionic_api_adminq_post(void *handle, struct ionic_admin_ctx *ctx)
 {
 	return ionic_adminq_post(handle, ctx);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_api.h b/drivers/net/ethernet/pensando/ionic/ionic_api.h
index 80606a37ae45..22d9fbb49575 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_api.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_api.h
@@ -74,6 +74,39 @@ const struct ionic_devinfo *ionic_api_get_devinfo(void *handle);
  */
 void ionic_api_request_reset(void *handle);
 
+#define IONIC_EXPDB_64B_WQE	BIT(0)
+#define IONIC_EXPDB_128B_WQE	BIT(1)
+#define IONIC_EXPDB_256B_WQE	BIT(2)
+#define IONIC_EXPDB_512B_WQE	BIT(3)
+struct ionic_qtype_info {
+	u64 features;
+	u16 desc_sz;
+	u16 comp_sz;
+	u16 sg_desc_sz;
+	u16 max_sg_elems;
+	u16 sg_desc_stride;
+	u8  version;
+	u8  supported;
+};
+
+/**
+ * ionic_api_get_queue_identity - Get queue identity
+ * @handle:     Handle to lif
+ * @qtype:      Queue type (enum ionic_logical_qtype)
+ *
+ * Return: pointer to queue identity
+ */
+struct ionic_qtype_info *
+ionic_api_get_queue_identity(void *handle, enum ionic_logical_qtype qtype);
+
+/**
+ * ionic_api_get_expdb - Get express DB capability
+ * @handle:     Handle to lif
+ *
+ * Return: express DB capability flag
+ */
+u8 ionic_api_get_expdb(void *handle);
+
 /**
  * ionic_api_get_intr - Reserve a device interrupt index
  * @handle:     Handle to lif
@@ -94,6 +127,28 @@ int ionic_api_get_intr(void *handle, int *irq);
  */
 void ionic_api_put_intr(void *handle, int intr);
 
+/**
+ * ionic_api_get_cmb - Reserve cmb pages
+ * @handle:      Handle to lif
+ * @pgid:        First page index
+ * @pgaddr:      First page bus addr (contiguous)
+ * @order:       Log base two number of pages (PAGE_SIZE)
+ * @stride_log2: Size of stride to determine CMB pool
+ * @expdb:       Will be set to true if this CMB region has expdb enabled
+ *
+ * Return: zero or negative error status
+ */
+int ionic_api_get_cmb(void *handle, u32 *pgid, phys_addr_t *pgaddr, int order,
+		      u8 stride_log2, bool *expdb);
+
+/**
+ * ionic_api_put_cmb - Release cmb pages
+ * @handle:     Handle to lif
+ * @pgid:       First page index
+ * @order:      Log base two number of pages (PAGE_SIZE)
+ */
+void ionic_api_put_cmb(void *handle, u32 pgid, int order);
+
 /**
  * ionic_api_kernel_dbpage - Get mapped doorbell page for use in kernel space
  * @handle:     Handle to lif
@@ -111,6 +166,29 @@ void ionic_api_kernel_dbpage(void *handle,
 			     struct ionic_intr __iomem **intr_ctrl,
 			     u32 *dbid, u64 __iomem **dbpage);
 
+/**
+ * ionic_api_get_dbid - Reserve a doorbell id
+ * @handle:     Handle to lif
+ * @dbid:       Doorbell id
+ * @addr:       Phys address of doorbell page
+ *
+ * Reserve a doorbell id.  This corresponds with exactly one doorbell page at
+ * an offset from the doorbell page base address, that can be mapped into a
+ * user space process.
+ *
+ * Return: zero on success or negative error status
+ */
+int ionic_api_get_dbid(void *handle, u32 *dbid, phys_addr_t *addr);
+
+/**
+ * ionic_api_put_dbid - Release a doorbell id
+ * @handle:     Handle to lif
+ * @dbid:       Doorbell id
+ *
+ * Mark the doorbell id unused, so that it can be reserved again.
+ */
+void ionic_api_put_dbid(void *handle, int dbid);
+
 /**
  * struct ionic_admin_ctx - Admin command context
  * @work:       Work completion wait queue element
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index 5fa8840b063f..dcb02c93671b 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -278,6 +278,8 @@ static int ionic_setup_one(struct ionic *ionic)
 	}
 	ionic_debugfs_add_ident(ionic);
 
+	ionic_map_cmb(ionic);
+
 	err = ionic_init(ionic);
 	if (err) {
 		dev_err(dev, "Cannot init device: %d, aborting\n", err);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index 57edcde9e6f8..f042fa2380f5 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -199,13 +199,201 @@ void ionic_init_devinfo(struct ionic *ionic)
 	dev_dbg(ionic->dev, "fw_version %s\n", idev->dev_info.fw_version);
 }
 
+void ionic_map_disc_cmb(struct ionic *ionic)
+{
+	struct ionic_identity *ident = &ionic->ident;
+	u32 length_reg0, length, offset, num_regions;
+	struct ionic_dev_bar *bar = ionic->bars;
+	struct ionic_dev *idev = &ionic->idev;
+	struct device *dev = ionic->dev;
+	int err, sz, i;
+	u64 end;
+
+	mutex_lock(&ionic->dev_cmd_lock);
+
+	ionic_dev_cmd_discover_cmb(idev);
+	err = ionic_dev_cmd_wait(ionic, DEVCMD_TIMEOUT);
+	if (!err) {
+		sz = min(sizeof(ident->cmb_layout),
+			 sizeof(idev->dev_cmd_regs->data));
+		memcpy_fromio(&ident->cmb_layout,
+			      &idev->dev_cmd_regs->data, sz);
+	}
+	mutex_unlock(&ionic->dev_cmd_lock);
+
+	if (err) {
+		dev_warn(dev, "Cannot discover CMB layout, disabling CMB\n");
+		return;
+	}
+
+	bar += 2;
+
+	num_regions = le32_to_cpu(ident->cmb_layout.num_regions);
+	if (!num_regions || num_regions > IONIC_MAX_CMB_REGIONS) {
+		dev_warn(dev, "Invalid number of CMB entries (%d)\n",
+			 num_regions);
+		return;
+	}
+
+	dev_dbg(dev, "ionic_cmb_layout_identity num_regions %d flags %x:\n",
+		num_regions, ident->cmb_layout.flags);
+
+	for (i = 0; i < num_regions; i++) {
+		offset = le32_to_cpu(ident->cmb_layout.region[i].offset);
+		length = le32_to_cpu(ident->cmb_layout.region[i].length);
+		end = offset + length;
+
+		dev_dbg(dev, "CMB entry %d: bar_num %u cmb_type %u offset %x length %u\n",
+			i, ident->cmb_layout.region[i].bar_num,
+			ident->cmb_layout.region[i].cmb_type,
+			offset, length);
+
+		if (end > (bar->len >> IONIC_CMB_SHIFT_64K)) {
+			dev_warn(dev, "Out of bounds CMB region %d offset %x length %u\n",
+				 i, offset, length);
+			return;
+		}
+	}
+
+	/* if first entry matches PCI config, expdb is not supported */
+	if (ident->cmb_layout.region[0].bar_num == bar->res_index &&
+	    le32_to_cpu(ident->cmb_layout.region[0].length) == bar->len &&
+	    !ident->cmb_layout.region[0].offset) {
+		dev_warn(dev, "No CMB mapping discovered\n");
+		return;
+	}
+
+	/* process first entry for regular mapping */
+	length_reg0 = le32_to_cpu(ident->cmb_layout.region[0].length);
+	if (!length_reg0) {
+		dev_warn(dev, "region len = 0. No CMB mapping discovered\n");
+		return;
+	}
+
+	/* Verify first entry size matches expected 8MB size (in 64KB pages) */
+	if (length_reg0 != IONIC_BAR2_CMB_ENTRY_SIZE >> IONIC_CMB_SHIFT_64K) {
+		dev_warn(dev, "Unexpected CMB size in entry 0: %u pages\n",
+			 length_reg0);
+		return;
+	}
+
+	sz = BITS_TO_LONGS((length_reg0 << IONIC_CMB_SHIFT_64K) /
+			    PAGE_SIZE) * sizeof(long);
+	idev->cmb_inuse = kzalloc(sz, GFP_KERNEL);
+	if (!idev->cmb_inuse) {
+		dev_warn(dev, "No memory for CMB, disabling\n");
+		idev->phy_cmb_pages = 0;
+		idev->phy_cmb_expdb64_pages = 0;
+		idev->phy_cmb_expdb128_pages = 0;
+		idev->phy_cmb_expdb256_pages = 0;
+		idev->phy_cmb_expdb512_pages = 0;
+		idev->cmb_npages = 0;
+		return;
+	}
+
+	for (i = 0; i < num_regions; i++) {
+		/* check this region matches first region length as to
+		 * ease implementation
+		 */
+		if (le32_to_cpu(ident->cmb_layout.region[i].length) !=
+		    length_reg0)
+			continue;
+
+		offset = le32_to_cpu(ident->cmb_layout.region[i].offset);
+
+		switch (ident->cmb_layout.region[i].cmb_type) {
+		case IONIC_CMB_TYPE_DEVMEM:
+			idev->phy_cmb_pages = bar->bus_addr + offset;
+			idev->cmb_npages =
+			    (length_reg0 << IONIC_CMB_SHIFT_64K) / PAGE_SIZE;
+			dev_dbg(dev, "regular cmb mapping: bar->bus_addr %pa region[%d].length %u\n",
+				&bar->bus_addr, i, length);
+			dev_dbg(dev, "idev->phy_cmb_pages %pad, idev->cmb_npages %u\n",
+				&idev->phy_cmb_pages, idev->cmb_npages);
+			break;
+
+		case IONIC_CMB_TYPE_EXPDB64:
+			idev->phy_cmb_expdb64_pages =
+				bar->bus_addr + (offset << IONIC_CMB_SHIFT_64K);
+			dev_dbg(dev, "idev->phy_cmb_expdb64_pages %pad\n",
+				&idev->phy_cmb_expdb64_pages);
+			break;
+
+		case IONIC_CMB_TYPE_EXPDB128:
+			idev->phy_cmb_expdb128_pages =
+				bar->bus_addr + (offset << IONIC_CMB_SHIFT_64K);
+			dev_dbg(dev, "idev->phy_cmb_expdb128_pages %pad\n",
+				&idev->phy_cmb_expdb128_pages);
+			break;
+
+		case IONIC_CMB_TYPE_EXPDB256:
+			idev->phy_cmb_expdb256_pages =
+				bar->bus_addr + (offset << IONIC_CMB_SHIFT_64K);
+			dev_dbg(dev, "idev->phy_cmb_expdb256_pages %pad\n",
+				&idev->phy_cmb_expdb256_pages);
+			break;
+
+		case IONIC_CMB_TYPE_EXPDB512:
+			idev->phy_cmb_expdb512_pages =
+				bar->bus_addr + (offset << IONIC_CMB_SHIFT_64K);
+			dev_dbg(dev, "idev->phy_cmb_expdb512_pages %pad\n",
+				&idev->phy_cmb_expdb512_pages);
+			break;
+
+		default:
+			dev_warn(dev, "[%d] Invalid cmb_type (%d)\n",
+				 i, ident->cmb_layout.region[i].cmb_type);
+			break;
+		}
+	}
+}
+
+void ionic_map_classic_cmb(struct ionic *ionic)
+{
+	struct ionic_dev_bar *bar = ionic->bars;
+	struct ionic_dev *idev = &ionic->idev;
+	struct device *dev = ionic->dev;
+	int sz;
+
+	bar += 2;
+	/* classic CMB mapping */
+	idev->phy_cmb_pages = bar->bus_addr;
+	idev->cmb_npages = bar->len / PAGE_SIZE;
+	dev_dbg(dev, "classic cmb mapping: bar->bus_addr %pa bar->len %lu\n",
+		&bar->bus_addr, bar->len);
+	dev_dbg(dev, "idev->phy_cmb_pages %pad, idev->cmb_npages %u\n",
+		&idev->phy_cmb_pages, idev->cmb_npages);
+
+	sz = BITS_TO_LONGS(idev->cmb_npages) * sizeof(long);
+	idev->cmb_inuse = kzalloc(sz, GFP_KERNEL);
+	if (!idev->cmb_inuse) {
+		idev->phy_cmb_pages = 0;
+		idev->cmb_npages = 0;
+	}
+}
+
+void ionic_map_cmb(struct ionic *ionic)
+{
+	struct pci_dev *pdev = ionic->pdev;
+	struct device *dev = ionic->dev;
+
+	if (!(pci_resource_flags(pdev, 4) & IORESOURCE_MEM)) {
+		dev_dbg(dev, "No CMB, disabling\n");
+		return;
+	}
+
+	if (ionic->ident.dev.capabilities & cpu_to_le64(IONIC_DEV_CAP_DISC_CMB))
+		ionic_map_disc_cmb(ionic);
+	else
+		ionic_map_classic_cmb(ionic);
+}
+
 int ionic_dev_setup(struct ionic *ionic)
 {
 	struct ionic_dev_bar *bar = ionic->bars;
 	unsigned int num_bars = ionic->num_bars;
 	struct ionic_dev *idev = &ionic->idev;
 	struct device *dev = ionic->dev;
-	int size;
 	u32 sig;
 	int err;
 
@@ -255,16 +443,11 @@ int ionic_dev_setup(struct ionic *ionic)
 	mutex_init(&idev->cmb_inuse_lock);
 	if (num_bars < 3 || !ionic->bars[IONIC_PCI_BAR_CMB].len) {
 		idev->cmb_inuse = NULL;
+		idev->phy_cmb_pages = 0;
+		idev->cmb_npages = 0;
 		return 0;
 	}
 
-	idev->phy_cmb_pages = bar->bus_addr;
-	idev->cmb_npages = bar->len / PAGE_SIZE;
-	size = BITS_TO_LONGS(idev->cmb_npages) * sizeof(long);
-	idev->cmb_inuse = kzalloc(size, GFP_KERNEL);
-	if (!idev->cmb_inuse)
-		dev_warn(dev, "No memory for CMB, disabling\n");
-
 	return 0;
 }
 
@@ -277,6 +460,11 @@ void ionic_dev_teardown(struct ionic *ionic)
 	idev->phy_cmb_pages = 0;
 	idev->cmb_npages = 0;
 
+	idev->phy_cmb_expdb64_pages = 0;
+	idev->phy_cmb_expdb128_pages = 0;
+	idev->phy_cmb_expdb256_pages = 0;
+	idev->phy_cmb_expdb512_pages = 0;
+
 	if (ionic->wq) {
 		destroy_workqueue(ionic->wq);
 		ionic->wq = NULL;
@@ -698,25 +886,75 @@ void ionic_dev_cmd_adminq_init(struct ionic_dev *idev, struct ionic_qcq *qcq,
 	ionic_dev_cmd_go(idev, &cmd);
 }
 
+void ionic_dev_cmd_discover_cmb(struct ionic_dev *idev)
+{
+	union ionic_dev_cmd cmd = {
+		.discover_cmb.opcode = IONIC_CMD_DISCOVER_CMB,
+	};
+
+	ionic_dev_cmd_go(idev, &cmd);
+}
+
 int ionic_db_page_num(struct ionic_lif *lif, int pid)
 {
 	return (lif->hw_index * lif->dbid_count) + pid;
 }
 
-int ionic_get_cmb(struct ionic_lif *lif, u32 *pgid, phys_addr_t *pgaddr, int order)
+int ionic_get_cmb(struct ionic_lif *lif, u32 *pgid, phys_addr_t *pgaddr,
+		  int order, u8 stride_log2, bool *expdb)
 {
 	struct ionic_dev *idev = &lif->ionic->idev;
-	int ret;
+	void __iomem *nonexpdb_pgptr;
+	phys_addr_t nonexpdb_pgaddr;
+	int i, idx;
 
 	mutex_lock(&idev->cmb_inuse_lock);
-	ret = bitmap_find_free_region(idev->cmb_inuse, idev->cmb_npages, order);
+	idx = bitmap_find_free_region(idev->cmb_inuse, idev->cmb_npages, order);
 	mutex_unlock(&idev->cmb_inuse_lock);
 
-	if (ret < 0)
-		return ret;
+	if (idx < 0)
+		return idx;
+
+	*pgid = (u32)idx;
+
+	if (idev->phy_cmb_expdb64_pages &&
+	    stride_log2 == IONIC_EXPDB_64B_WQE_LG2) {
+		*pgaddr = idev->phy_cmb_expdb64_pages + idx * PAGE_SIZE;
+		if (expdb)
+			*expdb = true;
+	} else if (idev->phy_cmb_expdb128_pages &&
+		  stride_log2 == IONIC_EXPDB_128B_WQE_LG2) {
+		*pgaddr = idev->phy_cmb_expdb128_pages + idx * PAGE_SIZE;
+		if (expdb)
+			*expdb = true;
+	} else if (idev->phy_cmb_expdb256_pages &&
+		  stride_log2 == IONIC_EXPDB_256B_WQE_LG2) {
+		*pgaddr = idev->phy_cmb_expdb256_pages + idx * PAGE_SIZE;
+		if (expdb)
+			*expdb = true;
+	} else if (idev->phy_cmb_expdb512_pages &&
+		  stride_log2 == IONIC_EXPDB_512B_WQE_LG2) {
+		*pgaddr = idev->phy_cmb_expdb512_pages + idx * PAGE_SIZE;
+		if (expdb)
+			*expdb = true;
+	} else {
+		*pgaddr = idev->phy_cmb_pages + idx * PAGE_SIZE;
+		if (expdb)
+			*expdb = false;
+	}
 
-	*pgid = ret;
-	*pgaddr = idev->phy_cmb_pages + ret * PAGE_SIZE;
+	/* clear the requested CMB region, 1 PAGE_SIZE ioremap at a time */
+	nonexpdb_pgaddr = idev->phy_cmb_pages + idx * PAGE_SIZE;
+	for (i = 0; i < (1 << order); i++) {
+		nonexpdb_pgptr =
+			ioremap_wc(nonexpdb_pgaddr + i * PAGE_SIZE, PAGE_SIZE);
+		if (!nonexpdb_pgptr) {
+			ionic_put_cmb(lif, *pgid, order);
+			return -ENOMEM;
+		}
+		memset_io(nonexpdb_pgptr, 0, PAGE_SIZE);
+		iounmap(nonexpdb_pgptr);
+	}
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index afda7204b6e2..cf48a6cadfce 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -35,6 +35,11 @@
 #define IONIC_RX_MIN_DOORBELL_DEADLINE	(HZ / 100)	/* 10ms */
 #define IONIC_RX_MAX_DOORBELL_DEADLINE	(HZ * 4)	/* 4s */
 
+#define IONIC_EXPDB_64B_WQE_LG2		6
+#define IONIC_EXPDB_128B_WQE_LG2	7
+#define IONIC_EXPDB_256B_WQE_LG2	8
+#define IONIC_EXPDB_512B_WQE_LG2	9
+
 struct ionic_dev_bar {
 	void __iomem *vaddr;
 	phys_addr_t bus_addr;
@@ -164,6 +169,11 @@ struct ionic_dev {
 	dma_addr_t phy_cmb_pages;
 	u32 cmb_npages;
 
+	dma_addr_t phy_cmb_expdb64_pages;
+	dma_addr_t phy_cmb_expdb128_pages;
+	dma_addr_t phy_cmb_expdb256_pages;
+	dma_addr_t phy_cmb_expdb512_pages;
+
 	u32 port_info_sz;
 	struct ionic_port_info *port_info;
 	dma_addr_t port_info_pa;
@@ -355,9 +365,15 @@ void ionic_dev_cmd_lif_reset(struct ionic_dev *idev, u16 lif_index);
 void ionic_dev_cmd_adminq_init(struct ionic_dev *idev, struct ionic_qcq *qcq,
 			       u16 lif_index, u16 intr_index);
 
+void ionic_dev_cmd_discover_cmb(struct ionic_dev *idev);
+
 int ionic_db_page_num(struct ionic_lif *lif, int pid);
 
-int ionic_get_cmb(struct ionic_lif *lif, u32 *pgid, phys_addr_t *pgaddr, int order);
+void ionic_map_disc_cmb(struct ionic *ionic);
+void ionic_map_classic_cmb(struct ionic *ionic);
+void ionic_map_cmb(struct ionic *ionic);
+int ionic_get_cmb(struct ionic_lif *lif, u32 *pgid, phys_addr_t *pgaddr,
+		  int order, u8 stride_log2, bool *expdb);
 void ionic_put_cmb(struct ionic_lif *lif, u32 pgid, int order);
 
 int ionic_cq_init(struct ionic_lif *lif, struct ionic_cq *cq,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_if.h b/drivers/net/ethernet/pensando/ionic/ionic_if.h
index f97f5d87b2ce..c796b310153b 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_if.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_if.h
@@ -56,6 +56,9 @@ enum ionic_cmd_opcode {
 	IONIC_CMD_VF_SETATTR			= 61,
 	IONIC_CMD_VF_CTRL			= 62,
 
+	/* CMB command */
+	IONIC_CMD_DISCOVER_CMB			= 80,
+
 	/* QoS commands */
 	IONIC_CMD_QOS_CLASS_IDENTIFY		= 240,
 	IONIC_CMD_QOS_CLASS_INIT		= 241,
@@ -269,9 +272,11 @@ union ionic_drv_identity {
 /**
  * enum ionic_dev_capability - Device capabilities
  * @IONIC_DEV_CAP_VF_CTRL:     Device supports VF ctrl operations
+ * @IONIC_DEV_CAP_DISC_CMB:    Device supports CMB discovery operations
  */
 enum ionic_dev_capability {
 	IONIC_DEV_CAP_VF_CTRL        = BIT(0),
+	IONIC_DEV_CAP_DISC_CMB       = BIT(1),
 };
 
 /**
@@ -395,6 +400,7 @@ enum ionic_logical_qtype {
  * @IONIC_Q_F_4X_DESC:      Quadruple main descriptor size
  * @IONIC_Q_F_4X_CQ_DESC:   Quadruple cq descriptor size
  * @IONIC_Q_F_4X_SG_DESC:   Quadruple sg descriptor size
+ * @IONIC_QIDENT_F_EXPDB:   Queue supports express doorbell
  */
 enum ionic_q_feature {
 	IONIC_QIDENT_F_CQ		= BIT_ULL(0),
@@ -407,6 +413,7 @@ enum ionic_q_feature {
 	IONIC_Q_F_4X_DESC		= BIT_ULL(7),
 	IONIC_Q_F_4X_CQ_DESC		= BIT_ULL(8),
 	IONIC_Q_F_4X_SG_DESC		= BIT_ULL(9),
+	IONIC_QIDENT_F_EXPDB		= BIT_ULL(10),
 };
 
 /**
@@ -2210,6 +2217,80 @@ struct ionic_vf_ctrl_comp {
 	u8      rsvd[15];
 };
 
+/**
+ * struct ionic_discover_cmb_cmd - CMB discovery command
+ * @opcode: Opcode for the command
+ * @rsvd:   Reserved bytes
+ */
+struct ionic_discover_cmb_cmd {
+	u8	opcode;
+	u8	rsvd[63];
+};
+
+/**
+ * struct ionic_discover_cmb_comp - CMB discover command completion.
+ * @status: Status of the command (enum ionic_status_code)
+ * @rsvd:   Reserved bytes
+ */
+struct ionic_discover_cmb_comp {
+	u8	status;
+	u8	rsvd[15];
+};
+
+#define IONIC_MAX_CMB_REGIONS	16
+#define IONIC_CMB_SHIFT_64K	16
+
+enum ionic_cmb_type {
+	IONIC_CMB_TYPE_DEVMEM	= 0,
+	IONIC_CMB_TYPE_EXPDB64	= 1,
+	IONIC_CMB_TYPE_EXPDB128	= 2,
+	IONIC_CMB_TYPE_EXPDB256	= 3,
+	IONIC_CMB_TYPE_EXPDB512	= 4,
+};
+
+/**
+ * union ionic_cmb_region - Configuration for CMB region
+ * @bar_num:	CMB mapping number from FW
+ * @cmb_type:	Type of CMB this region describes (enum ionic_cmb_type)
+ * @rsvd:	Reserved
+ * @offset:	Offset within BAR in 64KB pages
+ * @length:	Length of the CMB region
+ * @words:	32-bit words for direct access to the entire region
+ */
+union ionic_cmb_region {
+	struct {
+		u8	bar_num;
+		u8	cmb_type;
+		u8	rsvd[6];
+		__le32	offset;
+		__le32	length;
+	} __packed;
+	__le32  words[4];
+};
+
+/**
+ * union ionic_discover_cmb_identity - CMB layout identity structure
+ * @num_regions:    Number of CMB regions, up to 16
+ * @flags:          Feature and capability bits (0 for express
+ *                  doorbell, 1 for 4K alignment indicator,
+ *                  31-24 for version information)
+ * @region:         CMB mappings region, entry 0 for regular
+ *                  mapping, entries 1-7 for WQE sizes 64,
+ *                  128, 256, 512, 1024, 2048 and 4096 bytes
+ * @words:          Full union buffer size
+ */
+union ionic_discover_cmb_identity {
+	struct {
+		__le32 num_regions;
+#define IONIC_CMB_FLAG_EXPDB	BIT(0)
+#define IONIC_CMB_FLAG_4KALIGN	BIT(1)
+#define IONIC_CMB_FLAG_VERSION	0xff000000
+		__le32 flags;
+		union ionic_cmb_region region[IONIC_MAX_CMB_REGIONS];
+	};
+	__le32 words[478];
+};
+
 /**
  * struct ionic_qos_identify_cmd - QoS identify command
  * @opcode:  opcode
@@ -3057,6 +3138,8 @@ union ionic_dev_cmd {
 	struct ionic_vf_getattr_cmd vf_getattr;
 	struct ionic_vf_ctrl_cmd vf_ctrl;
 
+	struct ionic_discover_cmb_cmd discover_cmb;
+
 	struct ionic_lif_identify_cmd lif_identify;
 	struct ionic_lif_init_cmd lif_init;
 	struct ionic_lif_reset_cmd lif_reset;
@@ -3096,6 +3179,8 @@ union ionic_dev_cmd_comp {
 	struct ionic_vf_getattr_comp vf_getattr;
 	struct ionic_vf_ctrl_comp vf_ctrl;
 
+	struct ionic_discover_cmb_comp discover_cmb;
+
 	struct ionic_lif_identify_comp lif_identify;
 	struct ionic_lif_init_comp lif_init;
 	ionic_lif_reset_comp lif_reset;
@@ -3237,6 +3322,9 @@ union ionic_adminq_comp {
 #define IONIC_BAR0_DEV_CMD_DATA_REGS_OFFSET	0x0c00
 #define IONIC_BAR0_INTR_STATUS_OFFSET		0x1000
 #define IONIC_BAR0_INTR_CTRL_OFFSET		0x2000
+
+/* BAR2 */
+#define IONIC_BAR2_CMB_ENTRY_SIZE		0x800000
 #define IONIC_DEV_CMD_DONE			0x00000001
 
 #define IONIC_ASIC_TYPE_NONE			0
@@ -3290,6 +3378,7 @@ struct ionic_identity {
 	union ionic_port_identity port;
 	union ionic_qos_identity qos;
 	union ionic_q_identity txq;
+	union ionic_discover_cmb_identity cmb_layout;
 };
 
 #endif /* _IONIC_IF_H_ */
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index c1ad2b95d2b9..15f8bfc56566 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -672,7 +672,7 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 			new->cmb_order = order_base_2(new->cmb_q_size / PAGE_SIZE);
 
 			err = ionic_get_cmb(lif, &new->cmb_pgid, &new->cmb_q_base_pa,
-					    new->cmb_order);
+					    new->cmb_order, 0, NULL);
 			if (err) {
 				netdev_err(lif->netdev,
 					   "Cannot allocate queue order %d from cmb: err %d\n",
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index 54c8bbe8960a..aae4824d08fa 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -167,17 +167,6 @@ enum ionic_lif_state_flags {
 	IONIC_LIF_F_STATE_SIZE
 };
 
-struct ionic_qtype_info {
-	u8  version;
-	u8  supported;
-	u64 features;
-	u16 desc_sz;
-	u16 comp_sz;
-	u16 sg_desc_sz;
-	u16 max_sg_elems;
-	u16 sg_desc_stride;
-};
-
 struct ionic_phc;
 
 #define IONIC_LIF_NAME_MAX_SZ		32
-- 
2.34.1


