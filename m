Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF4F7E97E9
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Nov 2023 09:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjKMIjo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Nov 2023 03:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjKMIjn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Nov 2023 03:39:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B69010F4;
        Mon, 13 Nov 2023 00:39:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801B8C433C8;
        Mon, 13 Nov 2023 08:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699864780;
        bh=hxrsKbvBah29V/no+gKxOPyPffrTmSMNIqPs0SwCcwk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UpAl5RdrJbXklym6CpJwior12sCbwCKpUrNfiopzry4I3uD/jjTbgsbmRTP+g13J0
         81XUlAeALCzvoXNlA8ZT3I43JjmhsGwBCBo63MemOTgYJG4wEsrZT1FIuUxNbBbwWJ
         4nhIkHwsIxZGVNaE/nDf+6PQRI2WBy9Y7htim9yJLzXshsON/VMdhp+OG//oEUHln0
         6vvnpXkWQjiO+4CgJLzfR5G8HlnmsIzD/IQj/me90IbQKO8k2wS34/UANJf/nQOVjF
         OQzKmf2XaTLEB4i7o8zBub4/tSBAz/zTn6Umi5MNYFA/MfQzYO+rm4wN9KGhpJua7Y
         hw8iXQOhAtfAA==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Shigeru Yoshida <syoshida@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231108143113.1360567-1-syoshida@redhat.com>
References: <20231108143113.1360567-1-syoshida@redhat.com>
Subject: Re: [PATCH] RDMA/core: Fix uninit-value access in ib_get_eth_speed()
Message-Id: <169986477510.284064.741371212322802208.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 10:39:35 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Wed, 08 Nov 2023 23:31:13 +0900, Shigeru Yoshida wrote:
> KMSAN reported the following uninit-value access issue:
> 
> lo speed is unknown, defaulting to 1000
> =====================================================
> BUG: KMSAN: uninit-value in ib_get_width_and_speed drivers/infiniband/core/verbs.c:1889 [inline]
> BUG: KMSAN: uninit-value in ib_get_eth_speed+0x546/0xaf0 drivers/infiniband/core/verbs.c:1998
>  ib_get_width_and_speed drivers/infiniband/core/verbs.c:1889 [inline]
>  ib_get_eth_speed+0x546/0xaf0 drivers/infiniband/core/verbs.c:1998
>  siw_query_port drivers/infiniband/sw/siw/siw_verbs.c:173 [inline]
>  siw_get_port_immutable+0x6f/0x120 drivers/infiniband/sw/siw/siw_verbs.c:203
>  setup_port_data drivers/infiniband/core/device.c:848 [inline]
>  setup_device drivers/infiniband/core/device.c:1244 [inline]
>  ib_register_device+0x1589/0x1df0 drivers/infiniband/core/device.c:1383
>  siw_device_register drivers/infiniband/sw/siw/siw_main.c:72 [inline]
>  siw_newlink+0x129e/0x13d0 drivers/infiniband/sw/siw/siw_main.c:490
>  nldev_newlink+0x8fd/0xa60 drivers/infiniband/core/nldev.c:1763
>  rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>  rdma_nl_rcv+0xe8a/0x1120 drivers/infiniband/core/netlink.c:259
>  netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
>  netlink_unicast+0xf4b/0x1230 net/netlink/af_netlink.c:1368
>  netlink_sendmsg+0x1242/0x1420 net/netlink/af_netlink.c:1910
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  ____sys_sendmsg+0x997/0xd60 net/socket.c:2588
>  ___sys_sendmsg+0x271/0x3b0 net/socket.c:2642
>  __sys_sendmsg net/socket.c:2671 [inline]
>  __do_sys_sendmsg net/socket.c:2680 [inline]
>  __se_sys_sendmsg net/socket.c:2678 [inline]
>  __x64_sys_sendmsg+0x2fa/0x4a0 net/socket.c:2678
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> [...]

Applied, thanks!

[1/1] RDMA/core: Fix uninit-value access in ib_get_eth_speed()
      https://git.kernel.org/rdma/rdma/c/0550d4604e2ca4

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
