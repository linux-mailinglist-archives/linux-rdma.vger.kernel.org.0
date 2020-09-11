Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A032266A81
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Sep 2020 00:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgIKWAg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Sep 2020 18:00:36 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38554 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgIKWAd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Sep 2020 18:00:33 -0400
Received: by mail-pj1-f65.google.com with SMTP id u3so2312248pjr.3;
        Fri, 11 Sep 2020 15:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=T8QNDN9uTTnU+bIAQKTYlCDI+O7uMoLeGLrJTtMrEwY=;
        b=llEQ/5PazCN8Pl1EmmTutePkPSOzGCPHAo4xEohzdxuPqeOGw8MmKX4PvljIqeA/0Z
         j1Gj7LqnUQnWKktqtCkySliW2El1V9Fs6RB+ozagJPqdNQCAfwrufcDLrqQnhEs9cGwB
         ctthxGj4TClKhRLqxRvNa+oc+vSDtDrvsgesJTcTIjp6RyBojR85GJn/XKvo0iu/QKau
         AhYWNMkr0SNgjy0ZWzpuXiMbcSPNt1zMt9SAHBbx9nWBG6/Ssde5MEBOdWG3ejl1kcM/
         GCoC4cpP3psAJtJnD9DnkeKKHA5MT5mABBZ0uy0F85oI8itoHv9w+3A3n2CTaqzl1X0e
         7iHA==
X-Gm-Message-State: AOAM5317kgI7LtOZL+ZNXZLqZhXlKHWTAUm9W2GHsEkEvtNut7qNCei3
        RvU3RO5+HUKR9Ryr2hWRdGM=
X-Google-Smtp-Source: ABdhPJzY8k1/cj6HQYCp5WDaQSxEvFaemYrGpYmX0m6FvcD6E1Lu5HtN7dp/yb+a2IyrJCQqo4HJwQ==
X-Received: by 2002:a17:90a:7481:: with SMTP id p1mr3982786pjk.33.1599861632755;
        Fri, 11 Sep 2020 15:00:32 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:43f7:5036:5c0b:8fe1? ([2601:647:4000:d7:43f7:5036:5c0b:8fe1])
        by smtp.gmail.com with ESMTPSA id 20sm3241525pfv.87.2020.09.11.15.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 15:00:31 -0700 (PDT)
Subject: Re: [IB/srpt] c804af2c1d: last_state.test.blktests.exit_code.143
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Yamin Friedman <yaminf@mellanox.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org, lkp@lists.01.org
References: <20200802060925.GW23458@shao2-debian>
 <f8ef3284-4646-94d9-7eea-14ac0873b03b@acm.org>
 <ed6002b6-cd0c-55c5-c5a5-9c974a476a95@mellanox.com>
 <0c42aeb4-23a5-b9d5-bc17-ef58a04db8e8@grimberg.me>
 <128192ad-05ff-fa8e-14fc-479a115311e0@acm.org>
 <20200824133019.GH1152540@nvidia.com>
 <2a2ff3a5-f58e-8246-fd09-87029b562347@acm.org>
 <20200908182232.GP9166@nvidia.com>
 <e8a240aa-9e9b-3dca-062f-9130b787f29b@acm.org>
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
Message-ID: <6c86453d-d7ae-a36b-d827-7812999abc96@acm.org>
Date:   Fri, 11 Sep 2020 15:00:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <e8a240aa-9e9b-3dca-062f-9130b787f29b@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-09-08 19:01, Bart Van Assche wrote:
> The above patch didn't compile, but the patch below does and makes the hang
> disappear. So feel free to add the following to the patch below:
> 
> Tested-by: Bart Van Assche <bvanassche@acm.org>
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index c36b4d2b61e0..23ee65a9185f 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -1285,6 +1285,8 @@ static void disable_device(struct ib_device *device)
>  		remove_client_context(device, cid);
>  	}
> 
> +	ib_cq_pool_destroy(device);
> +
>  	/* Pairs with refcount_set in enable_device */
>  	ib_device_put(device);
>  	wait_for_completion(&device->unreg_completion);
> @@ -1328,6 +1330,8 @@ static int enable_device_and_get(struct ib_device *device)
>  			goto out;
>  	}
> 
> +	ib_cq_pool_init(device);
> +
>  	down_read(&clients_rwsem);
>  	xa_for_each_marked (&clients, index, client, CLIENT_REGISTERED) {
>  		ret = add_client_context(device, client);
> @@ -1400,7 +1404,6 @@ int ib_register_device(struct ib_device *device, const char *name)
>  		goto dev_cleanup;
>  	}
> 
> -	ib_cq_pool_init(device);
>  	ret = enable_device_and_get(device);
>  	dev_set_uevent_suppress(&device->dev, false);
>  	/* Mark for userspace that device is ready */
> @@ -1455,7 +1458,6 @@ static void __ib_unregister_device(struct ib_device *ib_dev)
>  		goto out;
> 
>  	disable_device(ib_dev);
> -	ib_cq_pool_destroy(ib_dev);
> 
>  	/* Expedite removing unregistered pointers from the hash table */
>  	free_netdevs(ib_dev);

Hi Jason,

Please let me know how you want to proceed with this patch.

Thanks,

Bart.
