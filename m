Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6074934D1EC
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Mar 2021 15:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhC2NzL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Mar 2021 09:55:11 -0400
Received: from mail-bn7nam10on2091.outbound.protection.outlook.com ([40.107.92.91]:33857
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231946AbhC2NzF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Mar 2021 09:55:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ST+g2T7bfyswzqdhatYgH+5/hVmDdOlNxEF2LB2+zb/r2Tjq5szRslOY2H7gsCufxeVn6a9bbZ7ig7aIcICWKuvdhMv8z1OmIhs1uvfcYPZqTn7cOkscBJ2NPgZL1X16Nt/iHK96dmtVr/WZL1Sm7TvvoO/VeZd9oITy047S3Ve2UXg1IIcQwQG5fO1NVGFSvEtBJd5D88tJeh3wmKzdKg6X/TattCbQ3eu6ogrvjd0o0Q8dtFEFaJefV1pbS1ri6JPsZrGud0ACL5c8u2hbB5N+urna2adbE3pzJhvBpvwjK3Q5b9o0LbWcjMimvyuImx4/K/MpWz9EZJaipe3DXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLT7FRxoli+0SOgbtMxf/VJM0e5EnYQUj6dr903ckJ4=;
 b=faWoM/Dh3KC+dP7SoZriKbVxT3rsb/ys+BrfrnP2gYmnpQP5PN3XMfr8rNNMH79flo51pydHTHPoCFzMX0ZeLXSxh+boxwXTEUinwV5vu/PvGaSuWqm1CawAy/VUWU0X8EsNzXMEFInbct/PXY37pLfY5YgLgkKK5gc2+SvafrL+rs1ZtnjLxJClE/zN95p/VgLFGO5XgzLB4GAW98Wsvv91PtAaIGfapS6X5hh59BdZjxq25d8nsvdjuOfuT3X2zWMJy0/1I3GUzUM/XdxebhMz0BuaP4WQxlg2oLNH+H7J7NJTXB+QYN4IvTHOT3sqfaIuAAFh6+HXAHNi7zS/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLT7FRxoli+0SOgbtMxf/VJM0e5EnYQUj6dr903ckJ4=;
 b=FRHEAjek0CCXM/uUu6YsALRkIKsmRSx5yhqyAc/kXN5nzeopNK6ZUJBMqSRHTeAgUCKf+oZcSwl3g+ShNP6WT1GcI4PO31DwQkzZJdw1kpPHaBc75mkLTHE+l9HXOI6O/gVVkU5OihAvcq+ptWNDG0RWk9k/QjX6rKPESxX6bGbyKtebL2FGyxPyjAoAVG1nsp9zRMDBwwVOMQC11ee8PsQhfyJeeLVZ4XOQqOQR5qTJ5Xcsd/z1irf+Q8kavUUjUC7/V/yj3Xouh1G9JewE0Z0Dn1wEETg31yG8ZMUPr61Bgv2GY1+HtkDwXZ3JA2bnq9BgCWruJT+AqeZWqSGItw==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6618.prod.exchangelabs.com (2603:10b6:510:78::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.24; Mon, 29 Mar 2021 13:55:04 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860%5]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 13:55:04 +0000
From:   dennis.dalessandro@cornelisnetworks.com
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: [PATCH for-next 05/10] IB/hfi1: Remove indirect call to hfi1_ipoib_send_dma()
Date:   Mon, 29 Mar 2021 09:54:11 -0400
Message-Id: <1617026056-50483-6-git-send-email-dennis.dalessandro@cornelisnetworks.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
References: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
Content-Type: text/plain
X-Originating-IP: [198.175.72.68]
X-ClientProxiedBy: SJ0PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:a03:338::21) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from awfm-01.cornelisnetworks.com (198.175.72.68) by SJ0PR03CA0166.namprd03.prod.outlook.com (2603:10b6:a03:338::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Mon, 29 Mar 2021 13:55:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5551486c-75a3-4bbd-d6b1-08d8f2ba413e
X-MS-TrafficTypeDiagnostic: PH0PR01MB6618:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB661898163655E7B66E6342D2F47E9@PH0PR01MB6618.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:283;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4gkmhdqGQDZSUQXCXDwo016Do6tnd29SW5s8kLkL9hFXCCrVLAnugWnzGdLMWYL1aLiGzQVxrTjIVU+rqdrYcC72OGOccRM0JLB0kGkspLdDsLe/suSYTQa2+6lvmIrVwZ24mA7+Q6NUOebpz2Uem+Crav45NO1sLSEFQ2AB2IvU9CoWI+h/BoLbT7zw4VAIQwR512Z9Q7xAb8Rzda52NjQD4c82SbUkJu1ZtccbDc9q5VXR3KFw3OkogmaY8SKWNvyl9BuFvDXS0UKQQgKmVrHVZSm6L7c2uMjuLSq7i7J+di9Z1kiUQOAw5CqJjU61cKbsFVUBkhxphF+NV1d5GM+LtXisj+H70CzXHq8zVGOw9tlBulyVTuPKx2ntAXkVsj+Exe+MpBQnigU/ibpkZVa1iZPrnYp+l0i2zTAWn2Qzdk9xyh3E3JU+86ADwaAoT8E0hBYZ3gO9/WDxq9GpR7ECzrvnpa56xc9Y8eHO5R/MzHF++AvGX0SpFLPBihyCAa/MledkR01JRkcTGdQYwpO+gvZ4/rs2wV4xTfVEUFLoCa+peOcFqBsNSMz5KpX8dcHVYY8AFrl9pDte1N6gICEGneZlWlfTX8znbkZVjtxwD/nYnHDBaT9s4WbzMc8e7r/KMfrQSQ5TwzZca53t3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39830400003)(366004)(346002)(376002)(396003)(86362001)(5660300002)(52116002)(186003)(4326008)(7696005)(2906002)(36756003)(66556008)(8936002)(956004)(66476007)(107886003)(2616005)(478600001)(54906003)(83380400001)(66946007)(6486002)(38100700001)(8676002)(26005)(316002)(9686003)(6666004)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jBCPHs3xowgAVw5QiT6iNBrRjXHpA9h8ahQASOWy5SFAnUpWM+g9+hjqmngI?=
 =?us-ascii?Q?+DpFZjAQTPbsiU/Y3H1qJbh/+79HJiloR8kSZYbdD+Q1Eoba1PfHC9x6lmau?=
 =?us-ascii?Q?b3QcyfhIqRp3BsyeuOY4zVaiKADW95KZ5otfkbKeSkUSCEzFtC/ON+atAHr5?=
 =?us-ascii?Q?wXhoTy+MoIDLcURufH+yDcdcFl2Emyc1QdfpYdWX2KjEdsjkM0uGSLHqAilD?=
 =?us-ascii?Q?LwgUZOpy4GqGWgB0OtdvQUYskfQZLqsVEqZ12/IEPlb6x0HiXFb/4QZg2avB?=
 =?us-ascii?Q?qtl2PIXb/GKQ7Nvd+PBi+U2nzk+4E1gGq5di6tUUJq6AWiwpOehqZEmPLVTJ?=
 =?us-ascii?Q?OG9vsjI22e0H0lP87q75Q/6zk5McIMTRxtG9ct4xKgdCHxQiMBzYRv+h9KS9?=
 =?us-ascii?Q?7B4BjpCUnK3okVsciVXUvggaNEEyaHRsgA3a1tuYPximTDyKCfNnOAJpw7Mi?=
 =?us-ascii?Q?gh8PQ5Z2js68zLsu2kE437PP4Rx4bQ5KX8/thLqSRGrS1KMW6yH09JmJbbWe?=
 =?us-ascii?Q?VnVaVbm3eT4qFe2O/4xp75+fF7mzI1iDJgAkrhJ0jylZ+3f4AoKOgu38IbAg?=
 =?us-ascii?Q?8hpC/o59o6VrvdEMyD2oIzwnGe1iA2S8dPCjQVfmDS8qpy3MhPWnm+mrCKry?=
 =?us-ascii?Q?2hhgSBFwouypCbwN9DqtzT6a6AkdRYSFoJw9kHtMoiP9RIbAI7S6O7r52/Qx?=
 =?us-ascii?Q?vyfKpd5ohfYW4G+WD649hvlhs9N3kLGeAEH5StZhK+qL7AxeYHUthR/HfjIF?=
 =?us-ascii?Q?QsPNcPiYiR/Qq3sTp2zxiJIxCsWAYbrQEmFXUelZYdzUa/g6P6s3AC2Tr8cD?=
 =?us-ascii?Q?QYndyRcoDsmHXqT/wh10zb9c9ikwQP3FvlKNTsO9MAbb9cuPRCRn+VPkY4E4?=
 =?us-ascii?Q?IHDz3xGeZ1Ppk+60Wyh8eo58RNbcWr6U9O7xADAF69M7wRytLnwz1z03dvfx?=
 =?us-ascii?Q?ceJaHUKSWxKaRuL0X6wdjjRmzrhVw1NdKyvDXGzbMJBnPpZqZFqz034b6wz3?=
 =?us-ascii?Q?wtJr4TOxAqi1XpeidRr7YSuSYFp5gzzh6Z4N2VSShpGp4ULyqK32ukOohQ31?=
 =?us-ascii?Q?DiDQE8FSLcBn6wWROyr/GZZb1OUYoeKREUdO4wHULpSIldbf0wJAh5mWwDfu?=
 =?us-ascii?Q?XIm28CAC+3e561U8yDBsdu5xR5rnu9uKroMx8m9KpdtkhU6saJWB34oD4Isk?=
 =?us-ascii?Q?fUV4OMedD4hLqbWfEuBKsZEUZUw8P0f4VmkHgM6Bf1G/R3i+AQTyLv2l0pnv?=
 =?us-ascii?Q?0dggwI1QbLmhX1Z/zn2MA1z3u7V6gD1MZk38f3oDrzViE5r5zDJ+dasnOViC?=
 =?us-ascii?Q?BWjnR+80th+lhyX9XQ5Q7uF0?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5551486c-75a3-4bbd-d6b1-08d8f2ba413e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 13:55:04.7193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5q5gC2YchjeESHIzvN4T+CDn8VZmKB62P2zAi9JC9JtQTCaSPnjFBWXvvlFaJas3yvP9bup1GCsDy1AGNN4l0+vjrXiR4Ozd5zQvYJmbxCPmUf4hu+t+mDB0XgZ+GIqR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6618
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

