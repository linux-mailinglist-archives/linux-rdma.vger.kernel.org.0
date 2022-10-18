Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B74602E6F
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 16:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJRO2A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 10:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiJRO17 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 10:27:59 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2139.outbound.protection.outlook.com [40.107.212.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592C2C0985
        for <linux-rdma@vger.kernel.org>; Tue, 18 Oct 2022 07:27:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBJczMfOvfzLA6cmeotaN2mnGktBx8GMpo433hXHY/ARc7fEXgcY759OrGeI9KInsLBPsC6Ll0vnCQle/WnuRpGe7sMnybsWvo4+pUDp40VxktEf8P/kjncUBj9Utjl2Z6edSVa0a55LHsuyRiXXtvTvEIADvGsea6GnXH8kcqDQKdIpGhC38SzMP3jpFDP3RPXRvwE83dVmcTxm99mAwGMt2H/kLprMF0hp55C0d4X3OzZbmcnBdLW7FxSJBk/BErpWf7T+Er8VcIXPJ3AG1TBn8KYpc15HPd+88a7tL6d1s2yo4fQqzb80ZlcSoM2TYBhhyvH0408mOmMbx8Ddfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBzCi6jX1oznDkCAX80ku3XpCYcwbRqEs3IUk2K5uAw=;
 b=JciC2L264fRpKfaYQom0lro2+TWbgKFhfDgKQeT5G2uc3l38l6uUL/2OZup2qpVu2r3R5lkp4ndycLOWeLPmjG6OUrCejonXnqedAnmhVaBs/giCO+imSQZAEUsSoZTqJeGG765sfTwglirnIGZ1wZvuxG5y46BQfYvLoFr8FyYHrSmB5TBq1PJ0wUddvMV2saE/KqXppI3fIf/GTq5wYb9Cn+Ho50UK+cdztYa6Hbd4FO8WyESmMcbYO8GNiiMdpaWHAtQqt9DMiyhI9KCDiipmYk0fUTtXLQyt7W1lF6QI7Itzll9+RbYQ48zy8z7btwxB5Y6hZSDVtiZZyqVO3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBzCi6jX1oznDkCAX80ku3XpCYcwbRqEs3IUk2K5uAw=;
 b=cFJ7o0chfZoXuOwJ3YUYuKO7oJf/bu65wH0w//rfVG4ddSJkA2vRsrR5Lfbru1v+PWP8AV3k1KAcSa1MHwmN3m9znjYgUwErW/SUb0va8eid3bAtTuRVi8Uf2wZufew+zJpprAm8yPPoLAxIzQlRRVO+cta5o6YcpSTPTovqaNCR10KrR9h5+cbzetfogu6ZVZMuDlZjebsFI8mMR8b3zanzAqsSbfx5aQu1DP/BGDp7xI0PcvNBoJCtWMJZTrQ8mb/aKt3EWCJ8nlciDAwmgHxOxOULbJnn+GGRCype9jPoQsWllbzN1/FYqP0GUYq8IRVYQ2eYkCvtG+MCKESvHA==
Received: from MW2PR16CA0044.namprd16.prod.outlook.com (2603:10b6:907:1::21)
 by DM6PR01MB4028.prod.exchangelabs.com (2603:10b6:5:26::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.33; Tue, 18 Oct 2022 14:27:52 +0000
Received: from CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::f3) by MW2PR16CA0044.outlook.office365.com
 (2603:10b6:907:1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Tue, 18 Oct 2022 14:27:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT103.mail.protection.outlook.com (10.13.174.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 14:27:51 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 29IERorh674440;
        Tue, 18 Oct 2022 10:27:50 -0400
Subject: [PATCH for-rc] IB/hfi1: Correctly move list in sc_disable()
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Tue, 18 Oct 2022 10:27:50 -0400
Message-ID: <166610327042.674422.6146908799669288976.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT103:EE_|DM6PR01MB4028:EE_
X-MS-Office365-Filtering-Correlation-Id: 298b68b5-d1bf-493c-76a8-08dab114f07b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aohfk5idR4EAZa8X3fynpku0gaI2wYyG6wg2Od5SWYx/ClyO6z+Qg8RhfFLRI8TsS2poR0S6Cd2JnFAUZP85gshBE3vHgf6cMcK3vt5G20H+MocmCc0RMZeNRYI84gDfngWwCCqZRMaMhvtP/pp5lQcVxIsWoKojis+fxzj0cXlzkY7H6DFO1NMfGK/kuBvEqZ7PRtMTR1dIzJgqE0XzA/aHMIGMvZj4Hm5klvqodlhunk4AQfm9gEz8sTvdZOzjRxymyYrmVT1N+/NPKKdMNEpGDWL983QxJdZJlkhk+KVChhqeP2tmp7e5DOlipUKxElnEK7uA832/ILkXUi10OvjSa4aYFmHDcSqao93JQOZl4ty2m+ux1UXdry/AM2XiMa2OElrzPtrKfsTazluynRvY6dkAqVE0jSraAtdnyQaJ1w7t7dMfQJxQNRh+9lxru83o/g1uEQ/hHuUtzHSNHnZJ6ZKVIrKR8L8Dx7v7TbNxkkg0uMPpjlOO4kBk03suwa2gHzoQbOzHL7PuOWyJaiVnfV+sYXgmVdupooW5i5MQC9OI8XR9Gcr2ijg1+vv0xL1jx47VTsstutPViXMI+v5G16AA9h4gCXVMtjUv4jg2gFD4OnAVs06DjO9jSOCmKdQeAGYB80esGwut5gGmlx1fv/dTfPQP6ZHP8eBovRuAwgzZtaUUL/DNuSe8lxuV35Z2e/QVbzUdKAd5Z/CIfs+pWlN2kKlG7VqhnSLWE6yk24pK/MTtNdja2HvcmlgnG5NhUgq+xW53oO/UlqT6uA==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39840400004)(451199015)(46966006)(36840700001)(103116003)(86362001)(81166007)(356005)(2906002)(47076005)(426003)(83380400001)(55016003)(40480700001)(8936002)(5660300002)(44832011)(7126003)(186003)(336012)(7696005)(36860700001)(26005)(478600001)(316002)(82310400005)(4326008)(70586007)(70206006)(8676002)(41300700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 14:27:51.6713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 298b68b5-d1bf-493c-76a8-08dab114f07b
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4028
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Dean Luick <dean.luick@cornelisnetworks.com>

Commit 13bac861952a ("IB/hfi1: Fix abba locking issue with
sc_disable()") incorrectly tries to move a list from one list
head to another.  The result is a kernel crash.

The crash is triggered when a link goes down and there are
waiters for a send to complete.  The following signature is
seen:

BUG: kernel NULL pointer dereference, address: 0000000000000030
[...]
Call Trace:
 <TASK>
 sc_disable+0x1ba/0x240 [hfi1]
 pio_freeze+0x3d/0x60 [hfi1]
 handle_freeze+0x27/0x1b0 [hfi1]
 process_one_work+0x1b0/0x380
 ? process_one_work+0x380/0x380
 worker_thread+0x30/0x360
 ? process_one_work+0x380/0x380
 kthread+0xd7/0x100
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x1f/0x30
 </TASK>

The fix is to use the correct call to move the list.

Fixes: 13bac861952a ("IB/hfi1: Fix abba locking issue with sc_disable()")
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/pio.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pio.c b/drivers/infiniband/hw/hfi1/pio.c
index 3d42bd2b36bd..51ae58c02b15 100644
--- a/drivers/infiniband/hw/hfi1/pio.c
+++ b/drivers/infiniband/hw/hfi1/pio.c
@@ -913,8 +913,7 @@ void sc_disable(struct send_context *sc)
 	spin_unlock(&sc->release_lock);
 
 	write_seqlock(&sc->waitlock);
-	if (!list_empty(&sc->piowait))
-		list_move(&sc->piowait, &wake_list);
+	list_splice_init(&sc->piowait, &wake_list);
 	write_sequnlock(&sc->waitlock);
 	while (!list_empty(&wake_list)) {
 		struct iowait *wait;


