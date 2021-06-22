Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B29A3AFFAC
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 10:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhFVI6c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 04:58:32 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:46058 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVI6c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Jun 2021 04:58:32 -0400
Received: by mail-wr1-f47.google.com with SMTP id j2so12126291wrs.12
        for <linux-rdma@vger.kernel.org>; Tue, 22 Jun 2021 01:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IxVzckRaLMZJNBjq5hS6C7X8AGvw284jGQ/ViJNCxJA=;
        b=aHlSpuR20XimYvRN26jqMRkmQMyYEdCIb/+t13A0bKtGu/8fCrRLiUeIcLQiEUGY/M
         ZpIV7bpnQY+5sT+54/kbMmkfuOhYfLXbPlc1PThEoihOl+ACNNBIoMDRmxy2eqvOnWQk
         v+hufeb4qaqbyWwyBWu0sySsgjgd1LiAKybypCudg1JfY9Xk+FZLsxYAXysNfiNIct8P
         mhrc38OKYfHZWtWqia1qGwpu1PpjArZOb/Z/w70zj6UmGvTnF1Gr4TyoQ+DhM+mUIrC6
         i6ysc+445dtOwj5sPHat7E8l2B6adgh4YFY2Aiy4bUqMxQf9P7pk525b03N9vlQEAWB0
         iDSw==
X-Gm-Message-State: AOAM531O3Dkd4VjEzR8fk92qA2apc8+2WbhslDD6tTgEoPYRg6c36G7G
        Br6uFy42LGXY6LFpkMdOfqI=
X-Google-Smtp-Source: ABdhPJyU2yNf1VGA6jY9O5q5L8vOQzsUZzCvY1PjdzZAOfVpa9WOnY7jzIKDOYv0T39DQ/301n8axw==
X-Received: by 2002:a5d:5010:: with SMTP id e16mr3420300wrt.54.1624352175033;
        Tue, 22 Jun 2021 01:56:15 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:a450:8917:2b92:33b7? ([2601:647:4802:9070:a450:8917:2b92:33b7])
        by smtp.gmail.com with ESMTPSA id l10sm19849181wrs.11.2021.06.22.01.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 01:56:14 -0700 (PDT)
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
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d6e2f70a-1885-9cc3-f82c-0c0abeca2c7d@grimberg.me>
Date:   Tue, 22 Jun 2021 01:56:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <90153fcc-8ed5-6ad5-0539-bcf97d8e0ce3@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> Well, from the distro's point of view this code is not going to be 
>> dead any time
>> soon..., And the current user experience is very bad, Could you guys 
>> please
>> decide on a way to fix this issue?
> 
> As mention above, I prefer the simple solution for this issue.
> 
> I guess the most of iSER users are using pretty old HW so defaults 
> should be accordingly.
> 
> For NVMe/RDMA this is a different story and we can use higher defaults
> 
> Adding fallbacks will complicate the code without a real justification 
> for doing it.

Usually when you end up changing the defaults multiple times it should
be an indication that it should do something about it.

But hey, if you are killing Connect-IB anyways, and you don't see any
sort of regressions from this I don't really have a problem with it.
