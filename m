Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4876443C56
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Nov 2021 06:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhKCFGS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Nov 2021 01:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhKCFGR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Nov 2021 01:06:17 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C374C061714
        for <linux-rdma@vger.kernel.org>; Tue,  2 Nov 2021 22:03:41 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id u2so2059201oiu.12
        for <linux-rdma@vger.kernel.org>; Tue, 02 Nov 2021 22:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bH4RDSjkZFm2dud+jPAsKImx5qaszg5GXRLB7woGiGQ=;
        b=YyoKoZC/AxQEHefX/wjl8GPOjQsSgOB84/b1m556e8rR6R59Yhue/2WWr3otKWhyAB
         1qB6l2eVUoQbcZfsmEfjca5U8lzhW7GwIr4I9e07vQBug63pB7sP3FEB5AtNKHvXErYS
         sAjPBblJEXTnvmAtREz8zXf7LXbX8JtlCyjgwyf2jdizY0TDR22ANKAubSCXEgipiFG5
         qZRSo/GjWiyGnZ7p8hWVPR6NQin3syn90CNkNlk+L/iPrZSn7cyVReGwRmnXA1SC6Zzf
         poyizaueslGmVVnkWZ/+tQDd3gjW2FYDUKiDNUkWfb5YIfrK6pGUaNKO1QGBkLErV4uR
         A7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bH4RDSjkZFm2dud+jPAsKImx5qaszg5GXRLB7woGiGQ=;
        b=CLjFF06YpsIAZy8De0L//h+MnmZwiEROK5iw7OUE8/v5apCHXbyISUQDdryBXbFMMw
         CZVRmZpm4iuIpThx5GOVsKKtiokLPePbCoJxYQe0pQHpsw1WMD4IoIFa91Hl9NhTvJpe
         c4Xo/LR4FIIMTZVeGFrI12mL9vqJE04Eo+EDG0+FBTqlEgQkJ3vELA7CmXxEVEOV4dRF
         oz3VKFiOuJlqEubBE2gGCqBHfO6ehBf7MBN9TsTkhXM74WQAKDm8auK/dm5kWa3lznOr
         RPmC99CZ4HSEeaVee5Z3Hi2U9jUt+x0Q/dJtZSecoPfse1dJtLJSox3cxZd0kgf7nNa7
         UXqg==
X-Gm-Message-State: AOAM532TYxvrPtXPKPZRY2ztZdoczBXJJqv1//+Y4DRAqBgWD7W0UcUC
        w+fz20xlt3iWd+cg/dmN3N8=
X-Google-Smtp-Source: ABdhPJydjRHM28hT7MNr2MCevfBI5ToNi5T8FD0S9aS5FsH6uiRb54NjTCukzJDwybdDZsbYwuUePw==
X-Received: by 2002:aca:3181:: with SMTP id x123mr5966684oix.158.1635915820963;
        Tue, 02 Nov 2021 22:03:40 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-b73d-116b-98e4-53b5.res6.spectrum.com. [2603:8081:140c:1a00:b73d:116b:98e4:53b5])
        by smtp.gmail.com with ESMTPSA id r23sm274990ooh.44.2021.11.02.22.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 22:03:40 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 10/13] RDMA/rxe: Prevent taking references to dead objects
Date:   Wed,  3 Nov 2021 00:02:39 -0500
Message-Id: <20211103050241.61293-11-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103050241.61293-1-rpearsonhpe@gmail.com>
References: <20211103050241.61293-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently rxe_add_ref() calls kref_get() which increments the
reference count even if the object has already been released.
Change this to refcount_inc_not_zero() which will only succeed
if the current ref count is larger than zero. This change exposes
some reference counting errors which will be fixed in the following
patches.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 6cd2366d5407..46f2abc359f3 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -7,6 +7,8 @@
 #ifndef RXE_POOL_H
 #define RXE_POOL_H
 
+#include <linux/refcount.h>
+
 enum rxe_pool_flags {
 	RXE_POOL_AUTO_INDEX	= BIT(1),
 	RXE_POOL_EXT_INDEX	= BIT(2),
@@ -70,9 +72,15 @@ int __rxe_pool_add(struct rxe_pool *pool, struct rxe_pool_elem *elem);
 
 void *rxe_pool_get_index(struct rxe_pool *pool, unsigned long index);
 
-#define rxe_add_ref(obj) kref_get(&(obj)->elem.ref_cnt)
+static inline int __rxe_add_ref(struct rxe_pool_elem *elem)
+{
+	return refcount_inc_not_zero(&elem->ref_cnt.refcount);
+}
+
+#define rxe_add_ref(obj) __rxe_add_ref(&(obj)->elem)
 
 void rxe_elem_release(struct kref *kref);
+
 #define rxe_drop_ref(obj) kref_put(&(obj)->elem.ref_cnt, rxe_elem_release)
 
 #endif /* RXE_POOL_H */
-- 
2.30.2

