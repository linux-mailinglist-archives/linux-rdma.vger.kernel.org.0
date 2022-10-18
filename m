Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6E76026B5
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 10:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiJRIYy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 04:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiJRIYw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 04:24:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D9D33A1C
        for <linux-rdma@vger.kernel.org>; Tue, 18 Oct 2022 01:24:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11DE6614A5
        for <linux-rdma@vger.kernel.org>; Tue, 18 Oct 2022 08:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBD7C433C1;
        Tue, 18 Oct 2022 08:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666081487;
        bh=j88ROZ+AdCcExlUIBZcP/O7s6LGc3yF5OwsybPIRgv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cbbJ1VsAllfjQQT01kwWaOzzFWaQVetM4hdmp9a7yUt2ciprEd1XED+Q6/IB8/emH
         oSRrLfPpT1LHY0rI8snGEbabaXDzEi3L/SsW2pDI5hjcU3jVyl6psDg4jRSUJmdo7l
         5Yc9eMYrsyoKS1jcJPZlyPIUIcENnQALJaJdkj2efKlLtCKJyCrMpVWIh55EUfX6vW
         6B6Cr76Jf5RxM6drPrxH/yqyLCvoe5hp7TIJJAsjcp+NMk/k+b8mYjsAF9HWTuPdfW
         Mu5WYxNVxOiU/ItqRXbbPsRcPsoZi2g1eARzFOl2+E/qnQotGexqY99T4YBcLssjmr
         CFfCS63XRvPaA==
Date:   Tue, 18 Oct 2022 11:24:43 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <yanjun.zhu@intel.com>, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev
Subject: Re: [PATCH 1/1] RDMA/mlx5: Make mlx5 device work with
 ib_device_get_by_netdev
Message-ID: <Y05iy+/0BUvbwp5z@unreal>
References: <20221016061925.1831180-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221016061925.1831180-1-yanjun.zhu@intel.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 16, 2022 at 02:19:25AM -0400, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Before mlx5 ib device is registered, the function ib_device_set_netdev
> is not called to map the mlx5 ib device with the related net device.
> 
> As such, when the function ib_device_get_by_netdev is called to get ib
> device, NULL is returned.
> 
> Other ib devices, such as irdma, rxe and so on, the function
> ib_device_get_by_netdev can get ib device from the related net device.

Ohh, you opened Pandora box, everything around it looks half-backed.

mlx4 and mlx5 don't call to ib_device_set_netdev(), because they have
.get_netdev() callback. This callback is not an easy task to eliminate
and many internal attempts failed to eliminate them.

This caused to very questionable ksmbd_rdma_capable_netdev()
implementation where ksmbd first checked internal ib_dev callback
and tried to use ib_device_get_by_netdev(). And to smc_ib, which
didn't even bother to use ib_device_get_by_netdev().

> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index 883d7c60143e..6899c3f73509 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -168,6 +168,7 @@ static int mlx5_netdev_event(struct notifier_block *this,
>  	u32 port_num = roce->native_port_num;
>  	struct mlx5_core_dev *mdev;
>  	struct mlx5_ib_dev *ibdev;
> +	int ret = 0;
>  
>  	ibdev = roce->dev;
>  	mdev = mlx5_ib_get_native_port_mdev(ibdev, port_num, NULL);
> @@ -183,6 +184,14 @@ static int mlx5_netdev_event(struct notifier_block *this,

This is part of the problem, as you are setting netdev for IB
representors, and not for simple RoCE flow. There is more cumbersome
multiport flow which needs special logic too.

Thanks

>  		if (ndev->dev.parent == mdev->device)
>  			roce->netdev = ndev;
>  		write_unlock(&roce->netdev_lock);
> +		if (ndev->dev.parent == mdev->device) {
> +			ret = ib_device_set_netdev(&ibdev->ib_dev, ndev, port_num);
> +			if (ret) {
> +				pr_warn("func: %s, error: %d\n", __func__, ret);
> +				goto done;
> +			}
> +		}
> +
>  		break;
>  
>  	case NETDEV_UNREGISTER:
> @@ -191,6 +200,15 @@ static int mlx5_netdev_event(struct notifier_block *this,
>  		if (roce->netdev == ndev)
>  			roce->netdev = NULL;
>  		write_unlock(&roce->netdev_lock);
> +
> +		if (roce->netdev == ndev) {
> +			ret = ib_device_set_netdev(&ibdev->ib_dev, NULL, port_num);
> +			if (ret) {
> +				pr_warn("func: %s, error: %d\n", __func__, ret);
> +				goto done;
> +			}
> +		}
> +
>  		break;
>  
>  	case NETDEV_CHANGE:
> -- 
> 2.27.0
> 
