Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 997EB2B974
	for <lists+linux-rdma@lfdr.de>; Mon, 27 May 2019 19:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfE0RkA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 May 2019 13:40:00 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33986 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfE0RkA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 May 2019 13:40:00 -0400
Received: by mail-vs1-f67.google.com with SMTP id q64so11054080vsd.1
        for <linux-rdma@vger.kernel.org>; Mon, 27 May 2019 10:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KDgJ+CakTrrSCpxh2Y/ItrkS4N2ePcjY1Nk9Ij4iRNo=;
        b=lbZxcAubDlBQ3HbgPR/o/6pHe5J92jJQJE9NN7vrFZy/D+yOx9B7JHiVRoQvjlK3ow
         iGQwCXMLdMgeolyXvMgiHf8s7cT0C9LOYeuzasOuY8seulY/q/qF/6hEH1DtKXg5VSDo
         NfnuieVGyeqhe+kjpCaiY1si2C4XEnfneG6hquKrbZ4ogj2ehUEVfEldpRwMGP17Bzzl
         WDx6L7TEBTwE6e2fdWskjRpqeDbDwwlel+BSeJdDqQkopRv3tdiPESa8eyOTqxInY/1L
         yusHewAAGLCsc/ldaJGphRiVkYEukG5Rk/3OcRDI6snHd41BmPHijtPTy1zVoufRi6bM
         YX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KDgJ+CakTrrSCpxh2Y/ItrkS4N2ePcjY1Nk9Ij4iRNo=;
        b=QXIzNIswpeJoBBL1e1l6EPEzpzW5TgOrEHzqwTOa1qsWtBjvLQPwlAvZ+6CVPO9Chq
         uPne0Ub+gWIYAwt2Wn8MSli+2Rpvbs2bSP9zvMELADzcP9bgH/8xt2gKbTowfijBu1VA
         RfCGSXtF1XlddhbnD8kHO1/NAwzO7GY2KSw0jO4E5klUtuw0SuAOOFfCPO9LytO+jNuT
         wHVk/mwMcu4HJSjsUPcr2lX5NI64CMF5uSnaBRVVOMgym7vLOlm9SonyBwwNhRi78UC9
         1FgUBU9bS5RrkpGSxwxdQWFrrkH6IFiufpdJJMbxs8mmyeTKOpAzIebKcOxX4z/R8F4/
         G6lQ==
X-Gm-Message-State: APjAAAVaJgcZ+VBu+vxm1iKBPlW1Q/B5bxO446vWImhRZxih06alxrsn
        ZX0R81CQSyT6J1D3++g61FZFhA==
X-Google-Smtp-Source: APXvYqzddyYweWmyTEcxOGVn5Os0T4dsXGsBltQe1TMf9ILfHXqpfGA2F4k/ii8k+5hvBa82X7BzCw==
X-Received: by 2002:a67:e9cf:: with SMTP id q15mr36780304vso.194.1558978799493;
        Mon, 27 May 2019 10:39:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id u123sm6374585vku.27.2019.05.27.10.39.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 10:39:59 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hVJbK-0008KX-JJ; Mon, 27 May 2019 14:39:58 -0300
Date:   Mon, 27 May 2019 14:39:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-rc] RDMA/uverbs: Pass udata on uverbs error unwind
Message-ID: <20190527173958.GB31960@ziepe.ca>
References: <20190522080643.52654-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522080643.52654-1-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 22, 2019 at 11:06:43AM +0300, Gal Pressman wrote:
> When destroy_* is called as a result of uverbs create cleanup flow a
> cleared udata should be passed instead of NULL to indicate that it is
> called under user flow.
> 
> Fixes: bc38a6abdd5a ("[PATCH] IB uverbs: core implementation")
> Fixes: 67cdb40ca444 ("[IB] uverbs: Implement more commands")
> Fixes: 42849b2697c3 ("RDMA/uverbs: Export ib_open_qp() capability to user space")
> Fixes: 9ee79fce3642 ("IB/core: Add completion queue (cq) object actions")
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/core/uverbs_cmd.c          | 9 +++++----
>  drivers/infiniband/core/uverbs_std_types_cq.c | 2 +-
>  2 files changed, 6 insertions(+), 5 deletions(-)

Applied to for-rc (that last one was for-rc too, woops)

Thanks,
Jason
