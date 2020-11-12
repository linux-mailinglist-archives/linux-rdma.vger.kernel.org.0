Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009942B0DD0
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 20:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgKLTXw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 14:23:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:34214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgKLTXv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Nov 2020 14:23:51 -0500
Received: from localhost (searspoint.nvidia.com [216.228.112.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 715E220B80;
        Thu, 12 Nov 2020 19:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605209031;
        bh=Hqp53UTTmzz0fbeX44hyworgdQJtKiLS9/Q31LjWQCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dogfo8GOXkx4WdR8g5EThqtgghdU/sFmdnjOGc+toO+Z/6uFOITpcUMEmf5WOBpC2
         otWoHCk2t+4KQD/2ptHlPn0x3/F/i0bSOUS0BuaHyrp1qFW90S0kH4w5aOdIYnN9q6
         lLOXPByHitUfDcCfFhjdqKRu6BKC16rrgoG80zWw=
Date:   Thu, 12 Nov 2020 21:23:46 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v4 0/5] Track memory allocation with restrack
 DB help (Part I)
Message-ID: <20201112192346.GB3483@unreal>
References: <20201104144008.3808124-1-leon@kernel.org>
 <20201112185951.GA981682@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112185951.GA981682@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 12, 2020 at 02:59:51PM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 04, 2020 at 04:40:03PM +0200, Leon Romanovsky wrote:
>
> > Leon Romanovsky (5):
> >   RDMA/core: Allow drivers to disable restrack DB
>
> This stuff is never used

It is in use in mlx4/mlx5 QPs.
https://lore.kernel.org/linux-rdma/20201104144008.3808124-2-leon@kernel.org/
https://lore.kernel.org/linux-rdma/20201104144008.3808124-2-leon@kernel.org/#Z30drivers:infiniband:hw:mlx4:qp.c
https://lore.kernel.org/linux-rdma/20201104144008.3808124-2-leon@kernel.org/#Z30drivers:infiniband:hw:mlx5:qp.c

>
> >   RDMA/cma: Be strict with attaching to CMA device
>
> This adds a return 0 which is pointless..

It will be used after I will resubmit patch "RDMA/restrack: Add error
handling while adding restrack object" and I'm working on it right now.

Can you please add this patch anyway and save me need to do constant
rebases?

Thanks

>
> >   RDMA/counter: Combine allocation and bind logic
> >   RDMA/restrack: Store all special QPs in restrack DB
> >   RDMA/cma: Add missing error handling of listen_id
>
> Took these three to for-next
>
> Thanks,
> Jason
