Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74AF322482
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Feb 2021 04:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhBWDJN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 22:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhBWDJK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Feb 2021 22:09:10 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F65C061574
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 19:08:30 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id j1so4336736oiw.3
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 19:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kfUzeBtJPddrjO5eIaL86BJswH1VC2q8I2tRRuXhbFQ=;
        b=JZi4nkY36708Awk0xLiGDN4V4q8qAg7rlzB8j5NUHOmETaTGJa6mPdT5sBsKT/xZU2
         UfhDwhnVfp0F4g4U25ZQfXkLFxQ2wE/Hi2XFR3LUIjgL27tjHpREhkWqfX+ai+JsOEgl
         jzvaRzsFIL1mSu7FHFaVGJ5sRac2JHrTJ5bMiYbAb7XmwfDKskzIIBW8p2qyAuzUHGbR
         S4hLv/8SzzaX7oa79CxEmBySnzk7SztFHlhAu2nvrsGwj3Gb/tBYCp6JYyQCu2x3QzvM
         AO24g6ado652F0vWyyWgCJU9/m6WoSAbU9cC95N6uoWaUKEncYSwTr1uHxh8LRcqK8/J
         nT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kfUzeBtJPddrjO5eIaL86BJswH1VC2q8I2tRRuXhbFQ=;
        b=W0SrIyzmRKvcNXo1xjZPam4pU8o4Qvu9amr0Hf+356nkjSrgpXGl1DNAMgm9i+pkrK
         yUdIjdCYDp0mTkHYLqY2swwZaDcX29yHr5bBy/XHRd7UrXYelSnpP2/vTmGGDoijdUEL
         Rw9BVJpKs9vT7bYKvI4lJO/w183vyZK6X7na2pefHzDlW67IHt97Pq6Zjz/Vr0NWAjUr
         +sMXc7weZBbi28NSesY9jJ+JnQDnvSdZRfn7c5GB6aWvl/DIZb/Pti+4MDCgyJYDQjlE
         vIUjf8Vt1AtHZ0WoyOAKn/E+nqBeLBeY3dChjX++w6r+1eA+ALJ7VE0BDjD+zP1EmAfZ
         owVw==
X-Gm-Message-State: AOAM532hTqGa/N+UuOv11nDKbcD8eKXFyWm7N4hSmDRqyXLq+uZD5Ui3
        thk20Dyh0Pxu6BcZJyhA4ukGv5Mr6FQRmTRyv2Zq2Upiflc=
X-Google-Smtp-Source: ABdhPJz+v4BgxIeo3cxI0MtQ6qDe0IR/zRA8k9iNCEldqch2iMOZ19lVTsHgJIHhydccfvTZWdFHY+ughJlWLKtVXWM=
X-Received: by 2002:a05:6808:3b0:: with SMTP id n16mr16853049oie.163.1614049709952;
 Mon, 22 Feb 2021 19:08:29 -0800 (PST)
MIME-Version: 1.0
References: <0fe96275-9413-18a7-8ec0-d6b456dd1f26@hhu.de>
In-Reply-To: <0fe96275-9413-18a7-8ec0-d6b456dd1f26@hhu.de>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 23 Feb 2021 11:08:18 +0800
Message-ID: <CAD=hENcBOO3KfH4wHoz1GBz9LPVZ5BOnoyPq8MMtbhB0DA=F5w@mail.gmail.com>
Subject: Re: ibv_rc_pingpong fails to create a completion queue
To:     Filip Krakowski <krakowski@hhu.de>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 23, 2021 at 12:21 AM Filip Krakowski <krakowski@hhu.de> wrote:
>
> Hi,
>
> whenever I try to test a reliable connection using "ibv_rc_pingpong -d
> mlx5_0"

ibv_rc_pingpong -d rxe0 -g 1 > /dev/null &

ibv_rc_pingpong -d rxe0 -g 1 192.168.1.2

I made tests with the above. It can work well.

Normally "-g" is needed.

Before directly using mlx5, please make tests with softroce firstly.

