Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052C37CF262
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Oct 2023 10:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344890AbjJSIWS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Oct 2023 04:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbjJSIWQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Oct 2023 04:22:16 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C4F13D;
        Thu, 19 Oct 2023 01:22:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeP46Y6/mBi87lHCNZKVZVKOq/th7Ju+sSLEqOBZjUSD6J+Gn/fr+4u8Jk6fJS2zQjIFYUIuJhyqyq1H3jGzl5gOpB/4zknMvDL7PlYxIraIhHrgEkzSyNsHxT5k0f8qZYJnRr9p5KTvpdNdfpPnuHSZsIjz3hzQ6rFI7ArAmAA+yORPn8k+PyuTn4RQrfKSf2Ao0FxvVFgANYchHMBe5YPB7uf+b82X1AakLsSZWwAr3iJH/RIEbBeAi/vYzHHAc+TJRn/lrT3yfvd7lMDHsnjvEFAHUG9rqrQvnQVkRUC0R8vcuG4tHF02zSuyW/p9DDa2MSOW7vbZKKuUJnbWTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9c+wlIyjjSBKjSN4BGAK+jh1CNCSmYTfBY11bsOb3Cc=;
 b=XcH8ZDGwSM9nWchcZrzEAdgRyPx0XCPaeo4yfO/OdwtY0hs5okc4WP+WKCbRqTrg+n/xqvSs8azgqyB/9Qh9rydV85Q0LPypMiW6P4CslCZx3TwTEWrZPhdDPN5X4ss9E5GvEfe1kjKGT6OOxjfoS6fRdCHda5kIpvuGcdDMi0fJiYyBosBnBxTZFpD3ByebtfH4BqhWsUmvQTGogBIeO8GAA9q677v+D7b3+WKbyDMciH1kgmdIe/YF5VU9nikZ7DwQyRNKizfMWKiSGhmug+KtYHIEigZ0eWPH9oTbUkK6pW8ImJ602hk3Tc7wsmIdwZj52HE6ItzqxGJy0PQ4xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9c+wlIyjjSBKjSN4BGAK+jh1CNCSmYTfBY11bsOb3Cc=;
 b=sCzFjDp0rPs2RQv6VdIw02O+wpSCvgAxFRoX8y1q1xHTqZyZJ6zLarwP9gZfXlv6Ii0GmlhPQvhvI3LKTeqrmcIbBWx40hJRFdd/F/TX7aXrO298HzqOR+Yg3M3EfgR0piBywz7bbjaPuJH+T8yn8hveLz+3Xfqz/QwjaEhQTHtWwLdnHYN17CdE4fN87iYd1imrQGUFKwhFIcCJEH4tUU8Ur2Ru3TbRbHS7OYUhhhqfxny00RAuxNChJELu3vOw3BoLkRIgow2oQzYLfM883ug84YOwJrmucz4cvYq7YdtujwrYmZXSI+sgZnUqIBdrx3PeJKChR/0mHEudwXX1Lg==
Received: from BL1P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::30)
 by IA1PR12MB8408.namprd12.prod.outlook.com (2603:10b6:208:3db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Thu, 19 Oct
 2023 08:22:12 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::f1) by BL1P222CA0025.outlook.office365.com
 (2603:10b6:208:2c7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25 via Frontend
 Transport; Thu, 19 Oct 2023 08:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 08:22:12 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 19 Oct
 2023 01:21:59 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 19 Oct 2023 01:21:58 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Thu, 19 Oct 2023 01:21:56 -0700
From:   Patrisious Haddad <phaddad@nvidia.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
        <stephen@networkplumber.org>
CC:     Patrisious Haddad <phaddad@nvidia.com>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
        <michaelgur@nvidia.com>
Subject: [PATCH iproute2-next 3/3] rdma: Adjust man page for rdma system set privileged_qkey command
Date:   Thu, 19 Oct 2023 11:21:38 +0300
Message-ID: <20231019082138.18889-4-phaddad@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20231019082138.18889-1-phaddad@nvidia.com>
References: <20231019082138.18889-1-phaddad@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|IA1PR12MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 10fa9d37-4c92-44db-6445-08dbd07c7efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VTm5lnvXUTIx532CrK7oBKy2t4cirUdvEE9piliFY2F2SGi8H8RBcVOAOvbgCFEV1pgnCqhH5HxtcHq0iNj/22pndqNSiaa0o/w3l3T0PTNuJsD9NCwwnjFIcYkIaZT1n80kI35hbcdmk5Bd+vY+ROTJb4OeFoyYN/XFv1Hpj/ehZQjkXZgamd49rV3Eog07djBv2da4KpuQxjVC0/pPi+pj8eQxaLGGpGfG4vjvdKNK4i2TbqD/Ewx6F+Xp0PQ6VSHP78K5liSg2O4VTSk0QjQVIm4vDX+MUKoqTxyCQh8+Bm7RL5JbJ41isTPDzKoaVDDyKqrESdF6c3m+/kRWsXqEe3J+6jw3qxqMqMc8XIGH85o8p9CJt07XmAbnIoPmHIq8ihc3L/gZ70jUt9oKRjB3nNjA29rom79H2sWuGm3JLiny2or959Oil01D8+Lu4dFmv0JoMg/Q3rCbpIR0VmXWH6x52p26Kfwjmn/rYOOvYq9Z/qx64P0hGvR7snv4SfLCOo3rDe00NEQ+ZkiSPJ3CkLcv6B9y2gy+n4Y7gQYLeso7+Svl0r0SWzkWleoSJixwUIIL+kX+AzBi4u/E7p848xomROlLbTVsiOSoR5w2N4ykUlqo5GygXlhSsXWpFBdQFSFGhAgBWR9LSwo4JFtELISFIbiParilG9lnvtJ9Wki2qbkrEyfOK37IFo57Opbk6AMUlwfOBYV2BJxKgiNBi+rjRqUeshYxR/kq7XcKsO9EwlIoUMp4KTrigpPG
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799009)(46966006)(40470700004)(36840700001)(40460700003)(47076005)(36860700001)(40480700001)(6666004)(7696005)(41300700001)(2906002)(2616005)(1076003)(336012)(26005)(7636003)(107886003)(356005)(36756003)(426003)(316002)(4326008)(70586007)(8936002)(110136005)(54906003)(70206006)(5660300002)(86362001)(8676002)(478600001)(82740400003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 08:22:12.5952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10fa9d37-4c92-44db-6445-08dbd07c7efb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8408
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

