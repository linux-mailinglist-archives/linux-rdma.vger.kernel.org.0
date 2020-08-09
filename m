Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07A023FD65
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Aug 2020 10:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgHIIjH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Aug 2020 04:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgHIIjE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Aug 2020 04:39:04 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A050AC061756;
        Sun,  9 Aug 2020 01:39:04 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d188so3535308pfd.2;
        Sun, 09 Aug 2020 01:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UUqjBFLSFj07bofmN+lmejWkKSobWy2Q37QPpM9tfM4=;
        b=DRitf7/xZbhFIbD4BmPyA9TTpOSRlwfq/F3xuOaDUsJO3IzpFeV1oVGTH8+Wi2SwGn
         My0qxHjKHMVTZ9DvI8QegnU3vp+xPjg26dsp6Ti4mW/lVmRg5Cp3A7CithXfxdgzlOhr
         qNSN4k+BoYJ25CZOj9PufG1/NM/JGTho6uEgF0BvQDvdKAzH2k302BvV4Eh5WdXRAtF+
         UUcqBgmwbJO5STQ4bAhV8foXLHWSGrvkM6gHQZ2U4pRJPDhxWmGxBGHqCb0RAdK/bInU
         it58SLgxoUYtnmLJ6h7limNeaE8Zjp0KuNCNQG8n5lhh1ti0MpH+5RLg2U+5zThs2DRm
         i/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UUqjBFLSFj07bofmN+lmejWkKSobWy2Q37QPpM9tfM4=;
        b=cv9H+fjZLmNCWIEU/5+HbL40YUnpfugrRiAAcXF1Hgs1PZh79CtYZnDtE6nnSwo8/Y
         pUw12z+ANmbYADmn/gP32FDvDl3POq5FQ/BFr/bIm2w/hjxiSiL1R1oNaKwZjcaVfKWt
         yxgmwHB7bpwg9b9X7mXlKM0DSLrY1LkEGbunuT8sovMG2cylfPzq3RE9GbKa3ztKwwDW
         vf1u79vu3AKQadzGxxDe345fbXrkuU937yR9B7GicnwyAtFVblNHZRnbA5rhLjvhF+ln
         e0W3rJ+m3UHu51hjXhc7ZuMm2bG3sUhrZBvn3ujD344vLFtupxG+iKOk8/papuGFQbnP
         6I0A==
X-Gm-Message-State: AOAM533ed3JjbVZaFIreuLOviL4ybMrfuY8FV8xEkCBCV+SS9S4qdSPI
        X3EDvdolR8by/MfXXWl8fb4=
X-Google-Smtp-Source: ABdhPJyvUr21NMad5ZRJfyYb5NwR2zQVU55Q8hb8qn25pFJb7Nomw/QR5LtliW/Q8gDkiMd+7/wHXQ==
X-Received: by 2002:aa7:8f0d:: with SMTP id x13mr20702677pfr.193.1596962344142;
        Sun, 09 Aug 2020 01:39:04 -0700 (PDT)
Received: from blackclown ([103.88.82.9])
        by smtp.gmail.com with ESMTPSA id s2sm16760513pjb.33.2020.08.09.01.39.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Aug 2020 01:39:03 -0700 (PDT)
Date:   Sun, 9 Aug 2020 14:08:57 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/4] Infiniband Subsystem: Remove pci-dma-compat wrapper
 APIs.
Message-ID: <20200809083857.GB4419@blackclown>
References: <cover.1596957073.git.usuraj35@gmail.com>
 <9220090e-7340-df50-a998-57a5e7752f90@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9220090e-7340-df50-a998-57a5e7752f90@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 09, 2020 at 11:35:51AM +0300, Gal Pressman wrote:
> On 09/08/2020 10:24, Suraj Upadhyay wrote:
> > Hii Developers,
> > 
> > 	This patch series will replace all the legacy pci-dma-compat wrappers
> > with the dma-mapping APIs directly in the INFINIBAND Subsystem.
> > 
> > This task is done through a coccinelle script which is described in each commit
> > message.
> > 
> > The changes are compile tested.
> > 
> > Thanks,
> > 
> > Suraj Upadhyay.
> > 
> > Suraj Upadhyay (4):
> >   IB/hfi1: Remove pci-dma-compat wrapper APIs
> >   IB/mthca: Remove pci-dma-compat wrapper APIs
> >   RDMA/qib: Remove pci-dma-compat wrapper APIs
> >   RDMA/pvrdma: Remove pci-dma-compat wrapper APIs
> > 
> >  drivers/infiniband/hw/hfi1/pcie.c             |  8 +++----
> >  drivers/infiniband/hw/hfi1/user_exp_rcv.c     | 13 +++++------
> >  drivers/infiniband/hw/mthca/mthca_eq.c        | 21 +++++++++--------
> >  drivers/infiniband/hw/mthca/mthca_main.c      |  8 +++----
> >  drivers/infiniband/hw/mthca/mthca_memfree.c   | 23 +++++++++++--------
> >  drivers/infiniband/hw/qib/qib_file_ops.c      | 12 +++++-----
> >  drivers/infiniband/hw/qib/qib_init.c          |  4 ++--
> >  drivers/infiniband/hw/qib/qib_pcie.c          |  8 +++----
> >  drivers/infiniband/hw/qib/qib_user_pages.c    | 12 +++++-----
> >  .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  6 ++---
> >  10 files changed, 59 insertions(+), 56 deletions(-)
> > 
> 
> The efa patch isn't listed here, and it shows as patch 5/4?

Yes, I forgot to add it in the queue.

Thought it would be nice if the patch ("efa") would be in the chain.

Though I am sending a v2 for that patch following joe perches suggestion.

Hope this wasn't an annoyance.

Thanks,

Suraj Upadhyay.
