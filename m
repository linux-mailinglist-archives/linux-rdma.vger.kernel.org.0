Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE9D176F03
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2020 06:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgCCF5W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Mar 2020 00:57:22 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52095 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgCCF5W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Mar 2020 00:57:22 -0500
Received: by mail-pj1-f67.google.com with SMTP id l8so858112pjy.1;
        Mon, 02 Mar 2020 21:57:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yo+dRABTent3gLV01eNpbbUuwD5LriWTxo0eVCxvitI=;
        b=bYdYb+fOmZungJVGXjhM9Igk6TLCVJm1RKob39vvvMvpnBmTsT8aZXAJ7COGJxGHfC
         WMInzof4uBn1wVSZTSgtfUI9NL3ksfCliSviz+etQ4FU1aml8aoTdacKCQmTHSyXPRJg
         6YHRQWbhALPEUdnPqnT1Bwz3je+4JjHSJCqiVrSS5hnwYnP/0u9MbNK1KHbLFGYYhjPZ
         BqNTVywRDyonErL5KVR4koZv40PB7GSFWOkmRA2nB9kNExECeNUAqg9ej00kFVO66v4p
         3FADuT/HQx/6HcJz/9VLcTmS6vWZtPUa5E/zx+TjAIifen/eoQra/AR/4TgAWzVYJrot
         KRBw==
X-Gm-Message-State: ANhLgQ1vZFskPosf1cwiUtlTFr3X4uw0pnSnPQev0BqfkXrdJ4IUb7Bh
        tXPoH/IzDnp/kjocL/d4yTc=
X-Google-Smtp-Source: ADFU+vuLo+fbJdzafAO81GBOO8Np+dvuSM0iWkucvcFxJeUnfaS5noqjbikr/TtXpSYc5OnHV4txYQ==
X-Received: by 2002:a17:90a:230d:: with SMTP id f13mr2307642pje.128.1583215041029;
        Mon, 02 Mar 2020 21:57:21 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:5909:8e52:fd69:e98d? ([2601:647:4000:d7:5909:8e52:fd69:e98d])
        by smtp.gmail.com with ESMTPSA id b15sm22930323pft.58.2020.03.02.21.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 21:57:19 -0800 (PST)
Subject: Re: [PATCH v9 20/25] block/rnbd: server: main functionality
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
References: <20200221104721.350-1-jinpuwang@gmail.com>
 <20200221104721.350-21-jinpuwang@gmail.com>
 <33864f54-62af-cb5f-45fa-55a283dcd434@acm.org>
 <CAHg0HuwvdYNB=C4yi4_tXeOWkj9rjTsV0B59Ea+_axLAuZ98Zg@mail.gmail.com>
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
Message-ID: <a44246c5-bfc0-a95c-eeb8-8183fc858574@acm.org>
Date:   Mon, 2 Mar 2020 21:57:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHg0HuwvdYNB=C4yi4_tXeOWkj9rjTsV0B59Ea+_axLAuZ98Zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-03-02 01:58, Danil Kipnis wrote:
> On Sun, Mar 1, 2020 at 3:58 AM Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> On 2020-02-21 02:47, Jack Wang wrote:
>>> +static int dev_search_path_set(const char *val, const struct kernel_param *kp)
>>> +{
>>> +     char *dup;
>>> +
>>> +     if (strlen(val) >= sizeof(dev_search_path))
>>> +             return -EINVAL;
>>> +
>>> +     dup = kstrdup(val, GFP_KERNEL);
>>> +
>>> +     if (dup[strlen(dup) - 1] == '\n')
>>> +             dup[strlen(dup) - 1] = '\0';
>>> +
>>> +     strlcpy(dev_search_path, dup, sizeof(dev_search_path));
>>> +
>>> +     kfree(dup);
>>> +     pr_info("dev_search_path changed to '%s'\n", dev_search_path);
>>> +
>>> +     return 0;
>>> +}
>>
>> It is not necessary in this function to do memory allocation. Something
>> like the following (untested) code should be sufficient:
>>
>>         const char *p = strrchr(val, '\n') ? : val + strlen(val);
>>
>>         snprintf(dev_search_path, sizeof(dev_search_path), "%.*s",
>>                 (int)(p - val), val);
>>
>> How are concurrent attempts to change dev_search_path serialized?
>>
> Hi Bart,
> 
> thanks a lot for your comments. Will try to avoid the allocation. The
> module parameter is readonly. It's only set during module init - I
> guess we don't need to handle concurrent access?

Right, if this function is only called during module init there is no
need to worry about concurrency.

Bart.
