Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304ED351F63
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 21:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbhDATP4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 15:15:56 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:43839 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbhDATNK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Apr 2021 15:13:10 -0400
Received: by mail-pg1-f172.google.com with SMTP id p12so2159693pgj.10;
        Thu, 01 Apr 2021 12:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6nikUHdC4KYpFBUCD+BpsVYV/5+RzIVusJ8v82wFnsM=;
        b=Tm/B5EJUcnOt025tjWQIwg+cSetREg2Hxwk13g+aYZE4pgbBFMq5m3RQNPm9NMieO4
         eA74SiXgdnCLC2qfsYxEekcBcc0JAspTYfM4TRZpdBS9HcG4ovAQrSp7+45KaIUYLp1l
         5PX44eE51oK3WW2nF9WOV3KwZBqYhI9mjIhD7lqlOcfGBcZYLxdCHGmxAFFlW8z6Iq+0
         imqmSzpUTYixQi5lxa5C92EMhDZl6lZDw6T5np4xTdTbBkuDY4EXxIK2WXrP/SK5q0aR
         /3ev1tW+UwC8RbX7CW9FXnhCUoPtopSG8sV/2Vn4a3ka8GFwB2ihyzXmN9rnKO5lyoHG
         SVJA==
X-Gm-Message-State: AOAM533mAvoXiRyMMtdFQZ4qeJEdO7B3fxXJtyhPgl7XQnOzHdlUcRA6
        rGrSn0t8sT4FI8x3YAgWtKA+a552PtI=
X-Google-Smtp-Source: ABdhPJzCxDGaSf2tNozh/q3faFUNNh/3qhwiuJp07xQ71f6eN2FEIzknAjYAg1mTxIaQh4dawyhqGg==
X-Received: by 2002:a62:ac1a:0:b029:1f9:5ca4:dd4d with SMTP id v26-20020a62ac1a0000b02901f95ca4dd4dmr8813587pfe.68.1617304387662;
        Thu, 01 Apr 2021 12:13:07 -0700 (PDT)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id k3sm5933235pgq.21.2021.04.01.12.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 12:13:07 -0700 (PDT)
Subject: Re: [PATCH -next] IB/srpt: Fix passing zero to 'PTR_ERR'
To:     YueHaibing <yuehaibing@huawei.com>, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210324140939.7480-1-yuehaibing@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <232b1dc3-ffac-4466-fc58-704fef87ce67@acm.org>
Date:   Thu, 1 Apr 2021 12:13:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210324140939.7480-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/24/21 7:09 AM, YueHaibing wrote:
> Fix smatch warning:
> 
> drivers/infiniband/ulp/srpt/ib_srpt.c:2341 srpt_cm_req_recv() warn: passing zero to 'PTR_ERR'
> 
> Use PTR_ERR_OR_ZERO instead of PTR_ERR
> 
> Fixes: 847462de3a0a ("IB/srpt: Fix srpt_cm_req_recv() error path (1/2)")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/infiniband/ulp/srpt/ib_srpt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 6be60aa5ffe2..3ff24b5048ac 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -2338,7 +2338,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>   
>   	if (IS_ERR_OR_NULL(ch->sess)) {
>   		WARN_ON_ONCE(ch->sess == NULL);
> -		ret = PTR_ERR(ch->sess);
> +		ret = PTR_ERR_OR_ZERO(ch->sess);
>   		ch->sess = NULL;
>   		pr_info("Rejected login for initiator %s: ret = %d.\n",
>   			ch->sess_name, ret);

(just noticed this patch)

target_setup_session() should either return a valid session pointer or 
an ERR_PTR() but not NULL. Changing IS_ERR_OR_NULL() into IS_ERR() and 
removing the WARN_ON_ONCE(ch->sess == NULL) may be a better solution.

Thanks,

Bart.
