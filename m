Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC05C67317
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 18:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfGLQMY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 12:12:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35808 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfGLQMY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jul 2019 12:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dG6diy7V6S4lK/b3VvWqSMbbXCrffARazC3Zctr1xxs=; b=ctbFyOgLoT6nwqZqoDaaHy2SR
        Q1T4rvUj8j+B6wujCcNEnoaPYyEUBa9JpDZmJ4UHZwDlHqBMbRijWEfZRWSHecs9cUD5XBAcR+s/1
        LIBP6F2cXen0350mqZwY6yvkSDp7J92diHZ5qlt3LzJ/1y/SXyk8zvY1E6DXgO1qcvbqGNIB3uWkg
        5PQlfmC5l+p5VrhDb6yaiOWck5eK45YK61Xgfl2I4OO+vA1FxwB14mG/itQtThPCzb1zBsD89AhxS
        J7NezN6kMe34TtuLlCqZ8odBu3cGKAr13LmL2XDQDMSXrIzaB7z2xi++BFjok9/KJHvSe+ay2BzHW
        IsXeg8elg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hly9d-0006vn-It; Fri, 12 Jul 2019 16:12:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3AA8A209772E8; Fri, 12 Jul 2019 18:12:12 +0200 (CEST)
Date:   Fri, 12 Jul 2019 18:12:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: Re: Re: Re: [PATCH] rdma/siw: avoid smp_store_mb() on a u64
Message-ID: <20190712161212.GW3419@hirez.programming.kicks-ass.net>
References: <20190712144257.GE27512@ziepe.ca>
 <20190712135339.GC27512@ziepe.ca>
 <20190712120328.GB27512@ziepe.ca>
 <20190712085212.3901785-1-arnd@arndb.de>
 <OF05C1A780.433E36D1-ON00258435.003381DA-00258435.003F847E@notes.na.collabserv.com>
 <OF36428621.B839DE8B-ON00258435.00461748-00258435.0047E413@notes.na.collabserv.com>
 <OF3D069E00.E0996A14-ON00258435.004DD8C8-00258435.00502F8C@notes.na.collabserv.com>
 <OF9F46C3F6.DC3E03FF-ON00258435.00521546-00258435.00549C01@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF9F46C3F6.DC3E03FF-ON00258435.00521546-00258435.00549C01@notes.na.collabserv.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 12, 2019 at 03:24:09PM +0000, Bernard Metzler wrote:
> -----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

> Hmmm, I don't yet get why we should test and clear atomically, if we
> clear anyway - is it because we want to avoid clearing a re-arm which
> happens just after testing and before clearing?
> (1) If the test was positive, we will call the CQ event handler,
> and per RDMA verbs spec, the application MUST re-arm the CQ after it
> got a CQ event, to get another one. So clearing it sometimes before
> calling the handler is right.
> (2) If the test was negative, a test and reset would not change
> anything.
> 
> Another complication -- test_and_set_bit() operates on a single
> bit, but we have to test two bits, and reset both, if one is
> set. Can we do that atomically, if we test the bits conditionally?
> I didn't find anything appropriate.

There's cmpxchg() loops that can do that.

	unsigned int new, val = atomic_read(&var);
	do {
		if (!(val & MY_TWO_BITS))
			break;

		new = val | MY_TWO_BITS;
	} while (!atomic_try_cmpxchg(&var, &val, new));

only problem is you probably shouldn't share atomic_t with userspace,
unless you put conditions on what archs you support.

> >And then I think all the weird barriers go away
> >
> >> >> @@ -1141,11 +1145,17 @@ int siw_req_notify_cq(struct ib_cq
> >> >*base_cq, enum ib_cq_notify_flags flags)
> >> >>  	siw_dbg_cq(cq, "flags: 0x%02x\n", flags);
> >> >>  
> >> >>  	if ((flags & IB_CQ_SOLICITED_MASK) == IB_CQ_SOLICITED)
> >> >> -		/* CQ event for next solicited completion */
> >> >> -		smp_store_mb(*cq->notify, SIW_NOTIFY_SOLICITED);
> >> >> +		/*
> >> >> +		 * Enable CQ event for next solicited completion.
> >> >> +		 * and make it visible to all associated producers.
> >> >> +		 */
> >> >> +		smp_store_mb(cq->notify->flags, SIW_NOTIFY_SOLICITED);
> >> >
> >> >But what is the 2nd piece of data to motivate the smp_store_mb?
> >> 
> >> Another core (such as a concurrent RX operation) shall see this
> >> CQ being re-armed asap.
> >
> >'ASAP' is not a '2nd piece of data'. 
> >
> >AFAICT this requirement is just a normal atomic set_bit which does
> >also expedite making the change visible?
> 
> Absolutely!!
> good point....this is just a single flag we are operating on.
> And the weird barrier goes away ;)

atomic ops don't expedite anything, and memory barriers don't make
things happen asap.

That is; the stores from atomic ops can stay in store buffers just like
any other store, and memory barriers don't flush store buffers, they
only impose order between memops.
