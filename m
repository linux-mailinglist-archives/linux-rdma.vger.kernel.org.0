Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24E61B8B9D
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2019 09:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfITHgN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Sep 2019 03:36:13 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37008 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730493AbfITHgN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Sep 2019 03:36:13 -0400
Received: by mail-io1-f65.google.com with SMTP id b19so14052418iob.4
        for <linux-rdma@vger.kernel.org>; Fri, 20 Sep 2019 00:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3wAoPIOEegYjxcdNSfiqPOaQG+lDfmCcLciq1efzk9c=;
        b=bFIMF5Xxou9zC73vV6CeI36YR42/4UpMsw1WA1bqGEr2DzojGS5gha3rWICOp+BULn
         tQsnRB8aa/6JmfZFVoweXERA9eCz2uzHQfz8AIU/Fd+KdvQWzy4SbqXcHzSwvi3HXx/B
         ZKfhOgMKkKvZkTfST61e3bElPO+NQdejexXdbbt+wrpNYzJDJTpVWGO6HtG1l9m17oOh
         plsP9BJFNPFWRUfrUqyg7vNy66sfRcvDJvj0PyXlHcb8d2xJ+wKAmF07x0FnY0XqRFE1
         owuFVvcfoJzeWlcFE0rxhp+JTxqiHs58Aj67752CAWElhTaF3XGYXVzgjC8qR+DbYQns
         DBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3wAoPIOEegYjxcdNSfiqPOaQG+lDfmCcLciq1efzk9c=;
        b=PpotGMgKFm0LHvVwTUdRfGjRk5MKy/oY2REIEOz0QHsq2bLNZKLb3zFmrKeHLGifSz
         1uxFduB+NjBJaXfPRVsJ2w52kEIQtLp3KKfshMW3jY6NAG1WA52egjBuOX77L9M2SRKs
         xfkwF4oCMN9JWH8tsiYxaI/MpDeWJlfRJ3ia9wuB0JKgpbXjOWSyCNJjMUZ/jxyASIqr
         KDwqKrHpJoufdg3gzBbmRyL7bVnP5buaBOBfhgX9jkKCA9bK5AISeI1mN4LK02C9EVGt
         FEtu43u879i1b9piThaXESXfeI5DfvIqeDIQCPVPSsofhjNpIVloWrTRkupweEX8GABr
         U9Cg==
X-Gm-Message-State: APjAAAWDgRVrhJ9ciQybzf4phQOJ+13VRuF6dnhPvbxwAK3DHCfSTFLM
        QO+oDnVYKxXvgD1I+fZy+Xn2o+i7SpiDC3EFf2LgvNNGFg==
X-Google-Smtp-Source: APXvYqzs9Bqr0H5HXT290r740Ho2q1hoQMKYtZwzfrW68n1hzf/XO+qSjvFaJwQI6B4wRWqlDw52r9/PilqW0My8ivI=
X-Received: by 2002:a02:e47:: with SMTP id 68mr18155308jae.126.1568964971206;
 Fri, 20 Sep 2019 00:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-21-jinpuwang@gmail.com>
 <5ceebb9c-b7ae-8e0c-6f07-d83e878e23d0@acm.org>
In-Reply-To: <5ceebb9c-b7ae-8e0c-6f07-d83e878e23d0@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Fri, 20 Sep 2019 09:36:00 +0200
Message-ID: <CAHg0Huw8Sk-ORjDaFDsTiL00nfsHru20MpNqGmWrCa_pSWuQSQ@mail.gmail.com>
Subject: Re: [PATCH v4 20/25] ibnbd: server: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 18, 2019 at 7:41 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 6/20/19 8:03 AM, Jack Wang wrote:
> > +#undef pr_fmt
> > +#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
>
> Same comment here as for a previous patch - please do not include line
> number information in pr_fmt().

Will drop it, thanks.

