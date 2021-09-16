Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9405040ED49
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Sep 2021 00:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240961AbhIPWWo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 18:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240927AbhIPWWl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Sep 2021 18:22:41 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AB4C061574
        for <linux-rdma@vger.kernel.org>; Thu, 16 Sep 2021 15:21:19 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id z62so7587919vsz.9
        for <linux-rdma@vger.kernel.org>; Thu, 16 Sep 2021 15:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ppCpZQ5VhVE+srOwauW9qo8IE850BovMAIJmRp3iSC0=;
        b=dk1j9p+/oHOCNCJyZNIE5dEAMC7Zw+bVgItahv2x0yEzhc2PGQhA2/jcBwcPbFjtP7
         L7v0b77XMZUUCtU3R87baGRv/RXGFExjabjGfTK8dd6goVUaz6CbtxNBnOzZFD4YVPVd
         sB3P/G5PZs89umnDYWf4DEkS9+mKUMusqL3d1efA+5PAZxUW5f+qZsMT1tbos2cpGzM5
         ubOygpQyEMdC8ijBI5AqJHNcZmcQmpJXHEhKZ8bmxcDVii5XBarQSTIyFjygqyrYU9pe
         xUp7m7Cfg9EDHUHcK/08T5S9eafxT8oAr51ZiqGgvp7vvISraJZcFlakflPqTlBcQskq
         ZENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ppCpZQ5VhVE+srOwauW9qo8IE850BovMAIJmRp3iSC0=;
        b=Me97ZDm/1MatQJXd/VUoDR6TFJYBVMxZ098282dYSR8EzJPGMh/D6UE3oBxvJpNet9
         FTX2POqZyWWbwEtedtvyPcWogrjEmPsqPrVWufn1st6sHa2qIO+jn6QrqyjDWgILZXjS
         7nz30Yh2iEoa98HSZdInTGXRrNRREDswULf83mmaKvLARuKyEN/AQhFXiINYP8Z1j81T
         8FVpEVkJL6KQGFpTuyR4gaHMZQj61ybV/JUOV9j+Bm9xOQS3sGP1m3cTMnyat+S1uFBH
         tnevYopG1ZefNpFMdrgAKEJbWpcI9vymPlq+N4hHp3ro0wy3WbBulmNfa+vBo5/Qa3G0
         txmA==
X-Gm-Message-State: AOAM530LPMtmIZ4f+rzkllFqOSWJWZz81M4CkXEg8PSmAT6KTtm+62NQ
        L3zs7kcalHaCGAmLmQu8SBm6pomMwMKJAb9Dd8g=
X-Google-Smtp-Source: ABdhPJxFmPtupI/KHpYN5flPU0CvilBN1NObDjvVuY8tHdo4ckFJNEnuR7VKTcwZSJNWGnkKBOc1WHl5JckWeCrGYEQ=
X-Received: by 2002:a05:6102:528:: with SMTP id m8mr3669174vsa.43.1631830878223;
 Thu, 16 Sep 2021 15:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <OF54F8428F.7EA7E570-ON00258752.006AB21B-00258752.006BBB93@ibm.com>
In-Reply-To: <OF54F8428F.7EA7E570-ON00258752.006AB21B-00258752.006BBB93@ibm.com>
From:   Robert Pearson <rpearsonhpe@gmail.com>
Date:   Thu, 16 Sep 2021 17:21:00 -0500
Message-ID: <CAFc_bgaH=fYMtKO-pJ0=KMU=d1wafDwWid8AoZsPhjpT9GdSDQ@mail.gmail.com>
Subject: Re: Issus with blktest/srp on 5.15-rc1 and rdma_rxe
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Bernard,
That would indicate that you have not applied the patch series
RDMA/rxe: Fix various bugs which fixes the rkey not match rxe bug.
I do not know how to get it to select the siw device instead of the rxe
device but Bart does.

Bob

