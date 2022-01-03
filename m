Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A565C4836D2
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jan 2022 19:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbiACS0r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 13:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbiACS0q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jan 2022 13:26:46 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3EDC06179B
        for <linux-rdma@vger.kernel.org>; Mon,  3 Jan 2022 10:26:45 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so290509wme.4
        for <linux-rdma@vger.kernel.org>; Mon, 03 Jan 2022 10:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nelhage.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=p0/JS+FVjlTbmYojdEE1+lNDIA43XxYyEeFZvqy07QY=;
        b=eGSrVHI6yPYtZzKu6Qo0kkF26BeGBoXzmj9ZzFKyOoxlDX1w67kjVts/YDPOjwm4T6
         Krhut5pSHhq8F5/T0eS95lpY8Au5aHw9IjChqyd3FyniMxuvw4oltKhRZ/t8g6EWb4Rp
         lfeBuxCoY/HT8QLV5tcjmXg8pWSAkqZAb4Sek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=p0/JS+FVjlTbmYojdEE1+lNDIA43XxYyEeFZvqy07QY=;
        b=1MsE29UT9C7L4/ttqRouCeTx2K4wkXtn/0D10doyDy0PC0kNmyOhdi5PK0iPmQs0xR
         evM76p0Q06zwTBLNDNMomcEJE0KbQizzAMBEnueHn+Y06CEW4ur1PCiEifecDWe+tZ+D
         7SmncHzjnqpBKDuOHnVJ7rTB2joi/pk22RjQcIRJLKWiyp7QABGMLFo9tBt3ZfONBR9K
         49snqRLYBUeckezu6lMi+DC4OQ2fEYi2Q/MC2LBApnd5UKaqMN7w2plLYlXqMTeGobB8
         Ny+FL2/qRcG/iYNypaZ45GKRxROu2iS/1MIVcZqT9rUSJYXxekWXBC8QXSvJWXW0b+TP
         7f9Q==
X-Gm-Message-State: AOAM532GPkemXLN1V1Rz4sR4LthvAt9oa+nYPysKiA4At+/OQYvrIx5e
        XnbRt+s+s+LJ05cpDCEOoDhF5gnmhLLhLMc1K176xU9kXOfB7Q==
X-Google-Smtp-Source: ABdhPJyfMwgkBI8AFiCFDJ+m+7VXAhEAnZpMGkmgvInwvtfre84I1McspEPHK+cNh/hXeMeIdeBhTTtR71i4+p3lC5E=
X-Received: by 2002:a7b:c08e:: with SMTP id r14mr39259920wmh.68.1641234403880;
 Mon, 03 Jan 2022 10:26:43 -0800 (PST)
MIME-Version: 1.0
From:   Nelson Elhage <nelhage@nelhage.com>
Date:   Mon, 3 Jan 2022 10:26:32 -0800
Message-ID: <CAPSG9dZ-dkWPcbXECQeZyvOHu7M+vfrX+jJDe+fxY6_iSnQyKw@mail.gmail.com>
Subject: rdma-core: ibv_dontfork_range should not round up to page boundaries
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

# The problem

If RDMAV_FORK_SAFE or IBV_FORK_SAFE is set, rdma-core will call
`ibv_dontfork_range` to mark regions of memory that will be used for
RDMA as `MADV_DONTFORK` to prevent CoW from relocating them.

`ibv_dontfork_range` calls `ibv_madvise_range`, which will round the
provided memory range up to page boundaries automatically
(libibverbs/memory.c:L638-L640):

        start = (uintptr_t) base & ~(range_page_size - 1);
        end   = ((uintptr_t) (base + size + range_page_size - 1) &
                 ~(range_page_size - 1)) - 1;

This behavior avoids EINVAL from the kernel, but has the effect of
potentially marking random unrelated data that shares a page with the
registered region as `MADV_DONTFORK`.

In particular, we ran into a case where a `aws-ofi-nccl` was
registering a region inside of a (sub-page-size) `malloc`'d struct.
With some probability, that struct would end up on a page that also
contains the glibc `struct malloc_state` managing that heap arena.
When this happens, `fork` will result in a corrupted heap, and we
would see post-fork segfaults from the child inside
`__malloc_fork_unlock_child`:

#0  __malloc_fork_unlock_child () at arena.c:193
#1  0x00007fe2a996fab5 in __libc_fork () at ../sysdeps/nptl/fork.c:188
#2  0x00007fe2aa6e3941 in subprocess_fork_exec (self=<optimized out>,
args=<optimized out>) at
/usr/local/src/conda/python-3.8.10/Modules/_posixsubprocess.c:693
...

Googling for [__malloc_fork_unlock_child segfault] finds a handful of
reports -- most or all of which also implicate RDMA setups -- that I
suspect of having the same root cause.

# The proposed behavior change

The proximate bug here is arguably in the libiverbs clients that are
making the problematic registrations, but I'd like to see libiverbs be
more helpful here by rejecting non-page-aligned regions, at least in
fork-safe mode. Marking memory we don't control as `MADV_DONTFORK` is
*always* incorrect behavior, even if most of the time it may not have
immediate consequences.

I expect this change could pose compatibility problems for existing
libraries. Potentially it could be rolled out as a warning initially,
which would help surface the problem and correct downstreams, as well
as making it easier for administrators to debug this problem.

# Details of our environment

The code inside of aws-ofi-nccl that performs the problematic
registration (by way of libfabric) is here:

https://github.com/aws/aws-ofi-nccl/blob/f16565b2560d21f038a171007d5800ddd9ba1206/src/nccl_ofi_net.c#L1736-L1765

Following our report to AWS, they've fixed the bug on their end here:
https://github.com/aws/aws-ofi-nccl/commit/caa40416bae9562a615d730c8a706d38fba1a9b9

Thanks,
- Nelson Elhage
