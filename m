Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358B6613EFB
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Oct 2022 21:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJaU2h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Oct 2022 16:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiJaU2g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Oct 2022 16:28:36 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAB75F8B
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:35 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-13b6c1c89bdso14683056fac.13
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zkz4bwOdtuQaDxsUm4Et7kpA3fRhuxZ16vjanIUl/bk=;
        b=a5tyqbj8bH615XX2JUFNkHiMLqs1pab5N/DsBxI9yFNguOtzFYJPaa2oCv5cEbCXIe
         CcVhkQakNk7t3Bc9I/e/6XfzCBvSrVmMXnXpOXE//hBXIYlmBifcy3SpslDp1KmcptMC
         NCNktFYjqXlcZieAt6rmHxBDEvJopr8gP2m0GIHcJSBQsPGimqzIIlCp7G/slEg4GZ6P
         kfRLs/fgYw1j38zq3UggvEmO4GBJ67zr4q+57YxuLLYRaM/LcXtMyn87eQ5kfn0fhOlS
         EhT9XNq3DKHGzeKbbVFFW7onKJ9Znu5Otc7qk1QNqKgDK7zEfcbFnvJKTMpnZ6rnUo0I
         19UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zkz4bwOdtuQaDxsUm4Et7kpA3fRhuxZ16vjanIUl/bk=;
        b=xr9vpMaL8ILUY2gCJLH0soBHB/yO9AJeGHxLPxHX2oMn3yT3m8PXZm5MTH4XxqPFLq
         b3+s5UtzeJL+ZgFF5AG4aOZSXarQUAivpFLIkiH9N0CHxCKzZFKNRpdB7Ds2pH2lhhiG
         C3iWBDkTU44luRdKUSmP9AAvXEVuTT3hGd4YVJkVBd3VKx9XntRHfaem717cyrBEUZCy
         OxP5gkg/bRegu244/jJUsIjRGJOaREdAaQP3OZYd8WJ9WEj/VaLUjWgQH/lBdqOhbGtH
         ehlxq8nQS40Yxl5N/ydUDzNnntAfj9+qiay8D7HA6R0GxzryCFM/wkWAs8o/GC+Dkj7z
         1KBw==
X-Gm-Message-State: ACrzQf3z+NRZZjCDYO3L5ExhGrj9kSX4QcAFTEU0h2+0SEy1L/e183Y1
        XnAlSCAzl0M8poLL+jaYcyM=
X-Google-Smtp-Source: AMsMyM44e+fhoTt729hB15y9KuWKWo07Soawkv0IB4rDtJp8kSRSiR3Ty5KgpW9SqxKHiAoBPIz72Q==
X-Received: by 2002:a05:6870:6088:b0:12c:19b0:f878 with SMTP id t8-20020a056870608800b0012c19b0f878mr8652639oae.70.1667248114977;
        Mon, 31 Oct 2022 13:28:34 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-ce7d-a808-badd-629d.res6.spectrum.com. [2603:8081:140c:1a00:ce7d:a808:badd:629d])
        by smtp.googlemail.com with ESMTPSA id w1-20020a056808018100b00342e8bd2299sm2721215oic.6.2022.10.31.13.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:28:34 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 06/18] RDMA/rxe: Add rxe_add_frag() to rxe_mr.c
Date:   Mon, 31 Oct 2022 15:27:55 -0500
Message-Id: <20221031202805.19138-6-rpearsonhpe@gmail.com>
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

Add the subroutine rxe_add_frag() to add a fragment to an skb.

This is in preparation for supporting fragmented skbs.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h |  2 ++
 drivers/infiniband/sw/rxe/rxe_mr.c  | 34 +++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index ff803a957ac1..81a611778d44 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -68,6 +68,8 @@ void rxe_mr_init_dma(int access, struct rxe_mr *mr);
 int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr);
 int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr);
+int rxe_add_frag(struct sk_buff *skb, struct rxe_phys_buf *buf,
+		 int length, int offset);
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		enum rxe_mr_copy_op op);
 int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 60a8034f1416..2dcf37f32330 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -286,6 +286,40 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 	return addr;
 }
 
+/**
+ * rxe_add_frag() - Add a frag to a nonlinear packet
+ * @skb: The packet buffer
+ * @buf: Kernel buffer info
+ * @length: Length of fragment
+ * @offset: Offset of fragment in buf
+ *
+ * Returns: 0 on success else a negative errno
+ */
+int rxe_add_frag(struct sk_buff *skb, struct rxe_phys_buf *buf,
+		 int length, int offset)
+{
+	int nr_frags = skb_shinfo(skb)->nr_frags;
+	skb_frag_t *frag = &skb_shinfo(skb)->frags[nr_frags];
+
+	if (nr_frags >= MAX_SKB_FRAGS) {
+		pr_debug("%s: nr_frags (%d) >= MAX_SKB_FRAGS\n",
+			__func__, nr_frags);
+		return -EINVAL;
+	}
+
+	frag->bv_len = length;
+	frag->bv_offset = offset;
+	frag->bv_page = virt_to_page(buf->addr);
+	/* because kfree_skb will call put_page() */
+	get_page(frag->bv_page);
+	skb_shinfo(skb)->nr_frags++;
+
+	skb->data_len += length;
+	skb->len += length;
+
+	return 0;
+}
+
 /* copy data from a range (vaddr, vaddr+length-1) to or from
  * a mr object starting at iova.
  */
-- 
2.34.1

