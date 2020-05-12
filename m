Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24D71CFF33
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 22:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgELU1V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 16:27:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35132 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgELU1V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 May 2020 16:27:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id r14so6934108pfg.2
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 13:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hX5F+R/puhg774wGMiXxAn15A7PpCw7WEEA42SKx4hI=;
        b=sNYkz1HO09VhLxEiPaPa9J56UVQBgFaNnn+DfCyZvIN9vePRqJFs32KIg2LqaGZKDL
         om3qiaUdeTgv+rg5jotF/6y+FTJsVD5ijzKWjk1yKcMMYeOdYFwR49plJYvPGoG/dRFd
         7B0Pp9dCu3fgXR8KHOFLIJNYeqo5ucWVnmcmuRFz5RyP5y/1/emDhmvDl+nRHr9EwPTb
         5AnArvUlu9pTtNsfXH42Xh+IGdJsSbbaboyErZ//nwMVUpWpb+3wV1RX+JKF4wOZGplt
         pOft6nqGJFGsH6DHzspQic+gjdmRAFJRheWcvkDdDXVJaPiq22Ntnmps/eg7LeArMdRI
         hNrA==
X-Gm-Message-State: AOAM532ui0wZcn6+hUNwtbwNfHuqVvr+KODK8nkkogkI5IIH91Q3T21p
        lgEi3RfrxZkG6e43bbEc9E0=
X-Google-Smtp-Source: ABdhPJwVuOEoM9JX4TbTJ7BmydrGzM5JlvatXP7YaywbDY0fEu6LpqImaqqkJESibeSGqU4fLDJnMA==
X-Received: by 2002:a63:9255:: with SMTP id s21mr12147974pgn.363.1589315240171;
        Tue, 12 May 2020 13:27:20 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:c1b6:f086:b604:b4dc? ([2601:647:4000:d7:c1b6:f086:b604:b4dc])
        by smtp.gmail.com with ESMTPSA id 6sm12618155pfj.123.2020.05.12.13.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 13:27:19 -0700 (PDT)
Subject: Re: [PATCH] IB/iser: Remove support for FMR memory registration
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Israel Rukshin <israelr@mellanox.com>, sagi@grimberg.me,
        linux-rdma@vger.kernel.org, dledford@redhat.com, maxg@mellanox.com,
        sergeygo@mellanox.com, Chuck Lever <chuck.lever@oracle.com>
References: <1589299739-16570-1-git-send-email-israelr@mellanox.com>
 <20200512171633.GO4814@unreal> <5b8b0b51-83e3-06c2-9b99-dec0862c0e5b@acm.org>
 <20200512201303.GA19158@mellanox.com>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <98a0d1aa-6364-a2f1-37f6-9c69e1efaa0b@acm.org>
Date:   Tue, 12 May 2020 13:27:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512201303.GA19158@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-05-12 13:13, Jason Gunthorpe wrote:
> On Tue, May 12, 2020 at 01:09:02PM -0700, Bart Van Assche wrote:
>> On 2020-05-12 10:16, Leon Romanovsky wrote:
>>> On Tue, May 12, 2020 at 07:08:59PM +0300, Israel Rukshin wrote:
>>>> FMR is not supported on most recent RDMA devices (that use fast memory
>>>> registration mechanism). Also, FMR was recently removed from NFS/RDMA
>>>> ULP.
>>>>
>>>> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
>>>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>>>>  drivers/infiniband/ulp/iser/iscsi_iser.h     |  79 +----------
>>>>  drivers/infiniband/ulp/iser/iser_initiator.c |  19 ++-
>>>>  drivers/infiniband/ulp/iser/iser_memory.c    | 188 ++-------------------------
>>>>  drivers/infiniband/ulp/iser/iser_verbs.c     | 126 +++---------------
>>>>  4 files changed, 40 insertions(+), 372 deletions(-)
>>>
>>> Can we do an extra step and remove FMR from srp too?
>>
>> Which HCA's will be affected by removing FMR support? Or in other words,
>> when did (Mellanox) HCA's start supporting fast memory registration? I'm
>> asking this because there is a tradition in the Linux kernel not to
>> remove support for old hardware unless it is pretty sure that nobody is
>> using that hardware anymore.
> 
> We haven't entirely been following that in RDMA.. More like when
> people can't test any more it can go.
> 
> For FMR the support was dropped in newer HW so AFAIK, nobody tests
> this and it just stands in the way of making FRWR work properly.
> 
> Do the ULPs stop working or do they just run slower with some regular
> MR flow?

I'm not sure. I do not have access to RDMA adapters that do not support
FRWR.

A possible test is to check on websites for used products whether old
RDMA adapters are still available. Is the InfiniHost adapter one of the
adapters that supports FMR? It seems like that adapter is still easy to
find. See also
https://www.ebay.com/sch/i.html?_from=R40&_trksid=p2334524.m570.l1313.TR2.TRC0.A0.H0.Xmellanox+infinihost.TRS0&_nkw=mellanox+infinihost&_sacat=0&LH_TitleDesc=0&_osacat=0&_odkw=mthca+infiniband.

Thanks,

Bart.
