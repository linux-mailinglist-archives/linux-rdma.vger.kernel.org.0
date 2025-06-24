Return-Path: <linux-rdma+bounces-11573-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D018AE6467
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 14:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34A3189E00F
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 12:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAA2291C29;
	Tue, 24 Jun 2025 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fqp5xYEQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F45291C21;
	Tue, 24 Jun 2025 12:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767240; cv=fail; b=ByZV+jxuOKunzbr+5NQALm2yLf3+sIEGceFE2RRTC8U2UPaPlGSBkdZrcneuKXBz4mEOo/lD/476AlERz6WsHTYR+vdPzxsAkgXd04NHmL5cz4odT5KFrqhFXohmt7FOsKf4199qWF8E1dT7NwaPVz6l0RojHoi9Kjkhgw0CEAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767240; c=relaxed/simple;
	bh=3jNC5D9X4moqTBlTj3oHEbFC+xGYjlwhpYLCYN09x1c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBCwN6YiY7vPY1ilsnvEY9/Ousua7rnY0BCPhQDCaErUMIBMIHYiMaC72K9nKPECwED2K7SSjggFFMcGLTkwQSlOhsUHhtMOZVDQuIoJ3ZpITfuyUtiGoko4tfGvMIlCVzfyrb6EYJFxYMXVD5+QKxe6BDDcIEgImbCqmTFPvlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fqp5xYEQ; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRfD3budV6scCWVqFTNE9ZsonUvCIrgnIqmuImTVxN6zCmmf3t0lMM3l/a87b0HqRTM35Dbz+EUcc+2CCqBYhv87ZmeSHBZCi45HnyxiYRxEUSQALmhnNCKWF75Jp2ysZXkQvhz2batjPB/DA3ejtJ0GY/KDm+Zg8Gsa5g4IGP3cUlMNWFqBAt7zT7AZXgW+NGn7eymsCK1aRIi5zebOi14BLtrXoneD2S5kxH+wQZA9qSCbJOEgz6bhzQFmO4csNK3YVJ8B2PQLLixpGx97wptVfAm4neS+rLYNzhiJL+D/q3tKr836hPj3Q537x0E8/vSLxTqzr/yvLYNyMQaVaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ev9F1xIwMTpn7FnC9TiteFXYsmsD1+B7N4Rc2ym1kEE=;
 b=YUY4XtQuPEDmT+lkUvUVtXa/R7CxcGR1hFHrRg/45j8Dnp7FfdhTP5mgjHJoZ697GzWjRrSIpEcAjq3aVMDW+JHwOSlu1HnDII8t012OBPnvBe4JOYggfitd4J76D2E7E4y02DEjDsnZ7SJ/4wPF+3VsIUr3HkwottvTTdt/ujubwWU0V3MqDTjQ6LQfJI7g9pOvrFGAqV83VBfVnFueMYlzDSouNBwSmZy2oiOs4nTq6l4o4hDntau914mOWa/908KTvZNdrq0IMj2f6EBq6qTx02LzA5M9egVAd0AWeQuU/GucYJSmUmw+6E+wIDRyIt2JO8Lfpo26Lbmp1EuPZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ev9F1xIwMTpn7FnC9TiteFXYsmsD1+B7N4Rc2ym1kEE=;
 b=fqp5xYEQ9IC8SDjky6hH3IN3Net2V7DOqKbOrlEdbqVKInP/zeODsFM+y9iANlusAhQu+KiPlpDLpCVWo/kbPNFQ7ZxlbEOJjL4URWDrFLMLcdjt1fhH9p+c7gxdvtLEBkjoCrENqcNn991BMza9YA5IwSio4LeTnkPH9tEBw5s=
