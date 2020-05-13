Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9371D1CFE
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 20:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733175AbgEMSHN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 14:07:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42078 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732488AbgEMSHM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 May 2020 14:07:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id k19so133975pll.9
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 11:07:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sd5KF3LZnq5zxJJKwm/dnKy4yuRXDJwGIhRYBD0dzwU=;
        b=Uwy6bhAirgj0zHWOdDqw8kieR8OLnDvTx/rhv3HZ6+5ngbjFk09tZYChvAWZuSImig
         18hotDI9FoZqAG6GXDwiqT3hkVcBcjl1qJDUqtc/3J94obwBhEwSaUuTCh0gbKBSMRW0
         /ukovhM+YJ9u8e/446RRk5mxoKz5MCXoi2jvcn1w7f9JtniHPnK31V3DL5kFfB1FxLas
         qHLxNEhhBOuTh1uoPzG+kw58EX77/QB683eJ9fi5MNkKiUm2DOzSy5onSJ9J1O74MHTJ
         l2NPuKjZ883qoCc7DMtr5y98EtV9sMQCW1cM9tzYAGQW5eziXoS1Q6YF8Qhv/EgVgcxH
         5XyA==
X-Gm-Message-State: AOAM5320KS7JAGlrQJIHzRDGrn0geZkXywaI4xs3+/qQ1lO0mr7/IGu6
        Zx4z3bnACyNdkGzdKaXnOk0=
X-Google-Smtp-Source: ABdhPJzq5aMb7o21/Geft7UQGrcwgjfA4HaSiDiyBt3RVhoEX8u9PXCK431/xc5irWn2WJz87su6CQ==
X-Received: by 2002:a17:90a:5802:: with SMTP id h2mr11424853pji.221.1589393231930;
        Wed, 13 May 2020 11:07:11 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:89b0:7138:eb9:79bf? ([2601:647:4000:d7:89b0:7138:eb9:79bf])
        by smtp.gmail.com with ESMTPSA id r12sm288606pgv.59.2020.05.13.11.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 11:07:11 -0700 (PDT)
Subject: Re: [PATCH for-rc] RDMA/srpt: Fix disabling device management
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kamal Heib <kamalheib1@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
References: <20200513072203.GR4814@unreal>
 <20200513100204.GA92901@kheib-workstation> <20200513102132.GW4814@unreal>
 <20200513104536.GA120318@kheib-workstation> <20200513105045.GX4814@unreal>
 <20200513111435.GA121070@kheib-workstation> <20200513113118.GY4814@unreal>
 <20200513123837.GA123854@kheib-workstation> <20200513124334.GA29989@ziepe.ca>
 <d3e729d7-97c0-607c-b1b3-80a2df47cbae@acm.org>
 <20200513180244.GE29989@ziepe.ca>
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
Message-ID: <e205763f-b36f-484e-3b16-8363fc438242@acm.org>
Date:   Wed, 13 May 2020 11:07:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513180244.GE29989@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-05-13 11:02, Jason Gunthorpe wrote:
> On Wed, May 13, 2020 at 08:25:41AM -0700, Bart Van Assche wrote:
>> In other words, on my setup the ib_srpt driver was working find with SR-IOV.
> 
> But it won't be properly discoverable without the
> IB_PORT_DEVICE_MGMT_SUP flag being set on the physical port?

That matches my understanding. Even if srp_daemon can't discover an SRP
target, it is still possible to log in by writing the proper login
parameters into /sys/class/infiniband_srp/*/add_target.

Bart.
