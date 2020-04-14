Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40EA01A8A6F
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2020 21:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504582AbgDNTAz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Apr 2020 15:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504580AbgDNTAx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Apr 2020 15:00:53 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CACC061A0E
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 12:00:53 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id f13so11053923qti.5
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 12:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xb53BP4M4iMuZX0zMtrWmrYkdAckW7B/PKiyGjIRuWc=;
        b=ZFv1puLHHbtpSLwqPtKlrtCAvyLYSQoJ3loQz1u1wN7K7ZrfxoDJj5UsDX33n9j/iI
         w9e1vQRvBiiMa4Ydu5rMn3v9B/Tk4DN68h01xIDACOCjRP0S6IdN0ewnv67w94NA8KtB
         keL3iUZJAsY4TXAlBZ4ut5NtyfCSTbxMDsrCFSfMpZz+3Cok8YSkY0FNL3am/Rzrbdmq
         3kvKtQ9lAMefB4JfqitkQQet4dHxUnjei7rlgmJUnheC4CN+qmA7eVB23oB/t3HUY6sh
         /rk+VojAR1sRcUlqLO7wSqrRcKG1wmXNXdNDXquCftpCS7o1hOCWOE0XBlzf5wygaJiM
         e8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xb53BP4M4iMuZX0zMtrWmrYkdAckW7B/PKiyGjIRuWc=;
        b=Q/OVeyyZSvBEY2ds9paJf8ou/z5yV8XbeKwXHHnd8Xo7AyL68GKOcJqMmnrtZGOUPs
         hGoABPeIDmo9tTIs3ngv2Rr2B/zy9mHo7UwhQqVgj+HLpraQ61LBPwHmKBE6L6xDc48J
         1pJXvdoKNe8jtZl+Ea05tstoZF0gK2aIt/+s6StAZNWFNNHNxPVb2rKj9SfpyXt0xDDY
         i0mJF9dL3XYcZhrxJBUsPavr1PilvlMkpQap4Ug852AzXlt3pR25PoMvl8s4BqI7rh0j
         CZVj7Ta5L9BrXbe5qZax0wDFtY4fzV1NKeO/TdSuqovmLGit8ttQd9SG+ggfPF4zAoy8
         jQRg==
X-Gm-Message-State: AGi0PuYtgshFIPBuh7sJHRt7miNhVz/iP0o0r/RYSaLsCwlxG6ofMvsE
        G+yny7j+4zwyAbAIZHTQFhSKutgkHg3D3A==
X-Google-Smtp-Source: APiQypK2VTx6NmzuW91ILr+60cmT9enDZOyMof5ZJEdaoHKde1WqA+yF3Sp3rfQCdlGCOwULZihbgw==
X-Received: by 2002:aed:3f92:: with SMTP id s18mr17936881qth.145.1586890852682;
        Tue, 14 Apr 2020 12:00:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n190sm10841070qkb.93.2020.04.14.12.00.52
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Apr 2020 12:00:52 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jOQnj-00033r-RM
        for linux-rdma@vger.kernel.org; Tue, 14 Apr 2020 16:00:51 -0300
Date:   Tue, 14 Apr 2020 16:00:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/uverbs: Make the event_queue fds return POLLERR
 when disassociated
Message-ID: <20200414190051.GC11664@ziepe.ca>
References: <0-v1-ace813388969+48859-uverbs_poll_fix%jgg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-ace813388969+48859-uverbs_poll_fix%jgg@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 06, 2020 at 09:44:26PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> If is_closed is set, and the event list is empty, then read() will return
> -EIO without blocking. After setting is_closed in
> ib_uverbs_free_event_queue(), we do trigger a wake_up on the poll_wait,
> but the fops->poll() function does not check it, so poll will continue to
> sleep on an empty list.
> 
> Fixes: 14e23bd6d221 ("RDMA/core: Fix locking in ib_uverbs_event_read")
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/uverbs_main.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to for-next

Jason
