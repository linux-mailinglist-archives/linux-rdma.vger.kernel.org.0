Return-Path: <linux-rdma+bounces-10137-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A84AAF262
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 07:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA861C07365
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 05:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CF52144A5;
	Thu,  8 May 2025 05:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1DXAMwd2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C0320E000;
	Thu,  8 May 2025 05:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746680478; cv=fail; b=SC5tfpCYiHdIfnvRaL+u8SgGcia3U0Efti0NX2fDPCSSYQ9wHYXAr5fdLLqgzrdWG5GGuTE3WjWFv3EPOM03t4XfU/Ye2HuZjQQczUoHVfwv97zQ7VNRccVZNPIkbJc0ekflnhq0HmZUuerpgd6XXR/U8Erqynx7urLjPGFRB3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746680478; c=relaxed/simple;
	bh=Pj7th5Kk1LbaOdfP8F1QmbaGJ9tUVaLO645VYNwWftY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TmImhuX4vVXK0z8q2+0aflwTkBW8hy/4okLVEDTG/C/ptFT8JbenyuyRrxirYkidMP37/A3sUcOY9WatIIzUwQhmeCAgaAkWVcUfJo6KAA6I1WwMbQ8iAuNb+rcMxxIEzfR0AbDbAP4t1/GJte4w4Gk6zmUk7KxILJGkHpOt1do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1DXAMwd2; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtV+nKP41TQ//GN+EoRTI27bkBrt+Nk9QYU/WV/qaYHDkDQVLSbe9xRTP5YTZ/s5qZUgoiht1+Ynck9s7d1nr4FC+TcNkqqos4NzlM+3y9FLCKgLvp4rEal0BJ2pWUalUdxkVQjDaK8/YP98AubC25O886A97oZ3/2R8d9kvDc50F/tLqaQ6l2G/eKaAlR0n8zVakH2QAWQHbJOEknCkgXxn9V2YYRVQeeBg1kJeCXBo/MoXM1Lzo+6MvyxR298NBDIJgVEheUPh4UbTqzotlQHtp0PhM3rS00YN5Th7ofHqR7mMZHlybDQjd5NKvJITPSChFSBX3byRXPmSKL8olg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrmTijwsrplb1XYR1omfQow2aYPsKYWefZ1HrQbDvBQ=;
 b=e5IuubaJ3Yy3AWQm6giPyiREpQfJOvlfmxRWpFS8I/uMFGfLTvDez5mKN0vWlmAecYJ18AA+kT05kmK8M5BkRALnqlz5E8HFr8LiSC6n6YHVVBBbSrEWwJL3RyWwAeFJa9cuKTiREed9smcQemnH2SYQlgMnGaaOiDfDkIygV6/BEXP09v1pPQ9OsZNYzlHwc7VgUWPlI7cCkI5lGbwjav8UsUCygnoGaPe3LxeeFonmQTXbzayUKfOIBBUvvcA0vQ4qmmQ+6gDhhxDkrp5ukl0Kezz03gAHxTdaEeUwjxcUzbPlg8D5h1+mps/VUchWqnol9mJH74IRzWwJBzCGlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrmTijwsrplb1XYR1omfQow2aYPsKYWefZ1HrQbDvBQ=;
 b=1DXAMwd2tcgtr1XDYnbMrF8idwNVjAdIAKomqNhqocboycf/1qhEI7yzUA0AqMPwsRnF18yyhKvw0kLnGlZhclKecN4p8gVaPOZ7V08B2/1SWVcUKgb3C4S01AL/J8/4ixkACCB6PQofmR/QnTiX5JqiVLsz8G9VDKTi9B02y+E=
