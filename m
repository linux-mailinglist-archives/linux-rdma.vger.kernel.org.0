Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48286DBF10
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Apr 2023 09:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjDIHcf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Apr 2023 03:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDIHce (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Apr 2023 03:32:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A217259DA
        for <linux-rdma@vger.kernel.org>; Sun,  9 Apr 2023 00:32:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3989E60BA1
        for <linux-rdma@vger.kernel.org>; Sun,  9 Apr 2023 07:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1750CC433EF;
        Sun,  9 Apr 2023 07:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681025552;
        bh=Jn/Fd8XHP//YJXyqmJfd9Wr1SYxUVhELVy3+xQ/l10I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uCnwFMf7nj4ZP2Ltmoro9k8zjcVccnRsYt24AiqqZS//QOt/mJ1sXo+nppc/NRpsj
         Sz5yvsbMJp+boDiPMRLSIrzKTb15GKn/s+No4vku9BeAZpQl/9csRr9NkOtYkEQ5jA
         adypfC0Rnam6wR9IIO/KUv/wagfBigOyhEvTVNOF9wnU1xgRAYqvdZf44c9ElHoIa2
         tsTPHJyxfGnp36UqwNjyv+GFA3Mpg2tScPoVEENITJIgVvYfJRqEz/Jk/7XYfLKzGM
         crrDf0nrEY9dh9veXxc7WOrZmfcCwqB7CAY/hKiD0qszft8DY0xFIUgj3+qAAZ6+U9
         O0YWFibcK3jJg==
Date:   Sun, 9 Apr 2023 10:32:28 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     ynachum@amazon.com
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, sleybo@amazon.com,
        matua@amazon.com, mrgolin@amazon.com,
        Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH] RDMA/efa: Add rdma write capability to device caps
Message-ID: <20230409073228.GA14869@unreal>
References: <20230404154313.35194-1-ynachum@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404154313.35194-1-ynachum@amazon.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 04, 2023 at 03:43:13PM +0000, ynachum@amazon.com wrote:
> From: Yonatan Nachum <ynachum@amazon.com>
> 
> Add rdma write capability that is propagated from the device to
> rdma-core.
> Enable MR creation with remote write permissions according to this
> device capability.
> 
> Reviewed-by: Firas Jahjah <firasj@amazon.com>
> Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> ---
>  .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 12 ++++--
>  drivers/infiniband/hw/efa/efa_io_defs.h       | 42 +++++++++++++------
>  drivers/infiniband/hw/efa/efa_verbs.c         |  6 ++-
>  include/uapi/rdma/efa-abi.h                   |  1 +
>  4 files changed, 44 insertions(+), 17 deletions(-)

<...>

>  #endif /* _EFA_IO_H_ */
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> index c27c36418f7f..a394011a598c 100644
> --- a/drivers/infiniband/hw/efa/efa_verbs.c
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -253,6 +253,9 @@ int efa_query_device(struct ib_device *ibdev,
>  		if (EFA_DEV_CAP(dev, DATA_POLLING_128))
>  			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_DATA_POLLING_128;
>  
> +		if (EFA_DEV_CAP(dev, RDMA_WRITE))
> +			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_RDMA_WRITE;
> +
>  		if (dev->neqs)
>  			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_CQ_NOTIFICATIONS;
>  
> @@ -1571,7 +1574,8 @@ static struct efa_mr *efa_alloc_mr(struct ib_pd *ibpd, int access_flags,
>  
>  	supp_access_flags =
>  		IB_ACCESS_LOCAL_WRITE |
> -		(EFA_DEV_CAP(dev, RDMA_READ) ? IB_ACCESS_REMOTE_READ : 0);
> +		(EFA_DEV_CAP(dev, RDMA_READ) ? IB_ACCESS_REMOTE_READ : 0) |
> +		(EFA_DEV_CAP(dev, RDMA_WRITE) ? IB_ACCESS_REMOTE_WRITE : 0);
>  
>  	access_flags &= ~IB_ACCESS_OPTIONAL;
>  	if (access_flags & ~supp_access_flags) {
> diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
> index 74406b4817ce..d94c32f28804 100644
> --- a/include/uapi/rdma/efa-abi.h
> +++ b/include/uapi/rdma/efa-abi.h
> @@ -121,6 +121,7 @@ enum {
>  	EFA_QUERY_DEVICE_CAPS_CQ_NOTIFICATIONS = 1 << 2,
>  	EFA_QUERY_DEVICE_CAPS_CQ_WITH_SGID     = 1 << 3,
>  	EFA_QUERY_DEVICE_CAPS_DATA_POLLING_128 = 1 << 4,
> +	EFA_QUERY_DEVICE_CAPS_RDMA_WRITE = 1 << 5,

Why do you need special device capability while all rdma-core users
set IBV_ACCESS_REMOTE_WRITE anyway without relying on anything from
providers?

Thanks

>  };
>  
>  struct efa_ibv_ex_query_device_resp {
> -- 
> 2.39.2
> 
