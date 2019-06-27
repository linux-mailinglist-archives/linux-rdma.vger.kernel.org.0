Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68D1358653
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2019 17:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfF0PwV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jun 2019 11:52:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40075 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfF0PwV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jun 2019 11:52:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so1440064pfp.7
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jun 2019 08:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VLLd6K0vqyBNbkQVwgp5BZXO/LT3WOmaSUwZO5QWDrg=;
        b=knTQPbK6G+svsmWdrj/2PXhQkHj5UhNU+/qMResMeicO7+l39HTC0p2xvP5nrzFn7x
         Q2pH+5it2QAQM4Q6UUebNuwyQQIUNSfDiyOoE05K/6LF4LMBnQERJrJP4gljUBaKR5d0
         5Xngb90Wc/iPMZBYW4KHC/u9vcxHDwRv2Qb/DMEnWPfEZEwjg+eLqnGd11PSNt+JYFub
         9pw9VGakW7HR+4aunXxJBrlJwxmfM0SG4HFT9StI/pKXxj+pA657ZkFxHsAkq2KK9yQf
         C6m8s2pqtFUs01BrfbSfjD3ptQYJc6AZJyT5O5nU1C647yKNy0o0UE+qoBKqQ/QQfeHQ
         0+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VLLd6K0vqyBNbkQVwgp5BZXO/LT3WOmaSUwZO5QWDrg=;
        b=tZI3V417EBODNWyUUcw5KLvszGkeYJndZn14serHAZ2+GMjgtbjNSdUIcaCBE31SU5
         ICA5sH9NJgMQ369cboNwOqp6r3xq7b7X5Fl4o1WcNrC2aJcfgp7VQtU+Jqpql6q04d5d
         AximHjSBZ/NgCK3knIW8KJchGjRYyOTEbja8z9TUXVWySbE+GoABZ7NEdFrQgE+zf2Ez
         I0BhraQuWi+ympgqP+N90iwAntPTutnscTbWRHOPH9NT9qN8yfh8EaCtMfA64hjTUWHm
         Kxzo9GKu+cj5nE3wiyTKul9jLTDSrrkpKeJT5T+3Rnk02Ee4GUvitG9z2fRjnnwOS5mN
         wbWQ==
X-Gm-Message-State: APjAAAU/koJDoQc3IhGZLUQsmB7xhj27QcjSOM01RFWbe7/Bi+IfpyKV
        uYD1S+ULms7g24/iKiiaVm1h/Q==
X-Google-Smtp-Source: APXvYqwCVKsMztKGVGBRcG9r0gNZ3vTgg2wxpx17R5TVCC+vnaxuhJCcJB1h6/HcKe9TwsXmPIdXtA==
X-Received: by 2002:a17:90a:a410:: with SMTP id y16mr6998519pjp.62.1561650740801;
        Thu, 27 Jun 2019 08:52:20 -0700 (PDT)
Received: from ziepe.ca ([12.199.206.50])
        by smtp.gmail.com with ESMTPSA id x25sm3185282pfm.48.2019.06.27.08.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 08:52:20 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hgWh9-0002XN-Do; Thu, 27 Jun 2019 12:52:19 -0300
Date:   Thu, 27 Jun 2019 12:52:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Michal Kalderon <michal.kalderon@marvell.com>, dledford@redhat.com,
        leon@kernel.org, sleybo@amazon.com, ariel.elior@marvell.com,
        linux-rdma@vger.kernel.org
Subject: Re: [RFC rdma 1/3] RDMA/core: Create a common mmap function
Message-ID: <20190627155219.GA9568@ziepe.ca>
References: <20190627135825.4924-1-michal.kalderon@marvell.com>
 <20190627135825.4924-2-michal.kalderon@marvell.com>
 <d6e9bc3b-215b-c6ea-11d2-01ae8f956bfa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6e9bc3b-215b-c6ea-11d2-01ae8f956bfa@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 27, 2019 at 06:25:37PM +0300, Gal Pressman wrote:
> On 27/06/2019 16:58, Michal Kalderon wrote:
> > Create a common API for adding entries to a xa_mmap.
> > This API can be used by drivers that don't require special
> > mapping for user mapped memory.
> > 
> > The code was copied from the efa driver almost as is, just renamed
> > function to be generic and not efa specific.
> 
> I don't think we should force the mmap flags to be the same for all drivers..
> Take a look at mlx5 for example:
> 
> enum mlx5_ib_mmap_cmd {
> 	MLX5_IB_MMAP_REGULAR_PAGE               = 0,
> 	MLX5_IB_MMAP_GET_CONTIGUOUS_PAGES       = 1,
> 	MLX5_IB_MMAP_WC_PAGE                    = 2,
> 	MLX5_IB_MMAP_NC_PAGE                    = 3,
> 	/* 5 is chosen in order to be compatible with old versions of libmlx5 */
> 	MLX5_IB_MMAP_CORE_CLOCK                 = 5,
> 	MLX5_IB_MMAP_ALLOC_WC                   = 6,
> 	MLX5_IB_MMAP_CLOCK_INFO                 = 7,
> 	MLX5_IB_MMAP_DEVICE_MEM                 = 8,
> };
> 
> The flags taken from EFA aren't necessarily going to work for other drivers.
> Maybe the flags bits should be opaque to ib_core and leave the actual mmap
> callbacks in the drivers. Not sure how dealloc_ucontext is going to work with
> opaque flags though?

Yes, the driver will have to take care of masking the flags before
lookup

We should probably store the struct page * in the
rdma_user_mmap_entry() and use that to key struct page behavior.

Do you think we should go further and provide a generic mmap() that
does the right thing? It would not be hard to provide a callback that
computes the pgprot flags 

Jason
