Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68FDEE27FD
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 04:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436684AbfJXCNb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 22:13:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39116 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436605AbfJXCNb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Oct 2019 22:13:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id p12so13248187pgn.6
        for <linux-rdma@vger.kernel.org>; Wed, 23 Oct 2019 19:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=M9GUzoFkdLIfoWxag9frxYvyT68lzZGYCeA1RN1/2S4=;
        b=kJwRWzM3OXskXnJRYMat9ypHF0WMx6HaD9uTSc47lqMXbORYloBI4i6AqtWqOfFNvk
         8tZ56CGwHvtBeLizfYil3GYCe6QY5oVRhKS7AiDjfJhSlwnT80l5wGyIJiPiLdbrwDn/
         71zlNOrZCodqZ/vBZZpgQ6f6rcuc3NVWFPuXfvasDMAPs4GzOGN0ZV7TNXAu7aJUWQJr
         /AkyrmHmo17sBZGrIczLriqMlAZLZ5xARKheOD8OeggFNl6EwY9H3n8GXWPT76a17ULE
         HbeWwgqTiI9+vrjGLrJSNAou98rofkIwe9oT6dX6puDGRTQgdnwRg2FjYuY9Z0sLvsj0
         NYMg==
X-Gm-Message-State: APjAAAUDbjjxtCaRHSGueomj0oWB2/Md3TcmRCUPGqcL4XFyksELeOIR
        YS6DhrjDtTVZ8IVenCBr5l4/O9F6
X-Google-Smtp-Source: APXvYqzzDlAxofzOiDhpPE/3CcE9z0HsdhSX/pUXsb/RsRbdV2hPyfb1dyPYaXIbL+JtZto2nRTqgA==
X-Received: by 2002:a63:560d:: with SMTP id k13mr13607075pgb.437.1571883209759;
        Wed, 23 Oct 2019 19:13:29 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:c3:68e9:e651:6431:4a0])
        by smtp.gmail.com with ESMTPSA id d5sm500788pjw.31.2019.10.23.19.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 19:13:28 -0700 (PDT)
Subject: Re: [PATCH] srp_daemon: Use maximum initiator to target IU size
To:     Honggang LI <honli@redhat.com>
Cc:     linux-rdma@vger.kernel.org
References: <20191018044104.21353-1-honli@redhat.com>
 <1d811fc0-1f74-b546-b296-a4e9f8c33d86@acm.org>
 <20191018152253.GA32562@dhcp-128-227.nay.redhat.com>
 <21142610-1e01-4ce8-635c-2fe677e69cf9@acm.org>
 <20191022070025.GA20278@dhcp-128-227.nay.redhat.com>
 <5f664232-ca58-c25c-e9b1-e441c053c818@acm.org>
 <20191023030641.GA14551@dhcp-128-227.nay.redhat.com>
 <20191023153357.GA9650@dhcp-128-227.nay.redhat.com>
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
Message-ID: <3b632531-da0a-8c98-365a-076a7d0b3460@acm.org>
Date:   Wed, 23 Oct 2019 19:13:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191023153357.GA9650@dhcp-128-227.nay.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2019-10-23 08:33, Honggang LI wrote:
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> index b7f7a5f7bd98..96434f743a91 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.c
> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> @@ -74,6 +74,7 @@ static bool allow_ext_sg;
>  static bool prefer_fr = true;
>  static bool register_always = true;
>  static bool never_register;
> +static bool has_max_it_iu_size = true;
>  static int topspin_workarounds = 1;
>  
>  module_param(srp_sg_tablesize, uint, 0444);
> @@ -103,6 +104,10 @@ module_param(register_always, bool, 0444);
>  MODULE_PARM_DESC(register_always,
>  		 "Use memory registration even for contiguous memory regions");
>  
> +module_param(has_max_it_iu_size, bool, 0444);
> +MODULE_PARM_DESC(has_max_it_iu_size,
> +		  "Indicate the module supports max_it_iu_size login parameter");
> +
>  module_param(never_register, bool, 0444);
>  MODULE_PARM_DESC(never_register, "Never register memory");
>  
> ==============
> Then, srp_daemon should check file "/sys/module/ib_srp/parameters/has_max_it_iu_size"
> instead of "/sys/module/ib_srp/parameters/use_imm_data".

This should work but I'm not sure this is the best approach we can come
up with. Will one new kernel module parameter be added to the ib_srp
kernel module every time a login parameter is added?

Thanks,

Bart.

