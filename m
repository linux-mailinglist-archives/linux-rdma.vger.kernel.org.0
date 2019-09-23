Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 163DCBB53A
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2019 15:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405044AbfIWN3h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 09:29:37 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33494 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404581AbfIWN3g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 09:29:36 -0400
Received: by mail-qk1-f195.google.com with SMTP id x134so15401403qkb.0
        for <linux-rdma@vger.kernel.org>; Mon, 23 Sep 2019 06:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VuUrEuIRK+qw8CviiPDPKqslaPLYoFq8LqrD1/UIhLA=;
        b=gzosrvnuOZNSSJs9yb1M8XkIiAvnTSBD06ofSOh4oW78iOA3CusPmLeRwI54M32a6l
         AzVl2JCGKF1REPDp7+T01wzlmpnnTkIJm+fQBhLEqCRmDRMPnFrEhpcmOq+cV3piMa8K
         DVq+2uhfkSHaD6e3D2XtLxaBtguGJre3rIJ7FrXoF65y/0LUh17hMoMEzDzg6oK1pJf0
         2Wv+5wsWI4TyXib7MiR/8wnOVsIRJQ6D07X1LATcQx3ydHPqEjEqBNou0z4Qf+gSd+vc
         BL+aFLEDwi9LtxS9xfTVT+lo0cp/njdrt1lnOM17w2N9F1dD6FCetLR/YaBM6ZiURabO
         CyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VuUrEuIRK+qw8CviiPDPKqslaPLYoFq8LqrD1/UIhLA=;
        b=DxERQpudAF29A8fJwewxVrRSzc03Yu2nZiaccllpCIiDDsJcPTtiKaqz15FgRdWGwo
         OhDFYigG1UBRE8D+m0jLfCe1hM+PbWBEp35cArHXlPbsk2ruwhxkc2MO1A+/7ib+VokX
         ym5EfFhujE+ecPI5YuCU3Mt6y0g4gQFb4+FwuBQzohptUfpZBsWEyM7XTgiF/HM1yXVx
         TfsBFYqFYQzqCSXl2eHXoNHNPZ0VkazxZLVDwNyFmLJ6DhbULA2MSIs6g9m/ZY8YySgQ
         IEB/iffnRd9H9AHV8vn7G00U1ThQ1iRrVJUhUrC4Q/faRXIxw2hmn5QGc/3Nid57oRrc
         XaEw==
X-Gm-Message-State: APjAAAXyTwBiXuCi3necdGtUB+ZM2Mzu2qwcZWvXNoTGW3AJ1x/bdKTK
        o4DkZtESQZXWc0Uaj6s3CIza0Q==
X-Google-Smtp-Source: APXvYqxP71oAZyqszei2+lEvpcAsjLMSut876EEB1KI8TsQEKX8eRse9mk4k74/xvpK5Ldpqw/RTxw==
X-Received: by 2002:a37:a1cd:: with SMTP id k196mr17347181qke.189.1569245374697;
        Mon, 23 Sep 2019 06:29:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-223-10.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.223.10])
        by smtp.gmail.com with ESMTPSA id b130sm5066143qkc.100.2019.09.23.06.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Sep 2019 06:29:34 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iCOPF-0003mR-Qi; Mon, 23 Sep 2019 10:29:33 -0300
Date:   Mon, 23 Sep 2019 10:29:33 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     Gal Pressman <galpress@amazon.com>,
        Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v11 rdma-next 5/7] RDMA/qedr: Use the common mmap API
Message-ID: <20190923132933.GC12047@ziepe.ca>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
 <20190905100117.20879-6-michal.kalderon@marvell.com>
 <20190919175546.GD4132@ziepe.ca>
 <af160e72-bcc3-c511-8757-a21b33bd9e5c@amazon.com>
 <MN2PR18MB31828BDF43D9CA65A7BF1BC8A1850@MN2PR18MB3182.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR18MB31828BDF43D9CA65A7BF1BC8A1850@MN2PR18MB3182.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 23, 2019 at 09:21:37AM +0000, Michal Kalderon wrote:
> > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > owner@vger.kernel.org> On Behalf Of Gal Pressman
> > 
> > On 19/09/2019 20:55, Jason Gunthorpe wrote:
> > > Huh. If you recall we did all this work with the XA and the free
> > > callback because you said qedr was mmaping BAR pages that had some HW
> > > lifetime associated with them, and the HW resource was not to be
> > > reallocated until all users were gone.
> > >
> > > I think it would be a better example of this API if you pulled the
> > >
> > >  	dev->ops->rdma_remove_user(dev->rdma_ctx, ctx->dpi);
> > >
> > > Into qedr_mmap_free().
> > >
> > > Then the rdma_user_mmap_entry_remove() will call it naturally as it
> > > does entry_put() and if we are destroying the ucontext we already know
> > > the mmaps are destroyed.
> > >
> > > Maybe the same basic comment for EFA, not sure. Gal?
> > 
> > That's what EFA already does in this series, no?
> > We no longer remove entries on dealloc_ucontext, only when the entry is
> > freed.
> 
> Actually, I think most of the discussions you had on the topic were with Gal, but
> Some apply to qedr as well, however, for qedr, the only hw resource we allocate (bar)
> is on alloc_ucontext , therefore we were safe to free it on dealloc_ucontext as all mappings
> were already zapped. Making the mmap_free a bit redundant for qedr except for the need
> to free the entry. 

I think if we are changing things to use this new interface then you
should consistenly code so that the lifetime of the object in the
mmap_entry is entirely controlled by the mmap_entry and not also split
to the ucontext.

Having mmapable object lifetimes linked to the ucontext is a bit of a
hack really

Jason
