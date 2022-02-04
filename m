Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2D34A9C95
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Feb 2022 16:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243078AbiBDP7x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Feb 2022 10:59:53 -0500
Received: from out0.migadu.com ([94.23.1.103]:42823 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351844AbiBDP7x (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Feb 2022 10:59:53 -0500
Message-ID: <787e7fca-205a-eea9-4a23-f46793668d98@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1643990390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bBBgxKxEMHonXclYJliWrohuXVCEJKe17wCT6U+hQr8=;
        b=SYubo7rwD1vfU3Ea1sK3euykiknLqulql3ai2fYYblfNLOnFMTiLUhl7nQIG8b6AdPJOdM
        JNpXN7wU8Czj/XOIZpc8JykXoaG04dpAsQCo66Bshzy1qMuB6GO/52+R1/N4py92AIcs3i
        z4vgzytIPoxOIrLuqakRAg28JNPjmPw=
Date:   Fri, 4 Feb 2022 23:59:37 +0800
MIME-Version: 1.0
Subject: Re: ibv_rc_pingpong failes on softroce device using GID[0]
To:     hui wang <huiwang20160306@gmail.com>, linux-rdma@vger.kernel.org
References: <CAMBwrqnrRiLc8e5X6d1E8879HbOfFgG-nhuWEoyatRVW8cUtwg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <CAMBwrqnrRiLc8e5X6d1E8879HbOfFgG-nhuWEoyatRVW8cUtwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/2/3 13:28, hui wang 写道:
> Hi All
> I am using ubuntu 21.10. I used the following command to create a
> softroce device rxe0:
> sudo rdma link add rxe0 type rxe netdev enp0s3
> 
> rxe0's GID[0] is not an real IP address assigned to my enp0s3. It
> seems to be something softroce generated from the node_guid (seems to
> be generated from mac address of enp0s3).
> Is this expected behavior? How to use this GID given that it is not
> reachable because it is not a real IP address?
> 
> I used ibv_rc_pingpong -d rxe0 -g 0 to setup a server with this GID,
> the server failed with "Failed to modify QP to RTR" when client tries

please check this link:

https://www.spinics.net/lists/linux-rdma/msg108317.html

Zhu Yanjun

> to talk with it with client's GID[0] using command "./ibv_rc_pingpong
> -d rxe0 -g 0 10.0.0.233". Is this because the GID[0] is not a real IP?
> 
> ibv_rc_pingpong works if i use any other GID, (eg. GID[1] - GID[5])
> 
> Here is the output of ibv_devinfo and ip addr. you can see GID[0]
> fe80::a00:27ff:fe2e:f7a5 is not a real ip address assigned to enp0s3
> (where rxe0 was created).
> 
> huiwang@huiwang-VirtualBox:~/rdma-core$ ibv_devinfo -v
> hca_id: rxe0
>          transport:                      InfiniBand (0)
>          fw_ver:                         0.0.0
>          node_guid:                      0a00:27ff:fe2e:f7a5
>          sys_image_guid:                 0a00:27ff:fe2e:f7a5
> ....
>                          GID[  0]:
> fe80::a00:27ff:fe2e:f7a5, RoCE v2
>                          GID[  1]:
> fe80::9bd3:885:53df:9fc4, RoCE v2
>                          GID[  2]:               ::ffff:10.0.0.151, RoCE v2
>                          GID[  3]:
> 2601:647:5380:2210:19df:d855:54a9:cc9f, RoCE v2
>                          GID[  4]:
> 2601:647:5380:2210:e3f3:7e57:504b:7e5c, RoCE v2
>                          GID[  5]:
> 2601:647:5380:2210::3be1, RoCE v2
> 
> huiwang@huiwang-VirtualBox:~/rdma-core/build/bin$ ip addr
> 2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel
> state UP group default qlen 1000
>      link/ether 08:00:27:2e:f7:a5 brd ff:ff:ff:ff:ff:ff
>      inet 10.0.0.151/64 brd 10.0.0.255 scope global dynamic noprefixroute enp0s3
>         valid_lft 143273sec preferred_lft 143273sec
>      inet6 2601:647:5380:2210::3be1/128 scope global dynamic noprefixroute
>         valid_lft 575276sec preferred_lft 575276sec
>      inet6 2601:647:5380:2210:e3f3:7e57:504b:7e5c/64 scope global
> temporary dynamic
>         valid_lft 255135sec preferred_lft 56812sec
>      inet6 2601:647:5380:2210:19df:d855:54a9:cc9f/64 scope global
> dynamic mngtmpaddr noprefixroute
>         valid_lft 255135sec preferred_lft 255135sec
>      inet6 fe80::9bd3:885:53df:9fc4/64 scope link noprefixroute
>         valid_lft forever preferred_lft forever
> 
> Thanks,
> Hui

