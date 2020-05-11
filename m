Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C531CD428
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 10:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgEKIjr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 04:39:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54944 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbgEKIjr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 May 2020 04:39:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id h4so17097828wmb.4
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2020 01:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IktNoNzYag7XQW6gtmvNtoCdXJM87ekkz7CTWjhhL4g=;
        b=Hrb7ET1Wk7UqaRo0H8Y92ECqPvmxXvNY19xsnm2LUbJ7ZCGfnUvoJzvs4zg8Tchmgw
         6X7VTBY/crSA+1+G7S3/zv9qA/6Aqy5IrAw9ebFb19Q5VBbdnspX1QQfFNcUTDFXTu99
         CCfAq28zYJz87Oi6P5s9YsHiCT1enJXi7FpofK/jsyu/kc89UgagVnPm0bLZo9345UJt
         tw2o7CmGc+SQgJXemg3Iwnr+vDJrdDZy9mRMk9R8ClS5YcLZGheNmcUd9jkYo0cReOhM
         utUJdN+ipDnpGJkgBVbn2gZLqz6EHtmjfiPqug4zsJgGPVkq+FbdjgFuDM9vRihQssGn
         7S2w==
X-Gm-Message-State: AGi0Pua2LjkrCaV5/8mFnN+gIzNXUFu+8wSM6fiDTW2AR70L+caR7DtH
        d1DJPjOKGEZwvwPnoibQ6gGsxErm
X-Google-Smtp-Source: APiQypJlHiopBZ7bKir7wtzbnyu/Om/r+9vN+++YE0TGzUWL5uZ748D8QPHedV16KKu1rTn3wyAGeA==
X-Received: by 2002:a05:600c:2109:: with SMTP id u9mr5857065wml.75.1589186386304;
        Mon, 11 May 2020 01:39:46 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:59c:65b4:1d66:e6e? ([2601:647:4802:9070:59c:65b4:1d66:e6e])
        by smtp.gmail.com with ESMTPSA id l12sm15019818wrh.20.2020.05.11.01.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 01:39:45 -0700 (PDT)
Subject: Re: [PATCH 1/4] infiniband/core: Add protection for shared CQs used
 by ULPs
To:     Leon Romanovsky <leon@kernel.org>,
        Yamin Friedman <yaminf@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>, Christoph Hellwig <hch@lst.de>,
        linux-rdma@vger.kernel.org
References: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
 <1589122557-88996-2-git-send-email-yaminf@mellanox.com>
 <20200511043753.GA356445@unreal>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <297f6c2c-b64d-9a0a-08ef-90c83a4a7c0c@grimberg.me>
Date:   Mon, 11 May 2020 01:39:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511043753.GA356445@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>
>>   static void rdma_dim_init(struct ib_cq *cq)
>> @@ -218,6 +222,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
>>   	cq->cq_context = private;
>>   	cq->poll_ctx = poll_ctx;
>>   	atomic_set(&cq->usecnt, 0);
>> +	cq->cq_type = IB_CQ_PRIVATE;
> 
> I would say it should be opposite, default is not shared CQ and only
> pool sets something specific to mark that it is shared.

Agree.


>> +int rdma_set_cq_moderation(struct ib_cq *cq, u16 cq_count, u16 cq_period)
>> +{
>> +	if (WARN_ON_ONCE(cq->cq_type != IB_CQ_PRIVATE))
>> +		return -EOPNOTSUPP;
>> +	else
>> +		return _rdma_set_cq_moderation(cq, cq_count, cq_period);
>> +}
>>   EXPORT_SYMBOL(rdma_set_cq_moderation);
>>
>> -int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>> +int rdma_set_cq_moderation_force(struct ib_cq *cq, u16 cq_count, u16 cq_period)
>> +{
>> +	return _rdma_set_cq_moderation(cq, cq_count, cq_period);
>> +}
> 
> All these one liners makes no sense, the call to
> _rdma_set_cq_moderation() in this function and above is exactly the
> same. It means there is no need in specific function.

Agree as well.
