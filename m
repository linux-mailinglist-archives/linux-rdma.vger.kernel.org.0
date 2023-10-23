Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94A17D32BB
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 13:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbjJWLXK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Oct 2023 07:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbjJWLXD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Oct 2023 07:23:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30C2D6E;
        Mon, 23 Oct 2023 04:22:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7V58lLrTUOvtohS+GwXoKt02wmrnYdujZVtxrnCxbNKTqc4zceKv0S9vlfBsYPYIjV74E+DIOwxhVGNsv7lZ3424tfgigZ0HHMJpCc1ojmUi97/K7Aesgf4AAjGeom1sG6zdkJS7Tyv5hRGzQz/G9T5shRKfV5UgcAC9tPHCd5qf9QrwWefQCYXr+AbYR3sqHdBG9Ubu9LN877oZ1Hslcvkn6vsxSwtpv4on8T4TZnetHQjtrcqQUIlJWOCdvSl4yBFFls5/e0o7SI5gbZIOAeYiwSrbYKfqTxY9hnkSpcrtvo3I8mm5mj7y5kvB0yqdemswYAsD8e85gFlJ9stDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9c+wlIyjjSBKjSN4BGAK+jh1CNCSmYTfBY11bsOb3Cc=;
 b=gdu6ukU/p3J83qIYio5T1dhI0hEj5AzBKXK0/9r8ZNwuTB9RpPonm1v+MpBG1DOJ9xsH3PIm3sDqnjChXUylJiXSeWnhu/akOKyuT09ykJWHmMBdnrRHLgG9/ntX8akO4iv2uvam61SlaIQdLgep618ymMzvqM8E19A5CLypWo/VL4qC0BvFxlQqf7ZYyUbIo3Bo5XE+2PXnCphBmXxWTfjEodl7qHzRWF8WSVxnQDZcYTen7A76tX2g1kerZfJQ2wJuXWBjZ0FlKVGDnqa37qWJouYwonHM+UcCZKhoetgvIotMFpKacGujKpkRU2Tatqr5OJMAnDKD2k6l2bbKvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9c+wlIyjjSBKjSN4BGAK+jh1CNCSmYTfBY11bsOb3Cc=;
 b=EY25mp0FFWvSjyxlzFYZoArEVtTGSiCmNgcWR4w66DfEOP7iK2NKGhFDP3s9Gbq/7lGEEiyabeiVvKiiEnjNmYQyw2+sa8LrWQewJeYVpECYCcB8GdqHXggkcBIfJaQuSRFcUwVr8pXxgd/LNWrbahGpTcTg2+Ok/a2Tzc5JBut+mok0TZhluOGkLwCXt7eTM3LNa4JeCl8B0/jOynzs1hztjBomGPW+mNfVWDSTQXSDXPa6aQn0qoLDWIWwCUV9PuAOKLWCr2+2LoXdW7qal4cT8YyHIZfMmrdmOs5PqIa6Y04VSHvoJ7b0iyoUiwUrFJ/P6Hj3ry2zwnN6XhlnNg==
