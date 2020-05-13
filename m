Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC6D1D194F
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 17:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732408AbgEMPZo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 11:25:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44288 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732383AbgEMPZo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 May 2020 11:25:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id x13so2240138pfn.11
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 08:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZqThxTfH9MdgUBsESWhA9ORDZgw8BFyezfAiWQaIKtM=;
        b=UOmtFjce7p0TmS6TRvxKMYsurcnqTw3HS5MSAyQ4PrN2hCWJa7u/ixJJeF7SAqWrH4
         0rZdy7uFmOfBV2h+4E6/TEruIgVSk9k09CHyvQc2mHmRe2gghgcc8Pzn3O1xz9rgu4cI
         TIChWqtYGqBtHW0HH0iKwyGEyYonYtUSTVptPsql0OGzg5cATie4lHTNjX326BjzjykB
         h3Zw99FqOl81dB7XpsOKDMXdy2tLD9hse8+2S4+VOT4u4D+6HuRriI5SwYMG3bBRcF5+
         l5BWGPjSjrX5KAuSuomlH1CuLpOt6HFuyKPtTPKMmpX0FFJgNhDuwZZB/MgugjvZwi8e
         TRGA==
X-Gm-Message-State: AOAM532rp0AHT/y3RgOHvaHwb7ITs7dh1Q4jRFF5G/GLzsguKfxW4yHK
        3FZL22JtHq3p0SuWg+Gc32A=
X-Google-Smtp-Source: ABdhPJwQHrscBp0iwNvbWd7tFUnCgzu+QQGbqVhPp2+nt4Wh9fIvJmldW81azXnu0vwik9FCETGh+A==
X-Received: by 2002:a62:77d1:: with SMTP id s200mr2962324pfc.128.1589383543209;
        Wed, 13 May 2020 08:25:43 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:e13e:45d5:70d9:c74e? ([2601:647:4000:d7:e13e:45d5:70d9:c74e])
        by smtp.gmail.com with ESMTPSA id gd17sm15747519pjb.21.2020.05.13.08.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 08:25:42 -0700 (PDT)
Subject: Re: [PATCH for-rc] RDMA/srpt: Fix disabling device management
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kamal Heib <kamalheib1@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
References: <20200511222918.62576-1-kamalheib1@gmail.com>
 <20200513072203.GR4814@unreal> <20200513100204.GA92901@kheib-workstation>
 <20200513102132.GW4814@unreal> <20200513104536.GA120318@kheib-workstation>
 <20200513105045.GX4814@unreal> <20200513111435.GA121070@kheib-workstation>
 <20200513113118.GY4814@unreal> <20200513123837.GA123854@kheib-workstation>
 <20200513124334.GA29989@ziepe.ca>
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
Message-ID: <d3e729d7-97c0-607c-b1b3-80a2df47cbae@acm.org>
Date:   Wed, 13 May 2020 08:25:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513124334.GA29989@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-05-13 05:43, Jason Gunthorpe wrote:
> On Wed, May 13, 2020 at 03:38:37PM +0300, Kamal Heib wrote:
>>>> Correct me if I'm wrong, Do you mean check the return value from
>>>> rdma_cap_ib_mad()?
>>>
>>> I think so.
>>>
>>> Thanks
>>
>> Well, this function will not help in the case of VFs, because the flag
>> that is checked in rdma_cap_ib_mad() is RDMA_CORE_CAP_IB_MAD which is
>> set almost for each create IB device as part of RDMA_CORE_PORT_IBA_IB or
>> RDMA_CORE_PORT_IBA_ROCE or RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP.
> 
> AFAIK this case only happens for mlx4 devices that use the GUID table
> to emulate virtual IB ports. In this case there is no bit to control.
> 
> I didn't quite understand why srpt has this stuff, does it mean it is
> broken on mlx4 vports? Why allow the failure?

The commit message of the code that introduced the most recent
IB_PORT_DEVICE_MGMT_SUP changes is as follows:

-----------------------------------------------------------------------
commit 09f8a1486dcaf69753961a6df6cffdaafc5ccbcb
Author: Bart Van Assche <bvanassche@acm.org>
Date:   Mon Sep 30 16:17:01 2019 -0700

RDMA/srpt: Fix handling of SR-IOV and iWARP ports

Management datagrams (MADs) are not supported by SR-IOV VFs nor by iWARP
ports. Support SR-IOV VFs and iWARP ports by only logging an error
message if MAD handler registration fails.
-----------------------------------------------------------------------

In other words, on my setup the ib_srpt driver was working find with SR-IOV.

Bart.