> > +MODULE_AUTHOR("ibnbd@profitbricks.com");
> > +MODULE_VERSION(IBNBD_VER_STRING);
> > +MODULE_DESCRIPTION("InfiniBand Network Block Device Server");
> > +MODULE_LICENSE("GPL");
>
> Please remove the version number (MODULE_VERSION()).

OK.

> > +static char dev_search_path[PATH_MAX] = DEFAULT_DEV_SEARCH_PATH;
>
> Please change dev_search_path[] into a dynamically allocated string to
> avoid a hard-coded length limit.

OK.

> > +     if (dup[strlen(dup) - 1] == '\n')
> > +             dup[strlen(dup) - 1] = '\0';
>
> Can this be changed into a call to strim()?

A directory name can start and end with spaces, for example this
works: mkdir "     x      "

> > +static void ibnbd_endio(void *priv, int error)
> > +{
> > +     struct ibnbd_io_private *ibnbd_priv = priv;
> > +     struct ibnbd_srv_sess_dev *sess_dev = ibnbd_priv->sess_dev;
> > +
> > +     ibnbd_put_sess_dev(sess_dev);
> > +
> > +     ibtrs_srv_resp_rdma(ibnbd_priv->id, error);
> > +
> > +     kfree(priv);
> > +}
>
> Since ibtrs_srv_resp_rdma() starts an RDMA WRITE without waiting for the
> write completion, shouldn't the session reference be retained until the
> completion for that RDMA WRITE has been received? In other words, is
> there a risk with the current approach that the buffer that is being
> transferred to the client will be freed before the RDMA WRITE has finished?

ibtrs-srv.c is keeping track of inflights. When closing session it
first marks the queue as closing, so that no new write requests would
be posted, when IBNBD calls ibtrs_srv_resp_rdma():
1831         if (ibtrs_srv_change_state_get_old(sess, IBTRS_SRV_CLOSING,
1832                                            &old_state)
Then ibtrs-srv schedules the ibtrs_srv_close_work, that drains the
queue and then waits for all inflights to return from IBNBD:
...
1274                 ib_drain_qp(con->c.qp);
1275         }
1276         /* Wait for all inflights */
1277         ibtrs_srv_wait_ops_ids(sess);
....
Only then the resources can be deallocated:
1282         unmap_cont_bufs(sess);
1283         ibtrs_srv_free_ops_ids(sess);

>
> > +static struct ibnbd_srv_sess_dev *
> > +ibnbd_get_sess_dev(int dev_id, struct ibnbd_srv_session *srv_sess)
> > +{
> > +     struct ibnbd_srv_sess_dev *sess_dev;
> > +     int ret = 0;
> > +
> > +     read_lock(&srv_sess->index_lock);
> > +     sess_dev = idr_find(&srv_sess->index_idr, dev_id);
> > +     if (likely(sess_dev))
> > +             ret = kref_get_unless_zero(&sess_dev->kref);
> > +     read_unlock(&srv_sess->index_lock);
> > +
> > +     if (unlikely(!sess_dev || !ret))
> > +             return ERR_PTR(-ENXIO);
> > +
> > +     return sess_dev;
> > +}
>
> Something that is not important: isn't the sess_dev check superfluous in
> the if-statement just above the return statement? If ret == 1, does that
> imply that sess_dev != 0 ?

We want to have found the device (sess_dev != NULL) and we want to
have been able to take reference to it (ret != 0)... You are right, if
ret != 0 then sess_dev can't be NULL.

> Has it been considered to return -ENODEV instead of -ENXIO if no device
> is found?

The backend block device, i.e. /dev/nullb0, is still there and might
even be still exported over other session(s). So we thought "No such
device or address" is more appropriate.

