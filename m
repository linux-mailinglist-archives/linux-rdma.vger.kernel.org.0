Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A530254A9F
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 18:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgH0QXA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 12:23:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35346 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgH0QXA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Aug 2020 12:23:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id o68so56335pfg.2
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 09:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Zko1SJUVRJBPxBYatDX3H+Goh1VCykVJBZiCrTNbFSg=;
        b=XImnHIrqDGzMjLbze/0bhbEI7e5ehCKbtNWH63Qtkyf4KlEsPPwMnPOOpwLANJCsz8
         zzJWiDv9hwx5kxxannsSfmmwGSl56XRSmNoH6PvFKVtpKj31IVVeKkiFcJXw2NzuZTgC
         MS3e8hnaWWENzpuya6sOEXcF8B2lUUqtvwCd15jJhGZjhCGCRFZRJX9xe/N9B04l0bz8
         z2BYiBvnDu+qD+8EZzWSgEeNzvlawYqmJGFEIfiqXOmu9Z1170/gWq2EB4dR7aNsXrB/
         hj4O1dLdo/SpvYWIMWZrUwXzSk+Tajb+mox6T2I+Ltftkfm9yPj33pmZKQrsKENTNebh
         I5ew==
X-Gm-Message-State: AOAM530XXfipPRU3NJaV4JB8gFD1hqI5fGWCSyyVTlAg3/RCckiNqjXY
        SARwObSMCKjTrJ9BQ7cvGC4dzmls2i8=
X-Google-Smtp-Source: ABdhPJz4jKT0doARzRmhzpTRu9lB9RDoturfq0LE3sPj1+3FO1G/vgAv9TGzHLMOiY2zq6bTNQqQIQ==
X-Received: by 2002:a65:4984:: with SMTP id r4mr4968760pgs.261.1598545379164;
        Thu, 27 Aug 2020 09:22:59 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id t33sm2845704pga.72.2020.08.27.09.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 09:22:58 -0700 (PDT)
Subject: Re: [PATCH v4 for-rc] RDMA/rxe: Fix panic when calling
 kmem_cache_create()
To:     Jason Gunthorpe <jgg@nvidia.com>, Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
References: <20200825151725.254046-1-kamalheib1@gmail.com>
 <20200827121822.GA4014126@nvidia.com>
 <20200827142955.GA406793@kheib-workstation>
 <20200827145450.GK1152540@nvidia.com>
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
Message-ID: <47468360-cd58-96fd-7d4f-4f4c351e9ce7@acm.org>
Date:   Thu, 27 Aug 2020 09:22:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200827145450.GK1152540@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-08-27 07:54, Jason Gunthorpe wrote:
> On Thu, Aug 27, 2020 at 05:29:55PM +0300, Kamal Heib wrote:
>>> Can you send a PR to rdma-core to delete rxe_cfg as well? In
>>> preperation to remove the module parameters
>>>
>>
>> Someone already did that :-)
>>
>> commit 0d2ff0e1502ebc63346bc9ffd37deb3c4fd0dbc9
>> Author: Jason Gunthorpe <jgg@ziepe.ca>
>> Date:   Tue Jan 28 15:53:07 2020 -0400
>>
>>     rxe: Remove rxe_cfg
>>
>>     This is obsoleted by iproute2's 'rdma link add' command.
>>
>>     Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> 
> Oh! Lets drop the kernel side of this in Jan 2021 then?

I think the person who wants to remove the kernel side of this is responsible
for modifying blktests such that blktests does not break. From the blktests
source code:

                modprobe rdma_rxe || return $?
                (
                        cd /sys/class/net &&
                                for i in *; do
                                        if [ -e "$i" ] && ! has_rdma_rxe "$i"; then
                                                echo "$i" > /sys/module/rdma_rxe/parameters/add ||
                                                        echo "Failed to bind the rdma_rxe driver to $i"
                                        fi
                                done
                )

Thanks,

Bart.