On Thu, Sep 16, 2021 at 2:36 PM Bernard Metzler <BMT@zurich.ibm.com> wrote:
>
> Hi,
>
> if I run the complete srp test series from the blktests suite,
> the dmesg log contains many rdma_rxe messages of type:
>
> rdma_rxe: rxe_invalidate_mr: rkey (n) doesn't match mr->ibmr.rkey (n + 1)
>
> where 'n' is the current key. I expect this is not intended
> behavior.
>
> I am at commit 1b789bd4dbd48a92f5427d9c37a72a8f6ca17754
>
>
>
> Furthermore, running ./check -q srp/005 sometimes I get this:
>
> [  308.903330] sd 11:0:0:1: [sde] Attached SCSI disk
> [  308.917293] scsi 11:0:0:1: alua: Detached
> [  308.918191] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [  308.918223] #PF: supervisor instruction fetch in kernel mode
> [  308.918242] #PF: error_code(0x0010) - not-present page
> [  308.918259] PGD 0 P4D 0
> [  308.918271] Oops: 0010 [#1] SMP PTI
> [  308.918285] CPU: 1 PID: 4214 Comm: kworker/1:255 Not tainted 5.15.0-rc1+ #4
> [  308.918309] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./Z77 Extreme6, BIOS P2.80 07/01/2013
> [  308.918338] Workqueue: srp_remove srp_remove_work [ib_srp]
> [  308.918362] RIP: 0010:0x0
> [  308.918375] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
> [  308.918397] RSP: 0018:ffffb6124b9a3b68 EFLAGS: 00010086
> [  308.918414] RAX: 0000000000000001 RBX: ffffb6124b9a3ce0 RCX: 0000000000000000
> [  308.918437] RDX: 0000000000000000 RSI: ffffb6124b9a3c50 RDI: ffff966063a27a00
> [  308.918459] RBP: ffffb6124b9a3bb0 R08: ffff966067481c00 R09: ffffeb578489b808
> [  308.918481] R10: ffff966043c0f200 R11: ffffb6124b9a3d00 R12: ffff966063a27a00
> [  308.918503] R13: 0000000000000004 R14: 0000000000000000 R15: ffffb6124b9a3c50
> [  308.918524] FS:  0000000000000000(0000) GS:ffff966157680000(0000) knlGS:0000000000000000
> [  308.918550] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  308.918568] CR2: ffffffffffffffd6 CR3: 000000005060a004 CR4: 00000000001706e0
> [  308.918590] Call Trace:
> [  308.918601]  __ib_process_cq+0x89/0x150 [ib_core]
> [  308.918640]  ib_process_cq_direct+0x30/0x50 [ib_core]
> [  308.918669]  ? xas_store+0x331/0x640
> [  308.918684]  ? free_unref_page_commit.isra.135+0x91/0x140
> [  308.918705]  ? free_unref_page+0x6e/0xd0
> [  308.918719]  ? __free_pages+0xa3/0xc0
> [  308.918733]  ? kfree+0x32f/0x3b0
> [  308.918748]  srp_destroy_qp+0x24/0x40 [ib_srp]
> [  308.918767]  srp_free_ch_ib+0x77/0x180 [ib_srp]
> [  308.918784]  srp_remove_work+0xde/0x1a0 [ib_srp]
> [  308.918801]  process_one_work+0x1d0/0x380
> [  308.918817]  worker_thread+0x37/0x390
> [  308.918831]  ? process_one_work+0x380/0x380
> [  308.918846]  kthread+0x12f/0x150
> [  308.918859]  ? set_kthread_struct+0x40/0x40
> [  308.918874]  ret_from_fork+0x22/0x30
>
>
> With ./check -q srp/008 I sometimes get something similar:
>
> [ 1772.149274] sd 11:0:0:1: [sde] Attached SCSI disk
> [ 1772.150096] scsi 11:0:0:2: alua: Detached
> [ 1772.150184] blk_update_request: I/O error, dev sde, sector 8 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> [ 1772.151653] blk_update_request: I/O error, dev sde, sector 8 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> [ 1772.153080] Buffer I/O error on dev sde, logical block 1, async page read
> [ 1772.169139] scsi 11:0:0:1: alua: Detached
> [ 1772.169446] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [ 1772.170881] #PF: supervisor instruction fetch in kernel mode
> [ 1772.172297] #PF: error_code(0x0010) - not-present page
> [ 1772.173751] PGD 0 P4D 0
> [ 1772.175165] Oops: 0010 [#1] SMP PTI
> [ 1772.176575] CPU: 3 PID: 8654 Comm: kworker/3:60 Not tainted 5.15.0-rc1+ #4
> [ 1772.177995] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./Z77 Extreme6, BIOS P2.80 07/01/2013
> [ 1772.179430] Workqueue: srp_remove srp_remove_work [ib_srp]
> [ 1772.180859] RIP: 0010:0x0
> [ 1772.182276] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
> [ 1772.183705] RSP: 0018:ffffa9710a2f7b68 EFLAGS: 00010086
> [ 1772.185129] RAX: 0000000000000001 RBX: ffffa9710a2f7c50 RCX: 0000000000000000
> [ 1772.186566] RDX: 0000000000000000 RSI: ffffa9710a2f7c08 RDI: ffff91a703825a00
> [ 1772.187994] RBP: ffffa9710a2f7bb0 R08: ffff91a7184f8300 R09: 0000000000000000
> [ 1772.189425] R10: ffff91a7869ce000 R11: ffffa9710a2f7d00 R12: ffff91a703825a00
> [ 1772.190848] R13: 0000000000000002 R14: 0000000000000000 R15: ffffa9710a2f7c08
> [ 1772.192270] FS:  0000000000000000(0000) GS:ffff91a817780000(0000) knlGS:0000000000000000
> [ 1772.193689] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1772.195118] CR2: ffffffffffffffd6 CR3: 0000000111458006 CR4: 00000000001706e0
> [ 1772.196558] Call Trace:
> [ 1772.197975]  __ib_process_cq+0x89/0x150 [ib_core]
> [ 1772.199402]  ib_process_cq_direct+0x30/0x50 [ib_core]
> [ 1772.200830]  ? put_cpu_partial+0x98/0xb0
> [ 1772.202260]  ? __slab_free+0x226/0x3c0
> [ 1772.203664]  ? __slab_free+0x226/0x3c0
> [ 1772.205038]  ? xas_store+0x331/0x640
> [ 1772.206404]  ? rxe_elem_release+0x4f/0x60 [rdma_rxe]
> [ 1772.207763]  ? kfree+0x372/0x3b0
> [ 1772.209101]  ? srp_destroy_fr_pool+0x43/0x50 [ib_srp]
> [ 1772.210439]  srp_destroy_qp+0x24/0x40 [ib_srp]
> [ 1772.211759]  srp_free_ch_ib+0x77/0x180 [ib_srp]
> [ 1772.213093]  srp_remove_work+0xde/0x1a0 [ib_srp]
> [ 1772.214417]  process_one_work+0x1d0/0x380
> [ 1772.215756]  worker_thread+0x37/0x390
> [ 1772.217082]  ? process_one_work+0x380/0x380
> [ 1772.218422]  kthread+0x12f/0x150
> [ 1772.219744]  ? set_kthread_struct+0x40/0x40
> [ 1772.221059]  ret_from_fork+0x22/0x30
>
>
> Many thanks,
> Bernard.
>
>
