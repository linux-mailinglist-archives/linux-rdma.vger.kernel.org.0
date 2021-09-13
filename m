Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526DA408679
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 10:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbhIMI2d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 04:28:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234575AbhIMI2c (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Sep 2021 04:28:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BF506101C;
        Mon, 13 Sep 2021 08:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631521637;
        bh=eqrWVyssyPaYL1h0uEUiq3mr0e0gcIZLR2J4CDmYd5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O2M5C8ancPZ3RkWUyhHTdq4b7hpjErQQhJUiplZtShVpMejS+kl4q9lKyvFVwYFEs
         b/y229gWQ6+AtQ2COXgfFepSZ+q2UefURrbEmm6ht0q6hvARxcWej8fUDAre/rSNnu
         5wqgsXXGnv6oIncDC3aFvbm30bc8x1HXEEtrT0zJblzWjM973UNdFvBkjxFLx8lBx7
         IAC51wKizMg2pdXiNbqDM515BOxU/V3fmt/4DDCC6JWmPnlWztCBuCQITBEHmoOO4z
         cx6zY/ynh3IRFrboezV1PiMO3SqPZLlag2AbEILF/wtDjpxx+t1swoF2wlPnOuKgO/
         wMpb5L9OQBShA==
Date:   Mon, 13 Sep 2021 11:27:13 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Nelson Escobar <neescoba@cisco.com>
Subject: Re: [PATCH rdma-rc] RDMA/usnic: Lock VF with mutex instead of
 spinlock
Message-ID: <YT8LYZvhYm/kT7Kb@unreal>
References: <2a0e295786c127e518ebee8bb7cafcb819a625f6.1631520231.git.leonro@nvidia.com>
 <ADF1D118-A29D-4B32-9D25-F3B1768C8924@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ADF1D118-A29D-4B32-9D25-F3B1768C8924@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 13, 2021 at 08:17:00AM +0000, Haakon Bugge wrote:
> 
> 
> > On 13 Sep 2021, at 10:04, Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Usnic VF doesn't need lock in atomic context to create QPs, so it is safe
> > to use mutex instead of spinlock. Such change fixes the following smatch
> > error.
> 
> s/GFP_ATOMIC/GFP_KERNEL/ in find_free_vf_and_create_qp_grp() as well?

Do you mean in usnic_uiom_get_dev_list()?
That GFP_ATOMIC existed before my patch while we are holding usdev_lock mutex.

Anyway, I prefer to touch that driver as less as possible.

The allocations can continue to be with GFP_ATOMIC while we use mutex.
It is bad thing, but not a necessary to fix bug. We just wasting atomic
memory and instruct kernel do not sleep while
doing allocations.

Thanks
