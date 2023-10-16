Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE71F7C9F84
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Oct 2023 08:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjJPGb1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Oct 2023 02:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJPGb0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Oct 2023 02:31:26 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2503B97;
        Sun, 15 Oct 2023 23:31:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NR6eRMSqoOPra9h2uOPCk/3JiNpZg67UClons0kToOAskMvl/08wKVUQzqwEOuvcyz/zgTgulRiibwPgWsdc07LciDDWNx5zr5KAIdOFZZfim1DukGQ+yhNMCb4Rdi0DyIFvWZ/l8cWW1KKlaRVymhsvs1Bg52QKbc5+hlN85IRTLESYwVo12XvLXBK9OBAGu2aRGG09YzBUNCt+Yv/P484YEo3r6WPqtjc2IIrv+7yMHvGj7LST11hN/yfEt5w62IXfw8bcgMLFVTLWHFRV0ExddraOBcHtLz1J72xCQ5GK32+HSyQiuVhfboBKb8c9RvLWR5SRLFzjLRuwylRBwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+pek2iuI+a3PC7Fuga8Jy4wSiFxgtbzMJGiKDQLMcM=;
 b=HKsfmsDloUb3MGvdnusjXky4dn0oq/4cz3SFUSy1SOvpznrgzJ3tS0gXj+XyOg0QHKDfIX2Fnlr+fanzv2AQy2696fqB65NlEcRkjSDa88uR9zQo0CAAL8RKRwbK5gS7Np6/w7KD6KkDbtK08hITMHi3H0duFf9EYCnIMB6Oh1gl7qmJrK6b09SXKZnvNUEOOljMZLyO/C8HRcQ3dt03OwMY1WwseWe6VL8gBjoY/dRE2LdQB3xvBx6VaUpOhOjldhs8s/6xB+/tMYVrmNdO8dMDOdy55Uc1YATY+r9M/QNZAMi2mwVC7KAbg1KspS0gbCN2KN9hCo08+Th6ysILow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+pek2iuI+a3PC7Fuga8Jy4wSiFxgtbzMJGiKDQLMcM=;
 b=YhqEC+eNjaOq6npF5VSpUAsoDq3x69U4ELePywrJPmCrgDYqs2jx8NX+iFnR4aTtGkZ0CbbKWS24rS6mGfZAvRTNGHq1Q6RCGplqw6hYV+n8OTCLCT3IS6B6oHBXg8UIJUXys5wT2u5FOkDEQ965lpadEqtUlOC566cFfIjBUIgcb9EBOe922zhd8/coQDHbDRLPcA/7svXL1MjfFil5R4hTAkmO5L1FfOM7/0Uxy/llQ9n3v1nNf8oWeKjpmMU3HfnSUV5D5qBV2XaND4teolj9PpZu/bibaIQ2bKVCEJ2ce58lmp6oHQ1sObV0BTyQplG0WU93QO81TENynm2PMA==
Received: from CH2PR05CA0009.namprd05.prod.outlook.com (2603:10b6:610::22) by
 MN2PR12MB4391.namprd12.prod.outlook.com (2603:10b6:208:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 06:31:20 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:610:0:cafe::9a) by CH2PR05CA0009.outlook.office365.com
 (2603:10b6:610::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.18 via Frontend
 Transport; Mon, 16 Oct 2023 06:31:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 06:31:19 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 15 Oct
 2023 23:31:11 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 15 Oct
 2023 23:31:11 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Sun, 15 Oct
 2023 23:31:08 -0700
From:   Patrisious Haddad <phaddad@nvidia.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
        <stephen@networkplumber.org>
CC:     Patrisious Haddad <phaddad@nvidia.com>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
        <michaelgur@nvidia.com>
Subject: [RFC iproute2-next 0/3] Add support to set privileged qkey parameter
Date:   Mon, 16 Oct 2023 09:31:00 +0300
Message-ID: <20231016063103.19872-1-phaddad@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|MN2PR12MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: f78836e1-a9ab-4a69-afdf-08dbce11826a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUF/ja04CpdwuWWmi2EBSpqhc5I8wXL4FG08gm2SDd/sdrJXgIEmgo1zdurOHrdV+8znldKxgMBKZ2HHqawt/MGGosE7EXQXj3wxhazJsza00vW6agKvp+fAVJpHjUqw4Mrd2tI/hP8MV2vn5V6XlqHF/vfEvTYsAj8Tx2SAIuxIIBnk69O2Rp9GSnzpUzr3yLTnPoTIaWrjNaPfGLy5788Q3p2Z2cQKWmhsxFgzP5k4BZYgxAL5t8jsLVciFefqnpc9tz9dY8WioNf85epQIM47PKwbrLtKhreZJvY54kvyNCShQSJXcYZ32IsAKnjOfoTxu42NQr3bT/OYzHMwqtBhcp0SFe+qB7H9uD0tl1j3Twn8t96qZ/NpNK7hDGIvZVpBqoziw1OHUv+GmgBQNuh0v7pxoZcp6gcJBY8yN+kIUK2ByE398jzOa/Lz6pAKvdNgde+jO3hYmqo1FjF18nRcV3gLoG0rKS/tz9tRfsbLa0ZlQt+2Kqdw7Jv2164sdgsEIyl2dUa68/ErYWBmoKpsfelUzgAbmKuUpTTbnsKfZA17Ajfotjs/gzIbAb8MBD4qaRnZQe/k4fLjws9tDBrQDxtjMTcv+h8Gmrg2Kn9NnpPECtZ5pyRWFl8JlaU2y7vDw2te7suuGuuVtePyRDmvJJWZB5UlbOQYkVjyZMn90XfmjLukJXQe2X8cpx5Aux73KXnzdc5cdxfN6pPxwLniXgKJZoZiBcHaE6d+t6z4icedNqrZueefvL3Q9hY4
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(82310400011)(451199024)(1800799009)(64100799003)(186009)(40470700004)(36840700001)(46966006)(7696005)(40480700001)(5660300002)(6666004)(40460700003)(1076003)(2906002)(26005)(107886003)(2616005)(83380400001)(426003)(336012)(36756003)(4744005)(7636003)(82740400003)(356005)(86362001)(36860700001)(47076005)(41300700001)(54906003)(316002)(110136005)(70206006)(70586007)(8936002)(8676002)(4326008)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 06:31:19.9759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f78836e1-a9ab-4a69-afdf-08dbce11826a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4391
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patchset adds support to enable or disable privileged QKEY.
When enabled, non-privileged users will be allowed to specify a controlled QKEY.
The corresponding kernel commit is yet to be merged so currently there
is no hash but the commit name is
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

