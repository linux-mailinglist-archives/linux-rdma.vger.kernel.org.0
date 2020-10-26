Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6B5298A5E
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 11:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1769737AbgJZK2K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 06:28:10 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:41755 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1768422AbgJZK2J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Oct 2020 06:28:09 -0400
Received: by mail-ed1-f48.google.com with SMTP id l24so8678590edj.8
        for <linux-rdma@vger.kernel.org>; Mon, 26 Oct 2020 03:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=copLvvrJbazdXyqzCxJJdZkQMy9u28Uu7XeADF/luNk=;
        b=E2zfUpFIQqp9ywAEKRF009lVB3iwH3Qp3TrUZvNi3W+LCCdLdbt7WIwrnuVgZ2uZAf
         lNy4UYrAKpZxovIDLGKtY2AzlXbyAdLNU168hFv3Jb7NLdLYEgb9Tlw6Yx3NOf6TTRcn
         urIuno0pIpKuBn/vmrMuaTePlB17Mm2KFZ8Vu9EFKBjMSZYWbUitFEcQ/UtGenhm2S8/
         abqGffkI59+heAKtty/eR5jpwMBK+31Vp29Dmo1grr1u/gPUtYaga3jbuQIurXtggqkX
         N+SvEeNvHq03anJfjLNvuykhGOh6VTM5xvNRQVspCrnFJqIhNrFOYf8dDHN7CHPF6OVf
         GfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=copLvvrJbazdXyqzCxJJdZkQMy9u28Uu7XeADF/luNk=;
        b=HhZQxBPSX4KltIyk0uskm/aalUhwnVj3cwtRaY9Zp/TeoiRnqxkVps23WSrr29lWWP
         Ix2njg6ifCAYRqNF24ZXDgG20YKNGScCeIUux8MGen2OiXC5DR4ia26HW9u9CgVo/Lj2
         3rwbId6ZcCaqSipq6HHcwLnRC36O6igDI1BptJe5E7QExC1atjkY5DmBlG8u1XkNQU9B
         2Im4etJoPQXOWBhBhQ2+m/1yXsCjyFlNCxejsojCunY/nwZII4/ibC92xOWOpw0Ol2pp
         Loit73mkLO0W1S4toEz3XZ053JxEQcfGaxKrGM+e0bzAoVVGY66pF1xSegcy0vYnJSbA
         QG4A==
X-Gm-Message-State: AOAM5300AW3sETs3KhGeppQQ1mVG/yW72nObQ0GF9yyem58iQr/uB0db
        v9yxY2DiyjlcE4PfYwlfMJ4GVzMiUREiK9XIPfa8RQ==
X-Google-Smtp-Source: ABdhPJyngwSjrj4+Ve317ZAwKZ3iD+W162+gtyDMEc4SXEItx+azXITt68u4mP+DKn08ouZvlbqXGGoeRQDQe45qfKU=
X-Received: by 2002:aa7:cf0f:: with SMTP id a15mr13942233edy.3.1603708085000;
 Mon, 26 Oct 2020 03:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <3b1f7767-98e2-93e0-b718-16d1c5346140@cloud.ionos.com>
