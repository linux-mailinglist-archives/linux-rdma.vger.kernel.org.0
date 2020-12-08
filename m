Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB6E2D26A7
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Dec 2020 09:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgLHIyu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Dec 2020 03:54:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbgLHIyu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Dec 2020 03:54:50 -0500
Date:   Tue, 8 Dec 2020 10:54:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607417650;
        bh=MKC6KVhrrYBpiXxY8tJkTlnEwtylEBVG+VORhKfwla0=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=bOa0vJTmr/z1c9mK1LLNgXIvssBw4bwG+LOGS6SIZQ3xtqB9myJaxqv0Tq0/n9qrr
         MoHJoqVfB4ua3K9PHnASf2X1+qWLug81JvGisj7k9jTR0d560LdniiKSy7xqYp8U0z
         FSGwInz7e5cEyiJjImaI2WX3DMQ0SuAeOt1LWyWfPvPmsZlmQD03rlgV/9Psl3E+YU
         InAJ9FBLmbjUX+5Nfu5Btns7MEuvt8FM3apQ03hjvGZ0Tmoej6d8RPIl+BWKMoacwQ
         W244blajCHG8hfxfUipXsldr24maCxCD2UcA/b/iVMmZJTY13ekuqWhvozmofpx8ot
         TAibGmV0PDt+w==
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 3/3] RDMA/uverbs: Fix incorrect variable type
Message-ID: <20201208085405.GH4430@unreal>
References: <20201208073545.9723-1-leon@kernel.org>
 <20201208073545.9723-4-leon@kernel.org>
 <20201208075539.GA2789@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208075539.GA2789@kadam>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 08, 2020 at 10:55:39AM +0300, Dan Carpenter wrote:
> On Tue, Dec 08, 2020 at 09:35:45AM +0200, Leon Romanovsky wrote:
> > @@ -336,19 +335,16 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_GID_TABLE)(
> >  		attrs, UVERBS_ATTR_QUERY_GID_TABLE_RESP_ENTRIES,
> >  		user_entry_size);
> >  	if (max_entries <= 0)
> > -		return -EINVAL;
> > +		return max_entries ?: -EINVAL;
> >
> >  	ucontext = ib_uverbs_get_ucontext(attrs);
> >  	if (IS_ERR(ucontext))
> >  		return PTR_ERR(ucontext);
> >  	ib_dev = ucontext->device;
> >
> > -	if (check_mul_overflow(max_entries, sizeof(*entries), &num_bytes))
> > -		return -EINVAL;
> > -
> > -	entries = uverbs_zalloc(attrs, num_bytes);
> > -	if (!entries)
> > -		return -ENOMEM;
> > +	entries = uverbs_kcalloc(attrs, max_entries, sizeof(*entries));
> > +	if (IS_ERR(entries))
> > +		return PTR_ERR(entries);
>
> This isn't right.  The uverbs_kcalloc() should match every other
> kcalloc() function and return NULL on error.  This actually buggy
> because it returns both is error pointers and NULL so it will lead to
> a NULL dereference.

The actual bug was before, when an error result from uverbs_zalloc()
was treated as NULL. The uverbs_kcalloc/uverbs_zalloc will call to
_uverbs_alloc() that doesn't return NULL.

>
> Btw, when a function returns both error pointers and NULL the NULL
> return means that the feature has been deliberately disabled.  It's not
> an error pointer because it's deliberate.
>
> regards,
> dan carpenter
>
> >
> >  	num_entries = rdma_query_gid_table(ib_dev, entries, max_entries);
> >  	if (num_entries < 0)
> > diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
> > index bf167ef6c688..39ef204753ec 100644
> > --- a/include/rdma/uverbs_ioctl.h
> > +++ b/include/rdma/uverbs_ioctl.h
> > @@ -865,6 +865,16 @@ static inline __malloc void *uverbs_zalloc(struct uverbs_attr_bundle *bundle,
> >  {
> >  	return _uverbs_alloc(bundle, size, GFP_KERNEL | __GFP_ZERO);
> >  }
> > +
> > +static inline __malloc void *uverbs_kcalloc(struct uverbs_attr_bundle *bundle,
> > +					    size_t n, size_t size)
> > +{
> > +	size_t bytes;
> > +
> > +	if (unlikely(check_mul_overflow(n, size, &bytes)))
> > +		return ERR_PTR(-EOVERFLOW);
> > +	return uverbs_zalloc(bundle, bytes);
> > +}
> >  int _uverbs_get_const(s64 *to, const struct uverbs_attr_bundle *attrs_bundle,
> >  		      size_t idx, s64 lower_bound, u64 upper_bound,
> >  		      s64 *def_val);
> > --
> > 2.28.0
