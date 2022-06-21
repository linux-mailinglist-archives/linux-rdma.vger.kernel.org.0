Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B8A552A70
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jun 2022 07:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiFUFZ7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jun 2022 01:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiFUFZ6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Jun 2022 01:25:58 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DE42124D;
        Mon, 20 Jun 2022 22:25:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id go6so7206511pjb.0;
        Mon, 20 Jun 2022 22:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cObR3+olODnsmHmG40dfcNk9dBbtTD141Doa/y8coxE=;
        b=PvwRqUb/i0fSGKPftsQ1EvcaFh/v7AmSfz9FHt3LB3+HaYe1qYVdiWY7uytiwvhrTe
         e/p0JBYfwfrESybD/kF8zC2YB6Zw/Ks1YLOYYfxOAOesk3BJ7wk804AQueWCJ/5G+HIs
         PqVuLMupqclywDPFvkLlFTHSh9/t0N2HPdPcdjx5BMTVJtS0VWV5zcs6WOjuoUFdBk4C
         +CAfKP5RL6GtltSasWefoTZrHOgJZEGgS2tokYZeuqUn2MhPdkY2bHmHyQi8UsXJPApX
         QmCCQg+THKWzM4+Dk5lKdbc5ss5Zqa6F1sPGdTJUpQG490CDchrRqgsWfI+eIM8Pc7IC
         Ehpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cObR3+olODnsmHmG40dfcNk9dBbtTD141Doa/y8coxE=;
        b=esmXdKEm3YMfN5Ei3BSGemTGNjayVqm0pSlAbMXJx1fqE4vLiXHCLQhfB/Yder1Tmn
         Ae3Gu926ZEkSKHZx9bhZKhyd7BUtzJLPs5jLtlDa82ZvAQbr3GCga0GZe3lboV4oRNIN
         2qk7gU9RJEr5Hri3jmPB832kuADq+QxqC7ZMKpFllKfOaBo2YiUhW4nYIswi8qMmDzHK
         LzXa8/rFww6+AjuHxW0BYB3Kh3eFf5UFlYmsfsjXmwz15EUOy0CUnEOd3i2mQXWo8zgl
         9sctWTD+JRUuWufekkud1s2u2UAmeJGIdkw/u3qTcGARwzz9qYbfZlf7oRLcBm+I8Mgy
         7HHg==
X-Gm-Message-State: AJIora8EqU09NKxhrzdSbpEtF3L85Dn0c0Ag7brP9ZO8t0KuzE0mstTH
        4fFV04AgAg/wiREFM/Ld79A=
X-Google-Smtp-Source: AGRyM1ui1Et9aDTy1aPasyfHl0qi1yawDAg9J/fOvbEllSGx9hNYepdkFsTxzGb3ysKQqfPu197Y5A==
X-Received: by 2002:a17:90b:4b10:b0:1ea:fa1a:feb5 with SMTP id lx16-20020a17090b4b1000b001eafa1afeb5mr26854018pjb.205.1655789157389;
        Mon, 20 Jun 2022 22:25:57 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id g23-20020a17090a579700b001eaec814132sm10966488pji.3.2022.06.20.22.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 22:25:56 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Mark Zhang <markzhang@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Weihang Li <liweihang@huawei.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] RDMA/cm: Fix memory leak in ib_cm_insert_listen
Date:   Tue, 21 Jun 2022 09:25:44 +0400
Message-Id: <20220621052546.4821-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

cm_alloc_id_priv() allocates resource for cm_id_priv.
when cm_init_listen() fails, it doesn't free it,
leading to memory leak. call ib_destroy_cm_id() to fix this.

Fixes: 98f67156a80f ("RDMA/cm: Simplify establishing a listen cm_id")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/infiniband/core/cm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 1c107d6d03b9..b985e0d9bc05 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1252,8 +1252,10 @@ struct ib_cm_id *ib_cm_insert_listen(struct ib_device *device,
 		return ERR_CAST(cm_id_priv);
 
 	err = cm_init_listen(cm_id_priv, service_id, 0);
-	if (err)
+	if (err) {
+		ib_destroy_cm_id(&cm_id_priv->id);
 		return ERR_PTR(err);
+	}
 
 	spin_lock_irq(&cm_id_priv->lock);
 	listen_id_priv = cm_insert_listen(cm_id_priv, cm_handler);
-- 
2.25.1

