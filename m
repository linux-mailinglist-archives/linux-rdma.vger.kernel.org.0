Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A84405E30
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Sep 2021 22:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbhIIUrg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Sep 2021 16:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345513AbhIIUrf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Sep 2021 16:47:35 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4D1C061575
        for <linux-rdma@vger.kernel.org>; Thu,  9 Sep 2021 13:46:22 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id t2-20020a4ae9a2000000b0028c7144f106so988267ood.6
        for <linux-rdma@vger.kernel.org>; Thu, 09 Sep 2021 13:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K8QclyT6YwReg2Sbj3mCsph2JF/Ghr33vsgZB5KMcDU=;
        b=pvuKbZFzgjlAFn3C4uyXGsounND1LuyCDATrC8r0EdNEw5lESfKgzdKomfRs2S8E+l
         po8uTZoHbHY1DPUVAJ1lOu8lJ8OWTx7i4lBMzX1gjlXKq9gcn9jRQEPqUwk0VeTOzNPI
         YmaQuX64zVdBwmkkEkw1gBLeU8rTF3SNZioycdMRIhfAB0Xo2mjG3ppfeTIlK5UDKhZV
         NnYDF6bO9CeJWH3kDX2aZYDI3nEhjyE1vo+HFZBneVquqE2MtYUuTYA3mrYZ94Zg6shu
         xZt0JoyTDqj8J2B23sT21HaZYoI12PqbPlzMwQxd2XfNxUrtokKQ0ngf1LCarehNna3j
         u85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K8QclyT6YwReg2Sbj3mCsph2JF/Ghr33vsgZB5KMcDU=;
        b=blkeSDgvOhv6fUqeQDYTUF3qO+v4meCEjnRX2N4Z4v7TpBRrCRGng0aDHhMgJljNLq
         yISfU7SuUPMnKC761uPTD7x/4+QH1nz06hj5Tazy0DVGKzGynpA6mb5aq1dMRpInP73X
         /MtULnI369H9hDF8UhzbAdzlwxDglgmqA4kUdiaRY/L19xpIqcujUyBvBjyWqG+tyQvq
         rUjjqA0jETl/lgniaxL6cr4dMjFn3JZHxV2YBlrKua4+s8kJggNtYQ878EemrJtfMaoO
         rR3Mx0S8gukWDSZzHpWpM7IwV4Cn2rnkMMZ4jx+Rv17w666iifSe98Toqsffpx9YDmFC
         rmUA==
X-Gm-Message-State: AOAM532TfQj0t4aHfBTB7DTVU4kxab9i5ncuKD0F118MERyT6gzH+Vma
        u4YiptI/tuuTjcvpU9NkSUk=
X-Google-Smtp-Source: ABdhPJxb4jAqL+jebywRgzelC52pjxfMIJRBgnch83MjxmrgwByHbm6boKyOAJJ8zxiu+pmEMrWIvw==
X-Received: by 2002:a4a:db86:: with SMTP id s6mr1515247oou.58.1631220381979;
        Thu, 09 Sep 2021 13:46:21 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-a0a5-b98f-837d-887f.res6.spectrum.com. [2603:8081:140c:1a00:a0a5:b98f:837d:887f])
        by smtp.gmail.com with ESMTPSA id i9sm719892otp.18.2021.09.09.13.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 13:46:21 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        mie@igel.co.jp, bvanassche@acm.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH for-rc v3 2/6] RDMA/rxe: Fix memory allocation while locked
Date:   Thu,  9 Sep 2021 15:44:53 -0500
Message-Id: <20210909204456.7476-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909204456.7476-1-rpearsonhpe@gmail.com>
References: <20210909204456.7476-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe_mcast_add_grp_elem() in rxe_mcast.c calls rxe_alloc() while holding
spinlocks which in turn calls kzalloc(size, GFP_KERNEL) which is
incorrect.  This patch replaces rxe_alloc() by rxe_alloc_locked() which
uses GFP_ATOMIC. This bug was caused by the below mentioned commit and
failing to handle the need for the atomic allocate.

Fixes: 4276fd0dddc9 ("Remove RXE_POOL_ATOMIC")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 0ea9a5aa4ec0..1c1d1b53312d 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -85,7 +85,7 @@ int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 		goto out;
 	}
 
-	elem = rxe_alloc(&rxe->mc_elem_pool);
+	elem = rxe_alloc_locked(&rxe->mc_elem_pool);
 	if (!elem) {
 		err = -ENOMEM;
 		goto out;
-- 
2.30.2

