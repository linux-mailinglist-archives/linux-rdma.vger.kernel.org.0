Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F165184964
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 15:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCMOdX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 10:33:23 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42156 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMOdX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Mar 2020 10:33:23 -0400
Received: by mail-qk1-f195.google.com with SMTP id e11so12763229qkg.9
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2020 07:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yg//pOcVw1+kfWenZNyOtZ65fgD8TPmisUJgcMSlhfw=;
        b=Pe/0Mt3DcVObA30rv5sYhme3GKM7itNNUc8UjHCtpSumhagEdT0Wfo5MKAAaadqTtv
         9us5inEtZNsfSqEWYZ5UCCTL51QrUfpyFXLZh67N7w5phM9rzcuksYW3N2xhDGLHi3vw
         yua1kZ5t+1fymZBrrC9MmpGFORV40+9sKRRI26kBl7VGq0o+DZ/YGIlEIv7a7hhjagV0
         o+ApI5AcqKzAGtIz5SSCFE7IjJZYC7U7SxfqOiD1KjDvnyk9R00rFelcvPqw9TJ4slSU
         dwkrWRo3yYvqvS9IpkJigN1vKjxsz+6RN2hccBUq2WuxlSzFAJt29UxICuFKqo/qJ8YA
         GlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yg//pOcVw1+kfWenZNyOtZ65fgD8TPmisUJgcMSlhfw=;
        b=MbdiddDuXN3zTPigPuCJuYzr1Sf/HHdB8oCA+Lt7WSmhLuO4RULlqRQSMaqND3VXxc
         zltufpHd5ZNR0ZnEPkpk6V7HTniO6UdOlPD1ka3l8ID+jj8WGKpnyXrYJYQhFcL3pKfk
         jW6pWEkMp2WAVSzDhY/llj8OG3lJRBe7Z7IBFU5t8vnHsYwfOrdV8nxcchS+qazYe9A+
         hQ2B9rBXyRPzf8VW+dAXVnTpjigUFf6wCF7cz1yOtX0jlOZNLV3vBBU8+kgfSxqbo+Fw
         iOk+dFEwmi0b5MUwXNc5VscLU56tc4w5iMbmtGhCkHentdN4lC3ruI8eY8Fvw70EZ9LF
         9NYQ==
X-Gm-Message-State: ANhLgQ20w8n3QHAJsn243yvZ2neDgPMRWEhZ0a4O4iBI3jPnjumKONYL
        BN4M01eFzyN/F97/YGUHdF1oIw==
X-Google-Smtp-Source: ADFU+vts8Lefnbd5eQcrV4qLEj08kXXzupPQu6GncyaPMLyQdPJLZ+dzzreKRMMl0E/KdrICXOVscA==
X-Received: by 2002:a37:8982:: with SMTP id l124mr1489014qkd.195.1584110002425;
        Fri, 13 Mar 2020 07:33:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id j4sm9317244qtn.78.2020.03.13.07.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 07:33:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jClNJ-0002fO-6q; Fri, 13 Mar 2020 11:33:21 -0300
Date:   Fri, 13 Mar 2020 11:33:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc] IB/rdmavt: Free kernel completion queue when done
Message-ID: <20200313143321.GA10215@ziepe.ca>
References: <20200313123957.14343.43879.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313123957.14343.43879.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 13, 2020 at 08:39:57AM -0400, Mike Marciniszyn wrote:
> From: Kaike Wan <kaike.wan@intel.com>
> 
> When a kernel ULP requests the rdmavt to create a completion queue, it
> allocated the queue and set cq->kqueue to point to it. However, when
> the completion queue is destroyed, cq->queue is freed instead, leading
> to memory leak:
> 
> https://marc.info/?l=linux-rdma&m=158344182614924&w=2

Please always use lore.kernel.org for links to emails, I fixed it.

> unreferenced object 0xffffc90006639000 (size 12288):
> comm "kworker/u128:0", pid 8, jiffies 4295777598 (age 589.085s)
>     hex dump (first 32 bytes):
>       4d 00 00 00 4d 00 00 00 00 c0 08 ac 8b 88 ff ff  M...M...........
>       00 00 00 00 80 00 00 00 00 00 00 00 10 00 00 00  ................
>     backtrace:
>       [<0000000035a3d625>] __vmalloc_node_range+0x361/0x720
>       [<000000002942ce4f>] __vmalloc_node.constprop.30+0x63/0xb0
>       [<00000000f228f784>] rvt_create_cq+0x98a/0xd80 [rdmavt]
>       [<00000000b84aec66>] __ib_alloc_cq_user+0x281/0x1260 [ib_core]
>       [<00000000ef3764be>] nvme_rdma_cm_handler+0xdb7/0x1b80 [nvme_rdma]
>       [<00000000936b401c>] cma_cm_event_handler+0xb7/0x550 [rdma_cm]
>       [<00000000d9c40b7b>] addr_handler+0x195/0x310 [rdma_cm]
>       [<00000000c7398a03>] process_one_req+0xdd/0x600 [ib_core]
>       [<000000004d29675b>] process_one_work+0x920/0x1740
>       [<00000000efedcdb5>] worker_thread+0x87/0xb40
>       [<000000005688b340>] kthread+0x327/0x3f0
>       [<0000000043a168d6>] ret_from_fork+0x3a/0x50
> 
> This patch fixes the issue by freeing cq->kqueue instead.
> 
> Fixes: 239b0e52d8aa ("IB/hfi1: Move rvt_cq_wc struct into uapi directory")
> Cc: <stable@vger.kernel.org> # 5.4.x
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Signed-off-by: Kaike Wan <kaike.wan@intel.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> --
>  drivers/infiniband/sw/rdmavt/cq.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc

Thanks,
Jason
