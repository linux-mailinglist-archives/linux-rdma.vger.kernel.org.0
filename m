Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6E95A08EC
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Aug 2022 08:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbiHYGfj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Aug 2022 02:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235803AbiHYGfi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Aug 2022 02:35:38 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F8C9E887
        for <linux-rdma@vger.kernel.org>; Wed, 24 Aug 2022 23:35:36 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t5so24777016edc.11
        for <linux-rdma@vger.kernel.org>; Wed, 24 Aug 2022 23:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=RTFjvdY/XdFelUrknZTQMm6pYrH+vswDsl8CCg9+3Ek=;
        b=MdmHEnyxWRpEirAJiggHyjFX/uGwwvoxXS/ejcI/h7yzAfYdC6fY6NzZc8afjf2Q2H
         NfmNOVnfWcuiOJtcfRA5/jJl6R4b24rY1JJPcFJsY4QQLg0o5WZBRP022Y/HoSm2pcQl
         EBVeyGKisGj+/Zn2o5cvJKGW2SW4W3gmLUetXhJXSZ6CMAL+zsd0se9ORZHwejQFP/Zn
         RF/grv92gKY1D1cZSkj/blcb9pzv5n0mpKy3Izt2MdnOAviMRuNux4hujCKpl43XVUXG
         RZdDdXcwb9N/cI42BwJ42KlaH+6iLwCWCyfGkFzJKadwLHfufAzGNMuipVzLVOkJs/Vs
         +8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=RTFjvdY/XdFelUrknZTQMm6pYrH+vswDsl8CCg9+3Ek=;
        b=uETegO69ZnLQpl8h2GaFaoXTZb8FrbII1SH6piJXIMKmSlFdePFn7p+y+dtG4lVtVL
         t4xEYOsqXKCoGQwB5jWwaqYOhsoK01nbd//ESuC8Lxzogn9w7F7o0jh4J+PtV176WN26
         gA/avWinANpo7OGp1+NHXjzvawyFc+l698Sgigl3KBIv0ozCXmMrBvQkd23yJ8bowmNS
         melyVLU+DSDsbyG9MFdp/5YaLA/8r5MRseuck7Kpkwy9F/9bDyy4Ls2hmQliUs3QEXIB
         unYA8E+or15at0+4Bsi3jZJByIGrz6Pmkv5RFC+G11woxuoQJshLP3YYRRfoFSFdfEsV
         /dtA==
X-Gm-Message-State: ACgBeo2GiE4pqaU3CBs7AL9UdDKn+uAYcRHU4NY9pYL9QqrNYvmMFTo+
        wBKpkinprCXewp6F9VvfV4QmEg==
X-Google-Smtp-Source: AA6agR6X5o2hV4TMW4hKB+1bS0ceFDAQdGoYFFSN+ZQv5Iy7sMlgEDc8oX1CZ8H3MlRrESI+d4wJ6Q==
X-Received: by 2002:a05:6402:501d:b0:443:1c7:ccb9 with SMTP id p29-20020a056402501d00b0044301c7ccb9mr1931783eda.101.1661409335279;
        Wed, 24 Aug 2022 23:35:35 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:142d:a900:eab:b5b1:a064:1d0d])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906328200b0073c9d68ca0dsm1991219ejw.133.2022.08.24.23.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 23:35:34 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     kuba@kernel.org, davem@davemloft.net
Cc:     Tariq Toukan <tariqt@nvidia.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH] net/mlx4: Fix error check for dma_map_sg
Date:   Thu, 25 Aug 2022 08:35:33 +0200
Message-Id: <20220825063533.21015-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

dma_map_sg return 0 on error.

Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx4/icm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/icm.c b/drivers/net/ethernet/mellanox/mlx4/icm.c
index d89a3da89e5a..59b8b3c73582 100644
--- a/drivers/net/ethernet/mellanox/mlx4/icm.c
+++ b/drivers/net/ethernet/mellanox/mlx4/icm.c
@@ -208,7 +208,7 @@ struct mlx4_icm *mlx4_alloc_icm(struct mlx4_dev *dev, int npages,
 						chunk->sg, chunk->npages,
 						DMA_BIDIRECTIONAL);
 
-			if (chunk->nsg <= 0)
+			if (!chunk->nsg)
 				goto fail;
 		}
 
@@ -222,7 +222,7 @@ struct mlx4_icm *mlx4_alloc_icm(struct mlx4_dev *dev, int npages,
 		chunk->nsg = dma_map_sg(&dev->persist->pdev->dev, chunk->sg,
 					chunk->npages, DMA_BIDIRECTIONAL);
 
-		if (chunk->nsg <= 0)
+		if (!chunk->nsg)
 			goto fail;
 	}
 
-- 
2.34.1

