Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39EA4A7F1A
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Feb 2022 06:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbiBCF2j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Feb 2022 00:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiBCF2g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Feb 2022 00:28:36 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93880C061714
        for <linux-rdma@vger.kernel.org>; Wed,  2 Feb 2022 21:28:36 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id i62so5476690ybg.5
        for <linux-rdma@vger.kernel.org>; Wed, 02 Feb 2022 21:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Ojt02agVKr9ldZIqrrOlRt7h0svNhSUMSBg64VWm8tE=;
        b=ZPT058thZAPhiiSKUiHBwOczP5CP9GA5jUbtuhlO+99es621zO/vrvp+yh70xif2DM
         /I249CXMyOcCGVeoON30f9O03Qj2n4o0EBZ6Y4HqfGlbPlw/DyKLf3IVFPjkmuQtsKxa
         XRBvteoIAxnSJL7DvmRTpCdwXVHHhz4W+1ty7FcHTIe594G1T5df8ECUmNBQApta+/OM
         +O2Go1yFgFTd9dAxb3KKs4CXXlifj3VsNavT1i2Z5zzMI9wm/o4dEN5IXWfCwXLKqaoF
         9YC3/KwtcMYndC99XDqENY+WO40R2m91wEss5XMDzSlJfKLhuKSSkRm0N+q6R259sefH
         nJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Ojt02agVKr9ldZIqrrOlRt7h0svNhSUMSBg64VWm8tE=;
        b=yxN2DC7/FLCVxDkZQBF5bnXkIypX2O+DBRzUMcLbitKv9yd7Khft3eujz9B9nS5GDg
         2H3IazegafH2A3qCQahz44MtmHLQN/Li+oYDhnmsgPwRbMxMxPswuKkmgEEILJLu87OU
         2OB1xh0vAsOrWivzdc+jzeji0fIk1BzGz0f0xClVlfVTHZaEdM5UgsSGP+g21SP9+c4I
         Lgttn/08aHB6Mov+hcXKrQ7iT5qo6x9C/40pIGYenxQ/5GMcfakYUUAa99nhBFzDtTpa
         zXvJmNBvhmwQ8mTa94vFSnIkOkJk0k0l18SO3+LpC4acmf/0lbP5cbvd4fpvaYHcS7at
         1AJw==
X-Gm-Message-State: AOAM532t9xVIPBgNvO2I7ecy/audazvb0ZG2EacbMN6oeyVSLLzIk81t
        2CQbebA6J7vG2kWRJaGePteHTGQYTvyaM1CeJLqpoOXn008=
X-Google-Smtp-Source: ABdhPJzhU9n62+kEXmOnw0Ii4o4VsT6l7VaXD9l7jn8CgOTra17zWaipSCthcMnnZYs3S8n0b7a+A1jb8k7fmSSevG4=
X-Received: by 2002:a25:6089:: with SMTP id u131mr43595988ybb.67.1643866115760;
 Wed, 02 Feb 2022 21:28:35 -0800 (PST)
MIME-Version: 1.0
From:   hui wang <huiwang20160306@gmail.com>
Date:   Wed, 2 Feb 2022 21:28:24 -0800
Message-ID: <CAMBwrqnrRiLc8e5X6d1E8879HbOfFgG-nhuWEoyatRVW8cUtwg@mail.gmail.com>
Subject: ibv_rc_pingpong failes on softroce device using GID[0]
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi All
I am using ubuntu 21.10. I used the following command to create a
softroce device rxe0:
sudo rdma link add rxe0 type rxe netdev enp0s3

rxe0's GID[0] is not an real IP address assigned to my enp0s3. It
seems to be something softroce generated from the node_guid (seems to
be generated from mac address of enp0s3).
Is this expected behavior? How to use this GID given that it is not
reachable because it is not a real IP address?

I used ibv_rc_pingpong -d rxe0 -g 0 to setup a server with this GID,
the server failed with "Failed to modify QP to RTR" when client tries
to talk with it with client's GID[0] using command "./ibv_rc_pingpong
-d rxe0 -g 0 10.0.0.233". Is this because the GID[0] is not a real IP?

ibv_rc_pingpong works if i use any other GID, (eg. GID[1] - GID[5])

Here is the output of ibv_devinfo and ip addr. you can see GID[0]
fe80::a00:27ff:fe2e:f7a5 is not a real ip address assigned to enp0s3
(where rxe0 was created).

huiwang@huiwang-VirtualBox:~/rdma-core$ ibv_devinfo -v
hca_id: rxe0
        transport:                      InfiniBand (0)
        fw_ver:                         0.0.0
        node_guid:                      0a00:27ff:fe2e:f7a5
        sys_image_guid:                 0a00:27ff:fe2e:f7a5
....
                        GID[  0]:
fe80::a00:27ff:fe2e:f7a5, RoCE v2
                        GID[  1]:
fe80::9bd3:885:53df:9fc4, RoCE v2
                        GID[  2]:               ::ffff:10.0.0.151, RoCE v2
                        GID[  3]:
2601:647:5380:2210:19df:d855:54a9:cc9f, RoCE v2
                        GID[  4]:
2601:647:5380:2210:e3f3:7e57:504b:7e5c, RoCE v2
                        GID[  5]:
2601:647:5380:2210::3be1, RoCE v2

huiwang@huiwang-VirtualBox:~/rdma-core/build/bin$ ip addr
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel
state UP group default qlen 1000
    link/ether 08:00:27:2e:f7:a5 brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.151/64 brd 10.0.0.255 scope global dynamic noprefixroute enp0s3
       valid_lft 143273sec preferred_lft 143273sec
    inet6 2601:647:5380:2210::3be1/128 scope global dynamic noprefixroute
       valid_lft 575276sec preferred_lft 575276sec
    inet6 2601:647:5380:2210:e3f3:7e57:504b:7e5c/64 scope global
temporary dynamic
       valid_lft 255135sec preferred_lft 56812sec
    inet6 2601:647:5380:2210:19df:d855:54a9:cc9f/64 scope global
dynamic mngtmpaddr noprefixroute
       valid_lft 255135sec preferred_lft 255135sec
    inet6 fe80::9bd3:885:53df:9fc4/64 scope link noprefixroute
       valid_lft forever preferred_lft forever

Thanks,
Hui
