Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6C614BF9B
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jan 2020 19:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgA1SZZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jan 2020 13:25:25 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41834 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgA1SZZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jan 2020 13:25:25 -0500
Received: by mail-qt1-f194.google.com with SMTP id l19so5486335qtq.8
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jan 2020 10:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cgxKMpHFKn4hSZK4Ab5jy2YFw30mUYxzmDc6cWww/r8=;
        b=E1HO014qRTE0dWscy4rsG+l6a3D3DA79u1EKlIQBVmlLE8aFXoW5lu3q0/h92pv/3C
         o16lxazQ4rqQWzY1Zhku+naupwDtLyU2eTfctYeHzCfJOuzOlqtYmKYg0ssjcddIUax6
         1bvvftL7XCgCP9SuLQDXi7aZfIeBGpubH8dYQpP/pR1gHzJe6H9jnBuDudkfxZMwLBdq
         pahFW1toJ1/Rdj8jdtW/DZAKQ4dpP9BtTkxWGLlPYwg5kQUp5bvwDZEnn6c2cI8N1tb7
         5OeSMJMsQAq2TCQlelVynkN11OTaLPC1mnHds3dxpi5d8dgsiMZGwmLaEaNJFhhE9iTU
         s6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cgxKMpHFKn4hSZK4Ab5jy2YFw30mUYxzmDc6cWww/r8=;
        b=TVeGZil1OBUw3QImXbT0s+OBX359k1OcBzkL9Av+70Ru5cxNE3pqP4+LjN4nyoRVCT
         72onpPcqYdiRVHsA+BFJCUWYhiaFi7BhbdbQ/D76rQJQrUPFZHRsWoPDKMlE31eGUUpT
         MAXYehHn4SqE8AHDeghWdVP7RaBAe9Le7aMe15YYgTBqLL+URnKy6xRQbEDQo8n7lY1G
         Q+LvrS4qEGbN2ZdYy2AcutNXC5BAXnIYSMeWoHVJajsLIYfhnmYHqs9UgL//FOtkX+o6
         s04p/gVunjaG2DUgNDUCb9Yf51+bfJzGtaesZY8VSvQbrj6h/24RE4kZz036ykVnRjgb
         vz9w==
X-Gm-Message-State: APjAAAVzuRKGLzyzAA5BMJ3fD5U0HTW2hv87ZZ6LETqMqgLR95LAFO5U
        0IDYj6wiGbFAhj9yMTyBLgaMvw==
X-Google-Smtp-Source: APXvYqw4pT9Yr5WmPQj65uZQs2IMfacwZfucAbF9pJG9pVAyVj1krrYlW/EhH60VpuqH/JaYX3KP2w==
X-Received: by 2002:ac8:3f88:: with SMTP id d8mr6905701qtk.382.1580235924571;
        Tue, 28 Jan 2020 10:25:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g6sm3830195qtp.53.2020.01.28.10.25.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Jan 2020 10:25:24 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iwVYB-0008SI-HM; Tue, 28 Jan 2020 14:25:23 -0400
Date:   Tue, 28 Jan 2020 14:25:23 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH rdma-next 1/7] RDMA/cma: Fix unbalanced cm_id reference
 count during address resolve
Message-ID: <20200128182523.GA32407@ziepe.ca>
References: <20200126142652.104803-1-leon@kernel.org>
 <20200126142652.104803-2-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126142652.104803-2-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 26, 2020 at 04:26:46PM +0200, Leon Romanovsky wrote:
> From: Parav Pandit <parav@mellanox.com>
> 
> Below cited commit missed to consider AF_IB and loopback code flow in
> rdma_resolve_addr().
> This leads to unbalanced cm_id refcount in cma_work_handler() which
> puts the refcount which was not incremented in rdma_resolve_addr().
> 
> A call trace is observed with such code flow.
> 
> BUG: unable to handle kernel NULL pointer dereference at (null)
> [<ffffffff96b67e16>] __mutex_lock_slowpath+0x166/0x1d0
> [<ffffffff96b6715f>] mutex_lock+0x1f/0x2f
> [<ffffffffc0beabb5>] cma_work_handler+0x25/0xa0
> [<ffffffff964b9ebf>] process_one_work+0x17f/0x440
> [<ffffffff964baf56>] worker_thread+0x126/0x3c0
> 
> Hence, hold the cm_id reference when scheduling resolve work item.
> 
> Fixes: 722c7b2bfead ("RDMA/{cma, core}: Avoid callback on rdma_addr_cancel()")
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/cma.c | 2 ++
>  1 file changed, 2 insertions(+)

It is very hard to read this flow around the 'work', the incr of the
refcount in rdma_resolve_route() seems very poorly placed.

But this looks correct, so applied to for-next

Thanks,
Jason
