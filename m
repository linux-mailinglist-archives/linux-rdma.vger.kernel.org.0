Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E207707BD
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Aug 2023 20:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjHDSXY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Aug 2023 14:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjHDSXL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Aug 2023 14:23:11 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C6749FF;
        Fri,  4 Aug 2023 11:23:09 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso23148555e9.1;
        Fri, 04 Aug 2023 11:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691173388; x=1691778188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e9RjHAaTmtqplqyd9TcAqVVbw6vEHay+aiqiJorNXr4=;
        b=TWAD2SuThA81VPEMChQHTLdafS9mLNVS61GnYk/kjJnpVjWYFSMSVlazVgRQnHbRZb
         1iQ8rVJyKw+w1cFWacZ8I8MlGW/LOkt8Vr3INoT9NxBS/jWWPBLAA41pZjg+Yg5esdGa
         QeotBDDU2dkcq4fzpNwOJE46VJDE9MODsYNxv+6TQYl4byznJRQ5QkwA5CN5BqI3bCqI
         jeqocHRYsJSUIVzos/i4Zz66gsamuGbtCi1EOHRBYT+QaQEIxGl8Nv18GXq/vfNNdR4l
         ZbKxa2gXSWc4saQoJHJLpboCmLHT3ObzrIPOgyN9G9UEueXUKqB+KBswcYXQynIV3RdC
         0TGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691173388; x=1691778188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e9RjHAaTmtqplqyd9TcAqVVbw6vEHay+aiqiJorNXr4=;
        b=lNQcE2DtytSOQCzfvCVqKqjvmdeHxzsaTkS8vlubzj5923q/y823AvNmYpTxOpyDbz
         VMDHRYBJrCwJ6+A6brFp5Qu7y9JoC+zErjZbo3bgQyG+4tJ4OGcndGlES1/uJKefrXfi
         OthlyZmoq3RZpPVyRiV+qkTgob9C2Jzc6sDxOlU8aKBnw3jPAx5lyF0spnoFPdNdk1u1
         vqwKWDvh9GHqMmgYDVVru+N8xPxCwenr8MoYHw20yHkM/MXC3dhSw1oMKHx/TDyIDdXN
         fYKzq2NqITyhF/hVSL8De2eSer6FZhpeTcBOeIL1fpnq5tFe2vpfdgRiQKY2Kc8gpgrO
         TR+A==
X-Gm-Message-State: AOJu0Yw+uU1F4W8YxN/wUx0OCsHuB/m/VvziJAjv5E/INxcKFuxpLEgg
        kSYp3QNL/jO8sSiYcHsiGfc=
X-Google-Smtp-Source: AGHT+IHEE6/IhBd3elcfIhdXbZcFQ5bfE+5UdmSOSb4iTuT+SpASg0JoQW95YXU9/yTgdxIUvhb9iA==
X-Received: by 2002:a1c:7205:0:b0:3f5:fff8:d4f3 with SMTP id n5-20020a1c7205000000b003f5fff8d4f3mr2117493wmc.7.1691173388107;
        Fri, 04 Aug 2023 11:23:08 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id c10-20020a05600c0aca00b003fe17e04269sm2961822wmr.40.2023.08.04.11.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 11:23:07 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jianbo Liu <jianbol@nvidia.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] net/mlx5e: Fix spelling mistake "Faided" -> "Failed"
Date:   Fri,  4 Aug 2023 19:23:06 +0100
Message-Id: <20230804182306.843673-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is a spelling mistake in a warning message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
index 455746952260..095f31f380fa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
@@ -316,7 +316,7 @@ void mlx5_esw_ipsec_restore_dest_uplink(struct mlx5_core_dev *mdev)
 			err = mlx5_esw_ipsec_modify_flow_dests(esw, flow);
 			if (err)
 				mlx5_core_warn_once(mdev,
-						    "Faided to modify flow dests for IPsec");
+						    "Failed to modify flow dests for IPsec");
 		}
 		rhashtable_walk_stop(&iter);
 		rhashtable_walk_exit(&iter);
-- 
2.39.2

