Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C1A6100CF
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 20:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbiJ0S4V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 14:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbiJ0S4R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 14:56:17 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122783ECF6
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:16 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id d18-20020a05683025d200b00661c6f1b6a4so1615333otu.1
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgfK65zhGxM3YpTMVzt80iGe2w+uRgkCclbJ+PVGusU=;
        b=ahcG85LZqWnEnksh3uOtK6Si8CG7PReDFThyA9n4fueuH4KKTnDi2jYQaV3adId2PC
         TrqU/1A+TidovKe0VN4ZZTjMAizlWnPeMAu9S6IfUeGqmFdpEi1Jm+r8DPj/U/BQpvTi
         hfM/QD41WNhvoNZ1dV1QcEVl6VAZ+4m+FkPfz7Uhh3hTVmrYb4LiwVAdpUGQoZJYCRHR
         4n27skBeoT15sqcMh6AtfL9mGX0qSEDqiZGLMsBTGooPIPly6ir6fu78OGHY93jIxVjg
         kzSGIfU1q2doycJ34r+1ehbq0QNhbIUdWC1e2W+o+dVf+0PXoX+LABEyey+SbXEOy9wu
         WioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgfK65zhGxM3YpTMVzt80iGe2w+uRgkCclbJ+PVGusU=;
        b=w9GwuszW4Kn7tU2GE1oAqFogiwAYjDVxVnP8luTDr/5A7epOTAo4+yzKM/FMnwoR+6
         f1THuXx8RlTNK3cjUFMWUNQ86VkkeEEhTAqouDz8w0KBJd16qQkAgI2bXC74MPqwlNMg
         NFZo2pMPdt4tjlq6t423QXGTzpQ1DMnPMUjAeJPTsiBHb0QhAx3J7Uovl4G4mJi4ZC3D
         0M4C45Q5s5h4nqJIKzAdClkI4VWS7hE2Ugia3tuaOKxLnBpvUqjIz9ZgVwtndMg6V4Jm
         deqOPp/ICJNFj3kvBnh/7HgY7uij93nFKaijJN1euJkpFRiHF/7DIzDoAGLaUhlJ3VYn
         Stnw==
X-Gm-Message-State: ACrzQf2wJYEPM3dE8x51lnJqnvqesqyZhdyD4Bi2wCWqKN+G6Qq7OBh3
        9Q0P0k27PvjaGkgsc7mS2pQ=
X-Google-Smtp-Source: AMsMyM6sokGDC1jzAfIm7VjGi7+/cnDCv+WUtI7mdEeSh/6gmKNUSH2Cl523cilAJiaCehHTfd0JCg==
X-Received: by 2002:a9d:2ae8:0:b0:667:d857:55bc with SMTP id e95-20020a9d2ae8000000b00667d85755bcmr6324731otb.50.1666896975397;
        Thu, 27 Oct 2022 11:56:15 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f015-3653-e617-fa3f.res6.spectrum.com. [2603:8081:140c:1a00:f015:3653:e617:fa3f])
        by smtp.googlemail.com with ESMTPSA id f1-20020a4a8f41000000b0049602fb9b4csm732736ool.46.2022.10.27.11.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 11:56:14 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 04/17] RDMA/rxe: Add sg fragment ops
Date:   Thu, 27 Oct 2022 13:54:58 -0500
Message-Id: <20221027185510.33808-5-rpearsonhpe@gmail.com>
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

Rename rxe_mr_copy_dir to rxe_mr_copy_op and add new operations for
copying between an skb fragment list and an mr.

This is in preparation for supporting fragmented skbs.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  |  4 ++--
 drivers/infiniband/sw/rxe/rxe_loc.h   |  4 ++--
 drivers/infiniband/sw/rxe/rxe_mr.c    | 14 +++++++-------
 drivers/infiniband/sw/rxe/rxe_req.c   |  2 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  |  9 +++++----
 drivers/infiniband/sw/rxe/rxe_verbs.h | 15 ++++++++++++---
 6 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index c9170dd99f3a..77640e35ae88 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -356,7 +356,7 @@ static inline enum comp_state do_read(struct rxe_qp *qp,
 
 	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
 			&wqe->dma, payload_addr(pkt),
-			payload_size(pkt), RXE_TO_MR_OBJ);
+			payload_size(pkt), RXE_COPY_TO_MR);
 	if (ret) {
 		wqe->status = IB_WC_LOC_PROT_ERR;
 		return COMPST_ERROR;
@@ -378,7 +378,7 @@ static inline enum comp_state do_atomic(struct rxe_qp *qp,
 
 	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
 			&wqe->dma, &atomic_orig,
-			sizeof(u64), RXE_TO_MR_OBJ);
+			sizeof(u64), RXE_COPY_TO_MR);
 	if (ret) {
 		wqe->status = IB_WC_LOC_PROT_ERR;
 		return COMPST_ERROR;
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 574a6afc1199..ff803a957ac1 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -69,9 +69,9 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr);
 int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr);
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
-		enum rxe_mr_copy_dir dir);
+		enum rxe_mr_copy_op op);
 int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
