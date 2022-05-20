Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532F652F30F
	for <lists+linux-rdma@lfdr.de>; Fri, 20 May 2022 20:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347361AbiETShM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 May 2022 14:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352899AbiETShK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 May 2022 14:37:10 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20721.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::721])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B84460AA8
        for <linux-rdma@vger.kernel.org>; Fri, 20 May 2022 11:37:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cet7R4ksC6ddEh8HzSuxR2x2cCKkaTMVWZmoh6i0IJdmNLsG2MQgaK1XjEfgijeTRC5XcVsSiDa3MR64FrnqNOyVfMQi9yComYjNdMgdUinguVTNM/pLx625UOJUfjh5mjUTW/F26PCvz2S2uhHOmLF+O9TFibbmrR+TgfJ7fe9Ip8v0qhInF1Vvee4HX7BE+Wf6MCz++M8/hnAY0nLpvqU/lVv9zzf486A9E96WnvK/OmtBh7N5YmMlTcmo0xvzV8s8YrLlvgUhlLFdzyeAEhCp1kGGS8gvepGoza30NmDJeb2ycFZKkXiKawwekUsWXPczHS0zqSDy9BlH4xOL0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ga6RdUjO5jHNUnPNuMY5df46N1Qy550vtzRuJQfGEsA=;
 b=IK9neEl04DPZJ79VA7EC2LutZtMBQ/9fQuIo0VE3nBVqHyouwTDJy6Y+PNzT+eU9HIx5sZgkfzm+EORDbhgGGyOmdZU6pCUuOgCEfzyB39ThMoAh2wOkZk9iKmEY6kqntuaNQOB+Wok6FdqKev6XOJnEEuVv2NiDL7MVhhpX4gAZ4LFHNmbneJ8cRCQufMgiVl7rwrcx6iispqzuZTgZbuuzpCzjdq85xaAH8L+X1jx2cmMz5ranIWAPFgvnPfInwUkr17HbtTHsyKHlTuFSl8vXWMEo39qyy2lXBl9W4BvRmJMUydYd7qc7thscEuKpFz8vybe/yWtfmGbCLUtkDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ga6RdUjO5jHNUnPNuMY5df46N1Qy550vtzRuJQfGEsA=;
 b=PaRGNk6ai66BpZkKZEI+dO596mTpbK5ZQ3JBEiAfB7CH43hLgB3Uzf+mvqnzwlKruT+k8HXq8mHB6S6rMzghVsxN6E5UtEKHTI2oSB2h/BUfCcGWspsWFXOV6xZ2yLe616mbLanIam6lFtNzwL/n2ckKxlz+ESr5PBkoI077F+cZsCYv7yz+ZbstzZA1fcRlGl1JB5ydd/xoznFwG1LKvEFDHW/hI0JdoH+WEfZQrLLh29k3tB5JtCSd2x3T1OfLShK21UJBocZimFqu3YZU0QU3v4X8+no3kubWu9qScfwJbo4bNdII7TsGod6s+LI4kV+XT4Yj5dmqMdEvTUmrHg==
