Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0D16100D1
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 20:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbiJ0S4W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 14:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbiJ0S4T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 14:56:19 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9300036DF8
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:17 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id g10so3366362oif.10
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTJppGzc1eVithpbvGTjYFt0v38pZhvidz2L6iFmF4E=;
        b=ldCR6QpyP0ubyiIjLB4T3D+QZ2Z0H+u+7+a/KWmG+zWQ43N2G5cobdd8/HuTYHpDtR
         IR2Uu0kKUmA+GpNnXgEygLdVq+uQQFVHF9rrEan3mFzaEwT6/cW+XR/UXArBjG+RGGFE
         wCqVSMT/dgpnsPeu7cV4MF1IrtzxWE8yJ8GhWIKtqPaKtrZDEkj1oa4p8f1E45GSPUpI
         3/GeNG8lbvUVPWYWyKJYjQwKgqbsaViEMLTju0G1rnReTeFjIpUT0DuExsxR4wW0m84L
         1bL5PUyNjiUSTaxe9nwLzI8KmrnzHOnGgcqLprrb6Z0eDdOcoGAasjCuPeTQsQbm9pQB
         i7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTJppGzc1eVithpbvGTjYFt0v38pZhvidz2L6iFmF4E=;
        b=lUPaPBAJg5U//GPu6HOTaKzL3XxDpZnXD1ERVbrQPNONPQDA6riRJTG2IkoGHcVCIc
         +awMyv1mOOFkqKIz/seffhAAWOEdqvpkqWMnto+1NsWBDGSP5HNr6hr2bpenNIs9E0aN
         Cp8bupOds+1cGHo8+O5+1Ynghu3i7mp2Ml7v/bJP2h3WYiX+HXLnukNEhI4QgQ6YO0a5
         f+QdHWYBYGHuKnBz7Z0SCXpa+oc//5G9KC28iZZYCRJCvGUK2uabu66uvOwhPylypasV
         AbyYdBCnl44Lh9UTtzmJ/Yscva1iihg29uaiObx6v6BES7zFfA87K96aPtkZWVFQweCX
         gnuw==
X-Gm-Message-State: ACrzQf0SW/BOLkG7cvIuzBaaofhLzKtJeE0k9vUVp+3iJroHaKaRQaBJ
        XbKGewhp9gL8Q/RbFqgFRUE=
X-Google-Smtp-Source: AMsMyM79cIcwejtlF+sHmqkYdilpwesLEMS4Oqr7bDYjG3dW6iF5jDPkKHSsF+aspiglijIiCU1RJw==
X-Received: by 2002:a05:6808:989:b0:354:fcc8:2b4d with SMTP id a9-20020a056808098900b00354fcc82b4dmr5558953oic.157.1666896976425;
        Thu, 27 Oct 2022 11:56:16 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f015-3653-e617-fa3f.res6.spectrum.com. [2603:8081:140c:1a00:f015:3653:e617:fa3f])
        by smtp.googlemail.com with ESMTPSA id f1-20020a4a8f41000000b0049602fb9b4csm732736ool.46.2022.10.27.11.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 11:56:16 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 05/17] RDMA/rxe: Add rxe_add_frag() to rxe_mr.c
Date:   Thu, 27 Oct 2022 13:54:59 -0500
Message-Id: <20221027185510.33808-6-rpearsonhpe@gmail.com>
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
index 1cb997caa292..cf39412cac54 100644
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

