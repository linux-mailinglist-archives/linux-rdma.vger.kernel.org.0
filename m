Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688544C1F5A
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 00:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242631AbiBWXIN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 18:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244062AbiBWXIM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 18:08:12 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4763584B
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 15:07:43 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id ay7so652420oib.8
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 15:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qYYgccM/xsqiv1zvdQzPYwV/Qajr9hRwnCJAvMmYI6w=;
        b=VlUvoiBJSvAbGcO/TLKiO7XXmcfwangTDRCcap0j2uXFuhss/4j6QnHcPWefv61pPT
         Ii6JJXLSRe+LfMQs67HDGUmwzECRkgs0+cjQ0JqDDbbu37Kk3ASTt8WPzlYLsWh8SjaW
         fdAbzH6vf7kqsFMI+nhY5Ga0qN6j0N2lsAhFvwf3kTOm61ulnA1NX2Dbxy1VUHSS+bT1
         qDSSej3DNZrlaRDFBMz+NOmXJgyTxhnuG/aUHwF+q9aIp5AMP55MDfDwariUsOa3agD1
         n3W7npFeVXcms5Q6X8WwKUD+Kk3IhqHQudcPRGVYZUQ8MK3isVXbc1Htc3Pe9gPlMeTs
         Sb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qYYgccM/xsqiv1zvdQzPYwV/Qajr9hRwnCJAvMmYI6w=;
        b=A5LDTx6A8BF32LY6jeevIuWtIhl9RfAogcLJTgg1tk79HVG73FOT4DGIOj9l3dFZ4J
         g9hVVioy4T0Lso6hhUCRMW82SSIiy1NtkTM2cE/zW/huzh5kLaIZ5vOg+0Mdr6+iNGLj
         x2JVIYJqvWESFf1GSCcPp8k++z+ZO9za2LxhQSYEQ6gasC4j0ppM2bhyD5YO9L9gESY7
         2bn8DSrMYPUaaaIe4kMFYnssz6+oA/hft8OEfwjT0TscNbJsbzWYiEaqxJCokttRHapi
         0z4NycK4dYRiSpVNKa3BSXxT6V+pjYi0cqIA+er5X3+d1/F1MYE5q8HfxunsTOdGsD3a
         4ahA==
X-Gm-Message-State: AOAM531A+iDq/v6hoyM2WkxsCM+1v8zsT0NFvGXztKQEhMbo/QOVgj7V
        IHK2XA2MvD+jT65WlLY+KHc=
X-Google-Smtp-Source: ABdhPJweiAt1OXtM+f3zAbkgNNkbbqGOUoyTwdiGoUFqFH41njJqWex60Yosrn416/sI6Kxx+ckHgw==
X-Received: by 2002:a05:6808:188b:b0:2d4:f7bd:ef42 with SMTP id bi11-20020a056808188b00b002d4f7bdef42mr1064645oib.179.1645657662498;
        Wed, 23 Feb 2022 15:07:42 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-809e-284a-c7bf-c6d9.res6.spectrum.com. [2603:8081:140c:1a00:809e:284a:c7bf:c6d9])
        by smtp.googlemail.com with ESMTPSA id y3sm505030oiv.21.2022.02.23.15.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 15:07:42 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v13 1/6] RDMA/rxe: Warn if mcast memory is not freed
Date:   Wed, 23 Feb 2022 17:07:03 -0600
Message-Id: <20220223230706.50332-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220223230706.50332-1-rpearsonhpe@gmail.com>
References: <20220223230706.50332-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Print a warning if memory allocated by mcast
is not cleared when the rxe driver is unloaded.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 3520eb2db685..fce3994d8f7a 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -29,6 +29,8 @@ void rxe_dealloc(struct ib_device *ib_dev)
 	rxe_pool_cleanup(&rxe->mr_pool);
 	rxe_pool_cleanup(&rxe->mw_pool);
 
+	WARN_ON(!RB_EMPTY_ROOT(&rxe->mcg_tree));
+
 	if (rxe->tfm)
 		crypto_free_shash(rxe->tfm);
 }
-- 
2.32.0

