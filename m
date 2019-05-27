Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA772BA0B
	for <lists+linux-rdma@lfdr.de>; Mon, 27 May 2019 20:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfE0SWW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 May 2019 14:22:22 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:32914 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfE0SWW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 May 2019 14:22:22 -0400
Received: by mail-vs1-f67.google.com with SMTP id y6so11135334vsb.0
        for <linux-rdma@vger.kernel.org>; Mon, 27 May 2019 11:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/01cq/SlaYtbObkQmxmZjx+axtEBoN7csuX0fKHDcl8=;
        b=lT/DaBwGHTHzn0cV3BLyQXSapO0RBgxGvERFvh56gsn4Zb4OBgEtFFEDEobyS481WN
         AFdN7EddQdi4M+68E/2joCb/T2QF9wJvJvB623VEx779sgIpv/mX2KN19vizyKZa5Okj
         2mc/uiEsLNdZ5Z6x0djfOGFVlPBfDCDFA5ex3HaL6HZM3YMg3oSISz1t6YKkvJAfSW0s
         xDYXf8szb9JgcuraU0uWxvS5q4JD9d1DvEsgo2hoie9B++ufmLR0ukgmkTx/0klti21W
         4lj012BopBMroWX2q+FalglYy1xiPz+HcJDK8ST4s9loWhd5Nh9X3RmPQPpMSXD77kvH
         vvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/01cq/SlaYtbObkQmxmZjx+axtEBoN7csuX0fKHDcl8=;
        b=IccFiuxol/44pt2wPiuU053/pBsg1HaDKWa6L0tnSetFs0QGWyr6o/I5u2QJiGacje
         VCtIXSucwQR0/LayVxpbJRTk+WR4st30LrSX4KEir+Ekq8biwB71oE8/3JsimnTpo5mk
         H9gl6f2vCSuhUeQWvK8ldmE+HhKDmd73FyNGHEtWPL4uCjPhxbO6B4GPsFO8+/FtxfZQ
         nGpGOenB/orp6yBtiEz01JYkYQk6h75qByF6Mts/eIRusQoRd82nIHKdvOZm5sTyyWSN
         /DrwOXgS6o0fWxx0Z5HJRv6I+EF64wuMg1Wi390AkyshArP6cJrFdWzJ1pkxr1oYEgY7
         WBlg==
X-Gm-Message-State: APjAAAUHPKIOSokRc5CmgfnOG5NyctwsbXSKnk3iPw6wKF8DtMp4BOmt
        kA8X2kuN734cnSpR/gg0Xb2vmw==
X-Google-Smtp-Source: APXvYqz0x7n/PurCMpAcrP2HcCDXsAu+c1D6AWgDLypzmGgf96DcDbTeuC9OxnZ9iBSI8yy47T7BqQ==
X-Received: by 2002:a05:6102:2008:: with SMTP id p8mr30980558vsr.73.1558981341026;
        Mon, 27 May 2019 11:22:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id t193sm7610091vkc.48.2019.05.27.11.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 11:22:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hVKGK-0003Xm-0o; Mon, 27 May 2019 15:22:20 -0300
Date:   Mon, 27 May 2019 15:22:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yuval Shaia <yuval.shaia@oracle.com>
Cc:     yishaih@mellanox.com, dledford@redhat.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-core] verbs: Introduce a new reg_mr API for virtual
 address space
Message-ID: <20190527182219.GF18100@ziepe.ca>
References: <20190527150004.21191-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527150004.21191-1-yuval.shaia@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 27, 2019 at 06:00:04PM +0300, Yuval Shaia wrote:
> The virtual address that is registered is used as a base for any address
> used later in post_recv and post_send operations.
> 
> On a virtualised environment this is not correct.
> 
> A guest cannot register its memory so hypervisor maps the guest physical
> address to a host virtual address and register it with the HW. Later on,
> at datapath phase, the guest fills the SGEs with addresses from its
> address space.
> Since HW cannot access guest virtual address space an extra translation
> is needed to map those addresses to be based on the host virtual address
> that was registered with the HW.
> 
> To avoid this, a logical separation between the address that is
> registered and the address that is used as a offset at datapath phase is
> needed.
> 
> This separation is already implemented in the lower layer part
> (ibv_cmd_reg_mr) but blocked at the API level.
> 
> Fix it by introducing a new API function that accepts a address from
> guest virtual address space as well.
> 
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>  libibverbs/verbs.c | 24 ++++++++++++++++++++++++
>  libibverbs/verbs.h |  6 ++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
> index 1766b9f5..9ad74ee0 100644
> +++ b/libibverbs/verbs.c
> @@ -324,6 +324,30 @@ LATEST_SYMVER_FUNC(ibv_reg_mr, 1_1, "IBVERBS_1.1",
>  	return mr;
>  }
>  
> +LATEST_SYMVER_FUNC(ibv_reg_mr_virt_as, 1_1, "IBVERBS_1.1",
> +		   struct ibv_mr *,
> +		   struct ibv_pd *pd, void *addr, size_t length,
> +		   uint64_t hca_va, int access)
> +{

Doesn't need this macro since it doesn't have a compat version

> +	struct verbs_mr *vmr;
> +	struct ibv_reg_mr cmd;
> +	struct ib_uverbs_reg_mr_resp resp;
> +	int ret;
> +
> +	vmr = malloc(sizeof(*vmr));
> +	if (!vmr)
> +		return NULL;
> +
> +	ret = ibv_cmd_reg_mr(pd, addr, length, hca_va, access, vmr, &cmd,
> +			     sizeof(cmd), &resp, sizeof(resp));

It seems problematic not to call the driver, several of the drivers
are wrappering mr in their own type (ie bnxt_re_mr) and we can't just
allocate the wrong size of memory here.

What you should do is modify the existing driver callback to accept
another argument and go and fix all the drivers to pass that argument
into their ibv_cmd_reg_mr as the hca_va above. This looks pretty
trivial.

Jason
