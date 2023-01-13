Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083A566A70C
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Jan 2023 00:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjAMX1g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Jan 2023 18:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjAMX1f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Jan 2023 18:27:35 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CE87A397
        for <linux-rdma@vger.kernel.org>; Fri, 13 Jan 2023 15:27:34 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id k7-20020a056830168700b0067832816190so13058449otr.1
        for <linux-rdma@vger.kernel.org>; Fri, 13 Jan 2023 15:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSc+ZeVhmJVAyrOad5GEnPdKs11Mmr6EK22kGWHehxY=;
        b=My4hdjo2+P/Wli7csPfuJiS1HFcm6l7xxDyBN3G+4WztuyB1tugCDA65WW+np1Vohn
         IdXePYKYy5umoDFl7isEPca3krQ1i3SlJN4OM4lDwcS+VePodwsxUOgmvv0Q0Hlie1Xv
         y3vFTnmp45sp+th1Ul2P6IqheVPWbHTRh8PeN3rvEJxhE0V0z57Rh0hjQ1hW4siPowFS
         tp4OCTUJ4VoDU9x5QgEmAGzZjjrTtWIizyD7bzJnN/0BBZwGFQv5vy8s5Aaq2UWfGljC
         ZIyrpcmjmVSPjuGdZi+KSHNtIsTHllOYAm7wzIa7YDCn+DJ04hBSGZMOY/QsMfhESk7B
         e4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSc+ZeVhmJVAyrOad5GEnPdKs11Mmr6EK22kGWHehxY=;
        b=uFUkoBasmmuloXEZA8bmZ2/+VUwiTzy/KssHNjkDbV1vZV2cSRdHi8UMDVu4OjCEkV
         BBtUKM8x4VQkfuO8F4BBqwE2h0azYWAoEvsN+ijz44oZeG2hDk9ukidC/two+nplZpHD
         j5E9SEkFV8e9RFREKecYHNbJglDyuw+HUxtDhQIr1Sv0L0cMuzma8eW1lv2VFTKOnXVA
         WhvjepqQ/EHBA0oCOP1hViabZfmx6SZEewhfg5OOEjVcOQiGE4UA6aN4ER+092+kCAMC
         Pjhh56SoSfxk2zw9sZidDF/WNimhJe2aN0rABbafTIqE+Mj7UGAz07z0Myzo+NjQJI00
         FFUw==
X-Gm-Message-State: AFqh2kr6cN9sOqPxgJ3Zv34Qc2aoPdXF44puDhS1itcVbZcsnuMiV0DX
        9zz33d10g0zCTB0c24naycv3PrDTWXGq/A==
X-Google-Smtp-Source: AMrXdXsYXhVRQTKqoqk0b6EnoTkQNMjty13jnPNuGEWfEe8rGLK6IZYPC1WQ6XzsidRnFMJJG8KPug==
X-Received: by 2002:a9d:7748:0:b0:684:dc47:77f8 with SMTP id t8-20020a9d7748000000b00684dc4777f8mr371722otl.5.1673652453693;
        Fri, 13 Jan 2023 15:27:33 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-3f47-8433-ec70-f475.res6.spectrum.com. [2603:8081:140c:1a00:3f47:8433:ec70:f475])
        by smtp.gmail.com with ESMTPSA id q13-20020a9d57cd000000b0066871c3adb3sm11297433oti.28.2023.01.13.15.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 15:27:33 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leonro@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 2/6] RDMA/rxe: Move rxe_map_mr_sg to rxe_mr.c
Date:   Fri, 13 Jan 2023 17:27:01 -0600
Message-Id: <20230113232704.20072-3-rpearsonhpe@gmail.com>
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

Move rxe_map_mr_sg() to rxe_mr.c where it makes a little more sense.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  2 ++
 drivers/infiniband/sw/rxe/rxe_mr.c    | 36 +++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.c | 36 ---------------------------
 3 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 948ce4902b10..29b6c2143045 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -69,6 +69,8 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		enum rxe_mr_copy_dir dir);
 int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
 	      void *addr, int length, enum rxe_mr_copy_dir dir);
+int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
+		  int sg_nents, unsigned int *sg_offset);
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 632ee1e516a1..229c7259644c 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -223,6 +223,42 @@ int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
 	return err;
 }
 
+static int rxe_set_page(struct ib_mr *ibmr, u64 addr)
+{
+	struct rxe_mr *mr = to_rmr(ibmr);
+	struct rxe_map *map;
+	struct rxe_phys_buf *buf;
+
+	if (unlikely(mr->nbuf == mr->num_buf))
+		return -ENOMEM;
+
+	map = mr->map[mr->nbuf / RXE_BUF_PER_MAP];
+	buf = &map->buf[mr->nbuf % RXE_BUF_PER_MAP];
+
+	buf->addr = addr;
+	buf->size = ibmr->page_size;
+	mr->nbuf++;
+
+	return 0;
+}
+
+int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
+		  int sg_nents, unsigned int *sg_offset)
+{
+	struct rxe_mr *mr = to_rmr(ibmr);
+	int n;
+
+	mr->nbuf = 0;
+
+	n = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, rxe_set_page);
+
+	mr->page_shift = ilog2(ibmr->page_size);
+	mr->page_mask = ibmr->page_size - 1;
+	mr->offset = ibmr->iova & mr->page_mask;
+
+	return n;
+}
+
 static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
 			size_t *offset_out)
 {
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 025b35bf014e..7a902e0a0607 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -948,42 +948,6 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	return ERR_PTR(err);
 }
 
-static int rxe_set_page(struct ib_mr *ibmr, u64 addr)
-{
-	struct rxe_mr *mr = to_rmr(ibmr);
-	struct rxe_map *map;
-	struct rxe_phys_buf *buf;
-
-	if (unlikely(mr->nbuf == mr->num_buf))
-		return -ENOMEM;
-
-	map = mr->map[mr->nbuf / RXE_BUF_PER_MAP];
-	buf = &map->buf[mr->nbuf % RXE_BUF_PER_MAP];
-
-	buf->addr = addr;
-	buf->size = ibmr->page_size;
-	mr->nbuf++;
-
-	return 0;
-}
-
-static int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
-			 int sg_nents, unsigned int *sg_offset)
-{
-	struct rxe_mr *mr = to_rmr(ibmr);
-	int n;
-
-	mr->nbuf = 0;
-
-	n = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, rxe_set_page);
-
-	mr->page_shift = ilog2(ibmr->page_size);
-	mr->page_mask = ibmr->page_size - 1;
-	mr->offset = ibmr->iova & mr->page_mask;
-
-	return n;
-}
-
 static ssize_t parent_show(struct device *device,
 			   struct device_attribute *attr, char *buf)
 {
-- 
2.37.2

