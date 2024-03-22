Return-Path: <linux-rdma+bounces-1499-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4E6886B3A
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Mar 2024 12:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A1B1F23D76
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Mar 2024 11:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1CC3D0A9;
	Fri, 22 Mar 2024 11:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rwZNE/mC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7CA1CAA3
	for <linux-rdma@vger.kernel.org>; Fri, 22 Mar 2024 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711106472; cv=fail; b=K5gQP2Yivb0NIoMLoo1wLyDIG8v3awKQULZbUTIEBl0OHsXPCesiRDU3Oo/raZMhkoUy5uul8LG2N0QvVqlHk/FpNvpfB1NTs7xhXH1YHNdv7RxiEE9lo/NbTnWMKq50Ez7Bg5W5HTBAmlCd1j9h1Ju8iQy8/qgmtZojJvumHZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711106472; c=relaxed/simple;
	bh=Q6u+IvUfwbodVBZu78fHmeL6p3eQJjsVsvtxnPhwGnI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QpdaCw/AsH4bYi5aYuPpMawoVQpo028mbwlAzJcUyNUCO0UAp2rn9b1XZ5op6+uMgixzfeonVy10GATAUvRP0O47/ddBpe631Cb7lF2F56zqjI45Quhsmw0J1kcESKfC9XsTZvxUX38xITEdf9YrsT/tpASdZJEOZOPd3u9LSUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rwZNE/mC; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2poHSxkxBkcyNBNsw8E6Ks2KYHX7G7XCpiaqG/P+FrWeqXkYSVtsynZOQoqBix/lpv6b5k+sqYhE9GnoqkDfz60lrxulUBbWVSy/UjjYLUDI1B5yeVj/AmQ4DpjfKybHSKoItpV9K9FMPxH8PNVxUn9IV1ARB3CNuWBfy6QvSdZD1HHEfBmdDzSykv9QzMboGZwFxBIFU621BJg7mz5ay1yhIPBRoEIZG2/iypSQYXkPWi97AlF1qrJQlUoTSmQFylz/xKbN4cndcBrYAL71XVOmLFV+SxvyVca8023B3dnLagXLVjNAA6uqE9fuTg1LGV/h2VwrUdaoplr3crMRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQPkF6dmTI3TUUTCEQnZoK3pb11H+v28ihHP4OEhcCw=;
 b=QQnEtm4Isw43xn7QH7RlNUAXgj8sL3CCZrkVOcchefMg5YeW4HuEGzvU1M+xx9JPPzG4Mij3nmk/0jOt3ufHNsXjzbYQ9X1BVz6hnyNw/p+C5G0ISPQo+A+tL3qkgz3M+WaRRru9gmTgdvS7IpSpUyA/rd7ZSDy45kTciwl7tOIynhouZG/Sbtuge+MFpw2BIyKfQ5wWtlEkaQsYesyjyM9n9CvQX5ujko7Jx5jPlXUUxf3iM2H4jbLLW43tZpDal06n839ElQ4MJI8erhTBlKygcjiajNPvzL1qHIFrh2NnWBX2MnW9w5tadKP9/P1jQ8FQmOmARl8KuK2O9iFe1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQPkF6dmTI3TUUTCEQnZoK3pb11H+v28ihHP4OEhcCw=;
 b=rwZNE/mCP3OII0yUy8LqQWNSxXRFtnIyu1hYsMfyRtQ6n6sgJn3IuUP/Eu7dlLgTg1n6gb9fapb78i56Rh50GC6OEgu1LygEjpnWsH6MVg0rE4Y4t6WT7Gc0qfrhhAPYm11oeldQ+X299uy2YqxB6w/jaRxOtagfq2Mg82ps/zsQUNcoQabNppU1oio4xNjUTCLbJX8gikYd9MzkcQztgmXTyeQza6LjeAc/tSlZtEpPif03PZCvjHEDoC6SUYUSRWv1WR3b06ia8l+D3HtfJCx51jwjnf+X9+tIhi6SYNn3MuLOxYKzaOmOvDjFgodUcqzfKc8NpIGbDZA2bV80fA==
