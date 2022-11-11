Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0E862528F
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 05:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiKKEbD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Nov 2022 23:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiKKEbA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Nov 2022 23:31:00 -0500
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339FB68AD9;
        Thu, 10 Nov 2022 20:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1668141056; i=@fujitsu.com;
        bh=YDhoYW+eXCKjvdTLBizlFrYt3TOUamkuYfdivtZaMMk=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=hVgtHvu6W1bvlIX3kfc2RL3uBP9LP032+foxXnX+egnZEj99xx+ylI7Dh5btleSmC
         6wCjdm4bLdzk5bH5wcEAOecZNVXE1Tlh0Lt9B3942wrP0LPBhBjrUCgAeuBfEYgSpr
         6e6FQa796VAW3anwijJyMc4lFmxvJsCKPGa3XYLx47Nwd8XkRnx96k2u81wvwvR5Jt
         UfQV+o/L7Ysh3vg8FeojYdbeML2dbWUz0oGURpib8REx2x1LJDT9MUmbU3pRZEQQYX
         3ctWpHM0iM7flJMbXldi0EtpVbiPRqz7fAYnUObDyKAwx6Lc2CTRUa91J8gjmRFyuD
         +S9Rfye8kcJkA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRWlGSWpSXmKPExsViZ8ORqPv/fG6
  ywcXjKhYzZ5xgtJjyaymzxeVdc9gsnh3qZbE4f6yf3YHVY+esu+wem1Z1snl83iTnsfXzbZYA
  lijWzLyk/IoE1ozmybOYCx7wVix7up+pgXE7dxcjF4eQwBZGicfHNjN2MXICOcuZJP6uC4NIH
  GCUWLv3DFiCTUBD4l7LTTBbRKCTUWJbaxqIzSzgJrHpzWx2EFtYwFaiZ845MJtFQFVi79lXTF
  2MHBy8Ao4SX96Xg4QlBBQkpjx8zwxicwo4SSy/84UNYq+jxKmZd1hAbF4BQYmTM5+wQIyXkDj
  44gUzyBgJASWJmd3xEGMqJGbNamOCsNUkrp7bxDyBUXAWku5ZSLoXMDKtYjQrTi0qSy3SNTTU
  SyrKTM8oyU3MzNFLrNJN1Est1S1PLS7RNdJLLC/WSy0u1iuuzE3OSdHLSy3ZxAgM/pRitYAdj
  B+X/dE7xCjJwaQkyrvPJjdZiC8pP6UyI7E4I76oNCe1+BCjDAeHkgSv3lmgnGBRanpqRVpmDj
  ASYdISHDxKIrzC24HSvMUFibnFmekQqVOMilLivFbA+BUSAElklObBtcGi/xKjrJQwLyMDA4M
  QT0FqUW5mCar8K0ZxDkYlYd64c0BTeDLzSuCmvwJazAS02C41C2RxSSJCSqqBqZjpbv6Dna8m
  JFmGz4lqnSgrppl+r9Nw6jLVjWvDjuYu8OOOO1epVMjvJFrZmX+I8UZrbWXGmXDVF8yHfK/7n
  nkceNQ7Y0PEkkX+v1cdjmWNnvxiwZODWy1PtnHca1nCaSX2del1hdRHKRMf/NklorU1SKJ6Ee
  +cbdObhKbn/uGecUax6fGDczFqZk8zXYoubjPbW55kveCL4+Izk/OrLmtbpUqtSepKTtM0cPn
  BEFV4eIaDY3NgH8esI2ff9y/Vlt6eIPpDiutZu7S54uHeTEWRJXs0AufybbxccHPBtdDjnuHc
  HBoPt3CaNQn+cJtkULwkNXJjK3ux9NZofle1eSv/umREvq0/8dlZ/PNTJZbijERDLeai4kQAy
  sR8P3kDAAA=
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-17.tower-571.messagelabs.com!1668141055!691429!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19201 invoked from network); 11 Nov 2022 04:30:55 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-17.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 11 Nov 2022 04:30:55 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 4711D1001A1;
        Fri, 11 Nov 2022 04:30:55 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 3A8BD10019F;
        Fri, 11 Nov 2022 04:30:55 +0000 (GMT)
Received: from bc0da1a9c27e.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 11 Nov 2022 04:30:52 +0000
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Leon Romanovsky" <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH 3/5] RDMA/rxe: iova_to_vaddr cleanup
Date:   Fri, 11 Nov 2022 04:30:28 +0000
Message-ID: <1668141030-2-4-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1668141030-2-1-git-send-email-lizhijian@fujitsu.com>
References: <1668141030-2-1-git-send-email-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

No functional change, do cleanup for refactoring it easily later.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 37 ++++++++++++++----------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index cf3ce8d293b3..a4e786b657b7 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -246,41 +246,38 @@ static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
 	}
 }
 
-void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
+static void *__iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 {
 	size_t offset;
 	int m, n;
-	void *addr;
 
+	lookup_iova(mr, iova, &m, &n, &offset);
+
+	if (offset + length > mr->ibmr.page_size) {
+		pr_warn("crosses page boundary\n");
+		return NULL;
+	}
+
+	return (void *)(uintptr_t)mr->map[m]->buf[n].addr + offset;
+}
+
+void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
+{
 	if (mr->state != RXE_MR_STATE_VALID) {
 		pr_warn("mr not in valid state\n");
-		addr = NULL;
-		goto out;
+		return NULL;
 	}
 
 	if (!mr->map) {
-		addr = (void *)(uintptr_t)iova;
-		goto out;
+		return (void *)(uintptr_t)iova;
 	}
 
 	if (mr_check_range(mr, iova, length)) {
 		pr_warn("range violation\n");
-		addr = NULL;
-		goto out;
-	}
-
-	lookup_iova(mr, iova, &m, &n, &offset);
-
-	if (offset + length > mr->ibmr.page_size) {
-		pr_warn("crosses page boundary\n");
-		addr = NULL;
-		goto out;
+		return NULL;
 	}
 
-	addr = (void *)(uintptr_t)mr->map[m]->buf[n].addr + offset;
-
-out:
-	return addr;
+	return __iova_to_vaddr(mr, iova, length);
 }
 
 /* copy data from a range (vaddr, vaddr+length-1) to or from
-- 
2.31.1

