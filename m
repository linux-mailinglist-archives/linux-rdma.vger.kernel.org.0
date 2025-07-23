Return-Path: <linux-rdma+bounces-12435-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA930B0F92B
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 19:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B39AAC5603
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 17:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B3523644D;
	Wed, 23 Jul 2025 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1ViEqWRS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564AF23184F;
	Wed, 23 Jul 2025 17:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291955; cv=fail; b=Por9Xn307h/a+w55cngnfVZp1K3GWScjyPt7mnmLexYKPEqkIl4WIxOXC5Q6ppmNF8xTGQdY/R0072VMpMDz1oUGXKo4DpZzry1H6oC1dzw+fh5Wct9nI4lNeTrXe2cHWy+dBsBN8m6+E8ofQsUvtngqhR02XqlQScnZPD8MURc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291955; c=relaxed/simple;
	bh=3jNC5D9X4moqTBlTj3oHEbFC+xGYjlwhpYLCYN09x1c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ua8pf9rUDVh+P/gtsVngZPvUNhoZKfS2WRxnpWgTlBwik3YWq6cXPrEaEFT0oque1AVgGBFIeAIx/KapVXOjJsFk29M5abocjbsze2CLoS2OOYRACqvX/a9WjMcwvcdPcoYi/oned4Za8Hxkldz7NDD+NI4twbm0kUGw/XJw8+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1ViEqWRS; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSk22b2cTjNNiG9c9jU0XtGKv/jeVL8N1ZwI58Nq7vCjK1t4BmDP+s+xYZUD/ZsAGbi7+l8anitQ+7r0Cl1WmwWa37g90ygOmBTXHdEER2MmPtQHgd3MmyTPqJyC7ktj2FQI66J/OYzThcfhVHjFsnKLisHJisywT3gTVcYm22dI9HFk3KLMwMcMVNgf//aEeYskZtgS4dI/ptBLjfw3XVmD9Ss2jUHXKDw7fMC/bztv9gG7qxrkInJsWD1Iz7yoHj1rPbZuS9IZcs5ZlUj278vgV2Csz2LRv9/zuxHOH8W+5dfKeHydXQXiWeqfP7Vg9cI3UmIb2PTTHbX4EKIs/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ev9F1xIwMTpn7FnC9TiteFXYsmsD1+B7N4Rc2ym1kEE=;
 b=aBScYUX3C2xfCh29c7CeVY7EbdNhtjV+Qh43O9VUTJnPkAAXlTKoIWLBtTnUiljrQF5JNzy8ZVORVBMJ8wupm1azXz90KzCWAwdLK9nDs6HhSHsoR+8k52G+WroK3kNWHVYuwMdSzqR0lpRfHMzJTVCFCDOGVBSjkhu0rHJ93HH8XHHnQg4I8NoRIfxIC/IhskntyTv7mXcP1CMzvOLQhm3jAmSQL0JT+4kI620ab+jMO4yVfbw+Y0Kc3zv+v0ESES6vzp96S0Ki4sWaXbH4NpIGWBQ/ADJw/i3AqOAONYmpjjbkk6ClZky33dOlpCUc/UoG2RWDDozdVObuAuFVag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ev9F1xIwMTpn7FnC9TiteFXYsmsD1+B7N4Rc2ym1kEE=;
 b=1ViEqWRSaI+C21zAWcTyxwQrF9wZhmlr9ovpTmwd7EZEkMB28/uCH73zWRzNcAdRS41KHvJ3TPptUPlZd7uxmc/MjzHWaA9H0gXIbWK0XhSENrDxGoprsQBcXXa7ZXE8q+cuqtvz2K3i5T5w7JGrjVAsSvzOA5hDYHxBZmAbCDM=
