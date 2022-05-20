Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3225C52F315
	for <lists+linux-rdma@lfdr.de>; Fri, 20 May 2022 20:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiETSh0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 May 2022 14:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352899AbiETShX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 May 2022 14:37:23 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2136.outbound.protection.outlook.com [40.107.92.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6CF8AE49
        for <linux-rdma@vger.kernel.org>; Fri, 20 May 2022 11:37:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXTzxuFpVX5c2iJTZBq60Ab0mkUqRfjmyVT6UngMszjBRUQvPjqBOo0oLFxcJ3hTZLcxKr0sRNToGbBcKenfbDBNppRt4qYIJJ0NvxeJX9wQRfDhQvuJ2wvPl9JM5SErP25Gsk1yi8Gpoog64xC2BhK3xCaq6YaHmcADfvNg8/LRpY9hz3IrBlgECrQhSOFRUq2NaShAvdt6Ihxu7NLe0KZTKf1IGbDhWB1UTBRdUZBPF8zt2c3SflCdMYKlXQvjYUw0xUuk1H7pCJDiamAwb73d0eouSSmkfWxTHflkTMr2CVxe3voOntTBW+3yTTSJkxH3VBPPkCHi36kb7XOYOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hf9+oQy0Ie3S1PD4EEnLbTbYp1mFiwKnJ4pVQh3tw/0=;
 b=lMeqel/VHa3fF0ohKRwlnri/SOHsyHy1y1pxfGMP+/NhqNbXwEBrCa00udbcDCy4gSEhW4FYR8I20ETOtEuEugQy8KwqAtTCl7dTxg4KKa06HkhVQZkvkDmDpDxNSEiSvomB+wlMvF73cZqoF8sD6XKh1OyT7poOJClssaSGNalGII/2NeJCguk6nYIqwP4P8MPHso6OX92oR0il4GUdqfDHz9DEauB7pLfmMqWmo1lQYzMiuaa/dHS6LmR/Nz76v5n55xA+1rLb9caHc502UBXXHWIIbE6QDPc7DtK0ud/zBrhwbY9mlMY7QaftvmYdxgLhUpidYB66leR3qp4y9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hf9+oQy0Ie3S1PD4EEnLbTbYp1mFiwKnJ4pVQh3tw/0=;
 b=Aav3z4K9BuRTU6W/2EFCYZAMy+wr/SCU+MznJUULPlf4MoFnkJyr9gZTsn3kj7N7FtumlCbUNJs23NbdEVei5YDF+YVdKVW5KZYAqjiHFCgohPyF3oAkW7A5fUPzd5Z833rmV2fgYSY1cblj4GdLTLJNk/0kQEIIgANP/kQa1bHhMjEROe4rXqQqZ+nph/YoQ/ukenvZm7/sZTlLjFzaEpwumlmt7mJSxahuj7VHL1kaKxptTjb9r6MM06ZKAA92VfU4ubs5GKjEEWygWRCDiZM3Ln7NR+ivGrXeH9P9km4TFLzGWLBvy+rqbnk5GyU7OqwkV9kbXmnCH3uuSRbyhA==
Received: from MW2PR16CA0065.namprd16.prod.outlook.com (2603:10b6:907:1::42)
 by SA1PR01MB7360.prod.exchangelabs.com (2603:10b6:806:1fb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.13; Fri, 20 May 2022 18:37:19 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1::4) by MW2PR16CA0065.outlook.office365.com
 (2603:10b6:907:1::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17 via Frontend
 Transport; Fri, 20 May 2022 18:37:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com; pr=C
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14 via Frontend Transport; Fri, 20 May 2022 18:37:18 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 24KIbHV8056069;
        Fri, 20 May 2022 14:37:17 -0400
Subject: [PATCH for-next 4/6] RDMA/hfi1: Remove pointless driver version
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     leonro@nvidia.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org
Date:   Fri, 20 May 2022 14:37:17 -0400
Message-ID: <20220520183717.48973.17418.stgit@awfm-01.cornelisnetworks.com>
In-Reply-To: <20220520183516.48973.565.stgit@awfm-01.cornelisnetworks.com>
References: <20220520183516.48973.565.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f3d5c0e-9f70-459d-ba60-08da3a8fc4e6
X-MS-TrafficTypeDiagnostic: SA1PR01MB7360:EE_
X-Microsoft-Antispam-PRVS: <SA1PR01MB7360BDEE4B529E7BCBDF2B0CF4D39@SA1PR01MB7360.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oC13PeSFePqzEWUkuuF+/cDfl1aWKFqTzIaxtiI4oM55Sjb2ImnfnS97uv1kxgW43a5vsXpwjTd/dJAaiAfhTpSA7RLHH58iKDEaDcLDzQhUCsi/BHgVg0sogeqp063PDIfAkG/kv3yEIy6NAguBfbnOb5eJWKpl9b7gG7oN7WUicq4fJfZWGSNM+/nFdIHC9CV0EOznfD8sic3RUMQQKktISey9uFgWlKNFf6/mC+QbcsWCbQx40IGitg1Ab/Qhplp+jomks5bGTs0ZWqCGzSHIB/OaZ2ojf5hhbWAH6OVoM2lpS8CUe0/Ac25wAHPsDCtDAtESSX3ZIS6wBUh/eECghSCgwOQwyzBAt32DSPetIp6g7uEjimCfcYr8ad1a4Gqp8Ci5XFJ5QZ8ykg8Gp1kz8n+N3huknKem3I8Wcnf0cS3mBsZMpDzOl2WJJyAryq2vJDuxMcar9kyhT0pCwDgouz5Re+wBSgMmFMagUGwdc0IA4DTtKaYcvsjLpHUinJ+3z2MOMo+ICn9z9I1WyYNghKxxGoqjrQ7S8LJ3hAQ5gh154hKZ5oeN6APMtaun3judjiAK9T4ALKT2OKANi7DbYCtUdEARAn2zbfWGfMVUQPCAoqJP0OnJVxGCQ31DtVo4hEaX4PUQ1jiip2BBZ3+Ep6SKLd5GIgD48oaTYT4dYyugztwhzke1Xp96eYMTC1qjoS9KrhFp4dpabIxXUw==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(396003)(376002)(39840400004)(346002)(136003)(36840700001)(46966006)(82310400005)(186003)(1076003)(36860700001)(7126003)(44832011)(5660300002)(41300700001)(83380400001)(2906002)(8936002)(103116003)(40480700001)(508600001)(55016003)(336012)(426003)(47076005)(7696005)(70206006)(86362001)(8676002)(26005)(4326008)(70586007)(316002)(356005)(81166007)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 18:37:18.2817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3d5c0e-9f70-459d-ba60-08da3a8fc4e6
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7360
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Driver versions have long been forbidden in the RDMA subsystem. We removed most
of the code relating to them and have been very strict about not allowing.
However there is some leftover versioning that we do not need. Get rid of that.

Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/common.h |   15 ---------------
 drivers/infiniband/hw/hfi1/driver.c |    6 ------
 2 files changed, 21 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/common.h b/drivers/infiniband/hw/hfi1/common.h
index 995991d..73a2f13 100644
--- a/drivers/infiniband/hw/hfi1/common.h
+++ b/drivers/infiniband/hw/hfi1/common.h
@@ -155,21 +155,6 @@
 #define HFI1_KERN_SWVERSION ((HFI1_KERN_TYPE << 31) | HFI1_USER_SWVERSION)
 
 /*
- * Define the driver version number.  This is something that refers only
- * to the driver itself, not the software interfaces it supports.
- */
-#ifndef HFI1_DRIVER_VERSION_BASE
-#define HFI1_DRIVER_VERSION_BASE "0.9-294"
-#endif
-
-/* create the final driver version string */
-#ifdef HFI1_IDSTR
-#define HFI1_DRIVER_VERSION HFI1_DRIVER_VERSION_BASE " " HFI1_IDSTR
-#else
-#define HFI1_DRIVER_VERSION HFI1_DRIVER_VERSION_BASE
-#endif
-
-/*
  * Diagnostics can send a packet by writing the following
  * struct to the diag packet special file.
  *
diff --git a/drivers/infiniband/hw/hfi1/driver.c b/drivers/infiniband/hw/hfi1/driver.c
index e2c634a..8e71bef 100644
--- a/drivers/infiniband/hw/hfi1/driver.c
+++ b/drivers/infiniband/hw/hfi1/driver.c
@@ -29,12 +29,6 @@
 #undef pr_fmt
 #define pr_fmt(fmt) DRIVER_NAME ": " fmt
 
-/*
- * The size has to be longer than this string, so we can append
- * board/chip information to it in the initialization code.
- */
-const char ib_hfi1_version[] = HFI1_DRIVER_VERSION "\n";
-
 DEFINE_MUTEX(hfi1_mutex);	/* general driver use */
 
 unsigned int hfi1_max_mtu = HFI1_DEFAULT_MAX_MTU;

