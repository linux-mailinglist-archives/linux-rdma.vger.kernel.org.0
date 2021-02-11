Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B75318678
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Feb 2021 09:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhBKIsW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Feb 2021 03:48:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:37386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229648AbhBKIsH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Feb 2021 03:48:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D4C664E66;
        Thu, 11 Feb 2021 08:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613033332;
        bh=lswKxjQZhc6gdOgPjNtf2RkPeuQL4kOEbFeEzfYh/lM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YNHUXMi8OBIh7gC3zYa4N3JruhrsbcL08Lg28FpnrbUvdsH2CDp1bNcplLLqMFly2
         31glZNXPukcR6lXK1rHXhEBMT1spYNUHYIgVuGHB3GBUlRNURuYIDXjwBOxurk0VfD
         n18K2eDeGAGIEpkA+9ETbgst/JqQnnxB2pQ5V5SMZAOXCh7M3kxndssrygheolzhG3
         It4cziflZQlMaB96nJ8GrUsugggoHPsORzI/JtXwu07GLwDuac1AQWtjKqOR5r8onw
         z6a9ZTb1z9R5Emo1CiEdmXgNU6t+jhM2FFhVA+qQG0W4kqMsssLilXrU+oYvBQaVGi
         m88ZAyWPgOSUQ==
Date:   Thu, 11 Feb 2021 10:48:49 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: Re: [PATCH for-next 4/4] RDMA/rtrs-srv-sysfs: fix missing put_device
Message-ID: <20210211084849.GC1275163@unreal>
References: <20210211065526.7510-1-jinpu.wang@cloud.ionos.com>
 <20210211065526.7510-5-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211065526.7510-5-jinpu.wang@cloud.ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 11, 2021 at 07:55:26AM +0100, Jack Wang wrote:
> From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
>
> put_device() decreases the ref-count and then the device will
> be cleaned-up, while at is also add missing put_device in
> rtrs_srv_create_once_sysfs_root_folders
>
> This patch solves a kmemleak error as below:
>
> unreferenced object 0xffff88809a7a0710 (size 8):
>   comm "kworker/4:1H", pid 113, jiffies 4295833049 (age 6212.380s)
>   hex dump (first 8 bytes):
>     62 6c 61 00 6b 6b 6b a5                          bla.kkk.
>   backtrace:
>     [<0000000054413611>] kstrdup+0x2e/0x60
>     [<0000000078e3120a>] kobject_set_name_vargs+0x2f/0xb0
>     [<00000000f1a17a6b>] dev_set_name+0xab/0xe0
>     [<00000000d5502e32>] rtrs_srv_create_sess_files+0x2fb/0x314 [rtrs_server]
>     [<00000000ed11a1ef>] rtrs_srv_info_req_done+0x631/0x800 [rtrs_server]
>     [<000000008fc5aa8f>] __ib_process_cq+0x94/0x100 [ib_core]
>     [<00000000a9599cb4>] ib_cq_poll_work+0x32/0xc0 [ib_core]
>     [<00000000cfc376be>] process_one_work+0x4bc/0x980
>     [<0000000016e5c96a>] worker_thread+0x78/0x5c0
>     [<00000000c20b8be0>] kthread+0x191/0x1e0
>     [<000000006c9c0003>] ret_from_fork+0x3a/0x50
>
> Fixes: baa5b28b7a47 ("RDMA/rtrs-srv: Replace device_register with device_initialize and device_add")
> Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
