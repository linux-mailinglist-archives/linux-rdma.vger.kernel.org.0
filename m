Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA2125EE0A
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Sep 2020 16:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgIFOEl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 6 Sep 2020 10:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbgIFODV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 6 Sep 2020 10:03:21 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913BEC061573
        for <linux-rdma@vger.kernel.org>; Sun,  6 Sep 2020 07:03:11 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id nw23so14478979ejb.4
        for <linux-rdma@vger.kernel.org>; Sun, 06 Sep 2020 07:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wFCv1J9xAIzcUJ7g6aXFElfYUIZ+i3MU4qCK/C4X1kY=;
        b=SNq9Cwnhc6gK8RFA4a2LtggwgTihP5CwjbGFqHL0DPkgmWsb3tdymFtAC/OnZS3w6D
         2bWdzOE5K8jWLJQS6afdjBwLbLMDZq4lMp3Cj4lIRD3nGszxKKjMXANISgffYBA1hKs2
         PwAh6wxw+nMU2qAtvy2wIaLbkop7lZ6K8fjXWSM6Zvk0UAU3yYGiTXIlV2wlort2ov/P
         XllInCajDWWF1UriFtUFGSz0qM0vWKmWD0r1yLC8buUqtzzur1VKvCpDVqs9js23t2Gw
         5Y/B5S/B8doE9Ec/WYIs4yxhV98VG+3sRxdyuMxba21nOCR6M5/ogfSPXhi4ZixX1/gD
         VjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFCv1J9xAIzcUJ7g6aXFElfYUIZ+i3MU4qCK/C4X1kY=;
        b=DixerNeuFnXQzYOVh6ihkr3i+wnhPkz3xyMJ1n/pV3i02kEt853sLh5qsbIDQffjNa
         2NJXS4Jtmb+TTOnb/aEXI4ISxXNLKBx9qhOCvhVHAYP5SiigREP46jpOquYVRmKB8QpF
         30mO3NBtK3Txjck348HUfYLFDoGFrFyCbuCh3o2DqsTKq/ZqZ8lun/pQv+v+m4KHIwdS
         TqCEbNFRuNNoYf3xF6blks7i0kvraAiMjlm/VTaHXf0nbu6md5lkr+xA+Fzv9Vh12Nwv
         I/1k6XEFZWJKv56cUyKV+aI4wcYqMceVh/X5lt0B+QPUy7OFBoEgiQXgbhpgO4bbkI23
         nJLg==
X-Gm-Message-State: AOAM530fcj/9eBhTf9RwPnVBUXS+qwu/pWjwioP7CZRO/42m8u8v+H53
        DEWwFRbACD5t/jjPiiaO2dIMFkQQLoI2BMyQJzLf6g==
X-Google-Smtp-Source: ABdhPJz+MEYFmvpxWIZjzifyihDbM+2qI8B1H1AYuE+FTH9MpbfVZHT7Ppo5jqodyD+IgHtLc42uYqr2YS3YsGyks9U=
X-Received: by 2002:a17:906:1185:: with SMTP id n5mr11215963eja.495.1599400989524;
 Sun, 06 Sep 2020 07:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200904133038.335680-1-haris.iqbal@cloud.ionos.com> <20200906074647.GF55261@unreal>
In-Reply-To: <20200906074647.GF55261@unreal>
From:   Haris Iqbal <haris.iqbal@cloud.ionos.com>
Date:   Sun, 6 Sep 2020 19:32:58 +0530
Message-ID: <CAJpMwyhd3=JbMpdfzrkRaVpGEzz68tNNR69YCeCEixZ8szdZAg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs-srv: Set .release function for rtrs srv device
 during device init
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 6, 2020 at 1:16 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Sep 04, 2020 at 07:00:38PM +0530, Md Haris Iqbal wrote:
> > The device .release function was not being set during the device
> > initialization. This was leading to the below warning, in error cases when
> > put_srv was called before device_add was called.
> >
> > Warning:
> >
> > Device '(null)' does not have a release() function, it is broken and must
> > be fixed. See Documentation/kobject.txt.
> >
> > So, set the device .release function during device initialization in the
> > __alloc_srv() function.
> >
> > Fixes: baa5b28b7a474 ("RDMA/rtrs-srv: Replace device_register with..")
>
> Please don't truncate Fixes line, many of us rely on full line for automation.

Sure. Didn't know that. Will send the updated patch. Thanks.

>
> Thanks
>
> > Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 8 --------
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 8 ++++++++
> >  2 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> > index 2f981ae97076..cf6a2be61695 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> > @@ -152,13 +152,6 @@ static struct attribute_group rtrs_srv_stats_attr_group = {
> >       .attrs = rtrs_srv_stats_attrs,
> >  };
> >
> > -static void rtrs_srv_dev_release(struct device *dev)
> > -{
> > -     struct rtrs_srv *srv = container_of(dev, struct rtrs_srv, dev);
> > -
> > -     kfree(srv);
> > -}
> > -
> >  static int rtrs_srv_create_once_sysfs_root_folders(struct rtrs_srv_sess *sess)
> >  {
> >       struct rtrs_srv *srv = sess->srv;
> > @@ -172,7 +165,6 @@ static int rtrs_srv_create_once_sysfs_root_folders(struct rtrs_srv_sess *sess)
> >               goto unlock;
> >       }
> >       srv->dev.class = rtrs_dev_class;
> > -     srv->dev.release = rtrs_srv_dev_release;
> >       err = dev_set_name(&srv->dev, "%s", sess->s.sessname);
> >       if (err)
> >               goto unlock;
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > index b61a18e57aeb..28f6414dfa3d 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > @@ -1319,6 +1319,13 @@ static int rtrs_srv_get_next_cq_vector(struct rtrs_srv_sess *sess)
> >       return sess->cur_cq_vector;
> >  }
> >
> > +static void rtrs_srv_dev_release(struct device *dev)
> > +{
> > +     struct rtrs_srv *srv = container_of(dev, struct rtrs_srv, dev);
> > +
> > +     kfree(srv);
> > +}
> > +
> >  static struct rtrs_srv *__alloc_srv(struct rtrs_srv_ctx *ctx,
> >                                    const uuid_t *paths_uuid)
> >  {
> > @@ -1337,6 +1344,7 @@ static struct rtrs_srv *__alloc_srv(struct rtrs_srv_ctx *ctx,
> >       srv->queue_depth = sess_queue_depth;
> >       srv->ctx = ctx;
> >       device_initialize(&srv->dev);
> > +     srv->dev.release = rtrs_srv_dev_release;
> >
> >       srv->chunks = kcalloc(srv->queue_depth, sizeof(*srv->chunks),
> >                             GFP_KERNEL);
> > --
> > 2.25.1
> >



-- 

Regards
-Haris
