Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03E46100D2
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 20:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbiJ0S4W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 14:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbiJ0S4U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 14:56:20 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB341248C0
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:18 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id s206so3405246oie.3
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IP44sTc2xj7SImr8+JKsYI5I/w/qT5HqhNNRRehFm3o=;
        b=aMhOc15B4MPVAeVxndr95FnGiwiP8RL5VjoRzCoF4dPparWIvVL8woaxR2jFp9WfLa
         6S2NsgwlW7gdCTBxDIaSXY+vrkEQ5g6Ukkg17330edrDn32+YY9HZwbDjdw3DwjZNAj1
         VMx77h3emAuO1c31x7uKaIRSeFXIiaOpSELcnq1bO0V6fKut1Fkz/qrZKhJ0WdvCD1f0
         BwZk0ujwTShC5+TJYFPvUc0vPLIMLBFoTZihlG4VRYsRff1PwK5sIQQcy5VdTV9yv8nk
         WgjskE+a9kaelY01ds3Acs7TcggHtLhhYikitRuoYXkuFchd3unGzmP03MRmODJMWgXO
         bOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IP44sTc2xj7SImr8+JKsYI5I/w/qT5HqhNNRRehFm3o=;
        b=Ikq6LlLSzEYdQTZM8lGxTMqHLwnxfTP2SHdvaD6vVNAVFUr0P9u5shrWsEPJ0FYK0n
         Iu21zv/mX24nj+YK7jcs38D9laYURwlZqumWskg5/MctH5S+URL+9JZa2munnfi1IzwM
         2SAbmotR6HGt8a3P+/pg/imKwM9w4T6lLa+EvQT2VpwxnUnJcVDYqhE2UnapeI06raBN
         +pFr2P09m3RDseeCRJ+bF2QHWdyHvw2WKMhk/Rk+LwvQdzkUH5H1kU/d+wTYTOjL9pUV
         KuqVh3EzAg365Oqrp8rR+k+Nrly60dZkJVrMwquYVUrXVMTp0NJxEaDsJEnGkAbUQJJS
         cL8Q==
X-Gm-Message-State: ACrzQf3H0QgiNCDVKVI6f26YaCen2AoAyRDT4wQ0cqWm5c/SyWCuRX+u
        sM3djJAseTfNPf8IS0lb2oM=
X-Google-Smtp-Source: AMsMyM51GfGir5Mq6DGi/eDMQxyq4En1oaMgOofJ5nGvBa4cDCQw1McbXi3k3GA2FzKCjchp3OuxtA==
X-Received: by 2002:a05:6808:e8f:b0:345:7a77:2ae0 with SMTP id k15-20020a0568080e8f00b003457a772ae0mr5832185oil.52.1666896978566;
        Thu, 27 Oct 2022 11:56:18 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f015-3653-e617-fa3f.res6.spectrum.com. [2603:8081:140c:1a00:f015:3653:e617:fa3f])
        by smtp.googlemail.com with ESMTPSA id f1-20020a4a8f41000000b0049602fb9b4csm732736ool.46.2022.10.27.11.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 11:56:18 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 07/17] RDMA/rxe: Extend rxe_mr_copy to support skb frags
Date:   Thu, 27 Oct 2022 13:55:01 -0500
Message-Id: <20221027185510.33808-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027185510.33808-1-rpearsonhpe@gmail.com>
References: <20221027185510.33808-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_mr.c   | 142 +++++++++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_resp.c |  20 ++--
 3 files changed, 116 insertions(+), 49 deletions(-)

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
index dd4dbe117c91..fd39b3e17f41 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
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
 
-	if (mr->type == IB_MR_TYPE_DMA) {
-		u8 *src, *dest;
-
-		src = (op == RXE_COPY_TO_MR) ? addr : ((void *)(uintptr_t)iova);
-
-		dest = (op == RXE_COPY_TO_MR) ? ((void *)(uintptr_t)iova) : addr;
+	switch (mr->type) {
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
+			__func__, mr->type);
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
index 4b185ddac887..ba359242118a 100644
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

