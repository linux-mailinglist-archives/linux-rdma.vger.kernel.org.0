Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3E0399D3D
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 10:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhFCI5D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 04:57:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbhFCI5C (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Jun 2021 04:57:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C37361361;
        Thu,  3 Jun 2021 08:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622710518;
        bh=q2XjFZmNcMW2w+e43UnJ5OjBO2o0qLeFrIUmL+5meL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jEhrOQAA8auqlHcs+S+G2PXftiMGMcChJX6OVNX9jgsSZgNnCEQtWCwTphCkwCM6k
         DcOticObnDc01iIewJHDGayFspl5kpqvxdlUDYMkxi9j/Hhailt3HDcIaE83d2p0+k
         P4KO8ydi4XVFznX92i+22qEpQeUsbilSFwIrrcGHuJ0XBf5R0osShuSys/rlI5BZJA
         XnYVoUFc5kXLWIstdUOJVwDLEuYuuVs2iBzLNy0wdR5AD/5puG3TyFATn9bDx8FG1Y
         5GiH7HCb+64UnqrjXT8LL/1sLk5a8f+/GJqwLj1ifqIVi52ndyKgadfCNUHyAQWmqJ
         5OfWy0EDfs+Og==
Date:   Thu, 3 Jun 2021 11:55:15 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Anand Khoje <anand.a.khoje@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com
Subject: Re: [PATCH v2 2/3] IB/core: Shuffle locks in ib_port_data to save
 memory
Message-ID: <YLiY8xeOEHseDW+8@unreal>
References: <20210603065024.1051-1-anand.a.khoje@oracle.com>
 <20210603065024.1051-3-anand.a.khoje@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603065024.1051-3-anand.a.khoje@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 03, 2021 at 12:20:23PM +0530, Anand Khoje wrote:
> pahole shows two 4-byte holes in struct ib_port_data after
> pkey_list_lock and netdev_lock respectively.
> 
> Shuffling the netdev_lock to be after pkey_list_lock, this 
> shaves off eight bytes from the struct.
> 
> Suggested-by: Haakon Bugge <haakon.bugge@oracle.com>
> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
> ---
>  include/rdma/ib_verbs.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
