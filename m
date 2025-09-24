Return-Path: <linux-rdma+bounces-13626-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C66B5B9A359
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 16:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0976B4C1F69
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 14:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C0E15C0;
	Wed, 24 Sep 2025 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ugznh7ce"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012009.outbound.protection.outlook.com [40.107.200.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1A7303C88;
	Wed, 24 Sep 2025 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758723698; cv=fail; b=WKkmCoFU9xpluIr0do8sy9b3Twb95zgE/XxrS+ybTy1Pe4ki13PxkXM9mRy2Mnyu9yrVno0QCCY80xebip65gzZninKNV39zoIGz6UWetXWySwnNTJ68MEJExWO9FihLxDtcoC9SGN8tN/D5IgXAivteKtXtneY1nYpMM647Uu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758723698; c=relaxed/simple;
	bh=p1/KIDfClReDQtQuGqaTSeRXoEHZSMy3XExNcUesNdA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fEgntZGw7hd3rtqv4YtsTluio86CcnsVpVzA/oz0elJ9wQ1SMDnzAvVOSZ+sUDrG+3n0cRYSAJTpLZ14AzOPexu5tj0XOmcNHug2GzVeLdV8fNX3LQcb24IXa4cVy2MsrSTHN2cjFS7xo9YN2Mp8zyAciCSlP8dEcDKjgQ2v/uI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ugznh7ce; arc=fail smtp.client-ip=40.107.200.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtO+bbfEQVU8251N6yaVcW2jyOJi7rQINAB+AwcRLPLi0dJ3BxyKfIFTjpslP8iSei1DH5tZreXXqr/If+Zoc/g4q2P7QyTg0I1oEyjzT04alsmLa8xTr+1RerwgQSf6rvHkHLp97XFgYaKekmoPXLirmbGO6XFOpuq04o/bzJ/5TcvOJ9/K64y/qRqtOT5Mej2uCghIBc/w6DpqRag+wQSYOPvTLHEPLXUnFGWuyk78bJMsc7WyIwZx3fXKYr+YDzxvDB2HFGDca68zyWcqeKx/QenGMjf2QXq0VHHMt/o+fj5VJo9IG8g70MLgrFfPqSGay24rRxI3pARQm9NrMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=443l5vXvAIhq8Kna857shsqkhNSr0plGX4DMVBWUNuU=;
 b=CMQG3to3T7NxLdPe33e9IZo+GDdmFQg2D9M++P3u4ikBrEn6zpRTg0dpqqOPgLAZ5v0brVRTO7mObmMNj+r7qQYpS86yUUrYDZE1bKziTmjZDtZow0+ZG5jguTgkpnJKo+MJXv/y6c/S1Kcoqy6F781dEEZL1AZxSRKP6TnXGu+eN64YP4plq33DhvUpT1Sucjo97OmeoHuYww9PczvplNpDAOR86JGerDu+JzQCNAJBh1snOoLgyUFz47K9eJHz5poxNAQ4kHVqf+1dvRMHduKWMrHUgkW/hlPrsy+rqsn6Av3jbFRhgMHLZLC9Zqhw224PJbHF47vIVCoN382QRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=443l5vXvAIhq8Kna857shsqkhNSr0plGX4DMVBWUNuU=;
 b=Ugznh7cePMJ71wpxHziwCvFSoPMCXnLwGZ3wGHfOeKTCo27D89DnysqQ/oAeAF4803E4NCwYlJrdnCHa2heei/H9j2zNiFZ0ZdRBF37TofyazjR29WUXBViHGrfz0zJ5oQL3o5vM1kA2//JgbcZNNBuUh3jz9MnwQkUHWMjY1OM=
