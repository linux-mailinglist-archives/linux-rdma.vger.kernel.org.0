Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE94760972
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jul 2023 07:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjGYFkT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jul 2023 01:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjGYFkO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jul 2023 01:40:14 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9622136
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jul 2023 22:39:52 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso41998195e9.2
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jul 2023 22:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690263591; x=1690868391;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QK/okmUinC9yivXMdeIX7gtpB1W4+61OtE5OK7/P5uM=;
        b=hGf5EtwfUSuy9kJcR7Zdai1zR/HrZNBAVsoFFQ4Wyfr0D3wJtHkYsDJe93CM7GURcG
         hv6GpSzwkHjC4xgJLBcucTuJa7BFfLixJgvIxYnjbdTXusFn5MNcBoQ2jFW54vm43eqT
         eAlu7D42IcjTUvA1F48PrCNopqiNyvm0JfkSfzf8YVYdd/9FbVn++/zZXEmnP0uBrkwc
         BcYMa+AnSc2NrgkpwO478drbMBlXltslzQFbkxUuoey/GT0I/NB0aaIaUXTJO/56JL2q
         3KHN3Apb7FLv1PybYP41iRT1mn0bS69anZ8fiIw5zGYqXhGPdq8sPQ71FNPWjHWSaOxm
         61aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690263591; x=1690868391;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QK/okmUinC9yivXMdeIX7gtpB1W4+61OtE5OK7/P5uM=;
        b=KHb+NbTAZfR/7UFG6/JPzax1jh+/wH73koRxCNWjsbBAIp5JGMImyn7H3JduRTPkuJ
         HWE42zJjT8+QXWkvvmxZ6P6I/LznfDsOpmmiiLmQ13FILh4+VVIejGhE9puoQnTjT/6C
         4firkPN0UwIdnGwHLI88PDNB+4PmdHm08bTHcQiKECUiCye7RM+yIY65a8Rmqu7fCngV
         wAoSne9+A1e2V61bK2gtGUUQXEoNg4NJC/79HzgLNuQqiVTS6AJvh7uB0vjBBBY2Y34q
         hu+TJYf9e3ENb36kdONSFVLuoBnTm9yUq1ccIppRdEw3b6mrx2fmJSBbXMFTVok82W1e
         J/Ag==
X-Gm-Message-State: ABy/qLb/SZvSm5lfrJ/YyqM60p2a1pGbYJMUbG5SvShrGjf7D0FX/Z2e
        lG1gPQUiBlJ4FQoxbSubQPxVeQ==
X-Google-Smtp-Source: APBJJlHonfpvehVKWDAgzjTBn8MdMn1leAqDn8dOoo5ZmhCLQseSzOxoAfr6/4Wt7yR3/q9Q6jVKhA==
X-Received: by 2002:a7b:cc17:0:b0:3fa:e92e:7a8b with SMTP id f23-20020a7bcc17000000b003fae92e7a8bmr8339981wmh.13.1690263591355;
        Mon, 24 Jul 2023 22:39:51 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b13-20020a5d4d8d000000b0031417fd473csm1868914wru.78.2023.07.24.22.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 22:39:51 -0700 (PDT)
Date:   Tue, 25 Jul 2023 08:39:47 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Tariq Toukan <tariqt@nvidia.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net/mlx4: clean up a type issue
Message-ID: <52d0814a-7287-4160-94b5-ac7939ac61c6@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These functions returns type bool, not pointers, so return false instead
of NULL.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Not a bug.  Targetting net-next.

 drivers/net/ethernet/mellanox/mlx4/mcg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/mcg.c b/drivers/net/ethernet/mellanox/mlx4/mcg.c
index f1716a83a4d3..24d0c7c46878 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mcg.c
+++ b/drivers/net/ethernet/mellanox/mlx4/mcg.c
@@ -294,7 +294,7 @@ static bool check_duplicate_entry(struct mlx4_dev *dev, u8 port,
 	struct mlx4_promisc_qp *dqp, *tmp_dqp;
 
 	if (port < 1 || port > dev->caps.num_ports)
-		return NULL;
+		return false;
 
 	s_steer = &mlx4_priv(dev)->steer[port - 1];
 
@@ -375,7 +375,7 @@ static bool can_remove_steering_entry(struct mlx4_dev *dev, u8 port,
 	bool ret = false;
 
 	if (port < 1 || port > dev->caps.num_ports)
-		return NULL;
+		return false;
 
 	s_steer = &mlx4_priv(dev)->steer[port - 1];
 
-- 
2.39.2

