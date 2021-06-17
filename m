Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC163ABDAD
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jun 2021 22:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhFQUrZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Jun 2021 16:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhFQUrY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Jun 2021 16:47:24 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7378C061574
        for <linux-rdma@vger.kernel.org>; Thu, 17 Jun 2021 13:45:16 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id d19so7958051oic.7
        for <linux-rdma@vger.kernel.org>; Thu, 17 Jun 2021 13:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=J4OBOLcmUSjtf0dsa/9i3GzaSb7PSwCNiG1PsCPp930=;
        b=brpdvRVqIREl9c8AQ3FlpKXJ5K15Zl4ssRC7y6A6Nzy4Nc5DOpmFWzS7UyRHdGjprc
         VtvHiiqhZVn2QuRqLK1eqSjw+zPU9wuZIx9yFLgJBmjvcZIraSf/xiEtuVKIbDUs3ilz
         8cqfjDleOqydBroebFighIuZlCm46vjHrWf95skd1DXML8RTXXvsNvjhAxKCBqCFiUHy
         10EDkUADdlqIIqy7e3654rTZowPZ0ynzvHfD9aSYBMB1MfboGJYnLlR3759AvlcpZzmi
         1lkKyBcObmr0vgd37bqpOclS+nx2e5zw16m0dyWbETrdMLvnKs7HWthL6vMHR1Aq2LQx
         ubVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J4OBOLcmUSjtf0dsa/9i3GzaSb7PSwCNiG1PsCPp930=;
        b=q0Io4Fe/ZZseEIaiq2/zZIyhy0TnJ+ihWApxBST3hYUpLdyJ8wa6xD7RNz6MCDMxOQ
         qaZaGov7NQzYmFFE4n7F8u6SvRpuVZgi2HziPE+tE59t9i0jrewQIbz/NuuGn/jnpTUU
         V91dsZ2p4WdExLpbVYynCBZtAU9cI9y2iG8kJmfi4xRWD9pWUAwuqBw8W6BEO3P+hUc7
         E5wJXvF+HoBbBOgEmfC9rrM5qA20qqdaDZLYJfDifEq9DR3MTmaB08OPdtF1gQDuKT0l
         TSZNx+ZAjeXhhRZCejp5yWmHZxBhI9nnnNGoVKmSx+vEX54ggtD6OyTZgv71QfUh1Y8u
         sl2A==
X-Gm-Message-State: AOAM530tgBI5KAeaX0+JAv+MeaizWAVarA0SNXzoYJx+Nrb1T0zQGdwf
        QixOPx4ecaHJ0crxmWzJ7Mc=
X-Google-Smtp-Source: ABdhPJxU0WAYVIGm1Oamx+NDFqcBWSiqQ35tBI+PfkUFx0ln8j2/swPZZKDdQvNRYTM8PEXfkx4+FA==
X-Received: by 2002:a05:6808:1589:: with SMTP id t9mr11946036oiw.111.1623962716043;
        Thu, 17 Jun 2021 13:45:16 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:62ce:b5dc:8263:18a7? (2603-8081-140c-1a00-62ce-b5dc-8263-18a7.res6.spectrum.com. [2603:8081:140c:1a00:62ce:b5dc:8263:18a7])
        by smtp.gmail.com with ESMTPSA id y7sm1307718oix.36.2021.06.17.13.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 13:45:15 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] RDMA/rxe: Increase value of RXE_MAX_AH
To:     Rao Shoaib <Rao.Shoaib@oracle.com>, linux-rdma@vger.kernel.org,
        jgg@ziepe.ca, Zhu Yanjun <zyjzyj2000@gmail.com>
References: <20210617182511.1257629-1-Rao.Shoaib@oracle.com>
 <20210617182511.1257629-3-Rao.Shoaib@oracle.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <3aa5a673-3fd7-744b-b664-510005215bd2@gmail.com>
Date:   Thu, 17 Jun 2021 15:45:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210617182511.1257629-3-Rao.Shoaib@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/17/21 1:25 PM, Rao Shoaib wrote:
> From: Rao Shoaib <rao.shoaib@oracle.com>
> 
> In our internal testing we have found that the
> current limit is too small, this patch bumps it
> up to a higher value required for our tests, which
> are indicative of our customer usage.
> 
> Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
> index 3b9b1ff4234f..d375f2cff484 100644
> --- a/drivers/infiniband/sw/rxe/rxe_param.h
> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> @@ -66,7 +66,7 @@ enum rxe_device_param {
>  	RXE_MAX_MCAST_GRP		= 8192,
>  	RXE_MAX_MCAST_QP_ATTACH		= 56,
>  	RXE_MAX_TOT_MCAST_QP_ATTACH	= 0x70000,
> -	RXE_MAX_AH			= 100,
> +	RXE_MAX_AH			= 64000,
>  	RXE_MAX_SRQ			= 17408,
>  	RXE_MAX_SRQ_WR			= 0x4000,
>  	RXE_MIN_SRQ_WR			= 1,
> 

Interesting. There is no real reason to pick most of these values since it's just memory and does not reflect underlying hardware resources. It is advantageous to also be able to set them smaller to verify whether test cases correctly limit resources. It seems that there should be a way (module parameter or other) to adjust these values without having to recompile the driver. Thoughts?

Regards,

Bob Pearson
