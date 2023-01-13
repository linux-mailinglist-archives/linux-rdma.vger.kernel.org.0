Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06F366A70E
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Jan 2023 00:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjAMX2C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Jan 2023 18:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjAMX2B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Jan 2023 18:28:01 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730037A397
        for <linux-rdma@vger.kernel.org>; Fri, 13 Jan 2023 15:28:00 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id i26-20020a9d68da000000b00672301a1664so13057050oto.6
        for <linux-rdma@vger.kernel.org>; Fri, 13 Jan 2023 15:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9wMGObKT8LqdYGdJxfp6Pi1vT8lU038I/3cKeDppoE=;
        b=DuY+RfSco8zei/9qAyYekMe4GDNwqF132J5PWnaj+DgL9Xfu0uOTa4uu7RL1/+od77
         b8kndQ9X5tBm+yo03Ivrze6wyinCMlNdp+AX/SBuszuPzFgaUHYHbxwmtu+33znjE8O5
         1EHEl6u9k+1jXrjGPPS1Xf4JcHhJA72FbZIVY6BZfp7GUEoY56Wf4spXsdhUnA67ft/m
         qCQYnnqyjq+vZ7N3sZffKyj3BpzIEpD85khMEMkHh/q0aM6bBdEFiS+F0RLyXsSCsYCs
         QFYyedihULiTrZYi9A3NaP/bhXYAPtoGBmTxVPeowiCgMiMvRIDpa+hvhjXTZmNI8pbS
         KK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9wMGObKT8LqdYGdJxfp6Pi1vT8lU038I/3cKeDppoE=;
        b=7KRWnfm/71ux55wYGBvNC4XjE0/O9fBGJ+eB0djI0ngVjZbi6bZzh6Icegm0j1XJ7C
         g1zBuvb6OnmVKde49G6ZPFDSfTam9R//4sCCT5KxYOfNHb/G7uhNhivdUKnp/4eh2xAn
         KsZzh1OdcY3ENHsURWkknesTMVs2BxCLz033MqEj+JnLwaXMmZ5mljqv37S7n4pauRLl
         y8IPTLWbOvcE59uPXFm4VoroOsKxK3ASHB9V7bxjUJ5JqG/tFuV9kQBF6fKpOt56Ov6o
         kztVKJlYXKSY4T9UaEAjLXpNYS2iixP91takQ2KdaD0l4Aq95cNdwMKwLrWBzMU3iNAK
         QBVw==
X-Gm-Message-State: AFqh2kqV/600lG100vAgVDQ/q3lfK3Qv1eoss6tBXwwtUs63X1EjhnCL
        YxvCgthoMe0NJ1e6SKNL5xQ=
X-Google-Smtp-Source: AMrXdXsesoDjljT514r4W7Ot68qy6CE1d7XisNAwAVa798ubT7gPcsZXU1qfWUlBLroCzl7y5BDclw==
X-Received: by 2002:a05:6830:6209:b0:661:dfeb:a95e with SMTP id cd9-20020a056830620900b00661dfeba95emr7760569otb.9.1673652479847;
        Fri, 13 Jan 2023 15:27:59 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-3f47-8433-ec70-f475.res6.spectrum.com. [2603:8081:140c:1a00:3f47:8433:ec70:f475])
        by smtp.gmail.com with ESMTPSA id q13-20020a9d57cd000000b0066871c3adb3sm11297433oti.28.2023.01.13.15.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 15:27:59 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leonro@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 4/6] RDMA-rxe: Isolate mr code from atomic_write_reply()
Date:   Fri, 13 Jan 2023 17:27:04 -0600
Message-Id: <20230113232704.20072-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230113232704.20072-1-rpearsonhpe@gmail.com>
References: <20230113232704.20072-1-rpearsonhpe@gmail.com>
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

Isolate mr specific code from atomic_write_reply() in rxe_resp.c into
a subroutine rxe_mr_do_atomic_write() in rxe_mr.c.
Check length for atomic write operation.
Make iova_to_vaddr() static.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v3:
  Fixed bug reported by kernel test robot. Ifdef'ed out atomic 8 byte
  write if CONFIG_64BIT is not defined as orignally intended by the
  developers of the atomic write implementation.
link: https://lore.kernel.org/linux-rdma/202301131143.CmoyVcul-lkp@intel.com/

 drivers/infiniband/sw/rxe/rxe_loc.h  |  1 +
 drivers/infiniband/sw/rxe/rxe_mr.c   | 50 ++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_resp.c | 58 +++++++++++-----------------
 3 files changed, 73 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index bcb1bbcf50df..fd70c71a9e4e 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -74,6 +74,7 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
 int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 			u64 compare, u64 swap_add, u64 *orig_val);
