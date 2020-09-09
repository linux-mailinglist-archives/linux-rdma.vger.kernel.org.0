Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3542624B4
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Sep 2020 04:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgIICCB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Sep 2020 22:02:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36107 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgIICB7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Sep 2020 22:01:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id m8so904108pgi.3;
        Tue, 08 Sep 2020 19:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kvL65AfQsPGI4gpoBmEgnMaj8DleEIV8yU5wsNDGWf0=;
        b=uO3xDQb9hb9jcE8cC6MKof/ILAu7vTlVFIWTLePcpsJf/VJg29Sote9Qk414LBunC/
         3UTTpb0dcd16Hh/8/agbflwNRdE5CGKwBDz0Y0+ctr9Jsekl36x7sQNnAsFgQCnQh5w/
         +D30wH4/xMpcMTfZr15CAyaId5slnE0mdGUN8ObDqh7okiZ4ZUPEDhsTKwCt0h5swpIV
         KqkoP0vIAuWOU66MZ4QsTYq1/6p17KDCH3mai851ZeSAu6v+4iUKoZo+8fx4Whzac3sI
         JjSJ61+G+68Di7F8eDcww+RztfDvCuR6tOBW+rppAOc7p4ddRmIrU5CRk6SpwH+Qd7at
         v5/g==
X-Gm-Message-State: AOAM533vGJooohv9kS2/7+M4GMVKNBEhoAyRFFCN+wAGy0ikOYx6/2Cp
        PlZc7if43ehYke4SVps/B8Q=
X-Google-Smtp-Source: ABdhPJzywdzVLVX5JZdZ9cKfiVBn/LFo9kj0C56l7tuJqdbfDnbcLB5tt0u07fWpcpjPzS7aCDaA9A==
X-Received: by 2002:a63:1a21:: with SMTP id a33mr1235125pga.305.1599616917034;
        Tue, 08 Sep 2020 19:01:57 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:fb09:e536:da63:a7cd? ([2601:647:4000:d7:fb09:e536:da63:a7cd])
        by smtp.gmail.com with ESMTPSA id 72sm645870pfx.79.2020.09.08.19.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 19:01:56 -0700 (PDT)
Subject: Re: [IB/srpt] c804af2c1d: last_state.test.blktests.exit_code.143
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
Message-ID: <e8a240aa-9e9b-3dca-062f-9130b787f29b@acm.org>
Date:   Tue, 8 Sep 2020 19:01:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908182232.GP9166@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-09-08 11:22, Jason Gunthorpe wrote:
> It is reasonable to consider the cq_pool as a built-in client, so I
> would suggest moving it to right around the time the dynamic clients
> are handled. Something like this:
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index c36b4d2b61e0c0..e3651dacad1da6 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -1285,6 +1285,8 @@ static void disable_device(struct ib_device *device)
>  		remove_client_context(device, cid);
>  	}
>  
> +	ib_cq_pool_destroy(ib_dev);
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

The above patch didn't compile, but the patch below does and makes the hang
disappear. So feel free to add the following to the patch below:

Tested-by: Bart Van Assche <bvanassche@acm.org>

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index c36b4d2b61e0..23ee65a9185f 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1285,6 +1285,8 @@ static void disable_device(struct ib_device *device)
 		remove_client_context(device, cid);
 	}

+	ib_cq_pool_destroy(device);
+
 	/* Pairs with refcount_set in enable_device */
 	ib_device_put(device);
 	wait_for_completion(&device->unreg_completion);
@@ -1328,6 +1330,8 @@ static int enable_device_and_get(struct ib_device *device)
 			goto out;
 	}

+	ib_cq_pool_init(device);
+
 	down_read(&clients_rwsem);
 	xa_for_each_marked (&clients, index, client, CLIENT_REGISTERED) {
 		ret = add_client_context(device, client);
@@ -1400,7 +1404,6 @@ int ib_register_device(struct ib_device *device, const char *name)
 		goto dev_cleanup;
 	}

-	ib_cq_pool_init(device);
 	ret = enable_device_and_get(device);
 	dev_set_uevent_suppress(&device->dev, false);
 	/* Mark for userspace that device is ready */
@@ -1455,7 +1458,6 @@ static void __ib_unregister_device(struct ib_device *ib_dev)
 		goto out;

 	disable_device(ib_dev);
-	ib_cq_pool_destroy(ib_dev);

 	/* Expedite removing unregistered pointers from the hash table */
 	free_netdevs(ib_dev);

