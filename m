Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47151CFBCB
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 19:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgELRQi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 13:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbgELRQi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 13:16:38 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0302205ED;
        Tue, 12 May 2020 17:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589303797;
        bh=SS0M/SlQqI+Y1bhUmaexpW7pa3Ec+haCWgJf5iZwi1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eQIosHg8e+SSpPlhGw+hqEE5an5/PH5ashdftLASo18cPY36oXXStblWE+SQ5ioVO
         OZWHSoeGHQDnbzP2BR6Wrcct2NrYpyJelc0ulTGQznH+qk2FF0Rou7Hb+byDuCfk8y
         Pqxz3mZgBHfjMy4wabST+xRha4Qn9l93lo3pUsv0=
Date:   Tue, 12 May 2020 20:16:33 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Israel Rukshin <israelr@mellanox.com>
Cc:     sagi@grimberg.me, jgg@mellanox.com, linux-rdma@vger.kernel.org,
        dledford@redhat.com, maxg@mellanox.com, sergeygo@mellanox.com
Subject: Re: [PATCH] IB/iser: Remove support for FMR memory registration
Message-ID: <20200512171633.GO4814@unreal>
References: <1589299739-16570-1-git-send-email-israelr@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589299739-16570-1-git-send-email-israelr@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 12, 2020 at 07:08:59PM +0300, Israel Rukshin wrote:
> FMR is not supported on most recent RDMA devices (that use fast memory
> registration mechanism). Also, FMR was recently removed from NFS/RDMA
> ULP.
>
> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> ---
>  drivers/infiniband/ulp/iser/iscsi_iser.h     |  79 +----------
>  drivers/infiniband/ulp/iser/iser_initiator.c |  19 ++-
>  drivers/infiniband/ulp/iser/iser_memory.c    | 188 ++-------------------------
>  drivers/infiniband/ulp/iser/iser_verbs.c     | 126 +++---------------
>  4 files changed, 40 insertions(+), 372 deletions(-)

Can we do an extra step and remove FMR from srp too?

Thanks
