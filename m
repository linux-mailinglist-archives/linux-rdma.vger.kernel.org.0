Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB75C1905E3
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2020 07:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgCXGqy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Mar 2020 02:46:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgCXGqy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Mar 2020 02:46:54 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 569C020719;
        Tue, 24 Mar 2020 06:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585032414;
        bh=jtt6G/dwnXJytxdHP5mQylNjpIqcmfDPITUJRm8HajY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bHZ8oVxFIQiMPrtpJ3fqGQCcRf5J9OjP/KL+8ODg39i3Qj+spTkSwR0qaVIPiNHb7
         oQhqX+YFnpI2GUxr8HW+Tf3khxOJSTXft8COXqE/3xnf7T0pOIwytJs4IYBUnTEmHJ
         VSNl4lON/eymnixRj0p5UpwxqqoEJnuIqBbI4tHE=
Date:   Tue, 24 Mar 2020 08:46:50 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     akpm@linux-foundation.org
Cc:     bmt@zurich.ibm.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
Subject: Re: [patch 1/1] drivers/infiniband/sw/siw/siw_qp_rx.c: suppress
 uninitialized var warning
Message-ID: <20200324064650.GS650439@unreal>
References: <20200323184627.ZWPg91uin%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323184627.ZWPg91uin%akpm@linux-foundation.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 23, 2020 at 11:46:27AM -0700, akpm@linux-foundation.org wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: drivers/infiniband/sw/siw/siw_qp_rx.c: suppress uninitialized var warning
>
> drivers/infiniband/sw/siw/siw_qp_rx.c: In function siw_proc_send:
> ./include/linux/spinlock.h:288:3: warning: flags may be used uninitialized in this function [-Wmaybe-uninitialized]
>    _raw_spin_unlock_irqrestore(lock, flags); \
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/infiniband/sw/siw/siw_qp_rx.c:335:16: note: flags was declared here
>   unsigned long flags;
>
> Cc: Bernard Metzler <bmt@zurich.ibm.com>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  drivers/infiniband/sw/siw/siw_qp_rx.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

It is unclear to me how is that possible.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
