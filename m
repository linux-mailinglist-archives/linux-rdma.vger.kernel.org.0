Return-Path: <linux-rdma+bounces-2945-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E168FE7EF
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 15:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4581FB273ED
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 13:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07836195FDB;
	Thu,  6 Jun 2024 13:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="VISpfj71"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D4C195F1C
	for <linux-rdma@vger.kernel.org>; Thu,  6 Jun 2024 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680896; cv=none; b=VIvAMqxlRFoHTtIktaon6AAYEZIBKqgMbdvUO/XnQqvvU45K0JNOPn6CMJFP+DReIV7su/lFsh1yZrT+BfH21ec9WQ4ko9RI+stZYaNGLct9gzMAqi4yZZYbfw4bT86uDmnEJ4XalNWYVjW/BFuXYcik/aPm067xjs/ntYBwZ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680896; c=relaxed/simple;
	bh=q4o+QahbTuNXu7PqakB8Qj6acnooH2iQePCeLaBmhoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SemSXeR3leWQbdqkhbPA0+BgBa6EIa+1gGjHPxYXP1ZYAKe43bxUkKEirs+2THaWbDDlYY/sqZCDlGx6WtuBIx3LvVHPGXqOSmgUuG+8beMerSvAR9Er/n+QL+zV8SX6zqSupzTOs54CKMZwmf5CLYgPz2mK/f9LOFcMsRrJZrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=VISpfj71; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eaa794eb9fso11819811fa.2
        for <linux-rdma@vger.kernel.org>; Thu, 06 Jun 2024 06:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1717680891; x=1718285691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I04HKaazZBJoltKWxcG9Rb/UCZ3l9zMjgqW3l2HYN+A=;
        b=VISpfj71+uu+jVDbNaiuDIIE/qeLm0vaSyB8C4HTk5WXIxaoHkNMwuR8sjqAouvPlu
         nrjIOkAmGKVatWLZg6lcU8ZNJy+WhpVI9qvujS2hISVfUHRuAm1yt21g8JHLBQJt+Isb
         Dg6rNG841QNBVZ9FaW0gO1alAedAbZe3xzsMtGvm4uWxXuvgaKd/iy3SLVzFY5Lxbcuq
         mm1wuH6DI1QqLHFv0HL/HOZrnUYgyAa+keM+fvgyn+qaZLYHFpCuQheNvjmRiLig1ZNs
         e0d8umVjZHzVY0vWVaNVnq7YtHmUzAaoWmJtdgYKOsBbbeRbQiC4XjHsphgny6n2c8QS
         BqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717680891; x=1718285691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I04HKaazZBJoltKWxcG9Rb/UCZ3l9zMjgqW3l2HYN+A=;
        b=vGLHXHj4UouI3i5LDzphU6HnS6qkSXEzyBCSiPiLbpjS6orb6XJokA1tDNYQbU9yoj
         sfXju2JKFCpb3FmdX2OHIR7ZWH03n8+txv9o8jgQCEOO/PE050tJ2ADzm/lIHAkw1gT5
         n7jGPJGMDtEXNoDukVE1GSjNAps/x6yPR6asxDMOk6CCEV4n4D9m1Hy2DfYnke6FN0rD
         6xNqRMrsiha7MFtPGDIM+znGm61SMSo9FkgMIgc+qJpt+wdQADLM4Z+KI7OTzVSCAdFM
         ilMWpCKlnFQrDUUNzxmQT3meMMpNaUnFFug9Tjy2WIoJL8QOxSE3nxLLCxbg8MLucJ9K
         UwyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzYdA8IzBLm9SagiypInRBf7Tez/ur6cK/vFJOrQsWlwBGYhe3jz9PD4keSBly92idlQ9h2k460Zl/ZHZTPDe2oqp/vnnQCT5Y9Q==
X-Gm-Message-State: AOJu0YxAzAjsUI1QyWWd6+GEYwI3BWtDWLRP6ZM9WaGFsRKA8CBFEhU/
	ux3xf32o4ujAcA/NINLXWDuSUvvA49W5jEnm8jpOUOwB04GySY+dC3Rz0uZ0aB/zCF9P/+HJqza
	K7c/U9tHrS/G+UPcxEb8wHORLNfcqWPx5VKBivA==
