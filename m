Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BBA67BFEB
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jan 2023 23:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjAYW2h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Jan 2023 17:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236291AbjAYW2f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Jan 2023 17:28:35 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5CF5EF96
        for <linux-rdma@vger.kernel.org>; Wed, 25 Jan 2023 14:28:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvLKQxANTcEiKb135ZbXLfBv6tkDzyvFZmij9462ZGSidvKalH7G6F8RH8CT6q3rVSXAszDT8aeYKypCc3chBIkOkeE9/oBJaP3Ageds7Mlno42V1Noxw9sfA3O6N4jcp2jrJBCcCgzY7XNw2O+w6jSeWUadeYwzKA/fcVksAHIH2CQD3JCnI6z56bRXanARy3LWkkdNsaFqPfe2Vd8Yjvq+Jg2Ud8Z+Nj+WMDJkHiN8Sa36lIyY2wSzsodLp5JWLaJLuRCc88fTt829dJehYwQuMJborwTHCjUZy8f0gC2kg05bGEv2DslzLms86xL0ANgri0k9yF708ZNcYH2glg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayRMCzDzXXBmw43ubl1XvrbVbhCEH4ZtPmhfYYWd2Pw=;
 b=GcQeWU9snIsBW3WDGzyTuKJ45HqtgjnYIZwVMMJ4Xv3uuifFwW/aLL4YIPer9XUwCTyeTLZ3Ub5qoxLDQrdJB0wwx3IPFEUFKbkRqsxNfEb5ayinSuPFGmSMmn5lDzpLtO2QQjSJNszKpUxM3EPmxIY14rnZ1mQXBXeQsAAudb8whd4w8hzLzjDKq2e3A67P9S+jrQCah+NY6IDgBRnt4Fh0C0TUZwOGybhLom8/CDph8YOB7DlJ/WdIpjd9fMWfyuGP48/aLCY4ZBeBETrRZl4pUIwQQ8g3LMgFtXoJXHTlNzIQjEntjx8go06YUO5EIFc8wIJHM72ow+V90zGmyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayRMCzDzXXBmw43ubl1XvrbVbhCEH4ZtPmhfYYWd2Pw=;
 b=HOF3jWACZpjEnAh6YFxnScmfTfGLcw9PGo48wUJXwcwG9XRnKCGqQHiklhk5pZNyONAb7GVkSDcNxoyHCdEWXsNHM+IIuH/lBANVX/Lbc2Q/WBzU2YuPrD+RuiVlIyX84Y/6M+gjw3Lv4g5EPZkBKLo51NRU3s4kSXyLRCg3TlbIMZCApCkFGWFW4noCLpRMQ9ZHDs0Ch23xctXkEPrPGoT9mMp3tLU/FnNtSOlLmiQd7qpR3BhCGVJmpTNXZ1RwIAfLMrWiOApmVKtqIKZc3y5ocRoAtfxxM2UvhoqFU6a/ZwCPX6VwKVRTjDb99s1FoMZv3xNM/ht0uJSa13SX/Q==
Received: from MW4P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::27)
 by DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 22:28:33 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::91) by MW4P221CA0022.outlook.office365.com
 (2603:10b6:303:8b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21 via Frontend
 Transport; Wed, 25 Jan 2023 22:28:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.21 via Frontend Transport; Wed, 25 Jan 2023 22:28:33 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 25 Jan
 2023 14:28:24 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 25 Jan 2023 14:28:23 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 25 Jan 2023 14:28:22 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v5 rdma-next 0/6] RDMA/mlx5: Switch MR cache to use RB-tree
