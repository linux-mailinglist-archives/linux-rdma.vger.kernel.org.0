Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26220199242
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2020 11:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbgCaJ35 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Mar 2020 05:29:57 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:32934 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730216AbgCaJ35 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Mar 2020 05:29:57 -0400
Received: by mail-io1-f67.google.com with SMTP id o127so20990843iof.0
        for <linux-rdma@vger.kernel.org>; Tue, 31 Mar 2020 02:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e9TC9Dvq+NxHGmVjcxml98fEBNVdqGYWIzldJgXCRdc=;
        b=L4AdER7p0yZLutfy4JSvfuKwUGwUmZY2JV3er/hjSVcru+yO8m3Egcr096hguEw12Q
         kG15HJ6d7JqhzwOT0tw9DIIxCvpEixVwn39C6k1HAEHhp8mFv7YN4eFVcemYszFPOUpU
         0rWazWw5V3HmcarKda3nQN6I4XsioPeTiqg57pMMIAcFwnWSfcOHOBqy3ZytnVWE678H
         nFeH2A0KlPu7tzGNqIkVftUouawcRYHYxkWsBXOWXqU97hqUZ+hjlT5IZhxvEqlNIKZ7
         b6jCOfNNnknKTfNXNUAlTT7a5oH9CMUi9pem8iaFF2MLcog5D5nVH68T2Jz7sTNqfM5G
         djfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e9TC9Dvq+NxHGmVjcxml98fEBNVdqGYWIzldJgXCRdc=;
        b=aVlJyp0l4JatzUFz4BV02GXXTz+cfjpiF0qlu6uwK+cfmn0uAYTXaOH5zELR8AJlEK
         XM0Tpo3r9ZbYQpdKTOoGjtrZ4fF4uZ8IWJCpdtnG/3KAZhOjtJV71/9My9v1G73o1x3v
         gzXeuaYLjaZ1wbcQ963oRtV9CTfodKndTX73zDQU0WQnFgHswCzuvVcGp4XYdEsjPNfz
         t5T1rj2SyAH0W12TeRWCkQpTBjom2jrqIKH5/Dh4HB12P1Uzj+UhrgkxG0DC50KxDcuG
         P5qoL3Eo9j3k+o/nd71JgU0K3kwzP5iUVtdpFkHSbJfQzClLjLMVeiabmzNG/VAwqdwS
         xuYA==
X-Gm-Message-State: ANhLgQ0uyLd/Kf1MpU4W9/+9bSKIHyM3vqRPOs7sg4h30FLFzycjsH9n
        H3KFpfci5eya47h2fiOrKWpNG9ey6dhHFgvnUGew7w==
X-Google-Smtp-Source: ADFU+vtWWlZdtpSbBkN5OF1s68dy0E68ycIqrABToueXo4BBTpuuADtHMSmrlQ5bG4CgB6gHmAHmcls73EBg9Oeub2A=
X-Received: by 2002:a6b:b24d:: with SMTP id b74mr14544159iof.49.1585646996530;
 Tue, 31 Mar 2020 02:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-22-jinpu.wang@cloud.ionos.com> <ba7c258f-a169-f2d5-3d62-62a7d09908a4@acm.org>
In-Reply-To: <ba7c258f-a169-f2d5-3d62-62a7d09908a4@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 31 Mar 2020 11:29:45 +0200
Message-ID: <CAMGffE=4LNom-aWJhogqjgD+mHPp1_B9g=rEzHzdr=x9Zy6vAw@mail.gmail.com>
Subject: Re: [PATCH v11 21/26] block/rnbd: server: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 28, 2020 at 6:41 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-03-20 05:16, Jack Wang wrote:
> > +static int __read_mostly port_nr = RTRS_PORT;
>
> Would uint16_t be sufficient for this kernel module parameter?
yes, u16 is enough.
>
> Is this kernel module parameter used anywhere in the hot path? If not,
> should __read_mostly perhaps be left out?
not in hot path, __read_mostly can be removed.
>
> > +module_param_named(port_nr, port_nr, int, 0444);
> > +MODULE_PARM_DESC(port_nr,
> > +              "The port number server is listening on (default: "
>                                 ^^^
>                                 the?
right!
> > +              __stringify(RTRS_PORT)")");
> > +
> > +#define DEFAULT_DEV_SEARCH_PATH "/"
>
> > +static void destroy_device(struct rnbd_srv_dev *dev)
> > +{
> > +     WARN(!list_empty(&dev->sess_dev_list),
> > +          "Device %s is being destroyed but still in use!\n",
> > +          dev->id);
>
> Has it been considered to change WARN() into WARN_ONCE()?
ok.
>
> > +static int rnbd_srv_rdma_ev(struct rtrs_srv *rtrs, void *priv,
> > +                          struct rtrs_srv_op *id, int dir,
> > +                          void *data, size_t datalen, const void *usr,
> > +                          size_t usrlen)
> > +{
> > +     struct rnbd_srv_session *srv_sess = priv;
> > +     const struct rnbd_msg_hdr *hdr = usr;
> > +     int ret = 0;
> > +     u16 type;
> > +
> > +     if (WARN_ON(!srv_sess))
> > +             return -ENODEV;
>
> Same question here: how about using WARN_ON_ONCE() instead of WARN_ON()?
ok.
>
> > +static char *rnbd_srv_get_full_path(struct rnbd_srv_session *srv_sess,
> > +                                  const char *dev_name)
> > +{
> > +     char *full_path;
> > +     char *a, *b;
> > +
> > +     full_path = kmalloc(PATH_MAX, GFP_KERNEL);
> > +     if (!full_path)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     /*
> > +      * Replace %SESSNAME% with a real session name in order to
> > +      * create device namespace.
> > +      */
> > +     a = strnstr(dev_search_path, "%SESSNAME%", sizeof(dev_search_path));
> > +     if (a) {
> > +             int len = a - dev_search_path;
> > +
> > +             len = snprintf(full_path, PATH_MAX, "%.*s/%s/%s", len,
> > +                            dev_search_path, srv_sess->sessname, dev_name);
> > +             if (len >= PATH_MAX) {
> > +                     pr_err("Tooooo looong path: %s, %s, %s\n",
> > +                            dev_search_path, srv_sess->sessname, dev_name);
> > +                     kfree(full_path);
> > +                     return ERR_PTR(-EINVAL);
> > +             }
> > +     } else {
> > +             snprintf(full_path, PATH_MAX, "%s/%s",
> > +                      dev_search_path, dev_name);
> > +     }
>
> Has it been considered to use kasprintf() instead of kmalloc() + snprintf()?
will convert to kasprintf.
>
> Otherwise this patch looks fine to me.
>
> Thanks,
>
> Bart.
Thanks Bart!
