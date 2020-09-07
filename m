Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C582926037B
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 19:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgIGRt6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 13:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbgIGMMa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Sep 2020 08:12:30 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9680C061573
        for <linux-rdma@vger.kernel.org>; Mon,  7 Sep 2020 05:12:29 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l63so12548557edl.9
        for <linux-rdma@vger.kernel.org>; Mon, 07 Sep 2020 05:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g3ZVUSosgZVpeMmvxWlF0u7Ck5S6TOjhXB1rjnYeLU8=;
        b=N3eQ/229mSuWN4qwId9MoHRg6uabupn3DDRwx8c9jbvOrjMp2cVpu3kSR+2+e1vH7X
         t7FR6aadLj+k7qXz2Q3EyivuqW5BUSzHXkEqFx98teuBr40Lb9ypOaSZr6HM9M1x8zl+
         IdGhxCBaOCFIa/0ZciZSJINz6/6JZ7WFCgPMRPg3YX2GLoGFGB/gSIMDXSrJ+OB+wLhk
         D34HvwaN5tZA+VDeWno+i0J76f7a0PPCRMLJbnZNavQHa8Y1b7SYZH0+JBQjtrbtjBWP
         TMuKjD30tPMYtoQ39mDTTDUMA3NYLEx31VJPgCyS09OVHRo9fM0jlh6dzw0pf3TfX7Cw
         x2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g3ZVUSosgZVpeMmvxWlF0u7Ck5S6TOjhXB1rjnYeLU8=;
        b=lVeGAIGjCEqSW7++s+h5aI0G6AspPgiQDiXknKR4lEuLHXo1QQJRJoMWXN7Qx/LcFM
         be7UJetM87kPShl0/1XCX/mb7ICWFu9pIHXmw4Vw2THMffkR8AH6waSFQvU9TPxVz6zZ
         i9BuuSRLblguwajdmmZoM2V/NTyg2xmIRI4o3PmD+b1fd9z8zAeRbCJAVX9YiMfWJVbS
         pLxuw3bh0X+bGTf2G+YVExFyD1ytiyP9gFajiVy9JB+jxf4LM2rOM+7u9n6rxnn8pMF1
         zm69ogpqc3E65Jfz9uw2oPzqOVO2HwEKrRwf8kOY3YoKZPQkgpAvEIxUZ8mq/EneF9qh
         ELsA==
X-Gm-Message-State: AOAM533U2pAecijGaHe5ZK2H13iAbNLQSEG6VHE20cUFdJ/6X3snQJB4
        JB1ascJwglOh+ZvVr4qibRZWE8tkatram9IUjXsHTg==
X-Google-Smtp-Source: ABdhPJx6hR0ptqb6gm0fQPm2Ea2af6od03M1fzCTHi4onQVfdOrP9WenfqU4QySwz9oLxosJB5D4bXjTLaThK7LpeiM=
X-Received: by 2002:aa7:cb83:: with SMTP id r3mr20833884edt.35.1599480748346;
 Mon, 07 Sep 2020 05:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200907102216.104041-1-haris.iqbal@cloud.ionos.com>
In-Reply-To: <20200907102216.104041-1-haris.iqbal@cloud.ionos.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 7 Sep 2020 14:12:15 +0200
Message-ID: <CAMGffEm=J5bXNhw2ae2oYf5bNtK=keFK2YFkD0VrBZVEXU7XRw@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/rtrs-srv: Set .release function for rtrs srv
 device during device init
To:     Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 7, 2020 at 12:22 PM Md Haris Iqbal
<haris.iqbal@cloud.ionos.com> wrote:
>
> The device .release function was not being set during the device
> initialization. This was leading to the below warning, in error cases when
> put_srv was called before device_add was called.
>
> Warning:
>
> Device '(null)' does not have a release() function, it is broken and must
> be fixed. See Documentation/kobject.txt.
>
> So, set the device .release function during device initialization in the
> __alloc_srv() function.
>
> Fixes: baa5b28b7a47 ("RDMA/rtrs-srv: Replace device_register with device_initialize and device_add")
> Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Thanks,
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
> Change in v2:
>         Use the complete Fixes line
>
>  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 8 --------
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 8 ++++++++
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> index 2f981ae97076..cf6a2be61695 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> @@ -152,13 +152,6 @@ static struct attribute_group rtrs_srv_stats_attr_group = {
>         .attrs = rtrs_srv_stats_attrs,
>  };
>
> -static void rtrs_srv_dev_release(struct device *dev)
> -{
> -       struct rtrs_srv *srv = container_of(dev, struct rtrs_srv, dev);
> -
> -       kfree(srv);
> -}
> -
>  static int rtrs_srv_create_once_sysfs_root_folders(struct rtrs_srv_sess *sess)
>  {
>         struct rtrs_srv *srv = sess->srv;
> @@ -172,7 +165,6 @@ static int rtrs_srv_create_once_sysfs_root_folders(struct rtrs_srv_sess *sess)
>                 goto unlock;
>         }
>         srv->dev.class = rtrs_dev_class;
> -       srv->dev.release = rtrs_srv_dev_release;
>         err = dev_set_name(&srv->dev, "%s", sess->s.sessname);
>         if (err)
>                 goto unlock;
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index b61a18e57aeb..28f6414dfa3d 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -1319,6 +1319,13 @@ static int rtrs_srv_get_next_cq_vector(struct rtrs_srv_sess *sess)
>         return sess->cur_cq_vector;
>  }
>
> +static void rtrs_srv_dev_release(struct device *dev)
> +{
> +       struct rtrs_srv *srv = container_of(dev, struct rtrs_srv, dev);
> +
> +       kfree(srv);
> +}
> +
>  static struct rtrs_srv *__alloc_srv(struct rtrs_srv_ctx *ctx,
>                                      const uuid_t *paths_uuid)
>  {
> @@ -1337,6 +1344,7 @@ static struct rtrs_srv *__alloc_srv(struct rtrs_srv_ctx *ctx,
>         srv->queue_depth = sess_queue_depth;
>         srv->ctx = ctx;
>         device_initialize(&srv->dev);
> +       srv->dev.release = rtrs_srv_dev_release;
>
>         srv->chunks = kcalloc(srv->queue_depth, sizeof(*srv->chunks),
>                               GFP_KERNEL);
> --
> 2.25.1
>
