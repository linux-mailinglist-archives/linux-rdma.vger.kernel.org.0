Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2995B16506E
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 21:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgBSU6I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 15:58:08 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44675 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgBSU6I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 15:58:08 -0500
Received: by mail-qk1-f193.google.com with SMTP id j8so1495013qka.11
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 12:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9xXSiLUa2Hb363dyZQ+4wp+jSc9evSSCZAofUlXVWrU=;
        b=iN5G3rCxrlqcksUj6CgB5Wbp19iADPp2B80b870iWpxg0U56qlRlMa3wq8R7/sER14
         iYwsGOO5OKa+O7G6S9ItCTjL660zlgK/MVH6dOP0EX6aFERnus3BGOm81gkYo360+EDW
         bhzhZOzIVM/LiQcdVczlqcwCamNYZxXmux7z3f1Ef8FyXWIK/1lES18tVTL+kOzGhmZi
         9tVNQ15gI5vJ7Ilb8KnkGqVANETe3dTS449AnFhccT+k+mauErgQwdE0GRQAI6B7yIvu
         JuvQav3xjZfOoDWNtWU9ttEUs6aOXE29JyNqIDDSYES4DMB3lBOO/b1DkZNsmiee0/Un
         8uuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9xXSiLUa2Hb363dyZQ+4wp+jSc9evSSCZAofUlXVWrU=;
        b=uBIzuaM4OZmGQylNfFRalTLB8mKeoWm3WIUGNW7gvImCJ+fS7HWal41MNJbB6pvGIp
         sv4qwjE1vOxlI5ZSmUD20j+Luy7pGJ5hWSCZqcXwt4rfdR2lsIKBZq3KVDa0VGHtZY3A
         rqNSMQ8H+tg1MGJzpjI12RIl0YhjT+27H7TEud3NF7pYzPO7HPQvZHK/yRsYVzOW4Rmx
         SMPod2Au7fYTyfk+/n51V286YpyBUQggldn/jHTunXHaTx2904jbLSkm9fjOgV7gGXpu
         kLnxQoFVvX1KawojXi4dVj+M3K0uhPJdVzLctlyQz4R51DhYY9d/aWc+CTsruh8SyO1F
         znUg==
X-Gm-Message-State: APjAAAXTLJH5UiypUJHzrg77fOnyr7qSs7/gmh64FiDTdyApw2miAN4j
        KQgr8LajFsAnZqJwHFtdn9k03A==
X-Google-Smtp-Source: APXvYqy0CMq3V5fvx9+t9PRuLtF6ix/5RxnOKtMOcljRaB2bUqR7Uezf+aSacYg499eH/SEsymR8Bw==
X-Received: by 2002:a37:40c:: with SMTP id 12mr25416692qke.212.1582145887255;
        Wed, 19 Feb 2020 12:58:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id t23sm615308qto.88.2020.02.19.12.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 12:58:06 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4WQ2-0006sB-AK; Wed, 19 Feb 2020 16:58:06 -0400
Date:   Wed, 19 Feb 2020 16:58:06 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Moni Shoua <monis@mellanox.com>
Subject: Re: [PATCH] RDMA/rxe: Fix configuration of atomic queue pair
 attributes
Message-ID: <20200219205806.GA26379@ziepe.ca>
References: <20200217205714.26937-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217205714.26937-1-bvanassche@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 17, 2020 at 12:57:14PM -0800, Bart Van Assche wrote:
> >From the comment above the definition of the roundup_pow_of_two() macro:
> 
>      The result is undefined when n == 0.
> 
> Hence only pass positive values to roundup_pow_of_two(). This patch fixes
> the following UBSAN complaint:
> 
> UBSAN: Undefined behaviour in ./include/linux/log2.h:57:13
> shift exponent 64 is too large for 64-bit type 'long unsigned int'
> Call Trace:
>  dump_stack+0xa5/0xe6
>  ubsan_epilogue+0x9/0x26
>  __ubsan_handle_shift_out_of_bounds.cold+0x4c/0xf9
>  rxe_qp_from_attr.cold+0x37/0x5d [rdma_rxe]
>  rxe_modify_qp+0x59/0x70 [rdma_rxe]
>  _ib_modify_qp+0x5aa/0x7c0 [ib_core]
>  ib_modify_qp+0x3b/0x50 [ib_core]
>  cma_modify_qp_rtr+0x234/0x260 [rdma_cm]
>  __rdma_accept+0x1a7/0x650 [rdma_cm]
>  nvmet_rdma_cm_handler+0x1286/0x14cd [nvmet_rdma]
>  cma_cm_event_handler+0x6b/0x330 [rdma_cm]
>  cma_ib_req_handler+0xe60/0x22d0 [rdma_cm]
>  cm_process_work+0x30/0x140 [ib_cm]
>  cm_req_handler+0x11f4/0x1cd0 [ib_cm]
>  cm_work_handler+0xb8/0x344e [ib_cm]
>  process_one_work+0x569/0xb60
>  worker_thread+0x7a/0x5d0
>  kthread+0x1e6/0x210
>  ret_from_fork+0x24/0x30
> 
> Cc: Moni Shoua <monis@mellanox.com>
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied to for-next, thanks

Jason
