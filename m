Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B299CF850
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 14:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfD3MHi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 08:07:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727400AbfD3MHh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Apr 2019 08:07:37 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 739F020835;
        Tue, 30 Apr 2019 12:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556626056;
        bh=FHKe9QBg+dbF+xFb8m7ZqEdWesxBv81qzBSGaGOS4j8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IMH/2vaBimgrOB/Mv+k4GEsJT+piwy+TTYSvhiSR8WyXu3oWVS5m96h/Yjw9zDnnl
         0aG0Sy5g8LdZArfzZpOQN5uEkOx9rhAYslayT114zBCkW6A58oAGXUnqHVObaUzF8B
         kpWIieDNEljycNP3I9ws3TTqjTt0eh9x7d6pp5P4=
Date:   Tue, 30 Apr 2019 15:07:32 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        linux-rdma@vger.kernel.org,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for-next] RDMA/uverbs: Initialize udata struct on destroy
 flows
Message-ID: <20190430120732.GG6705@mtr-leonro.mtl.com>
References: <1556613999-14823-1-git-send-email-galpress@amazon.com>
 <20190430111814.GE6705@mtr-leonro.mtl.com>
 <45a1912f-b811-ad4b-cf66-ac02edb4b811@amazon.com>
 <5dbebe7f-a55e-043f-ccc1-30f12096a36b@intel.com>
 <dc45f88e-16fe-bd9d-f45a-584fd83ab773@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc45f88e-16fe-bd9d-f45a-584fd83ab773@amazon.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 30, 2019 at 02:38:30PM +0300, Gal Pressman wrote:
> On 30-Apr-19 14:35, Dennis Dalessandro wrote:
> > On 4/30/2019 7:27 AM, Gal Pressman wrote:
> >> On 30-Apr-19 14:18, Leon Romanovsky wrote:
> >>> On Tue, Apr 30, 2019 at 11:46:39AM +0300, Gal Pressman wrote:
> >>>> Cited commit introduced the udata parameter to different destroy flows
> >>>> but the uapi method definition does not have udata (i.e has_udata flag
> >>>> is not set). As a result, an uninitialized udata struct is being passed
> >>>> down to the driver callbacks.
> >>>>
> >>>> Fix that by clearing the driver udata even in cases where has_udata flag
> >>>> is not set.
> >>>>
> >>>> Fixes: c4367a26357b ("IB: Pass uverbs_attr_bundle down ib_x destroy path")
> >>>> Cc: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> >>>> Co-developed-by: Jason Gunthorpe <jgg@ziepe.ca>
> >>>
> >>> What is wrong with Signed-off-by that caused you to add new tag?
> >>
> >> Jason is the one that originally wrote and sent the code, this tag seems
> >> appropriate.
> >> Obviously I don't mind removing it, it's there to give him credit..
> >
> > Did you find documentation for using that tag or did you just make it up? I
> > think Signed-off-by is what you want here.
>
> https://www.kernel.org/doc/html/v5.0/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

I see no benefit of this new tag over SOB, especially for the patch which
has 100% code of that Co-* author.

Thanks
