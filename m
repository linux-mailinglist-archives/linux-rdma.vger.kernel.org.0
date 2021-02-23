Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEFF322823
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Feb 2021 10:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhBWJxp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Feb 2021 04:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhBWJvS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Feb 2021 04:51:18 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6E2C061786
        for <linux-rdma@vger.kernel.org>; Tue, 23 Feb 2021 01:50:38 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id b8so14939245oti.7
        for <linux-rdma@vger.kernel.org>; Tue, 23 Feb 2021 01:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DzQ9pQ2Y4ykOxM4kBnezaXnOuK+QMlrXt0XpviCqjbY=;
        b=VBBFeH3In68vqrCZq/LdbyO4B8BJZ3LHoZH0+O2TaGGLN4KmmeFVyl3QDF8qNdoSaP
         bAwEMiWQytGygznLIM8U89/XgMZOUkdHQsTo9pg1eVXIn2nnq8w4AtjR/t16hR8fvdqv
         R0kmT9RZ4q09FlEZAcNxhZzoRTa7L3uecHMNhnq1orMaqCu8Fv7ec0MsJi9B4/juK4GO
         IV6WRzFSmgJZznZXfVTPhKhZ38+9TcJ369cSSqHQ7vnfDgOCXY05tRAhwEiXi9JF+ddi
         U0x6H0BgX6A8SzgeoK0oyQzHSxxC95hpmc/GXx5mikh3MwNZNJxj290Kc3xtNsMArxZ7
         dbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DzQ9pQ2Y4ykOxM4kBnezaXnOuK+QMlrXt0XpviCqjbY=;
        b=WKQnMB5lVha43LSnlZCd59X49q29WhorYw/HiLkMon26lS8neW6VI4ddVEMGLs3qIY
         /tl4dlgSiCNFspG4xQezyTMjSzziY5U5aD/1MrBccqeHolj+r7FdfizEnT+pIhbLukNi
         9bMn9DPG+T8H9bf2J88t37yaGg889H8EAKoyE114rmPS2MrXasdlkgJ1lte8jONDF2hI
         GMaNKrZh8hYScLHSYCwriZcSeSVvX+Ki2KTlHyNWRiznn6/tlx0v66q1invxVf5uOC1y
         3qm5f5/f06/lULJDEdq29z+AhOdbO1XIdCzoEfMdnVGjUXeEZc2yGHYiCcMF/Arq9Po1
         hfdg==
X-Gm-Message-State: AOAM5327sQuYncjI2B0JV/s4Y3AqI0dYUgEe6dlTz+u/QcoNj3sumYqs
        a+xp9LkuMx3pT43Agw6jvRseGSztvNQqcBcokbXEJ19A5wk=
X-Google-Smtp-Source: ABdhPJyqtIWXnstSaNB7QwbkTwZqscBZmsFPOaFMvdvaM5I99FURk4YKVnHHTVe1LztJsLdCJyv/SRdJ/Z2sOfz69I8=
X-Received: by 2002:a05:6830:30bb:: with SMTP id g27mr16403760ots.278.1614073837968;
 Tue, 23 Feb 2021 01:50:37 -0800 (PST)
MIME-Version: 1.0
References: <0fe96275-9413-18a7-8ec0-d6b456dd1f26@hhu.de> <CAD=hENcBOO3KfH4wHoz1GBz9LPVZ5BOnoyPq8MMtbhB0DA=F5w@mail.gmail.com>
 <YDTDLd8cvGUgtkqb@unreal>
In-Reply-To: <YDTDLd8cvGUgtkqb@unreal>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 23 Feb 2021 17:50:26 +0800
Message-ID: <CAD=hENfGaH00Y52ped7v1uQtiDwaHUFMxMjGMJYLjp_L0hSmEw@mail.gmail.com>
Subject: Re: ibv_rc_pingpong fails to create a completion queue
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Filip Krakowski <krakowski@hhu.de>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 23, 2021 at 4:56 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, Feb 23, 2021 at 11:08:18AM +0800, Zhu Yanjun wrote:
> > On Tue, Feb 23, 2021 at 12:21 AM Filip Krakowski <krakowski@hhu.de> wrote:
> > >
> > > Hi,
> > >
> > > whenever I try to test a reliable connection using "ibv_rc_pingpong -d
> > > mlx5_0"
> >
> > ibv_rc_pingpong -d rxe0 -g 1 > /dev/null &
> >
> > ibv_rc_pingpong -d rxe0 -g 1 192.168.1.2
> >
> > I made tests with the above. It can work well.
> >
> > Normally "-g" is needed.
>
> "-g" is needed because you are running RoCE, while Filip is running IB.
>
> >
> > Before directly using mlx5, please make tests with softroce firstly.
>
> Are you sure that RXE works in 4.18.0-151.el8.x86_64 kernel?

