Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3112D42C689
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Oct 2021 18:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhJMQku (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Oct 2021 12:40:50 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:37400 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhJMQkt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Oct 2021 12:40:49 -0400
Received: by mail-pg1-f174.google.com with SMTP id r201so2876091pgr.4
        for <linux-rdma@vger.kernel.org>; Wed, 13 Oct 2021 09:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zM75VIDNGwezxyCmi7rOOUy+NwMqAPbpeID+9qiem5A=;
        b=zUb5CbXjrtqWd9XcLS37lp6/l7fxpjfWM6343vV+F38/rJFTtrpm3WcabjgSyB5XfY
         i3BmkjQJMBdqGell+ar50bpZiX8XSU+SwIyJ9eeuLfPNTF3+rv/Un4znn7AKuk/2yc/f
         YToGjGVPY1qKnM2N7nbc5Hk8Px5AP7dwE4HJsTzqfrk6ekw11T/y7Pu4iGxsZql3V2p8
         MQWkRiNsgX9d0cFwoJlR+87Qte/94OLikd6e+Qn1RWVA+UqtiXrFYKDdrBpAMpeSTsFV
         kaGT/jd2+F5LEL+QoZpZQ/oZve1530VLK5AXlZRKLnL3p4OQEwdFTzeBPUkQ+S0X2d/W
         xoHA==
X-Gm-Message-State: AOAM531fXR6LML+PORvj55uiv8aqPZho5FLT3drsqOShG3TOF/imGKpc
        f01Z510YzCrCgl9CFaFftx4=
X-Google-Smtp-Source: ABdhPJzxmObMs+mHiqK/6u5JniPlGsocGAHZ2MNRnzBK9gj5NgopDOaisdSWiCHTAGkX6DXkvavrTw==
X-Received: by 2002:a63:cc08:: with SMTP id x8mr161705pgf.166.1634143124394;
        Wed, 13 Oct 2021 09:38:44 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ae3:1dc1:f2a3:9c06])
        by smtp.gmail.com with ESMTPSA id a27sm70866pfl.20.2021.10.13.09.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 09:38:43 -0700 (PDT)
Subject: Re: Kernel warning at drivers/infiniband/core/rw.c:349
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <996fa723-18ef-d35b-c565-c9cb9dc2d5e1@acm.org>
 <2b07fbf9-36b4-37ea-b203-7d0a2fc6589a@deltatee.com>
 <a9d05dea-860f-fe77-fc41-19208d76d9c1@acm.org>
 <6ff6b13c-d5c8-eec1-6949-5aabf28a5e68@deltatee.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <66af8970-e05c-6525-5e5d-b879f2e2c87d@acm.org>
Date:   Wed, 13 Oct 2021 09:38:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <6ff6b13c-d5c8-eec1-6949-5aabf28a5e68@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/13/21 9:15 AM, Logan Gunthorpe wrote:
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 4b50d9a3018a..4ba642fc8a19 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -4097,8 +4097,13 @@ static inline int ib_dma_map_sgtable_attrs(struct ib_dev>
>                                             enum dma_data_direction direction,
>                                             unsigned long dma_attrs)
>   {
> +       int nents;
> +
>          if (ib_uses_virt_dma(dev)) {
> -               ib_dma_virt_map_sg(dev, sgt->sgl, sgt->orig_nents);
> +               nents = ib_dma_virt_map_sg(dev, sgt->sgl, sgt->orig_nents);
> +               if (!nents)
> +                       return -EIO;
> +               sgt->nents = nents;
>                  return 0;
>          }
>          return dma_map_sgtable(dev->dma_device, sgt, direction, dma_attrs);

Thanks!

Tested-by: Bart Van Assche <bvanassche@acm.org>
