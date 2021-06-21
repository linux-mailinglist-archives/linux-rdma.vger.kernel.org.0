Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572543AE6BD
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 12:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhFUKJh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 06:09:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhFUKJh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 06:09:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C23A3611BD;
        Mon, 21 Jun 2021 10:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624270043;
        bh=STOdkfkXiJl4gz/GqCyugZd8VSEX0TH3rFOhbFvvry4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZkF1v+8wQAbj01cthcDv7qNyQHO371M5FJBODWkviDJH9sjmojhLe/yPE1SUI4wQC
         JKoeBhDlgybShTIs8JxXfbAxFmjiIRToZy2EKM0FPhfG9sFQKKn/rgrBVp5e2YlAAl
         5t4NLyv86+YNzVJJsWRDm6yjxHh3r8TrO6MPDZ/nwxG07Qq9xN2mJmxJeZcPlI4Dfa
         VSiDcJuX5ZFLa9oQwaquFCbNMQGJ74XZt4LcjiOyudHs/kCjVok7KW0p0zBYzaqGgg
         s5xcITYvYMMrpmVr96eMuHIomQWGIaet/OmiP3cWyooZiiBWXnBKq6UZPSJ6LbsW4E
         s+aCplLm7pk7w==
Date:   Mon, 21 Jun 2021 13:07:20 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/cma: Remove unnecessary INIT->INIT
 transition
Message-ID: <YNBk2HcMKlSTM2tn@unreal>
References: <1623944783-9093-1-git-send-email-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1623944783-9093-1-git-send-email-haakon.bugge@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 17, 2021 at 05:46:23PM +0200, Håkon Bugge wrote:
> In rdma_create_qp(), a connected QP will be transitioned to the INIT
> state.
> 
> Afterwards, the QP will be transitioned to the RTR state by the
> cma_modify_qp_rtr() function. But this function starts by performing
> an ib_modify_qp() to the INIT state again, before another
> ib_modify_qp() is performed to transition the QP to the RTR state.
> 
> Hence, there is no need to transition the QP to the INIT state in
> rdma_create_qp().
> 
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/core/cma.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
