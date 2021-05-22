Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E9438D4E2
	for <lists+linux-rdma@lfdr.de>; Sat, 22 May 2021 11:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhEVJnX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 22 May 2021 05:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhEVJnX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 22 May 2021 05:43:23 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349FDC061574
        for <linux-rdma@vger.kernel.org>; Sat, 22 May 2021 02:41:58 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so20343656otc.6
        for <linux-rdma@vger.kernel.org>; Sat, 22 May 2021 02:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uW4asTissqYazs0XK7FidUfbWSRLQRdCRrkqy8hql74=;
        b=UbKiEPmAH0kBAlqEj5A6UkqKTC1My3I7TDlYbM3gZvbOu+ST+aVDrSp/UJffrcRBIy
         4HCWBsqeFcpSiR3zI8yXAdN4moL3FzK0rEU8y+orTLIfbOzjUSzuFn3tSe3xEjP6Skog
         CciTfzaqIzQnmkg4rHo9UN4pmP2o5poz7owWSvbNUbPl2yuLTnnBNVZ/JkBXf3ucsUB4
         6qbYNwut7uJ7agMro7ISkSD7sWv7bdNZ1jbFrxzrt9lswQjcYvbTvSbe2280dSWB5qst
         Kijtfu1vJYJOyEmy3y8RnVh6UJeecU2e3MfnTRkbzrgl7CkIP9/yeq3wUYGz0mNKNBS1
         9fvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uW4asTissqYazs0XK7FidUfbWSRLQRdCRrkqy8hql74=;
        b=hu5VKwXm3sgDK0hlBYpXPKDZyK1QB/cYb/blqncfE7dX9q6NQ+xAafrDUySSuKAg0z
         gTIYjDQzjCj0JHyuSeJK60YZOzW//SgBljgM1x4BrJgQbXnAFLZfwmiObCgBsIBM8Am2
         xwyT0sp1BFf35uOYNA5o/oZI/mQMZrSM1iqpZCe25fuCnMVXLF/YXS99BBCeelUIfA2z
         XMsQNE7DXWwz/xhY+WpKI3o3eEE8fBfGH6yNX2w1cOZyS/uAqk9S9c/IWz5KoNpk3kjd
         r0F1IdPupwidbGWNsAZ1ozxonpxCwg3QlU89v7eVYzAnme70NKfs8gIoQe0837lZwJNR
         0HkA==
X-Gm-Message-State: AOAM531kyEx+ZV1TWghdnnOOM+uTAlbjCAEDhODH8eev1ZvkYHPtJSgO
        nwpYz8MJXKUxsrjFYMRpe+urMATjjHA0O76YGIs=
X-Google-Smtp-Source: ABdhPJyp4saM9ElJKnsOqTPxH4q163Bv+VsoYurzVV/6PtuIQHVIWMZvecwWh1cCBBz77RZKdTAsbGu6TV/viBvqQTk=
X-Received: by 2002:a05:6830:1388:: with SMTP id d8mr11507771otq.53.1621676517603;
 Sat, 22 May 2021 02:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <1621590825-60693-1-git-send-email-liweihang@huawei.com> <1621590825-60693-13-git-send-email-liweihang@huawei.com>
In-Reply-To: <1621590825-60693-13-git-send-email-liweihang@huawei.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sat, 22 May 2021 17:41:46 +0800
Message-ID: <CAD=hENcvLGEYOSXqU-KsWLn1He4hWoZt0S29hG7bwmpwU6ZS=g@mail.gmail.com>
Subject: Re: [PATCH v2 for-next 12/17] RDMA/i40iw: Use refcount_t instead of
 atomic_t on refcount of i40iw_cqp_request
To:     Weihang Li <liweihang@huawei.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        linuxarm@huawei.com, Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 21, 2021 at 7:35 PM Weihang Li <liweihang@huawei.com> wrote:
>
> The refcount_t API will WARN on underflow and overflow of a reference
> counter, and avoid use-after-free risks.
>
> Cc: Faisal Latif <faisal.latif@intel.com>
> Cc: Shiraz Saleem <shiraz.saleem@intel.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/i40iw/i40iw.h       |  2 +-
>  drivers/infiniband/hw/i40iw/i40iw_main.c  |  2 +-
>  drivers/infiniband/hw/i40iw/i40iw_utils.c | 10 +++++-----