Received: from SA1PR05CA0014.namprd05.prod.outlook.com (2603:10b6:806:2d2::23)
 by MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 14:21:32 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:2d2:cafe::ec) by SA1PR05CA0014.outlook.office365.com
 (2603:10b6:806:2d2::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Wed,
 24 Sep 2025 14:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 14:21:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 07:21:31 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 07:21:30 -0700
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Sep 2025 07:21:28 -0700
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Abhijit
 Gangurde" <abhijit.gangurde@amd.com>
Subject: [PATCH rdma-next 1/1] RDMA/ionic: Fix memory leak of admin q_wr
Date: Wed, 24 Sep 2025 19:51:23 +0530
Message-ID: <20250924142123.18344-1-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|MW6PR12MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d01667e-7d14-4e91-50a4-08ddfb75a8a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y8GdTLOBvsWi6rDVVtSa9YPmD2+ukk8oEjia5PEdlZ7+z8NN+JNf18yH03y3?=
 =?us-ascii?Q?C/nV07ixYXvCJWbskmEnelzsNmrkDXhNgZl09nW4Wgnm3aEkilqx+KIDSS+x?=
 =?us-ascii?Q?kY6Hh5C9tSGiiKR7ZzxiqRgqyzRRvk20l4v5ETtfHfL8odf1rHy6EXtr/rUO?=
 =?us-ascii?Q?/TYWsnUgSNWsy0c57m+sJw80Nbq6bJbl1Rtz9S9hNj9rfnPJkSJlQmLTMP7N?=
 =?us-ascii?Q?vOg69Y+yljiY7kIX8d8Rksyk7OmuFLWBPUkoU80aEIblxdp5SeLC8ecNFM4e?=
 =?us-ascii?Q?H7eTHTZJLfJJ7vln5z8H2jyEYdlGVzjHhQjUh0B9sT1MGNSwIgmOKVYA9IZU?=
 =?us-ascii?Q?gOEmHbAnDXluAi/hbv41xjMrYdLywrM5OI/I9YFmQSR7rc3s0g2E1S20L+d0?=
 =?us-ascii?Q?CMvdbDKOm1qJzHrpVWrSWqu6nDRHomKS7TFRxWqAu7XBZcs5WCNrt4NXhn94?=
 =?us-ascii?Q?q0t0rL0Li2TbQXra2mbFO1afd6M/Bf3QTVELAMOS3GPnI9ANbJXVhlwJbvBI?=
 =?us-ascii?Q?tqi428/N6ohArf6/oOSGJxtexTlEU3MXMmCcxii03BXSv9fu6ZHOKSnAoi2c?=
 =?us-ascii?Q?zY+GkMkC+lWArwNvpK0r3JHMgveYyz5tNzCg14AQt/Q4kop7VkkiA4mlMe0K?=
 =?us-ascii?Q?8inS08zOg9pPUzBnes3af2H0nX2DQrsm8cX+Zs36zoUaMEr/a+Mvxwx1pLTt?=
 =?us-ascii?Q?cA7DaNz5jyO/Sip+wMk9sqshplE/LypyuUFIO19uwcrpzpVLm4xZH4mQpTXl?=
 =?us-ascii?Q?jaX5hhN/VMiYh7Vtsw5qBNbqKZb4VIIxHt4rQV8ertd5gu3xINb5gMT0zyrJ?=
 =?us-ascii?Q?e9TVG/lQhFqPY5KofnP//3354RBEirf9IzvatlLMZr8xMjFK1sOpCWod76B/?=
 =?us-ascii?Q?pijFssjQFW4BvqZX+z28M6Kxr1pfRHTnfrMoUu72VynXfX/hEf2+WX6+T0b/?=
 =?us-ascii?Q?NqlRTjqn0KJ/nHhVSXgakHozus+ygszJvG6j11C0gwfp4M7RFmt6+L+Y/G0J?=
 =?us-ascii?Q?kKB6/1jmpHh7OjK5TE1s7ATUeDFMxjgh/DUW4XUA254uAr/OmUgs+paDszar?=
 =?us-ascii?Q?CKoQSGkrO2IS4LdLjBVQ259ngV/LH31nx8PDFYo3QNXDAEKD/SNjuFdZBOQd?=
 =?us-ascii?Q?Glzg2lWvg7sXf9cR32siRSogJsKWLrwOfUQvrkPxhE5/0stonPhhETwKTSzk?=
 =?us-ascii?Q?/uDz8xj6w6uTILBWBQu9mWC5kDxc+8D/NOJ8kyRhgKDdUAhyRZ78jkwcRbiK?=
 =?us-ascii?Q?EmR1krNarpVC8fhsqfbtmCZojyH1LHeeWTvg5qJ7xK/XIIzHi2hRE1kNSjnT?=
 =?us-ascii?Q?BRy05MBcA/cAt2nbJ/1mKGiV0EIMEVHXgbuainKz7Np13tvhpg+LT39ISlB2?=
 =?us-ascii?Q?0Al1sp/cYtm/8OnPa/dpEifby5+MpqZKFTlks5fCMaEHuDMEBNo0Jd2eQjpy?=
 =?us-ascii?Q?F7gMgmdRBOW5vZkZANRWzp6TnIgYsSQNoqP9ArmQyMgIVIJXk3KQQTiVJ+S6?=
 =?us-ascii?Q?fC2xOgsq8kTKs2WbxKPO50ZcUKx5HebhNKWK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:21:31.5106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d01667e-7d14-4e91-50a4-08ddfb75a8a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916

The admin queue work request buffer, aq->q_wr, is allocated
via kcalloc in __ionic_create_rdma_adminq. However, it was
not being freed in the corresponding teardown function
__ionic_destroy_rdma_adminq. This results in a memory leak.
Fix this leak by adding the missing kfree(aq->q_wr) in the
destruction path.

Fixes: f3bdbd42702c ("RDMA/ionic: Create device queues to support admin operations")
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/infiniband/hw/ionic/ionic_admin.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/ionic/ionic_admin.c b/drivers/infiniband/hw/ionic/ionic_admin.c
index c2ff21bcd96f..2537aa55d12d 100644
--- a/drivers/infiniband/hw/ionic/ionic_admin.c
+++ b/drivers/infiniband/hw/ionic/ionic_admin.c
@@ -600,6 +600,7 @@ static struct ionic_aq *__ionic_create_rdma_adminq(struct ionic_ibdev *dev,
 static void __ionic_destroy_rdma_adminq(struct ionic_ibdev *dev,
 					struct ionic_aq *aq)
 {
+	kfree(aq->q_wr);
 	ionic_queue_destroy(&aq->q, dev->lif_cfg.hwdev);
 	kfree(aq);
 }

base-commit: 9b9e32f75aa3d257e3ee3ab0a0f9ad5fbfb298af
-- 
2.43.0


