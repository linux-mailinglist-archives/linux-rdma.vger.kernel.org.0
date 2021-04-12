Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC74735D093
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Apr 2021 20:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236591AbhDLSsC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Apr 2021 14:48:02 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:34801 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhDLSsA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Apr 2021 14:48:00 -0400
Received: by mail-pf1-f170.google.com with SMTP id 10so893623pfl.1;
        Mon, 12 Apr 2021 11:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q599cja+Cm2p8IjuDqpqW0IPdWPwNsRlxkwQHrgh1MA=;
        b=hCpIHKPZ5do5VvAIUtHsG9nkoeD7mrHdDa94Nm961GrUGtJKfQnuSS34K56eaEgRMh
         7t1ArRm3/mJLRB6vystiuPsevsJC9alVUX5WB/lQuUwZlyp85BoY4M3tTbrT8wV2q0zZ
         jG879WPSMfnlJbMbXtkGb87sXzaXpsIHt2QKcmwQk6/BbqhFaOmqsaUTCOSQQzKa841M
         JRB8uKneAPVAmOsqoa1ah/3kjT4zgGauJOnGk2pLqZpHhFIN8FjksgVq8scdmI7ixjon
         A9iBM8uI46Q0W+lckh7x/pvU7MDbZFKal7lENYraE9QFfCks1Mw2gaOXjk8qW5bmJ47q
         favw==
X-Gm-Message-State: AOAM533XuoYEUgAw3Y93DzKioXdnDgUh58d3Sz9/oSkrnX50J6b9epz9
        nUD8f6Ql8FfXlklXOg6i31k=
X-Google-Smtp-Source: ABdhPJznUrpHK9RXg0eWDQqSicAVbqu8qXb5R6qeueXo/VksaCLHsUDpB2rBiCeSb7swT9uTqS9oTw==
X-Received: by 2002:a62:2cce:0:b029:21d:97da:833e with SMTP id s197-20020a622cce0000b029021d97da833emr25278871pfs.40.1618253262322;
        Mon, 12 Apr 2021 11:47:42 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:5f68:b2bd:8704:6a68? ([2601:647:4000:d7:5f68:b2bd:8704:6a68])
        by smtp.gmail.com with ESMTPSA id i7sm12112158pgq.16.2021.04.12.11.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 11:47:41 -0700 (PDT)
Subject: Re: [PATCH -next] RDMA/srpt: Fix error return code in
 srpt_cm_req_recv()
To:     Wang Wensheng <wangwensheng4@huawei.com>, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rui.xiang@huawei.com
References: <20210408113132.87250-1-wangwensheng4@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <cdb4321e-99cd-2ca3-fd6e-e273c5000165@acm.org>
Date:   Mon, 12 Apr 2021 11:47:40 -0700
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

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
