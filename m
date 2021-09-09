Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA59404524
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Sep 2021 07:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhIIFrC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Sep 2021 01:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350827AbhIIFrC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Sep 2021 01:47:02 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62E4C061575;
        Wed,  8 Sep 2021 22:45:53 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id q26-20020a4adc5a000000b002918a69c8eeso202418oov.13;
        Wed, 08 Sep 2021 22:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Pv/SG3tA7yrSb48sLZzZKagPhqs7Dod2/pQrk+267E=;
        b=MGpgdDSkN+o4FYqEt4gdXdwpa7SfDBsHOhdPE7LwhR5FmrIbZQ9kwpx2JXpmKEp9Lp
         XiibZh4zGE7W+QQ3ztxPw4aH4lHKGq2gEdwgKbK6L4N7vES6/1rrGNj4kSHhdbaF/VdJ
         BSxP8PF2fMrKIXmUY3wnCFWZXPzpXVrm/Qbw81VeLBQsV1QpGnPvjc83snjiI1erliHc
         WYlMrWPqTzGJTVZ/dAKGWcwtoFi2xtNWgS53HsxLJz1dkqdYFQ0JWCuMjvggoattBsB8
         8vLhB2S2ddvZjLhNIbNFKGvri50KAnYw6PSflQrL2mggk9utb/hKtKqz9HzHjvgkOK0J
         IT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Pv/SG3tA7yrSb48sLZzZKagPhqs7Dod2/pQrk+267E=;
        b=2rWMVuLqEnQ2BENyOV2nIv3jtBkovrWEVNkwU9S3/3jLn0jrKmZRYhOniIp/ABCHRs
         60C2FlsEMFq2MfYwjD3xyXJqrOAdkkHuDhBUkypHAOuw9vnZ1kFiopvdpejT/YpCiwOK
         KT2q9Qo0hFP4Bgs1PlrJG8/Rq+f0rxjAt14M3AtIFLUaeM3/vjpr7+KrdVjRApkPVrbV
         N9Lx2cJ01lEGqpn+h8j0ozj/mFjvcSyPtI/+eJmcOeMG+pxZYHHq2JvMJU0h7+qdsIqj
         aKLM1rc0iOMyHvgx0NLXl39nxuUIXQlXhIG18QfaTiMhZJ/TJ71QetGNFIKLe+y9UXQL
         Vfmw==
X-Gm-Message-State: AOAM5332Gtdk42Qy3cGS7Mb4dCuGF0AcYEaxLGH1EP7A+rtP1x93JD6V
        QmLW/gGSQXmurX4WdhyCM5b9uXELO0bdFfqly7E9buEZ
X-Google-Smtp-Source: ABdhPJyZqqIln9S03n1DUtOd+twg50f5kxz5HF0f9k3QrRU8LpNtc0XqrL6Fodh9fIMHIgzSBjbqVsYpZ62Nnhx9uzQ=
X-Received: by 2002:a05:6820:235:: with SMTP id j21mr1086605oob.75.1631166352576;
 Wed, 08 Sep 2021 22:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210908061611.69823-1-mie@igel.co.jp>
In-Reply-To: <20210908061611.69823-1-mie@igel.co.jp>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 9 Sep 2021 13:45:41 +0800
Message-ID: <CAD=hENcYPRQXB4NVfpm+_R2qn3czW3oSOS6rS=CEKWwhHEfkZA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] RDMA/rxe: Add dma-buf support
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        dhobsong@igel.co.jp, taki@igel.co.jp, etom@igel.co.jp
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 8, 2021 at 2:16 PM Shunsuke Mie <mie@igel.co.jp> wrote:
>
> This patch series add a support for rxe driver.

After applying the patches, please run rdma-core tests with the patched kernel.
Then fix all the problems in rdma-core.

Thanks
Zhu Yanjun

>
> A dma-buf based memory registering has beed introduced to use the memory
> region that lack of associated page structures (e.g. device memory and CMA
> managed memory) [1]. However, to use the dma-buf based memory, each rdma
> device drivers require add some implementation. The rxe driver has not
> support yet.
>
> [1] https://www.spinics.net/lists/linux-rdma/msg98592.html
>
> To enable to use the memories in rxe rdma device, add some changes and
> implementation in this patch series.
>
> This series consists of three patches. The first patch changes the IB core
> to support for rdma drivers that have not real dma device. The second
> patch extracts a memory mapping process of rxe as a common function to use
> a dma-buf support. The third patch adds the dma-buf support to rxe driver.
>
> Related user space RDMA library changes are provided as a separate
> patch.
>
> Shunsuke Mie (3):
>   RDMA/umem: Change for rdma devices has not dma device
>   RDMA/rxe: Extract a mapping process into a function
>   RDMA/rxe: Support dma-buf as memory region
>
>  drivers/infiniband/core/umem_dmabuf.c |   2 +-
>  drivers/infiniband/sw/rxe/rxe_loc.h   |   3 +
>  drivers/infiniband/sw/rxe/rxe_mr.c    | 186 +++++++++++++++++++++-----
>  drivers/infiniband/sw/rxe/rxe_verbs.c |  36 +++++
>  4 files changed, 193 insertions(+), 34 deletions(-)
>
> --
> 2.17.1
>
