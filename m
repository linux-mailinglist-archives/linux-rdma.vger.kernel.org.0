Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EE958ABE1
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Aug 2022 15:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiHEN50 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Aug 2022 09:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiHEN5Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Aug 2022 09:57:25 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616B9BC32;
        Fri,  5 Aug 2022 06:57:23 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id z187so2306842pfb.12;
        Fri, 05 Aug 2022 06:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=WXsHnW98Ol/RR5LVCi+lD4WhQ/7kAEJ76/fSyx1eUIs=;
        b=S5DA0pZAZ6x+OdpWADKIE6qKzgcf1fJMQxBIPu7XvBRDngWSbM/Pv49a/azv1woHh2
         MbrAvmDr8h7n1AXt2FdHmrW/ak9ycNFxsnzcH7VkaNe4RrH8+0BdF5w/+5SyyENvaNOu
         ZcD0kjUqLMMYd6A92CTAdsnKmKCXu05/gxEDMY0NUsRgbT834CE9Cw5gumSO115RwUH2
         qF3tjMBL8qJS6TlgACrHDmoGvJSzbF8LAhsulR5plvZLbCAwilDI/mXr+yU9sMekCP+n
         aq8xg2F0QQuoqTA/edw1M5LCsVF+9YpG8AvauPzAHMqkusDYAKBM6LjxDNRzAmIPjDG9
         K+zQ==
X-Gm-Message-State: ACgBeo0DOEvUL7jYm//3OGpLMxHlidrgOMC/ZWoXSADrXuAK6cZWMQVV
        WWzib94U99f4SBJOLqnflsHcnk4GOe0=
X-Google-Smtp-Source: AA6agR62oAu3mdPvL4Yt6CYvizPyqvuAN1v2Us7b4hFhGKtkTfR92yJf+SoRooWfkiF6Zui4o9azWQ==
X-Received: by 2002:a05:6a00:2449:b0:528:3a29:e79d with SMTP id d9-20020a056a00244900b005283a29e79dmr7269921pfj.39.1659707842665;
        Fri, 05 Aug 2022 06:57:22 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id u5-20020a170903124500b0016bf2a4598asm3055571plh.229.2022.08.05.06.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 06:57:21 -0700 (PDT)
Message-ID: <d105bbea-9414-053a-1481-dfed663c83a8@acm.org>
Date:   Fri, 5 Aug 2022 06:57:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] RDMA/srp: Check dev_set_name() return value
Content-Language: en-US
To:     Bo Liu <liubo03@inspur.com>, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220805053434.3944-1-liubo03@inspur.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220805053434.3944-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/4/22 22:34, Bo Liu wrote:
> It's possible that dev_set_name() returns -ENOMEM, catch and handle this.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>   drivers/infiniband/ulp/srp/ib_srp.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> index 7720ea270ed8..a6f788e3b84b 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.c
> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> @@ -3905,8 +3905,9 @@ static struct srp_host *srp_add_port(struct srp_device *device, u8 port)
>   
>   	host->dev.class = &srp_class;
>   	host->dev.parent = device->dev->dev.parent;
> -	dev_set_name(&host->dev, "srp-%s-%d", dev_name(&device->dev->dev),
> -		     port);
> +	if (dev_set_name(&host->dev, "srp-%s-%d", dev_name(&device->dev->dev),
> +		     port))
> +		goto free_host;
>   
>   	if (device_register(&host->dev))
>   		goto free_host;

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
