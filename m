Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC332432A4
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Aug 2020 05:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHMDQx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Aug 2020 23:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgHMDQw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Aug 2020 23:16:52 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1A5C061757
        for <linux-rdma@vger.kernel.org>; Wed, 12 Aug 2020 20:16:52 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id r11so2071346pfl.11
        for <linux-rdma@vger.kernel.org>; Wed, 12 Aug 2020 20:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/KGcybTpHGppXAunkXu5U5/JDPmFjpBXLgXKIxvXPmM=;
        b=pEpzX10HzUR+6tKVfbAjAROw+f6BeaTBzgDrtX18aVSGwCQKldg60bnBH3qY/c23c6
         v4AeO+E5ifAJ9r8DPRhrrQrDDJGOWWBcM+gpfoPlwBqH85iIhPX3TE3iPZH+zepkO5MO
         mlwoG/PMDjvfAUf/LPF3hwNDIqvIjQbF/umyKlPW69L1urOZEEPGYhvlURw7CGmXl23M
         IgCzjU6VF4E6BW20mVpeC4SAHlk7VrbehScCGX3p3an126Vj/N8h3gr6vvzyweTejm/E
         y17oe2EXdJxYu2OLg/wc1xIRot7gB1Ij59kHpjEs3J9+/aTE750AhTo8YOWtkqAhlfYt
         YLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/KGcybTpHGppXAunkXu5U5/JDPmFjpBXLgXKIxvXPmM=;
        b=qw+yrTGGqFRPxFmItZ26ex+0tgxCw7USWOdaTAVt6y9wzH4YYSiQ9eY/YaSCVuOQkd
         VuWELbo56Fv5vlE3jvGdnjwmBHQs99assiyw56zfWjU1zBxlexXh8fzEN/mSSj6ryvC3
         5XBtK9UEqX4pIJweoHxo8PocAvaBjN/I/LsSfblJT03vdIiuZEp7Jl0hntLeZXqIx1DC
         llyadjCyKOxvkDkmmSj8lJEo8Zqnhq8aFI17Tt/1rr4w39667aU2ODgQti6QXZ4f663D
         yUuP4Wp+ODpfK32edsQAI5+V1DbWqtVL7o7eYDTEPmixYV64NGtTbqbpp0zBKZgp+wOS
         /b+w==
X-Gm-Message-State: AOAM531oLx/8vQAsvUUzG50QnHX065rhulTh3tMwsWxGjgLMRh6R5MJG
        yoKUj4rzSfUQghS9RoDozNs=
X-Google-Smtp-Source: ABdhPJyMdBHJvBupQGUTEw85VFiSXWHUv3Zv019k/wJCmhDVHgvJ2BCg0BG25X3/wZFLsuBIF9WZJg==
X-Received: by 2002:a63:201f:: with SMTP id g31mr1882122pgg.186.1597288612016;
        Wed, 12 Aug 2020 20:16:52 -0700 (PDT)
Received: from [10.75.201.17] ([118.201.220.138])
        by smtp.gmail.com with ESMTPSA id 74sm2885455pfv.191.2020.08.12.20.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 20:16:51 -0700 (PDT)
Subject: Re: [PATCH] RDMA/rxe: prevent rxe creation on top of vlan interface
To:     Mohammad Heib <goody698@gmail.com>, linux-rdma@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, kamalheib1@gmail.com,
        leon@kernel.org
References: <20200811150415.3693-1-goody698@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Message-ID: <72e827bd-2934-8947-15e5-3692ab7409ae@gmail.com>
Date:   Thu, 13 Aug 2020 11:16:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200811150415.3693-1-goody698@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/11/2020 11:04 PM, Mohammad Heib wrote:
> Creating rxe device on top of vlan interface will create a non-functional device
> that has an empty gids table and can't be used for rdma cm communication.

Can we fix this empty gids table?

So this gids table can be used for rdma cm communication.

Zhu Yanjun

>
> This is caused by the logic in enum_all_gids_of_dev_cb()/is_eth_port_of_netdev(),
> which only considers networks connected to "upper devices" of the configured
> network device, resulting in an empty set of gids for a vlan interface,
> and attempts to connect via this rdma device fail in cm_init_av_for_response
> because no gids can be resolved.
>
> apparently, this behavior was implemented to fit the HW-RoCE devices that create
> RoCE device per port, therefore RXE must behave the same like HW-RoCE devices
> and create rxe device per real device only.
>
> In order to communicate via a vlan interface, the user must use the gid index of
> the vlan address instead of creating rxe over vlan.
>
> Signed-off-by: Mohammad Heib <goody698@gmail.com>
> ---
>   drivers/infiniband/sw/rxe/rxe.c       | 6 ++++++
>   drivers/infiniband/sw/rxe/rxe_sysfs.c | 6 ++++++
>   2 files changed, 12 insertions(+)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index 5642eefb4ba1..d2076aa7a732 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -310,6 +310,12 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
>   	struct rxe_dev *exists;
>   	int err = 0;
>   
> +	if (is_vlan_dev(ndev)) {
> +		pr_err("rxe creation allowed on top of a real device only\n");
> +		err = -EPERM;
> +		goto err;
> +	}
> +
>   	exists = rxe_get_dev_from_net(ndev);
>   	if (exists) {
>   		ib_device_put(&exists->ib_dev);
> diff --git a/drivers/infiniband/sw/rxe/rxe_sysfs.c b/drivers/infiniband/sw/rxe/rxe_sysfs.c
> index ccda5f5a3bc0..0a083c3d900a 100644
> --- a/drivers/infiniband/sw/rxe/rxe_sysfs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_sysfs.c
> @@ -73,6 +73,12 @@ static int rxe_param_set_add(const char *val, const struct kernel_param *kp)
>   		return -EINVAL;
>   	}
>   
> +	if (is_vlan_dev(ndev)) {
> +		pr_err("rxe creation allowed on top of a real device only\n");
> +		err = -EPERM;
> +		goto err;
> +	}
> +
>   	exists = rxe_get_dev_from_net(ndev);
>   	if (exists) {
>   		ib_device_put(&exists->ib_dev);


