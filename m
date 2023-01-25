Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C55A67BB8B
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jan 2023 21:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbjAYUBo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Jan 2023 15:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235528AbjAYUBn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Jan 2023 15:01:43 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2095.outbound.protection.outlook.com [40.107.102.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC3F13508
        for <linux-rdma@vger.kernel.org>; Wed, 25 Jan 2023 12:01:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATm71PWqo6nP+GOUJIdXYXDL3SWvOLlrXiAKn9VmUgWubk+8FWy97kuQ4qBzb7+l+kSNMewrDDXyqmMoADn3zDnyxtb8EcuSfXSzt5seBbLpOlASipBvKHhZl9Pmb+RD5bSvRmYHBPS1Sk6quY1eoOlfYcBTgxZgNJSJ2w3VCddOL689/dqeT4yD1lTJJw8N49Xs7ji3jTvXLuGz/EFL5nPSd4xZRr1zCdZkaRdxaVxhbh2c2LK6UogqudKO7t8ZAJbgQ34h91yQsb6mFNMZOPTMwhMePt0pXobGC/0PS+awYX6P05a9UrNmK9xjslrPzpI25Ilr9zJBS9L2eU3J2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqV3CbuVrGPIZbmxHH3yH/yFh/kK0gS0ynNnC0jpQEI=;
 b=AXn9eDCUHiAKCmd5P43i7GzD51xix8g1JbghW1vryunqEWKWiAhbP3hPS71snnKlhFe7J5jrOlATvI1OaNrzjSe9gxQhkLfABiBe6JuF2HUQDOeRaDgelBVd58PTJkElvxTDDk8KI0cWemprbHHkZX9M4AF/bfet1u9ANDt1Z6ETfxYF20ZLmt4j1YJbkGaB/m1ioP/buu9tze2orj9BxkUl/QavpDSp/O0tQ4L04bO7GcNMCkUPf1/cHM8Vy5G6tKyn1JxLhcAjuJoIzx5ytR6G8j+qYwE6S7agVmpO8NuS/mbajz8yaV3K/0xDKK+1vx2jTyXhy9coz0ulqqndqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqV3CbuVrGPIZbmxHH3yH/yFh/kK0gS0ynNnC0jpQEI=;
 b=dhHQJijTLyiovddm/Zm/DHtmzaUm2UUWyfIpLRRRTJAe9xiCLNDhdYILh414VdLCQZIKfv523FaCV7QYJ7JR8I8/7HKVrrZhnvgARD6PkFUjM180gPTHGMa2NiKoL5p51MCiIoeBbOn+rQ8IAWbxiPmxI1NKX7Xe7T9Ve3vGyKlA1A6iP/Zn+jjA2q0ypediGEMz02I34nS+VJCCIQlODBh/V7CE5DKu4z89jzZrX2ykxNRd5DpoqDq3aJueY9/eZfpKIno2x/z59PhdKmI5vtCdTi9iTIPpw2ThWINGpgo4hb9MCGiUAMuNjdHpD3PJlkmeyVcbZAlN0hz9OiXenw==
Received: from MW4P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::34)
 by CO6PR01MB7449.prod.exchangelabs.com (2603:10b6:303:140::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.33; Wed, 25 Jan 2023 20:01:35 +0000
Received: from CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::3f) by MW4P223CA0029.outlook.office365.com
 (2603:10b6:303:80::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21 via Frontend
 Transport; Wed, 25 Jan 2023 20:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT110.mail.protection.outlook.com (10.13.175.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.21 via Frontend Transport; Wed, 25 Jan 2023 20:01:34 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 30PK1XRo3649741;
        Wed, 25 Jan 2023 15:01:33 -0500
Subject: [PATCH for-next v2 0/3] Rework system pinning
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Wed, 25 Jan 2023 15:01:33 -0500
Message-ID: <167467667721.3649436.2151007723733044404.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT110:EE_|CO6PR01MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: bd05459b-e826-4b51-620c-08daff0ef628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FAxMoSwCSE0sbnKMkNu5ISCzO8wSa23K3kkxFd+vr+nh2tAeAKvvOU0uOOiFXg2YAp3zkaCcF/aYJJiRa1LuQ1SUMxp4G5qpReS5sVY3QCyAgESuigRVG8AsdcAoVO+KHd4wkEOAwXuJ3Ut2mEX8dJ3t7Tpm396FJPoA292LzxVeZxd7V7udolkZbGU1Cqrz/EpYxtY6gHelWvam7X37B8pmIFj3aIph0TycMn3O0zoPPwRhFl0kDhayIu5qaHK+wXEdipkBLVgfhhrIez+kL7/J7YzkuQfRD0XMRvPzPIX3NOohzhdGCzPpELS5Jyx0rb8IiCHK415V896ueoYNi0Q6/Fc4FxPiSRC3ncyLGE18drTDB/PUk1FZni6m4iPbqc2EleOXsaTSH5eKTwioINUx5EskWnnntBEvTr6Q1ALW0yf1e37cgUIYWr6GVTE3DZ7f89hO2uEAmMtZNjVXMWemKJlzMlJHKsQKpl/hQvmuBMbaQ9f2Ccl2FL7sQDOfxpto3bCDEvv+BB02bjvoUdSHT65mpROlgSTbv3V02pd4jk9XtGO49+sCedosvmUDuVkLZAu06HOsR/B8QC5/h5Is7lDiSVgqYwy5yYE3GAaoNka7ap/kO1AfV6YAs5TTHVyugJc5vog5RgjUR66bs93FzsmODqUNryLNY+IW7/+2m6uD0kQD3FH5tyUIW4ma9+9hhiZfYb8RR2RuppJgug==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39840400004)(136003)(396003)(346002)(376002)(451199018)(36840700001)(46966006)(70586007)(86362001)(40480700001)(83380400001)(70206006)(47076005)(5660300002)(103116003)(41300700001)(82310400005)(2906002)(44832011)(426003)(8936002)(4326008)(54906003)(8676002)(36860700001)(7696005)(316002)(336012)(478600001)(81166007)(7126003)(55016003)(186003)(26005)(356005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 20:01:34.9250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd05459b-e826-4b51-620c-08daff0ef628
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR01MB7449
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

Changes Since v1:
----------------
Added missing commit messages to patches 1 and 2.

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

