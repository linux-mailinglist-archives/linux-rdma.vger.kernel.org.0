Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364FB358A20
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 18:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhDHQur (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 12:50:47 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:38739 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhDHQup (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Apr 2021 12:50:45 -0400
Received: by mail-pf1-f170.google.com with SMTP id y16so2259853pfc.5;
        Thu, 08 Apr 2021 09:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sdar1JYqPbP9ANx4vLPaKOvhZp3igugdf1CBVsY07+k=;
        b=HljPIXqvBVwBfr4CCcxKBJYh/oovt/wMk6XPy0S3WGeM0eHLFhKQOjhv7+FP4mY52n
         02yB7l1xi4L8X0M2Dt71jKmmzlZP3EN7plqGw642xJrcbFWHkhBqSe+2eDOnMQsgrfQS
         yE4CB4AhxQ5YPitqGn/RwidRSsbMMVe/02bjTco8Mx/z2N/fVjTYnToQD5BMRnjX3Y19
         x2guHYrVkcfesmC8bauMXSU0Ckyl6dSQUT781xTkAtJ6h65MLd1tClSyVf6osafK59uf
         g+pQz3lrLm35+YFmH8gOCLaSeDMInF3x4kq/5QZZL09HTtaOW1waneQZ9cxfaMl5JvBA
         +6Mw==
X-Gm-Message-State: AOAM532bEXLO4tyV2u+VvtlB6cdVN6tYV8si4n1C+dWW83y60Xt0lHYW
        M/Hr4vkxFvZM9+61RtUbogc=
X-Google-Smtp-Source: ABdhPJzOi9QErRu7oWT8gam8d6+h+7Hg3lrNHxXIOaDY9mV1pB95iEGKetbftSwHe4PLucQY19+chw==
X-Received: by 2002:a62:6451:0:b029:23f:6ea1:293f with SMTP id y78-20020a6264510000b029023f6ea1293fmr8279846pfb.53.1617900632069;
        Thu, 08 Apr 2021 09:50:32 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:7ef5:d4a7:50dd:fa70? ([2601:647:4000:d7:7ef5:d4a7:50dd:fa70])
        by smtp.gmail.com with ESMTPSA id c16sm29465pfc.112.2021.04.08.09.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 09:50:31 -0700 (PDT)
Subject: Re: [PATCH -next] RDMA/srpt: Fix error return code in
 srpt_cm_req_recv()
To:     Wang Wensheng <wangwensheng4@huawei.com>, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rui.xiang@huawei.com
References: <20210408113132.87250-1-wangwensheng4@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <241d391f-2f18-18e5-9e3f-3cf214a30b38@acm.org>
Date:   Thu, 8 Apr 2021 09:50:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210408113132.87250-1-wangwensheng4@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/8/21 4:31 AM, Wang Wensheng wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: db7683d7deb2 ("IB/srpt: Fix login-related race conditions")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 98a393d..ea44780 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -2382,6 +2382,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>  		pr_info("rejected SRP_LOGIN_REQ because target %s_%d is not enabled\n",
>  			dev_name(&sdev->device->dev), port_num);
>  		mutex_unlock(&sport->mutex);
> +		ret = -EINVAL;
>  		goto reject;
>  	}

Please fix the Hulk Robot. The following code occurs three lines above
the modified code:

	ret = -EINVAL;

Thanks,

Bart.
