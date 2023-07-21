Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7670075D5FC
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jul 2023 22:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjGUUvQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jul 2023 16:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjGUUvP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jul 2023 16:51:15 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E35D2D7B
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 13:51:14 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a412653352so1597673b6e.0
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 13:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689972673; x=1690577473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50adx+O5i2zetcnORsbaLKi+BjncFeH1wEkN4/15/TI=;
        b=WdHLi7ryjjxUAanqqFoDmBn5fI9JswywJm79+cnEGlQaeiwtVcNHg9b6G0mIyCClwy
         5ylZ4s+JbCceIdIytK/sohRRDzOEMD1ZdILNgNLPx19UqoGNX3kyVXTF8T4zF+1KYOvr
         diudTbpR20teRTJ1IBTFprOGLpzc+n9j9t+hrlxmM7aW+ePgODg7pICR5BHJpaLjr4G/
         YtOxOe3Ws5cMD295PCAy4+V0WaHF8Ld2S2WzcxeaP0OtAZ5uvfO2vhHdLUsrhZZ/VOw2
         gXtTV55UYc5yI9AymHSqteFdGax+2VucyhyLvEST1NLfjGGsLbcePJrr9U1fLaYbW62Z
         xOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689972673; x=1690577473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50adx+O5i2zetcnORsbaLKi+BjncFeH1wEkN4/15/TI=;
        b=QZL/yJODiWZJBN8JmYhY5W8nw1vJR0p5LJ+mt3Q1nRRfuqv1t3nDnFwSl773ZHNJHc
         ePc78yqm0rDtu/Z1XqJcanooOgn8ci5YQEGnglFtgDAP9QqjYoui6bIGXEw1rxL2v65h
         AKD8WMg0Nm8RKGd1oQZrYw6ipwJTuU6FG4JB84GxKraBcDM5EUi41YH3/0+vO5C72TwL
         +NJbuL+xPLIZpSDX6EDAA5eM22If0fE2lAaC8CX7nTFC0qAX6w2Q8eA/5Vd6XbyFPSuM
         guowssEtV2pNWeUAwFMFgWgObG1vFkUzhvJ18nTMi6d0EgcXnDTrqagNPcaSvi8AI/S2
         vaPQ==
X-Gm-Message-State: ABy/qLZAZXuFSrHJNHYRE1vOQ4FBftBvPeTyGkVujtuF202YneDXu5Gv
        KieJxxMfQgA/FTmgUysnR3I=
X-Google-Smtp-Source: APBJJlHSCUSGXMIzJiHreJ9UU28DMpIV/ZspKt8eMM0uJ8FkJec07nguWKQZmw1acFDokgqe1I04hQ==
X-Received: by 2002:a05:6808:2a6f:b0:3a4:45b7:ae06 with SMTP id fu15-20020a0568082a6f00b003a445b7ae06mr2852249oib.56.1689972673389;
        Fri, 21 Jul 2023 13:51:13 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-3742-d596-b265-a511.res6.spectrum.com. [2603:8081:140c:1a00:3742:d596:b265:a511])
        by smtp.gmail.com with ESMTPSA id o188-20020acaf0c5000000b003a375c11aa5sm1909551oih.30.2023.07.21.13.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 13:51:12 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 8/9] RDMA/rxe: Report leaked objects
Date:   Fri, 21 Jul 2023 15:50:21 -0500
Message-Id: <20230721205021.5394-9-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721205021.5394-1-rpearsonhpe@gmail.com>
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch gives a more detailed list of objects that are not
freed in case of error before the module exits.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index cb812bd969c6..3249c2741491 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -113,7 +113,17 @@ void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
 
 void rxe_pool_cleanup(struct rxe_pool *pool)
 {
-	WARN_ON(!xa_empty(&pool->xa));
+	unsigned long index;
+	struct rxe_pool_elem *elem;
+
+	xa_lock(&pool->xa);
+	xa_for_each(&pool->xa, index, elem) {
+		rxe_err_dev(pool->rxe, "%s#%d: Leaked", pool->name,
+				elem->index);
+	}
+	xa_unlock(&pool->xa);
+
+	xa_destroy(&pool->xa);
 }
 
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
-- 
2.39.2

