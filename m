Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8297B5B27F0
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 22:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiIHUyw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 16:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiIHUyp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 16:54:45 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2066.outbound.protection.outlook.com [40.107.212.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D841A3C153
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 13:54:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Scu7w5L5FRmN8xrWdnQDvs9jal3QXRkGTtVuPWTF96GIbd0keyyvqBeyQ9ys4FYOhgBE0UH9WQ85x5wbj/j/nSa7bG0WdgUTEvFZGOAfKEsqQ6nuMQ9ruoKDe0q82JGVepCQsTb3xI9McAJ4APO9Gp0gF+70bofl4bOR4/qkxG6Dlehe3kx62hZ3A06fzcplkiohjSbolsaOUIyMApyB792G/Q5YqSoJYradMy+Ogj4wZNnO2zfmYPF7vh2/FtpfFmHm3mAiC3B3VT6P8FMYDpBOQyewObhWmwyvrQUALsQAPybfxm4pWfIid2IaX0wSKlNofaWiXOuES6jn+p+j6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38PUDaVdqxz+REBX0HgQPW6tCQCmaPZ0n0VPizpGHeU=;
 b=BKNUO4l69JuQNBCTpTp7kiHR23MMbXyurva8PQRGEeaFqsCT+wy7zfBXIsqwBpNWJ1epVcBYGV3OINRvMsnU/dog70y/1jqwGDzc5sNGb1HkETajWR4/duoceAMFIkE1w1OGE6zz2RsuLMYX2q1Ma8zg7+3vdr98oR8uL+8rYIrYKzB3oIklBKhZUWT7KUwyzEi749T88Ew0ToBoTwp/kQ9DoFlx89U7LfvItis0xThmKfGyTfGS3R9oU4LM+iJGcubDT9ets2KGFx3kJ7GjTGdPNZppJss2cM53Rd4v/5W3NmoisIElnfkkQIOZ79ISW2SSziJxGtBqtBN10Nn2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38PUDaVdqxz+REBX0HgQPW6tCQCmaPZ0n0VPizpGHeU=;
 b=Hp6uQrZgTlxEZyfnh356quRZ/6ghDr2ORf2Vk2iwuecoPIBn76YP9/8vtDZJ4EwgZpkHzuz21E1Mn++cMrbPYbeh4mpeGfpdaQT0s577GJG6qKEQOehuxZaNXxd4ajjqeRj0GnSpRUTzA2+jt5WKZNroYnX76pXCtiodbA2Q46H2zBthsx/47dZapx+49fG9Pu2QqrM6/Iee1JwthUJOYRXiNQM/SwGlgR+BXQYO0IkCBel9vRaWbY3Rl3CW9w57Ebztb2fltZZ1JWNSpYODAFpuxCOsUe9jJly8GJHsLFbzUqT+cfJkVEt3rma3TNoiSngzZubRrVREtIDX3xhPfQ==
Received: from BN9PR03CA0590.namprd03.prod.outlook.com (2603:10b6:408:10d::25)
 by MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 20:54:43 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::31) by BN9PR03CA0590.outlook.office365.com
 (2603:10b6:408:10d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Thu, 8 Sep 2022 20:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 20:54:42 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Thu, 8 Sep
 2022 20:54:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 8 Sep 2022
 13:54:41 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Thu, 8 Sep
 2022 13:54:39 -0700
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>
CC:     <maorg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <saeedm@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 0/8] RDMA/mlx5: Switch MR cache to use RB-tree
Date:   Thu, 8 Sep 2022 23:54:13 +0300
Message-ID: <20220908205421.210048-1-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT011:EE_|MN2PR12MB4093:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c698926-86ef-4df0-9c28-08da91dc5afd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vInRlMQ35BDSKDxwOJCm9KAoVNfJTFSQHdDVYcUvUJmscqdgTc5WYtEZFZ/1pRj0iP52uSPmWYLR0nCKX1ssceA2f5ku3tN1iCdUK47E0+OiCc0a5GY0a/MSVGV3haMwzh+4B2/t30R6S7k3bpQppv59Mv0gc2Xov+FbGHBMuNuEqwYdB99ruDYL/GrURrulqdtMzPVuzuMlv3d8v63ScEGLLsRnpyDJvPd81sdNIcZb2Z0GGoFqPBW9rX6ZizS5u+rIiHBXTVLnWIuQhrdI93dng9gjpmqL6MZ+Cabxjt1xEn+UCTakLxidsYbK4JYNPL5iRDQBXUbj+ipNkqjZO3d2VrFJ+Um8llJ+T3q6onrTsIuy5NtQJ+DOkL1ei+mw/GsEVMsIHLxflqe6H4D9EQLSJUVE7jCcc4F3S+tX5W1PZ4140Dj3F3AqDox1Pso8oBKjzFofDNFWuJya7lpkbLxdDJvaX0dAI6on7bF45utUwuEgspzy7D1jO7AVbCab9m9jqkug/VfWv4L4P+8/FhW9lJwiBSJXLsdC1s5iJncZOL2XlqNipXwulZM0qgWv9v/SXa5rbRG1ycGUGq+BJ8uCOHNhtDbc6N+oN+7Agy1ZgsDd8T0g9gFlBgZNU5vXCcfKs5eGqd0I3WxnwrnNQylg3mjyJDJyIdz/NYrcsmwEYk5F/e447vidMUTxmGAaRgvlDOTD7gkNrl8zTVW5EhAQyVbks2WgiyaYzxvrHcNPzMtMLRIqdthQsU/jpsWM47G/0A73plAvY8AhrJCiY8S4Mp2Ze/MgtmBd23av4H+LPB6qUGPEsJmuVtHhakbs
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(39860400002)(376002)(36840700001)(46966006)(40470700004)(36860700001)(478600001)(82310400005)(426003)(47076005)(336012)(2616005)(186003)(1076003)(7696005)(40480700001)(41300700001)(86362001)(26005)(83380400001)(107886003)(6666004)(8676002)(81166007)(8936002)(4326008)(2906002)(82740400003)(356005)(40460700003)(70586007)(70206006)(54906003)(6636002)(110136005)(36756003)(316002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 20:54:42.9874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c698926-86ef-4df0-9c28-08da91dc5afd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
applications to reuse the their released mkey and improve restart times.

Aharon Landau (8):
  RDMA/mlx5: Don't keep umrable 'page_shift' in cache entries
  RDMA/mlx5: Generalize mlx5_cache_cache_mr() to fit all cacheable mkeys
  RDMA/mlx5: Remove explicit ODP cache entry
  RDMA/mlx5: Allow rereg all the mkeys that can load pas with UMR
  RDMA/mlx5: Introduce mlx5r_cache_rb_key
  RDMA/mlx5: Change the cache structure to an RB-tree
  RDMA/mlx5: Cache all user cacheable mkeys on dereg MR flow
  RDMA/mlx5: Add work to remove temporary entries from the cache

 drivers/infiniband/hw/mlx5/mlx5_ib.h |  42 +-
 drivers/infiniband/hw/mlx5/mr.c      | 559 +++++++++++++++++++--------
 drivers/infiniband/hw/mlx5/odp.c     |  34 +-
 include/linux/mlx5/driver.h          |   1 -
 4 files changed, 451 insertions(+), 185 deletions(-)

-- 
2.17.2