Date:   Thu, 26 Jan 2023 00:28:01 +0200
Message-ID: <20230125222807.6921-1-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT011:EE_|DM4PR12MB5149:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dfbdc75-87c0-434c-b79a-08daff237e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wgfvj6d7wJIwLSCjqNLtCCIIeE30PnYCTmcY0EmOi/QvqoFztTEqcRzV+4Tf6Jn5FeK90Oln4X1iwLFSHywZzmrtwjlZUUC05nVgjPjnmUFDRRhzveMPvOF9B11mJMWhQxOEd6B+larlaxRm6k7wkSC+dMfq3RM3wmAV9ZMmhpy3qXHqbDEPIiecml9p8QraeK4yyvTiSETq556oTUk+tbcFFUO7S1waHk0t3kgktahOFtzoJSWpEkfn7lKYW5WbLIwOvp4ndJ3GDjH5dMLycUkSEHVTSXKUvW8p2Y/cavI5cBk7tF5VMZkOWrspXeDnGwZJXKRYN3cwT7+0hwJ9BGfB1FSCHOZHspeY/x9871Qr5Zoizyaa3RCzvpEkSAXcu+ly3UsZ3pG2X4vJ13TnUnVyvk/6iQQZDG/GMTl6hhpmEGX7KHoiFSnJKwqRQp6D0wLRRy0y6nDqi7W8WqgrkGpUeG7hE769o2gvUoiiMWTZjVeJ6IMjGaEWtB9sF7UWa0laiP11v1GgLaA2xefaXkTkj5aB3jGCdemxCCIaNS3kXn6xluvr2gSsNwiFj7QmgL7Lh0wBX1mlgDl0uFOqXGrZocYQ89yYrNd/d7/g94BkbUaL/0YCQiNY2QQ3vISBnslP5GbwDGTgp1ojOt8roO4jzEO7UMm6WGFMaajctk1d+vHK3AdWZbGU7yBY57QJCwmkSxrhghtKIEw0nAoOka0tAeXJQIu+HjtvH/OOTOU=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199018)(36840700001)(40470700004)(46966006)(36860700001)(36756003)(86362001)(5660300002)(40460700003)(4326008)(2906002)(1076003)(110136005)(26005)(83380400001)(6666004)(54906003)(7696005)(316002)(107886003)(8936002)(41300700001)(186003)(7636003)(40480700001)(82740400003)(356005)(478600001)(426003)(2616005)(336012)(47076005)(70586007)(8676002)(70206006)(82310400005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 22:28:33.2674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfbdc75-87c0-434c-b79a-08daff237e40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5149
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series moves the MR cache to use RB tree to store the entries of the
cache. By doing so, enabling more flexibility when managing the cache
entries.

The MR cache will now cache mkeys returned by the user even if they are
not from one of the predefined pools, by that allowing restarting
applications to reuse their released mkey and improve restart times.

v4->v5:
- Commit message fix: 'Remove implicit ODP' instead of 'explicit'
- Fix return value of init function in case of no ODP in configuration

v3->v4:
- remove 'change-id' and 'issue' git trailers

v2->v3:
- Refactor MR cache init flow
- Move rb_key decleration to rome unnecessary change in following
  patches

v1->v2:
- Rearrange patch order to first introduce the RB-tree and only then
  introduce the caching of previously non-cachable mkeys

v0->v1:
- Fix rb tree search from memcmp to dedicated cmp function
- Rewording of some commit messages

Aharon Landau (2):
  RDMA/mlx5: Don't keep umrable 'page_shift' in cache entries
  RDMA/mlx5: Remove explicit ODP cache entry

Michael Guralnik (4):
  RDMA/mlx5: Change the cache structure to an RB-tree
  RDMA/mlx5: Introduce mlx5r_cache_rb_key
  RDMA/mlx5: Cache all user cacheable mkeys on dereg MR flow
  RDMA/mlx5: Add work to remove temporary entries from the cache

 drivers/infiniband/hw/mlx5/mlx5_ib.h |  38 ++-
 drivers/infiniband/hw/mlx5/mr.c      | 478 +++++++++++++++++++++------
 drivers/infiniband/hw/mlx5/odp.c     |  40 +--
 include/linux/mlx5/driver.h          |   1 -
 4 files changed, 417 insertions(+), 140 deletions(-)

-- 
2.17.2