X-Google-Smtp-Source: AGHT+IHLdLHxmTwWN2MZCJQU2+F5anQTqdp0RhPoUccKgQtQxt7cBr2guI0zM8A6QhOA95UZK+Q7Ww+PLk+e/vpoGe0=
X-Received: by 2002:a2e:984c:0:b0:2ea:aca0:2767 with SMTP id
 38308e7fff4ca-2eac7a70433mr33682441fa.44.1717680891377; Thu, 06 Jun 2024
 06:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com> <1717503252-51884-4-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1717503252-51884-4-git-send-email-arei.gonglei@huawei.com>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Thu, 6 Jun 2024 15:34:40 +0200
Message-ID: <CAJpMwyh38bHxM7JEjt+w4Y4yOiKDpGnsL6WUy7rL40=4KB0+mg@mail.gmail.com>
Subject: Re: [PATCH 3/6] io/channel-rdma: support working in coroutine
To: Gonglei <arei.gonglei@huawei.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, yu.zhang@ionos.com, 
	mgalaxy@akamai.com, elmar.gerdes@ionos.com, zhengchuan@huawei.com, 
	berrange@redhat.com, armbru@redhat.com, lizhijian@fujitsu.com, 
	pbonzini@redhat.com, mst@redhat.com, xiexiangyou@huawei.com, 
	linux-rdma@vger.kernel.org, lixiao91@huawei.com, jinpu.wang@ionos.com, 
	Jialin Wang <wangjialin23@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 2:14=E2=80=AFPM Gonglei <arei.gonglei@huawei.com> wr=
