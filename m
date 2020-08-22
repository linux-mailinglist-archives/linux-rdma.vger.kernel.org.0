Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B92324E4E9
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Aug 2020 05:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgHVDcR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Aug 2020 23:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgHVDcR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Aug 2020 23:32:17 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500E3C061573
        for <linux-rdma@vger.kernel.org>; Fri, 21 Aug 2020 20:32:17 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mt12so1644801pjb.4
        for <linux-rdma@vger.kernel.org>; Fri, 21 Aug 2020 20:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3uij7HqByVEpW6pXYBQ6y6toOrqnDT7WXtpYctfIGFM=;
        b=skCDzJJThNCOkXcT/fk0gZ6wBo8uheJ1q+KcEOZwYU1OoM3nIwoOODcl2H3Igfq7vZ
         y/PvMGCPGTRmO/foN+fuIjqy9ze/Ye5Guxe4XQMltlzBml5cl2w6FaST1dGRnDY2R3Iz
         zgvnDOAqnKBCMadCxwx7dS043EHs+tds3FnNiUr9HBOM7V6qnFcjw17KbMNt44nYJ54w
         fGSXy6CA1UCL9DQ2A8mWXvJDhmh6QXg6eCkk2l0R0n5h3i5tLGu5taR6yw3l0nsviayJ
         ApesSb2MjAKmQzVFfVYKt7O6g7EMHv4+nDQPmhIjjcth5frbXPY65zFnh6UUtvhToJjg
         7qfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3uij7HqByVEpW6pXYBQ6y6toOrqnDT7WXtpYctfIGFM=;
        b=Ade2BIONsw+1uF3OT+jDfqYw8Y0xgwhHOlNPXcFjlJ79Ei+Vm162OMt2iInm4yvZJk
         qh60NERTNCKpKMtVxsk5V0tvdhXSbkGRr0iAY4+C8wyIV3/IUgVPM9tYoTp69B+ok9LV
         7GYORC2NfEvKB6/Xv4MSnILo4BNt2CcM9itEDFPnIJIcB6A7s6SRA5vsmmjpyx3Kpkrg
         NCoFIKySC4DiqlRf749zyQe4up7ngEQnJ7Wmw0w/qpvFqEOC1ktIAXL5nLsJtRdhBbow
         /irEDYK5kooScFg71cFFWUQ6vSNIjemL9WX3PDWDXNbL4bIkQbSRZUshE+GWmdyH7keC
         b/uA==
X-Gm-Message-State: AOAM533y+KVFCC2wBgAntaQcjjVbMQhJczUkGahbjska6oKfWmxmKShV
        La7zUK6s2RIphKZloZlMRUD20B07MRo=
X-Google-Smtp-Source: ABdhPJxDShGgCk6FCFJFrfGHb/6pC2JRQLAnjt08x/Rs7JkfERKMCjFymPx8Uw1J8X4JReQlx8zuoA==
X-Received: by 2002:a17:902:b589:: with SMTP id a9mr4606907pls.98.1598067136858;
        Fri, 21 Aug 2020 20:32:16 -0700 (PDT)
Received: from [10.75.201.17] ([118.201.220.138])
        by smtp.gmail.com with ESMTPSA id b22sm3867943pfb.213.2020.08.21.20.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 20:32:16 -0700 (PDT)
Subject: Re: [PATCH v3 11/17] rdma_rxe: Address an issue with hardened user
 copy
To:     Bob Pearson <rpearsonhpe@gmail.com>, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
References: <20200820224638.3212-1-rpearson@hpe.com>
 <20200820224638.3212-12-rpearson@hpe.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Message-ID: <4fd91289-7cd7-a62c-54ee-4ace9eb45a14@gmail.com>
Date:   Sat, 22 Aug 2020 11:32:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200820224638.3212-12-rpearson@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/21/2020 6:46 AM, Bob Pearson wrote:
> Added a new feature to pools to let driver white list a region of
> a pool object. This removes a kernel oops caused when create qp
> returns the qp number so the next patch will work without errors.
>
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_pool.c | 20 +++++++++++++++++---
>   drivers/infiniband/sw/rxe/rxe_pool.h |  4 ++++
>   2 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index 5679714827ec..374e56689d30 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -40,9 +40,12 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
>   		.name		= "rxe-qp",
>   		.size		= sizeof(struct rxe_qp),
>   		.cleanup	= rxe_qp_cleanup,
> -		.flags		= RXE_POOL_INDEX,
> +		.flags		= RXE_POOL_INDEX
> +				| RXE_POOL_WHITELIST,
>   		.min_index	= RXE_MIN_QP_INDEX,
>   		.max_index	= RXE_MAX_QP_INDEX,
> +		.user_offset	= offsetof(struct rxe_qp, ibqp.qp_num),
> +		.user_size	= sizeof(u32),
>   	},
>   	[RXE_TYPE_CQ] = {
>   		.name		= "rxe-cq",
> @@ -116,10 +119,21 @@ int rxe_cache_init(void)
>   		type = &rxe_type_info[i];
>   		size = ALIGN(type->size, RXE_POOL_ALIGN);
>   		if (!(type->flags & RXE_POOL_NO_ALLOC)) {
> -			type->cache =
> -				kmem_cache_create(type->name, size,
> +			if (type->flags & RXE_POOL_WHITELIST) {
> +				type->cache =
> +					kmem_cache_create_usercopy(
> +						type->name, size,
> +						RXE_POOL_ALIGN,
> +						RXE_POOL_CACHE_FLAGS,
> +						type->user_offset,
> +						type->user_size, NULL);
> +			} else {
> +				type->cache =
> +					kmem_cache_create(type->name, size,
>   						  RXE_POOL_ALIGN,
>   						  RXE_POOL_CACHE_FLAGS, NULL);
> +			}
> +
>   			if (!type->cache) {
>   				pr_err("Unable to init kmem cache for %s\n",
>   				       type->name);
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
> index 664153bf9392..fc5b584a8137 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.h
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.h
> @@ -17,6 +17,7 @@ enum rxe_pool_flags {
>   	RXE_POOL_INDEX		= BIT(1),
>   	RXE_POOL_KEY		= BIT(2),
>   	RXE_POOL_NO_ALLOC	= BIT(4),
> +	RXE_POOL_WHITELIST	= BIT(5),
>   };
>   
>   enum rxe_elem_type {
> @@ -44,6 +45,9 @@ struct rxe_type_info {
>   	u32			min_index;
>   	size_t			key_offset;
>   	size_t			key_size;
> +	/* for white listing where necessary */

s/where/when


> +	unsigned int		user_offset;
> +	unsigned int		user_size;
>   	struct kmem_cache	*cache;
>   };
>   


