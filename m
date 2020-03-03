Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E00F17783B
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2020 15:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgCCOFl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Mar 2020 09:05:41 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46080 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgCCOFl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Mar 2020 09:05:41 -0500
Received: by mail-io1-f68.google.com with SMTP id x21so3610245iox.13
        for <linux-rdma@vger.kernel.org>; Tue, 03 Mar 2020 06:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R3wvEN36jOzXrCcZbM0UhW912tq8WUQ3p96m+z3N6qY=;
        b=EY2PSud1WGZt+tkRLYU4GRUvr1R3EVo7AO3VXcmbX9H2vmqUUY33YDO5HOqRXm66mc
         BWeHpc/xPRqrwuApPo91fgFICW3fFJ2dfPYnS4vyAcS/XdTE2Y4xdVvdo19YRiHD3XPw
         3Ed4sEhPXC8mdm4Z9Wswa55YoIZ2Z9N4KxtAKI0pgA0qGOdC3ZQapUM8XbVJQBaY2+fb
         dfFP3fMDsOu4H+4Zik8L86zKt0/5Fi/9+95xWLkrJU2bKPasq3iIWTJMQ195lwmynwIe
         VXuc6z38x1w9xFsZUpBZ2WJF0MQiPwPl/R18tjnrt/GEwRdBTHWAwrMXQgSHulJmr8xI
         WVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R3wvEN36jOzXrCcZbM0UhW912tq8WUQ3p96m+z3N6qY=;
        b=F4x9t/ufrRRo5DhiBbupBLH9E+MQD2iGkC2XanJLhkwNays9R8TYqE+0MRm3h8PBjD
         RMAkz5vtmvGMV4d5UaUEFunmM/CrzEuCuIYT0B+80C1QOi28rRN38XTpFATh4QuXNtJy
         B2Kk+dbJnVwVm+UHUd1pfc/FJkvShVwGCNaYfs4I6o4GhHLikMNw9pmczAyvhOpYKOlS
         uXlL0O8FXVz3Hmq7rmrsL7rzETpqJ6hLhZ0f5XatHuHyddGUo9KXti/VT1PX2xNA3NTb
         s4ufGqoD15ckBAo8u+H2bQm9qvRFyTchJKFEl52CCEzhXW/tZF+8cbKBXUIg3Dx1aPqJ
         P3Vg==
X-Gm-Message-State: ANhLgQ2xHPFpkRdLzzBSyPumGS4FTELktPaBZI0BWNOjR25wBK77kLyq
        bCtI77M2mgcHy3qXrILlpTxY1DG176IetqPZZ5YLvg==
X-Google-Smtp-Source: ADFU+vvdyoNHqZ+wF+Zjzy/HUFaIjCq+KN5qcSjq93hWJd1pZiYfdjvfN1nsLc5GMF/nA5VYlYlBtWDiNaGw4h5g5Zc=
X-Received: by 2002:a6b:6814:: with SMTP id d20mr4061766ioc.71.1583244339958;
 Tue, 03 Mar 2020 06:05:39 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-3-jinpuwang@gmail.com>
 <20200303094035.GI121803@unreal>
In-Reply-To: <20200303094035.GI121803@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 3 Mar 2020 15:05:27 +0100
Message-ID: <CAMGffEkezAHp6xkOPDHB-zXpTVhz6JNGQadvwO3KhZP8fJeLTg@mail.gmail.com>
Subject: Re: [PATCH v9 02/25] RDMA/rtrs: public interface header to establish
 RDMA connections
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
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

