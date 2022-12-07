Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D798F6455E0
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Dec 2022 09:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiLGI6q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Dec 2022 03:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiLGI62 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Dec 2022 03:58:28 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26A6BB1
        for <linux-rdma@vger.kernel.org>; Wed,  7 Dec 2022 00:58:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8xpHC7GMl5zlguOw9LvCKw64d8jiRkinWbzuUiTky8p/FO8geid0FRYxqc9G2En3Z3xMcuhUH39pxmeAZS0Qf7FCqLPhTuWSCIsB3tKpEpb4SMtqVX3r/A8O1oIjRDZP5aTJnCwsElNNuk+Fr7JQh51vrh6/TdxGTh7NIaHfC7dzeOdZ4GjhGp6TRwgLLf4KprSlj1RLCorJyQYTC6N6lJ/CNKGrLoCOqncZRjt3uga0ThJUsaug6PUTKoq5LAdJAPxCuoCfijbdZU/ZHBLTWmLgHWw6Q+ZQn9YVo8czvGWE3+KXZ+fTNLsp28w7ZYXIPL0S0WEfmBWaUa/sOm0cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZgQo+XfMR8suxF8cr0D90PptahISDZAEPN3KplumOM=;
 b=BpJGzYfI5QPAJBFiSQRhUEOcWBefHwUt5LuSgHafO0csGo6bz2m4Yvc4oKO1ig51PgrUf5fZPfwoyt9pe/8vRi6F/Da3S7XCrn+ebLd1t0rrkaVoLrisvR7rX/GSg6jqYnivy1q/v6A62RMotK9AbVIGFbxXKb+qhwAVsLLE8Yp7qqHI1QQWGyo58iaQgEXB5j9Yj3Msmu0ZtqhToS0XEO4EgSyCMrYMdL3z/2bcGjpOxbuG/QW3JHjN5/dQNgkVPOkYs9OKF48qxpEDkaja74ULCC/5AyeKjgm171sAy50aT3UNH9VEf9J6pgBoKPIG5A9QsDbq8zgaaDf1lNkv4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZgQo+XfMR8suxF8cr0D90PptahISDZAEPN3KplumOM=;
 b=gBCgkXvLInsRzX/YEy5d4p5o436fW7OM69sHUgOUGVHg4EPYuCg81dGJjjDrAJ1WnOFcyVWliwZLV3qMDbyVR9PTm2FSM4AINVywMX764EndeyEqEaIUN7lA5EE8two91a9sYrgseuvQ3vt32g7t+GHeRRHaWryMfi4J3cU+3WPl6CtP+jXzkUbs/E4GORPLCz1F3vOJpVzgFVaZFsAFibdRK0/mM1YaNMNefkG47R2QBs1+4izPuAbDpsq6QPo0yJdX2GBRYdBJ5PfuxgA3XSUOgIV5M8KjYoQcKIDUMQ7aR/X7hIrv7d86Wi2pqSaZWcAqF1VHHkNxUTBqIJvNlw==
Received: from BN7PR06CA0044.namprd06.prod.outlook.com (2603:10b6:408:34::21)
 by SA1PR12MB7150.namprd12.prod.outlook.com (2603:10b6:806:2b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 08:58:26 +0000
Received: from BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::dd) by BN7PR06CA0044.outlook.office365.com
 (2603:10b6:408:34::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 08:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT071.mail.protection.outlook.com (10.13.177.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.14 via Frontend Transport; Wed, 7 Dec 2022 08:58:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 00:58:07 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 00:58:07 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Wed, 7 Dec
 2022 00:58:04 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v2 rdma-next 0/6] RDMA/mlx5: Switch MR cache to use RB-tree
Date:   Wed, 7 Dec 2022 10:57:46 +0200
Message-ID: <20221207085752.82458-1-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT071:EE_|SA1PR12MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a291dc-74b7-4516-a0d3-08dad831337e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DNk6beKzGgEUQjTxqfINSYnHBe52C6HJiSxqCvk/t4U5Ez4ayG7IAygJUpNGdnV+wpyRA2WbXhZ9E3o8zeF77Q/HHtDAJ7E2gmDYCFsKlmXa//AKM+IGt2dPmR/XSGr+wsZhLuo2KBV5aSHIp64GyKYev1gghbZje8keR8a9qkOLdfi/kew35plSaKBBO+hyDv964ZwlZDeCcCeXs9ePT74drhD5e61/+vUvOzJcpyP//OWVsVwPEIoCe2eiSPIycmE8/uPRjoYSVR8KcEc+TH93NXSBsFMk5oHfGsv0WZQpA+2BPZblVKQ5iHBRRbsrsi0Qk1mLahAPK1deNieflBOsFhuIZ3pCGIBNkkAM1423yqqgaMZmji1OtUKdkSezduq/cLqiAcN2Y2jA/9/HGJAochW/z9IEMQGNRl70SLH30HvhpS4/1cdbqADV50Ci5nfZCFaOM+aEccMKDAcZrUl0kcgt4DDmnvVhlW4OA3XoCQcSDdFXsbrRkoUiX5ipEnzdYDfs/bC9eakdGyfuFG6ZXyeW1hVeQftPH58CUy0CZHIXPnBaiQ7xoffivyLziOIUDatopRUMMHWrpegjfOKl9G0oYLb6u24cQDXWHxR+B4bxnEPJ8d4roK7EdVP6uYJqB01RPqnyR5fm2jdSSerqlIt8PnaDAFXJakWguQ9bHG7otwfuj2MT7ypIa8B0RJP/IVj6BTEfYCrHQ9lNMOB1mx4xlxaU4SCXUdbNDDs=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199015)(46966006)(36840700001)(40470700004)(47076005)(83380400001)(41300700001)(426003)(8936002)(5660300002)(356005)(70586007)(4326008)(40460700003)(7636003)(7696005)(2906002)(336012)(316002)(8676002)(70206006)(36756003)(6666004)(2616005)(40480700001)(107886003)(1076003)(36860700001)(86362001)(82740400003)(82310400005)(478600001)(54906003)(110136005)(186003)(26005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 08:58:25.3092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a291dc-74b7-4516-a0d3-08dad831337e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7150
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

 drivers/infiniband/hw/mlx5/mlx5_ib.h |  42 ++-
 drivers/infiniband/hw/mlx5/mr.c      | 445 +++++++++++++++++++++------
 drivers/infiniband/hw/mlx5/odp.c     |  37 +--
 include/linux/mlx5/driver.h          |   1 -
 4 files changed, 394 insertions(+), 131 deletions(-)

-- 
2.17.2

