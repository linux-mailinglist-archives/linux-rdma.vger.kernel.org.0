Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42D5B10B4F
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2019 18:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfEAQ3d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 May 2019 12:29:33 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45910 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfEAQ3d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 May 2019 12:29:33 -0400
Received: by mail-yw1-f67.google.com with SMTP id r139so8674372ywe.12
        for <linux-rdma@vger.kernel.org>; Wed, 01 May 2019 09:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=T9Z8RFGs2a/irq3SWQJ1wI98nx1GrUfatzyTxU7r1+8=;
        b=C3FvmrMBuzUACJYrxuTGUgqxZv3mpshAQtO9/Kj6zJtcYTcoVc1kM/BtOy8gaymebt
         CAZeDIBHC4QB1JwS5bWAUtWfgl9CscRrnjq1YkzOB6FGnQkIjRzSwkeU7bLNDDJUlLdn
         0e5Q5prLVlMCAz/RsuK1WdWhqqG7PfyZBbc/doGbmodfFYtdcG6p32b9pHZmX5vm3LpQ
         /whicNf0skZBrXIfPEng3sUdnMoNJtuz/sbWTecMK6Hj3MRyxRGIFbc4LSN1AGQP0AaN
         CyGW+9y8xgCoJtjR9ADc51eS9WD5AxbSiZKwUlaLtp53RsdrVNeKwVyh5YTWzLv2MOFP
         opmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=T9Z8RFGs2a/irq3SWQJ1wI98nx1GrUfatzyTxU7r1+8=;
        b=XEOfI9U1VW9ynsPBOD/dFUXPJnocCwCRFA/4XtNfUSvMCcwoST0SM5PsCM7aqq5DEY
         EHLhVAp3XrJEUX/ZzulBYdRTUsKoHBaYmQgiFcV1cStQSiBOmRaeTWoftTKRLN4aEWE1
         2ahRnh/LQHLs5kxbJvirA2jbDRYwWqzrqLWC8mlAGsYLUeGi+rhYUA5XLhsbS4fvZ8F5
         /YGYkViqsIMR/5KbpBAVXOfGAUCT9X8+hYbrNjOggzf0zzn+uQQ9RQgb1KYis1qn8LZR
         xLzQr5XRhPxy0Y5+NEjB4B/FOh0Oq7q3FRIuu3HcNSSjNN94pQilWPVoMdp7FOsLKq1z
         6nqQ==
X-Gm-Message-State: APjAAAWBdHwaVwpCSCcXPeRss+4MX+h/98413/YcW/fSk4ApLblOUae6
        TQJeE0pY6Bz1GTDDK89/a0Kbme8Qscc=
X-Google-Smtp-Source: APXvYqyJwtgQkXG9nv4QTFCW6rQIG1Lt3Wv0uvj00d+ieQYsSb5AP3hfMJiBJt/QxVQHZsOt3fqByw==
X-Received: by 2002:a0d:dd45:: with SMTP id g66mr54585019ywe.177.1556728172454;
        Wed, 01 May 2019 09:29:32 -0700 (PDT)
Received: from ziepe.ca (adsl-173-228-226-134.prtc.net. [173.228.226.134])
        by smtp.gmail.com with ESMTPSA id v191sm1985636ywv.55.2019.05.01.09.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 09:29:31 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hLs6t-0004II-33; Wed, 01 May 2019 13:29:31 -0300
Date:   Wed, 1 May 2019 13:29:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Leon Romanovsky <leon@kernel.org>, Tejun Heo <tj@kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>
Subject: Re: [PATCH for-rc 1/5] IB/hfi1: Fix WQ_MEM_RECLAIM warning
Message-ID: <20190501162931.GA15621@ziepe.ca>
References: <20190318165205.23550.97894.stgit@scvm10.sc.intel.com>
 <20190318165501.23550.24989.stgit@scvm10.sc.intel.com>
 <20190319192737.GB3773@ziepe.ca>
 <32E1700B9017364D9B60AED9960492BC70CD9227@fmsmsx120.amr.corp.intel.com>
 <20190327152517.GD69236@devbig004.ftw2.facebook.com>
 <20190327170213.GD22899@mtr-leonro.mtl.com>
 <4A4820DA-474E-437F-B3D3-56EAA31ED58D@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4A4820DA-474E-437F-B3D3-56EAA31ED58D@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 01, 2019 at 11:21:08AM -0400, Doug Ledford wrote:
> On Mar 27, 2019, at 1:02 PM, Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > On Wed, Mar 27, 2019 at 08:25:17AM -0700, Tejun Heo (tj@kernel.org) wrote:
> >> Hello,
> >> 
> >> On Tue, Mar 26, 2019 at 08:55:09PM +0000, Marciniszyn, Mike wrote:
> >>> The latter is the ipoib wq that conflicts with our non-WQ_MEM_RECLAIM.  This seems excessive and pretty gratuitous.
> >>> 
> >>> Tejun, what does "mem reclaim" really mean and when should it be used?
> >> 
> >> That it may be depended during memory reclaim.
> >> 
> >>> I was assuming that since we are freeing QP kernel memory held by user mode programs that could be oom killed, we need the flag.
> >> 
> >> If it can't block memory reclaim, it doesn't need the flag.  Just in
> >> case, if a workqueue is used to issue block IOs, it is depended upon
> >> for memory reclaim as writeback and swap-outs are critical parts of
> >> memory reclaim.
> > 
> > It looks like WQ_MEM_RECLAIM is needed for IPoIB, because if NFS runs
> > over IPoIB, it will do those types of IOs.
> 
> Because of what IPoIB does, you’re right that it’s needed.  However,
> it might be necessary to audit the wq usage in IPoIB to make sure
> it’s actually eligible for the flag and that it hasn’t been set when
> the code doesn’t meet the requirements of the flag.

It isn't right - it is doing memory allocations from the work queue
without the GFP_NOIO (or memalloc_noio_save)

And I'm not sure it can actually tolerate failure of a memory
allocation anyhow without blocking the dataplane.

In other words, the entire thing hasn't been designed with the idea
that it could be on the IO path..

I'm not sure how things work if NFS is on the critical reclaim path in
general - does it even work with a normal netdev? How does netdev
allocate a neighbor for instance if it becomes required?

Jason
