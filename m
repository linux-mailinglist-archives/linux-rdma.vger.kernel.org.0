Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCA7613EFD
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Oct 2022 21:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiJaU2l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Oct 2022 16:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiJaU2k (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Oct 2022 16:28:40 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B71313E33
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:39 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id p127so13930276oih.9
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sp90QASqkoEDHPYCIDVhjfWBKi7P/IYIQ3+aOjk6wK4=;
        b=C4MpBjHQvwGEgKdnj744UGNhWDrKPNaGbYkkDZa3q0R3/Gi/L90EnaCWHvenR3PRKD
         bQFybnvZu5w8xLJlg/XBIvXvTImztjoS2Nzhnou5x6BSE0vhDDG+viUylURhUAh/iTA6
         t5muYiJ+IcGZjUojYNeVe7EuwO7pq3zKcxV+CsV7UNh6WEU8rDXKbhxNjq79sPNuFA52
         o+YNCACsTFAl7HgRdfznpR8oErISQ0haoO2LP9jw9KJJmevhWT47KoqYuhBkekYLET2L
         uiuC9l4mqV4OJX0i0AzsrQiFyiLe9b/Hida0DEIxGUVJHURpb0nn1DS+A3JEHFG8uF+/
         G9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sp90QASqkoEDHPYCIDVhjfWBKi7P/IYIQ3+aOjk6wK4=;
        b=xIM/6Ev04udz6CXD0sN9J6fV1e+nBmxaNq+8b8KXjDyG6Tn8L/quwZ/0ctstmah7Ia
         U28lWXtsLqoQ91USbLQIVs4Xfb2FuwodXogfH6l4bZtnhMTCoQoz6hR7SiqLTXsPQiMf
         bTzMd6V7rGydjpEYvOUUXbqAJy/egWfU95dxGXxzMZ1+qikBtyDijBLbMNqDke/8Tdpy
         5mgTQ4khho4IEXoZUnSvxKCziGVC7/0Inx2xrC0UP0K1fZM7zEbFUYF9jPnWk7tjsCrk
         YWo6RovY/lNqEu1zfWftdvgviB9HR0Y+DH25oqYMrZkHgsC1g1hNxYztAiZRB/soF/7Y
         dpcQ==
X-Gm-Message-State: ACrzQf0rtLGBqB6N0fAIGrBNYXDAEsOTZzRX6/bfgDIyboInWNeb++oP
        wiQKv9vsdp0m1BL7uanAcQDP9qRp/5k=
X-Google-Smtp-Source: AMsMyM63XTkko9QFv694dyXojoSoe/dWGB0i3lxIul1l0FYtg30hXMT7LGtSlEnnhNpujLCRH8LUQg==
X-Received: by 2002:aca:dac2:0:b0:354:a921:a87e with SMTP id r185-20020acadac2000000b00354a921a87emr16189369oig.292.1667248118353;
        Mon, 31 Oct 2022 13:28:38 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-ce7d-a808-badd-629d.res6.spectrum.com. [2603:8081:140c:1a00:ce7d:a808:badd:629d])
        by smtp.googlemail.com with ESMTPSA id w1-20020a056808018100b00342e8bd2299sm2721215oic.6.2022.10.31.13.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:28:37 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 08/18] RDMA/rxe: Extend rxe_mr_copy to support skb frags
Date:   Mon, 31 Oct 2022 15:27:57 -0500
Message-Id: <20221031202805.19138-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221031202805.19138-1-rpearsonhpe@gmail.com>
References: <20221031202805.19138-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe_mr_copy() currently supports copying between an mr and
a contiguous region of kernel memory.

Rename rxe_mr_copy() to rxe_copy_mr_data().
Extend the operations to support copying between an mr and an skb
fragment list. Fixup calls to rxe_mr_copy() to support the new
API.

This is in preparation for supporting fragmented skbs.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h  |   3 +
 drivers/infiniband/sw/rxe/rxe_mr.c   | 144 +++++++++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_resp.c |  20 ++--
 3 files changed, 117 insertions(+), 50 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 87fb052c1d0a..c62fc2613a01 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -71,6 +71,9 @@ int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr);
 int rxe_add_frag(struct sk_buff *skb, struct rxe_phys_buf *buf,
 		 int length, int offset);
 int rxe_num_mr_frags(struct rxe_mr *mr, u64 iova, int length);
+int rxe_copy_mr_data(struct sk_buff *skb, struct rxe_mr *mr, u64 iova,
+		     void *addr, int skb_offset, int length,
+		     enum rxe_mr_copy_op op);
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		enum rxe_mr_copy_op op);
 int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 23abcf2a0198..37d35413da94 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -343,7 +343,7 @@ int rxe_num_mr_frags(struct rxe_mr *mr, u64 iova, int length)
 	if (length == 0)
 		return 0;
 
