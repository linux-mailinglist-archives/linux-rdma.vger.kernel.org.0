Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A4669FF9E
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Feb 2023 00:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjBVXfm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Feb 2023 18:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjBVXfk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Feb 2023 18:35:40 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E700474E5
        for <linux-rdma@vger.kernel.org>; Wed, 22 Feb 2023 15:35:34 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id h6-20020a9d7986000000b0068bd8c1e836so1823363otm.3
        for <linux-rdma@vger.kernel.org>; Wed, 22 Feb 2023 15:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txrG+XyGJdvlPT2WXHV96O7F0Ip9Mn8/lpisEf+j1DI=;
        b=jfaWxFQlx37/I0cWRKsYOEyfGpBSkJRF+9sTVMaMjYcDMOorZfmrBQ24wCzAbnQ+RY
         y2ehekvfLV/NPE91wnMYAUL9MRiM7I7skrDyt464k+N4pDELdoNSdJ04UfD+Q0tixOgn
         yvhNSAMblzFLFs7mz6BA6Ehg8OW+xKP6gukESmGLYvVeGfCfeUj7ltsumkKVDgqK+LeR
         IgaULLB6+OCxfSINd0K8UE0l9AbtEtfQMAh77MHJHf5ESoqHTUIDwdj/5i6xYYwZV3og
         Y8GUUzqpxlCgY1/ml0O+UpzsFEg4GYdi1BHSGNd7lpsmURv1Ncby3JKAGocdoio1ybT9
         sLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txrG+XyGJdvlPT2WXHV96O7F0Ip9Mn8/lpisEf+j1DI=;
        b=ntTmRVL0c1sbPNCjF4m+OkkNr/EkwqCypeL9XJovRJ+R+KtFetY3BQznvbdhCcSgSW
         aAfclbljkHs7NI+3SmrQ6jsI5uiLybas8rU8140Fopqenhc8RLK18Dn9fL2MPqPweYID
         s7TMKIDOzuWFU67TgPlXVFT+icEhn7yRB3NnOVhVzi26HSzXv99dUR1/vAN5x8xai4ZH
         PNmUXFzvzDBqc95S+gp5Lmzdzj51habv9wvxEC2mNs/4o3b6J3xpQDQLyjSycm5bw/k+
         U7amQZ2iGEzH2uek/jMuPFOjVfNohE0HarM3zfmmGqnyTCxya/UMkQbz/fSACT93mNNU
         6KSg==
X-Gm-Message-State: AO0yUKVI3451NpY8a8qx4N1PP+jV3Af4MNw1nT3xL5cEuyihvdSFST8E
        tz/B4TD1LE+/oHjNS2e4Hz19TGxqYiU=
X-Google-Smtp-Source: AK7set8I2WIH6QapqN7veHKSNOrRmh9rjDmb6NC9fGzhG9u5kkI1uL8m8+UCX8T6Y4O0HeCbqK5beg==
X-Received: by 2002:a05:6830:441e:b0:68b:c67c:5d0b with SMTP id q30-20020a056830441e00b0068bc67c5d0bmr1365177otv.10.1677108933465;
        Wed, 22 Feb 2023 15:35:33 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-e92c-8850-3fad-351f.res6.spectrum.com. [2603:8081:140c:1a00:e92c:8850:3fad:351f])
        by smtp.gmail.com with ESMTPSA id l19-20020a9d7093000000b0068663820588sm2723281otj.44.2023.02.22.15.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 15:35:31 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 5/9] RDMA/rxe: Add a warning if refcnt zero in rxe_put
Date:   Wed, 22 Feb 2023 17:32:34 -0600
Message-Id: <20230222233237.48940-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230222233237.48940-1-rpearsonhpe@gmail.com>
References: <20230222233237.48940-1-rpearsonhpe@gmail.com>
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

This patch adds a WARN_ON if the reference count of the object
passed to __rxe_put() is <= 0. This can only happen if the
object has already been destroyed so the object will soon be deleted
which is a driver bug.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 3f6bd672cc2d..1b160e36b751 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -244,6 +244,8 @@ int __rxe_get(struct rxe_pool_elem *elem)
 
 int __rxe_put(struct rxe_pool_elem *elem)
 {
+	if (WARN_ON(kref_read(&elem->ref_cnt) <= 0))
+		return 0;
 	return kref_put(&elem->ref_cnt, rxe_elem_release);
 }
 
-- 
2.37.2

