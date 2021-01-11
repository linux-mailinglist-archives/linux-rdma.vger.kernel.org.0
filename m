Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA572F0CF8
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Jan 2021 07:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbhAKGmJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Jan 2021 01:42:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbhAKGmI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 Jan 2021 01:42:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B38D222573;
        Mon, 11 Jan 2021 06:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610347288;
        bh=bZAvJzpYwr+i15NCF9KE/xuOvfRt4Sc6Az3w01Sza7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OZVsZcdH/P2HHCoE2WKMRD/efwFCJaL2t9nraK8E/h/za5c+BhxhiA3F9n/W5Qets
         MokN2+rSgShlkYZ2O+6bQ0tjExoSBC70Q2XfT5HeTRxQKvMR3Mlelg1tFfcT58zCEJ
         b9vM5fUMBK3wHMSvVk6nVV/1bMW4oLz1ysd66+B7Z516fy+ylR5plzaCwL/Ogvj96L
         CQNGlncLgc/5njgL3NbyXQwpfgaVTLkFLxuMuCUiCI9jHqwa6cV6BZxQED7g/mBzQ5
         sbd+QqLel86mG7OptEX4WP40z4SPkAMByXl7GddXfoqpwjIZullkxtZtixeTAEcxRN
         LQQ76ob+4nDyQ==
Date:   Mon, 11 Jan 2021 08:41:24 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/umem: Silence build warning on i386
 architecture
Message-ID: <20210111064124.GK31158@unreal>
References: <20210106122047.498453-1-leon@kernel.org>
 <20210108202831.GA1042005@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108202831.GA1042005@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 08, 2021 at 04:28:31PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 06, 2021 at 02:20:47PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> >
> > Sacrifice one page in order to silence compilation failure on i386
> > architecture.
> >
> > drivers/infiniband/core/umem.c:205 __ib_umem_get() warn: impossible
> > 			condition '(npages > (~0)) => (0-u32max > u32max)'
>
> I think I prefer to just leave this warning on 32 bit builds.. 32 bit
> inherently can't have this overflow so yes the condition should be
> impossible
>
> Using >= is just confusing
>
> If you really want to fix it then npages and every place that touches
> it should be made size_t or unsigned long.
>
> This includes __sg_alloc_table_from_pages, which doesn't look so bad
> actually..

npages is used as "unsigned long" in all places: pin_user_pages_fast()
and internally in __sg_alloc_table_from_pages().

I can't say if it is going to be not bad as you said.

However, let's add rewrite of this patch to my backlog.

Thanks

>
> Jason
