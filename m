Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2F25175B9F
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 14:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgCBN3Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 08:29:24 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37507 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbgCBN3Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Mar 2020 08:29:24 -0500
Received: by mail-qt1-f193.google.com with SMTP id j34so7522459qtk.4
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2020 05:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GhA06hWrbCQmtMvc++hcsURdqNebD8apDHeMWTba0tk=;
        b=GajPFRQ+wH3vBSO4yVHtWZW+Z2QdQw894shd8/3f9GhHBuODs9wq7o+/S4yVQ4TXFb
         fuRdrlLnFYFqp5eUIZnokNy/PO2tLk/O0O6EMkSBCke07QWHjwblJuApTVGoPrLTwYiU
         MhYYrBHZZ1IsWYorADDCKrfzmAt7H5XBNDd/jdcqvWbzEgsnYfEgXV0kapPTsU2IYwql
         qtwGfdN5YgCppZUVVDUKlqwhnN7aBqVPiQq823UtpSW1KbpTC4oYdCoorzENfRz1GDYh
         8TVJWEeM9e7SXDFp6wXgGQ/gqbE3XDr3EYrCCntUbPEyWvUmGFDg2oo0vwTg/Zha4NAG
         CffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GhA06hWrbCQmtMvc++hcsURdqNebD8apDHeMWTba0tk=;
        b=HvWxp/vp9gocyYuWYGd1uXDV8bDTTwFoldiJOkRcafqA/8+9kTI11eiTQMB5qr5gGZ
         dIaYMdsnB20t2h/ivNRZK0ssAqnPs4j8z/tRgAigt3QkLiFBQv92shHzipFm+71Ps6+u
         2IhbWxu0JTr6td4VfDRrByL6Ca6E+Vdu7DDhIqS7R74CeJdtt/YzJjXmNFpVLj2SGb7e
         9/V7O5BCMtiRpFfLiFPS6/iDni3h2uL1B6QC66RS7HxZhlOr0CqM/xsCI4ScUKwG2nNL
         klWLoyqvV/3uiI09Ln1rkiPDHvZlG6K++CbV2f5eNVWg5BoUrJ0o2evsUMXmlPy4mKqQ
         0hnQ==
X-Gm-Message-State: APjAAAU8yVsT9BrJSVlaYpJjq5Zn4+F8THKdEEHvnKHGmvyTR3Fm1/kF
        +sQgW4gfXDFqfRAGo/TtFFFHDA==
X-Google-Smtp-Source: APXvYqwQb/UDu8oV7oJak+W2OrWojer4N++VK7kbj7Lc8m8ar6ivMTnV7k5l9kZIaIGkEzCnixu3kw==
X-Received: by 2002:ac8:481a:: with SMTP id g26mr15177281qtq.91.1583155763103;
        Mon, 02 Mar 2020 05:29:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n138sm10026699qkn.33.2020.03.02.05.29.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Mar 2020 05:29:22 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j8l8L-0004V9-Ot; Mon, 02 Mar 2020 09:29:21 -0400
Date:   Mon, 2 Mar 2020 09:29:21 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: Re: [PATCH for-rc] IB/hfi1, qib: Ensure RCU is locked when accessing
 list
Message-ID: <20200302132921.GX31668@ziepe.ca>
References: <20200225195445.140896.41873.stgit@awfm-01.aw.intel.com>
 <20200228161516.GA26535@ziepe.ca>
 <8c036704-cd70-fd86-4fb7-20621543d1d2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c036704-cd70-fd86-4fb7-20621543d1d2@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 02, 2020 at 08:14:52AM -0500, Dennis Dalessandro wrote:
> On 2/28/2020 11:15 AM, Jason Gunthorpe wrote:
> > On Tue, Feb 25, 2020 at 02:54:45PM -0500, Dennis Dalessandro wrote:
> > > The packet handling function, specifically the iteration of the qp list
> > > for mad packet processing misses locking RCU before running through the
> > > list. Not only is this incorrect, but the list_for_each_entry_rcu() call
> > > can not be called with a conditional check for lock dependency. Remedy
> > > this by invoking the rcu lock and unlock around the critical section.
> > > 
> > > This brings MAD packet processing in line with what is done for non-MAD
> > > packets.
> > > 
> > > Cc: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> > > Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> > > Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> > >   drivers/infiniband/hw/hfi1/verbs.c    |    4 +++-
> > >   drivers/infiniband/hw/qib/qib_verbs.c |    2 ++
> > >   2 files changed, 5 insertions(+), 1 deletion(-)
> > 
> > Applied to for-next, thanks
> > 
> 
> Maybe it should have went to -rc?

It doesn't even have a fixes line. If you want patches in -rc send
better commit message. I keep repeating this again and again..

Jason
