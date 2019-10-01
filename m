Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34F97C36DE
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 16:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388666AbfJAORR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 10:17:17 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40033 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfJAORR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 10:17:17 -0400
Received: by mail-qt1-f194.google.com with SMTP id f7so21784619qtq.7
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 07:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=woGnZ4muXm0EAq53RtvKEYWKzdzgNYp33U3mq7AHnKI=;
        b=Vb1c6rn8eYf8O8teFi4qh9rx/G1n8blVyJcVqipnFcOK0ESTFy6y90RWEVMnauumvz
         xoCBKHEwC1mw3Ex3IiZ+lW6jr2KkF7s4J08aEKAv87gY8dYzSrLym7ZPxZHsdciY92Y8
         zPTdfnN+Z8oD9y8X/eqI7/H56SWarYOz4YZAg9vIuxzub0LEVBoylLJpHk/ffQXYdvKi
         TZ92vGSMzmYZpkLBFog5CnmXkCoqg6kD9YYXvF1puctFniyOqJqCxeZBcLaacfwmcrSP
         nzz2HstQzkDpH1wnB3SUxMPDbB0zHuzAxiGNsxvAEI4iSInvoBnoFU9ewBitkxSxJ4xB
         MIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=woGnZ4muXm0EAq53RtvKEYWKzdzgNYp33U3mq7AHnKI=;
        b=n6np9NM59ZwnlzVAZv1Y/5Fgw1aeuvbKvCAmMlB4QtFpu3N9b41dIbVL16tZ0OuQRm
         jDSi8gDIRsPq9/KGMylRcZBSZ7KwIfTK6jl77touWUuooKj7T5Ii0LdUTPEpeYHgXck1
         rqjaMNacYzPyEqgSm8K4gBTvQrhlBtj8yiWi3B4fVzIr6lWt7StVqVd2nKT5LmHdjVQ+
         OLcJz1tHEgMJoulwr+SDCe/ioAs/OVNSfRM/25NYGNNa8YKmt0GEhiBziCp/1hilhlKd
         Ck0VHbZVQO7RrXlexLBjkNdL4xQlyZLnOawwvWZ7KWR2i3d1bgRDRW5Ld+7ryVj7duch
         mORA==
X-Gm-Message-State: APjAAAVqj2IGe5L3W47rnmtE1EXiWyNPrd2M0MpiY5UayBKYlWRVsgMJ
        DjjZOYPFHk6091gCJoxfb5kBtw==
X-Google-Smtp-Source: APXvYqyghO40O+A5+ZHXvYYdqCnj2Nfp91De99yTxz1aSZJnPLYk09OjRC6R3UbJEhlmeHyuiHxZ9A==
X-Received: by 2002:ac8:340d:: with SMTP id u13mr30386157qtb.103.1569939435986;
        Tue, 01 Oct 2019 07:17:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id l129sm8140671qkd.84.2019.10.01.07.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 07:17:15 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFIxn-0007OD-1a; Tue, 01 Oct 2019 11:17:15 -0300
Date:   Tue, 1 Oct 2019 11:17:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>
Cc:     bmt@zurich.ibm.com, linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com
Subject: Re: [PATCH for-next] RDMA/siw: fixes serialization issue in
 write_space
