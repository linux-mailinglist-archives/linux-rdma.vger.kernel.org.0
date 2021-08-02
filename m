Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CF23DDB15
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 16:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbhHBObY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 10:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbhHBObY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Aug 2021 10:31:24 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A457C06175F
        for <linux-rdma@vger.kernel.org>; Mon,  2 Aug 2021 07:31:14 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id q2so24191206ljq.5
        for <linux-rdma@vger.kernel.org>; Mon, 02 Aug 2021 07:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XwDZ/iGU4xBTiETru+bI8rQ5dNWiOGMzY1GmXDOJ3h8=;
        b=LCkZ+kRjUSoBY2zGCgnfpendpmi5V6eyrnBTfseA2LumRdWFAUGZ3Urq20OSYRtvgZ
         rKw13vKPOh4ii7xEPhOO42SthY6ma68A9k9dCw4jTrhIXBVL9MLjgOYlD2HXSlgimE2j
         zzpcFPvVXUIOcq+wsFOHuLBnkhM4slmXBw5+IzhaisezwQY2rrqw+81jeVLlJoqN1Ffm
         h0ULXwkKQ7vvQKny3yTeLM3k2HB32xouy7KJRb+mj7otLqzBxQ0kjzRy5n918U0XBFef
         CCOlb1QLcAzo4BO+WXEG6DrUyu+PLclcZJQVGiJ4K2Vc9SNsiJDns1TnT30pj2FQ+Hw7
         E2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XwDZ/iGU4xBTiETru+bI8rQ5dNWiOGMzY1GmXDOJ3h8=;
        b=s/fKycEO8bBVzGEWb2Ri2JpJowS6QnUpEfa2LrVayGHKgIzao72w9dZrUVTMFmDw6S
         zDhenHJtgsQAPzfpzCMdrsdhrnG2uCMOaR2K1UZa0I9p77M/bnYpNHFWek768X60apGZ
         84w6zSMHfBt5kq4KbgNXj2h4JTsMiIjErpp5Dr5sACYiRUvlz7prTX1QpDYq7DcWBsbk
         TkVuGzrlTs5mE85g/Ag0zWCg9NZP1qxz3aUeHGkS3e363KuqKy62+VUdQLzw5T22ou8U
         IZrpocJGFh9FbEpa1AUQ5rVzvh1uaHJVBtpRYhJ7jP+uZlvBtEDDmetSnpFSFr3lH9Ak
         B8Cw==
X-Gm-Message-State: AOAM530M/8VCtUx1dt29NP0SjM5eJAVyNprNIAozSf4V7P4eI+MxemPl
        EzZfCz+QCg3/gntUmZIaIg78UYSLtnAott+saIwc3g==
X-Google-Smtp-Source: ABdhPJzSBJmPRm/bdQqLDX5Onm5HA5409rn8GmE9F1i8DSi0SE4JaaAhsrKOEXHJyBMB+QwnLAPwmYPWPfZe3rLbLhY=
X-Received: by 2002:a2e:9f17:: with SMTP id u23mr11953270ljk.489.1627914672674;
 Mon, 02 Aug 2021 07:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210730131832.118865-1-jinpu.wang@ionos.com> <20210730131832.118865-10-jinpu.wang@ionos.com>
 <YQee8091rXaXU4vL@unreal>
