Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85C8AB3462
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2019 07:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfIPF1e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Sep 2019 01:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfIPF1e (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Sep 2019 01:27:34 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 446AC2067B;
        Mon, 16 Sep 2019 05:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568611652;
        bh=5V0xxOh8NLjEKs+yRiSk0RdBVTcGkJjjPD1bZy3GmEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dOVmpJ/egQuUlM1hhw//+VgIGm6GlLI8BFCF9LWaLVLUnTo9j56CJ36dlQFvHQEJX
         I+8Z912w6C2UFt4sStOxDq2+t2mTYVGHVPqkQKbMDiZPDSxR7iSX/ijEXJL7XRmv43
         QYLqe06LxJtl18H35qH0FAA62Q2vDt7nbdtSHVYA=
Date:   Mon, 16 Sep 2019 08:27:29 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>
Subject: Re: [PATCH v4 15/25] ibnbd: private headers with IBNBD protocol
 structs and helpers
Message-ID: <20190916052729.GB18203@unreal>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-16-jinpuwang@gmail.com>
 <4fbad80b-f551-131e-9a5c-a24f1fa98fea@acm.org>
 <CAMGffEnVFHpmDCiazHFX1jwi4=p401T9goSkes3j1AttV0t1Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEnVFHpmDCiazHFX1jwi4=p401T9goSkes3j1AttV0t1Ng@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 15, 2019 at 04:30:04PM +0200, Jinpu Wang wrote:
> Thanks Bart for detailed review, reply inline.
>
> On Sat, Sep 14, 2019 at 12:10 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >
> > On 6/20/19 8:03 AM, Jack Wang wrote:
> > > +#define ibnbd_log(fn, dev, fmt, ...) ({                              \
> > > +     __builtin_choose_expr(                                          \
> > > +             __builtin_types_compatible_p(                           \
> > > +                     typeof(dev), struct ibnbd_clt_dev *),           \
> > > +             fn("<%s@%s> " fmt, (dev)->pathname,                     \
> > > +             (dev)->sess->sessname,                                  \
> > > +                ##__VA_ARGS__),                                      \
> > > +             __builtin_choose_expr(                                  \
> > > +                     __builtin_types_compatible_p(typeof(dev),       \
> > > +                                     struct ibnbd_srv_sess_dev *),   \
> > > +                     fn("<%s@%s>: " fmt, (dev)->pathname,            \
> > > +                        (dev)->sess->sessname, ##__VA_ARGS__),       \
> > > +                     unknown_type()));                               \
> > > +})
> >
> > Please remove the __builtin_choose_expr() /
> > __builtin_types_compatible_p() construct and split this macro into two
> > macros or inline functions: one for struct ibnbd_clt_dev and another one
> > for struct ibnbd_srv_sess_dev.
> Ok, will split to two macros.
>
> >
> > > +#define IBNBD_PROTO_VER_MAJOR 2
> > > +#define IBNBD_PROTO_VER_MINOR 0
> > > +
> > > +#define IBNBD_PROTO_VER_STRING __stringify(IBNBD_PROTO_VER_MAJOR) "." \
> > > +                            __stringify(IBNBD_PROTO_VER_MINOR)
> > > +
> > > +#ifndef IBNBD_VER_STRING
> > > +#define IBNBD_VER_STRING __stringify(IBNBD_PROTO_VER_MAJOR) "." \
> > > +                      __stringify(IBNBD_PROTO_VER_MINOR)
> >
> > Upstream code should not have a version number.
> IBNBD_VER_STRING can be removed together with MODULE_VERSION.
> >
> > > +/* TODO: should be configurable */
> > > +#define IBTRS_PORT 1234
> >
> > How about converting this macro into a kernel module parameter?
> Sounds good, will do.

Don't rush to do it and defer it to be the last change before merging,
this is controversial request which not everyone will like here.

Thanks