ote:
>
> From: Jialin Wang <wangjialin23@huawei.com>
>
> It is not feasible to obtain RDMA completion queue notifications
> through poll/ppoll on the rsocket fd. Therefore, we create a thread
> named rpoller for each rsocket fd and two eventfds: pollin_eventfd
> and pollout_eventfd.
>
> When using io_create_watch or io_set_aio_fd_handler waits for POLLIN
> or POLLOUT events, it will actually poll/ppoll on the pollin_eventfd
> and pollout_eventfd instead of the rsocket fd.
>
> The rpoller rpoll() on the rsocket fd to receive POLLIN and POLLOUT
> events.
> When a POLLIN event occurs, the rpoller write the pollin_eventfd,
> and then poll/ppoll will return the POLLIN event.
> When a POLLOUT event occurs, the rpoller read the pollout_eventfd,
> and then poll/ppoll will return the POLLOUT event.
>
> For a non-blocking rsocket fd, if rread/rwrite returns EAGAIN, it will
> read/write the pollin/pollout_eventfd, preventing poll/ppoll from
> returning POLLIN/POLLOUT events.
>
> Known limitations:
>
>   For a blocking rsocket fd, if we use io_create_watch to wait for
>   POLLIN or POLLOUT events, since the rsocket fd is blocking, we
>   cannot determine when it is not ready to read/write as we can with
>   non-blocking fds. Therefore, when an event occurs, it will occurs
>   always, potentially leave the qemu hanging. So we need be cautious
>   to avoid hanging when using io_create_watch .
>
> Luckily, channel-rdma works well in coroutines :)
>
> Signed-off-by: Jialin Wang <wangjialin23@huawei.com>
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> ---
>  include/io/channel-rdma.h |  15 +-
>  io/channel-rdma.c         | 363 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 376 insertions(+), 2 deletions(-)
>
> diff --git a/include/io/channel-rdma.h b/include/io/channel-rdma.h
> index 8cab2459e5..cb56127d76 100644
> --- a/include/io/channel-rdma.h
> +++ b/include/io/channel-rdma.h
> @@ -47,6 +47,18 @@ struct QIOChannelRDMA {
>      socklen_t localAddrLen;
>      struct sockaddr_storage remoteAddr;
>      socklen_t remoteAddrLen;
> +
> +    /* private */
> +
> +    /* qemu g_poll/ppoll() POLLIN event on it */
> +    int pollin_eventfd;
> +    /* qemu g_poll/ppoll() POLLOUT event on it */
> +    int pollout_eventfd;
> +
> +    /* the index in the rpoller's fds array */
> +    int index;
> +    /* rpoller will rpoll() rpoll_events on the rsocket fd */
> +    short int rpoll_events;
>  };
>
>  /**
> @@ -147,6 +159,7 @@ void qio_channel_rdma_listen_async(QIOChannelRDMA *io=
c, InetSocketAddress *addr,
>   *
>   * Returns: the new client channel, or NULL on error
>   */
> -QIOChannelRDMA *qio_channel_rdma_accept(QIOChannelRDMA *ioc, Error **err=
p);
> +QIOChannelRDMA *coroutine_mixed_fn qio_channel_rdma_accept(QIOChannelRDM=
A *ioc,
> +                                                           Error **errp)=
;
>
>  #endif /* QIO_CHANNEL_RDMA_H */
> diff --git a/io/channel-rdma.c b/io/channel-rdma.c
> index 92c362df52..9792add5cf 100644
> --- a/io/channel-rdma.c
> +++ b/io/channel-rdma.c
> @@ -23,10 +23,15 @@
>
>  #include "qemu/osdep.h"
>  #include "io/channel-rdma.h"
> +#include "io/channel-util.h"
> +#include "io/channel-watch.h"
>  #include "io/channel.h"
>  #include "qapi/clone-visitor.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-visit-sockets.h"
> +#include "qemu/atomic.h"
> +#include "qemu/error-report.h"
> +#include "qemu/thread.h"
>  #include "trace.h"
>  #include <errno.h>
>  #include <netdb.h>
> @@ -39,11 +44,274 @@
>  #include <sys/poll.h>
>  #include <unistd.h>
>
> +typedef enum {
> +    CLEAR_POLLIN,
> +    CLEAR_POLLOUT,
> +    SET_POLLIN,
> +    SET_POLLOUT,
> +} UpdateEvent;
> +
> +typedef enum {
> +    RP_CMD_ADD_IOC,
> +    RP_CMD_DEL_IOC,
> +    RP_CMD_UPDATE,
> +} RpollerCMD;
> +
> +typedef struct {
> +    RpollerCMD cmd;
> +    QIOChannelRDMA *rioc;
> +} RpollerMsg;
> +
> +/*
> + * rpoll() on the rsocket fd with rpoll_events, when POLLIN/POLLOUT even=
t
> + * occurs, it will write/read the pollin_eventfd/pollout_eventfd to allo=
w
> + * qemu g_poll/ppoll() get the POLLIN/POLLOUT event
> + */
> +static struct Rpoller {
> +    QemuThread thread;
> +    bool is_running;
> +    int sock[2];
> +    int count; /* the number of rsocket fds being rpoll() */
> +    int size; /* the size of fds/riocs */
> +    struct pollfd *fds;
> +    QIOChannelRDMA **riocs;
> +} rpoller;
> +
> +static void qio_channel_rdma_notify_rpoller(QIOChannelRDMA *rioc,
> +                                            RpollerCMD cmd)
> +{
> +    RpollerMsg msg;
> +    int ret;
> +
> +    msg.cmd =3D cmd;
> +    msg.rioc =3D rioc;
> +
> +    ret =3D RETRY_ON_EINTR(write(rpoller.sock[0], &msg, sizeof msg));
> +    if (ret !=3D sizeof msg) {
> +        error_report("%s: failed to send msg, errno: %d", __func__, errn=
o);
> +    }
> +}
> +
> +static void qio_channel_rdma_update_poll_event(QIOChannelRDMA *rioc,
> +                                               UpdateEvent action,
> +                                               bool notify_rpoller)
> +{
> +    /* An eventfd with the value of ULLONG_MAX - 1 is readable but unwri=
table */
> +    unsigned long long buf =3D ULLONG_MAX - 1;
> +
> +    switch (action) {
> +    /* only rpoller do SET_* action, to allow qemu ppoll() get the event=
 */
> +    case SET_POLLIN:
> +        RETRY_ON_EINTR(write(rioc->pollin_eventfd, &buf, sizeof buf));
> +        rioc->rpoll_events &=3D ~POLLIN;
> +        break;
> +    case SET_POLLOUT:
> +        RETRY_ON_EINTR(read(rioc->pollout_eventfd, &buf, sizeof buf));
> +        rioc->rpoll_events &=3D ~POLLOUT;
> +        break;
> +
> +    /* the rsocket fd is not ready to rread/rwrite */
> +    case CLEAR_POLLIN:
> +        RETRY_ON_EINTR(read(rioc->pollin_eventfd, &buf, sizeof buf));
> +        rioc->rpoll_events |=3D POLLIN;
> +        break;
> +    case CLEAR_POLLOUT:
> +        RETRY_ON_EINTR(write(rioc->pollout_eventfd, &buf, sizeof buf));
> +        rioc->rpoll_events |=3D POLLOUT;
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    /* notify rpoller to rpoll() POLLIN/POLLOUT events */
> +    if (notify_rpoller) {
> +        qio_channel_rdma_notify_rpoller(rioc, RP_CMD_UPDATE);
> +    }
> +}
> +
> +static void qio_channel_rdma_rpoller_add_rioc(QIOChannelRDMA *rioc)
> +{
> +    if (rioc->index !=3D -1) {
> +        error_report("%s: rioc already exsits", __func__);
> +        return;
> +    }
> +
> +    rioc->index =3D ++rpoller.count;
> +
> +    if (rpoller.count + 1 > rpoller.size) {
> +        rpoller.size *=3D 2;
> +        rpoller.fds =3D g_renew(struct pollfd, rpoller.fds, rpoller.size=
);
> +        rpoller.riocs =3D g_renew(QIOChannelRDMA *, rpoller.riocs, rpoll=
er.size);
> +    }
> +
> +    rpoller.fds[rioc->index].fd =3D rioc->fd;
> +    rpoller.fds[rioc->index].events =3D rioc->rpoll_events;

The allotment of rioc fds and events to rpoller slots are sequential,
but making the deletion also sequentials means that the del_rioc needs
to be called in the exact opposite sequence as they were added
(through add_rioc). Otherwise we leaves holes in between, and
readditions might step on an already used slot.

Does this setup make sure that the above restriction is satisfied, or
am I missing something?

> +    rpoller.riocs[rioc->index] =3D rioc;
> +}
> +
> +static void qio_channel_rdma_rpoller_del_rioc(QIOChannelRDMA *rioc)
> +{
> +    if (rioc->index =3D=3D -1) {
> +        error_report("%s: rioc not exsits", __func__);
> +        return;
> +    }
> +
> +    rpoller.fds[rioc->index] =3D rpoller.fds[rpoller.count];

Should this be rpoller.count-1?

> +    rpoller.riocs[rioc->index] =3D rpoller.riocs[rpoller.count];
> +    rpoller.riocs[rioc->index]->index =3D rioc->index;
> +    rpoller.count--;
> +
> +    close(rioc->pollin_eventfd);
> +    close(rioc->pollout_eventfd);
> +    rioc->index =3D -1;
> +    rioc->rpoll_events =3D 0;
> +}
> +
> +static void qio_channel_rdma_rpoller_update_ioc(QIOChannelRDMA *rioc)
> +{
> +    if (rioc->index =3D=3D -1) {
> +        error_report("%s: rioc not exsits", __func__);
> +        return;
> +    }
> +
> +    rpoller.fds[rioc->index].fd =3D rioc->fd;
> +    rpoller.fds[rioc->index].events =3D rioc->rpoll_events;
> +}
> +
> +static void qio_channel_rdma_rpoller_process_msg(void)
> +{
> +    RpollerMsg msg;
> +    int ret;
> +
> +    ret =3D RETRY_ON_EINTR(read(rpoller.sock[1], &msg, sizeof msg));
> +    if (ret !=3D sizeof msg) {
> +        error_report("%s: rpoller failed to recv msg: %s", __func__,
> +                     strerror(errno));
> +        return;
> +    }
> +
> +    switch (msg.cmd) {
> +    case RP_CMD_ADD_IOC:
> +        qio_channel_rdma_rpoller_add_rioc(msg.rioc);
> +        break;
> +    case RP_CMD_DEL_IOC:
> +        qio_channel_rdma_rpoller_del_rioc(msg.rioc);
> +        break;
> +    case RP_CMD_UPDATE:
> +        qio_channel_rdma_rpoller_update_ioc(msg.rioc);
> +        break;
> +    default:
> +        break;
> +    }
> +}
> +
> +static void qio_channel_rdma_rpoller_cleanup(void)
> +{
> +    close(rpoller.sock[0]);
> +    close(rpoller.sock[1]);
> +    rpoller.sock[0] =3D -1;
> +    rpoller.sock[1] =3D -1;
> +    g_free(rpoller.fds);
> +    g_free(rpoller.riocs);
> +    rpoller.fds =3D NULL;
> +    rpoller.riocs =3D NULL;
> +    rpoller.count =3D 0;
> +    rpoller.size =3D 0;
> +    rpoller.is_running =3D false;
> +}
> +
> +static void *qio_channel_rdma_rpoller_thread(void *opaque)
> +{
> +    int i, ret, error_events =3D POLLERR | POLLHUP | POLLNVAL;
> +
> +    do {
> +        ret =3D rpoll(rpoller.fds, rpoller.count + 1, -1);
> +        if (ret < 0 && errno !=3D -EINTR) {
> +            error_report("%s: rpoll() error: %s", __func__, strerror(err=
no));
> +            break;
> +        }
> +
> +        for (i =3D 1; i <=3D rpoller.count; i++) {
> +            if (rpoller.fds[i].revents & (POLLIN | error_events)) {
> +                qio_channel_rdma_update_poll_event(rpoller.riocs[i], SET=
_POLLIN,
> +                                                   false);
> +                rpoller.fds[i].events &=3D ~POLLIN;
> +            }
> +            if (rpoller.fds[i].revents & (POLLOUT | error_events)) {
> +                qio_channel_rdma_update_poll_event(rpoller.riocs[i],
> +                                                   SET_POLLOUT, false);
> +                rpoller.fds[i].events &=3D ~POLLOUT;
> +            }
> +            /* ignore this fd */
> +            if (rpoller.fds[i].revents & (error_events)) {
> +                rpoller.fds[i].fd =3D -1;
> +            }
> +        }
> +
> +        if (rpoller.fds[0].revents) {
> +            qio_channel_rdma_rpoller_process_msg();
> +        }
> +    } while (rpoller.count >=3D 1);
> +
> +    qio_channel_rdma_rpoller_cleanup();
> +
> +    return NULL;
> +}
> +
> +static void qio_channel_rdma_rpoller_start(void)
> +{
> +    if (qatomic_xchg(&rpoller.is_running, true)) {
> +        return;
> +    }
> +
> +    if (qemu_socketpair(AF_UNIX, SOCK_STREAM, 0, rpoller.sock)) {
> +        rpoller.is_running =3D false;
> +        error_report("%s: failed to create socketpair %s", __func__,
> +                     strerror(errno));
> +        return;
> +    }
> +
> +    rpoller.count =3D 0;
> +    rpoller.size =3D 4;
> +    rpoller.fds =3D g_malloc0_n(rpoller.size, sizeof(struct pollfd));
> +    rpoller.riocs =3D g_malloc0_n(rpoller.size, sizeof(QIOChannelRDMA *)=
);
> +    rpoller.fds[0].fd =3D rpoller.sock[1];
> +    rpoller.fds[0].events =3D POLLIN;
> +
> +    qemu_thread_create(&rpoller.thread, "qio-channel-rdma-rpoller",
> +                       qio_channel_rdma_rpoller_thread, NULL,
> +                       QEMU_THREAD_JOINABLE);
> +}
> +
> +static void qio_channel_rdma_add_rioc_to_rpoller(QIOChannelRDMA *rioc)
> +{
> +    int flags =3D EFD_CLOEXEC | EFD_NONBLOCK;
> +
> +    /*
> +     * A single eventfd is either readable or writable. A single eventfd=
 cannot
> +     * represent a state where it is neither readable nor writable. so u=
se two
> +     * eventfds here.
> +     */
> +    rioc->pollin_eventfd =3D eventfd(0, flags);
> +    rioc->pollout_eventfd =3D eventfd(0, flags);
> +    /* pollout_eventfd with the value 0, means writable, make it unwrita=
ble */
> +    qio_channel_rdma_update_poll_event(rioc, CLEAR_POLLOUT, false);
> +
> +    /* tell the rpoller to rpoll() events on rioc->socketfd */
> +    rioc->rpoll_events =3D POLLIN | POLLOUT;
> +    qio_channel_rdma_notify_rpoller(rioc, RP_CMD_ADD_IOC);
> +}
> +
>  QIOChannelRDMA *qio_channel_rdma_new(void)
>  {
>      QIOChannelRDMA *rioc;
>      QIOChannel *ioc;
>
> +    qio_channel_rdma_rpoller_start();
> +    if (!rpoller.is_running) {
> +        return NULL;
> +    }
> +
>      rioc =3D QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
>      ioc =3D QIO_CHANNEL(rioc);
>      qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
> @@ -125,6 +393,8 @@ retry:
>          goto out;
>      }
>
> +    qio_channel_rdma_add_rioc_to_rpoller(rioc);
> +
>  out:
>      if (ret) {
>          trace_qio_channel_rdma_connect_fail(rioc);
> @@ -211,6 +481,8 @@ int qio_channel_rdma_listen_sync(QIOChannelRDMA *rioc=
, InetSocketAddress *addr,
>      qio_channel_set_feature(QIO_CHANNEL(rioc), QIO_CHANNEL_FEATURE_LISTE=
N);
>      trace_qio_channel_rdma_listen_complete(rioc, fd);
>
> +    qio_channel_rdma_add_rioc_to_rpoller(rioc);
> +
>  out:
>      if (ret) {
>          trace_qio_channel_rdma_listen_fail(rioc);
> @@ -267,8 +539,10 @@ void qio_channel_rdma_listen_async(QIOChannelRDMA *i=
oc, InetSocketAddress *addr,
>                             qio_channel_listen_worker_free, context);
>  }
>
> -QIOChannelRDMA *qio_channel_rdma_accept(QIOChannelRDMA *rioc, Error **er=
rp)
> +QIOChannelRDMA *coroutine_mixed_fn qio_channel_rdma_accept(QIOChannelRDM=
A *rioc,
> +                                                           Error **errp)
>  {
> +    QIOChannel *ioc =3D QIO_CHANNEL(rioc);
>      QIOChannelRDMA *cioc;
>
>      cioc =3D qio_channel_rdma_new();
> @@ -283,6 +557,17 @@ retry:
>          if (errno =3D=3D EINTR) {
>              goto retry;
>          }
> +        if (errno =3D=3D EAGAIN) {
> +            if (!(rioc->rpoll_events & POLLIN)) {
> +                qio_channel_rdma_update_poll_event(rioc, CLEAR_POLLIN, t=
rue);
> +            }
> +            if (qemu_in_coroutine()) {
> +                qio_channel_yield(ioc, G_IO_IN);
> +            } else {
> +                qio_channel_wait(ioc, G_IO_IN);
> +            }
> +            goto retry;
> +        }
>          error_setg_errno(errp, errno, "Unable to accept connection");
>          goto error;
>      }
> @@ -294,6 +579,8 @@ retry:
>          goto error;
>      }
>
> +    qio_channel_rdma_add_rioc_to_rpoller(cioc);
> +
>      trace_qio_channel_rdma_accept_complete(rioc, cioc, cioc->fd);
>      return cioc;
>
> @@ -307,6 +594,10 @@ static void qio_channel_rdma_init(Object *obj)
>  {
>      QIOChannelRDMA *ioc =3D QIO_CHANNEL_RDMA(obj);
>      ioc->fd =3D -1;
> +    ioc->pollin_eventfd =3D -1;
> +    ioc->pollout_eventfd =3D -1;
> +    ioc->index =3D -1;
> +    ioc->rpoll_events =3D 0;
>  }
>
>  static void qio_channel_rdma_finalize(Object *obj)
> @@ -314,6 +605,7 @@ static void qio_channel_rdma_finalize(Object *obj)
>      QIOChannelRDMA *ioc =3D QIO_CHANNEL_RDMA(obj);
>
>      if (ioc->fd !=3D -1) {
> +        qio_channel_rdma_notify_rpoller(ioc, RP_CMD_DEL_IOC);
>          rclose(ioc->fd);
>          ioc->fd =3D -1;
>      }
> @@ -330,6 +622,12 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *io=
c, const struct iovec *iov,
>  retry:
>      ret =3D rreadv(rioc->fd, iov, niov);
>      if (ret < 0) {
> +        if (errno =3D=3D EAGAIN) {
> +            if (!(rioc->rpoll_events & POLLIN)) {
> +                qio_channel_rdma_update_poll_event(rioc, CLEAR_POLLIN, t=
rue);
> +            }
> +            return QIO_CHANNEL_ERR_BLOCK;
> +        }
>          if (errno =3D=3D EINTR) {
>              goto retry;
>          }
> @@ -351,6 +649,12 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *i=
oc, const struct iovec *iov,
>  retry:
>      ret =3D rwritev(rioc->fd, iov, niov);
>      if (ret <=3D 0) {
> +        if (errno =3D=3D EAGAIN) {
> +            if (!(rioc->rpoll_events & POLLOUT)) {
> +                qio_channel_rdma_update_poll_event(rioc, CLEAR_POLLOUT, =
true);
> +            }
> +            return QIO_CHANNEL_ERR_BLOCK;
> +        }
>          if (errno =3D=3D EINTR) {
>              goto retry;
>          }
> @@ -361,6 +665,28 @@ retry:
>      return ret;
>  }
>
> +static int qio_channel_rdma_set_blocking(QIOChannel *ioc, bool enabled,
> +                                         Error **errp G_GNUC_UNUSED)
> +{
> +    QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(ioc);
> +    int flags, ret;
> +
> +    flags =3D rfcntl(rioc->fd, F_GETFL);
> +    if (enabled) {
> +        flags &=3D ~O_NONBLOCK;
> +    } else {
> +        flags |=3D O_NONBLOCK;
> +    }
> +
> +    ret =3D rfcntl(rioc->fd, F_SETFL, flags);
> +    if (ret) {
> +        error_setg_errno(errp, errno,
> +                         "Unable to rfcntl rsocket fd with flags %d", fl=
ags);
> +    }
> +
> +    return ret;
> +}
> +
>  static void qio_channel_rdma_set_delay(QIOChannel *ioc, bool enabled)
>  {
>      QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(ioc);
> @@ -374,6 +700,7 @@ static int qio_channel_rdma_close(QIOChannel *ioc, Er=
ror **errp)
>      QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(ioc);
>
>      if (rioc->fd !=3D -1) {
> +        qio_channel_rdma_notify_rpoller(rioc, RP_CMD_DEL_IOC);
>          rclose(rioc->fd);
>          rioc->fd =3D -1;
>      }
> @@ -408,6 +735,37 @@ static int qio_channel_rdma_shutdown(QIOChannel *ioc=
, QIOChannelShutdown how,
>      return 0;
>  }
>
> +static void
> +qio_channel_rdma_set_aio_fd_handler(QIOChannel *ioc, AioContext *read_ct=
x,
> +                                    IOHandler *io_read, AioContext *writ=
e_ctx,
> +                                    IOHandler *io_write, void *opaque)
> +{
> +    QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(ioc);
> +
> +    qio_channel_util_set_aio_fd_handler(rioc->pollin_eventfd, read_ctx, =
io_read,
> +                                        rioc->pollout_eventfd, write_ctx=
,
> +                                        io_write, opaque);
> +}
> +
> +static GSource *qio_channel_rdma_create_watch(QIOChannel *ioc,
> +                                              GIOCondition condition)
> +{
> +    QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(ioc);
> +
> +    switch (condition) {
> +    case G_IO_IN:
> +        return qio_channel_create_fd_watch(ioc, rioc->pollin_eventfd,
> +                                           condition);
> +    case G_IO_OUT:
> +        return qio_channel_create_fd_watch(ioc, rioc->pollout_eventfd,
> +                                           condition);
> +    default:
> +        error_report("%s: do not support watch 0x%x event", __func__,
> +                     condition);
> +        return NULL;
> +    }
> +}
> +
>  static void qio_channel_rdma_class_init(ObjectClass *klass,
>                                          void *class_data G_GNUC_UNUSED)
>  {
> @@ -415,9 +773,12 @@ static void qio_channel_rdma_class_init(ObjectClass =
*klass,
>
>      ioc_klass->io_writev =3D qio_channel_rdma_writev;
>      ioc_klass->io_readv =3D qio_channel_rdma_readv;
> +    ioc_klass->io_set_blocking =3D qio_channel_rdma_set_blocking;
>      ioc_klass->io_close =3D qio_channel_rdma_close;
>      ioc_klass->io_shutdown =3D qio_channel_rdma_shutdown;
>      ioc_klass->io_set_delay =3D qio_channel_rdma_set_delay;
> +    ioc_klass->io_create_watch =3D qio_channel_rdma_create_watch;
> +    ioc_klass->io_set_aio_fd_handler =3D qio_channel_rdma_set_aio_fd_han=
dler;
>  }
>
>  static const TypeInfo qio_channel_rdma_info =3D {
> --
> 2.43.0
>
>

