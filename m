Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA6E7A4F9B
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 18:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjIRQre (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 12:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjIRQrV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 12:47:21 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA18E5B
        for <linux-rdma@vger.kernel.org>; Mon, 18 Sep 2023 09:45:21 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6c0a42a469dso2987972a34.2
        for <linux-rdma@vger.kernel.org>; Mon, 18 Sep 2023 09:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1695055520; x=1695660320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xwVwdymhk9ZNEYwcJiyFkPPjqsBsogD2MSPmiRZEtZ4=;
        b=dYSBgcljFxw5iryzF0ydHydmWDU9euOqdet+wEzL9gdDiz/ee8HdRi0X4cwCbeExJi
         QE+lzKgWUEKKHqb8ur95byzaL5YySJLF2vkKk02lr/JZQLaEqk3H73X2s0KaMGXAoB1R
         bheI8JVuNCOOhvItJQxB022Z7mSBjmUGudhvkam6fAIYjs5zPcTZ+fZQooPHKhXItajc
         4aOTbAHS1kSnEl/z5qefKqKNBlDEt5Jdk49Fqamk1FtkTVkRZPWi1dzkB9d4JGaJiL1h
         8TCaov+LhgNH+vVU+JQWpGb1kpWMnmIGd5ggl2gIFacqWkWo9J76KpXyY1L1XW/RzV1m
         a83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695055520; x=1695660320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwVwdymhk9ZNEYwcJiyFkPPjqsBsogD2MSPmiRZEtZ4=;
        b=NrRvK3FrUcJvvyRahETscdihfBvvwb9mDttx6J7BbEJBjFUI1XgFHrRou78XFbEEN4
         51kzk6jKbcCJMZL5UFq+MWMjt6e8rlgcHdIjvdylh3PxnNU0SL5qOeBTN47YZi0lyBIk
         RCz0T/3BV7HUGxF7i0yQgx9rnCWe3gBiHtS8K82PAW1MD84VI8D+CrStFIgkAkMNicZM
         Gvna5mLbql2V2+8nleMQKm9R1YSIbrKQkf2cqpg9VMJsl1Se6up38GOtR/Bp7hHrXcYp
         x74RhZNpf0fr9YWCAkO1jwMuK9lJlvsyXkK0HOt4RqLKQ8S3Wx27APpcBdSfAKBzZVCy
         qrkA==
X-Gm-Message-State: AOJu0Yz52BF3/jFYhOafdIWzSR6//sNYsIOoQh+NIYf4JvLheYP7mLs5
        VARB2JdcIYsUYcHrbU0ZOXRBvUn7V22xAehcYVyKt9oCwIIk44VYMMVUZkU8hPykm8zkdZqsSJQ
        YMy3tBXbFIAr00RayqgFYCqsXGG9vBTyhQVtavYPcy10UlmjX1YUBCdglXhnrNF5bkZ5g0OS7DY
        1Pch4NOrw=
X-Google-Smtp-Source: AGHT+IFfBOl7CpmhXn7ZKRewqnZ6wapTwITx0xPq+fuPKEj2VfK2Z3RN8HiFyAKEUzVgVdzs3BLOsQ==
X-Received: by 2002:a05:620a:4051:b0:76f:339:96fd with SMTP id i17-20020a05620a405100b0076f033996fdmr9921703qko.23.1695047221104;
        Mon, 18 Sep 2023 07:27:01 -0700 (PDT)
Received: from enf.. (pool-173-48-155-156.bstnma.fios.verizon.net. [173.48.155.156])
        by smtp.gmail.com with ESMTPSA id q16-20020ae9e410000000b00767d4a3f4d9sm3173585qkc.29.2023.09.18.07.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 07:27:00 -0700 (PDT)
From:   Vitaly Mayatskikh <vitaly@enfabrica.net>
To:     linux-rdma@vger.kernel.org
Cc:     David Ahern <dsahern@kernel.org>,
        Roland Dreier <roland@enfabrica.net>
Subject: [PATCH] RDMA/core: use rdma_cap_iw_cm() in rdma_resolve_route()
Date:   Mon, 18 Sep 2023 14:27:00 +0000
Message-Id: <20230918142700.12745-1-vitaly@enfabrica.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rdma_resolve_route checks for the full rdma_protocol_iwarp support
before calling cma_resolve_iw_route, while in fact rdma_cap_iw_cm is
sufficient. This makes it possible to use IW CM for device
implementing IW Connection Management only, but not the whole iWarp.

Signed-off-by: Vitaly Mayatskikh <vitaly@enfabrica.net>
---
 drivers/infiniband/core/cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index c343edf2f664..356da8e625aa 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3378,7 +3378,7 @@ int rdma_resolve_route(struct rdma_cm_id *id, unsigned long timeout_ms)
 		if (!ret)
 			cma_add_id_to_tree(id_priv);
 	}
-	else if (rdma_protocol_iwarp(id->device, id->port_num))
+	else if (rdma_cap_iw_cm(id->device, id->port_num))
 		ret = cma_resolve_iw_route(id_priv);
 	else
 		ret = -ENOSYS;
-- 
2.34.1

