Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4174D1B10
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Mar 2022 15:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347648AbiCHO4w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Mar 2022 09:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245628AbiCHO4w (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Mar 2022 09:56:52 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2043.outbound.protection.outlook.com [40.107.212.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE37B4D60E
        for <linux-rdma@vger.kernel.org>; Tue,  8 Mar 2022 06:55:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHpwAzVxDO1d50eo+ITv6N0x2iGiJXb5ZL/pG4VX2FlLjT7dn+q4DNuP63unmrPMQqrPAeNuTchuq01nEHFB9oN5KXksmgsPFkwmXq9CznjD/dYAbSmcMOhXSj/Wq6r+T4+z11Th1ICz5VV/Ycmt52llMan3267uFY+2njRviwWo0ULUm2OrpCWHx6I5VBM1Cw9RzjVe1lt3jxLXgzt+PwaLUXyRnbM9GmX5cs5gThXadkgsco6bjfZcKryyZWT4edyIfGuYgG+AiEqoXtd2NpQ4G9UNvFAREvVN12Jilqs/U/GWsfbB5HxRs52vK2R8z264xi0vDAZBxHhCFnvchw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+ydtGtlB4aCvwnftHhyUD1SbR/NqOGc5q867YXK1XY=;
 b=a92SYdwiPd6I3P315pdYm1+l3q1zVmKq2Gahlw8tCwslxgfw/rIVR2Q4bnvgS5uSy81iQlMCkTv4ng1fEv+Mw5wdzLOc+ZOXgxx25uWSfnPY+eB8el8mw1SBbLToDG6KizTD3LUviqqu/oWNdUfuq6vn8PnlVLOCyj4v6y6Dr8sKIuRhCegw7+15pCApVX5zmfSdstfoBg9Q5NooF9euV9WhoBPHLQqPfi/s7g6jvt0Tqe9olHtMCZKrziXluKsjXUFH8QeYPaQZO+AxWN8yA1KTdwbVUbFljaejAS8cBAG5n4mcLIFleSPdqQfBwpbq9Q/WPz01UhzXcz3t+C3syQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+ydtGtlB4aCvwnftHhyUD1SbR/NqOGc5q867YXK1XY=;
 b=nZvM2dIWLSMjh+4CiJu7uyiP+Z4VWscPELLkZV5JWa0EfT5UVI7r89Zvm+TgONnVjD4sow5x/WClW9MdAFScJ69xot6RngmfWkmN0FuKN94FoNqGcSdhmJgld7Q6xUEX1VcPK+5BJE0/w0Da3dGPi9cnYEF0Y8Yyzn+DUcyK1d6+VK9HPe6THDghfmF+NQjwYFVrMFrLLwDVjFSbj9Xi346ZJpZRm2AwTjc1gYbW/REKc5S6EnFBTRLMNarvbdCR0yT6gjyog8Qzfeb0P7LjqtoK1sDWL+NYurfLy+kNEv9U80Rx7atBMrqECjw/9deJT7wnqRQ4T1uwAtvZYsz62Q==
Received: from BN1PR12CA0021.namprd12.prod.outlook.com (2603:10b6:408:e1::26)
 by CY4PR12MB1751.namprd12.prod.outlook.com (2603:10b6:903:121::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.26; Tue, 8 Mar
 2022 14:55:52 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::dd) by BN1PR12CA0021.outlook.office365.com
 (2603:10b6:408:e1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 14:55:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 14:55:51 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 8 Mar
 2022 14:55:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 8 Mar 2022
 06:55:49 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 8 Mar 2022 06:55:47 -0800
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>, <sagi@grimberg.me>
CC:     <oren@nvidia.com>, <sergeygo@nvidia.com>, <israelr@nvidia.com>,
        <leonro@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v2 0/4] iSER cleanups and fixes for 5.18
Date:   Tue, 8 Mar 2022 16:55:42 +0200
Message-ID: <20220308145546.8372-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 279c1274-b095-4811-0db0-08da0113bd3f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1751:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1751E3502D4919A59B935569DE099@CY4PR12MB1751.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2QXi47jW+4p0rlmSaQr1vc66DjQhNYYSH9q5+K04usRXcUJvUxGVkENKEq5PpH3gOI7eFqUXcdGZd68ql3T1ch9quIeNrHoKpR8bsHwB/9/zPChMnyuGfIOHjp9NZsVxIUR/GAOQ7KkDWDI3ghom7iP6+Qg+ZcKwsB5f4VHxSjiclHabAh4w6gqJ9dZ+1BbZLRIZjccjCnz02RR6P3SPuLpXs3Hq8ef2IwrzllOg8o5vb+xShdDRb8S8Ac95vRxQvgTdq3Gs3NqWg39yqtZs8T5zwK0rLTse4OOLB/RoYq7lUTpYrKtimG4fg7Mp+f3LUrnDGgsePuUeI/R5H3GyCvygU3aPHWGNSGUJGi/abMpSpMth+DyGJ5XDGkal5ryX0xAgG6Gt2RSg26e7hLaThOnpzEVt1ZuBSK/CZs2VmKzgO8gMTpafiJcpVIslv0N9tG7hS0ufiqc3QYmJAYvTRe5l430uGniGx4ExFtauichYwLlIS5ZvaZ7aE+0H7l5vt8a6PL/2k1riOjzaL8BL9c6CW6wrAhE2v/4FQ/nOug+ZI1G5Nk35TbxPRTYiczgI4K49ZGd1/3X7rPpqR7B/M9GyytmADTydL/Cc+b4SlvrFY9lixSB/Riq67zjf0vBjLPcAhyPkOll0zYytipn8U4z1BOIeZ3tkwtJdhlnOg1x8Ulnda4qAFsPCKH0Quzg40NtA1lWTBWPDeGTIPEFGxw==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(4744005)(5660300002)(186003)(356005)(316002)(81166007)(2906002)(4326008)(70206006)(8936002)(70586007)(336012)(426003)(47076005)(83380400001)(40460700003)(107886003)(1076003)(2616005)(54906003)(8676002)(26005)(110136005)(82310400004)(36860700001)(86362001)(36756003)(6666004)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 14:55:51.5660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 279c1274-b095-4811-0db0-08da0113bd3f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1751
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

---

changes from v1:
 - remove redundant if check in patch 1/4 (from Leon)

---

Max Gurtovoy (4):
  IB/iser: remove iser_reg_data_sg helper function
  IB/iser: use iser_fr_desc as registration context
  IB/iser: generalize map/unmap dma tasks
  IB/iser: fix error flow in case of registration failure

 drivers/infiniband/ulp/iser/iscsi_iser.h     | 13 ++--
 drivers/infiniband/ulp/iser/iser_initiator.c | 58 +++++------------
 drivers/infiniband/ulp/iser/iser_memory.c    | 68 +++++++++++---------
 drivers/infiniband/ulp/iser/iser_verbs.c     |  2 +-
 4 files changed, 61 insertions(+), 80 deletions(-)

-- 
2.18.1

