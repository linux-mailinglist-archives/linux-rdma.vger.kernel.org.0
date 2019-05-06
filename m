Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9B0F14BA4
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 16:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfEFORD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 10:17:03 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44163 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEFORC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 10:17:02 -0400
Received: by mail-qt1-f195.google.com with SMTP id f24so4416266qtk.11
        for <linux-rdma@vger.kernel.org>; Mon, 06 May 2019 07:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KCqxekTcJSqupNeS7Zru0c6aS0xUSMfCNbyWRnYL3yE=;
        b=ayijKFSm5ea1Wd7pVw46BFEsIjRAd5PTO5IzrmxeXiz9nuBmLaLx8oflBjq08wiVeO
         IMK0pwd6wPjNXEB1VabfYMBgS2kDZAuFsv8f0EnNak5rNSBlcf612qPmeUnoOQ6QyXRH
         Ojm0qa1Q234WM6r06SAtUOB+KbtnSXuvvl/Eynfg3spgL5Xy34XPDc4ZurvSVw2tULD3
         agKkjK33Rs/2eaZmdBJ58GYFfHc6DLXbv/hJqXB7tQrxLgaTDJoqRwTrLOjaykm8nq3Y
         kKkMXr3pZ1e9aGXFMUXnxE4Qb0ZH+WQvGrrdf0jyrvQNbjOQC8S0lANb+rI3bwlrOt4c
         mY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KCqxekTcJSqupNeS7Zru0c6aS0xUSMfCNbyWRnYL3yE=;
        b=nlVKMYjK7i99Yfe7GSfdq4f6i1wy26FZuGIRIOMzrTgZGxyAzy5p1KtoHMk/3Uj7nR
         6bxRhF60wCqNm+OEHqYtTqlG58Dkngxc9It5d2bktQ0BxVA+77FEDaxRpcGKaCrqPzDD
         tU4XsnULxIr697YA3NEjbtCX6GY55mJ2mVVzy9BnXVr0gsFugrhkeY1RlQkT51cm5elW
         nk0suxPotSNGftK4JZ2JKPHMJGHBQ4xqjmDsYU6N2LixmNSJwipcGQQ+QpBo/ISTV8MQ
         DwKtFfZ9DPelt0K+VoFW2zO2lqe7uvGvcvdbOvxhZpaG/79V3YdUxWsnlxNE9gFZIAFT
         hSCQ==
X-Gm-Message-State: APjAAAWuiytjYLGlqGVZF17m/KZbNGRtQDbPjOTTVoag+iQtny3dLgYq
        bz4NwzNdoBWY0nZj3kTglBXlxQ==
X-Google-Smtp-Source: APXvYqzQMeCYaFievZLutopvNcTW7NZgOzNYW09hVb9PPQF99Ygt5WEuxzaayfeDSNPBPJkqvypbVQ==
X-Received: by 2002:ac8:3fe3:: with SMTP id v32mr20397788qtk.307.1557152221784;
        Mon, 06 May 2019 07:17:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id o44sm8708422qto.36.2019.05.06.07.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 07:17:00 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hNeQN-0003TC-UT; Mon, 06 May 2019 11:16:59 -0300
Date:   Mon, 6 May 2019 11:16:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3 rdma-next 6/6] RDMA/verbs: Extend DMA block iterator
 support for mixed block sizes
Message-ID: <20190506141659.GA6201@ziepe.ca>
References: <20190506135337.11324-1-shiraz.saleem@intel.com>
 <20190506135337.11324-7-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506135337.11324-7-shiraz.saleem@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 06, 2019 at 08:53:37AM -0500, Shiraz Saleem wrote:
> Extend the DMA block iterator for HW that can support mixed
> block sizes. A bitmap of HW supported page sizes are provided
> to block iterator which returns contiguous aligned memory blocks
> within a HW supported page size.
> 
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
>  drivers/infiniband/core/verbs.c | 38 ++++++++++++++++++++++++++++++++++++--
>  include/rdma/ib_verbs.h         | 18 ++++++++++++++----
>  2 files changed, 50 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index 3806038..fa9725d 100644
> +++ b/drivers/infiniband/core/verbs.c
> @@ -2712,16 +2712,47 @@ int rdma_init_netdev(struct ib_device *device, u8 port_num,
>  }
>  EXPORT_SYMBOL(rdma_init_netdev);
>  
> +static unsigned int rdma_find_mixed_pg_bit(struct ib_block_iter *biter)
> +{
> +	if (biter->__sg == biter->__sgl_head) {
> +		return rdma_find_pg_bit(sg_dma_address(biter->__sg) +
> +					sg_dma_len(biter->__sg),
> +					biter->pgsz_bitmap);
> +	} else if (sg_is_last(biter->__sg)) {
> +		return rdma_find_pg_bit(sg_dma_address(biter->__sg),
> +					biter->pgsz_bitmap);
> +	} else {
> +		unsigned int remaining =
> +			sg_dma_address(biter->__sg) + sg_dma_len(biter->__sg) -
> +			biter->__dma_addr;
> +		unsigned int pg_bit = rdma_find_pg_bit(biter->__dma_addr,
> +						       biter->pgsz_bitmap);
> +		if (remaining < BIT_ULL(biter->__pg_bit))
> +			pg_bit = rdma_find_pg_bit(remaining,
> +						  biter->pgsz_bitmap);

I think this needs to follow the same basic algorithm as the single
bit case, considering the IOVA/etc.

But there is no user, so let us just drop this patch until a user
appears..

Jason
