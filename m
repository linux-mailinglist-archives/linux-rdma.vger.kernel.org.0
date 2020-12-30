Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0BC2E75B6
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Dec 2020 03:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgL3Cs3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Dec 2020 21:48:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726161AbgL3Cs2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Dec 2020 21:48:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609296422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Qd6nMabBaDCBXEiCctK4wjRScqdv2pc8J+Ek6ufNcrI=;
        b=Jxp4gpkHqln+T2GxemWNQiSq2P0nHDPopO635kq5L3uKgzE3HQQ+zW0us13CaXvTs2fhXx
        mCU6uRUV5WgQ0otMxn8okHX3kVXNXfxGHaP3SC/Juy9Itf+0HUKTXl1R2FcsGF1W2LNImt
        n7IGZ8+nSPJLezZxAZvGEKFjIHyqSHw=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-ZUq54M8FNESDTBFuVMMtXw-1; Tue, 29 Dec 2020 21:47:00 -0500
X-MC-Unique: ZUq54M8FNESDTBFuVMMtXw-1
Received: by mail-ot1-f69.google.com with SMTP id x15so11066435otp.8
        for <linux-rdma@vger.kernel.org>; Tue, 29 Dec 2020 18:47:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qd6nMabBaDCBXEiCctK4wjRScqdv2pc8J+Ek6ufNcrI=;
        b=RpL09oqAgory9JKKBFTf6kkirnEy2iZ+w+0FlJXdPW9ZyvBaonF2+wc9alnEgNsHtn
         WE5zC8PWYiT7R2nLrRDxjG6E7e4gO2smQsJzRqodc0HSttU8NnU8tVo5bWsCjWo8TzPe
         CL8HUNQH5iVdMZB/dt6ntQJDcawgzXOwxHD7kl6M3shL0AQN1IRtqyGt/wxUh5Va8kIS
         owSFRn6hUos6GZCqCfrEVXQQCb1Iz81Csto8qwkaSonXBoTM/N+KfDwsPuFkkEgnZ20J
         nGzlBt8z0F+c0eMpaDhCe/RTMa750/j0nv6XO4zxyvMJxETwsJO3DY9r0vSjgDipK7L5
         A+fg==
X-Gm-Message-State: AOAM531UwOEzOdbQnp5LHcGMbzLbmWhgLlXxRClC3eXv8gzUroq4Q2jW
        qnkeEpj4ZFsLH76e1BpaaNcldzBT3H44et4l2bzFiwlEL41srJFSIN4x7xcmlnrzX3pFhNoROUY
        Z3j1EUnImArgtROI7bGOu5w==
X-Received: by 2002:a9d:4793:: with SMTP id b19mr36913695otf.193.1609296419864;
        Tue, 29 Dec 2020 18:46:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyi+KRvLyMyUmLuqPNbTkK+ueMj71floi2LMwHGuN3AywqUKApUEtQilDxkXXDP+Bc+Nc7x8w==
X-Received: by 2002:a9d:4793:: with SMTP id b19mr36913679otf.193.1609296419647;
        Tue, 29 Dec 2020 18:46:59 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 94sm10488091otw.41.2020.12.29.18.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 18:46:59 -0800 (PST)
From:   trix@redhat.com
To:     selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        maxg@mellanox.com, galpress@amazon.com, michaelgur@nvidia.com,
        monis@mellanox.com, gustavoars@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] RDMA/ocrdma: fix use after free in ocrdma_dealloc_ucontext_pd()
Date:   Tue, 29 Dec 2020 18:46:53 -0800
Message-Id: <20201230024653.1516495-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Tom Rix <trix@redhat.com>

In ocrdma_dealloc_ucontext_pd() uctx->cntxt_pd is assigned to
the variable pd and then after uctx->cntxt_pd is freed, the
variable pd is passed to function _ocrdma_dealloc_pd() which
dereferences pd directly or through its call to
ocrdma_mbx_dealloc_pd().

Reorder the free using the variable pd.

Fixes: 21a428a019c9 ("RDMA: Handle PD allocations by IB/core")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index bc98bd950d99..3acb5c10b155 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -434,9 +434,9 @@ static void ocrdma_dealloc_ucontext_pd(struct ocrdma_ucontext *uctx)
 		pr_err("%s(%d) Freeing in use pdid=0x%x.\n",
 		       __func__, dev->id, pd->id);
 	}
-	kfree(uctx->cntxt_pd);
 	uctx->cntxt_pd = NULL;
 	_ocrdma_dealloc_pd(dev, pd);
+	kfree(pd);
 }
 
 static struct ocrdma_pd *ocrdma_get_ucontext_pd(struct ocrdma_ucontext *uctx)
-- 
2.27.0

