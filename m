Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D67369CAB7
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Feb 2023 13:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjBTMVg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Feb 2023 07:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjBTMVf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Feb 2023 07:21:35 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6FD1C311;
        Mon, 20 Feb 2023 04:21:27 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id z2so1311131plf.12;
        Mon, 20 Feb 2023 04:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xov+H10N4vCuWc2wR2lV1r0anzrEzPO+y5PbK8+0+Wg=;
        b=oEXNk9FTQfMd90pGU9YBBD0J8HTO3YCODyFDym0F4VsxzZKDOxSFizVgrhFrqELNoG
         /DuyJVlDJHEh+EQyROUpC6xQq8R+pLm4ax3Qsf8bBsAaBgl7N5H9g47EOpWkj+5el0Fu
         yr9seuay5UIy6F2sZTQTCmSEqgj2Rx1zb57/P8PkzkdFMMBRn1M0tVAwTx0EFFty1cDY
         +1alyKKQXgJOVxTowZDQF8pfrXOiahMUGISj48f5XC4Rk9m1heCPYUPgGVmsiTD5LaVa
         Y/AnRlu0CRBEmw2w804UOcvACBPncbyGXBTdtNhlVyC+5XmkHVyOr9GhStorubPx0XtN
         UPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xov+H10N4vCuWc2wR2lV1r0anzrEzPO+y5PbK8+0+Wg=;
        b=q1xh24gOKAwIkHDagKp1Ttk+Z9u/iWkBbPIeOrVmlzq0mH+yP2+rvmm3dedMqT4e9C
         mMy3p2ppTrl0AjBwIw959al5lg0jhvxl4JnikYyi9d/56EaNi1qSgSB1F1Hb0igxSLS5
         6BCxjUKAEvdJBjBA2iFJ74mI6bWGinCa/awBfyyRS6TXXW99AdDu45Yn9hCmPdRzDC1s
         4XgVEmlXNgMFMUuFZkDANFSd7mr+eU+YkUw/MYJNVJSPboyqCWnG71O1uqR151j4wC4F
         egUmIdMcGqsZK+sB+gx6+t4ptMSgcMIEN6p37cFoK7ir8BYVnaXn40dhCnfSnXafqbGc
         fsbg==
X-Gm-Message-State: AO0yUKXTy4bh+HC+8Ziym7DKPGstIHcRLaS1vZEk/b9/+OEshhw0K0Wi
        lZiyUV3BkDL1vtNON1dZvBk=
X-Google-Smtp-Source: AK7set/dU7RFWwNrbEHXiFCOrku4J6mCeCr53TSrPYuLtRQ/6uMT+ANyMbeiH/D26pXhj0QPcJVH2Q==
X-Received: by 2002:a05:6a20:a008:b0:bc:8b20:97b7 with SMTP id p8-20020a056a20a00800b000bc8b2097b7mr11689327pzj.28.1676895687178;
        Mon, 20 Feb 2023 04:21:27 -0800 (PST)
Received: from XHD-CHAVAN-L1.amd.com ([149.199.50.128])
        by smtp.gmail.com with ESMTPSA id 20-20020aa79114000000b005a7bd10bb2asm7564064pfh.79.2023.02.20.04.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 04:21:26 -0800 (PST)
From:   Rohit Chavan <roheetchavan@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH] RDMA/mlx5: Coding style fix
Date:   Mon, 20 Feb 2023 17:51:16 +0530
Message-Id: <20230220122116.2047-1-roheetchavan@gmail.com>
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

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index cf953d23d18d..45c45e57bbb8 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2769,9 +2769,9 @@ static void process_vendor_flag(struct mlx5_ib_dev *dev, int *flags, int flag,
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
@@ -5514,8 +5514,7 @@ int mlx5_ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *wq_attr,
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

