Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C9C1FF23C
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2020 14:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbgFRMrS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Jun 2020 08:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729943AbgFRMrP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Jun 2020 08:47:15 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADDBC06174E
        for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2020 05:47:15 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id cv17so2638630qvb.13
        for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2020 05:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P0QI9IbJzhZz6iMdjNQIy2nbNyFvIUkCsqxu8rJxbOg=;
        b=e26HrYxtRtRJWxygAvTyuRGZkMo7jSjGubOoAQ+j4N5CEi4hGWbeBqHTai3/ip5Kma
         Lv41hqOKFK5SnzWGbo8lU//QO2w4fBOkRpRe7bERTSyGI75//g7nhVx8yVGnKf75h1Wv
         InZE3/4dS/AOPM8OPxYp/BHIUBycu9Pv6hWPurj74q8roxgMJwpn6/uAFbIwnKDzv8uI
         4Y7MhEuuBNPuNOB1wbwzuWHG7UeUhdG6C4/K0F4gcJrye4qpowU9GFCY1FVHNzO78G/Y
         COWSWC0u2i0kgqoB8OFpEAgCag76ZUfddy314Lnw2ER4Oo++Rp1x4lCZvVBQj6iLyfmS
         0YOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P0QI9IbJzhZz6iMdjNQIy2nbNyFvIUkCsqxu8rJxbOg=;
        b=XKnqe/D6SOg1cpKQOMZ1yY9Ig+DFxRMMj452J1nIPGnQ86jwjVVxJtkYeT5pJPC8lY
         YeayQ1Hvt4E8wCkM5gK3rF3zrcTm15lIGQ4sM4dVuAZ1VeurvWrhX/nLlFuv3j1e3n68
         Vhw1cC6QUO7tH4F5WA0XxzfZxPS78OAImkQFyFVpKfRZaTonypBaRKPnfVwnwmAWnlUJ
         nUrNjf8X5hrgv9Q1mhj9CHwc2y0xSSDOXzYum8SyXj7W4nOJvB6pbNUkTP6ilQXU4AgY
         zwaxWTj2kfTnBPknNOjwd8TKq9YH6mBCnblYMiKPH8+lq9YfhQLGTZzA4dUl/V+x2USY
         fS7A==
X-Gm-Message-State: AOAM533j2eA3iaMS+yHuSQwVZ59AM79g9qCp2lcg7ueUBoi9t3enqIVl
        BD4wEX5UJ6xrEJhW926OSYsKpw==
X-Google-Smtp-Source: ABdhPJwjdh73NSRJfBK1IkBpE9ejTir7sZG52NpSt18yIS4DVX+HnfzcxuM23zlBkfsIrX8zS/G80Q==
X-Received: by 2002:ad4:424f:: with SMTP id l15mr3507110qvq.94.1592484434716;
        Thu, 18 Jun 2020 05:47:14 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id o144sm2924018qke.126.2020.06.18.05.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 05:47:14 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jltwn-00A2Vp-By; Thu, 18 Jun 2020 09:47:13 -0300
Date:   Thu, 18 Jun 2020 09:47:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     dledford@redhat.com, ariel.elior@marvell.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma] RDMA/qedr: Fix KASAN: use-after-free in
 ucma_event_handler+0x532
Message-ID: <20200618124713.GD2392687@ziepe.ca>
References: <20200616093408.17827-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616093408.17827-1-michal.kalderon@marvell.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 16, 2020 at 12:34:08PM +0300, Michal Kalderon wrote:
> Private data passed to iwarp_cm_handler is copied for
> connection request / response, but ignored otherwise.
> If junk is passed, it is stored in the event and used later
> in the event processing.
> Driver passed old junk pointer during connection close
> which lead to a use-after-free on event processing.
> Set private data to NULL for events that don 't have private
> data.
> 
> BUG: KASAN: use-after-free in ucma_event_handler+0x532/0x560 [rdma_ucm]
> kernel: Read of size 4 at addr ffff8886caa71200 by task kworker/u128:1/5250
> kernel:
> kernel: Workqueue: iw_cm_wq cm_work_handler [iw_cm]
> kernel: Call Trace:
> kernel: dump_stack+0x8c/0xc0
> kernel: print_address_description.constprop.0+0x1b/0x210
> kernel: ? ucma_event_handler+0x532/0x560 [rdma_ucm]
> kernel: ? ucma_event_handler+0x532/0x560 [rdma_ucm]
> kernel: __kasan_report.cold+0x1a/0x33
> kernel: ? ucma_event_handler+0x532/0x560 [rdma_ucm]
> kernel: kasan_report+0xe/0x20
> kernel: check_memory_region+0x130/0x1a0
> kernel: memcpy+0x20/0x50
> kernel: ucma_event_handler+0x532/0x560 [rdma_ucm]
> kernel: ? __rpc_execute+0x608/0x620 [sunrpc]
> kernel: cma_iw_handler+0x212/0x330 [rdma_cm]
> kernel: ? iw_conn_req_handler+0x6e0/0x6e0 [rdma_cm]
> kernel: ? enqueue_timer+0x86/0x140
> kernel: ? _raw_write_lock_irq+0xd0/0xd0
> kernel: cm_work_handler+0xd3d/0x1070 [iw_cm]
> 
> Fixes: e411e0587e0d ("RDMA/qedr: Add iWARP connection management functions")
> Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
> Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
> ---
>  drivers/infiniband/hw/qedr/qedr_iw_cm.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason
