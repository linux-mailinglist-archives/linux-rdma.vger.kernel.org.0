Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E59E6ADB38
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Mar 2023 10:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjCGJ55 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Mar 2023 04:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjCGJ5k (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Mar 2023 04:57:40 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A033570B8;
        Tue,  7 Mar 2023 01:57:36 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id s11so49920941edy.8;
        Tue, 07 Mar 2023 01:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678183055;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jJQB/5gXipfe1LU3X5YR10NL53UE8w0mr0UyzsB03S8=;
        b=KgForhX7LM+oAiVt4CMKCwzpS5UjfFx+wa0BXt8jHwe4HGGLchHyxDx1JwtjhlMLLT
         te6qYLEimW3JJIYuiWxca+4xwipsprmTbjweRbqPMPez2Ji7tC+Qb30OAydugxB7RXvc
         MHmxdti6v0oXo0opMGL/ONHwhcDmI7jK0Fp/m93CPpRnpFU3WbZe06EIfioIrv7utSWw
         VZc7KL3aly+WaCTVXTaTi3ikbgqIy4JFaYL2TugKsXybFQtHgazymY5zMF/0HauldZ8U
         1R1gqoCCjkRu9QEVG1UA3I24W5Rt3Gy0SXC6MaRCJg1QenbZpH4ZOrVbXOfpYi70Va3d
         1BBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678183055;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJQB/5gXipfe1LU3X5YR10NL53UE8w0mr0UyzsB03S8=;
        b=kM/qkZGRNYJ7jgE1xbg6wi8ZXZKsBBmCtK0nVaViZyxKGX6e6GJNLd43bK6ZlovJlt
         Qw5PGIxNProege9rZf241VcFGWjPlacfnYjvk4wx0OpKGmswOTGhneW/EZEfeiQljewl
         n8PJP1C8tCq/SrXGcrrzy0B8FkxNiqPUbfelmpUiIKo5D0DnjQyY5pE3NMHH6JKhooQf
         JT0kDjsjVMS/goRmxqYhfMKrNOkzTessKM/6P1RrsTzlTMD9GYFSCY42gQkGd8lSjAXA
         BZqtxeThXPbt68oLAIlh1d/YOMB2L/ZGdfXe7sMh12IJ7NgVfkSV+J0EqpVp34mYtPgr
         TW0Q==
X-Gm-Message-State: AO0yUKX9AdLF6qR8oagOqefC/iOuRsMENrs5wmcNmOsFrtIrFkD5zsYk
        +Q9aeoAqg6opyZtx3PBfKSBeSXbOMJ0=
X-Google-Smtp-Source: AK7set8YRCPqJl/SKCS3F9pCBfL7k/OKqg2EWwsuALLrsybrjJ8XFz2YkuY03YTcWtjFO9ltIsLKbw==
X-Received: by 2002:aa7:cf90:0:b0:4bc:502e:e7de with SMTP id z16-20020aa7cf90000000b004bc502ee7demr12996835edx.32.1678183054977;
        Tue, 07 Mar 2023 01:57:34 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d27-20020a50f69b000000b004acb696a0f6sm6435229edn.91.2023.03.07.01.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 01:57:34 -0800 (PST)
Date:   Tue, 7 Mar 2023 12:51:27 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Jack Morgenstein <jackm@dev.mellanox.co.il>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Roland Dreier <rolandd@cisco.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/mlx: prevent shift wrapping in set_user_sq_size()
Message-ID: <a8dfbd1d-c019-4556-930b-bab1ded73b10@kili.mountain>
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

The ucmd->log_sq_bb_count variable is controlled by the user so this
shift can wrap.  Fix it by using check_shl_overflow() in the same way
that it was done in commit 515f60004ed9 ("RDMA/hns: Prevent undefined
behavior in hns_roce_set_user_sq_size()").

Fixes: 839041329fd3 ("IB/mlx4: Sanity check userspace send queue sizes")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/infiniband/hw/mlx4/qp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 884825b2e5f7..456656617c33 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -447,9 +447,13 @@ static int set_user_sq_size(struct mlx4_ib_dev *dev,
 			    struct mlx4_ib_qp *qp,
 			    struct mlx4_ib_create_qp *ucmd)
 {
+	u32 cnt;
+
 	/* Sanity check SQ size before proceeding */
-	if ((1 << ucmd->log_sq_bb_count) > dev->dev->caps.max_wqes	 ||
-	    ucmd->log_sq_stride >
+	if (check_shl_overflow(1, ucmd->log_sq_bb_count, &cnt) ||
+	    cnt > dev->dev->caps.max_wqes)
+		return -EINVAL;
+	if (ucmd->log_sq_stride >
 		ilog2(roundup_pow_of_two(dev->dev->caps.max_sq_desc_sz)) ||
 	    ucmd->log_sq_stride < MLX4_IB_MIN_SQ_STRIDE)
 		return -EINVAL;
-- 
2.39.1

