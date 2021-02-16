Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24AC31C718
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Feb 2021 09:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhBPIDB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Feb 2021 03:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhBPIC6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Feb 2021 03:02:58 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5D5C061574
        for <linux-rdma@vger.kernel.org>; Tue, 16 Feb 2021 00:02:15 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id w1so5945247ejk.6
        for <linux-rdma@vger.kernel.org>; Tue, 16 Feb 2021 00:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LRZIoMO4EEe9NsTSv1W4VCGgjsuY0f4egMYjkaR/yzM=;
        b=ZL1Df+Xb9c/gPV3QasFxZ4IdqnS3RQ3FO5DMc9sFve0F9SPRtAp7n8LJNGBGzjHpdW
         nY4vs8+DeQaUYV5oPU/98Cvs9SyQyiF0Mym5F9+s/DLLVBljENZuLZsPiNhZcwPRK58u
         C4NwTsSYQzXwJhvIvoVLX93RV6a+BwQiJUCZjbVEzZlLBg3j1vxrJDuCJzMiCs/L43Ct
         R8STD/RAZrQa2p3m2NP6+FPCizt4lmw1vQq7OIdCHjrqJnGdSbUpNFZi+C+e3bp7qLVZ
         1fR3or6k29MIaa+QyfREwc6q+Ku5TZdy7G1vyotP5bC1HTrReJN59GOkQ9VLIk7o/8vn
         fibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LRZIoMO4EEe9NsTSv1W4VCGgjsuY0f4egMYjkaR/yzM=;
        b=TAb4VKj4ot6s/aGRhFh1x7oX4MvOLdqEOdqdQsxTKhdqTvh52ghuSGEaeFjPKyDXKg
         cXVNCj8voynqEtyJdGLqL9nEYZoZJSH+VEwcg5NUMtGmicGdNSPt6EiQ8f7R40Aa8hHg
         Z7hGKKyl8Wmc5+pCQWJh3irhBQluvnCeToO/Q3tuHQjH1cvTqHO6PCx9TXzXnTCE7rw/
         D+SYRlVEWcVxp0bNRFFxYql4H1g0sFa+L66jK2zuqP+XTklcQ1VlAhvM+F19mScQmAoJ
         +4y3MmTvxNPnym5pB+IEBQA263e+8N5/SMGp8zFS7GpaCc/u02eQ/MhzTvA74ZEU+7Za
         p8fw==
X-Gm-Message-State: AOAM533jSytw+eBV+mWm2usxG5PT1OLpCTY026jhJEiT7GtTsakeds9q
        WKVKdOt8Qofut72XU5wsmngsNQydpEFZqy/J+UKmFA==
X-Google-Smtp-Source: ABdhPJylm1n3lSOnV9uMPfrseaMJbNZ6LB774BdfB3vfbmhfWs3cLrdoJYU1dJdFPdtyc8m8gUHGrh6DWT1Bl42o8UM=
X-Received: by 2002:a17:906:d93:: with SMTP id m19mr18970827eji.212.1613462534330;
 Tue, 16 Feb 2021 00:02:14 -0800 (PST)
MIME-Version: 1.0
References: <20210216073958.13957-1-jinpu.wang@cloud.ionos.com> <YCt5Nv+czQtYqQL9@unreal>
In-Reply-To: <YCt5Nv+czQtYqQL9@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 16 Feb 2021 09:02:03 +0100
Message-ID: <CAMGffEmKu4mfWMLUaJeOrkV526rh=FSSns0zfbDvwii33HLAhw@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs-srv: suppress warnings passing zero to 'PTR_ERR'
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Leon,
On Tue, Feb 16, 2021 at 8:50 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, Feb 16, 2021 at 08:39:58AM +0100, Jack Wang wrote:
> > smatch warnings:
> > drivers/infiniband/ulp/rtrs/rtrs-srv.c:1805 rtrs_rdma_connect() warn: passing zero to 'PTR_ERR'
> >
> > Smatch seems confused by the refcount_read condition, so just
> > treat it seperately.
> >
> > Fixes: f0751419d3a1 ("RDMA/rtrs: Only allow addition of path to an already established session")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > index eb17c3a08810..2f6d665bea90 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > @@ -1799,12 +1799,16 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
> >       }
> >       recon_cnt = le16_to_cpu(msg->recon_cnt);
> >       srv = get_or_create_srv(ctx, &msg->paths_uuid, msg->first_conn);
> > +     if (IS_ERR(srv)) {
> > +             err = PTR_ERR(srv);
> > +             goto reject_w_err;
> > +     }
> >       /*
> >        * "refcount == 0" happens if a previous thread calls get_or_create_srv
> >        * allocate srv, but chunks of srv are not allocated yet.
> >        */
> > -     if (IS_ERR(srv) || refcount_read(&srv->refcount) == 0) {
> > -             err = PTR_ERR(srv);
> > +     if (refcount_read(&srv->refcount) == 0) {
>
> I would say that "list_add(&srv->ctx_list, &ctx->srv_list);" line in the
> get_or_create_srv() is performed too early,
Moving list_add down to the end was the initial code, but we noticed
the memory allocation could take quite
some time when system under memory pressure, hence we  changed it in
d715ff8acbd5 ("RDMA/rtrs-srv: Don't guard the whole __alloc_srv with
srv_mutex")

Thanks for the comment.
