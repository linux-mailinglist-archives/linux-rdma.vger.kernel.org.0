Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5093775D1
	for <lists+linux-rdma@lfdr.de>; Sun,  9 May 2021 09:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhEIHs6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 May 2021 03:48:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229593AbhEIHs5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 9 May 2021 03:48:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EA0D61401;
        Sun,  9 May 2021 07:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620546474;
        bh=pEntzvQQqAeiJ0ASVCaCMwEGkRCtcrPXlraXW3LTZQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A2W22qme2jH+dvh37FkMhw9YCo5llCDX+sGFy+fbob5ovP7emVkXznp+iPgSdLsiu
         Jn99H1iskm76lHPVPwfcyMBmGrhBuOG7/BAoiRUZ8m2Kjhq6lJaIUPaSqI1cy1W13N
         FHFmFUBsYnFSzp64gqhyewS+rdLd0Yq4EgsmzPpUDF2yhGWnplAll+ZLOddGpJvZgI
         bh08X2A0t3/aDQcL2FkLrB+PscXlRAK21elC/aLRiDnWpx8FtTw8XvBzpWvR8PWnXq
         zq2+ojxC0MbJRO+2SbesoDe0UdGR0/8h7O8nxbx/tQ0NBjyBhYfieWwDHZnsLmZZHj
         H77eGUVm3efCw==
Date:   Sun, 9 May 2021 10:47:51 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2] IB/core: Only update PKEY and GID caches on
 respective events
Message-ID: <YJeTp0W1S81E5fcZ@unreal>
References: <1620289904-27687-1-git-send-email-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1620289904-27687-1-git-send-email-haakon.bugge@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 06, 2021 at 10:31:44AM +0200, Håkon Bugge wrote:
> Both the PKEY and GID tables in an HCA can hold in the order of
> hundreds entries. Reading them are expensive. Partly because the API
> for retrieving them only returns a single entry at a time. Further, on
> certain implementations, e.g., CX-3, the VFs are paravirtualized in
> this respect and have to rely on the PF driver to perform the
> read. This again demands VF to PF communication.
> 
> IB Core's cache is refreshed on all events. Hence, filter the refresh
> of the PKEY and GID caches based on the event received being
> IB_EVENT_PKEY_CHANGE and IB_EVENT_GID_CHANGE respectively.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> 
> ---
> 
> v1 -> v2:
>    * Changed signature of ib_cache_update() as per Leon's suggestion
>    * Added Fixes tag as per Zhu Yanjun' suggestion
> ---
>  drivers/infiniband/core/cache.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
