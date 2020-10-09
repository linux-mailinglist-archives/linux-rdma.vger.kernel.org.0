Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE51288BD1
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 16:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388649AbgJIOs6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 10:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732056AbgJIOs6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Oct 2020 10:48:58 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74233C0613D2
        for <linux-rdma@vger.kernel.org>; Fri,  9 Oct 2020 07:48:58 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z33so4234139qth.8
        for <linux-rdma@vger.kernel.org>; Fri, 09 Oct 2020 07:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3C+37EmCr6aULcQIzB3q4nqjXCrhrMRJ4RH2Ni3ul5U=;
        b=geAKGMKh4JiEUsZW3VEHrqhjQuMDUQwBfVLgFeotQ45SCl+dSI+Rs1UkhZF86x7p8C
         oYlIrMaltyXiAeXd1Z3gih6rJGTN7RGz7FolkU9SysVHwiWXOpbmqVE/Krr/sMgiyhZ9
         nGPmYptUjF828TYAD5+ZgDEAUuBvsjXxqxSlZjcv+aiu6An89HyezgrkA8/gLCHyiiXI
         lpk7mLQXbf6yVN409H+Yc7t0qBG9uOVtAR4V70y/M61/o1ri9SFTc4q9XXr5iRbmXtWw
         W2hDyoTjelLhnfkEvufryg/L9Ic856pWQ3mZEwycJtyUMQa6SsmB6PqAGNvJKcMqeF5X
         QcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3C+37EmCr6aULcQIzB3q4nqjXCrhrMRJ4RH2Ni3ul5U=;
        b=ivWrF1iFDNSm/kj0hZfsTzZHI12VYTrGf905AmLXgU0+BmeA7E1Gf77+3FGkc3ca3d
         UOwaeSDjrsTvT6uZkSdeUndm43P2H7YibPMUrnqpgC6MaDcCdz3XJU7qIDNHKp4LitHZ
         Ql0MMoE8TQwTdQbKp6VzLDWBGnh811QvCFY+nJzCL8TmaHs+XbBXUTN06DpZ2tOxTZD6
         0aIM+wwXly4huioL79S7cjfSYEN5IKca9Z6kiPNW1xdoPhAa9jY1ZyBz56/Suh7VRyKb
         Yj9aZfzj3aSN8CpLOqulEzv5R4ksxrwEDUF8VdFgDFkM87agRRT69FNR2tq2h7Gct8wk
         u0IQ==
X-Gm-Message-State: AOAM531NtygQo3tkHuMSkmt5kN5xJ03hN1k4zNxoWevbva1Q47cut569
        +/OujkI2kBcTfV6qEUIne6g=
X-Google-Smtp-Source: ABdhPJwEfs9ma+ftzfHv6kNFhjJotz7N83AgKyk5hcm4hfp9t/seBlT1n0aHHrPULEsi0MDIZ7m62Q==
X-Received: by 2002:aed:243b:: with SMTP id r56mr14462663qtc.249.1602254937744;
        Fri, 09 Oct 2020 07:48:57 -0700 (PDT)
Received: from anon-dhcp-152.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i22sm1029449qki.74.2020.10.09.07.48.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2020 07:48:56 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <20201009143940.GT5177@ziepe.ca>
Date:   Fri, 9 Oct 2020 10:48:55 -0400
Cc:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <0E82FB51-244C-4134-8F74-8C365259DCD5@gmail.com>
References: <20201005154548.GT9916@ziepe.ca>
 <765ff6f8-1cba-0f12-937b-c8893e1466e7@oracle.com>
 <20201006124627.GH5177@ziepe.ca>
 <ad892ef5-9b86-2e75-b0f8-432d8e157f60@oracle.com>
 <20201007111636.GD3678159@unreal>
 <4d29915c-3ed7-0253-211b-1b97f5f8cfdf@oracle.com>
 <20201008103641.GM13580@unreal>
 <aec6906d-7be5-b489-c7dc-0254c4538723@oracle.com>
 <20201008160814.GF5177@ziepe.ca>
 <727de097-4338-c1d8-73a0-1fce0854f8af@oracle.com>
 <20201009143940.GT5177@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason-

> On Oct 9, 2020, at 10:39 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> On Fri, Oct 09, 2020 at 12:49:30PM +0800, Ka-Cheong Poon wrote:
>> As I mentioned before, this is a very serious restriction on how
>> the RDMA subsystem can be used in a namespace environment by kernel
>> module.  The reason given for this restriction is that any kernel
>> socket without a corresponding user space file descriptor is "rogue".
>> All Internet protocol code create a kernel socket without user
>> interaction.  Are they all "rogue"?
> 
> You should work with Chuck to make NFS use namespaces properly and
> then you can propose what changes might be needed with a proper
> justification.

The NFS server code already uses namespaces for creating listener
endpoints, already has a user space component that drives the
creation of listeners, and already passes an appropriate struct
net to rdma_create_id. As far as I am aware, it is namespace-aware
and -friendly all the way down to rdma_create_id().

What more needs to be done?


> The rules for lifetime on IB clients are tricky, and the interaction
> with namespaces makes it all a lot more murky.

I think what Ka-cheong is asking is for a detailed explanation of
these lifetime rules so we can understand why rdma_create_id bumps
the namespace reference count.


--
Chuck Lever
chucklever@gmail.com



