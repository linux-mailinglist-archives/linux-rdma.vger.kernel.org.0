Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D7952F312
	for <lists+linux-rdma@lfdr.de>; Fri, 20 May 2022 20:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352914AbiETShQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 May 2022 14:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352917AbiETShO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 May 2022 14:37:14 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2135.outbound.protection.outlook.com [40.107.100.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CED86AA61
        for <linux-rdma@vger.kernel.org>; Fri, 20 May 2022 11:37:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQ32t8gi6fZ2hPq/dWeECQLVafsU/C3YMrjLCKyaL3NfmIRlyq7C7GuXPdjYwW88fi+1py0ye98EGGtRZsxZ62h6mBBdqMiUtNuSs70FTy151fiRv4ClqtuR7lF8vBeS6vNsWsEecuKXzpPPW7s6ttZYSSzue4bnNY/Y25AFqnLj5HyRLvozqBhvkY2TRI7EEJ8jueR2qnL+4nCGF/KzKsqD+ueK0pAr1wZgCiiif49Uj+32hUWLnUNyDEcZbVdjx0jJ+xzGgwvizHyRy6tFk7HEQTqqMKIEj6cMlc+GbEh3UmZuiMOqZ5OjwZVUYJzSr3laj5rhCZRJ5R8WSR83kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aykMwosWzNSiUIwhU8Moz0uN3rzW7qCsx009eetH4P8=;
 b=FbmOQWwKuFRfFiVM6dgXZXPNmsbbpfmmrVRTc5P8Y/5J+2xipGXnzpfHXq6wHVMsFLLrsgWTdB4HA4PiCvTok2Gzm6z7nWaQGllGTAS3Gs+/DVGUDbO1WrmswkG1hfypmMW3sjumuyRLO+/U8qQ86SrnWdSVsJvltcONGUbFiPottMkgWvlBloSbJh5HjDuMGzkPww9nUWdwPWUo6bpZ092di5BHyhwcnjgnGg5ow0O6U6o1JLBdrNEJo5xzyaXBcFklqiBG9DIrB02MyumH6NrcXjDypqteiYWhEp6FmfS0Y8gcG8P/8WNUjY6Ud0FSzL7EEm0ox6IsYHoxIJw4Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aykMwosWzNSiUIwhU8Moz0uN3rzW7qCsx009eetH4P8=;
 b=GsBB1m2PFFDkYIPSZS3gDoUOEDIjaVN7DujDBPXRzaWRyAUAIOgm6sed301gp6/RWhSp+b+NUkuVBFwQgTKZkW1mKID4ll6Cfy9r0bKpys5MDur+pleTMLq1UgMTWeASlbtBZKtXufY2IJ91EgeBeudSIpCFFOQlsYyauwpuawnu2Q1n0ZQ5BP5LkYaWiwOrS5unGl1Djt/VCvEFUUXwYDZhoujWxIWfWWq9pDDxfWPAVCXg65K7hGYpQrzBmL5dejujXaHJFV+0TWmdC1PMew3I1dhw657xNZEp8E+bDnjhE5+dpGypLEykR5XNZ7T2etGVjqmgaIgCaQCQwUcsCg==
Received: from MWHPR10CA0022.namprd10.prod.outlook.com (2603:10b6:301::32) by
 CY4PR01MB2533.prod.exchangelabs.com (2603:10b6:903:75::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.14; Fri, 20 May 2022 18:37:08 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::67) by MWHPR10CA0022.outlook.office365.com
 (2603:10b6:301::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17 via Frontend
 Transport; Fri, 20 May 2022 18:37:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com; pr=C
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14 via Frontend Transport; Fri, 20 May 2022 18:37:07 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 24KIb66t055428;
        Fri, 20 May 2022 14:37:06 -0400
Subject: [PATCH for-next 2/6] RDMA/hfi1: Prevent panic when SDMA is disabled
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     leonro@nvidia.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org,
        Douglas Miller <doug.miller@cornelisnetworks.com>
Date:   Fri, 20 May 2022 14:37:06 -0400
Message-ID: <20220520183706.48973.79803.stgit@awfm-01.cornelisnetworks.com>
In-Reply-To: <20220520183516.48973.565.stgit@awfm-01.cornelisnetworks.com>
References: <20220520183516.48973.565.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed582c3e-b845-4854-0a99-08da3a8fbeb0
X-MS-TrafficTypeDiagnostic: CY4PR01MB2533:EE_
X-Microsoft-Antispam-PRVS: <CY4PR01MB25337A45394A043B54A8A3F0F4D39@CY4PR01MB2533.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QmYs+OXEhm0wlV4PlqG/ZcpVBdnA1QpOg6mC+wbXW0LMzNPBFbu5F0ZdRw4WoWIo3ijS+sJVQnS5+bK/ViuwHV9OmTL4rMSa0y0mGItgahEBeyljYy1B5tjInCJqOb3lhJXfH39Uaamly6m0XXFUWJ9yjpemwrSCl7eZAl/GKFIHsaYHdq9CCceEgoNrALkGgC+FIkcyZ4h+j6swnyRpA01I08R4vdOklfGixqhQL6DAWHgIRG6LdOqkOW4k7xfsH9wntWDuodIOZqlSTizcQKjIMLE6TeLCwFfWb7/lOu4exSg7Op7J1wxcNEuDeFD58yqOjQRzW/ykTtZdqMfqrnDQOpTvPpf6oCrzuTqLpkAnCSTAbKV19DS1DhBeGD2GlET4L9GMGEUxa4/pOBhSLSJ83NtJET/APE7WdHIfoUlXANgi1h3etuaEQOQZlmNdeaqT6tUUKKS726DMhUk+nJ4c3yb8+CA4Ayw05CMogtppz3ii7dbVNewHAtNQibl3GmQKPdcmAZD5vn7HFsyjsw3SIexW95ydC86dX9ayXDv0MJcp4R1rzRFmw2BciFdFYSSzyahvNejZbxegME/Ehyu7cYAWDyzaznjskpfrvQ6dzaD8VvkHMbduJooZ0LWY4PkKE/dhzavWfrXJAvlt2ZB2utr7gSfRIRhKfDbqCWigcPAGNElHrl9UEUcQW0M71Ah+aRXLtjKIFauuAyVEBQ==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(346002)(136003)(396003)(376002)(39840400004)(36840700001)(46966006)(8676002)(70206006)(81166007)(7126003)(4326008)(7696005)(44832011)(86362001)(26005)(508600001)(103116003)(8936002)(2906002)(83380400001)(5660300002)(70586007)(316002)(186003)(55016003)(107886003)(82310400005)(36860700001)(41300700001)(356005)(336012)(47076005)(426003)(40480700001)(1076003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 18:37:07.8570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed582c3e-b845-4854-0a99-08da3a8fbeb0
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR01MB2533
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Douglas Miller <doug.miller@cornelisnetworks.com>

If the hfi1 module is loaded with HFI1_CAP_SDMA off,
a call to hfi1_write_iter() will dereference a NULL pointer
and panic. A typical stack frame is:

sdma_select_user_engine [hfi1]
hfi1_user_sdma_process_request [hfi1]
hfi1_write_iter [hfi1]
do_iter_readv_writev
do_iter_write
vfs_writev
do_writev
do_syscall_64

The fix is to test for SDMA in hfi1_write_iter() and fail
the I/O with EINVAL.

Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/file_ops.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index 1783a6e..cb65f31 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -265,6 +265,9 @@ static ssize_t hfi1_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 	unsigned long dim = from->nr_segs;
 	int idx;
 
+	if (!HFI1_CAP_IS_KSET(SDMA)) {
+		return -EINVAL;
+	}
 	idx = srcu_read_lock(&fd->pq_srcu);
 	pq = srcu_dereference(fd->pq, &fd->pq_srcu);
 	if (!cq || !pq) {

