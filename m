Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF35D793B35
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Sep 2023 13:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239817AbjIFL2o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Sep 2023 07:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239800AbjIFL2g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Sep 2023 07:28:36 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542C019B2
        for <linux-rdma@vger.kernel.org>; Wed,  6 Sep 2023 04:28:16 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401b393df02so35273625e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 06 Sep 2023 04:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693999683; x=1694604483; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6xD2y6ASS/vFv5J+YNGGSowN6CS8sw9pXvlfwxwaUgY=;
        b=iVdiT969Gs3okdRazuyIH3hhbaMKLFMucxaUVqL7Um65kmoS8jHA1gjytfVN/xNS5I
         YKs0M+iPZb+NFGgc4X1uwBlhgN6KnLBzb+MNFzQR6RptrLaiiHrSpIpPdPpBbu3EOm6Y
         5OGhl/gee+oj52pcKahbWI7N9frt1VBG9uJinQib7e2UM8MkjYzjSRrp6z6qHmwdiHBE
         fF+iA7YAHldL/Lo0iTC6xzVmvefz/TDouO2DtyeWwYPNqoA14dTqoE+5gwp7cZ9zUMdB
         CCK2QVy+2zf3ugqpKEeeEIM/eyZj6Zj+OcYq3fIXwhLksHu98yHVHWaCQxFN4rJUq05W
         7PSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693999683; x=1694604483;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xD2y6ASS/vFv5J+YNGGSowN6CS8sw9pXvlfwxwaUgY=;
        b=DhQlwfl7MPBRq0SDU+wkja8hJlX0C3b1meMFJhG+ciJSe2HDOitLQcGM7+k84Ik1E9
         ty70bgCM5an5tJ+XAGbTqF2GYuAkL4YP+HAgIvOry1iXgo3zG6l9L+I7eSsgWGYJKKQ8
         pnQrtg5kcOYNalAP3ysBftPzwQvPfhK9yNw8dSig2LdnouYj+uLMhnVBPMTCYsBwNFU+
         cdxUhupZCfdRL2R+1gCasmY4Ra/GH7HE/VDLNoR0zMehzMdy9K9e5tfepYZ2zYPag1ml
         okpkf6gOYVHtZjbouiaZ6itKgX0cq+3qLiiWOlvPt80tK3p0G9zRMzHF/NhmasGqodVb
         ZKyA==
X-Gm-Message-State: AOJu0YxDcHC7ZvFGDdh2vON7a4Zm7k+pTQmW8fohDY6ZpuSEzN8u/MK+
        zeqlNwDvgZxoL7A+Zt+z0pHeNg==
X-Google-Smtp-Source: AGHT+IFhKVNBvzWmqJiMxXo6DcmAUlI2fug/11cjVjkEq6XBxB6A1W0vlbMOPP2RTUGUZTenDGTSvw==
X-Received: by 2002:a7b:c7c7:0:b0:3fe:1db2:5179 with SMTP id z7-20020a7bc7c7000000b003fe1db25179mr2013510wmk.19.1693999683536;
        Wed, 06 Sep 2023 04:28:03 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y23-20020a7bcd97000000b003fbc9d178a8sm23018122wmj.4.2023.09.06.04.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 04:28:03 -0700 (PDT)
Date:   Wed, 6 Sep 2023 14:27:59 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     chengyou@linux.alibaba.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/erdma: Add verbs implementation
Message-ID: <3d140c1d-524a-4dbe-a51c-aee4f7ecafdb@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Cheng Xu,

The patch 155055771704: "RDMA/erdma: Add verbs implementation" from
Jul 27, 2022 (linux-next), leads to the following Smatch static
checker warning:

	drivers/infiniband/hw/erdma/erdma_verbs.c:1044 erdma_get_dma_mr()
	error: potential zalloc NULL dereference: 'mr->mem.mtt'

drivers/infiniband/hw/erdma/erdma_verbs.c
    1023 struct ib_mr *erdma_get_dma_mr(struct ib_pd *ibpd, int acc)
    1024 {
    1025         struct erdma_dev *dev = to_edev(ibpd->device);
    1026         struct erdma_mr *mr;
    1027         u32 stag;
    1028         int ret;
    1029 
    1030         mr = kzalloc(sizeof(*mr), GFP_KERNEL);
    1031         if (!mr)
    1032                 return ERR_PTR(-ENOMEM);
    1033 
    1034         ret = erdma_create_stag(dev, &stag);
    1035         if (ret)
    1036                 goto out_free;
    1037 
    1038         mr->type = ERDMA_MR_TYPE_DMA;
    1039 
    1040         mr->ibmr.lkey = stag;
    1041         mr->ibmr.rkey = stag;
    1042         mr->ibmr.pd = ibpd;
    1043         mr->access = ERDMA_MR_ACC_LR | to_erdma_access_flags(acc);
--> 1044         ret = regmr_cmd(dev, mr);

The "mr->mem.mtt" pointer is NULL here so regmr_cmd() will crash.  There
are three callers and the other two are correct.

    1045         if (ret)
    1046                 goto out_remove_stag;
    1047 
    1048         return &mr->ibmr;
    1049 
    1050 out_remove_stag:
    1051         erdma_free_idx(&dev->res_cb[ERDMA_RES_TYPE_STAG_IDX],
    1052                        mr->ibmr.lkey >> 8);
    1053 
    1054 out_free:
    1055         kfree(mr);
    1056 
    1057         return ERR_PTR(ret);
    1058 }

regards,
dan carpenter
