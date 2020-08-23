Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF5324EFD3
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Aug 2020 23:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgHWVSq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Aug 2020 17:18:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36152 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgHWVSp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Aug 2020 17:18:45 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so3258833plt.3;
        Sun, 23 Aug 2020 14:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Vi0dm8w5d4Lt77qeOvVZYVSCtoaDsjZjWKLPsqVLob8=;
        b=PCUaCMfjz9I4tFanZ8T7mfFLUUc4+iTGgiBiQl8wUG+S5rLRAUjA/M8tO2QnEqAfzd
         DRu9oceUw/gJNWu8bp7ytNEesd7X3Y5ISMWppiJMFtV0vs5sKOK26zQi8eFqPZ+i9rnR
         p8o5pvdl6eC4QtjHTeugDmumdMEkz/leYiqExjU5JmPPqihNbD3eG2/GA6ZTs+W7e3K1
         zXNiXhDIhWNj39XWNF3QpTkKIPR8D+5OJYiE74LCfnS+G7UYgvRVyP+dHKMoRi42iiJ+
         7ASpyuCAlbK55WuOwM8vc7WmX/m1uUvxnkvZjEd/7qMM10BPjDOQq+zJyuKfgaXD4ENn
         hJdA==
X-Gm-Message-State: AOAM533DsZCpgnSDsg6sUALfaEfX9i0pLjl9AhK5C8faZmEPKspB+rKV
        0ewtGlKb/pPtu53kTH3S/HE=
X-Google-Smtp-Source: ABdhPJybhVWmfuADEBnqwPOuNKLX8BQccS3YPE9P4Glo3YXSoyU76hsqk0R0TM2Tvs4Ri3Lw7GrRIg==
X-Received: by 2002:a17:90b:1182:: with SMTP id gk2mr2233995pjb.172.1598217523634;
        Sun, 23 Aug 2020 14:18:43 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id nl15sm336068pjb.42.2020.08.23.14.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2020 14:18:42 -0700 (PDT)
Subject: Re: [IB/srpt] c804af2c1d: last_state.test.blktests.exit_code.143
To:     Sagi Grimberg <sagi@grimberg.me>,
        Yamin Friedman <yaminf@mellanox.com>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Max Gurtovoy <maxg@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org, lkp@lists.01.org
References: <20200802060925.GW23458@shao2-debian>
 <f8ef3284-4646-94d9-7eea-14ac0873b03b@acm.org>
 <ed6002b6-cd0c-55c5-c5a5-9c974a476a95@mellanox.com>
 <0c42aeb4-23a5-b9d5-bc17-ef58a04db8e8@grimberg.me>
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
Message-ID: <128192ad-05ff-fa8e-14fc-479a115311e0@acm.org>
Date:   Sun, 23 Aug 2020 14:18:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <0c42aeb4-23a5-b9d5-bc17-ef58a04db8e8@grimberg.me>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-08-03 00:27, Sagi Grimberg wrote:
> 
>>>> Greeting,
>>>>
>>>> FYI, we noticed the following commit (built with gcc-9):
>>>>
>>>> commit: c804af2c1d3152c0cf877eeb50d60c2d49ac0cf0 ("IB/srpt: use new shared CQ mechanism")
>>>> https://git.kernel.org/cgit/linux/kernel/git/rdma/rdma.git for-next
>>>>
>>>>
>>>> in testcase: blktests
>>>> with following parameters:
>>>>
>>>>     test: srp-group1
>>>>     ucode: 0x21
>>>>
>>>>
>>>>
>>>> on test machine: 4 threads Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 4G memory
>>>>
>>>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>>>
>>>>
>>>>
>>>>
>>>> If you fix the issue, kindly add following tag
>>>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>>>>
>>>>
>>>> user  :notice: [   44.688140] 2020-08-01 16:10:22 ./check srp/001 srp/002 srp/003 srp/004 srp/005 srp/006 srp/007 srp/008 srp/009 srp/010 srp/011 srp/012 srp/013 srp/015
>>>> user  :notice: [   44.706657] srp/001 (Create and remove LUNs)
>>>> user  :notice: [   44.718405] srp/001 (Create and remove LUNs)                             [passed]
>>>> user  :notice: [   44.729902]     runtime  ...  1.972s
>>>> user  :notice: [   99.038748] IPMI BMC is not supported on this machine, skip bmc-watchdog setup!
>>>> user  :notice: [ 3699.039790] Sat Aug  1 17:11:22 UTC 2020 detected soft_timeout
>>>> user  :notice: [ 3699.060341] kill 960 /usr/bin/time -v -o /tmp/lkp/blktests.time /lkp/lkp/src/tests/blktests
>>> Yamin and Max, can you take a look at this? The SRP tests from the
>>> blktests repository pass reliably with kernel version v5.7 and before.
>>> With label next-20200731 from linux-next however that test triggers the
>>> following hang:
>>
>> I will look into it.
> 
> FWIW, I ran into this as well with nvme-rdma, but it also reproduces
> when I revert the shared CQ patch from nvme-rdma. Another data point
> is that my tests passes with siw.

Hi Jason,

The patch below is sufficient to unbreak blktests. I think that the
deadlock while unloading rdma_rxe happens because the RDMA core waits for
all ib_dev references to be dropped before dealloc_driver is called.
The rdma_rxe dealloc_driver implementation drops an ib_dev reference. The
dealloc_driver callback was introduced by commit d0899892edd0
("RDMA/device: Provide APIs from the core code to help unregistration").
Do you agree that this regression has been introduced by commits
d0899892edd0 and c367074b6c37 ("RDMA/rxe: Use driver_unregister and new
unregistration API")?

Thanks,

Bart.

---
 drivers/infiniband/core/device.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index dca2842a7872..5192f305b253 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1287,13 +1287,8 @@ static void disable_device(struct ib_device *device)

 	/* Pairs with refcount_set in enable_device */
 	ib_device_put(device);
-	wait_for_completion(&device->unreg_completion);

-	/*
-	 * compat devices must be removed after device refcount drops to zero.
-	 * Otherwise init_net() may add more compatdevs after removing compat
-	 * devices and before device is disabled.
-	 */
+	/* To do: prevent init_net() to add more compat_devs. */
 	remove_compat_devs(device);
 }