Received: from PH7P220CA0155.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::8)
 by CYYPR12MB8890.namprd12.prod.outlook.com (2603:10b6:930:c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 8 May
 2025 05:01:06 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:33b:cafe::78) by PH7P220CA0155.outlook.office365.com
 (2603:10b6:510:33b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.32 via Frontend Transport; Thu,
 8 May 2025 05:01:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 05:01:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:01:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:01:00 -0500
Received: from xhdipdslab61.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 8 May 2025 00:00:56 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, =?UTF-8?q?Pablo=20Casc=C3=B3n?=
	<pablo.cascon@amd.com>
Subject: [PATCH v2 06/14] net: ionic: Provide doorbell and CMB region information
Date: Thu, 8 May 2025 10:29:49 +0530
Message-ID: <20250508045957.2823318-7-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
References: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|CYYPR12MB8890:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d39bb1-5ab0-4ce3-e4a3-08dd8ded56f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHJRblBJMWVjTlZORG8vZk9ZeG8rK2Vkdk1nckpZSzNsWVAvWVNMYnBybzVY?=
 =?utf-8?B?YmNPS2dWSEJKZExuTlJ3L1ZoTGRuVjJmRjNNR21EWWpOV0YzNW04V3pvNEFu?=
 =?utf-8?B?amZhbXZET2d3UUdTRW0wOFp0cTZsL21paHJNcUQ1aVYxM2hId1dsaThzWERF?=
 =?utf-8?B?bEE2SWNVSGcyS3l1a2VRa3RqQWFkRnRoWStHYTJha1NwSnlCVWFubXVEZWxS?=
 =?utf-8?B?VG1zVFlEWXk3MWlIMFBKMURudTNoclIzaVpmbHF6M3FVekNBdW4wUzNoNnJE?=
 =?utf-8?B?WkoyUnQ0b0hWVm94NGowaGN1Zk1ZZzczZjBiZ0M3V2Y0UitEMkNEVVdvRlRp?=
 =?utf-8?B?Nk5KSjV6Vis2aGpyQTl5ZUpLbWNySVVoNmVrRE9oeUVuMkpteUVUOWltNEVQ?=
 =?utf-8?B?UUNJYmhjT3N0bzZRNzhla3BuMmk1TWpCT01nNWx3aEdhdDdVYlpiRFp6QkRs?=
 =?utf-8?B?SDlldlZFNUE5Z2ZicHc4UjBieXQwOVZTL0JrZmFUZDd6bUNPaEg3R2VJTm9u?=
 =?utf-8?B?RVVXdVllZDRnOHArSnB4b0RTQ3pUQk00QTI2Wjc4dTlDcEtjREVlZEdyWDkx?=
 =?utf-8?B?VlY1Skd2b3VsRHdRaUt6MjY3Q25kbmdneUZDakhHRnRDYk92alZtWk13TGZl?=
 =?utf-8?B?dHJ3V2VyMGFEekZ5VTVFaVk4aHVNREkrSXBhdklkL0pkSDVtV0ZyNzBldVhJ?=
 =?utf-8?B?anJFTWsrSDZqbFQvUG4vb2N4ajlBOHFLNWs5Vyt4WHBtcW9TZFVVU25GSkk4?=
 =?utf-8?B?TmRxSzI2QWhNeUdDQThuNEphbFhoVCtnczhlUjFOWGVwL3Z5Y3pUaEVkbGRR?=
 =?utf-8?B?SFQzNlcwcW41Um1hYVAvZ1NyNWY3OFhPclJPQURMMDNTME11OTVhS2U3NjVu?=
 =?utf-8?B?cHQ1cnhNMm42a3RzaFpSNG10KzRoRGtkL3hmN1k4dk85YThtOWJyY2RkaUIw?=
 =?utf-8?B?ajF6ZUVDUHFvcmx4WWhxcGZsaTF5ZWcxc2JZQmgzb0hYam5NM2t4d2ZCdjBs?=
 =?utf-8?B?b2lVK055TkNaejVLaEMvRzVVTVordEhJc1g1emFyZlJJRVNtR3lqNjhqQWJ4?=
 =?utf-8?B?RmhvY1UxZWJ5aUlkL1l1YjRMdmlZc2U0NWpKWmVtdlcrVXhqTDAvbGFIM1A5?=
 =?utf-8?B?MHNkblJWcUdIUFJJVitkSitKV01JSDhNSG9uZzV2RnFyYTMzUTUxZEE0ZDI5?=
 =?utf-8?B?V1B2WFZTUXp5V2JEbjhIblhHMlJOQi9ZdU5FQUdpUVJOYnR3VzMzVXhBcTJD?=
 =?utf-8?B?S1RoaGZrdVRuRXJTRVVQZDRvc2ZWV0h2MDJkRXFiNDlXR1lxRDQ3bTZrOVlE?=
 =?utf-8?B?VVF4djM5dHl0NkMxcnZSaTJBaC8zM2dRVno0UTgvT0pjM1NvSVRSRjRNR2Nj?=
 =?utf-8?B?UlN6VEhUMVhWQ1BKdmkrQ2p6cGpCbkVpdmpFNWRBWE85aXhlT0RHL2MwWmhX?=
 =?utf-8?B?VGltUnVJczFhTGpzSnVJd0c1MVNYczdKQmlYMCtpbm5HcFE0a0FjVGdjejVM?=
 =?utf-8?B?QUVlNnQ0ZE8xNmpjcGtRYXlxZjNQTjBTSGJRSll1SmpERzlUQndXamhpMCtF?=
 =?utf-8?B?YmMvSkxVcFFIdHpORHVKbEF0UXViNlhIQ05yVHJNcXlqY1IwZ0hlK3VZaTRr?=
 =?utf-8?B?OUd4SWUzTVRJeFh3UDQ1dUdabkRxS2toRlNvQjNuYmRhV01Fa0hGNkpEMkVQ?=
 =?utf-8?B?S1k4L3RkRW45NUZPWlltbERGaDRBcnZJT2NHaVBZRFNpbDNwKytFODhmV1JT?=
 =?utf-8?B?ZWs4S0Z5ajQxV0gvSmV0NWs2WmpFOHQvSXY2QXVMNU9kMHBqTUxBSDBRTUxh?=
 =?utf-8?B?cnlEUzZHRStMUUg1ZDdjMkRDMXdCdnZSUnVpQk4yWnQrM3JDVUg2cDI2SFVj?=
 =?utf-8?B?ZVVBbU1Nd0Q2aHlwSi9vOVBmdlBoRlRhRm1IUlNhM1dDeHFsK1BabnEzZXlU?=
 =?utf-8?B?M09icHhKREFYb3c0ZjFWU0svT2JtL1F3c0l6WDdoN2hZWVBZb25rLzRWZ3h6?=
 =?utf-8?B?SzdTbHRSSy9WTzZBYjhqNXc3R3hEWHdTZHNQdTZBRGYxZkF0L3lMcE1vK3Vs?=
 =?utf-8?B?VXhaTGsxWmZ6WVI3eGk1eUVRZVdpTXg0QzFuQT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 05:01:06.0886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d39bb1-5ab0-4ce3-e4a3-08dd8ded56f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8890

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
 .../net/ethernet/pensando/ionic/ionic_api.h   |  22 ++
 .../ethernet/pensando/ionic/ionic_bus_pci.c   |   2 +
 .../net/ethernet/pensando/ionic/ionic_dev.c   | 270 +++++++++++++++++-
 .../net/ethernet/pensando/ionic/ionic_dev.h   |  14 +-
 .../net/ethernet/pensando/ionic/ionic_if.h    |  89 ++++++
 .../net/ethernet/pensando/ionic/ionic_lif.c   |   2 +-
 6 files changed, 381 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_api.h b/drivers/net/ethernet/pensando/ionic/ionic_api.h
index 5fd23aa8c5a1..bd88666836b8 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_api.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_api.h
@@ -106,4 +106,26 @@ int ionic_intr_alloc(struct ionic_lif *lif, struct ionic_intr_info *intr);
  */
 void ionic_intr_free(struct ionic_lif *lif, int intr);
 
+/**
+ * ionic_get_cmb - Reserve cmb pages
+ * @lif:         Logical interface
+ * @pgid:        First page index
+ * @pgaddr:      First page bus addr (contiguous)
+ * @order:       Log base two number of pages (PAGE_SIZE)
+ * @stride_log2: Size of stride to determine CMB pool
+ * @expdb:       Will be set to true if this CMB region has expdb enabled
+ *
+ * Return: zero or negative error status
+ */
+int ionic_get_cmb(struct ionic_lif *lif, u32 *pgid, phys_addr_t *pgaddr,
+		  int order, u8 stride_log2, bool *expdb);
+
+/**
+ * ionic_put_cmb - Release cmb pages
+ * @lif:        Logical interface
+ * @pgid:       First page index
+ * @order:      Log base two number of pages (PAGE_SIZE)
+ */
+void ionic_put_cmb(struct ionic_lif *lif, u32 pgid, int order);
+
 #endif /* _IONIC_API_H_ */
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index bb75044dfb82..4f13dc908ed8 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -272,6 +272,8 @@ static int ionic_setup_one(struct ionic *ionic)
 	}
 	ionic_debugfs_add_ident(ionic);
 
