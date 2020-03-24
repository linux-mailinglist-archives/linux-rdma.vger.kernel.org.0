Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88FB4191D1D
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2020 23:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgCXWvT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Mar 2020 18:51:19 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45391 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgCXWvT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Mar 2020 18:51:19 -0400
Received: by mail-qk1-f196.google.com with SMTP id c145so410732qke.12
        for <linux-rdma@vger.kernel.org>; Tue, 24 Mar 2020 15:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PjcP9lzQMwmICwhCoEKnoXXGKoXGa/nC7VH5icQxC5o=;
        b=WWUZ6BsMgNfzw1P/XbzyJ0cZCuxE9StGudpHUN/cxMQtdc7EBsS6qyFSKbCR2IBTDI
         I9lcDWMyb58zmxbT/a+Thq44YDxmaMOT4u4hgq4RtE4vQFx8vbZSXLZoww36P2+sWBvB
         tqyPQMH17Yvg0Mv+urYBYgjyLeA71PIDmPfkB8vlF7QJd1L2o0WDc67QcMNKY7Qs6WjS
         dlXe+W2uc18OnWIR/MTpbL6vMpSOp9tmkPR3zIeVP6RxSrorO8ErwMJWPdGRBkk+jmqT
         IxrsNLzPcUvN6ylkT9CKPPHwbtkNf0tXGq8h6k+j1EVAfRTT7740nPDvikV9YxOsJE1i
         Z1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PjcP9lzQMwmICwhCoEKnoXXGKoXGa/nC7VH5icQxC5o=;
        b=sy7lNzuT8yWI5FAs1cM8Cug4N/A8xqwxNEJXXHj7lfMSQAk5sKyKmbOkD9sN1KlHqV
         UO65u41SwRPTko1els/PmySj+Sn852l+RPXCslMNSgAiBiW8TSvWcZK8xmv9ChQOycY7
         CwsJ5E15FlvJJe0WNFSEG2dUDv+JwxNIxc208sYY+xfJT2SCcC91vyYKoq8AjCKo1nWa
         eGWC4eK0gSkSDwMsSkK29hvKOB4b+DxE2z9loK02fqDpg3iul3Dx7l4NJdVYrPe+c1E3
         sHg3wOSgIaCi1m0dmzWh1BrTttpWfcAy6rbcyOIqnOZn9XTP8f557AhzgYaU54UOf5XE
         3TRw==
X-Gm-Message-State: ANhLgQ0ndAkVHguzlLoMvvjgBnCPZYPzOiHj3gQUyqfMgF9+cQmJcGMt
        wgzUgT2NNn1DYrLgRxSRZRNsOw==
X-Google-Smtp-Source: ADFU+vtkJo9IOLurEFJbhSY7tww6MTT1dkx3qVfKIXvicK+OhvBSEdXbdq2e7JXX0/uwY4P6CNvN9g==
X-Received: by 2002:a37:4f51:: with SMTP id d78mr253272qkb.28.1585090276895;
        Tue, 24 Mar 2020 15:51:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id w132sm14105005qkb.96.2020.03.24.15.51.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Mar 2020 15:51:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jGsOC-0007Rn-2K; Tue, 24 Mar 2020 19:51:16 -0300
Date:   Tue, 24 Mar 2020 19:51:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     akpm@linux-foundation.org
Cc:     bmt@zurich.ibm.com, dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [patch 1/1] drivers/infiniband/sw/siw/siw_qp_rx.c: suppress
 uninitialized var warning
Message-ID: <20200324225116.GB28435@ziepe.ca>
References: <20200323184627.ZWPg91uin%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323184627.ZWPg91uin%akpm@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

Applied to for-next, though I suppose gcc fixed this at some point as
I don't see the warning here...

Thanks,
Jason
