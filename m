Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238CA52F31B
	for <lists+linux-rdma@lfdr.de>; Fri, 20 May 2022 20:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352805AbiETSh3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 May 2022 14:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352884AbiETSh2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 May 2022 14:37:28 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2099.outbound.protection.outlook.com [40.107.237.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37C616F900
        for <linux-rdma@vger.kernel.org>; Fri, 20 May 2022 11:37:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vs34c3UAul+kx81O0fuj8NyEodQfidAy8H9HTxWeeNYjA93bUq672OeXTc59Ej/yDMxo17zri/FQa8dep58Y7H5wqBquho1rHIDzqmYTB8JAKsw9acgj6xWppuCuUZ02btycllZYnBA/DAyHDMGlTWF4wvT4xTN8cZ20BSs9hSGLONDHd92wmfu8ku4doyLKyXL1q0hCT0K9BDl8AaqxeRhvI/rr2IUhDbNQZvs36BvJWRInjg+quxMlJJ2xNhcnKEXaotIQPlIv7Ngx0nNSSMgeJ3/nlvK0WuLCF143bNyPUALJNlSAUojQXwtFWD1BQMYeieL+DTBOa97QMC9Iuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8hIRO73NeizVSu6xGoS+41/WiSEhzM/7pbOt/W2QNU=;
 b=YWiN4bw4Vyclxesf6mr5EtsG1ckIWJSwH7/xoortdpGSsqqQyqdGFq/D5iFhP2P7o9SIgfBzWdimy+zqvoDORWYH1hsOYZcUNtBDWCAEEZC4z6r61XXNvnMq8c8N1jSrDYsf1pBUEg4VV6EHrBYe/QPBbM0IbM9w10JEQgOBjAncItFn0UYL7cOMDPo6iWaMpK6yVGtC0Cje/JCNJk1M3T/WwTrdeho/EDjY+XMYFtCGRyG02sc7Mj3VoJLSuEqxdQ7MJL8dvj0F6bFIgsNahiSg5oISsZsQ6diuZ5sHmT3afzJDSN5vl1QrM0physBxwDe+CQ6evhpWgTqzQf5mNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8hIRO73NeizVSu6xGoS+41/WiSEhzM/7pbOt/W2QNU=;
 b=dBPEMtueAltv+0r7AVysAkQg4r0YvlvPNDuOLVHhSbe11CWwxGnhOnKakAAMZyc7ltDywt36N7zV1SH+Hu4aM5MMIZzIZN5VuDJCDi8lA8QSXtJMR4dOsrgNQlEylwho42tvhO007DWzQaluLR1ZSydsr2Xba6FwfQtcB7c/6H+RXPxHqx2wRyZHtAhQRq2qQ9SzWtHyK5kAbUYSCcE967sMFCm5uDXTd9ejCaZEn1zcEw/rxCuiWdhjE49D7SF02sZrGmZUpgZyr8AWewQzbpgchyYq/p17d9vHjnPRI3XznvH8UaIITEAXZIozOvFEhzOfuC5j/YzfoI7sCr4KKw==
Received: from MWHPR14CA0038.namprd14.prod.outlook.com (2603:10b6:300:12b::24)
 by DM8PR01MB7205.prod.exchangelabs.com (2603:10b6:8:f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.15; Fri, 20 May 2022 18:37:24 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::f2) by MWHPR14CA0038.outlook.office365.com
 (2603:10b6:300:12b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17 via Frontend
 Transport; Fri, 20 May 2022 18:37:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com; pr=C
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14 via Frontend Transport; Fri, 20 May 2022 18:37:23 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 24KIbMLU056385;
        Fri, 20 May 2022 14:37:22 -0400
Subject: [PATCH for-next 5/6] RDMA/hfi1: Consolidate software versions
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     leonro@nvidia.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org
Date:   Fri, 20 May 2022 14:37:22 -0400
Message-ID: <20220520183722.48973.60262.stgit@awfm-01.cornelisnetworks.com>
In-Reply-To: <20220520183516.48973.565.stgit@awfm-01.cornelisnetworks.com>
References: <20220520183516.48973.565.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a2c60b8-8699-4cf2-cca1-08da3a8fc80f
X-MS-TrafficTypeDiagnostic: DM8PR01MB7205:EE_
X-Microsoft-Antispam-PRVS: <DM8PR01MB7205BC16C2F9C6E0C0E28113F4D39@DM8PR01MB7205.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JOym7kU43J4Ts4ISzZkUelfAjUs8nEacul9290GrPCEEtC2dXbk41kZ1naEQIcDFi8g31hOkxFqBQrII8W5Pm6O9RyxG16FZjkNE4WPaNrOODk9s8Hb54Zt1IwT0qEcmJOHxLo7CvVh/kL7GiVTLOxEvXjltxGnP/Dik8U6SzSb9gEQMMCZHqkEpikxAiv51d7ZMDmBJue3pTvCEcgBLW/KW8bdrb3i+tZbRdH0Ut6Ea4Vy228yGwbOKbhkekApncGmd9uh8+IuBfThvDKFTZ8+6aMmGaXLg4UEuE+gxuWuyAb/pevv2Gptz68W8NK/g1liMO/3jXLMR+GJKSP0aKp3la/qjTi0iYkTyu3AmihNQ+rkV53Quc/vWGUtqiJHcwAwEIsmSXAwf5MtCGBFIuhl+M6LoZdvWMYJA129GwRImSyV6IXabm1/NISxwPYc1/GUdB2awfNc2pwiNObJR6LdHLnAv99NZDNr7ABCVp12bMi31ydiNvJoxgmXjKUz6Aq/9TzMHbuyTkDNgMrqtmDo7Nr8/BOvqCuh1f4Z+Y06roI3vVGTum0PEzUxwo64j1ef4Qx77uqUl7MaP7nlJHWfjhUghRijuXksbwzF4HON8RBuqqXMmmLbELjc53alaOLR3x3KT5ceiGrj3W6hEXWO9mF999s4gF5KqQSkIWprPRBzBdJJgGFJ5+aey2e0fJxVjguajyCjr8dIT6mO7pw==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(136003)(39840400004)(396003)(346002)(376002)(46966006)(36840700001)(81166007)(186003)(36860700001)(2906002)(508600001)(356005)(103116003)(83380400001)(316002)(7696005)(26005)(41300700001)(86362001)(70206006)(40480700001)(70586007)(8936002)(5660300002)(336012)(426003)(47076005)(1076003)(7126003)(55016003)(8676002)(82310400005)(44832011)(4326008)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 18:37:23.5997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2c60b8-8699-4cf2-cca1-08da3a8fc80f
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB7205
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is no need to have separate user and kernel software versions. There is a
single software that the kernel is compatible with.

Also remove the notion of a "kernel type" that is long since deprecated.

Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/common.h   |   17 -----------------
 drivers/infiniband/hw/hfi1/file_ops.c |    2 +-
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/common.h b/drivers/infiniband/hw/hfi1/common.h
index 73a2f13..f32f858 100644
--- a/drivers/infiniband/hw/hfi1/common.h
+++ b/drivers/infiniband/hw/hfi1/common.h
@@ -137,23 +137,6 @@
 #define HFI1_USER_SWVERSION ((HFI1_USER_SWMAJOR << HFI1_SWMAJOR_SHIFT) | \
 			     HFI1_USER_SWMINOR)
 
-#ifndef HFI1_KERN_TYPE
-#define HFI1_KERN_TYPE 0
-#endif
-
-/*
- * Similarly, this is the kernel version going back to the user.  It's
- * slightly different, in that we want to tell if the driver was built as
- * part of a Intel release, or from the driver from openfabrics.org,
- * kernel.org, or a standard distribution, for support reasons.
- * The high bit is 0 for non-Intel and 1 for Intel-built/supplied.
- *
- * It's returned by the driver to the user code during initialization in the
- * spi_sw_version field of hfi1_base_info, so the user code can in turn
- * check for compatibility with the kernel.
-*/
-#define HFI1_KERN_SWVERSION ((HFI1_KERN_TYPE << 31) | HFI1_USER_SWVERSION)
-
 /*
  * Diagnostics can send a packet by writing the following
  * struct to the diag packet special file.
diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index cb65f31..231cced 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -1223,7 +1223,7 @@ static int get_base_info(struct hfi1_filedata *fd, unsigned long arg, u32 len)
 
 	memset(&binfo, 0, sizeof(binfo));
 	binfo.hw_version = dd->revision;
-	binfo.sw_version = HFI1_KERN_SWVERSION;
+	binfo.sw_version = HFI1_USER_SWVERSION;
 	binfo.bthqp = RVT_KDETH_QP_PREFIX;
 	binfo.jkey = uctxt->jkey;
 	/*