https://patchwork.kernel.org/project/linux-rdma/patch/20210520143809.819-22-shiraz.saleem@intel.com/

In this commit, i40iw will be removed. And this commit will be merged
into upstream linux.
Not sure if this commit makes sense.

>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/infiniband/hw/i40iw/i40iw.h b/drivers/infiniband/hw/i40iw/i40iw.h
> index be4094a..15c5dd6 100644
> --- a/drivers/infiniband/hw/i40iw/i40iw.h
> +++ b/drivers/infiniband/hw/i40iw/i40iw.h
> @@ -137,7 +137,7 @@ struct i40iw_cqp_request {
>         struct cqp_commands_info info;
>         wait_queue_head_t waitq;
>         struct list_head list;
> -       atomic_t refcount;
> +       refcount_t refcount;
>         void (*callback_fcn)(struct i40iw_cqp_request*, u32);
>         void *param;
>         struct i40iw_cqp_compl_info compl_info;
> diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
> index b496f30..fc48555 100644
> --- a/drivers/infiniband/hw/i40iw/i40iw_main.c
> +++ b/drivers/infiniband/hw/i40iw/i40iw_main.c
> @@ -1125,7 +1125,7 @@ static enum i40iw_status_code i40iw_alloc_local_mac_ipaddr_entry(struct i40iw_de
>         }
>
>         /* increment refcount, because we need the cqp request ret value */
> -       atomic_inc(&cqp_request->refcount);
> +       refcount_inc(&cqp_request->refcount);
>
>         cqp_info = &cqp_request->info;
>         cqp_info->cqp_cmd = OP_ALLOC_LOCAL_MAC_IPADDR_ENTRY;
> diff --git a/drivers/infiniband/hw/i40iw/i40iw_utils.c b/drivers/infiniband/hw/i40iw/i40iw_utils.c
> index 9ff825f..32ff432b 100644
> --- a/drivers/infiniband/hw/i40iw/i40iw_utils.c
> +++ b/drivers/infiniband/hw/i40iw/i40iw_utils.c
> @@ -384,10 +384,10 @@ struct i40iw_cqp_request *i40iw_get_cqp_request(struct i40iw_cqp *cqp, bool wait
>         }
>
>         if (wait) {
> -               atomic_set(&cqp_request->refcount, 2);
> +               refcount_set(&cqp_request->refcount, 2);
>                 cqp_request->waiting = true;
>         } else {
> -               atomic_set(&cqp_request->refcount, 1);
> +               refcount_set(&cqp_request->refcount, 1);
>         }
>         return cqp_request;
>  }
> @@ -424,7 +424,7 @@ void i40iw_free_cqp_request(struct i40iw_cqp *cqp, struct i40iw_cqp_request *cqp
>  void i40iw_put_cqp_request(struct i40iw_cqp *cqp,
>                            struct i40iw_cqp_request *cqp_request)
>  {
> -       if (atomic_dec_and_test(&cqp_request->refcount))
> +       if (refcount_dec_and_test(&cqp_request->refcount))
>                 i40iw_free_cqp_request(cqp, cqp_request);
>  }
>
> @@ -445,7 +445,7 @@ static void i40iw_free_pending_cqp_request(struct i40iw_cqp *cqp,
>         }
>         i40iw_put_cqp_request(cqp, cqp_request);
>         wait_event_timeout(iwdev->close_wq,
> -                          !atomic_read(&cqp_request->refcount),
> +                          !refcount_read(&cqp_request->refcount),
>                            1000);
>  }
>
> @@ -1005,7 +1005,7 @@ static void i40iw_cqp_manage_hmc_fcn_callback(struct i40iw_cqp_request *cqp_requ
>
>         if (hmcfcninfo && hmcfcninfo->callback_fcn) {
>                 i40iw_debug(&iwdev->sc_dev, I40IW_DEBUG_HMC, "%s1\n", __func__);
> -               atomic_inc(&cqp_request->refcount);
> +               refcount_inc(&cqp_request->refcount);
>                 work = &iwdev->virtchnl_w[hmcfcninfo->iw_vf_idx];
>                 work->cqp_request = cqp_request;
>                 INIT_WORK(&work->work, i40iw_cqp_manage_hmc_fcn_worker);
> --
> 2.7.4
>