+int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, void *addr);
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type);
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 791731be6067..1e74f5e8e10b 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -568,6 +568,56 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 	return 0;
 }
 
+/**
+ * rxe_mr_do_atomic_write() - write 64bit value to iova from addr
+ * @mr: memory region
+ * @iova: iova in mr
+ * @addr: source of data to write
+ *
+ * Returns:
+ *	 0 on success
+ *	-1 for misaligned address
+ *	-2 for access errors
+ *	-3 for cpu without native 64 bit support
+ */
+int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, void *addr)
+{
+#if defined CONFIG_64BIT
+	u64 *vaddr;
+	u64 value;
+	unsigned int length = 8;
+
+	/* See IBA oA19-28 */
+	if (unlikely(mr->state != RXE_MR_STATE_VALID)) {
+		rxe_dbg_mr(mr, "mr not valid");
+		return -2;
+	}
+
+	/* See IBA A19.4.2 */
+	if (unlikely((uintptr_t)vaddr & 0x7 || iova & 0x7)) {
+		rxe_dbg_mr(mr, "misaligned address");
+		return -1;
+	}
+
+	vaddr = iova_to_vaddr(mr, iova, length);
+	if (unlikely(!vaddr)) {
+		rxe_dbg_mr(mr, "iova out of range");
+		return -2;
+	}
+
+	/* this makes no sense. What of payload is not 8? */
+	memcpy(&value, addr, length);
+
+	/* Do atomic write after all prior operations have completed */
+	smp_store_release(vaddr, value);
+
+	return 0;
+#else
+	rxe_dbg_mr(mr, "64 bit integers not atomic");
+	return -3;
+#endif
+}
+
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
 {
 	struct rxe_sge		*sge	= &dma->sge[dma->cur_sge];
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 02301e3f343c..1083cda22c65 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -762,26 +762,33 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 	return RESPST_ACKNOWLEDGE;
 }
 
-#ifdef CONFIG_64BIT
-static enum resp_states do_atomic_write(struct rxe_qp *qp,
-					struct rxe_pkt_info *pkt)
+static enum resp_states atomic_write_reply(struct rxe_qp *qp,
+					   struct rxe_pkt_info *pkt)
 {
+	u64 iova = qp->resp.va + qp->resp.offset;
+	struct resp_res *res = qp->resp.res;
 	struct rxe_mr *mr = qp->resp.mr;
+	void *addr = payload_addr(pkt);
 	int payload = payload_size(pkt);
-	u64 src, *dst;
-
-	if (mr->state != RXE_MR_STATE_VALID)
-		return RESPST_ERR_RKEY_VIOLATION;
+	int err;
 
-	memcpy(&src, payload_addr(pkt), payload);
+	if (!res) {
+		res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_WRITE_MASK);
+		qp->resp.res = res;
+	}
 
-	dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, payload);
-	/* check vaddr is 8 bytes aligned. */
-	if (!dst || (uintptr_t)dst & 7)
-		return RESPST_ERR_MISALIGNED_ATOMIC;
+	if (res->replay)
+		return RESPST_ACKNOWLEDGE;
 
-	/* Do atomic write after all prior operations have completed */
-	smp_store_release(dst, src);
+	err = rxe_mr_do_atomic_write(mr, iova, addr);
+	if (unlikely(err)) {
+		if (err == -3)
+			return RESPST_ERR_UNSUPPORTED_OPCODE;
+		else if (err == -2)
+			return RESPST_ERR_RKEY_VIOLATION;
+		else
+			return RESPST_ERR_MISALIGNED_ATOMIC;
+	}
 
 	/* decrease resp.resid to zero */
 	qp->resp.resid -= sizeof(payload);
@@ -794,29 +801,8 @@ static enum resp_states do_atomic_write(struct rxe_qp *qp,
 
 	qp->resp.opcode = pkt->opcode;
 	qp->resp.status = IB_WC_SUCCESS;
-	return RESPST_ACKNOWLEDGE;
-}
-#else
-static enum resp_states do_atomic_write(struct rxe_qp *qp,
-					struct rxe_pkt_info *pkt)
-{
-	return RESPST_ERR_UNSUPPORTED_OPCODE;
-}
-#endif /* CONFIG_64BIT */
-
-static enum resp_states atomic_write_reply(struct rxe_qp *qp,
-					   struct rxe_pkt_info *pkt)
-{
-	struct resp_res *res = qp->resp.res;
 
-	if (!res) {
-		res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_WRITE_MASK);
-		qp->resp.res = res;
-	}
-
-	if (res->replay)
-		return RESPST_ACKNOWLEDGE;
-	return do_atomic_write(qp, pkt);
+	return RESPST_ACKNOWLEDGE;
 }
 
 static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
-- 
2.37.2

