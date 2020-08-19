Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909CF249339
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Aug 2020 05:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgHSDID (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 23:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgHSDIC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 23:08:02 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A68C061389
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:08:02 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mw10so450098pjb.2
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Sb9vbApk6CCB20Zi+qR+drVkCzG+Jh/5puXQEl4JfcY=;
        b=ZheUj4oEUa9jkfC7MIzvwyIOt7CSsIju3fxqj61oZ8YurHStdJndVxmOdESqK7s1BF
         JEL5cm1x0te+6ivDYKWD/0tDxsLPSVuBDxdCE00qYw7rzXHt6eQfTpz294PBLTSUjNok
         9JfbOj77KqkTGzS2qSRU/fZ6cA6RvQcRoeWO9PYmZYh1d2Yr57gLX5TmE62yPf0ek6qu
         XQmyeL8UQRljHMPaLknpiwYQWel7oDmshMkf2unjnsADpzJG+r/MXYT72WEQJIvNKp2D
         vNR6mnbuR5BFCF17RqYsPcL8KCfY6wyDgoiBOqwU2Qkv2BzDoXlfxmweD+yqTntEXvPb
         HU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Sb9vbApk6CCB20Zi+qR+drVkCzG+Jh/5puXQEl4JfcY=;
        b=SnJDO9p6+xAEHM6cpkMNpZXBvf5HSixQg0eUOLLGyiBNwz4tWd3epxCAUXII2QSYUK
         XTsaxdm1PkzUCAK1zCMCDU1bIelXEpaMWwe5uHF2aFJFFrbP4w6gRU3JGCTT6DgQHYDi
         nvLGzh42mCbSEHZBU0waYBl8U7bY4d07AoJ39zWYCrcuuXafiUsYFk5vaIIlCq9Bw5er
         t+HywulEQ8BxxIHH74n+Dh9Ye8kPOlHWQB7qViHxQJMd2+uF5W62BuulKrhP2qXQJ1CA
         g9hCFa2xcB1WVYPNWdU71UoDM6T22zHKIZp3oC55PZG0FIhDTHA6xgmcnh8OICPMXYdH
         vntw==
X-Gm-Message-State: AOAM531qBQB3MlOuME/OHzvkriIOcnJoyfcgXcjNMNT+YLa/U2mxdhVL
        JfNs8zdWe2ZZX6dljXwFUzo=
X-Google-Smtp-Source: ABdhPJxWv2xGBQICiR/Igmn8a5Aj8C1L5m4cRszsabYpMWNATLEDB/W2lGP6bdaKM8MV6ItbDIv/Kw==
X-Received: by 2002:a17:90a:bc96:: with SMTP id x22mr2537807pjr.164.1597806482096;
        Tue, 18 Aug 2020 20:08:02 -0700 (PDT)
Received: from [10.75.201.17] ([118.201.220.138])
        by smtp.gmail.com with ESMTPSA id u3sm338206pjn.29.2020.08.18.20.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 20:08:01 -0700 (PDT)
Subject: Re: [PATCH for-rc] RDMA/rxe: Fix panic when calling
 kmem_cache_create()
To:     Leon Romanovsky <leon@kernel.org>,
        Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20200812111447.256822-1-kamalheib1@gmail.com>
 <9701a68d-c377-474a-5f65-c4e045a67e11@gmail.com>
 <20200816221236.GA821081@kheib-workstation>
 <a52afe9b-e474-5412-bf33-4f3a3690a322@gmail.com>
 <20200818055057.GA881164@kheib-workstation> <20200818074956.GM7555@unreal>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Message-ID: <31678b13-4db1-d454-a85c-1ba5c8029c41@gmail.com>
Date:   Wed, 19 Aug 2020 11:07:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200818074956.GM7555@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/18/2020 3:49 PM, Leon Romanovsky wrote:
> On Tue, Aug 18, 2020 at 08:50:57AM +0300, Kamal Heib wrote:
>> On Tue, Aug 18, 2020 at 09:48:43AM +0800, Zhu Yanjun wrote:
>>> On 8/17/2020 6:12 AM, Kamal Heib wrote:
>>>> On Sat, Aug 15, 2020 at 02:58:45PM +0800, Zhu Yanjun wrote:
>>>>> On 8/12/2020 7:14 PM, Kamal Heib wrote:
>>>>>> To avoid the following kernel panic when calling kmem_cache_create()
>>>>>> with a NULL pointer from pool_cache(),
>>>>> What is the root cause of this kernel panic?
>>>>>
>>>> The kernel panic is triggered using the following command and it happen
>>>> because the cache is not getting initialized.
>>>>
>>>> modprobe rdma_rxe add=eno1
>>>>
>>>> Thanks,
>>>> Kamal
>>>>
>>>>> Zhu Yanjun
>>>>>
>>>>>>     move the rxe_cache_init() to the
>>>>>> context of device creation.
>>>>>>
>>>>>>     BUG: unable to handle kernel NULL pointer dereference at 000000000000000b
>>>>>>     PGD 0 P4D 0
>>>>>>     Oops: 0000 [#1] SMP NOPTI
>>>>>>     CPU: 4 PID: 8512 Comm: modprobe Kdump: loaded Not tainted 4.18.0-231.el8.x86_64 #1
>>>>>>     Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 10/02/2018
>>>>>>     RIP: 0010:kmem_cache_alloc+0xd1/0x1b0
>>>>>>     Code: 8b 57 18 45 8b 77 1c 48 8b 5c 24 30 0f 1f 44 00 00 5b 48 89 e8 5d 41 5c 41 5d 41 5e 41 5f c3 81 e3 00 00 10 00 75 0e 4d 89 fe <41> f6 47 0b 04 0f 84 6c ff ff ff 4c 89 ff e8 cc da 01 00 49 89 c6
>>>>>>     RSP: 0018:ffffa2b8c773f9d0 EFLAGS: 00010246
>>>>>>     RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000005
>>>>>>     RDX: 0000000000000004 RSI: 00000000006080c0 RDI: 0000000000000000
>>>>>>     RBP: ffff8ea0a8634fd0 R08: ffffa2b8c773f988 R09: 00000000006000c0
>>>>>>     R10: 0000000000000000 R11: 0000000000000230 R12: 00000000006080c0
>>>>>>     R13: ffffffffc0a97fc8 R14: 0000000000000000 R15: 0000000000000000
>>>>>>     FS:  00007f9138ed9740(0000) GS:ffff8ea4ae800000(0000) knlGS:0000000000000000
>>>>>>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>     CR2: 000000000000000b CR3: 000000046d59a000 CR4: 00000000003406e0
>>>>>>     Call Trace:
>>>>>>      rxe_alloc+0xc8/0x160 [rdma_rxe]
>>>>>>      rxe_get_dma_mr+0x25/0xb0 [rdma_rxe]
>>>>>>      __ib_alloc_pd+0xcb/0x160 [ib_core]
>>>>>>      ib_mad_init_device+0x296/0x8b0 [ib_core]
>>>>>>      add_client_context+0x11a/0x160 [ib_core]
>>>>>>      enable_device_and_get+0xdc/0x1d0 [ib_core]
>>>>>>      ib_register_device+0x572/0x6b0 [ib_core]
>>>>>>      ? crypto_create_tfm+0x32/0xe0
>>>>>>      ? crypto_create_tfm+0x7a/0xe0
>>>>>>      ? crypto_alloc_tfm+0x58/0xf0
>>>>>>      rxe_register_device+0x19d/0x1c0 [rdma_rxe]
>>>>>>      rxe_net_add+0x3d/0x70 [rdma_rxe]
>>>>>>      ? dev_get_by_name_rcu+0x73/0x90
>>>>>>      rxe_param_set_add+0xaf/0xc0 [rdma_rxe]
>>>>>>      parse_args+0x179/0x370
>>>>>>      ? ref_module+0x1b0/0x1b0
>>>>>>      load_module+0x135e/0x17e0
>>>>>>      ? ref_module+0x1b0/0x1b0
>>>>>>      ? __do_sys_init_module+0x13b/0x180
>>>>>>      __do_sys_init_module+0x13b/0x180
>>>>>>      do_syscall_64+0x5b/0x1a0
>>>>>>      entry_SYSCALL_64_after_hwframe+0x65/0xca
>>>>>>     RIP: 0033:0x7f9137ed296e
>>>>>>
>>>>>> Fixes: 8700e3e7c485 ("Soft RoCE driver")
>>>>>> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>>>>>> ---
>>>>>>     drivers/infiniband/sw/rxe/rxe.c       | 14 +++++++-------
>>>>>>     drivers/infiniband/sw/rxe/rxe_pool.c  |  3 +++
>>>>>>     drivers/infiniband/sw/rxe/rxe_sysfs.c |  7 +++++++
>>>>>>     3 files changed, 17 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
>>>>>> index 5642eefb4ba1..60d5086dd34d 100644
>>>>>> --- a/drivers/infiniband/sw/rxe/rxe.c
>>>>>> +++ b/drivers/infiniband/sw/rxe/rxe.c
>>>>>> @@ -318,6 +318,13 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
>>>>>>     		goto err;
>>>>>>     	}
>>>>>> +	/* initialize slab caches for managed objects */
>>>>>> +	err = rxe_cache_init();
>>>>>> +	if (err) {
>>>>>> +		pr_err("unable to init object pools\n");
>>>>>> +		goto err;
>>>>>> +	}
>>>>>> +
>>>>>>     	err = rxe_net_add(ibdev_name, ndev);
>>>>>>     	if (err) {
>>>>>>     		pr_err("failed to add %s\n", ndev->name);
>>>>>> @@ -336,13 +343,6 @@ static int __init rxe_module_init(void)
>>>>>>     {
>>>>>>     	int err;
>>>>>> -	/* initialize slab caches for managed objects */
>>>>>> -	err = rxe_cache_init();
>>> When modprobe rdma_rxe, rxe_module_init should be called. Then
>>> rxe_cache_init should be also called.
>>>
>>> Why does the above call trace occur?
>>>
>>> Zhu Yanjun
>>>
>> As you can see in the call trace attached to the commit message, When
>> running the "modprobe rdma_rxe add=eno1" command the rxe_param_set_add()
>> is called before rxe_module_init() (without init the caches), so the
>> call trace occurs when trying to register the allocated rxe device from
>> the context of rxe_param_set_add() without initialize the caches.
> I would expect the fix being in rxe_init() instead of putting calls to
> rxe_cache_init() in all places.

I agree with you.

Is it possible to make rxe_module_init be called before rxe_param_set_add?

Thanks

>
> Thanks


