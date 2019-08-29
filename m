Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 642A3A1A4B
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2019 14:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfH2Mky (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Aug 2019 08:40:54 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41733 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfH2Mky (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Aug 2019 08:40:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id i4so3433601qtj.8
        for <linux-rdma@vger.kernel.org>; Thu, 29 Aug 2019 05:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W6McVuntShI0ZBjP355k37kdEByszCEWrlO/NXjYE78=;
        b=mwBLdQoggzkImXM4whgsjjH6yy0P2C4oGplh/sTWQGImvJJVlEUMX6fgzeJGFqa2/G
         09dRYBWbVPpznJwmtborugU7aZTB+uIw9Lg8sR5YF/c/2ZfFWujl0lJ1wnKc08tjzPM7
         RLy3Q0jXyegaEdoZYa0C2BSnmojYY6MUR2lIxKu8OOVSkLexbsV/ks6/D4ZQmarSCgch
         RaQaijFhbLTUMpdbG1ewkPTncogEnzkdqqR1KdteGX1VqIHFRIvhP9Ed2hZmUSXl+/NU
         f+LkQRU/59wzLzqDRjJP/GToGnpoUIE7J4yRTAZVeqxUTJCrSA/20vj0rBdBlxqkdQQG
         KU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W6McVuntShI0ZBjP355k37kdEByszCEWrlO/NXjYE78=;
        b=l88rhjGwUo9AF8EdemQLQEuXCL7vFAbzjs66V0s6iNthzYwQLE59XxzGjHM3b9Yq7P
         quSJpiVo1/AvzOufjEuUV3KcxVp1WnMaxNN9LdW/A1d5KKQCrMIzBylsIvspde37cjYZ
         8gWrlf/Xk0enyH55i2kVepXDXP0CSjOWDNDVTTyLYEe55EAfOud7i/2z8H5oE1HKa1+2
         fmXBY2VBmjURd3xWfEwQnXv/0r+c8aNNky6mqEnXOTBZDhHD8Jgdds7r+8X6dNKQmeLT
         YMls2WPblJdNkQC7sIqBPwOA3K7fM/GdKr1dhTbBPBzVJJvKn+ZOANJGmIVX+t3j6h0h
         +ngg==
X-Gm-Message-State: APjAAAV400aJconmPeo8VRaf3LyT3iKMbfTIIYiZ3MiATdyr7sFje6Jc
        06UtUoMHQUaEw+Uyy1FDqt/Vpw==
X-Google-Smtp-Source: APXvYqzrravAnh0QNP+TUUPvKWLhwjF/rzTOXpUze4yL2pif7vMUz+lGh6kq2vssDEIkG4b9WWxHnQ==
X-Received: by 2002:ac8:614c:: with SMTP id d12mr9513062qtm.178.1567082453306;
        Thu, 29 Aug 2019 05:40:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id y1sm1111324qti.49.2019.08.29.05.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Aug 2019 05:40:52 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i3JjQ-0005GL-94; Thu, 29 Aug 2019 09:40:52 -0300
Date:   Thu, 29 Aug 2019 09:40:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Michal Kalderon <michal.kalderon@marvell.com>,
        mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
        bmt@zurich.ibm.com, sleybo@amazon.com, leon@kernel.org,
        linux-rdma@vger.kernel.org, Ariel Elior <ariel.elior@marvell.com>
Subject: Re: [PATCH v8 rdma-next 2/7] RDMA/core: Create mmap database and
 cookie helper functions
Message-ID: <20190829124052.GA17115@ziepe.ca>
References: <20190827132846.9142-1-michal.kalderon@marvell.com>
 <20190827132846.9142-3-michal.kalderon@marvell.com>
 <4d80bab8-d48c-70b3-52ba-494c98e8a349@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d80bab8-d48c-70b3-52ba-494c98e8a349@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 29, 2019 at 02:35:45PM +0300, Gal Pressman wrote:
> On 27/08/2019 16:28, Michal Kalderon wrote:
> > +/**
> > + * rdma_user_mmap_entry_get() - Get an entry from the mmap_xa.
> > + *
> > + * @ucontext: associated user context.
> > + * @key: the key received from rdma_user_mmap_entry_insert which
> > + *     is provided by user as the address to map.
> > + * @len: the length the user wants to map.
> > + * @vma: the vma related to the current mmap call.
> > + *
> > + * This function is called when a user tries to mmap a key it
> > + * initially received from the driver. The key was created by
> > + * the function rdma_user_mmap_entry_insert. The function should
> > + * be called only once per mmap. It initializes the vma and
> > + * increases the entries ref-count. Once the memory is unmapped
> > + * the ref-count will decrease. When the refcount reaches zero
> > + * the entry will be deleted.
> > + *
> > + * Return an entry if exists or NULL if there is no match.
> > + */
> > +struct rdma_user_mmap_entry *
> > +rdma_user_mmap_entry_get(struct ib_ucontext *ucontext, u64 key, u64 len,
> > +			 struct vm_area_struct *vma)
> > +{
> > +	struct rdma_user_mmap_entry *entry;
> > +	u64 mmap_page;
> > +
> > +	mmap_page = key >> PAGE_SHIFT;
> > +	if (mmap_page > U32_MAX)
> > +		return NULL;
> > +
> > +	entry = xa_load(&ucontext->mmap_xa, mmap_page);
> > +	if (!entry)
> > +		return NULL;
> 
> I'm probably missing something, what happens if an insertion is done, a get is
> called and right at this point (before kref_get) the entry is being removed (and
> freed by the driver)?

Yes, things are wrong here.. It should hold xa_lock to protect entry
until the kref is obtained and this must use kref_get_unless_zero() as
the kref could be 0 while still in the xarray.

> > +	for (i = 0; i < entry->npages; i++) {
> > +		xa_erase(&ucontext->mmap_xa, entry->mmap_page + i);

This is better to use __xa_erase and hold the xa_lock outside the loop

> > +	/* We want the whole allocation to be done without interruption
> > +	 * from a different thread. The allocation requires finding a
> > +	 * free range and storing. During the xa_insert the lock could be
> > +	 * released, we don't want another thread taking the gap.
> > +	 */
> > +	mutex_lock(&ufile->umap_lock);
> > +
> > +	xa_lock(&ucontext->mmap_xa);
> 
> Doesn't the mutex replace the xa_lock?

No, absolutely not. xarray must hold its internal lock when
required. The external lock is only about protecting the contents

I'm not sure why this needs to hold this mutex, the spinlock looks OK.

> > +
> > +	/* We want to find an empty range */
> > +	npages = (u32)DIV_ROUND_UP(length, PAGE_SIZE);
> > +	entry->npages = npages;
> > +	do {
> > +		/* First find an empty index */
> > +		xas_find_marked(&xas, U32_MAX, XA_FREE_MARK);
> > +		if (xas.xa_node == XAS_RESTART)
> > +			goto err_unlock;
> > +
> > +		xa_first = xas.xa_index;
> > +
> > +		/* Is there enough room to have the range? */
> > +		if (check_add_overflow(xa_first, npages, &xa_last))
> > +			goto err_unlock;
> > +
> > +		/* Now look for the next present entry. If such doesn't
> > +		 * exist, we found an empty range and can proceed
> > +		 */
> > +		xas_next_entry(&xas, xa_last - 1);
> > +		if (xas.xa_node == XAS_BOUNDS || xas.xa_index >= xa_last)
> > +			break;
> > +		/* o/w look for the next free entry */
> > +	} while (true);

while(true) not do/while is the usual convention

Jason
