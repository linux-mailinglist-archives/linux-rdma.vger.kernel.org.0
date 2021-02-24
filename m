Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9CF7323A89
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Feb 2021 11:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbhBXK2S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Feb 2021 05:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhBXK2E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Feb 2021 05:28:04 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F01C061574
        for <linux-rdma@vger.kernel.org>; Wed, 24 Feb 2021 02:27:22 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id s107so1657589otb.8
        for <linux-rdma@vger.kernel.org>; Wed, 24 Feb 2021 02:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4acaKRqCf0bOOQ3IyH+lZJeYfD3Ft4tRiyv2kJXH9Ow=;
        b=gYcoMYg/78VPZJnJm4/FeOpBOUsZFGv32YvJmwRjxKJFqn+kEHHn5fxWosQg0i5yUE
         tpqA1P0MpmvAKRgw5R+G0C+/WU43slWdTVzUEu7qEJ9G7ygMg42tWSA1JePrwIj+oTgB
         VEztwQ7a9XtqlVoyhIxHWKIE0IOHMWkkuZ39G+CbCFHMdIBG1Ojcgvh1refE5mRDY8Ye
         saeWWJFvsnNi2reH7qYQim3rsl/7k4HkoGNz3NEYXXTqo9+wyKrJ9cSIH2USlsR44km4
         PtTm/EZ6w12FUV0HH6Xt9W+B1hbf/V9tjDMgDcrCc1tvfB03lFRs95Tw1tlW88q8GM/u
         hqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4acaKRqCf0bOOQ3IyH+lZJeYfD3Ft4tRiyv2kJXH9Ow=;
        b=TdsHKgQmk+NTCLcCgCW7hxPNUQKEADkWGWeadiVc6hslYR2Kl5kB2k7jsDXHALjDnh
         woAoiM9tHsiEzbnEZh3HSyq1YVQyaLx19YdzAaDsfK7KntrCmW8LAA/e2xq/FvNLnAmd
         /uqTzz8R2zdswNZPeUuVMbTc8WsP8q/ZYaZdIVKwHAKzFzpERrd/A9ttLFbt9TntKoki
         j+u/4/A88Y23hubEubLFjQfUGvnTIiUZEk2/0oGVUieKDu4QcetgBZz1NkwWW0tGdwO3
         uz1vziE0VPNNObCcbPKKPgBQIhh8sEZfd9+ZG5MQPw0FQZSZNWvyNSouLsrF77at18QU
         PJNQ==
X-Gm-Message-State: AOAM530Fn1LaqTDpkGYv41ZRQuujNMlTTQu+BcJ5qg3fvUX0KzYRidar
        OHI+dfu6IygE0S1EeTifTjW2Y9iB+Klbsf5hAps=
X-Google-Smtp-Source: ABdhPJxwkY0a0Bs3dk2ALiyB4WZa2jTb2z/mSs+nG4z5b70wSE1DfdCfs1tgAxTsld8pQqTfdtRTxWwcr8qLQu1/s2E=
X-Received: by 2002:a05:6830:3482:: with SMTP id c2mr23872030otu.59.1614162441483;
 Wed, 24 Feb 2021 02:27:21 -0800 (PST)
MIME-Version: 1.0
References: <0fe96275-9413-18a7-8ec0-d6b456dd1f26@hhu.de> <CAD=hENcBOO3KfH4wHoz1GBz9LPVZ5BOnoyPq8MMtbhB0DA=F5w@mail.gmail.com>
 <YDTDLd8cvGUgtkqb@unreal> <CAD=hENfGaH00Y52ped7v1uQtiDwaHUFMxMjGMJYLjp_L0hSmEw@mail.gmail.com>
 <d976bf77-c291-11a5-a8d4-8bbfd149a2d8@hhu.de>
In-Reply-To: <d976bf77-c291-11a5-a8d4-8bbfd149a2d8@hhu.de>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 24 Feb 2021 18:27:10 +0800
Message-ID: <CAD=hENfLMHd0EbLUUzYXOoN5+ghiZRmMdAQ0-8ogTY_fCFW9Dg@mail.gmail.com>
Subject: Re: ibv_rc_pingpong fails to create a completion queue
To:     Filip Krakowski <krakowski@hhu.de>
Cc:     Leon Romanovsky <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 23, 2021 at 9:45 PM Filip Krakowski <krakowski@hhu.de> wrote:
>
> Hi,
>
> "I use the kernel 4.18.0-240.10.1.el8_3.x86_64 to make tests." was the
> line that solved this problem.
> I never thought I would be stuck with a problem for a week caused by the
> kernel...
>
> That said, updating the kernel to "4.18.0-277.el8.x86_64" solved the
> problem.

Glad to hear this.

