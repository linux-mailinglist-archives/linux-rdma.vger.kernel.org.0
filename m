Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0536765CC5
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 22:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjG0UCT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 16:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjG0UCR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 16:02:17 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2834A2D75
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 13:02:13 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b9cf1997c4so1144022a34.3
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 13:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690488132; x=1691092932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRQ3tQaCHBe8nYmHcrq3Y3i1vEg/iOu1gwQSV5rGm3Y=;
        b=KaTYyRt325xN6/OiJ3M/UqiO9/ajOWAeIGSBloEKCBxJrvcN1jo9T4DvLVbMKCcSxI
         wx/KHn2FD9B+T7VPPt1lWubZM3/D62MVbXv12Ip19hJyzM4SeEzUf5BTDmcZqCPuhCOM
         yAUFr4vFdE/Ddx5OBK15osRGSKWZ5faOACbUi8nUa17OjzVFbU8lmVCfLxXvLpQi2kjq
         jWlviHlGYypLNYJXPxiZcSWAnQHFhrMuKy5+zqKrTXw9QIanA0lB+XDjLxNIYP3RzqIV
         lDg+aohbYf+pV3SLOuT8KB70Xdx6qMKIKLi9wyMwctDXRlIjsj895Cc/8bI0JHfmjwI2
         Tvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690488132; x=1691092932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRQ3tQaCHBe8nYmHcrq3Y3i1vEg/iOu1gwQSV5rGm3Y=;
        b=A4ZBf25YnsWGfjxNIu0vu7uw2dWwpoQAh/Az2J/I3Qb2ezi59GKSUFXn+bBRlNBTw5
         uDVr6TFZM3IqLVBGCWx6RTiqFFcbYPGMXDA8fG3dwMPIi3bBv/nMeSF7gCfezjEEBLr0
         4s1QLR0LcjTXW95nbSrEXHDUBJ5EMEIC8MbDz4id7ExrVUKlwvMSyTlNXIi5ZJ6RPSTh
         oMXiCn7VrRIK4Jig/pnM/pUVUKSm/DEA9mTgWC+iifbTV3i5O55IY75xGnxYYW3eTBha
         vc9blUozHh/fuuMqm81zmJREyl2AmeSSd8KBQN8yfbl8oHtUovhYyMDfDsS3M0WYI3CO
         VFXA==
X-Gm-Message-State: ABy/qLZOAcZXkQ1pET5tQPc77Q7dIl8/mNTqmAAjD6cDqacVktI7Ny1q
        +/hTYqAYfu9eZyXmfDYJcsjGpOVHvjs=
X-Google-Smtp-Source: APBJJlE0NCwNJQdtL6HvL+TIaMgw3NPYH8K/j5xsdrZrwo/gcpQ+xQDevq/pRS21LlR34gdAMaIloA==
X-Received: by 2002:a9d:77d2:0:b0:6b2:ac44:bf8e with SMTP id w18-20020a9d77d2000000b006b2ac44bf8emr199094otl.8.1690488132376;
        Thu, 27 Jul 2023 13:02:12 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-a360-d7ee-0b00-a1d3.res6.spectrum.com. [2603:8081:140c:1a00:a360:d7ee:b00:a1d3])
        by smtp.gmail.com with ESMTPSA id m3-20020a9d73c3000000b006b9acf5ebc0sm938142otk.76.2023.07.27.13.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 13:02:11 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 02/10] RDMA/rxe: Extend rxe_mr_copy to support skb frags
Date:   Thu, 27 Jul 2023 15:01:21 -0500
Message-Id: <20230727200128.65947-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727200128.65947-1-rpearsonhpe@gmail.com>
References: <20230727200128.65947-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe_mr_copy() currently supports copying between an mr and
a contiguous region of kernel memory.

