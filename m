Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BEA736D9A
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jun 2023 15:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjFTNn3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jun 2023 09:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjFTNn2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jun 2023 09:43:28 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DC7170D
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 06:43:16 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31129591288so2975453f8f.1
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 06:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687268594; x=1689860594;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FXEzWvVaTpDBI6VqaBUCaMKU3ESDTmt5tb+GXKM/9lU=;
        b=jHRzec0TCzelOEc95MtKjmVHQWlHzHZi8Pp8968XHSTBMdl5I7PiaqWG4hV/2tnSpK
         g7y8+YWM2qNJT6DCoP7+ztfFyG+nPCQrAvRZrO0KqffM5/4lHf03ao/aH6GZ9rqfh4nU
         TeFKMZzQ5Z9OR1xdQeEphnjZziYE1tz4HhjDJxmI1ikcB9THDn8XCwbTfProloBFFTC2
         bxKCJFpXs4Ng8uPP/+BhjpdNuR2QqS6ee0Rvs9eZUmckFF1Hooh77PWYFpgylNIbcwdc
         OxMnPXOqoZCFZBOP/t5eeRa43gDA2Qoet08VWSQu2/y1AEpBo03LWGewnKr0Zk7RHYbs
         w74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687268594; x=1689860594;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXEzWvVaTpDBI6VqaBUCaMKU3ESDTmt5tb+GXKM/9lU=;
        b=ceDczWXswTj2aEbGdIs8Vb91itANS3HfAv/wBODRTEBDLEeNrGiZFxD+LEo3R+e8kt
         GPK7t/l+Xg6OwHvbWOdrEhHI6knZ2SLYCpLR34AbqxnRe3wouZmjyC50tjiW0WqCijmO
         pwXzWGDwAfciGZk6A9a4WkR2jVXVY3+sK9GwRfF7I8FxQMORBZ09Saa1M7AC8i9mBceX
         fxsjapmEB6KJ9RSWDvIN0dqrrWuxKq3Tpq6de/mOPuFxEBoMVdYFHoEVwLmlIfCUjRNW
         AeeuOG7otjFEyxH1cUDMGkN5HdiLPJtYebeys/UbmUiO4k9CE1ugcDM+jhsFD4FerBp0
         udww==
X-Gm-Message-State: AC+VfDxD8tEGW5KytK8VYf8MSMK9clgB88Q5xPWFNn2TtLEuMdtbIcLD
        jidg0auQLENjGFVvlOrUxyXfTA==
X-Google-Smtp-Source: ACHHUZ6upvLJQp+I/vEd6WG/WBwHY2kcxULaHdzrZEwgyc1/ebxdsp11EH/PEpQ+MbvkNOiJ/2VQ+Q==
X-Received: by 2002:a5d:45c6:0:b0:30f:c653:b819 with SMTP id b6-20020a5d45c6000000b0030fc653b819mr8616094wrs.14.1687268594450;
        Tue, 20 Jun 2023 06:43:14 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c9-20020a056000104900b0030631a599a0sm2023107wrx.24.2023.06.20.06.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 06:43:12 -0700 (PDT)
Date:   Tue, 20 Jun 2023 16:43:07 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Moshe Shemesh <moshe@nvidia.com>
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shay Drory <shayd@nvidia.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net/mlx5: Fix error code in
 mlx5_is_reset_now_capable()
Message-ID: <53f95829-1a94-4565-aa75-f0335cd64b8a@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The mlx5_is_reset_now_capable() function returns bool, not negative
error codes.  So if fast teardown is not supported it should return
false instead of -EOPNOTSUPP.

Fixes: 92501fa6e421 ("net/mlx5: Ack on sync_reset_request only if PF can do reset_now")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 7af2b14ab5d8..fb7874da3caa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -327,7 +327,7 @@ static bool mlx5_is_reset_now_capable(struct mlx5_core_dev *dev)
 
 	if (!MLX5_CAP_GEN(dev, fast_teardown)) {
 		mlx5_core_warn(dev, "fast teardown is not supported by firmware\n");
-		return -EOPNOTSUPP;
+		return false;
 	}
 
 	err = pci_read_config_word(dev->pdev, PCI_DEVICE_ID, &dev_id);
-- 
2.39.2

