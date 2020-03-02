Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADEC175DE8
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 16:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgCBPKA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 10:10:00 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44175 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbgCBPKA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Mar 2020 10:10:00 -0500
Received: by mail-qk1-f193.google.com with SMTP id f198so2598668qke.11
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2020 07:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N8SNyCjNb2Ol0mPt/h9lHEFs/F/R+FkJiirkQ6gDuNU=;
        b=expCroaEPAmx9FqTfAAtIAK+/Aa+SgOh98dgUCcYDNsOzBgsL3mO8iqyOruX7mw/Pn
         LeMMxUtYmbpadFQE5+/5r2O4Vma4/C9QpuOw+wtIEX7IrhmPSwl53+5xNnIHfybB8Ddu
         RBp8bmR1AmBwCqYp3pf/uDLE7DJyvGZ0tVUyDsA+W0ckSucKB8o1pmt8cX27Rh0FuuD9
         l5DnDKLYd/jMSJqjWwQR0+2bs+1iHDRsQjdN6SlCx37B0OSVlkHARfYanJONj23yIZUt
         /wmkNiFdohsldkY/S2PcvxMF5HtIScRjZR+se6UqWhUmTOZ92pL7zSK1jR8OAJFIJdtr
         clTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N8SNyCjNb2Ol0mPt/h9lHEFs/F/R+FkJiirkQ6gDuNU=;
        b=Gtgt5lOnmT3ntnXNhWaHukx1iQlUtqEwH//kD/yWZPiPFji9KNZzMhGR0mTHCOFUHk
         KdxwTW+W9ZaW8pL8v3zBlZxSbHl4o37FOk0rH2whKtSX/l9pS06fNDfQpHZ2gauqJUW8
         Txq56XgQyKs1EKKVFjZYp0aQIQj86myLtgcPQ+fSyMFi0gLV3GLsBHALd5mVdM+wzZs7
         LmQN1HySjwa+3MGg10LCKBIKQ/Rs93BjKtZCnmwQB/Gp510SRS5k6v1NDUwUxU4t14mp
         axusX5c1JXmF/9RyrxMf3nJ90hf2nW2UHgwOaP3o+TY5C3JK3laVSFBydrTOsx98BBlg
         R+Gg==
X-Gm-Message-State: ANhLgQ3xFw7MHLaX75VTnXyCrOTw2DY4h2ObpDZbfrPwxBAuUvEg+y0F
        b3asb5XO/KvKYblxH60KreSLFQ==
X-Google-Smtp-Source: ADFU+vtWANPvnugGG5PQ1urgmYeDSbIElel8g3TMCap1tKFJ/oAf+Whgm5ODO/DBHoVyCmD2ax1sQA==
X-Received: by 2002:a05:620a:13e3:: with SMTP id h3mr1893223qkl.44.1583161799254;
        Mon, 02 Mar 2020 07:09:59 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id w60sm10304739qte.39.2020.03.02.07.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Mar 2020 07:09:58 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j8mhh-0003qt-QK; Mon, 02 Mar 2020 11:09:57 -0400
Date:   Mon, 2 Mar 2020 11:09:57 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: Re: [PATCH for-rc] IB/hfi1, qib: Ensure RCU is locked when accessing
 list
Message-ID: <20200302150957.GZ31668@ziepe.ca>
References: <20200225195445.140896.41873.stgit@awfm-01.aw.intel.com>
 <20200228161516.GA26535@ziepe.ca>
 <8c036704-cd70-fd86-4fb7-20621543d1d2@intel.com>
 <20200302132921.GX31668@ziepe.ca>
 <bb4cdcd5-46c9-339a-54a1-5560e14ed9fe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb4cdcd5-46c9-339a-54a1-5560e14ed9fe@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 02, 2020 at 09:52:03AM -0500, Dennis Dalessandro wrote:
> On 3/2/2020 8:29 AM, Jason Gunthorpe wrote:
> > On Mon, Mar 02, 2020 at 08:14:52AM -0500, Dennis Dalessandro wrote:
> > > On 2/28/2020 11:15 AM, Jason Gunthorpe wrote:
> > > > On Tue, Feb 25, 2020 at 02:54:45PM -0500, Dennis Dalessandro wrote:
> > > > > The packet handling function, specifically the iteration of the qp list
> > > > > for mad packet processing misses locking RCU before running through the
> > > > > list. Not only is this incorrect, but the list_for_each_entry_rcu() call
> > > > > can not be called with a conditional check for lock dependency. Remedy
> > > > > this by invoking the rcu lock and unlock around the critical section.
> > > > > 
> > > > > This brings MAD packet processing in line with what is done for non-MAD
> > > > > packets.
> > > > > 
> > > > > Cc: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> > > > > Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> > > > > Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> > > > >    drivers/infiniband/hw/hfi1/verbs.c    |    4 +++-
> > > > >    drivers/infiniband/hw/qib/qib_verbs.c |    2 ++
> > > > >    2 files changed, 5 insertions(+), 1 deletion(-)
> > > > 
> > > > Applied to for-next, thanks
> > > > 
> > > 
> > > Maybe it should have went to -rc?
> > 
> > It doesn't even have a fixes line. If you want patches in -rc send
> > better commit message. I keep repeating this again and again..
> > 
> > Jason
> > 
> 
> Crap, yeah my bad on that. However there really isn't a good fixes line for
> this. It's pretty much just the initial commit of the driver, does that
> really help? It's still just in your WIP branch so is it too late to add:
> 
> Fixes: 7724105686e7 ("IB/hfi1: add driver files")

Yes, it really does help, ok I updated it.

> Other than a fixes line what else do you need for the commit message? Messed
> up locking is pretty self explanatory I would think.

Well, missing rcu_lock only causes problems for realtime kernels, but
sure it can be moved to -rc

Jason