hfi1_ipoib_send() directly calls hfi1_ipoib_send_dma() with
no value add.

Fix by renaming hfi1_ipoib_send_dma() to hfi1_ipoib_send().

Reviewed-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/ipoib.h      | 8 ++++----
 drivers/infiniband/hw/hfi1/ipoib_main.c | 8 --------
 drivers/infiniband/hw/hfi1/ipoib_tx.c   | 8 ++++----
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/ipoib.h b/drivers/infiniband/hw/hfi1/ipoib.h
index 39c8909..bd0c9af 100644
--- a/drivers/infiniband/hw/hfi1/ipoib.h
+++ b/drivers/infiniband/hw/hfi1/ipoib.h
@@ -126,10 +126,10 @@ struct hfi1_ipoib_rdma_netdev {
 	return &((struct hfi1_ipoib_rdma_netdev *)netdev_priv(dev))->dev_priv;
 }
 
-int hfi1_ipoib_send_dma(struct net_device *dev,
-			struct sk_buff *skb,
-			struct ib_ah *address,
-			u32 dqpn);
+int hfi1_ipoib_send(struct net_device *dev,
+		    struct sk_buff *skb,
+		    struct ib_ah *address,
+		    u32 dqpn);
 
 int hfi1_ipoib_txreq_init(struct hfi1_ipoib_dev_priv *priv);
 void hfi1_ipoib_txreq_deinit(struct hfi1_ipoib_dev_priv *priv);
