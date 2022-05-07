Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FEA51E2AB
	for <lists+linux-rdma@lfdr.de>; Sat,  7 May 2022 02:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445040AbiEGAOm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 May 2022 20:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445023AbiEGAOg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 May 2022 20:14:36 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047B71A054
        for <linux-rdma@vger.kernel.org>; Fri,  6 May 2022 17:10:52 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d22so8880483plr.9
        for <linux-rdma@vger.kernel.org>; Fri, 06 May 2022 17:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=qX1mz/JZe7ZPxODZcKyr8rLK/sSZXLuQxeabvbld9wQ=;
        b=QkSvP41J+ZVTKBRUTG8ZCAN6BTde3zrZuU567xIu9Os37Q0cDCy3ahbg5lK24IiSyu
         F0ReJ+1MNxY02vRA6CDpM5j98Rs8JDwfaXSYbN2OppdcEAGqkEKNzdUxWwHdu7ZyI4Jq
         GbkIyoyG8btFmAvCm3/AeCuDaU5f+DtLjJXlFGwR8Lx/HJqusnjvH+EWXARIAHkFZAUM
         8KrRLy4CPwEOEYBrjE2kABHaYld48CoAZhujuUBI7t7lBNCLWrsooTnarOkp3SMifXU7
         EkVsEHaayvABPSlYmILwNgNybgarKSZLnV3qcon23ib4uKRcWBM8DlGUhKcxlNzvMvIV
         bWJw==
X-Gm-Message-State: AOAM533LSb+SuKqFsvXZrT4pUjhW0+KbgmYFD0lu67uuXICInjuwxuLS
        TXs3BVLtixg+OIw3lPB9/uk=
X-Google-Smtp-Source: ABdhPJyMCbVyTwi+fzZVDN6gtpfdU2OooiNN9mClpr1Wmgs0TAx/c60xCKO3lnBioIBRwfiQn4PcxQ==
X-Received: by 2002:a17:903:2310:b0:15e:a944:aa52 with SMTP id d16-20020a170903231000b0015ea944aa52mr6286554plh.49.1651882251286;
        Fri, 06 May 2022 17:10:51 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902c64300b0015e8d4eb277sm2302770pls.193.2022.05.06.17.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 17:10:50 -0700 (PDT)
Message-ID: <cf8b9980-3965-a4f6-07e0-d4b25755b0db@acm.org>
Date:   Fri, 6 May 2022 17:10:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: Apparent regression in blktests since 5.18-rc1+
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <e7c31ebb-60c0-cd57-2009-5e9383ecc472@gmail.com>
Content-Language: en-US
In-Reply-To: <e7c31ebb-60c0-cd57-2009-5e9383ecc472@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/6/22 11:11, Bob Pearson wrote:
> Before the most recent kernel update I had blktests running OK on rdma_rxe. Since we went on to 5.18.0-rc1+
> I have been experiencing hangs. All of this is with the 'revert scsi-debug' patch which addressed the
> 3 min timeout related to modprobe -r scsi-debug.
> 
> You suggested checking with siw and I finally got around to this and the behavior is exactly the same.
> 
> Specifically here is a run and dmesgs from that run:
> 
> root@u-22:/home/bob/src/blktests# use_siw=1 ./check srp
> 
> srp/001 (Create and remove LUNs)                             [passed]
> 
>      runtime  3.388s  ...  3.501s
> 
> srp/002 (File I/O on top of multipath concurrently with logout and login (mq))
> 
>      runtime  54.689s  ...
>    <HANGS HERE>
> 
> I had to reboot to recover.
> 
> The dmesg output is attached in a long file called out.
> The output looks normal until line 1875 where it hangs at an "Already connected ..." message.
> This is the same as the other hangs I have been seeing.
> This is followed by a splat warning that a cpu has hung for 120 seconds.
> 
> Since this is behaving the same for rxe and siw I am going to stop chasing this bug since
> it is most likely outside of the the rxe driver.

Hi Bob,

What I see on my test setup is that the SRP tests from the blktests suite pass with
the SoftiWARP driver (kernel v5.18-rc5 / commit 4b97bac0756a):

# (cd blktests && use_siw=1 ./check -q srp)
srp/001 (Create and remove LUNs)                             [passed]
     runtime  5.781s  ...  5.464s
srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [passed]time  40.772s  ...
     runtime  40.772s  ...  42.039s
srp/003 (File I/O on top of multipath concurrently with logout and login (sq)) [not run]
     legacy device mapper support is missing
