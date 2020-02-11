Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31D361598CA
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2020 19:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgBKSf0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Feb 2020 13:35:26 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35233 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbgBKSfZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Feb 2020 13:35:25 -0500
Received: by mail-qk1-f195.google.com with SMTP id v2so6181251qkj.2
        for <linux-rdma@vger.kernel.org>; Tue, 11 Feb 2020 10:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3l8bG3Modik7o9dSjL+Uzzx09lalKUJpec/R98Tv7So=;
        b=KAh1HMaSEaPBl7UO629zL2R/rEuXVqZZYuRqcQ1TMQuQwDIdbdF03L1xzxfXASgxZY
         aOL0E/r53fFBBvllP1eWSCUw+fz0Ag5+qd+ltaPdD2u+r01OVrp0vf0FWR43UI94f9iW
         NWXdHFs38t0jLpK9T/I5qXV8NJDqK9HkY1ConICgYmE3GxPgglnCcRgCGTGj2YG8J7wf
         aT0BZGsBFUE/4gmWkjtJwlPuSFfdCWv/b+0ZDqHEiGRpYYa0k/lV8dDAicFvokKI0bFZ
         KGS+6dbRXCPsw8BbzSSyyBe4IjSsnC/DpNR/cm02zWEHnziTbPoJCwWn7y/V2m98qWgU
         0S1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3l8bG3Modik7o9dSjL+Uzzx09lalKUJpec/R98Tv7So=;
        b=rQxeavjjWRCK+zLGMxRzbY1jFynRIfpmatmWaifbtR54e8rFrEXEXh8roTdtajDkne
         g0MfeW7YVyqZ/DKF/fl61/HIBIRmByazG3h7fdRjYpRqOlKBBf/WMRCdAa+IP0TGZI0o
         UJKcwug0GibZIS8HoOi9K9yWuqvk0X2VI0VWCXY/fvolDx0uwHCgdbHwQaxndsMX5RHS
         TR/jbTYICGVAmLzXEDvAxYH5Di0PsQF3fiYIN0osI8k8dTYdysGQrQwR85Wxv9TBrTaq
         Md6FoHICMAaSiMdVuLc8/b0Zq1wnxcbZsiW9QyoGokaaoqNTUXED3clgbztINd/bT7zb
         aLzA==
X-Gm-Message-State: APjAAAV7Fmb0GrI+oV3ruZRHrgtC16RsOHt6LU97XVOejhFuQnr2mXoy
        I1q8cik/KFvFVHbQTSP12QebRg==
X-Google-Smtp-Source: APXvYqzltAlFPq4IPoC0CxJuZFhnKNrCR8lk0srVaKL8Pe81d7zMm7HGupFSINcH9RBCfBAskSnFhg==
X-Received: by 2002:a37:2f07:: with SMTP id v7mr3741634qkh.261.1581446124940;
        Tue, 11 Feb 2020 10:35:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id c25sm2409995qkc.12.2020.02.11.10.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2020 10:35:24 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j1aNX-0003sI-Qn; Tue, 11 Feb 2020 14:35:23 -0400
Date:   Tue, 11 Feb 2020 14:35:23 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>
Cc:     dledford@redhat.com, bmt@zurich.ibm.com,
        linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com
Subject: Re: [PATCH for-rc] RDMA/siw: Remove unwanted WARN_ON in
 siw_cm_llp_data_ready()
Message-ID: <20200211183523.GA14870@ziepe.ca>
References: <20200207141429.27927-1-krishna2@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207141429.27927-1-krishna2@chelsio.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 07, 2020 at 07:44:29PM +0530, Krishnamraju Eraparaju wrote:
> Warnings like below can fill up the dmesg while disconnecting RDMA
> connections.
> Hence, removing the unwanted WARN_ON.
> 
> [72103.557612] WARNING: CPU: 6 PID: 0 at
> drivers/infiniband/sw/siw/siw_cm.c:1229 siw_cm_llp_data_ready+0xc1/0xd0
> [siw]
> [72103.557677] RIP: 0010:siw_cm_llp_data_ready+0xc1/0xd0 [siw]
> [72103.557693] Call Trace:
> [72103.557699]  <IRQ>
> [72103.557711]  tcp_data_queue+0x226/0xb40
> [72103.557714]  tcp_rcv_established+0x220/0x620
> [72103.557720]  tcp_v4_do_rcv+0x12a/0x1e0
> [72103.557722]  tcp_v4_rcv+0xb05/0xc00
> [72103.557728]  ip_local_deliver_finish+0x69/0x210
> [72103.557730]  ip_local_deliver+0x6b/0xe0
> [72103.557735]  ip_rcv+0x273/0x362
> [72103.557740]  __netif_receive_skb_core+0xb35/0xc30
> [72103.557752]  netif_receive_skb_internal+0x3d/0xb0
> [72103.557754]  napi_gro_frags+0x13b/0x200
> [72103.557788]  t4_ethrx_handler+0x433/0x7d0 [cxgb4]
> [72103.557800]  process_responses+0x318/0x580 [cxgb4]
> [72103.557820]  napi_rx_handler+0x14/0x100 [cxgb4]
> [72103.557822]  net_rx_action+0x149/0x3b0
> [72103.557826]  __do_softirq+0xe3/0x30a
> [72103.557831]  irq_exit+0x100/0x110
> [72103.557834]  do_IRQ+0x7f/0xe0
> [72103.557837]  common_interrupt+0xf/0xf
> [72103.557838]  </IRQ>
> 
> Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
> ---
>  drivers/infiniband/sw/siw/siw_cm.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Applied to for-rc, thanks

Jason
