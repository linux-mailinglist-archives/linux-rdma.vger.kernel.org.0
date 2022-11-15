Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522DC629543
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Nov 2022 11:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiKOKHL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 05:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238031AbiKOKCN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 05:02:13 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFC324081
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 02:02:09 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id k19so16845141lji.2
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 02:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C0EgT8fvXMqFpAxiyCQcK4MFV2UeFC3dwMXCSxIlMOI=;
        b=b+UrnjuaxEWHeepSdOuedmDWHDYJwr3g/j6527X6Rv2GdSLKEbWbxybkw73VedPvid
         cM+EwRvdnCul5mzMwIQRfaTI0Bif4f85tXsF+RRAHVh+a93DquC8tAtA5acbY7wndpFY
         FseV1XIwr7HU2QBO0ZAITKqaL+ZD7+vjSMMsCjTAAMZVjBjLH0RcsME2/OIG7iQPXaCg
         ytw6RrUz+cukdFZITnEaWL+5cFSo3JysaHgPoLLVDLdEgultaBuSXajdjP7/c5RSOFEK
         GEkxhqWtfh51lShXr5xwNbM5lwpsGXMq5A9pdmUxvOZZ1DKx81g81FN57lMtTMhNKyf2
         Dujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0EgT8fvXMqFpAxiyCQcK4MFV2UeFC3dwMXCSxIlMOI=;
        b=mbM+0lz/YBGxfqRH5mgF/fFepoJ1PT0imYqLKHOsxSiKpgu2cVAOl3EeAc2TYZloX9
         /2dPXZVMUw4BHwRIk8oIiDnqe8NZb/C/BjAwHetwbh2/XFMT31ebr1wM6+DLy1Fnovcb
         hL8AcAXNdm+tm+6GVhPOQycfSGKXG872IuHIHg2WLICVmnU4lNlSoVMxdvu1wWlDbNSz
         /flBAh3BMS+gLiQVIkCxLR3VcKi6GuVSMwe7Xo8ZZe+zWSTUU5uUfZ3h1HxzPBoeE/vx
         j8ScLYgcji6iC9oIKZCLw6sOvdOvYIpW7bzkfNFT0G8TNjkKVzcnDNbgpech6K8KEJcA
         wong==
X-Gm-Message-State: ANoB5pl+7adBIWScwo05vAQSJIdREU9Zb2t/Tnc/h0gDUq6KMO2Ivw5d
        Cv/Kod6nG68jIIIHQzTpsIdWHHD9EHcsD2zuRLAxAw==
X-Google-Smtp-Source: AA0mqf6YH4HmLKdiZ5Mh48pEPEhrnGtVK4q+b7LHbMGm3EXDfPWryOVZqXwlOWAI7/PLCmx8yZ0KS1gdjwdFZuop4YY=
X-Received: by 2002:a2e:b0f0:0:b0:278:a1bc:ad26 with SMTP id
 h16-20020a2eb0f0000000b00278a1bcad26mr5863103ljl.235.1668506528002; Tue, 15
 Nov 2022 02:02:08 -0800 (PST)
MIME-Version: 1.0
References: <20221113010823.6436-1-guoqing.jiang@linux.dev>
 <20221113010823.6436-11-guoqing.jiang@linux.dev> <CAJpMwyjkeYj6eVMG+htwHkFVRP6m-tGpyFEaUeSCkXO3u6MqzA@mail.gmail.com>
In-Reply-To: <CAJpMwyjkeYj6eVMG+htwHkFVRP6m-tGpyFEaUeSCkXO3u6MqzA@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 15 Nov 2022 11:01:56 +0100
Message-ID: <CAMGffEmPd4XjjgATYTNHt0HPCp=B9KNFChzmkh9YLp_S=hzDEw@mail.gmail.com>
Subject: Re: [PATCH RFC 10/12] RDMA/rtrs-srv: Remove paths_num
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 15, 2022 at 10:49 AM Haris Iqbal <haris.iqbal@ionos.com> wrote:
>
> On Sun, Nov 13, 2022 at 2:08 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
> >
> > The paths_num is only increased by rtrs_rdma_connect -> __alloc_path
> > which is only one time thing, so is the decreasing of it given only
> > rtrs_srv_close_work -> del_path_from_srv, which means paths_num should
> > always be 1.
>
> It would actually go up to the number of paths a session will have in
> a multipath setup. It is the exact counter part of paths_num in the
> structure rtrs_clt_sess. But whereas on the client side, the number is
> used to access the path list for making decisions in multipathing IO
> like round-robin, etc. On the server side, I don't see the use of it.
> Maybe just for sanity checks.
>
> @Jinpu Any thoughts?
Yes, the idea is RTRS can have many paths, not only one, and you can
add/remove path at run time,
so not a one time thing.
>
> >
> > Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 --------
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.h | 1 -
> >  2 files changed, 9 deletions(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > index e2ea09a8def7..400cf8ae34a3 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > @@ -1437,8 +1437,6 @@ static void __add_path_to_srv(struct rtrs_srv_sess *srv,
> >                               struct rtrs_srv_path *srv_path)
> >  {
> >         list_add_tail(&srv_path->s.entry, &srv->paths_list);
> > -       srv->paths_num++;
> > -       WARN_ON(srv->paths_num >= MAX_PATHS_NUM);
> >  }
> >
> >  static void del_path_from_srv(struct rtrs_srv_path *srv_path)
> > @@ -1450,8 +1448,6 @@ static void del_path_from_srv(struct rtrs_srv_path *srv_path)
> >
> >         mutex_lock(&srv->paths_mutex);
> >         list_del(&srv_path->s.entry);
> > -       WARN_ON(!srv->paths_num);
> > -       srv->paths_num--;
> >         mutex_unlock(&srv->paths_mutex);
> >  }
> >
> > @@ -1719,10 +1715,6 @@ static struct rtrs_srv_path *__alloc_path(struct rtrs_srv_sess *srv,
> >         char str[NAME_MAX];
> >         struct rtrs_addr path;
> >
> > -       if (srv->paths_num >= MAX_PATHS_NUM) {
> > -               err = -ECONNRESET;
> > -               goto err;
> > -       }
> >         if (__is_path_w_addr_exists(srv, &cm_id->route.addr)) {
> >                 err = -EEXIST;
> >                 pr_err("Path with same addr exists\n");
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > index eccc432b0715..8e4fcb578f49 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > @@ -100,7 +100,6 @@ struct rtrs_srv_sess {
> >         struct list_head        paths_list;
> >         int                     paths_up;
> >         struct mutex            paths_ev_mutex;
> > -       size_t                  paths_num;
> >         struct mutex            paths_mutex;
> >         uuid_t                  paths_uuid;
> >         refcount_t              refcount;
> > --
> > 2.31.1
> >
