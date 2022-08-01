Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A25586298
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Aug 2022 04:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238902AbiHACbw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 31 Jul 2022 22:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiHACbv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 31 Jul 2022 22:31:51 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42B6DFC8;
        Sun, 31 Jul 2022 19:31:50 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id u133so2707945pfc.10;
        Sun, 31 Jul 2022 19:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=+u3WpKUmMzPqbZzSWYDRL7/pAJLplGIO9btAuJayqQY=;
        b=JNd36XPXWqxT98RGwCR4Ij1q5WuQSFBkNckIidMUz1/hJ4n5dizleITM+fv9+ewBKT
         vCFtpvRpNa9tqkUYYnbIy/MAQUGaFzZTGjCCawCNx1jqx1H18Ze1D/RVqOE3O0OZPACu
         Q0FqKrB90hAdVewbNaXee8pg0bZuPNxi9DeQOdRIKd0p8bqBngcvjsQ3h2vdB7YpLmNP
         sNpiPMXfe7x93+jCVqc3t+Zb/UpqF0GgCn4CAbdmvzWZBasXjQHC0VsCuz9dty31rFVT
         w04y8YstzzihIb/Hrhfnm7DiK9jMa0BbfowpHIyBNUpbYATyrQuWCcxWRJ0VmuCgv57z
         ru7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=+u3WpKUmMzPqbZzSWYDRL7/pAJLplGIO9btAuJayqQY=;
        b=09aabYp1rsIuvrJ//wsPznNG/THf3Igg9nd8O5TL67LtjhP3ZYpS2aPwllwl1+gpnb
         ULolZ7tdgKad9Px2Srq0FE0Sb/xFse9DGJZYLbSimei15eoP7DiT2J8ZZnn2V3CLQct0
         QMh27+oIZlvO3UGqDJXAOQLpfZFGGXl9aGov9tCX695zUXT9Xx1mNzu6vtQwnCksqUYM
         6jX16k+RvhSxqQQYjC+MDturOJx2gbwz+rWCPscHYAYp+FDPw4CPLDO+vtDpGbuzlKK1
         12J0mPlqAklTIKwsTjqau8uyLWnZjLnNm5HmgsSZGFgqO5Eth9s+rZtQ32VKz0JIM1zS
         0X1Q==
X-Gm-Message-State: ACgBeo2r4ns9B9dx+WrSrMxU1MmvE8O2dfuBf6iRQ5QGknBhtia5XvRB
        ZNmoIGEQw/Ng/2RxpDpWvg46ERwSzik=
X-Google-Smtp-Source: AA6agR73gQNBvRukmjTyH6j0WtZsxhvZxxx8abjV+526FLr9AX8XWg0BLf/tSny4AIy6FSqAQwEXZA==
X-Received: by 2002:a63:6587:0:b0:41b:dacc:1826 with SMTP id z129-20020a636587000000b0041bdacc1826mr5754462pgb.142.1659321110335;
        Sun, 31 Jul 2022 19:31:50 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a3ea300b001f317767790sm8587544pjc.23.2022.07.31.19.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 19:31:50 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     linux-rdma@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] IB/cm:Change the conditional statements
Date:   Mon,  1 Aug 2022 02:31:46 +0000
Message-Id: <20220801023146.1594841-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Conditional statements could changed to be easier explain.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/infiniband/core/cm.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index b985e0d9bc05..6e323d0c0fce 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -676,14 +676,9 @@ static struct cm_id_private *cm_find_listen(struct ib_device *device,
 			refcount_inc(&cm_id_priv->refcount);
 			return cm_id_priv;
 		}
-		if (device < cm_id_priv->id.device)
+		if (device < cm_id_priv->id.device ||
+		    be64_lt(service_id, cm_id_priv->id.service_id))
 			node = node->rb_left;
-		else if (device > cm_id_priv->id.device)
-			node = node->rb_right;
-		else if (be64_lt(service_id, cm_id_priv->id.service_id))
-			node = node->rb_left;
-		else if (be64_gt(service_id, cm_id_priv->id.service_id))
-			node = node->rb_right;
 		else
 			node = node->rb_right;
 	}
-- 
2.25.1
