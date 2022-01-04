Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EF0483E9B
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 09:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiADI7y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 03:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiADI7y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jan 2022 03:59:54 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF294C061761
        for <linux-rdma@vger.kernel.org>; Tue,  4 Jan 2022 00:59:53 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id f5so145744451edq.6
        for <linux-rdma@vger.kernel.org>; Tue, 04 Jan 2022 00:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6f6GdnqVp+fpviuWY1rqKV1J+lr9pdDZMkcf5F/Ftw=;
        b=bWTbZHLlf/RB5yIC5PzRiSRLke+t4+ntZMd0RhAei1o5atPU38clIG9r+3ny1aGPms
         ITx0lHX/41G8sjNG6vF5qh9o9kDPbrjny72L8s7gX20nkqjYmLGF3A1MXyZYSLbGG2b1
         nNQfZdRiwQ2gn6qlMUProuwtBoGINDmqD2RWWgmSxR19P4XuF0bd34HSMAWAKVH0quuI
         NyW/ro5cEhMfhttGWg8cYgcUUwAPol4z1YlB6jXGKpWxc/gCNEChgkPpvXYj32GudQ+h
         DhdHhe9hALlOJKDPaspBlWqpI6ETZ4Wd5/mLlINEYPhDRxB8xReqYHFQnJumW9AWaIoo
         2o8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6f6GdnqVp+fpviuWY1rqKV1J+lr9pdDZMkcf5F/Ftw=;
        b=DhxUTkWyoz9dTndLX9LS6KWUKVLQpzAdNeSl+Tax6WD9mLWW1yiGll9Sz8pjbN7tcN
         Mn3nZaQmvdg5OhvYwBmjM702t4+cm/FHXye6IwKI+qt8v4I/Fz49KWgN3xCfbqcMG+fw
         OdIGFVEDyvzOvJ/Nlv+zKbPbKCb0c8wA4B/0B8VR0/RPyhzCFx0rjQEQe/9Gm9S712mP
         BsoDHWwngtlI7/o0oObDgur7n0FF+4x1R5vhPce9+c5RDBVz7bvc2agqE2MuDVXReu0F
         ROm/z8etwBiSgVQRbgUHM2WGACs9rMhxASvKIuX4l0tGVncaeEGhG3Ow6DAje70eN8/l
         m/dA==
X-Gm-Message-State: AOAM531QroBEmLDYEs+GR5DWAqyiuz5seJab6JlLywZFCoRGwNBwzHBL
        plmbaI05oc7e4tnMPW/ev4qzejsswLekjrL+3/APPw==
X-Google-Smtp-Source: ABdhPJyVxQbZhvg566N3d4NIPHOT4wHpqt4z5UfyS261Q7OyZUbo0lolvMeJaj2XCQxGBg6QDvlK7b055XcCXApFogo=
X-Received: by 2002:a05:6402:490:: with SMTP id k16mr48071526edv.99.1641286792250;
 Tue, 04 Jan 2022 00:59:52 -0800 (PST)
MIME-Version: 1.0
References: <20220103133339.9483-1-jinpu.wang@ionos.com> <20220103133339.9483-5-jinpu.wang@ionos.com>
 <21f09494-6b5b-087e-f312-0d4b1faf5f44@linux.dev>
In-Reply-To: <21f09494-6b5b-087e-f312-0d4b1faf5f44@linux.dev>
From:   Vaishali Thakkar <vaishali.thakkar@ionos.com>
Date:   Tue, 4 Jan 2022 09:59:41 +0100
Message-ID: <CAKw44h5cj8ABSr21LQ1NM+8i1Mv=8dY2q1Uxwh3c3Bhky+WFLg@mail.gmail.com>
Subject: Re: [PATCHv2 for-next 4/5] RDMA/rtrs-srv: Rename rtrs_srv to rtrs_srv_sess
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     Jack Wang <jinpu.wang@ionos.com>, linux-rdma@vger.kernel.org,
        bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 4, 2022 at 8:00 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
>
>
> On 1/3/22 9:33 PM, Jack Wang wrote:
> > diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
> > index 98ddc31eb408..e5604bce123a 100644
> > --- a/drivers/block/rnbd/rnbd-srv.h
> > +++ b/drivers/block/rnbd/rnbd-srv.h
> > @@ -20,7 +20,7 @@
> >   struct rnbd_srv_session {
> >       /* Entry inside global sess_list */
> >       struct list_head        list;
> > -     struct rtrs_srv         *rtrs;
> > +     struct rtrs_srv_sess    *rtrs;
>
> How about change it to srv_sess?

I've kept the variable names as it is if it didn't include incorrect
naming. e.g. naming path variables with sess/session. Struct
names in the last 2 patches are changed just to make a clear
distinction. Doing variable name changes will probably require
a lot more changes in the files and I'm not sure if it's worth the
effort.

> >       char                    sessname[NAME_MAX];
> >       int                     queue_depth;
> >       struct bio_set          sess_bio_set;
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> > index 628ef20ebf0c..b94ae12c2795 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> > @@ -154,7 +154,7 @@ static const struct attribute_group rtrs_srv_stats_attr_group = {
> >
> >   static int rtrs_srv_create_once_sysfs_root_folders(struct rtrs_srv_path *srv_path)
> >   {
> > -     struct rtrs_srv *srv = srv_path->srv;
> > +     struct rtrs_srv_sess *srv = srv_path->srv;
>
> It is srv here, maybe srv_sess too, FYI.
>
> [ ... ]
>
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > index 6119e6708080..6292e87f6afd 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > @@ -73,7 +73,7 @@ struct rtrs_srv_mr {
> >
> >   struct rtrs_srv_path {
> >       struct rtrs_path        s;
> > -     struct rtrs_srv *srv;
> > +     struct rtrs_srv_sess    *srv;
>
> Ditto.
>
> Thanks,
> Guoqing
