Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEE925D8CC
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 02:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfGCA3f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jul 2019 20:29:35 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35658 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfGCA3f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Jul 2019 20:29:35 -0400
Received: by mail-qk1-f194.google.com with SMTP id r21so111230qke.2
        for <linux-rdma@vger.kernel.org>; Tue, 02 Jul 2019 17:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PHSbzNrU7eGGZXZD0AacWMBlI/Op9clHTfYxssXMqi0=;
        b=jWXR3BvgSRojUrHckKoThkxxy/8IZPDG/erYKRHDkY+Ld18hMCQVQ5/kDgVBYr4FPG
         qm94DH5oQaYLrDn4hZx8/FIazaZ3KNuIWd6gH6wJaM6yA7Y0PPqP7b9rjbTYCnEpP7Cj
         pwVhWkflABcJCLKXKrbt5IhJyw1ZgvR0v5b2DKbJ35rDJ2opPZ9z3lLurj6wYxKy4BCJ
         pZ8Zian8CEFR6B3LPvlXYA4vwSd1KLh1tBCa/H3Wv2+WmYrtRTsrOR4/Rb3vFMay2a2Z
         oaqPTVGZzukwrGkFKeH8eAkeJxPxBRyR8Cz2cCVwyQvCCLoXpls4wA6Y2d+y4/ix5QkQ
         jtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PHSbzNrU7eGGZXZD0AacWMBlI/Op9clHTfYxssXMqi0=;
        b=SR4+x3pRm8j1oJfyMwtFhQC3LZFWO/pcaidJQLCCXZSkpzjudyi+WbP4HWPO9nw/cr
         OhSwzztrPlzoa8wnoTQ6kF/Gv6QNdhA0a71ex3q0yUjvjterPkeq2y7f6qRmxTvzsqEY
         EuqSzGTvHfnMJjDXKa00b+CZBEMwkxx0h4gDS8fZMBw03eCDKjkO1+SbqpFT4puoXVXx
         rTVYvb4w0hYVhxnM7+5d45zLrYdfnxA/c2UH5gk4nTX5QH+Zj58YrEtDbfdtP00jZA4x
         KZhLWNCaNtBoI1X1BUbd6kfysAA8AvLoS9UBo25pzx3nwxXcOpg8nsDgLbgiYXBcgZjx
         fSYg==
X-Gm-Message-State: APjAAAVBoi1T7ovTdURVlnhxbL9ZGg+kJ4dTAfiyQnfkUTUs5rvGbnf9
        fkRMkf2HrVopef7DVlkR1lza/zLaMg2TqA==
X-Google-Smtp-Source: APXvYqwPshAz/jzHQvxq4m19H4+qdpHEysTjK67YJYXkIMhAJOCpUmmXQt5l2TE0Ryz5LW+CJWUucQ==
X-Received: by 2002:a37:6a87:: with SMTP id f129mr27709475qkc.183.1562107688624;
        Tue, 02 Jul 2019 15:48:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id j79sm87486qke.112.2019.07.02.15.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 15:48:08 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hiRZH-0003N8-Sr; Tue, 02 Jul 2019 19:48:07 -0300
Date:   Tue, 2 Jul 2019 19:48:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yuval Shaia <yuval.shaia@oracle.com>
Cc:     Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        linux-rdma@vger.kernel.org, leon@kernel.org,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [RFC rdma-core] verbs: add ibv_export_to_fd man page
Message-ID: <20190702224807.GE11860@ziepe.ca>
References: <20190626083614.23688-1-shamir.rabinovitch@oracle.com>
 <20190626124637.GA3091@lap1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626124637.GA3091@lap1>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 26, 2019 at 03:46:39PM +0300, Yuval Shaia wrote:
> On Wed, Jun 26, 2019 at 11:36:14AM +0300, Shamir Rabinovitch wrote:
> > Add the ibv_export_to_fd man page.
> 
> This is RFC but still suggesting to give some words here.
> 
> Also, subject is incorrect since man page is for all functions involved in
> the shared-obj mechanism, not only the export_to_fd.
> 
> > 
> > Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> >  libibverbs/man/ibv_export_to_fd.3.md | 109 +++++++++++++++++++++++++++
> >  1 file changed, 109 insertions(+)
> >  create mode 100644 libibverbs/man/ibv_export_to_fd.3.md
> > 
> > diff --git a/libibverbs/man/ibv_export_to_fd.3.md b/libibverbs/man/ibv_export_to_fd.3.md
> > new file mode 100644
> > index 00000000..8e3f0fb2
> > +++ b/libibverbs/man/ibv_export_to_fd.3.md
> > @@ -0,0 +1,109 @@
> > +---
> > +date: 2018-06-26
> > +footer: libibverbs
> > +header: "Libibverbs Programmer's Manual"
> > +layout: page
> > +license: 'Licensed under the OpenIB.org BSD license (FreeBSD Variant) - See COPYING.md'
> > +section: 3
> > +title: ibv_export_to_fd
> > +tagline: Verbs
> > +---
> > +
> > +# NAME
> > +
> > +**ibv_export_to_fd**, **ibv_import_pd**, **ibv_import_mr** - export & import ib hw objects.
> > +
> > +# SYNOPSIS
> > +
> > +```c
> > +#include <infiniband/verbs.h>
> > +
> > +int ibv_export_to_fd(uint32_t fd,
> > +                     uint32_t *new_handle,
> > +                     struct ibv_context *context,
> > +                     enum uverbs_default_objects type,
> > +                     uint32_t handle);

This should probably be some internal function and the exports should
be type safe just like the imports.

> > +struct ibv_pd *ibv_import_pd(struct ibv_context *context,
> > +                             uint32_t fd,
> > +                             uint32_t handle);
> > +
> > +struct ibv_mr *ibv_import_mr(struct ibv_context *context,
> > +                             uint32_t fd,
> > +                             uint32_t handle);
> > +
> > +uint32_t ibv_context_to_fd(struct ibv_context *context);
> > +
> > +uint32_t ibv_pd_to_handle(struct ibv_pd *pd);
> > +
> > +uint32_t ibv_mr_to_handle(struct ibv_mr *mr);
> 
> Do you know if extra stuff besides this new file needs to be done so i can
> do ex man ibv_context_to_fd and get this man page?

Yes, they need to be setup in cmake with aliases.

I think this man page is kind of terse for such a complicated
thing. 

Ie it doesn't talk about what happens when close() or ibv_destroy_X()
is called.

Jason
