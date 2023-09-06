Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC48793B02
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Sep 2023 13:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjIFLYQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Sep 2023 07:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjIFLYQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Sep 2023 07:24:16 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A071986
        for <linux-rdma@vger.kernel.org>; Wed,  6 Sep 2023 04:23:57 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31de47996c8so3127025f8f.2
        for <linux-rdma@vger.kernel.org>; Wed, 06 Sep 2023 04:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693999436; x=1694604236; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YnD5AsR+rQGEikt0Jm0WB+aaQ90cGSQSw3FwinvIwiE=;
        b=u8DWgxBGaSmNxN+4J36lAeI7U92xFah2GXT1U8iHCl3pvgLrtmeqHekw72KomrVm+u
         9yMw21S+p5O4APpde1dHu79ox7r93G7mI5cLA3MUP9cejn+7qb2LhKx3IzE43By3584x
         oUnzVfm50hR+EZl3FhEWPk4yn78Kc6OmCA3C/decnN+T7ZjspRnmFAxmKSRprOmU1nUm
         prUhwWIgOWfzgGqJfC+PMMc7J1LRo7lQM3mzUuo1TlvW0VNM+eZNqB8gf7YERuqh35du
         1L3wbvCkTwGPwfYiW45Fd3TBEumCKbefTAxsk5ejIzYdFcsdydjaoHo4D+PhwQUoSZNW
         HFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693999436; x=1694604236;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YnD5AsR+rQGEikt0Jm0WB+aaQ90cGSQSw3FwinvIwiE=;
        b=JF08vbC0Gq5kaPem1wP0e6PIfVwo1IcQq4ajYfzr7z+45AcQ81L67DwUxL87ZuO450
         jrZOfiMaqWSuV1wKa6DLtg5QCjV5VP+Xd0bJUshk/8rEcWoKnumpxzKBF1tjbqkcUFD0
         RPFxANNfADcCvcRDMH2ki/5tvijybbvXrb2wQN74TSH+b95IsW9am8FS/ouRqyQck0XU
         f0ufGg4B7w529AIsIjZHWCfYYuNOGXJlDjVzWfiT6UDH6s4xDYCNUvBLLHEYntKqkK9u
         /bXyl1P+Q1StSeH2RmhpzOneuVVM0kgd99G8fNORHuYr78DNeLnF6AhXFaBaFLRnqIym
         O61w==
X-Gm-Message-State: AOJu0YyFZPgdSOToZixfRfPqJValPrAdWRVw5hkVY8jDcvr0Bjr+cZEm
        tRCfR4TCdSfcBoMAYWiaU0IVHuDNjt94hDgO2lM=
X-Google-Smtp-Source: AGHT+IGfYP3zQPLwT2yb30uf2wbJUO0eXJJuYp2woUe5QwMhi7INC4jOkYKyCpdhntKmPZhIYrk5yQ==
X-Received: by 2002:adf:f4d0:0:b0:317:58e4:e941 with SMTP id h16-20020adff4d0000000b0031758e4e941mr1878533wrp.33.1693999436178;
        Wed, 06 Sep 2023 04:23:56 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h8-20020a056000000800b0030647449730sm20357768wrx.74.2023.09.06.04.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 04:23:55 -0700 (PDT)
Date:   Wed, 6 Sep 2023 14:23:52 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     Kai Shen <kaishen@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/erdma: Fix error code in erdma_create_scatter_mtt()
Message-ID: <1eb400d5-d8a3-4a8e-b3da-c43c6c377f86@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The erdma_create_scatter_mtt() function is supposed to return error
pointers.  Returning NULL will lead to an Oops.

Fixes: ed10435d3583 ("RDMA/erdma: Implement hierarchical MTT")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index dcccb6015232..70eaed59a67c 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -655,7 +655,7 @@ static struct erdma_mtt *erdma_create_scatter_mtt(struct erdma_dev *dev,
 
 	mtt = kzalloc(sizeof(*mtt), GFP_KERNEL);
 	if (!mtt)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	mtt->size = ALIGN(size, PAGE_SIZE);
 	mtt->buf = vzalloc(mtt->size);
-- 
2.39.2

