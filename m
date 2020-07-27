Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B18022F838
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jul 2020 20:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbgG0SrH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jul 2020 14:47:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36778 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgG0SrG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jul 2020 14:47:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id t6so8591457plo.3
        for <linux-rdma@vger.kernel.org>; Mon, 27 Jul 2020 11:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=auX5FuI4Qsx9E/mYVb0tH2+RJUVpN2LmIKY7fjo2gug=;
        b=HId6tA5TYkFiSHiwI3v4fXQH5wBUBJ4+dFWwbRTRsUs8O4vWgWckrxpwQcoy5lJY/0
         5y5GWs7BCviy0BgDnmsn+hcFTKFQqpo3t6GMbmxXtzen4JrFKmK+ebd4vyhYmkd7d6lg
         INqWlkJJQfZWFebkt9LCWFrqoJ2vdjM2+F0ama/T4j6azOWR8tC/cBGNkrzUIw5/udoI
         ZfD07GCegGrHM/MqsV2YBsYmPQkdPkV4w2F23XG3zLvLmyH34cqxKrkuoNBeAE3Y0poy
         CBmPk9bLsmLg+jIG+PfLUrr1hji6txw80yD7YV0zMr58nSkgskrOtPxLghSetUvCn09/
         RsfQ==
X-Gm-Message-State: AOAM531hgCWbWc/7sD2fjfo6/L4hVwT0JSyd5PtyAA8QQ1nwHJbXpC2s
        hKKHmoOm2xwqdQxXgGjjNe561nRZ
X-Google-Smtp-Source: ABdhPJzbebcDHPrQ9vGxQn2Isl+wk8s7i6YWcAQF+UWFO5UeS+W632FYNmBWgUxGCYPq+AvCb+N6Iw==
X-Received: by 2002:a17:902:c80c:: with SMTP id u12mr19778611plx.196.1595875625166;
        Mon, 27 Jul 2020 11:47:05 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d7d:f206:b163:f30b? ([2601:647:4802:9070:5d7d:f206:b163:f30b])
        by smtp.gmail.com with ESMTPSA id e191sm15783540pfh.42.2020.07.27.11.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 11:47:04 -0700 (PDT)
Subject: Re: Hang at NVME Host caused by Controller reset
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>,
        linux-nvme@lists.infradead.org
Cc:     linux-rdma@vger.kernel.org
References: <20200727181944.GA5484@chelsio.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9b8dae53-1fcc-3c03-5fcd-cfb55cd8cc80@grimberg.me>
Date:   Mon, 27 Jul 2020 11:47:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727181944.GA5484@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> kernel hang observed on NVME Host(TCP) while running iozone with link
> toggle:

Hi Krishnamraju,

Good timing, please see my patch:
[PATCH 1/2] nvme-tcp: fix controller reset hang during traffic

It will be great to get your tested-by.

> 
>      
> [ +42.773018] INFO: task kworker/u24:5:1243 blocked for more than 122
> seconds.
> [  +0.000124]       Not tainted 5.8.0-rc4ekr+ #19
> [  +0.000105] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  +0.000164] kworker/u24:5   D12600  1243      2 0x00004000
> [  +0.000114] Workqueue: nvme-reset-wq nvme_reset_ctrl_work [nvme_tcp]
> [  +0.000109] Call Trace:
> [  +0.000105]  __schedule+0x270/0x5d0
> [  +0.000105]  schedule+0x45/0xb0
> [  +0.000125]  blk_mq_freeze_queue_wait+0x41/0xa0
> [  +0.000122]  ? wait_woken+0x80/0x80
> [  +0.000116]  blk_mq_update_nr_hw_queues+0x8a/0x380
> [  +0.000109]  nvme_tcp_setup_ctrl+0x345/0x510 [nvme_tcp]
> [  +0.000108]  nvme_reset_ctrl_work+0x45/0x60 [nvme_tcp]
> [  +0.000135]  process_one_work+0x149/0x380
> [  +0.000107]  worker_thread+0x1ae/0x3a0
> [  +0.000107]  ? process_one_work+0x380/0x380
> [  +0.000108]  kthread+0xf7/0x130
> [  +0.000135]  ? kthread_bind+0x10/0x10
> [  +0.000121]  ret_from_fork+0x22/0x30
> [  +0.000134] INFO: task bash:6000 blocked for more than 122 seconds.
> [  +0.000122]       Not tainted 5.8.0-rc4ekr+ #19
> [  +0.000109] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  +0.000195] bash            D14232  6000   5967 0x00000080
> [  +0.000115] Call Trace:
> [  +0.000106]  __schedule+0x270/0x5d0
> [  +0.000138]  ? terminate_walk+0x8a/0x90
> [  +0.000123]  schedule+0x45/0xb0
> [  +0.000108]  schedule_timeout+0x1d6/0x290
> [  +0.000121]  wait_for_completion+0x82/0xe0
> [  +0.000120]  __flush_work.isra.37+0x10c/0x180
> [  +0.000115]  ? flush_workqueue_prep_pwqs+0x110/0x110
> [  +0.000119]  nvme_reset_ctrl_sync+0x1c/0x30 [nvme_core]
> [  +0.000110]  nvme_sysfs_reset+0xd/0x20 [nvme_core]
> [  +0.000137]  kernfs_fop_write+0x10a/0x1a0
> [  +0.000124]  vfs_write+0xa8/0x1a0
> [  +0.000122]  ksys_write+0x50/0xc0
> [  +0.000117]  do_syscall_64+0x3e/0x70
> [  +0.000108]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  +0.000111] RIP: 0033:0x7f4ed689dc60
> [  +0.000107] Code: Bad RIP value.
> [  +0.000105] RSP: 002b:00007ffe636b6fe8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000001
> [  +0.000188] RAX: ffffffffffffffda RBX: 0000000000000002 RCX:
> 00007f4ed689dc60
> ----
> 
> This issue got uncovered after commit fe35ec58f0d3, which does
> freeze-queue operation if set->nr_maps is greater than '1'(all nvmef
> trasnports sets nr_maps to '2' by default).
>    
> Issue will not occur with multipath enabled.
> Issue observed with RDMA transports also.
> 
> Steps to reproduce:
> nvme connect -t tcp -a 102.1.1.6 -s 4420 -n nvme-ram0 -i 1
> 
> Run below each while loop in different terminals parallelly, to reprodue
> instantaneously.
> while [ 1 ]; do echo 1 > /sys/block/nvme0n1/device/reset_controller;
> done
> while [ 1 ]; do  nvme write-zeroes /dev/nvme0n1 -s 1 -c 1; done
> 
> 
> 
> My understanding is: while performing reset-controller, nvme-write task
> tries to submit IO/blk_queue_enter, but fails at blk_mq_run_hw_queue()
> after seeing blk_queue_quiesced.
> And never succeeded to blk_queue_exit, may be due to out-of-sync percpu
> counter operations(q_usage_counter), causing this hang at freeze_queue.
> 
> Thanks,
> Krishna.
> 
