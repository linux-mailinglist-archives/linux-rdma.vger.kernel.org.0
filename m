Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EC4613EFE
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Oct 2022 21:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiJaU2o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Oct 2022 16:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiJaU2n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Oct 2022 16:28:43 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B2C13EB9
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:40 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id m204so2233506oib.6
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjCtF35HNc5lMjI9u6SvZPnqLYKOdrRqQUk6KF4IPio=;
        b=MZnlBKVm1vuNF9JqClEJdbLHLv7jmXiYSwBiKtlt7dc7kXm2JJzeOlfIGZ2H1m/HI+
         Wy9yDICd+hgQtDKH6P7dU1aFG/sFq4kjp9zSBougYGSsBCvtc0khfMCslXltMlWwF0sz
         Iv6+/fDEBRcjPmxsK4SptAvBFULkr1NmVL/Nil9XxfQFs//z7SXbej/Gn+iinvgaXA/O
         whMPl6HaHo5dq8m6g0OvyCxWxbmoo+r/rx4ez5k3L3lNcz5csRuXs4grOdIAKilIMQQB
         l47e+Zr6c3jXyNpvezndHkp5mNqAw3ctJTGncvShpxt+qyL932mOEKvpPdrTvQnnLx8C
         XK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjCtF35HNc5lMjI9u6SvZPnqLYKOdrRqQUk6KF4IPio=;
        b=E+uft8JJIebRYhIUZ0/W1qJunWjVUMhFSDxdKnvBSxmuKKiudr2V1yH7me7RrEaf+3
         YRAfQqW76b6fGXDIWsq92CbwVwMK7sltOq42Us932ZX3bnccuIWHMEQLuwbbfyviUflq
         fLA517xYhIvUd+fcrOmWT+w66jZy5DRxABlvqI/eWHh4ck3RQkSdINMqAhsH9G/Jgpf2
         Qsqv3nCFrzdzc/bHuCXXGEw9zZ1X1715TGvwHrs3JaekPZAQUfdvGUOd2QJY0YxUMdrq
         ZuLNWy7HvHjWOO9fiprrmOi1CoCLRbWHePgmCRgOiejVrhZu83TA99bjAtXrHonjBtG4
         Z0RA==
X-Gm-Message-State: ACrzQf1QvdLSFyNCbTS3irHSu7o8XHHR+8OM77s1h4LDCnOPdsJWqYDE
        XfnlQmwCRcF+UbCy61HtjQM=
X-Google-Smtp-Source: AMsMyM5KUaC2NEcvSOCVtiBMdOq/n4VtyiQ5YXRsUmHgzedxDoid8JmNEaWz1nnlKUQgK70CNwq5dg==
X-Received: by 2002:a05:6808:1b0b:b0:35a:1a7c:ba9e with SMTP id bx11-20020a0568081b0b00b0035a1a7cba9emr1754423oib.25.1667248119830;
        Mon, 31 Oct 2022 13:28:39 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-ce7d-a808-badd-629d.res6.spectrum.com. [2603:8081:140c:1a00:ce7d:a808:badd:629d])
        by smtp.googlemail.com with ESMTPSA id w1-20020a056808018100b00342e8bd2299sm2721215oic.6.2022.10.31.13.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:28:39 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 09/18] RDMA/rxe: Add routine to compute number of frags for dma
Date:   Mon, 31 Oct 2022 15:27:58 -0500
Message-Id: <20221031202805.19138-9-rpearsonhpe@gmail.com>
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

Add routine named rxe_num_dma_frags() to compute the number of skb
frags needed to copy length bytes from a dma info struct.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h |  4 +-
 drivers/infiniband/sw/rxe/rxe_mr.c  | 67 ++++++++++++++++++++++++++++-
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index c62fc2613a01..4c30ffaccc92 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -76,10 +76,12 @@ int rxe_copy_mr_data(struct sk_buff *skb, struct rxe_mr *mr, u64 iova,
 		     enum rxe_mr_copy_op op);
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		enum rxe_mr_copy_op op);
+int rxe_num_dma_frags(const struct rxe_pd *pd, const struct rxe_dma_info *dma,
+		      int length);
 int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
 	      void *addr, int length, enum rxe_mr_copy_op op);
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
-struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
+struct rxe_mr *lookup_mr(const struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type);
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 37d35413da94..99d0b5afefc3 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -522,6 +522,71 @@ int rxe_copy_mr_data(struct sk_buff *skb, struct rxe_mr *mr, u64 iova,
 	return 0;
 }
 
+/**
+ * rxe_num_dma_frags() - Count the number of skb frags needed to copy
+ *			 length bytes from a dma info struct to an skb
+ * @pd: protection domain used by dma entries
+ * @dma: dma info
+ * @length: number of bytes to copy
+ *
+ * Returns: number of frags needed or negative error
+ */
+int rxe_num_dma_frags(const struct rxe_pd *pd, const struct rxe_dma_info *dma,
+		      int length)
+{
+	int cur_sge = dma->cur_sge;
+	const struct rxe_sge *sge = &dma->sge[cur_sge];
+	int buf_offset = dma->sge_offset;
+	int resid = dma->resid;
+	struct rxe_mr *mr = NULL;
+	int bytes;
+	u64 iova;
+	int ret;
+	int num_frags = 0;
+
+	if (length == 0)
+		return 0;
+
+	if (length > resid)
+		return -EINVAL;
+
+	while (length > 0) {
+		if (buf_offset >= sge->length) {
+			if (mr)
+				rxe_put(mr);
+
+			sge++;
+			cur_sge++;
+			buf_offset = 0;
+
+			if (cur_sge >= dma->num_sge)
+				return -ENOSPC;
+			if (!sge->length)
+				continue;
+		}
+
+		mr = lookup_mr(pd, 0, sge->lkey, RXE_LOOKUP_LOCAL);
+		if (!mr)
+			return -EINVAL;
+
+		bytes = min_t(int, length, sge->length - buf_offset);
+		if (bytes > 0) {
+			iova = sge->addr + buf_offset;
+			ret = rxe_num_mr_frags(mr, iova, length);
+			if (ret < 0) {
+				rxe_put(mr);
+				return ret;
+			}
+
+			buf_offset += bytes;
+			resid -= bytes;
+			length -= bytes;
+		}
+	}
+
+	return num_frags;
+}
+
 /* copy data in or out of a wqe, i.e. sg list
  * under the control of a dma descriptor
  */
@@ -658,7 +723,7 @@ int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
  * (3) verify that the mr can support the requested access
  * (4) verify that mr state is valid
  */
-struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
+struct rxe_mr *lookup_mr(const struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type)
 {
 	struct rxe_mr *mr;
-- 
2.34.1

