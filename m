Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91591DF456
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 19:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfJURdw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 13:33:52 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44054 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJURdv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Oct 2019 13:33:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id u22so13394180qkk.11
        for <linux-rdma@vger.kernel.org>; Mon, 21 Oct 2019 10:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vlU9Z5F7RDf5lXGIhaENKPkzd+ytYK7ydxIT0ILxsSo=;
        b=WiArqXej3GSPc0A4IuR7xt6IhEbOFjUt9SjF3IN6rw/HHlRipDYZCgiuFk/7xkJRDk
         mcokeUgUFKsKMxi1aj1uKgFDNO5D0YWC9lssPDdV4l4kj+sOHESaf4c4gLQDeJZuNwR6
         y3vtCIbfp+fak0iBAQDQHbFh17oVtTIqjrJ0UhtydFSjzoUa+vdreu5dUcQLN44Wz6hK
         iOd4nwtBV8S0TWkEg/3aFD2bcNrHbtXHkVH6Ci83LSwx3hgnX3r1cuJDJWCONWwNfTuu
         i+8sTSG9eY3iFOjFIZIQnmUwvV1GIg9p1VoAGqQYR+DCfLv+bxwMzPEKSTygkuFq9Buh
         zlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vlU9Z5F7RDf5lXGIhaENKPkzd+ytYK7ydxIT0ILxsSo=;
        b=L89haYKuKuab/nHHi7yA1/+HYQdB+/f/iolLghhOiQhhQ7wvWe+kfM/u5VJ+QIQ+BI
         bZ7b7YzNQXZH2fmW5jVaL0DtsC76dRscRGRwk+LcAEuuRgt9Nl5+SB4Yg2763hrMdlFe
         ei7/37gKprrgPS8/6IcQSrhKkOXccC5CrBVYbJUX5280ovMtyEk7Jh4FLSbECyqk2NyY
         yDtq2O/UOrfJ4uXxyjDbLDvQZu4Dg7X3/H2N9cbt5n4vfwTISysZJicVXZwEhL06zBJK
         T9QOhBOVm16hvCxfYL8F4uopMepRoElzCjUU61ereoOu//7dfHnsSXdWHML7uGsFsaxk
         Gemg==
X-Gm-Message-State: APjAAAUi15bN0+UjlB7jh4vHPVcp/rRBdcqZ54nLyGPZM0tW1bEHLX7x
        HMGSQKxJQJ9og1zTolPq06vWwg==
X-Google-Smtp-Source: APXvYqzKiN9WixxNmeh9ma6qqZyMX9FdPwJtoxqqn6bjLbNHVObhxjHUv1Y1SXjEe96OPssuv8xTKA==
X-Received: by 2002:a05:620a:2052:: with SMTP id d18mr266220qka.418.1571679230429;
        Mon, 21 Oct 2019 10:33:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id 194sm7978804qkm.62.2019.10.21.10.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 10:33:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iMbYz-0002D7-Fu; Mon, 21 Oct 2019 14:33:49 -0300
Date:   Mon, 21 Oct 2019 14:33:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "Leybovich, Yossi" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v11 rdma-next 5/7] RDMA/qedr: Use the common mmap API
Message-ID: <20191021173349.GH25178@ziepe.ca>
References: <MN2PR18MB31828BDF43D9CA65A7BF1BC8A1850@MN2PR18MB3182.namprd18.prod.outlook.com>
 <4A66AD43-246B-4256-BA99-B61D3F1D05A8@amazon.com>
 <MN2PR18MB3182999F3ACFC93455B887C8A1840@MN2PR18MB3182.namprd18.prod.outlook.com>
 <f7f91641-6a80-2c06-2d4a-9045b876daff@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7f91641-6a80-2c06-2d4a-9045b876daff@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 20, 2019 at 10:19:34AM +0300, Gal Pressman wrote:
> On 24/09/2019 12:31, Michal Kalderon wrote:
> >> From: Pressman, Gal <galpress@amazon.com>
> >> Sent: Tuesday, September 24, 2019 11:50 AM
> >>
> >>
> >>> On 23 Sep 2019, at 18:22, Michal Kalderon <mkalderon@marvell.com>
> >> wrote:
> >>>
> >>>
> >>>>
> >>>> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> >>>> owner@vger.kernel.org> On Behalf Of Gal Pressman
> >>>>
> >>>>> On 19/09/2019 20:55, Jason Gunthorpe wrote:
> >>>>> Huh. If you recall we did all this work with the XA and the free
> >>>>> callback because you said qedr was mmaping BAR pages that had some
> >>>>> HW lifetime associated with them, and the HW resource was not to be
> >>>>> reallocated until all users were gone.
> >>>>>
> >>>>> I think it would be a better example of this API if you pulled the
> >>>>>
> >>>>>    dev->ops->rdma_remove_user(dev->rdma_ctx, ctx->dpi);
> >>>>>
> >>>>> Into qedr_mmap_free().
> >>>>>
> >>>>> Then the rdma_user_mmap_entry_remove() will call it naturally as it
> >>>>> does entry_put() and if we are destroying the ucontext we already
> >>>>> know the mmaps are destroyed.
> >>>>>
> >>>>> Maybe the same basic comment for EFA, not sure. Gal?
> >>>>
> >>>> That's what EFA already does in this series, no?
> >>>> We no longer remove entries on dealloc_ucontext, only when the entry
> >>>> is freed.
> >>>
> >>> Actually, I think most of the discussions you had on the topic were
> >>> with Gal, but Some apply to qedr as well, however, for qedr, the only
> >>> hw resource we allocate (bar) is on alloc_ucontext , therefore we were
> >>> safe to free it on dealloc_ucontext as all mappings were already
> >>> zapped. Making the mmap_free a bit redundant for qedr except for the
> >> need to free the entry.
> >>>
> >>> For EFA, it seemed the only operation delayed was freeing memory - I
> >>> didn't see hw resources being freed... Gal?
> >>
> >> What do you mean by hw resources being freed? The BAR mappings are
> >> under the device’s control and are associated to the lifetime of the UAR.
> > The bar offset you get is from the device -> don't you release it back to the device
> > So it can be allocated to a different application ? 
> > In efa_com_create_qp -> you get offsets from the device that you use for mapping
> > The bar -> are these unique for every call ? are they released during destroy_qp ? 
> > Before this patch series mmap_entries_remove_free only freed the DMA pages, but
> > Following this thread, it seemed the initial intention was that only the hw resources would
> > Be delayed as the DMA pages are ref counted anyway.  I didn't see any delay to returning
> > The bar offsets to the device. Thanks.
> The BAR pages are being "freed" back to the device once the UAR is freed.
> These pages' lifetime is under the control of the device so there's nothing the
> driver needs to do, just make sure no one else is using them.

What frees the UAR?

In the mlx drivers this was done during destruction of the ucontext,
but with this new mmap stuff it could be moved to the mmap_free..

Jason
