Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD8E7980B2
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 18:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfHUQvX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 12:51:23 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42889 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfHUQvW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 12:51:22 -0400
Received: by mail-qt1-f196.google.com with SMTP id t12so3827438qtp.9
        for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2019 09:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sI69GcxYIeQySz6aQGfhAEdB+/UT8SqtsKSz4WX7TLs=;
        b=b6tu599aJwRmxe7tDlFpfB8L7wSMmOUFx6gGwLPqTv/7VkfoJOORt0Ez/6Eswk9xmS
         SbXnxQNzK/Z4IDGKn85mXNk53Bavgc/iq3AwDgf7QHTgfZ/N0XrQx2OwYrYn+SspOEgm
         2Z04tgKfV22rPo3dJ1b3c/u1SEsn3RzwzurNsDIVTpCnGkOUhkl2zO6ZIN8x5u7YCKWF
         V0ufUcJXAOvCYTvvWqrGHSlF9HTBGk0F2mqG+4wnM+GY89k/KCpqMGUzVHAidrzHH7sH
         75/C3hizqIDxyhEszgNcIz5eRYKlAa9oXIu0+8/6coGKWgu1MaxIq+LsRjg/nkGx77iJ
         OZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sI69GcxYIeQySz6aQGfhAEdB+/UT8SqtsKSz4WX7TLs=;
        b=qJmfZOf6OATGapm528OWrfNyA0QcqYu02hqyHZqbkreKhgOFsq8yus78DZvt41txMI
         gDWlUxip50t25KSweMpLDNGJMBYZgC7TKT1G+5kcPBu+O1d9dszhKKOrQGOThoZcZ1xR
         qSHQ1sEc6lKItjEQTtVVFlEUQ0lM9AN04nOLzFcVdNy8/3mmTlZx2ZTb5cauwz7JrwPo
         zL6+9EfHg0yBGLU1O1mgXMqlyx92s6xEfPg0VwWiKpVW9IxyTbr2b3viird9uURHaA5v
         32HEKwzVp9M27Wg4tizH6vUwzzpVWLHzNJcnJ9eXVCVnQByNfB85g9lQFBfiiodC5uOn
         KFRA==
X-Gm-Message-State: APjAAAWWrxPwHTLjyuspO7gUfM+bZlcAEPBrSNuZZ03k8SIJs9mHqtn/
        bQdgkfrzkKnS4m9y8XhKmCGYrA==
X-Google-Smtp-Source: APXvYqyc/dkYytMkTJlBpf5keBjC+rM9cu1qYJ/ynOMAUi8PaH/wJW1u+ihCzAHvLwQ16wxoL59aog==
X-Received: by 2002:ac8:480c:: with SMTP id g12mr29310836qtq.108.1566406281831;
        Wed, 21 Aug 2019 09:51:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id z186sm10851922qkb.2.2019.08.21.09.51.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 09:51:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i0TpR-0005NS-43; Wed, 21 Aug 2019 13:51:21 -0300
Date:   Wed, 21 Aug 2019 13:51:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v7 rdma-next 2/7] RDMA/core: Create mmap
 database and cookie helper functions
Message-ID: <20190821165121.GE8653@ziepe.ca>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <20190820121847.25871-3-michal.kalderon@marvell.com>
 <20190820132125.GC29246@ziepe.ca>
 <MN2PR18MB31821E7411D0E44267F4A256A1AB0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <CH2PR18MB31752BE286837BFDCEE3B17CA1AA0@CH2PR18MB3175.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR18MB31752BE286837BFDCEE3B17CA1AA0@CH2PR18MB3175.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 21, 2019 at 04:47:47PM +0000, Michal Kalderon wrote:
> > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > owner@vger.kernel.org> On Behalf Of Michal Kalderon
> > 
> > > From: Jason Gunthorpe <jgg@ziepe.ca>
> > > Sent: Tuesday, August 20, 2019 4:21 PM
> > >
> > > On Tue, Aug 20, 2019 at 03:18:42PM +0300, Michal Kalderon wrote:
> > > > Create some common API's for adding entries to a xa_mmap.
> > > > Searching for an entry and freeing one.
> > > >
> > > > +
> > > > +/**
> > > > + * rdma_user_mmap_entry_insert() - Allocate and insert an entry to
> > > > +the
> > > mmap_xa.
> > > > + *
> > > > + * @ucontext: associated user context.
> > > > + * @obj: opaque driver object that will be stored in the entry.
> > > > + * @address: The address that will be mmapped to the user
> > > > + * @length: Length of the address that will be mmapped
> > > > + * @mmap_flag: opaque driver flags related to the address (For
> > > > + *           example could be used for cachability)
> > > > + *
> > > > + * This function should be called by drivers that use the
> > > > +rdma_user_mmap
> > > > + * interface for handling user mmapped addresses. The database is
> > > > +handled in
> > > > + * the core and helper functions are provided to insert entries
> > > > +into the
> > > > + * database and extract entries when the user call mmap with the
> > > > +given
> > > key.
> > > > + * The function returns a unique key that should be provided to
> > > > +user, the user
> > > > + * will use the key to map the given address.
> > > > + *
> > > > + * Return: unique key or RDMA_USER_MMAP_INVALID if entry was not
> > > added.
> > > > + */
> > > > +u64 rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext, void
> > > *obj,
> > > > +				u64 address, u64 length, u8 mmap_flag) {
> > > > +	XA_STATE(xas, &ucontext->mmap_xa, 0);
> > > > +	struct rdma_user_mmap_entry *entry;
> > > > +	unsigned long index = 0, index_max;
> > > > +	u32 xa_first, xa_last, npages;
> > > > +	int err, i;
> > > > +	void *ent;
> > > > +
> > > > +	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> > > > +	if (!entry)
> > > > +		return RDMA_USER_MMAP_INVALID;
> > > > +
> > > > +	entry->obj = obj;
> > >
> > > It is more a kernel pattern to have the driver allocate a
> > > rdma_user_mmap_entry and extend it with its 'priv', then use
> > > container_of
> > then would we also want the driver to free the memory ?
> > Or will it be ok to free it using the kref put callback ?
> 
> Jason, I looked into this deeper today, it seems that since the 
> Core is the one handling the reference counting, and eventually
> Freeing the object that it makes more sense to keep the allocation
> In core and not in the drivers, since the driver won't be able to free
> The entry without providing yet an additional callback function to the
> Core to be called once the reference count reaches zero. 

This already added a callback to free the xa_entry, why can't it free
all the memory too when kref goes to 0?

Jason