diff --git a/drivers/infiniband/hw/hfi1/ipoib_main.c b/drivers/infiniband/hw/hfi1/ipoib_main.c
index b8838fa..b737354 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_main.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_main.c
@@ -101,14 +101,6 @@ static int hfi1_ipoib_dev_stop(struct net_device *dev)
 	.ndo_get_stats64  = dev_get_tstats64,
 };
 
-static int hfi1_ipoib_send(struct net_device *dev,
-			   struct sk_buff *skb,
-			   struct ib_ah *address,
-			   u32 dqpn)
-{
-	return hfi1_ipoib_send_dma(dev, skb, address, dqpn);
-}
-
 static int hfi1_ipoib_mcast_attach(struct net_device *dev,
 				   struct ib_device *device,
 				   union ib_gid *mgid,
diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
index 8ebb653..993f983 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
@@ -581,10 +581,10 @@ static u8 hfi1_ipoib_calc_entropy(struct sk_buff *skb)
 	return (u8)skb_get_queue_mapping(skb);
 }
 
-int hfi1_ipoib_send_dma(struct net_device *dev,
-			struct sk_buff *skb,
-			struct ib_ah *address,
-			u32 dqpn)
+int hfi1_ipoib_send(struct net_device *dev,
+		    struct sk_buff *skb,
+		    struct ib_ah *address,
+		    u32 dqpn)
 {
 	struct hfi1_ipoib_dev_priv *priv = hfi1_ipoib_priv(dev);
 	struct ipoib_txparms txp;
-- 
1.8.3.1

