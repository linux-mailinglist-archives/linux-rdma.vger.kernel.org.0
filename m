Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D912645463E
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Nov 2021 13:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbhKQMUC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Nov 2021 07:20:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:38774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233484AbhKQMUC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Nov 2021 07:20:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE89061BE2;
        Wed, 17 Nov 2021 12:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637151423;
        bh=Tc+DJXUVo3Rj7d2HQx4B+GVQxMKRE6QMYoLiyzq2VR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c0qYik7SaFVc8uVWm/f5v3vR7h9u44tBfkDABPPI5eiV8YvZaFGhX5TD6oHx/01cx
         ZVYufCoV87N1DEU60Dc9X+DDM6+x2lOe7cMWZ27HRPTN2XPjoYM2sd/iK6a8UAAudY
         Gd9O/xy7mKneraPFAJ80k4PjbT7JtF+Joytz56a2QTNF0snkGRiTlYcrfhO3FVIBjL
         Q1UNxsumy7UfKbB7gjJ44tPc8jehOFjPS69xJpgA6EmTF1wt1xUIvc0j/8g71mUi8h
         PXJ10BTrrPuM1au1kN6Ue4/M/nGuKBB4nPs5Eug2N3gGqUd8LAwrwKLlneA7+pLu68
         R+7XwpLrkiPtQ==
Date:   Wed, 17 Nov 2021 14:16:59 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, haris.iqbal@ionos.com,
        yishaih@nvidia.com
Subject: Re: [PATCH] RDMA/mlx4: Do not fail the registration on port stats
Message-ID: <YZTyuxOCScNeeaTl@unreal>
References: <20211115101519.27210-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115101519.27210-1-jinpu.wang@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 15, 2021 at 11:15:19AM +0100, Jack Wang wrote:
> If the FW doesn't support MLX4_DEV_CAP_FLAG2_DIAG_PER_PORT,
> mlx4 driver will fail the ib_setup_port_attrs, which is called
> from ib_register_device/enable_device_and_get, in the end leads
> to device not detected[1][2]
> 
> To fix it, add a new mlx4_ib_hw_stats_ops1, w/o alloc_hw_port_stats
> if FW does not support MLX4_DEV_CAP_FLAG2_DIAG_PER_PORT.
> 
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=2014094
> [2] https://lore.kernel.org/linux-rdma/CAMGffEn2wvEnmzc0xe=xYiCLqpphiHDBxCxqAELrBofbUAMQxw@mail.gmail.com/T/#t
> 
> Fixes: 4b5f4d3fb408 ("RDMA: Split the alloc_hw_stats() ops to port and device variants")
> 
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/hw/mlx4/main.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

Just a nitpick, no need for a blank line between Fixes line and SOB.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
