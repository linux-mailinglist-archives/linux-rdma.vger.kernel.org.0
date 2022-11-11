Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E04625296
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 05:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiKKEcv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Nov 2022 23:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiKKEcu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Nov 2022 23:32:50 -0500
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4254A68AEB;
        Thu, 10 Nov 2022 20:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1668141166; i=@fujitsu.com;
        bh=bqzxuxOj1uBZFGGeCXRO50kMdRTB6u9u4Z9D5YPVTeo=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=pKAmvP12BU+OFaZO4k/MPVM6nSXuLTaqQXcRgwJTYXRTBDSr4kpETIH/cCZsBL1zz
         hcfxtJ0wROMv89Neo3rYJUsExY16UDn/f+pCCYv8B5MHQ/amjVZCmWdSvdHMcQ6ris
         hRvbgcMEo+83hPuMvSHTLFNlAouDtXFR7xRNe4xEDbtwEecQMaFH+E3nvJMUKgI/jP
         G2G50sRs6Tcfw2h6YqgJI85ftvG48CL3yhgXoTjSfZUGAl2WLmFYLkVFkdmod7C221
         JtdrJFVXFqu52E47CCgW80uLpmCGQGqHKu3uIuBAfp2W84XJcPmAFC1NbanGK0b7gI
         jR1u4AKX1Z8tw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRWlGSWpSXmKPExsViZ8ORpJt7ITf
  ZYNtufYuZM04wWkz5tZTZ4vKuOWwWzw71slicP9bP7sDqsXPWXXaPTas62Tw+b5Lz2Pr5NksA
  SxRrZl5SfkUCa0b/3x62gqtCFZ+mnmVrYPzC38XIxSEksJFR4t7/54wQzmImiSNPbzFBOAcYJ
  ZYsfsjSxcjJwSagIXGv5SYjiC0i0Mkosa01DcRmFnCT2PRmNnsXIweHsICPRNereJAwi4CqxJ
  rbG5lBbF4BR4mnT66xgdgSAgoSUx6+B4tzCjhJLL/zBSwuBFRzauYdFoh6QYmTM5+wQIyXkDj
  44gUzyHgJASWJmd3xEGMqJGbNamOCsNUkrp7bxDyBUXAWku5ZSLoXMDKtYjQrTi0qSy3SNTTR
  SyrKTM8oyU3MzNFLrNJN1Est1S1PLS7RNdRLLC/WSy0u1iuuzE3OSdHLSy3ZxAgM/5RitlU7G
  H8t+6N3iFGSg0lJlHefTW6yEF9SfkplRmJxRnxRaU5q8SFGGQ4OJQlevbNAOcGi1PTUirTMHG
  AswqQlOHiURHiFtwOleYsLEnOLM9MhUqcYFaXEea3OAyUEQBIZpXlwbbD4v8QoKyXMy8jAwCD
  EU5BalJtZgir/ilGcg1FJmDfuHNAUnsy8Erjpr4AWMwEttkvNAllckoiQkmpgsr8Wvq3NQuva
  ox2XQvbLadwUETj2s2yvXFzQ6S/yD23NOJuc7RlNDPd1em5yWqSSLnM29f2pGTV7n54yXe00b
  dddjWrVxSrhcw9yiv+qXWSUo7Te7vL2giqGss9+1yZce9BalbOvprjurbveKpGp/1g0/aIOmV
  oIWX09WXq+j997dh2/hJm3iv+j+APhJxnDDCU2FgQ03DS8WPyK7aONj8mVpEcSPWeYz39T+Ow
  /795nLY8MtuoPq35PvXN0QqXB1kNzKnZmznF12dJm5/ZT7ejZ23WT3rlMO1DooCHocrupSEh3
  2p0Df10/RDcYn9HcP/P3Wv8rgr+ni+989+SzwRt2bpNrVqvfZU46YaP0S4mlOCPRUIu5qDgRA
  MVi5iN6AwAA
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-26.tower-585.messagelabs.com!1668141165!713889!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31940 invoked from network); 11 Nov 2022 04:32:45 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-26.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 11 Nov 2022 04:32:45 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 607E81AE;
        Fri, 11 Nov 2022 04:32:45 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 5554C7B;
        Fri, 11 Nov 2022 04:32:45 +0000 (GMT)
Received: from 401ba783c32b.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 11 Nov 2022 04:32:42 +0000
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Leon Romanovsky" <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH 5/5] RDMA/rxe: Rename iova_to_vaddr to rxe_map_iova
Date:   Fri, 11 Nov 2022 04:32:15 +0000
Message-ID: <1668141135-2-1-git-send-email-lizhijian@fujitsu.com>
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

be pair with rxe_unmap_vaddr

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h  | 2 +-
 drivers/infiniband/sw/rxe/rxe_mr.c   | 4 ++--
 drivers/infiniband/sw/rxe/rxe_resp.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 22a8c44d39c8..496e29215e0f 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -72,7 +72,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		enum rxe_mr_copy_dir dir);
 int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
 	      void *addr, int length, enum rxe_mr_copy_dir dir);
-void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
+void *rxe_map_iova(struct rxe_mr *mr, u64 iova, int length);
 void rxe_unmap_vaddr(struct rxe_mr *mr, void *vaddr);
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index d26a4a33119c..e46ea2a7179c 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -264,7 +264,7 @@ static void *__iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 }
 
 /* must call rxe_unmap_vaddr to unmap vaddr */
-void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
+void *rxe_map_iova(struct rxe_mr *mr, u64 iova, int length)
 {
 	if (mr->state != RXE_MR_STATE_VALID) {
 		pr_warn("mr not in valid state\n");
@@ -321,7 +321,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		if (bytes > length)
 			bytes = length;
 
-		va = iova_to_vaddr(mr, iova, bytes);
+		va = rxe_map_iova(mr, iova, bytes);
 		if (!va)
 			return -EFAULT;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 765cb9f8538a..831d71e2054c 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -615,8 +615,8 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 			goto out;
 		}
 
-		vaddr = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset,
-					sizeof(u64));
+		vaddr = rxe_map_iova(mr, qp->resp.va + qp->resp.offset,
+				     sizeof(u64));
 
 		/* check vaddr is 8 bytes aligned. */
 		if (!vaddr || (uintptr_t)vaddr & 7) {
-- 
2.31.1

