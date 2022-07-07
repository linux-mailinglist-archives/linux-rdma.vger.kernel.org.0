Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5F2569B96
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Jul 2022 09:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiGGHaT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Jul 2022 03:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiGGHaT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Jul 2022 03:30:19 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8495424971
        for <linux-rdma@vger.kernel.org>; Thu,  7 Jul 2022 00:30:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id n4so11613873ejz.10
        for <linux-rdma@vger.kernel.org>; Thu, 07 Jul 2022 00:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8MsJ6BI4hN+BIsxK0CDEFRUnRcg1mVyEgqX6ss2vClA=;
        b=lkBKsuD7s4cSnZfnDT3OU9ZqKOr6I1gUQKs2XgZnVVBAXWlPuiERR/2TTuIATNyui/
         rCURKFFk2lxCe6KeRJMW17+RtlbiF0TzhzdkTMfNM9/8zg62GI+2k6rNlp7YjRncZJGg
         5hi8Ok9NKhLNiOhURjHYwvN3qLblAw3s0bw3tCxZ3BE51I+xiv/+T5BbMYYrD+vjP8cF
         zc5C+lxgXD5xCKRmOgdv3F8a7J1LMk2BW3QlsyLM4Df3y9IpTaSSk1xKOhRTJJ+0M3Cb
         RADe8428YelUsX1ynmDEc7/UEarYoNGO8AlnOoircIiDV73l46tEaXSlJuOzrCbbP33F
         f3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8MsJ6BI4hN+BIsxK0CDEFRUnRcg1mVyEgqX6ss2vClA=;
        b=4hnCoMky92A0Yz12cRyeeL5ZbM8jI+Blx0BDCvELBWlZLL+V8Z92NYQPvMg47UKUZO
         CJirCekwZIW4ZgoUOc0m1NGtZrsduUZOL5S6+5Gza3KNBvL6/b6Mcr7pDJ59CsBut+oL
         oCsAtGfX/tr/z89B1XJdnQt8IpOMJotbwaEzBdDcU5TuCQabfF9TNjlXDiVhT0EA16m5
         bZGC5/wm9b1P5SsaHV37JDz66IyOnr05uOHy5NHSagtGPchaC0b2MjHyv7HKbNxaklaZ
         ke5a16pWi1hO7mVxcIHPKkIDCkRrgrGBuM3QoqdNIyGSjeWP0GP6lzGES9aFpsdl5yvp
         j2Bg==
X-Gm-Message-State: AJIora8pRsyFMXNcQRRr4OeY0ehDMsXnadYTtSjaLnweD3k0tO/5C0st
        3v5dQ7BVNS9SakhvIcqw3/wDRm7OUs2KNM/W
X-Google-Smtp-Source: AGRyM1sxF51bzkDEwnktW/bePKM8bcbFB6RjcNyZTXhZe/pA0QdN1HyTtFzk5OLj5XEMsGkGSxJ0/g==
X-Received: by 2002:a17:906:dc8c:b0:722:f40e:e653 with SMTP id cs12-20020a170906dc8c00b00722f40ee653mr43889289ejc.83.1657179016805;
        Thu, 07 Jul 2022 00:30:16 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id ew6-20020a056402538600b0043a6dc3c4b0sm7484791edb.41.2022.07.07.00.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 00:30:16 -0700 (PDT)
From:   Md Haris Iqbal <haris.phnx@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        aleksei.marov@ionos.com, Md Haris Iqbal <haris.phnx@gmail.com>,
        rpearsonhpe@gmail.com
Subject: [PATCH] RDMA/rxe: For invalidate compare according to set keys in mr
Date:   Thu,  7 Jul 2022 09:30:06 +0200
Message-Id: <20220707073006.328737-1-haris.phnx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The 'rkey' input can be an lkey or rkey, and in rxe the lkey or rkey have
the same value, including the variant bits.

So, if mr->rkey is set, compare the invalidate key with it, otherwise
compare with the mr->lkey.

Since we already did a lookup on the non-varient bits to get this far,
the check's only purpose is to confirm that the wqe has the correct
variant bits.

Fixes: 001345339f4c ("RDMA/rxe: Separate HW and SW l/rkeys")
Cc: rpearsonhpe@gmail.com
Signed-off-by: Md Haris Iqbal <haris.phnx@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h |  2 +-
 drivers/infiniband/sw/rxe/rxe_mr.c  | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 0e022ae1b8a5..37484a559d20 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -77,7 +77,7 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type);
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
-int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
+int rxe_invalidate_mr(struct rxe_qp *qp, u32 key);
 int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr);
 int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index fc3942e04a1f..3add52129006 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -576,22 +576,22 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 	return mr;
 }
 
-int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
+int rxe_invalidate_mr(struct rxe_qp *qp, u32 key)
 {
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct rxe_mr *mr;
 	int ret;
 
-	mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
+	mr = rxe_pool_get_index(&rxe->mr_pool, key >> 8);
 	if (!mr) {
-		pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
+		pr_err("%s: No MR for key %#x\n", __func__, key);
 		ret = -EINVAL;
 		goto err;
 	}
 
-	if (rkey != mr->rkey) {
-		pr_err("%s: rkey (%#x) doesn't match mr->rkey (%#x)\n",
-			__func__, rkey, mr->rkey);
+	if (mr->rkey ? (key != mr->rkey) : (key != mr->lkey)) {
+		pr_err("%s: wr key (%#x) doesn't match mr key (%#x)\n",
+			__func__, key, (mr->rkey ? mr->rkey : mr->lkey));
 		ret = -EINVAL;
 		goto err_drop_ref;
 	}
-- 
2.25.1

