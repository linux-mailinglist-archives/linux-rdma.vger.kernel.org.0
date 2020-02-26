Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE524170088
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2020 14:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgBZN4P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Feb 2020 08:56:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:54880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgBZN4P (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 26 Feb 2020 08:56:15 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E27C72467B;
        Wed, 26 Feb 2020 13:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582725374;
        bh=+8Vrvm5qp45n9Zz02tevQMdq8xUVQpAsBI9QsGdqSN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HQq9kyzuWkAXAX+ONscoLQBT4n29q1WtgPoBGipSRUBi/Z9T/pVekneDbMYnljMfe
         Ru/amG/Re4WKYleZ3Mh1yPZI0r/orPzzoviLnL5kbRt6ELiFhyS6qKPBE2XNU++ymo
         B8x/g6v0dOlf0oedGNB2cftb+KZd75ufFHZqgREM=
Date:   Wed, 26 Feb 2020 15:56:11 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     Jens Domke <jens.domke@riken.jp>,
        Haim Boozaglo <haimbo@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: "ibstat -l" displays CA device list in an unsorted order
Message-ID: <20200226135611.GD12414@unreal>
References: <2b43584f-f56a-6466-a2da-43d02fad6b64@mellanox.com>
 <20200225074815.GB5347@unreal>
 <a854a50a-cce3-3a36-9fed-1e5ce3a34669@mellanox.com>
 <20200225091815.GE5347@unreal>
 <52f4364b-30c5-5c62-36bb-78341ca8fe6e@riken.jp>
 <20200225194303.GA12414@unreal>
 <dbb87a79-2edb-b19b-7408-267db7587a5c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbb87a79-2edb-b19b-7408-267db7587a5c@intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 26, 2020 at 08:42:57AM -0500, Dennis Dalessandro wrote:
> On 2/25/2020 2:43 PM, Leon Romanovsky wrote:
> > > I (and highly likely many other admins out there who don't follow this
> > > list) am in full support of Haim's request for sorted output.
> >
> > I don't see any API or utils in the rdma-core which promised to provide
> > sorted output.
>
> That is true, but when sys admins count on things in a certain way and the
> rug gets pulled out from under them that's a headache at best.

I'm not arguing about that and really understand, just don't want people
to develop cargo cult around internal implementation of some tool.

>
> > >
> > > Not everything can/will be pinned down in a manpage, but if you insist
> > > then sure someone can submit a amendment to the ibstat documentation
> > > which demands alphanumeric sorting for the NICs/ports.
> >
> > The manual is not enough, what about other tools? Should we update them
> > too? Or do we need to make ibstat special while rest of the tools keep
> > the list unsorted?
> >
> > Maybe I'm part of the problem, but any solution will require unified
> > approach for whole rdma-core, so users like you will get stable and
> > consistent result from any rdma-core API/tool.
>
> So am I understanding this right, the crux of the problem is the code
> switched from using scandir() via libibumad to readdir(). The later of which
> does not keep the same sorted order?
>
> Maybe let's look at why the change was done in the first place rather than
> arguing over which way it should be. Is there a good reason to go with
> readdir() approach if so then maybe that out weights the inconvenience of
> not getting a sorted list. Or maybe it doesn't.

I sure that Jason will remember more details, but from my point of view,
everything started when we allowed to extend ibstat to look on sysfs
instead of implementing netlink discovery, which will change order
again.

Thanks

>
> -Denny
