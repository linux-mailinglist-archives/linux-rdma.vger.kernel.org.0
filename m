Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0638BE588
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2019 21:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfIYTVD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Sep 2019 15:21:03 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40133 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfIYTVD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Sep 2019 15:21:03 -0400
Received: by mail-qt1-f196.google.com with SMTP id f7so704780qtq.7
        for <linux-rdma@vger.kernel.org>; Wed, 25 Sep 2019 12:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fj5E/rkJiNQk0iPFhqSdiFSeHER0u0hWYrVUbk4+Jmg=;
        b=E+fO+7Js6herUMsHACsbUCZHB06wD42Gk5uiHkxZrzCQe9i3c8ttyBEvheO7VXW8pp
         Gi2eKWDQ78cR5s8EZQNaKFE6lMgY6I6N00H6aGHLfo2oNwjU2QljY0XnVQCBiq+rMY2u
         NFNkmIg4ofW33TdOSoyavqKe1xdMyLx0pABg8OYjyqTkaoFoiJoPKAoHE0bYKhTWK1eM
         vZANpP5LVYsIKkzSAvnF1lYRG4KwYFa628J6Sg3BVx3YGcNetc1FTmNpB6m4QuTiy5Dm
         1Vrao9cbVCzZYQXZnIVVaE2jYOSbqvxSqxTcYd1MI/zAztiG0Ks6A5IWL/X0CyenahA6
         t5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fj5E/rkJiNQk0iPFhqSdiFSeHER0u0hWYrVUbk4+Jmg=;
        b=HXffvjRQMbDm0JFaktBkJsorBcqYEmJzeINhlfJiSwirTDeNbFi8yShVKf44QJ+YhM
         kfMCbbVrTbCslhWme+DSZG5qlxxvuP5DHs8sOWyS0ZRvs2TK5ipE9LQUszVruMIv6iG8
         ibfecHAM7HUI5eJmmth49IpuIt1pL5qMd8MK9vztH2rtJFrY5CWRB8luxe7gwbsMVX/S
         DdpxxJ8yprEr1isUfYYyRVJx1MFRfv3/QlwdkWIoJlxZu7s4VBydwLpYjh5592PY7egE
         atwCO9Lr969+T8zUbIj+HbVHFpsxAto6lXrtwDBqk2pQqbtcgehGmxz4sMp2GBF5sjCW
         nZJg==
X-Gm-Message-State: APjAAAXGdaXHUE9dEaJKf0pivfnl+eGdUnUUA8mz9MwxnfRmN+dIiRwV
        rjx/GyNCRWIoEe0r/ZPgnnlgJg==
X-Google-Smtp-Source: APXvYqxcbSQ88Sy70ep2MKHgG5RmFYVT4Hp5+8IYg6e7K+G8+BGb8Zly1INP5HREcCd5MecA3HH2XQ==
X-Received: by 2002:ad4:4712:: with SMTP id k18mr970600qvz.97.1569439262270;
        Wed, 25 Sep 2019 12:21:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-223-10.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.223.10])
        by smtp.gmail.com with ESMTPSA id b26sm3420971qkl.43.2019.09.25.12.21.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Sep 2019 12:21:01 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iDCqT-0000KF-4K; Wed, 25 Sep 2019 16:21:01 -0300
Date:   Wed, 25 Sep 2019 16:21:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     Gal Pressman <galpress@amazon.com>,
        Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v11 rdma-next 6/7] RDMA/qedr: Add doorbell
 overflow recovery support
Message-ID: <20190925192101.GA626@ziepe.ca>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
 <20190905100117.20879-7-michal.kalderon@marvell.com>
 <20190919180224.GE4132@ziepe.ca>
 <a0e19fb2-cd5c-4394-16d6-75ac856340b4@amazon.com>
 <20190920133817.GB7095@ziepe.ca>
 <MN2PR18MB3182FEF24664E620E357B83AA1870@MN2PR18MB3182.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR18MB3182FEF24664E620E357B83AA1870@MN2PR18MB3182.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 25, 2019 at 07:16:23PM +0000, Michal Kalderon wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Friday, September 20, 2019 4:38 PM
> > 
> > External Email
> > 
> > On Fri, Sep 20, 2019 at 04:30:52PM +0300, Gal Pressman wrote:
> > > On 19/09/2019 21:02, Jason Gunthorpe wrote:
> > > > On Thu, Sep 05, 2019 at 01:01:16PM +0300, Michal Kalderon wrote:
> > > >
> > > >> @@ -347,6 +360,9 @@ void qedr_mmap_free(struct
> > rdma_user_mmap_entry
> > > >> *rdma_entry)  {
> > > >>  	struct qedr_user_mmap_entry *entry =
> > > >> get_qedr_mmap_entry(rdma_entry);
> > > >>
> > > >> +	if (entry->mmap_flag == QEDR_USER_MMAP_PHYS_PAGE)
> > > >> +		free_page((unsigned long)phys_to_virt(entry->address));
> > > >> +
> > > >
> > > > While it isn't wrong it do it this way, we don't need this
> > > > mmap_free() stuff for normal CPU pages. Those are refcounted and
> > > > qedr can simply call free_page() during the teardown of the uobject
> > > > that is using the this page. This is what other drivers already do.
> > >
> > > This is pretty much what EFA does as well.  When we allocate pages for
> > > the user (CQ for example), we DMA map them and later on mmap them to
> > > the user. We expect those pages to remain until the entry is freed,
> > > how can we call free_page, who is holding a refcount on those except
> > > for the driver?
> > 
> > free_page is kind of a lie, it is more like put_page (see __free_pages). I think
> > the difference is that it assumes the page came from alloc_page and skips
> > some generic stuff when freeing it.
> > 
> > When the driver does vm_insert_page the vma holds another refcount and
> > the refcount does not go to zero until that page drops out of the vma (ie at
> > the same time mmap_free above is called).
> > 
> > Then __put_page will do the free_unref_page(), etc.
> > 
> > So for CPU pages it is fine to not use mmap_free so long as vm_insert_page
> > is used

> Jason, by adding the kref to the rdma_user_mmap_entry we sort of
> disable the option of being sure the entry is removed from the mmap
> xarray when it is removed by the driver (this will only decrease the
> refcnt).  If we call free_page during the uobject teardown, we can't
> be sure the entry is removed from the mmap_xa, this could lead to us
> having an entry in the mmap_xa that points to an invalid page.

I suppose I was expecting that the when the object was no longer to be
shown to userspace the mmap_xa's were somehow neutralized too so new
mmaps cannot be established.

Jason
