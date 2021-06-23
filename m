Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573373B2298
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jun 2021 23:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhFWVmC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Jun 2021 17:42:02 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:42704 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhFWVmC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Jun 2021 17:42:02 -0400
Received: by mail-wr1-f45.google.com with SMTP id j1so4221735wrn.9
        for <linux-rdma@vger.kernel.org>; Wed, 23 Jun 2021 14:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wkW+1IRsoOV7dgCGp7KoNHFH+4Rdb/xRTBr2VLOih/4=;
        b=DBm3SL9HUsZe27LvgRvmfdv1siVxS/0zHFEqbgLoQRYPihkA7cEd1ps5IG4eFipdNi
         mucLq84hyqyAY33p5/CKThHXuhtL3tyfmVSdOdWFp/pf1GoJjRTRG9aWOc8ZxXTYGAgR
         n3+9Q0qSikh2wKsXq6ceNakXgP1UBFYuwNVaufsjbWot9slXJgTMjamPq6mnC22kUEei
         XZyV3/PofCEXPsIMsarSXY6jOldFx3IO1qxILOT2wHOWjCUCrFIM4KMdyvP4nvXOMmAV
         k+rGi58l4ag4yVGJuByvjfi2POrct4BIl+DZiGaENjwqFV3ATPNEN5JWx6M4usyEwCNl
         dzTw==
X-Gm-Message-State: AOAM530d6rDP5BNZr4TN9oDvOnPha8lWQfgGZrn9NimmwhGVfBFX/Vfg
        BLNQG9W/ksR/XcRn07JiDqo=
X-Google-Smtp-Source: ABdhPJz9FrlhauHxL5K9AGdJLvDUmmNNs69vqJ1nYU2cwlE/kdTKPJwMVeu8/6VWkpJSNgS0C4VOHA==
X-Received: by 2002:a5d:5401:: with SMTP id g1mr192907wrv.373.1624484383409;
        Wed, 23 Jun 2021 14:39:43 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d7a5:9de1:faa6:69b7? ([2601:647:4802:9070:d7a5:9de1:faa6:69b7])
        by smtp.gmail.com with ESMTPSA id k13sm1128876wrp.73.2021.06.23.14.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 14:39:42 -0700 (PDT)
Subject: Re: [PATCH 1/1] IB/isert: align target max I/O size to initiator size
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, Kamal Heib <kheib@redhat.com>
Cc:     israelr@nvidia.com, alaa@nvidia.com, linux-rdma@vger.kernel.org,
        jgg@nvidia.com
References: <20210524085215.29005-1-mgurtovoy@nvidia.com>
 <46c4d30d-510d-b329-4793-8a354642632e@grimberg.me>
 <fdef3991-74e1-63f1-593e-ac2018286ae9@nvidia.com>
 <b62e5d29-025a-0827-ecad-a48812114220@redhat.com>
 <e6623d9e-0122-ea0c-e148-f739bd15b0bb@nvidia.com>
 <0e4f17d0-5237-e9ae-44a0-4891a53bb26a@grimberg.me>
 <2237ccdf-e2b0-aab3-6e3f-297e5b7791a1@nvidia.com>
 <82ef613c-2697-261e-317e-b40d09cf0764@redhat.com>
 <90153fcc-8ed5-6ad5-0539-bcf97d8e0ce3@nvidia.com>
 <d6e2f70a-1885-9cc3-f82c-0c0abeca2c7d@grimberg.me>
 <ba0b44fa-c93b-34fa-41c0-8bd492cda92e@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4d503c23-506f-6e49-8b48-48426de6a239@grimberg.me>
Date:   Wed, 23 Jun 2021 14:39:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <ba0b44fa-c93b-34fa-41c0-8bd492cda92e@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>>> Well, from the distro's point of view this code is not going to be 
>>>> dead any time
>>>> soon..., And the current user experience is very bad, Could you guys 
>>>> please
>>>> decide on a way to fix this issue?
>>>
>>> As mention above, I prefer the simple solution for this issue.
>>>
>>> I guess the most of iSER users are using pretty old HW so defaults 
>>> should be accordingly.
>>>
>>> For NVMe/RDMA this is a different story and we can use higher defaults
>>>
>>> Adding fallbacks will complicate the code without a real 
>>> justification for doing it.
>>
>> Usually when you end up changing the defaults multiple times it should
>> be an indication that it should do something about it.
>>
>> But hey, if you are killing Connect-IB anyways, and you don't see any
>> sort of regressions from this I don't really have a problem with it.
> 
> I don't know why you conclude it from the above.
> 
> I just want to change the defaults to what we had in the past. This will 
> help OOB for old devices. We did the same for Chelsio.
> 
> And we see that RH team is also interested in it.

I'm fine with this.
Acked-by: Sagi Grimberg <sagi@grimberg.me>
