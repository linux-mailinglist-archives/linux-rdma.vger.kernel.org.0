Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCA4251FF2
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 21:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgHYT1b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 15:27:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgHYT1b (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Aug 2020 15:27:31 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF6722072D;
        Tue, 25 Aug 2020 19:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598383650;
        bh=qj5E9gVeNqZwo1UaXkKAeBCLaXdu7GM/ujbqTkU1D/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wIRXa+uAEhm5RpBSamKhPxY4NYOrwu2aji8PDXqaPQdjPpdVdpkzKt8M/nCz71qgi
         8Ei7TwqE0o0s6j5gb7LJ7D37YfjV6nPYdThFdzGQpx1UZvBe5dbpSIbmwgBLEmeUCy
         A2pq47mrNAL0b8/9/KDRL5kRrUM9RyxGHNcTwtU0=
Date:   Tue, 25 Aug 2020 14:33:27 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     dennis.dalessandro@intel.com, dledford@redhat.com,
        gustavo@embeddedor.com, jgg@ziepe.ca, joe@perches.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        mike.marciniszyn@intel.com, roland@purestorage.com
Subject: Re: [PATCH v2 1/2] IB/qib: remove superfluous fallthrough statements
Message-ID: <20200825193327.GA5504@embeddedor>
References: <64d7e1c9-9c6a-93f3-ce0a-c24b1c236071@gmail.com>
 <20200825171242.448447-1-alex.dewar90@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825171242.448447-1-alex.dewar90@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 25, 2020 at 06:12:42PM +0100, Alex Dewar wrote:
> Commit 36a8f01cd24b ("IB/qib: Add congestion control agent implementation")
> erroneously marked a couple of switch cases as /* FALLTHROUGH */, which
> were later converted to fallthrough statements by commit df561f6688fe
> ("treewide: Use fallthrough pseudo-keyword"). This triggered a Coverity
> warning about unreachable code.
>

It's worth mentioning that this warning is triggered only by compilers
that don't support __attribute__((__fallthrough__)), which has been
supported since GCC 7.1.

> Remove the fallthrough statements.
> 
> Addresses-Coverity: ("Unreachable code")
> Fixes: 36a8f01cd24b ("IB/qib: Add congestion control agent implementation")
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

> ---
> v2: Do refactoring in a separate patch (Gustavo)
> ---

 ^^^
These dashes are not needed.

Thanks
--
Gustavo

>  drivers/infiniband/hw/qib/qib_mad.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/qib/qib_mad.c b/drivers/infiniband/hw/qib/qib_mad.c
> index e7789e724f56..f972e559a8a7 100644
> --- a/drivers/infiniband/hw/qib/qib_mad.c
> +++ b/drivers/infiniband/hw/qib/qib_mad.c
> @@ -2322,7 +2322,6 @@ static int process_cc(struct ib_device *ibdev, int mad_flags,
>  			ret = cc_get_congestion_control_table(ccp, ibdev, port);
>  			goto bail;
>  
> -			fallthrough;
>  		default:
>  			ccp->status |= IB_SMP_UNSUP_METH_ATTR;
>  			ret = reply((struct ib_smp *) ccp);
> @@ -2339,7 +2338,6 @@ static int process_cc(struct ib_device *ibdev, int mad_flags,
>  			ret = cc_set_congestion_control_table(ccp, ibdev, port);
>  			goto bail;
>  
> -			fallthrough;
>  		default:
>  			ccp->status |= IB_SMP_UNSUP_METH_ATTR;
>  			ret = reply((struct ib_smp *) ccp);
> -- 
> 2.28.0
> 
