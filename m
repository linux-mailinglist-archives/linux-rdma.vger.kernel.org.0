Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0556177B57
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2020 17:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbgCCQAn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Mar 2020 11:00:43 -0500
Received: from mail-yw1-f46.google.com ([209.85.161.46]:43955 "EHLO
        mail-yw1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbgCCQAn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Mar 2020 11:00:43 -0500
Received: by mail-yw1-f46.google.com with SMTP id p69so3750086ywh.10
        for <linux-rdma@vger.kernel.org>; Tue, 03 Mar 2020 08:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=M3arb8b7eWz3OCgnwLZGoXkXKp8M1C6IfbQvbKfl/ys=;
        b=a4LVxSeUS42z57oTGOhqaBTzoXL23+9PbvA7mkxIBtRKG9gEYPTAfZakOkXqF2qtmt
         ulRV1zj0r4fgzysNWjXcNyoItWlvouDWkQH0yMBd3HsZ/wZgPBO38ZaSOFiEOff/6kks
         sX6QGaGmFFaa1+zC1/P/QlNZt1vlyeFIqGDkpOMirmbe8Y6q2MlklXI379NcQntM/3QE
         O2WrrAic6W1RnhbfNSlh/dUJBDsKKf95lS9S46NPxXOKgKArsY3o9hCrUucdZZ79GSYD
         fvLhd4AqCxiXLZEH0nj8jH2pefmqc4/sFdaZobzVLXZWdQqMT7t78/R2E/Gq+7J6yz3V
         cxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=M3arb8b7eWz3OCgnwLZGoXkXKp8M1C6IfbQvbKfl/ys=;
        b=k8Ty+AoI96mJt6UqaYzE7r3Flc41wM/PF7h292vohjJOtBzfK/US3posafah3XNZ5r
         leRcCotMCMqf81sSGBievsk91RzinyHzgErlj9wVzfVQlDzwu5c3MwrWSdZe9i2T4MZc
         vxnpIF1G1mq7NgXSKXVccH3hqVwWLw7+kV8p7J3z/kHY1h9v9UoojWIFzUGTExL4JtsY
         6gBs88suSNabqSXLWg6wsnMYdsIKKcBppl7PHCA5ESGJVsQefdqrktGI00CGrz0r9ry9
         0FBOYYLrY8zHiZ+d/bXGYG0xzZA9cu2MqhLAVp/+VlKzIAs1pwaAJtBhjyGR5QgdunRQ
         fTUw==
X-Gm-Message-State: ANhLgQ2X2so3y0iwSF1+s/yZBeouJx712d3FNtzG8P89DaXXF40StvSv
        JXJPh49MPSOiuHIT8Z0/xLRDhpv48XrkdjqzjlgW1v9aBKc=
X-Google-Smtp-Source: ADFU+vswFTMTqIgM2gGJ0s/ONJZJ/VVFRWK3HG/YuueUjJ/q0YuYengmPGgVnHJeg28FFi3rNkJ5bNOS2ETVwuzG3Kw=
X-Received: by 2002:a25:af87:: with SMTP id g7mr4267974ybh.3.1583251241940;
 Tue, 03 Mar 2020 08:00:41 -0800 (PST)
MIME-Version: 1.0
From:   Frank Huang <tigerinxm@gmail.com>
Date:   Wed, 4 Mar 2020 00:00:29 +0800
Message-ID: <CAKC_zSsbA2wWnkTK3E0vf+AP3CjZyVJ=aOgDiY57SX73BtrPNg@mail.gmail.com>
Subject: hang on rdma_destroy_id
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi, ALL

I am testing on nvmf, but I meet a bug with spdk, the spdk community
say it is a bug about *soft-roce*.

Here is the link I talk with SPDK community.

https://github.com/spdk/spdk/issues/1184#issuecomment-582795537

And there is the stack of hang process.The bug come every time when I
restart the network.service.

PID: 44459  TASK: ffff9ff048322600  CPU: 0   COMMAND: "reactor_0"
 #0 [ffffc324ecae7bb0] __schedule at ffffffffbc89d270
 #1 [ffffc324ecae7c38] schedule at ffffffffbc89d882
 #2 [ffffc324ecae7c48] schedule_timeout at ffffffffbc8a1622
 #3 [ffffc324ecae7cd8] wait_for_completion at ffffffffbc89eecf
 #4 [ffffc324ecae7d38] flush_workqueue at ffffffffbc0c2d65
 #5 [ffffc324ecae7dc8] ucma_destroy_id at ffffffffc04bb7e2 [rdma_ucm]
 #6 [ffffc324ecae7e08] ucma_write at ffffffffc04b929b [rdma_ucm]
 #7 [ffffc324ecae7e38] __vfs_write at ffffffffbc27cc56
 #8 [ffffc324ecae7eb8] vfs_write at ffffffffbc27cf3d
 #9 [ffffc324ecae7ef0] sys_write at ffffffffbc27d182
#10 [ffffc324ecae7f30] do_syscall_64 at ffffffffbc003774
#11 [ffffc324ecae7f50] entry_SYSCALL_64_after_hwframe at ffffffffbca00081
    RIP: 00007fec5bf0169d  RSP: 00007ffc251449d0  RFLAGS: 00000293
    RAX: ffffffffffffffda  RBX: 00000000024ef240  RCX: 00007fec5bf0169d
    RDX: 0000000000000018  RSI: 00007ffc251449f0  RDI: 000000000000000e
    RBP: 0000000000000000   R8: 0000000000000000   R9: 0000000000000010
    R10: 0000000000000060  R11: 0000000000000293  R12: 00007ffc25144a40
    R13: 00000000024efc30  R14: 00000000024efca0  R15: 0000000000000001
    ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b


Is any one meet this before?  What's the right way to handle the
RDMA_CM_EVENT_DEVICE_REMOVAL event?

The driver what I used is come from MLNX_OFED 4.7-3.2.9.0
