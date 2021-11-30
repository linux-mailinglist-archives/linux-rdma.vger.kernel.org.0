Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A33462CE8
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Nov 2021 07:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbhK3GnR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Nov 2021 01:43:17 -0500
Received: from verein.lst.de ([213.95.11.211]:57112 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233768AbhK3GnR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Nov 2021 01:43:17 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5AB1C68B05; Tue, 30 Nov 2021 07:39:55 +0100 (CET)
Date:   Tue, 30 Nov 2021 07:39:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 04/14] bfq: use bfq_bic_lookup in bfq_limit_depth
Message-ID: <20211130063955.GA10268@lst.de>
References: <20211126115817.2087431-1-hch@lst.de> <20211126115817.2087431-5-hch@lst.de> <20211129160925.GB29512@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129160925.GB29512@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 29, 2021 at 05:09:25PM +0100, Jan Kara wrote:
> On Fri 26-11-21 12:58:07, Christoph Hellwig wrote:
> > No need to create a new I/O context if there is none present yet in
> > ->limit_depth.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  block/bfq-iosched.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> > index c990c6409c119..ecc2e57e68630 100644
> > --- a/block/bfq-iosched.c
> > +++ b/block/bfq-iosched.c
> > @@ -663,7 +663,7 @@ static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
> >  static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
> >  {
> >  	struct bfq_data *bfqd = data->q->elevator->elevator_data;
> > -	struct bfq_io_cq *bic = icq_to_bic(blk_mq_sched_get_icq(data->q));
> > +	struct bfq_io_cq *bic = bfq_bic_lookup(data->q);
> 
> Maybe I'm missing something but bfq_limit_depth() needs to know to which
> BFQ queue (and consequently blkcg) this IO is going to be added. And to be
> able to lookup this queue we are using IO context. So AFAICT we need the
> IO context allocated already in bfq_limit_depth()?

But by allocating it you won't now anything, as it will still be empty.
