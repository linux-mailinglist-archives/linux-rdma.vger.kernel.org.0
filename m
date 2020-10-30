Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048202A0AF7
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Oct 2020 17:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgJ3QSS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Oct 2020 12:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgJ3QSR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Oct 2020 12:18:17 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89006C0613CF
        for <linux-rdma@vger.kernel.org>; Fri, 30 Oct 2020 09:18:17 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k27so7154568oij.11
        for <linux-rdma@vger.kernel.org>; Fri, 30 Oct 2020 09:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ygxdLejkCqYaXogAL/PXXs2yOnCVoOTO5GUNVcZLDoQ=;
        b=pgxB+PifEZvf1sIvb4N+xUyDXfY+NV5mQUh90V2cXZjJQnP3fccQSXb8TWu52ZYlMy
         ivSGK4wZbjDiF6TzsoN6/ycMWQJUjh5NSERJ4XJCoW3GbfP18Z8I6l2a5wH6Gwy46tvn
         RamF8ygVclkOr/x1YJIGvsrSWnbH+gx2w7FNb3ZAPo1IX/6LNBICrWvjY0nvq3+Pi7BP
         1Ag+r+4lpsZap4iGOwTCfDEeGMgXluXcWh39vKb2dZWf83dyfQr1fTVru/zvP/xt8Nqc
         DqRVFE2SAghabJea/fZeo10YKQa/TbYj9cHe1RiGy0SvfIXfo0n5OShS7X2kLI/xiDq/
         ZiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ygxdLejkCqYaXogAL/PXXs2yOnCVoOTO5GUNVcZLDoQ=;
        b=JM5s9BIoMczpllggcHE0Nd97ODKQhDiMUzjpN4gqjfd5WTF5MhUOdrePW2RjHDdLmh
         +IjHVIzD9m8u8B5EMKDZ6cwtDk5EiBBcbQvK89/GyABDyiT9LnRvcZo3Iaki2Y5S90iw
         O92Tb7wR50OsAijhoHIluSb3BIPa9YbkbAQDKEZs+8rCxclVQ6r9e6BuAybZbm5Lutl7
         RAgfaJIzPDyL0UZvtKaKjIBMjAJo/JzajsouAVd8j4+AHxRdM1oKkqaYHYcQ/gi226kI
         hHLDM6brcgtvALW/M9EKKPkNLE1pM1md6+HhS9220GJQYNyyZkyYRDJsxNv01PHw0th+
         jtGQ==
X-Gm-Message-State: AOAM531YSnX6nKMx50QGH823cM32hN3iTTPm2gXabd/sX+qfZ3rjc4k4
        dvhaXttRGqF2i0hkI7E5I60=
X-Google-Smtp-Source: ABdhPJxlWCKwZExoKkdgsCMQjLsSOrKrr06SgdAH9UuLBHgs5Fo8FU133c8z/9uWCR85NW77I2GvCg==
X-Received: by 2002:aca:aa47:: with SMTP id t68mr568489oie.40.1604074696920;
        Fri, 30 Oct 2020 09:18:16 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:b6dc:62b4:e209:78d4? (2603-8081-140c-1a00-b6dc-62b4-e209-78d4.res6.spectrum.com. [2603:8081:140c:1a00:b6dc:62b4:e209:78d4])
        by smtp.gmail.com with ESMTPSA id 76sm1427551oty.15.2020.10.30.09.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 09:18:16 -0700 (PDT)
Subject: Re: [PATCH] RDMA/rxe,siw: Restore uverbs_cmd_mask
 IB_USER_VERBS_CMD_POST_SEND
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        linux-rdma@vger.kernel.org, Zhu Yanjun <yanjunz@nvidia.com>
References: <0-v1-4608c5610afa+fb-uverbs_cmd_post_send_fix_jgg@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <77c24a90-0df2-e0b4-02a7-6f88f2aa9b46@gmail.com>
Date:   Fri, 30 Oct 2020 11:18:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <0-v1-4608c5610afa+fb-uverbs_cmd_post_send_fix_jgg@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/30/20 9:03 AM, Jason Gunthorpe wrote:
> These two drivers open code the call to POST_SEND and do not use the
> rdma-core wrapper to do it, thus their usages was missed during the audit.
> 
> Both drivers use this as a doorbell to signal the kernel to start DMA.
> 
> Fixes: 628c02bf38aa ("RDMA: Remove uverbs cmds from drivers that don't use them")
> Reported-by: Bob Pearson <rpearsonhpe@gmail.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 3 ++-
>  drivers/infiniband/sw/siw/siw_main.c  | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 7652d53af2c1d9..209c7b3fab97a2 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1142,7 +1142,8 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
>  	dma_set_max_seg_size(&dev->dev, UINT_MAX);
>  	dma_set_coherent_mask(&dev->dev, dma_get_required_mask(&dev->dev));
>  
> -	dev->uverbs_cmd_mask |= BIT_ULL(IB_USER_VERBS_CMD_REQ_NOTIFY_CQ);
> +	dev->uverbs_cmd_mask |= BIT_ULL(IB_USER_VERBS_CMD_POST_SEND) |
> +				BIT_ULL(IB_USER_VERBS_CMD_REQ_NOTIFY_CQ);
>  
>  	ib_set_device_ops(dev, &rxe_dev_ops);
>  	err = ib_device_set_netdev(&rxe->ib_dev, rxe->ndev, 1);
> diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
> index e49faefdee923d..9cf596429dbf7d 100644
> --- a/drivers/infiniband/sw/siw/siw_main.c
> +++ b/drivers/infiniband/sw/siw/siw_main.c
> @@ -347,6 +347,8 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
>  				    addr);
>  	}
>  
> +	base_dev->uverbs_cmd_mask |= BIT_ULL(IB_USER_VERBS_CMD_POST_SEND);
> +
>  	base_dev->node_type = RDMA_NODE_RNIC;
>  	memcpy(base_dev->node_desc, SIW_NODE_DESC_COMMON,
>  	       sizeof(SIW_NODE_DESC_COMMON));
> 
This the right short term fix but seriously why not just completely kill off uverbs_cmd_mask? If a driver sets a non-NULL value in ib_device_ops assume it was done for a reason and allow commands through. Is there any example of a driver using uverbs_cmd_mask to dynamically enable/disable a verb? I thought this was your plan when you mentioned this change a while back.

Your comment about open coding the post send command is valid. I don't recall all the history that got us to where we are now but it looks like calling ibv_cmd_post_send could be made to work. Since wr_count will be zero a lot of extra work will not happen but there is still more work than needed. The only thing I would be worried about is that it assumes the wqes are struct ib_uverbs_send_wr's but at least for rxe they are expanded. Have to make sure there aren't any bad side effects now or in the future from e.g. sending the wrong wqe size to the kernel.

Bob
