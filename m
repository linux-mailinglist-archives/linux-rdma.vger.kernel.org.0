Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C267150E2
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 18:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfEFQHf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 12:07:35 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43823 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfEFQHf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 12:07:35 -0400
Received: by mail-qt1-f194.google.com with SMTP id r3so5428914qtp.10
        for <linux-rdma@vger.kernel.org>; Mon, 06 May 2019 09:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wcYjv+ipE7Mk1JjxK/0IsG1O/VBMreXC+yZJOTRZ6Hg=;
        b=F/0mje9RWL33zq3pipkzuyVUvoyiTv2qessZGP2xdT1R5LSc5RJtx5YYUp1mOQwrLH
         8bOtk+wm4HIOLujKhctmabpis+G6sexXAUIXeHDDuspmF/rwkAgKH79JEST8nTs9UImM
         T+ep8G/SlP1fUhZUYVnX5jKuhu3bvLVsRsbPSfb67CYPJ2IEeF9wg8HcOamIy8IndmNK
         l8oGW7UxqCF3qWOVSZ6F/ZxAFd2epsTn3rLxQEAcri4/KKOEIrwbinTFfEkYBSoAgRyj
         TqZZg0xjt44A0TAjOszMgd/h0n7teeVoX20ENIN49mVmcSVuvupnaKhzPdS0MyvgutM6
         hQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wcYjv+ipE7Mk1JjxK/0IsG1O/VBMreXC+yZJOTRZ6Hg=;
        b=GnJ514/IcS9H8qyhLuyCm4eTMvhngvpwal2i6UW1HZLKGXMvU9vbX3aXr+bcKFXdIU
         S020i6nBurVXyOm3oLf0I14h39ooEa0Ic+LmK1mPsEXFt2+ZHUMRTEhQYixh4yWdATkh
         Qy9DDygTmmw/+4/kvmeAqhJsen7TLJ8glsNE8mWeJ/vBq/ArjkyQsbckQ04NJyZxg7L7
         Y51IqExTvgvl0aRI7tll3wceiJLeJgk12tSzWV0BpAhs3GlEl0jJi+tdPaPvdnU2xUDz
         lpCyV/uB7OwDgKmC5SGb3gwfiv1jdPNgaX8ZLpRrC7nGQ3ZC4ZL770XGLJGHY3B16w70
         Bakg==
X-Gm-Message-State: APjAAAWMKbHr1KaFqqI7M3ezpXWP7fqK7GXKPocgwLP33EmRpYQbwkrT
        1zxRnb/oDCRzO2aTvu2b22TuDg==
X-Google-Smtp-Source: APXvYqyRvaa64P6N/Z5gV9spyYOGfJGYgzBHXeed1X9xkylGhyCfRkPtqh65Dbc83GrmP2xEKtCDNg==
X-Received: by 2002:a0c:9066:: with SMTP id o93mr21438167qvo.246.1557158854480;
        Mon, 06 May 2019 09:07:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id s68sm5879951qkb.16.2019.05.06.09.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 09:07:32 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hNg9M-0001gS-9h; Mon, 06 May 2019 13:07:32 -0300
Date:   Mon, 6 May 2019 13:07:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
Subject: Re: [PATCH for-rc 1/5] IB/hfi1: Fix WQ_MEM_RECLAIM warning
Message-ID: <20190506160732.GA6402@ziepe.ca>
References: <20190318165205.23550.97894.stgit@scvm10.sc.intel.com>
 <20190318165501.23550.24989.stgit@scvm10.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318165501.23550.24989.stgit@scvm10.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 18, 2019 at 09:55:09AM -0700, Dennis Dalessandro wrote:
> From: Mike Marciniszyn <mike.marciniszyn@intel.com>
> 
> The work_item cancels that occur when a QP is destroyed
> can elicit the following trace:
> 
> [  708.997199] workqueue: WQ_MEM_RECLAIM ipoib_wq:ipoib_cm_tx_reap [ib_ipoib] is flushing !WQ_MEM_RECLAIM hfi0_0:_hfi1_do_send [hfi1]
> [  708.997209] WARNING: CPU: 7 PID: 1403 at kernel/workqueue.c:2486 check_flush_dependency+0xb1/0x100
> [  709.227743] Call Trace:
> [  709.230852]  __flush_work.isra.29+0x8c/0x1a0
> [  709.235779]  ? __switch_to_asm+0x40/0x70
> [  709.240335]  __cancel_work_timer+0x103/0x190
> [  709.245253]  ? schedule+0x32/0x80
> [  709.249216]  iowait_cancel_work+0x15/0x30 [hfi1]
> [  709.254475]  rvt_reset_qp+0x1f8/0x3e0 [rdmavt]
> [  709.259554]  rvt_destroy_qp+0x65/0x1f0 [rdmavt]
> [  709.264703]  ? _cond_resched+0x15/0x30
> [  709.269081]  ib_destroy_qp+0xe9/0x230 [ib_core]
> [  709.274223]  ipoib_cm_tx_reap+0x21c/0x560 [ib_ipoib]
> [  709.279799]  process_one_work+0x171/0x370
> [  709.284425]  worker_thread+0x49/0x3f0
> [  709.288695]  kthread+0xf8/0x130
> [  709.292450]  ? max_active_store+0x80/0x80
> [  709.297050]  ? kthread_bind+0x10/0x10
> [  709.301293]  ret_from_fork+0x35/0x40
> [  709.305441] ---[ end trace f0e973737146499b ]---
> 
> Since QP destruction frees memory, hfi1_wq should have the WQ_MEM_RECLAIM.
> 
> Fixes: 0a226edd203f ("staging/rdma/hfi1: Use parallel workqueue for SDMA engines")
> Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> ---
>  drivers/infiniband/hw/hfi1/init.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Since Mike confirms there are no GFP_KERNEL memory allocations in the
hfi1_wq, applied to for-next

Thanks,
Jason
