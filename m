Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224234B6A3C
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 12:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiBOLHH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 06:07:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236902AbiBOLHG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 06:07:06 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A634101F2B
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 03:06:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdnprCR2UF5LbOgLXGTsnAe9r4djXoWNdWywaoshVSyEmaRvnbOhkQSXtyBihgN4bPM9d70Yxnp1HBhYaRNdKfBVPgWgIw+gd0gtpS+gowL3nF0eZeBbBYrlNMZmT9v8Z5llV+Y+0Sy/YDgVxjI143SuDOtrBXjbBgry/PqXNn7Yo9Q2gw7mhSyGKtYh/DfXIBYJlnWemBZH8vu8raxIjaeJ/YTGXGHQwi81MPcdJDSFGHAMD5fX/8g0z5aTQjYU56yGesks7XXI2uOFxHLsR9HM0UAoC16e+8LGXJvftyZbxeNt3BFy0fsyhNpg5EFoBm7LFKhDIrhhX3aPXv8efA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S96udE7mOZ0X5ituw32Bsq9k9LdguzoGfpIneZx9I2o=;
 b=X5F0wFMcz7J+Tz9F1AdXaAZSXlKgDsyzqqyJDzZeeFhl2Rtm4q6u191HZrdn2TSP72vP0LTmEpN9b8yoNQZXJCjpUOSvqp92Fpjy2xIcCnRdmWyNblRFiNSTSfJFIWjdCaJGuGqfMhbIv3+5X/ptxVqTsDy8pAjTwtfV/+qaxM263WfZRaxcBK7vIuK1h9P7Rw7Cuz4XIz+RmOTB8blkWWxMa8PO2pfeE9sWbDuCwOjgkY5X3MPdDZA22yBQlPdXBE1IxYemcbSPTpeyON+DrrAbEAyD36vgYi/fbZz/LvznR+O2at6gYUntlKIqjBzM5sEfvWw6+LAkA8aey/+c9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S96udE7mOZ0X5ituw32Bsq9k9LdguzoGfpIneZx9I2o=;
 b=avjsHpIVd6UMZqG0SMEYNWB0DxAj1U0JA1qgKtskJ2tAiB4kF+HOnFkP+QOuR6/ztQrruygbeTnsZddXFj3mpWLMj8/VLq1zWkuTdI9lJ6Kl4Gp7X+oNv8ZSdBqXqGn/uRhjiErlbOZR54Of5yLu81gBhzbyzBBfHE+GFCVywnAD+TqsaKUd5O/ZbpSSrbgeYwz2mHp4aSoHQoZpwHDGZ19SbfFI2bx5yN/KAc+LfUFTOlOi7BdVznLpk1x4agXpZuqJJygQaD57Mf5zda3HDvrGxWK14Int3v0c2DYBLya2j5Kj+HAykNmgLq1ywDn2YQHWVtmPflhWEuH1L6AHWQ==
Received: from BN9PR03CA0876.namprd03.prod.outlook.com (2603:10b6:408:13c::11)
 by CY4PR12MB1671.namprd12.prod.outlook.com (2603:10b6:910:c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Tue, 15 Feb
 2022 11:06:55 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::7e) by BN9PR03CA0876.outlook.office365.com
 (2603:10b6:408:13c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Tue, 15 Feb 2022 11:06:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 11:06:54 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Feb
 2022 11:06:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 15 Feb 2022
 03:06:34 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 15 Feb 2022 03:06:32 -0800
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>, <sagi@grimberg.me>
CC:     <oren@nvidia.com>, <sergeygo@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 0/4] iSER cleanups and fixes for 5.18
Date:   Tue, 15 Feb 2022 13:06:28 +0200
Message-ID: <20220215110632.10697-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d52d9c3-990f-40fd-0eb8-08d9f073468e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1671:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1671455E7C7BAA095BC9342DDE349@CY4PR12MB1671.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 85s4RFpY3dRJN2HFVVglyP5nyzGyCWQV3eWK+Po2dfmsAP9Dicd/2H1rM4FDIUxdWQErH4keXxYwmZPyB4lV+ESaodath53vmVDKr1q6ImhtQ2VfKZkIp5ElndXSmpR0IAEhGVRxhs5akMCmtceOgoeQTUoiZcmfnIS2nT6329ZOukrms4r/6gYX0Bs2drxisd2TOySTh0DMbdiYuN5zF1oKuClR+yKny1yCCmJM6+fAdH6fx4SQV6V3KiG7L+c2mVzQff0pmb/iVk/xE5QHk7K5whSQzriKQbM6igxCzobJHJeY/VhZpxedM5OPasbn6nmo3BeR6Vzt1DusHlgpDjVZaHuBWiE95SgAd8siwzaILW/6SwVD5fM/ywDaATvlbcneU/TqQ5zNyQwfrixqeFA0tIGoa2dMKY6cwIAuchuaYiES0nycbjEK0ptiOCrTDBrHJ4Y4V9lqDABlgNBYdTJ3nCXTGgn2y0EXW/II1txOlrOMiFT7RwbakuMFF0xCxgeSO0bmHlM27xlfkHfEmdM3Tq06AlYQrTMu0wF1jKPZ3jXgh6b55VL9Vi+3h7LctQpH0rBcIKmSURAV2yaCV9srbAYCF099+Oth4EGjC5Xk93CgQJjk5YUkz4uwFH6RfzANfW2PzTZbk7hEi3WIsPuZukxVfQjvMdwu2kLa7tRRrEuSEZFoFAXQDSKcVWipq8LV1e7OSOcsTknh680tWw==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(186003)(107886003)(5660300002)(1076003)(26005)(336012)(4744005)(2906002)(426003)(6666004)(82310400004)(8936002)(2616005)(83380400001)(47076005)(40460700003)(86362001)(36860700001)(81166007)(316002)(54906003)(8676002)(4326008)(110136005)(36756003)(508600001)(70206006)(70586007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:06:54.3537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d52d9c3-990f-40fd-0eb8-08d9f073468e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1671
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason/Sagi,
This series adds one small fix in error flow in case of registration
failures and 3 patches for improving code readability that will ease
on maintaining the ib_iser driver.

Please consider merging this series to kernel 5.18 merge window.

Max Gurtovoy (4):
  IB/iser: remove iser_reg_data_sg helper function
  IB/iser: use iser_fr_desc as registration context
  IB/iser: generalize map/unmap dma tasks
  IB/iser: fix error flow in case of registration failure

 drivers/infiniband/ulp/iser/iscsi_iser.h     | 13 ++--
 drivers/infiniband/ulp/iser/iser_initiator.c | 58 +++++-----------
 drivers/infiniband/ulp/iser/iser_memory.c    | 69 ++++++++++++--------
 drivers/infiniband/ulp/iser/iser_verbs.c     |  2 +-
 4 files changed, 63 insertions(+), 79 deletions(-)

-- 
2.18.1

