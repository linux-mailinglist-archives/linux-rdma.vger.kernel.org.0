Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C52896FED7
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 13:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfGVLi6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 07:38:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbfGVLi5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Jul 2019 07:38:57 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82DB42190D;
        Mon, 22 Jul 2019 11:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563795537;
        bh=r+6kMP+pi8wot/n9SQ/wiesCcwZ7eSHlZ9aYDbrRyxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w959WcjIEfWjNnnNv3E/OUqNC9pjroPioDtFzGZGTYjGkHluP8QA0W8ZrFEaJ+zCN
         mfArTkqeONsXbjv7org/4sILjqVIXdE7g67FyRnjvNje6UQcOEOUJo7rFmFthwnjpd
         zcRHcQFnzDeJCoW0CHKANTbi1bXkvCFRa2vt6RsY=
Date:   Mon, 22 Jul 2019 14:38:51 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: Re: rdma-core device memory leak
Message-ID: <20190722113851.GD5125@mtr-leonro.mtl.com>
References: <9c250b8c-df24-7491-deda-ede0b72fd689@amazon.com>
 <20190722091523.GC5125@mtr-leonro.mtl.com>
 <394ed0b6-9f77-d951-5315-fe496d72f9d1@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <394ed0b6-9f77-d951-5315-fe496d72f9d1@amazon.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 22, 2019 at 02:21:18PM +0300, Gal Pressman wrote:
> On 22/07/2019 12:15, Leon Romanovsky wrote:
> > On Mon, Jul 22, 2019 at 11:10:51AM +0300, Gal Pressman wrote:
> >> Hi all,
> >>
> >> I'm seeing memory leaks when running tests with valgrind memcheck tool [1]. It
> >> seems like it's caused due to verbs_device refcount never reaching zero.
> >>
> >> Last related commit is 8125fdeb69bb ("verbs: Avoid ibv_device memory leak"),
> >> which seems like it should prevent this issue - but I'm not sure it covers all
> >> cases.
> >>
> >> When calling ibv_get_device_list, try_driver will eventually get called and set
> >> the device refcount to one. The refcount for each device will be increased when
> >> iterating the devices list, and on each verbs_init_context call.
> >>
> >> In the free flow, the refcount is decreased on verbs_uninit_context and when
> >> iterating the devices list - which brings the refcount back to one, as initially
> >> set by try_driver (hence uninit_device isn't called).
> >>
> >> Is there a reason for initializing refcount to one instead of zero? According to
> >> the cited commit the reference count should be decreased when the device no
> >> longer exists in the sysfs, but the device isn't necessarily removed from the sysfs.
> >
> > Such scheme allows us to avoid rdma-core provider reinitialization every
> > time application "plays" with ibv_get_device_list(). Anyway, the rdma-core
> > library (libibverbs) won't be unloaded till dclose() is called and glibc
> > reference count won't reach zero, so we don't need to release provider
> > till that point of time too.
>
> So you consider these valgrind errors false alarms?

Yes, valgrind checks executed code and unlikely to check unload sequence.
In your case, the unload code wasn't called at all.

Thanks
