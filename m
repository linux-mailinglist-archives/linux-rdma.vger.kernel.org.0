Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FC24631D6
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Nov 2021 12:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbhK3LNN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Nov 2021 06:13:13 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:48244 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237212AbhK3LNL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Nov 2021 06:13:11 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9B8A82170C;
        Tue, 30 Nov 2021 11:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638270581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wbsFCrlaCNIiei6i9NjlZM3Pbtz2W7UBXNwVzac9ddg=;
        b=y1oEmd8F/ewZMTrDi/AJJIGbjwYGm1A71Z5biF+P4D94Mu69IpL9T9xslKbTLtJbrc5y8H
        Q9ygrf5Xdo9XV7HlpehgFcKI27TiuOuxLzdhqsKhKxO4oCNHpp4dyCQHVDRDEAAoodPcvA
        aaLRKWVJSkJi2d2LATH1EvgzIkc1JPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638270581;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wbsFCrlaCNIiei6i9NjlZM3Pbtz2W7UBXNwVzac9ddg=;
        b=5Ls7osqyqNo4nUavg2oJ8nJlsJolrTDlP8irv7GiT9urdpHAjWKCChYhfLWqWBr4blxTKN
        YWtc13oaGbvSlPCA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 6E1ACA3B84;
        Tue, 30 Nov 2021 11:09:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B5B381F2CAE; Tue, 30 Nov 2021 12:09:35 +0100 (CET)
Date:   Tue, 30 Nov 2021 12:09:35 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        linux-rdma@vger.kernel.org, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Subject: Re: cleanup I/O context handling
Message-ID: <20211130110935.GD7174@quack2.suse.cz>
References: <20211126115817.2087431-1-hch@lst.de>
 <163802042046.623756.9169975969414207413.b4-ty@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163802042046.623756.9169975969414207413.b4-ty@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat 27-11-21 06:40:20, Jens Axboe wrote:
> On Fri, 26 Nov 2021 12:58:03 +0100, Christoph Hellwig wrote:
> > this series does a little spring cleaning of the I/O context handling/
> > 
> > Subject:
> >  block/bfq-iosched.c                   |   41 ++++++------
> >  block/blk-ioc.c                       |  115 +++++++++++++++++++++++++---------
> >  block/blk-mq-sched.c                  |   35 ----------
> >  block/blk-mq-sched.h                  |    3
> >  block/blk-mq.c                        |   14 ----
> >  block/blk.h                           |    8 --
> >  drivers/infiniband/hw/qib/qib_verbs.c |    4 -
> >  include/linux/iocontext.h             |   40 +++--------
> >  kernel/fork.c                         |   26 -------
> >  9 files changed, 128 insertions(+), 158 deletions(-)
> > 
> > [...]
> 
> Applied, thanks!

FWIW I've read the whole series now and it looks good to me so feel free to
add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
