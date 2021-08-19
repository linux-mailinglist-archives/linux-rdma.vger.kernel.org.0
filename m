Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603733F1DA8
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Aug 2021 18:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhHSQTs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 12:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhHSQTq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Aug 2021 12:19:46 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADC6C0613CF
        for <linux-rdma@vger.kernel.org>; Thu, 19 Aug 2021 09:19:10 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s11so6377925pgr.11
        for <linux-rdma@vger.kernel.org>; Thu, 19 Aug 2021 09:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n2oL4Tx9YBEJZiltx3dyyG7cK1iW2U3lPZG+XFyhvas=;
        b=XcvTQsHIqAMvz+OHaEsqApoAMj9xFz4KXlaVtsPGT2F+luagoLzdXIebPHS4j6pFee
         IJW4Vxvn87dQMza107p/hLmHsT8aJn/AJga6hh91EOE0PYesVez/KzjBmcCzRbB43LwI
         H4TFo9uhc7IGBXaXQosGymgHxkkIqv0Mxbo5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n2oL4Tx9YBEJZiltx3dyyG7cK1iW2U3lPZG+XFyhvas=;
        b=EEJFIb/lxplBijz5nbqZmkGHLDtVY0XEOrxPGE8PqM6EdeSTh1OuFJXl609saraUtl
         9T961l8JTvmFMPU68nA1+6UaIc6GsVgL/Qc9SstfWlcAR8u/VEg6ohwi7ezgpF5KBmcV
         LasrodAsE/J1fMM+pIMKERyiJ1IIX2SAPSjMFkSRg+ZTOIIeM6i1hWOUJu4lgXPpQd7t
         /MS92k7G1XUZxqtt+bMGBaHzLzZiVOvScqFGg+qft4kybFwTiznmUcKKnNUf3k25bLWJ
         2eA/HfgFSldAp6ToUZi1IyP2KxttE+1oi96L79s6+dWluuusZhapljY7aapEAafDVd2y
         rYbQ==
X-Gm-Message-State: AOAM533zlLJvFHN8HMxqF/C6QhK/OQxQHeIKErrg/5ww7z0h4B04WflK
        QkSVcJtzsfPa9aDyOp7ScVyPtA==
X-Google-Smtp-Source: ABdhPJyZRMTxNLvnP3ZI2pCtW5KRkxw1jg2bC0ZQQ8R3fVO/fGTe1UBVRpNWar80Ru5tv+2px3ZDyw==
X-Received: by 2002:a62:78d0:0:b029:3dd:8fc1:2797 with SMTP id t199-20020a6278d00000b02903dd8fc12797mr15227415pfc.65.1629389949876;
        Thu, 19 Aug 2021 09:19:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g26sm4675777pgb.45.2021.08.19.09.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 09:19:09 -0700 (PDT)
Date:   Thu, 19 Aug 2021 09:19:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 56/63] RDMA/mlx5: Use struct_group() to zero struct
 mlx5_ib_mr
Message-ID: <202108190916.7CC455DA@keescook>
References: <20210818060533.3569517-1-keescook@chromium.org>
 <20210818060533.3569517-57-keescook@chromium.org>
 <20210819122716.GP543798@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819122716.GP543798@ziepe.ca>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 19, 2021 at 09:27:16AM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 17, 2021 at 11:05:26PM -0700, Kees Cook wrote:
> > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > field bounds checking for memset(), avoid intentionally writing across
> > neighboring fields.
> > 
> > Add struct_group() to mark region of struct mlx5_ib_mr that should be
> > initialized to zero.
> > 
> > Cc: Leon Romanovsky <leon@kernel.org>
> > Cc: Doug Ledford <dledford@redhat.com>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: linux-rdma@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/infiniband/hw/mlx5/mlx5_ib.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > index bf20a388eabe..f63bf204a7a1 100644
> > --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > @@ -644,6 +644,7 @@ struct mlx5_ib_mr {
> >  	struct ib_umem *umem;
> >  
> >  	/* This is zero'd when the MR is allocated */
> > +	struct_group(cleared,
> >  	union {
> >  		/* Used only while the MR is in the cache */
> >  		struct {
> > @@ -691,12 +692,13 @@ struct mlx5_ib_mr {
> >  			bool is_odp_implicit;
> >  		};
> >  	};
> > +	);
> >  };
> >  
> >  /* Zero the fields in the mr that are variant depending on usage */
> >  static inline void mlx5_clear_mr(struct mlx5_ib_mr *mr)
> >  {
> > -	memset(mr->out, 0, sizeof(*mr) - offsetof(struct mlx5_ib_mr, out));
> > +	memset(&mr->cleared, 0, sizeof(mr->cleared));
> >  }
> 
> Why not use the memset_after(mr->umem) here?

I can certainly do that instead. In this series I've tended to opt
for groupings so the position of future struct member additions are
explicitly chosen. (i.e. reducing the chance that a zeroing of the new
member be a surprise.)

-Kees

-- 
Kees Cook
