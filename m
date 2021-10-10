Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CAF42824B
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Oct 2021 17:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhJJPeO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Oct 2021 11:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbhJJPeM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Oct 2021 11:34:12 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038C6C061570;
        Sun, 10 Oct 2021 08:32:12 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x27so62566181lfu.5;
        Sun, 10 Oct 2021 08:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1rpdPrFDqjSDlQM4/xeyql1J912iBebRnv6liKAQE0g=;
        b=j6iQjh1tToVrzJtt7fH1P0Ms8/WhjifKtfcvmZ9+CgCIbQq/8NeHwRceEEKa1uhbqs
         n9ls8nIxVPVjmoweNSTdwEMD1cH9ppZYtIAoLDxqxBZUCczX3kjfHE8GO+gQ0nGi4ysp
         xZ1iGRAYTjKEfimvl8BYJVXwndQHhHUk1ZPbdK3lRgE4W664gerwwxY6939vg+QvlnEy
         Q7AzUKIRgcd1E05hReiExfiV/nSialR3/u69MRpUij4F7r2JFS5AMg813S5nK1KfEUL0
         y5xGdjU6SDULP4cvDSoxEuEw1VkZJ4xMq+eZsXR4PUWYRkPDmf4Ge6bTlkezlNg5duUU
         EENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1rpdPrFDqjSDlQM4/xeyql1J912iBebRnv6liKAQE0g=;
        b=RfxmmX7LEULjjx/hO0Te6Dx9mjgQgsOHVshdgg7uj09ZNKFm7gz7JdjagQe4qJt2r7
         UGIyBNUZCUz5hBnz/V6ocxQDo8dsg70/gTabT6tH8xA0Ja+UOnO3RAoMEduQ3XVJAZQU
         BkROPajZEBUo4KN5/p81x/BlX5hCgkDbm2KOes821iu7dbsANyLwWPofgtI9h9YEkZL3
         7vo9tbWdC+P+T9bFYI4Qp9W9jrFZerIz/St58DyLJOytbmtiSNJh5Lha0T/tlYp9pTDt
         myrW3glhNpxnXS8ZX7RXKWKuecFW8XPaKi0q9oz7REWxLlApK3cCuOW5cTmJrXid4pHW
         Argg==
X-Gm-Message-State: AOAM532k3x6fScCoCUxnqaYHWJlQ125HQzh0ZQuhHqm2+t/Cm9R3xz3A
        OZhD3Cn8HMEayt8Q8gUYut5PSVFzp4NJ4ceF1jQ=
X-Google-Smtp-Source: ABdhPJxlXX56rnWAN26VHPoa1prBkAG9E1MGtFp9RJVf2LbBsuT9cbojKXYLD55A1Pb8Rr3Dtn1X54gTIwsrGQAuafM=
X-Received: by 2002:a05:651c:230e:: with SMTP id bi14mr15752888ljb.467.1633879930288;
 Sun, 10 Oct 2021 08:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210929041905.126454-1-mie@igel.co.jp>
In-Reply-To: <20210929041905.126454-1-mie@igel.co.jp>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sun, 10 Oct 2021 23:31:58 +0800
Message-ID: <CAD=hENexf1asHuHROrxh-X8BUn22LM9fzvFRS1zq_XeO3DCyMA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] RDMA/rxe: Add dma-buf support
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
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
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>,
        Tomohito Esaki <etom@igel.co.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 29, 2021 at 12:19 PM Shunsuke Mie <mie@igel.co.jp> wrote:
>
> This patch series add a dma-buf support for rxe driver.
>
> A dma-buf based memory registering has beed introduced to use the memory
> region that lack of associated page structures (e.g. device memory and CMA
> managed memory) [1]. However, to use the dma-buf based memory, each rdma
> device drivers require add some implementation. The rxe driver has not
> support yet.
>
> [1] https://www.spinics.net/lists/linux-rdma/msg98592.html

It seems that dma-buf is in discussion. We will focus on this discussion.
After dma-buf is accepted, we will check this dma-buf on rxe.

Zhu Yanjun

>
> To enable to use the dma-buf memory in rxe rdma device, add some changes
> and implementation in this patch series.
>
> This series consists of two patches. The first patch changes the IB core
> to support for rdma drivers that has not dma device. The secound patch adds
> the dma-buf support to rxe driver.
>
> Related user space RDMA library changes are provided as a separate patch.
>
> v2:
> * Rebase to the latest linux-rdma 'for-next' branch (5.15.0-rc1+)
> * Instead of using a dummy dma_device to attach dma-buf, just store
>   dma-buf to use software RDMA driver
> * Use dma-buf vmap() interface
> * Check to pass tests of rdma-core
> v1: https://www.spinics.net/lists/linux-rdma/msg105376.html
> * The initial patch set
> * Use ib_device as dma_device.
> * Use dma-buf dynamic attach interface
> * Add dma-buf support to rxe device
>
> Shunsuke Mie (2):
>   RDMA/umem: Change for rdma devices has not dma device
>   RDMA/rxe: Add dma-buf support
>
>  drivers/infiniband/core/umem_dmabuf.c |  20 ++++-
>  drivers/infiniband/sw/rxe/rxe_loc.h   |   2 +
>  drivers/infiniband/sw/rxe/rxe_mr.c    | 118 ++++++++++++++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_verbs.c |  34 ++++++++
>  drivers/infiniband/sw/rxe/rxe_verbs.h |   2 +
>  include/rdma/ib_umem.h                |   1 +
>  6 files changed, 173 insertions(+), 4 deletions(-)
>
> --
> 2.17.1
>
