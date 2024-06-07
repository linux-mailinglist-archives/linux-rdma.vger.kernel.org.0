Return-Path: <linux-rdma+bounces-2987-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0A090002E
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 12:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1286F1F249AB
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 10:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9BD155328;
	Fri,  7 Jun 2024 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="imiXffGC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECCB158214
	for <linux-rdma@vger.kernel.org>; Fri,  7 Jun 2024 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717754519; cv=none; b=e1uHGJAYVXV2yoKEHnkQF5YzAR5KyGE3rOxOANLnHinM27tPCBrY2XwR8vbYvma0kJ9RM+Q45yeBazx7Ft5G5UdbM2Y6iITYAE7EU4wSo1nFImHf5kG/TNAQT1gFZQgNEk8jufmiySX6tMQBdH5aMyawZcPzeXWrmKNQPLlic3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717754519; c=relaxed/simple;
	bh=8kLASKfZLAchbfvM5yXWjkQYtN/xmIQT10a1h2r/FTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ag+6ghENGwXMswx+YeuBRLpPprvzEV5STcbd4YAuQuicKTcr3tQGCWyrUG7CREHjprysY4DF6XNQLiAuMZFIRXccb1MHkXDB5yUp6u0RSCJUkYyXYTiveREntEEbcehwytbiScwD32bDQhWimew1b/3mZpZBKvYxCD+h71NJi8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=imiXffGC; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eab0bc74cdso19733931fa.3
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2024 03:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1717754513; x=1718359313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMNWK2XsVOhMr4LzMM9LpNrh2IhCDcTVBzz5QX4COTo=;
        b=imiXffGCWb1XqxEqfpOyyGGFNU6iIt++W7YFxHqimNux8jS4bD/gaVaoI7Iu5VcDWn
         vw+46JmpfjQcHmVsSchYk4ZnXWyf+1tlBTLjljJJinO2xS5uSHCP4FZDPw9pwrhYS/wQ
         902fSg9eu2o2PK0zpDKSBaLpm7W9pi5FOxKpj2gZHGxj8TT82D3tFWA2XdEdWXHR39WR
         4CLeV4jyMyHhlN+Wxjdn0E7YM79T/h2Or7iik/iws9clfqPQvKQ3SumxbElXC52Nw65E
         rxIJauipc7zER0DdpfhbHvdi5wk+XaUde4O+vQgi86nTYSeN1jov1O+MPQZHVZlOF4mD
         pKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717754513; x=1718359313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMNWK2XsVOhMr4LzMM9LpNrh2IhCDcTVBzz5QX4COTo=;
        b=WAMMVQhwDwj+7a8ZMkWKjPkhzkZxN5lpER3+z94o3JXTssMwY6XLxFEhby/5WGL93W
         93rTLQX6sgfSUTDxXBRJa7p9/EcbkKWf+4MmAMd0Uev5QKNt7LArc2TSdwzn7d78d2P6
         l966n0xDUda9YJ8q2XfYkyxTWkTRKEJJ4QeKxOcoKe+BitlvCh9TeiiXnli9vQ1etb5K
         U6S3G98TmYq04I8p+6h39pf+O1Q/iekhY9o19Tb/rq7oA5yYC8okcnWRui9S3p//tXyo
         tPh9bLMLfPJrnRXMaWLEFTRB6xvuZ7CU76K9d6EyZDO6QQqUWxbETp1cxsrEqt9m59vh
         cfhg==
X-Forwarded-Encrypted: i=1; AJvYcCVI+BPSHciJWKrUDu+By2gSey3cqF2ML0ENPciNKe9Mx6tkxS5LLnj12+JkF2Js7Wt47giz6g4sjc0R5gybS02g/kEJ5vnhrQKl1w==
X-Gm-Message-State: AOJu0YzpLrl+5cj9DXDwc9MmnYvQmhFQ4ZgrfgYXXfFo5u+hgS7fsWO3
	48euacuna3nsYJ9KsnZ2iO69yvmB4EsRdExLPBY9RnRsVORb3X72T7cKocglcdYQlGOe6+Pw5ae
	XCoivG7HE841jPEUVj7ycQ0dYMkTpFNoYPVnq4A==