Received: from CH0PR03CA0379.namprd03.prod.outlook.com (2603:10b6:610:119::6)
 by DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Tue, 24 Jun
 2025 12:13:55 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::35) by CH0PR03CA0379.outlook.office365.com
 (2603:10b6:610:119::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.31 via Frontend Transport; Tue,
 24 Jun 2025 12:13:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 12:13:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 07:13:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 07:13:54 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 24 Jun 2025 07:13:49 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, =?UTF-8?q?Pablo=20Casc=C3=B3n?=
	<pablo.cascon@amd.com>
Subject: [PATCH v3 06/14] net: ionic: Provide doorbell and CMB region information
Date: Tue, 24 Jun 2025 17:43:07 +0530
Message-ID: <20250624121315.739049-7-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624121315.739049-1-abhijit.gangurde@amd.com>
References: <20250624121315.739049-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|DM6PR12MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: b389d054-7a6e-45c5-11f0-08ddb3189721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmdnOGMrRUZXQW1xaG85WC9PUVJPcFhrclpZZWp3ZmJDMGNXVFJqdWxVTXB4?=
 =?utf-8?B?MUF1RmVFanZtcitISFlRMFhBT1NrQ3JIdUZwRjhaOXpSSFova3FaMkRQdmRP?=
 =?utf-8?B?QlV6UjdWeFZqVkg3bHNJMHduekVWY3RobGpmVkV1TmxjaXBiV3JrNnArbTBP?=
 =?utf-8?B?c1kyS2lnWDA2ZHRLUFRFSVUvNzkyWGFRWjc4RE5YSUtscWRCWEIrenQyZlZ0?=
 =?utf-8?B?TzBhUDFkRUZicUtCQmZnaGt5WjdUMkNTaFJIMFJOV3JTTHRVaVBOcDBvOW8z?=
 =?utf-8?B?WmhhUWoyNGZVbnNkN1VJQWQ0NWdYOERSOWhOOTZyb3V4RUxrVnVkdXZRdVF2?=
 =?utf-8?B?S0lOdjRtRXJvanpxRnV5KzM1VzVwdjlwZ1FmVzc1TlZWUVNuVHMvbnNCdVNI?=
 =?utf-8?B?TkZJZlNhTzI3MUdocGhrejF5YWNnUmQrR0NnN3lOQTVjWU90OW5mY2hjTDNy?=
 =?utf-8?B?SHpMbllPeUZhQ2F5YU93MUo0YkI5VEZjNG5VdnhVcHc1SHRuOTFJeWlaMHdp?=
 =?utf-8?B?OVVUQ0lFWkxyckROTnFUVEo1UlZ4Z0R4OEY2cEx5MUszVGRXYzZTcGhrY0pq?=
 =?utf-8?B?WmJQODUrKytIMWFKeWh0ZjROL1N0L0xyTjR4UytJS3NnQ2ZkbTUyNHdLdThH?=
 =?utf-8?B?Q0hXeVhod0tiTkF5RGtzUmRzcWxRcXREZjQ5YWJ5QlEwUk1OdTdkK0ZENXFR?=
 =?utf-8?B?bzhwcElzelhKNEFWU3hzaDU1N0lkVlJCYkR4WjdyZDcvRmt0ZXQvOHFCRjkz?=
 =?utf-8?B?U2ZkbmZvNFhsdlozQVE5YkpUSDhOYzJIak1rU3FkYW84UlQyNmhDOWQ3WUY5?=
 =?utf-8?B?V3RUNU8zNHRqYXNmK3RkWG12dFdtc2d5RWpqaHJDY0ZoYS8zRFdOZHdzdGlP?=
 =?utf-8?B?Q0JQWGJlejAyMUVJanpvekRXdUtneVk3RVNrelFlWUpINXV6N0xPbXVIV1Rl?=
 =?utf-8?B?Slk1akZ5L1o1ZTJ0UW84d0daMmYxSUZFbnZqRmVBbXdGOVdKNFZQTzJKbjll?=
 =?utf-8?B?azJPSjFMSi9CQWhVd3RvcE1qWlJUNnhzOVQ2dGlOWkFrZk5YUDNBL093eVNo?=
 =?utf-8?B?M0Y1K29NYUdYTjJ6bmQrTWhPK0pyVGVWV24zNmdpSlFZSnZtNncwTGJ2U01R?=
 =?utf-8?B?TFZTUjJzblFKOVAwYlN5eFlsY2VpM1pDekVDSFpZTFNmT2R3VDRUOXcwRmxE?=
 =?utf-8?B?Z1FPWTd4aEkyMERKcUc5QktKMmpCclk3dDlIWnQrMHNucC9uV2ZNK29JRDlw?=
 =?utf-8?B?MENnNGlERDJjMFJWRFlVWEZ4UDA2eUFRNVg4dk5FYTJLMVhGb0Rpd1FNQ3du?=
 =?utf-8?B?U21tZGgxOEVNWFROYndXODBOcTNEV2ZROExFTm5YM012MjVYblN3Nk5GUEY2?=
 =?utf-8?B?MVlJVnMrTnU5Q3BXZ2trYzJaVDNWNVFVVG82Q2o0SVFOMGY2eTVKaDNhR3dE?=
 =?utf-8?B?K0ozVyt3MkNRZ3BrY2tla3QxZHNvQjVwck1MbXdkUHNWSXRlZ2tWZWlkTVd6?=
 =?utf-8?B?T0x0dHRBaTFxeFQ3V290K25mUUx4cC84aDVuRHEwcWU3TjNkcnJsWHFQSTJa?=
 =?utf-8?B?UmZsOHNLN1BlTEpuY1NtRjR3dTZOcjVOWVdMejFvTjdzWmNMcU1vL0UrMWsy?=
 =?utf-8?B?ZGxNdXNkNVJBZVc1ZmlBcEpxUmdad2pOaGNjZElrc2hqMUU0amFhWjVQVXZW?=
 =?utf-8?B?V2R5dFVEOEdoeVVkYWYwa1FIYTg1YjV0a2pUNDFhV2x4QkVFWkxzNGlFWDlE?=
 =?utf-8?B?aGh3LzZYTDk4NmpBOXo2alJzUUpnUVdZWit4YktuRTBFSHFTSXNVZDlkVUlD?=
 =?utf-8?B?U0taQmxQbk1WLy9aUFhvVlNxYnV1Tmkzd0NJVnYxd3BLdUE1ZktNRi9ueDBC?=
 =?utf-8?B?RDFtZWNpQmZXT2NlWW1PQVRseWs1dXJtWXRxS01qR1dVNm9WUGorYW9nRUxO?=
 =?utf-8?B?eUN3Uzl4V2Z1S29JOFNqZFRLcDB3OVo1UzFZNVBSSTVYZGZXNkNhYnMyZFlj?=
 =?utf-8?B?N1EzRzJsNWFCblFrYjZNblB0cFZqS1hJYkQ4aG1MUklWWnhOSDBCY3NQM0xr?=
 =?utf-8?B?QTBZM29veHJRL29ITm5qdFpublpJY2xOd2ZZZz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 12:13:55.2052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b389d054-7a6e-45c5-11f0-08ddb3189721
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4371

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
index 18b9c8a810ae..60c3d3e69098 100644
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
index 59d6e97b3986..f9e653349d6e 100644
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
@@ -3073,6 +3154,8 @@ union ionic_dev_cmd {
 	struct ionic_vf_getattr_cmd vf_getattr;
 	struct ionic_vf_ctrl_cmd vf_ctrl;
 
+	struct ionic_discover_cmb_cmd discover_cmb;
+
 	struct ionic_lif_identify_cmd lif_identify;
 	struct ionic_lif_init_cmd lif_init;
 	struct ionic_lif_reset_cmd lif_reset;
@@ -3112,6 +3195,8 @@ union ionic_dev_cmd_comp {
 	struct ionic_vf_getattr_comp vf_getattr;
 	struct ionic_vf_ctrl_comp vf_ctrl;
 
+	struct ionic_discover_cmb_comp discover_cmb;
+
 	struct ionic_lif_identify_comp lif_identify;
 	struct ionic_lif_init_comp lif_init;
 	ionic_lif_reset_comp lif_reset;
@@ -3253,6 +3338,9 @@ union ionic_adminq_comp {
 #define IONIC_BAR0_DEV_CMD_DATA_REGS_OFFSET	0x0c00
 #define IONIC_BAR0_INTR_STATUS_OFFSET		0x1000
 #define IONIC_BAR0_INTR_CTRL_OFFSET		0x2000
+
+/* BAR2 */
+#define IONIC_BAR2_CMB_ENTRY_SIZE		0x800000
 #define IONIC_DEV_CMD_DONE			0x00000001
 
 #define IONIC_ASIC_TYPE_NONE			0
@@ -3306,6 +3394,7 @@ struct ionic_identity {
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
2.43.0


