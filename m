Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61237248E58
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 20:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHRS6N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 14:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgHRS6J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 14:58:09 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11BAC061389
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 11:58:08 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id w17so16079748edt.8
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 11:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DcSiF9BvO3QkAU5ib+Xz5B/aind/8GrqXBGMtW1mEf0=;
        b=bEmjfhEr/4H44+lteG1/5yV1vIF3ms6BmtumOiIxllYPVwZQwAG9rhstAbm+JIkWnd
         f1cSc1W00I/uEcDV+BdfXN/O4Qkd6kyFs0rtcJNuqHVC2pNObN63b0lBbVThdr6WRaBO
         AVYCvjezxumPRE5UmQsBa95tJD0uy/eWNXYbuWX8H3cUPldy0khZW1Q4XK8p+warjZxk
         qtUtOFsXgYBhRRJ2DNbJTLhHMHs2vc9lhn6/jm1cLYI8ah2MghINyZmCkCE8NgMeirjT
         hHMyrXQR5SRlEcIDiaphFgSgl07o/wa6zvUQOmVCWtG72cbioKbsBCHL58i6h2ClAK07
         59ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DcSiF9BvO3QkAU5ib+Xz5B/aind/8GrqXBGMtW1mEf0=;
        b=RBHZJZWfPb1zkJ0AnwcNhyPBnX4gh4Qh60QscBCD8Kwwd2OUZAykdiKrv0nYTKGHBm
         G9n321MydbCTy/1gekGOv+JVPOXGVKOf7vsQen/Guv+MVTbOAc5qf6mAXbJLJm3omCsI
         p8F3ePbozKLpI7W8vqYkhpd8TPNaXfigQIDXLThICrsc0dcQtu9GfhyYFDF1e0r9uJkR
         oNTgWvbSPXR91nhtMLvGK0GLQs7w0XEPsoMtYxif5zQ5md3zau5DDF2UpcMBs7hEvkrl
         KlrUowCL/haaHVvlQ9ySVfVyhssK8qbGEDw/oRZr9PjJkHc9RkiAiSFm7//vz06gFAK1
         LoOg==
X-Gm-Message-State: AOAM530lFyfTi6EIwfrFjIKWZT9SFRiM5l/TDJwvN7zSFN+CdBvNRHzG
        Vm63qbGTnSiojpc78wZKTjhoUEW54gpCE3mK3frcQg==
X-Google-Smtp-Source: ABdhPJzRqO5W38eLG3Xf3NOVi3Kozt+oGum/+zJT5vT61AS5eWCnY5G3YTjIQ3j6rdIsKbe8iV474McZ6/9PFYMNH9M=
X-Received: by 2002:a50:8f44:: with SMTP id 62mr21934799edy.3.1597777087449;
 Tue, 18 Aug 2020 11:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200811092722.2450-1-haris.iqbal@cloud.ionos.com>
In-Reply-To: <20200811092722.2450-1-haris.iqbal@cloud.ionos.com>
From:   Haris Iqbal <haris.iqbal@cloud.ionos.com>
Date:   Wed, 19 Aug 2020 00:27:56 +0530
Message-ID: <CAJpMwygSD2mjdK2zpzkMLQOvXvy-=M8nv+wGot4gD4YMACQgag@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs-srv: Replace device_register with
 device_initialize and device_add
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        linux-rdma@vger.kernel.org,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 11, 2020 at 2:58 PM Md Haris Iqbal
<haris.iqbal@cloud.ionos.com> wrote:
>
> There are error cases when we will call free_srv before device kobject is
> initialized; in such cases calling put_device generates the following
> warning,
>
> kobject: '(null)' (000000009f5445ed): is not initialized, yet
> kobject_put() is being called.
>
> It was suggested by Jason to call device_initialize() sooner.
>
> So call device_initialize() only once when the server is allocated. If we
> end up calling put_srv() and subsequently free_srv(), our call to
> put_device() would result in deletion of the obj. Call device_add() later
> when we actually have a connection. Correspondingly, call device_del()
> instead of device_unregister() when srv->dev_ref falls to 0.
>
> Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 8 ++++----
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 1 +
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> index 3d7877534bcc..2f981ae97076 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> @@ -182,16 +182,16 @@ static int rtrs_srv_create_once_sysfs_root_folders(struct rtrs_srv_sess *sess)
>          * sysfs files are created
>          */
>         dev_set_uevent_suppress(&srv->dev, true);
> -       err = device_register(&srv->dev);
> +       err = device_add(&srv->dev);
>         if (err) {
> -               pr_err("device_register(): %d\n", err);
> +               pr_err("device_add(): %d\n", err);
>                 goto put;
>         }
>         srv->kobj_paths = kobject_create_and_add("paths", &srv->dev.kobj);
>         if (!srv->kobj_paths) {
>                 err = -ENOMEM;
>                 pr_err("kobject_create_and_add(): %d\n", err);
> -               device_unregister(&srv->dev);
> +               device_del(&srv->dev);
>                 goto unlock;
>         }
>         dev_set_uevent_suppress(&srv->dev, false);
> @@ -216,7 +216,7 @@ rtrs_srv_destroy_once_sysfs_root_folders(struct rtrs_srv_sess *sess)
>                 kobject_del(srv->kobj_paths);
>                 kobject_put(srv->kobj_paths);
>                 mutex_unlock(&srv->paths_mutex);
> -               device_unregister(&srv->dev);
> +               device_del(&srv->dev);
>         } else {
>                 mutex_unlock(&srv->paths_mutex);
>         }
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index a219bd1bdbc2..b61a18e57aeb 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -1336,6 +1336,7 @@ static struct rtrs_srv *__alloc_srv(struct rtrs_srv_ctx *ctx,
>         uuid_copy(&srv->paths_uuid, paths_uuid);
>         srv->queue_depth = sess_queue_depth;
>         srv->ctx = ctx;
> +       device_initialize(&srv->dev);
>
>         srv->chunks = kcalloc(srv->queue_depth, sizeof(*srv->chunks),
>                               GFP_KERNEL);
> --
> 2.25.1
>
Ping! Hi Jason, can you take this in your queue.

-- 

Regards
-Haris