Message-ID: <20191001141715.GA28346@ziepe.ca>
References: <20190923101112.32685-1-krishna2@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923101112.32685-1-krishna2@chelsio.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 23, 2019 at 03:41:12PM +0530, Krishnamraju Eraparaju wrote:
> In siw_qp_llp_write_space(), 'sock' members should be accessed
> with sk_callback_lock held, otherwise, it could race with
> siw_sk_restore_upcalls(). And this could cause "NULL deref" panic.
> Below panic is due to the NULL cep returned from sk_to_cep(sk):
> [14524.030863] Call Trace:
> [14524.030868]  <IRQ>    siw_qp_llp_write_space+0x11/0x40 [siw]
> [14524.030873]  tcp_check_space+0x4c/0xf0
> [14524.030877]  tcp_rcv_established+0x52b/0x630
> [14524.030880]  tcp_v4_do_rcv+0xf4/0x1e0
> [14524.030882]  tcp_v4_rcv+0x9b8/0xab0
> [14524.030886]  ip_protocol_deliver_rcu+0x2c/0x1c0
> [14524.030889]  ip_local_deliver_finish+0x44/0x50
> [14524.030891]  ip_local_deliver+0x6b/0xf0
> [14524.030893]  ? ip_protocol_deliver_rcu+0x1c0/0x1c0
> [14524.030896]  ip_rcv+0x52/0xd0
> [14524.030898]  ? ip_rcv_finish_core.isra.14+0x390/0x390
> [14524.030903]  __netif_receive_skb_one_core+0x83/0xa0
> [14524.030906]  netif_receive_skb_internal+0x73/0xb0
> [14524.030909]  napi_gro_frags+0x1ff/0x2b0
> [14524.030922]  t4_ethrx_handler+0x4a7/0x740 [cxgb4]
> [14524.030930]  process_responses+0x2c9/0x590 [cxgb4]
> [14524.030937]  ? t4_sge_intr_msix+0x1d/0x30 [cxgb4]
> [14524.030941]  ? handle_irq_event_percpu+0x51/0x70
> [14524.030943]  ? handle_irq_event+0x41/0x60
> [14524.030946]  ? handle_edge_irq+0x97/0x1a0
> [14524.030952]  napi_rx_handler+0x14/0xe0 [cxgb4]
> [14524.030955]  net_rx_action+0x2af/0x410
> [14524.030962]  __do_softirq+0xda/0x2a8
> [14524.030965]  do_softirq_own_stack+0x2a/0x40
> [14524.030967]  </IRQ>
> [14524.030969]  do_softirq+0x50/0x60
> [14524.030972]  __local_bh_enable_ip+0x50/0x60
> [14524.030974]  ip_finish_output2+0x18f/0x520
> [14524.030977]  ip_output+0x6e/0xf0
> [14524.030979]  ? __ip_finish_output+0x1f0/0x1f0
> [14524.030982]  __ip_queue_xmit+0x14f/0x3d0
> [14524.030986]  ? __slab_alloc+0x4b/0x58
> [14524.030990]  __tcp_transmit_skb+0x57d/0xa60
> [14524.030992]  tcp_write_xmit+0x23b/0xfd0
> [14524.030995]  __tcp_push_pending_frames+0x2e/0xf0
> [14524.030998]  tcp_sendmsg_locked+0x939/0xd50
> [14524.031001]  tcp_sendmsg+0x27/0x40
> [14524.031004]  sock_sendmsg+0x57/0x80
> [14524.031009]  siw_tx_hdt+0x894/0xb20 [siw]
> [14524.031015]  ? find_busiest_group+0x3e/0x5b0
> [14524.031019]  ? common_interrupt+0xa/0xf
> [14524.031021]  ? common_interrupt+0xa/0xf
> [14524.031023]  ? common_interrupt+0xa/0xf
> [14524.031028]  siw_qp_sq_process+0xf1/0xe60 [siw]
> [14524.031031]  ? __wake_up_common_lock+0x87/0xc0
> [14524.031035]  siw_sq_resume+0x33/0xe0 [siw]
> [14524.031039]  siw_run_sq+0xac/0x190 [siw]
> [14524.031041]  ? remove_wait_queue+0x60/0x60
> [14524.031045]  kthread+0xf8/0x130
> [14524.031049]  ? siw_sq_resume+0xe0/0xe0 [siw]
> [14524.031051]  ? kthread_bind+0x10/0x10
> [14524.031053]  ret_from_fork+0x35/0x40
> 
> Fixes: f29dd55b0236 (rdma/siw: queue pair methods)
> Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
> Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_qp.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Applied to for-rc, thanks

Jason
