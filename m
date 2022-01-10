Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B320489726
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jan 2022 12:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244520AbiAJLQR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jan 2022 06:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244539AbiAJLPx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jan 2022 06:15:53 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C80C06175D
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jan 2022 03:15:52 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id x4so879767wru.7
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jan 2022 03:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3zCZeq1YfrwfNpurPrffAnuWbNebuZkXvppZ0HJsuMM=;
        b=IytnJCooamEpvXhz5Zg+VCWZomAiLY8bvHFqu0uZFs/rNmd6uRMnnZ+17ginoyqJBr
         piA7Kc4HdGUlZcIiAla1M8tXtTCSzTzsZyKjrkdUILsEQthDnf0k7iMaJKxenFEv2jnm
         58h5RCR0rYbvMaILmZE8lIll/wZZosf2w+czrSjmK/wMd+PNcqDpqp7MOjw9Wlf0Tj6a
         JEh+Z31qW25QMoyyr/q/tc//hAMoiZ6R2qqMyXddsalytpqt23xyQP3KBEiBmvNo7X4k
         6ZCr/YuvL5iSdVFLnym5HPF7QOlf+R6i/3gt069FX2tueLsNDAFMcQVkmUunUoZCVwEu
         rcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3zCZeq1YfrwfNpurPrffAnuWbNebuZkXvppZ0HJsuMM=;
        b=8RTME2dMPkH9TdIKkjB45h0lL2/MV7TwewqI5cYuLTwvg3adVS9UuGreGg5GeCnIFK
         KrOSi413z9VknZvaf4EATtJw8uaslLRtLQSMWa3kGdbIqIn1xLRBxyRHtYDuOHjLD9SD
         7kPsGc8HC9EzmSlQ8COl5WTyntxDPcZBmb1ZBbhgOcObvZm07Cejatz/XpmHDcJeHJLe
         Lc8xXpW0YzVHKZhcnEPysJvX1M6HZTIgulnb5BRLzOPNhdeFYsn6h7GlB+eSWFM9chZW
         ZcDr3SDan7bIrUjr5yQfHQ+kMRBVPc2EjXPsmMqUTn7cc85cE94h/cdcXGOow6RTVIZW
         IAfA==
X-Gm-Message-State: AOAM531VSbofjRgQUnlzb4x32TGQcv8jGMRqqI/y4NPNpKzYzC/PcVGt
        s5VQSVBPL6G89kDI+NPGdLfQxA==
X-Google-Smtp-Source: ABdhPJyKXoZRZJL3WRFJ1cFt3/bsFsemHXkhNpXIzbV0Kd7MaZgee97OkQsgoE15KZcFCt9vs9dpyA==
X-Received: by 2002:a5d:4609:: with SMTP id t9mr6926861wrq.551.1641813350970;
        Mon, 10 Jan 2022 03:15:50 -0800 (PST)
Received: from google.com ([31.124.24.179])
        by smtp.gmail.com with ESMTPSA id m7sm825551wmi.13.2022.01.10.03.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 03:15:50 -0800 (PST)
Date:   Mon, 10 Jan 2022 11:15:55 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     kvartet <xyru1999@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Anand Khoje <anand.a.khoje@oracle.com>,
        Gal Pressman <galpress@amazon.com>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        Mark Bloch <mbloch@nvidia.com>,
        Parav Pandit <parav@nvidia.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        sunhao.th@gmail.com
Subject: Re: INFO: task hung in add_one_compat_dev
Message-ID: <YdwVaxb1Qsf31lxK@google.com>
References: <CAFkrUsizocCypDTb059euzP9g0WEq+MOsjYEOZRpk17-=eDW_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFkrUsizocCypDTb059euzP9g0WEq+MOsjYEOZRpk17-=eDW_g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 04 Jan 2022, kvartet wrote:

> Hello,
> 
> When using Syzkaller to fuzz the latest Linux kernel, the following
> crash was triggered.

Why was this sent to me?

> HEAD commit: a7904a538933 Linux 5.16-rc6
> git tree: upstream
> console output: https://paste.ubuntu.com/p/b6z4q5NnV6/plain/
> kernel config: https://paste.ubuntu.com/p/FDDNHDxtwz/plain/
> 
> Sorry, I don't have a reproducer for this crash, hope the symbolized
> report can help.
> 
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Yiru Xu <xyru1999@gmail.com>
> 
> 
> INFO: task syz-executor.5:32436 blocked for more than 143 seconds.
>       Not tainted 5.16.0-rc6 #9
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor.5  state:D stack:24768 pid:32436 ppid:  6788 flags:0x00004000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:4972 [inline]
>  __schedule+0xcd9/0x2530 kernel/sched/core.c:6253
>  schedule+0xd2/0x260 kernel/sched/core.c:6326
>  schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
>  __mutex_lock_common kernel/locking/mutex.c:680 [inline]
>  __mutex_lock+0xc48/0x1610 kernel/locking/mutex.c:740
>  add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
>  add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
>  rdma_dev_init_net+0x28b/0x480 drivers/infiniband/core/device.c:1184
>  ops_init+0xaf/0x420 net/core/net_namespace.c:140
>  setup_net+0x415/0xa40 net/core/net_namespace.c:326
>  copy_net_ns+0x2d9/0x660 net/core/net_namespace.c:470
>  create_new_namespaces.isra.0+0x3cb/0xae0 kernel/nsproxy.c:110
>  copy_namespaces+0x391/0x450 kernel/nsproxy.c:178
>  copy_process+0x2d37/0x73e0 kernel/fork.c:2194
>  kernel_clone+0xe7/0x10c0 kernel/fork.c:2582
>  __do_sys_clone3+0x1c9/0x2e0 kernel/fork.c:2857
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7ff4fe91489d
> RSP: 002b:00007ff4fd285c28 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
> RAX: ffffffffffffffda RBX: 00007ff4fea33f60 RCX: 00007ff4fe91489d
> RDX: 0000000000000000 RSI: 0000000000000058 RDI: 0000000020000440
> RBP: 00007ff4fe98100d R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fff3b67e98f R14: 00007ff4fea33f60 R15: 00007ff4fd285dc0

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
