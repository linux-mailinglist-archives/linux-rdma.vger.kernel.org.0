Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF95010932B
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2019 18:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfKYR4I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Nov 2019 12:56:08 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37351 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfKYR4F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Nov 2019 12:56:05 -0500
Received: by mail-qt1-f196.google.com with SMTP id w47so14067174qtk.4
        for <linux-rdma@vger.kernel.org>; Mon, 25 Nov 2019 09:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+AkbOYNSfYiezjPLdSnjolzt8xxFhu2Td/znte/qf/w=;
        b=JRgNm/9iwjQ39ugOzZX2fVrnVVkJkUowGDl+o8x94AJohrxs6fqQ4G60a9uVflAvf6
         zUBBB9fr/9CLr6j7s31qcPLtgadSDmrnD2hv60/7tMKcD/5nKtEnIuBRCdcer3tXzsFT
         vWvJtXhnhcNcrLNahkkjL5DPyOPjLW70rIZujXPlIiXZlF3/HZUNYab0lpBCLOthAwQu
         URLwbfeKXopukt58Q1Fq90bIBJ94JDsHWxgcNiANdMA1E8Rqy6HuMwnoMYBIm4ffBfhp
         LaYStd9vm/G8YGYWupwjQHAXNsVG0m88Mtm0OCwr4eKBT3CaRgTYic7k4HUlWVw8B+t6
         OAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+AkbOYNSfYiezjPLdSnjolzt8xxFhu2Td/znte/qf/w=;
        b=OikDmmZSUDsZBtLnggeqcsZvzk3BmZzSi+IFMXlWsKKzjCjWBrvSRWN11w6FOdgBGM
         jN1yRrdoUE3V3fKplvh4FV8/TUqldqlmJ6Lcyy9r1liE9wDz1MQIBDn0GOLzFtT3RD/9
         W1Kyc5ONS4rxId0bDoG7MD9EU6237XIbiLj5YigAk3y25iQBqakuItmbcXdTQk7NLa6J
         HpVpPQTX2G+mIRfh2OLoiUH1Gq+BEwjzYWmy0zzjYQ6pWWv+Z04xWngNRWbwDqXyagV2
         HIT1dOdqHHx4D88bIHgEszEfUq579AOel7gbRFImKizC5iv1THQOkcgPt2WJbkAP3qq4
         8/cA==
X-Gm-Message-State: APjAAAXviqeFdMS6DNLJggB2AmEIKVQveuLq7vG6cOWf6gudJJ317Yj+
        9lystg6AVHGv1SZtrGJUQ4MoQbmqqzk=
X-Google-Smtp-Source: APXvYqwW/UG8XvIB6NUL6nC0IC7Yhf8NvBHHncoqWwC42kFITIbLnsBVS2VFYignqyym08cPpxAx1Q==
X-Received: by 2002:ac8:5491:: with SMTP id h17mr19376040qtq.292.1574704564315;
        Mon, 25 Nov 2019 09:56:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id j16sm4326726qta.59.2019.11.25.09.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Nov 2019 09:56:03 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iZIah-00013G-6H; Mon, 25 Nov 2019 13:56:03 -0400
Date:   Mon, 25 Nov 2019 13:56:03 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Andrew Boyer <aboyer@pensando.io>
Cc:     linux-rdma@vger.kernel.org, allenbh@pensando.io
Subject: Re: [PATCH] rdma-core: Recognize IBV_DEVICE_LOCAL_DMA_LKEY in
 ibv_devinfo
Message-ID: <20191125175603.GB11270@ziepe.ca>
References: <20191125152237.19084-1-aboyer@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125152237.19084-1-aboyer@pensando.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 25, 2019 at 07:22:37AM -0800, Andrew Boyer wrote:
> This bit is defined in the kernel but not displayed by ibv_devinfo.
> 
> Signed-off-by: Andrew Boyer <aboyer@pensando.io>
>  libibverbs/examples/devinfo.c | 3 +++
>  libibverbs/verbs.h            | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/libibverbs/examples/devinfo.c b/libibverbs/examples/devinfo.c
> index bf53eac2..e3210f6e 100644
> +++ b/libibverbs/examples/devinfo.c
> @@ -220,6 +220,7 @@ static void print_device_cap_flags(uint32_t dev_cap_flags)
>  				   IBV_DEVICE_RC_RNR_NAK_GEN |
>  				   IBV_DEVICE_SRQ_RESIZE |
>  				   IBV_DEVICE_N_NOTIFY_CQ |
> +				   IBV_DEVICE_LOCAL_DMA_LKEY |
>  				   IBV_DEVICE_MEM_WINDOW |
>  				   IBV_DEVICE_UD_IP_CSUM |
>  				   IBV_DEVICE_XRC |
> @@ -260,6 +261,8 @@ static void print_device_cap_flags(uint32_t dev_cap_flags)
>  		printf("\t\t\t\t\tSRQ_RESIZE\n");
>  	if (dev_cap_flags & IBV_DEVICE_N_NOTIFY_CQ)
>  		printf("\t\t\t\t\tN_NOTIFY_CQ\n");
> +	if (dev_cap_flags & IBV_DEVICE_LOCAL_DMA_LKEY)
> +		printf("\t\t\t\t\tLOCAL_DMA_LKEY\n");
>  	if (dev_cap_flags & IBV_DEVICE_MEM_WINDOW)
>  		printf("\t\t\t\t\tMEM_WINDOW\n");
>  	if (dev_cap_flags & IBV_DEVICE_UD_IP_CSUM)
> diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
> index 7b8d4310..81e5812c 100644
> +++ b/libibverbs/verbs.h
> @@ -112,6 +112,7 @@ enum ibv_device_cap_flags {
>  	IBV_DEVICE_RC_RNR_NAK_GEN	= 1 << 12,
>  	IBV_DEVICE_SRQ_RESIZE		= 1 << 13,
>  	IBV_DEVICE_N_NOTIFY_CQ		= 1 << 14,
> +	IBV_DEVICE_LOCAL_DMA_LKEY	= 1 << 15,
>  	IBV_DEVICE_MEM_WINDOW           = 1 << 17,
>  	IBV_DEVICE_UD_IP_CSUM		= 1 << 18,
>  	IBV_DEVICE_XRC			= 1 << 20,

This flag really only has meaning for the kernel, it should come out
of the uapi at all.

It is a mistake that kernel internal bits have been mixed in with
userspace bits.

Jason
