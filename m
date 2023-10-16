Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482037C9F8E
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Oct 2023 08:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjJPGbx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Oct 2023 02:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjJPGbp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Oct 2023 02:31:45 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2144FEB;
        Sun, 15 Oct 2023 23:31:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0zIhA57jANWRzoyNYW8cKQcv+PEz8bYclempi+VoRVCDDJM1xKObDvOR3xv1mqyvqQCCG/uP9wm+KmHKI2x43N5Yq/Z2DApvLuhq61hAnft7gyiu+SZ/aQk25vUmGMxNnhDIasBPL0ZJ/AfbEUlJiJXOL0nIxNltymHoSeAX09PuXRc3z4Gbv0Lp6gRAhqcYn5p3oTLpaNFG2GK2LPDl6Mov53BfHKvoum1LXbejqAPGHOg2qfE70+opmOvAzZvPqdcnJvgm5cEV1HY8vl+gwbCaR9ILGmqKVyTV+X42RDCLUymAiIZLLbh9jqump+rp7wqgst8PEqIbxP0AZFeGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9c+wlIyjjSBKjSN4BGAK+jh1CNCSmYTfBY11bsOb3Cc=;
 b=m6DnQ28nDdchi+A1JecKClxB612R02mjm35KTrJw9aVr7N5woJH+xZYvz738TSCefUulgE2hbnwAXRzEXFj9QdsiuC/kVgh1g3UTD8Osj19cbJwWZF1nO8wxO9+zETZAwTzTcFDwrcAdV3LMo7Y8BUY/Aylch8m+5i/wjP0nmvBVvNBDcUIaEsWYofA5Xxp9Ph5KXRUVmhhlMhdaCRW1I9Sxj/IJVwL2kz8L7KgT/l0abSGDEzQ7qIVNkeiXmvhgcyqjTpoMCQF5S/oWCu8iSchd1fewykagMR8YfiBhGMni4PL9fCqJ8GNklqJiYQ3Om9at3Fe0QDaFyD5EL4PIaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9c+wlIyjjSBKjSN4BGAK+jh1CNCSmYTfBY11bsOb3Cc=;
 b=pTOUtuvQAJTNsKCYlwTWq/2ZnH5sHNNbyUO43XZ6c4uzZL03nWkWNpbW6UDeTs3hac+mjfA8O5iWQ50oBpUyV9RyObnFf+zuV3iAGmrbSrHzOW2UnRlHtq5HOo0aOepLyxDosguEw06OiysLOUZU+4/NvTXaa+xlbEuBLImCYuNIdaZxm9I3/OoiXQCU1oj0LSisWl5+ZGqst6RjpGz4iN+jKMIqlQlHqDscEBne+sIf+ViENf8x7ZjLaqGEdoQjWS/oFWozgpuYPB+NtELeusUyAzgOdpLCBmL2oGCUTsUHnBT3mXyrr+W6FssDmL9TNO4vQ5tIFimZmgh/nmGyIA==
Received: from BYAPR08CA0023.namprd08.prod.outlook.com (2603:10b6:a03:100::36)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 06:31:41 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:100:cafe::99) by BYAPR08CA0023.outlook.office365.com
 (2603:10b6:a03:100::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 06:31:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 06:31:41 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 15 Oct
 2023 23:31:22 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 15 Oct
 2023 23:31:22 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Sun, 15 Oct
 2023 23:31:19 -0700
From:   Patrisious Haddad <phaddad@nvidia.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
        <stephen@networkplumber.org>
CC:     Patrisious Haddad <phaddad@nvidia.com>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
        <michaelgur@nvidia.com>
Subject: [RFC iproute2-next 3/3] rdma: Adjust man page for rdma system set privileged_qkey command
Date:   Mon, 16 Oct 2023 09:31:03 +0300
Message-ID: <20231016063103.19872-4-phaddad@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20231016063103.19872-1-phaddad@nvidia.com>
References: <20231016063103.19872-1-phaddad@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: d06a0987-a77c-40cb-9283-08dbce118f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kkWfKAC1bxe7qe+qWCYVKcoTEeNM8I9hzCR9ZKcv6s91VNTDEEFefXeqGWqwXxvsWNVIxgkzkEwfDmVdc7YE63XUN4rkAXI0dDF6kYqk1N/vNdyrPPnlr7ACVH/LoEiZxe9Qr0YhQkf8+p7KRMb8hHiCqMEolYWarvM9y7fjXLJeE+J2APkBa4olqsiN5qyEuHkwzLQ4smOuSkwk9sTftVq/SAE1WzvImLSJZX9Qyg4ZvKKrlFUV1xXGPvsl0KNyB9uEl7F6Cy80MojIWeDgf0o5lYmW7oScVxbyOj+bP60tAJdZbp95N2MMQ38RoDo8MCQOcXWuli7HF5r5T4dmhTKr6lvE/stsEsc2SIT4rOug4+KNOdB0HZSR/+64tj8TIA+HwNBPZxNUkqIkjGpKSevCxfdoI/XTbJKVi+O3Y18ABMgHZM3zQuWPJI/Jml3p23mxCQGZ09GPJsA8nzs+hNI4Kl7fnaQ13//rSgeWvDk5dLs5l3rqUfkslC1DOO0atr/942arEm4NPQrl8LwaJcs4sXKGbSt0uKpGv2OJEKmsF4Sd4hFH/0SVR5fXTQJcxtXZh0+rqslSOmt25h1PdXswXyeDBI6I/o6GXt+92pnc94JuzG2wAXZ9bWczaJ2eKTwHHjzzwgnot7v3FdHVBSvd67jdcf6lCOi354rSdsX9K2EBR4ixhfYlLOb2xwbMfxE7pajyyPa2yah+35Us//ziju42nhDpesKChaF21QtIBV97OtSsuvwzOrX+MmKv
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(82740400003)(36756003)(7636003)(356005)(36860700001)(47076005)(83380400001)(26005)(6666004)(7696005)(70586007)(70206006)(54906003)(478600001)(316002)(336012)(1076003)(107886003)(2616005)(426003)(110136005)(2906002)(41300700001)(86362001)(5660300002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 06:31:41.1251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d06a0987-a77c-40cb-9283-08dbce118f0a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
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

