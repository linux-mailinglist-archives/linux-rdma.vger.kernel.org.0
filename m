Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53707458CFF
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Nov 2021 12:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbhKVLLf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Nov 2021 06:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhKVLLe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Nov 2021 06:11:34 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3116C061714
        for <linux-rdma@vger.kernel.org>; Mon, 22 Nov 2021 03:08:27 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id h63so14943573pgc.12
        for <linux-rdma@vger.kernel.org>; Mon, 22 Nov 2021 03:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8j9GfMJUTSuyNlX0JtYEUNzVRbO89IElhevludBeDeE=;
        b=2BUgIZ4SylDSAEO3Yl2LRpi29Cil8ozANeYZz+NqBNkpJpIT70W3l0VMWSjAQnMUDm
         W9Oo/hEfSpBTRCgmDCOiCcnRvEQ+akoIRTo4pMrYJBGwlunqQEHuH0taC7Q5eniJeYs9
         xfuZQlqmfdagZPee5GJMfkeGAPMC8yjQL9nnCU0D4wBrI8+4nqPT1IL3NI36XDK7kaQn
         tqYdNc0oTHU+ETytp4UQqD2jIkmfo0fRV4EJON7wQD/8aj84cI6zbhnf6fYb6mHBkMms
         +hu7xnWLLQxuApX+jjRpY7Ny1FbQhix3CnEGdHHrZb1z6gbgSU8lsG/U1IVF0d1F/odN
         Cyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8j9GfMJUTSuyNlX0JtYEUNzVRbO89IElhevludBeDeE=;
        b=hB25wDZ7YRXuiHi+4zK5acfYBFWPB8dZFzkf1SWZmtc0Oez+m7dSDAu58SpThzavvb
         ja8lNNbOzg7PLKEi/zDum+7KZTKC+21DvNM14QfTeJ3zsszMiFNAS9Uwhc5uTNUjZ90h
         q5c6U1zE6X/Jtct3bCb3Q2Twa8gFAEDN3DBHNAvLHRNkZ8Xbl3zygObgGQ/jSci8Yl+s
         InR8/Rj5xzHRcrWMqhVZNFsEjfPxYYswKW7bqQ0W9g78Y+6mXiduuAM3BLEqXtIZWXhD
         fNxW88spP4pVki8TrialiJt+MlbzhUYQwULyQps3XK+pvvGLfyuG7MIcyN8xzGcFRAJw
         fOLQ==
X-Gm-Message-State: AOAM533gusn+oglozH2XcsiGZLKskfgCXlzWkXWqgYmBJcYbqVQ7DTT9
        KJXe/POSJfLFnheQpbMiZn3N2Q==
X-Google-Smtp-Source: ABdhPJxuy6lp75A9lhhuf/bGm760C8DD2KjY595wMNcaig7hBpaExK18IXGA4veJWh6ofv4Q4OFXDA==
X-Received: by 2002:a62:e908:0:b0:49f:c633:51ec with SMTP id j8-20020a62e908000000b0049fc63351ecmr43319945pfh.1.1637579307242;
        Mon, 22 Nov 2021 03:08:27 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id h6sm9572816pfh.82.2021.11.22.03.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 03:08:26 -0800 (PST)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Shunsuke Mie <mie@igel.co.jp>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Maor Gottlieb <maorg@nvidia.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, dhobsong@igel.co.jp, taki@igel.co.jp,
        etom@igel.co.jp
Subject: [RFC PATCH v4 0/2] RDMA/rxe: Add dma-buf support
Date:   Mon, 22 Nov 2021 20:08:15 +0900
Message-Id: <20211122110817.33319-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch series add a dma-buf support for rxe driver.

A dma-buf based memory registering has beed introduced to use the memory
region that lack of associated page structures (e.g. device memory and CMA
managed memory) [1]. However, to use the dma-buf based memory, each rdma
device drivers require add some implementation. The rxe driver has not
support yet.

[1] https://www.spinics.net/lists/linux-rdma/msg98592.html

To enable to use the dma-buf memory in rxe rdma device, add some changes
and implementation in this patch series.

This series consists of two patches. The first patch changes the IB core
to support for rdma drivers that has not dma device. The secound patch adds
the dma-buf support to rxe driver.

Related user space RDMA library changes are provided as a separate patch.

v4:
* Fix warnings, unused variable and casting
v3: https://www.spinics.net/lists/linux-rdma/msg106776.html
* Rebase to the latest linux-rdma 'for-next' branch (5.15.0-rc6+)
* Fix to use dma-buf-map helpers
v2: https://www.spinics.net/lists/linux-rdma/msg105928.html
* Rebase to the latest linux-rdma 'for-next' branch (5.15.0-rc1+)
* Instead of using a dummy dma_device to attach dma-buf, just store
  dma-buf to use software RDMA driver
* Use dma-buf vmap() interface
* Check to pass tests of rdma-core
v1: https://www.spinics.net/lists/linux-rdma/msg105376.html
* The initial patch set
* Use ib_device as dma_device.
* Use dma-buf dynamic attach interface
* Add dma-buf support to rxe device

Shunsuke Mie (2):
  RDMA/umem: Change for rdma devices has not dma device
  RDMA/rxe: Add dma-buf support

 drivers/infiniband/core/umem_dmabuf.c |  20 ++++-
 drivers/infiniband/sw/rxe/rxe_loc.h   |   2 +
 drivers/infiniband/sw/rxe/rxe_mr.c    | 113 ++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.c |  34 ++++++++
 include/rdma/ib_umem.h                |   1 +
 5 files changed, 166 insertions(+), 4 deletions(-)

-- 
2.17.1

