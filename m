Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01E9784379
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 16:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbjHVOJQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 10:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbjHVOJP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 10:09:15 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2098.outbound.protection.outlook.com [40.107.212.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DF310EA
        for <linux-rdma@vger.kernel.org>; Tue, 22 Aug 2023 07:08:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enuGwbD6HLpaslOJ4JP+NhPrYnQz1aDjD7yfl4mJriqL94K9KSY2tARFztYIo5sChsTcDZVYu80jiVH4fvqLJfQoJ6O4j8deW2m0TeJ24ZjpCckGuo7iV6kshhwuubEb0O0Ng8cIB+IzMWzvt3QSY6N+25+bMvCgHjvqGo5X6Saxt8lo1wvm/sWtQ03gsVrp2H48ReizBSsKeWEEnvLBJ1vFRRXXfJlLjmfTLD+llmKh+75DIVHWnetQW2+W0st+spCsU86fxhgTFO9IfhHMUCYzgHMI4cQcyx4buKG8/r/h23281W2x8+kwCHXRWXnteJty7wPXo3As7VKxy2v3ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BengDRzKmntNQccYDQb6oI0TyuvbAEqly72OI/Qr+gE=;
 b=fTKhUHBThBeqSMZF9fcEzVQznLy13HVz+NZ71GNdq2kOBqOWjmpc4DCA1bldefDE+SMGQPU9Shib4Mf8ID5TQ0VWhw2HiZF6naWxIBvvdSUxBvA5cgK1tSWTXiF0GiH6lA4heWWY03yYpjwgyzWxNA3a/aXEYaSMrcfp6ozyBjLfMq8KRr/ZtXfZWmRSmb4EaOW1KcGWtkOMfv8xycAuvH91/QMcyTzAm9kxFzFJoXZ4bQuBFmeTCmHClxQI3gCdQ7gpjWSTsCGPsMLFunZ6lLoD7zoIiy7NsZ7ujk6N9POQF2BhtmmDJt8TcXsPTbHIWKHcNWitTi7lBJh9nZO5UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BengDRzKmntNQccYDQb6oI0TyuvbAEqly72OI/Qr+gE=;
 b=DnTlrDdjElhCtgskYOo8VpSTkCxskKvaSEoRjO1MpTkVQy2pE0HOUBvvL/RmZRjcTIqtx72WGT6IpHyTxVZ8K7qLrYNZl3x7Erfx4bov59nrCgvnMWwVvaGTaPS328znfCMfTEQYreBfkLJufUM7Eo/bBXS5KGVsowHLZaet/Tk3estFm6BnRg5KTV+ccxI1aK9aLaVl/uYbXBoWqYmE7ENf9bXeUDTlOW5QYmro/BLXJaaKkCKnuvD/7tE0r+ngCJqliK62EgdLBMHt5/AAgKfgprG75ckmAgDgJmvN2v/tSV4PnNGkuwiPov/mDwXD44rq6AulLuRObPbIPsQTOw==
Received: from MW4PR03CA0240.namprd03.prod.outlook.com (2603:10b6:303:b9::35)
 by SA1PR01MB6669.prod.exchangelabs.com (2603:10b6:806:18a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.24; Tue, 22 Aug 2023 14:07:50 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:b9:cafe::b4) by MW4PR03CA0240.outlook.office365.com
 (2603:10b6:303:b9::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Tue, 22 Aug 2023 14:07:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.2 via Frontend Transport; Tue, 22 Aug 2023 14:07:49 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 37ME7lYb1856181;
        Tue, 22 Aug 2023 10:07:47 -0400
Subject: [PATCH for-next 0/2] Series short description
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        Douglas Miller <doug.miller@cornelisnetworks.com>,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Tue, 22 Aug 2023 10:07:47 -0400
Message-ID: <169271289743.1855761.7584504317823143869.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|SA1PR01MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: ca48103e-adc8-46d0-c2d0-08dba3192b00
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g6SPG8TtiLD83pO9PqlM2/lEPgbayqxD0vj+d2Ho+XKfvYbZynZ0+N/MOsOS3YnPe7kSCHtAqxuZ9aSmUrGoTfLl0vUE3Pa+iiVd7ee5U6Vi0pQLh3nKdK8/I9GkthgQo3wTIgVg+syuJoAEHbHXFRW9FDxPQk0nUzmGCa1rFmRFdb/jBtKL1UOXhdYT/Fwk8j+vs7xrmEZSqVv6/3BEVylVN7nI6se64Lq7AeUULaFAhslitj05aaC5O6oFVugLF4ZeQ4Jk6y67Ey7w3d+MkL7Dg8egm/7ZCxJB56OFqkPnDf6ebff2c1LTm5wSude3/cr3eJEs6k/GqzxRo7Y+TT97mb4s3l3Al+47XwxYBVxL8otSSb8bppP/RlO7SNBDbHbQIw2XLEnn2BW0GBDxnkL8TpitU16DsQYjRnRi1zn/b7iI03X9ATHPKyfdfUWy+/X2mmrsZWpAbUTQDgifey1aXqx4shwyNs8leiHvAP0GfO70OMNai0CeQSw6SBr86Z6J8LlggUbQIbHkrJQ4GnYeliQSk0Dk30P+FsxDBRC/YbRlvdynpA3hKyXhixm8qH8cAtehNXDUMgGKJvoKRI4mHi01dx5V9Zm6f4ObRT8zDbONKnAApUFsTnVKoKW6uHKiQwBtSafcYMzlxu8a9B2felCogJeX2Gv3h40nVfrJIbtbxznsFpUD/pZ7/HpKfgcYh4N9LDRHWdfgcBoG95SgresFWjwCXRZk28btf5c=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39840400004)(346002)(1800799009)(186009)(451199024)(82310400011)(46966006)(36840700001)(54906003)(70586007)(316002)(70206006)(66899024)(8676002)(7126003)(8936002)(4326008)(41300700001)(356005)(81166007)(478600001)(55016003)(40480700001)(83380400001)(2906002)(103116003)(47076005)(7696005)(36860700001)(86362001)(336012)(44832011)(426003)(5660300002)(26005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:07:49.1224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca48103e-adc8-46d0-c2d0-08dba3192b00
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6669
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Much scaled down version of Brendan's previous patches. This doesn't touch uAPI
just refactors some code.

Small fixup from Doug.

Would have sent a couple weeks ago but had been dealing with the isert
regression. Reverting that give us a clean bill of health. If too late
for 6.6 can wait another cycle even. 

---

Brendan Cunningham (1):
      RDMA/hfi1: Move user SDMA system memory pinning code to its own file

Douglas Miller (1):
      IB/hfi1: Reduce printing of errors during driver shut down


 drivers/infiniband/hw/hfi1/Makefile     |   1 +
 drivers/infiniband/hw/hfi1/chip.c       |   8 +-
 drivers/infiniband/hw/hfi1/hfi.h        |   4 +-
 drivers/infiniband/hw/hfi1/pin_system.c | 474 ++++++++++++++++++++++++
 drivers/infiniband/hw/hfi1/pinning.h    |  20 +
 drivers/infiniband/hw/hfi1/user_sdma.c  | 441 +---------------------
 drivers/infiniband/hw/hfi1/user_sdma.h  |  17 +-
 7 files changed, 510 insertions(+), 455 deletions(-)
 create mode 100644 drivers/infiniband/hw/hfi1/pin_system.c
 create mode 100644 drivers/infiniband/hw/hfi1/pinning.h

--
-Denny

