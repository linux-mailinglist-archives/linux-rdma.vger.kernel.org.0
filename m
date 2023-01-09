Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D965B662CC9
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 18:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjAIRcQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 12:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237287AbjAIRb0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 12:31:26 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2115.outbound.protection.outlook.com [40.107.244.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24E1B87D
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 09:31:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vs0Qzu1aEc24nprAfHwST4xhlkljEqlTYg7UZnV2YFTEi4kg+l+/j+WzVEV+rWjK+2n9BUE+SUVgaU4wJYW8HdJWrfCRDbaTbKRPtGoypH2gPCl+7DPYiVnpBUjzlYuzLMGLpB5U4MAzSwChK6dpgwlb1sNWFEOUFBCGUa+s0X47wO/vQHhkOi/6nGEEQlbRF8S3NJoFsVvLfRCA8GSmtZVN1yVzYox0OJWYFWVRfWQBhyYku5D/3I3Ft8SPd2ra44vuRfOSSPpLi068I3BxteAVNO98p7ByfuI1zeAOlwreo0t7BqKuvMLVuuoTmfg+Tieo2JAihvt+be9aNnUnrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7v/MUyz+2qqaJHcQD34muWmkGmqeSgKIz+ETnc5lts=;
 b=EfOES/PJJNCsEF9Haqu7+9B+OYKRn3JslzXFqzHjfNg0QuaipBtZzsoERQLk09VI0DLXTv5duwLzLoKNC8VNZcsy19uD+I2W5dybPFX2FPQYgEm9WCdpioORlmisCC3fHLyhL+KNxoDQtzeM+AkVRfNk/icxIjnNmTAQQvuEdwtcnkW3NkQXTjEjfHZsiwtPVwS3rvoeFtIqsAThTD/2EOYWuxJdRVW7mSme866z9bn/bij3poheFPpTCYXNUujwHEJJh58oUKhCqXfx9YiOwXZvFEEZ5ir5ec2fu4DXIpud3UBzuKQIkGQmudLBQF3NOjthKMa11IUibj04pPo+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7v/MUyz+2qqaJHcQD34muWmkGmqeSgKIz+ETnc5lts=;
 b=DS+VaEzW8+VTEtljOmg8/rJG+KG9OezJXlQwKnLm6m5PdAJWebJRhtKf9GMT8inVh94ng1MYwGS3GY76CY1YlLATeEJlQIyRdxvp8YFNrC6ZbKlQ5WH7pAmkkpXMsEJWfhnLg35B4gk8zSvJsHfbWL7j3o473fGuY3pmandpOxEgNsUY26KNfayuCqJcZzjIsRHGGSPmZSK7ANCxPT4ckwqhf8GW3qG670+ZOPr1ENxfG12i+SkeANoJ1pTWEVN745HaHDtWy6Zju41IpoQm+J62A9s9fVYBEme2sT4nFA6p5C5WWkSCl85y+3821AqWkjLhA+OeBJaPd7+o+wI4Uw==
Received: from DM6PR08CA0030.namprd08.prod.outlook.com (2603:10b6:5:80::43) by
 SN7PR01MB7924.prod.exchangelabs.com (2603:10b6:806:347::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 9 Jan 2023 17:31:22 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::9c) by DM6PR08CA0030.outlook.office365.com
 (2603:10b6:5:80::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 17:31:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 17:31:22 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 309HVLvE1472607;
        Mon, 9 Jan 2023 12:31:21 -0500
Subject: [PATCH for-rc 4/6] IB/hfi1: Fix expected receive setup error exit
 issues
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Mon, 09 Jan 2023 12:31:21 -0500
Message-ID: <167328548150.1472310.1492305874804187634.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <167328512911.1472310.3529280633243532911.stgit@awfm-02.cornelisnetworks.com>
References: <167328512911.1472310.3529280633243532911.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT003:EE_|SN7PR01MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 3599c980-2268-4e13-4dd9-08daf26753a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3WXL8zIh3qxUkdBPdHi2mot5zEVjmAB1MtKDLH/WAWrSRrYpuOPmwNS/LZI/hjmDRuwW3WbHJhl5xICSgqFf87XhQmObnUc5zTKnxUeUDZsWxESxvTRSdcO6VNrQBYNDTXpdKvvkXpZ314EYgQR/SAu/oX1hWYKomrQVUAjzY/iV6puMdfhpYCje2XUNCIDLLutuu21/f5TLkxc40rTlAILb7tt6BMl8TgSPkCedI4bYsescHA04lbFCeHlr75VZa+bec74QUPptKCMfwWynj+psY+lz0A4zGXELH1LWbxHXell5Af1lFwTmEj5hNc8zKzgyXnbZiSV3C0WWNzVTJAQgMyoSfNb4+JS866OXmZO8DlcVNC8s9z8EASZS5OT2vH92faWsEaOMVGTPiu6cMWdanOlVzqKaGYgTGoCXAgbaci2ksdfkFLiffBeP8IH8/2NXMlaWwKt2rUFx2crjxuzN8QESpOUZAj3v9RPIwMEdB6Wavd5G6dDxAcVQkofDtVBwFFhvlqdwdlrO+lWfEduO5vyG5TLD9Q4Rp/LQQddJFURvy89on46Cbj5H5dObHYVrLV1kGaQD+0+MWQw2wGRuIaIhzTf5QiBbQ03Lt2wx0c5NXAkWzGQUkkZHIhjO/KMqaiPDsaBImNXfCsm+SlyjxglbGO0MmtWSIdhGD7TrUtIwI3CoN1t+XwW3jXqFON7ZAUkOJyz9b0MPyRWSiw==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39840400004)(136003)(346002)(376002)(451199015)(36840700001)(46966006)(8676002)(4326008)(70586007)(316002)(7696005)(70206006)(44832011)(356005)(2906002)(5660300002)(8936002)(81166007)(41300700001)(426003)(47076005)(36860700001)(83380400001)(103116003)(478600001)(40480700001)(7126003)(336012)(186003)(26005)(86362001)(55016003)(82310400005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 17:31:22.4148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3599c980-2268-4e13-4dd9-08daf26753a5
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR01MB7924
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

Fix three error exit issues in expected receive setup.
Re-arrange error exits to increase readability.

Issues and fixes:
1. Possible missed page unpin if tidlist copyout fails and
   not all pinned pages where made part of a TID.
   Fix: Unpin the unused pages.

2. Return success with unset return values tidcnt and length
   when no pages were pinned.
   Fix: Return -ENOSPC if no pages were pinned.

3. Return success with unset return values tidcnt and length when
   no rcvarray entries available.
   Fix: Return -ENOSPC if no rcvarray entries are available.

Fixes: 7e7a436ecb6e ("staging/hfi1: Add TID entry program function body")
Fixes: 97736f36dbeb ("IB/hfi1: Validate page aligned for a given virtual addres")
Fixes: f404ca4c7ea8 ("IB/hfi1: Refactor hfi_user_exp_rcv_setup() IOCTL")
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/user_exp_rcv.c |   83 +++++++++++++++++------------
 1 file changed, 50 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
index d7487555d109..88df8ca4bb57 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
@@ -268,15 +268,14 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 	tidbuf->psets = kcalloc(uctxt->expected_count, sizeof(*tidbuf->psets),
 				GFP_KERNEL);
 	if (!tidbuf->psets) {
-		kfree(tidbuf);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto fail_release_mem;
 	}
 
 	pinned = pin_rcv_pages(fd, tidbuf);
 	if (pinned <= 0) {
-		kfree(tidbuf->psets);
-		kfree(tidbuf);
-		return pinned;
+		ret = (pinned < 0) ? pinned : -ENOSPC;
+		goto fail_unpin;
 	}
 
 	/* Find sets of physically contiguous pages */
@@ -291,14 +290,16 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 	fd->tid_used += pageset_count;
 	spin_unlock(&fd->tid_lock);
 
-	if (!pageset_count)
-		goto bail;
+	if (!pageset_count) {
+		ret = -ENOSPC;
+		goto fail_unreserve;
+	}
 
 	ngroups = pageset_count / dd->rcv_entries.group_size;
 	tidlist = kcalloc(pageset_count, sizeof(*tidlist), GFP_KERNEL);
 	if (!tidlist) {
 		ret = -ENOMEM;
-		goto nomem;
+		goto fail_unreserve;
 	}
 
 	tididx = 0;
@@ -394,44 +395,60 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 	}
 unlock:
 	mutex_unlock(&uctxt->exp_mutex);
-nomem:
 	hfi1_cdbg(TID, "total mapped: tidpairs:%u pages:%u (%d)", tididx,
 		  mapped_pages, ret);
+
+	/* fail if nothing was programmed, set error if none provided */
+	if (tididx == 0) {
+		if (ret >= 0)
+			ret = -ENOSPC;
+		goto fail_unreserve;
+	}
+
 	/* adjust reserved tid_used to actual count */
 	spin_lock(&fd->tid_lock);
 	fd->tid_used -= pageset_count - tididx;
 	spin_unlock(&fd->tid_lock);
-	if (tididx) {
-		tinfo->tidcnt = tididx;
-		tinfo->length = mapped_pages * PAGE_SIZE;
 
-		if (copy_to_user(u64_to_user_ptr(tinfo->tidlist),
-				 tidlist, sizeof(tidlist[0]) * tididx)) {
-			/*
-			 * On failure to copy to the user level, we need to undo
-			 * everything done so far so we don't leak resources.
-			 */
-			tinfo->tidlist = (unsigned long)&tidlist;
-			hfi1_user_exp_rcv_clear(fd, tinfo);
-			tinfo->tidlist = 0;
-			ret = -EFAULT;
-			goto bail;
-		}
+	/* unpin all pages not covered by a TID */
+	unpin_rcv_pages(fd, tidbuf, NULL, mapped_pages, pinned - mapped_pages,
+			false);
+
+	tinfo->tidcnt = tididx;
+	tinfo->length = mapped_pages * PAGE_SIZE;
+
+	if (copy_to_user(u64_to_user_ptr(tinfo->tidlist),
+			 tidlist, sizeof(tidlist[0]) * tididx)) {
+		ret = -EFAULT;
+		goto fail_unprogram;
 	}
 
-	/*
-	 * If not everything was mapped (due to insufficient RcvArray entries,
-	 * for example), unpin all unmapped pages so we can pin them nex time.
-	 */
-	if (mapped_pages != pinned)
-		unpin_rcv_pages(fd, tidbuf, NULL, mapped_pages,
-				(pinned - mapped_pages), false);
-bail:
+	kfree(tidbuf->pages);
 	kfree(tidbuf->psets);
+	kfree(tidbuf);
 	kfree(tidlist);
+	return 0;
+
+fail_unprogram:
+	/* unprogram, unmap, and unpin all allocated TIDs */
+	tinfo->tidlist = (unsigned long)tidlist;
+	hfi1_user_exp_rcv_clear(fd, tinfo);
+	tinfo->tidlist = 0;
+	pinned = 0;		/* nothing left to unpin */
+	pageset_count = 0;	/* nothing left reserved */
+fail_unreserve:
+	spin_lock(&fd->tid_lock);
+	fd->tid_used -= pageset_count;
+	spin_unlock(&fd->tid_lock);
+fail_unpin:
+	if (pinned > 0)
+		unpin_rcv_pages(fd, tidbuf, NULL, 0, pinned, false);
+fail_release_mem:
 	kfree(tidbuf->pages);
+	kfree(tidbuf->psets);
 	kfree(tidbuf);
-	return ret > 0 ? 0 : ret;
+	kfree(tidlist);
+	return ret;
 }
 
 int hfi1_user_exp_rcv_clear(struct hfi1_filedata *fd,


