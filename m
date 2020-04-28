Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4261BB28C
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2020 02:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgD1AKh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 20:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726279AbgD1AKg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 20:10:36 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA84C03C1A8
        for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2020 17:10:36 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ck5so2781604qvb.11
        for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2020 17:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+SvbcRM+D8Hoa6IrST25It7oQmI1YKKGE8UvIYsd3j4=;
        b=egsqS2uaZQ0GqvuGL0dUXYrCAQ34rUZ7q4SKDLz3KYfTgCwcsf5vUKXxMBovxwsQJR
         9V9FdJpN5GX9QGqu6QlMkbhg+VFg/ZPNDC3T9lEm9VG1y8mCW3+FLp3MCpuwPXte4sWy
         EyN47YLP+7s7+GqENKpIiRrZ5UjNjRZNufDzGdOWOzmlgNdZ6KhQLT3ZFR419K8TfQdL
         uD+ODP8FUSOZyCAjeuq38WK2BnicfgYd9rvH8K+nV3jLkqUZgfRfksPvxdMqT++wLBtd
         kdHp/LlbAQyi+otXveuXhsh+trZa9qp/1i8GMo/fQGUT2OSnBwtx2w7hOtz6CluqI3fZ
         LoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+SvbcRM+D8Hoa6IrST25It7oQmI1YKKGE8UvIYsd3j4=;
        b=dyNcSTwXFd0iQ1IADy89ZCTQ4E7M0p6c0p+glEdds8dwtr+0z2WEyj5xmS933UdJ4y
         EE4nP0hgNbdxdxCu1219tMsQ/5mBfvKzufj+sb1dpp5mOZT65QvhVa3EJqIqza51LF+T
         gkgvyk/qQNDRnin56iVVgTzLRu6/ksE7pm6oAAvp2xvhmIf6/jiaO4O8YqLDv0Gt9Oil
         y/7B6E9Xvo3M0GABdpBwH389ZJSTXNuCCXZ1dzM936LW18sLfD5N67bXO/zrKIOUfKnr
         Wwmvz27cHOExAzJDq2C2OqahV3RxVNydw+huNMLDgSqlklplPgdR2iSUPDOglVWKybcO
         krzg==
X-Gm-Message-State: AGi0PuYIHHNO/KH+OCB8LrzZ5HzydchTL6SQdpEjxzSIyUK6LdAQYWYW
        1CQVNMLWS7L8SRSRDI97xOzf7g==
X-Google-Smtp-Source: APiQypJXnyTV0OcNdko5OBsfPbZLy53Ghm/5PHAA7ooZmHNZVFoHsm0r3ONTDRpVr8v2Sdv0o97Isg==
X-Received: by 2002:a0c:f004:: with SMTP id z4mr25173331qvk.29.1588032635506;
        Mon, 27 Apr 2020 17:10:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p80sm12120531qka.134.2020.04.27.17.10.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Apr 2020 17:10:34 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jTDpa-0002Q4-8l; Mon, 27 Apr 2020 21:10:34 -0300
Date:   Mon, 27 Apr 2020 21:10:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+4088ed905e4ae2b0e13b@syzkaller.appspotmail.com>
Cc:     dledford@redhat.com, kamalheib1@gmail.com, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, parav@mellanox.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in ib_unregister_device_queued
Message-ID: <20200428001034.GQ26002@ziepe.ca>
References: <000000000000aa012505a431c7d9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000aa012505a431c7d9@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 26, 2020 at 06:43:13AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    b9663b7c net: stmmac: Enable SERDES power up/down sequence
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=166bf717e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5d351a1019ed81a2
> dashboard link: https://syzkaller.appspot.com/bug?extid=4088ed905e4ae2b0e13b
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+4088ed905e4ae2b0e13b@syzkaller.appspotmail.com
> 
> rdma_rxe: ignoring netdev event = 10 for netdevsim0
> infiniband  yz2: set down
> WARNING: CPU: 0 PID: 22753 at drivers/infiniband/core/device.c:1565 ib_unregister_device_queued+0x122/0x160 drivers/infiniband/core/device.c:1565

The only thing I can think of for this is that ib_register_driver()
is racing with __ib_unregister_device() and took the special error
unwind.

I suspect this is not a bug, but over complexity triggering a
pre-condition WARN_ON..

Maybe the solution is to swap the dealloc_driver = NULL for some other flag.

Jason
