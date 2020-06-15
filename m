Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97C21F9911
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2020 15:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbgFONh7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Jun 2020 09:37:59 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45888 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730167AbgFONh7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 15 Jun 2020 09:37:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id d8so6818491plo.12;
        Mon, 15 Jun 2020 06:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wpyxJv/PM1wE2X/LCvdaNR8aTZBt1o2wUTKPmTumIZU=;
        b=CSsXKd73Eu0wUabrIH+cLvboO+tmwivYcj1kgyWxe9rm8bqcfjaCIeCXJC35lTqBH6
         WSVQiWXSsjjlrfcyapo1Vv7biiw12vJ0VPlfijiITfjG2ilAqvKrxYjEJ4KxPauiS/CJ
         uP6v096yyHIazQafmIhsjylYBMQb7OFMKX8Y/nNxIoBj+6SaOsAVaiKlGEbsgeVYwENJ
         qN/9BZV3b95KHTGCKw/FuOoqcrCSb1XXvPFHfZVR62LXfC+tJGpw2F6QaTxO+FA+uDhL
         A3vC2LJwIK9BBihD2OWxnFAB6Ru1tIp+SOXg+pF14YxsAGQdZvTTrHIjR3ofnHN51vUf
         tLow==
X-Gm-Message-State: AOAM531MZuy3vCDbiOzBgsMXXtucnr32BJSDknEOzu3YXwjcoDZRRB3s
        WDopc4e1dOR7vQkCMjH5kIc8XTZf
X-Google-Smtp-Source: ABdhPJyr/l0oRGL6uU3APS2OcIqbEqYfER6YeVxPtUFty159+MQPg+GUVoGGRpPJ2VVLgigRmJJ6VQ==
X-Received: by 2002:a17:902:eed4:: with SMTP id h20mr922321plb.134.1592228277890;
        Mon, 15 Jun 2020 06:37:57 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id e12sm14177046pfj.137.2020.06.15.06.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 06:37:57 -0700 (PDT)
Subject: Re: [PATCH] IB/srpt: Fix a potential null pointer dereference
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20200615091220.6439-1-jingxiangfeng@huawei.com>
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
Message-ID: <7366b608-4474-cfaa-c465-957fd2d2366d@acm.org>
Date:   Mon, 15 Jun 2020 06:37:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615091220.6439-1-jingxiangfeng@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-06-15 02:12, Jing Xiangfeng wrote:
> In srpt_cm_req_recv(), it is possible that sdev is NULL,
> so we should test sdev before using it.
> 
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 98552749d71c..72053254bf84 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -2143,7 +2143,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>  			    const struct srp_login_req *req,
>  			    const char *src_addr)
>  {
> -	struct srpt_port *sport = &sdev->port[port_num - 1];
> +	struct srpt_port *sport;
>  	struct srpt_nexus *nexus;
>  	struct srp_login_rsp *rsp = NULL;
>  	struct srp_login_rej *rej = NULL;
> @@ -2162,6 +2162,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>  	if (WARN_ON(!sdev || !req))
>  		return -EINVAL;
>  
> +	sport = &sdev->port[port_num - 1];
>  	it_iu_len = be32_to_cpu(req->req_it_iu_len);
>  

Please remove the (!sdev || !req) check instead of making the above
change. It's easy to show that both pointers are always valid.

Thanks,

Bart.
