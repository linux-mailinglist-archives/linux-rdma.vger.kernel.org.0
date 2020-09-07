Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661E325F1CC
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 04:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgIGC6Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 6 Sep 2020 22:58:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33121 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgIGC6Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 6 Sep 2020 22:58:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id d19so382116pld.0;
        Sun, 06 Sep 2020 19:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=V8cA7enjbh48/8eRE2MElq9oDfjEE+NkHjPLBOpS/KQ=;
        b=fg0cGWEiECu6rDQGSAuj8VMZlhTfjngG89XnWTG5AFKRaHzkT6Docn7+OUAjX63D5X
         UxI21wrjfPMBeK4BQKpLdwI4j5fxqODwLex97S1SM6Jb3foTU+zudzK7x8r95nWHeHwV
         sYjabza7o+Pmb5UTNQ7LGHIEIx1kj9ZLHGcVZpFK5NmwXrHOjTybtM9SSmYHo3Fzwdx9
         L0vxl+FS0BWF7nuQ0sHsIa+4liArsm+veNybkla0Wu9r4Q+GX0b65WaP+AS4UKmDbJJD
         JoJZnaUNdKmQoCyX76ldD2EstoIjuzLi7DweaYQELIrQJsr8pROWFlaTwL+qKRdSCVRn
         UuDg==
X-Gm-Message-State: AOAM530o6UmDPlxzmGKCPQhGVlijIoKgjuk3D4YDOgMEvUi/re57Oz6a
        01du6L6SEZEcAJvIeupo4sM=
X-Google-Smtp-Source: ABdhPJwKf1v3Sf88AYroAfn5Ivk2MKk+w9z88r7Qf4cuyh3v3KJdYiXvVbE/fE/pICFFQaa1s1ipmQ==
X-Received: by 2002:a17:902:9347:: with SMTP id g7mr18105601plp.200.1599447494672;
        Sun, 06 Sep 2020 19:58:14 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:30fd:ff3e:1f2d:1c1c? ([2601:647:4000:d7:30fd:ff3e:1f2d:1c1c])
        by smtp.gmail.com with ESMTPSA id j14sm9790820pgf.76.2020.09.06.19.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 19:58:13 -0700 (PDT)
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
Message-ID: <2a2ff3a5-f58e-8246-fd09-87029b562347@acm.org>
Date:   Sun, 6 Sep 2020 19:58:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824133019.GH1152540@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-08-24 06:30, Jason Gunthorpe wrote:
> On Sun, Aug 23, 2020 at 02:18:41PM -0700, Bart Van Assche wrote:>  
>> The patch below is sufficient to unbreak blktests. I think that the
>> deadlock while unloading rdma_rxe happens because the RDMA core waits for
>> all ib_dev references to be dropped before dealloc_driver is called.
> 
> Which is required, yes
> 
>> The rdma_rxe dealloc_driver implementation drops an ib_dev
>> reference. 
> 
> Where does it do that? I didn't notice it?

That last statement was wrong.

Anyway, with the following debugging patch applied:

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index c36b4d2b61e0..b976dd30f727 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -332,6 +332,8 @@ struct ib_device *ib_device_get_by_index(const struct net *net, u32 index)
  */
 void ib_device_put(struct ib_device *device)
 {
+	WARN(device->warn_on_refcount_drop, "%s refcnt = %d\n",
+	     dev_name(&device->dev), refcount_read(&device->refcount));
 	if (refcount_dec_and_test(&device->refcount))
 		complete(&device->unreg_completion);
 }
@@ -1287,7 +1289,10 @@ static void disable_device(struct ib_device *device)

 	/* Pairs with refcount_set in enable_device */
 	ib_device_put(device);
+	device->warn_on_refcount_drop = true;
+#if 0
 	wait_for_completion(&device->unreg_completion);
+#endif

 	/*
 	 * compat devices must be removed after device refcount drops to zero.
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index c868609a4ffa..2d050e3ee55a 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2704,6 +2704,7 @@ struct ib_device {
 	 * registered and cannot be unregistered.
 	 */
 	refcount_t refcount;
+	bool		warn_on_refcount_drop;
 	struct completion unreg_completion;
 	struct work_struct unregistration_work;

The following appeared:

WARNING: CPU: 5 PID: 1760 at drivers/infiniband/core/device.c:335 ib_device_put+0xf2/0x100 [ib_core]

Call Trace:
 rxe_elem_release+0x76/0x90 [rdma_rxe]
 rxe_destroy_cq+0x4f/0x70 [rdma_rxe]
 ib_free_cq_user+0x12b/0x2b0 [ib_core]
 ib_cq_pool_destroy+0xa8/0x140 [ib_core]
 __ib_unregister_device+0x9c/0x1c0 [ib_core]
 ib_unregister_driver+0x181/0x1a0 [ib_core]
 rxe_module_exit+0x31/0x50 [rdma_rxe]
 __x64_sys_delete_module+0x22a/0x310
 do_syscall_64+0x36/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Do you agree that the above proves that the hang-on-unload is a
regression that has been introduced by the cq-pool patches? Is the patch
below a good way to fix this?

--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1454,8 +1454,8 @@ static void __ib_unregister_device(struct ib_device *ib_dev)
 	if (!refcount_read(&ib_dev->refcount))
 		goto out;

-	disable_device(ib_dev);
 	ib_cq_pool_destroy(ib_dev);
+	disable_device(ib_dev);

 	/* Expedite removing unregistered pointers from the hash table */
 	free_netdevs(ib_dev);

Thanks,

Bart.
