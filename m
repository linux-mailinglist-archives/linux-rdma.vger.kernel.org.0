Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B668D66B147
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Jan 2023 14:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjAONfH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 08:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjAONfH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 08:35:07 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A6013519
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 05:35:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m12h7/Z0dR3fnBHwKPGe72rR6dELwGxemG/GoxYKreT3dDYgB7BNrw1ZOkt/+Cvxv571YWTqZYEJiOO9zj3Zu5w9lwTIAkr1rbzhCmvrfcBhV2OYvgm/TPtRCgCJ9fcKh0gumGaj29tB0+RB9VQKFhJpRBvrBsVJWD1GEco+HIXM8T0IrvOC0dFGeX/JfyGpXi9vuGF9TU/m7lSR1amJWARGCGim8aM3EUXHFUz4Ka5/ZD5WvE1bjjEKM4goh/i1jbT7eqWw+hZkqK5u0yUD8NA16US7EtfixGxgtUkolBYxmStn3UeOh7uZp8xoCE1NE/k16ql+hXDMC8KgKhNS+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2YfffEs4qwkrKZu6VKoNFWt+G+i7aaR4BWbRy5y4hI=;
 b=Vqv1+AiDV4Sy94xat8ALLrWanI5t0CXUPixwc3pRJTx8jgr7q8zkfh8TkfRD0n1LKSW+hpplFdou+MRkp5yKCuA7YYhD60K+mlQhVPmTvluJBUvlvc4WPnPoo5saqg5q1fsoncNeAFgVYB57NNaNK2UMfyr/NWE5m+mc0rQXxWvY2HJZiHuhznsPtTzzS65mDKvwzg5lzPz3+9ZY6RM1vyUeV7TZv+HUSu5cCzWM6xGc7c6+3gN9CVv64Yux5x3K1zPfQ5eEj851GXTmKCZBv0lk+0S/Q/5r+qyLVph+PAtxI240C4Yn4tUKS1k0Vfi+uMmJxFASwBvQaveN8FTc5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2YfffEs4qwkrKZu6VKoNFWt+G+i7aaR4BWbRy5y4hI=;
 b=J+1ESGuEyN/i2EyuP6HOIBygbzZ+vZVektubKzEL7Jka2O/PeKngp3vzI3xiJRZCBZmpoMlC9jBuKcEJccSbRSueEY+Uescv1WCD6lLKSZvM1O/kGY9gsA3tzgS6SLflbP7s8t+XZ/H0QK1S9dTxIM7yy5bh6YJCf/PmBE7HqnQg+bq87gJ3eBsWZ9gotu2iTJ6+DfODoSq+wV0N54EKr6vQdCrd6sjs7A+Sz3vYutP7Svs+zkOWbwu424RRIjRWfojvLh2vo2sMBR8rI4VAk9v9SiH7b2SU7AxoLqPhcVm5v3XqAH/kag9y8Cka+GRzC2hfAfSha/Mc13Yn7rmD2Q==
Received: from MW4PR04CA0370.namprd04.prod.outlook.com (2603:10b6:303:81::15)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Sun, 15 Jan
 2023 13:35:02 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::1d) by MW4PR04CA0370.outlook.office365.com
 (2603:10b6:303:81::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Sun, 15 Jan 2023 13:35:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Sun, 15 Jan 2023 13:35:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 15 Jan
 2023 05:35:00 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 15 Jan
 2023 05:34:59 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Sun, 15 Jan
 2023 05:34:57 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v4 rdma-next 0/6] RDMA/mlx5: Switch MR cache to use RB-tree
Date:   Sun, 15 Jan 2023 15:34:48 +0200
Message-ID: <20230115133454.29000-1-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|MW3PR12MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: 9928792f-664d-4114-a19f-08daf6fd4e63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +/ZWiI0Sei1kxCMb4T4y394KfheZk1WF6J/Ujjy11eO53ugKH6tq6D/3nFm6xhEP00fqUGCSQLwo0ft7kfhJiNbSBxSb79WO70RHUMb7u54kTJbh8y1qSpQXc2byZcfD7XjLfKBgf6tnXZ3FXCDi0jQ5g6MBfey0gcIDgdfeE3a+YLxjTg3W76F0Bz/slz+y2+2U3JCd11jID1t5Qdp+zf5IHsJABeo1szO4VIGenye7bmI0ZtUEgDa5yR8p7lr+qmuDVL/gyVDTWdbK9ju5eFpjfOB5PkSuGn8KHhZsk/oFpNdVPZ9PxLUKWsQdyiIVRb+tIi4gNtU6ofrAskm9ouahMU6uP4gam6qyjz+hd8pxtC5rL1KMsZX49SPzBWfxmWLRa1sZO8010svIU9Ad5TZ3GV1BoX5yWMbYE2k4uMNb+pgkUNtEtv5ucb0Sv4BOY4E7gE3LaurlHZ+0aVeR4x0wY/hZNKXxHQK9fkVhcKxDUgg3WdWWXuJuX8AE35/YuqtF1Ey+8EVcc2tZh0sWQEbOA3NuhICh0VanDdK2CEBPi7zUAjybtxxqnAHEZy+nKIMdFO53/8SqQyisQxzFqqM9rR08ry2yjWBLtwDtOXqBOCMWSDic10fg3rYx9S0zcsiOXjAJv+NMW3jvByWe7/cvatqvOo5ClwzIk3zjitZPowPN6NqCmYodnWQZ0z2zvs9o6hCcvRQGs+ft6pzMbj+7RQYj23DpEK0P1QBmEYc=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(36756003)(356005)(86362001)(8936002)(4326008)(8676002)(70586007)(70206006)(2906002)(5660300002)(83380400001)(36860700001)(82740400003)(7636003)(478600001)(40460700003)(7696005)(316002)(54906003)(6666004)(110136005)(40480700001)(82310400005)(41300700001)(2616005)(47076005)(107886003)(426003)(336012)(1076003)(26005)(186003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 13:35:02.7095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9928792f-664d-4114-a19f-08daf6fd4e63
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

