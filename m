Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7944B322751
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Feb 2021 09:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhBWI5I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Feb 2021 03:57:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:45176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231845AbhBWI46 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Feb 2021 03:56:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DDF964E4B;
        Tue, 23 Feb 2021 08:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614070577;
        bh=14Vyo4w6HmlmunAB2Xfpmmi1NAfP5HI/euFUBbwRhpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HZpADPRcF5YYCgvQcXFYIyoj2t+kerDR2ry1yv9gJ5DkyqMY9Anc0+ZtpDQL9seSw
         KXHuUy1m3t2k2IGip8MKG/Z3PQdng2tEndY9CkZHuj4O3bjZJSmxx2UDp4mpCIyt0j
         X+KqCfyrcTc6gVC01HTthxGjtGKoUinyY4CK6yToMSmycsxu5YDZ0SHuCBvIBk/uTa
         E1CDycwIJ6/CiRjgfws0db+XJPJ4594YyS5tBkR5q1mLkr5wldG4q/qdHj0opxjfSx
         VyJyiqMwi8n0JETwOEKa8pY2yqu9Nb2xLr9fglY/JFFRmQdL706Usgcfr9mY+C402B
         swdB35B2a4Y2A==
Date:   Tue, 23 Feb 2021 10:56:13 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Filip Krakowski <krakowski@hhu.de>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: ibv_rc_pingpong fails to create a completion queue
Message-ID: <YDTDLd8cvGUgtkqb@unreal>
References: <0fe96275-9413-18a7-8ec0-d6b456dd1f26@hhu.de>
 <CAD=hENcBOO3KfH4wHoz1GBz9LPVZ5BOnoyPq8MMtbhB0DA=F5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENcBOO3KfH4wHoz1GBz9LPVZ5BOnoyPq8MMtbhB0DA=F5w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 23, 2021 at 11:08:18AM +0800, Zhu Yanjun wrote:
> On Tue, Feb 23, 2021 at 12:21 AM Filip Krakowski <krakowski@hhu.de> wrote:
> >
> > Hi,
> >
> > whenever I try to test a reliable connection using "ibv_rc_pingpong -d
> > mlx5_0"
>
> ibv_rc_pingpong -d rxe0 -g 1 > /dev/null &
>
> ibv_rc_pingpong -d rxe0 -g 1 192.168.1.2
>
> I made tests with the above. It can work well.
>
> Normally "-g" is needed.

"-g" is needed because you are running RoCE, while Filip is running IB.

>
> Before directly using mlx5, please make tests with softroce firstly.

Are you sure that RXE works in 4.18.0-151.el8.x86_64 kernel?

>
> Zhu Yanjun
>
>  to start the server side the test immediately stops with
> > "Couldn't create CQ". Since I couldn't find a solution for this problem
> > in one week I would like to ask if someone has encountered this error
> > before or knows a way of troubleshooting it. Just to be sure I updated
> > the controller to its latest firmware (16.29.2002) today, but the error
> > remained the same.
> >
> > System Information
> > ====
> >
> >      * CentOS Linux release 8.1.1911 (Core)
> >      * Linux 4.18.0-151.el8.x86_64
> >      * ConnectX-5 (MCX555A-ECA)
> >
> >
> > Installed Packages
> > ====
> >
> >      * rdma-core-32.0-4.el8.x86_64
> >      * libibverbs-32.0-4.el8.x86_64
> >
> >
> > Loaded Kernel Modules (lsmod | grep -E 'rdma|mlx')
> > ====
> >
> >      rpcrdma               274432  0
> >      sunrpc                454656  22
> > rpcrdma,nfsv4,auth_rpcgss,lockd,nfsv3,rpcsec_gss_krb5,nfs_acl,nfs
> >      rdma_ucm               32768  0
> >      rdma_cm                69632  5
> > rpcrdma,ib_srpt,ib_iser,ib_isert,rdma_ucm
> >      iw_cm                  53248  1 rdma_cm
> >      ib_cm                  57344  3 rdma_cm,ib_ipoib,ib_srpt
> >      mlx5_ib               327680  0
> >      ib_uverbs             147456  3 i40iw,rdma_ucm,mlx5_ib
> >      ib_core               356352  14
> > rdma_cm,ib_ipoib,rpcrdma,ib_srpt,iw_cm,ib_iser,ib_umad,ib_isert,i40iw,rdma_ucm,ib_uverbs,mlx5_ib,ib_cm
> >      mlx5_core             798720  1 mlx5_ib
> >      mlxfw                  24576  1 mlx5_core
> >
> >
> >
> > Infiniband Device Info (ibv_devinfo)
> > ====
> >
> >      hca_id:    i40iw0
> >          transport:            iWARP (1)
> >          fw_ver:                0.2
> >          node_guid:            3cec:ef0d:51c3:0000
> >          sys_image_guid:            3cec:ef0d:51c3:0000
> >          vendor_id:            0x8086
> >          vendor_part_id:            14290
> >          hw_ver:                0x0
> >          board_id:            I40IW Board ID
> >          phys_port_cnt:            1
> >              port:    1
> >                  state:            PORT_DOWN (1)
> >                  max_mtu:        4096 (5)
> >                  active_mtu:        1024 (3)
> >                  sm_lid:            0
> >                  port_lid:        1
> >                  port_lmc:        0x00
> >                  link_layer:        Ethernet
> >
> >      hca_id:    i40iw1
> >          transport:            iWARP (1)
> >          fw_ver:                0.2
> >          node_guid:            3cec:ef0d:51c2:0000
> >          sys_image_guid:            3cec:ef0d:51c2:0000
> >          vendor_id:            0x8086
> >          vendor_part_id:            14290
> >          hw_ver:                0x0
> >          board_id:            I40IW Board ID
> >          phys_port_cnt:            1
> >              port:    1
> >                  state:            PORT_ACTIVE (4)
> >                  max_mtu:        4096 (5)
> >                  active_mtu:        1024 (3)
> >                  sm_lid:            0
> >                  port_lid:        1
> >                  port_lmc:        0x00
> >                  link_layer:        Ethernet
> >
> >      hca_id:    mlx5_0
> >          transport:            InfiniBand (0)
> >          fw_ver:                16.29.2002
> >          node_guid:            0c42:a103:0054:74ca
> >          sys_image_guid:            0c42:a103:0054:74ca
> >          vendor_id:            0x02c9
> >          vendor_part_id:            4119
> >          hw_ver:                0x0
> >          board_id:            MT_0000000010
> >          phys_port_cnt:            1
> >              port:    1
> >                  state:            PORT_ACTIVE (4)
> >                  max_mtu:        4096 (5)
> >                  active_mtu:        4096 (5)
> >                  sm_lid:            8
> >                  port_lid:        196
> >                  port_lmc:        0x00
> >                  link_layer:        InfiniBand
> >
> >
> > Best regards
> > Filip
