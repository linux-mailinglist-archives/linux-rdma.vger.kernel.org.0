Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A3366301A
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 20:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjAITPO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 14:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjAITPC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 14:15:02 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2139.outbound.protection.outlook.com [40.107.101.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE003BFB
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 11:15:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wej4kpZ3cIQ6ArIUa1ZFI5p/w3EW97MhmePPx+LEe5iCDAIQiMXHqYPuGQVB9gFrB7ZspXiN1oOORM20dkwIsLzCJhK+8QzI5mTiwHU2ZlrUct4moV6cucey7ITN6l1s8/vEyKrsgNkr9jHwe+27IsMfL8CC7tt83mKUCRDLs+3WhRDYM9O6Ybivd/x8GHpBU3MNKcU//8NFlZbCF99hejpbxuWSMjB307KM6NLvmWd8EgbPlHvl7TML5dugkPEPckpCkS3W40VW45NYPootVTOdd3aY7v2tGxxxS/I70B26M4V7k9RBURKV5yIrKbAZz4qJeYmY3XwV+uBGVPqNwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+VK31/O2BygCLXJMmgvZlah6N1XyeTgP6ebCDm9jWg=;
 b=DHGZ1NYgQhf3fVK/kojGlCcvniiWD9oVq2heDeHAKyv3al4q6Q1Byq/ULLhnEzVchswPelZjcp/e5zCjZbFWTZAGiAl2tkEhQ2JIxAqCRzpCl/c9PYUYyiEK0OIbaBaBiVsFTqndt4scxzp9mKuMdAbYwvzppRdjQDwD+UZKqIuN6WPHCECFe4gqom8gQUkfpBgxqUj2gD5OUKWC1d1eDpx3vH3mDcp761bczAyDrSV9iPYwKt+ilneF90oWcjiZkrnBtECz1t+x634y5V8fskqZB9wKG8yLKL1aN4RR/c3pkvJ93mDpRJDAdA7LviMJnA3FFtknmNTzp+AeqKx76Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+VK31/O2BygCLXJMmgvZlah6N1XyeTgP6ebCDm9jWg=;
 b=PNWZZ0BWTtUOd5s9PNEcFHe0NDclNyfGabch/YGexXOdGC7MtfQTdUk7rzuAN+U7HYJKs3uO01IEPn2VbixszABbbRJFHXlve2fw4T6ccfpcMhOBNzaPF6BKU+sMVvdW//bxjlUnvHxqPu9zx6FocFWx9ZApXg1dCVQ8xbbC06ZoFb/AHb6EJmKV/+QATfN2qxSxLO9JjwgEAMQ8s8LXEYvfgJkfxoczrt0fh7krG2hhIiV3YgEzSTiFDBFKxP5hxkMWw7kw8OnpfLUjAg5y051FqRG+A4NuSd29wldA8/42XgBu/Dd91dCuV3uIM9OV5uJ00CpmLa3JZWOZdYLQGg==
Received: from MW4PR03CA0196.namprd03.prod.outlook.com (2603:10b6:303:b8::21)
 by MWHPR01MB2655.prod.exchangelabs.com (2603:10b6:300:ff::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 9 Jan 2023 19:14:58 +0000
Received: from CO1PEPF00001A64.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::66) by MW4PR03CA0196.outlook.office365.com
 (2603:10b6:303:b8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 19:14:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 CO1PEPF00001A64.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.11 via Frontend Transport; Mon, 9 Jan 2023 19:14:56 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 309JEtsj1478673;
        Mon, 9 Jan 2023 14:14:55 -0500
Subject: [PATCH for-next 0/3] Rework system pinning
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Mon, 09 Jan 2023 14:14:55 -0500
Message-ID: <167329118368.1478031.13301737756220998277.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A64:EE_|MWHPR01MB2655:EE_
X-MS-Office365-Filtering-Correlation-Id: 498646d3-da8b-4573-ad3e-08daf275cbe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VL8ZgUA1CVAc8Qg9I2pgeJPgghogKdN+/+4IPweKRIZWn+upMwyBWAlY8yIGw9F1yVAPJn8CesAYhCDTxoqYSdmq7ncCEFgwrONa58bdJ8SGertJ4Xm8lzmRyOXnCdk2PaXsoK5P03ilZkMegh5AEfQ662cdrFJf3BgBmNaYK9hSG1pz/G7vblK9Vd8xggN1B8hLV7Sko2OylgY8EWs8Vy0RvHWT2QSxemsksPm0/pwS9UWH4rZuu3kQhhLCt68DoAzL2vGExuOc4yDCiuFui7pyYb3ZK783v3cFrRWAIYNxlY00nVLyVG5dIXqmco1ok28XZZX7ixm6IjZgU7lJT1pWa0VGSdA5GmjYl5EqmiMfbZY8mUR1uLL/iAUrAdrdLhUtXtKE8A2AqP+Mi/F6Ce3naM49B4KbAHiLl3nSIjzPMWIGAqNN5MyJzwTsWjgnoJsBwGGXMPY1DZfl7MM8yLWLV5nStwxk645uhHZE6M83YXpg+aidXILfV6GcwajnKMGgCcjBu9cLu3Rx4MQjMPHW++9zGDkUa+8JvIg77HVqhUiwdqZ76ImoEikkjIl8bbbFD/BXUPpkXE3pIMMB9EYyI6dr354NnKAGjFf3X/rTBs7U1GPnywS+pz4jlBE1NyFFP7evmhm7ACJeiBCVu38m0r170mQ/zPu4LROuYIHgv/1A0YZo63WdsW0q8abrR85Cz4qtJ32XRMsUttKROA==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(376002)(39840400004)(451199015)(46966006)(36840700001)(82310400005)(41300700001)(44832011)(8936002)(5660300002)(2906002)(8676002)(70586007)(70206006)(316002)(7696005)(54906003)(103116003)(40480700001)(478600001)(47076005)(4326008)(336012)(186003)(55016003)(26005)(7126003)(426003)(86362001)(83380400001)(36860700001)(81166007)(356005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 19:14:56.8700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 498646d3-da8b-4573-ad3e-08daf275cbe3
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB2655
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series from Pat & Brendan reworks the system memory pinning in our driver
to better handle different types of memory buffers that are passed into. 

---

Patrick Kelsey (3):
      IB/hfi1: Fix math bugs in hfi1_can_pin_pages()
      IB/hfi1: Fix sdma.h tx->num_descs off-by-one errors
      IB/hfi1: Do all memory-pinning through hfi1's pinning interface


 drivers/infiniband/hw/hfi1/Makefile     |   2 +
 drivers/infiniband/hw/hfi1/file_ops.c   |  51 ++-
 drivers/infiniband/hw/hfi1/init.c       |   5 +
 drivers/infiniband/hw/hfi1/ipoib_tx.c   |   7 +-
 drivers/infiniband/hw/hfi1/mmu_rb.c     |  96 ++--
 drivers/infiniband/hw/hfi1/mmu_rb.h     |  30 +-
 drivers/infiniband/hw/hfi1/pin_system.c | 567 ++++++++++++++++++++++++
 drivers/infiniband/hw/hfi1/pinning.c    |  55 +++
 drivers/infiniband/hw/hfi1/pinning.h    |  94 ++++
 drivers/infiniband/hw/hfi1/sdma.c       |  33 +-
 drivers/infiniband/hw/hfi1/sdma.h       |  77 ++--
 drivers/infiniband/hw/hfi1/sdma_txreq.h |   2 +
 drivers/infiniband/hw/hfi1/trace_mmu.h  |   4 -
 drivers/infiniband/hw/hfi1/user_pages.c |  61 ++-
 drivers/infiniband/hw/hfi1/user_sdma.c  | 354 ++-------------
 drivers/infiniband/hw/hfi1/user_sdma.h  |  24 +-
 drivers/infiniband/hw/hfi1/verbs.c      |   5 +-
 drivers/infiniband/hw/hfi1/vnic_sdma.c  |   6 +-
 include/uapi/rdma/hfi/hfi1_ioctl.h      |  18 +
 include/uapi/rdma/hfi/hfi1_user.h       |  31 +-
 include/uapi/rdma/rdma_user_ioctl.h     |   3 +
 21 files changed, 1046 insertions(+), 479 deletions(-)
 create mode 100644 drivers/infiniband/hw/hfi1/pin_system.c
 create mode 100644 drivers/infiniband/hw/hfi1/pinning.c
 create mode 100644 drivers/infiniband/hw/hfi1/pinning.h

--
-Denny

