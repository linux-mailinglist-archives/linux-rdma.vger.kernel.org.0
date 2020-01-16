Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAFD13D50D
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 08:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgAPHcN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 02:32:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:34760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbgAPHcN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Jan 2020 02:32:13 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 853FF206D9;
        Thu, 16 Jan 2020 07:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579159932;
        bh=71p+ojXSFncYgtjwBte4i1//8EsdierqMI4JPvefN0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2OlW3PLsZ9J5jY7zPjXU9ENigXmjDDeDmkiaIl73Okhxgh1lbgGjeoZEwZjcLHFKQ
         ao9YwSJe3MjYOELfAI2J4qotAdWs/ffrXLqSJ4swvCkTVh1k9IaSvhZHSpt0PqliK9
         ednWxwejV5ldfVWGVP58EXfZ3IL7RbsgFroMAogo=
Date:   Thu, 16 Jan 2020 09:32:08 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-rc v2 00/48] Organize code according to IBTA layout
Message-ID: <20200116073208.GG76932@unreal>
References: <20191212093830.316934-1-leon@kernel.org>
 <20200107184019.GA20166@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107184019.GA20166@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 07, 2020 at 02:40:19PM -0400, Jason Gunthorpe wrote:
> On Thu, Dec 12, 2019 at 11:37:42AM +0200, Leon Romanovsky wrote:
> >   RDMA/cm: Delete unused CM LAP functions
> >   RDMA/cm: Delete unused CM ARP functions
>
> These are applied to for-next
>
> > Leon Romanovsky (48):
> >   RDMA/cm: Provide private data size to CM users
> >   RDMA/srpt: Use private_data_len instead of hardcoded value
> >   RDMA/ucma: Mask QPN to be 24 bits according to IBTA
> >   RDMA/cm: Add SET/GET implementations to hide IBA wire format
> >   RDMA/cm: Request For Communication (REQ) message definitions
> >   RDMA/cm: Message Receipt Acknowledgment (MRA) message definitions
> >   RDMA/cm: Reject (REJ) message definitions
> >   RDMA/cm: Reply To Request for communication (REP) definitions
> >   RDMA/cm: Ready To Use (RTU) definitions
> >   RDMA/cm: Request For Communication Release (DREQ) definitions
> >   RDMA/cm: Reply To Request For Communication Release (DREP) definitions
> >   RDMA/cm: Load Alternate Path (LAP) definitions
> >   RDMA/cm: Alternate Path Response (APR) message definitions
> >   RDMA/cm: Service ID Resolution Request (SIDR_REQ) definitions
> >   RDMA/cm: Service ID Resolution Response (SIDR_REP) definitions
> >   RDMA/cm: Convert QPN and EECN to be u32 variables
> >   RDMA/cm: Convert REQ responded resources to the new scheme
> >   RDMA/cm: Convert REQ initiator depth to the new scheme
> >   RDMA/cm: Convert REQ remote response timeout
> >   RDMA/cm: Simplify QP type to wire protocol translation
> >   RDMA/cm: Convert REQ flow control
> >   RDMA/cm: Convert starting PSN to be u32 variable
> >   RDMA/cm: Update REQ local response timeout
> >   RDMA/cm: Convert REQ retry count to use new scheme
> >   RDMA/cm: Update REQ path MTU field
> >   RDMA/cm: Convert REQ RNR retry timeout counter
> >   RDMA/cm: Convert REQ MAX CM retries
> >   RDMA/cm: Convert REQ SRQ field
> >   RDMA/cm: Convert REQ flow label field
> >   RDMA/cm: Convert REQ packet rate
> >   RDMA/cm: Convert REQ SL fields
> >   RDMA/cm: Convert REQ subnet local fields
> >   RDMA/cm: Convert REQ local ack timeout
> >   RDMA/cm: Convert MRA MRAed field
> >   RDMA/cm: Convert MRA service timeout
> >   RDMA/cm: Update REJ struct to use new scheme
> >   RDMA/cm: Convert REP target ack delay field
> >   RDMA/cm: Convert REP failover accepted field
> >   RDMA/cm: Convert REP flow control field
> >   RDMA/cm: Convert REP RNR retry count field
> >   RDMA/cm: Convert REP SRQ field
> >   RDMA/cm: Convert LAP flow label field
> >   RDMA/cm: Convert LAP fields
> >   RDMA/cm: Convert SIDR_REP to new scheme
> >   RDMA/cm: Add Enhanced Connection Establishment (ECE) bits
> >   RDMA/cm: Convert private_date access
>
> I spent a long, long time looking at this. Far too long.
>
> The series is too big, and the patches make too many changes all at
> once. There are also many problems with the IBA_GET/etc macros I gave
> you. Finally, I didn't like that it only did half the job and still
> left the old structs around.
>
> I fixed it all up, and put it here:
>
> https://github.com/jgunthorpe/linux/commits/cm_rework
>
> I originaly started by just writing out the IBA_CHECK things in the
> first patch. This showed that the IBA_ acessors were not working right
> (I fixed all those too). At the end of that exercise I had full
> confidence that the new macros and the field descriptors were OK.
>
> When I started to look at the actual conversion patches and doing the
> missing ones, I realized this whole thing was trivially done via
> spatch. So I made a script that took the proven mapping of new names
> to old names and had it code gen a spatch script which then was
> applied.
>
> I split the spatch rules into 4 patches bases on 'kind of thing' being
> converted.
>
> The first two can be diffed against your series. I didn't observe any
> problems, so the conversion was probably good. However, it was hard to
> tell as there was lots of functional changes mixed in your series,
> like dropping more BE's and what not.
>
> The last two complete the work and convert all the loose structure
> members. The final one deletes most of cm_msgs.h
>
> I have a pretty high confidence in the spatch process and the input
> markup. But I didn't run sparse or test it.
>
> While this does not do everything your series did, it gobbles up all
> the high LOC stuff and the remaining things like dropping more of the
> be's are best done as smaller followup patches which can be applied
> right away.
>
> The full diffstat is ridiculous:
>  5 files changed, 852 insertions(+), 1253 deletions(-)
>
> Please check the revised series and let me know.

Hi Jason,

We tested the series and I reviewed it on github, everything looks
amazing, and I have only three nitpicks.

1. "exta" -> "extra"
2. IMHO, you don't need to include your selftest in final patches, because
the whole series is going to be accepted and that code will be added and
deleted at the same time. Especially printk part.
3. Copyright needs to be 2020

Thanks,
Tested-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
