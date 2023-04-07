Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2EA6DB0F1
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Apr 2023 18:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjDGQwk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Apr 2023 12:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjDGQwj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Apr 2023 12:52:39 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2094.outbound.protection.outlook.com [40.107.244.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE7655B4
        for <linux-rdma@vger.kernel.org>; Fri,  7 Apr 2023 09:52:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jae6zoIwq4g+sdScC5mQVMCFLKMotJr/9rEJJgLrpDS0O6FRsanKV9XyaQvsjZ+hlJIHysh/wBefqrbx1bGHgcaSDoWWi2DpCWOjBCssVyR6KZH3OtQmLX9sgxzF59iDu8RV5mRQSXZW3azNlF1yiABkItA1Cmj3AVz2Go7l/DzdNthvTAzYXusWhAqVWGqV9/wzeGcjz0qcSwIdWTCF35AMyb106QYE6azqadbyVNxxGNV06JmbRT3zfJX3dFtyfk5wbmf+vpZBwsuPMeWrwMwkOL0tp2MyQPaQ0dL0XPI2dHzRwVRrdELlFr/WGOdqV1lIRaMwMBs1zbO/F8HHcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xv8T9Ki4+9pnS04dHE87FY1gKL0O4ijH3MV1Y8wrWvU=;
 b=IrI4HzSVgBtuNf1qkgz2aeoCvJZPgqYwI9p7rsNWYOEutYwmZrTWsj+VapS5Nkl/Nht2AaagSy24/kE8O2m/ZZoAOOoHreCifCoP3K6nN0MXwc0ab5kIGJkEOEhxmUydEuWTwErOMxKl7AImxEQMpgSHWcQct6MY1GortScyiGOvHTsFhfz3WqnBwipdeHWbLs34bHK2tJMxiEMD68wAifWXxg/DAG+aP2x20+WYkftYVM4rAfIB6ifynFoo+5rfFZWl8/8qK6+LdGVG7jB/oJMlmc81WnMX6TKqiIL9zU4wnPsjARJaDD9nh2McdLftlpT8Qe9c2aFD8d8Lh28F2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xv8T9Ki4+9pnS04dHE87FY1gKL0O4ijH3MV1Y8wrWvU=;
 b=iZ1fUimm+9hQNNRIegnUl29Omrz9X5sdo9lNK304UrhYbbsKQzEwNMnP9RjqQQ9Ufz5E9ism6w0oEk4FzdqMYIpKMA+QE+w+Ou/gF8doHCK9vwSX/DChtuTr3CnHqqCxIeOscnHCuJ0wd7+XDY8dcQVY7BBeKdiXvLWdyRlYz3R88HcMFDA0jbNZn35qFAPrQF/CPX8q51FJPx+4Gj6BuZK/pW5xjYx2pgO+A0c9LwKiowWGL++zdcVqH5kNEy+4F2MXFZ0wEyGhPS7IbBKtaq7FmrlSLh/ucv5wdKgNo2HV5kpqPtXAMvhZOsJS/+DiRF0oGArL3Crspj9fgIgPyg==
Received: from DS7PR03CA0078.namprd03.prod.outlook.com (2603:10b6:5:3bb::23)
 by BYAPR01MB4776.prod.exchangelabs.com (2603:10b6:a03:84::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.27; Fri, 7 Apr 2023 16:52:26 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::46) by DS7PR03CA0078.outlook.office365.com
 (2603:10b6:5:3bb::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31 via Frontend
 Transport; Fri, 7 Apr 2023 16:52:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.20 via Frontend Transport; Fri, 7 Apr 2023 16:52:25 +0000
Received: from 252.162.96.66.static.eigbox.net (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 337GqNpt3027362;
        Fri, 7 Apr 2023 12:52:23 -0400
Subject: [PATCH for-next 0/5] Updates for next cycle
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Fri, 07 Apr 2023 12:52:23 -0400
Message-ID: <168088607365.3027109.2194306496858796762.stgit@252.162.96.66.static.eigbox.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|BYAPR01MB4776:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c9c93ec-baf2-43b7-3864-08db378876f4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NmxPvKu/aSDooxk5wEsrZMvrh3bsLXybaLY9hAKuDsldoKz8cuk78k+Ew3Zjjm1juIqajX6r6b1hnhEtQwohv91drhAifdQ4/5OomxpVgl3x8F1dEDaOowsl6TB91Kq/Nw0vRcWoTObKPW3zgWsoFqbwBhxjh0o4yVfdcLC+J78HXv4Gre2B05LzjWL0CCBMg5lCHrqA5LAn2l/x96vUFsqa4W8987Z35JWnubvsBFw7uQHgXuyJXZMqL7QGXhgolN0p2E3g2L0IbERBhdJCieunbNBIWABiCIWaxl1aEpxe1ESNdn6NyDSOe7e3DO/z97V4O+uVbp3TD5SuJV3i4usq2uyZ7i6BIJYWw2N8ibWykGrTj48LVFsZLijsY0HDVhVGg5sESUIIQFNs+vuBVZt+AJa6QYscYEopfA6KP7W4EUimMMlEiy7e8tT7eGsoXuJ3J7T4KqbP2dcl6mJ8FEmt7y2X8aF+A3uBUx7eYH0jOYlPDquKkAhkAuEIL1oGeAhhqdkM1YIKbRJfBu1SbZro/LOTb78uRXgLnzKguPa4nHI/C2Gjbizlw+RzpfRYFWMoa7ZXW+DFSMD4lMJau/zsuLSqH9mWMuqSrkyQu6iMj8tIwPQf9qeEFQf6HeONfurqbpyqzS0rJHi6+r4FuRVMVpjrnFItzPP6STEzFD+xM9xkEajvlZerqUVZQmYcnEUmDI3jHe2C+MB89fnBkL4eKQ0jE7xZ45gMD5bIWcsaND3+ZpCGUO5BfLrYCw48eOvVU9e8JFeT8XrG/nvDow==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39840400004)(451199021)(36840700001)(46966006)(83380400001)(356005)(5660300002)(47076005)(70206006)(426003)(70586007)(336012)(2906002)(54906003)(41300700001)(44832011)(8936002)(7126003)(316002)(81166007)(4326008)(8676002)(86362001)(478600001)(36860700001)(9686003)(26005)(966005)(186003)(40480700001)(55016003)(103116003)(82310400005)(7696005)(9916002)(24686002)(102196002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 16:52:25.2447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9c93ec-baf2-43b7-3864-08db378876f4
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4776
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The patches from Patrick by way of Brendan are part of that monster patch [1].
Brendan has been working on whittling it down to make it more consumable. 

The other two are minor cleanups.

[1] https://lore.kernel.org/linux-rdma/167467690923.3649436.11426965323185168102.stgit@awfm-02.cornelisnetworks.com/

---

Dean Luick (1):
      IB/hfi1: Remove trace newlines

Ehab Ababneh (1):
      IB/hfi1: Suppress useless compiler warnings

Patrick Kelsey (3):
      IB/hfi1: Fix SDMA mmu_rb_node not being evicted in LRU order
      IB/hfi1: Fix bugs with non-PAGE_SIZE-end multi-iovec user SDMA requests
      IB/hfi1: Place struct mmu_rb_handler on cache line start


 drivers/infiniband/hw/hfi1/chip.c       |  18 +-
 drivers/infiniband/hw/hfi1/driver.c     |   2 +-
 drivers/infiniband/hw/hfi1/file_ops.c   |   2 +-
 drivers/infiniband/hw/hfi1/init.c       |  12 +-
 drivers/infiniband/hw/hfi1/ipoib_tx.c   |   1 +
 drivers/infiniband/hw/hfi1/mmu_rb.c     |  84 +---
 drivers/infiniband/hw/hfi1/mmu_rb.h     |  22 +-
 drivers/infiniband/hw/hfi1/pio.c        |   2 +-
 drivers/infiniband/hw/hfi1/sdma.c       |  21 +-
 drivers/infiniband/hw/hfi1/sdma.h       |  16 +-
 drivers/infiniband/hw/hfi1/sdma_txreq.h |   1 +
 drivers/infiniband/hw/hfi1/trace_dbg.h  |   7 +
 drivers/infiniband/hw/hfi1/trace_mmu.h  |   4 -
 drivers/infiniband/hw/hfi1/user_sdma.c  | 600 +++++++++++++++---------
 drivers/infiniband/hw/hfi1/user_sdma.h  |   5 -
 drivers/infiniband/hw/hfi1/verbs.c      |   4 +-
 drivers/infiniband/hw/hfi1/vnic_sdma.c  |   1 +
 17 files changed, 470 insertions(+), 332 deletions(-)

--
-Denny

