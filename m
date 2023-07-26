Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A8B763712
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jul 2023 15:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjGZNHk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jul 2023 09:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjGZNHi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Jul 2023 09:07:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD721FFA
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jul 2023 06:07:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F960619FD
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jul 2023 13:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B17C433C7;
        Wed, 26 Jul 2023 13:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690376851;
        bh=gmrUscnY0HHn9EXb3VVbnB4HeKljsnLNGZ7F7ONf1cY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YQ9ntjSINtjDWy+fqzL9THAYdAFfTQhT45FXWPz+2m+HSpOkxqLgDLQUiAnXi4Yj5
         gikKRk3sWI8CMXyqvcIbwDlleUbOsJXriFfCph9lTWP7ph8tYnRsP8ii0YE0AGIt9k
         iLAnPoJvgdJy0Q1cCGX7kcKWijfoZuWgghAEevOIuCyYVkSWBjgAsNt5FY3s3+yiZU
         DMOg6PYe8anA4arL1a95ERJLn2Jp7wUf+PlPQd+1cUhivjsq+BXHCeR/ks2rojaFYF
         CNPOjWepZzHPxd8PNC9M9LWzMEPD2YY1BYmU0Yp3tmXFcxaKZx2yjATDlkPFJjOw0n
         ui42bUE2uqL6w==
Date:   Wed, 26 Jul 2023 16:07:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com,
        Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH] IB/core: Add more speed parsing in ib_get_eth_speed()
Message-ID: <20230726130726.GW11388@unreal>
References: <1690360493-8428-1-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690360493-8428-1-git-send-email-selvin.xavier@broadcom.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 26, 2023 at 01:34:53AM -0700, Selvin Xavier wrote:
> From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 
> The function ib_get_eth_speed() does not take consideration
> of 50G, 56G, 100G and 200G speeds. Added these speeds parsing.
> We are not considering the lane width now. This can be enhanced
> later.
> 
> Also, refactored the code to use switch case instead of if-else.
> 
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/core/verbs.c | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index b99b3cc..ebd389a 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -1908,22 +1908,44 @@ int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
>  			netdev_speed);
>  	}
>  
> -	if (netdev_speed <= SPEED_1000) {
> +	switch (netdev_speed) {
> +	case SPEED_1000:
>  		*width = IB_WIDTH_1X;
>  		*speed = IB_SPEED_SDR;
> -	} else if (netdev_speed <= SPEED_10000) {
> +		break;
> +	case SPEED_10000:

This conversion is not equal to code before. We have more speeds between
SPEED_1000 and SPEED_10000.

include/uapi/linux/ethtool.h
...
  1889 #define SPEED_1000              1000
  1890 #define SPEED_2500              2500
  1891 #define SPEED_5000              5000
  1892 #define SPEED_10000             10000


Thanks



>  		*width = IB_WIDTH_1X;
>  		*speed = IB_SPEED_FDR10;
> -	} else if (netdev_speed <= SPEED_20000) {
> +		break;
> +	case SPEED_20000:
>  		*width = IB_WIDTH_4X;
>  		*speed = IB_SPEED_DDR;
> -	} else if (netdev_speed <= SPEED_25000) {
> +		break;
> +	case SPEED_25000:
>  		*width = IB_WIDTH_1X;
>  		*speed = IB_SPEED_EDR;
> -	} else if (netdev_speed <= SPEED_40000) {
> +		break;
> +	case SPEED_40000:
>  		*width = IB_WIDTH_4X;
>  		*speed = IB_SPEED_FDR10;
> -	} else {
> +		break;
> +	case SPEED_50000:
> +		*width = IB_WIDTH_2X;
> +		*speed = IB_SPEED_EDR;
> +		break;
> +	case SPEED_56000:
> +		*width = IB_WIDTH_4X;
> +		*speed = IB_SPEED_FDR;
> +		break;
> +	case SPEED_100000:
> +		*width = IB_WIDTH_4X;
> +		*speed = IB_SPEED_EDR;
> +		break;
> +	case SPEED_200000:
> +		*width = IB_WIDTH_4X;
> +		*speed = IB_SPEED_HDR;
> +		break;
> +	default:
>  		*width = IB_WIDTH_4X;
>  		*speed = IB_SPEED_EDR;
>  	}
> -- 
> 2.5.5
> 