srp/004 (File I/O on top of multipath concurrently with logout and login (sq-on-srp/004 (File I/O on top of multipath concurrently with logout and login (sq-on-mq)) [not run]
     legacy device mapper support is missing
srp/005 (Direct I/O with large transfer sizes, cmd_sg_entries=255 and bs=4M) [passed]untime  17.870s  ...
     runtime  17.870s  ...  17.016s
srp/006 (Direct I/O with large transfer sizes, cmd_sg_entries=255 and bs=8M) [passed]untime  16.369s  ...
     runtime  16.369s  ...  17.315s
srp/007 (Direct I/O with large transfer sizes, cmd_sg_entries=1 and bs=4M) [passed] runtime  16.729s  ...
     runtime  16.729s  ...  17.409s
srp/008 (Direct I/O with large transfer sizes, cmd_sg_entries=1 and bs=8M) [passed] runtime  16.823s  ...
     runtime  16.823s  ...  16.453s
srp/009 (Buffered I/O with large transfer sizes, cmd_sg_entries=255 and bs=4M) [passed]time  17.304s  ...
     runtime  17.304s  ...  17.838s
srp/010 (Buffered I/O with large transfer sizes, cmd_sg_entries=255 and bs=8M) [passed]time  17.191s  ...
     runtime  17.191s  ...  17.117s
srp/011 (Block I/O on top of multipath concurrently with logout and login) [passed] runtime  40.835s  ...
     runtime  40.835s  ...  38.728s
srp/012 (dm-mpath on top of multiple I/O schedulers)         [passed]
     runtime  23.703s  ...  24.763s
srp/013 (Direct I/O using a discontiguous buffer)            [passed]
     runtime  11.279s  ...  9.265s
srp/014 (Run sg_reset while I/O is ongoing)                  [passed]
     runtime  39.110s  ...  37.929s
srp/015 (File I/O on top of multipath concurrently with logout and login (mq) ussrp/015
     (File I/O on top of multipath concurrently with logout and login (mq) using the SoftiWARP (siw) driver) [passed]
     runtime  40.027s  ...  40.220s

If I try to run the SRP test 002 with the soft-RoCE driver, the following appears:

[  749.901966] ================================
[  749.903638] WARNING: inconsistent lock state
[  749.905376] 5.18.0-rc5-dbg+ #1 Not tainted
[  749.907039] --------------------------------
[  749.908699] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
[  749.910646] ksoftirqd/5/40 [HC0[0]:SC1[1]:HE0:SE0] takes:
[  749.912499] ffff88818244d350 (&xa->xa_lock#14){+.?.}-{2:2}, at: rxe_pool_get_index+0x73/0x170 [rdma_rxe]
[  749.914691] {SOFTIRQ-ON-W} state was registered at:
[  749.916648]   __lock_acquire+0x45b/0xce0
[  749.918599]   lock_acquire+0x18a/0x450
[  749.920480]   _raw_spin_lock+0x34/0x50
[  749.922580]   __rxe_add_to_pool+0xcc/0x140 [rdma_rxe]
[  749.924583]   rxe_alloc_pd+0x2d/0x40 [rdma_rxe]
[  749.926394]   __ib_alloc_pd+0xa3/0x270 [ib_core]
[  749.928579]   ib_mad_port_open+0x44a/0x790 [ib_core]
[  749.930640]   ib_mad_init_device+0x8e/0x110 [ib_core]
[  749.932495]   add_client_context+0x26a/0x330 [ib_core]
[  749.934302]   enable_device_and_get+0x169/0x2b0 [ib_core]
[  749.936217]   ib_register_device+0x26f/0x330 [ib_core]
[  749.938020]   rxe_register_device+0x1b4/0x1d0 [rdma_rxe]
[  749.939794]   rxe_add+0x8c/0xc0 [rdma_rxe]
[  749.941552]   rxe_net_add+0x5b/0x90 [rdma_rxe]
[  749.943356]   rxe_newlink+0x71/0x80 [rdma_rxe]
[  749.945182]   nldev_newlink+0x21e/0x370 [ib_core]
[  749.946917]   rdma_nl_rcv_msg+0x200/0x410 [ib_core]
[  749.948657]   rdma_nl_rcv+0x140/0x220 [ib_core]
[  749.950373]   netlink_unicast+0x307/0x460
[  749.952063]   netlink_sendmsg+0x422/0x750
[  749.953672]   __sys_sendto+0x1c2/0x250
[  749.955281]   __x64_sys_sendto+0x7f/0x90
[  749.956849]   do_syscall_64+0x35/0x80
[  749.958353]   entry_SYSCALL_64_after_hwframe+0x44/0xae
[  749.959942] irq event stamp: 1411849
[  749.961517] hardirqs last  enabled at (1411848): [<ffffffff810cdb28>] __local_bh_enable_ip+0x88/0xf0
[  749.963338] hardirqs last disabled at (1411849): [<ffffffff81ebf24d>] _raw_spin_lock_irqsave+0x5d/0x60
[  749.965214] softirqs last  enabled at (1411838): [<ffffffff82200467>] __do_softirq+0x467/0x6e1
[  749.967027] softirqs last disabled at (1411843): [<ffffffff810cd947>] run_ksoftirqd+0x37/0x60

I think the above is strong evidence that there is something wrong with the
soft-RoCE driver.

Thanks,

Bart.
