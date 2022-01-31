Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A17D4A475C
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jan 2022 13:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348776AbiAaMh6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jan 2022 07:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377971AbiAaMhw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jan 2022 07:37:52 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC19C061714
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 04:37:51 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id t7so19180095ljc.10
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 04:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GSaXwCyoeZjyzhm88nDoFFkVdfYS1ajplIb9rucyrFg=;
        b=M1LnOcRZOOo0w74Hy+AGssfbBS+7lk69dzqj61gAbVW6pe62CyLJ7BlrUBJ4SfuqGX
         w+8vRc6wvWZXlV50gns+7I5qTnfYJbIeWqXO8iBaydD8qsgi5GxU1liFm8oOgabbtiRN
         a3xjhrZbVbQq7p8uyr0EjH6SaDJKxVCxpPUo5KPM4qk+VwIQpdSRuDLkHLZmooci06pP
         WB4PtuwzZ+k5mZ1NkzTV1inmkv81jF+ZoU//tK8z74rbl6g06siDL4RV9jNWvwL7uwqB
         2MT3VAXurYH1IV2yik48uuGiAeNrfjYwNY42pivnJ9weLVckifTx7PVFIsisRnDtBdVM
         TCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GSaXwCyoeZjyzhm88nDoFFkVdfYS1ajplIb9rucyrFg=;
        b=domH2Mk1gOgqg/MZf+bhJMTbaHJP8sSXsP/O/P+f9eCoQewm/5oy9A9nLHL61ispZc
         JWqiZeIRiVC2cFPmEv9fub1fvLhVq8fBTQAfjsXO1rI/sMRZKJlcZYUmTD630dPY+MWo
         NrMZ5rh1sw1zfocgbo9PYuZIOVNaxpedK2IhXzNvnR96+mIq1AonHQrbOD7XSCz+TJha
         U2QbJ2eijj3DKBpdcXmp+J7DvtiuI2CnuKoSblnZgwl66oyO9vLPggs+hWQ/ewhH37Bz
         le1iy+54wIbIEX0kPsyjkPLwfH8l70rotdiGy55156Wlgv6zJj1FXDdSQ3rySz2yIz1D
         5MCA==
X-Gm-Message-State: AOAM533HqtkJaYXdeceUN0czv3cS7E4XNvvXP7Gk0Tsjb28khzJTgO+A
        +/cfGBTkEywWsmmWO6pv/aoJeIY8y4ByS9gCLpeIKg==
X-Google-Smtp-Source: ABdhPJyUggPrsk7uyc3yYX9NIjpDffpxYzZdoMbxElsdVO+lhbCW1q+PYWBGmVBZfBOyn4ryM0zn69fOQodX9f/PTos=
X-Received: by 2002:a2e:9003:: with SMTP id h3mr13387843ljg.111.1643632669768;
 Mon, 31 Jan 2022 04:37:49 -0800 (PST)
MIME-Version: 1.0
References: <20220120143237.63374-1-jinpu.wang@ionos.com> <20220128165951.GA1874313@nvidia.com>
In-Reply-To: <20220128165951.GA1874313@nvidia.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 31 Jan 2022 13:37:38 +0100
Message-ID: <CAJpMwyjR4JKhjEMdUja39uVRQmnncc9E-iXVH21UmUAah4rr2w@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs-clt: Fix possible double free in error case
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jack Wang <jinpu.wang@ionos.com>, linux-rdma@vger.kernel.org,
        bvanassche@acm.org, leon@kernel.org,
        Miaoqian Lin <linmq006@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 28, 2022 at 5:59 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Jan 20, 2022 at 03:32:37PM +0100, Jack Wang wrote:
> > Callback function rtrs_clt_dev_release() for put_device()
> > calls kfree(clt) to free memory. We shouldn't call kfree(clt) again,
> > and we can't use the clt after kfree too.
> >
> > Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> > Reported-by: Miaoqian Lin <linmq006@gmail.com>
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > index b159471a8959..fbce9cb87d08 100644
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > @@ -2680,6 +2680,7 @@ static void rtrs_clt_dev_release(struct device *dev)
> >       struct rtrs_clt_sess *clt = container_of(dev, struct rtrs_clt_sess,
> >                                                dev);
> >
> > +     free_percpu(clt->pcpu_path);
> >       kfree(clt);
> >  }
>
> This need to delete the call in free_clt() too.
>
> Also, calling dev_set_name before device_initialize is a bad idea.
>
> Do it like this and fix all the bugs please:
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index b696aa4abae46d..4d1895ab99c4da 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -2685,6 +2685,9 @@ static void rtrs_clt_dev_release(struct device *dev)
>         struct rtrs_clt_sess *clt = container_of(dev, struct rtrs_clt_sess,
>                                                  dev);
>
> +       free_percpu(clt->pcpu_path);
> +       mutex_destroy(&clt->paths_ev_mutex);
> +       mutex_destroy(&clt->paths_mutex);
>         kfree(clt);
>  }
>
> @@ -2707,13 +2710,8 @@ static struct rtrs_clt_sess *alloc_clt(const char *sessname, size_t paths_num,
>         clt = kzalloc(sizeof(*clt), GFP_KERNEL);
>         if (!clt)
>                 return ERR_PTR(-ENOMEM);
> -
> -       clt->pcpu_path = alloc_percpu(typeof(*clt->pcpu_path));
> -       if (!clt->pcpu_path) {
> -               kfree(clt);
> -               return ERR_PTR(-ENOMEM);
> -       }
> -
> +       clt->dev.class = rtrs_clt_dev_class;
> +       clt->dev.release = rtrs_clt_dev_release;
>         uuid_gen(&clt->paths_uuid);
>         INIT_LIST_HEAD_RCU(&clt->paths_list);
>         clt->paths_num = paths_num;
> @@ -2730,52 +2728,52 @@ static struct rtrs_clt_sess *alloc_clt(const char *sessname, size_t paths_num,
>         init_waitqueue_head(&clt->permits_wait);
>         mutex_init(&clt->paths_ev_mutex);
>         mutex_init(&clt->paths_mutex);
> +       device_initialize(&clt->dev);
> +
> +       clt->pcpu_path = alloc_percpu(typeof(*clt->pcpu_path));
> +       if (!clt->pcpu_path) {
> +               err = -ENOMEM;
> +               goto err_put;

This path would lead to a call to "free_percpu(clt->pcpu_path);", even
after alloc_percpu failed.

Everything else looks good to me. I will send a revised patch after
some internal testing in sometime.

Thanks for the review and comments.

> +       }
>
> -       clt->dev.class = rtrs_clt_dev_class;
> -       clt->dev.release = rtrs_clt_dev_release;
>         err = dev_set_name(&clt->dev, "%s", sessname);
>         if (err)
> -               goto err;
> +               goto err_put;
> +
>         /*
>          * Suppress user space notification until
>          * sysfs files are created
>          */
>         dev_set_uevent_suppress(&clt->dev, true);
> -       err = device_register(&clt->dev);
> -       if (err) {
> -               put_device(&clt->dev);
> -               goto err;
> -       }
> +       err = device_add(&clt->dev);
> +       if (err)
> +               goto err_put;
>
>         clt->kobj_paths = kobject_create_and_add("paths", &clt->dev.kobj);
>         if (!clt->kobj_paths) {
>                 err = -ENOMEM;
> -               goto err_dev;
> +               goto err_del;
>         }
>         err = rtrs_clt_create_sysfs_root_files(clt);
>         if (err) {
>                 kobject_del(clt->kobj_paths);
>                 kobject_put(clt->kobj_paths);
> -               goto err_dev;
> +               goto err_del;
>         }
>         dev_set_uevent_suppress(&clt->dev, false);
>         kobject_uevent(&clt->dev.kobj, KOBJ_ADD);
>
>         return clt;
> -err_dev:
> -       device_unregister(&clt->dev);
> -err:
> -       free_percpu(clt->pcpu_path);
> -       kfree(clt);
> +err_del:
> +       device_del(&clt->dev);
> +err_put:
> +       put_device(&clt->dev);
>         return ERR_PTR(err);
>  }
>
>  static void free_clt(struct rtrs_clt_sess *clt)
>  {
>         free_permits(clt);
> -       free_percpu(clt->pcpu_path);
> -       mutex_destroy(&clt->paths_ev_mutex);
> -       mutex_destroy(&clt->paths_mutex);
>         /* release callback will free clt in last put */
>         device_unregister(&clt->dev);
>  }
