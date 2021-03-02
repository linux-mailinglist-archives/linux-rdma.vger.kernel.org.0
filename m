Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860EB32A815
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Mar 2021 18:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351631AbhCBRGt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Mar 2021 12:06:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:47750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376827AbhCBINY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 2 Mar 2021 03:13:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE4FF600EF;
        Tue,  2 Mar 2021 08:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614672710;
        bh=C05pcYmBBTPybCut+kGLUjfBfyTbzd68WhGvjViqEOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rG9sCufSqhJGkWa3Wv1nCjYmt23QwFdzuRDfRMjZizdr9GQBJx68Jcd0uBq6ehTKA
         rtphjdV0m3fr9gmfn1LvpN8qfk9tAIjX4qXs5eVrVVjWcgzyV541ljuA4QDhj2nyan
         EkUQ0pJOx8MJC1lBXHAUwKBc1JfAb7zxw7KVAMybL3pF2rxHb/hlFwnOCKXlBKYuJT
         A5bDYVFochm6RYu9fs7qRglmLSXxlKXKfDFj8LHrzqAHklME5pEtZ3vmMvTNuwPVqF
         x+i/9xlNBn8p7ggONd4lI03Zp4UoOI2BTJrZtdOgCJyROaM3357SwheuJK/45Rt9cS
         e+FIk9fZ37CVw==
Date:   Tue, 2 Mar 2021 10:11:46 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Zago, Frank" <frank.zago@hpe.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix ib_device reference counting
 (again)
Message-ID: <YD3zQjVgoTpiQlei@unreal>
References: <48dcbdc5-35a3-2fe3-3e3d-bff37c2d8053@gmail.com>
 <20210226233301.GA4247@nvidia.com>
 <3165add7-518d-9485-fa12-6d7822ed9165@gmail.com>
 <YDoGJIcB6SB/7LPj@unreal>
 <db406802-25a8-bda8-6add-4b75057eec96@gmail.com>
 <YDyWqLuRw33mU63D@unreal>
 <b1fec0dc-6b4a-8364-2b90-a4ef5cd839c6@gmail.com>
 <20210301173540.GN4247@nvidia.com>
 <CS1PR8401MB08218976C89D1C7B20394B4DBC9A9@CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM>
 <20210301182711.GZ4247@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301182711.GZ4247@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 01, 2021 at 02:27:11PM -0400, Jason Gunthorpe wrote:
> On Mon, Mar 01, 2021 at 06:20:06PM +0000, Pearson, Robert B wrote:
> > > On Mon, Mar 01, 2021 at 10:54:21AM -0600, Bob Pearson wrote:
> >
> > >> I agree that ib_device_get/put is attempting to solve a problem that
> > >> it not really very critical since ib_device is very unlikely to be
> > >> shut down in the middle of a data transfer. The driver never worried about this for years.
> > >> But now that it's been put on the table it should be done right. A
> > >> data packet arriving is completely independent of the verbs API which
> > >> *could* delete all the QPs and shut down the HCA while it was
> > >> wondering around the universe or worse yet while the packet is being processed.
> >
> > > If driver shutdown can guarentee that all pointers involved in
> > > multicast are revoked before shutdown can finish then you don't
> > > need this refcounting.
> >
> > > It was only brought up because the API that returns the ib_device
> > > from the netdev requires the refcounts as it is general purpose
> >
> > Unfortunately what you ask for is exactly what the refcounting code
> > accomplishes and I don't see a simpler way to get there.  This also
> > applies to the non-multicast packets as well but all the debate has
> > been about the code in rxe_rcv_mcast_pkt() because it is more
> > blatant there or because I haven't been able to explain how it works
> > well enough.
>
> Usually in the netstack land the shutdown of the device flushes all
> this parallel work out so all the dataplane can happily ignore all
> these details.
>
> I'm not so clear on all these details and how they apply to rxe of
> course. You'd have to look at the full lifecycle of this skb and show
> that the kfree_skb happens only before any unregistration finishes.
>
> Most likely there are other bugs if the unregistration can pass while
> the skb is still out there.
>
> But, I'm not clear on how any of this works in rxe, this is just a
> general remark on how things should ideally work.

+1, I have same understanding and expect SKB to be flushed and new SKB
are prevented from entering ib_device if it is going under destroy.

Thanks

>
> Jason
