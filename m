Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EAC68C051
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Feb 2023 15:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBFOkn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Feb 2023 09:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBFOkm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Feb 2023 09:40:42 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C6F6E8F;
        Mon,  6 Feb 2023 06:40:41 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso10924514wms.5;
        Mon, 06 Feb 2023 06:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lNBGnfql26nMVEZnGqLckYgZRmrNvkVJGT25CMo/sv0=;
        b=D7K5LC2cy6FPkd+E/LUC4kZeqdzjUw6ynZizepdmKnsj/G7jINlaYwbkblMs6cLLar
         JPvghdqfKgdCfB5Ei9TKE+ad2/K+7LoIuD2/8vOpeK6yjXzAi5XJn8q8l02izyWoD5ik
         oQGB1sEfnKp7dTfps3B/SG1yXJQBMtCqmHMoqwb1pGMB+DEL9i2AmBLM9KGkfo2Hf3f8
         6z4hzc6iah6Iqk6ZVFeZ+DRJok5kyyXMsdYxIYVOJMnQbDpa8BMWUnMDgQilm07UcHa5
         MPrpnYTuknHx09qn4/EqLBllf5Cjag24tzs8MZcClX4mixK+HnECX9ERTSLZRS8UyXl5
         IS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNBGnfql26nMVEZnGqLckYgZRmrNvkVJGT25CMo/sv0=;
        b=wVUy2IXtUWjCF0gX0JuV9mO/LDrNlkx9jFkNdUyC0O6LJTrtECp/mGQH0rfq+3aSCH
         UUz82gUZNvuDVm3Av4/nUL2UUpLEJAyV9DDLLvD8jq98/WrRqXjJ1eg5e7vflzkI2mrJ
         kx8tu0OTB3ZRYpThnEY0wOs2GIaJI5fuEBYKUnjp3qK2CjZCHRJLdkULhjZrbRkepcFt
         YASuwSbsh/Gj/YWbAZyugm+05tI7Du5PvEta2S3dou3nkSI7dVPyiBbvs2dNQaPEEw6a
         Tzn6RJSjkRlkW8GNSBjFScN/AStijdDWV4LDGoitvmsrOFsMLCT9Lw5QA6Nu6WJsvdCA
         bXnQ==
X-Gm-Message-State: AO0yUKV27iH+CMApDMGGhodiBn7AE7q+JZ9VgOF9I2v4RLq1KRyZbaP2
        EEMjWhF+n67AGkoLB6lPl7I=
X-Google-Smtp-Source: AK7set/grbWLfkMRpIFTz5OrVlF5doiXTKdPxO0cBlJpGfKcoO6rMYpOCKdMA5oSsJtP6sGqFaK3Gw==
X-Received: by 2002:a05:600c:5113:b0:3dc:59ee:7978 with SMTP id o19-20020a05600c511300b003dc59ee7978mr19621900wms.38.1675694439951;
        Mon, 06 Feb 2023 06:40:39 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x9-20020a05600c21c900b003dc434b39c7sm21309230wmj.0.2023.02.06.06.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 06:40:39 -0800 (PST)
Date:   Mon, 6 Feb 2023 17:40:35 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Michael Guralnik <michaelgur@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/mlx5: check reg_create() create for errors
Message-ID: <Y+ERYy4wN0LsKsm+@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The reg_create() can fail.  Check for errors before dereferencing it.

Fixes: dd1b913fb0d0 ("RDMA/mlx5: Cache all user cacheable mkeys on dereg MR flow")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index c396b942d0c8..2feab0818a76 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1164,6 +1164,8 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 		mutex_lock(&dev->slow_path_mutex);
 		mr = reg_create(pd, umem, iova, access_flags, page_size, false);
 		mutex_unlock(&dev->slow_path_mutex);
+		if (IS_ERR(mr))
+			return mr;
 		mr->mmkey.rb_key = rb_key;
 		return mr;
 	}
-- 
2.35.1

