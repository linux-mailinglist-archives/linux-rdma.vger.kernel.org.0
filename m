Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECD625039F
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 18:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgHXQre (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 12:47:34 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37073 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgHXQrK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 12:47:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id s14so4506749plp.4
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 09:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XVrRwpRAI5KR5N0VOGCo163ZBFH7dIYsN80X7JWxdTQ=;
        b=S2tTsmK7W3B+7OLC5RHi8fnPblzZ1DfmfuZBunZ18xEQuLpHccGXI1lZoLpnn01+xY
         PJq6CW0+CnVZVFxCisjan+CKQ9zRz2gA87YUsp4+Zd1an5k9kTwvx/B/CHDlMr83CAFm
         sFKvAlmx5QmYuDX+V4hhRZaOTlyEY6fNsB7WdqSP+2A78OYmj95lvzFdEOWHoDGxm55z
         ZNSchovrsGtRPX41Je7hU76+accKghN4DkZXXcJiLApBA5ihAWUm+6A0RB2xDbzUtDoo
         Tbo1Z2A33RM0kDJX3gde2VIDQlL7tSxFNl2j0ytDYJVHB62AsML0FyRxjyWR2mH9UH94
         y3Ow==
X-Gm-Message-State: AOAM530EJ5eudGCCRkAIMpMIhv6BH26cfBddR/Gb0OEm1EMOfTQl+Juf
        XmhOD45MeyP1yv/mcYpqTwQ=
X-Google-Smtp-Source: ABdhPJwNu3hyLSB07Xv8mWzkh1VVis6dRaTC7blbw/ZoezMiHuSAwpiMZwLRFioy7EdjxNadx5EomA==
X-Received: by 2002:a17:90b:94c:: with SMTP id dw12mr160735pjb.214.1598287629744;
        Mon, 24 Aug 2020 09:47:09 -0700 (PDT)
Received: from [192.168.50.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id d23sm10137110pgm.11.2020.08.24.09.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 09:47:08 -0700 (PDT)
Subject: Re: [PATCH v2] RDMA/rxe: fix the parent sysfs read when the interface
 has 15 chars
To:     Yi Zhang <yi.zhang@redhat.com>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com
Cc:     kamalheib1@gmail.com, yanjunz@mellanox.com
References: <20200820153646.31316-1-yi.zhang@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a577d41b-5172-034e-c629-a1858ece74c9@acm.org>
Date:   Mon, 24 Aug 2020 09:47:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820153646.31316-1-yi.zhang@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/20/20 8:36 AM, Yi Zhang wrote:
> parent sysfs reads will yield '\0' bytes when the interface name
> has 15 chars, and there will no "\n" output.
> 
> reproducer:
> Create one interface with 15 chars
> [root@test ~]# ip a s enp0s29u1u7u3c2
> 2: enp0s29u1u7u3c2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN group default qlen 1000
>      link/ether 02:21:28:57:47:17 brd ff:ff:ff:ff:ff:ff
>      inet6 fe80::ac41:338f:5bcd:c222/64 scope link noprefixroute
>         valid_lft forever preferred_lft forever
> [root@test ~]# modprobe rdma_rxe
> [root@test ~]# echo enp0s29u1u7u3c2 > /sys/module/rdma_rxe/parameters/add
> [root@test ~]# cat /sys/class/infiniband/rxe0/parent
> enp0s29u1u7u3c2[root@test ~]#
> [root@test ~]# f="/sys/class/infiniband/rxe0/parent"
> [root@test ~]# echo "$(<"$f")"
> -bash: warning: command substitution: ignored null byte in input
> enp0s29u1u7u3c2
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_verbs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index bb61e534e468..756980f79951 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1056,7 +1056,7 @@ static ssize_t parent_show(struct device *device,
>   	struct rxe_dev *rxe =
>   		rdma_device_to_drv_device(device, struct rxe_dev, ib_dev);
>   
> -	return snprintf(buf, 16, "%s\n", rxe_parent_name(rxe, 1));
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", rxe_parent_name(rxe, 1));
>   }
>   
>   static DEVICE_ATTR_RO(parent);

Please add 'Cc: stable' to this patch.

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
