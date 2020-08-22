Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF2A24E4F0
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Aug 2020 05:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgHVDjt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Aug 2020 23:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbgHVDjs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Aug 2020 23:39:48 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA54CC061573
        for <linux-rdma@vger.kernel.org>; Fri, 21 Aug 2020 20:39:48 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y6so1753300plk.10
        for <linux-rdma@vger.kernel.org>; Fri, 21 Aug 2020 20:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FqZ4CilYgMg80cDAoOn39XgiqlQHm0Am0nLYenMgDcQ=;
        b=XR5cOsJJd0xpFooMj5bTJZ8GYifgTnku84baIoCLnL6BMETDn0HucCWOVW1XsZbQjg
         QHPkPQ2H2QtUl8iO3S046U+N/x0Hu05bQGKRgpgCDdkUkvL5ceMTcS9S7tz72YFiLB7H
         cm72HlW4rF917yFFjI6HIIZMXZAM+tU2DnW+Ww0Lx9x2JFbOLQFkL+CsQVuB2PkVgwU3
         3P2R9nAXDqepVrfYP+E0bIkuxTzY6cj5pFQf5rwZ5I9s/MzKWfNOz/6QFnIDnRzMCsqA
         awlXejctvbbDXTK7huuF1zVLojwI/3TQw4TQpbTX1rwej+Yd9RMb8kU1UmKD+3rBUNni
         gtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FqZ4CilYgMg80cDAoOn39XgiqlQHm0Am0nLYenMgDcQ=;
        b=tcprUdDKlSayoUTRFkYclZJqFpcbMltw4u1duqEGNIIIUW6BzOeS7GSLBoUJfE7K94
         /Rv/Uo9RUA4rWVrUMPtddzzR3MD1IcpupDb2eaCte3KVfloPicLlKNSWxE01QFGbLa7m
         mNnsitA7WCIb8MsfY4k/ZAWNfr2jQ5mO+IR6e7lQRliKCBzVk+f4ghkWrwAoPcZMmvAQ
         2mEAMvlYD3GNYaDlkObomA/Oz9sccs8Cba7sB5yJS6JawX2yrPK0bxpW5lbVXSF6WBZ3
         QZL/TWwUFoszQbSpcd7L1kalf8P9RfJZEVPIe9wNl+FIFdGtkk7kAtHTh1cYJw+qN6N/
         fJZw==
X-Gm-Message-State: AOAM532R80n2c18b6FOhGbIQbFljeRChibPy9AKazAzy5YkqXUrAApXf
        krajbpmVn9j80pPRMhIi5iU=
X-Google-Smtp-Source: ABdhPJxVDFde4ffGWQ8tEuKELDNV9pHPfbat13y5wxxGxeZVY2/5BMiIrmdo2uROPnigQzuIYRwsww==
X-Received: by 2002:a17:90a:bd86:: with SMTP id z6mr4896713pjr.141.1598067588388;
        Fri, 21 Aug 2020 20:39:48 -0700 (PDT)
Received: from [10.75.201.17] ([118.201.220.138])
        by smtp.gmail.com with ESMTPSA id t33sm3573303pga.72.2020.08.21.20.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 20:39:47 -0700 (PDT)
Subject: Re: [PATCH v3 08/17] rdma_rxe: Added mw object
To:     Bob Pearson <rpearsonhpe@gmail.com>, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
References: <20200820224638.3212-1-rpearson@hpe.com>
 <20200820224638.3212-9-rpearson@hpe.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Message-ID: <658f29cf-8e9b-0282-9e8b-56285881fc0a@gmail.com>