Rename rxe_mr_copy() to rxe_copy_mr_data().
Extend the operations to support copying between an mr and an skb
fragment list. Fixup calls to rxe_mr_copy() to support the new API.
Add two APIs rxe_add_frag() and rxe_num_mr_frags() to add a fragment
to and skb and count the total number of fragments needed.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  10 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    | 170 +++++++++++++++++++++++---
 drivers/infiniband/sw/rxe/rxe_resp.c  |  14 ++-
 drivers/infiniband/sw/rxe/rxe_verbs.h |   2 +
 4 files changed, 173 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 532026cdd49e..77661e0ccab7 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -62,11 +62,15 @@ void rxe_mr_init_dma(int access, struct rxe_mr *mr);
 int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr);
 int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr);
-int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length);
-int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
-		unsigned int length, enum rxe_mr_copy_op op);
+int rxe_add_frag(struct sk_buff *skb, struct rxe_mr *mr, struct page *page,
+		 unsigned int length, unsigned int offset);
+int rxe_num_mr_frags(struct rxe_mr *mr, u64 iova, unsigned int length);
+int rxe_copy_mr_data(struct sk_buff *skb, struct rxe_mr *mr, u64 iova,
+		     void *addr, unsigned int skb_offset,
+		     unsigned int length, enum rxe_mr_copy_op op);
 int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
 	      void *addr, int length, enum rxe_mr_copy_op op);
+int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length);
 int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 		  int sg_nents, unsigned int *sg_offset);
 int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 812c85cad463..2667e8129a1d 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -242,7 +242,79 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
 	return ib_sg_to_pages(ibmr, sgl, sg_nents, sg_offset, rxe_set_page);
 }
 
