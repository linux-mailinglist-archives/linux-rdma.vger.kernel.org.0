Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37097435E4C
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 11:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhJUJxZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 05:53:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230269AbhJUJxZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Oct 2021 05:53:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBAA86103D;
        Thu, 21 Oct 2021 09:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634809869;
        bh=jWs+LEDKSXOWvWFnMvWzeB5NegznLl8/HUTf7GFsITI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N00lUzUJqe21y5bXxu3/+HVZc+0yeeIVoPkOzV0URS22eZHUT7vi2CU67OozR96+K
         rTjGrHCRmfLl8d2rEko7QI3tSYaulcSLCsdnJ33apIt1RqAtzk65lv/KSOhCbnyuSu
         Uj8TFSfwtobtb34E3UEt7yIncVoynbZ370bWYOyMrEr0JX5xoaiP1QbSjZY5wpuB42
         qYI/Q5eniYlLYbdi405Bxs9erkqtRhvhMzQSTIS6i7tvyMzBTQ+gckEP7ZJSD2R53+
         gBL7Q1pFAUXOK7CQkgXJ/Y8zlt2/RVzr4np/vnpNH6/ispYfDZDwRPfbSCCZbTq93i
         b8bdZCSjQmeCA==
Date:   Thu, 21 Oct 2021 12:51:05 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        jgg@ziepe.ca, yuehaibing@huawei.com, manjunath.b.patil@oracle.com,
        mbloch@nvidia.com, jinpu.wang@ionos.com,
        mike.marciniszyn@cornelisnetworks.com, liweihang@huawei.com
Subject: Re: [PATCH rdma-next 1/3] ipoib: use dev_addr_mod()
Message-ID: <YXE4CRMsn4qDpXGu@unreal>
References: <20211019182604.1441387-1-kuba@kernel.org>
 <20211019182604.1441387-2-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019182604.1441387-2-kuba@kernel.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 19, 2021 at 11:26:02AM -0700, Jakub Kicinski wrote:
> Commit 406f42fa0d3c ("net-next: When a bond have a massive amount
> of VLANs...") introduced a rbtree for faster Ethernet address look
> up. To maintain netdev->dev_addr in this tree we need to make all
> the writes to it got through appropriate helpers.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: dledford@redhat.com
> CC: jgg@ziepe.ca
> CC: yuehaibing@huawei.com
> CC: manjunath.b.patil@oracle.com
> CC: leon@kernel.org
> CC: mbloch@nvidia.com
> CC: jinpu.wang@ionos.com
> CC: mike.marciniszyn@cornelisnetworks.com
> CC: liweihang@huawei.com
> CC: linux-rdma@vger.kernel.org
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_cm.c   |  4 +++-
>  drivers/infiniband/ulp/ipoib/ipoib_ib.c   |  9 ++++-----
>  drivers/infiniband/ulp/ipoib/ipoib_main.c | 17 +++++++++--------
>  3 files changed, 16 insertions(+), 14 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
