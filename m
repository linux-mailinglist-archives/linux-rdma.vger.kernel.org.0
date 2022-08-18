Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB065981B8
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Aug 2022 12:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243923AbiHRKyD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Aug 2022 06:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238963AbiHRKyC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Aug 2022 06:54:02 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F627E018
        for <linux-rdma@vger.kernel.org>; Thu, 18 Aug 2022 03:54:01 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h5so477401wru.7
        for <linux-rdma@vger.kernel.org>; Thu, 18 Aug 2022 03:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=fr2v3RSLAAFVGU4ZnToOw6WKbJPi95JAWN3CM4OQ5QI=;
        b=aQ+0Bpy+94hyWqnCtnOlpzOel5V3/dpBPB2Gvcko/DEm980eT8/5WdJS11khPU5eW2
         6lYzb5+DDiYh02WpTpjVXD5GqdgAXT+sBCrR5fjkDHVcaaAWl3e2Rz13fKubG94gyVhZ
         Kw1BaGFHVWjKpii7r1xpY20xPfk8o/Q+RnZovS2KjwQTGwIVaokRFEisXFHQHCoCcCcz
         Gd6KTVKUFHgg14yw0IscfhxOKEvFnjTQBq2DpmYXm9p3cjF2fm3kkOuzZNZZ2mfN3wLT
         d5RMPDddrlSrBNgrKxiDcbaIs8RKmQLfGE8M9dkp1m1aas1QVsmd1E5Y17eWmt1ess55
         R6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=fr2v3RSLAAFVGU4ZnToOw6WKbJPi95JAWN3CM4OQ5QI=;
        b=pwuyC1ynDIwWZv96keE8l8RNcXkDkG2JKPmZhYwTHvtnOqeHd42H4cLHSwcwztgAx2
         3h/4vu0YH1/5p8x/gbvoVavZnf7+YlidbGVDitmt1ZoPOZqQKByKHrrw5sjylf2PZ2yS
         sywuH5E7R21+hrf6HpSalNDKWm5bZd+yhByBQ7NosoTWGmO/YOklso+DY6IJVRKTRLLG
         NL1VSjdl4Q9LI4w7XG7TEDVi/yPJ/I8CdeCa9eRsqgMmHwkZ7ArcXOcLqIVfhKj0UPSs
         olKIesmI+5hFxbUnjhfpQGf0TQ6iZ8lH42rJBP92CuJcVJQlwkTJ1iCCSnkn8c6OnDjd
         m1Lw==
X-Gm-Message-State: ACgBeo2z9lVFFMsI/YD627afUgdcI4Ud8ALxl03NY2Ks7bPvOqueNsz/
        UPglMB/kVjK1puY+CVkjmV9lvvXigsRjzw==
X-Google-Smtp-Source: AA6agR57/DSOHqKM96I6sNPTWGqVzHQaaKit6qoSuY7m/a/QWsGS1LOGYPLyBT7reffje1eU1NMgjg==
X-Received: by 2002:a5d:640f:0:b0:220:e5a7:f5e7 with SMTP id z15-20020a5d640f000000b00220e5a7f5e7mr1276122wru.314.1660820040214;
        Thu, 18 Aug 2022 03:54:00 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id n3-20020a05600c3b8300b003a54fffa809sm1920751wms.17.2022.08.18.03.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 03:53:59 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, Aleksei Marov <aleksei.marov@ionos.com>
Subject: [PATCH for-next 3/3] RDMA/rtrs-srv: Pass the correct number of entries for dma mapped SGL
Date:   Thu, 18 Aug 2022 12:53:55 +0200
Message-Id: <20220818105355.110344-4-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220818105355.110344-1-haris.iqbal@ionos.com>
References: <20220818105355.110344-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@ionos.com>

ib_dma_map_sg() augments the SGL into a 'dma mapped SGL'. This process
may change the number of entries and the lengths of each entry.

Code that touches dma_address is iterating over the 'dma mapped SGL'
and must use dma_nents which returned from ib_dma_map_sg().

We should use the return count from ib_dma_map_sg for futher usage.

Fixes: 9cb837480424e ("RDMA/rtrs: server: main functionality")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 22e6f991946c..aa259b4c6f89 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -593,7 +593,7 @@ static int map_cont_bufs(struct rtrs_srv_path *srv_path)
 		struct sg_table *sgt = &srv_mr->sgt;
 		struct scatterlist *s;
 		struct ib_mr *mr;
-		int nr, chunks;
+		int nr, nr_sgt, chunks;
 
 		chunks = chunks_per_mr * mri;
 		if (!always_invalidate)
@@ -608,19 +608,19 @@ static int map_cont_bufs(struct rtrs_srv_path *srv_path)
 			sg_set_page(s, srv->chunks[chunks + i],
 				    max_chunk_size, 0);
 
-		nr = ib_dma_map_sg(srv_path->s.dev->ib_dev, sgt->sgl,
+		nr_sgt = ib_dma_map_sg(srv_path->s.dev->ib_dev, sgt->sgl,
 				   sgt->nents, DMA_BIDIRECTIONAL);
-		if (nr < sgt->nents) {
-			err = nr < 0 ? nr : -EINVAL;
+		if (!nr_sgt) {
+			err = -EINVAL;
 			goto free_sg;
 		}
 		mr = ib_alloc_mr(srv_path->s.dev->ib_pd, IB_MR_TYPE_MEM_REG,
-				 sgt->nents);
+				 nr_sgt);
 		if (IS_ERR(mr)) {
 			err = PTR_ERR(mr);
 			goto unmap_sg;
 		}
-		nr = ib_map_mr_sg(mr, sgt->sgl, sgt->nents,
+		nr = ib_map_mr_sg(mr, sgt->sgl, nr_sgt,
 				  NULL, max_chunk_size);
 		if (nr < 0 || nr < sgt->nents) {
 			err = nr < 0 ? nr : -EINVAL;
@@ -639,7 +639,7 @@ static int map_cont_bufs(struct rtrs_srv_path *srv_path)
 			}
 		}
 		/* Eventually dma addr for each chunk can be cached */
-		for_each_sg(sgt->sgl, s, sgt->orig_nents, i)
+		for_each_sg(sgt->sgl, s, nr_sgt, i)
 			srv_path->dma_addr[chunks + i] = sg_dma_address(s);
 
 		ib_update_fast_reg_key(mr, ib_inc_rkey(mr->rkey));
-- 
2.25.1