In-Reply-To: <3b1f7767-98e2-93e0-b718-16d1c5346140@cloud.ionos.com>
From:   Haris Iqbal <haris.iqbal@cloud.ionos.com>
Date:   Mon, 26 Oct 2020 15:57:53 +0530
Message-ID: <CAJpMwyhONwT6mYzOazjuWS01AVSd4bu=K33-LYk=ZygP021V4w@mail.gmail.com>
Subject: Re: Lock issue with 2a7cec53816 ("RDMA/cma: Fix locking for the
 RDMA_CM_CONNECT state")
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 26, 2020 at 1:50 PM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> Hi Jason & Leon,
>
>
> [Sorry to send again since the previous mail didn't hit the list]
>
> With the mentioned commit, I got the below calltraces.
>
> [ 1209.544359] INFO: task kworker/u8:3:615 blocked for more than 120
> seconds.
> [ 1209.545170]       Tainted: G           O      5.9.0-rc8+ #30
> [ 1209.545341] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [ 1209.545814] task:kworker/u8:3    state:D stack:    0 pid:  615
> ppid:     2 flags:0x00004000
> [ 1209.547601] Workqueue: rdma_cm cma_work_handler [rdma_cm]
> [ 1209.548645] Call Trace:
> [ 1209.552120]  __schedule+0x363/0x7b0
> [ 1209.552903]  schedule+0x44/0xb0
> [ 1209.553093]  schedule_preempt_disabled+0xe/0x10
> [ 1209.553253]  __mutex_lock.isra.10+0x26d/0x4e0
> [ 1209.553421]  __mutex_lock_slowpath+0x13/0x20
> [ 1209.553596]  ? __mutex_lock_slowpath+0x13/0x20
> [ 1209.553751]  mutex_lock+0x2f/0x40
> [ 1209.554045]  rdma_connect+0x52/0x770 [rdma_cm]
> [ 1209.554215]  ? vprintk_default+0x1f/0x30
> [ 1209.554359]  ? vprintk_func+0x62/0x100
> [ 1209.554532]  ? cma_cm_event_handler+0x2b/0xe0 [rdma_cm]
> [ 1209.554688]  ? printk+0x52/0x6e
> [ 1209.554852]  rtrs_clt_rdma_cm_handler+0x393/0x8b0 [rtrs_client]
> [ 1209.555056]  cma_cm_event_handler+0x2b/0xe0 [rdma_cm]
> [ 1209.561823]  ? cma_comp_exch+0x4e/0x60 [rdma_cm]
> [ 1209.561883]  ? cma_cm_event_handler+0x2b/0xe0 [rdma_cm]
> [ 1209.561940]  cma_work_handler+0x89/0xc0 [rdma_cm]
> [ 1209.561988]  process_one_work+0x20c/0x400
> [...]
> [ 1209.562323] INFO: task bash:630 blocked for more than 120 seconds.
> [ 1209.562368]       Tainted: G           O      5.9.0-rc8+ #30
> [ 1209.562404] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [ 1209.562456] task:bash            state:D stack:    0 pid:  630
> ppid:   618 flags:0x00004000
> [ 1209.562515] Call Trace:
> [ 1209.562559]  __schedule+0x363/0x7b0
> [ 1209.562603]  schedule+0x44/0xb0
> [ 1209.562642]  schedule_preempt_disabled+0xe/0x10
> [ 1209.562685]  __mutex_lock.isra.10+0x26d/0x4e0
> [ 1209.562727]  ? vprintk_func+0x62/0x100
> [ 1209.562765]  ? vprintk_default+0x1f/0x30
> [ 1209.562806]  __mutex_lock_slowpath+0x13/0x20
> [ 1209.562847]  ? __mutex_lock_slowpath+0x13/0x20
> [ 1209.562887]  mutex_lock+0x2f/0x40
> [ 1209.562936]  rdma_destroy_id+0x31/0x60 [rdma_cm]
> [ 1209.562983]  destroy_cm.isra.24+0x2d/0x50 [rtrs_client]
> [ 1209.563586]  init_sess+0x23b/0xac0 [rtrs_client]
> [ 1209.563691]  ? wait_woken+0x80/0x80
> [ 1209.563742]  rtrs_clt_open+0x27f/0x540 [rtrs_client]
> [ 1209.563791]  ? remap_devs+0x150/0x150 [rnbd_client]
> [ 1209.563867]  find_and_get_or_create_sess+0x4a1/0x5e0 [rnbd_client]
> [ 1209.563921]  ? remap_devs+0x150/0x150 [rnbd_client]
> [ 1209.563966]  ? atomic_notifier_call_chain+0x1a/0x20
> [ 1209.564011]  ? vt_console_print+0x203/0x3d0
> [ 1209.564051]  ? up+0x32/0x50
> [ 1209.564093]  ? __irq_work_queue_local+0x4f/0x60
> [ 1209.564132]  ? irq_work_queue+0x1a/0x30
> [ 1209.564169]  ? wake_up_klogd.part.28+0x34/0x40
> [ 1209.564208]  ? vprintk_emit+0x126/0x2b0
> [ 1209.564249]  ? vprintk_default+0x1f/0x30
> [ 1209.564292]  rnbd_clt_map_device+0x74/0x7b0 [rnbd_client]
> [ 1209.564341]  rnbd_clt_map_device_store+0x39e/0x6c0 [rnbd_client]
>
>  From my understanding, it is caused by the rdma_connect need to hold
> the handler_mutex
> again in the path.
>
> cma_ib_handler -> mutex_lock(&id_priv->handler_mutex)
> -> cma_cm_event_handler
>                      -> id_priv->id.event_handler = rtrs_clt_rdma_cm_handler
> -> rdma_connect
> -> mutex_lock(&id_priv->handler_mutex)

I think its coming from

cma_work_handler() -> cma_cm_event_handler() ->
id_priv->id.event_handler = rtrs_clt_rdma_cm_handler
rtrs_rdma_route_resolved
-> rdma_connect tries to get the same lock again
                                       -> mutex_lock(&id_priv->handler_mutex)

Since, cma_ib_handler() doesn't handle and forward the
RDMA_CM_EVENT_ROUTE_RESOLVED event.
And cma_work_handler() also holds the mutex before calling
cma_cm_event_handler()

It probably starts with,

After RDMA_CM_EVENT_ADDR_RESOLVED comes to rtrs_clt_rdma_cm_handler,
rdma_resolve_route() -> cma_resolve_ib_route() -> cma_query_ib_route() --> ...
(callback) cma_work_handler()

>
>
> And seems nvme rdma could have the same issue since rdma_connect is
> called by
> nvme_rdma_cm_handler -> nvme_rdma_route_resolved.
>
> Thanks,
> Guoqing



-- 

Regards
-Haris
