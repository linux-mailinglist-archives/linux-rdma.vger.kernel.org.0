Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16321E14AE
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 21:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389488AbgEYTPh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 15:15:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46607 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389460AbgEYTPg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 15:15:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id 131so757938pfv.13
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 12:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rnHJ1spPJBxhJ9i/HBbETpr1SazWwnsUGJZ0qaa4pE4=;
        b=PIpLQ3XpNWmgQrnSFu6VCdry6xtJ8VWx3QPjP/hByWXT/tqAdLB6numE6mWYJn+2zB
         McuPmAgK8qngs0r8hW4AQY9E4ShOyTBe9Mfq1i0gQ05yAEly8Upw2tBIP9GnLLrM2EfE
         JqMK4jXoslajBDV7IIpKqUZxUGC5ovHwPB3tHDfdyJtv0kWIdMXpoaFCJiYvOM/CsK1T
         S/+gGD5Ri7KsllJVD1472YdjPT3h7lipbXaV1UivSZgVMzGPX5p2/Iw7SGlt29aY+VGb
         VMAwTARu0hKcZhpl37MbdaIJ6zCPrgQ6JEY3NAz6Zh1ix1Vf6Qox5EykKyQ6hPavv436
         5a5A==
X-Gm-Message-State: AOAM532354kxx7rNsxEXP5jRLnLr/QHS8bNGc4DmdpKXaLrfr9Ni7h5D
        yj1HPcN5AD8vW3fYs/AAQBc=
X-Google-Smtp-Source: ABdhPJzRKHqYmwGAx6nAbpO8kuUIHSVvDIBJrjAcSFWREZSYMjwQp+drVFbm02dneZb/BGDJzdVIfg==
X-Received: by 2002:a63:3c11:: with SMTP id j17mr28554565pga.70.1590434135699;
        Mon, 25 May 2020 12:15:35 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:2590:9462:ff8a:101f? ([2601:647:4000:d7:2590:9462:ff8a:101f])
        by smtp.gmail.com with ESMTPSA id i66sm13033703pfe.135.2020.05.25.12.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 12:15:34 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] RDMA/srpt: Increase max_send_sge
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org, Laurence Oberman <loberman@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>
References: <20200525172212.14413-1-bvanassche@acm.org>
 <20200525172212.14413-5-bvanassche@acm.org> <20200525175152.GI10591@unreal>
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
Message-ID: <8633b4b8-fb7d-8034-e2ac-789ec61f4c67@acm.org>
Date:   Mon, 25 May 2020 12:15:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200525175152.GI10591@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-05-25 10:51, Leon Romanovsky wrote:
> On Mon, May 25, 2020 at 10:22:12AM -0700, Bart Van Assche wrote:
>> The ib_srpt driver limits max_send_sge to 16. Since that is a workaround
>> for an mlx4 bug that has been fixed, increase max_send_sge. For mlx4, do
>> not use the value advertised by the driver (32) since that causes QP's
>> to transition to the error status.
> 
> How are you avoiding mlx4 bug in this patch?
> Isn't "attrs->max_send_sge" come from driver as is?

Hi Leon,

Development of this patch started considerable time ago - before the
ib_srpt driver was converted to the RDMA R/W API. Before that conversion
the ib_srpt driver was using attrs->max_send_sge limit for both RDMA
writes and RDMA reads, which is wrong. Hence the need for the
"max_sge_delta" parameter (max_send_sge = 32 and max_sge_rd = 30 for
mlx4). The following code from drivers/infiniband/core/rw.c selects the
proper limit:

       u32 max_sge = dir == DMA_TO_DEVICE ? qp->max_write_sge :
                     qp->max_read_sge;

The following code in drivers/infiniband/core/verbs.c sets these limits:

        qp->max_write_sge = qp_init_attr->cap.max_send_sge;
        qp->max_read_sge = min_t(u32, qp_init_attr->cap.max_send_sge,
                                 device->attrs.max_sge_rd);

Bart.
