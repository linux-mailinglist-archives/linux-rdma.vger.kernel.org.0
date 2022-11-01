Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFC361532E
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Nov 2022 21:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiKAUYC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Nov 2022 16:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiKAUYB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Nov 2022 16:24:01 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E0E1EAE5
        for <linux-rdma@vger.kernel.org>; Tue,  1 Nov 2022 13:23:59 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-13b23e29e36so18099338fac.8
        for <linux-rdma@vger.kernel.org>; Tue, 01 Nov 2022 13:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3rQEWll29OjU+ecMAk0UIt23uSILXVIrphaLoNTl9g=;
        b=AcHwO1s54d8os4kAo9febr+BwsYCS55/o5MEbHYyL2Y0W30awBcYj65hc5QoeI8NM1
         2+o0j/bzqSLMWdn+MyJWTibibOKchYgXyjRvw4FMPiGLmtmSrMQOXSepm5y0wtAN4Bt9
         vvS122hoX5n/Sb9vDa4YbQIA3qUV52j3YOdA0QPi9GsKKoq08bsmTQ9Yo79y7BiaDheO
         9GLuOxwaswgN9bG7554VV0tKbobxPAhquQFG3wh/ivzNnRRl6pn697b9+2pTERYJJHmz
         E8WBwfeyS6yaTe0YZ33YGpQ+qAs6++VXYCUrQ1bSamfrvdXMCHo2+3FTtxrZ/EJfnqau
         vUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3rQEWll29OjU+ecMAk0UIt23uSILXVIrphaLoNTl9g=;
        b=ZYWwZ8S/1jC6bat8OwynVllhiJj9jGYIGA+/M9UvoIYxYUjD9yGxY1/K33U/ZM1b/q
         2p+iNRcme/IOLLYd/8GH4BCyJ8nSSqKmL8KGi1CElMkI/WVRz5ASubgSe6YBzMzLzcBR
         5hLaMzoFuzsqDeMDKkhP4gCs+wKeSvJC7Ism2D8INt7bzOS9vvYskBbwywk19lktzBwe
         SSITrc+WgDsthLusOy9LwQENgB7gysFamZnfEkgoYtXV+cY9ED70ubBYN2mv5/Qx8yoQ
         6ihVaTy4mHaaFU9OVFU37e9dsnIIYWfCG7gplLwblRwqqccWwNEoXFSPjcFnXggftJ1o
         FYvw==
X-Gm-Message-State: ACrzQf3SMXb9uQIOsntpbKfKI4pvBBbOwlH1lkHvLfzDQAjFbf7AgTnS
        dseLuue67KdDVmA0Lv92K2M=
X-Google-Smtp-Source: AMsMyM4vxcs0KsxG2NEAgrNGhxOpuR9w9ykMFoqjbMqMFTHECvtza9Kpp49nPcRpg0ddr9HCC0ToLg==
X-Received: by 2002:a05:6870:808f:b0:13d:3e44:49ff with SMTP id q15-20020a056870808f00b0013d3e4449ffmr2876776oab.63.1667334238920;
        Tue, 01 Nov 2022 13:23:58 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-e052-4710-92ba-8142.res6.spectrum.com. [2603:8081:140c:1a00:e052:4710:92ba:8142])
        by smtp.googlemail.com with ESMTPSA id d22-20020a056830045600b0066210467fb1sm4337493otc.41.2022.11.01.13.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:23:58 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 11/16] RDMA/rxe: Replace pr_xxx by rxe_dbg in rxe_verbs.c
Date:   Tue,  1 Nov 2022 15:22:36 -0500
Message-Id: <20221101202238.32836-12-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101202238.32836-1-rpearsonhpe@gmail.com>
References: <20221101202238.32836-1-rpearsonhpe@gmail.com>
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

Repalce calls to rxe_err/warn in rxe_verbs.c with rxe_dbg().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 510ae471ac7a..e6eca21c54e6 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1103,7 +1103,7 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 
 	err = ib_register_device(dev, ibdev_name, NULL);
 	if (err)
-		pr_warn("%s failed with error %d\n", __func__, err);
+		rxe_dbg(rxe, "failed with error %d\n", err);
 
 	/*
 	 * Note that rxe may be invalid at this point if another thread
-- 
2.34.1

