Return-Path: <linux-rdma+bounces-2985-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B61A8FFEA7
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 11:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 917A0B22E29
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 09:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED0D15B967;
	Fri,  7 Jun 2024 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WzeVvUZJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B4A15B15C
	for <linux-rdma@vger.kernel.org>; Fri,  7 Jun 2024 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751074; cv=none; b=uOP9frRRkd63+Kj16iOS1dzIy+p3u+Ms1NmlXs9R1DBHzu9VsNsBQIXFySbyCUTDK+Giw38BIql2yTr2aGhkZqenTDAVneOTC7qr27M1dGpNaXOag9zphmI9CITjojvUy28js6HmJHvHWYf9Zjwi188u9p1UmPtGypQ4FLWVMjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751074; c=relaxed/simple;
	bh=SUIQthDvFkZtX4yXtXRAAiwnvUpa9MPE3vwkvR1t1ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRdltqLAh11E6mL+2B5o0VrtWuhWo9P2QH49PKRAN5dFdX49T/b6lSsbyO1EABCpplHe2F/H4F2X21we9ERlbDZgExDd0u8ybinHgq5w7EwpH1XU6Bsbg/rm2NbX1zLxZL610S401dD4dLG1dfBH0OIiZDdwd5u9aZwmv0hRXeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WzeVvUZJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717751071;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=BcFayrWtggtMP3po7Z8Z9ax3OJMOt2ZY/TMiLnkBC4E=;
	b=WzeVvUZJ3HMQGeTEi5tfFKO0I9HPB9BXF9Ado9+OHyb2dW8MXSmHqaQRO8lp2oIS9/pft9
	rj/Hv63iXffzwyq3bzH5AbezN7e9PXxixzAqndhzfi1xXzwmAqfytwKg5OCwWzj6IVFw4S
	Lac+6Ba5ZH1fTuozY93I+Tr7KJ0f18U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-lcAfQ5hHMrmQ6rDfyf2yAQ-1; Fri, 07 Jun 2024 05:04:27 -0400
X-MC-Unique: lcAfQ5hHMrmQ6rDfyf2yAQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9261A101A528;
	Fri,  7 Jun 2024 09:04:26 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.232])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B6182166B0E;
	Fri,  7 Jun 2024 09:04:22 +0000 (UTC)
Date: Fri, 7 Jun 2024 10:04:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gonglei <arei.gonglei@huawei.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, yu.zhang@ionos.com,
	mgalaxy@akamai.com, elmar.gerdes@ionos.com, zhengchuan@huawei.com,
	armbru@redhat.com, lizhijian@fujitsu.com, pbonzini@redhat.com,
	mst@redhat.com, xiexiangyou@huawei.com, linux-rdma@vger.kernel.org,
	lixiao91@huawei.com, jinpu.wang@ionos.com,
	Jialin Wang <wangjialin23@huawei.com>