-	      void *addr, int length, enum rxe_mr_copy_dir dir);
+	      void *addr, int length, enum rxe_mr_copy_op op);
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 502e9ada99b3..1cb997caa292 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -290,7 +290,7 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
  * a mr object starting at iova.
  */
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
-		enum rxe_mr_copy_dir dir)
+		enum rxe_mr_copy_op op)
 {
 	int			err;
 	int			bytes;
@@ -307,9 +307,9 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 	if (mr->type == IB_MR_TYPE_DMA) {
 		u8 *src, *dest;
 
-		src = (dir == RXE_TO_MR_OBJ) ? addr : ((void *)(uintptr_t)iova);
+		src = (op == RXE_COPY_TO_MR) ? addr : ((void *)(uintptr_t)iova);
 
-		dest = (dir == RXE_TO_MR_OBJ) ? ((void *)(uintptr_t)iova) : addr;
+		dest = (op == RXE_COPY_TO_MR) ? ((void *)(uintptr_t)iova) : addr;
 
 		memcpy(dest, src, length);
 
@@ -333,8 +333,8 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		u8 *src, *dest;
 
 		va	= (u8 *)(uintptr_t)buf->addr + offset;
-		src = (dir == RXE_TO_MR_OBJ) ? addr : va;
-		dest = (dir == RXE_TO_MR_OBJ) ? va : addr;
+		src = (op == RXE_COPY_TO_MR) ? addr : va;
+		dest = (op == RXE_COPY_TO_MR) ? va : addr;
 
 		bytes	= buf->size - offset;
 
@@ -372,7 +372,7 @@ int copy_data(
 	struct rxe_dma_info	*dma,
 	void			*addr,
 	int			length,
-	enum rxe_mr_copy_dir	dir)
+	enum rxe_mr_copy_op	op)
 {
 	int			bytes;
 	struct rxe_sge		*sge	= &dma->sge[dma->cur_sge];
@@ -433,7 +433,7 @@ int copy_data(
 		if (bytes > 0) {
 			iova = sge->addr + offset;
 
-			err = rxe_mr_copy(mr, iova, addr, bytes, dir);
+			err = rxe_mr_copy(mr, iova, addr, bytes, op);
 			if (err)
 				goto err2;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 8cc683ebf536..9d92acfb2fcf 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -450,7 +450,7 @@ static int rxe_init_payload(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		wqe->dma.sge_offset += payload;
 	} else {
 		err = copy_data(qp->pd, 0, &wqe->dma, payload_addr(pkt),
-				payload, RXE_FROM_MR_OBJ);
+				payload, RXE_COPY_FROM_MR);
 	}
 
 	return err;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index a00885799619..4b185ddac887 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -524,7 +524,7 @@ static enum resp_states send_data_in(struct rxe_qp *qp, void *data_addr,
 	int err;
 
 	err = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE, &qp->resp.wqe->dma,
-			data_addr, data_len, RXE_TO_MR_OBJ);
+			data_addr, data_len, RXE_COPY_TO_MR);
 	if (unlikely(err))
 		return (err == -ENOSPC) ? RESPST_ERR_LENGTH
 					: RESPST_ERR_MALFORMED_WQE;
@@ -540,7 +540,7 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
 	int data_len = payload_size(pkt);
 
 	err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
-			  payload_addr(pkt), data_len, RXE_TO_MR_OBJ);
+			  payload_addr(pkt), data_len, RXE_COPY_TO_MR);
 	if (err) {
 		rc = RESPST_ERR_RKEY_VIOLATION;
 		goto out;
@@ -807,8 +807,9 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		return RESPST_ERR_RNR;
 
 	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
-			  payload, RXE_FROM_MR_OBJ);
-	rxe_put(mr);
+			  payload, RXE_COPY_FROM_MR);
+	if (mr)
+		rxe_put(mr);
 	if (err) {
 		kfree_skb(skb);
 		return RESPST_ERR_RKEY_VIOLATION;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 5f5cbfcb3569..b3218715ef5d 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -267,9 +267,18 @@ enum rxe_mr_state {
 	RXE_MR_STATE_VALID,
 };
 
-enum rxe_mr_copy_dir {
-	RXE_TO_MR_OBJ,
-	RXE_FROM_MR_OBJ,
+/**
+ * enum rxe_mr_copy_op - Operations peformed by rxe_copy_mr/dma_data()
+ * @RXE_COPY_TO_MR:	Copy data from packet to MR(s)
+ * @RXE_COPY_FROM_MR:	Copy data from MR(s) to packet
+ * @RXE_FRAG_TO_MR:	Copy data from frag list to MR(s)
+ * @RXE_FRAG_FROM_MR:	Copy data from MR(s) to frag list
+ */
+enum rxe_mr_copy_op {
+	RXE_COPY_TO_MR,
+	RXE_COPY_FROM_MR,
+	RXE_FRAG_TO_MR,
+	RXE_FRAG_FROM_MR,
 };
 
 enum rxe_mr_lookup_type {
-- 
2.34.1

