Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F48866B115
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Jan 2023 13:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjAOM6a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 07:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjAOM63 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 07:58:29 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88A410A90
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 04:58:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFO8pjavUak3Dah3C8N9bKgv1CJpC0fYGUvtOJ0Pf1ePWmP3fWxtxiPsFOSgSB7lp8EOg9jaBXoziOR69UAWuPkdIO6lVl3YI/HDFQpAqEQMcsBpFlOXLpnzDFHbvvxnEgmxGXAXLrX9fzcKr3HeQ1yF48FVj8z+jud29yA52cB5cyKB1qb/cjcn+yVUUnS/BdhavAFOjmSNqlSRFUZPw6PKr5rpolpVAa4p0f1r3An2fFvJxEXcneeoh9VZz/E80xr8+PNk37Y2ACS5FUiMHcthqr7el3fNhVWhfkIYbpU1wcEviVTPlANGxRhw1s7VIxhZP/t5K+LGTqu1JDEg7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/QYlEXNVspTe1MfbA8voSjqALiQ/+zMuE2XJfOkFn0=;
 b=ELdjLvhb6lA23beizGsI4n1X4uyapnkNB2i6ZWzrL2j9i/pIWaLFuFQnqEqHEnEfJfb8Qfl8HUfeiosoMdfbY0DqTl8C7CSqj9wc/eyt+Xcpm6Mrn2UH+CPVtA5xTaDChpUoWps+1dLWXnz2uBX+6VujE+QtUCmluGsWbYo/e7oSzwv80aVaZCnCIWJ4hphy4xXaA7tPqa+eVCpkl7eLdKEdbMubS5IHq+946eKa9orUCtN6w/Ee4mHkwVxaBuTiTyuxQ1DIlCxdRM9FGDvZW+n8wOAbO6QLMAyyfCkw7S5J5nUBeu2YJgwdtWZHhXwd+7Al4WMxQKaHH8zR+EFDdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/QYlEXNVspTe1MfbA8voSjqALiQ/+zMuE2XJfOkFn0=;
 b=gR5ETZsX4t9SC1pwbZpUTlbcy7t+pP83Fjlxf0Z28zbnubgWOXHckyQEmqgKui/dkdc0sXlF4GXuhAHVHoOj5KoTYNkJn2kT7rEhRu60yeyMyVxNkdpiypqLQkJ54ExHMoMskAqM1oHWewEaH073R/0TUxoN/xCRwvLo2cgylDRIdy8Mjs5LxIColtEsI/N0KIY6A8rF941YNSmAOmR0Dd7MFHQ29FT+s6V9OyEx0uhHOHhxzI+Lf2gqMb/ng5/sMq60dBdvk5Y7VkeYiALPNoYv6wwZAwkx3zqqZzjjkhJOPs+fRP20aFG1bF4h1YwTc1/y1bgA/8HW6V6M9MOTnA==
Received: from BL1P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::29)
 by IA1PR12MB6211.namprd12.prod.outlook.com (2603:10b6:208:3e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Sun, 15 Jan
 2023 12:58:26 +0000
Received: from BL02EPF000108EB.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::1a) by BL1P221CA0016.outlook.office365.com
 (2603:10b6:208:2c5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.20 via Frontend
 Transport; Sun, 15 Jan 2023 12:58:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF000108EB.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.11 via Frontend Transport; Sun, 15 Jan 2023 12:58:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 15 Jan
 2023 04:58:25 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 15 Jan 2023 04:58:25 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Sun, 15 Jan 2023 04:58:23 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v3 rdma-next 0/6] RDMA/mlx5: Switch MR cache to use RB-tree
Date:   Sun, 15 Jan 2023 14:58:13 +0200
Message-ID: <20230115125819.15034-1-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108EB:EE_|IA1PR12MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 67c3e675-52e5-4cc7-f64f-08daf6f83134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59vlzqFEPZqjjnrHEK6yWNL8coztqnZqHHcIVdOnzhVknzgm8BZTw/WnAB8LQbbxZAIXio5sMfkmsdgjva8iwMCNacc7a+L1S8xwR2d5v85vIB6mTdIdAk44xxyS90TFiDtNzN150hCODse7qhpEY599+lGf9pfIWu2TZCyzh9iYp8japQrDHka1BsjfSTR3R9kPbq85EVoBT8QBC5uDVvzrWJCRVaScHA4eh7WM18McafZjClvaExQqKkoBOGlEIehILuEyn9wViX9JCnvoVVVb6wMSKEEdTgzwQECGucNfd/grEruCUkiLG5UDxICMNysNJ5EWvVlTANIe5zNjG8630W+lQSlLujBBI1hwECjkFejBm6o+xQBd196cCyYoB6erJ/wlBAg2x8LYRV2soaXPHh3zNSM4Td7AWlvCPD5PFGxjFlxRgvDaC/QwYDw3fYpvmBSM6HNYuGj2kP8mdTJ6lvq5zDIOH6Ufjj2BdamfAg6lphpqOpfr8PRTCoiinpdp+ffXxzlkVWCElrfzpX7qKYR14qUmwGT8nx8gnL2tN/prJ1KAw0753E0W7VXd4vuc2edstOBhRgk0JSu2tmzAqwlvpjCc8+5tVD3Fn8IvP+NCiIdkrqAYqtLa71kuMzSq2xUvCzVOfsKT4R5/zOGfEwO+kee8lW1qDbBiZZQdl2L+++0+26SK0+hCtFsxkwxblBgcV3LtllcIwrSRjt8O561yaUec4z3QXgoxGMY=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(2906002)(107886003)(7696005)(6666004)(26005)(478600001)(186003)(54906003)(110136005)(36756003)(336012)(70586007)(70206006)(316002)(2616005)(8676002)(426003)(1076003)(40460700003)(41300700001)(36860700001)(5660300002)(4326008)(82740400003)(8936002)(83380400001)(40480700001)(47076005)(86362001)(82310400005)(356005)(7636003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 12:58:26.2503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c3e675-52e5-4cc7-f64f-08daf6f83134
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6211
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

