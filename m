Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB54494DD6
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jan 2022 13:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242102AbiATMXT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jan 2022 07:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241995AbiATMXS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jan 2022 07:23:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C52C06173F
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jan 2022 04:23:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C729B81D18
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jan 2022 12:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB79C340E5;
        Thu, 20 Jan 2022 12:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642681395;
        bh=LUXfvCJ3wl5psUnR+AVfxxlpXW87GbImyQxPNSSPN+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EWuYAPMqHPqfLqYwMU9xEBrcAIHDR6+a3obRJb2h9w6TrHvuZDuIqx0ZoT2zfIr0Y
         CUGupTTjvh8yKERjMogR7M0gnupGQuWPuNvweleKdzrrmpdPs9IDMj9BIGG+VXLG4E
         PBafOux7YXDynkxqWYtZDj3gHTr69q4fXfxceS0FryrVSmzosRvdeoJoyQU0slz8iI
         MYNYBLv94D/5c1ErvP96HR43QrZJpH0YdgjvO9dXvTwvdCIoUG3x8w22khR/VIdc7n
         UaIhJopcUqO4FXUhoGTJfWjVUW/tdbnNTbdfcMBUz26EdR7XRQ7aM8S+QtRPnaTNmJ
         nh1cSJJ7oHvDw==
Date:   Thu, 20 Jan 2022 14:23:11 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Alexander Kalentyev <comrad.karlovich@gmail.com>
Cc:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        Yanjun Zhu <yanjun.zhu@linux.dev>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: rdma_rxe usage problem
Message-ID: <YelUL9bP20xIOQV1@unreal>
References: <CABrV9Yt0HYenR_qk_QWFkvH4-0Ooeb61y+CyT3WVOnDiAmxjhA@mail.gmail.com>
 <d6551275-6d84-d117-dfa3-91956860ab05@linux.dev>
 <CABrV9YuiYkCKMBMsrnd38ZxwqxJeWMw+xXFRpXc1gMtdAN9bFA@mail.gmail.com>
 <PH7PR84MB14880DAC2578D1CBFAC7CC87BC599@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
 <CABrV9Ys2QnOWJo=-m3fgz77=uLxtbKN4HcDgtxzFskXEObmL-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABrV9Ys2QnOWJo=-m3fgz77=uLxtbKN4HcDgtxzFskXEObmL-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 20, 2022 at 12:32:12PM +0100, Alexander Kalentyev wrote:
> Dear Robert,
> 
> Thank you for your help!
> What I did was :
> ipv6calc --in prefix+mac fe80:: XX:XX:XX:XX:XX:XX
> (with XX:XX:XX:XX:XX:XX one have to insert the MAC address of the NIC)
> And then
> udo ip addr add dev <dev> fe80::ZZZZ:ZZZZ:ZZZZ:ZZZZ/64
> (with ZZZ:ZZZZ:ZZZZ the address genereted by ipv6calc)
> sudo rdma link add rxe0 type rxe netdev <dev>
> After that everything is working as expected:
> >ibv_rc_pingpong -d rxe0 -g 0 192.168.0.176
>   local address:  LID 0x0000, QPN 0x000012, PSN 0xf85048, GID
> ZZZZ::ZZZZ:ZZZZ:ZZZZ:ZZZZ
>   remote address: LID 0x0000, QPN 0x000011, PSN 0xf7c7b7, GID
> ZZZZ::ZZZZ:ZZZZ:ZZZZ:ZZZZ
> 8192000 bytes in 0.01 seconds = 4743.49 Mbit/sec
> 1000 iters in 0.01 seconds = 13.82 usec/iter
> 
> So, I think it make sense to include this information in a README on
> github. Otherwise somebody like me can spend a week trying to figure
> out what is going on!

PR is more than welcomed.

Thanks

> 
> Thanks once again!
> Regards,
> Alexander Kalentev
> 
> ср, 19 янв. 2022 г. в 20:54, Pearson, Robert B <robert.pearson2@hpe.com>:
> >
> >
> >
> > -----Original Message-----
> > From: Alexander Kalentyev <comrad.karlovich@gmail.com>
> > Sent: Wednesday, January 19, 2022 11:53 AM
> >
> >
> > Anyway the ibv_rc_pingpong shows an error:
> >
> > >ibv_rc_pingpong -d rxe0 -g 0
> >   local address:  LID 0x0000, QPN 0x000015, PSN 0x015dd8, GID
> > fe80::4a51:c5ff:fef6:e159
> > Failed to modify QP to RTR
> > Couldn't connect to remote QP
> >
> > >
> > Alexander,
> >
> > I use a script to restart rxe after changing anything it looks like
> >
> >         #!/bin/bash
> >
> >         export LD_LIBRARY_PATH=<path to rdma-core>/rdma-core/build/lib:/usr/lib
> >
> >         sudo rmmod rdma_rxe
> >         sudo modprobe rdma_rxe
> >
> >         sudo ip link set dev enp0s3 mtu 4500
> >         sudo ip addr add dev enp0s3 fe80::0a00:27ff:fe35:5ea7/64
> >         sudo rdma link add rxe0 type rxe netdev enp0s3
> >
> > The important line is adding the ipv6 address which corresponds with the MAC address of
> > The ethernet nic which is
> >
> >         08:00:27:35:5e:a7
> >
> > Some OSes (like mine) do not create this address automatically but mangle the address.
> > But the rdma core driver seems to expect all roce providers to have it.
> >
> > Hope this helps.
> >
> > Bob Pearson
> > rpearson@hpe.com
