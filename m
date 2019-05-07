Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E94A516AC7
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 20:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfEGS4C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 14:56:02 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37338 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfEGS4C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 14:56:02 -0400
Received: by mail-qt1-f194.google.com with SMTP id o7so8360182qtp.4
        for <linux-rdma@vger.kernel.org>; Tue, 07 May 2019 11:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WjKzKGj6Y/X1rcQdz/pN+9bcNAZSA+oEv0J12SBKndM=;
        b=ckRL0GPUuivIkQSqo5H4gyvYfH2KNoYLgWvY82whdV0mhhQguB1bHIl3eu+w20V/SW
         xLdoUtecS7fB809Sd1bvUJHPHV1IntGsoCWsiCc9di3x/8cIJLkxvrlF062K/PTlKZmh
         Uf8sqN8TDGY8Y4NcU4IoyNP7ZiKI8dCi4IUJUGrIPjJMiQbE6TCshKZd8QM5S9k3MNCa
         AKtqaljxkt5ZLigUgvBkHUUjfoGtXASKci2KpvJMQUpYg3Og3i0sP99hNzSBiMKcMSD/
         4eilPidcHNIg8rSxPP+ylc23fC2xxQvWqQkOP2u+vqVTEVF0RiA9Lo6sIqZM3VKyUP/e
         xXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WjKzKGj6Y/X1rcQdz/pN+9bcNAZSA+oEv0J12SBKndM=;
        b=c3P4/ynV+QkA5HhxqxH4orSrfMwLs8l+VN1m0GIROTaX7EN3kQqniVdPeLF0kEZ9fK
         G4k09x6f8kTYdhsg35KX5YHFE3yppCvS5ePlZXIZhMxyvzk1+r0wpNusTgnZCbcS+NY8
         x8kN17Pq95BFK8czJM45xYyxk3nKJJNQDhfWhJBmp3FKuDHzKLI0iePey28gG7H42gvg
         sGaw3/bJcB5M3bHZ+jV3JtviWEOo0WmVPYtqGA2FGiQh/hoqxXJnXbRwkFz9/t62GpYl
         lRSwSlC5BCyyNCuP6MhWnwwYamI1QnEoCKuArC99SrcQ5a19rVtKuVX+uf4KPXEVhTq6
         1+og==
X-Gm-Message-State: APjAAAUyC3zl08BkIo3bjgiVnVitcZBhFUXVGiyL1qPmueP2WGUV13dv
        R/q/Ru7/Q5LgmVTCQn64mGUdaw==
X-Google-Smtp-Source: APXvYqxuxm49DkdcIGhmy+MkEx1Thqlv8h0AHhgEU3HeOkLf8kR54RAoMhoN+8Ny15r4+QOov7bF3w==
X-Received: by 2002:a0c:8187:: with SMTP id 7mr8052597qvd.247.1557255361140;
        Tue, 07 May 2019 11:56:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id v190sm5727470qkc.9.2019.05.07.11.55.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 11:56:00 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hO5Fv-0007fB-CR; Tue, 07 May 2019 15:55:59 -0300
Date:   Tue, 7 May 2019 15:55:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Tejun Heo (tj@kernel.org)" <tj@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>
Subject: Re: [PATCH for-rc 1/5] IB/hfi1: Fix WQ_MEM_RECLAIM warning
Message-ID: <20190507185559.GJ6201@ziepe.ca>
References: <20190327194347.GH21008@ziepe.ca>
 <20190327212502.GF69236@devbig004.ftw2.facebook.com>
 <053009d7de76f8800304f354e3cbde068453257f.camel@redhat.com>
 <32E1700B9017364D9B60AED9960492BC70D3737D@fmsmsx120.amr.corp.intel.com>
 <580150427022440ab0475cda91d666322ef7e055.camel@redhat.com>
 <32E1700B9017364D9B60AED9960492BC70D38297@fmsmsx120.amr.corp.intel.com>
 <20190506181610.GB6201@ziepe.ca>
 <20190506190356.GO6938@mtr-leonro.mtl.com>
 <20190506200849.GF6201@ziepe.ca>
 <7C7AD392-B9EE-41D8-92C9-D09037E8B6E5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7C7AD392-B9EE-41D8-92C9-D09037E8B6E5@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 06, 2019 at 04:18:44PM -0400, Chuck Lever wrote:
> 
> 
> > On May 6, 2019, at 4:08 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > On Mon, May 06, 2019 at 10:03:56PM +0300, Leon Romanovsky wrote:
> >> On Mon, May 06, 2019 at 03:16:10PM -0300, Jason Gunthorpe wrote:
> >>> On Mon, May 06, 2019 at 05:52:48PM +0000, Marciniszyn, Mike wrote:
> >>>>> 
> >>>>> My mistake.  It's been a long while since I coded the stuff I did for
> >>>>> memory reclaim pressure and I had my flag usage wrong in my memory.
> >>>>> From the description you just gave, the original patch to add
> >>>>> WQ_MEM_RECLAIM is ok.  I probably still need to audit the ipoib usage
> >>>>> though.
> >>>>> 
> >>>> 
> >>>> Don't lose sight of the fact that the additional of the WQ_MEM_RECLAIM is to silence
> >>>> a warning BECAUSE ipoib's workqueue is WQ_MEM_RECLAIM.  This happens while
> >>>> rdmavt/hfi1 is doing a cancel_work_sync() for the work item used by the QP's send engine
> >>>> 
> >>>> The ipoib wq needs to be audited to see if it is in the data path for VM I/O.
> >>> 
> >>> Well, it is doing unsafe memory allocations and other stuff, so it
> >>> can't be RECLAIM. We should just delete them from IPoIB like Doug says.
> >> 
> >> Please don't.
> > 
> > Well then fix the broken allocations it does, and I don't really see
> > how to do that. We can't have it both ways.
> > 
> > I would rather have NFS be broken then normal systems with ipoib
> > hanging during reclaim.
> 
> TBH, NFS on IPoIB is a hack that I would be happy to see replaced
> with NFS/RDMA.

Does NFS/RDMA even work? Tejun said you can't do a GFP_KERNEL
allocation on the writeback progress path.

So if the system runs out of memory, and NFS/RDMA is in a state where
the connection has glitched and needs to be restarted it needs to go
through the whole CM stuff to progress writeback. That stuff uses
GFP_KERNEL, so it is not OK.

This is where nvme got to when it started to look at this problem.

> If you are truly curious, bring this up on linux-nfs to find out
> what NFS needs and how it works on Ethernet-only network stacks.

I have a feeling the only robust answer here is that NFS can never be
on the critical path of reclaim

Jason
