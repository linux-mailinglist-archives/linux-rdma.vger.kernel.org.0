Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CEC6747C8
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jan 2023 01:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjATADz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Jan 2023 19:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjATADd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Jan 2023 19:03:33 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539ECA103C
        for <linux-rdma@vger.kernel.org>; Thu, 19 Jan 2023 16:02:54 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id s66so3115647oib.7
        for <linux-rdma@vger.kernel.org>; Thu, 19 Jan 2023 16:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2BKlIDukzXJiyTlHXLoZNDafNftANyGeYBmpVK6WjI=;
        b=K/X+6fXKdxT7/OYRlW1B7OXwv2U1zytFOciOsHD4FQqau810W+YHtHaOBNUpO3En4Q
         SFbCA6oNg8KUM5T87Utnsb8T9ZMlyViC8zjSSG+tQaNu5OVhb5TsGyrXh1rv9xS+95jX
         +wX+5tZ4yOxmng1qUB3F9MitqjgcNpH7kP6KOx1q9JrKUbIkJN5CqCHjbTJrdJ4yXZHZ
         JAdzfUsDOKAh0NpILeFYk1fGqfFy7eRFsRduXvuSz0NZc1ZAR5lX4+EXQLp/r5I8NM7h
         UXXcp002Z5wY6h9vwvxaFnmNfTQmKrPwpKoZlPLtcpNBlkax861TAfzi8T3H24JTmj5m
         tsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2BKlIDukzXJiyTlHXLoZNDafNftANyGeYBmpVK6WjI=;
        b=3j356KBcDU+uPviYrq3NUW9TrUrbUR49THBOPZLP2VRGEM1z/Bab82uJfpWS6lSlJ8
         lywsGqPrZr5bU7yeHBj1Kqm8ooYqKhs3RfZ5zIq4Xj8rVQW5rIWDeABjHvJv6JbAR/aM
         kI8m/WsY1D7U0xRJ9C+4/IA9J8OmlSIvBASXiXoihrl/igXIv7WUY3Kh0u1NkdsyZrhk
         u+6/kz+MwyXfPVfI5OVQ8kPRYvHZCIfBmqX3s3Bv99Yo/v9f6qSVvWPIFZVxvPWw4ONP
         AZRRyCtE1FArDRfuckYRxoRB+NALbmPffAxcV9xIqlYLdv27BgRovwLqdsmENjYSC1uW
         svQg==
X-Gm-Message-State: AFqh2ko9DMA4xQVsj8krCn43JZ5slmuIma634ZO+bcqTtHleY3En6ecX
        3r9UC7yaMUvhTqs2upSkX5I=
X-Google-Smtp-Source: AMrXdXunr+ykqiuxXiI3K2+wkESotMK+pHG88Cs7lhEmlpyPNhlfxIRO6FoPEPUWdwiBKfcPQn6m5A==
X-Received: by 2002:a05:6808:1889:b0:36d:ba2e:9a27 with SMTP id bi9-20020a056808188900b0036dba2e9a27mr3917159oib.34.1674172973994;
        Thu, 19 Jan 2023 16:02:53 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-d086-74d8-5274-c0f1.res6.spectrum.com. [2603:8081:140c:1a00:d086:74d8:5274:c0f1])
        by smtp.gmail.com with ESMTPSA id bj23-20020a056808199700b0036718f58b7esm6139394oib.15.2023.01.19.16.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 16:02:53 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leonro@nvidia.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v7 4/6] RDMA-rxe: Isolate mr code from atomic_write_reply()
Date:   Thu, 19 Jan 2023 17:59:35 -0600
Message-Id: <20230119235936.19728-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230119235936.19728-1-rpearsonhpe@gmail.com>
References: <20230119235936.19728-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_loc.h  |  2 +-
 drivers/infiniband/sw/rxe/rxe_mr.c   | 38 ++++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_resp.c | 61 ++++++++++------------------
 3 files changed, 59 insertions(+), 42 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index bcb1bbcf50df..ad8bd6bd728a 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -71,9 +71,9 @@ int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
 	      void *addr, int length, enum rxe_mr_copy_dir dir);
 int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 		  int sg_nents, unsigned int *sg_offset);
-void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
 int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 			u64 compare, u64 swap_add, u64 *orig_val);
+int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value);
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type);
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index df9741474f1f..5c4ce43914fa 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -297,7 +297,7 @@ static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
 	}
 }
 
-void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
+static void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 {
 	size_t offset;
 	int m, n;
@@ -565,6 +565,42 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 	return 0;
 }
 
+/* only implemented for 64 bit architectures */
+#if defined CONFIG_64BIT
+int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
+{
+	u64 *va;
+
+	/* See IBA oA19-28 */
+	if (unlikely(mr->state != RXE_MR_STATE_VALID)) {
+		rxe_dbg_mr(mr, "mr not in valid state");
+		return RESPST_ERR_RKEY_VIOLATION;
+	}
+
+	va = iova_to_vaddr(mr, iova, sizeof(value));
+	if (unlikely(!va)) {
+		rxe_dbg_mr(mr, "iova out of range");
+		return RESPST_ERR_RKEY_VIOLATION;
+	}
+
+	/* See IBA A19.4.2 */
+	if (unlikely((uintptr_t)va & 0x7 || iova & 0x7)) {
+		rxe_dbg_mr(mr, "misaligned address");
+		return RESPST_ERR_MISALIGNED_ATOMIC;
+	}
+
+	/* Do atomic write after all prior operations have completed */
+	smp_store_release(va, value);
+
+	return 0;
+}
+#else
+int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
+{
+	return RESPST_ERR_UNSUPPORTED_OPCODE;
+}
+#endif
+
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
 {
 	struct rxe_sge		*sge	= &dma->sge[dma->cur_sge];
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 9d4b4e9b42fc..cd2d88de287c 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -723,30 +723,32 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 	return RESPST_ACKNOWLEDGE;
 }
 
-#ifdef CONFIG_64BIT
-static enum resp_states do_atomic_write(struct rxe_qp *qp,
-					struct rxe_pkt_info *pkt)
+static enum resp_states atomic_write_reply(struct rxe_qp *qp,
+					   struct rxe_pkt_info *pkt)
 {
-	struct rxe_mr *mr = qp->resp.mr;
-	int payload = payload_size(pkt);
-	u64 src, *dst;
-
-	if (mr->state != RXE_MR_STATE_VALID)
-		return RESPST_ERR_RKEY_VIOLATION;
+	struct resp_res *res = qp->resp.res;
+	struct rxe_mr *mr;
+	u64 value;
+	u64 iova;
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
+	mr = qp->resp.mr;
+	value = *(u64 *)payload_addr(pkt);
+	iova = qp->resp.va + qp->resp.offset;
 
-	/* decrease resp.resid to zero */
-	qp->resp.resid -= sizeof(payload);
+	err = rxe_mr_do_atomic_write(mr, iova, value);
+	if (err)
+		return err;
 
+	qp->resp.resid = 0;
 	qp->resp.msn++;
 
 	/* next expected psn, read handles this separately */
@@ -755,29 +757,8 @@ static enum resp_states do_atomic_write(struct rxe_qp *qp,
 
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

