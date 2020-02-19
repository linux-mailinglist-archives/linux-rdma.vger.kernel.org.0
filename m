Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 309E3163CF1
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 07:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgBSGOC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 01:14:02 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33173 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgBSGOC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 01:14:02 -0500
Received: by mail-oi1-f193.google.com with SMTP id q81so22773993oig.0
        for <linux-rdma@vger.kernel.org>; Tue, 18 Feb 2020 22:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3w+NpCy4/ndZuEEfIoZcUX1T70vwpMcA7JCQTLTOQf0=;
        b=eAI6wKQkx/n4HuW58SRBAQPbu6XeyTFRyN9nU3JfFgIcE5X2zFQ7Dl4hLTVld0ereF
         axpHO4x8dFFZTj2bhc96kHyoVZM/YwzS5IZgxtkJUJgWF0rNHYTMAHEw5pudFU85zwq4
         2itw4nk/lZmzzWYUj3NfEu40YC76jcOHeAsk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3w+NpCy4/ndZuEEfIoZcUX1T70vwpMcA7JCQTLTOQf0=;
        b=BzlejlVt6DN4sR70fvegZTRDey0L7OrqiBnqGdaI+OWQFA+aJ8TrkQUw/DiD5PYiNJ
         7N0e3OtVVNPJVZ9mSlzRzel8qABeqfsNbkFf30GHmr50oXZDQPXQsGi4XMzqkUtVkO0g
         UO7mCwvT3EJxhYjDYIiYpxGgwYVINY2tZMn0JnlZcz/1Bml15rIbwLKQWExcx6MJ2o+A
         bIwzDrEMKPWE4DpKtPh5eF9UnN3uLxnxAN1YINGj5aX9z7MCFQ7egO38Awps0jO3LXYu
         OWRb8Opzvr1w+9BrBfGENJhc9XviOHHWuR73Y6BV+9aw/3DJpwGPILWv8M40C6uVGt6r
         CyDg==
X-Gm-Message-State: APjAAAX/RQdXSiPHGb+HM/w4ekw/tByfLDk1Xo9/koRNVH9ALW8zI/Iz
        /tGoNvXaUn1O7SoUxpFutw6GBWDsHXdAfnG3kPSUow==
X-Google-Smtp-Source: APXvYqzyun6AStZspo3GqolDGfsWrTwb1dlpp10vLpd3tpVc6nvcu43mdILD1LKs5RhjZMuS7UrOW9dQTva+jaijMiw=
X-Received: by 2002:aca:f0b:: with SMTP id 11mr3817592oip.34.1582092841640;
 Tue, 18 Feb 2020 22:14:01 -0800 (PST)
MIME-Version: 1.0
References: <1582006810-32174-1-git-send-email-selvin.xavier@broadcom.com>
 <1582006810-32174-2-git-send-email-selvin.xavier@broadcom.com>
 <20200218154237.GE31668@ziepe.ca> <CA+sbYW1uO+LT=6a_J-9=yaot8qULbHehY9AummLD2h-kW04nBQ@mail.gmail.com>
 <20200218200320.GG31668@ziepe.ca>
In-Reply-To: <20200218200320.GG31668@ziepe.ca>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Wed, 19 Feb 2020 11:43:50 +0530
Message-ID: <CA+sbYW3J7OWY=RWQ8JR+NqRpRtJmcPE8RvsQ5PFf9dCOwjx-QA@mail.gmail.com>
Subject: Re: [PATCH for-next v3 1/2] RDMA/core: Add helper function to
 retrieve driver gid context from gid attr
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 19, 2020 at 1:33 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Feb 18, 2020 at 10:12:17PM +0530, Selvin Xavier wrote:
> > On Tue, Feb 18, 2020 at 9:12 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Mon, Feb 17, 2020 at 10:20:09PM -0800, Selvin Xavier wrote:
> > > > Adding a helper function to retrieve the driver gid context
> > > > from the gid attr.
> > > >
> > > > Suggested-by: Jason Gunthorpe <jgg@mellanox.com>
> > > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > >  drivers/infiniband/core/cache.c | 41 +++++++++++++++++++++++++++++++++++++++++
> > > >  include/rdma/ib_cache.h         |  1 +
> > > >  2 files changed, 42 insertions(+)
> > > >
> > > > diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> > > > index 17bfedd..1b73a71 100644
> > > > +++ b/drivers/infiniband/core/cache.c
> > > > @@ -973,6 +973,47 @@ int rdma_query_gid(struct ib_device *device, u8 port_num,
> > > >  EXPORT_SYMBOL(rdma_query_gid);
> > > >
> > > >  /**
> > > > + * rdma_read_gid_hw_context - Read the HW GID context from GID attribute
> > > > + * @attr:            Potinter to the GID attribute
> > > > + *
> > > > + * rdma_read_gid_hw_context() reads the vendor drivers GID HW
> > > > + * context corresponding to SGID attr. It takes reference to the GID
> > > > + * attribute and this need to be released by the caller using
> > > > + * rdma_put_gid_attr
> > > > + *
> > > > + * Returns HW context on success or NULL on error
> > > > + *
> > > > + */
> > > > +void *rdma_read_gid_hw_context(const struct ib_gid_attr *attr)
> > > > +{
> > > > +     struct ib_gid_table_entry *entry =
> > > > +             container_of(attr, struct ib_gid_table_entry, attr);
> > > > +     struct ib_device *device = entry->attr.device;
> > > > +     u8 port_num = entry->attr.port_num;
> > > > +     struct ib_gid_table *table;
> > > > +     unsigned long flags;
> > > > +     void *context = NULL;
> > > > +
> > > > +     if (!rdma_is_port_valid(device, port_num))
> > > > +             return NULL;
> > > > +
> > > > +     table = rdma_gid_table(device, port_num);
> > > > +     read_lock_irqsave(&table->rwlock, flags);
> > > > +
> > > > +     if (attr->index < 0 || attr->index >= table->sz ||
> > > > +         !is_gid_entry_valid(table->data_vec[attr->index]))
> > > > +             goto done;
> > >
> > > Why all this validation and locking? ib_gid_attrs are only created by
> > > the core code..
> > Locking and validation was added to avoid any scenario where the  gid
> > entry is deleted while we are
> > executing this API. I saw similar implementation for
> > rdma_read_gid_attr_ndev_rcu symbol.
>
> This is required to deref the ndev as GID_TABLE_ENTRY_PENDING_DEL no
> longer has the ndev memory.
>
> However here things are not derefing the ndev, there is no reason to
> check this. The driver state attached to a gid entry should always be
> valid so long as the pointer is valid. This is the entire point of the
> refcounting scheme.
>
> > > > +     get_gid_entry(entry);
> > >
> > > And why a get? Surely it is invalid to call this function without a
> > > get already held?
> > Getting the reference to the entry only if the entry is valid after
> > all the checks. This is the
> > reason for invoking this inside the function, rather than in the
> > caller. Added a note in the symbol description
> > that the caller needs to release reference using rdma_put_gid_attr,
> > once the caller finished using
> > the void * pointer returned.
>
> That makes no sense, we already *must* have a get at this point or the
> whole thing is really buggy
>
Got it now. I missed the fact that the ref is taken in
rdma_fill_sgid_attr for both
create_ah and modify_qp contexts. Thanks for your explanation.

I will respin the patch.

Thanks,
Selvin
> Jason
