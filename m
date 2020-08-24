Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A031A25033A
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 18:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgHXQlf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 12:41:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45478 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbgHXQlR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 12:41:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id 67so1709424pgd.12
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 09:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lSMXvGoT0B1yunMOAt+Wc0hpWxRxvqLWGnQ1q2lf7Tg=;
        b=Brxtwt5lkqOpL2dNAFF1B7qZoOwKlAvvBI/P4f/VouBN4JTq9w/W9boMu1B8rCbsJj
         Q5GcIPknPbTf2kVFjNZm6GpWxrM6iM1j1wF5FutTLQ8c6W1fekjHwpuO1nvv5oFR0vx1
         UO/YUf5s1ZHv/56kjEQarJYihefvml2YOF/de6SepJi6rUYTN9G3xnbOWt3f7uZeivS7
         VYKjjND9mQAZF6Ec208+45UAf9n7NVVHBDWVlMbC9DoSTI71UrziupaIwsgXf8cK537X
         SehpsiHYh114hkZge+6ZkRRTFbs9tsDy4FDtWV2DYNseXNMfFQhXXCByywjs/5dye7LL
         29DA==
X-Gm-Message-State: AOAM5331d7URJ33/GW2RoJcTYh2n2x9UCuwks+jPxH9YNxlLP0qKF6tl
        TWjcSffaGMQfZVLoNyYwmhg9H1GlDnI=
X-Google-Smtp-Source: ABdhPJyNVQZUoIyYfoyqBF0yT7ftfNPmlud5N0+6LOa0scaMS8jvbDiftfh+alSU6HdKbXmaAqyvDQ==
X-Received: by 2002:a63:db50:: with SMTP id x16mr3921876pgi.66.1598287276714;
        Mon, 24 Aug 2020 09:41:16 -0700 (PDT)
Received: from [192.168.50.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id s10sm62068pjl.37.2020.08.24.09.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 09:41:15 -0700 (PDT)
Subject: Re: [PATCH v3 for-rc] RDMA/rxe: Fix panic when calling
 kmem_cache_create()
To:     Kamal Heib <kamalheib1@gmail.com>, linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Zhu Yanjun <yanjunz@nvidia.com>
References: <20200824155220.153854-1-kamalheib1@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ee809280-48d2-a5cc-c1a1-521ba58636b1@acm.org>
Date:   Mon, 24 Aug 2020 09:41:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824155220.153854-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/24/20 8:52 AM, Kamal Heib wrote:
> +bool rxe_is_loaded;

The name of this variable seems wrong to me. My understanding is that rxe_module_init() is
called whether or not rxe has been built as a module. Consider renaming this variable into
e.g. "rxe_initialized".

> diff --git a/drivers/infiniband/sw/rxe/rxe_sysfs.c b/drivers/infiniband/sw/rxe/rxe_sysfs.c
> index ccda5f5a3bc0..12c7ca0764d5 100644
> --- a/drivers/infiniband/sw/rxe/rxe_sysfs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_sysfs.c
> @@ -61,6 +61,11 @@ static int rxe_param_set_add(const char *val, const struct kernel_param *kp)
>   	struct net_device *ndev;
>   	struct rxe_dev *exists;
>   
> +	if (!rxe_is_loaded) {
> +		pr_err("Please make sure to load the rdma_rxe module first\n");
> +		return -EINVAL;
> +	}
> +
>   	len = sanitize_arg(val, intf, sizeof(intf));
>   	if (!len) {
>   		pr_err("add: invalid interface name\n");

The above message is misleading. Consider changing it into e.g. the following:

     Please wait until initialization of the rdma_rxe module has finished.

Additionally, how about returning -EAGAIN instead of -EINVAL?

Thanks,

Bart.


