Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE500298832
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 09:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1771540AbgJZITu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 04:19:50 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:38087 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1771538AbgJZITt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Oct 2020 04:19:49 -0400
Received: by mail-pl1-f176.google.com with SMTP id f21so41987plr.5
        for <linux-rdma@vger.kernel.org>; Mon, 26 Oct 2020 01:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=zLk7Ed613/Zom2AmnbWVVf1MWjumGguLj5QVlpWRcVY=;
        b=WIOCtT2o135FfdED1CjccfYr+DL8Ks0Ux59T9wXYifgd0xLonvqpmAwL+a0eMjWHZd
         ML2e9o0XUbaoJeN0+OauoNTgaJ6fUQJDAnGE7ROXEhLPQiEcHQhvYWievcD5XQ6pcYKs
         jKLEfTrB208WnCbQfRSSLDZLGinsMPIYO29+rHxHgTuuw7q81NlcbAZn3DmA5a0/X5YL
         GdzQZx6t8lyqHcRIXWKzXBUPHcg5Zx1P2tT2cGRpvzDpqFfwG0XNNTgZ6Br8NeD1umDW
         jqLODXCBWzwJ/rtkDn4DJKG6VKRpGfILqjYX+RWQRAXPV1XaNsxIJO2KgqpBuEfFRwhy
         eSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=zLk7Ed613/Zom2AmnbWVVf1MWjumGguLj5QVlpWRcVY=;
        b=QlSXbJSXHaY8dsarxMRxXp9aUly6rZ2Sy0Hjw57UIS+X2oLtr+z/LY4E3QzFr0O0fy
         hws1YI6QbRPPseTNpvBllzsUjdjm5eKuTyxjF2x1AbOSkBlDisKWK4iUMtmqkem9MH12
         VDSyG5gN39kZeQybNP9Tq2kMaZB2mkBT28Xbb/M2hcTv2H+ByawXu0Zg2nCL2QzV9f7p
         QO6ncBm6JWL/qDqHdGDAWV08dSpTnWmcLA8SNj8t5IGY6tEeT9GoKh1+o6kTMBpB5S3r
         0Tr2dl5GXTBiB6fbZW2UJRBY69tYa8co4kmorPj2XoSJ5UzOuoGEbG/orSP7QxdW9QwM
         X5eQ==
X-Gm-Message-State: AOAM53336rjfBoMaid88wVQu3eYH/sg1afh0ctjvlgXEjhg0LIaH0cza
        4A00TiwYMktyAO3Ldl8jSTO9Qw==
X-Google-Smtp-Source: ABdhPJyYhmJDq8KxhWxpvHE23PhM16EPLFJFfR2fw687B0rEzM3UcaukhiwDfQeLPfPhIwpI+IKkkA==
X-Received: by 2002:a17:90a:4e0d:: with SMTP id n13mr8611529pjh.95.1603700387135;
        Mon, 26 Oct 2020 01:19:47 -0700 (PDT)