-	if (mr->type == IB_MR_TYPE_DMA) {
+	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
 		while (length > 0) {
 			buf_offset = iova & ~PAGE_MASK;
 			bytes = PAGE_SIZE - buf_offset;
@@ -388,70 +388,130 @@ int rxe_num_mr_frags(struct rxe_mr *mr, u64 iova, int length)
 	return num_frags;
 }
 
-/* copy data from a range (vaddr, vaddr+length-1) to or from
- * a mr object starting at iova.
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
  */
-int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
-		enum rxe_mr_copy_op op)
+int rxe_copy_mr_data(struct sk_buff *skb, struct rxe_mr *mr, u64 iova,
+		     void *addr, int skb_offset, int length,
+		     enum rxe_mr_copy_op op)
 {
-	int			err;
-	int			bytes;
-	u8			*va;
-	struct rxe_map		**map;
-	struct rxe_phys_buf	*buf;
-	int			m;
-	int			i;
-	size_t			offset;
+	struct rxe_phys_buf dmabuf;
+	struct rxe_phys_buf *buf;
+	struct rxe_map **map;
+	size_t buf_offset;
+	int bytes;
+	void *va;
+	int m;
+	int i;
+	int err = 0;
 
 	if (length == 0)
 		return 0;
 
-	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
-		u8 *src, *dest;
-
-		src = (op == RXE_COPY_TO_MR) ? addr : ((void *)(uintptr_t)iova);
-
-		dest = (op == RXE_COPY_TO_MR) ? ((void *)(uintptr_t)iova) : addr;
+	switch (mr->ibmr.type) {
+	case IB_MR_TYPE_DMA:
+		va = (void *)(uintptr_t)iova;
+		switch (op) {
+		case RXE_COPY_TO_MR:
+			memcpy(va, addr, length);
+			break;
+		case RXE_COPY_FROM_MR:
+			memcpy(addr, va, length);
+			break;
+		case RXE_FRAG_TO_MR:
+			err = skb_copy_bits(skb, skb_offset, va, length);
+			if (err)
+				return err;
+			break;
+		case RXE_FRAG_FROM_MR:
+			/* limit frag length to PAGE_SIZE */
+			while (length) {
+				dmabuf.addr = iova & PAGE_MASK;
+				buf_offset = iova & ~PAGE_MASK;
+				bytes = PAGE_SIZE - buf_offset;
+				if (bytes > length)
+					bytes = length;
+				err = rxe_add_frag(skb, &dmabuf, bytes,
+						   buf_offset);
+				if (err)
+					return err;
+				iova += bytes;
+				length -= bytes;
+			}
+			break;
+		}
+		return 0;
 
-		memcpy(dest, src, length);
+	case IB_MR_TYPE_MEM_REG:
+	case IB_MR_TYPE_USER:
+		break;
 
-		return 0;
+	default:
+		pr_warn("%s: mr type (%d) not supported\n",
+			__func__, mr->ibmr.type);
+		return -EINVAL;
 	}
 
 	WARN_ON_ONCE(!mr->map);
 
 	err = mr_check_range(mr, iova, length);
-	if (err) {
-		err = -EFAULT;
-		goto err1;
-	}
+	if (err)
+		return -EFAULT;
 
-	lookup_iova(mr, iova, &m, &i, &offset);
+	lookup_iova(mr, iova, &m, &i, &buf_offset);
 
 	map = mr->map + m;
-	buf	= map[0]->buf + i;
+	buf = map[0]->buf + i;
 
 	while (length > 0) {
-		u8 *src, *dest;
-
-		va	= (u8 *)(uintptr_t)buf->addr + offset;
-		src = (op == RXE_COPY_TO_MR) ? addr : va;
-		dest = (op == RXE_COPY_TO_MR) ? va : addr;
-
-		bytes	= buf->size - offset;
-
+		va = (void *)(uintptr_t)buf->addr + buf_offset;
+		bytes = buf->size - buf_offset;
 		if (bytes > length)
 			bytes = length;
 
-		memcpy(dest, src, bytes);
+		switch (op) {
+		case RXE_COPY_TO_MR:
+			memcpy(va, addr, bytes);
+			break;
+		case RXE_COPY_FROM_MR:
+			memcpy(addr, va, bytes);
+			break;
+		case RXE_FRAG_TO_MR:
+			err = skb_copy_bits(skb, skb_offset, va, bytes);
+			if (err)
+				return err;
+			break;
+		case RXE_FRAG_FROM_MR:
+			err = rxe_add_frag(skb, buf, bytes, buf_offset);
+			if (err)
+				return err;
+			break;
+		}
 
-		length	-= bytes;
-		addr	+= bytes;
+		length -= bytes;
+		addr += bytes;
 
-		offset	= 0;
+		buf_offset = 0;
+		skb_offset += bytes;
 		buf++;
 		i++;
 
+		/* we won't overrun since we checked range above */
 		if (i == RXE_BUF_PER_MAP) {
 			i = 0;
 			map++;
@@ -460,9 +520,6 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 	}
 
 	return 0;
-
-err1:
-	return err;
 }
 
 /* copy data in or out of a wqe, i.e. sg list
@@ -535,7 +592,8 @@ int copy_data(
 		if (bytes > 0) {
 			iova = sge->addr + offset;
 
-			err = rxe_mr_copy(mr, iova, addr, bytes, op);
+			err = rxe_copy_mr_data(NULL, mr, iova, addr,
+					       0, bytes, op);
 			if (err)
 				goto err2;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 023df0562258..5f00477544fa 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -535,12 +535,15 @@ static enum resp_states send_data_in(struct rxe_qp *qp, void *data_addr,
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
@@ -766,6 +769,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	int err;
 	struct resp_res *res = qp->resp.res;
 	struct rxe_mr *mr;
+	int skb_offset = 0;
 
 	if (!res) {
 		res = rxe_prepare_res(qp, req_pkt, RXE_READ_MASK);
@@ -806,15 +810,17 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	if (!skb)
 		return RESPST_ERR_RNR;
 
-	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
-			  payload, RXE_COPY_FROM_MR);
-	if (mr)
-		rxe_put(mr);
+	err = rxe_copy_mr_data(skb, mr, res->read.va, payload_addr(&ack_pkt),
+			       skb_offset, payload, RXE_COPY_FROM_MR);
 	if (err) {
 		kfree_skb(skb);
+		rxe_put(mr);
 		return RESPST_ERR_RKEY_VIOLATION;
 	}
 
+	if (mr)
+		rxe_put(mr);
+
 	if (bth_pad(&ack_pkt)) {
 		u8 *pad = payload_addr(&ack_pkt) + payload;
 
-- 
2.34.1

