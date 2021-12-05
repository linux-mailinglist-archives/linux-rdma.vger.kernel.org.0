Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742C0468AE0
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Dec 2021 13:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbhLEM4r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Dec 2021 07:56:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25320 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233841AbhLEM4r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Dec 2021 07:56:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638708799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EYXarmSLA7/vOOd3j7uzySuWpcgti12rBTj1myUWo7s=;
        b=UIHhoDp2jsKx17JyyU1HDxAtsTPmx3VG35LK/3JfctTm8M2sk7XMUzx5d380hKED1FcMif
        bxDomrZ3QHhJr7cE8kINDtcbuPGclEXP7RQeeaO5QiKHRPbaobz6YQEoP15oMwftH11inn
        pgjleiyOJC9n3lx3v5Qqgy5M4Lh5z7Y=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-bMJGQM20ODSZnyrz2ruQFA-1; Sun, 05 Dec 2021 07:53:18 -0500
X-MC-Unique: bMJGQM20ODSZnyrz2ruQFA-1
Received: by mail-yb1-f198.google.com with SMTP id w5-20020a25ac05000000b005c55592df4dso15498161ybi.12
        for <linux-rdma@vger.kernel.org>; Sun, 05 Dec 2021 04:53:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EYXarmSLA7/vOOd3j7uzySuWpcgti12rBTj1myUWo7s=;
        b=zsjbmrbhI7xvQE0jc+BItC3dlD3W8SCmcQVn/gTodCC3APhl0m1nk/SgxqtkuguZFH
         KI0MVo89BR6OVOKTlQXzWLEiWFWZW3hcOt8txyC+8JDA21Ijx30U5tNOGVoB4Cyuk+Eu
         cKTt/KEfga/VFFCbWwAGJF49XCirLe2/8YqP339cA6yyg177UAghTAVgJ4PIvoEfUo5f
         rlKPXSeDNCUn+P+g5a0xxtpVacV9QWBcBU5L+RCOrw+6IdJ0hR1iy7unhmIho0ry4oN+
         uBXtohZekY+2INGOcgBMFZgrxkjkdtfOrxn7V/l7qSFq1mIH/VMheyTbt8AcsRIYro66
         3ekQ==
X-Gm-Message-State: AOAM530XBVXlRfbRwBkjNBS2XqAwiRU2gGd27Owf8QeVqGD60SoAZCxc
        yEiJLTut6QVAFZQ2X0S0EaFW/gDttV+0dIhp+ogwF2bEFUwD/0M4BpZy8mj9CcdeEEEb5Bjk/Ct
        UgOTF7jKI9b8+T2Uwg4oG63QafaWCxvOShuqpBw==
X-Received: by 2002:a25:516:: with SMTP id 22mr37790250ybf.294.1638708798077;
        Sun, 05 Dec 2021 04:53:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIekqJqipgnEjIFaFJc1oEfeE3uUs61JX8WTiGIf56gYro3shpLlt5LOMFpsTjkaS+WWjWOIujJDCkSMrkroU=
X-Received: by 2002:a25:516:: with SMTP id 22mr37790236ybf.294.1638708797877;
 Sun, 05 Dec 2021 04:53:17 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs9_ZuMnrP9=E-jP7mBZ87Et1ne0VTfQiQGq284XrbbOnw@mail.gmail.com>
 <8d41da04-717e-8116-c091-83393990dd84@acm.org>
In-Reply-To: <8d41da04-717e-8116-c091-83393990dd84@acm.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Sun, 5 Dec 2021 20:53:06 +0800
Message-ID: <CAHj4cs9tL9TBp9Ko-geOrNz2fa7jCDKvN5NaMUSg853-E4WKxQ@mail.gmail.com>
Subject: Re: [bug report] blktests srp/011 hang at "ib_srpt
 srpt_disconnect_ch_sync:still waiting ..."
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 3, 2021 at 2:42 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 12/1/21 12:55 AM, Yi Zhang wrote:
> > [root@gigabyte-r120-11 blktests]# use_siw=1 ./check srp/011 -------------> hang
>
> Hi Yi,
>
> Does this only occur with the siw driver or also with the rdma_rxe driver?
>
> If this hang occurs with both drivers, how about bisecting this issue? I

Hi Bart
Bisecting shows it was introduced with below commit:
commit 5a836bf6b09f99ead1b69457ff39ab3011ece57b
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Fri Feb 26 17:11:55 2021 +0100

    mm: slub: move flush_cpu_slab() invocations __free_slab()
invocations out of IRQ context

    flush_all() flushes a specific SLAB cache on each CPU (where the cache
    is present). The deactivate_slab()/__free_slab() invocation happens
    within IPI handler and is problematic for PREEMPT_RT.

    The flush operation is not a frequent operation or a hot path. The
    per-CPU flush operation can be moved to within a workqueue.

    Because a workqueue handler, unlike IPI handler, does not disable irqs,
    flush_slab() now has to disable them for working with the kmem_cache_cpu
    fields. deactivate_slab() is safe to call with irqs enabled.

    [vbabka@suse.cz: adapt to new SLUB changes]
    Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

BTW, I just found this issue cannot be reproduced If I update the
ch_count to 10,.
# cat /etc/modprobe.d/ib_srp.conf
options ib_srp ch_count=10


> have not yet run into this issue with the rdma_rxe driver and Linus' master
> branch.
>
> Thanks,
>
> Bart.
>


-- 
Best Regards,
  Yi Zhang

