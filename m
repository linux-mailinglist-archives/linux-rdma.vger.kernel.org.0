Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2EC6100D3
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 20:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbiJ0S4X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 14:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236284AbiJ0S4U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 14:56:20 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E271D33C
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:20 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id r83so3396785oih.2
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7zgQgeSXLF/fNVhN5xzAHBWpV3bu2nbiNNH6HqTPc0=;
        b=OFSMwDOoSFJYKmC+eyxnXSmJI3lcnLePQtweYxFJ2ZVPmcoHs81rUPbQpkn+oFKmYq
         ivu6f9cDVgYoVbpCorxTTbOB415aUW7mS/Q6DDOHD9WtnYQT8Nm8jUXHsLSWua2kSGpN
         HwzH/aKxlrIAZ5FXGHwOO5gGVneY83krxrLO7EdYRxCpNDflZYzoGOG5T++PlDz6qbKx
         GEVBezNY6ZKPYzpFLGuWJcSpnduEoLFMeXG//P4UozlM37VLA3pQhyh+bv+mS+k611AZ
         QHcijNKo5bZiRidmwYbe5oNamwsudcgpBoB3A7h/AJgkj4Owr6eIsDsclTBzbJCRCUZU
         OLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7zgQgeSXLF/fNVhN5xzAHBWpV3bu2nbiNNH6HqTPc0=;
        b=NStG6xnb57rp0pUhsZS95YjWqeXQH2LyoCTbXR5j30sjOeLpbnrAeXYRR/zeYBWe7d
         PaDTOnWhhSiALpjRa2bF01OQ7X4NKjRzcS9Aeb+zYWme9U4mtaePMepsVbOvCRwla8dV
         Iwt+7+G0xX8Z5Thml2rCmojGpxjunFwIa0hW4KrhxBtI6qaymtD8P7o0EmZgRvOEoVU9
         lyywJpzb4zoJ491vCRbPJpV2wbwM0wCTxpbHOIyvkrc81GnTGSJ/AM+Bi2yA+mXkGsRT
         3UWNAQPbwH3OBcggGwKyreoiuNtRA6EIoFYR/QDbAynXQeI5B7aHf3j5Kjhcqwy6y3TI
         u3Ag==
X-Gm-Message-State: ACrzQf3DIMyGnJ5GOJ1/0V8PBRu9sJbNSAakrhoemHSOyzqN4+X6vI9K
        FhDUmuaPz6haR2Vk9gJUUE4=
X-Google-Smtp-Source: AMsMyM5FblE9ZV06iAys+dh0HlmpnK58UhJGT7q0Op88g+7TvrFTsYeZXSUlQBffilQSUE3dsJbtVg==
X-Received: by 2002:a05:6808:f91:b0:359:a22e:b047 with SMTP id o17-20020a0568080f9100b00359a22eb047mr5794526oiw.215.1666896979835;
        Thu, 27 Oct 2022 11:56:19 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f015-3653-e617-fa3f.res6.spectrum.com. [2603:8081:140c:1a00:f015:3653:e617:fa3f])
        by smtp.googlemail.com with ESMTPSA id f1-20020a4a8f41000000b0049602fb9b4csm732736ool.46.2022.10.27.11.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 11:56:19 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 08/17] RDMA/rxe: Add routine to compute number of frags for dma
Date:   Thu, 27 Oct 2022 13:55:02 -0500
Message-Id: <20221027185510.33808-9-rpearsonhpe@gmail.com>
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
index fd39b3e17f41..77437a0dd7ec 100644
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