Received: from CH2PR19CA0016.namprd19.prod.outlook.com (2603:10b6:610:4d::26)
 by SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 17:32:30 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::b2) by CH2PR19CA0016.outlook.office365.com
 (2603:10b6:610:4d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Wed,
 23 Jul 2025 17:32:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 17:32:29 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 12:32:27 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 12:32:26 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 23 Jul 2025 12:32:22 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, =?UTF-8?q?Pablo=20Casc=C3=B3n?=
	<pablo.cascon@amd.com>
Subject: [PATCH v4 06/14] net: ionic: Provide doorbell and CMB region information
Date: Wed, 23 Jul 2025 23:01:41 +0530
Message-ID: <20250723173149.2568776-7-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
References: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SJ2PR12MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c85bd4-028a-40ff-f8bb-08ddca0ee5de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDBqQWxXTXpWYXd0WERWZFVHTVBRdmsxeVZIOFhEVlFJUFdNK2N3VzZsL1ds?=
 =?utf-8?B?NjcxcDkyTXZFT1VoSUtvTVI1b2xzSStCYU4vMnQ5ZmJ2MXBuN1FQZDQ5V0d4?=
 =?utf-8?B?ZEdrd25BUHp1RExrcXlJTlJsRU5lK3NNVlp4TW5odmpBZmVoOW1ydFdUNTVR?=
 =?utf-8?B?RWVOY3pwd3dwNHVVbHR3cDVxY1hDUE5WWFZ2Lzl6VGpwcjA3VTBUR3h2QnhZ?=
 =?utf-8?B?YW1kdVBKUDh5VzlocXVkWHBGYlFhaTdXT0NBK3NUS3lHamhIeWdETHlnam5R?=
 =?utf-8?B?VWtnMnQ3SW9mK25RWU9vYnZxZlRrUWFXUWxMZWFVWmRXeUp1QWt6WWM1dURo?=
 =?utf-8?B?aDlJelBCa2V5ZmZvcHZhdEM3WWhIUEROQm5CamdPWWRYaWZiSEQwRHhpKzla?=
 =?utf-8?B?eGVJR2dJekZxaUtSbU1NR2xSR21ueHdScDNFVWRubDV3bFBVM0I0Y0VUM3Ba?=
 =?utf-8?B?ejRzbkl6TnlVb1Z0NlM0NkVsQWhJK0p2c2lmellqeWxpeDhrbUxBUWxGdTNE?=
 =?utf-8?B?bm5sRlRzMjhBOEs0eU5oemlySmdXMVJxVkczM1pLM0lpdDVuUzJqY2ViNlN0?=
 =?utf-8?B?VjF0djEyVVZYd0hzcS9OdVRuUjlaLzdFb2VQQTVQQlFGS3FzYk4ybkxabzlL?=
 =?utf-8?B?Y1dVOUxxbFdvWVUvZmg4Rm1oOHlpUEl2V0dTL2pyT1gzLzdaYmlPZ3hzbkJB?=
 =?utf-8?B?NVRBNStnNXI3bWFqeWx2b1RweW01WHFNQ29xSkZUZEgvYm5IcXREcWVSRktG?=
 =?utf-8?B?WlF0cTZ3MHZWWGpTNWhLVTlUZ1FrdzMrM3k5SWhOZGtnNUdHdVR3dVlEMU1X?=
 =?utf-8?B?aVB1clNsYjdNdXprK0RrSWtqVVJuQzFnK0J5M3FQLzNwVmprcjJ3dWlXZXlj?=
 =?utf-8?B?L1FneFJ4bWxKVnJGSE9OYXhvRU90OEFkR0NNVXVOYmZKNW82QmIvY0g2bkRN?=
 =?utf-8?B?RlZ3U05NNVkzajB4K09GOC9jY3ZBTVJpL0tNQ05sMDdEdnQ1eHRHdFlvUHV1?=
 =?utf-8?B?dGVENmtqbXRBem5MYlFhME9oWUVyNlQ1K1UzSmpmdjdIQkorSFJ0K0RMN1Vr?=
 =?utf-8?B?TU5INUYwQm5ITTR1aDlxd3YxN1JsQkQvdkVaN051Wjc4dWZ1VzFmM2dWK3Qx?=
 =?utf-8?B?ZW9iZWl3MEVxM1ZXY2djd2Rvc1pEeVRWMDlBNmNCUXZBM2g4amNYeERBK2Y0?=
 =?utf-8?B?Yzk0VG1rRlZjT0NPUU9tUldSd3hPNnpuVVhIZ0JLeEFpN1BrNEx1dkJONEwy?=
 =?utf-8?B?Q0RSYllUZC9QSEZ0T1lpYWZsckNHcDNCNk9nbGxkcThwWE8zN29mSHpWM3dR?=
 =?utf-8?B?d3BrSC8xN1J2YlBhVHltU1B6YnNBbDJaK3Vpc2VDOUx0WEs0MExnUFhUOGo4?=
 =?utf-8?B?RnhVeFZHYlgyYUc3TEd2ZHZ5TmlUbzFjTisxeUVJcys2cy9NSmhwazI5YzNy?=
 =?utf-8?B?YlVPUGQxRzVmNXRxUXZHTTdsNmRIU2xWejc4ZzdHR2pJRzZ6dzFzVUFYL2lz?=
 =?utf-8?B?dDZMVUo0VG1hQUtNVzM5bE9nRitPdGljMXlUa3JDQWZ5QXRBQzFMRi9aSlBC?=
 =?utf-8?B?OWVvVHpmdzQrQ2NlNkxTVGs1eFdXc0Zhd0FTb21WRExpK1dzcVpCeFhTTmwv?=
 =?utf-8?B?eUtmUkQ2Z0oydjZUd1lHN2gvbHFJQ2tkb3VDb3VrU3NwK1loWXB6N2ZLbkht?=
 =?utf-8?B?TXhMMWkyWGNUSC9rL2l0bk1pTlZZMjYrUmgvQytLTmxISmgwS29LcGtpbFV2?=
 =?utf-8?B?UTFOZElVckRtUzBIZzRhV2pFemlSMFhsZzAyUFkrV0FlYXVJMTJNQXdMeHhB?=
 =?utf-8?B?ZldxMDNuMXl0REJXV2tQUGZYSmRZd0IwTDZWbFJnYkFWTDlMYlpOcGYxMXBS?=
 =?utf-8?B?Ymx3d2RTZjRKdElIcUpZaFFCK3B3MTRPejRwa2l2U21iTVdGeFVBTDJNanFr?=
 =?utf-8?B?SzM4ZUQ3UEVvL211Y0V1MnVBVmt5YkVwNnAwZ01XSkxvSU96b05oL3dqbFl6?=
 =?utf-8?B?Q0NSZFNVSnlnb0tDOFV4dUhVVkk5ZE5LV0prYlBnNG9IZmpPM0N6aUVqR1E4?=
 =?utf-8?B?SjFNNzVCa0hQeDJSVTNHYTRnUEpIbHVKeEZHUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 17:32:29.0873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c85bd4-028a-40ff-f8bb-08ddca0ee5de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8807

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


