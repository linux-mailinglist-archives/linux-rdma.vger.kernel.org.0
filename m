Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D67FEE293F
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 06:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbfJXEBo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 00:01:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41603 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfJXEBo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Oct 2019 00:01:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id t3so13382544pga.8
        for <linux-rdma@vger.kernel.org>; Wed, 23 Oct 2019 21:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=k2tKAMrnRBBW2cNYq4iYvEtlu8Nro6R2nXS1Kunjsds=;
        b=tolRjBwEGtovd1u1uzY9kaV4nRsdCO6C7d5MErbg/geJQiUcuV/Z59wyiS6fs81DIG
         6WKy9QKl63kkunaRemKFF1BHdm9j498qoZg/3ehOOqJZhIEbE8UC/5fMByoZV9RIWKPm
         gmuZuHrkCIqHgi2WZZO5Msm7KkxvfYuQch/U7nA2Bc5s4z3084wiBpqFMKhTJssY95r2
         CiBOZfqY4v0BgHQBZWcz77xH4RZNZ2FGSVp92Ww02SIcSCaJ7FpIUoEXMiXGDlTp1jwa
         +BjTBEgz9k+T9U1dqPx/gj8h0bHql3pPH5lmMr2Ya1q0P6SPfl8lrT5FDUUB2WjtN1W9
         mFgA==
X-Gm-Message-State: APjAAAUKy6jP01MVjBsbCtDIBR4WcOCt5uzcTCFWunvlE5/M/9DWYnd3
        Xljzqf9er2e+FhTuJfjkOIJ4SB98
X-Google-Smtp-Source: APXvYqwOPXlEHLLZClw/mVLPJS3TwS65f/POeCl4cdS2/XwWmodrxXizvjmOB7HeqElTGa1pAHNnmg==
X-Received: by 2002:aa7:9a0c:: with SMTP id w12mr14768943pfj.81.1571889703386;
        Wed, 23 Oct 2019 21:01:43 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:c3:68e9:e651:6431:4a0])
        by smtp.gmail.com with ESMTPSA id m34sm23246295pgb.91.2019.10.23.21.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 21:01:42 -0700 (PDT)
Subject: Re: [PATCH] RDMA/srpt: Fix TPG creation
To:     Honggang LI <honli@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
References: <20191023204106.23326-1-bvanassche@acm.org>
 <20191024033715.GA16157@dhcp-128-227.nay.redhat.com>
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
Message-ID: <f01ed6c8-b499-85d3-1b8e-d0b2350e44d3@acm.org>
Date:   Wed, 23 Oct 2019 21:01:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191024033715.GA16157@dhcp-128-227.nay.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2019-10-23 20:37, Honggang LI wrote:
> On Wed, Oct 23, 2019 at 01:41:06PM -0700, Bart Van Assche wrote:
>> +	mutex_lock(&sport->port_gid_id.mutex);
>> +	list_for_each_entry(stpg, &sport->port_gid_id.tpg_list, entry) {
>> +		if (!IS_ERR_OR_NULL(ch->sess))
>                 ^^^^^^^
>> +			break;
>> +		ch->sess = target_setup_session(&stpg->tpg, tag_num,
>                            ^^^^^^^^^^^^^^^^^^^^
>>  					tag_size, TARGET_PROT_NORMAL, i_port_id,
>>  					ch, NULL);
>> -	/* Retry without leading "0x" */
>> -	if (sport->port_gid_id.tpg.se_tpg_wwn && IS_ERR_OR_NULL(ch->sess))
>> -		ch->sess = target_setup_session(&sport->port_gid_id.tpg, tag_num,
>> +		if (!IS_ERR_OR_NULL(ch->sess))
>                     ^
>> +			break;
> 
> I'm confused about this 'if' statement. In case you repeated the
> validation as previous 'if' statement, it is redundance.
> 
> In case you check the return of the first target_setup_session,
> it seems wrong, we only need to retry in case first target_setup_session
> was failed. But you break out, and skip the second target_setup_session.
> 
>> +		/* Retry without leading "0x" */
>> +		ch->sess = target_setup_session(&stpg->tpg, tag_num,
>                            ^^^^^^^^^^^^^^^^^^^^
>>  						tag_size, TARGET_PROT_NORMAL,
>>  						i_port_id + 2, ch, NULL);

Hi Honggang,

The purpose of this code is to keep iterating until a session has been
created. The "if (!IS_ERR_OR_NULL(ch->sess)) break" code prevents
further target_setup_session() calls after a session has been created
successfully.

Bart.
