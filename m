Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73324613EFC
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Oct 2022 21:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiJaU2j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Oct 2022 16:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiJaU2i (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Oct 2022 16:28:38 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0590713D0F
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:37 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-13b6c1c89bdso14683140fac.13
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUUrwK5X8XzRkku41V3eAXwI8CumESsTLSiUb8Gn8ys=;
        b=BSydw51cAHtDyWG2J/Rez+VrzUbUEH0BIFXEtw4CBkXh58pOf4BVDyBS6OALE8tEuv
         PnP+C2NboWSCT5mF5DLGs+Y1iW4JLKOLT0RY6eFtGhpft5WbTEYkq1e4Cr3itN5utKbU
         akN+OUC52vz31Xj5GjlfpvlpmfzfZMXDmA782zKG4Raqj2JaFV/edkxvoZ4l2gA8yO9U
         Dwl2dGWTZw1AkdDyvmi/w1UIK4UXfCNyxsbRyHyMWRmQbTLoBX9rxbswNwbaFiNNeywj
         ixfLMLTvcJwiz3Kshin8PpHRH05wJXsFEKE4DoGoi0sWWYfbZSvI7IXraxSowra83j+k
         Q1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUUrwK5X8XzRkku41V3eAXwI8CumESsTLSiUb8Gn8ys=;
        b=QywkPCkM0r6tjXwjIG/0741OGWNEnjNU/E4oox4/dUjuTyWvqcC5Zl9FGGx4gI3YiK
         5jvbNQjRi0wTWXV7ocPeajhQnGYg//5L5Px6V8pjMJ+zON30c54sRtTSWO5wewo6uaas
         Hyys0t9C+ggFN7ETZJsJ6qNYEG98/uNQqa6PASqKayQdERNINRtvFFdPYzlOnsygF2qM
         oPvGp/nuikZjVmW9J8elMo84r455dWMkEi6Fxtyr4hlWQUvQj2WNp3izY5eUKuQm2Q+/
         yHE+aSQcztpq6XPnfum426kEU+G3E+NVmsm8iNhc1lFERsbhC9jtFGBchbyMYu8cgXQ8
         U2Qg==
X-Gm-Message-State: ACrzQf08aXGjUQ5YwDBOrnmQQJFLRDHQ9JwAUqTdwcCcO8hICTInc82t
        hSc2LVEl1Qx6v1l3xJ20ZMA=
X-Google-Smtp-Source: AMsMyM4tum+trVFdIAUdBoRAHOw43MVjZN4ETufnnDp7rAyit3eFaPTmOVSkjEVuSfSag3HwwL8eWg==
X-Received: by 2002:a05:6870:6189:b0:13b:9640:6ed7 with SMTP id a9-20020a056870618900b0013b96406ed7mr18238604oah.216.1667248116754;
        Mon, 31 Oct 2022 13:28:36 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-ce7d-a808-badd-629d.res6.spectrum.com. [2603:8081:140c:1a00:ce7d:a808:badd:629d])
        by smtp.googlemail.com with ESMTPSA id w1-20020a056808018100b00342e8bd2299sm2721215oic.6.2022.10.31.13.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:28:35 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 07/18] RDMA/rxe: Add routine to compute the number of frags
Date:   Mon, 31 Oct 2022 15:27:56 -0500
Message-Id: <20221031202805.19138-7-rpearsonhpe@gmail.com>
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
index 2dcf37f32330..23abcf2a0198 100644
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

