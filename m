Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0664C76F102
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Aug 2023 19:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjHCR6v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Aug 2023 13:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbjHCR6u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Aug 2023 13:58:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5099930E9
        for <linux-rdma@vger.kernel.org>; Thu,  3 Aug 2023 10:58:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE21261E4E
        for <linux-rdma@vger.kernel.org>; Thu,  3 Aug 2023 17:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD31C433C7;
        Thu,  3 Aug 2023 17:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691085527;
        bh=Lf1c6O0JBMWJkiGMPoPzhBXA3bncbz9VVS1SIKOl2T4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PMWPlIitp1vCXgHz83R7m7WenUarh4IOAqCxv8BhV9+u1CFJGG5ZiAQv9RHKLBVHs
         FhNqpeSQBqurLyyYkJ6wfYoPWWZHVk9csH4MQUCshWoJlmRBFuWxrupEfV4015sa7T
         eBlr40MZ19xlzoMdj7a3bk7sVkxKEhYO1DaAnqFbkmLFWJdNDNFZWnkoqj7Jk4Q9a7
         1VehAqEd34JgFeLV5MlFeZBWIqErE04QQTmkfBW0GaFQqpYxpZpX/QKGd0Os/z11Tt
         aFGcEiR0HzzuBZZZTc16IdpYgfX3pVqNBmNJdwASPz1WaIwjHjqlaQTmABWBxcIJ/h
         x0MzOXP0G+Ebg==
Date:   Thu, 3 Aug 2023 20:58:42 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com,
        Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH for-next v2] IB/core: Add more speed parsing in
 ib_get_width_and_speed()
Message-ID: <20230803175842.GF53714@unreal>
References: <1690966823-8159-1-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690966823-8159-1-git-send-email-selvin.xavier@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 02, 2023 at 02:00:23AM -0700, Selvin Xavier wrote:
> From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 
> When the Ethernet driver does not provide the number of lanes
> in the __ethtool_get_link_ksettings() response, the function
> ib_get_width_and_speed() does not take consideration of 50G,
> 100G and 200G speeds while calculating the IB width and speed.
> Update the width and speed for the above netdev speeds.
> 
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
> v1 - v2:
>     - Rebased the patch based on the latest changes in ib_get_width_and_speed
>     - removed the switch case and use the existing else if check
> ---
>  drivers/infiniband/core/verbs.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index 25367bd..41ff559 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -1899,9 +1899,18 @@ static void ib_get_width_and_speed(u32 netdev_speed, u32 lanes,
>  		} else if (netdev_speed <= SPEED_40000) {
>  			*width = IB_WIDTH_4X;
>  			*speed = IB_SPEED_FDR10;
> -		} else {
> +		} else if (netdev_speed <= SPEED_50000) {
> +			*width = IB_WIDTH_2X;
> +			*speed = IB_SPEED_EDR;
> +		} else if (netdev_speed <= SPEED_100000) {
>  			*width = IB_WIDTH_4X;
>  			*speed = IB_SPEED_EDR;
> +		} else if (netdev_speed <= SPEED_200000) {
> +			*width = IB_WIDTH_4X;
> +			*speed = IB_SPEED_HDR;


SPEED_50000, SPEED_100000 and SPEED_200000 depends on
ClassPortInfo:CapabilityMask2.is* values.

For example, SPEED_50000 can b IB_WIDTH_2X/IB_SPEED_EDR and IB_WIDTH_1X/IB_SPEED_HDR.

Thanks

> +		} else {
> +			*width = IB_WIDTH_4X;
> +			*speed = IB_SPEED_NDR;
>  		}
>  
>  		return;
> -- 
> 2.5.5
> 


