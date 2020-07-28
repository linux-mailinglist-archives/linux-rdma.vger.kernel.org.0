Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DA72311CF
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jul 2020 20:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgG1Sf5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jul 2020 14:35:57 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35789 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbgG1Sf5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jul 2020 14:35:57 -0400
Received: by mail-pj1-f66.google.com with SMTP id il6so362453pjb.0
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jul 2020 11:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9i5BBHREORuTzj8FAN14ckMlGcQgcgOsiBwHPLWsVpE=;
        b=ugyjOhXoO3mTJE2JRrStG30uzFtb0/PESgmm4VAMiZWhhvjk7IIiA/rlRVXaKX02bL
         Oat7D9/7xFCSpzlL9Z/+YvODIzExAmcXdmffmO02HmUm90UURNgFic1hApE/gHU05QHO
         asWZbrlGCsXYMXbVt7ZyoxV/nitFu3+ZiFWkD1YxuKFLlovAfTetok38ycS7H+Dr6D8H
         fEXW1EuY53YQI8DBJR7VgPjTs1fFBj7U2GAZq9TqzYFjvHsv8x9dRs1PWLNoNjWP1dsr
         8tcHgJJi22RX1ijuTGPWwWysRXHH+6aDW5RR/0cr8grYwTBddtdKLZ+BkPx1WQ9tDO/p
         nGXA==
X-Gm-Message-State: AOAM530D8klxCT6jp9I/hFy4VgKKUungHyMNJOFOca/IZ5X1MZV2zvP5
        U7OAwmoaKTcEMaI0AUzHEJ+iimLQ
X-Google-Smtp-Source: ABdhPJwJV/Nd3Zr81y3cR4096NvjviTeoZrcTQ//uuEkvRbHfzsey1tjXRxCYL7+JA/op/f/XWhQUA==
X-Received: by 2002:a17:902:6b08:: with SMTP id o8mr24268973plk.104.1595961356381;
        Tue, 28 Jul 2020 11:35:56 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:541c:8b1b:5ac:35fe? ([2601:647:4802:9070:541c:8b1b:5ac:35fe])
        by smtp.gmail.com with ESMTPSA id s194sm19172559pgs.24.2020.07.28.11.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 11:35:55 -0700 (PDT)
Subject: Re: Hang at NVME Host caused by Controller reset
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>
Cc:     linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        bharat@chelsio.com
References: <20200727181944.GA5484@chelsio.com>
 <9b8dae53-1fcc-3c03-5fcd-cfb55cd8cc80@grimberg.me>
 <20200728115904.GA5508@chelsio.com>
 <4d87ffbb-24a2-9342-4507-cabd9e3b76c2@grimberg.me>
 <20200728174224.GA5497@chelsio.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3963dc58-1d64-b6e1-ea27-06f3030d5c6e@grimberg.me>
Date:   Tue, 28 Jul 2020 11:35:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728174224.GA5497@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Sagi,
> 
> Yes, Multipath is disabled.

Thanks.

> This time, with "nvme-fabrics: allow to queue requests for live queues"
> patch applied, I see hang only at blk_queue_enter():

Interesting, does the reset loop hang? or is it able to make forward
progress?

> [Jul28 17:25] INFO: task nvme:21119 blocked for more than 122 seconds.
> [  +0.000061]       Not tainted 5.8.0-rc7ekr+ #2
> [  +0.000052] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  +0.000059] nvme            D14392 21119   2456 0x00004000
> [  +0.000059] Call Trace:
> [  +0.000110]  __schedule+0x32b/0x670
> [  +0.000108]  schedule+0x45/0xb0
> [  +0.000107]  blk_queue_enter+0x1e9/0x250
> [  +0.000109]  ? wait_woken+0x70/0x70
> [  +0.000110]  blk_mq_alloc_request+0x53/0xc0
> [  +0.000111]  nvme_alloc_request+0x61/0x70 [nvme_core]
> [  +0.000121]  nvme_submit_user_cmd+0x50/0x310 [nvme_core]
> [  +0.000118]  nvme_user_cmd+0x12e/0x1c0 [nvme_core]
> [  +0.000163]  ? _copy_to_user+0x22/0x30
> [  +0.000113]  blkdev_ioctl+0x100/0x250
> [  +0.000115]  block_ioctl+0x34/0x40
> [  +0.000110]  ksys_ioctl+0x82/0xc0
> [  +0.000109]  __x64_sys_ioctl+0x11/0x20
> [  +0.000109]  do_syscall_64+0x3e/0x70
> [  +0.000120]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  +0.000112] RIP: 0033:0x7fbe9cdbb67b
> [  +0.000110] Code: Bad RIP value.
> [  +0.000124] RSP: 002b:00007ffd61ff5778 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [  +0.000170] RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
> 00007fbe9cdbb67b
> [  +0.000114] RDX: 00007ffd61ff5780 RSI: 00000000c0484e43 RDI:
> 0000000000000003
> [  +0.000113] RBP: 0000000000000000 R08: 0000000000000001 R09:
> 0000000000000000
> [  +0.000115] R10: 0000000000000000 R11: 0000000000000246 R12:
> 00007ffd61ff7219
> [  +0.000123] R13: 0000000000000006 R14: 00007ffd61ff5e30 R15:
> 000055e09c1854a0
> [  +0.000115] Kernel panic - not syncing: hung_task: blocked tasks

For some reason the ioctl is not woken up when unfreezing the queue...

> You could easily reproduce this by running below, parallelly, for 10min:
>   while [ 1 ]; do  nvme write-zeroes /dev/nvme0n1 -s 1 -c 1; done
>   while [ 1 ]; do echo 1 > /sys/block/nvme0n1/device/reset_controller;
> done
>   while [ 1 ]; do ifconfig enp2s0f4 down; sleep 24; ifconfig enp2s0f4 up;
> sleep 28; done
>   
>   Not sure using nvme-write this way is valid or not..

sure it is, its I/O just like fs I/O.
