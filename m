Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59EDB6C16F
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2019 21:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfGQTZe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jul 2019 15:25:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52382 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQTZe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jul 2019 15:25:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so23262595wms.2
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jul 2019 12:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zgfgKQoE31GlOhgKwL/anftZ1NvXrUpDmewe2UclmIw=;
        b=fgdoG7PJ6yKkIPJcOzX9I10yqgxY3YW2BBoaFlISIuJqruXzQHGyqWkx5fg6pAQBc6
         Nva7y6cjEAsP/44GFY6vUydQy/pxGrqSkoBdya3TwF2/Hol/J/UNLPujASlu3guTC9bp
         gTJD8cZa7F22Aq2RsbZyTvh+Akt363UmnRwc6lx1HpI650FsHklaBBC3sidPTWhYb/R/
         RZCxqXOAcYWTXmJvDRSnTarXd6pIEM7+l/WEiwYcHNOs3x2CEtDkqtaE6d1ATeNJY7Tv
         JSE4YYYbLAj8WufOE3cjaoeW8zLRyj2nC0YYj+FI9vwbvwUCwraKW/3fvZXM1tbumojv
         CYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zgfgKQoE31GlOhgKwL/anftZ1NvXrUpDmewe2UclmIw=;
        b=L+BoRawRqOEd0Ry82LA5kyR/inlvZ9dWMpvY/noZtFGKTw++8Am7hvPshpNDuQgUjh
         ucRXOo2BaYfOROg4Paa6GkoB7whfmaOkC5lqJ3dJsKKwYmdsYHHUMlWiLKg1Q/eMl7uU
         15DlmJ+31TvwM4lDol1lf5rERSkv+vIHtrlwIr8118U/P66BMq6sBNa06x5uSgkZj7vU
         5BlHA18rLBho5hPAXCHF6iuHrPje8SKuMimx9y6koRLlwN63/DrbS5CFAsX3I5h/MI+8
         LlfMWf1ZeMLgNLBBpqnym9LwNApR/Zx5WJiGXygGJoNYgYKiKMaN1h7oqC670yMA9c9N
         Wvmw==
X-Gm-Message-State: APjAAAWIHBOet0QFKEkCB5WpIPKWfQfyBlU4fiKMUIrb8SbJ258Z/qcS
        8Rr5YAhELuF87vcFhNyFxuY=
X-Google-Smtp-Source: APXvYqwzWCa+39aogb0cBthiqzBVKGwRlbqUM1F2ZwvdoGMEFqdaUWJsQpsYa6l8B1jtJfvK1p+cnQ==
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr39105584wma.41.1563391531224;
        Wed, 17 Jul 2019 12:25:31 -0700 (PDT)
Received: from shamir-ThinkPad-X240 (85-250-118-146.bb.netvision.net.il. [85.250.118.146])
        by smtp.gmail.com with ESMTPSA id j33sm55948046wre.42.2019.07.17.12.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 12:25:30 -0700 (PDT)
From:   Shamir Rabinovitch <srabinov7@gmail.com>
X-Google-Original-From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Date:   Wed, 17 Jul 2019 22:25:25 +0300
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Shamir Rabinovitch <srabinov7@gmail.com>, dledford@redhat.com,
        leon@kernel.org, monis@mellanox.com, parav@mellanox.com,
        danielj@mellanox.com, kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, johannes.berg@intel.com,
        willy@infradead.org, michaelgur@mellanox.com, markb@mellanox.com,
        yuval.shaia@oracle.com, dan.carpenter@oracle.com,
        bvanassche@acm.org, maxg@mellanox.com, israelr@mellanox.com,
        galpress@amazon.com, denisd@mellanox.com, yuvalav@mellanox.com,
        dennis.dalessandro@intel.com, will@kernel.org, ereza@mellanox.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 08/25] IB/uverbs: ufile must be freed only when not used
 anymore
Message-ID: <20190717192525.GA2515@shamir-ThinkPad-X240>
References: <20190716181200.4239-1-srabinov7@gmail.com>
 <20190716181200.4239-9-srabinov7@gmail.com>
 <20190717115354.GC12119@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717115354.GC12119@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 17, 2019 at 08:53:54AM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 16, 2019 at 09:11:43PM +0300, Shamir Rabinovitch wrote:
> > From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> > 
> > ufile (&ucontext) with the process who own them must not be released
> > when there are other ufile (&ucontext) that depens at them.
> 
> We already have a kref, why do we need more? Especially wrongly done
> refcounts with atomics?

Yes. Will fix in v2.

> 
> Trying to sequence the destroy of the ucontext seems inherently wrong
> to me. If the driver has to link the PD/MR to data in the ucontext it
> can't support sharing.

The issue we try to solve here is this:

[process 1]                     [process 2]
- alloc mr & point mr to        -
  context 1                     
- share context                 -
-                               - import mr
- exit                          -
-- ufile_destroy_ucontext       -
--- ib_mr is not destroyed      -
--- context 1 is destroyed      -
-                               - exit
-                               -- ufile_destroy_ucontext
-                               --- driver dereg_mr is called
-                               ---- ib_umem_release on umem from
                                     previously destroyed context 1

If I recall correctly, you suggested the shere and shree concept.

We also talked with Mellanox architecture team and they suggested
that the shrere will be bullet proof process that *only* create and
share objects.

The whole thing directly links to the next step we talked about 
which is sharing objects via file system rathen then via FD.

> 
> > Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> > Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
> >  drivers/infiniband/core/rdma_core.c   | 29 +++++++++++++++++++++++++++
> >  drivers/infiniband/core/uverbs.h      | 22 ++++++++++++++++++++
> >  drivers/infiniband/core/uverbs_cmd.c  | 16 +++++++++++++++
> >  drivers/infiniband/core/uverbs_main.c |  4 ++++
> >  4 files changed, 71 insertions(+)
> > 
> > diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
> > index 651625f632d7..c81ff8e28fc6 100644
> > +++ b/drivers/infiniband/core/rdma_core.c
> > @@ -841,6 +841,33 @@ static void ufile_destroy_ucontext(struct ib_uverbs_file *ufile,
> >  	ufile->ucontext = NULL;
> >  }
> >  
> > +static void __uverbs_ufile_refcount(struct ib_uverbs_file *ufile)
> > +{
> > +	int wait;
> > +
> > +	if (ufile->parent) {
> > +		pr_debug("%s: release parent ufile. ufile %p parent %p\n",
> > +			 __func__, ufile, ufile->parent);
> > +		if (atomic_dec_and_test(&ufile->parent->refcount))
> > +			complete(&ufile->parent->context_released);
> > +	}
> > +
> > +	if (!atomic_dec_and_test(&ufile->refcount)) {
> > +wait:
> > +		wait = wait_for_completion_interruptible_timeout(
> > +			&ufile->context_released, 3*HZ);
> > +		if (wait == -ERESTARTSYS) {
> > +			WARN_ONCE(1,
> > +			"signal while waiting for context release! ufile %p\n",
> > +				ufile);
> 
> ????
> 
> Jason

I copied the behaviour I saw in the rest of the kernel as for what to do
when wait_for_completion_interruptible_timeout exit due to interrupt.

From the above reason I think we need to delay the shrere process exit
so it will not close the context prematurely *unless* it receive signal.

In that case I'd expect that process to soot some clear warning and do 
whatevere id need to do for the given signal.
