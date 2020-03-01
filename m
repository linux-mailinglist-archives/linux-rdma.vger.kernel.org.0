Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9544174A7A
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Mar 2020 01:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgCAAbi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 29 Feb 2020 19:31:38 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45108 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgCAAbh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 29 Feb 2020 19:31:37 -0500
Received: by mail-pg1-f194.google.com with SMTP id m15so3488289pgv.12;
        Sat, 29 Feb 2020 16:31:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3yNBLDFfZPTa4D82QJPVgnnqZX/d7OMJSCq77QBfI4Y=;
        b=oItiz2fLlvQFfwBUsN2sbOl+Xd6HXWrpwD8atKpKE4XqyH8yQN8u9WaMBzk0YKqfIF
         UPeSR2ivsVRXcVk0+oggdromhilxlAGZCyGldlLCnErQT2+PZ0W3nNn5Z+xzVJoK9kd9
         03cVg/oja0xgRk0rCztlqgbIOTyVEbbVJ2ZK6XEnTehKhEfqe1rZL5Iy5Ei8sgYjoEHV
         HjblRVCFyu8FPkAOt4oaBkZB+RNUIWInAQxQITyUYf2FhpXN0cluvvxBDioS0rH7xcAv
         UEZ0mQIZpCZQ4AjCKgGV4vx5UZfCTpMqnyEP3kJBqph6P16Vc4pxae25c11yD5Vd/8X3
         t+6A==
X-Gm-Message-State: APjAAAUWCbHsNaCLSRlrDmwoLwliKgpGNsvymwHEyRhLrD2Pbskg/rg4
        Q3IEn/oeZxZeJYXLRk2pgS4=
X-Google-Smtp-Source: APXvYqz+kK2oV+KmzALJoSdxA2gTeJdPNwqTZvM+LbueGUuSdNCaBAYfaAzAOAR6+wdYWqiO6nBGOw==
X-Received: by 2002:a63:f714:: with SMTP id x20mr11914441pgh.114.1583022696638;
        Sat, 29 Feb 2020 16:31:36 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:bd83:6f94:8c5:942d? ([2601:647:4000:d7:bd83:6f94:8c5:942d])
        by smtp.gmail.com with ESMTPSA id e2sm11261283pfh.151.2020.02.29.16.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 16:31:35 -0800 (PST)
Subject: Re: [PATCH v9 02/25] RDMA/rtrs: public interface header to establish
 RDMA connections
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de, pankaj.gupta@cloud.ionos.com
References: <20200221104721.350-1-jinpuwang@gmail.com>
 <20200221104721.350-3-jinpuwang@gmail.com>
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
Message-ID: <e1d8d2ca-78cf-f3ee-2286-1c96e5cfefc7@acm.org>
Date:   Sat, 29 Feb 2020 16:31:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221104721.350-3-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-02-21 02:46, Jack Wang wrote:
> +/**
> + * enum rtrs_clt_con_type() type of ib connection to use with a given
> + * rtrs_permit
> + * @USR_CON - use connection reserved vor "service" messages
> + * @IO_CON - use a connection reserved for IO
> + */

vor -> for?

> +enum rtrs_clt_con_type {
> +	RTRS_USR_CON,
> +	RTRS_IO_CON
> +};

The name "USR" is confusing. How about changing this into "ADMIN"?

> +/*
> + * Here goes RTRS server API
> + */

How about splitting this header file into one header file for the client
API and another header file for the server API? I expect that most users
will only include one of these header files but not both.

Thanks,

Bart.
