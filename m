Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A862163206
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 21:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgBRUEc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 15:04:32 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41690 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbgBRUDW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 15:03:22 -0500
Received: by mail-qt1-f194.google.com with SMTP id l21so15447087qtr.8
        for <linux-rdma@vger.kernel.org>; Tue, 18 Feb 2020 12:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BI6/5elNw+KMaVIonRG7SXMZDI8jM4Dwm7aBP0DOikA=;
        b=FGQGxF21dmHr89PgBLD7tyh8fVvvjZevQZyMPtd0vdDnYSSjK0r39GZwKoJUzlH+FR
         sdzY85cbdnmn1/zhyZLILrw/nK4in/G+mWu0aKEF/+nsEdcHJZ96isXePvZ7Cm2ElmKy
         J5lZe/DWLP8QWMS50FhbY5H0eCxS0xsGxxdlud2rcogP2ELi/uFO2noIe5RIvefZbv6S
         kHVxZ2qOGcTYS2pq6fVrFCKC8WKG3W1qOvPl8p95JiT0+d8cUK9w8GMjdZKm680MSYOX
         9dXcCXkf8g+FS570KFKVN5Obt1/1aSgosmSsN9Mmzh5BTn2gfQBZ+tDhoKKRqxb87yte
         UI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BI6/5elNw+KMaVIonRG7SXMZDI8jM4Dwm7aBP0DOikA=;
        b=kcwd51j4+/7mDAE24ROG9vizaZ21pjyRMdxv5PNZ6963JS2ii6e7OrQPObjZ45eM/A
         F2ZST4he1bsKq6pM63rmTATNGsNg62NTLGAH0O+sZEowY4xbTt3hXi3GmTucyt4s/K6V
         jgvd3StuWpwgiTra2j4YdC1Uj5N6lZRW5tDWvw7+P2mOISdtskK2on5KukqaMecvbfQn
         78+ooSW5vGp7FYrghxKDx8/GGTqa+h5c85CD1p/UD116tNGZZx6kxYgmw+7v8ySPTNSt
         1EDoUMyjXDi1YnooBM32NMQZ084T04CsdsY0SipCQM1uA8osZhAjeAjBAXodPN0U5haC
         SViQ==
X-Gm-Message-State: APjAAAWWan2CLm3+lSx+a4NN76+jARHgCodd1aUhw8coXQcZlo0mxqlK
        59GNrx7/A6XWXtPVKKjHRH75Uw==
X-Google-Smtp-Source: APXvYqzf6USjs6CaYSA9VhIKu8jlfUMyu0Qu5yadMcnNX8aL8S6YKmThrHD8Hl1SvqeScCKp5xD/wQ==
X-Received: by 2002:ac8:60d5:: with SMTP id i21mr19075270qtm.341.1582056201485;
        Tue, 18 Feb 2020 12:03:21 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id f2sm2347971qkm.81.2020.02.18.12.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Feb 2020 12:03:20 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j495U-0004bm-Fy; Tue, 18 Feb 2020 16:03:20 -0400
Date:   Tue, 18 Feb 2020 16:03:20 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v3 1/2] RDMA/core: Add helper function to
 retrieve driver gid context from gid attr
Message-ID: <20200218200320.GG31668@ziepe.ca>
References: <1582006810-32174-1-git-send-email-selvin.xavier@broadcom.com>
 <1582006810-32174-2-git-send-email-selvin.xavier@broadcom.com>
 <20200218154237.GE31668@ziepe.ca>
 <CA+sbYW1uO+LT=6a_J-9=yaot8qULbHehY9AummLD2h-kW04nBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+sbYW1uO+LT=6a_J-9=yaot8qULbHehY9AummLD2h-kW04nBQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 18, 2020 at 10:12:17PM +0530, Selvin Xavier wrote:
> On Tue, Feb 18, 2020 at 9:12 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Mon, Feb 17, 2020 at 10:20:09PM -0800, Selvin Xavier wrote:
> > > Adding a helper function to retrieve the driver gid context
> > > from the gid attr.
> > >
> > > Suggested-by: Jason Gunthorpe <jgg@mellanox.com>
> > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > >  drivers/infiniband/core/cache.c | 41 +++++++++++++++++++++++++++++++++++++++++
> > >  include/rdma/ib_cache.h         |  1 +
> > >  2 files changed, 42 insertions(+)
> > >
> > > diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> > > index 17bfedd..1b73a71 100644
> > > +++ b/drivers/infiniband/core/cache.c
> > > @@ -973,6 +973,47 @@ int rdma_query_gid(struct ib_device *device, u8 port_num,
> > >  EXPORT_SYMBOL(rdma_query_gid);
> > >
> > >  /**
> > > + * rdma_read_gid_hw_context - Read the HW GID context from GID attribute
> > > + * @attr:            Potinter to the GID attribute
> > > + *
> > > + * rdma_read_gid_hw_context() reads the vendor drivers GID HW
> > > + * context corresponding to SGID attr. It takes reference to the GID
> > > + * attribute and this need to be released by the caller using
> > > + * rdma_put_gid_attr
> > > + *
> > > + * Returns HW context on success or NULL on error
> > > + *
> > > + */
> > > +void *rdma_read_gid_hw_context(const struct ib_gid_attr *attr)
> > > +{
> > > +     struct ib_gid_table_entry *entry =
> > > +             container_of(attr, struct ib_gid_table_entry, attr);
> > > +     struct ib_device *device = entry->attr.device;
> > > +     u8 port_num = entry->attr.port_num;
> > > +     struct ib_gid_table *table;
> > > +     unsigned long flags;
> > > +     void *context = NULL;
> > > +
> > > +     if (!rdma_is_port_valid(device, port_num))
> > > +             return NULL;
> > > +
> > > +     table = rdma_gid_table(device, port_num);
> > > +     read_lock_irqsave(&table->rwlock, flags);
> > > +
> > > +     if (attr->index < 0 || attr->index >= table->sz ||
> > > +         !is_gid_entry_valid(table->data_vec[attr->index]))
> > > +             goto done;
> >
> > Why all this validation and locking? ib_gid_attrs are only created by
> > the core code..
> Locking and validation was added to avoid any scenario where the  gid
> entry is deleted while we are
> executing this API. I saw similar implementation for
> rdma_read_gid_attr_ndev_rcu symbol.

This is required to deref the ndev as GID_TABLE_ENTRY_PENDING_DEL no
longer has the ndev memory.

However here things are not derefing the ndev, there is no reason to
check this. The driver state attached to a gid entry should always be
valid so long as the pointer is valid. This is the entire point of the
refcounting scheme.

> > > +     get_gid_entry(entry);
> >
> > And why a get? Surely it is invalid to call this function without a
> > get already held?
> Getting the reference to the entry only if the entry is valid after
> all the checks. This is the
> reason for invoking this inside the function, rather than in the
> caller. Added a note in the symbol description
> that the caller needs to release reference using rdma_put_gid_attr,
> once the caller finished using
> the void * pointer returned.

That makes no sense, we already *must* have a get at this point or the
whole thing is really buggy

Jason
