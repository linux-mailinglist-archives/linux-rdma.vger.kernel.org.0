Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0BAF1996
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2019 16:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfKFPKQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Nov 2019 10:10:16 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36842 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfKFPKQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Nov 2019 10:10:16 -0500
Received: by mail-qt1-f193.google.com with SMTP id y10so27261297qto.3
        for <linux-rdma@vger.kernel.org>; Wed, 06 Nov 2019 07:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WwjzLqzI+gy4pPG4aukZss4i/UlCGv6Nl7wTvQ7+lMY=;
        b=kfGbWcT+ZLxStIXrYTiwK7dh5HJ8TAihI9JGBrveA63BhtdvBj3PRhOoeffWWRCubf
         foZcraObhxCGcVkipd7bOYuG48MoO/lTdnbDxDLKUN3kn+L/qSYDmwxYkFSXtHnTPFh9
         XpgbKiNVrLygZ0oU8FSB+J3h38d0AQtqtd7HqF6ESZxTnmBVBPh8wTRBJCNUecevMdpD
         EnXJ2EA83NGuYZfT1c+2TJnBXpFA3vXRj4bM1BzKjQS3U1yTOo680S5+BZb2ZaqgGsOA
         fPtP5RrkMEpOxSJ1wLS8DhNHGOAaD+nobiwyQoChwqNUEUV7++YIJBkhlFLqzlRJwcFt
         h5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WwjzLqzI+gy4pPG4aukZss4i/UlCGv6Nl7wTvQ7+lMY=;
        b=oLAqhUNMEbWr7lYxhJmxxtOTHFi+G9KkExEAdttdyfLpJdw9gcVIFTjdrb7Kgwo/Wn
         2dzHTtw8n7mtORgvNV2KpQlu3JG0glcWSMZ3gwXTRt+Om3FQ6PdeIO4s9hOub7GS7LND
         86h2NZWDmoIM2VOVMDnLMTkxCjEm+1LUvGodJ3uT42EHBNvM0Ne0txngFnGWhIIIBfoO
         6f3TVjez2cs6wv3j15EQRrmip2a/an8H3sgjNHb4IkFMPPndjnv1McbC71Wt5ahjp06a
         PTdrrlvzreuLdePvX/DF9d2YKNZ4QT6YuWtqHNwJyEOI3OYTopPHO0g8SKdumK/8L37m
         Cpow==
X-Gm-Message-State: APjAAAUEHLpDqwglxGdHG+XnJn4e1SZF1n2komhZOnzoxaHQ8ea1DJVe
        VVgVYiklh3rb3sKoHmZyotvi1A==
X-Google-Smtp-Source: APXvYqzL+u46idsgAH5M3gyaQd33YmGXmoq9G8Uhlq0td5MU1SjEWUqk20UvYmyP5TxMkPTadDgsLA==
X-Received: by 2002:ac8:7a93:: with SMTP id x19mr2964368qtr.343.1573053015651;
        Wed, 06 Nov 2019 07:10:15 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id u9sm12944542qke.50.2019.11.06.07.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 07:10:14 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iSMwo-0003GW-DS; Wed, 06 Nov 2019 11:10:14 -0400
Date:   Wed, 6 Nov 2019 11:10:14 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "yishaih@mellanox.com" <yishaih@mellanox.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v12 rdma-next 0/8] RDMA/qedr: Use the doorbell overflow
 recovery mechanism for RDMA
Message-ID: <20191106151014.GA15851@ziepe.ca>
References: <20191030094417.16866-1-michal.kalderon@marvell.com>
 <20191105204144.GB19938@ziepe.ca>
 <MN2PR18MB318254AD4C7254E12BE970ECA1790@MN2PR18MB3182.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR18MB318254AD4C7254E12BE970ECA1790@MN2PR18MB3182.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> > Please let me know if I messed it up, otherwise I'll apply this in
> > a few days.
>
> Thanks Jason. One small comment is that the length field was removed from siw + efa 
> But not qedr_user_mmap_entry, I can also send a patch after to fix this. 
> And one small insignificant typo below

qedr looked to me like it was using non page size lengths, so I left
it..

> > diff --git a/drivers/infiniband/core/ib_core_uverbs.c
> > b/drivers/infiniband/core/ib_core_uverbs.c
> > index 88d9d47fb8adaa..6238842fd06402 100644
> > +++ b/drivers/infiniband/core/ib_core_uverbs.c
> > @@ -11,14 +11,14 @@
> > 
> >  /**
> > - * rdma_user_mmap_entry_insert() - Insert an entry to the mmap_xa.
> > + * rdma_user_mmap_entry_insert() - Insert an entry to the mmap_xa
> >   *
> >   * @ucontext: associated user context.
> >   * @entry: the entry to insert into the mmap_xa
> >   * @length: length of the address that will be mmapped
> >   *
> >   * This function should be called by drivers that use the rdma_user_mmap
> > - * interface for handling user mmapped addresses. The database is handled
> > in
> > - * the core and helper functions are provided to insert entries into the
> > - * database and extract entries when the user calls mmap with the given
> > key.
> > - * The function allocates a unique key that should be provided to user, the
> > user
> > - * will use the key to retrieve information such as address to
> > - * be mapped and how.
> > + * interface for implementing their mmap syscall A database of mmap
> > + offsets is
> > + * handled in the core and helper functions are provided to insert
> > + entries
> > + * into the database and extract entries when the user calls mmap with
> > + the
> > + * given offset.  The function allocates a unique page offset that
> > + should be
> > + * provided to user, the user will use the iffset to retrieve
> 
> Typo - should be offset

Thanks, I'll fix that

Jason
