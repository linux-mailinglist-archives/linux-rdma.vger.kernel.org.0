Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CA63B0414
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 14:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhFVMTY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 08:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231409AbhFVMTX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 08:19:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8453C61374;
        Tue, 22 Jun 2021 12:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624364228;
        bh=jc0n7n1yoQiR1dze48G5a/DXri6P2J2DoBIwplqNRoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pBDUIU63XL1Pa2whDLSowt6R4tMsp3m8a7nKHJlVduk/wqY66iYcPjhu3lA87P7Zl
         FPuudN1tIASi6CebQpNyN7nTVtIhRKwAVmJazrLRiqfeTPPPc0c/+MpknOl+evFrj9
         4LLBNwG0dXUl66NsOAiM4xYA0fZLPDVFpQrkPynyB9lgxHYEtC80NMiOdk1HyU27Zv
         sIBx4xXa0kwl1N6QbmGXKS+8KNaFMPAt8eVATESHZpA60j8/rFl8OL8nZ5HuDGMKJZ
         dt56yVYCK0IVwdwgEqTw0ffTUsLu2wCGNHKEDLYH5YTFrtQCUgvjb1u27n06EQaci0
         Q8JBKUJaAyQzg==
Date:   Tue, 22 Jun 2021 15:17:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Hans Ry <hans.westgaard.ry@oracle.com>
Subject: Re: [PATCH for-next] RDMA/cma: Fix incorrect Packet Lifetime
 calculation
Message-ID: <YNHUv48x1WcKPJxA@unreal>
References: <1624281537-5573-1-git-send-email-haakon.bugge@oracle.com>
 <YNGcznXKXn2+izJX@unreal>
 <E0581DD9-4001-48E5-9BF7-24E4D149C089@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E0581DD9-4001-48E5-9BF7-24E4D149C089@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 22, 2021 at 09:32:27AM +0000, Haakon Bugge wrote:
> 
> 
> > On 22 Jun 2021, at 10:18, Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > On Mon, Jun 21, 2021 at 03:18:57PM +0200, Håkon Bugge wrote:
> >> An approximation for the PacketLifeTime is half the local ACK timeout.
> >> The encoding for both timers are logarithmic. The PacketLifeTime
> >> calculation is wrong when local ACK timeout is zero. In that case,
> >> PacketLifeTime is set to the incorrect value 255.
> >> 
> >> Fixed by explicitly testing for timeout being zero.
> >> 
> >> Fixes: e1ee1e62bec4 ("RDMA/cma: Use ACK timeout for RoCE packetLifeTime")
> >> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> >> 
> >> ---
> >> 
> >> 	* Note: This commit must be merged after ("RDMA/cma: Replace
> >>          RMW with atomic bit-ops")
> >> ---
> >> drivers/infiniband/core/cma.c | 8 +++++---
> >> 1 file changed, 5 insertions(+), 3 deletions(-)
> >> 
> > 
> > Thanks,
> > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> 
> Thanks for the review, Leon! I have to rebase on the tip of for-next, since the ("RDMA/cma: Replace RMW with atomic bit-ops") will not have the get_bit() stuff in cma_resolve_iboe_route() anymore. I assume I can retain your r-b after the rebase?

Yes, please.

> 
> 
> Thxs, Håkon
> 
> 
> 
> 
