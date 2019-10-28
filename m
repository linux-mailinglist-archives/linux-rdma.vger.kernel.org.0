Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B667E775F
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 18:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbfJ1RKv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 13:10:51 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44601 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730212AbfJ1RKv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 13:10:51 -0400
Received: by mail-qt1-f193.google.com with SMTP id z22so15592968qtq.11
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 10:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gansFGAadh5PdS/EE4lpvE19TBMfVKFwbiuzkB2+Ud0=;
        b=WafEXSz0s/1IYnxstXSYKXJx4co1xXuF1ai2wCqosKeGonB6YkrNKy5TzHFTyVcfr9
         /LLzSfra7/GPqhfHx23iq5hqGYQ6ajpCRE+8hk4ngtajphqLxoWiNcgUpkUe1k9WY2as
         Osxqc/qrLZ+0NTDc/Cj/oGBmWcqGkEByAoryYZJk7x0H3i3wcXNoL9kWG6WeKyQ9TyDa
         6AgisnR6CZdK4e1kGriwVdf5PylKD/cuiGE+EpwYmaHYCNdk4ZHs+cM8qIIuem7xutXb
         ONV2nLYPmA0pTZQCQEa5ZeDBhJv9GgnwBTbdy7RIojejoU3B9ybqpxfyfMIEaNeOUtRb
         q4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gansFGAadh5PdS/EE4lpvE19TBMfVKFwbiuzkB2+Ud0=;
        b=lOtGD2PmOaKQSegZjJuQ/u4m3PlPydjg6yBR7V1Sjaziqiv+EgSHT5hoY5WBOo6knG
         AAY3r7LiV7F8mxD+x8BGuDdfWUVbKqxzK6vu9LD1VF7WHuqGBx2ls6H2BEL9qgS8xT8f
         Y0gUpE975cIYnOKGilHqCma4Ur4mP9TDGhL+4bhuW7+4h7G/rxrRopT5mFtgSSRhzbZQ
         kPpbanyiCBGdd2CXG2+ajIAy83bErw71HoDZoQbGtC/Ejf3MYjqHoFAR9IQXP+D7QNU4
         CqCcgxdbTfitLgC0ZGTr6Kt+s31cCoRIHakPHyDHT0wMVAujQP0mg2gZoKXdporLAMq9
         xLbw==
X-Gm-Message-State: APjAAAW5nkR0AvMYsol1AFrFzzFLaxzSpEU156VaXG5fXtjZl0c76pX2
        e48LJ0mGopDMc+EiihTVYJmm2GqVcKw=
X-Google-Smtp-Source: APXvYqzcwNf5l8R5KO+F/sKcwaVr9YHINVBaIJ6+zb1InMg2jw8PwFjaHbN0fUosjV+wjZtjxUqN1w==
X-Received: by 2002:ac8:23d3:: with SMTP id r19mr3912084qtr.297.1572282650181;
        Mon, 28 Oct 2019 10:10:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id 27sm921950qtu.71.2019.10.28.10.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 10:10:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iP8XZ-0001t2-70; Mon, 28 Oct 2019 14:10:49 -0300
Date:   Mon, 28 Oct 2019 14:10:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH] RDMA/mlx5: Use irq xarray locking for mkey_table
Message-ID: <20191028171049.GA7212@ziepe.ca>
References: <20191024234910.GA9038@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024234910.GA9038@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 24, 2019 at 11:49:13PM +0000, Jason Gunthorpe wrote:
> The mkey_table xarray is touched by the reg_mr_callback() function which
> is called from a hard irq. Thus all other uses of xa_lock must use the
> _irq variants.
> 
>   WARNING: inconsistent lock state
>   5.4.0-rc1 #12 Not tainted
>   --------------------------------
>   inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
>   python3/343 [HC0[0]:SC0[0]:HE1:SE1] takes:
>   ffff888182be1d40 (&(&xa->xa_lock)->rlock#3){?.-.}, at: xa_erase+0x12/0x30
>   {IN-HARDIRQ-W} state was registered at:
>     lock_acquire+0xe1/0x200
>     _raw_spin_lock_irqsave+0x35/0x50
>     reg_mr_callback+0x2dd/0x450 [mlx5_ib]
>     mlx5_cmd_exec_cb_handler+0x2c/0x70 [mlx5_core]
>     mlx5_cmd_comp_handler+0x355/0x840 [mlx5_core]
>    [..]
> 
>    Possible unsafe locking scenario:
> 
>          CPU0
>          ----
>     lock(&(&xa->xa_lock)->rlock#3);
>     <Interrupt>
>       lock(&(&xa->xa_lock)->rlock#3);
> 
>    *** DEADLOCK ***
> 
>   2 locks held by python3/343:
>    #0: ffff88818eb4bd38 (&uverbs_dev->disassociate_srcu){....}, at: ib_uverbs_ioctl+0xe5/0x1e0 [ib_uverbs]
>    #1: ffff888176c76d38 (&file->hw_destroy_rwsem){++++}, at: uobj_destroy+0x2d/0x90 [ib_uverbs]
> 
>   stack backtrace:
>   CPU: 3 PID: 343 Comm: python3 Not tainted 5.4.0-rc1 #12
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
>   Call Trace:
>    dump_stack+0x86/0xca
>    print_usage_bug.cold.50+0x2e5/0x355
>    mark_lock+0x871/0xb50
>    ? match_held_lock+0x20/0x250
>    ? check_usage_forwards+0x240/0x240
>    __lock_acquire+0x7de/0x23a0
>    ? __kasan_check_read+0x11/0x20
>    ? mark_lock+0xae/0xb50
>    ? mark_held_locks+0xb0/0xb0
>    ? find_held_lock+0xca/0xf0
>    lock_acquire+0xe1/0x200
>    ? xa_erase+0x12/0x30
>    _raw_spin_lock+0x2a/0x40
>    ? xa_erase+0x12/0x30
>    xa_erase+0x12/0x30
>    mlx5_ib_dealloc_mw+0x55/0xa0 [mlx5_ib]
>    uverbs_dealloc_mw+0x3c/0x70 [ib_uverbs]
>    uverbs_free_mw+0x1a/0x20 [ib_uverbs]
>    destroy_hw_idr_uobject+0x49/0xa0 [ib_uverbs]
>    [..]
> 
> Fixes: 0417791536ae ("RDMA/mlx5: Add missing synchronize_srcu() for MW cases")
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Acked-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/mr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-rc

Jason
