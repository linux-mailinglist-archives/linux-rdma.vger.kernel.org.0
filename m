Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCFC2329BF
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jul 2020 03:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgG3B6E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jul 2020 21:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgG3B6D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jul 2020 21:58:03 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51C6C061794
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jul 2020 18:58:03 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id f18so3432378qke.0
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jul 2020 18:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hD4JVbRoXU8HBHOVfHiuteW8LNmG7l4+fLjJw6+lL+o=;
        b=NNHAiB3GjPKlQ2xd5ZEwvNI3BDPOqBsPbHib1dCO1pZMaDNmrdPoRZI+l+EGuATwEr
         LTtHLGmJFuTcIfU43Sqt7WooR5gHwVSc5mQM6X2YENJvLGONb7TGwcsKR2Ch+t+w9Gsh
         MFH0D0jjOIfYTSTEhLPQD/VhFax+cUjC/QKjVrcbzM0yZRgbYgBELsI2na6TDBicnWRB
         VCx8lSF2ElimO0Kpffa/BFNtv2ids+2NZ6uou8OYNhal1Ac5a+T6nCpM3/F0ySEt3NkI
         5L7dt1j0BSu3dopiQ97Q+CbqhkfRadubUKfaQjHQFkUHP40w1Ve98WSC53EtzifkMmNb
         xH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hD4JVbRoXU8HBHOVfHiuteW8LNmG7l4+fLjJw6+lL+o=;
        b=nAa9zuYYg3fhkZ6CoSjklNfXi9lVhnS9ZvXpsIoVtqkmvf7ylLlOhIsYSWw4dHZSWl
         1eNe7VMQzy6AsDwhdFKVNuJDWZs6CoTRy5+fCUKSB4YiOwfyiWu+BLRq8OQDgPsjiZ7A
         C7p61QgYpZ1Aytd4N2f4unYHSovAtJGJzcwyNooPjoWSt06OA2QDpmAlNopVc5hbaREB
         RTJTEUOTvHx9ucRzKb5OIJRnP0tK9uhhNz/j7Z9J00rfDibXP5QkBqc8f1kDw1UphRuD
         gAiMvfmpRI1QKkfplmXrat2RvDOYYCSs9oonFmZUcxu+uorSk1VhBSyeqY6zjZZ4l1EG
         P4gA==
X-Gm-Message-State: AOAM531dBKlxVFK3uuXUOxTmJdcYT0IJaobKTO1/Iy/MfIDQETA2HlXW
        1bX3ijcZMF3kjVmKYyAblSmenKgxADXwSA==
X-Google-Smtp-Source: ABdhPJxtYHASL5siDARRmf7mGdSRr96pDCPaV546UOgYlDtH2NBqg8etyj2L9VQKSHjUZCfKcfpQhSULoZWGyw==
X-Received: by 2002:ad4:4d83:: with SMTP id cv3mr767697qvb.236.1596074282824;
 Wed, 29 Jul 2020 18:58:02 -0700 (PDT)
Date:   Wed, 29 Jul 2020 18:57:55 -0700
Message-Id: <20200730015755.1827498-1-edumazet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH net] RDMA/umem: add a schedule point in ib_umem_get()
From:   Eric Dumazet <edumazet@google.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Mapping as little as 64GB can take more than 10 seconds,
triggering issues on kernels with CONFIG_PREEMPT_NONE=y.

ib_umem_get() already splits the work in 2MB units on x86_64,
adding a cond_resched() in the long-lasting loop is enough
to solve the issue.

Note that sg_alloc_table() can still use more than 100 ms,
which is also problematic. This might be addressed later
in ib_umem_add_sg_table(), adding new blocks in sgl
on demand.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/core/umem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 82455a1392f1d19c96ae956f0bd4e93e3a52d29c..831bff8d52e547834e9e04064127fbb280595126 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -261,6 +261,7 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 	sg = umem->sg_head.sgl;
 
 	while (npages) {
+		cond_resched();
 		ret = pin_user_pages_fast(cur_base,
 					  min_t(unsigned long, npages,
 						PAGE_SIZE /
-- 
2.28.0.rc0.142.g3c755180ce-goog

