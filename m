Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E295162AE1
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 17:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgBRQma (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 11:42:30 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34737 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgBRQm3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 11:42:29 -0500
Received: by mail-oi1-f196.google.com with SMTP id l136so20744635oig.1
        for <linux-rdma@vger.kernel.org>; Tue, 18 Feb 2020 08:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A7A6iDXmfs2xZ9SnKZnyK6vKkCLvqLQ/7Y4o70dQrIQ=;
        b=HEnnp3kEYpam/D3Fz4reD6nms4QiJgh7gLUMiNqgbYkzG9aNzaf1H7S35ogYCXk7im
         RTwEZA9j5CvowL9xnRkOcHXCvT+iQ+Thr81iUCCWUlb/8wAmDhOFWaUdotkDBux03Jrd
         bqA9IgEitt5Yb8mSPBQ5fJh86BN+FHilCoEZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A7A6iDXmfs2xZ9SnKZnyK6vKkCLvqLQ/7Y4o70dQrIQ=;
        b=paz9FpTZyDSPued5M7P0uAliXhpu4dkl3i98PwtDoU8BcrCbV0w90e5j056B5I4OBJ
         8ynS8RvL9jnFfk00Tl3aHA2r5Tl5Hvf3aeGrLhIct+NOsRIv+J0GgLhjLhKbK2Vhhx0o
         3pQsIPodmGODQpWkImO4n6JoufVg6JUHlzHyo5Asdu4oDup+deiOOQLzXz6zo3SQ4Ufl
         mTMhb7tTtKFKG5H5kdY1yj+UxLZiazScxmPKozTj8PyJ1bQLf9XOislx7tyZ8tpU6NRJ
         AMdge/nBLjhBcebnrhFwxSWNR99QOZmUFADUk611mWUmcwzWRyABlRZNGJyuCSzV1yOc
         qqeg==
X-Gm-Message-State: APjAAAWqzZBnXo0rJrOdSbgOE4s8bIEy9G63W/6S0WDogdvCCpNBDiei
        gF6z56+iPJg4pRnCAgQau1Aay1AZDKLbghn8gkMx8A==
X-Google-Smtp-Source: APXvYqyvaauWnjBy2H2h1uPGRr13DVqsPqYjRQMZnnukrXNH9tQvcKUJuA8IJ5QeFIyi9Qjs3Ve6ha/af1MHbWWu5Hk=
X-Received: by 2002:a05:6808:a11:: with SMTP id n17mr1735405oij.94.1582044148819;
 Tue, 18 Feb 2020 08:42:28 -0800 (PST)
MIME-Version: 1.0
References: <1582006810-32174-1-git-send-email-selvin.xavier@broadcom.com>
 <1582006810-32174-2-git-send-email-selvin.xavier@broadcom.com> <20200218154237.GE31668@ziepe.ca>
In-Reply-To: <20200218154237.GE31668@ziepe.ca>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Tue, 18 Feb 2020 22:12:17 +0530
Message-ID: <CA+sbYW1uO+LT=6a_J-9=yaot8qULbHehY9AummLD2h-kW04nBQ@mail.gmail.com>
Subject: Re: [PATCH for-next v3 1/2] RDMA/core: Add helper function to
 retrieve driver gid context from gid attr
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 18, 2020 at 9:12 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Feb 17, 2020 at 10:20:09PM -0800, Selvin Xavier wrote:
> > Adding a helper function to retrieve the driver gid context
> > from the gid attr.
> >
> > Suggested-by: Jason Gunthorpe <jgg@mellanox.com>
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> >  drivers/infiniband/core/cache.c | 41 +++++++++++++++++++++++++++++++++++++++++
> >  include/rdma/ib_cache.h         |  1 +
> >  2 files changed, 42 insertions(+)
> >
> > diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> > index 17bfedd..1b73a71 100644
> > +++ b/drivers/infiniband/core/cache.c
> > @@ -973,6 +973,47 @@ int rdma_query_gid(struct ib_device *device, u8 port_num,
> >  EXPORT_SYMBOL(rdma_query_gid);
> >
> >  /**
> > + * rdma_read_gid_hw_context - Read the HW GID context from GID attribute
> > + * @attr:            Potinter to the GID attribute
> > + *
> > + * rdma_read_gid_hw_context() reads the vendor drivers GID HW
> > + * context corresponding to SGID attr. It takes reference to the GID
> > + * attribute and this need to be released by the caller using
> > + * rdma_put_gid_attr
> > + *
> > + * Returns HW context on success or NULL on error
> > + *
> > + */
> > +void *rdma_read_gid_hw_context(const struct ib_gid_attr *attr)
> > +{
> > +     struct ib_gid_table_entry *entry =
> > +             container_of(attr, struct ib_gid_table_entry, attr);
> > +     struct ib_device *device = entry->attr.device;
> > +     u8 port_num = entry->attr.port_num;
> > +     struct ib_gid_table *table;
> > +     unsigned long flags;
> > +     void *context = NULL;
> > +
> > +     if (!rdma_is_port_valid(device, port_num))
> > +             return NULL;
> > +
> > +     table = rdma_gid_table(device, port_num);
> > +     read_lock_irqsave(&table->rwlock, flags);
> > +
> > +     if (attr->index < 0 || attr->index >= table->sz ||
> > +         !is_gid_entry_valid(table->data_vec[attr->index]))
> > +             goto done;
>
> Why all this validation and locking? ib_gid_attrs are only created by
> the core code..
Locking and validation was added to avoid any scenario where the  gid
entry is deleted while we are
executing this API. I saw similar implementation for
rdma_read_gid_attr_ndev_rcu symbol.
>
> > +     get_gid_entry(entry);
>
> And why a get? Surely it is invalid to call this function without a
> get already held?
Getting the reference to the entry only if the entry is valid after
all the checks. This is the
reason for invoking this inside the function, rather than in the
caller. Added a note in the symbol description
that the caller needs to release reference using rdma_put_gid_attr,
once the caller finished using
the void * pointer returned.

>
> Jason