Zhu Yanjun
> Thanks for answering this fast and sorry for taking your time
> considering the trivial solution.
>
> Best regards
> Filip
>
> On 2/23/21 10:50 AM, Zhu Yanjun wrote:
> > On Tue, Feb 23, 2021 at 4:56 PM Leon Romanovsky <leon@kernel.org> wrote:
> >> On Tue, Feb 23, 2021 at 11:08:18AM +0800, Zhu Yanjun wrote:
> >>> On Tue, Feb 23, 2021 at 12:21 AM Filip Krakowski <krakowski@hhu.de> wrote:
> >>>> Hi,
> >>>>
> >>>> whenever I try to test a reliable connection using "ibv_rc_pingpong -d
> >>>> mlx5_0"
> >>> ibv_rc_pingpong -d rxe0 -g 1 > /dev/null &
> >>>
> >>> ibv_rc_pingpong -d rxe0 -g 1 192.168.1.2
> >>>
> >>> I made tests with the above. It can work well.
> >>>
> >>> Normally "-g" is needed.
> >> "-g" is needed because you are running RoCE, while Filip is running IB.
> >>
> >>> Before directly using mlx5, please make tests with softroce firstly.
> >> Are you sure that RXE works in 4.18.0-151.el8.x86_64 kernel?
> > I have no 4.18.0-151.el8.x86_64 kernel at hand.
> > I use the kernel 4.18.0-240.10.1.el8_3.x86_64 to make tests.
> >
> > SoftRoCE can work well.
> >
> > Zhu Yanjun
> >
> >>> Zhu Yanjun
> >>>
> >>>   to start the server side the test immediately stops with
> >>>> "Couldn't create CQ". Since I couldn't find a solution for this problem
> >>>> in one week I would like to ask if someone has encountered this error
> >>>> before or knows a way of troubleshooting it. Just to be sure I updated
> >>>> the controller to its latest firmware (16.29.2002) today, but the error
> >>>> remained the same.
> >>>>
> >>>> System Information
> >>>> ====
> >>>>
> >>>>       * CentOS Linux release 8.1.1911 (Core)
> >>>>       * Linux 4.18.0-151.el8.x86_64
> >>>>       * ConnectX-5 (MCX555A-ECA)
> >>>>
> >>>>
> >>>> Installed Packages
> >>>> ====
> >>>>
> >>>>       * rdma-core-32.0-4.el8.x86_64
> >>>>       * libibverbs-32.0-4.el8.x86_64
> >>>>
> >>>>
> >>>> Loaded Kernel Modules (lsmod | grep -E 'rdma|mlx')
> >>>> ====
> >>>>
> >>>>       rpcrdma               274432  0
> >>>>       sunrpc                454656  22
> >>>> rpcrdma,nfsv4,auth_rpcgss,lockd,nfsv3,rpcsec_gss_krb5,nfs_acl,nfs
> >>>>       rdma_ucm               32768  0
> >>>>       rdma_cm                69632  5
> >>>> rpcrdma,ib_srpt,ib_iser,ib_isert,rdma_ucm
> >>>>       iw_cm                  53248  1 rdma_cm
> >>>>       ib_cm                  57344  3 rdma_cm,ib_ipoib,ib_srpt
> >>>>       mlx5_ib               327680  0
> >>>>       ib_uverbs             147456  3 i40iw,rdma_ucm,mlx5_ib
> >>>>       ib_core               356352  14
> >>>> rdma_cm,ib_ipoib,rpcrdma,ib_srpt,iw_cm,ib_iser,ib_umad,ib_isert,i40iw,rdma_ucm,ib_uverbs,mlx5_ib,ib_cm
> >>>>       mlx5_core             798720  1 mlx5_ib
> >>>>       mlxfw                  24576  1 mlx5_core
> >>>>
> >>>>
> >>>>
> >>>> Infiniband Device Info (ibv_devinfo)
> >>>> ====
> >>>>
> >>>>       hca_id:    i40iw0
> >>>>           transport:            iWARP (1)
> >>>>           fw_ver:                0.2
> >>>>           node_guid:            3cec:ef0d:51c3:0000
> >>>>           sys_image_guid:            3cec:ef0d:51c3:0000
> >>>>           vendor_id:            0x8086
> >>>>           vendor_part_id:            14290
> >>>>           hw_ver:                0x0
> >>>>           board_id:            I40IW Board ID
> >>>>           phys_port_cnt:            1
> >>>>               port:    1
> >>>>                   state:            PORT_DOWN (1)
> >>>>                   max_mtu:        4096 (5)
> >>>>                   active_mtu:        1024 (3)
> >>>>                   sm_lid:            0
> >>>>                   port_lid:        1
> >>>>                   port_lmc:        0x00
> >>>>                   link_layer:        Ethernet
> >>>>
> >>>>       hca_id:    i40iw1
> >>>>           transport:            iWARP (1)
> >>>>           fw_ver:                0.2
> >>>>           node_guid:            3cec:ef0d:51c2:0000
> >>>>           sys_image_guid:            3cec:ef0d:51c2:0000
> >>>>           vendor_id:            0x8086
> >>>>           vendor_part_id:            14290
> >>>>           hw_ver:                0x0
> >>>>           board_id:            I40IW Board ID
> >>>>           phys_port_cnt:            1
> >>>>               port:    1
> >>>>                   state:            PORT_ACTIVE (4)
> >>>>                   max_mtu:        4096 (5)
> >>>>                   active_mtu:        1024 (3)
> >>>>                   sm_lid:            0
> >>>>                   port_lid:        1
> >>>>                   port_lmc:        0x00
> >>>>                   link_layer:        Ethernet
> >>>>
> >>>>       hca_id:    mlx5_0
> >>>>           transport:            InfiniBand (0)
> >>>>           fw_ver:                16.29.2002
> >>>>           node_guid:            0c42:a103:0054:74ca
> >>>>           sys_image_guid:            0c42:a103:0054:74ca
> >>>>           vendor_id:            0x02c9
> >>>>           vendor_part_id:            4119
> >>>>           hw_ver:                0x0
> >>>>           board_id:            MT_0000000010
> >>>>           phys_port_cnt:            1
> >>>>               port:    1
> >>>>                   state:            PORT_ACTIVE (4)
> >>>>                   max_mtu:        4096 (5)
> >>>>                   active_mtu:        4096 (5)
> >>>>                   sm_lid:            8
> >>>>                   port_lid:        196
> >>>>                   port_lmc:        0x00
> >>>>                   link_layer:        InfiniBand
> >>>>
> >>>>
> >>>> Best regards
> >>>> Filip
>
