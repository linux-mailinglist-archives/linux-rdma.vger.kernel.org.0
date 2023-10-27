Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E17F7D8D1E
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 04:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjJ0Cds (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 22:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjJ0Cds (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 22:33:48 -0400
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [IPv6:2001:41d0:203:375::b6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D201AD
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 19:33:45 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698374024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P92n84d/ePW97KQqbG+s+E6bBBjLQYBpPhf0+b8dy4w=;
        b=q9lJDsAxfIKKo/9lkd1AxWrvIxX56sqNlznezEYcYeSGxbQKNgAt75+DoLesqIcEl3zehW
        PsGifi7MBKK1XoS61eteBTE23xekI3yGyJnbtFYkjPQWzQLf4ByrOvKFht7lxg0UQUtJhU
        YwCeBkv/N2ensTg5y4iUL2hcPY+PMhI=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V3 01/18] RDMA/siw: Introduce siw_get_page
Date:   Fri, 27 Oct 2023 10:33:11 +0800
Message-Id: <20231027023328.30347-2-guoqing.jiang@linux.dev>
In-Reply-To: <20231027023328.30347-1-guoqing.jiang@linux.dev>
References: <20231027023328.30347-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add the wrapper function to get either pbl page or umem page.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 31 +++++++++++----------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index b2c06100cf01..6a24e08356e9 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -34,6 +34,15 @@ static struct page *siw_get_pblpage(struct siw_mem *mem, u64 addr, int *idx)
 	return NULL;
 }
 
+static struct page *siw_get_page(struct siw_mem *mem, struct siw_sge *sge,
+				 unsigned long offset, int *pbl_idx)
+{
+	if (!mem->is_pbl)
+		return siw_get_upage(mem->umem, sge->laddr + offset);
+	else
+		return siw_get_pblpage(mem, sge->laddr + offset, pbl_idx);
+}
+
 /*
  * Copy short payload at provided destination payload address
  */
@@ -67,11 +76,7 @@ static int siw_try_1seg(struct siw_iwarp_tx *c_tx, void *paddr)
 			char *buffer;
 			int pbl_idx = 0;
 
-			if (!mem->is_pbl)
-				p = siw_get_upage(mem->umem, sge->laddr);
-			else
-				p = siw_get_pblpage(mem, sge->laddr, &pbl_idx);
-
+			p = siw_get_page(mem, sge, 0, &pbl_idx);
 			if (unlikely(!p))
 				return -EFAULT;
 
@@ -85,13 +90,7 @@ static int siw_try_1seg(struct siw_iwarp_tx *c_tx, void *paddr)
 				memcpy(paddr, buffer + off, part);
 				kunmap_local(buffer);
 
-				if (!mem->is_pbl)
-					p = siw_get_upage(mem->umem,
-							  sge->laddr + part);
-				else
-					p = siw_get_pblpage(mem,
-							    sge->laddr + part,
-							    &pbl_idx);
+				p = siw_get_page(mem, sge, part, &pbl_idx);
 				if (unlikely(!p))
 					return -EFAULT;
 
@@ -502,13 +501,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 			if (!is_kva) {
 				struct page *p;
 
-				if (mem->is_pbl)
-					p = siw_get_pblpage(
-						mem, sge->laddr + sge_off,
-						&pbl_idx);
-				else
-					p = siw_get_upage(mem->umem,
-							  sge->laddr + sge_off);
+				p = siw_get_page(mem, sge, sge_off, &pbl_idx);
 				if (unlikely(!p)) {
 					siw_unmap_pages(iov, kmap_mask, seg);
 					wqe->processed -= c_tx->bytes_unsent;
-- 
2.35.3

