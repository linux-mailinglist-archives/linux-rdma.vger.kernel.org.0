Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AB2269252
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Sep 2020 18:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgINQ7B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Sep 2020 12:59:01 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52749 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgINQ4W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Sep 2020 12:56:22 -0400
Received: by mail-pj1-f65.google.com with SMTP id o16so136466pjr.2
        for <linux-rdma@vger.kernel.org>; Mon, 14 Sep 2020 09:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=d5r5ZjxqslDTHYertXw07PFVkvDSdh/4MUWRrEj439I=;
        b=aU/ucgRvK0xorQ8sDJ8AlKw1of1tw/E0FKN+tqOzv4N+kxOuUhenROEo7776pvzfKZ
         G0WiWh+jIegKT62z7xbEKNqXuCRDKsW9hXKFNpXCZUcUfKLWo5B+RiweBWcJ7f8EAEn9
         EC9IJwfIFyeUCNwUDBhX7Osu5/mKb28SXd533b90+JOj7/eriOrcjEF8PWRSAXopPp1Z
         Ui2UliLQnhhrz/Uuw7ds4xMGjlcLowul2EXOKhRrrDeYxRbjB8BRCH18W7qoLS5Mb7Zl
         rImzVlxm7BwiHXb8EdO95PCX/mkKK8et5rRuUNg4otS6wn/Zhnvy0iKzF8q3owcQjNvD
         RNkg==
X-Gm-Message-State: AOAM532iEldxUoyg88essjP825LHxlS2z21GY6SUcb09thDC0MUT9kc6
        U9NZP/iO9aUvZH9lpg7Kl78=
X-Google-Smtp-Source: ABdhPJyuA9oUotyVPxuPXui0SyedpROUA9UCwiaLN5/AxcXcr3miy/LTB2AaYSrEQQueucCKTFyWYA==
X-Received: by 2002:a17:90a:f682:: with SMTP id cl2mr285273pjb.158.1600102581102;
        Mon, 14 Sep 2020 09:56:21 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:3f5a:7698:1b81:cc96? ([2601:647:4000:d7:3f5a:7698:1b81:cc96])
        by smtp.gmail.com with ESMTPSA id e123sm11066876pfh.167.2020.09.14.09.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 09:56:20 -0700 (PDT)
Subject: Re: [PATCH] srp_daemon: Avoid extra permissions for the lock file
To:     Sergey Gorenko <sergeygo@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20200819141745.11005-1-sergeygo@nvidia.com>
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
Message-ID: <7027c39a-1435-c4eb-d42f-c7fe272456a8@acm.org>
Date:   Mon, 14 Sep 2020 09:56:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200819141745.11005-1-sergeygo@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-08-19 07:17, Sergey Gorenko wrote:
> There is no need to create a world-writable lock file.
> It's enough to have an RW permission for the file owner only.
> 
> Signed-off-by: Sergey Gorenko <sergeygo@nvidia.com>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  srp_daemon/srp_daemon.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/srp_daemon/srp_daemon.c b/srp_daemon/srp_daemon.c
> index f14d9f56c9f2..fcf94537cebb 100644
> --- a/srp_daemon/srp_daemon.c
> +++ b/srp_daemon/srp_daemon.c
> @@ -142,7 +142,6 @@ static int check_process_uniqueness(struct config_t *conf)
>  		return -1;
>  	}
>  
> -	fchmod(fd, S_IRUSR|S_IRGRP|S_IROTH|S_IWUSR|S_IWGRP|S_IWOTH);
>  	if (0 != lockf(fd, F_TLOCK, 0)) {
>  		pr_err("failed to lock %s (errno: %d). possibly another "
>  		       "srp_daemon is locking it\n", path, errno);

I think the fchmod() call was introduced by commit ee138ce1e40d ("Cause
srp_daemon launch to fail if another srp_daemon is already working on the
same HCA port."). Has it been verified that with this change applied that
mechanism still works?

Anyway, please add a reference to that commit in the patch description.

Thanks,

Bart.



