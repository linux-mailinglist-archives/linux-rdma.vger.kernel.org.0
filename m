Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9585F1D9C35
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 18:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgESQQJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 12:16:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41936 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbgESQQJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 12:16:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id a13so73783pls.8;
        Tue, 19 May 2020 09:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QxKaFrKqCcwILQrx7w2ZBbHw7MyXAaQ0yfp2yLJWOL4=;
        b=JjV3s2BJq97V4N5XxScV4fSgjB5SHp/trsQxtKgVsVaIE7KnEcyhnD7kn29HGBgVmG
         ahANGqC27viuXSHQ7FJRAvlixZM6tu0cnHwTKKmi/8YVT9YGlMrhNQNowSFre3D9cDnW
         TPOUtTufPfHL6qLIq9oi9UPwd1yOVOblrrhT1m3eoTkgGA9AcgcBb483MtXLIl7s4Ei1
         /CY/CrL6aSRqdw0Z5KNW0zncBlosXRjyStZ2ViurjX0hc8ejJfvdvCiqdK5OOkUOONFL
         wEvVh3ebVuFJMs++iz5nuKgr6s/iJnoZCtGy8EfJDcgoHsNOEO4ps5hbccEAIk0i7zS9
         mN/w==
X-Gm-Message-State: AOAM531fIPPXjmDlhbhJNAAxdbxWybbz/YaK9gCsTt943tsRhaZ6Wgpd
        MTKhN8gGfcoacJQc9GsvqfY=
X-Google-Smtp-Source: ABdhPJxTNi4/prRnHRZp5jgEZhvdYGVRY0F4710nT+lBjblX3yu7iW8AhPShUbaZk1LKjzlxCdZpDw==
X-Received: by 2002:a17:902:bb86:: with SMTP id m6mr208429pls.341.1589904968185;
        Tue, 19 May 2020 09:16:08 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:a402:5dc4:a04b:e81f? ([2601:647:4000:d7:a402:5dc4:a04b:e81f])
        by smtp.gmail.com with ESMTPSA id i98sm54200pje.37.2020.05.19.09.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 09:16:07 -0700 (PDT)
Subject: Re: [PATCH] RDMA/rtrs: client: Fix function return on success
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
References: <20200519161345.GA3910@embeddedor>
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
Message-ID: <220e3cd2-2f22-063a-4117-8ee987521c61@acm.org>
Date:   Tue, 19 May 2020 09:16:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519161345.GA3910@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-05-19 09:13, Gustavo A. R. Silva wrote:
> The function should return 0 on success, instead of err.
> 
> Addresses-Coverity-ID: 1493753 ("Identical code for different branches")
> Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 468fdd0d8713c..465515e46bb1a 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -1594,7 +1594,8 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
>  
>  	if (err)
>  		return err;
> -	return err;
> +
> +	return 0;
>  }

Why to keep the if-statement? Has the following been considered?

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 8dfa56dc32bc..a7f5d55f8542 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1587,8 +1587,6 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 	 * since destroy_con_cq_qp() must be called.
 	 */

-	if (err)
-		return err;
 	return err;
 }

Thanks,

Bart.