Received: from ?IPv6:240e:82:3:8c99:cde8:9978:8c8f:325c? ([240e:82:3:8c99:cde8:9978:8c8f:325c])
        by smtp.gmail.com with ESMTPSA id l3sm11369064pju.28.2020.10.26.01.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 01:19:46 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: Lock issue with 2a7cec53816 ("RDMA/cma: Fix locking for the
 RDMA_CM_CONNECT state")
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>
Message-ID: <3b1f7767-98e2-93e0-b718-16d1c5346140@cloud.ionos.com>
Date:   Mon, 26 Oct 2020 09:19:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason & Leon,


[Sorry to send again since the previous mail didn't hit the list]

With the mentioned commit, I got the below calltraces.

[ 1209.544359] INFO: task kworker/u8:3:615 blocked for more than 120 
seconds.
[ 1209.545170]       Tainted: G           O      5.9.0-rc8+ #30
[ 1209.545341] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1209.545814] task:kworker/u8:3    state:D stack:    0 pid:  615 
ppid:     2 flags:0x00004000
[ 1209.547601] Workqueue: rdma_cm cma_work_handler [rdma_cm]
[ 1209.548645] Call Trace:
[ 1209.552120]  __schedule+0x363/0x7b0
[ 1209.552903]  schedule+0x44/0xb0
[ 1209.553093]  schedule_preempt_disabled+0xe/0x10
[ 1209.553253]  __mutex_lock.isra.10+0x26d/0x4e0
[ 1209.553421]  __mutex_lock_slowpath+0x13/0x20
[ 1209.553596]  ? __mutex_lock_slowpath+0x13/0x20
[ 1209.553751]  mutex_lock+0x2f/0x40
[ 1209.554045]  rdma_connect+0x52/0x770 [rdma_cm]
[ 1209.554215]  ? vprintk_default+0x1f/0x30
[ 1209.554359]  ? vprintk_func+0x62/0x100
[ 1209.554532]  ? cma_cm_event_handler+0x2b/0xe0 [rdma_cm]
[ 1209.554688]  ? printk+0x52/0x6e
[ 1209.554852]  rtrs_clt_rdma_cm_handler+0x393/0x8b0 [rtrs_client]
[ 1209.555056]  cma_cm_event_handler+0x2b/0xe0 [rdma_cm]
[ 1209.561823]  ? cma_comp_exch+0x4e/0x60 [rdma_cm]
[ 1209.561883]  ? cma_cm_event_handler+0x2b/0xe0 [rdma_cm]
[ 1209.561940]  cma_work_handler+0x89/0xc0 [rdma_cm]
[ 1209.561988]  process_one_work+0x20c/0x400
[...]
[ 1209.562323] INFO: task bash:630 blocked for more than 120 seconds.
[ 1209.562368]       Tainted: G           O      5.9.0-rc8+ #30
[ 1209.562404] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1209.562456] task:bash            state:D stack:    0 pid:  630 
ppid:   618 flags:0x00004000
[ 1209.562515] Call Trace:
[ 1209.562559]  __schedule+0x363/0x7b0
[ 1209.562603]  schedule+0x44/0xb0
[ 1209.562642]  schedule_preempt_disabled+0xe/0x10
[ 1209.562685]  __mutex_lock.isra.10+0x26d/0x4e0
[ 1209.562727]  ? vprintk_func+0x62/0x100
[ 1209.562765]  ? vprintk_default+0x1f/0x30
[ 1209.562806]  __mutex_lock_slowpath+0x13/0x20
[ 1209.562847]  ? __mutex_lock_slowpath+0x13/0x20
[ 1209.562887]  mutex_lock+0x2f/0x40
[ 1209.562936]  rdma_destroy_id+0x31/0x60 [rdma_cm]
[ 1209.562983]  destroy_cm.isra.24+0x2d/0x50 [rtrs_client]
[ 1209.563586]  init_sess+0x23b/0xac0 [rtrs_client]
[ 1209.563691]  ? wait_woken+0x80/0x80
[ 1209.563742]  rtrs_clt_open+0x27f/0x540 [rtrs_client]
[ 1209.563791]  ? remap_devs+0x150/0x150 [rnbd_client]
[ 1209.563867]  find_and_get_or_create_sess+0x4a1/0x5e0 [rnbd_client]
[ 1209.563921]  ? remap_devs+0x150/0x150 [rnbd_client]
[ 1209.563966]  ? atomic_notifier_call_chain+0x1a/0x20
[ 1209.564011]  ? vt_console_print+0x203/0x3d0
[ 1209.564051]  ? up+0x32/0x50
[ 1209.564093]  ? __irq_work_queue_local+0x4f/0x60
[ 1209.564132]  ? irq_work_queue+0x1a/0x30
[ 1209.564169]  ? wake_up_klogd.part.28+0x34/0x40
[ 1209.564208]  ? vprintk_emit+0x126/0x2b0
[ 1209.564249]  ? vprintk_default+0x1f/0x30
[ 1209.564292]  rnbd_clt_map_device+0x74/0x7b0 [rnbd_client]
[ 1209.564341]  rnbd_clt_map_device_store+0x39e/0x6c0 [rnbd_client]

 From my understanding, it is caused by the rdma_connect need to hold 
the handler_mutex
again in the path.

cma_ib_handler -> mutex_lock(&id_priv->handler_mutex)
-> cma_cm_event_handler
                     -> id_priv->id.event_handler = rtrs_clt_rdma_cm_handler
-> rdma_connect
-> mutex_lock(&id_priv->handler_mutex)


And seems nvme rdma could have the same issue since rdma_connect is 
called by
nvme_rdma_cm_handler -> nvme_rdma_route_resolved.

Thanks,
Guoqing