Zhu Yanjun

 to start the server side the test immediately stops with
> "Couldn't create CQ". Since I couldn't find a solution for this problem
> in one week I would like to ask if someone has encountered this error
> before or knows a way of troubleshooting it. Just to be sure I updated
> the controller to its latest firmware (16.29.2002) today, but the error
> remained the same.
>
> System Information
> ====
>
>      * CentOS Linux release 8.1.1911 (Core)
>      * Linux 4.18.0-151.el8.x86_64
>      * ConnectX-5 (MCX555A-ECA)
>
>
> Installed Packages
> ====
>
>      * rdma-core-32.0-4.el8.x86_64
>      * libibverbs-32.0-4.el8.x86_64
>
>
> Loaded Kernel Modules (lsmod | grep -E 'rdma|mlx')
> ====
>
>      rpcrdma               274432  0
>      sunrpc                454656  22
> rpcrdma,nfsv4,auth_rpcgss,lockd,nfsv3,rpcsec_gss_krb5,nfs_acl,nfs
>      rdma_ucm               32768  0
>      rdma_cm                69632  5
> rpcrdma,ib_srpt,ib_iser,ib_isert,rdma_ucm
>      iw_cm                  53248  1 rdma_cm
>      ib_cm                  57344  3 rdma_cm,ib_ipoib,ib_srpt
>      mlx5_ib               327680  0
>      ib_uverbs             147456  3 i40iw,rdma_ucm,mlx5_ib
>      ib_core               356352  14
> rdma_cm,ib_ipoib,rpcrdma,ib_srpt,iw_cm,ib_iser,ib_umad,ib_isert,i40iw,rdma_ucm,ib_uverbs,mlx5_ib,ib_cm
>      mlx5_core             798720  1 mlx5_ib
>      mlxfw                  24576  1 mlx5_core
>
>
>
> Infiniband Device Info (ibv_devinfo)
> ====
>
>      hca_id:    i40iw0
>          transport:            iWARP (1)
>          fw_ver:                0.2
>          node_guid:            3cec:ef0d:51c3:0000
>          sys_image_guid:            3cec:ef0d:51c3:0000
>          vendor_id:            0x8086
>          vendor_part_id:            14290
>          hw_ver:                0x0
>          board_id:            I40IW Board ID
>          phys_port_cnt:            1
>              port:    1
>                  state:            PORT_DOWN (1)
>                  max_mtu:        4096 (5)
>                  active_mtu:        1024 (3)
>                  sm_lid:            0
>                  port_lid:        1
>                  port_lmc:        0x00
>                  link_layer:        Ethernet
>
>      hca_id:    i40iw1
>          transport:            iWARP (1)
>          fw_ver:                0.2
>          node_guid:            3cec:ef0d:51c2:0000
>          sys_image_guid:            3cec:ef0d:51c2:0000
>          vendor_id:            0x8086
>          vendor_part_id:            14290
>          hw_ver:                0x0
>          board_id:            I40IW Board ID
>          phys_port_cnt:            1
>              port:    1
>                  state:            PORT_ACTIVE (4)
>                  max_mtu:        4096 (5)
>                  active_mtu:        1024 (3)
>                  sm_lid:            0
>                  port_lid:        1
>                  port_lmc:        0x00
>                  link_layer:        Ethernet
>
>      hca_id:    mlx5_0
>          transport:            InfiniBand (0)
>          fw_ver:                16.29.2002
>          node_guid:            0c42:a103:0054:74ca
>          sys_image_guid:            0c42:a103:0054:74ca
>          vendor_id:            0x02c9
>          vendor_part_id:            4119
>          hw_ver:                0x0
>          board_id:            MT_0000000010
>          phys_port_cnt:            1
>              port:    1
>                  state:            PORT_ACTIVE (4)
>                  max_mtu:        4096 (5)
>                  active_mtu:        4096 (5)
>                  sm_lid:            8
>                  port_lid:        196
>                  port_lmc:        0x00
>                  link_layer:        InfiniBand
>
>
> Best regards
> Filip