I have no 4.18.0-151.el8.x86_64 kernel at hand.
I use the kernel 4.18.0-240.10.1.el8_3.x86_64 to make tests.

SoftRoCE can work well.

Zhu Yanjun

>
> >
> > Zhu Yanjun
> >
> >  to start the server side the test immediately stops with
> > > "Couldn't create CQ". Since I couldn't find a solution for this problem
> > > in one week I would like to ask if someone has encountered this error
> > > before or knows a way of troubleshooting it. Just to be sure I updated
> > > the controller to its latest firmware (16.29.2002) today, but the error
> > > remained the same.
> > >
> > > System Information
> > > ====
> > >
> > >      * CentOS Linux release 8.1.1911 (Core)
> > >      * Linux 4.18.0-151.el8.x86_64
> > >      * ConnectX-5 (MCX555A-ECA)
> > >
> > >
> > > Installed Packages
> > > ====
> > >
> > >      * rdma-core-32.0-4.el8.x86_64
> > >      * libibverbs-32.0-4.el8.x86_64
> > >
> > >
> > > Loaded Kernel Modules (lsmod | grep -E 'rdma|mlx')
> > > ====
> > >
> > >      rpcrdma               274432  0
> > >      sunrpc                454656  22
> > > rpcrdma,nfsv4,auth_rpcgss,lockd,nfsv3,rpcsec_gss_krb5,nfs_acl,nfs
> > >      rdma_ucm               32768  0
> > >      rdma_cm                69632  5
> > > rpcrdma,ib_srpt,ib_iser,ib_isert,rdma_ucm
> > >      iw_cm                  53248  1 rdma_cm
> > >      ib_cm                  57344  3 rdma_cm,ib_ipoib,ib_srpt
> > >      mlx5_ib               327680  0
> > >      ib_uverbs             147456  3 i40iw,rdma_ucm,mlx5_ib
> > >      ib_core               356352  14
> > > rdma_cm,ib_ipoib,rpcrdma,ib_srpt,iw_cm,ib_iser,ib_umad,ib_isert,i40iw,rdma_ucm,ib_uverbs,mlx5_ib,ib_cm
> > >      mlx5_core             798720  1 mlx5_ib
> > >      mlxfw                  24576  1 mlx5_core
> > >
> > >
> > >
> > > Infiniband Device Info (ibv_devinfo)
> > > ====
> > >
> > >      hca_id:    i40iw0
> > >          transport:            iWARP (1)
> > >          fw_ver:                0.2
> > >          node_guid:            3cec:ef0d:51c3:0000
> > >          sys_image_guid:            3cec:ef0d:51c3:0000
> > >          vendor_id:            0x8086
> > >          vendor_part_id:            14290
> > >          hw_ver:                0x0
> > >          board_id:            I40IW Board ID
> > >          phys_port_cnt:            1
> > >              port:    1
> > >                  state:            PORT_DOWN (1)
> > >                  max_mtu:        4096 (5)
> > >                  active_mtu:        1024 (3)
> > >                  sm_lid:            0
> > >                  port_lid:        1
> > >                  port_lmc:        0x00
> > >                  link_layer:        Ethernet
> > >
> > >      hca_id:    i40iw1
> > >          transport:            iWARP (1)
> > >          fw_ver:                0.2
> > >          node_guid:            3cec:ef0d:51c2:0000
> > >          sys_image_guid:            3cec:ef0d:51c2:0000
> > >          vendor_id:            0x8086
> > >          vendor_part_id:            14290
> > >          hw_ver:                0x0
> > >          board_id:            I40IW Board ID
> > >          phys_port_cnt:            1
> > >              port:    1
> > >                  state:            PORT_ACTIVE (4)
> > >                  max_mtu:        4096 (5)
> > >                  active_mtu:        1024 (3)
> > >                  sm_lid:            0
> > >                  port_lid:        1
> > >                  port_lmc:        0x00
> > >                  link_layer:        Ethernet
> > >
> > >      hca_id:    mlx5_0
> > >          transport:            InfiniBand (0)
> > >          fw_ver:                16.29.2002
> > >          node_guid:            0c42:a103:0054:74ca
> > >          sys_image_guid:            0c42:a103:0054:74ca
> > >          vendor_id:            0x02c9
> > >          vendor_part_id:            4119
> > >          hw_ver:                0x0
> > >          board_id:            MT_0000000010
> > >          phys_port_cnt:            1
> > >              port:    1
> > >                  state:            PORT_ACTIVE (4)
> > >                  max_mtu:        4096 (5)
> > >                  active_mtu:        4096 (5)
> > >                  sm_lid:            8
> > >                  port_lid:        196
> > >                  port_lmc:        0x00
> > >                  link_layer:        InfiniBand
> > >
> > >
> > > Best regards
> > > Filip
