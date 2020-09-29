Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54BB27BCC0
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Sep 2020 08:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgI2GEv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 02:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI2GEv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Sep 2020 02:04:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D99C061755
        for <linux-rdma@vger.kernel.org>; Mon, 28 Sep 2020 23:04:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t10so3919667wrv.1
        for <linux-rdma@vger.kernel.org>; Mon, 28 Sep 2020 23:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UTzjivD8al9txgEqwbjKP1Ayj3RsW00zEDrSgHBx658=;
        b=Idarl2WengdjMgiDBvwpLfRXGioVemysTxdP6h/iiOTJ628OlsXoMBPE/IQiVgWXW4
         EAYbm2jFoPjnyYZmHUchuq8WcQT8laCwqWeZSnthy3R2oaR0uzceK3Qq5esDZVnkC3Vm
         qTG0FKkSgCNkY01DgQjrxM1/5eD97/qmQnqZi9LIZFc35OZE42p3JGmTm6ZbQnfgl6/N
         LOE+QOqDxNJ64BeXSaUrYWUfPUG+RI1mYoEuF//X3F9NUHlEAbKoN5kbKwquKecYqo6e
         Fbkaoixuut+1JhQ7K9mX6AOxFGc+7ebWcGYlXDpxyLSxLGVI167HMDrOgBEB0pfLrjuL
         DVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UTzjivD8al9txgEqwbjKP1Ayj3RsW00zEDrSgHBx658=;
        b=CLYLwTBJgptiK8Z/RSxM/Fixj1/IvlaN4EP9LjLShLgcwaSYNC/1lWnXha12jbHHko
         5x7GILqHCg9y+Jboowc3zAtcnNj8xf4XXOc4tnhXldgwj1eOePkPIWKQ5JdFdBU5zoFj
         Zd0UtissqDoBjIpvCoyQpj5bvxaVT0bp3TFQBfiR/XCARkiTYJMGk0Ig5XQE1UoUO9as
         VFkMtbixvbbIcXnf1cL07a8scyOIL7/2/nrl9JgnYF9XMfHHg2B9QFC/re7RaGr3w1Zo
         Iyx8LPU6JPq/twSsTttLZFcemn+egwK5ds38wXEZWAocm1LQA2ubAawRmBhxG45WEJua
         ZcNA==
X-Gm-Message-State: AOAM532O2SeUsb95bC+mLh3k66a7ohANtJjmR0xXHONpRn+pwtkQRh82
        XNnxmWRAR5LMnHHqwCIH9Zo=
X-Google-Smtp-Source: ABdhPJyUMKgS7TOeObnoaSazm7fe2LwSIxHnfsnTHMVriOKsoO9yOKIohsrB32py5feA3EtCCOi9JQ==
X-Received: by 2002:a5d:56cd:: with SMTP id m13mr2089239wrw.261.1601359489860;
        Mon, 28 Sep 2020 23:04:49 -0700 (PDT)
Received: from kheib-workstation ([2a00:a040:19b:e02f:5cc2:9fa6:fc6d:771d])
        by smtp.gmail.com with ESMTPSA id h186sm3976642wmf.24.2020.09.28.23.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 23:04:49 -0700 (PDT)
Date:   Tue, 29 Sep 2020 09:04:38 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-rc] RDMA/ipoib: Set rtnl_link_ops for ipoib interfaces
Message-ID: <20200929060438.GA73375@kheib-workstation>
References: <20200928202631.52020-1-kamalheib1@gmail.com>
 <20200928223602.GS9916@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928223602.GS9916@ziepe.ca>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 28, 2020 at 07:36:02PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 28, 2020 at 11:26:31PM +0300, Kamal Heib wrote:
> > Before this patch, the rtnl_link_ops are set only for ipoib network
> > devices that are created via the rtnl_link_ops->newlink() callback, this
> > patch fixes that by setting the rtnl_link_ops for all ipoib network
> > devices. Also, implement the dellink() callback to block users from
> > trying to remove the base ipoib network device while allowing it only
> > for child interfaces.
> 
> Why?
>

This is needed to avoid the inconsistent user experience for PKeys that
is created via netlink VS PKeys that is created via sysfs and the based
ipoib interface, as you can see below the ipoib attributes are reported
only for PKeys that is created via netlink in the 'ip -d link show'
output:

