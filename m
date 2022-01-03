Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2358C4836CE
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jan 2022 19:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbiACS0a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 13:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbiACS03 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jan 2022 13:26:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C508EC061761;
        Mon,  3 Jan 2022 10:26:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61773611BD;
        Mon,  3 Jan 2022 18:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A72C36AED;
        Mon,  3 Jan 2022 18:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641234388;
        bh=0Gi7JyTqVC5ueKzP3+v5rbz7t64PrkTzQNHCXiBqSWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hFDvAoHfVnEmTuOKozlcDZ2JvkFu75g3t/W7IodZoiY2WhnBGVdAlCaRHDWT53VtQ
         eEpql9UTDEX7/SSRg8CygP4NLUE0D3zPtbaWwxCkO7eO7dvrmQJvGU8+QebD5qKvzU
         dyT0e7s4p80madBOYG9MB2Clx+5mMeLF9pM+RkV1LUJKbfY5sQUelN6ZL//AU09aH9
         65wUgvfECpvfCVQWEg44jVFcuO684AMGreDo0mwf7V6AnI7bIxAFaGVIcn48EEQErB
         +V3vu9WTKPYJPbUwu5bwF2sOHjNJpsEwpvomw4AIO/x6yml3DBXmJ7Nba6Vava+Aj2
         QhX9r0+IK02hQ==
Date:   Mon, 3 Jan 2022 20:26:24 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Tony Lu <tonylu@linux.alibaba.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Alaa Hleihel <alaa@nvidia.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix dereg mr flow for kernel MRs
Message-ID: <YdM/0EUd3S4obWWa@unreal>
References: <f298db4ec5fdf7a2d1d166ca2f66020fd9397e5c.1640079962.git.leonro@nvidia.com>
 <YcKSzszT/zw2ECjh@TonyMac-Alibaba>
 <YdLHDzmNXlqSMj/A@unreal>
 <0d897f0a-6671-bb78-21d5-e475d1db29b9@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d897f0a-6671-bb78-21d5-e475d1db29b9@leemhuis.info>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 03, 2022 at 02:15:59PM +0100, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker speaking.
> 
> On 03.01.22 10:51, Leon Romanovsky wrote:
> > On Wed, Dec 22, 2021 at 10:51:58AM +0800, Tony Lu wrote:
> >> On Tue, Dec 21, 2021 at 11:46:41AM +0200, Leon Romanovsky wrote:
> >>> From: Maor Gottlieb <maorg@nvidia.com>
> >>>
> >>> The cited commit moved umem into the union, hence
> >>> umem could be accessed only for user MRs. Add udata check
> >>> before access umem in the dereg flow.
> >>>
> >>> Fixes: f0ae4afe3d35 ("RDMA/mlx5: Fix releasing unallocated memory in dereg MR flow")
> >>> Tested-by: Chuck Lever <chuck.lever@oracle.com>
> >>> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> >>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >>> ---
> >>>  drivers/infiniband/hw/mlx5/mlx5_ib.h | 2 +-
> >>>  drivers/infiniband/hw/mlx5/mr.c      | 4 ++--
> >>>  drivers/infiniband/hw/mlx5/odp.c     | 4 ++--
> >>>  3 files changed, 5 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> >>
> >> This patch was tested and works for me in our environment for SMC. It
> >> wouldn't panic when release link and call ib_dereg_mr.
> >>
> >> Tested-by: Tony Lu <tonylu@linux.alibaba.com>
> > 
> > Thanks, unfortunately, this patch is incomplete.
> 
> Could you be a bit more verbose and give a status update? It's hard to
> follow from the outside. But according to the "Fixes: f0ae4afe3d35"
> above this was supposed to fix a regression introduced in v5.16-rc5 that
> was also reported here:
> https://lore.kernel.org/linux-rdma/9974ea8c-f1cb-aeb4-cf1b-19d37536894a@linux.alibaba.com/

The problematic commit f0ae4afe3d35 ("RDMA/mlx5: Fix releasing unallocated memory in dereg MR flow")
should be reverted https://lore.kernel.org/all/20211222101312.1358616-1-maorg@nvidia.com
and rewritten from the beginning.

There are three possible ways to rewrite that f0ae4afe3d35 commit, while
the nutshell of the problem is: "DM MR is user created verb object that
is missing very important property (umem) which is needed to distinguish
between kernel and user created objects."

The proposals are:
1. Return back to v1, which had dummy umem, so so DM memory regions will
behave as regular user created verbs object.
2. Add extra flag to is_user/is_kernel for mlx5 mr struct and update all
paths to rely on that flag.
3. Create separate dereg MR function that will treat DM differently.

We are waiting for Jason to return from vacation and express his
preference as he didn't like my preferred option #1.

Thanks

> 
> Commit f0ae4afe3d35 in fact was also backported to v5.15.y and might
> cause trouble there as well.
> 
> Should it maybe simply be reverted (and reapplied with all fixes later)
> in mainline (5.16 will likely be released in 6 days!) and v5.15.y?
> 
> Ciao, Thorsten (wearing his 'Linux kernel regression tracker' hat)
> 
> P.S.: As a Linux kernel regression tracker I'm getting a lot of reports
> on my table. I can only look briefly into most of them. Unfortunately
> therefore I sometimes will get things wrong or miss something important.
> I hope that's not the case here; if you think it is, don't hesitate to
> tell me about it in a public reply, that's in everyone's interest.
> 
> BTW, I have no personal interest in this issue, which is tracked using
> regzbot, my Linux kernel regression tracking bot
> (https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
> this mail to get things rolling again and hence don't need to be CC on
> all further activities wrt to this regression.
> 
