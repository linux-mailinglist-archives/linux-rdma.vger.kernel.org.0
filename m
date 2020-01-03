Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1421D12F935
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 15:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgACOaS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 09:30:18 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:32813 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbgACOaS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 09:30:18 -0500
Received: by mail-io1-f68.google.com with SMTP id z8so41482437ioh.0
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2020 06:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IF0x8HDxYSbyd1StX/j2ltCeR2flobH/OcU2qnowXrQ=;
        b=XIg7qsrr6uq2OC/1iV7dn0UPk8+6+Fh6HdID37U/rMAb1ZJ8D+7aF1boeLUFhceRYs
         RTT6WscMB7UDLFrKkexDM4H2h24xid4clWXqjOeAj4iZMpbJIfPxb1hyhOj67DhNblYa
         zKWfYMpKhm3QmR6SqkpAkFlylkZqRbfEt+diHBQVXU2WhPEtCjdQiOs2hcYve3GCCXrH
         3SZlOEB2yjBoVULIrX1dfzoNizNEVhQQ3QPvC2zLuAcNwf9pzH0BiceynceAqPDUBHh5
         TTfHUXQ/h14riEdKRMcgIC2XSZLV+eZXGsQ9SAHpK3itweIirmXl04OX6YuXadvk6rCK
         nrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IF0x8HDxYSbyd1StX/j2ltCeR2flobH/OcU2qnowXrQ=;
        b=jd1BljWFbZCxCkl6mRCVJAAwWbORdQs4r9Fv699ErJrO91OyclNoBjvTDAU9PQHpLV
         kQs+TQMCWyiLECBSpLrSlOuBzF8MsmK7K0zRdQai1zd3iZu33taSs4GT+T5jV2iBoREE
         kVferqtpjUOLgNNaWG8iCcKlXi0T8C+SwzLQ+CCoILyUwMzlr8IXk4ut0V1L+M8joDIr
         9G1ADoSAad/LnQncATL1AVxcfhNYjkrNL1Y+ocD3TySmEAfOCUkig1M6FLMHnIDiDUFv
         +9GyCDg6fo5TUx0dvy05sOdLwgv+iwXbISKYBR8yRidurJsrlMleo7ldP9PeF6akEy53
         bhYw==
X-Gm-Message-State: APjAAAXLU2P6270yLVxT27N5Mx8EwZuF/7gf6EjbTPo3oTn5TUfuE5ma
        3yDhsG0B0pgUqbm6ECRtZzM6F+h1hlyJ5K0pXHrGFg==
X-Google-Smtp-Source: APXvYqwkQ95NRCJ1wARUhlDSzFQ2Ct9JKzQCmnJSYGU52CMLZU/y+eN0zmdlMh4rN2IpUx4KWXzXlA23l8i971M99m0=
X-Received: by 2002:a05:6602:25d3:: with SMTP id d19mr48389819iop.217.1578061817138;
 Fri, 03 Jan 2020 06:30:17 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-7-jinpuwang@gmail.com>
 <e242c08f-68e0-49b7-82e6-924d0124b792@acm.org>
In-Reply-To: <e242c08f-68e0-49b7-82e6-924d0124b792@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 3 Jan 2020 15:30:06 +0100
Message-ID: <CAMGffEn3M=E=77z5DqE_sohFuoct=2cctpgTAky6GHkDKGJ2cw@mail.gmail.com>
Subject: Re: [PATCH v6 06/25] rtrs: client: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 31, 2019 at 12:53 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2019-12-30 02:29, Jack Wang wrote:
> > + * InfiniBand Transport Layer
>
> InfiniBand or RDMA?
will fix.
>
> > +MODULE_DESCRIPTION("RTRS Client");
>
> Please spell out RTRS in full.
ok.

>
> > +static const struct rtrs_ib_dev_pool_ops dev_pool_ops;
>
> Can this forward declaration be avoided?
I don't see how to do it easily.

>
> > +static struct rtrs_ib_dev_pool dev_pool = {
> > +     .ops = &dev_pool_ops
> > +};
>
> Can this structure be declared 'const'?
No, it's not const, we also initialize it in rtrs_ib_dev_pool_init
>
> > +static inline struct rtrs_permit *
> > +__rtrs_get_permit(struct rtrs_clt *clt, enum rtrs_clt_con_type con_type)
> > +{
> > +     size_t max_depth = clt->queue_depth;
> > +     struct rtrs_permit *permit;
> > +     int cpu, bit;
> > +
> > +     cpu = get_cpu();
> > +     do {
> > +             bit = find_first_zero_bit(clt->permits_map, max_depth);
> > +             if (unlikely(bit >= max_depth)) {
> > +                     put_cpu();
> > +                     return NULL;
> > +             }
> > +
> > +     } while (unlikely(test_and_set_bit_lock(bit, clt->permits_map)));
> > +     put_cpu();
>
> Are the get_cpu() and put_cpu() calls around this loop useful? If not,
> please remove these calls. Otherwise please add a comment that explains
> the purpose of these calls.
>
> An additional question: is it possible to replace the above loop with an
> sbitmap_get() call?
will check.
>
> > +static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
> > +                           bool notify, bool can_wait)
> > +{
> > +     struct rtrs_clt_con *con = req->con;
> > +     struct rtrs_clt_sess *sess;
> > +     int err;
> > +
> > +     if (WARN_ON(!req->in_use))
> > +             return;
> > +     if (WARN_ON(!req->con))
> > +             return;
> > +     sess = to_clt_sess(con->c.sess);
> > +
> > +     if (req->sg_cnt) {
> > +             if (unlikely(req->dir == DMA_FROM_DEVICE && req->need_inv)) {
> > +                     /*
> > +                      * We are here to invalidate RDMA read requests
> > +                      * ourselves.  In normal scenario server should
> > +                      * send INV for all requested RDMA reads, but
> > +                      * we are here, thus two things could happen:
> > +                      *
> > +                      *    1.  this is failover, when errno != 0
> > +                      *        and can_wait == 1,
> > +                      *
> > +                      *    2.  something totally bad happened and
> > +                      *        server forgot to send INV, so we
> > +                      *        should do that ourselves.
> > +                      */
>
> Please document in the protocol documentation when RDMA reads are used.
We don't use RDMA READ, it's requested RDMA read meaning, server side will do
RDMA write to the buffers.
>
> What does "server forgot to send INV" mean?
Means server side malfunctional/server panic/etc, server didnot sent
SEND_WITH_INV WR,
so client have to do local invalidate.
>
> Additionally, if I remember correctly Jason considers it very important
> that invalidation happens from the submitting context because otherwise
> the RDMA retry mechanism can't work.

>
> > +static void process_io_rsp(struct rtrs_clt_sess *sess, u32 msg_id,
> > +                        s16 errno, bool w_inval)
> > +{
> > +     struct rtrs_clt_io_req *req;
> > +
> > +     if (WARN_ON(msg_id >= sess->queue_depth))
> > +             return;
> > +
> > +     req = &sess->reqs[msg_id];
> > +     /* Drop need_inv if server responsed with invalidation */
> > +     req->need_inv &= !w_inval;
> > +     complete_rdma_req(req, errno, true, false);
> > +}
>
> Please document the meaning of the "w_inval" argument. Please also fix
> the spelling of "responsed".
>
> Thanks,
>
> Bart.
OK, thanks
