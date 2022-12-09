Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6CA6482A9
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Dec 2022 14:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiLINBU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Dec 2022 08:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLINBS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Dec 2022 08:01:18 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D683F6150B
        for <linux-rdma@vger.kernel.org>; Fri,  9 Dec 2022 05:01:16 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id x28so3446967qtv.13
        for <linux-rdma@vger.kernel.org>; Fri, 09 Dec 2022 05:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t4EcL+sW0FV5i/8KEtc5L3BEzEEl7w8LGf0ZWhes5j0=;
        b=BhUBUyobMY3/J3NKbsPc7mae2/8L+gdmNwVvJHjVhitpebjE5zgYDWeCyRCaRCZFS7
         XOhKUiEPyaDQZthQoDJ6DRj3zCVS1RhAVt6A4Nc8TiV3qxTzUl/+BZWpbGDg8Kbuebf2
         mxhDDpgDYT959EIxxkslYzbpqT6d1c6PlEZYND2OyZThNW56hTV4nD9nnq62gRuEWLGS
         W9+rry1ECrxYZ9ohfMEWFi9uc4bk9mgT8EwezfBqcg5gg8PH/aFfqJ5Z3Id9xRRvgVGL
         nj08NsOz9kZkp0w0dErGbJgLfnzitzfDSaD45rjcfBrXVQeHNxviNZctWpR8y7aHax67
         fycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4EcL+sW0FV5i/8KEtc5L3BEzEEl7w8LGf0ZWhes5j0=;
        b=k2d/uZKXCTFjcZKgQrqIfLfR1Abw/Jkl24/Mbon63PjROEwbFrNFosv7dLATt457Ih
         hRk/62ZvJ1RQuIU4Mgm6LknU5lRHlxr0veP4lONONpGD/metf2HlnzibGtiN4PmBWNsY
         R/jASFSkSx/s6c/dwvHUImpCZ0CT1Qu/UhqBHiSnpXXC4FWF4OxhhmEmZVgQy9LZELWV
         yuSRaKIV7yI54p3rnM+O33z8HU5PscVkKXlocVtryRevcCLbf9Uqo+AIGhhr+w67Sesl
         4YfpS+gM+13r47qFR1A01kHIHpu0pj5KckDlnccJdAnl92HSszZ3buUbsIs5enUlrODx
         N41A==
X-Gm-Message-State: ANoB5pn/fFi0KeRDoGQyty6wxZUuOwX7VwnufCYDpn0BOM8pK23JN88H
        43bxrbzTlsE2BC5UGaIdTcrTfg==
X-Google-Smtp-Source: AA0mqf5EpHbdu8Wqt4QHu1tqwR5mTZ2Xu5LKK8x1qa/bTGmpQKeoHqDcOCL3qazQWroE8uWe6nCvOA==
X-Received: by 2002:ac8:4f49:0:b0:3a5:4168:9534 with SMTP id i9-20020ac84f49000000b003a541689534mr8293322qtw.54.1670590875950;
        Fri, 09 Dec 2022 05:01:15 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id s16-20020ac87590000000b003a6934255dasm841325qtq.46.2022.12.09.05.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 05:01:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1p3d06-006ygm-FL;
        Fri, 09 Dec 2022 09:01:14 -0400
Date:   Fri, 9 Dec 2022 09:01:14 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     syzbot <syzbot+3fd8326d9a0812d19218@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        markzhang@nvidia.com, ohartoov@nvidia.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING: refcount bug in nldev_newlink
Message-ID: <Y5MxmrLlXPMZ+WS2@ziepe.ca>
References: <0000000000004fe6c005ef43161d@google.com>
 <Y5Gq/zVi/fR85OJK@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5Gq/zVi/fR85OJK@unreal>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 08, 2022 at 11:14:39AM +0200, Leon Romanovsky wrote:

> >  __refcount_dec include/linux/refcount.h:344 [inline]
> >  refcount_dec include/linux/refcount.h:359 [inline]
> >  ref_tracker_free+0x539/0x6b0 lib/ref_tracker.c:118
> >  netdev_tracker_free include/linux/netdevice.h:4039 [inline]
> >  netdev_put include/linux/netdevice.h:4056 [inline]
> >  dev_put include/linux/netdevice.h:4082 [inline]
> >  nldev_newlink+0x360/0x5d0 drivers/infiniband/core/nldev.c:1733
> >  rdma_nl_rcv_msg+0x371/0x6a0 drivers/infiniband/core/netlink.c:195
> >  rdma_nl_rcv_skb.constprop.0.isra.0+0x2fc/0x440 drivers/infiniband/core/netlink.c:239
> >  netlink_unicast_kernel net/netlink/af_netlink.c:1330 [inline]
> >  netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1356
> >  netlink_sendmsg+0x91b/0xe10 net/netlink/af_netlink.c:1932
> >  sock_sendmsg_nosec net/socket.c:714 [inline]
> >  sock_sendmsg+0xd3/0x120 net/socket.c:734
> >  ____sys_sendmsg+0x712/0x8c0 net/socket.c:2476
> >  ___sys_sendmsg+0x110/0x1b0 net/socket.c:2530
> >  __sys_sendmsg+0xf7/0x1c0 net/socket.c:2559
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7fd5bc473699
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffed185aff8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fd5bc473699
> > RDX: 0000000000000000 RSI: 0000000020000340 RDI: 0000000000000003
> > RBP: 0000000000000000 R08: 000000000000000d R09: 000000000000000d
> > R10: 00007ffed185aa70 R11: 0000000000000246 R12: 00007ffed185b010
> > R13: 00000000000f4240 R14: 0000000000011fc1 R15: 00007ffed185b004
> >  </TASK>
> > 
> > 
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > syzbot can test patches for this issue, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
> 
> Jason, what do you think?

No, the key to this report is that the refcount dec is inside the tracker:

> >  __refcount_dec include/linux/refcount.h:344 [inline]
> >  refcount_dec include/linux/refcount.h:359 [inline]
> >  ref_tracker_free+0x539/0x6b0 lib/ref_tracker.c:118
> >  netdev_tracker_free include/linux/netdevice.h:4039 [inline]

Which is not underflowing the refcount on the dev, it is actually
trying to say the tracker has become unbalanced.

Eg this put is not matched with a hold that specified the tracker.

Probably this:

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index ff35cebb25e265..115b77c5e9a146 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2192,6 +2192,7 @@ static void free_netdevs(struct ib_device *ib_dev)
                if (ndev) {
                        spin_lock(&ndev_hash_lock);
                        hash_del_rcu(&pdata->ndev_hash_link);
+                       netdev_tracker_free(ndev, &pdata->netdev_tracker);
                        spin_unlock(&ndev_hash_lock);
 
                        /*
@@ -2201,7 +2202,7 @@ static void free_netdevs(struct ib_device *ib_dev)
                         * comparisons after the put
                         */
                        rcu_assign_pointer(pdata->netdev, NULL);
-                       dev_put(ndev);
+                       __dev_put(ndev);
                }
                spin_unlock_irqrestore(&pdata->netdev_lock, flags);
        }

