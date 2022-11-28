Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E1363A5EF
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Nov 2022 11:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiK1KSz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Nov 2022 05:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiK1KSw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Nov 2022 05:18:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911A21A389
        for <linux-rdma@vger.kernel.org>; Mon, 28 Nov 2022 02:18:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E71061073
        for <linux-rdma@vger.kernel.org>; Mon, 28 Nov 2022 10:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECDFC433D7;
        Mon, 28 Nov 2022 10:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669630726;
        bh=l5JQ9X7I0cTdyzdEB/DE96gLkohptNtkeMdIpLSzNX0=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=SQfkhfFTAYTHcnmkKK37IswQhaXxNlMTrvb4eKlNQgc4VJweaI45tF3UOC8N8myrd
         GLwMY9Wk1eJmrHSadco+B8E9ikWkHWlVVYYBgumC0fYHF5iHS0T2UEm8IBR6i1k0rx
         hEGX0koBWf73vlGql42AgQqifR0rp3ZnxGVe1ZswARr5xaEQIiZ1RkV7kPra3uSF3Q
         R1d7fs0zRm7PALfbzXysVTuflJZtzzTYH611tG/igx+chrARpKNdXGy5tYaUT3/mJ0
         cVvp1nEIF3Kp31W9+xOUDSuBGHqwtdWxIz4hcpcy+wn6XbS4XosMMwpOu3l3N3wiIG
         +ebSjtYVmnQKw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
In-Reply-To: <0-v1-a7c81b3842ce+e5-netdev_tracker_jgg@nvidia.com>
References: <0-v1-a7c81b3842ce+e5-netdev_tracker_jgg@nvidia.com>
Subject: Re: [PATCH] RDMA: Add netdevice_tracker to ib_device_set_netdev()
Message-Id: <166963072220.595164.2063038868083584091.b4-ty@kernel.org>
Date:   Mon, 28 Nov 2022 12:18:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-87e0e
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 23 Nov 2022 20:27:14 -0400, Jason Gunthorpe wrote:
> This will cause an informative backtrace to print if the user of
> ib_device_set_netdev() isn't careful about tearing down the ibdevice
> before its the netdevice parent is destroyed. Such as like this:
> 
>   unregister_netdevice: waiting for vlan0 to become free. Usage count = 2
>   leaked reference.
>    ib_device_set_netdev+0x266/0x730
>    siw_newlink+0x4e0/0xfd0
>    nldev_newlink+0x35c/0x5c0
>    rdma_nl_rcv_msg+0x36d/0x690
>    rdma_nl_rcv+0x2ee/0x430
>    netlink_unicast+0x543/0x7f0
>    netlink_sendmsg+0x918/0xe20
>    sock_sendmsg+0xcf/0x120
>    ____sys_sendmsg+0x70d/0x8b0
>    ___sys_sendmsg+0x11d/0x1b0
>    __sys_sendmsg+0xfa/0x1d0
>    do_syscall_64+0x35/0xb0
>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [...]

Applied, thanks!

[1/1] RDMA: Add netdevice_tracker to ib_device_set_netdev()
      https://git.kernel.org/rdma/rdma/c/09f530f0c6d668

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
