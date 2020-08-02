Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4629D2357E3
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Aug 2020 17:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgHBPFj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 2 Aug 2020 11:05:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41101 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgHBPFi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 2 Aug 2020 11:05:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id s15so6976397pgc.8;
        Sun, 02 Aug 2020 08:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=msdliJO2IbDt9fUvTQtaMAo5AQDTY3VgWmqB/7DohRs=;
        b=Gw2wi/ABKdwh537AQJdzFAkc86BK0guXVHY45V1mfM+rSdJHv1s1T85zK3a/0IGqIL
         iZYLNvlZgjo+EAAUglHWKqMH6IuH5cmdG0UQyrpxl5MX4skGOD8LNiCLKFsZW1qpTUnI
         R8MxyGDbJIlhqh1w/8OLtaWKGHywqMSGG6kgoSwL5FtpQEvV4hsH7Ab3nIa0kbXwOFL1
         /RS4iLoL0YiuBM3Y3RCkQPbED5Lq4LyHLS/Kk6FKokdeoqAybqjDeyf2v4brs6xe9S5M
         bi0B4WcgzUf+8n+AapnKL49JCE4UbhQhEc6s4r8GETbQaV+inm1TLDVjmumEcVeS56Ip
         Ms5w==
X-Gm-Message-State: AOAM532aAMKLfyDIs9jLy+MWehfjwjKmmZ4dodBeSBurp7BsTY9qzsBL
        m/Sxf9HNg5brRr/srzSWlKU=
X-Google-Smtp-Source: ABdhPJzT2SsNB+d3k6f33KWUfzGcNgob9bgaWi0egAE5zzBdoTLDHtbsrx0hk9sEQvILUexPJrdX9A==
X-Received: by 2002:a62:2bd0:: with SMTP id r199mr11636558pfr.160.1596380737528;
        Sun, 02 Aug 2020 08:05:37 -0700 (PDT)
Received: from [192.168.3.219] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id b78sm17800303pfb.144.2020.08.02.08.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2020 08:05:36 -0700 (PDT)
Subject: Re: [IB/srpt] c804af2c1d: last_state.test.blktests.exit_code.143
To:     kernel test robot <rong.a.chen@intel.com>,
        Yamin Friedman <yaminf@mellanox.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Max Gurtovoy <maxg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org, lkp@lists.01.org
References: <20200802060925.GW23458@shao2-debian>
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
Message-ID: <f8ef3284-4646-94d9-7eea-14ac0873b03b@acm.org>
Date:   Sun, 2 Aug 2020 08:05:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200802060925.GW23458@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-08-01 23:09, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: c804af2c1d3152c0cf877eeb50d60c2d49ac0cf0 ("IB/srpt: use new shared CQ mechanism")
> https://git.kernel.org/cgit/linux/kernel/git/rdma/rdma.git for-next
> 
> 
> in testcase: blktests
> with following parameters:
> 
> 	test: srp-group1
> 	ucode: 0x21
> 
> 
> 
> on test machine: 4 threads Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 4G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> user  :notice: [   44.688140] 2020-08-01 16:10:22 ./check srp/001 srp/002 srp/003 srp/004 srp/005 srp/006 srp/007 srp/008 srp/009 srp/010 srp/011 srp/012 srp/013 srp/015
> user  :notice: [   44.706657] srp/001 (Create and remove LUNs)                            
> user  :notice: [   44.718405] srp/001 (Create and remove LUNs)                             [passed]
> user  :notice: [   44.729902]     runtime  ...  1.972s
> user  :notice: [   99.038748] IPMI BMC is not supported on this machine, skip bmc-watchdog setup!
> user  :notice: [ 3699.039790] Sat Aug  1 17:11:22 UTC 2020 detected soft_timeout
> user  :notice: [ 3699.060341] kill 960 /usr/bin/time -v -o /tmp/lkp/blktests.time /lkp/lkp/src/tests/blktests 

Yamin and Max, can you take a look at this? The SRP tests from the
blktests repository pass reliably with kernel version v5.7 and before.
With label next-20200731 from linux-next however that test triggers the
following hang:

sd 8:0:0:0: [sda] Synchronizing SCSI cache
rdma_rxe: not configured on eth0
rdma_rxe: not configured on lo
INFO: task modprobe:1894 blocked for more than 122 seconds.
      Not tainted 5.8.0-rc7-next-20200731-dbg+ #3
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
modprobe        D27624  1894   1081 0x00004000
Call Trace:
 __schedule+0x4ee/0x1170
 schedule+0x7f/0x170
 schedule_timeout+0x453/0x6f0
 wait_for_completion+0x126/0x1b0
 disable_device+0x12a/0x1c0 [ib_core]
 __ib_unregister_device+0x64/0x100 [ib_core]
 ib_unregister_driver+0x11c/0x180 [ib_core]
 rxe_module_exit+0x1e/0x36 [rdma_rxe]
 __x64_sys_delete_module+0x22a/0x310
 do_syscall_64+0x36/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f8d0e0c8a3b
Code: Bad RIP value.
RSP: 002b:00007ffe8238f798 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
RAX: ffffffffffffffda RBX: 000055a2c7d9be80 RCX: 00007f8d0e0c8a3b
RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055a2c7d9bee8
RBP: 000055a2c7d9be80 R08: 0000000000000000 R09: 0000000000000000
R10: 00007f8d0e144ac0 R11: 0000000000000206 R12: 000055a2c7d9bee8
R13: 0000000000000000 R14: 000055a2c7d9bee8 R15: 000055a2c7d9be80

Showing all locks held in the system:
1 lock held by khungtaskd/53:
 #0: ffffffff82895880 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x37/0x20f
1 lock held by modprobe/1894:
 #0: ffff8881c5e8c660 (&device->unregistration_lock){+.+.}-{3:3}, at: __ib_unregister_device+0x23/0x100 [ib_core]

=============================================
INFO: task modprobe:1894 blocked for more than 245 seconds.
      Not tainted 5.8.0-rc7-next-20200731-dbg+ #3
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
modprobe        D27624  1894   1081 0x00004000
Call Trace:
 __schedule+0x4ee/0x1170
 schedule+0x7f/0x170
 schedule_timeout+0x453/0x6f0
 wait_for_completion+0x126/0x1b0
 disable_device+0x12a/0x1c0 [ib_core]
 __ib_unregister_device+0x64/0x100 [ib_core]
 ib_unregister_driver+0x11c/0x180 [ib_core]
 rxe_module_exit+0x1e/0x36 [rdma_rxe]
 __x64_sys_delete_module+0x22a/0x310
 do_syscall_64+0x36/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f8d0e0c8a3b
Code: Bad RIP value.
RSP: 002b:00007ffe8238f798 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
RAX: ffffffffffffffda RBX: 000055a2c7d9be80 RCX: 00007f8d0e0c8a3b
RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055a2c7d9bee8
RBP: 000055a2c7d9be80 R08: 0000000000000000 R09: 0000000000000000
R10: 00007f8d0e144ac0 R11: 0000000000000206 R12: 000055a2c7d9bee8
R13: 0000000000000000 R14: 000055a2c7d9bee8 R15: 000055a2c7d9be80

Showing all locks held in the system:
1 lock held by khungtaskd/53:
 #0: ffffffff82895880 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x37/0x20f
no locks held by systemd-journal/241.
1 lock held by modprobe/1894:
 #0: ffff8881c5e8c660 (&device->unregistration_lock){+.+.}-{3:3}, at: __ib_unregister_device+0x23/0x100 [ib_core]

=============================================
