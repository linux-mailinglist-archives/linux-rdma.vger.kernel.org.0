Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D9C4630F6
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Nov 2021 11:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhK3K32 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Nov 2021 05:29:28 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57240 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhK3K32 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Nov 2021 05:29:28 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 68A0A1FD54;
        Tue, 30 Nov 2021 10:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638267968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z5xCEVo0syBfMr10VXyOKlSSa7AIkvzHoHu5qOQ831U=;
        b=Ehj/n/0S1aIOtvrf60msYTs9x6aRPhc0h2lYX55ZFZZbAfQoiRCgdqf+1gdszAFP6SHeA7
        lrn/4FQyp1+WZTOnPa5WnmtpdZ5Egr8/HVauwv1n1zyFKUb3UbPtvKIfK2xaZBUcFnP4kU
        gcxYkTyRpgxTb3vPP9eNnmVULxUFtZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638267968;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z5xCEVo0syBfMr10VXyOKlSSa7AIkvzHoHu5qOQ831U=;
        b=JNSZmXxUgK9AdcmXgqwCyTReCETZhPtpITQihG7Hxsceudc7LL9eD+CExzmSZ56W50joba
        E3FlzKVEczHmVpAw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 0C6B2A3B83;
        Tue, 30 Nov 2021 10:26:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7B7FD1E14AC; Tue, 30 Nov 2021 11:26:06 +0100 (CET)
Date:   Tue, 30 Nov 2021 11:26:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 04/14] bfq: use bfq_bic_lookup in bfq_limit_depth
Message-ID: <20211130102606.GA7174@quack2.suse.cz>
References: <20211126115817.2087431-1-hch@lst.de>
 <20211126115817.2087431-5-hch@lst.de>
 <20211129160925.GB29512@quack2.suse.cz>
 <20211130063955.GA10268@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130063955.GA10268@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue 30-11-21 07:39:55, Christoph Hellwig wrote:
> On Mon, Nov 29, 2021 at 05:09:25PM +0100, Jan Kara wrote:
> > On Fri 26-11-21 12:58:07, Christoph Hellwig wrote:
> > > No need to create a new I/O context if there is none present yet in
> > > ->limit_depth.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  block/bfq-iosched.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> > > index c990c6409c119..ecc2e57e68630 100644
> > > --- a/block/bfq-iosched.c
> > > +++ b/block/bfq-iosched.c
> > > @@ -663,7 +663,7 @@ static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
> > >  static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
> > >  {
> > >  	struct bfq_data *bfqd = data->q->elevator->elevator_data;
> > > -	struct bfq_io_cq *bic = icq_to_bic(blk_mq_sched_get_icq(data->q));
> > > +	struct bfq_io_cq *bic = bfq_bic_lookup(data->q);
> > 
> > Maybe I'm missing something but bfq_limit_depth() needs to know to which
> > BFQ queue (and consequently blkcg) this IO is going to be added. And to be
> > able to lookup this queue we are using IO context. So AFAICT we need the
> > IO context allocated already in bfq_limit_depth()?
> 
> But by allocating it you won't now anything, as it will still be empty.

You're right, we'll create only IO context and corresponding bfq_io_cq but
we won't actually create bfqq in bfq_limit_depth() anyway and without that
bfq_limit_depth() isn't going to do more. So your patch indeed does not
change anything in that regard.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