>
> > +static int create_sess(struct ibtrs_srv *ibtrs)
> > +{
>  > [ ... ]
> > +     strlcpy(srv_sess->sessname, sessname, sizeof(srv_sess->sessname));
>
> Please change the session name into a dynamically allocated string such
> that strdup() can be used instead of strlcpy().

OK.

>
> > +static int process_msg_open(struct ibtrs_srv *ibtrs,
> > +                         struct ibnbd_srv_session *srv_sess,
> > +                         const void *msg, size_t len,
> > +                         void *data, size_t datalen);
> > +
> > +static int process_msg_sess_info(struct ibtrs_srv *ibtrs,
> > +                              struct ibnbd_srv_session *srv_sess,
> > +                              const void *msg, size_t len,
> > +                              void *data, size_t datalen);
>
> Can the code be reordered such that these forward declarations can be
> dropped?

Will try to.

>
> > +static struct ibnbd_srv_sess_dev *
> > +ibnbd_srv_create_set_sess_dev(struct ibnbd_srv_session *srv_sess,
> > +                           const struct ibnbd_msg_open *open_msg,
> > +                           struct ibnbd_dev *ibnbd_dev, fmode_t open_flags,
> > +                           struct ibnbd_srv_dev *srv_dev)
> > +{
> > +     struct ibnbd_srv_sess_dev *sdev = ibnbd_sess_dev_alloc(srv_sess);
> > +
> > +     if (IS_ERR(sdev))
> > +             return sdev;
> > +
> > +     kref_init(&sdev->kref);
> > +
> > +     strlcpy(sdev->pathname, open_msg->dev_name, sizeof(sdev->pathname));
>
> Can the path name be changed into a dynamically allocated string?

Probably we could just do strdup() and free it afterwards...

>
> > +static char *ibnbd_srv_get_full_path(struct ibnbd_srv_session *srv_sess,
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

I didn't know there is kasprintf()... Looks it would fit here.

> > +static int process_msg_sess_info(struct ibtrs_srv *ibtrs,
> > +                              struct ibnbd_srv_session *srv_sess,
> > +                              const void *msg, size_t len,
> > +                              void *data, size_t datalen)
> > +{
> > +     const struct ibnbd_msg_sess_info *sess_info_msg = msg;
> > +     struct ibnbd_msg_sess_info_rsp *rsp = data;
> > +
> > +     srv_sess->ver = min_t(u8, sess_info_msg->ver, IBNBD_PROTO_VER_MAJOR);
> > +     pr_debug("Session %s using protocol version %d (client version: %d,"
> > +              " server version: %d)\n", srv_sess->sessname,
> > +              srv_sess->ver, sess_info_msg->ver, IBNBD_PROTO_VER_MAJOR);
>
> Has this patch been verified with checkpatch? I think checkpatch
> recommends not to split literal strings.

Yes it does complain about our splitted strings. But it's either
splitted string or line over 80 chars or "Avoid line continuations in
quoted strings" if we use backslash on previous line. I don't know how
to avoid all three of them.

> > +/**
> > + * find_srv_sess_dev() - a dev is already opened by this name
> > + *
> > + * Return struct ibnbd_srv_sess_dev if srv_sess already opened the dev_name
> > + * NULL if the session didn't open the device yet.
> > + */
> > +static struct ibnbd_srv_sess_dev *
> > +find_srv_sess_dev(struct ibnbd_srv_session *srv_sess, const char *dev_name)
> > +{
> > +     struct ibnbd_srv_sess_dev *sess_dev;
> > +
> > +     if (list_empty(&srv_sess->sess_dev_list))
> > +             return NULL;
> > +
> > +     list_for_each_entry(sess_dev, &srv_sess->sess_dev_list, sess_list)
> > +             if (!strcmp(sess_dev->pathname, dev_name))
> > +                     return sess_dev;
> > +
> > +     return NULL;
> > +}
>
> Is explicit the list_empty() check really necessary? Would the behavior
> of this function change if that check is left out?
Will drop the check and fix if necessary if doesn't work without
(which I hope it does), thanks.

> Has the posted code been compiled with W=1? I'm asking this because the
> documentation of the function arguments is missing from the kernel-doc
> header. I expect that a warning will be reported if this code is
> compiled with W=1.
Yes it does, I didn't know about W=1. Will fix those warnings, thank you!

>
> Thanks,
>
> Bart.
