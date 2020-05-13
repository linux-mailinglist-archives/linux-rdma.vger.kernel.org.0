Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66841D18CE
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 17:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbgEMPLO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 11:11:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38442 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgEMPLN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 May 2020 11:11:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id y25so8128003pfn.5
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 08:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=g2+d7KjigHhUqJnh+iC064AcMpJwAXkhjZpeC32UO+o=;
        b=fMqkayYrLvjLvVcoNNR7cUKN29w9BOyO6jY1gvrzCZWIMXZChq2BmxpYb6SHuARoCa
         8nm6RSqTGXwEutes4zfCfGUWrfP3/4IufZ6oqTOuYhnNoePRIp9HQS6dqTcWwm5mds+P
         dTI+50ng8SADdzKwQTXRCStv4OricdBsfzh3yoTh5sRkBDGSOvnl22n/Gv6n8EyHW6Jx
         YHyhGZj5/pXwsCwtaaU4LuEtwg2C2yid7I+u3e0D1nV75o05zHAqssMK9bbeHPsV5HIB
         DeXnr9wim+1ovu5Bwn0ad6d/TormiwsfNuoxlDjCClDcUk/JhDq8NQ4LLAk/AcwvJjCG
         5s5Q==
X-Gm-Message-State: AOAM532RxEWdDcmbEiNltgRUbrozQkB3d5FQ91+lneT4fIr6QhBKQUki
        Rze/XO9ReJv9wLXv7SY5nSg=
X-Google-Smtp-Source: ABdhPJy0B2HKeXE84ygBZJpmenLRYdGIJfk7e9GlkhbE2W0QBxcZwiGxuZgah8k3sDkHjI23YstSHw==
X-Received: by 2002:a65:4204:: with SMTP id c4mr5629804pgq.118.1589382672893;
        Wed, 13 May 2020 08:11:12 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:e13e:45d5:70d9:c74e? ([2601:647:4000:d7:e13e:45d5:70d9:c74e])
        by smtp.gmail.com with ESMTPSA id q134sm4886392pfc.143.2020.05.13.08.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 08:11:11 -0700 (PDT)
Subject: Re: [PATCH 1/1] IB/srp: remove support for FMR memory registration
To:     Max Gurtovoy <maxg@mellanox.com>, jgg@mellanox.com,
        linux-rdma@vger.kernel.org, dledford@redhat.com, leon@kernel.org
Cc:     sagi@grimberg.me, israelr@mellanox.com
References: <20200513144930.150601-1-maxg@mellanox.com>
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
Message-ID: <b356d083-7c53-145c-bd30-38fe3b5a6510@acm.org>
Date:   Wed, 13 May 2020 08:11:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513144930.150601-1-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-05-13 07:49, Max Gurtovoy wrote:
> FMR is not supported on most recent RDMA devices (that use fast memory
> registration mechanism). Also, FMR was recently removed from NFS/RDMA
> ULP.

Please mention how this patch has been tested.

> @@ -71,7 +71,7 @@
>  static unsigned int cmd_sg_entries;
>  static unsigned int indirect_sg_entries;
>  static bool allow_ext_sg;
> -static bool prefer_fr = true;
> +static bool prefer_fr;
>  static bool register_always = true;
>  static bool never_register;
>  static int topspin_workarounds = 1;

Is this change necessary?

Thanks,

Bart.
