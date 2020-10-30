Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE942A01BB
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Oct 2020 10:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgJ3JsP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Oct 2020 05:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgJ3JsP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Oct 2020 05:48:15 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38C9C0613CF
        for <linux-rdma@vger.kernel.org>; Fri, 30 Oct 2020 02:48:13 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b8so5766988wrn.0
        for <linux-rdma@vger.kernel.org>; Fri, 30 Oct 2020 02:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q0cqWxTuGMilmd1mw4GMD/Lnmx0idiEf5piJvmyiMKY=;
        b=Ggurgj+ZoTJw7rUVBXhpNGvYG0Hbko/Y2zN5RTqsP0yKLiY/lCLGM+Be09MaNo6NL5
         R0r3edocuOljZHlgNT/mm3tJSj+Zq7Uf3HIU7UiGb4lUS6CuqqVtB0pELN0CzGGV2ohl
         bYgcPlVryfTA9Wq3v0vGRSd1Qa4KGp0Re3POLEd0xclAb0sBI03hh3wApBYXBoqfAKGG
         ZA4VO0axmo7EFDg2f5IAMRyuzVrh+LSELd315JifF6xKsepytOLxa8FtShNLjKqaWgbM
         Z+/axW+CEpSQOiZEyGo73tYBlTzRGdXnvv7aEiIfVwvUkQHuZ875pTjlHC8l8+yV7t8U
         QqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q0cqWxTuGMilmd1mw4GMD/Lnmx0idiEf5piJvmyiMKY=;
        b=RxJ0Ijgv8JSccFOSnOjfB6icASgaKrPuMUAz3JLAyx7dH8EIfJ7gmPf39SjlnSZa7A
         5orkqGmu7Pk2zuhpIE1Zq1Lu7Z9mazNZsEjaT86viyDUJD1gKSr5kPBvmsgni2C2cUsp
         jia9NtCSXoRImJ56r6BpjATa7I0skMRUqX+fT2Y2u80sIVTBnM+7ps+KYibjkpiZXweG
         UUzwA0QdWTCtMyz3MhD2YGW/ss7TIfbhR+EaOiAdFio4FsOHlQH2e6AwNQ79F6s8V4Jr
         taLXs+UN+ukV+E6ZuPV1H0G88ehMstvcz9cRnLvTdXUX+UUDyWNwbWCy3Imse1mlYhPN
         QUbQ==
X-Gm-Message-State: AOAM5322iTCSQ7J0C76ClU8eO5uqPvYQMgpw4uwga50BzJ8hZXdrM+FI
        +UAiyfJv1cILb6PjFfQSw1+D4A==
X-Google-Smtp-Source: ABdhPJyfpTBvv56UHyIdIL9rnyOiKBDXtJ0ioZdDUamPiwzCvH3AOaGoUnyftkeS/BxarIvsbfBY2g==
X-Received: by 2002:a05:6000:1188:: with SMTP id g8mr1738804wrx.422.1604051292279;
        Fri, 30 Oct 2020 02:48:12 -0700 (PDT)
Received: from ?IPv6:240e:82:3:96c8:9dbf:9753:3203:b67b? ([240e:82:3:96c8:9dbf:9753:3203:b67b])
        by smtp.gmail.com with ESMTPSA id s2sm4153549wmf.45.2020.10.30.02.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 02:48:11 -0700 (PDT)
Subject: Re: [PATCH] RDMA: Fix software RDMA drivers for dma mapping error
To:     Parav Pandit <parav@nvidia.com>,
        dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca, yanjunz@nvidia.com, bmt@zurich.ibm.com,
        linux-rdma@vger.kernel.org
Cc:     hch@lst.de, syzbot+34dc2fea3478e659af01@syzkaller.appspotmail.com
References: <20201030093803.278830-1-parav@nvidia.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <5448d3f6-b5b5-4362-373a-5e424ca787db@cloud.ionos.com>
Date:   Fri, 30 Oct 2020 10:48:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201030093803.278830-1-parav@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 10/30/20 10:38, Parav Pandit wrote:
> A cited commit in fixes tag avoided setting dma_mask of the ib_device.
> Commit [1] made dma_mask as mandetory field to be setup even for
> dma_virt_ops based dma devices. Due to which below call trace occurred.
> 
> Fix it by setting empty DMA MASK for software based RDMA devices.
> 
> WARNING: CPU: 1 PID: 8488 at kernel/dma/mapping.c:149
> dma_map_page_attrs+0x493/0x700 kernel/dma/mapping.c:149 Modules linked in:
> CPU: 1 PID: 8488 Comm: syz-executor144 Not tainted 5.9.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 01/01/2011
> RIP: 0010:dma_map_page_attrs+0x493/0x700 kernel/dma/mapping.c:149
> Trace:
>   dma_map_single_attrs include/linux/dma-mapping.h:279 [inline]
> ib_dma_map_single include/rdma/ib_verbs.h:3967 [inline]
>   ib_mad_post_receive_mads+0x23f/0xd60
> drivers/infiniband/core/mad.c:2715
>   ib_mad_port_start drivers/infiniband/core/mad.c:2862 [inline]
> ib_mad_port_open drivers/infiniband/core/mad.c:3016 [inline]
>   ib_mad_init_device+0x72b/0x1400 drivers/infiniband/core/mad.c:3092
>   add_client_context+0x405/0x5e0 drivers/infiniband/core/device.c:680
>   enable_device_and_get+0x1d5/0x3c0
> drivers/infiniband/core/device.c:1301
>   ib_register_device drivers/infiniband/core/device.c:1376 [inline]
>   ib_register_device+0x7a7/0xa40 drivers/infiniband/core/device.c:1335
>   rxe_register_device+0x46d/0x570
> drivers/infiniband/sw/rxe/rxe_verbs.c:1182
>   rxe_add+0x12fe/0x16d0 drivers/infiniband/sw/rxe/rxe.c:247
>   rxe_net_add+0x8c/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:507
>   rxe_newlink drivers/infiniband/sw/rxe/rxe.c:269 [inline]
>   rxe_newlink+0xb7/0xe0 drivers/infiniband/sw/rxe/rxe.c:250
>   nldev_newlink+0x30e/0x540 drivers/infiniband/core/nldev.c:1555
>   rdma_nl_rcv_msg+0x367/0x690 drivers/infiniband/core/netlink.c:195
>   rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>   rdma_nl_rcv+0x2f2/0x440 drivers/infiniband/core/netlink.c:259
>   netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
>   netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
>   netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
> sock_sendmsg_nosec net/socket.c:651 [inline]
>   sock_sendmsg+0xcf/0x120 net/socket.c:671
>   ____sys_sendmsg+0x6e8/0x810 net/socket.c:2353
>   ___sys_sendmsg+0xf3/0x170 net/socket.c:2407
>   __sys_sendmsg+0xe5/0x1b0 net/socket.c:2440
>   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x443699
> 
> [1] commit f959dcd6ddfd ("dma-direct: Fix potential NULL pointer dereference")
> 
> Reported-by: syzbot+34dc2fea3478e659af01@syzkaller.appspotmail.com
> Fixes: e0477b34d9d1 ("RDMA: Explicitly pass in the dma_device to ib_register_device")
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---

Fixed the issue which happened in my test.

Tested-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Guoqing