Received: from MN2PR04CA0036.namprd04.prod.outlook.com (2603:10b6:208:d4::49)
 by CH2PR12MB4956.namprd12.prod.outlook.com (2603:10b6:610:69::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 11:22:55 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:d4:cafe::25) by MN2PR04CA0036.outlook.office365.com
 (2603:10b6:208:d4::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 11:22:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Mon, 23 Oct 2023 11:22:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 23 Oct
 2023 04:22:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 23 Oct 2023 04:22:39 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 23 Oct 2023 04:22:37 -0700
From:   Patrisious Haddad <phaddad@nvidia.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
        <stephen@networkplumber.org>
CC:     Patrisious Haddad <phaddad@nvidia.com>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
        <michaelgur@nvidia.com>
Subject: [PATCH v2 iproute2-next 3/3] rdma: Adjust man page for rdma system set privileged_qkey command
Date:   Mon, 23 Oct 2023 14:22:17 +0300
Message-ID: <20231023112217.3439-4-phaddad@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20231023112217.3439-1-phaddad@nvidia.com>
References: <20231023112217.3439-1-phaddad@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|CH2PR12MB4956:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e0ba71c-1c44-41cf-abe7-08dbd3ba6767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gFEwYsvHeKBHlQfaiGYDUAo5iQdjPFWTNmElupRZjbcUxeJJ6G5UL7Xr4njqWwoImrFHwVTWb000ZusDGRA86vDyE9Tl6PAON3cE/+f4miL+tDLAd9Zfx8eE/PGiZs1U6fjHi/8U3ue9mXMUhEG+gX+89DivRxEpsDOOGJStMmL3IhzlII8l0yqfBtNWxzIXQUQRtIivOsI7oMp2+/ZuWojkBNtyexIz3h2Ug2ne6KXW/93uET77gvt1OsHQ8NMBPyxE6n9GbqNydVyzZS1rkO5bR/oj21VRiTAfVFeZZRpbx2jwrxuajh/piVl3V76a+ps74fLGZgFWDKEXuphVnxZVhx4T0+Ffn5rzU9usAHvt8lFt/fmAMgQWxs61dl368J13uDYwG4Quc8wGjI0GoPQ/j58kvcsMBojolY52WqUYB0aWBYquiuPmph7u9lIqmPcopagDOVO/qpgvUKo+W6ftok/X6S+mak6CC0WG99WOntLJscdpHqZtdoFC/BHznjfjERWYqb+YlAoJqxzF4L5gU14LDe2fEJCOg75gnQvwopd6/JTdRrYhOmUT1kDtrpK2FCrOHSaq5t3lVsk1B2SG8sRFpHfW31rm3k0saTEpb9RbK7O+KzyOK5ZI/vpYIoVv6CanOXFuyodWx3T+PpdtZe82F0lQj2WaKKS1EQ7EQgWT9/pHT6R4O/UiHqKImVaEOPCPuPLa6nPTlTCAZk76sDwBBaP2U6qQ7Mhd94Bat+NpUxz2MEGifB1GC09l
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(1800799009)(451199024)(82310400011)(186009)(64100799003)(36840700001)(40470700004)(46966006)(36860700001)(2906002)(41300700001)(316002)(70206006)(82740400003)(54906003)(70586007)(2616005)(1076003)(110136005)(7636003)(107886003)(6666004)(7696005)(478600001)(356005)(40480700001)(47076005)(426003)(336012)(83380400001)(40460700003)(36756003)(86362001)(5660300002)(4326008)(8936002)(8676002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 11:22:55.3407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0ba71c-1c44-41cf-abe7-08dbd3ba6767
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4956
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
---
 man/man8/rdma-system.8 | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/man/man8/rdma-system.8 b/man/man8/rdma-system.8
index ab1d89fd..a2914eb8 100644
--- a/man/man8/rdma-system.8
+++ b/man/man8/rdma-system.8
@@ -23,16 +23,16 @@ rdma-system \- RDMA subsystem configuration
 
 .ti -8
 .B rdma system set
-.BR netns
-.BR NEWMODE
+.BR netns/privileged_qkey
+.BR NEWMODE/NEWSTATE
 
 .ti -8
 .B rdma system help
 
 .SH "DESCRIPTION"
-.SS rdma system set - set RDMA subsystem network namespace mode
+.SS rdma system set - set RDMA subsystem network namespace mode or privileged qkey mode
 
-.SS rdma system show - display RDMA subsystem network namespace mode
+.SS rdma system show - display RDMA subsystem network namespace mode and privileged qkey state
 
 .PP
 .I "NEWMODE"
@@ -49,12 +49,21 @@ network namespaces is not needed, shared mode can be used.
 
 It is preferred to not change the subsystem mode when there is active
 RDMA traffic running, even though it is supported.
+.PP
+.I "NEWSTATE"
+- specifies the new state of the privileged_qkey parameter. Either enabled or disabled.
+Whereas this decides whether a non-privileged user is allowed to specify a controlled
+QKEY or not, since such QKEYS are considered privileged.
+
+When this parameter is enabled, non-privileged users will be allowed to
+specify a controlled QKEY.
 
 .SH "EXAMPLES"
 .PP
 rdma system show
 .RS 4
-Shows the state of RDMA subsystem network namespace mode on the system.
+Shows the state of RDMA subsystem network namespace mode on the system and
+the state of privileged qkey parameter.
 .RE
 .PP
 rdma system set netns exclusive
@@ -69,6 +78,19 @@ Sets the RDMA subsystem in network namespace shared mode. In this mode RDMA devi
 are shared among network namespaces.
 .RE
 .PP
+.PP
+rdma system set privileged_qkey enabled
+.RS 4
+Sets the privileged_qkey parameter to enabled. In this state non-privileged user
+is allowed to specify a controlled QKEY.
+.RE
+.PP
+rdma system set privileged_qkey disabled
+.RS 4
+Sets the privileged_qkey parameter to disabled. In this state non-privileged user
+is *not* allowed to specify a controlled QKEY.
+.RE
+.PP
 
 .SH SEE ALSO
 .BR rdma (8),
-- 
2.18.1