Date:   Sat, 22 Aug 2020 11:39:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200820224638.3212-9-rpearson@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/21/2020 6:46 AM, Bob Pearson wrote:
> Set max_mw device attribute.
> Changed rxe_param.c so we can create mw objects (RXE_MAX_MW != 0).
> Changed mw_pool.c to use struct rxe_mw size for the mw pool.
> Added new mw struct to rxe_verbs.h. Can share state enum with mr.
>
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>   drivers/infiniband/sw/rxe/rxe.c       |  1 +
>   drivers/infiniband/sw/rxe/rxe_param.h | 10 ++++++----
>   drivers/infiniband/sw/rxe/rxe_pool.c  |  2 +-
>   drivers/infiniband/sw/rxe/rxe_verbs.h | 13 +++++++++++++
>   4 files changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index 6c2100c71874..10f441ac7203 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -54,6 +54,7 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
>   	rxe->attr.max_cq			= RXE_MAX_CQ;
>   	rxe->attr.max_cqe			= (1 << RXE_MAX_LOG_CQE) - 1;
>   	rxe->attr.max_mr			= RXE_MAX_MR;
> +	rxe->attr.max_mw			= RXE_MAX_MW;
>   	rxe->attr.max_pd			= RXE_MAX_PD;
>   	rxe->attr.max_qp_rd_atom		= RXE_MAX_QP_RD_ATOM;
>   	rxe->attr.max_res_rd_atom		= RXE_MAX_RES_RD_ATOM;
> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
> index 96516e251bc1..e1d485bdd6af 100644
> --- a/drivers/infiniband/sw/rxe/rxe_param.h
> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> @@ -60,7 +60,8 @@ enum rxe_device_param {
>   	RXE_MAX_SGE_RD			= 32,
>   	RXE_MAX_CQ			= 16384,
>   	RXE_MAX_LOG_CQE			= 15,
> -	RXE_MAX_MR			= 256 * 1024,
> +	RXE_MAX_MR			= 0x40000,
> +	RXE_MAX_MW			= 0x40000,

How to get this 0x40000?

Thanks


>   	RXE_MAX_PD			= 0x7ffc,
>   	RXE_MAX_QP_RD_ATOM		= 128,
>   	RXE_MAX_RES_RD_ATOM		= 0x3f000,
> @@ -89,9 +90,10 @@ enum rxe_device_param {
>   	RXE_MAX_SRQ_INDEX		= 0x00040000,
>   
>   	RXE_MIN_MR_INDEX		= 0x00000001,
> -	RXE_MAX_MR_INDEX		= 0x00040000,
> -	RXE_MIN_MW_INDEX		= 0x00040001,
> -	RXE_MAX_MW_INDEX		= 0x00060000,
> +	RXE_MAX_MR_INDEX		= RXE_MIN_MR_INDEX + RXE_MAX_MR - 1,
> +	RXE_MIN_MW_INDEX		= RXE_MIN_MR_INDEX + RXE_MAX_MR,
> +	RXE_MAX_MW_INDEX		= RXE_MIN_MW_INDEX + RXE_MAX_MW - 1,
> +
>   	RXE_MAX_PKT_PER_ACK		= 64,
>   
>   	RXE_MAX_UNACKED_PSNS		= 128,
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index fe652ce488f3..ad6f50e8b57a 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -60,7 +60,7 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
>   	},
>   	[RXE_TYPE_MW] = {
>   		.name		= "rxe-mw",
> -		.size		= sizeof(struct rxe_mr),
> +		.size		= sizeof(struct rxe_mw),
>   		.flags		= RXE_POOL_INDEX,
>   		.max_index	= RXE_MAX_MW_INDEX,
>   		.min_index	= RXE_MIN_MW_INDEX,
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index c866fc5a80d6..44da74a41ccb 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -264,6 +264,7 @@ struct rxe_qp {
>   	struct execute_work	cleanup_work;
>   };
>   
> +/* common state values for mr and mw */
>   enum rxe_mem_state {
>   	RXE_MEM_STATE_ZOMBIE,
>   	RXE_MEM_STATE_INVALID,
> @@ -321,6 +322,18 @@ struct rxe_mr {
>   	struct rxe_map		**map;
>   };
>   
> +struct rxe_mw {
> +	struct rxe_pool_entry	pelem;
> +	struct ib_mw		ibmw;
> +	struct rxe_qp		*qp;	/* type 2B only */
> +	struct rxe_mr		*mr;
> +	spinlock_t		lock;
> +	enum rxe_mem_state	state;
> +	u32			access;
> +	u64			addr;
> +	u64			length;
> +};
> +
>   struct rxe_mc_grp {
>   	struct rxe_pool_entry	pelem;
>   	spinlock_t		mcg_lock; /* guard group */


