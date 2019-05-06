Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21459154CC
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 22:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfEFUIx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 16:08:53 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39075 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfEFUIw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 16:08:52 -0400
Received: by mail-qt1-f193.google.com with SMTP id y42so16350812qtk.6
        for <linux-rdma@vger.kernel.org>; Mon, 06 May 2019 13:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P//cgiXW98aWt456rO6uqbuEIkKSQ8wK8Usw6crMETA=;
        b=DVUwh35+Wi80SP36eX+CTBh/LIjGfHjXKipbOO3U73xiykLxkorgfhBQSFvxlgsrQ7
         KJu/DG3w6wkI+Uy9dvjrVcW3YlMCa5Pq5U2/e9sW/zQgvmQbgLUfsLnvvjNzBCav0FOU
         iWwzbVih1sXoU1gTrTgE+y9RfrqqJgOCdW9oq0/3Qj/kiuX07ImjyeK4TOr6l01Nb1Y/
         gakf7HHyR90MWmTfbfqGKIUI/vP8XH38tSX8zYyJaTnShnaDQ4nifyTr9Z8rtqGIuRRc
         MPN4JUVJmsTZmrfJAuz55J6OqurrEol+qC1dHVsHVcVEKORKtgeYYH03kctyAOAxTa6F
         NASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P//cgiXW98aWt456rO6uqbuEIkKSQ8wK8Usw6crMETA=;
        b=mPElah5ENCxuLkLV2voLOWDCIDyjWMVALuTiJu4IBnD3/rLt+FTny5C3XhCQkGK9zJ
         Cicl/dDhweEU149McOEBUbEB7WN6UwAT9mFr/u9eNNtb3Wd65NOUfPfTlMhfYgPaNgV5
         2+JmRU0Wkj+u7JgLWFDZjpYmSs6qPjdyGDcjE6AWji9jPQQ/QC5waFH3IH8PT3F1MJEJ
         lRnGC2GIR0tWYgeVeko96otv3mWSwTmpyEjtSyINZFKJMjz90S16tmQC+vjOKraPxGMs
         hh77kdeRTd2wnDYPR7pVb3CWSy+ZVvZ4klOkp6kxBp994isYIclCb98mGSd7pZVXjbq0
         dSdQ==
X-Gm-Message-State: APjAAAXeoEWNWmcejpq54HzXqshaZiTkA2Gu7OE+sJVWeZlR5oHWkuzc
        R8SXrUtTU/y/YG9EHFxpDIroDw==
X-Google-Smtp-Source: APXvYqx3jQpACSmEBHbAZH8lWmc4z6mIpu/nYIJbSkHlNhl7Ubp2HnKhHqIG7LdUYjVrVs9CpmDCWQ==
X-Received: by 2002:a0c:c48c:: with SMTP id u12mr22752826qvi.107.1557173331829;
        Mon, 06 May 2019 13:08:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id z85sm6754538qka.18.2019.05.06.13.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 13:08:50 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hNjur-0004KK-Ua; Mon, 06 May 2019 17:08:49 -0300
Date:   Mon, 6 May 2019 17:08:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Tejun Heo (tj@kernel.org)" <tj@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>
Subject: Re: [PATCH for-rc 1/5] IB/hfi1: Fix WQ_MEM_RECLAIM warning
Message-ID: <20190506200849.GF6201@ziepe.ca>
References: <20190327171611.GF21008@ziepe.ca>
 <20190327190720.GE69236@devbig004.ftw2.facebook.com>
 <20190327194347.GH21008@ziepe.ca>
 <20190327212502.GF69236@devbig004.ftw2.facebook.com>
 <053009d7de76f8800304f354e3cbde068453257f.camel@redhat.com>
 <32E1700B9017364D9B60AED9960492BC70D3737D@fmsmsx120.amr.corp.intel.com>
 <580150427022440ab0475cda91d666322ef7e055.camel@redhat.com>
 <32E1700B9017364D9B60AED9960492BC70D38297@fmsmsx120.amr.corp.intel.com>
 <20190506181610.GB6201@ziepe.ca>
 <20190506190356.GO6938@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506190356.GO6938@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 06, 2019 at 10:03:56PM +0300, Leon Romanovsky wrote:
> On Mon, May 06, 2019 at 03:16:10PM -0300, Jason Gunthorpe wrote:
> > On Mon, May 06, 2019 at 05:52:48PM +0000, Marciniszyn, Mike wrote:
> > > >
> > > > My mistake.  It's been a long while since I coded the stuff I did for
> > > > memory reclaim pressure and I had my flag usage wrong in my memory.
> > > > From the description you just gave, the original patch to add
> > > > WQ_MEM_RECLAIM is ok.  I probably still need to audit the ipoib usage
> > > > though.
> > > >
> > >
> > > Don't lose sight of the fact that the additional of the WQ_MEM_RECLAIM is to silence
> > > a warning BECAUSE ipoib's workqueue is WQ_MEM_RECLAIM.  This happens while
> > > rdmavt/hfi1 is doing a cancel_work_sync() for the work item used by the QP's send engine
> > >
> > > The ipoib wq needs to be audited to see if it is in the data path for VM I/O.
> >
> > Well, it is doing unsafe memory allocations and other stuff, so it
> > can't be RECLAIM. We should just delete them from IPoIB like Doug says.
> 
> Please don't.

Well then fix the broken allocations it does, and I don't really see
how to do that. We can't have it both ways.

I would rather have NFS be broken then normal systems with ipoib
hanging during reclaim.

Jason
