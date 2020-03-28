Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74F0E19638C
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2020 05:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgC1E0U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Mar 2020 00:26:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35668 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgC1E0T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 28 Mar 2020 00:26:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id u68so5575662pfb.2;
        Fri, 27 Mar 2020 21:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=EOBaEh/uVvw0vCXCbf1sUX04UzfoNwxpRmXDE8Z5BuY=;
        b=MbTJlBrwAxZH1rC5QT1f7t++kIJdxuWNMx+BAyEMtmdwgs4aPQShfqkqc4TsgKZz0e
         ttvzpG7ZnvjR+8R23IIn5QoeS90u5Yp4c6brpaAmOrpslSNfpuXGaF+3LwdVccodxGxx
         n2W6h6uMjPb23Mx2CKzMJkwk3wV9QHjvcMB5MCjw10D6dPavIbew+0My64cKLQUZl3iR
         BObu1nSjXHFb4kK9hi4uYB7R9uTejX//YwbGT5C1XMdjVbWxG+KD4XP5agftBSJGr7Yg
         36jGL6EogHZn8F5lCGdxWDeWI/H7j4CGrz/tiJjtWOSlOMcFcm0efNQi0AVgv1NM36J7
         byPA==
X-Gm-Message-State: ANhLgQ08xmc2GX/HdLWiiKGe2WfHmVqZZOA35FYMYfi1Oi/Tl4A33xEz
        EZ0ldTlqX54lH88hTGpgFCk=
X-Google-Smtp-Source: ADFU+vtCFaQl45eia6qqE6v/sDMMJdvyRx22KOCdexttI7u8MqV0NOqyxJgCjraXk4bl1foR6tLm3w==
X-Received: by 2002:a63:c050:: with SMTP id z16mr2582309pgi.177.1585369578877;
        Fri, 27 Mar 2020 21:26:18 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:3563:edda:f4cf:995c? ([2601:647:4000:d7:3563:edda:f4cf:995c])
        by smtp.gmail.com with ESMTPSA id mg20sm4891464pjb.12.2020.03.27.21.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 21:26:18 -0700 (PDT)
Subject: Re: [PATCH v11 17/26] block/rnbd: client: private header with client
 structs and functions
To:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-18-jinpu.wang@cloud.ionos.com>
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
Message-ID: <0b163be9-2cd6-248a-f9e7-a68e690aceb2@acm.org>
Date:   Fri, 27 Mar 2020 21:26:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200320121657.1165-18-jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-03-20 05:16, Jack Wang wrote:
> +#define BMAX_SEGMENTS 29
> +#define RECONNECT_DELAY 30
> +#define MAX_RECONNECTS -1

Please add a comment above each of these constants that explains the
role of these constants. I can guess what the purpose of the last two
constants is but not what the purpose of the first constant is.

Thanks,

Bart.
