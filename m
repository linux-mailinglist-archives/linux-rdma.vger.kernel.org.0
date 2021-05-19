Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C56388682
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 07:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbhESF26 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 01:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229598AbhESF25 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 01:28:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1312D601FA;
        Wed, 19 May 2021 05:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621402057;
        bh=R2CqO90CmXrJc4sOmOG/G284wQWK7uB3qAUY9i++Aes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GcoQKDoXyy94pFNGuxECmvqjM9h89YNOxOEblwZTVrdDqJcoLjfTF9eb5dxKC0Bah
         I+b5/RoNg0P9nI44IOq8S7Dzf0o+NZ0bqBJbwYZ9MxlpqRv+rr3GkEw2P6xmvx5gLR
         I65DmeMsq0mqhhO0CBL3iONU0jDbvbDIkq97ld73BR0kOk5gVo//TXV+58n55rzg7l
         nKjuQ0LV3m7+O9q4Gv4E1ICQ5I8hey/UZp0gQh6mn0ZVF4OHzoN+8+u2JcMvagHbXI
         kn/liM35P05AOrZlfEPwskB845Liqdhc6g558vTMhpBx8pPpsRUsbIqNJCttRJUKA3
         OyYLWNK+L42xg==
Date:   Wed, 19 May 2021 08:27:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-rc v1] RDMA/core: Sanitize WQ state received from
 the userspace
Message-ID: <YKShxoNM9Az8GQ0q@unreal>
References: <0433d8013ed3a2ffdd145244651a5edb2afbd75b.1621342527.git.leonro@nvidia.com>
 <b40b9bac4f3e4a628bee17b5b5acc61a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b40b9bac4f3e4a628bee17b5b5acc61a@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 18, 2021 at 10:07:38PM +0000, Saleem, Shiraz wrote:
> > Subject: [PATCH rdma-rc v1] RDMA/core: Sanitize WQ state received from the
> > userspace
> > 
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > The mlx4 and mlx5 implemented differently the WQ input checks.
> > Instead of duplicating mlx4 logic in the mlx5, let's prepare the input in the central
> > place.
> 
> Maybe some more verbiage about what the bug was in mlx5 that prompted this patch would
> be good since this an -rc fix.

It can go to -next too, the bug is that we didn't check for validity of
state input in mlx5. It is not real bug because our FW checked that, but
still worth to fix.

I'll add this.

Thanks

> 
> Shiraz
