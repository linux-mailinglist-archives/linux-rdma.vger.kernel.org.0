Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3865A2532
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Aug 2022 11:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245413AbiHZJ4a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Aug 2022 05:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343619AbiHZJ4W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Aug 2022 05:56:22 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5A671701
        for <linux-rdma@vger.kernel.org>; Fri, 26 Aug 2022 02:56:20 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c93so1462896edf.5
        for <linux-rdma@vger.kernel.org>; Fri, 26 Aug 2022 02:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1OtudCFdOB5S7Toxd4SmAHP6iPCLN05Aag/oasSZDWA=;
        b=efRIhw++dqp6QLx+Q2w7pAGcxcUmskniao0oki8SgvSPc86uO3IxEmNXglFS27j2hT
         RjEQ67PugOZynFe2rpz3UzfqWJ0v2ZwHgr+0eikZqwn0GOwBYhYQCLhPEqnpk/nguZW8
         Nkm/+lfEmSW/2+O1vFtUk+ySCwL1lYhaMmmsQhy01RZv2EHUC5ca99S/MlH+vfqvzpxG
         GGRzGM7pL1YnQJfEXSDoua7tkRY32VMkU9HPN/kpTpkt6jgdXzmufev6Ju9bcd+I1UUF
         9bVKtRTcZi1cFiXdAZt3gDhO0hGEUxvCSuZsrGl32rZPw5QWQCEWnKNgP8u4sd+1PgBJ
         5l6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1OtudCFdOB5S7Toxd4SmAHP6iPCLN05Aag/oasSZDWA=;
        b=axmcH0DHtliyeQO3whvJo86peX7YoeD0rxcd8DFV4t42D6iZ5kgPtOfuB0iHArYoIk
         gSEHYGZypJwPTMG+l+jOzgV4kiLNdjyT8JK/HUvCbYH3n7Y0tO2o0RcFBoSPBwedsHv6
         iCJLxoKELY8z/2iwYAiDnLP4209h+y3OFsfiF/3LL04aF4pS4MTBDkbeNnxo4jlnRgtp
         b2rIJZ6XgpEZPL8eqlm/Y/1InuUgntMMZGPLR0nuj7Fwlp2d7eP1Fnk6ABe8DJYVVZQM
         D21MVnR0xKS+aLHtRGP70cFYZCpVtBQgqZWZqL9y0BIpYHnQbPVvyapWlklKh6fFZnpi
         SNpQ==
X-Gm-Message-State: ACgBeo0glh2d99fdO1Q4Rw11IXgQNdFQJdlmGQzUdOF27W2DspVXF0EY
        JE8ra0Ccr6xkz1Bo+9t0HP+Ekw==
X-Google-Smtp-Source: AA6agR7Yqqg3A4Dbj2cSfbf06U2Z2J4BviHFEZdFKdknQy2IT0JEZsM/AVORLCAC3t51Cb+lLoMWeA==
X-Received: by 2002:a05:6402:1943:b0:443:5ffb:b04e with SMTP id f3-20020a056402194300b004435ffbb04emr6139295edz.230.1661507779210;
        Fri, 26 Aug 2022 02:56:19 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:140d:2300:3a17:fa67:2b0b:b905])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906218100b007081282cbd8sm694826eju.76.2022.08.26.02.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 02:56:18 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] RDMA: dma-mapping: Return an unsigned int from ib_dma_map_sg{,_attrs}
Date:   Fri, 26 Aug 2022 11:56:15 +0200
Message-Id: <20220826095615.74328-3-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220826095615.74328-1-jinpu.wang@ionos.com>
References: <20220826095615.74328-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Following 2a047e0662ae ("dma-mapping: return an unsigned int from dma_map_sg{,_attrs}")
change the return value of ib_dma_map_sg{,attrs} to unsigned int.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/core/device.c | 2 +-
 include/rdma/ib_verbs.h          | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index d275db195f1a..72489294391d 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2721,7 +2721,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 EXPORT_SYMBOL(ib_set_device_ops);
 
 #ifdef CONFIG_INFINIBAND_VIRT_DMA
-int ib_dma_virt_map_sg(struct ib_device *dev, struct scatterlist *sg, int nents)
+unsigned int ib_dma_virt_map_sg(struct ib_device *dev, struct scatterlist *sg, int nents)
 {
 	struct scatterlist *s;
 	int i;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 975d6e9efbcb..49256bf8cbf5 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4101,8 +4101,8 @@ static inline void ib_dma_unmap_page(struct ib_device *dev,
 		dma_unmap_page(dev->dma_device, addr, size, direction);
 }
 
-int ib_dma_virt_map_sg(struct ib_device *dev, struct scatterlist *sg, int nents);
-static inline int ib_dma_map_sg_attrs(struct ib_device *dev,
+unsigned int ib_dma_virt_map_sg(struct ib_device *dev, struct scatterlist *sg, int nents);
+static inline unsigned int ib_dma_map_sg_attrs(struct ib_device *dev,
 				      struct scatterlist *sg, int nents,
 				      enum dma_data_direction direction,
 				      unsigned long dma_attrs)
@@ -4163,7 +4163,7 @@ static inline void ib_dma_unmap_sgtable_attrs(struct ib_device *dev,
  * @nents: The number of scatter/gather entries
  * @direction: The direction of the DMA
  */
-static inline int ib_dma_map_sg(struct ib_device *dev,
+static inline unsigned int ib_dma_map_sg(struct ib_device *dev,
 				struct scatterlist *sg, int nents,
 				enum dma_data_direction direction)
 {
-- 
2.34.1

