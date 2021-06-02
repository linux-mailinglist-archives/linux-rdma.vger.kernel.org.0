Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F0539805C
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jun 2021 06:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhFBEe4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Jun 2021 00:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229571AbhFBEez (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Jun 2021 00:34:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44EF660FDB;
        Wed,  2 Jun 2021 04:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622608393;
        bh=9a9dDkujkT1nzgYKXZW5zFQGI0FPKBB4qk+ZfH6F86o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tFBGYLvUfw50mplmr5oFMwLkSPN5R9zirH56Png4LMAS6EeNMlRHHsGvV5Y+GoIy6
         FGg9ghyd7wZ6i/GvpJAyOa1NyrHb6+xKSZhAyXkIsNNWY8P7pdhoJ5hEYX0IrKw6Ye
         b+tpbrSCwWYDrNQDC1l+aTOd1h3WQkOCVl8urXvhyRAEByYbrvueAKx16HZz0W01qU
         nzkxi4WO5RghcI3W1terBwOSKUWcAfHyg5q4c0INm+i+xuYZW4ZXOs5ttR8TjqqZF6
         JaFsPPKNuskmp0BlDFaBK+BReaFps9xmYDjahdr6t8Ag5oTeaETXhZ+28mcJpXQgTw
         oK5VLTCjSe4Tw==
Date:   Wed, 2 Jun 2021 07:33:09 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Message-ID: <YLcKBb3/Oir2Bdm5@unreal>
References: <CH0PR01MB71533DE9DBEEAEC7C250F8F8F2509@CH0PR01MB7153.prod.exchangelabs.com>
 <20210514150237.GJ1002214@nvidia.com>
 <YKTDPm6j29jziSxT@unreal>
 <0b3cc247-b67b-6151-2a32-e4682ff9af22@cornelisnetworks.com>
 <20210519182941.GQ1002214@nvidia.com>
 <1ceb34ec-eafb-697e-672c-17f9febb2e82@cornelisnetworks.com>
 <20210519202623.GU1002214@nvidia.com>
 <983802a6-0fa2-e181-832e-13a2d5f0fa82@cornelisnetworks.com>
 <20210525131358.GU1002214@nvidia.com>
 <4e4df8bd-4e3a-fe35-041d-ed3ed95be1cb@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e4df8bd-4e3a-fe35-041d-ed3ed95be1cb@cornelisnetworks.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 25, 2021 at 10:10:47AM -0400, Dennis Dalessandro wrote:
> On 5/25/21 9:13 AM, Jason Gunthorpe wrote:
> > On Thu, May 20, 2021 at 06:02:09PM -0400, Dennis Dalessandro wrote:

<...>

> We are already mid 5.13 cycle. So the earliest this could be queued up to go
> in is 5.14. Can this wait one more cycle? If we can't get it tested/proven
> to make a difference mid 5.14, we will drop the objection and Leon's patch
> can go ahead in for 5.15. Fair compromise?

I sent this patch as early as I could to make sure that it won't
jeopardize the restrack QP flow fixes. Delaying one more cycle means
that QP conversion will be delayed too which is needed to close the race
between netlink query QP call and simultaneous ibv_destroy_qp() call.

Thanks

> 
> -Denny
> 
> 
> 
> 
