Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9387CF257
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Oct 2023 10:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjJSIWE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Oct 2023 04:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjJSIWD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Oct 2023 04:22:03 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241B210F;
        Thu, 19 Oct 2023 01:22:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOVRVijlUdLF/CwmXCtFswG0H/iopeztK6OVmwvx8EZP9ZEUZ1TWPDwqJhWu2NlcWfKLcedJI/psrIQbfFCOkaGzVbTEVWunC3sNMZpasJrOoMWhVobjJgnuFNhWi7Wm+lI+A6gRdXuEJPPubCJ2wORtMnQInxTI/+nWVyRsqKtIc6v5NC42eC555WxY8Zo2VNB8UTZHoilw9/V5GcFhWNiaZCOw5AatVH2CqZYp8XZxU5U/7SchjCOR0lpTcpe3WFQIEevm955TCX1BN1X99i1ARWYapHIAW3mpoWrLzudozJDdZDEu1Ii7x6TCVfIAp/lmVRQliuy6M9fIEB+MDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AdJIbffa/C+UCtx2rDWrPWIiq32Ep3/j507QlCH0Yw=;
 b=meGejmB5HnsUpM030y7G8mgJIoSHY+fKsZtPTefpJ2Qbp3996HsvwiYg1dWdGW+3OefPKTW43fPFdfWO7O8R+ocxVS/63ZU997U6+Eni8TFA+exZLxbOawmi7CVimToxJCf/e4TbPJAQUYMumfjUuyTnBc5pQ1tyxfdzly0briTjDsbYR/84LGQO0dXKIw7D/Wh5tjdyguq8t2GQlDAj5swpLgWL2eOuG8CliaHmW8MaeduQibtl9R5dltKqzz5rKpB3J4Qr0LvkEcQ+/cPM9H9G/7pSQU81OW5UvBvg61eD4Qos2/vl29ZSBEyGD8iIRidjP8fNvVXs9Qz8wPkMvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AdJIbffa/C+UCtx2rDWrPWIiq32Ep3/j507QlCH0Yw=;
 b=U6CGFBDCN8m+ppBjXUh4lg6HkuBcDr3/AI47GC8/nWbzR0/vfqjfrzA0HDYUObF+W5Li9iRxUNVkomDh+jZzNh70Nt94sPMniX7elXi89XOOhVzFJ2wGmiizwl32x5pw6CUiRosSu/JRezQqyrI+wARLLRlDJKK1hT/A7PtA5bnUCXVuUXKLDXAz8ly0f48O9ss3rooEN/c9GGc1jmgaRdNpZpSWQ7swl+uQErvojf3LYjfkVHZ8HH2KgQlV9MXWR4xBzOn8egK90BnP+wTatWUfJzmL0NL3JbU2GKAOPAgJyfTDD8y8vKXJ5Ls3Skp633hGGZJiDZbhFpc+G2daHQ==
Received: from BL0PR0102CA0061.prod.exchangelabs.com (2603:10b6:208:25::38) by
 DS7PR12MB8291.namprd12.prod.outlook.com (2603:10b6:8:e6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.26; Thu, 19 Oct 2023 08:21:59 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:25:cafe::7c) by BL0PR0102CA0061.outlook.office365.com
 (2603:10b6:208:25::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25 via Frontend
 Transport; Thu, 19 Oct 2023 08:21:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 08:21:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 19 Oct
 2023 01:21:45 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 19 Oct 2023 01:21:44 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Thu, 19 Oct 2023 01:21:41 -0700
From:   Patrisious Haddad <phaddad@nvidia.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
        <stephen@networkplumber.org>
CC:     Patrisious Haddad <phaddad@nvidia.com>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
        <michaelgur@nvidia.com>
Subject: [PATCH iproute2-next 0/3] Add support to set privileged qkey parameter
Date:   Thu, 19 Oct 2023 11:21:35 +0300
Message-ID: <20231019082138.18889-1-phaddad@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DS7PR12MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: 0baf44fe-2266-4f43-7a3f-08dbd07c76c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oV2WQfxQvE2akGjYoMYpqkmnptITXXYI6uwrAqN3GpyTRjjrC5kGvXwuXrVsv01Yh0yqhFsrIq4GGvU9xvFGMTMswE9GUD9bst7y1Vbwk3HsFH+Ct88xfeu4mI/BJQfUK3nNdrkW8N+WkydUM5+UUMSF8FfBVOmJ0J1mPu7Xm+0F/9A92miZcI8m1bk5xdBOVLppLqiDii9GE0nltckg346hvuz7NkGlo74DJXszB1lzg1Rj7otry5y6VkwZiWPYbwY8AZHuTmgmk4XWJnZQSgdcj6pYJHsikniKzV/ORcAxaOpHzwkXEH2+uECm5yThoTuy2Pglvcl4Y0oROQINmHNQ45kB+hQOS5nbacvPa2a279MRwajnTV635ia5ebq655X6eR9SXJBST+Pa87a0euPtDQcgT3A5aMtiv25KZ7umZ9X/8kNHVxzTSoGpJrH2TXBXw0p+u4OSpSm4bw1hNjGNQhoyDv/tZLWs+QILTqzBFfkgiTqZrvaBU7ruYTUXztocRtGc6BsKw0cQCB+2fHjKEEB8f9f2gVUeeATqXl6ZRhdueuK1bvIHbHl2rGizQthrWyQC2EJZNQHfy62ggp0txfmb4BCuImixCHwF0t4q0OcedtBpB54CFrjUETAvX9Z6emM1aKEGt5J8eYFgF7IJcHPkRdNP4nmVGAKqJWdeo2TEuNECMuylkKaIhaLR7OAn6FkeblusnYrKefj4Qw05AIEe9/l4TmLl3dMf/z+rYko8HGpcPgSm+wCuLzQH
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(70586007)(70206006)(110136005)(54906003)(316002)(6666004)(478600001)(8936002)(8676002)(5660300002)(36756003)(41300700001)(4326008)(4744005)(2906002)(86362001)(7696005)(47076005)(36860700001)(107886003)(2616005)(1076003)(83380400001)(7636003)(26005)(356005)(426003)(336012)(82740400003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 08:21:58.8357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0baf44fe-2266-4f43-7a3f-08dbd07c76c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8291
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patchset adds support to enable or disable privileged QKEY.
When enabled, non-privileged users will be allowed to specify a controlled QKEY.
The corresponding kernel commit is 36ce80759f8c
("RDMA/core: Add support to set privileged qkey parameter")

All the information regarding the added parameter and its usage are included
in the commits below and the edited man page.

Patrisious Haddad (3):
  rdma: update uapi headers
  rdma: Add an option to set privileged QKEY parameter
  rdma: Adjust man page for rdma system set privileged_qkey command

 man/man8/rdma-system.8                | 32 +++++++++++---
 rdma/include/uapi/rdma/rdma_netlink.h |  6 +++
 rdma/sys.c                            | 64 ++++++++++++++++++++++++++-
 rdma/utils.c                          |  1 +
 4 files changed, 96 insertions(+), 7 deletions(-)

-- 
2.18.1