X-Google-Smtp-Source: AGHT+IGr37VAsMKtAkAlMCsayHErrBPl6vL1/q1ZFyeCNDSgdQohTsvPPtimC0VJ91mnjJkJ7lsdNjnbg+gkygcOaBA=
X-Received: by 2002:a2e:91c6:0:b0:2e6:f2e1:32a6 with SMTP id
 38308e7fff4ca-2eadce38050mr13286501fa.27.1717754513562; Fri, 07 Jun 2024
 03:01:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <1717503252-51884-4-git-send-email-arei.gonglei@huawei.com>
 <CAJpMwyh38bHxM7JEjt+w4Y4yOiKDpGnsL6WUy7rL40=4KB0+mg@mail.gmail.com> <4f76b5e737584bfda08bf141d1667b9e@huawei.com>
In-Reply-To: <4f76b5e737584bfda08bf141d1667b9e@huawei.com>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Fri, 7 Jun 2024 12:01:42 +0200
Message-ID: <CAJpMwyhjoofH8i9QdS_H8tNDyU2EAL+_xtHsNZMWhhbyxChG3Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] io/channel-rdma: support working in coroutine
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peterx@redhat.com" <peterx@redhat.com>, 
	"yu.zhang@ionos.com" <yu.zhang@ionos.com>, "mgalaxy@akamai.com" <mgalaxy@akamai.com>, 
	"elmar.gerdes@ionos.com" <elmar.gerdes@ionos.com>, zhengchuan <zhengchuan@huawei.com>, 
	"berrange@redhat.com" <berrange@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, 
	"lizhijian@fujitsu.com" <lizhijian@fujitsu.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"mst@redhat.com" <mst@redhat.com>, Xiexiangyou <xiexiangyou@huawei.com>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "lixiao (H)" <lixiao91@huawei.com>, 
	"jinpu.wang@ionos.com" <jinpu.wang@ionos.com>, Wangjialin <wangjialin23@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 10:45=E2=80=AFAM Gonglei (Arei) <arei.gonglei@huawei=
