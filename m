Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301817D6BBE
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 14:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjJYMcF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 08:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbjJYMcD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 08:32:03 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02C2D56;
        Wed, 25 Oct 2023 05:31:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DD8nhEgQzPIWEP4HHqIXCYflQRkvHydxW0/rqZOH15iIRd97w4XVkx0SyyELnLIIW5fJwO52mPH/xEOQiFhB8MN0fotE98gkxEGMZ/jwFsnGsCuIEdhZQ9fVQsZuCXnj12uc+EPmFgRxYw0TA/uAxPdTU46O2IJmqM70MeE+AqNkUs/ALWW/89YJ8wHk/OL15m7+Z+P7IjSl9orREBhYhuClCHzErRtzC5WTVkr0Iv9uFgKBx6EBLJ//EpmcLX/T82VvW5kdui8d00g1dp107gQDGBcEFeQ2FZyX8XU6KXgeATg9smPAV1tLZPoxD48+6OAHO0qGeOcJSIgGAi+LAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbxp6D/DKnZ0Oew9TOM+2l9VjiIXoaDDWmFTIFBmeLY=;
 b=LAJtAI1qeb63E1nN4Zn7HtW1KHmfaTaNbPc2Zs76sZ+qZ8Kk4C7CdAf/IYrH1ZtTZ3m/tF+oc21mBsGubx328XT+xhMP0z3VPQjbI7y+3YdCkp0Hcw349MHcgLsPmDwXR7aLkFWvoC2aqSHaK4wy7J/G/t7wuxaYAC7mxOEHW6MRpZCIdSfuryAI/NwOMZHfnblEpTpRSD8E7F9HKAE1tPOs6Enzs+TexYH4hBFBqTiOwhvua/8Ld+6SauYBRrb8C9slc0lrIu5mzcCnG0YqPL0+2BZKAs9Ik4ZEF0hdY7r9oZHTyuAeWEz/kT/jERFMsqZQI1jc8Hcu8rsWoWC+Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbxp6D/DKnZ0Oew9TOM+2l9VjiIXoaDDWmFTIFBmeLY=;
 b=qQn6nVd56U1d7wtuUO99jHRY/iM8EsslN4jichA9wThEKxH7bb8qMZu4K0zEpp8Kh8FUso8dYP68cIFGg67ww83SIqIfI/FDh/lG1+HdofxROaXuoSZpnM4/iN/holGtz2drOOdW5QoNsplnlBhM5fKKASpEhR8RKXhjqrINi97uvZ8nQjNmLDaG7yHXcfc7ht5/c9ZXJ2CFsdc9u4iWpunNdsdECpqw8VnBcdTcebdEpx4g32U6gsFR8I8OxHSEh+o5MUGJeZ8WlVsFDDbC3b8T3qu4//Z0xfLqDl3ojt994cOaHmlM3F5fWJmkUnqiDHf366x50V4rnXWMxbaitA==
