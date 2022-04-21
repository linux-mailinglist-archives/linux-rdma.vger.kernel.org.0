Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF895094BC
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Apr 2022 03:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383685AbiDUBoG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 21:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383667AbiDUBoD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 21:44:03 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D6C765E
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 18:41:15 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id z8so4115185oix.3
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 18:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PN7pvzubqtiBUl4kd7cQKBgLlljE+56vzGXCYJHPmkk=;
        b=CnJPCFT27FPwc7qUyIlEx8rbIBu75DRS64wh0mslROMhV20EbzHUxNuUmk24CswNze
         4aIjyqSEYHwApAOjicjKGzNWWUs/In+lT/w9AEOCo4m4SjvJ3rKhqdI0Hujbvs0+9wZY
         xMKuFmrnWWQrphQV/23g+eFsDGXIoXnIVstVlZ70MvwFrQq2cmq+hUVURT7eWqW5f2Dl
         Pf9BhFXY3EuShRwM95jZTxdZ3WD/BkHo6sj+ss9AUEWFLZImawRr/e55yc48SD/f5chQ
         wYqdngNP22aope8AfihIqT0bodBm/2wnh1/lazQQnvYZ68M3fj7SoR/F2KiZdCqqwFTs
         VXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PN7pvzubqtiBUl4kd7cQKBgLlljE+56vzGXCYJHPmkk=;
        b=R9lDHIktNqudbn8cwdb+AW7WU4XCqG/+NF0G1vDRlKnZ7JMO4nscM+zDbqt7PqaU5L
         bkqDLfgctJ68V85GIChemOZ+kN2ZGb69qmfpIv2udmzDtUnHS+tOSXz84dwnUNTdac1C
         44fV0dyxkHcAevQrJzS/HJc4yqAeKouKDLwECIwIAi24mbrWpN375mFVuFq1tmZn4eqM
         2Eitn8ZJBo/qoBUrpKHjpfbS3t3PN+sZEAT/Lw2TLe6O/4ennivDh+SOOICtCwuAJryn
         qMgEAMc2qT5WNs5BqduGzUyc9mP1aAaFjerPSY+fhhpMBIySluyYbebsg0Jbh7um+vYa
         2qbg==
X-Gm-Message-State: AOAM530Ah1jRySY5lWTOTZjQ1xfcxQ8G09A3qDuxGr1Pi29i6SRunXHm
        VVjfVAhmqUbQo5cA7Bn1kXeQR3hC92w=
X-Google-Smtp-Source: ABdhPJyOnrAxnzYDLKog+YC6hkGxkVo88w1pNk9lNumqBY9z6dH3IzB4hzHP/VslE1ZHdLmpKMIkzg==
X-Received: by 2002:a05:6808:2205:b0:322:8621:84f with SMTP id bd5-20020a056808220500b003228621084fmr3228785oib.80.1650505275366;
        Wed, 20 Apr 2022 18:41:15 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-c7f7-b397-372c-b2f0.res6.spectrum.com. [2603:8081:140c:1a00:c7f7:b397:372c:b2f0])
        by smtp.googlemail.com with ESMTPSA id l16-20020a9d6a90000000b0060548d240d4sm4847710otq.74.2022.04.20.18.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 18:41:15 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v14 10/10] RDMA/rxe: Cleanup rxe_pool.c
Date:   Wed, 20 Apr 2022 20:40:43 -0500
Message-Id: <20220421014042.26985-11-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220421014042.26985-1-rpearsonhpe@gmail.com>
References: <20220421014042.26985-1-rpearsonhpe@gmail.com>
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

Minor cleanup of rxe_pool.c. Add document comment headers for
the subroutines. Increase alignment for pool elements.
Convert some printk's to WARN-ON's.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 661e0af522a9..24bcf5d1f66f 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -256,16 +256,32 @@ int __rxe_cleanup(struct rxe_pool_elem *elem)
 	return err;
 }
 
+/**
+ * __rxe_get - takes a ref on the object unless ref count is zero
+ * @elem: rxe_pool_elem embedded in object
+ *
+ * Returns: 1 if reference is added else 0
+ */
 int __rxe_get(struct rxe_pool_elem *elem)
 {
 	return kref_get_unless_zero(&elem->ref_cnt);
 }
 
+/**
+ * __rxe_put - puts a ref on the object
+ * @elem: rxe_pool_elem embedded in object
+ *
+ * Returns: 1 if ref count reaches zero and release called else 0
+ */
 int __rxe_put(struct rxe_pool_elem *elem)
 {
 	return kref_put(&elem->ref_cnt, rxe_elem_release);
 }
 
+/**
+ * __rxe_finalize - enable looking up object from index
+ * @elem: rxe_pool_elem embedded in object
+ */
 void __rxe_finalize(struct rxe_pool_elem *elem)
 {
 	void *xa_ret;
-- 
2.32.0

