Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56A03DD0C3
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 08:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhHBGrl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 02:47:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231410AbhHBGrk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Aug 2021 02:47:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDCDC61050;
        Mon,  2 Aug 2021 06:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627886851;
        bh=tjOcz9TZwEilKhNtlP5WqvCRmPhGzI0gl+EwjDc+HBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ng8FQr2g9SjFNOQwHzCK6iMvebQZbGLkYUSig262N6LJuTyz4WrUusDAqQTZ1igVI
         ySbEUBjlKlTmv7MzBkLkG1WGZklpi9A4jrPl4SPpRE1MO/nSZPani/QdsCav8CDFiE
         +vo91xH7FUgSE57VV45a2TysBsX5WPoCe+y3VhO8V9XPk2OEbF0xHSt4xzZgsmBFX6
         wDLMd9EsQCBXwb03XZjOtQR6bLJc+LYsPnz7vWr6IjKSZXSlGlOUssNufLOG0SuFZo
         gIPx0xqLJqZ5BEEuE3SVQbcbBHFsrp0+pGrrYjBAWLKhWCqYzPDd71HEs34lycM6cn
         B8XQsCO2gay9g==
Date:   Mon, 2 Aug 2021 09:47:28 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, haris.iqbal@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: Re: [PATCH for-next 02/10] RDMA/rtrs-srv: Prevent sysfs error with
 path name "ctl"
Message-ID: <YQeVAMWiZZ1sRqDP@unreal>
References: <20210730131832.118865-1-jinpu.wang@ionos.com>
 <20210730131832.118865-3-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730131832.118865-3-jinpu.wang@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 30, 2021 at 03:18:24PM +0200, Jack Wang wrote:
> From: Gioh Kim <gi-oh.kim@ionos.com>
> 
> If the client tries to create a path with name "ctl",
> the server tries to creates /sys/devices/virtual/rtrs-server/ctl/.
> Then server generated below error because there is already ctl directory
> which manages some setup of the server.
> 
> sysfs: cannot create duplicate filename '/devices/virtual/rtrs-server/ctl'
> Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
> Call Trace:
> dump_stack+0x50/0x63
> sysfs_warn_dup.cold+0x17/0x24
> sysfs_create_dir_ns+0xb6/0xd0
> kobject_add_internal+0xa6/0x2a0
> kobject_add+0x7e/0xb0
> ? _cond_resched+0x15/0x30
> device_add+0x121/0x640
> rtrs_srv_create_sess_files+0x18f/0x1f0 [rtrs_server]
> ? __alloc_pages_nodemask+0x16c/0x2b0
> ? kmalloc_order+0x7c/0x90
> ? kmalloc_order_trace+0x1d/0xa0
> ? rtrs_iu_alloc+0x17e/0x1bf [rtrs_core]
> rtrs_srv_info_req_done+0x417/0x5b0 [rtrs_server]
> ? __switch_to_asm+0x40/0x70
> __ib_process_cq+0x76/0xd0 [ib_core]
> ib_cq_poll_work+0x26/0x80 [ib_core]
> process_one_work+0x1df/0x3a0
> worker_thread+0x4a/0x3c0
> kthread+0xfb/0x130
> ? process_one_work+0x3a0/0x3a0
> ? kthread_park+0x90/0x90
> ret_from_fork+0x1f/0x40
> kobject_add_internal failed for ctl with -EEXIST, don't try to register things with the same name in the same directory.
> rtrs_server L178: device_add(): -17
> 
> This patch checks the path name and disconnect on server to prevent
> the kernel error.
> 
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index cd9a4ccf4c28..b814a6052cf1 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -758,6 +758,14 @@ static bool exist_sessname(struct rtrs_srv_ctx *ctx,
>  	struct rtrs_srv_sess *sess;
>  	bool found = false;
>  
> +	/*
> +	 * Session name "ct" is not allowed because
> +	 * /sys/devices/virtual/rtrs-server/ctl already exists
> +	 * for setup management.
> +	 */
> +	if (!strcmp(sessname, "ctl"))
> +		return true;

Why does it have special treatment?
And what will happen if user supplies "." or ".."?
Does rtrs receive this session name from the other side in the network?

Thanks
