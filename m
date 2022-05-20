Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE3D52F311
	for <lists+linux-rdma@lfdr.de>; Fri, 20 May 2022 20:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345174AbiETShE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 May 2022 14:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352734AbiETShC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 May 2022 14:37:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2094.outbound.protection.outlook.com [40.107.237.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF765C65A
        for <linux-rdma@vger.kernel.org>; Fri, 20 May 2022 11:37:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ba71IEBz8K5+2oIH1JzjP1I/VZSfFvh8KgoIPTdTOGxNFukaFl93Qiza6AWcA2T4KO/9Ef0uSoAww9tz5pu7LnCFe12K40wdW735a4vlcmrG4GqhaAmwbG53YJRUlE+Rw+GlgsaAQP6bdwZFd7GQduDMIAzjsVMMAklHP9t/hoWMVlCtraF0roWo0IYSpS+4l6MJtaA1xEryvRdcl4f1Y5eolyvlMSi/hOr8gY/T4LV+N7dMAIi/zN+HTpkclad1KlfjdAvyUId/Lj6IsiGzXnDHN8Yptbm4ugkEXivw3IO4PimXOKOL6TrLY72SZKp7FxtG1HhZoe45ei4XzeA1Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6vMIQaWcPTu72vMF41+wtPG0NAR1OU/idUpBxeNd8E=;
 b=mOCwMrKMT9DdNPWcofTVR2cdv3g/eo0duyP+UTGX6APojnN7bPnFMy8ut0jmT3sxCvzzwvzqR1B8CvTullUngzNl7ntQaEMmEbFlDbLCeBnhyyLRCNifhp40o6Ydt6NsssHCLwWmkQsdI9qyXb8XokTex1/hLjim1axBbssAI87i8/V/V2FUeXT/YQricKv1xgdTQb8Me803ew6OD9eh/llIiZ3m5xc44kDQ4i2tNGnBdEeWOQVv2M+S9kapJNp/8fscv1CkmEtNhplCYgF5t7ffAMMOwOSgPo+iBS2Y6qcxCGJAcH/VmZZo/8aZUk47LFjzMq6ugfV/7D8DM7sYsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6vMIQaWcPTu72vMF41+wtPG0NAR1OU/idUpBxeNd8E=;
 b=LxJLosGOkEEwrEmI6SYsGWLOwG6uwuehkCq39AVZvTl8KriB5RS000G8axBJ7x4XwpHciMfYFyYMaKEv5B7qfhkdXqFCgt2w/TvK+q3EhmYjULXM1ftngEGqhWeVQUVQLXaEpQg0Kdcu3ww9iXoniPigy0DRY5GfTADa7VAQClNg2fNUT1J0CGffiFG9tB95FC/b9rkiyg8MkWLbpyq0fl13fp40xWyUvBRkxivpWD504KGw1T3N0TFm4I6uSgwmqWqU4uO8XhkNpANTorgNiJ94ee/fMdBHTcLgIVGJIFi2l5gr3FdfZgnes57U1d4HTTLHwY3yIc0RVZwJoes1qg==
Received: from MWHPR15CA0067.namprd15.prod.outlook.com (2603:10b6:301:4c::29)
 by MN0PR01MB7802.prod.exchangelabs.com (2603:10b6:208:37d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.17; Fri, 20 May 2022 18:36:58 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::7) by MWHPR15CA0067.outlook.office365.com
 (2603:10b6:301:4c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17 via Frontend
 Transport; Fri, 20 May 2022 18:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com; pr=C
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14 via Frontend Transport; Fri, 20 May 2022 18:36:57 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 24KIaueU054806;
        Fri, 20 May 2022 14:36:56 -0400
Subject: [PATCH for-next 0/6] Updates for 5.19
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     leonro@nvidia.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org
Date:   Fri, 20 May 2022 14:36:56 -0400
Message-ID: <20220520183516.48973.565.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b56de54a-cff3-4760-3e85-08da3a8fb878
X-MS-TrafficTypeDiagnostic: MN0PR01MB7802:EE_
X-Microsoft-Antispam-PRVS: <MN0PR01MB7802BFDC0A0D9B181547F053F4D39@MN0PR01MB7802.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n5ndXlozOJz2Ckjlh07ZoNsq+yaJyw9icNUcwUO9BfJpRWqPUJbXYO23Sx9VemXt4zrMmuQvCgud9CkEITIvvEl3oTIP7KH3YQ7edFaWIFBY7O1abqxuVnvFyRLgQpStWAwmaHBfnCUsKE0pa/HF82/dL+uGHOjSfwM2PCRtK1wwh+YYbJS2fIs6W74rab4baqJjMAOjCjwHnzoCjOuhyFDI3r/alCtHtnPZgiwhplUHkI9eodRZOSiQ6SZ47UN5yf4N6kbtKTcP4AcJia4wCB1foRCy5POY76fuhCEOHJZ5VZsonwqHLU77bbt4GUCPfYmN1q8zbHM/z0t+G3DAFhfvcADKNEa2Yf5/J4bH/2QYZAZQZZYDtL2tnttIiYg9n255RJdrhP+GJl+QrxIruLgd66rSTd2xuJax8w6mC7bT+HWrOrysqnMPfohvYfkMyKhj2yDdoCOY+FaE85A87b8VlsvXiz98Rb9UUdpRMYvuy49Caqc9MiSt1YvhEWAgSOC0RC45gvQrrjxpVMwskO/FSQg78l/VMFt5u/1HAT1In39DqHRhsRGqLM1AIfmHMzN3SEKbj0baQJxS++jGiG1C1y7aDyPC6T6eXlzsjiGsEyiAoDZDUZFTMLLB8XrAARd0XxKnfuDRHHBjWSE2efeTgbIlud3NUgcp+oN1svbnvw3Cwx4cj2zf7UabLDReAQ5ysw/41r47d/lbOlpKGg==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(346002)(39840400004)(376002)(396003)(136003)(36840700001)(46966006)(41300700001)(7126003)(8936002)(4744005)(7696005)(2906002)(44832011)(508600001)(5660300002)(103116003)(26005)(82310400005)(4326008)(70586007)(36860700001)(81166007)(83380400001)(186003)(356005)(47076005)(426003)(336012)(1076003)(86362001)(55016003)(40480700001)(70206006)(316002)(8676002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 18:36:57.4406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b56de54a-cff3-4760-3e85-08da3a8fb878
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7802
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here are some clean up patches, for the driver mersion that got missed and
diagpkt removal. Doug has two fixes as well.

---

Dennis Dalessandro (4):
      RDMA/hfi1: Fix potential integer multiplication overflow errors
      RDMA/hfi1: Remove pointless driver version
      RDMA/hfi1: Consolidate software versions
      RDMA/hfi1: Remove all traces of diagpkt support

Douglas Miller (2):
      RDMA/hfi1: Prevent use of lock before it is initialized
      RDMA/hfi1: Prevent panic when SDMA is disabled


 drivers/infiniband/hw/hfi1/common.h   |   55 ---------------------------------
 drivers/infiniband/hw/hfi1/driver.c   |    6 ----
 drivers/infiniband/hw/hfi1/file_ops.c |    5 ++-
 drivers/infiniband/hw/hfi1/init.c     |    2 +
 drivers/infiniband/hw/hfi1/sdma.c     |   12 ++++---
 5 files changed, 12 insertions(+), 68 deletions(-)

--
-Denny
