Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7872575F4D9
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jul 2023 13:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjGXLTv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jul 2023 07:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjGXLTq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jul 2023 07:19:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE29FE5C;
        Mon, 24 Jul 2023 04:19:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61C4D610A5;
        Mon, 24 Jul 2023 11:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AD2C433C7;
        Mon, 24 Jul 2023 11:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690197581;
        bh=GzUaJfQLXiclBu5jTUskyxqPGnBUzb/0S3OOXRP7gV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=itt39rI+Jj9TmkMjiihJU2dMhEyjo86bbK+X8Z5iWL6eihJ4Vw+duMVFBoDso9XkW
         JE0nS9mjs5Ez0Kdu+csF6hknbLQrI4BdszAAHZXX4y2GJYbmSvN6ErjStXQ0Z4O213
         zfin6Z8cRyJa9X0Q0/lHzXG8ddYGL5MQR7AN3GniRyXsl1vWJqhoLJfdb3uHM13r1L
         AEhHx18DRA+Blvba3GlrlDluqYsN2WNlWN3YaEduCm2Zt/6zFt9IGfsHmc8H6BL77H
         lmxYvlvnvDQTa83qzGuAbVdPh4PK1XCOlU0MkwehCItz6BWhJXjrsxd4vlKHsMj9cb
         wJlEOFUs3ZSdQ==
Date:   Mon, 24 Jul 2023 14:19:38 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 for-next] RDMA/core: Get IB width and speed from netdev
Message-ID: <20230724111938.GB9776@unreal>
References: <20230721092052.2090449-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721092052.2090449-1-huangjunxian6@hisilicon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 21, 2023 at 05:20:52PM +0800, Junxian Huang wrote:
> From: Haoyue Xu <xuhaoyue1@hisilicon.com>
> 
> Previously, there was no way to query the number of lanes for a network
> card, so the same netdev_speed would result in a fixed pair of width and
> speed. As network card specifications become more diverse, such fixed
> mode is no longer suitable, so a method is needed to obtain the correct
> width and speed based on the number of lanes.
> 
> This patch retrieves netdev lanes and speed from net_device and
> translates them to IB width and speed.
> 
> Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
> Signed-off-by: Luoyouming <luoyouming@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/core/verbs.c | 100 +++++++++++++++++++++++++-------
>  1 file changed, 79 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index b99b3cc283b6..25367bd6dd97 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -1880,6 +1880,80 @@ int ib_modify_qp_with_udata(struct ib_qp *ib_qp, struct ib_qp_attr *attr,
>  }
>  EXPORT_SYMBOL(ib_modify_qp_with_udata);
>  
> +static void ib_get_width_and_speed(u32 netdev_speed, u32 lanes,
> +				   u16 *speed, u8 *width)

<...>

> +	switch (netdev_speed / lanes) {
> +	case SPEED_2500:
> +		*speed = IB_SPEED_SDR;
> +		break;
> +	case SPEED_5000:
> +		*speed = IB_SPEED_DDR;
> +		break;
> +	case SPEED_10000:
> +		*speed = IB_SPEED_FDR10;
> +		break;
> +	case SPEED_14000:
> +		*speed = IB_SPEED_FDR;
> +		break;
> +	case SPEED_25000:
> +		*speed = IB_SPEED_EDR;
> +		break;
> +	case SPEED_50000:
> +		*speed = IB_SPEED_HDR;
> +		break;
> +	case SPEED_100000:
> +		*speed = IB_SPEED_NDR;
> +		break;
> +	default:
> +		*speed = IB_SPEED_SDR;
> +	}

How did you come to these translation values?

Thanks
