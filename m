Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873A9562D01
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Jul 2022 09:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbiGAHsZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Jul 2022 03:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbiGAHsW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Jul 2022 03:48:22 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECA1913F93;
        Fri,  1 Jul 2022 00:48:19 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id D43B41E80D92;
        Fri,  1 Jul 2022 15:46:50 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XMRAIELn1E8W; Fri,  1 Jul 2022 15:46:48 +0800 (CST)
Received: from localhost.localdomain (unknown [112.65.12.78])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id D6F421E80D21;
        Fri,  1 Jul 2022 15:46:46 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] IB/qib: Fix typo in comments
Date:   Fri,  1 Jul 2022 15:48:12 +0800
Message-Id: <20220701074812.12615-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is a typo (writeable) in qib_file_ops.c and qib_sd7220.c's comments.
Fix it.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 drivers/infiniband/hw/qib/qib_file_ops.c | 4 ++--
 drivers/infiniband/hw/qib/qib_sd7220.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
index aa290928cf96..f61e07f684cf 100644
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -851,7 +851,7 @@ static int mmap_rcvegrbufs(struct vm_area_struct *vma,
 		ret = -EPERM;
 		goto bail;
 	}
-	/* don't allow them to later change to writeable with mprotect */
+	/* don't allow them to later change to writable with mprotect */
 	vma->vm_flags &= ~VM_MAYWRITE;
 
 	start = vma->vm_start;
@@ -941,7 +941,7 @@ static int mmap_kvaddr(struct vm_area_struct *vma, u64 pgaddr,
 			goto bail;
 		}
 		/*
-		 * Don't allow permission to later change to writeable
+		 * Don't allow permission to later change to writable
 		 * with mprotect.
 		 */
 		vma->vm_flags &= ~VM_MAYWRITE;
diff --git a/drivers/infiniband/hw/qib/qib_sd7220.c b/drivers/infiniband/hw/qib/qib_sd7220.c
index 81b810d006c0..1dc3ccf0cf1f 100644
--- a/drivers/infiniband/hw/qib/qib_sd7220.c
+++ b/drivers/infiniband/hw/qib/qib_sd7220.c
@@ -587,7 +587,7 @@ static int epb_access(struct qib_devdata *dd, int sdnum, int claim)
 		/* Need to release */
 		u64 pollval;
 		/*
-		 * The only writeable bits are the request and CS.
+		 * The only writable bits are the request and CS.
 		 * Both should be clear
 		 */
 		u64 newval = 0;
-- 
2.25.1

