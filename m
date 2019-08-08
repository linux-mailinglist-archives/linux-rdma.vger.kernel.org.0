Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89C27865CD
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2019 17:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732698AbfHHPcF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Aug 2019 11:32:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43739 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732680AbfHHPcE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Aug 2019 11:32:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so20782763wru.10
        for <linux-rdma@vger.kernel.org>; Thu, 08 Aug 2019 08:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CD6KKcY7G7jWgcxBwdqLDNxOp3UBFMpaDOGLJorY9Qo=;
        b=Vz6ldKhFcbhyoZe6jl24AKB6NMg/ZC45oVQJLyPcW8edLVisBgPwtW5GrYp6GnTfl8
         45tbDNOF+OV98RFDBCRV7hcVOrTPX6OJzhN2cZUtSVGYIHRpGlDLns8vV81bCQYlGQKg
         I2aK3nxbhofe/YqHhUmDfnUnxoVH2X5LxkiGQWr0dD8nNl5TELnfVa6V8E2+zbfHd1zN
         Pmplj+8wtqJs95XKhuPiktc4dGSdj8eJhpaANxtOXc1scjvhuiCNio8iSlHYgHSrUgOV
         HPBhNPHwkQ7JaJG151vpf9nrUv4KRIuQ7upI+NQ7IQY03ALOKhEyk2OGfp06d61QfLhH
         pssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CD6KKcY7G7jWgcxBwdqLDNxOp3UBFMpaDOGLJorY9Qo=;
        b=IP2Y2sn4ow5SxV4jKk1LvdXX99qbcB/TbnZ4Fa9/he27ac5lwWVKWMXsmntcOoBMDC
         fHDDWOAkLuGTqZ7ajk3ymmeBNwiiwncAP5TLpsvJFtb4fIaa+T+Jn4W6wjl2kJYkzw+x
         jPgRPm48OGSwo/tnY3rXJt5rdAgUxU9nbay+4H8C7mIBGnYkSk7B7v/rt4LtaOor52U1
         hjZLfhaZMM6U+o+esiCZlJTze1A9HMj4/YGvaF6JPR/jBsBXFK2w/quiFeqIx1eaZlwH
         nEohLbQN+ceU3MF1eUXqKm208OtJdiOkaHwodVNNxgt56aNKeYd/YZDEkTPg/7PDN+6x
         JaUA==
X-Gm-Message-State: APjAAAVl7mivLRCO7Kh+4/Z01lEubjcNS9yqRmwrKPQtYYgQ72AnoWam
        /YVTLyw6rl0YEOhEtrQLYjt/01BPRIg=
X-Google-Smtp-Source: APXvYqxfjykg9ZQVzc7zuRhMND/E3J25HttA3irx57d4F6GWJq6ieRTi/Hf9eT5q7U7GeR+gx6zw3w==
X-Received: by 2002:a5d:4403:: with SMTP id z3mr18318571wrq.29.1565278321723;
        Thu, 08 Aug 2019 08:32:01 -0700 (PDT)
Received: from [10.80.2.155] ([193.47.165.251])
        by smtp.googlemail.com with ESMTPSA id s3sm3287243wmh.27.2019.08.08.08.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 08:32:01 -0700 (PDT)
Subject: Re: [PATCH rdma-rc] IB/mlx5: Fix use-after-free error while accessing
 ev_file pointer
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
References: <20190808081538.28772-1-leon@kernel.org>
 <20190808122615.GC1975@mellanox.com>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <869b1416-a87b-f361-7722-bf9d231bc262@dev.mellanox.co.il>
