Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D467E0141
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Nov 2023 11:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjKCGge (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Nov 2023 02:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjKCGgb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Nov 2023 02:36:31 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9045F1B2
        for <linux-rdma@vger.kernel.org>; Thu,  2 Nov 2023 23:36:25 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9d465d1c86bso258575266b.3
        for <linux-rdma@vger.kernel.org>; Thu, 02 Nov 2023 23:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698993384; x=1699598184; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3T+yLx+4ogAE3gIeP8EgVVgsRa9BX/dyzs2Dpc0BF4o=;
        b=JkOnr0cFHdtxVfiQRmuxWT3PRSUHv/Xdd7Ev/MwY9X+mstwSESg4VqwgoG5WZ5VAVA
         zmKu0fgaZlLyFDiEELknQaS7z1nws46byvs+hvpKiLPpeQXxQ0hAXsC/dw/zPUIBlElP
         YYr/5/d6xbMXHKO3oikJSyw/7eQ8T0GuzSohbrWESXKYU+iI2n0mjtCKDjhcrRhlpAoR
         zYqatuTdbKY8A76VDdZulGVTeODlazqynwIGMpt6Qx/AfEUckmB5zk8oEGwwxnocuSrK
         Fjc6Q6+xhYcwPOGambMI5jdp5UT6XN6ghYK1pVCexE1P/jB+rU4a8IkDQP64rA+8oWTL
         wwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698993384; x=1699598184;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3T+yLx+4ogAE3gIeP8EgVVgsRa9BX/dyzs2Dpc0BF4o=;
        b=faGf7QtRj1lzIY9nNUll3Uix+UaFTAg6+ewdKNuVG7dMv7QBq6QAAz3mzFfMulVfhB
         RJomfYAv/+HH1TlrD6nhf7eP6XiKBjVeTAFbs6Iqda3AZDKqXaLRtUlOIc57S7E9J/62
         boPy6sfGLx5633wt7flxvyarDPKQYDpxrB19NYs2dzkF1gXZMxp195GYixI+e1lzNhDa
         ePIWN8FJA4CykhrjoejksNDkjcTR+BEB/3XiTt4xKORMz6JoUfyZ/0fydFvRnabwII2Q
         0NM3LpnIXOyV7+f7rf/ZjVJYkod90HvQPcyLLXm5ckwolMX+cksQ+HVAx9CLL1/nvCpW
         A8+w==
X-Gm-Message-State: AOJu0YwvH48vdO4Ofh5MueDfAOFVh1lYZkxUO+poZFEu5AMZqvIABe1P
        NAkp1mDuZR4352MPBXRH+8CYc4uXVc15KYplmvQ=
X-Google-Smtp-Source: AGHT+IEIZwpXows9kDY2z3asR0pXuUZWwTLFQ4ciJzI6HwkQ9NLgBbUfSMO6/4CkCnV3aEALCj5gCg==
X-Received: by 2002:a17:906:6a23:b0:9bf:2f84:5de7 with SMTP id qw35-20020a1709066a2300b009bf2f845de7mr6147260ejc.4.1698993383852;
        Thu, 02 Nov 2023 23:36:23 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k11-20020a17090646cb00b009d0be9be6e2sm537198ejs.43.2023.11.02.23.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 23:36:23 -0700 (PDT)
Date:   Fri, 3 Nov 2023 09:36:20 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Saeed Mahameed <saeedm@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eli Cohen <elic@nvidia.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH net] net/mlx5: Fix a NULL vs IS_ERR() check
Message-ID: <4ee5fbea-7807-42dd-a9b8-738ac23249d0@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The mlx5_esw_offloads_devlink_port() function returns error pointers, not
NULL.

Fixes: 7bef147a6ab6 ("net/mlx5: Don't skip vport check")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
I *think* these normally go through the mellanox tree and not net.

 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 693e55b010d9..5c569d4bfd00 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -1493,7 +1493,7 @@ mlx5e_vport_vf_rep_load(struct mlx5_core_dev *dev, struct mlx5_eswitch_rep *rep)
 
 	dl_port = mlx5_esw_offloads_devlink_port(dev->priv.eswitch,
 						 rpriv->rep->vport);
-	if (dl_port) {
+	if (!IS_ERR(dl_port)) {
 		SET_NETDEV_DEVLINK_PORT(netdev, dl_port);
 		mlx5e_rep_vnic_reporter_create(priv, dl_port);
 	}
-- 
2.42.0

