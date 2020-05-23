Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DC61DF7FF
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2020 17:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387883AbgEWPWX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 23 May 2020 11:22:23 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38515 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387815AbgEWPWX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 23 May 2020 11:22:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id m7so5611852plt.5
        for <linux-rdma@vger.kernel.org>; Sat, 23 May 2020 08:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tdwIt/BFmJUbrMiasWZORHBkmACx1u1seyMonBKqKOc=;
        b=J4tnSqOQOWk3fXBdAVojZ+kuEQ+ak24fzlPPrW6ABvMlcGjGo6GuVKhHav8IgnqByM
         07kt0PNssk2DiPPoE69pYnyyKEkBpw1DWIo/t66gk49NUz6hWftRtOzzosMyRrk/4tac
         SWPVqN4yUU4kDq5O/Q0FdsKLUsXmm4uZMxMhXyncC8dUaq+y4HiwuIc2dE3m0A7e5v+/
         /3CBkVa5KmeUFA5u7ZQRlfHjjSK0B1jPBcK//Og1ns8NCzYIPh8b1lopamxgVxA5TDHF
         0wc8lq/uodo1ClqMPa5s1dhF9JbO22HHOy1ybC5QP2pjscTCWuGZknBXSGRPr2bvi40h
         JT0g==
X-Gm-Message-State: AOAM531I+AsCKF4MZ98veHdTW0/9RXUpnWMzplY7xpOIfj1cGi5uuyuI
        4NgnZFzEs2AUrtv8OjEDUnA=
X-Google-Smtp-Source: ABdhPJwoATW2olKvWhSwtSx5CfnWz+R/J7dSmyMR4UXVLJt29Uac2O6PLviwmpjvvFUrva/nwuFgjg==
X-Received: by 2002:a17:90a:db0c:: with SMTP id g12mr10712832pjv.5.1590247341376;
        Sat, 23 May 2020 08:22:21 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:e001:10c:9a49:9da9? ([2601:647:4000:d7:e001:10c:9a49:9da9])
        by smtp.gmail.com with ESMTPSA id w12sm9245593pjy.15.2020.05.23.08.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2020 08:22:20 -0700 (PDT)
Subject: Re: [PATCH 1/4] RDMA/srp: Make the channel count configurable per
 target
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org, Laurence Oberman <loberman@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>
References: <20200522213341.16341-1-bvanassche@acm.org>
 <20200522213341.16341-2-bvanassche@acm.org> <20200523135523.GA569407@unreal>
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
Message-ID: <3fc10293-d65b-fee3-ad5c-833323516e96@acm.org>
Date:   Sat, 23 May 2020 08:22:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200523135523.GA569407@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-05-23 06:55, Leon Romanovsky wrote:
> On Fri, May 22, 2020 at 02:33:38PM -0700, Bart Van Assche wrote:
>> Increase the flexibility of the SRP initiator driver by making the channel
>> count configurable per target instead of only providing a kernel module
>> parameter for configuring the channel count.
>>
>> Cc: Laurence Oberman <loberman@redhat.com>
>> Cc: Kamal Heib <kamalheib1@gmail.com>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>  drivers/infiniband/ulp/srp/ib_srp.c | 21 ++++++++++++++++-----
>>  1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
>> index 00b4f88b113e..d686c39710c0 100644
>> --- a/drivers/infiniband/ulp/srp/ib_srp.c
>> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
>> @@ -3424,6 +3424,7 @@ enum {
>>  	SRP_OPT_IP_DEST		= 1 << 16,
>>  	SRP_OPT_TARGET_CAN_QUEUE= 1 << 17,
>>  	SRP_OPT_MAX_IT_IU_SIZE  = 1 << 18,
>> +	SRP_OPT_CH_COUNT	= 1 << 19,
>>  };
>>
>>  static unsigned int srp_opt_mandatory[] = {
>> @@ -3457,6 +3458,7 @@ static const match_table_t srp_opt_tokens = {
>>  	{ SRP_OPT_IP_SRC,		"src=%s"		},
>>  	{ SRP_OPT_IP_DEST,		"dest=%s"		},
>>  	{ SRP_OPT_MAX_IT_IU_SIZE,	"max_it_iu_size=%d"	},
>> +	{ SRP_OPT_CH_COUNT,		"ch_count=%d",		},
> 
> Why did you use %d and not %u?

Hi Leon,

There is more kernel code that uses %d for unsigned integers. Anyway, if
someone cares enough I can change %d into %u.

Bart.
