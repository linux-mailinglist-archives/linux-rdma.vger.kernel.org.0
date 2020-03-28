Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9D69196740
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2020 17:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgC1QQ7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Mar 2020 12:16:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35347 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgC1QQ7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 28 Mar 2020 12:16:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id u68so6143358pfb.2;
        Sat, 28 Mar 2020 09:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qlkCmoKbw0saYYC0Jyy28ISdZipPWuEC61Gcw0o9wog=;
        b=NatDVGyQndyXkQaYu3+6paDZlbFcdAcTUW/ad9zp40HRag9qg3Ll+4sLD/iKswtbKZ
         rk52/p7LhrXQwbga7dnv/qj8Ixnqb2c5CC74/GYUHl7DqU5G1A9ZtZhTTF46MPOKAzoG
         uxVGF6p8PJw0u5k088+QaPTkiee/YAQ4u6qCBxq4r+H9HqSDcgomOxk5zD3BHzgBNmDd
         oCoJeecENSBy9IqwlkdxuRlqKcFrYUizmBIhHH2NEwmKg2OU7pWap6bonD+c+ptedE0y
         YP09t7TfuPkj91exwMpBsjLtYweKuT9Seo+WWQGjKIZks0Oqqj9d61jyv48sQHORA28N
         K/6g==
X-Gm-Message-State: AGi0PuYAoRZdvWwwdjAAADxfjRa9otNF5GS8wb5L6DdEwmwvwWxlzzQq
        dftLaWiWwu88ooEdFMCSkmUAtZtMNCk=
X-Google-Smtp-Source: APiQypJUm3vPU5dLRA6zSpNzlsfFv4I8E3zY6p8xY0kI+VBLVQ1SlagdGk/XQ1OVSYCJn5+Kw5d3Aw==
X-Received: by 2002:a63:64c4:: with SMTP id y187mr76397pgb.36.1585412217860;
        Sat, 28 Mar 2020 09:16:57 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:597d:a863:13de:4665? ([2601:647:4000:d7:597d:a863:13de:4665])
        by smtp.gmail.com with ESMTPSA id c128sm6438705pfa.11.2020.03.28.09.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2020 09:16:56 -0700 (PDT)
Subject: Re: [PATCH v11 15/26] block: reexport bio_map_kern
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, sagi@grimberg.me, leon@kernel.org,
        dledford@redhat.com, jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        rpenyaev@suse.de, pankaj.gupta@cloud.ionos.com
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-16-jinpu.wang@cloud.ionos.com>
 <15f25902-1f5a-a542-a311-c1e86330834b@acm.org>
 <20200328082953.GB16355@infradead.org>
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
Message-ID: <bbba2682-0221-4173-9d00-b42d4f91f3b8@acm.org>
Date:   Sat, 28 Mar 2020 09:16:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200328082953.GB16355@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-03-28 01:29, Christoph Hellwig wrote:
> On Fri, Mar 27, 2020 at 08:58:09PM -0700, Bart Van Assche wrote:
>> On 2020-03-20 05:16, Jack Wang wrote:
>>> To avoid duplicate code in rnbd-srv, we need to reexport
>>> bio_map_kern.
> 
> NAK.  If you need this helper you are doing something wrong.  What is
> the use case where a simple bio_add_page loop won't work?

Hi Christoph,

There are more users in the Linux kernel of bio_add_pc_page() than only
bio_map_kern(), e.g. the SCSI target pass-through code
(drivers/target/target_core_pscsi.c). The code that uses bio_map_kern()
is in patch 22/26: "block/rnbd: server: functionality for IO submission
to file or block dev". Isn't that use case similar to the SCSI
pass-through code? I think the RNBD server code also implements storage
target functionality.

Thanks,

Bart.


