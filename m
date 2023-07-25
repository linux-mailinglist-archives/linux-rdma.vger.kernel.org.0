Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F22760982
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jul 2023 07:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjGYFm3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jul 2023 01:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGYFm2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jul 2023 01:42:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F3C173F;
        Mon, 24 Jul 2023 22:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=HvlB6NlNRyyJ1H78qsw8NHEHOXMo+cT2kyETpzZW4Sw=; b=eAIt7l25AxxLhXBiTj0xRoijEs
        fS2W6QCZbGx2Q0LMUf2ed+ycNPtOCZzk+9p3K41grzTx0n0qgfc/kHb+1GHt81VHuoNrWwIeODvZR
        /ijMkkopdc+mDGGZkgkAXQLc9E+v93leJD2lAsbfsu4DxGAPJ7AM9vqC1EZDYTPCQXDT/LagfoGxd
        smM48MEdPT/MJ47/XiMWXpSVBBDtNctS8RHLSPXE16BjHeKj8hBBeaypUTt6D//7vtGgAPqvz183o
        Q4mEOQrPQG1mtxcRLNe5sO0DMi1Vc/hoy7xQWPnWm8+iTveE3tJo8jjFdfFTz1wnrtihU+750874U
        tY1qr61w==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOAoP-006Jvy-1z;
        Tue, 25 Jul 2023 05:42:21 +0000
Message-ID: <c90e00f9-db2e-d8e4-6608-4e969d9a57d6@infradead.org>
Date:   Mon, 24 Jul 2023 22:42:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] net/mlx4: clean up a type issue
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Tariq Toukan <tariqt@nvidia.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <52d0814a-7287-4160-94b5-ac7939ac61c6@moroto.mountain>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <52d0814a-7287-4160-94b5-ac7939ac61c6@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Dan,

On 7/24/23 22:39, Dan Carpenter wrote:
> These functions returns type bool, not pointers, so return false instead
> of NULL.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

LGTM. Thanks.
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> Not a bug.  Targetting net-next.
> 
>  drivers/net/ethernet/mellanox/mlx4/mcg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/mcg.c b/drivers/net/ethernet/mellanox/mlx4/mcg.c
> index f1716a83a4d3..24d0c7c46878 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/mcg.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/mcg.c
> @@ -294,7 +294,7 @@ static bool check_duplicate_entry(struct mlx4_dev *dev, u8 port,
>  	struct mlx4_promisc_qp *dqp, *tmp_dqp;
>  
>  	if (port < 1 || port > dev->caps.num_ports)
> -		return NULL;
> +		return false;
>  
>  	s_steer = &mlx4_priv(dev)->steer[port - 1];
>  
> @@ -375,7 +375,7 @@ static bool can_remove_steering_entry(struct mlx4_dev *dev, u8 port,
>  	bool ret = false;
>  
>  	if (port < 1 || port > dev->caps.num_ports)
> -		return NULL;
> +		return false;
>  
>  	s_steer = &mlx4_priv(dev)->steer[port - 1];
>  

-- 
~Randy