In-Reply-To: <YQee8091rXaXU4vL@unreal>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 2 Aug 2021 16:31:01 +0200
Message-ID: <CAJpMwyj6SjO+yNsA9uMDZP1Cu2gUfXHAeRGgaGf46xbxDBrk5g@mail.gmail.com>
Subject: Re: [PATCH for-next 09/10] RDMA/rtrs: Add support to disable an IB
 port on the storage side
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpu.wang@ionos.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 2, 2021 at 9:30 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Jul 30, 2021 at 03:18:31PM +0200, Jack Wang wrote:
> > From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> >
> > This commit adds support to reject connection on a specific IB port which
> > can be specified in the added sysfs entry for the rtrs-server module.
> >
> > Example,
> >
> > $ echo "mlx4_0 1" > /sys/class/rtrs-server/ctl/disable_port
> >
> > When a connection request is received on the above IB port, rtrs_srv
> > rejects the connection and notifies the client to disable reconnection
> > attempts. A manual reconnect has to be triggerred in such a case.
> >
> > A manual reconnect can be triggered by doing the following,
> >
> > echo 1 > /sys/class/rtrs-client/blya/paths/<select-path>/reconnect
> >
> > Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 10 ++++
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 82 +++++++++++++++++++++++++-
> >  2 files changed, 90 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > index 5cce727abca0..21001818e607 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > @@ -1898,6 +1898,7 @@ static int rtrs_rdma_conn_rejected(struct rtrs_clt_con *con,
> >                                   struct rdma_cm_event *ev)
> >  {
> >       struct rtrs_sess *s = con->c.sess;
> > +     struct rtrs_clt_sess *sess = to_clt_sess(s);
> >       const struct rtrs_msg_conn_rsp *msg;
> >       const char *rej_msg;
> >       int status, errno;
> > @@ -1916,6 +1917,15 @@ static int rtrs_rdma_conn_rejected(struct rtrs_clt_con *con,
> >                       rtrs_err(s,
> >                                 "Connect rejected: status %d (%s), rtrs errno %d\n",
> >                                 status, rej_msg, errno);
> > +
> > +             if (errno == -ENETDOWN) {
> > +                     /*
> > +                      * Stop reconnection attempts
> > +                      */
> > +                     sess->reconnect_attempts = -1;
> > +                     rtrs_err(s,
> > +                             "Disabling auto-reconnect. Trigger a manual reconnect after issue is resolved\n");
> > +             }
> >       } else {
> >               rtrs_err(s,
> >                         "Connect rejected but with malformed message: status %d (%s)\n",
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > index cc65cffdc65a..90d833041ccf 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > @@ -32,7 +32,9 @@ MODULE_LICENSE("GPL");
> >  static struct rtrs_rdma_dev_pd dev_pd;
> >  static mempool_t *chunk_pool;
> >  struct class *rtrs_dev_class;
> > +static struct device *rtrs_dev;
> >  static struct rtrs_srv_ib_ctx ib_ctx;
> > +static char disabled_port[NAME_MAX];
> >
> >  static int __read_mostly max_chunk_size = DEFAULT_MAX_CHUNK_SIZE;
> >  static int __read_mostly sess_queue_depth = DEFAULT_SESS_QUEUE_DEPTH;
> > @@ -1826,6 +1828,20 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
> >       u16 recon_cnt;
> >       int err = -ECONNRESET;
> >
> > +     if (strnlen(disabled_port, NAME_MAX) > 0) {
> > +             char ib_device[NAME_MAX];
> > +
> > +             snprintf(ib_device, NAME_MAX, "%s %u", cm_id->device->name, cm_id->port_num);
> > +             if (strncmp(disabled_port, ib_device, NAME_MAX) == 0) {
> > +                     /*
> > +                      * Reject connection attempt on disabled port
> > +                      */
> > +                     pr_err("Error: Connection request on a disabled port");
> > +                     err = -ENETDOWN;
> > +                     goto reject_w_err;
> > +             }
> > +     }
> > +
> >       if (len < sizeof(*msg)) {
> >               pr_err("Invalid RTRS connection request\n");
> >               goto reject_w_err;
> > @@ -2242,6 +2258,56 @@ static int check_module_params(void)
> >       return 0;
> >  }
> >
> > +static ssize_t disable_port_show(struct kobject *kobj,
> > +                              struct kobj_attribute *attr,
> > +                              char *page)
> > +{
> > +     return sysfs_emit(page, "%s\n", disabled_port);
> > +}
> > +
> > +static ssize_t disable_port_store(struct kobject *kobj,
> > +                               struct kobj_attribute *attr,
> > +                               const char *buf, size_t count)
> > +{
> > +     int ret, len;
> > +
> > +     if (count > 1 && strnlen(disabled_port, NAME_MAX) > 0) {
> > +             pr_err("A disabled port already exists.\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret = strscpy(disabled_port, buf, NAME_MAX);
> > +     if (ret == -E2BIG) {
> > +             pr_err("String too big.\n");
> > +             disabled_port[0] = '\0';
> > +             return ret;
> > +     }
> > +
> > +     len = strlen(disabled_port);
> > +     if (len > 0 && disabled_port[len-1] == '\n')
>
> All the "\n" checks in rtrs sysfs looks like cargo cult. You don't need
> them.

Thanks. Will change and resend.

>
> And maybe Jason thinks differently, but I don't feel comfortable with
> such new sysfs file at all.
>
> Thanks
