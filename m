Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A46429DA55
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 00:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733190AbgJ1XU6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Oct 2020 19:20:58 -0400
Received: from mail-eopbgr770081.outbound.protection.outlook.com ([40.107.77.81]:20388
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730715AbgJ1XUI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Oct 2020 19:20:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBg9/lsy69Lm7uSRL6PPjgzSAAyr9yNbQAJVa0gn3Esy20IJc3AbIoK5bT4eNFXFQ6VgicPe3IlKHT9nEojHkMmq1Tf4FRmTNgnTny9Ntc8f5+QohZLuHjXppeC+JTVnK6HRVyjsoAVV0TpXPVmnjUVkyF2YeCbAUNSmH4Md8E4RFStEyw/UuGgGzF2uKRHMI886V7RPXjh4DNl/FtTGto4nodHjTyFMoP8S6hrPpHqGPb/TwsFtgSPeHEc3zI4GdcHFfyQSvSdY/28g2uvEdnmOg6R3qI0sjRxE5VcAea2v28i86x4APOm4Gu4Zs7eNkz7vx8bDFOaqaZFpMf2TMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSdv1i60FbwEWhmDxXzIs0HDb/LTLuY0bs66xHXElHQ=;
 b=Dqmv+360oh7/wc++wkbnY3LS8rofssPAfOdtiVdpK/19EADRFFZXftQ5MRbUnn5Via8jB7lzsRP5qmLbGhxOXPVYa0clLHAKebH1U3KY/S8PTAKrb5RfFGttfr0RaXpp3Evhjz1sJkVCBH+V5kebuEKBRqyWmjLirxQKZZ6XnSd8I8v9PxNmQO+CzCAysUmL8108n/aC4N+FGIdTxfOPObdkxQtQ/4tSjE58XK98IhYbXtS1WtMBrLcZJ+TTsrYQ7K2oTax40y0UlL6dceQSoxMIuOmxgHg/vs7etI96LBBd5U7aB0hIYWVNDcFxlSdFjyczVcJrq4QimgEBD5AaOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSdv1i60FbwEWhmDxXzIs0HDb/LTLuY0bs66xHXElHQ=;
 b=NO4Taz9BPec7dR/Vb4OEaM7C6nchZe2O4AAT4NgL04nnq9XfPqsjhp/N9kxJkN9NeekgDj0jxDxrISuVJFFyQ4l0JO+UOnEUELmTQJq+zAElBCKcX02DMIPXz1xy6sV46Evn68EZGu6HNJTWyHAafi4WYlI7ow82+JM868nLk0M=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=vmware.com;
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (2603:10b6:a03:1a::28)
 by SJ0PR05MB7626.namprd05.prod.outlook.com (2603:10b6:a03:2ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.4; Wed, 28 Oct
 2020 23:20:04 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::958b:64f6:b2f9:97e0]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::958b:64f6:b2f9:97e0%7]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 23:20:04 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     jgg@mellanox.com, dledford@redhat.com, linux-rdma@vger.kernel.org