-static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
+/**
+ * rxe_add_frag() - Add a frag to a nonlinear packet
+ * @skb: The packet buffer
+ * @page: The page
+ * @mr: The memory region
+ * @length: Length of fragment
+ * @offset: Offset of fragment in page
+ *
+ * Caller must verify that the fragment is contained in the page.
+ * Caller should verify that the number of fragments does not
+ * exceed MAX_SKB_FRAGS
+ *
+ * Returns: 0 on success else a negative errno
+ */
+int rxe_add_frag(struct sk_buff *skb, struct rxe_mr *mr, struct page *page,
+		 unsigned int length, unsigned int offset)
+{
+	int nr_frags = skb_shinfo(skb)->nr_frags;
+	skb_frag_t *frag = &skb_shinfo(skb)->frags[nr_frags];
+
+	if (nr_frags >= MAX_SKB_FRAGS) {
+		rxe_dbg_mr(mr, "ran out of frags");
+		return -EINVAL;
+	}
+
+	frag->bv_len = length;
+	frag->bv_offset = offset;
+	frag->bv_page = page;
+	/* because kfree_skb will call put_page() */
+	get_page(page);
+	skb_shinfo(skb)->nr_frags++;
+
+	skb->data_len += length;
+	skb->len += length;
+
+	return 0;
+}
+
+/**
+ * rxe_num_mr_frags() - Compute the number of skb frags needed to copy
+ *			length bytes from an mr to an skb frag list.
+ * @mr: mr to copy data from
+ * @iova: iova in memory region as starting point
+ * @length: number of bytes to transfer
+ *
+ * Returns: the number of frags needed
+ */
+int rxe_num_mr_frags(struct rxe_mr *mr, u64 iova, unsigned int length)
+{
+	unsigned int page_size;
+	unsigned int page_offset;
+	unsigned int bytes;
+	int num_frags = 0;
+
+	if (mr->ibmr.type == IB_MR_TYPE_DMA)
+		page_size = PAGE_SIZE;
+	else
+		page_size = mr_page_size(mr);
+	page_offset = iova & (page_size - 1);
+
+	while (length) {
+		bytes = min_t(unsigned int, length,
+				page_size - page_offset);
+		length -= bytes;
+		page_offset = 0;
+		num_frags++;
+	}
+
+	return num_frags;
+}
+
+static int rxe_mr_copy_xarray(struct sk_buff *skb, struct rxe_mr *mr,
+			      u64 iova, void *addr, unsigned int skb_offset,
 			      unsigned int length, enum rxe_mr_copy_op op)
 {
 	unsigned int page_offset = rxe_mr_iova_to_page_offset(mr, iova);
@@ -250,6 +322,7 @@ static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
 	unsigned int bytes;
 	struct page *page;
 	void *va;
+	int err = 0;
 
 	while (length) {
 		page = xa_load(&mr->page_list, index);
@@ -258,12 +331,32 @@ static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
 
 		bytes = min_t(unsigned int, length,
 				mr_page_size(mr) - page_offset);
-		va = kmap_local_page(page);
-		if (op == RXE_COPY_FROM_MR)
+		switch (op) {
+		case RXE_COPY_FROM_MR:
+			va = kmap_local_page(page);
 			memcpy(addr, va + page_offset, bytes);
-		else
+			kunmap_local(va);
+			break;
+		case RXE_COPY_TO_MR:
+			va = kmap_local_page(page);
 			memcpy(va + page_offset, addr, bytes);
-		kunmap_local(va);
+			kunmap_local(va);
+			break;
+		case RXE_FRAG_TO_MR:
+			va = kmap_local_page(page);
+			err = skb_copy_bits(skb, skb_offset,
+					    va + page_offset, bytes);
+			kunmap_local(va);
+			skb_offset += bytes;
+			break;
+		case RXE_FRAG_FROM_MR:
+			err = rxe_add_frag(skb, mr, page, bytes,
+					   page_offset);
+			break;
+		}
+
+		if (err)
+			return err;
 
 		page_offset = 0;
 		addr += bytes;
@@ -274,13 +367,15 @@ static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
 	return 0;
 }
 
-static void rxe_mr_copy_dma(struct rxe_mr *mr, u64 dma_addr, void *addr,
-			    unsigned int length, enum rxe_mr_copy_op op)
+static int rxe_mr_copy_dma(struct sk_buff *skb, struct rxe_mr *mr,
+			   u64 dma_addr, void *addr, unsigned int skb_offset,
+			   unsigned int length, enum rxe_mr_copy_op op)
 {
 	unsigned int page_offset = dma_addr & (PAGE_SIZE - 1);
 	unsigned int bytes;
 	struct page *page;
 	u8 *va;
+	int err = 0;
 
 	while (length) {
 		page = ib_virt_dma_to_page(dma_addr);
@@ -288,10 +383,32 @@ static void rxe_mr_copy_dma(struct rxe_mr *mr, u64 dma_addr, void *addr,
 				PAGE_SIZE - page_offset);
 		va = kmap_local_page(page);
 
-		if (op == RXE_COPY_FROM_MR)
+		switch (op) {
+		case RXE_COPY_FROM_MR:
+			va = kmap_local_page(page);
 			memcpy(addr, va + page_offset, bytes);
-		else
+			kunmap_local(va);
+			break;
+		case RXE_COPY_TO_MR:
+			va = kmap_local_page(page);
 			memcpy(va + page_offset, addr, bytes);
+			kunmap_local(va);
+			break;
+		case RXE_FRAG_TO_MR:
+			va = kmap_local_page(page);
+			err = skb_copy_bits(skb, skb_offset,
+					    va + page_offset, bytes);
+			kunmap_local(va);
+			skb_offset += bytes;
+			break;
+		case RXE_FRAG_FROM_MR:
+			err = rxe_add_frag(skb, mr, page, bytes,
+					   page_offset);
+			break;
+		}
+
+		if (err)
+			return err;
 
 		kunmap_local(va);
 		page_offset = 0;
@@ -299,10 +416,31 @@ static void rxe_mr_copy_dma(struct rxe_mr *mr, u64 dma_addr, void *addr,
 		addr += bytes;
 		length -= bytes;
 	}
+
+	return 0;
 }
 
-int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
-		unsigned int length, enum rxe_mr_copy_op op)
+/**
+ * rxe_copy_mr_data() - transfer data between an MR and a packet
+ * @skb: the packet buffer
+ * @mr: the MR
+ * @iova: the address in the MR
+ * @addr: the address in the packet (TO/FROM MR only)
+ * @length: the length to transfer
+ * @op: copy operation (TO MR, FROM MR or FRAG MR)
+ *
+ * Copy data from a range (addr, addr+length-1) in a packet
+ * to or from a range in an MR object at (iova, iova+length-1).
+ * Or, build a frag list referencing the MR range.
+ *
+ * Caller must verify that the access permissions support the
+ * operation.
+ *
+ * Returns: 0 on success or an error
+ */
+int rxe_copy_mr_data(struct sk_buff *skb, struct rxe_mr *mr, u64 iova,
+		     void *addr, unsigned int skb_offset,
+		     unsigned int length, enum rxe_mr_copy_op op)
 {
 	int err;
 
@@ -313,8 +451,8 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
 		return -EINVAL;
 
 	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
-		rxe_mr_copy_dma(mr, iova, addr, length, op);
-		return 0;
+		return rxe_mr_copy_dma(skb, mr, iova, addr, skb_offset,
+				       length, op);
 	}
 
 	err = mr_check_range(mr, iova, length);
@@ -323,7 +461,8 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
 		return err;
 	}
 
