Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18F5210936B
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2019 19:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfKYSWI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Nov 2019 13:22:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:60530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfKYSWH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Nov 2019 13:22:07 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79F0D207FD;
        Mon, 25 Nov 2019 18:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574706127;
        bh=8wjD4xLR6l5PdwwRxLdEXRISUlqlaeFySzrkBWKcER4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jBZZRs4tAgGZH0PMiQ/2C+1QON1weejjf+70o7qnNldsJI0GM4/A1Q/C8ZBlcTutL
         eGAm+Kl8DAz8EA8rl77p55S1W0L38ru9mGnHifuQ0oobPwHworleiZAbZDkDYoy+FK
         9zM7CUyy0zJH41njYyCVmvj/u0jL2W4gQrtsmiQg=
Date:   Mon, 25 Nov 2019 20:22:03 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-next v1 04/48] RDMA/cm: Add SET/GET implementations
 to hide IBA wire format
Message-ID: <20191125182203.GA201922@unreal>
References: <20191121181313.129430-1-leon@kernel.org>
 <20191121181313.129430-5-leon@kernel.org>
 <20191121203836.GK7481@mellanox.com>
 <20191122065509.GC136476@unreal>
 <20191125144028.GX7481@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125144028.GX7481@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 25, 2019 at 02:40:33PM +0000, Jason Gunthorpe wrote:
> On Fri, Nov 22, 2019 at 08:55:09AM +0200, Leon Romanovsky wrote:
> > On Thu, Nov 21, 2019 at 08:38:40PM +0000, Jason Gunthorpe wrote:
> > > On Thu, Nov 21, 2019 at 08:12:29PM +0200, Leon Romanovsky wrote:
> > > > +#define _IBA_GET_MEM(field_struct, field_offset, byte_size, ptr, out, bytes)   \
> > > > +	({                                                                     \
> > > > +		WARN_ON(bytes > byte_size);                                    \
> > > > +		if (out && bytes) {                                            \
> > >
> > > Why check for null? Caller should handle
> > >
> > > > +			const field_struct *_ptr = ptr;                        \
> > > > +			memcpy(out, (void *)_ptr + (field_offset), bytes);     \
> > > > +		}                                                              \
> > > > +	})
> > > > +#define IBA_GET_MEM(field, ptr, out, bytes) _IBA_GET_MEM(field, ptr, out, bytes)
> > >
> > > This should really have some type safety, ie check that out is
> > > something like 'struct ibv_guid *'a
> >
> > This GET_MEM is not used yet, because I didn't find a way to model
> > properly access to private_data, ari, info and GIDs at the same time.
>
> I'm surprised we don't access the GIDs, how does that work?

Never mind, we are talking about different things.

>
> Jason
