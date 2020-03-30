Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E89E198754
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2020 00:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgC3WZs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Mar 2020 18:25:48 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55476 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729210AbgC3WZs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Mar 2020 18:25:48 -0400
Received: by mail-pj1-f66.google.com with SMTP id fh8so220046pjb.5;
        Mon, 30 Mar 2020 15:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=B2B0r1/+Ux0t+iEA8u3ZfCCWx36jhaWBWl29Sjd9+HA=;
        b=VYpj9njXVLaTdHIJ++zvB6v3M6HujeECuJ60x8OF7Oy4yACN5qu4L0KMnPoe39zJ0I
         QmfAygyk1/EiU1/rCkrCMT3UgvXp+Ps4HLQwI9hup6+rsyBwdD/y/wZkqW+p65a4CrOP
         KtUDwFP7nD5H2bcdAFcmG/+x/lJ2vWGG/gfIZ+WJi+QKFZInIRA1KVAjpo57QJnZfv3W
         UU6iBgLrNr35zpGo9X5l1KR78CPaUssZXlATBf9z0TKndpuLYzSiyYQicTNQ/Dg3csUg
         XO+3CT3xsZlGYvKAA94chvsAlDW/eXnw/OReVxZ4h0z1J3v/IwtNC8QcXi0VvC3xZZbo
         8a8g==
X-Gm-Message-State: AGi0PuZq9cZ1sCT0dN6C3b+wt8fF8SYVmK1SlxPLiatAG3VhMWfqOFMf
        wX0GWbbtZqCTaSFwxPlNuIM=
X-Google-Smtp-Source: APiQypKG1Up7hkApHThiU4C0diAb5nueY4DIoEtHoO0BOaYAaBmBOSCOli1Fn7fFWZuAitcnNUwGQQ==
X-Received: by 2002:a17:90a:7784:: with SMTP id v4mr373548pjk.30.1585607145816;
        Mon, 30 Mar 2020 15:25:45 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:5408:f41a:5985:3059? ([2601:647:4000:d7:5408:f41a:5985:3059])
        by smtp.gmail.com with ESMTPSA id na18sm460140pjb.31.2020.03.30.15.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 15:25:44 -0700 (PDT)
Subject: Re: [PATCH v11 04/26] RDMA/rtrs: core: lib functions shared between
 client and server modules
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-5-jinpu.wang@cloud.ionos.com>
 <cad654ae-d6c9-882d-aeeb-d6871994d280@acm.org>
 <CAMGffE=oU=auw9Re3JcpBx2cap=6i4P0R__bcO4NnN+yW76b8w@mail.gmail.com>
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
Message-ID: <445d2545-de0e-3ca5-4a6a-97c00de6f117@acm.org>
Date:   Mon, 30 Mar 2020 15:25:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAMGffE=oU=auw9Re3JcpBx2cap=6i4P0R__bcO4NnN+yW76b8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-03-30 03:34, Jinpu Wang wrote:
> On Sat, Mar 28, 2020 at 5:26 AM Bart Van Assche <bvanassche@acm.org> wrote:
>> On 2020-03-20 05:16, Jack Wang wrote:
>>> +/**
>>> + * rtrs_addr_to_sockaddr() - convert path string "src,dst" to sockaddreses
>>> + * @str:     string containing source and destination addr of a path
>>> + *           separated by comma. I.e. "ip:1.1.1.1,ip:1.1.1.2". If str
>>> + *           contains only one address it's considered to be destination.
>>> + * @len:     string length
>>> + * @port:    will be set to port.
>>                 ^^^^^^^^^^^^^^^^^^^
>> What does this mean? Please make comments easy to comprehend.
> how about just "port number"?

I don't think that's enough information. How about "destination port
number"?

Thanks,

Bart.