-	return rxe_mr_copy_xarray(mr, iova, addr, length, op);
+	return rxe_mr_copy_xarray(skb, mr, iova, addr, skb_offset,
+				  length, op);
 }
 
 /* copy data in or out of a wqe, i.e. sg list
@@ -395,7 +534,8 @@ int copy_data(
 
 		if (bytes > 0) {
 			iova = sge->addr + offset;
-			err = rxe_mr_copy(mr, iova, addr, bytes, op);
+			err = rxe_copy_mr_data(NULL, mr, iova, addr,
+					       0, bytes, op);
 			if (err)
 				goto err2;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 596615c515ad..87d61a462ff5 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -576,12 +576,15 @@ static enum resp_states send_data_in(struct rxe_qp *qp, void *data_addr,
 static enum resp_states write_data_in(struct rxe_qp *qp,
 				      struct rxe_pkt_info *pkt)
 {
+	struct sk_buff *skb = PKT_TO_SKB(pkt);
 	enum resp_states rc = RESPST_NONE;
-	int	err;
 	int data_len = payload_size(pkt);
+	int err;
+	int skb_offset = 0;
 
-	err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
-			  payload_addr(pkt), data_len, RXE_COPY_TO_MR);
+	err = rxe_copy_mr_data(skb, qp->resp.mr, qp->resp.va + qp->resp.offset,
+			  payload_addr(pkt), skb_offset, data_len,
+			  RXE_COPY_TO_MR);
 	if (err) {
 		rc = RESPST_ERR_RKEY_VIOLATION;
 		goto out;
@@ -876,6 +879,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	int err;
 	struct resp_res *res = qp->resp.res;
 	struct rxe_mr *mr;
+	unsigned int skb_offset = 0;
 	u8 *pad_addr;
 
 	if (!res) {
@@ -927,8 +931,8 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		goto err_out;
 	}
 
-	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
-			  payload, RXE_COPY_FROM_MR);
+	err = rxe_copy_mr_data(skb, mr, res->read.va, payload_addr(&ack_pkt),
+			       skb_offset, payload, RXE_COPY_FROM_MR);
 	if (err) {
 		kfree_skb(skb);
 		state = RESPST_ERR_RKEY_VIOLATION;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index d9c44bd30da4..89cf50b938c2 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -278,6 +278,8 @@ enum rxe_mr_state {
 enum rxe_mr_copy_op {
 	RXE_COPY_TO_MR,
 	RXE_COPY_FROM_MR,
+	RXE_FRAG_TO_MR,
+	RXE_FRAG_FROM_MR,
 };
 
 enum rxe_mr_lookup_type {
-- 
2.39.2

