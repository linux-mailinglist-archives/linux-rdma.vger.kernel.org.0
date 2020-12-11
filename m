Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E812B2D6E28
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Dec 2020 03:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391851AbgLKCgS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Dec 2020 21:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391850AbgLKCgS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Dec 2020 21:36:18 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D2CC0613CF
        for <linux-rdma@vger.kernel.org>; Thu, 10 Dec 2020 18:35:38 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id b9so10326091ejy.0
        for <linux-rdma@vger.kernel.org>; Thu, 10 Dec 2020 18:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m1Qo0HpFusYt9MAL5eH20gUZ9dNQXc9K6SGeSH33JGU=;
        b=RhVeoNe5n4NELTDFjdRq7IRvohEpUW+Ct7U/caZRv4SIPn47sJbW40NU1psmPTYKfZ
         u6NRdW17zOfvVgCs4y9P0wuuXFn6aJfvbWTV3EVFrS4LAtTKaP0wF6ljr5ngnaFGwfYK
         EVFPJ/pAp2TTTA0Qg3eLInNTHdXEmPpeyyR64DWaEYsr3m7UwRou5AUFwZP/9vMdoVn9
         R1QR64yUnct1y19kXkPIF68IY0utEncgNKcw4WmQBiZxIkZ+X1iqWmKjkwuyXi5oq4TZ
         J7K8A3cVUdPwwGXo8K425yxSsONKWY349DMnvcWITrlQTwosxkzMmLpMtp2/g/KeILrD
         e7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m1Qo0HpFusYt9MAL5eH20gUZ9dNQXc9K6SGeSH33JGU=;
        b=h3+jGXgcSwFC0uiLKuCv+BSgS6/YwGOVqbUdzjsPKG64aaVGV7XaxfzusC03ujtMJS
         K9j5gxTEBJYha7s5BeEnYoWvrqaofnb9FUmWhTr3siOy2EtimRL1iP5nKKpLBrE/MyMt
         ne0PWwGR+iRl9JQCulo/4Ohtz3VFr7IUNoMH+Ma+wyErCRjOXnRgRIUrNjRjlTqmKE3K
         /cNPNqgAZYkWKOngOd7riLamGZg4tFROAlbt1NZ78QjqfUkuGRAGEP2SaeL1Y6ik5o6X
         mpxYQdCj8EEEovRurCLJzNFK9hVZlctRSjv8pMLomwvuJSaKNGhltyYV0R2bt57UyKfp
         6T7w==
X-Gm-Message-State: AOAM532txikRgP9+ZvN5SC/XStLOTyWdZDQY5HAoL95LZITr7snbEwUG
        CTAQCCvRF9bk+w9EX3HPi/gf7A==
X-Google-Smtp-Source: ABdhPJzEM9b5sjVFsaU+VrY8Fc8YDBfwXCARLo1N/LZfwR/5sm/0+PNtTuD4waLN5bc0av+Bs4Llhw==
X-Received: by 2002:a17:906:2e82:: with SMTP id o2mr9275215eji.106.1607654136862;
        Thu, 10 Dec 2020 18:35:36 -0800 (PST)
Received: from ?IPv6:240e:82:1:36ab:f508:1adf:4d34:f89c? ([240e:82:1:36ab:f508:1adf:4d34:f89c])
        by smtp.gmail.com with ESMTPSA id qt1sm1452027ejb.115.2020.12.10.18.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 18:35:35 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: Re: [PATCH for-next 02/18] RMDA/rtrs-srv: Occasionally flush ongoing
 session closing
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>, linux-rdma@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
References: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
 <20201209164542.61387-3-jinpu.wang@cloud.ionos.com>
 <CAMGffE=_axtHU=pAV3qx5FVY2pB786z3kffQwDzinOaH=yS5Ag@mail.gmail.com>
Message-ID: <e841a2c3-2774-ca8f-302a-cd43c3b3161e@cloud.ionos.com>
Date:   Fri, 11 Dec 2020 03:33:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMGffE=_axtHU=pAV3qx5FVY2pB786z3kffQwDzinOaH=yS5Ag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 12/10/20 15:56, Jinpu Wang wrote:
> On Wed, Dec 9, 2020 at 5:45 PM Jack Wang <jinpu.wang@cloud.ionos.com> wrote:
>>
>> If there are many establishments/teardowns, we need to make sure
>> we do not consume too much system memory. Thus let on going
>> session closing to finish before accepting new connection.
>>
>> Inspired by commit 777dc82395de ("nvmet-rdma: occasionally flush ongoing controller teardown")
>> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
>> Reviewed-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> Please ignore this one, it could lead to deadlock, due to the fact
> cma_ib_req_handler is holding
> mutex_lock(&listen_id->handler_mutex) when calling into
> rtrs_rdma_connect, we call close_work which will call rdma_destroy_id,
> which
> could try to hold the same handler_mutex, so deadlock.
> 

I am wondering if nvmet-rdma has the similar issue or not, if so, maybe 
introduce a locked version of rdma_destroy_id.

Thanks,
Guoqing
