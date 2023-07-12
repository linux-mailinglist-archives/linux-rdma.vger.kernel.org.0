Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE95575086D
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jul 2023 14:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjGLMfi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jul 2023 08:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjGLMfh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jul 2023 08:35:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F110E134;
        Wed, 12 Jul 2023 05:35:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 898A7617BF;
        Wed, 12 Jul 2023 12:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711C2C433C8;
        Wed, 12 Jul 2023 12:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689165335;
        bh=d8QIF670JoMIsJ3YtjyA9SBVY70ZEITagSCcTDlRavo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pcM+qXT1zp/5bqLMQe5tR6SoryDajAbc031PMAs5udQR7QgRWtigyItmQSXwDGanG
         4H8IuQ8/qUb+lgj6BPUMg7/7tqEtdmdUnc6vdibYxDDjj/5zpeXWfXaBmnNDIj/UYr
         c/ska1N6U2Pjij9VofVt4YA3o6TjvRnZlNTw4J+6O0y0lwWnasDUSwpwuF1UlVUdJK
         ev/GhL34uGxUgPwV2O+ptDmU4RlKoqAqJH96McAFS08NFlbjsRi+NUFRXs74+57N2P
         PuJIUcdhTviDmPO8hQiCyeA8/cmm25AxjRMOt8PUDPPAdCsma9mG0RcBOfArpNkE7Z
         rVZUjgrz9FHdg==
Date:   Wed, 12 Jul 2023 15:35:30 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 for-next] RDMA/core: Get IB width and speed from netdev
Message-ID: <20230712123530.GA41919@unreal>
References: <20230707105634.1921046-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707105634.1921046-1-huangjunxian6@hisilicon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 07, 2023 at 06:56:34PM +0800, Junxian Huang wrote:
> From: Haoyue Xu <xuhaoyue1@hisilicon.com>
> 
> Previously, there was no way to query the number of lanes for a network
> card, so the same netdev_speed would result in a fixed pair of width and
> speed. As network card specifications become more diverse, such fixed
> mode is no longer suitable, so a method is needed to obtain the correct
> width and speed based on the number of lanes.
> 
> This patch retrieves netdev lanes and speed from net_device and
> translates them to IB width and speed. Also, add a generic function
> to translating netdev speed to IB speed.
> 
> Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
> Signed-off-by: Luoyouming <luoyouming@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/core/verbs.c | 17 +++++++++++++++--
>  include/rdma/ib_verbs.h         | 26 ++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index b99b3cc283b6..55a3ac9d01e2 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -1880,6 +1880,13 @@ int ib_modify_qp_with_udata(struct ib_qp *ib_qp, struct ib_qp_attr *attr,
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
> @@ -1902,10 +1909,16 @@ int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
>  
>  	if (!rc && lksettings.base.speed != (u32)SPEED_UNKNOWN) {
>  		netdev_speed = lksettings.base.speed;
> +		if (lksettings.lanes) {
> +			ib_get_width_and_speed(netdev_speed, lksettings.lanes,
> +					       speed, width);

Please move this function to be after "if {} else {}" section and combine
with *width/*speed calculations at the bottom of ib_get_eth_speed()
function.

> +			return 0;
> +		}
>  	} else {
>  		netdev_speed = SPEED_1000;
> -		pr_warn("%s speed is unknown, defaulting to %u\n", netdev->name,
> -			netdev_speed);
> +		if (rc)

No need to remove this if ().

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

<...>

> +static inline int ib_eth_to_ib_speed(u32 speed)
> +{

These two functions shouldn't be part in global include file.

Please embed them into ib_get_width_and_speed().

Thanks
