Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF10E461B9A
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Nov 2021 17:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242525AbhK2QOq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Nov 2021 11:14:46 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51980 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbhK2QMo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Nov 2021 11:12:44 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 94C3F1FCA1;
        Mon, 29 Nov 2021 16:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638202165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dlR9rlDvG2U7ujaNwRk+7nvnEIkWhGGTTtizeJOJEAg=;
        b=uAzB3SZnqEyc9NrTEvDsGi8r77PTjkxxWJ7BuFQhbfnSSe+IERGRMZE9lOfqJ6o9J2DzLC
        AXuqsnc2todWHYS4tFIb63uFMr61GrirXxcLrHpzb35OTD1vKDi+OCgMRwuT4pk0TuhMGq
        54ErrrSYI9SBtb1l3JNGYdG2RKkxx6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638202165;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dlR9rlDvG2U7ujaNwRk+7nvnEIkWhGGTTtizeJOJEAg=;
        b=y1NfIGreYeU1F2IEd9GZsuD3PbLo10m25VszRjMz3aFzpqul9iiMiD16BJybcSML9Fkm/x
        +Dt8hXSoyI/zbJAg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 858E3A3B85;
        Mon, 29 Nov 2021 16:09:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 480761E13A9; Mon, 29 Nov 2021 17:09:25 +0100 (CET)
Date:   Mon, 29 Nov 2021 17:09:25 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 04/14] bfq: use bfq_bic_lookup in bfq_limit_depth
Message-ID: <20211129160925.GB29512@quack2.suse.cz>
References: <20211126115817.2087431-1-hch@lst.de>
 <20211126115817.2087431-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126115817.2087431-5-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri 26-11-21 12:58:07, Christoph Hellwig wrote:
> No need to create a new I/O context if there is none present yet in
> ->limit_depth.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bfq-iosched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index c990c6409c119..ecc2e57e68630 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -663,7 +663,7 @@ static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
>  static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
>  {
>  	struct bfq_data *bfqd = data->q->elevator->elevator_data;
> -	struct bfq_io_cq *bic = icq_to_bic(blk_mq_sched_get_icq(data->q));
> +	struct bfq_io_cq *bic = bfq_bic_lookup(data->q);

Maybe I'm missing something but bfq_limit_depth() needs to know to which
BFQ queue (and consequently blkcg) this IO is going to be added. And to be
able to lookup this queue we are using IO context. So AFAICT we need the
IO context allocated already in bfq_limit_depth()?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
