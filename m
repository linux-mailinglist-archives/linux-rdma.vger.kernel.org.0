Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A591A3EBDB8
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Aug 2021 23:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbhHMVHU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Aug 2021 17:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbhHMVHU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Aug 2021 17:07:20 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D351CC061756
        for <linux-rdma@vger.kernel.org>; Fri, 13 Aug 2021 14:06:52 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id o185so17748137oih.13
        for <linux-rdma@vger.kernel.org>; Fri, 13 Aug 2021 14:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uvDVnegxwS+7MxkLjpl+EFWwbWDDk6PT3cCAhFlEBQ0=;
        b=vS2TdWKR7hVk49jbGUueq46p7u0M4xzlQKW3sNa8wQHeroNY2qfA4CIuuuUDCyVxUz
         sGMoMhIpUNZgIcwslhyXyPQb7uKhn1j+470j/+E2bh8r1IpKd/Y2Cc6LRhEICd0gBg5A
         33xNESu9+CrjCuyYNzr48qtLeEQ8B7SBd4/y7wsEoZv6N8N0PeUqzL55ihhx3/8MslAx
         YYIeqiFLVpAOtbFwNCnQZCvMeLUNTUVzmXulsAtennvRDo8pRrz38ilp+zz66uv5+Emg
         19wnWPOOO9PoMTSG5GFt5tkKCKNfdi1nwsbIDC6S9v3ZNr92wL1mwnHV/FUiPI8xOWW5
         SDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uvDVnegxwS+7MxkLjpl+EFWwbWDDk6PT3cCAhFlEBQ0=;
        b=QjHxTGHjBZLcWwVrQCZeL4Tg/va7yZhbIyx3PGr/dSKB9D5OFMYH/4TBPI54LIlT1E
         ClmWd/U/rg3SoyVS7XUY3eLpKtJstD7h9L+aRS1FkWYxuIvGDMVQ90HfHAUANz8k8nbA
         n2k0KvXvW9Ohvorneb6RZMkEHbTDUljxEhVNNlcdFuFIVFo0SVOntLWe8k3WDIVuMi4z
         5V1nRlzcqyiIYvQQVrk2l68HdCVbSjgg/JGPHGxvKgw7V8nkiELC0rT+d8dpeGahGmK0
         0IrilgoRE6VS1yG9h8PUz7JasoKVTLqrbP8wjj2A5+HsD/rf8WBa1bNF0nkVTMOZPxFj
         M+1w==
X-Gm-Message-State: AOAM533xSlWZFCO9uXpWa+gJ8w/V8NMmzKyOkAFU5UiFUBtPKg+SsDXe
        PgX6n/KG+KxM4GDJwXhgalU=
X-Google-Smtp-Source: ABdhPJwuibd8Rzrkkex2z24dvPjy1kJao2NifhULZgrlknP61qjDCPTS58axb8ls9DxWYy81x/UGKw==
X-Received: by 2002:aca:2105:: with SMTP id 5mr3614504oiz.98.1628888812346;
        Fri, 13 Aug 2021 14:06:52 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-5f86-1d06-aef7-df6b.res6.spectrum.com. [2603:8081:140c:1a00:5f86:1d06:aef7:df6b])
        by smtp.gmail.com with ESMTPSA id g13sm314968oos.39.2021.08.13.14.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 14:06:51 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, dan.carpenter@oracle.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Fix memory allocation while locked
Date:   Fri, 13 Aug 2021 16:06:26 -0500
Message-Id: <20210813210625.4484-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe_mcast_add_grp_elem() in rxe_mcast.c calls rxe_alloc() while holding
spinlocks which in turn calls kzalloc(size, GFP_KERNEL) which is incorrect.
This patch replaces rxe_alloc() by rxe_alloc_locked() which uses GFP_ATOMIC.
This bug was caused by the below mentioned commit and failing to handle the
need for the atomic allocate.

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

