Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C871F41BDE7
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Sep 2021 06:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240419AbhI2EVC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Sep 2021 00:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240312AbhI2EVC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Sep 2021 00:21:02 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986AEC061749
        for <linux-rdma@vger.kernel.org>; Tue, 28 Sep 2021 21:19:21 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so1294517otq.7
        for <linux-rdma@vger.kernel.org>; Tue, 28 Sep 2021 21:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3pnOoOe4H3uxisLbZYlvxtJ/hfJYJIe9/PJe31s9cPs=;
        b=NKFeRVZewTzimFlcsgeFS3uSkCR4J87AN7Ccy2GhzJvJs61zvHTCbIrXcXuF9A37Z3
         bOAczXU1HRiNyEokRPa4xvFlmLTUqSX2ieVAcFATfw24gsBJK1LfJxj6uUhCOM2M0yUM
         hwQ0u6udUkzg4mMpVYK8Ckebdrb8V8gT0ndANmFXxsDAogwCcZrwvaB58nL/P9Gf2Jlr
         jYoC6GYrCjWlFuM8CBLMcbMxi350112bv+4s89WjKlkG2bTHlLSQ2vSkapSpsaa/eY5O
         TmhV6DgYEnoyGjTgV7tQovgi6B1rQld0vC+8aiBh9VI+KiBrYj9fe0UuWdazT8V2MXI8
         7FHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3pnOoOe4H3uxisLbZYlvxtJ/hfJYJIe9/PJe31s9cPs=;
        b=WnxA+M8p8UtJcKhpOSD9OJ50mGNK9hQGGwrBkaIPwLgU17XFNFv2bAkoa65CVZI0ry
         ZvBfVzpqCoggPxghquI1ngqzhzHAwe0c3oioPzKr85s0pDqHzV5VU/aujzCCan5ltjCW
         r0pax2s9UYUvTVS2xUorGPyo8PFP+bwS+f3faYJO17+Lcbl7cYyZSMpLXFhygBJoxIgw
         02j1iACG3mMetr1lSYryjXL/+0h6OV3YarCKQvaHcHicyboyZxUbwUL/+boUu7QmNqO2
         LRgcCSORdLZ/NxkO+bTjFcUNaN8TnQM5I0GsLWpLonkLy68YWKr6jhIOeZL7fWx/U33z
         W2sA==
X-Gm-Message-State: AOAM5328M8K9+nhr2UuBKR60HYtKttb4pkDAFIXoPK0KFj5jiM+rqv0B
        ZutWakOL9Shaixo0Uq2kxX7RlKa0m6oMn3fk
X-Google-Smtp-Source: ABdhPJwp25Cz3J0zfuH70GHFOw3bQVPteyKSacgNo4gNqbV449fcUU2N51PPLDIKqcNUaNIegMPbuA==
X-Received: by 2002:a9d:184:: with SMTP id e4mr8359740ote.209.1632889160876;
        Tue, 28 Sep 2021 21:19:20 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id p2sm240861ooe.34.2021.09.28.21.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 21:19:20 -0700 (PDT)
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
Subject: [RFC PATCH v2 0/2] RDMA/rxe: Add dma-buf support
Date:   Wed, 29 Sep 2021 13:19:03 +0900
Message-Id: <20210929041905.126454-1-mie@igel.co.jp>
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

v2:
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
 drivers/infiniband/sw/rxe/rxe_mr.c    | 118 ++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.c |  34 ++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.h |   2 +
 include/rdma/ib_umem.h                |   1 +
 6 files changed, 173 insertions(+), 4 deletions(-)

-- 
2.17.1

