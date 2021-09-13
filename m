Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817B84089F3
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 13:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239442AbhIMLRi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 07:17:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238383AbhIMLRi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Sep 2021 07:17:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 331EA60FE6;
        Mon, 13 Sep 2021 11:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631531782;
        bh=qDvyzG5B8T87OO6jWx6mYyzzJfXqo41rVzeixXA4jxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RG1Xgv1/z0zk563zxpXWXjzgAP9T41EeA9lG3F2m1XBySI1TJsfWcRfalKk+joEZ8
         H8aDNHRJqMVVurKR0g2MP43iZfbnG6u0rOz+xxYApAlAvqFe+YUhX2DB92DoSx3qo7
         gHZSN7P1D3P5BgRGD4+/uQpc85eazsXOPRTmJW0SNLO0JBLKiz4QNioQhqqd805H5I
         iZO2gqMpC9MiNZNypfgYGtN5IAqNTGqzFI4A5SCxpu0pVGbG0z3KREIvwpEYIyxZoq
         zR+YkaXNgXBZC7jIhdm/Z08hg7EUJ3MnJ/PLwbhzEHUjYV0KgDFIv9PnqHvll+BSsV
         7fyKUL09b8mrA==
Date:   Mon, 13 Sep 2021 14:16:19 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Tao Liu <thomas.liu@ucloud.cn>
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        shayd@nvidia.com, avihaih@nvidia.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.liu@ucloud.com
Subject: Re: [PATCH] RDMA/cma: Fix listener leak in rdma_cma_listen_on_all()
 failure
Message-ID: <YT8zA8GaFgjzwSUK@unreal>
References: <20210913093344.17230-1-thomas.liu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913093344.17230-1-thomas.liu@ucloud.cn>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 13, 2021 at 05:33:44PM +0800, Tao Liu wrote:
> rdma_cma_listen_on_all() just destroy listener which lead to an error,
> but not including those already added in listen_list. Then cm state
> fallbacks to RDMA_CM_ADDR_BOUND.
> 
> When user destroys id, the listeners will not be destroyed, and
> process stucks.
> 
>  task:rping state:D stack:   0 pid:19605 ppid: 47036 flags:0x00000084
>  Call Trace:
>   __schedule+0x29a/0x780
>   ? free_unref_page_commit+0x9b/0x110
>   schedule+0x3c/0xa0
>   schedule_timeout+0x215/0x2b0
>   ? __flush_work+0x19e/0x1e0
>   wait_for_completion+0x8d/0xf0
>   _destroy_id+0x144/0x210 [rdma_cm]
>   ucma_close_id+0x2b/0x40 [rdma_ucm]
>   __destroy_id+0x93/0x2c0 [rdma_ucm]
>   ? __xa_erase+0x4a/0xa0
>   ucma_destroy_id+0x9a/0x120 [rdma_ucm]
>   ucma_write+0xb8/0x130 [rdma_ucm]
>   vfs_write+0xb4/0x250
>   ksys_write+0xb5/0xd0
>   ? syscall_trace_enter.isra.19+0x123/0x190
>   do_syscall_64+0x33/0x40
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Fixes: c80a0c52d85c ("RDMA/cma: Add missing error handling of listen_id")
> Signed-off-by: Tao Liu <thomas.liu@ucloud.cn>
> ---
>  drivers/infiniband/core/cma.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