Date:   Thu, 8 Aug 2019 18:32:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190808122615.GC1975@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/8/2019 3:26 PM, Jason Gunthorpe wrote:
> On Thu, Aug 08, 2019 at 11:15:38AM +0300, Leon Romanovsky wrote:
>> From: Yishai Hadas <yishaih@mellanox.com>
>>
>> Call to uverbs_close_fd() releases file pointer to 'ev_file' and
>> mlx5_ib_dev is going to be inaccessible. Cache pointer prior cleaning
>> resources to solve the KASAN warning below.
>>
>> BUG: KASAN: use-after-free in devx_async_event_close+0x391/0x480 [mlx5_ib]
>> Read of size 8 at addr ffff888301e3cec0 by task devx_direct_tes/4631
>> CPU: 1 PID: 4631 Comm: devx_direct_tes Tainted: G OE 5.3.0-rc1-for-upstream-dbg-2019-07-26_01-19-56-93 #1
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu2 04/01/2014
>> Call Trace:
>> dump_stack+0x9a/0xeb
>> print_address_description+0x1e2/0x400
>> ? devx_async_event_close+0x391/0x480 [mlx5_ib]
>> __kasan_report+0x15c/0x1df
>> ? devx_async_event_close+0x391/0x480 [mlx5_ib]
>> kasan_report+0xe/0x20
>> devx_async_event_close+0x391/0x480 [mlx5_ib]
>> __fput+0x26a/0x7b0
>> task_work_run+0x10d/0x180
>> exit_to_usermode_loop+0x137/0x160
>> do_syscall_64+0x3c7/0x490
>> entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x7f5df907d664
>> Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f
>> 80 00 00 00 00 8b 05 6a cd 20 00 48 63 ff 85 c0 75 13 b8
>> 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 44 f3 c3 66 90
>> 48 83 ec 18 48 89 7c 24 08 e8
>> RSP: 002b:00007ffd353cb958 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
>> RAX: 0000000000000000 RBX: 000056017a88c348 RCX: 00007f5df907d664
>> RDX: 00007f5df969d400 RSI: 00007f5de8f1ec90 RDI: 0000000000000006
>> RBP: 00007f5df9681dc0 R08: 00007f5de8736410 R09: 000056017a9d2dd0
>> R10: 000000000000000b R11: 0000000000000246 R12: 00007f5de899d7d0
>> R13: 00007f5df96c4248 R14: 00007f5de8f1ecb0 R15: 000056017ae41308
>>
>> Allocated by task 4631:
>> save_stack+0x19/0x80
>> kasan_kmalloc.constprop.3+0xa0/0xd0
>> alloc_uobj+0x71/0x230 [ib_uverbs]
>> alloc_begin_fd_uobject+0x2e/0xc0 [ib_uverbs]
>> rdma_alloc_begin_uobject+0x96/0x140 [ib_uverbs]
>> ib_uverbs_run_method+0xdf0/0x1940 [ib_uverbs]
>> ib_uverbs_cmd_verbs+0x57e/0xdb0 [ib_uverbs]
>> ib_uverbs_ioctl+0x177/0x260 [ib_uverbs]
>> do_vfs_ioctl+0x18f/0x1010
>> ksys_ioctl+0x70/0x80
>> __x64_sys_ioctl+0x6f/0xb0
>> do_syscall_64+0x95/0x490
>> entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> Freed by task 4631:
>> save_stack+0x19/0x80
>> __kasan_slab_free+0x11d/0x160
>> slab_free_freelist_hook+0x67/0x1a0
>> kfree+0xb9/0x2a0
>> uverbs_close_fd+0x118/0x1c0 [ib_uverbs]
>> devx_async_event_close+0x28a/0x480 [mlx5_ib]
>> __fput+0x26a/0x7b0
>> task_work_run+0x10d/0x180
>> exit_to_usermode_loop+0x137/0x160
>> do_syscall_64+0x3c7/0x490
>> entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> The buggy address belongs to the object at ffff888301e3cda8
>> which belongs to the cache kmalloc-512 of size 512
>> The buggy address is located 280 bytes inside of 512-byte region
>> [ffff888301e3cda8, ffff888301e3cfa8)
>> The buggy address belongs to the page:
>> page:ffffea000c078e00 refcount:1 mapcount:0
>> mapping:ffff888352811300 index:0x0 compound_mapcount: 0
>> flags: 0x2fffff80010200(slab|head)
>> raw: 002fffff80010200 ffffea000d152608 ffffea000c077808 ffff888352811300
>> raw: 0000000000000000 0000000000250025 00000001ffffffff 0000000000000000
>> page dumped because: kasan: bad access detected
>> Memory state around the buggy address:
>> ffff888301e3cd80: fc fc fc fc fc fb fb fb fb fb fb fb fb fb fb fb
>> ffff888301e3ce00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ffff888301e3ce80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ffff888301e3cf00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ffff888301e3cf80: fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc
>> Disabling lock debugging due to kernel taint
>>
>> Cc: <stable@vger.kernel.org> # 5.2
>> Fixes: 759738537142 ("IB/mlx5: Enable subscription for device events over DEVX")
>> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
>> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>>   drivers/infiniband/hw/mlx5/devx.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
>> index 2d1b3d9609d9..af5bbb35c058 100644
>> +++ b/drivers/infiniband/hw/mlx5/devx.c
>> @@ -2644,12 +2644,13 @@ static int devx_async_event_close(struct inode *inode, struct file *filp)
>>   	struct devx_async_event_file *ev_file = filp->private_data;
> 
> This line is wrong, it should be
> 
>    	struct devx_async_event_file *ev_file = container_of(struct
>   	                   devx_async_event_file, filp->private_data, uobj);

You suggested the below 2 lines instead of the above one line, correct ? 
as struct devx_async_event_file wraps uobj as its first field this is 
logically equal, agree ?

struct ib_uobject *uobj = filp->private_data;
struct devx_async_event_file *ev_file = container_of(struct
    	          devx_async_event_file, filp->private_data, uobj);

> 
> It should get fixed in a followup, along with any other places like
> it.
> 

This can be done if you prefer the extra line pointed above.

> It is also a bit redundant to store the mlx5_ib_dev in the
> devx_async_event_file as uobj->ucontext->dev is the same pointer.
> 

Post hot unplug uobj->ucontext might not be accessible, isn't it ?
Current code should be fine for that.

> Otherwise this patch is Ok
> 
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> 

Thanks.
Are we fine to take this patch ?

Yishai