Received: from PA7P264CA0112.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34c::15)
 by SA0PR12MB4573.namprd12.prod.outlook.com (2603:10b6:806:9c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 12:31:50 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10a6:102:34c:cafe::45) by PA7P264CA0112.outlook.office365.com
 (2603:10a6:102:34c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Wed, 25 Oct 2023 12:31:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 12:31:49 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 05:31:20 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 25 Oct 2023 05:31:19 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 25 Oct 2023 05:31:16 -0700
From:   Patrisious Haddad <phaddad@nvidia.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
        <stephen@networkplumber.org>
CC:     Patrisious Haddad <phaddad@nvidia.com>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
        <michaelgur@nvidia.com>
Subject: [PATCH v3 iproute2-next 3/3] rdma: Adjust man page for rdma system set privileged-qkey command
Date:   Wed, 25 Oct 2023 15:31:02 +0300
Message-ID: <20231025123102.27784-4-phaddad@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20231025123102.27784-1-phaddad@nvidia.com>
References: <20231025123102.27784-1-phaddad@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|SA0PR12MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: 12906306-f095-411d-b081-08dbd5565c4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r2m1yphTw8UwqM+/N/M6EwM2motpHbTKndaaTNd/7eQOqXDekC2mJ4GLnJ1dqF3xEcwGlYnKm3zQhcNnrrU5NitpmoVqw8sB+1oyq2LTrEHSngCHUHaVXuxB8eKqirQZpbSpk4R1yWwGMulG9qvdW4KD88EV4H4WLr0XGoqKOO+mRt/OYjA3TdfURK9nTtOePTdEWG1e9VdAkd+CQOkRhWqmcDMAMWW46CH46FCuZ3CAGlRwXc9ovFt+ZB0PdFGQ9C+5xqCkERfn6EYOtHK2A9CWAO4L/24XrSBhzMsQt9hmIzOeg9zYmoKix/trsQ8Ljd3DbHDsN00GtrnO5NMBAqwgy1k6hdYsp3IuPQQqozq3krdWnKdylLeWWObUEGeZTpsSzU1AUrZJJSiTIrWMyABNAUAti3vpJ79K36wDV5x35UKMJX5RE0Hc8yNpdh1Bm/ndKv1LJYwpzeZ1fO3UPEZcp9cUkynaF59AarDX62aoj6KLgYIR/fKQLqbE+gQftvwW47+3oOtF8hE4xcuqcQIVEjvOtYAqI5whWxCfpjOOzZhp5vZxPgid5rXnCGp+L4ROKRENiFQvbk+pI17Q+LbQXDliyahrUIECi8oQ6ggV7Cp9QhR6xTYPhHw+xnmaFBgaPKhRIFgQxAZxiK8PIZz/hluzrQt757CXGGWjIBOiqeMWD80PIRJWhw8lR33GsKlo66gHiishbtEzwLy5RrS9qkzfARQm8VcC1O3vorfjGdmBsx0RnZS/j1HmATGq
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(40470700004)(46966006)(36840700001)(7696005)(36860700001)(40480700001)(5660300002)(6666004)(2906002)(40460700003)(26005)(426003)(1076003)(83380400001)(336012)(41300700001)(107886003)(36756003)(2616005)(82740400003)(356005)(7636003)(47076005)(86362001)(478600001)(110136005)(54906003)(70586007)(316002)(70206006)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 12:31:49.3172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12906306-f095-411d-b081-08dbd5565c4a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4573
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
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 man/man8/rdma-system.8 | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/man/man8/rdma-system.8 b/man/man8/rdma-system.8
index ab1d89fd..554938eb 100644
--- a/man/man8/rdma-system.8
+++ b/man/man8/rdma-system.8
@@ -26,13 +26,20 @@ rdma-system \- RDMA subsystem configuration
 .BR netns
 .BR NEWMODE
 
+.ti -8
+.B rdma system set
+.BR privileged-qkey
+.BR NEWSTATE
+
 .ti -8
 .B rdma system help
 
 .SH "DESCRIPTION"
-.SS rdma system set - set RDMA subsystem network namespace mode
+.SS rdma system set - set RDMA subsystem network namespace mode or
+privileged qkey mode
 
-.SS rdma system show - display RDMA subsystem network namespace mode
+.SS rdma system show - display RDMA subsystem network namespace mode and
+privileged qkey state
 
 .PP
 .I "NEWMODE"
@@ -49,12 +56,18 @@ network namespaces is not needed, shared mode can be used.
 
 It is preferred to not change the subsystem mode when there is active
 RDMA traffic running, even though it is supported.
+.PP
+.I "NEWSTATE"
+- Specifies the new state of the privileged-qkey parameter, either on or off.
+This parameter determines whether a non-privileged user is allowed to specify a
+controlled QKEY or not.
 
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
@@ -69,6 +82,19 @@ Sets the RDMA subsystem in network namespace shared mode. In this mode RDMA devi
 are shared among network namespaces.
 .RE
 .PP
+.PP
+rdma system set privileged-qkey on
+.RS 4
+Sets the privileged-qkey parameter to on. In this state non-privileged user
+is allowed to specify a controlled QKEY.
+.RE
+.PP
+rdma system set privileged-qkey off
+.RS 4
+Sets the privileged-qkey parameter to off. In this state non-privileged user
+is *not* allowed to specify a controlled QKEY.
+.RE
+.PP
 
 .SH SEE ALSO
 .BR rdma (8),
-- 
2.18.1