Received: from BN9PR03CA0429.namprd03.prod.outlook.com (2603:10b6:408:113::14)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Fri, 22 Mar
 2024 11:21:06 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:113:cafe::e4) by BN9PR03CA0429.outlook.office365.com
 (2603:10b6:408:113::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Fri, 22 Mar 2024 11:21:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 11:21:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 22 Mar
 2024 04:20:55 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Fri, 22 Mar 2024 04:20:55 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 22 Mar 2024 04:20:53 -0700
From: Mark Zhang <markzhang@nvidia.com>
To: <jgg@nvidia.com>, <leonro@nvidia.com>, <manjunath.b.patil@oracle.com>
CC: <linux-rdma@vger.kernel.org>, Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next] RDMA/cm: Print the old state when cm_destroy_id gets timeout
Date: Fri, 22 Mar 2024 13:20:49 +0200
Message-ID: <20240322112049.2022994-1-markzhang@nvidia.com>
X-Mailer: git-send-email 2.26.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec7c7e4-6720-4311-94c9-08dc4a622ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DsXxqqZyUdSLoq9MQTJyueVdPyjSIVEi/dAdsKE9jVkrn9Ehewhe7+joLP3qN4jQmsugSeup7ctHY8bF11IafqrObTQvUwKGp3u3IrtHRTwlAED/4MpqDSatIDxDHGPPtVFy3p+MmdHrw9mEHB84jOZI0HW1euli35t+vtAx0/tFKBSe3oxl6wApiiLyO9oj3A1ucSsYx94gE/NH6UWroh0rJmPPcrrWpeswI2hqgTeJQ5yFL+RJzHpDyt5t7Z/pO3tm18h/FN2rpSn0SN93imfCesD6LYy61+2GdRPPn0ht/cv80vYKmWVfj5UzB6gHN3ZxbQyS5MRpp4GBrrV+Guwy5x0IFr+8uvaK2bhtTPCxelKANQw60UrQdmSTqFK2bd++9ZESUs50l5Y8a4F2nCYoqHxgDOmmpb0GUxhEaFH5ErrL9se8h5d7BucTh0DiCNZZr1z5GAxVPSokza9CWwqq3zlOadACHr4/n6qYH37HtipfbEKmy0QVRuBxAL2N7tJpmPkQY8si8Jcf38Ig7nUDXqbg+//AeFWqSGTIOU+ztYf8O68VdRg3xMMrqZ3mNL1RBMbrTanWwAgsrxPeJBUNFlKJEtvXB4hWQUeo0eyVzkbwPWKScxPhbo2h47rC0fPvKefVSscYApYX1YD4/2xjRfREPDjrw0N9flN7Om+ebUD5h2THdS380yYPZsB6ms07Rqo5br04BmDnrUPfQGFbfI76pSZxFzZgJ/QSRqnM0ESzW/kUCQtfWrRwAO20
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 11:21:06.1358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec7c7e4-6720-4311-94c9-08dc4a622ab0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038

The old state is helpful for debugging, as the current state is always
IB_CM_IDLE when timeout happens.

Fixes: 96d9cbe2f2ff ("RDMA/cm: add timeout to cm_destroy_id wait")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
---
 drivers/infiniband/core/cm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index bf0df6ee4f78..07fb8d3c037f 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1026,23 +1026,26 @@ static void cm_reset_to_idle(struct cm_id_private *cm_id_priv)
 	}
 }
 
-static noinline void cm_destroy_id_wait_timeout(struct ib_cm_id *cm_id)
+static noinline void cm_destroy_id_wait_timeout(struct ib_cm_id *cm_id,
+						enum ib_cm_state old_state)
 {
 	struct cm_id_private *cm_id_priv;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
-	pr_err("%s: cm_id=%p timed out. state=%d refcnt=%d\n", __func__,
-	       cm_id, cm_id->state, refcount_read(&cm_id_priv->refcount));
+	pr_err("%s: cm_id=%p timed out. state %d -> %d, refcnt=%d\n", __func__,
+	       cm_id, old_state, cm_id->state, refcount_read(&cm_id_priv->refcount));
 }
 
 static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 {
 	struct cm_id_private *cm_id_priv;
+	enum ib_cm_state old_state;
 	struct cm_work *work;
 	int ret;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
 	spin_lock_irq(&cm_id_priv->lock);
+	old_state = cm_id->state;
 retest:
 	switch (cm_id->state) {
 	case IB_CM_LISTEN:
@@ -1151,7 +1154,7 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 						  msecs_to_jiffies(
 						  CM_DESTROY_ID_WAIT_TIMEOUT));
 		if (!ret) /* timeout happened */
-			cm_destroy_id_wait_timeout(cm_id);
+			cm_destroy_id_wait_timeout(cm_id, old_state);
 	} while (!ret);
 
 	while ((work = cm_dequeue_work(cm_id_priv)) != NULL)
-- 
2.26.3