.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Haris Iqbal [mailto:haris.iqbal@ionos.com]
> > Sent: Thursday, June 6, 2024 9:35 PM
> > To: Gonglei (Arei) <arei.gonglei@huawei.com>
> > Cc: qemu-devel@nongnu.org; peterx@redhat.com; yu.zhang@ionos.com;
> > mgalaxy@akamai.com; elmar.gerdes@ionos.com; zhengchuan
> > <zhengchuan@huawei.com>; berrange@redhat.com; armbru@redhat.com;
> > lizhijian@fujitsu.com; pbonzini@redhat.com; mst@redhat.com; Xiexiangyou
> > <xiexiangyou@huawei.com>; linux-rdma@vger.kernel.org; lixiao (H)
> > <lixiao91@huawei.com>; jinpu.wang@ionos.com; Wangjialin
> > <wangjialin23@huawei.com>
> > Subject: Re: [PATCH 3/6] io/channel-rdma: support working in coroutine
> >
> > On Tue, Jun 4, 2024 at 2:14=E2=80=AFPM Gonglei <arei.gonglei@huawei.com=
> wrote:
> > >
> > > From: Jialin Wang <wangjialin23@huawei.com>
> > >
> > > It is not feasible to obtain RDMA completion queue notifications
> > > through poll/ppoll on the rsocket fd. Therefore, we create a thread
> > > named rpoller for each rsocket fd and two eventfds: pollin_eventfd an=
d
> > > pollout_eventfd.
> > >
> > > When using io_create_watch or io_set_aio_fd_handler waits for POLLIN
> > > or POLLOUT events, it will actually poll/ppoll on the pollin_eventfd
> > > and pollout_eventfd instead of the rsocket fd.
> > >
> > > The rpoller rpoll() on the rsocket fd to receive POLLIN and POLLOUT
> > > events.
> > > When a POLLIN event occurs, the rpoller write the pollin_eventfd, and
> > > then poll/ppoll will return the POLLIN event.
> > > When a POLLOUT event occurs, the rpoller read the pollout_eventfd, an=
d
> > > then poll/ppoll will return the POLLOUT event.
> > >
> > > For a non-blocking rsocket fd, if rread/rwrite returns EAGAIN, it wil=
l
> > > read/write the pollin/pollout_eventfd, preventing poll/ppoll from
> > > returning POLLIN/POLLOUT events.
> > >
> > > Known limitations:
> > >
> > >   For a blocking rsocket fd, if we use io_create_watch to wait for
> > >   POLLIN or POLLOUT events, since the rsocket fd is blocking, we
> > >   cannot determine when it is not ready to read/write as we can with
> > >   non-blocking fds. Therefore, when an event occurs, it will occurs
> > >   always, potentially leave the qemu hanging. So we need be cautious
> > >   to avoid hanging when using io_create_watch .
> > >
> > > Luckily, channel-rdma works well in coroutines :)
> > >
> > > Signed-off-by: Jialin Wang <wangjialin23@huawei.com>
> > > Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> > > ---
> > >  include/io/channel-rdma.h |  15 +-
> > >  io/channel-rdma.c         | 363
> > +++++++++++++++++++++++++++++++++++++-
> > >  2 files changed, 376 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/io/channel-rdma.h b/include/io/channel-rdma.h
> > > index 8cab2459e5..cb56127d76 100644
> > > --- a/include/io/channel-rdma.h
> > > +++ b/include/io/channel-rdma.h
> > > @@ -47,6 +47,18 @@ struct QIOChannelRDMA {
> > >      socklen_t localAddrLen;
> > >      struct sockaddr_storage remoteAddr;
> > >      socklen_t remoteAddrLen;
> > > +
> > > +    /* private */
> > > +
> > > +    /* qemu g_poll/ppoll() POLLIN event on it */
> > > +    int pollin_eventfd;
> > > +    /* qemu g_poll/ppoll() POLLOUT event on it */
> > > +    int pollout_eventfd;
> > > +
> > > +    /* the index in the rpoller's fds array */
> > > +    int index;
> > > +    /* rpoller will rpoll() rpoll_events on the rsocket fd */
> > > +    short int rpoll_events;
> > >  };
> > >
> > >  /**
> > > @@ -147,6 +159,7 @@ void
> > qio_channel_rdma_listen_async(QIOChannelRDMA *ioc, InetSocketAddress
> > *addr,
> > >   *
> > >   * Returns: the new client channel, or NULL on error
> > >   */
> > > -QIOChannelRDMA *qio_channel_rdma_accept(QIOChannelRDMA *ioc,
> > Error
> > > **errp);
> > > +QIOChannelRDMA *coroutine_mixed_fn
> > qio_channel_rdma_accept(QIOChannelRDMA *ioc,
> > > +
> > Error
> > > +**errp);
> > >
> > >  #endif /* QIO_CHANNEL_RDMA_H */
> > > diff --git a/io/channel-rdma.c b/io/channel-rdma.c index
> > > 92c362df52..9792add5cf 100644
> > > --- a/io/channel-rdma.c
> > > +++ b/io/channel-rdma.c
> > > @@ -23,10 +23,15 @@
> > >
> > >  #include "qemu/osdep.h"
> > >  #include "io/channel-rdma.h"
> > > +#include "io/channel-util.h"
> > > +#include "io/channel-watch.h"
> > >  #include "io/channel.h"
> > >  #include "qapi/clone-visitor.h"
> > >  #include "qapi/error.h"
> > >  #include "qapi/qapi-visit-sockets.h"
> > > +#include "qemu/atomic.h"
> > > +#include "qemu/error-report.h"
> > > +#include "qemu/thread.h"
> > >  #include "trace.h"
> > >  #include <errno.h>
> > >  #include <netdb.h>
> > > @@ -39,11 +44,274 @@
> > >  #include <sys/poll.h>
> > >  #include <unistd.h>
> > >
> > > +typedef enum {
> > > +    CLEAR_POLLIN,
> > > +    CLEAR_POLLOUT,
> > > +    SET_POLLIN,
> > > +    SET_POLLOUT,
> > > +} UpdateEvent;
> > > +
> > > +typedef enum {
> > > +    RP_CMD_ADD_IOC,
> > > +    RP_CMD_DEL_IOC,
> > > +    RP_CMD_UPDATE,
> > > +} RpollerCMD;
> > > +
> > > +typedef struct {
> > > +    RpollerCMD cmd;
> > > +    QIOChannelRDMA *rioc;
> > > +} RpollerMsg;
> > > +
> > > +/*
> > > + * rpoll() on the rsocket fd with rpoll_events, when POLLIN/POLLOUT
> > > +event
> > > + * occurs, it will write/read the pollin_eventfd/pollout_eventfd to
> > > +allow
> > > + * qemu g_poll/ppoll() get the POLLIN/POLLOUT event  */ static struc=
t
> > > +Rpoller {
> > > +    QemuThread thread;
> > > +    bool is_running;
> > > +    int sock[2];
> > > +    int count; /* the number of rsocket fds being rpoll() */
> > > +    int size; /* the size of fds/riocs */
> > > +    struct pollfd *fds;
> > > +    QIOChannelRDMA **riocs;
> > > +} rpoller;
> > > +
> > > +static void qio_channel_rdma_notify_rpoller(QIOChannelRDMA *rioc,
> > > +                                            RpollerCMD cmd) {
> > > +    RpollerMsg msg;
> > > +    int ret;
> > > +
> > > +    msg.cmd =3D cmd;
> > > +    msg.rioc =3D rioc;
> > > +
> > > +    ret =3D RETRY_ON_EINTR(write(rpoller.sock[0], &msg, sizeof msg))=
;
> > > +    if (ret !=3D sizeof msg) {
> > > +        error_report("%s: failed to send msg, errno: %d", __func__,
> > errno);
> > > +    }
> > > +}
> > > +
> > > +static void qio_channel_rdma_update_poll_event(QIOChannelRDMA *rioc,
> > > +                                               UpdateEvent
> > action,
> > > +                                               bool notify_rpoller)
> > {
> > > +    /* An eventfd with the value of ULLONG_MAX - 1 is readable but
> > unwritable */
> > > +    unsigned long long buf =3D ULLONG_MAX - 1;
> > > +
> > > +    switch (action) {
> > > +    /* only rpoller do SET_* action, to allow qemu ppoll() get the e=
vent */
> > > +    case SET_POLLIN:
> > > +        RETRY_ON_EINTR(write(rioc->pollin_eventfd, &buf, sizeof buf)=
);
> > > +        rioc->rpoll_events &=3D ~POLLIN;
> > > +        break;
> > > +    case SET_POLLOUT:
> > > +        RETRY_ON_EINTR(read(rioc->pollout_eventfd, &buf, sizeof buf)=
);
> > > +        rioc->rpoll_events &=3D ~POLLOUT;
> > > +        break;
> > > +
> > > +    /* the rsocket fd is not ready to rread/rwrite */
> > > +    case CLEAR_POLLIN:
> > > +        RETRY_ON_EINTR(read(rioc->pollin_eventfd, &buf, sizeof buf))=
;
> > > +        rioc->rpoll_events |=3D POLLIN;
> > > +        break;
> > > +    case CLEAR_POLLOUT:
> > > +        RETRY_ON_EINTR(write(rioc->pollout_eventfd, &buf, sizeof buf=
));
> > > +        rioc->rpoll_events |=3D POLLOUT;
> > > +        break;
> > > +    default:
> > > +        break;
> > > +    }
> > > +
> > > +    /* notify rpoller to rpoll() POLLIN/POLLOUT events */
> > > +    if (notify_rpoller) {
> > > +        qio_channel_rdma_notify_rpoller(rioc, RP_CMD_UPDATE);
> > > +    }
> > > +}
> > > +
> > > +static void qio_channel_rdma_rpoller_add_rioc(QIOChannelRDMA *rioc) =
{
> > > +    if (rioc->index !=3D -1) {
> > > +        error_report("%s: rioc already exsits", __func__);
> > > +        return;
> > > +    }
> > > +
> > > +    rioc->index =3D ++rpoller.count;
> > > +
> > > +    if (rpoller.count + 1 > rpoller.size) {
> > > +        rpoller.size *=3D 2;
> > > +        rpoller.fds =3D g_renew(struct pollfd, rpoller.fds, rpoller.=
size);
> > > +        rpoller.riocs =3D g_renew(QIOChannelRDMA *, rpoller.riocs,
> > rpoller.size);
> > > +    }
> > > +
> > > +    rpoller.fds[rioc->index].fd =3D rioc->fd;
> > > +    rpoller.fds[rioc->index].events =3D rioc->rpoll_events;
> >
> > The allotment of rioc fds and events to rpoller slots are sequential, b=
ut making
> > the deletion also sequentials means that the del_rioc needs to be calle=
d in the
> > exact opposite sequence as they were added (through add_rioc). Otherwis=
e we
> > leaves holes in between, and readditions might step on an already used =
slot.
> >
> > Does this setup make sure that the above restriction is satisfied, or a=
m I
> > missing something?
> >
>
> Actually, we use an O (1) algorithm for deletion, that is, each time we r=
eplace the array element to be deleted with the last one.
> Pls see qio_channel_rdma_rpoller_del_rioc():

Ah yes. I missed that. Thanks for the response.

>
>    rpoller.fds[rioc->index] =3D rpoller.fds[rpoller.count];
>
> > > +    rpoller.riocs[rioc->index] =3D rioc; }
> > > +
> > > +static void qio_channel_rdma_rpoller_del_rioc(QIOChannelRDMA *rioc) =
{
> > > +    if (rioc->index =3D=3D -1) {
> > > +        error_report("%s: rioc not exsits", __func__);
> > > +        return;
> > > +    }
> > > +
> > > +    rpoller.fds[rioc->index] =3D rpoller.fds[rpoller.count];
> >
> > Should this be rpoller.count-1?
> >
> No. the first element is the sockpairs' fd. Pls see qio_channel_rdma_rpol=
ler_start():
>
>    rpoller.fds[0].fd =3D rpoller.sock[1];
>    rpoller.fds[0].events =3D POLLIN;
>
>
> Regards,
> -Gonglei
>
> > > +    rpoller.riocs[rioc->index] =3D rpoller.riocs[rpoller.count];
> > > +    rpoller.riocs[rioc->index]->index =3D rioc->index;
> > > +    rpoller.count--;
> > > +
> > > +    close(rioc->pollin_eventfd);
> > > +    close(rioc->pollout_eventfd);
> > > +    rioc->index =3D -1;
> > > +    rioc->rpoll_events =3D 0;
> > > +}
> > > +
> > > +static void qio_channel_rdma_rpoller_update_ioc(QIOChannelRDMA *rioc=
)
> > > +{
> > > +    if (rioc->index =3D=3D -1) {
> > > +        error_report("%s: rioc not exsits", __func__);
> > > +        return;
> > > +    }
> > > +
> > > +    rpoller.fds[rioc->index].fd =3D rioc->fd;
> > > +    rpoller.fds[rioc->index].events =3D rioc->rpoll_events; }
> > > +
> > > +static void qio_channel_rdma_rpoller_process_msg(void)
> > > +{
> > > +    RpollerMsg msg;
> > > +    int ret;
> > > +
> > > +    ret =3D RETRY_ON_EINTR(read(rpoller.sock[1], &msg, sizeof msg));
> > > +    if (ret !=3D sizeof msg) {
> > > +        error_report("%s: rpoller failed to recv msg: %s", __func__,
> > > +                     strerror(errno));
> > > +        return;
> > > +    }
> > > +
> > > +    switch (msg.cmd) {
> > > +    case RP_CMD_ADD_IOC:
> > > +        qio_channel_rdma_rpoller_add_rioc(msg.rioc);
> > > +        break;
> > > +    case RP_CMD_DEL_IOC:
> > > +        qio_channel_rdma_rpoller_del_rioc(msg.rioc);
> > > +        break;
> > > +    case RP_CMD_UPDATE:
> > > +        qio_channel_rdma_rpoller_update_ioc(msg.rioc);
> > > +        break;
> > > +    default:
> > > +        break;
> > > +    }
> > > +}
> > > +
> > > +static void qio_channel_rdma_rpoller_cleanup(void)
> > > +{
> > > +    close(rpoller.sock[0]);
> > > +    close(rpoller.sock[1]);
> > > +    rpoller.sock[0] =3D -1;
> > > +    rpoller.sock[1] =3D -1;
> > > +    g_free(rpoller.fds);
> > > +    g_free(rpoller.riocs);
> > > +    rpoller.fds =3D NULL;
> > > +    rpoller.riocs =3D NULL;
> > > +    rpoller.count =3D 0;
> > > +    rpoller.size =3D 0;
> > > +    rpoller.is_running =3D false;
> > > +}
> > > +
> > > +static void *qio_channel_rdma_rpoller_thread(void *opaque) {
> > > +    int i, ret, error_events =3D POLLERR | POLLHUP | POLLNVAL;
> > > +
> > > +    do {
> > > +        ret =3D rpoll(rpoller.fds, rpoller.count + 1, -1);
> > > +        if (ret < 0 && errno !=3D -EINTR) {
> > > +            error_report("%s: rpoll() error: %s", __func__,
> > strerror(errno));
> > > +            break;
> > > +        }
> > > +
> > > +        for (i =3D 1; i <=3D rpoller.count; i++) {
> > > +            if (rpoller.fds[i].revents & (POLLIN | error_events)) {
> > > +                qio_channel_rdma_update_poll_event(rpoller.riocs[i],
> > SET_POLLIN,
> > > +                                                   false);
> > > +                rpoller.fds[i].events &=3D ~POLLIN;
> > > +            }
> > > +            if (rpoller.fds[i].revents & (POLLOUT | error_events)) {
> > > +                qio_channel_rdma_update_poll_event(rpoller.riocs[i],
> > > +
> > SET_POLLOUT, false);
> > > +                rpoller.fds[i].events &=3D ~POLLOUT;
> > > +            }
> > > +            /* ignore this fd */
> > > +            if (rpoller.fds[i].revents & (error_events)) {
> > > +                rpoller.fds[i].fd =3D -1;
> > > +            }
> > > +        }
> > > +
> > > +        if (rpoller.fds[0].revents) {
> > > +            qio_channel_rdma_rpoller_process_msg();
> > > +        }
> > > +    } while (rpoller.count >=3D 1);
> > > +
> > > +    qio_channel_rdma_rpoller_cleanup();
> > > +
> > > +    return NULL;
> > > +}
> > > +
> > > +static void qio_channel_rdma_rpoller_start(void)
> > > +{
> > > +    if (qatomic_xchg(&rpoller.is_running, true)) {
> > > +        return;
> > > +    }
> > > +
> > > +    if (qemu_socketpair(AF_UNIX, SOCK_STREAM, 0, rpoller.sock)) {
> > > +        rpoller.is_running =3D false;
> > > +        error_report("%s: failed to create socketpair %s", __func__,
> > > +                     strerror(errno));
> > > +        return;
> > > +    }
> > > +
> > > +    rpoller.count =3D 0;
> > > +    rpoller.size =3D 4;
> > > +    rpoller.fds =3D g_malloc0_n(rpoller.size, sizeof(struct pollfd))=
;
> > > +    rpoller.riocs =3D g_malloc0_n(rpoller.size, sizeof(QIOChannelRDM=
A *));
> > > +    rpoller.fds[0].fd =3D rpoller.sock[1];
> > > +    rpoller.fds[0].events =3D POLLIN;
> > > +
> > > +    qemu_thread_create(&rpoller.thread, "qio-channel-rdma-rpoller",
> > > +                       qio_channel_rdma_rpoller_thread, NULL,
> > > +                       QEMU_THREAD_JOINABLE); }
> > > +
> > > +static void qio_channel_rdma_add_rioc_to_rpoller(QIOChannelRDMA
> > > +*rioc) {
> > > +    int flags =3D EFD_CLOEXEC | EFD_NONBLOCK;
> > > +
> > > +    /*
> > > +     * A single eventfd is either readable or writable. A single eve=
ntfd
> > cannot
> > > +     * represent a state where it is neither readable nor writable. =
so use
> > two
> > > +     * eventfds here.
> > > +     */
> > > +    rioc->pollin_eventfd =3D eventfd(0, flags);
> > > +    rioc->pollout_eventfd =3D eventfd(0, flags);
> > > +    /* pollout_eventfd with the value 0, means writable, make it
> > unwritable */
> > > +    qio_channel_rdma_update_poll_event(rioc, CLEAR_POLLOUT, false);
> > > +
> > > +    /* tell the rpoller to rpoll() events on rioc->socketfd */
> > > +    rioc->rpoll_events =3D POLLIN | POLLOUT;
> > > +    qio_channel_rdma_notify_rpoller(rioc, RP_CMD_ADD_IOC); }
> > > +
> > >  QIOChannelRDMA *qio_channel_rdma_new(void)  {
> > >      QIOChannelRDMA *rioc;
> > >      QIOChannel *ioc;
> > >
> > > +    qio_channel_rdma_rpoller_start();
> > > +    if (!rpoller.is_running) {
> > > +        return NULL;
> > > +    }
> > > +
> > >      rioc =3D
> > QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
> > >      ioc =3D QIO_CHANNEL(rioc);
> > >      qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
> > @@
> > > -125,6 +393,8 @@ retry:
> > >          goto out;
> > >      }
> > >
> > > +    qio_channel_rdma_add_rioc_to_rpoller(rioc);
> > > +
> > >  out:
> > >      if (ret) {
> > >          trace_qio_channel_rdma_connect_fail(rioc);
> > > @@ -211,6 +481,8 @@ int
> > qio_channel_rdma_listen_sync(QIOChannelRDMA *rioc, InetSocketAddress
> > *addr,
> > >      qio_channel_set_feature(QIO_CHANNEL(rioc),
> > QIO_CHANNEL_FEATURE_LISTEN);
> > >      trace_qio_channel_rdma_listen_complete(rioc, fd);
> > >
> > > +    qio_channel_rdma_add_rioc_to_rpoller(rioc);
> > > +
> > >  out:
> > >      if (ret) {
> > >          trace_qio_channel_rdma_listen_fail(rioc);
> > > @@ -267,8 +539,10 @@ void
> > qio_channel_rdma_listen_async(QIOChannelRDMA *ioc, InetSocketAddress
> > *addr,
> > >                             qio_channel_listen_worker_free,
> > context);
> > > }
> > >
> > > -QIOChannelRDMA *qio_channel_rdma_accept(QIOChannelRDMA *rioc,
> > Error
> > > **errp)
> > > +QIOChannelRDMA *coroutine_mixed_fn
> > qio_channel_rdma_accept(QIOChannelRDMA *rioc,
> > > +
> > Error
> > > +**errp)
> > >  {
> > > +    QIOChannel *ioc =3D QIO_CHANNEL(rioc);
> > >      QIOChannelRDMA *cioc;
> > >
> > >      cioc =3D qio_channel_rdma_new();
> > > @@ -283,6 +557,17 @@ retry:
> > >          if (errno =3D=3D EINTR) {
> > >              goto retry;
> > >          }
> > > +        if (errno =3D=3D EAGAIN) {
> > > +            if (!(rioc->rpoll_events & POLLIN)) {
> > > +                qio_channel_rdma_update_poll_event(rioc,
> > CLEAR_POLLIN, true);
> > > +            }
> > > +            if (qemu_in_coroutine()) {
> > > +                qio_channel_yield(ioc, G_IO_IN);
> > > +            } else {
> > > +                qio_channel_wait(ioc, G_IO_IN);
> > > +            }
> > > +            goto retry;
> > > +        }
> > >          error_setg_errno(errp, errno, "Unable to accept connection")=
;
> > >          goto error;
> > >      }
> > > @@ -294,6 +579,8 @@ retry:
> > >          goto error;
> > >      }
> > >
> > > +    qio_channel_rdma_add_rioc_to_rpoller(cioc);
> > > +
> > >      trace_qio_channel_rdma_accept_complete(rioc, cioc, cioc->fd);
> > >      return cioc;
> > >
> > > @@ -307,6 +594,10 @@ static void qio_channel_rdma_init(Object *obj)  =
{
> > >      QIOChannelRDMA *ioc =3D QIO_CHANNEL_RDMA(obj);
> > >      ioc->fd =3D -1;
> > > +    ioc->pollin_eventfd =3D -1;
> > > +    ioc->pollout_eventfd =3D -1;
> > > +    ioc->index =3D -1;
> > > +    ioc->rpoll_events =3D 0;
> > >  }
> > >
> > >  static void qio_channel_rdma_finalize(Object *obj) @@ -314,6 +605,7
> > > @@ static void qio_channel_rdma_finalize(Object *obj)
> > >      QIOChannelRDMA *ioc =3D QIO_CHANNEL_RDMA(obj);
> > >
> > >      if (ioc->fd !=3D -1) {
> > > +        qio_channel_rdma_notify_rpoller(ioc, RP_CMD_DEL_IOC);
> > >          rclose(ioc->fd);
> > >          ioc->fd =3D -1;
> > >      }
> > > @@ -330,6 +622,12 @@ static ssize_t
> > qio_channel_rdma_readv(QIOChannel
> > > *ioc, const struct iovec *iov,
> > >  retry:
> > >      ret =3D rreadv(rioc->fd, iov, niov);
> > >      if (ret < 0) {
> > > +        if (errno =3D=3D EAGAIN) {
> > > +            if (!(rioc->rpoll_events & POLLIN)) {
> > > +                qio_channel_rdma_update_poll_event(rioc,
> > CLEAR_POLLIN, true);
> > > +            }
> > > +            return QIO_CHANNEL_ERR_BLOCK;
> > > +        }
> > >          if (errno =3D=3D EINTR) {
> > >              goto retry;
> > >          }
> > > @@ -351,6 +649,12 @@ static ssize_t
> > qio_channel_rdma_writev(QIOChannel
> > > *ioc, const struct iovec *iov,
> > >  retry:
> > >      ret =3D rwritev(rioc->fd, iov, niov);
> > >      if (ret <=3D 0) {
> > > +        if (errno =3D=3D EAGAIN) {
> > > +            if (!(rioc->rpoll_events & POLLOUT)) {
> > > +                qio_channel_rdma_update_poll_event(rioc,
> > CLEAR_POLLOUT, true);
> > > +            }
> > > +            return QIO_CHANNEL_ERR_BLOCK;
> > > +        }
> > >          if (errno =3D=3D EINTR) {
> > >              goto retry;
> > >          }
> > > @@ -361,6 +665,28 @@ retry:
> > >      return ret;
> > >  }
> > >
> > > +static int qio_channel_rdma_set_blocking(QIOChannel *ioc, bool enabl=
ed,
> > > +                                         Error **errp
> > G_GNUC_UNUSED)
> > > +{
> > > +    QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(ioc);
> > > +    int flags, ret;
> > > +
> > > +    flags =3D rfcntl(rioc->fd, F_GETFL);
> > > +    if (enabled) {
> > > +        flags &=3D ~O_NONBLOCK;
> > > +    } else {
> > > +        flags |=3D O_NONBLOCK;
> > > +    }
> > > +
> > > +    ret =3D rfcntl(rioc->fd, F_SETFL, flags);
> > > +    if (ret) {
> > > +        error_setg_errno(errp, errno,
> > > +                         "Unable to rfcntl rsocket fd with flags %d"=
,
> > flags);
> > > +    }
> > > +
> > > +    return ret;
> > > +}
> > > +
> > >  static void qio_channel_rdma_set_delay(QIOChannel *ioc, bool enabled=
)
> > > {
> > >      QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(ioc); @@ -374,6
> > +700,7 @@
> > > static int qio_channel_rdma_close(QIOChannel *ioc, Error **errp)
> > >      QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(ioc);
> > >
> > >      if (rioc->fd !=3D -1) {
> > > +        qio_channel_rdma_notify_rpoller(rioc, RP_CMD_DEL_IOC);
> > >          rclose(rioc->fd);
> > >          rioc->fd =3D -1;
> > >      }
> > > @@ -408,6 +735,37 @@ static int qio_channel_rdma_shutdown(QIOChannel
> > *ioc, QIOChannelShutdown how,
> > >      return 0;
> > >  }
> > >
> > > +static void
> > > +qio_channel_rdma_set_aio_fd_handler(QIOChannel *ioc, AioContext
> > *read_ctx,
> > > +                                    IOHandler *io_read,
> > AioContext *write_ctx,
> > > +                                    IOHandler *io_write, void
> > > +*opaque) {
> > > +    QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(ioc);
> > > +
> > > +    qio_channel_util_set_aio_fd_handler(rioc->pollin_eventfd, read_c=
tx,
> > io_read,
> > > +                                        rioc->pollout_eventfd,
> > write_ctx,
> > > +                                        io_write, opaque); }
> > > +
> > > +static GSource *qio_channel_rdma_create_watch(QIOChannel *ioc,
> > > +                                              GIOCondition
> > condition)
> > > +{
> > > +    QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(ioc);
> > > +
> > > +    switch (condition) {
> > > +    case G_IO_IN:
> > > +        return qio_channel_create_fd_watch(ioc, rioc->pollin_eventfd=
,
> > > +                                           condition);
> > > +    case G_IO_OUT:
> > > +        return qio_channel_create_fd_watch(ioc, rioc->pollout_eventf=
d,
> > > +                                           condition);
> > > +    default:
> > > +        error_report("%s: do not support watch 0x%x event", __func__=
,
> > > +                     condition);
> > > +        return NULL;
> > > +    }
> > > +}
> > > +
> > >  static void qio_channel_rdma_class_init(ObjectClass *klass,
> > >                                          void *class_data
> > > G_GNUC_UNUSED)  { @@ -415,9 +773,12 @@ static void
> > > qio_channel_rdma_class_init(ObjectClass *klass,
> > >
> > >      ioc_klass->io_writev =3D qio_channel_rdma_writev;
> > >      ioc_klass->io_readv =3D qio_channel_rdma_readv;
> > > +    ioc_klass->io_set_blocking =3D qio_channel_rdma_set_blocking;
> > >      ioc_klass->io_close =3D qio_channel_rdma_close;
> > >      ioc_klass->io_shutdown =3D qio_channel_rdma_shutdown;
> > >      ioc_klass->io_set_delay =3D qio_channel_rdma_set_delay;
> > > +    ioc_klass->io_create_watch =3D qio_channel_rdma_create_watch;
> > > +    ioc_klass->io_set_aio_fd_handler =3D
> > > + qio_channel_rdma_set_aio_fd_handler;
> > >  }
> > >
> > >  static const TypeInfo qio_channel_rdma_info =3D {
> > > --
> > > 2.43.0
> > >
> > >