+	ionic_map_cmb(ionic);
+
 	err = ionic_init(ionic);
 	if (err) {
 		dev_err(dev, "Cannot init device: %d, aborting\n", err);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index 57edcde9e6f8..c4d1ecb2d7e4 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -199,13 +199,201 @@ void ionic_init_devinfo(struct ionic *ionic)
 	dev_dbg(ionic->dev, "fw_version %s\n", idev->dev_info.fw_version);
 }
 
+static void ionic_map_disc_cmb(struct ionic *ionic)
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
+static void ionic_map_classic_cmb(struct ionic *ionic)
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
@@ -698,28 +886,79 @@ void ionic_dev_cmd_adminq_init(struct ionic_dev *idev, struct ionic_qcq *qcq,
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
+EXPORT_SYMBOL_NS(ionic_get_cmb, "NET_IONIC");
 
 void ionic_put_cmb(struct ionic_lif *lif, u32 pgid, int order)
 {
@@ -729,6 +968,7 @@ void ionic_put_cmb(struct ionic_lif *lif, u32 pgid, int order)
 	bitmap_release_region(idev->cmb_inuse, pgid, order);
 	mutex_unlock(&idev->cmb_inuse_lock);
 }
+EXPORT_SYMBOL_NS(ionic_put_cmb, "NET_IONIC");
 
 int ionic_cq_init(struct ionic_lif *lif, struct ionic_cq *cq,
 		  struct ionic_intr_info *intr,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 68cf4da3c6b3..35566f97eaea 100644
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
@@ -171,6 +176,11 @@ struct ionic_dev {
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
@@ -351,8 +361,8 @@ void ionic_dev_cmd_adminq_init(struct ionic_dev *idev, struct ionic_qcq *qcq,
 
 int ionic_db_page_num(struct ionic_lif *lif, int pid);
 
-int ionic_get_cmb(struct ionic_lif *lif, u32 *pgid, phys_addr_t *pgaddr, int order);
-void ionic_put_cmb(struct ionic_lif *lif, u32 pgid, int order);
+void ionic_dev_cmd_discover_cmb(struct ionic_dev *idev);
+void ionic_map_cmb(struct ionic *ionic);
 
 int ionic_cq_init(struct ionic_lif *lif, struct ionic_cq *cq,
 		  struct ionic_intr_info *intr,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_if.h b/drivers/net/ethernet/pensando/ionic/ionic_if.h
index 02cda3536dcb..2fe96b0cb0ae 100644
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
@@ -2213,6 +2220,80 @@ struct ionic_vf_ctrl_comp {
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
@@ -3060,6 +3141,8 @@ union ionic_dev_cmd {
 	struct ionic_vf_getattr_cmd vf_getattr;
 	struct ionic_vf_ctrl_cmd vf_ctrl;
 
+	struct ionic_discover_cmb_cmd discover_cmb;
+
 	struct ionic_lif_identify_cmd lif_identify;
 	struct ionic_lif_init_cmd lif_init;
 	struct ionic_lif_reset_cmd lif_reset;
@@ -3099,6 +3182,8 @@ union ionic_dev_cmd_comp {
 	struct ionic_vf_getattr_comp vf_getattr;
 	struct ionic_vf_ctrl_comp vf_ctrl;
 
+	struct ionic_discover_cmb_comp discover_cmb;
+
 	struct ionic_lif_identify_comp lif_identify;
 	struct ionic_lif_init_comp lif_init;
 	ionic_lif_reset_comp lif_reset;
@@ -3240,6 +3325,9 @@ union ionic_adminq_comp {
 #define IONIC_BAR0_DEV_CMD_DATA_REGS_OFFSET	0x0c00
 #define IONIC_BAR0_INTR_STATUS_OFFSET		0x1000
 #define IONIC_BAR0_INTR_CTRL_OFFSET		0x2000
+
+/* BAR2 */
+#define IONIC_BAR2_CMB_ENTRY_SIZE		0x800000
 #define IONIC_DEV_CMD_DONE			0x00000001
 
 #define IONIC_ASIC_TYPE_NONE			0
@@ -3293,6 +3381,7 @@ struct ionic_identity {
 	union ionic_port_identity port;
 	union ionic_qos_identity qos;
 	union ionic_q_identity txq;
+	union ionic_discover_cmb_identity cmb_layout;
 };
 
 #endif /* _IONIC_IF_H_ */
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index f89b458bd20a..1bd2202f263a 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -673,7 +673,7 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 			new->cmb_order = order_base_2(new->cmb_q_size / PAGE_SIZE);
 
 			err = ionic_get_cmb(lif, &new->cmb_pgid, &new->cmb_q_base_pa,
-					    new->cmb_order);
+					    new->cmb_order, 0, NULL);
 			if (err) {
 				netdev_err(lif->netdev,
 					   "Cannot allocate queue order %d from cmb: err %d\n",
-- 
2.34.1


