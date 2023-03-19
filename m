Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146176C0082
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Mar 2023 11:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjCSKJG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Mar 2023 06:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCSKJF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 Mar 2023 06:09:05 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B721557F;
        Sun, 19 Mar 2023 03:09:03 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso13590299pjb.0;
        Sun, 19 Mar 2023 03:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679220543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qrjBDcKLWIFWkd8qN7MihPIUroki0Vzxj+3swazicxU=;
        b=hohI0YcG4+0isHLMPAL9dGkOFQKa9TvXM6JW0ERGkG6g9LluWmBx/UTVBn4SPjsLl8
         BNR//nBzHctwOdjAev8ihqPGVaHZjCngbbWQ6e419r/pN2CkT50Z11XAebA5Q5qgyjVb
         UAUno3Y9w1wRLSrcv/wobidW76SG89IQucl8uggIXvFgq/IbNlikiy4+LskrxhKHFMRE
         17xvc0cUsOIIFx5/Cn8rKi1m9EzNcL+skPZyxgMBbdrtoT13f4YX5OSLorCMg7tbucFD
         pVsPedYHWMXz8yHuItHa8OFh7jBPYw7Jm1O8eisvpsxlgn4da0lN91nIPh2uPmD318q2
         wXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679220543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qrjBDcKLWIFWkd8qN7MihPIUroki0Vzxj+3swazicxU=;
        b=2B7Mp45DfWNS9s4OB8+jAPA656sRfdK9sZ7vHq3s2x0+/nu6xpiUDKOx9VW+u7JVdO
         7Mk6IdLz3IbMQT8fWXVyb1w+ZHS0NEDK7ZhGK0fJrUNmJolHXPYb2POZNfT3979X3aYQ
         aFdrrip/vayV95Yy4b/yhq6gtDYA5jQ8vqAjoCxmAjOeGHTo+yc2LNMrFsqw3ADPJFg4
         5gfHBMZaT+js1XoKTSimE+iPImpe/gHJ9/wdeyb7gxWHWKU0qbuxkn9CyUbiXkYVl6qW
         yC8YN6ezYvUqhjGYpfKZwsd4kC2PznlN6a2ouh/sauNECpWbeMOsdNAr+eauxfolkF17
         0LWg==
X-Gm-Message-State: AO0yUKWYTWOMF0Zy04qGOWyexb4KkzHHnI7qwWkMlZRq/1c91KdAJawI
        6s4chBN0RqxRJsg4cdLs7Ec=
X-Google-Smtp-Source: AK7set+WDm4v30L09kvk11uVxiHpUxvMPRro7LDrqOz6eKhJ8U1OZJVlK1BVRc/YV1Yuq4aTuZNYlQ==
X-Received: by 2002:a05:6a20:7b16:b0:d9:2cef:949a with SMTP id s22-20020a056a207b1600b000d92cef949amr1150958pzh.28.1679220542824;
        Sun, 19 Mar 2023 03:09:02 -0700 (PDT)
Received: from XHD-CHAVAN-L1.amd.com ([103.115.201.92])
        by smtp.gmail.com with ESMTPSA id g16-20020aa78190000000b0058d9058fe8asm4369441pfi.103.2023.03.19.03.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 03:09:02 -0700 (PDT)
From:   Rohit Chavan <roheetchavan@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH] RDMA/mlx5: Coding style fix reported by checkpatch
Date:   Sun, 19 Mar 2023 15:38:47 +0530
Message-Id: <20230319100847.5566-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Block comments should align the * on each line on line 2849
Avoid line continuations in quoted strings on line 3848

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 7cc3b973dec7..2bad38cb39fe 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2846,9 +2846,9 @@ static void process_vendor_flag(struct mlx5_ib_dev *dev, int *flags, int flag,
 	case MLX5_QP_FLAG_SCATTER_CQE:
 	case MLX5_QP_FLAG_ALLOW_SCATTER_CQE:
 		/*
-			 * We don't return error if these flags were provided,
-			 * and mlx5 doesn't have right capability.
-			 */
+		 * We don't return error if these flags were provided,
+		 * and mlx5 doesn't have right capability.
+		 */
 		*flags &= ~(MLX5_QP_FLAG_SCATTER_CQE |
 			    MLX5_QP_FLAG_ALLOW_SCATTER_CQE);
 		return;
@@ -5592,8 +5592,7 @@ int mlx5_ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *wq_attr,
 		if (wq_attr->flags_mask & IB_WQ_FLAGS_CVLAN_STRIPPING) {
 			if (!(MLX5_CAP_GEN(dev->mdev, eth_net_offloads) &&
 			      MLX5_CAP_ETH(dev->mdev, vlan_cap))) {
-				mlx5_ib_dbg(dev, "VLAN offloads are not "
-					    "supported\n");
+				mlx5_ib_dbg(dev, "VLAN offloads are not supported\n");
 				err = -EOPNOTSUPP;
 				goto out;
 			}
-- 
2.30.2

