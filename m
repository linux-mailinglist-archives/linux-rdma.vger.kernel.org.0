Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C09AE785D
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 19:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbfJ1SYd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 14:24:33 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41081 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403849AbfJ1SYc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 14:24:32 -0400
Received: by mail-qk1-f193.google.com with SMTP id m125so5467232qkd.8
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 11:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/ymsJWmQsMDsOBdliGezVB3+36UmYDbxusN99gaUbaM=;
        b=CIY+48DeenUnYru3tYIWWjrlEzkdn7Wvf9wBu1cWA9KSpzzimd4gsKDdB2qkU8lvnL
         YuSuz3sO2JFLP7CieALptcdYh6rAexwGpEIM70A8xhsKgomD7FneaO3B9jJHlrWD2OaG
         1WnOVYBWnnJwi4UDqBxXm3ot3m58YdfSyc+zxvxzFdq2hH4fAG7Ce+B/nZAQidhSo++y
         FGko3d5kswhbL2Wh0twJU4oUjaT8N6vwIGoCF+WEjBMAhnJuvOOP4dirupYBU6g0aBT7
         HkzOYmEi0Wxh3hKF1+JfHAzqfW0PV7OSRSsRCSBHqJfUVekBRNssuNWLYJgBDFLFem9j
         SPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/ymsJWmQsMDsOBdliGezVB3+36UmYDbxusN99gaUbaM=;
        b=Rs1y/+0iN3IiN0qhtXb9eYTkFUXKLZnR1MTsgjd1R8bSH85JViGDIuqWNThozzd3DN
         1NUXSkJ/zonTTlroWMsszuMhMkxPsCjkNR099vph0CoeqSmUGUZMPZqWGWp2fSn80bmQ
         3lNgmXYRjHYRY8zr7twZME6zXiFEDFkk3ZlBp/S+1+ydCVZ7FTL9pvpsK+xPjKLOe/Z6
         ndhwFC49r4GshfceXTQ6MkLhqaJOzhIdGUsl6Bsiub9ZVM7FuvUQWQcDuvzE9cicLHm/
         1NkRXfDLllQjhVdRwRsRJIqHsur0hb7dqLb+7Rq8qWE32wHcOwYF8AOSHPOHYQHPVfvZ
         D6sA==
X-Gm-Message-State: APjAAAXArFRG/+GY2nx24YzFBI7el8EXznFkG+Jj59HsQJdlo3W7NmPJ
        S2/ytzLc0zZpwmEsedjpbRksTg==
X-Google-Smtp-Source: APXvYqyB2BBlIDXxPkLlXr+7hB4qSLjqNnE0lGjomYABPNxXrmpb2nkHAE4hnFx3VSyWon98hBqw0w==
X-Received: by 2002:a05:620a:15f1:: with SMTP id p17mr16893832qkm.336.1572287070313;
        Mon, 28 Oct 2019 11:24:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id s21sm8349588qtc.12.2019.10.28.11.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 11:24:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iP9gr-0003oB-4W; Mon, 28 Oct 2019 15:24:29 -0300
Date:   Mon, 28 Oct 2019 15:24:29 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@hisilicon.com>, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-rc 1/2] RDMA/hns: Fix memory leaks about mr
Message-ID: <20191028182429.GA14440@ziepe.ca>
References: <1572072995-11277-1-git-send-email-liweihang@hisilicon.com>
 <1572072995-11277-2-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572072995-11277-2-git-send-email-liweihang@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Oct 26, 2019 at 02:56:34PM +0800, Weihang Li wrote:
> From: Lijun Ou <oulijun@huawei.com>
> 
> In hns_roce_v1_dereg_mr(), 'mr_work' is not freed in some cases, for
> example, try_wait_for_completion() runs fail, which will cause memory
> leaks.
> 
> Fixes: bfcc681bd09d ("IB/hns: Fix the bug when free mr")
> Signed-off-by: Lijun Ou <oulijun@huawei.com>
> Signed-off-by: Weihang Li <liweihang@hisilicon.com>
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
> index 5f74bf5..88c1cd9 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
> @@ -1094,7 +1094,6 @@ static void hns_roce_v1_mr_free_work_fn(struct work_struct *work)
>  free_work:
>  	if (mr_work->comp_flag)
>  		complete(mr_work->comp);
> -	kfree(mr_work);
>  }
>  
>  static int hns_roce_v1_dereg_mr(struct hns_roce_dev *hr_dev,
> @@ -1137,18 +1136,21 @@ static int hns_roce_v1_dereg_mr(struct hns_roce_dev *hr_dev,
>  
>  	while (end > 0) {
>  		if (try_wait_for_completion(&comp))
> -			goto free_mr;
> +			goto err;
>  		msleep(HNS_ROCE_V1_FREE_MR_WAIT_VALUE);
>  		end -= HNS_ROCE_V1_FREE_MR_WAIT_VALUE;
>  	}
>  
>  	mr_work->comp_flag = 0;
>  	if (try_wait_for_completion(&comp))
> -		goto free_mr;
> +		goto err;
>  
>  	dev_warn(dev, "Free mr work 0x%x over 50s and failed!\n", mr->key);
>  	ret = -ETIMEDOUT;
>  
> +err:
> +	kfree(mr_work);

This whole thing makes absolutely no sense.

Why is work being pushed onto a WQ and then the same routine turns
around and does wait_for_completion??

Further, trying to make this 'non blocking' by sleep spinning on
'try_wait_for_completion' is utterly insane.

Then going on to uncondionally free memory that we don't even know if
the work is finished with or not is just wrong.

Doug, you took this spin loop stuff, you get to review the fixes for
it! :)

Jason