On Tue, Mar 3, 2020 at 10:40 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Feb 21, 2020 at 11:46:58AM +0100, Jack Wang wrote:
> > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> >
> > Introduce public header which provides set of API functions to
> > establish RDMA connections from client to server machine using
> > RTRS protocol, which manages RDMA connections for each session,
> > does multipathing and load balancing.
> >
> > Main functions for client (active) side:
> >
> >  rtrs_clt_open() - Creates set of RDMA connections incapsulated
> >                     in IBTRS session and returns pointer on RTRS
> >                   session object.
> >  rtrs_clt_close() - Closes RDMA connections associated with RTRS
> >                      session.
> >  rtrs_clt_request() - Requests zero-copy RDMA transfer to/from
> >                        server.
> >
> > Main functions for server (passive) side:
> >
> >  rtrs_srv_open() - Starts listening for RTRS clients on specified
> >                     port and invokes RTRS callbacks for incoming
> >                   RDMA requests or link events.
> >  rtrs_srv_close() - Closes RTRS server context.
> >
> > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs.h | 310 +++++++++++++++++++++++++++++
> >  1 file changed, 310 insertions(+)
> >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs.h
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs.h b/drivers/infiniband/ulp/rtrs/rtrs.h
> > new file mode 100644
> > index 000000000000..5e1c8a654e92
> > --- /dev/null
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs.h
> > @@ -0,0 +1,310 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * RDMA Transport Layer
> > + *
> > + * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
> > + * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> > + * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
> > + */
> > +#ifndef RTRS_H
> > +#define RTRS_H
> > +
> > +#include <linux/socket.h>
> > +#include <linux/scatterlist.h>
> > +
> > +struct rtrs_permit;
> > +struct rtrs_clt;
> > +struct rtrs_srv_ctx;
> > +struct rtrs_srv;
> > +struct rtrs_srv_op;
> > +
> > +/*
> > + * RDMA transport (RTRS) client API
> > + */
> > +
> > +/**
> > + * enum rtrs_clt_link_ev - Events about connectivity state of a client
> > + * @RTRS_CLT_LINK_EV_RECONNECTED     Client was reconnected.
> > + * @RTRS_CLT_LINK_EV_DISCONNECTED    Client was disconnected.
> > + */
> > +enum rtrs_clt_link_ev {
> > +     RTRS_CLT_LINK_EV_RECONNECTED,
> > +     RTRS_CLT_LINK_EV_DISCONNECTED,
> > +};
> > +
> > +/**
> > + * Source and destination address of a path to be established
> > + */
> > +struct rtrs_addr {
> > +     struct sockaddr_storage *src;
> > +     struct sockaddr_storage *dst;
> > +};
> > +
> > +typedef void (link_clt_ev_fn)(void *priv, enum rtrs_clt_link_ev ev);
> > +/**
> > + * rtrs_clt_open() - Open a session to an RTRS server
> > + * @priv: User supplied private data.
> > + * @link_ev: Event notification callback function for connection state changes
> > + *   @priv: User supplied data that was passed to rtrs_clt_open()
> > + *   @ev: Occurred event
> > + * @sessname: name of the session
> > + * @paths: Paths to be established defined by their src and dst addresses
> > + * @path_cnt: Number of elements in the @paths array
> > + * @port: port to be used by the RTRS session
> > + * @pdu_sz: Size of extra payload which can be accessed after permit allocation.
> > + * @max_inflight_msg: Max. number of parallel inflight messages for the session
> > + * @max_segments: Max. number of segments per IO request
> > + * @reconnect_delay_sec: time between reconnect tries
> > + * @max_reconnect_attempts: Number of times to reconnect on error before giving
> > + *                       up, 0 for * disabled, -1 for forever
> > + *
> > + * Starts session establishment with the rtrs_server. The function can block
> > + * up to ~2000ms before it returns.
> > + *
> > + * Return a valid pointer on success otherwise PTR_ERR.
> > + */
> > +struct rtrs_clt *rtrs_clt_open(void *priv, link_clt_ev_fn *link_ev,
> > +                              const char *sessname,
> > +                              const struct rtrs_addr *paths,
> > +                              size_t path_cnt, u16 port,
> > +                              size_t pdu_sz, u8 reconnect_delay_sec,
> > +                              u16 max_segments,
> > +                              s16 max_reconnect_attempts);
> > +
> > +/**
> > + * rtrs_clt_close() - Close a session
> > + * @sess: Session handle. Session is freed upon return.
> > + */
> > +void rtrs_clt_close(struct rtrs_clt *sess);
> > +
> > +/**
> > + * rtrs_permit_to_pdu() - converts rtrs_permit to opaque pdu pointer
> > + * @permit: RTRS permit pointer, it associates the memory allocation for future
> > + *          RDMA operation.
> > + */
> > +void *rtrs_permit_to_pdu(struct rtrs_permit *permit);
> > +
> > +enum {
> > +     RTRS_PERMIT_NOWAIT = 0,
> > +     RTRS_PERMIT_WAIT   = 1,
> > +};
> > +
> > +/**
> > + * enum rtrs_clt_con_type() type of ib connection to use with a given
> > + * rtrs_permit
> > + * @USR_CON - use connection reserved vor "service" messages
> > + * @IO_CON - use a connection reserved for IO
> > + */
> > +enum rtrs_clt_con_type {
> > +     RTRS_USR_CON,
> > +     RTRS_IO_CON
> > +};
> > +
> > +/**
> > + * rtrs_clt_get_permit() - allocates permit for future RDMA operation
> > + * @sess:    Current session
> > + * @con_type:        Type of connection to use with the permit
> > + * @wait:    Wait type
> > + *
> > + * Description:
> > + *    Allocates permit for the following RDMA operation.  Permit is used
> > + *    to preallocate all resources and to propagate memory pressure
> > + *    up earlier.
> > + *
> > + * Context:
> > + *    Can sleep if @wait == RTRS_TAG_WAIT
> > + */
> > +struct rtrs_permit *rtrs_clt_get_permit(struct rtrs_clt *sess,
> > +                                 enum rtrs_clt_con_type con_type,
> > +                                 int wait);
> > +
> > +/**
> > + * rtrs_clt_put_permit() - puts allocated permit
> > + * @sess:    Current session
> > + * @permit:  Permit to be freed
> > + *
> > + * Context:
> > + *    Does not matter
> > + */
> > +void rtrs_clt_put_permit(struct rtrs_clt *sess, struct rtrs_permit *permit);
> > +
> > +typedef void (rtrs_conf_fn)(void *priv, int errno);
> > +/**
> > + * rtrs_clt_request() - Request data transfer to/from server via RDMA.
> > + *
> > + * @dir:     READ/WRITE
> > + * @conf:    callback function to be called as confirmation
> > + * @sess:    Session
> > + * @permit:  Preallocated permit
> > + * @priv:    User provided data, passed back with corresponding
> > + *           @(conf) confirmation.
> > + * @vec:     Message that is sent to server together with the request.
> > + *           Sum of len of all @vec elements limited to <= IO_MSG_SIZE.
> > + *           Since the msg is copied internally it can be allocated on stack.
> > + * @nr:              Number of elements in @vec.
> > + * @len:     length of data sent to/from server
> > + * @sg:              Pages to be sent/received to/from server.
> > + * @sg_cnt:  Number of elements in the @sg
> > + *
> > + * Return:
> > + * 0:                Success
> > + * <0:               Error
> > + *
> > + * On dir=READ rtrs client will request a data transfer from Server to client.
> > + * The data that the server will respond with will be stored in @sg when
> > + * the user receives an %RTRS_CLT_RDMA_EV_RDMA_REQUEST_WRITE_COMPL event.
> > + * On dir=WRITE rtrs client will rdma write data in sg to server side.
> > + */
> > +int rtrs_clt_request(int dir, rtrs_conf_fn *conf, struct rtrs_clt *sess,
> > +                   struct rtrs_permit *permit, void *priv,
> > +                   const struct kvec *vec, size_t nr, size_t len,
> > +                   struct scatterlist *sg, unsigned int sg_cnt);
> > +
> > +/**
> > + * rtrs_attrs - RTRS session attributes
> > + */
> > +struct rtrs_attrs {
> > +     u32     queue_depth;
> > +     u32     max_io_size;
> > +     u8      sessname[NAME_MAX];
> > +     struct kobject *sess_kobj;
> > +};
> > +
> > +/**
> > + * rtrs_clt_query() - queries RTRS session attributes
> > + *
> > + * Returns:
> > + *    0 on success
> > + *    -ECOMM         no connection to the server
> > + */
> > +int rtrs_clt_query(struct rtrs_clt *sess, struct rtrs_attrs *attr);
> > +
> > +/*
> > + * Here goes RTRS server API
> > + */
> > +
> > +/**
> > + * enum rtrs_srv_link_ev - Server link events
> > + * @RTRS_SRV_LINK_EV_CONNECTED:      Connection from client established
> > + * @RTRS_SRV_LINK_EV_DISCONNECTED:   Connection was disconnected, all
> > + *                                   connection RTRS resources were freed.
> > + */
> > +enum rtrs_srv_link_ev {
> > +     RTRS_SRV_LINK_EV_CONNECTED,
> > +     RTRS_SRV_LINK_EV_DISCONNECTED,
> > +};
> > +
> > +/**
> > + * rdma_ev_fn():     Event notification for RDMA operations
> > + *                   If the callback returns a value != 0, an error message
> > + *                   for the data transfer will be sent to the client.
> > +
> > + *   @sess:          Session
> > + *   @priv:          Private data set by rtrs_srv_set_sess_priv()
> > + *   @id:            internal RTRS operation id
> > + *   @dir:           READ/WRITE
> > + *   @data:          Pointer to (bidirectional) rdma memory area:
> > + *                   - in case of %RTRS_SRV_RDMA_EV_RECV contains
> > + *                   data sent by the client
> > + *                   - in case of %RTRS_SRV_RDMA_EV_WRITE_REQ points to the
> > + *                   memory area where the response is to be written to
> > + *   @datalen:       Size of the memory area in @data
> > + *   @usr:           The extra user message sent by the client (%vec)
> > + *   @usrlen:        Size of the user message
> > + */
> > +typedef int (rdma_ev_fn)(struct rtrs_srv *sess, void *priv,
> > +                      struct rtrs_srv_op *id, int dir,
> > +                      void *data, size_t datalen, const void *usr,
> > +                      size_t usrlen);
> > +
> > +/**
> > + * link_ev_fn():     Events about connectivity state changes
> > + *                   If the callback returns != 0 and the event
> > + *                   %RTRS_SRV_LINK_EV_CONNECTED the corresponding session
> > + *                   will be destroyed.
> > + *   @sess:          Session
> > + *   @ev:            event
> > + *   @priv:          Private data from user if previously set with
> > + *                   rtrs_srv_set_sess_priv()
> > + */
> > +typedef int (link_ev_fn)(struct rtrs_srv *sess, enum rtrs_srv_link_ev ev,
> > +                      void *priv);
>
> I don't think that it is good idea to add typedefs to hide function
> callbacks definitions.
>
> Thanks
Hi Leon,

What's the preferred way to do it, could you point me an example?

Thanks!
