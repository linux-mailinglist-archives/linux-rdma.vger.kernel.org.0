Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65CF739A0A
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 03:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfFHBfc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 21:35:32 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37575 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbfFHBfc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 21:35:32 -0400
Received: by mail-qt1-f195.google.com with SMTP id y57so4485063qtk.4
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 18:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UGOATcTaOKAluhrvGNEt0YBuzCUm7BqI1RnepYlBC8A=;
        b=CdkBfA/6OXeGxOQDEpRrnGbh+YU1WVUIiGmE6ObF1BdvREX2rE28bzeff0LPskY6K4
         gH8oEUMS2jzBTG9XsYBCIU0vO1Ux0uZft+Dls2FU0cg84J1T5cWuvC3xVzcnYykyxzb2
         9Sn1gVGHLQLuaEUN/pivXD8Iv84MG+tX2OGN7ZFtplU058T10fMBEfPmBpaRj27D/szU
         6bOagpwU7gtPX7gLQVwEwO3C+KMvBhxC228Opejk20nbMWBEmUpgwzYLo64TfpaORJxD
         zwMpYHDMyYQ27YdaZMzdhHhTd5Jjv2muJmE75OMWYHj+iRrQByu7sYb/LL1vDmWqUmv6
         tinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UGOATcTaOKAluhrvGNEt0YBuzCUm7BqI1RnepYlBC8A=;
        b=pvD5oQuHo7rXKUnlED0lnFjaKdOS9CU3F1KBg45HzlfbvMPjlwsVypwbrKkZkhEKZZ
         t8hh1J5//C8ZZUqE4V2MButN1Nfh2wJBoLvHWiAL+LFINcQlWjyz4nuH7vzKSHuKKou9
         NbGaw6TaZ58vDXVvXItGO4igOi+Yx0S2obfBBznsfzAnXF0DtSMHGFiHb69o0PdtBQYD
         +ZmjMIEoh95eLbR+Xlv2JhMchSJGw+ILDW+hSp6cA6V0cznUH2oRMJ1mSKewlDKShrqW
         /zFznzbrV9dpiJIyshkp2QmGcYLxfysNzlhbynHKlNsxeX0buXKQT3cv8mc96XzlvCI/
         rWZw==
X-Gm-Message-State: APjAAAUKPHwro6bPNxv+b4RGIOd04vg6SbtpZyK8tGyvZR0WOZ2HVMn6
        u0D+mAM/8s3MtR6GLt3b8RtMOA==
X-Google-Smtp-Source: APXvYqz4alB0pyXNzkKNUcsple2Jn80UBKfD2EM61r0Pq/XpSZdlSRxzdhI0YfjDFU7DVO4hGnKzdw==
X-Received: by 2002:ac8:644:: with SMTP id e4mr41209859qth.173.1559957731168;
        Fri, 07 Jun 2019 18:35:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id i55sm2718956qtc.21.2019.06.07.18.35.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 18:35:30 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZQGY-0002CD-9G; Fri, 07 Jun 2019 22:35:30 -0300
Date:   Fri, 7 Jun 2019 22:35:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 12/11] mm/hmm: Fix error flows in
 hmm_invalidate_range_start
Message-ID: <20190608013530.GB7844@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190607160557.GA335@ziepe.ca>
 <439b5731-0b7e-b25b-ce1a-74b34e1f9bf5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439b5731-0b7e-b25b-ce1a-74b34e1f9bf5@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 07, 2019 at 04:52:58PM -0700, Ralph Campbell wrote:
> > @@ -141,6 +142,23 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
> >   	hmm_put(hmm);
> >   }
> > +static void notifiers_decrement(struct hmm *hmm)
> > +{
> > +	lockdep_assert_held(&hmm->ranges_lock);
> > +
> > +	hmm->notifiers--;
> > +	if (!hmm->notifiers) {
> > +		struct hmm_range *range;
> > +
> > +		list_for_each_entry(range, &hmm->ranges, list) {
> > +			if (range->valid)
> > +				continue;
> > +			range->valid = true;
> > +		}
> 
> This just effectively sets all ranges to valid.
> I'm not sure that is best.

This is a trade off, it would be much more expensive to have a precise
'valid = true' - instead this algorithm is precise about 'valid =
false' and lazy about 'valid = true' which is much less costly to
calculate.

> Shouldn't hmm_range_register() start with range.valid = true and
> then hmm_invalidate_range_start() set affected ranges to false?

It kind of does, expect when it doesn't, right? :)

> Then this becomes just wake_up_all() if --notifiers == 0 and
> hmm_range_wait_until_valid() should wait for notifiers == 0.

Almost.. but it is more tricky than that.

This scheme is a collision-retry algorithm. The pagefault side runs to
completion if no parallel invalidate start/end happens.

If a parallel invalidation happens then the pagefault retries.

Seeing notifiers == 0 means there is absolutely no current parallel
invalidation.

Seeing range->valid == true (under the device lock)
means this range doesn't intersect with a parallel invalidate.

So.. hmm_range_wait_until_valid() checks the per-range valid because
it doesn't want to sleep if *this range* is not involved in a parallel
invalidation - but once it becomes involved, then yes, valid == true
implies notifiers == 0.

It is easier/safer to use unlocked variable reads if there is only one
variable, thus the weird construction.

It is unclear to me if this micro optimization is really
worthwhile. It is very expensive to manage all this tracking, and no
other mmu notifier implementation really does something like
this. Eliminating the per-range tracking and using the notifier count
as a global lock would be much simpler...

> Otherwise, range.valid doesn't really mean it's valid.

Right, it doesn't really mean 'valid'

It is tracking possible colliding invalidates such that valid == true
(under the device lock) means that there was no colliding invalidate.

I still think this implementation doesn't quite work, as I described
here:

https://lore.kernel.org/linux-mm/20190527195829.GB18019@mellanox.com/

But the idea is basically sound and matches what other mmu notifier
users do, just using a seqcount like scheme, not a boolean.

Jason
