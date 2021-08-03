Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AA33DF437
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Aug 2021 19:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbhHCR5K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 13:57:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:49112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233343AbhHCR5J (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Aug 2021 13:57:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C458F60EE9;
        Tue,  3 Aug 2021 17:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628013418;
        bh=otxBD+W8br1qAlPGK0SncEhzdtcUQKKIHlh6UHZyLfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lhw38K4tL11M/lh4pwWznrPoaZd2gBJdCWZq9ndQWobV4sb09fz6I3kYXuIchqyZy
         diCyclbOg3yYofB1q/6ZlIM9BC/q+7mYElSt6Ng3sjO3iSOb+lpV4IMVr8gBeiq/5q
         47Ex0edUSEDPk3cMB1ZCUo1HvmzYWiSuWOOCSrocDc5kXiTs7xc1Csnk6t2+DmYIP6
         9b0EX2XABw7yhvb1gtz5oi5z3h750VqIZRV3CApJwyD3zAiRVWHYp2Yl/h6FN6ovVm
         jtyx6Y2+QQwMmfjrkYQY0tlai3m584goy/5ItWVjBGjXIzrbYJNR2i7pbCc6K2nALF
         zW37x9AVJDY/Q==
Date:   Tue, 3 Aug 2021 20:56:54 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: return the EFAULT per ibv_advise_mr(3)
Message-ID: <YQmDZpbCy3uTS5jv@unreal>
References: <20210801092050.6322-1-lizhijian@cn.fujitsu.com>
 <20210803162507.GA2892108@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803162507.GA2892108@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 03, 2021 at 01:25:07PM -0300, Jason Gunthorpe wrote:
> On Sun, Aug 01, 2021 at 05:20:50PM +0800, Li Zhijian wrote:
> > ibv_advise_mr(3) says:
> > EFAULT In one of the following: o When the range requested is out of the  MR  bounds,
> >        or  when  parts of it are not part of the process address space. o One of the
> >        lkeys provided in the scatter gather list is invalid or with wrong write access
> > 
> > Actually get_prefetchable_mr() will return NULL if it see above conditions
> 
> No, get_prefetchable_mr() returns NULL if the mkey is invalid

And what is this?
  1701 static struct mlx5_ib_mr *                         
  1702 get_prefetchable_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
  1703                     u32 lkey)

...

  1721         /* prefetch with write-access must be supported by the MR */
  1722         if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE &&
  1723             !mr->umem->writable) {
  1724                 mr = NULL;
  1725                 goto end;
  1726         }


> 
> The above is talking about the address, which is checked inside
> pagefault_mr() and does return EFAULT for all the cases I can see?
> 
> Jason