PKey created via netlink (pkey, mode, and umcast attributes are present):
$ ip link add link mlx5_ib0 name mlx5_ib0.8001 type ipoib pkey 0x8001
$ ip -d link show dev mlx5_ib0.8001
28: mlx5_ib0.8001@mlx5_ib0: <BROADCAST,MULTICAST> mtu 4092 qdisc noop state DOWN mode DEFAULT group default qlen 256
    link/infiniband 00:00:1f:e3:fe:80:00:00:00:00:00:00:24:8a:07:03:00:a3:19:64 brd 00:ff:ff:ff:ff:12:40:1b:80:01:00:00:00:00:00:00:ff:ff:ff:ff promiscuity 0 minmtu 68 maxmtu 65520
    ipoib pkey  0x8001 mode  datagram umcast  0000 addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535

While:

PKey created via sysfs (the attributes are not present):
$ ip -d link show dev mlx5_ib0.8002
20: mlx5_ib0.8002@mlx5_ib0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 2044 qdisc mq state UP mode DEFAULT group default qlen 256
    link/infiniband 00:00:11:7b:fe:80:00:00:00:00:00:00:24:8a:07:03:00:a3:19:64 brd 00:ff:ff:ff:ff:12:40:1b:80:02:00:00:00:00:00:00:ff:ff:ff:ff promiscuity 0 minmtu 68 maxmtu 65520 addrgenmode none numtxqueues 256 numrxqueues 32 gso_max_size 65536 gso_max_segs 65535

Same for the base interface:
$ ip -d link show dev mlx5_ib0
19: mlx5_ib0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 2044 qdisc mq state UP mode DEFAULT group default qlen 256
    link/infiniband 00:00:11:79:fe:80:00:00:00:00:00:00:24:8a:07:03:00:a3:19:64 brd 00:ff:ff:ff:ff:12:40:1b:ff:ff:00:00:00:00:00:00:ff:ff:ff:ff promiscuity 0 minmtu 68 maxmtu 65520 addrgenmode none numtxqueues 256 numrxqueues 32 gso_max_size 65536 gso_max_segs 65535 
    altname ibp7s0f0

After applying this patch:

$ ip link add link mlx5_ib0 name mlx5_ib0.8001 type ipoib pkey 0x8001
$ ip -d link show dev mlx5_ib0.8001
38: mlx5_ib0.8001@mlx5_ib0: <BROADCAST,MULTICAST> mtu 4092 qdisc noop state DOWN mode DEFAULT group default qlen 256
    link/infiniband 00:00:2e:4e:fe:80:00:00:00:00:00:00:24:8a:07:03:00:a3:19:64 brd 00:ff:ff:ff:ff:12:40:1b:80:01:00:00:00:00:00:00:ff:ff:ff:ff promiscuity 0 minmtu 68 maxmtu 65520
    ipoib pkey  0x8001 mode  datagram umcast  0000 addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535

$ ip -d link show dev mlx5_ib0.8002
30: mlx5_ib0.8002@mlx5_ib0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 2044 qdisc mq state UP mode DEFAULT group default qlen 256
    link/infiniband 00:00:1f:e6:fe:80:00:00:00:00:00:00:24:8a:07:03:00:a3:19:64 brd 00:ff:ff:ff:ff:12:40:1b:80:02:00:00:00:00:00:00:ff:ff:ff:ff promiscuity 0 minmtu 68 maxmtu 65520 
    ipoib pkey  0x8002 mode  datagram umcast  0000 addrgenmode none numtxqueues 256 numrxqueues 32 gso_max_size 65536 gso_max_segs 65535

$ ip -d link show dev mlx5_ib0
29: mlx5_ib0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 2044 qdisc mq state UP mode DEFAULT group default qlen 256
    link/infiniband 00:00:1f:e4:fe:80:00:00:00:00:00:00:24:8a:07:03:00:a3:19:64 brd 00:ff:ff:ff:ff:12:40:1b:ff:ff:00:00:00:00:00:00:ff:ff:ff:ff promiscuity 0 minmtu 68 maxmtu 65520
    ipoib pkey  0xffff mode  datagram umcast  0000 addrgenmode none numtxqueues 256 numrxqueues 32 gso_max_size 65536 gso_max_segs 65535

Also modifying the the ipoib attributes will work only for PKeys that is
created via netlink (for example, setting the mode).

Thanks,
Kamal

> Jason

