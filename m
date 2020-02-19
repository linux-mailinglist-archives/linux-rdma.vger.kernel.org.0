Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0C80163C09
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 05:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgBSE0p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 23:26:45 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37485 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgBSE0o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 23:26:44 -0500
Received: by mail-pl1-f196.google.com with SMTP id c23so9013089plz.4;
        Tue, 18 Feb 2020 20:26:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GrHfY3ZvRV8AGbBZHN/E1LsO/j1xUKPo9RVDcCM/C24=;
        b=PdmzAzgfVL9vV9JcSCGWnEA8qofXWbCHKXhlsueNdWQj6HRcq+OJhjYX2NJFm2gh9v
         urLS/AIHq12UoPEaakUqDnwnWPwjRCc7xHjDT3qUnD97fe9wVIohV+/Bt3GJtLAd9i5a
         VpBlBsbawm+8AO65uvCtIJcUdd0klVtsH63VPxwzATzWpc9q4aGDkSmDKvXn3dHIpMcb
         o5Edh1aI7eT465g4yYHsm815E1b8saciYkqZwCp9/9kjMZ5NltItcUbxrhFamsuhDciV
         Iy2HfZwKwOgiMES+5HzvXrEr0gyRz88Bn0KVLeiPTnU7WEEQ6ubSmC9l1O97FnsB4x4U
         z/2w==
X-Gm-Message-State: APjAAAU89pkqusuUyLy8O7iu+/z2HFOaFW1Gjyqo/wJG3bTXfuBm2WOR
        9Q/VDvTsRioglEzzCb/p25s=
X-Google-Smtp-Source: APXvYqzlIuPnsq0bLSx92C/4wlTVIOiMRxib1NNuqlQwyqCR6NPdOLqkaNVAjpNE9cuBX4YMy8+Vhg==
X-Received: by 2002:a17:902:708b:: with SMTP id z11mr24660348plk.121.1582086404121;
        Tue, 18 Feb 2020 20:26:44 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:ede5:c6f1:47ba:512c? ([2601:647:4000:d7:ede5:c6f1:47ba:512c])
        by smtp.gmail.com with ESMTPSA id c19sm626762pfc.144.2020.02.18.20.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 20:26:43 -0800 (PST)
Subject: Re: [PATCH v8 00/25] RTRS (former IBTRS) RDMA Transport Library and
 RNBD (former IBNBD) RDMA Network Block Device
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Leon Romanovsky <leon@kernel.org>,
        Jinpu Wang <jinpuwang@gmail.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Doug Ledford <dledford@redhat.com>,
        Roman Penyaev <rpenyaev@suse.de>
References: <20200124204753.13154-1-jinpuwang@gmail.com>
 <CAHg0HuzLLHqp_76ThLhUdHGG_986Oxvvr15h_13T12eEWjyAxA@mail.gmail.com>
 <20200131165421.GB29820@ziepe.ca>
 <f657d371-3b23-e4b2-50b3-db47cd521e1f@kernel.dk>
 <CAD9gYJLVMVPjQcCj0aqbAW3CD86JQoFNvzJwGziRXT8B2UT0VQ@mail.gmail.com>
 <a1aaa047-3a44-11a7-19a1-e150a9df4616@kernel.dk>
 <CAMGffEkLkwkd73Q+m46VeOw0UnzZ0EkZQF-QcSZjyqNcqigZPw@mail.gmail.com>
 <20200219002449.GA11943@ziepe.ca>
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
Message-ID: <0a5cd5f9-cfcc-2561-d54f-c7f341a01506@acm.org>
Date:   Tue, 18 Feb 2020 20:26:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219002449.GA11943@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-02-18 16:24, Jason Gunthorpe wrote:
> On Thu, Feb 06, 2020 at 04:12:22PM +0100, Jinpu Wang wrote:
>> Hi Bart, hi Leon,
>>
>> Both of you spent quite some time to review the code, could you give a
>> Reviewed-by for some of the patches you've reviewed?
> 
> Anyone? I don't want to move ahead with a block driver without someone
> from the block community saying it is OK

Reviewing such a big patch series takes more time than I have available
right now. It may take several weeks before I can continue reviewing this
patch series. If anyone else could take a look that would be great.

Thanks,

Bart.