Subject: Re: [PATCH 3/6] io/channel-rdma: support working in coroutine
Message-ID: <ZmLNExmXzxb-hgoN@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <1717503252-51884-4-git-send-email-arei.gonglei@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1717503252-51884-4-git-send-email-arei.gonglei@huawei.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Tue, Jun 04, 2024 at 08:14:09PM +0800, Gonglei wrote:
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
> @@ -147,6 +159,7 @@ void qio_channel_rdma_listen_async(QIOChannelRDMA *ioc, InetSocketAddress *addr,
>   *
>   * Returns: the new client channel, or NULL on error
>   */
> -QIOChannelRDMA *qio_channel_rdma_accept(QIOChannelRDMA *ioc, Error **errp);
> +QIOChannelRDMA *coroutine_mixed_fn qio_channel_rdma_accept(QIOChannelRDMA *ioc,
> +                                                           Error **errp);
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
> + * rpoll() on the rsocket fd with rpoll_events, when POLLIN/POLLOUT event
> + * occurs, it will write/read the pollin_eventfd/pollout_eventfd to allow
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
> +    msg.cmd = cmd;
> +    msg.rioc = rioc;
> +
> +    ret = RETRY_ON_EINTR(write(rpoller.sock[0], &msg, sizeof msg));

So this message is handled asynchronously by the poll thread, but
you're not acquiring any reference on teh 'rioc' object. So there's
the possibility that the owner of the rioc calls 'unref' free'ing
the last reference, before the poll thread has finished processing
the message.  IMHO the poll thread must hold a reference on the
rioc for as long as it needs the object.

> +    if (ret != sizeof msg) {
> +        error_report("%s: failed to send msg, errno: %d", __func__, errno);
> +    }

I feel like this should be propagated to the caller via an Error **errp
parameter.

> +}
> +
> +static void qio_channel_rdma_update_poll_event(QIOChannelRDMA *rioc,
> +                                               UpdateEvent action,
> +                                               bool notify_rpoller)
> +{
> +    /* An eventfd with the value of ULLONG_MAX - 1 is readable but unwritable */
> +    unsigned long long buf = ULLONG_MAX - 1;
> +
> +    switch (action) {
> +    /* only rpoller do SET_* action, to allow qemu ppoll() get the event */
> +    case SET_POLLIN:
> +        RETRY_ON_EINTR(write(rioc->pollin_eventfd, &buf, sizeof buf));
> +        rioc->rpoll_events &= ~POLLIN;
> +        break;
> +    case SET_POLLOUT:
> +        RETRY_ON_EINTR(read(rioc->pollout_eventfd, &buf, sizeof buf));
> +        rioc->rpoll_events &= ~POLLOUT;
> +        break;
> +
> +    /* the rsocket fd is not ready to rread/rwrite */
> +    case CLEAR_POLLIN:
> +        RETRY_ON_EINTR(read(rioc->pollin_eventfd, &buf, sizeof buf));
> +        rioc->rpoll_events |= POLLIN;
> +        break;
> +    case CLEAR_POLLOUT:
> +        RETRY_ON_EINTR(write(rioc->pollout_eventfd, &buf, sizeof buf));
> +        rioc->rpoll_events |= POLLOUT;
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
> +    if (rioc->index != -1) {
> +        error_report("%s: rioc already exsits", __func__);
> +        return;
> +    }
> +
> +    rioc->index = ++rpoller.count;
> +
> +    if (rpoller.count + 1 > rpoller.size) {
> +        rpoller.size *= 2;
> +        rpoller.fds = g_renew(struct pollfd, rpoller.fds, rpoller.size);
> +        rpoller.riocs = g_renew(QIOChannelRDMA *, rpoller.riocs, rpoller.size);
> +    }
> +
> +    rpoller.fds[rioc->index].fd = rioc->fd;
> +    rpoller.fds[rioc->index].events = rioc->rpoll_events;
> +    rpoller.riocs[rioc->index] = rioc;
> +}
> +
> +static void qio_channel_rdma_rpoller_del_rioc(QIOChannelRDMA *rioc)
> +{
> +    if (rioc->index == -1) {
> +        error_report("%s: rioc not exsits", __func__);
> +        return;
> +    }
> +
> +    rpoller.fds[rioc->index] = rpoller.fds[rpoller.count];
> +    rpoller.riocs[rioc->index] = rpoller.riocs[rpoller.count];
> +    rpoller.riocs[rioc->index]->index = rioc->index;
> +    rpoller.count--;
> +
> +    close(rioc->pollin_eventfd);
> +    close(rioc->pollout_eventfd);
> +    rioc->index = -1;
> +    rioc->rpoll_events = 0;
> +}
> +
> +static void qio_channel_rdma_rpoller_update_ioc(QIOChannelRDMA *rioc)
> +{
> +    if (rioc->index == -1) {
> +        error_report("%s: rioc not exsits", __func__);
> +        return;
> +    }
> +
> +    rpoller.fds[rioc->index].fd = rioc->fd;
> +    rpoller.fds[rioc->index].events = rioc->rpoll_events;
> +}
> +
> +static void qio_channel_rdma_rpoller_process_msg(void)
> +{
> +    RpollerMsg msg;
> +    int ret;
> +
> +    ret = RETRY_ON_EINTR(read(rpoller.sock[1], &msg, sizeof msg));
> +    if (ret != sizeof msg) {
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
> +    rpoller.sock[0] = -1;
> +    rpoller.sock[1] = -1;
> +    g_free(rpoller.fds);
> +    g_free(rpoller.riocs);
> +    rpoller.fds = NULL;
> +    rpoller.riocs = NULL;
> +    rpoller.count = 0;
> +    rpoller.size = 0;
> +    rpoller.is_running = false;
> +}
> +
> +static void *qio_channel_rdma_rpoller_thread(void *opaque)
> +{
> +    int i, ret, error_events = POLLERR | POLLHUP | POLLNVAL;
> +
> +    do {
> +        ret = rpoll(rpoller.fds, rpoller.count + 1, -1);
> +        if (ret < 0 && errno != -EINTR) {
> +            error_report("%s: rpoll() error: %s", __func__, strerror(errno));
> +            break;
> +        }
> +
> +        for (i = 1; i <= rpoller.count; i++) {
> +            if (rpoller.fds[i].revents & (POLLIN | error_events)) {
> +                qio_channel_rdma_update_poll_event(rpoller.riocs[i], SET_POLLIN,
> +                                                   false);
> +                rpoller.fds[i].events &= ~POLLIN;
> +            }
> +            if (rpoller.fds[i].revents & (POLLOUT | error_events)) {
> +                qio_channel_rdma_update_poll_event(rpoller.riocs[i],
> +                                                   SET_POLLOUT, false);
> +                rpoller.fds[i].events &= ~POLLOUT;
> +            }
> +            /* ignore this fd */
> +            if (rpoller.fds[i].revents & (error_events)) {
> +                rpoller.fds[i].fd = -1;
> +            }
> +        }
> +
> +        if (rpoller.fds[0].revents) {
> +            qio_channel_rdma_rpoller_process_msg();
> +        }
> +    } while (rpoller.count >= 1);
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
> +        rpoller.is_running = false;
> +        error_report("%s: failed to create socketpair %s", __func__,
> +                     strerror(errno));
> +        return;
> +    }
> +
> +    rpoller.count = 0;
> +    rpoller.size = 4;
> +    rpoller.fds = g_malloc0_n(rpoller.size, sizeof(struct pollfd));
> +    rpoller.riocs = g_malloc0_n(rpoller.size, sizeof(QIOChannelRDMA *));
> +    rpoller.fds[0].fd = rpoller.sock[1];
> +    rpoller.fds[0].events = POLLIN;
> +
> +    qemu_thread_create(&rpoller.thread, "qio-channel-rdma-rpoller",
> +                       qio_channel_rdma_rpoller_thread, NULL,
> +                       QEMU_THREAD_JOINABLE);
> +}
> +
> +static void qio_channel_rdma_add_rioc_to_rpoller(QIOChannelRDMA *rioc)
> +{
> +    int flags = EFD_CLOEXEC | EFD_NONBLOCK;
> +
> +    /*
> +     * A single eventfd is either readable or writable. A single eventfd cannot
> +     * represent a state where it is neither readable nor writable. so use two
> +     * eventfds here.
> +     */
> +    rioc->pollin_eventfd = eventfd(0, flags);
> +    rioc->pollout_eventfd = eventfd(0, flags);
> +    /* pollout_eventfd with the value 0, means writable, make it unwritable */
> +    qio_channel_rdma_update_poll_event(rioc, CLEAR_POLLOUT, false);
> +
> +    /* tell the rpoller to rpoll() events on rioc->socketfd */
> +    rioc->rpoll_events = POLLIN | POLLOUT;
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
>      rioc = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
>      ioc = QIO_CHANNEL(rioc);
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
> @@ -211,6 +481,8 @@ int qio_channel_rdma_listen_sync(QIOChannelRDMA *rioc, InetSocketAddress *addr,
>      qio_channel_set_feature(QIO_CHANNEL(rioc), QIO_CHANNEL_FEATURE_LISTEN);
>      trace_qio_channel_rdma_listen_complete(rioc, fd);
>  
> +    qio_channel_rdma_add_rioc_to_rpoller(rioc);
> +
>  out:
>      if (ret) {
>          trace_qio_channel_rdma_listen_fail(rioc);
> @@ -267,8 +539,10 @@ void qio_channel_rdma_listen_async(QIOChannelRDMA *ioc, InetSocketAddress *addr,
>                             qio_channel_listen_worker_free, context);
>  }
>  
> -QIOChannelRDMA *qio_channel_rdma_accept(QIOChannelRDMA *rioc, Error **errp)
> +QIOChannelRDMA *coroutine_mixed_fn qio_channel_rdma_accept(QIOChannelRDMA *rioc,
> +                                                           Error **errp)
>  {
> +    QIOChannel *ioc = QIO_CHANNEL(rioc);
>      QIOChannelRDMA *cioc;
>  
>      cioc = qio_channel_rdma_new();
> @@ -283,6 +557,17 @@ retry:
>          if (errno == EINTR) {
>              goto retry;
>          }
> +        if (errno == EAGAIN) {
> +            if (!(rioc->rpoll_events & POLLIN)) {
> +                qio_channel_rdma_update_poll_event(rioc, CLEAR_POLLIN, true);
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
>      QIOChannelRDMA *ioc = QIO_CHANNEL_RDMA(obj);
>      ioc->fd = -1;
> +    ioc->pollin_eventfd = -1;
> +    ioc->pollout_eventfd = -1;
> +    ioc->index = -1;
> +    ioc->rpoll_events = 0;
>  }
>  
>  static void qio_channel_rdma_finalize(Object *obj)
> @@ -314,6 +605,7 @@ static void qio_channel_rdma_finalize(Object *obj)
>      QIOChannelRDMA *ioc = QIO_CHANNEL_RDMA(obj);
>  
>      if (ioc->fd != -1) {
> +        qio_channel_rdma_notify_rpoller(ioc, RP_CMD_DEL_IOC);

This is unsafe.

When finalize runs, the object has dropped its last reference and
is about to be free()d.  The notify_rpoller() method, however,
sends an async message to the poll thread, which the poll thread
will end up processing after the rioc is free()d. ie a use-after-free.

If you take my earlier suggestion that the poll thread should hold
its own reference on the ioc, then it becomes impossible for the
rioc to be freed while there is still an active I/O watch, and
thus this call can go away, and so will the use after free.

>          rclose(ioc->fd);
>          ioc->fd = -1;
>      }

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


