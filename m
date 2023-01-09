Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0103662FD0
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 20:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbjAITEF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 14:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237323AbjAITEF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 14:04:05 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2113.outbound.protection.outlook.com [40.107.244.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535FC3750A
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 11:04:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wja0Cne//ZwMEoMOnSG0trN3edD+cnK9oz06rWCPE93BjQ7aVwqQt1w1ICrCdJhcJxcH8MEO6wTv5yzH1Hg6MWcw3CpZKGHc2fqTu6gRuAzoTWEeCh2I7ip46KLSH3ufV7TJFIfGeA2W6kAUMAwsOSxMuZ/e96J9DHDE8vDs2ZIujhi1sUF8/ghSKZSQrv7keIXsTF+/PwRIOQ4QzoGiLBwvGOX1HSiCGlbZOtP1f9VmagbfKd/Xtwu8pNMAbdIJpbfQz+7aJmpAOI8UpqZJ4dMDi7AOoENEYWZo8JHE2G5nJT3vFg+fjq4vmvj8slzO0KEOlz6fd+k71xcQ9QBHsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGmaVfJFaSPVMuDb9qIhPcGsfQ4GXXir2onGO660pgc=;
 b=hfb+Urx+wV5IZQu4Qqoo2L9rtIpOOtLy31RnPbvi5AMpV9+r6nSSOoYu+3wfmpOH/Qhvx1SvZHetrN1laTqXOu6vr9Vjv/1IbTMeyufpYol4lqx37WnOjpiff57b2ilg9EwHeoHuLJjbkBFdd7R0Sjbzj5TQSPm6oroWo2Cscb0oHg6ToYqbaY5/t4E4heCKk0kbbfUYj+yo5XgFLNgdMkOEVU3bgymbQZCMsacaL3iJhZXt41KIPFBlxaoIIYD2N/wJ7bjdFFRe8TPa5vxFxqptEqbXEcjwkMhXmfBo4oqnvFfG3FCh+VPxnuAgcJMRX0iIPydmPzNAkluHSLIFtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGmaVfJFaSPVMuDb9qIhPcGsfQ4GXXir2onGO660pgc=;
 b=a0ZvdBdXBZOQfrxikJ3sQcfl0Qh8f4ruS5VJVjlvmBEMIzhtrnpex8ZF+GEpncBVjn7qZgCVwyJmt1mm0d0ZNOi2hgT3GnatWAH+IvvUsEFAN/fYgOavLCvrbMr6hTvAgGaTaPx5OaNQgDbU5/o/kcV7cQDRtPZl0Dtn+IR4WQoTXujoxJk4+D+ZpQQbfnq71sI5fxP4rz35Z3Jm/2EejXSavVB/GDqI77r6g7hAliXHlgUG0kI0tdtYAzIwxbpZdS+/O/Y6SSBKclKi5QSMBuyI4dDcKQ56RXg2EaJvUBUhl7O+QwI1enKahO/7u/7ReBl5a39R1W4iS24eZbGTbQ==
Received: from BN8PR15CA0013.namprd15.prod.outlook.com (2603:10b6:408:c0::26)
 by SN6PR01MB3663.prod.exchangelabs.com (2603:10b6:805:25::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 9 Jan 2023 19:03:59 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::87) by BN8PR15CA0013.outlook.office365.com
 (2603:10b6:408:c0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 19:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 19:03:59 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 309J3wBi1477889;
        Mon, 9 Jan 2023 14:03:58 -0500
Subject: [PATCH for-next 0/7] FIXME and other fixes
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Mon, 09 Jan 2023 14:03:58 -0500
Message-ID: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT041:EE_|SN6PR01MB3663:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f1a4a6e-ca45-49a3-4269-08daf27443bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aAKmslOLG9LAuAzHHGMDqKEg68AhzqHnVE9KmxP4rG9ReyooGKLzgolnZFG5s947WuT7jgmg2FaHukfdEjqL9uawKClrQ7tv1ViF8idk72Wddode2o220LwRJiFu+MwXCp67OiVliMEgu09A5RfgOVLTBkJiv0lQJV0SGNSaW/+VLXF+djpBbNnPVR0QNR8STGmAuQagj9MUCujatcteDniFcOpihGBfgP0bw28hRDaGrzjAupA6b4XQKzhur9U7llwk+FjS97KkjjznKSINtzJM4O1kinl3N9wQuzNO+brc/ONMDgu8g3vhCmWtmxlYs1uh7uDChtz4fDXQtwCpCGBAS/DdWy7Gdmki8rx94fOIV1cS6b0xu4pkCJVxgCMjsQiQjfoAeHEG8R1nOg8qUnxeVUYCcFKIw1cFEJNzQHHgkGyedoP/bAv43r9z61FxZd+rx+gdVk2b2VVEcq24VBctyqbXQL/SMo3Po0w3IUpaoDPoCdg8Iiguy8K5PG5qv4gixaz3rR1gePDxv2hEWZEwq4DBxD6N090VWepNxEf/GziztXRBXD2+Ixpd+pz+6wOZgkKFgTV9H18zcF/vmYTVZxR+Cfx+Km3Ln0EL3elNPUCn6rpazHSQFfThaehZN+R28lWrb/Cekuunt/YbwL1dAI5peA0hNS9uLWndJifTegsWGmwA8HLuzsn1UdgZJDh0747bcAmFLhMAKC4egw==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39840400004)(451199015)(46966006)(36840700001)(82310400005)(8936002)(2906002)(5660300002)(47076005)(426003)(41300700001)(81166007)(7696005)(70206006)(4326008)(70586007)(8676002)(316002)(356005)(44832011)(4744005)(186003)(26005)(40480700001)(7126003)(336012)(55016003)(86362001)(83380400001)(36860700001)(103116003)(478600001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 19:03:59.2417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1a4a6e-ca45-49a3-4269-08daf27443bc
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB3663
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Dean fixes the FIXME that was left by Jason in the code to use the interval
notifier. There are also fixes for other things like splitting our counter
allocation to better align with the way the core is moving. 

---

Dean Luick (7):
      IB/hfi1: Remove redundant pageidx variable
      IB/hfi1: Assign npages earlier
      IB/hfi1: Consolidate the creation of user TIDs
      IB/hfi1: Improve TID validity checking
      IB/hfi1: Split IB counter allocation
      IBh/hfi1: Update RMT size calculation
      IB/hfi1: Use dma_mmap_coherent for matching buffers


 drivers/infiniband/hw/hfi1/chip.c         | 59 +++++++++--------
 drivers/infiniband/hw/hfi1/exp_rcv.h      |  5 +-
 drivers/infiniband/hw/hfi1/file_ops.c     | 81 ++++++++++++++++-------
 drivers/infiniband/hw/hfi1/user_exp_rcv.c | 55 ++++++---------
 drivers/infiniband/hw/hfi1/verbs.c        | 81 +++++++++--------------
 5 files changed, 146 insertions(+), 135 deletions(-)

--
-Denny

