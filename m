Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8723241D383
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 08:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348034AbhI3GjJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 02:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348190AbhI3GjI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 02:39:08 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E8DC06176C;
        Wed, 29 Sep 2021 23:37:26 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id c26-20020a056830349a00b0054d96d25c1eso5995203otu.9;
        Wed, 29 Sep 2021 23:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UpCMKte4+xNLfPIEFcorY2txGsUkKL05E8UxngAqFMw=;
        b=N5ykDUOZTUBs2Y5qWszbpDqp88cTbjalX0dj3NmeVUvMuPOrOHLAaN3NqZfr7keKOp
         njkX/0bdG6+fJIYpSQB+GXnLOZTAOWDwgZ2njIcR0CSDszZCD1NHQKOw0pyiDLCKqXQv
         24aJuN/lB9NiuQSfnRcCV3THkBQqxs6wwtZpmIQHk8LihgnPU3ZtLVOTXu9WOwhmmEf1
         BCgWe+xyHzPCiNmAtB5nlWFWL4TMO+UCT8H0MAUrvK83dq9VdN6xD6IaqHyG+lMq6B4v
         kjKHvlOQ/RJwzHgBwe5r/IjMK/ErISKfAuTrZzmvtfckdpqvlZn5eUPQCe/RmRlI78k8
         qPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UpCMKte4+xNLfPIEFcorY2txGsUkKL05E8UxngAqFMw=;
        b=rxfQx9eDJDkF0efDm84cPsYRuJAI235srCmnjqyAI6kPTPXVx1S/95fJjcIdLT47ak
         +qkP7o8lmjug8PAp57QFHsvNHuDoCfbe9BLizM7EpOCjDZMHoXcREHwmu33lQUb7E9CR
         MXCc41BeZQvG2MxZPmQXErFZeqhtbvbPY54gvubu2VtDvi4vY2waBVwhoXsfiUog3eBt
         HWgp/9RygXQRNedupseeGSTnFwdJHVdBAl6rz79TIST2zmeKvUchwmnyYtc7k4nnITiZ
         bwQW2m2lgRf8G7yzIpJZmYtDaczxK3u3U6YRaJN+zb500EF5wkDdGfVkJlC422CZl/H2
         zQbA==
X-Gm-Message-State: AOAM532F05MLweWecw65mEbtAI/A5EKhGtK7NkkwHUfUn5ynBHrNvxTp
        J++pOPFnO9kCr1f8q4SxFZKS7hSzffd5sbCNO58=
X-Google-Smtp-Source: ABdhPJxYSHNlbkBfgzm9RVq+rFNE58GGZ65ZfxotZSdw0rV8yudfRpYxR0498mEQjyXg/GMz0ISms1OLAQqNDtP3hus=
X-Received: by 2002:a05:6830:1089:: with SMTP id y9mr3770951oto.335.1632983845807;
 Wed, 29 Sep 2021 23:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210930062014.38200-1-mie@igel.co.jp> <20210930062014.38200-2-mie@igel.co.jp>
In-Reply-To: <20210930062014.38200-2-mie@igel.co.jp>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 30 Sep 2021 14:37:14 +0800
Message-ID: <CAD=hENdzYGNp14fm9y9+A71D2BJSjV5GewHMkSJKUzNOs0hqWg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] Providers/rxe: Add dma-buf support
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
        dhobsong@igel.co.jp, taki@igel.co.jp, etom@igel.co.jp
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 30, 2021 at 2:20 PM Shunsuke Mie <mie@igel.co.jp> wrote:
>
> Implement a new provider method for dma-buf base memory registration.
>
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> ---
>  providers/rxe/rxe.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
> index 3c3ea8bb..84e00e60 100644
> --- a/providers/rxe/rxe.c
> +++ b/providers/rxe/rxe.c
> @@ -239,6 +239,26 @@ static struct ibv_mr *rxe_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
>         return &vmr->ibv_mr;
>  }
>
> +static struct ibv_mr *rxe_reg_dmabuf_mr(struct ibv_pd *pd, uint64_t offset,
> +                                       size_t length, uint64_t iova, int fd,
> +                                       int access)
> +{
> +       struct verbs_mr *vmr;
> +       int ret;
> +
> +       vmr = malloc(sizeof(*vmr));
> +       if (!vmr)
> +               return NULL;
> +

Do we need to set vmr to zero like the following?

memset(vmr, 0, sizeof(*vmr));

Zhu Yanjun

> +       ret = ibv_cmd_reg_dmabuf_mr(pd, offset, length, iova, fd, access, vmr);
> +       if (ret) {
> +               free(vmr);
> +               return NULL;
> +       }
> +
> +       return &vmr->ibv_mr;
> +}
> +
>  static int rxe_dereg_mr(struct verbs_mr *vmr)
>  {
>         int ret;
> @@ -1706,6 +1726,7 @@ static const struct verbs_context_ops rxe_ctx_ops = {
>         .alloc_pd = rxe_alloc_pd,
>         .dealloc_pd = rxe_dealloc_pd,
>         .reg_mr = rxe_reg_mr,
> +       .reg_dmabuf_mr = rxe_reg_dmabuf_mr,
>         .dereg_mr = rxe_dereg_mr,
>         .alloc_mw = rxe_alloc_mw,
>         .dealloc_mw = rxe_dealloc_mw,
> --
> 2.17.1
>