Received: from MW4PR03CA0068.namprd03.prod.outlook.com (2603:10b6:303:b6::13)
 by SA1PR01MB6573.prod.exchangelabs.com (2603:10b6:806:1a2::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Fri, 20 May 2022 18:37:03 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::d7) by MW4PR03CA0068.outlook.office365.com
 (2603:10b6:303:b6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16 via Frontend
 Transport; Fri, 20 May 2022 18:37:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com; pr=C
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14 via Frontend Transport; Fri, 20 May 2022 18:37:02 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 24KIb1W7055107;
        Fri, 20 May 2022 14:37:01 -0400
Subject: [PATCH for-next 1/6] RDMA/hfi1: Prevent use of lock before it is
 initialized
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     leonro@nvidia.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>,
        Douglas Miller <doug.miller@cornelisnetworks.com>
Date:   Fri, 20 May 2022 14:37:01 -0400
Message-ID: <20220520183701.48973.72434.stgit@awfm-01.cornelisnetworks.com>
In-Reply-To: <20220520183516.48973.565.stgit@awfm-01.cornelisnetworks.com>
References: <20220520183516.48973.565.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4947066d-526d-4138-6a9a-08da3a8fbb8f
X-MS-TrafficTypeDiagnostic: SA1PR01MB6573:EE_
X-Microsoft-Antispam-PRVS: <SA1PR01MB6573C0D1841DB294B651CA70F4D39@SA1PR01MB6573.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aJYSL6TH4tRIAq5RYQcD7nwhj32WyR3xCvqogjywz47ZsEHdQZ4XVKWusyY9bnrfW2UPcoaL4rOFL+4f3buu9KXvoMJ8BBUcT1NEFkcKo+qoW9Gb8NazKX0B7P/QMvU03Jbzeios8wyhklDlGal4TGpiETbVmzRxGBCm/yDk4glqAaMV2l80x8HrpDpljGiLzRIZVgYFAd161VjZWHK+eYosPgNO+DVjjNrkxPlRZgAAUIK3aYjLKegKpfXgLJzOCB1WA9W5lfYwCTCENN0QC8QcERA1/8LDikVH/9qmBbQW3jPLepk70YyjiBEmfZGxuwSRljzLP/sQswiVb+AQxAe2VI7f1CQ5NpYmGAPPQz1sIFS7E2BvG1+IM71ANYKiydavQ09FpMSVxX8CzuiZwOBYQQi+qBrypahOHn0tPFTG1Af+za8BR49zTtNPOdfoXB0khZHSdXASkYISnEsgwr4XFuD+dG+YQoqwD3bx83DrUea+f0ZXks73IJO9jbF45TvlXH3y0yYjJhY5i1/A6ErU19HW14wUEi96FchyZkKTuwhqh5Pym5aSHbNMWMK276pgqijS5SkaGP973FM1KI56uZPFZpz8PpfrpvdJZGB0iWtZR3Rjpv/EeIyu3itIeuhRBpSXJ+EQ3I2Zw5U4nG0g8Lt9ohhMM3Q18wGB3h2/z5N1Emp7n6AHQv6s95oYFp97uMa8yS+999vh8wTt+Q==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(136003)(346002)(376002)(39840400004)(396003)(46966006)(36840700001)(47076005)(426003)(336012)(54906003)(1076003)(55016003)(83380400001)(8676002)(41300700001)(186003)(508600001)(70206006)(4326008)(107886003)(44832011)(70586007)(7126003)(36860700001)(40480700001)(316002)(356005)(103116003)(26005)(5660300002)(81166007)(86362001)(8936002)(7696005)(2906002)(82310400005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 18:37:02.6100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4947066d-526d-4138-6a9a-08da3a8fbb8f
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6573
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Douglas Miller <doug.miller@cornelisnetworks.com>

If there is a failure during probe of hfi1 before the sdma_map_lock is
initialized, the call to hfi1_free_devdata() will attempt to use a lock
that has not been initialized. If the locking correctness validator is on
then an INFO message and stack trace resembling the following may be seen:

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
Call Trace:
register_lock_class+0x11b/0x880
__lock_acquire+0xf3/0x7930
lock_acquire+0xff/0x2d0
_raw_spin_lock_irq+0x46/0x60
sdma_clean+0x42a/0x660 [hfi1]
hfi1_free_devdata+0x3a7/0x420 [hfi1]
init_one+0x867/0x11a0 [hfi1]
pci_device_probe+0x40e/0x8d0

The use of sdma_map_lock in sdma_clean() is for freeing the sdma_map
memory, and sdma_map is not allocated/initialized until after
sdma_map_lock has been initialized. This code only needs to be run if
sdma_map is not NULL, and so checking for that condition will avoid
trying to use the lock before it is initialized.

Fixes: 473291b3ea0e1 ("IB/hfi1: Fix for early release of sdma context")
Fixes: 7724105686e71 ("IB/hfi1: add driver files")

Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/sdma.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index f07d328..a95b654 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -1288,11 +1288,13 @@ void sdma_clean(struct hfi1_devdata *dd, size_t num_engines)
 		kvfree(sde->tx_ring);
 		sde->tx_ring = NULL;
 	}
-	spin_lock_irq(&dd->sde_map_lock);
-	sdma_map_free(rcu_access_pointer(dd->sdma_map));
-	RCU_INIT_POINTER(dd->sdma_map, NULL);
-	spin_unlock_irq(&dd->sde_map_lock);
-	synchronize_rcu();
+	if (rcu_access_pointer(dd->sdma_map)) {
+		spin_lock_irq(&dd->sde_map_lock);
+		sdma_map_free(rcu_access_pointer(dd->sdma_map));
+		RCU_INIT_POINTER(dd->sdma_map, NULL);
+		spin_unlock_irq(&dd->sde_map_lock);
+		synchronize_rcu();
+	}
 	kfree(dd->per_sdma);
 	dd->per_sdma = NULL;
 

