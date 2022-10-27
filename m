Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B396100D0
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 20:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbiJ0S4V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 14:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236245AbiJ0S4T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 14:56:19 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AD21D33C
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:18 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id r83so3396628oih.2
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7arYcdylk3ELIDmzLKj5jx5A064a8DPStUt34r9GnZk=;
        b=GJNSwA69kawmg5RRiFva69v6JwP/06m343/Jy9GF2W75k6vqUDFuyM/uyPFvotJhiw
         4jCZyZ5U2gt6UPIvdxk0P/C2D4640lNDsBxzxs5NYNTdANWK2Qt40jyFGmEBkexPdagE
         Iw5HDSJP09upW786yEujDXD8T9VUoWlLTMTdYfmbRj89oZBAdx8fpO40FEWhUug/ik7K
         PqkLx5/J2+K4QoVMUehbfhYMMHZrtoU8XaXRRTPueXZTakvM07BbXsHXysQhVcDfXQMt
         auYPW8AAcKibwDgVc9lp8CRLdYKa7FHM8JD1axjdBGUQZ60Z64JEUh7vBqrfH2V6fyDg
         BPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7arYcdylk3ELIDmzLKj5jx5A064a8DPStUt34r9GnZk=;
        b=IlzMgpkGqP5BhgyYbmoLZqukQZTMSYGpY8HrxWjLh93tXzAEd9D0nDVogLBVQUCUdD
         k+gA9E18O8U/5Lyj+EbYxwUUmJXpDWKW3UtvIbj1jEgGiDg/a5oxmh/WEm615XVY68fo
         rOa45GA4f8A15XkKjNY3nQja8WqJL2JLmKljWQX1DEzsEthbIxprFsxBthKA6ypWg3CU
         AEA1D/KDfaW3O+0Zpa40De2Ku9lgUoIYevJVQEDMbtld+elOBl+20oY0CwEEwfGHwixF
         gfhwIiDFXoynfNo7ilZ1/bCbxLvfQCltLxjitR4nDwKEaB5z9KFSvo+3pXA+A/BWqMv+
         eY4Q==
X-Gm-Message-State: ACrzQf34B1MdvfNaHcruYVgQNhdxFb8UwP65DSL34VnhBhEflxg3H9XS
        Km8ZI5QlwliHw5/cqq+62rk=
X-Google-Smtp-Source: AMsMyM6o7RP03k3y7kiz/57RgH7FC7NE/jcIFZkaNC+Hiov8QZnwNZ7Mldn77GtAL5AAtYbcb2l1mw==
X-Received: by 2002:a05:6808:128b:b0:354:c73a:7241 with SMTP id a11-20020a056808128b00b00354c73a7241mr5667063oiw.34.1666896977596;
        Thu, 27 Oct 2022 11:56:17 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f015-3653-e617-fa3f.res6.spectrum.com. [2603:8081:140c:1a00:f015:3653:e617:fa3f])
        by smtp.googlemail.com with ESMTPSA id f1-20020a4a8f41000000b0049602fb9b4csm732736ool.46.2022.10.27.11.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 11:56:16 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 06/17] RDMA/rxe: Add routine to compute the number of frags
Date:   Thu, 27 Oct 2022 13:55:00 -0500
Message-Id: <20221027185510.33808-7-rpearsonhpe@gmail.com>
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

Add a subroutine named rxe_num_mr_frags() to compute the
number of skb frags needed to hold length bytes in an skb
when sending data from an mr starting at iova.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h |  1 +
 drivers/infiniband/sw/rxe/rxe_mr.c  | 68 +++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 81a611778d44..87fb052c1d0a 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -70,6 +70,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr);
 int rxe_add_frag(struct sk_buff *skb, struct rxe_phys_buf *buf,
 		 int length, int offset);
+int rxe_num_mr_frags(struct rxe_mr *mr, u64 iova, int length);
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		enum rxe_mr_copy_op op);
 int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index cf39412cac54..dd4dbe117c91 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -320,6 +320,74 @@ int rxe_add_frag(struct sk_buff *skb, struct rxe_phys_buf *buf,
 	return 0;
 }
 
+/**
+ * rxe_num_mr_frags() - Compute the number of skb frags needed to copy
+ *			length bytes from an mr to an skb frag list.
+ * @mr: mr to copy data from
+ * @iova: iova in memory region as starting point
+ * @length: number of bytes to transfer
+ *
+ * Returns: the number of frags needed or a negative error
+ */
+int rxe_num_mr_frags(struct rxe_mr *mr, u64 iova, int length)
+{
+	struct rxe_phys_buf *buf;
+	struct rxe_map **map;
+	size_t buf_offset;
+	int bytes;
+	int m;
+	int i;
+	int num_frags = 0;
+	int err;
+
+	if (length == 0)
+		return 0;
+
+	if (mr->type == IB_MR_TYPE_DMA) {
+		while (length > 0) {
+			buf_offset = iova & ~PAGE_MASK;
+			bytes = PAGE_SIZE - buf_offset;
+			if (bytes > length)
+				bytes = length;
+			length -= bytes;
+			num_frags++;
+		}
+
+		return num_frags;
+	}
+
+	WARN_ON_ONCE(!mr->map);
+
+	err = mr_check_range(mr, iova, length);
+	if (err)
+		return err;
+
+	lookup_iova(mr, iova, &m, &i, &buf_offset);
+
+	map = mr->map + m;
+	buf = map[0]->buf + i;
+
+	while (length > 0) {
+		bytes = buf->size - buf_offset;
+		if (bytes > length)
+			bytes = length;
+		length -= bytes;
+		buf_offset = 0;
+		buf++;
+		i++;
+		num_frags++;
+
+		/* we won't overrun since we checked range above */
+		if (i == RXE_BUF_PER_MAP) {
+			i = 0;
+			map++;
+			buf = map[0]->buf;
+		}
+	}
+
+	return num_frags;
+}
+
 /* copy data from a range (vaddr, vaddr+length-1) to or from
  * a mr object starting at iova.
  */
-- 
2.34.1

