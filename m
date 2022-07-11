Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB2757064F
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Jul 2022 16:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiGKOyt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Jul 2022 10:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiGKOyr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Jul 2022 10:54:47 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2102.outbound.protection.outlook.com [40.107.94.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EE971732
        for <linux-rdma@vger.kernel.org>; Mon, 11 Jul 2022 07:54:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezWRSXdwEFbxBUtAgItGUeBnUTBgEPONHWQ8u8vbpYSVf2hZZAMQplQZg81HxcxFN/LKUSvddTuHZdQVNCB16awQyIMPFUu36i0T8f0ff1RWR17mADhYad9O3cC6Q1xUq2GFwJvro94H8mPXzRtb32yJtYzdGVzMpYqOTMytGGfJ9oP2i/tbEAEAoU3awLyKjJSFk2vyll65TbESrW3p0HhU00kYhVZKLUDQ5rVv/oNHO0MIO5svCT8kr1U1F26MRMD6BbmWzbfFhYT3yjU+9QZrMLqd3TiIE45UsQzPbNVHYVD5QnMTXyPcyAkdBK73lP8gznTKGxfOFaTM/HUcrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xowSX4BpRDO+s/uv94vaqO5xV4E/OGJGS6LC2mz0C0g=;
 b=GFyWIvlrExgHe2TX8FgRjJsw8Ik8fV8eDBkmfIFu+CcRI8pMni29b5cYvWCCUpgkDL6J8F/kmWQW0z95dXX1oC8Aub9aXN6iA0UK5Teo5qI3NNt4HRPncton2GziNk2nza8yfPkz8gV3RHvzhAtv2FARptex3XgtfdsH+pyC4DXpWj4ffp9TMDy8fNJvzd/3nHzDxJ856sjypJjM7UZw2rr/1pXRw4GDcJh0/+F8mZuhThTEN+aGaek8MRxFI/y2JYty5q6TQhs2G4eozicPav0/p0DsIQ2a9ISoI87AC2L+U3ZR+bm84g0k/rULuypI3Cdbc09/Qmi3s42YOU7Jwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xowSX4BpRDO+s/uv94vaqO5xV4E/OGJGS6LC2mz0C0g=;
 b=GodoVUNNQhkTbT/bslyiB87TDm3xeVSOsXPmJTdcL/FJDQEi/07Sf9rWxpO86KbWoRMxQt6GbSTT8fKB9QvsLMhGJaTmAOSjRCNLDp0YZR9S2IyFN9STp0tgtlJ66cOVfWDdC7KRoZIwsjKulOk6IcHMAiDQtqFi6AYz7D7wIodM0wdSkgVB9dKhR5Sin9oi6WfmJdPIPyLvhLDgF4DA8cqiakSq593RkzFDahpbHD8N03bNnDqEJgF0nF5iUaMz0TNn9Ao8wS0Hoirg5CPxuc55aUMsB9HLvh8lXjo9i0vRHUqQb/LYJOKbyQ7EklCfyRDlQDeIui9jiK6AmxEOzQ==
Received: from MW4PR03CA0358.namprd03.prod.outlook.com (2603:10b6:303:dc::33)
 by BN3PR01MB1988.prod.exchangelabs.com (2a01:111:e400:7bbc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Mon, 11 Jul
 2022 14:54:41 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::e2) by MW4PR03CA0358.outlook.office365.com
 (2603:10b6:303:dc::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Mon, 11 Jul 2022 14:54:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15 via Frontend Transport; Mon, 11 Jul 2022 14:54:40 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 26BEscpt2996343;
        Mon, 11 Jul 2022 10:54:38 -0400
Subject: [PATCH for-next] RDMA/hfi1: Depend on !UML
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Mon, 11 Jul 2022 10:54:38 -0400
Message-ID: <165755127879.2996325.5668395672492732376.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d258ec73-abaf-4a83-d180-08da634d4847
X-MS-TrafficTypeDiagnostic: BN3PR01MB1988:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c0J+7Qom9+RjykgP2exdMFXEywX4WV8FelqnG+xXS1D7rpP1G8GQO/mX/vac70w1pK8Hbq2ckMUyHeAIYfD714U396vyGv9CKzo9EVmns+z/KDLBEymgv1f4EOU7eXT+r0T+k98Dsx3MDh5+H3mvQ9TA3HgPUxp6nHd4W1dwRvfizSB3p5UEFPmc5yWTWOPO/e6jptDtvnnqSmUOCGoy8kOFRRx0duBrDacXM33SyalP4QLYtWRLTCaMTgDSohuyH4wlbBpngUQRNdGBeAH+1vWjxJxEUXUVYroMhvpQSdoRpq76Sr/BrvpNSWb4E/FzulW7P5+MJ/HyIGHKlUL1JEsWDvxBNlvqDpFL7A2BW7eHkvjTudaA5tOjG7rFEwrzFEm+IHi38nxu+TS6iBs/GcbnFzxRrZIhDW2PSP2a44JC+/VcNTmCAMFn900dgO+y+bbSqcJAtGzBUIuVW3rak5ko3n+DCI+o9dfjQOw8Hq/kiUHYO4cmrw5NzsXoul0RP+zBBpl1T4VnoSHRV+gowt5MerE2sO4Tl7QdWgVV3FFhmKJh2C0APnY341blASzMY6srU9PDoD3XYI0hP8fYU3gFxw+KMeWJReiE5LS/MdbnFIIi0Xxfc154Tv9NDGaGjOiQfTLNuTeRuCj170RMDkHvuAfTxy1SswR0SNoHV6A78393BhsjY4xbdLIjV32JeUVgAPNyEqd83X1WMjWIWJx+lLAgFvdc71ZIjBpK2BhlkgYUaUb89dFI80RzBaC//3/7mMsN6UWG8nvvXvrrFsPaf9YNc/cCL13CSR2pBe/R/wiD72LAoF81qCHWiHeW
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39830400003)(346002)(396003)(376002)(36840700001)(46966006)(336012)(26005)(103116003)(186003)(70586007)(426003)(7696005)(7126003)(47076005)(2906002)(40480700001)(55016003)(356005)(86362001)(81166007)(82310400005)(478600001)(4744005)(36860700001)(44832011)(316002)(5660300002)(8936002)(4326008)(8676002)(41300700001)(70206006)(83380400001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 14:54:40.1081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d258ec73-abaf-4a83-d180-08da634d4847
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR01MB1988
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>

Both hfi1 and UML depend on x86_64, this can trigger build errors.
This driver must depends on !UML because it accesses x86_64
features that are not supported by UML.

Signed-off-by: Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/Kconfig b/drivers/infiniband/hw/hfi1/Kconfig
index 6eb739052121..14b92e12bf29 100644
--- a/drivers/infiniband/hw/hfi1/Kconfig
+++ b/drivers/infiniband/hw/hfi1/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config INFINIBAND_HFI1
 	tristate "Cornelis OPX Gen1 support"
-	depends on X86_64 && INFINIBAND_RDMAVT && I2C
+	depends on X86_64 && INFINIBAND_RDMAVT && I2C && !UML
 	select MMU_NOTIFIER
 	select CRC32
 	select I2C_ALGOBIT


