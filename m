Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D43F29F236
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 20:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfH0SSz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 14:18:55 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46405 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfH0SSz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Aug 2019 14:18:55 -0400
Received: by mail-qt1-f194.google.com with SMTP id j15so22199485qtl.13
        for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2019 11:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qXbhh/pnDf+18enVCX3uJnS5f7PnvgxlFj/48WlgMgc=;
        b=KQzm3DaQgdLqusxYMVByyTZsDZnc60QtQqY92M2kh7jqHRzHPwkncNBrCrIi2mFqYD
         Sj0NmPCGJQ9Qy4eRBPimXJWmQdDvt2kM6ZOSsEoQxxEjit5CsQor9AqhIZyA2Zj/Wi31
         a3L+nktvqBVoxpIMNzFj2tcc6WW54KldfE9aoL/FMCtOX6FrxugNcg+CSdBpD5lFI19+
         vrCKNeS9jO6u/GvtMzHOAjHpSs1nT99CkLAcprCH1KqpUaf1vO0OVwKNote7kblmU9H6
         7804Xm/ChDw4KZE9nx6A4lYND+tQnZXPId7f8e3/8i0/IITZ1Srvw+JqU0Y7q3Gk4Y0i
         zoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qXbhh/pnDf+18enVCX3uJnS5f7PnvgxlFj/48WlgMgc=;
        b=bHun9kOCpOnXco2tSWmsl3nIEZsvH2gM3cH9fyBjsNIKZ41sAzerrS3Qc7NytY573T
         GlUv8ZgfOmYKA5OIDFCd1tUOqW1MXYkRpo3hMhxuU2T+T4h2NoNoN0NuNX7ilSCGvZJ3
         KK6zapnIljmUG8aIbSBPgnU3M0fIc49r8/PY0qnO/XcBA/SaOaHwgWJzHrNyt08ka5hW
         T85dP7z/tnwuyzg4JYvw/ThUHAFIuuGchhjly1ndkqGctlEc8oMnupc2f2xp+HXRG6U2
         rr6br287RbcozAjVWYeu6njQwmhnuTciI/VeLY0ZZMDyGtpxj4S1Px4m9bzTAnN5Qhj3
         ZKog==
X-Gm-Message-State: APjAAAWTaRnIgZ0RvOcHYdcy3lvEurA0s9BGQ4oTuwOP3h4eP8EJyxeE
        pMMQTegPR1MlIWPTvKcoPF4umw==
X-Google-Smtp-Source: APXvYqzH6fzYwh0ieTaa3TrpKQpj7C0xsP2d9uiCL2er4ukVwyxu1tXs5tKqBggtR8ckfBVUkv4gDQ==
X-Received: by 2002:ac8:6688:: with SMTP id d8mr144938qtp.141.1566929933958;
        Tue, 27 Aug 2019 11:18:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id u13sm77875qkm.97.2019.08.27.11.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 11:18:53 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i2g3Q-0006KS-LD; Tue, 27 Aug 2019 15:18:52 -0300
Date:   Tue, 27 Aug 2019 15:18:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yuval Shaia <yuval.shaia@oracle.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        "kamalheib1@gmail.com" <kamalheib1@gmail.com>,
        Mark Zhang <markz@mellanox.com>,
        "swise@opengridcomputing.com" <swise@opengridcomputing.com>,
        "shamir.rabinovitch@oracle.com" <shamir.rabinovitch@oracle.com>,
        "johannes.berg@intel.com" <johannes.berg@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Israel Rukshin <israelr@mellanox.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        Denis Drozdov <denisd@mellanox.com>,
        Yuval Avnery <yuvalav@mellanox.com>,
        "dennis.dalessandro@intel.com" <dennis.dalessandro@intel.com>,
        "will@kernel.org" <will@kernel.org>,
        Erez Alfasi <ereza@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Shamir Rabinovitch <srabinov7@gmail.com>
Subject: Re: [PATCH v1 05/24] IB/core: ib_uobject need HW object reference
 count
Message-ID: <20190827181852.GF7149@ziepe.ca>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
 <20190821142125.5706-6-yuval.shaia@oracle.com>
 <20190821145324.GB8667@mellanox.com>
 <20190827162813.GA4737@lap1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827162813.GA4737@lap1>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 27, 2019 at 07:28:14PM +0300, Yuval Shaia wrote:
> On Wed, Aug 21, 2019 at 02:53:29PM +0000, Jason Gunthorpe wrote:
> > On Wed, Aug 21, 2019 at 05:21:06PM +0300, Yuval Shaia wrote:
> > > From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> > > 
> > > This new refcnt will points to the refcnt member of the HW object and will
> > > behaves as expected by refcnt, i.e. will be increased and decreased as a
> > > result of usage changes and will destroy the object when reaches to zero.
> > > For a non-shared object refcnt will remain NULL.
> > > 
> > > Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> > > Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
> > >  drivers/infiniband/core/rdma_core.c | 23 +++++++++++++++++++++--
> > >  include/rdma/ib_verbs.h             |  7 +++++++
> > >  2 files changed, 28 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
> > > index ccf4d069c25c..651625f632d7 100644
> > > +++ b/drivers/infiniband/core/rdma_core.c
> > > @@ -516,7 +516,26 @@ static int __must_check destroy_hw_idr_uobject(struct ib_uobject *uobj,
> > >  	const struct uverbs_obj_idr_type *idr_type =
> > >  		container_of(uobj->uapi_object->type_attrs,
> > >  			     struct uverbs_obj_idr_type, type);
> > > -	int ret = idr_type->destroy_object(uobj, why, attrs);
> > > +	static DEFINE_MUTEX(lock);
> > > +	int ret, count;
> > > +
> > > +	mutex_lock(&lock);
> > > +
> > > +	if (uobj->refcnt) {
> > > +		count = atomic_dec_return(uobj->refcnt);
> > > +		WARN_ON(count < 0); /* use after free! */
> > 
> > Use a proper refcount_t
> 
> uobj->refcnt points to HW object's refcnt (e.x ib_pd.refcnt)

Hurm. That refcount is kind of broken/racey as is, I'm not clear if it
can be used for this. More changes would probably be needed..

It would be more understandable to start with a dedicated refcount and
then have a patch to consolidate

> > > +
> > > +	/*
> > > +	 * ib_X HW object sharing support
> > > +	 * - NULL for HW objects that are not shareable
> > > +	 * - Pointer to ib_X reference counter for shareable HW objects
> > > +	 */
> > > +	atomic_t	       *refcnt;		/* ib_X object ref count */
> > 
> > Gross, shouldn't this actually be in the hw object?
> 
> It is belongs to the HW object, this one just *points* to it and it is
> defined here since we like to maintain it when destroy_hw_idr_uobject is
> called.

I mean, you should just extract it from the hw_object directly, some
how. Ie have a get_refcount accessor in the object definition.

Jason
