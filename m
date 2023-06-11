Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C927272B351
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Jun 2023 19:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjFKRqM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Jun 2023 13:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjFKRqM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Jun 2023 13:46:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F43F187;
        Sun, 11 Jun 2023 10:46:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92299612CC;
        Sun, 11 Jun 2023 17:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B0EC433D2;
        Sun, 11 Jun 2023 17:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686505569;
        bh=x78h9GsPVElFg5sfHPm11xprthIcGwa7s9zwxCB3qnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uN2xQmxpvpyMLY9Wuw+TH0AeYi0d4FPCYrXOBe9Oay/7kuQafzkD9IBalYgMVaOSc
         Qg4bj/dIe+SnEfTCXAsYQoU+8vuiWNYnz1t2jjnIf7vCOy4AZVyL+pnvgClOBcoWgo
         LLg+nvhWFw6JToMBuDr/ahgZHL8yWbGiyI9sRuRwJLkuoiqi+zWXvD1fTr+ZgQL17R
         S5MCaH4j8PkXorNIXDttWZNQzkIdTFpA/XJrrRkKpNKVbMD1uBW/8P1UVDF4fnbjlF
         K1cAPoEMRxRD8Wmt+SFZi94ya8Dbl55gIjcKCFMWf//GO/bF9y5rZydpfhdOC7onUi
         JzEMBSOOFvPng==
Date:   Sun, 11 Jun 2023 20:46:05 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 for-next] RDMA/core: Get IB width and speed from netdev
Message-ID: <20230611174605.GG12152@unreal>
References: <20230603063833.541682-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230603063833.541682-1-huangjunxian6@hisilicon.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 03, 2023 at 02:38:33PM +0800, Junxian Huang wrote:
> From: Haoyue Xu <xuhaoyue1@hisilicon.com>
> 
> Previously, there was no way to query the number of lanes for a network
> card, so the same netdev_speed would result in a fixed pair of width and
> speed. As network card specifications become more diverse, such fixed
> mode is no longer suitable, so a method is needed to obtain the correct
> width and speed based on the number of lanes.

I'm sorry but I didn't understand the problem statement. Can you please
provide an example of configuration that will give different results 
before this patch and after?

> 
> This patch retrieves netdev lanes and speed from net_device and
> translates them to IB width and speed. Also, add a generic function
> to translating netdev speed to IB speed.
> 
> Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
> Signed-off-by: Luoyouming <luoyouming@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/core/verbs.c | 19 +++++++++++++++++--
>  include/rdma/ib_verbs.h         | 26 ++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index b99b3cc283b6..35f1b670600a 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -1880,11 +1880,19 @@ int ib_modify_qp_with_udata(struct ib_qp *ib_qp, struct ib_qp_attr *attr,
>  }
>  EXPORT_SYMBOL(ib_modify_qp_with_udata);
>  
> +static void ib_get_width_and_speed(u32 netdev_speed, u32 lanes,
> +				   u16 *speed, u8 *width)
> +{
> +	*width = ib_int_to_ib_width(lanes);
> +	*speed = ib_eth_to_ib_speed(netdev_speed / lanes);
> +}
> +
>  int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
>  {
>  	int rc;
>  	u32 netdev_speed;
>  	struct net_device *netdev;
> +	bool cap_link_lanes_supported;
>  	struct ethtool_link_ksettings lksettings;
>  
>  	if (rdma_port_get_link_layer(dev, port_num) != IB_LINK_LAYER_ETHERNET)
> @@ -1896,16 +1904,23 @@ int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
>  
>  	rtnl_lock();
>  	rc = __ethtool_get_link_ksettings(netdev, &lksettings);
> +	cap_link_lanes_supported = netdev->ethtool_ops->cap_link_lanes_supported;
>  	rtnl_unlock();
>  
>  	dev_put(netdev);
>  
>  	if (!rc && lksettings.base.speed != (u32)SPEED_UNKNOWN) {
>  		netdev_speed = lksettings.base.speed;
> +		if (cap_link_lanes_supported && lksettings.lanes) {

According to the documentation cap_link_lanes_supported defines if
number of lanes can be supplied by user and I would expect from
__ethtool_get_link_ksettings() to get right numbers after it was
changed.

Thanks

> +			ib_get_width_and_speed(netdev_speed, lksettings.lanes,
> +					       speed, width);
> +			return 0;
> +		}
>  	} else {
>  		netdev_speed = SPEED_1000;
> -		pr_warn("%s speed is unknown, defaulting to %u\n", netdev->name,
> -			netdev_speed);
> +		if (rc)
> +			pr_warn("%s speed is unknown, defaulting to %u\n",
> +				netdev->name, netdev_speed);
>  	}
>  
>  	if (netdev_speed <= SPEED_1000) {
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 1e7774ac808f..7dc926ec7fee 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -552,6 +552,18 @@ static inline int ib_width_enum_to_int(enum ib_port_width width)
>  	}
>  }
>  
> +static inline int ib_int_to_ib_width(u32 lanes)
> +{
> +	switch (lanes) {
> +	case 1: return IB_WIDTH_1X;
> +	case 2: return IB_WIDTH_2X;
> +	case 4: return IB_WIDTH_4X;
> +	case 8: return IB_WIDTH_8X;
> +	case 12: return IB_WIDTH_12X;
> +	default: return IB_WIDTH_1X;
> +	}
> +}
> +
>  enum ib_port_speed {
>  	IB_SPEED_SDR	= 1,
>  	IB_SPEED_DDR	= 2,
> @@ -563,6 +575,20 @@ enum ib_port_speed {
>  	IB_SPEED_NDR	= 128,
>  };
>  
> +static inline int ib_eth_to_ib_speed(u32 speed)
> +{
> +	switch (speed) {
> +	case SPEED_2500: return IB_SPEED_SDR;
> +	case SPEED_5000: return IB_SPEED_DDR;
> +	case SPEED_10000: return IB_SPEED_FDR10;
> +	case SPEED_14000: return IB_SPEED_FDR;
> +	case SPEED_25000: return IB_SPEED_EDR;
> +	case SPEED_50000: return IB_SPEED_HDR;
> +	case SPEED_100000: return IB_SPEED_NDR;
> +	default: return IB_SPEED_SDR;
> +	}
> +}
> +
>  enum ib_stat_flag {
>  	IB_STAT_FLAG_OPTIONAL = 1 << 0,
>  };
> -- 
> 2.30.0
> 
