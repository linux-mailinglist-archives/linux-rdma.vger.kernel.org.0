Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6401A827A
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2020 17:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407419AbgDNPUh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Apr 2020 11:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438611AbgDNPUS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Apr 2020 11:20:18 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18600C061A0C
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 08:20:18 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id w24so10384636qts.11
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 08:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z1YAow+p2oTS0KjZHDFQURwufvTps2Ola21Ebzq8/Ho=;
        b=iyezjIJqp/sdBoQ3UXzMjDRI+QlR0jFpXTz00KcHVKW7gUIdLKtgUaLTamCODYtz44
         ZauNxHF/IJdYh2sg7CUvVwod3mRBxoiB4q93Qzaj1fnEFF5JNbOt4qhCYFW/wI6SZZnO
         hAueQYPyxW/A0iKkYz4XN+Lj7YKnTe40Gxbbrcr9183wAEfqaJyQiDO1A+2h4xYtp6qJ
         Wj/ceKFv3tuB7I2dOeBYDUk+yoSGCAiOuIdNIZ8UDJSUEEio6zhwr8aYIwi0hjD+14d+
         sLZOhQhqXJWbvf58qItDWr6KOsPTtAbESMzNm3CUJPKme/hM+vNEfnCvDCvnEU4sOb7Q
         EIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z1YAow+p2oTS0KjZHDFQURwufvTps2Ola21Ebzq8/Ho=;
        b=OUGNhjiwQmN1KWF4O0flWgcAhgN1OpuoC/MMyAj3LUGl6BoUzhLLH3DFtoIUsVVyXT
         4LJ0+X3YJdwyccksmN0H27vyPxFDgTTtJd1XkMROfKyXOsoUd7IEUe0zo4ZvY5JkLbwD
         OFz8jobs0LqujqTRTddB9+VamIJGAyqnj0z0bJH+ai4tarqC18LtmLz606xLTl6YysVX
         vbEaVVfl1OlrJ7vJ3G+qz45cMdDpbnIMtqtJzfzm2eV1sEUmBBF8S7lL6Gjmo0/gTUHd
         qZ/6aeoV1vpM099D36oWddY6Vs1uEVCHSiBsxelpb49xXc3E3yxbI96EVWhn8kIielwT
         SIAg==
X-Gm-Message-State: AGi0Puasu2WcKY3R3PfEeM9Ath/6nOuoIH1Jj3kcQ5aAeAv7icxwRmZ0
        ZwuFMHXkQN6lPCkK6Nzs+3vCuQ==
X-Google-Smtp-Source: APiQypIptgaajcv77BtAUSNRPq5NLkX+lMzcXJvBuSXT5gbE3Qw12Uvx7WK9RRNPmKVPyXyIO06lXw==
X-Received: by 2002:aed:3bf7:: with SMTP id s52mr16668392qte.362.1586877617287;
        Tue, 14 Apr 2020 08:20:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id y127sm10755689qkb.76.2020.04.14.08.20.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Apr 2020 08:20:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jONMG-0005Bp-8h; Tue, 14 Apr 2020 12:20:16 -0300
Date:   Tue, 14 Apr 2020 12:20:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Leon Romanovsky <leon@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v1 3/3] svcrdma: Fix leak of svc_rdma_recv_ctxt objects
Message-ID: <20200414152016.GE5100@ziepe.ca>
References: <20200407190938.24045.64947.stgit@klimt.1015granger.net>
 <20200407191106.24045.88035.stgit@klimt.1015granger.net>
 <20200408060242.GB3310@unreal>
 <D3CFDCAA-589C-4B3F-B769-099BF775D098@oracle.com>
 <20200409174750.GK11886@ziepe.ca>
 <20200413192907.GA23596@fieldses.org>
 <20200414121931.GA5100@ziepe.ca>
 <20200414151303.GA9796@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414151303.GA9796@fieldses.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 14, 2020 at 11:13:03AM -0400, J. Bruce Fields wrote:
> On Tue, Apr 14, 2020 at 09:19:31AM -0300, Jason Gunthorpe wrote:
> > On Mon, Apr 13, 2020 at 03:29:07PM -0400, J. Bruce Fields wrote:
> > > On Thu, Apr 09, 2020 at 02:47:50PM -0300, Jason Gunthorpe wrote:
> > > > On Thu, Apr 09, 2020 at 10:33:32AM -0400, Chuck Lever wrote:
> > > > > The commit ID is what automation should key off of. The short
> > > > > description is only for human consumption. 
> > > > 
> > > > Right, so if the actual commit message isn't included so humans can
> > > > read it then what was the point of including anything?
> > > 
> > > Personally as a human reading commits in a terminal window I prefer the
> > > abbreviated form.
> > 
> > Frankly, I think they are useless, picking one of yours at random:
> > 
> >     Fixes: 4e48f1cccab3 "NFSD: allow inter server COPY to have... "
> > 
> > And sadly the '4e48f1cccab3' commit doesn't appear in Linus's tree so
> 
> Ow, apologies.  Looks like I rebased after writing that Fixes tag.
> 
> I wonder if it's possible to make git warn....
> 
> Looks like a pre-rebase hook could check the branch being rebased for
> "Fixes:" lines referencing commits on the rebased branch.

I have some silly stuff to check patches before pushing them and it
includes checking the fixes lines because they are very often
wrong, both with wrong commit IDs and wrong subjects!

linux-next now automates complaining about them, but perhaps not
following the standard format defeats that..

Use 'git merge-base --is-ancestor fixes_id linus/master' to check
them.

> > now we are just totally lost, with a bad commit ID and a mangled
> > subject line.
> 
> For what it's worth, that part of the subject line is enough to find the
> original commit (even to uniquely specify it).

Lucky, but I wouldn't count on this as the general rule.. The point of
the full subject line is to be informative to the reader and serve as
a backup key in case the hash got mangled, as happens surprisingly
often..

Jason
