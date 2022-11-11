Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C4C62528C
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 05:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiKKEa7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Nov 2022 23:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKKEaz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Nov 2022 23:30:55 -0500
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6530442F68;
        Thu, 10 Nov 2022 20:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1668141050; i=@fujitsu.com;
        bh=fjsTTPP+5pcUTVlho3XxaWSxwAHN8a8nnOjRBSnAiBM=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=gVmFTUKy24yRO3ZNKouAZibyZxVDhdtkqL6D35FwlMFii/Qs06kTOwAEK7mNxJYRM
         pD2vhvfE7DIcxULPBpl4h46r5F9nUV76WucSTtBwbdnhzvPvjRSTgzl5O4daFwmxsW
         GD5JR1zVqO83HEq710tHHfjpMkfOcG9o+jOofoNp1wAcEnZijXYUuDeSgkuSogzBPi
         fXPSE65L3iV0wzQYsUornXqElaf9eEa4AxTev1AOloXPfmLlyGgTB1dc9Stx1fcW+P
         pYd9ltbD6VrPIuJ+yOVnj8dpTQ3b1aWDR4G3d5zZcA6rxL03KtfFsp+1RCf09ofbLd
         O1sbmSkYehV6Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRWlGSWpSXmKPExsViZ8ORpPvrfG6
  ywe4qi5kzTjBaTPm1lNni8q45bBbPDvWyWJw/1s/uwOqxc9Zddo9NqzrZPD5vkvPY+vk2SwBL
  FGtmXlJ+RQJrxppPvAVLJCueP/rB1MD4WaSLkYtDSGAjo8Tv+XfYIZwlTBKLX19m6WLkBHIOM
  Er83cgBYrMJaEjca7nJCGKLCHQySmxrTQOxmQXcJDa9mc0OYgsLOEic3XKNGcRmEVCVeHR8JS
  uIzSvgKLH/zSMwW0JAQWLKw/dgNZwCThLL73xhg9jlKHFq5h0WiHpBiZMzn7BAzJeQOPjiBVA
  9B1CvksTM7niIMRUSs2a1MUHYahJXz21insAoOAtJ9ywk3QsYmVYxmhWnFpWlFuma6iUVZaZn
  lOQmZuboJVbpJuqllurm5ReVZOga6iWWF+ulFhfrFVfmJuek6OWllmxiBIZ+SnGC0w7GKcv+6
  B1ilORgUhLl3WeTmyzEl5SfUpmRWJwRX1Sak1p8iFGGg0NJglfvLFBOsCg1PbUiLTMHGIcwaQ
  kOHiURXuHtQGne4oLE3OLMdIjUKUZFKXFeK2D0CgmAJDJK8+DaYLF/iVFWSpiXkYGBQYinILU
  oN7MEVf4VozgHo5Iwb9w5oCk8mXklcNNfAS1mAlpsl5oFsrgkESEl1cAk1bD5V9OZ9xd+pRcV
  TdfTESk5qLBIIsb955L2m4Vf7VgP7PuZOWfJmS+cz+/rlSc0bKtP/Zt0ZsexkH+zTT4//i8Yb
  nbhtMrz77NtGPvio0qyD7rvePxmvfrGb86KqQaXda/5lz99sIDrl0vwxLkqLm8MNb2YdNLSPq
  Xu4T6f2rBL9MJLppcRx+8Zfjw0lT1TXaBQXyXXo/RAiKVgeuxbOXfHa1YLG1Ljf33rn1L9w0z
  0bzCjee25+qCbVzvmfqlay68e+PjknEvLc7OfBFWc7/nU0vr5tJbapRB/L6aT/LZ3p3gXtq43
  eXPm+RPx+RG3y5c3l5s7lU9PO/nhcbfngo/sCSEN3FUP8/oNDeyVWIozEg21mIuKEwG4nn/je
  AMAAA==
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-17.tower-728.messagelabs.com!1668141049!608144!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30575 invoked from network); 11 Nov 2022 04:30:49 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-17.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 11 Nov 2022 04:30:49 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 6D3681AE;
        Fri, 11 Nov 2022 04:30:49 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 623541AD;
        Fri, 11 Nov 2022 04:30:49 +0000 (GMT)
Received: from bc0da1a9c27e.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 11 Nov 2022 04:30:46 +0000
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Leon Romanovsky" <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH 1/5] RDMA/rxe: Remove rxe_phys_buf.size
Date:   Fri, 11 Nov 2022 04:30:26 +0000
Message-ID: <1668141030-2-2-git-send-email-lizhijian@fujitsu.com>
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

Every rxe_phys_buf used by either IB_MR_TYPE_MEM_REG or IB_MR_TYPE_USER
has the same size, which should be same with ibmr->page_size. So we can
use ibmr->page_size correspondingly.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 11 ++++-------
 drivers/infiniband/sw/rxe/rxe_verbs.c |  1 -
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 -
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index d4f10c2d1aa7..f6366a635b92 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -145,6 +145,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 
 	mr->page_shift = PAGE_SHIFT;
 	mr->page_mask = PAGE_SIZE - 1;
+	mr->ibmr.page_size = PAGE_SIZE;
 
 	num_buf			= 0;
 	map = mr->map;
@@ -167,7 +168,6 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 			}
 
 			buf->addr = (uintptr_t)vaddr;
-			buf->size = PAGE_SIZE;
 			num_buf++;
 			buf++;
 
@@ -219,7 +219,7 @@ static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
 	size_t offset = iova - mr->ibmr.iova + mr->offset;
 	int			map_index;
 	int			buf_index;
-	u64			length;
+	u64			length = mr->ibmr.page_size;
 
 	if (likely(mr->page_shift)) {
 		*offset_out = offset & mr->page_mask;
@@ -230,8 +230,6 @@ static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
 		map_index = 0;
 		buf_index = 0;
 
-		length = mr->map[map_index]->buf[buf_index].size;
-
 		while (offset >= length) {
 			offset -= length;
 			buf_index++;
@@ -240,7 +238,6 @@ static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
 				map_index++;
 				buf_index = 0;
 			}
-			length = mr->map[map_index]->buf[buf_index].size;
 		}
 
 		*m_out = map_index;
@@ -274,7 +271,7 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 
 	lookup_iova(mr, iova, &m, &n, &offset);
 
-	if (offset + length > mr->map[m]->buf[n].size) {
+	if (offset + length > mr->ibmr.page_size) {
 		pr_warn("crosses page boundary\n");
 		addr = NULL;
 		goto out;
@@ -336,7 +333,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		src = (dir == RXE_TO_MR_OBJ) ? addr : va;
 		dest = (dir == RXE_TO_MR_OBJ) ? va : addr;
 
-		bytes	= buf->size - offset;
+		bytes	= mr->ibmr.page_size - offset;
 
 		if (bytes > length)
 			bytes = length;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 88825edc7dce..5da394c675bf 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -991,7 +991,6 @@ static int rxe_set_page(struct ib_mr *ibmr, u64 addr)
 	buf = &map->buf[mr->nbuf % RXE_BUF_PER_MAP];
 
 	buf->addr = addr;
-	buf->size = ibmr->page_size;
 	mr->nbuf++;
 
 	return 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 22a299b0a9f0..acab785ba7e2 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -281,7 +281,6 @@ enum rxe_mr_lookup_type {
 
 struct rxe_phys_buf {
 	u64      addr;
-	u64      size;
 };
 
 struct rxe_map {
-- 
2.31.1