Cc:     Adit Ranadive <aditr@vmware.com>, pv-drivers@vmware.com
Subject: [PATCH for-rc] RDMA/vmw_pvrdma: Fix the active_speed and phys_state value
Date:   Wed, 28 Oct 2020 23:19:45 +0000
Message-Id: <20201028231945.6533-1-aditr@vmware.com>
X-Mailer: git-send-email 2.18.1
Content-Type: text/plain
X-Originating-IP: [66.170.99.2]
X-ClientProxiedBy: SJ0PR13CA0101.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::16) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-build.eng.vmware.com (66.170.99.2) by SJ0PR13CA0101.namprd13.prod.outlook.com (2603:10b6:a03:2c5::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 23:20:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c590ded6-a9ef-47e9-c1eb-08d87b980041
X-MS-TrafficTypeDiagnostic: SJ0PR05MB7626:
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR05MB7626547D5A4B35CF25A994AEC5170@SJ0PR05MB7626.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OQQb0oMwP4ArP295T1VCXhFefygd5kmE2bNHCb4sd1zmT4WeXDFA9+bE+v6rD8LHMn2EGSLrFA/nHYjg6Obymbe59DNo32Bm1YdjYWMS/tdsmBJdyO8c9QXy0vSdg3ntThST3te+gJZy2MdK4QT6yaCTUr+wmmRCCMOboYvsg9PGVlJsCzUmzpaegVuOrkouwtMdycHqG56eEVF8OZB7w8tKdZqna6guacrfDi/IMG+nkaPcKWLrb1QfwqD3+UQ1VlDXJ1e45YQhVLRRgZy9u1Bqbx1FrYHaE39amJ3dtrGBLOX2hoeBOBxYvH79cfQVkXB/DaoMyu0KZKa/S6ngyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB5511.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(86362001)(36756003)(2906002)(5660300002)(6666004)(66476007)(1076003)(66556008)(66946007)(956004)(478600001)(8936002)(2616005)(316002)(16526019)(8676002)(26005)(186003)(6486002)(107886003)(4326008)(7696005)(52116002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: f35ICTPl6KWVTJwZKKhmgZT+o6eqR1o69nEmPoE2kaMhOgZJi7uwHH8eJjF+TPml4Vyuyfy8jWg74sEpjyJjPp1adUvwOG95tz0XwQhWpQnjgIXxJlzygqJwHW2AlOS34eq1JtuHsZ/LVvpRRc0UIWTYUYlXGFNaKSVM1gE4MT1mOEfkH+TwPjPLj4Qdhd0mfNJRhMEjPm5sjbiE/sAJeaRFVkBzNdrC/2XxktJq2o6AZzQ7ivwAkLhXXBpaCFSwDef+nRCi4yt5TjKqh2sTq9xC68BnbKBhcAW+U7DmDncAlpNy6WDwkW8ozFKFwKbUB57/1m1AsgjZThdSYovJqTZ4/jyflY0Y2usdlpKA9oQJ5zZNFkIDE22I4o+yxG8/nCIQu9RbiqQBQFTAmW9OKdomLb80Ka3W3Ro0eUxrusd6soUdiTKanbO/zRHVqxeV+zcEToxsYFoL1/ABVT3KpVUvhyC4zepB8XKVpswdaAR0baDAwxZRCevyQZfot6++Vp+ApuXt7MgnrZIK2C/5Oy9wcOoglj8S36KAbArarg0BKYVGueQ1g7rx9LCLX2DQQQHnIXebZG0X7EuhQoWliYWZiUOo9t/nqiJlH694EHVrU/DwX/WRzlf5krrMFSP3iCfgKDJWj5+alou6gc6nbw==
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c590ded6-a9ef-47e9-c1eb-08d87b980041
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB5511.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 23:20:04.8236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zsbjBBSERvb0IorMNSVGLqBcVQ6SaMn8jDKyCKQ3M/RCXmdHZ5mB5o14yFWAHgtE+2hjVOy4BgM52PYS8FVWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7626
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The PVRDMA device still reports the active_speed in u8.
Lets use the ib_eth_get_speed to report the speed and
width. Unfortunately, phys_state gets stored as msb of
the new u16 active_speed.

Fixes: 376ceb31ff87 ("RDMA: Fix link active_speed size")
Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Adit Ranadive <aditr@vmware.com>
---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h      | 18 ------------------
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.c    |  8 ++++----
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h    |  2 +-
 3 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
index c142f5e7f25f..17f20506575f 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
@@ -360,24 +360,6 @@ static inline enum pvrdma_port_width ib_port_width_to_pvrdma(
 	return (enum pvrdma_port_width)width;
 }
 
-static inline enum ib_port_width pvrdma_port_width_to_ib(
-					enum pvrdma_port_width width)
-{
-	return (enum ib_port_width)width;
-}
-
-static inline enum pvrdma_port_speed ib_port_speed_to_pvrdma(
-					enum ib_port_speed speed)
-{
-	return (enum pvrdma_port_speed)speed;
-}
-
-static inline enum ib_port_speed pvrdma_port_speed_to_ib(
-					enum pvrdma_port_speed speed)
-{
-	return (enum ib_port_speed)speed;
-}
-
 static inline int ib_qp_attr_mask_to_pvrdma(int attr_mask)
 {
 	return attr_mask & PVRDMA_MASK(PVRDMA_QP_ATTR_MASK_MAX);
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
index fc412cbfd042..221705837d78 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
@@ -167,11 +167,11 @@ int pvrdma_query_port(struct ib_device *ibdev, u8 port,
 	props->sm_sl = resp->attrs.sm_sl;
 	props->subnet_timeout = resp->attrs.subnet_timeout;
 	props->init_type_reply = resp->attrs.init_type_reply;
-	props->active_width = pvrdma_port_width_to_ib(resp->attrs.active_width);
-	props->active_speed = pvrdma_port_speed_to_ib(resp->attrs.active_speed);
-	props->phys_state = resp->attrs.phys_state;
+	err = ib_get_eth_speed(ibdev, 1, &props->active_speed,
+			       &props->active_width);
+	props->phys_state = resp->attrs.active_speed >> 8;
 
-	return 0;
+	return err;
 }
 
 /**
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
index f0e5ffba2d51..715416902992 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
@@ -178,7 +178,7 @@ struct pvrdma_port_attr {
 	u8			active_width;
 	u16			active_speed;
 	u8			phys_state;
-	u8			reserved[2];
+	u8			reserved;
 };
 
 struct pvrdma_global_route {
-- 
2.18.1

