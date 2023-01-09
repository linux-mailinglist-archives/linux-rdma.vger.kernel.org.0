Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A246F662FD3
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 20:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbjAITEY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 14:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbjAITEN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 14:04:13 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2120.outbound.protection.outlook.com [40.107.243.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130D138AFB
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 11:04:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btWlHcyU/N4Y4aDRUmbqQIRVMm4LqzlvqIpLVJjHNpJg6OsU6rVopINN+a1B9Kxn65JKddpQr0js3I3kh7OxdhA5arR0V48iGvd3vlT3HP2F5H8HzPDV3qzThHSQRe5NY2ED6+l1oEi6AX2eqfcQONxN9o+g2Ae+IZnCnnuCAFJ1srzpNCqgwi9gDuQQZCdMG7+FirnmgLQQqPEOsOgUfckjfbmhEojqswJ3USGV746Kr+zVzu0Ejh+EysBm4qKNVffmmHCwfPvUmkK6i0wB8f0n4/AesXIjXWNqb3TxKkcjibG3EI96ujwlyEjbo/czJO2T1hb1tBJ9dRlH5srvqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iKaT6tFy8MyfXTqFBq7FdLI/3o4UJeqe6+x02Qjsi4=;
 b=Ad34XPHGXUWdnlXvjPMhy425/nSaDHkZVJpS0kSRHMTp9LJxSv6q/XyqxRM2S8K62UZ2vq6Uifvx7T9aDvC3QUw+Rk/5dIeY+hk704piAHgvzAo1tLO3u+hgd2+Nifvc2637WtaNQCn9Xf/6krXMrkdMA//YLYTfh4sRupquEMzBmlE4mgArmAcnNZ5xsgFnrIvASbLIdnplrNAjCbieQApP8MDIO34UZmmedBOyDRKJgGginmmN4UO9xmCkIWnsIG4Npo4Cq31r1KP2+ovvwuocVkW1xWjTlW34IXth5wYrOSPcHZZ+APrd6VNYFzas4ttpHJ3zMFEn4Xob7jHgIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iKaT6tFy8MyfXTqFBq7FdLI/3o4UJeqe6+x02Qjsi4=;
 b=c2ASNwt9x2BxHkdoI4O0jmNvkQ+LXHK7xgIJxgc/L/Ev9oKc1zdAwTBr94HmauY3mI4vl0Fn612L7PfdAE9WL8nttrhSjlUNNy5b0AnLTw1lzxpgMLhtNuPTRmq5qAzkxHZUyJnnFTQWkgxibqtTIY2cEb/uABh3vzMW9r/kvIJ25+gJ/h0sxIrFQEC6qxJNRXSPnyFHSv0DD3b0urnybyLVbXf1yIQ4lf86EA6sQ9BhYiC9gN9yOGd0NmRcQlv+ZihFvl7kWxq6bu9UkYBp9TfaNfGXwEg2OIj5VdSz2BzCPsF3Y5BopVuWQGSUf8mxlhQdi4jRve72b+19PdL6eA==
Received: from BN0PR07CA0030.namprd07.prod.outlook.com (2603:10b6:408:141::13)
 by SN6PR01MB4973.prod.exchangelabs.com (2603:10b6:805:c4::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 9 Jan 2023 19:04:09 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::1c) by BN0PR07CA0030.outlook.office365.com
 (2603:10b6:408:141::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 19:04:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 19:04:09 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 309J48dL1477912;
        Mon, 9 Jan 2023 14:04:08 -0500
Subject: [PATCH for-next 2/7] IB/hfi1: Assign npages earlier
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Mon, 09 Jan 2023 14:04:08 -0500
Message-ID: <167329104884.1472990.4639750192433251493.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
References: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|SN6PR01MB4973:EE_
X-MS-Office365-Filtering-Correlation-Id: d7609788-666d-4017-852d-08daf27449e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wOs14EnKBlfJTyeA2mDTBInJ8pDKsCf39T18FZ4BS0taspRjPTWvfz9duOdLdDd1dRbMw4gSnzt5e1cv4EJ0WIYAZRxm/eNASST2YGgVISj+ZEICRAMEXBHMcANAW0j3FBAglZbWDzaEAHybPi7x0XthfgfgOXRIA52lGJYwI97fHNCb3pE3F3D0BsHyv/Nil19QJrDGRwZ1mYYfCpyApAgQWG+DcPRnIbjW9W+9kRYgPAchX0R6HCVf4REzrV40mZCmKhoNpCgpuj7kMmLrWGi6CAmlFi5U1WXCagfaCTcqltovi0GF2Z9zI6T2AZMUkyrdr7YGO1c8y3o33F6iBJhIDs51j/4/xetdYQUfl2xZNZtB44VY+9en9O12X0P5F1RaFOpiwpsHfC3jDlt5TVxxaoNMTFcAsdaPJjyLbmvUJy3FVDoEw7prvVar/21ZKRQ48g9IMuL2stxIEPiIlqSD/Oyg/rFAciPb93I/JoRWOqwg4rbfkzHthrycadmL41krJHrTY/Qjg8KRzq9+DcFQNTKxQZqn2R6B+tMG6TBGxw55CbuWXxs9RVbW0RrOrpEZBA4KmzezvSu99Z51uPaXpqjOUSJAnGeLeEJbdKDbnzQj3x3BohEjpuw5FUNV/YfoQ2BzEQlwLe1hie2ZssF+cG2Dg/cegUaGmhxS/Nb8lzdsobmkNQtvnQiiyUJBnhIG+uMrwZ8uCk1Y5o3rPA==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39840400004)(451199015)(36840700001)(46966006)(83380400001)(2906002)(44832011)(82310400005)(47076005)(336012)(36860700001)(426003)(81166007)(7126003)(5660300002)(55016003)(7696005)(40480700001)(26005)(186003)(8936002)(478600001)(70586007)(70206006)(8676002)(103116003)(41300700001)(86362001)(356005)(4326008)(316002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 19:04:09.5522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7609788-666d-4017-852d-08daf27449e1
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4973
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

Improve code clarity and enable earlier use of
tidbuf->npages by moving its assignment to
structure creation time.

Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/user_exp_rcv.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
index c2099510817c..0e51c95d3f1d 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
@@ -159,16 +159,11 @@ static void unpin_rcv_pages(struct hfi1_filedata *fd,
 static int pin_rcv_pages(struct hfi1_filedata *fd, struct tid_user_buf *tidbuf)
 {
 	int pinned;
-	unsigned int npages;
+	unsigned int npages = tidbuf->npages;
 	unsigned long vaddr = tidbuf->vaddr;
 	struct page **pages = NULL;
 	struct hfi1_devdata *dd = fd->uctxt->dd;
 
-	/* Get the number of pages the user buffer spans */
-	npages = num_user_pages(vaddr, tidbuf->length);
-	if (!npages)
-		return -EINVAL;
-
 	if (npages > fd->uctxt->expected_count) {
 		dd_dev_err(dd, "Expected buffer too big\n");
 		return -EINVAL;
@@ -195,7 +190,6 @@ static int pin_rcv_pages(struct hfi1_filedata *fd, struct tid_user_buf *tidbuf)
 		return pinned;
 	}
 	tidbuf->pages = pages;
-	tidbuf->npages = npages;
 	fd->tid_n_pinned += pinned;
 	return pinned;
 }
@@ -273,6 +267,7 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 	mutex_init(&tidbuf->cover_mutex);
 	tidbuf->vaddr = tinfo->vaddr;
 	tidbuf->length = tinfo->length;
+	tidbuf->npages = num_user_pages(tidbuf->vaddr, tidbuf->length);
 	tidbuf->psets = kcalloc(uctxt->expected_count, sizeof(*tidbuf->psets),
 				GFP_KERNEL);
 	if (!tidbuf->psets) {


