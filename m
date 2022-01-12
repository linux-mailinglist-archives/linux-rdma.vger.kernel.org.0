Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4016648CD43
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jan 2022 21:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357862AbiALUuB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jan 2022 15:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357779AbiALUtP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jan 2022 15:49:15 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56597C06173F
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jan 2022 12:49:15 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id e19so5943187plc.10
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jan 2022 12:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7W9xjq/mp4aCvm206IRSxrwEOD/OCQl74SQ0cZUg6Zk=;
        b=G3BfIgpjh8dLLN9x19avToNGSRfF/ePsf9nlDhPAc0Ehj3HS5/gMO/ZXBJxrXL201M
         +DW1BQ1fSpf8G9JpajYzKjS7Ofsy4kTGeWUF1yCcL4lszLSl0wx9Ok6rPUAGhaII5Kfx
         /FLCIJVVW9fE4ObKwgK7nNjhDytHcS1l5nc2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7W9xjq/mp4aCvm206IRSxrwEOD/OCQl74SQ0cZUg6Zk=;
        b=hJwqOwnGCDBcY+h8GpqS9qkFa16F3CfppDhbD9k8ZSVhWUBKcAU2HTrEE2iCBSd9CT
         Iw+ji5KZrMBUqXUs4146G+TYgXLxBfRcd54k8UXF1Ni621hz5nzpeCM2fBQ4grdGZpKD
         9C3gzEKBJNABugh/GitRQv1JLNvmp5KkdwLI6US0gt/2BP7ZWDJclp9Hgbuenew7RK9a
         Tr/+Si5Ym+cALBSp10qrwk2kW2ghelPYpKFY3da8ZNL/BcVtvaArPuFPXpyItSsuvaRW
         OZuMuoJxGko6DulNdzIjS1NcRuDfKsM6cNvIPNpkdLQ5MK533QoQNMg2gJoWIOXk+k/P
         vC1g==
X-Gm-Message-State: AOAM530gSv3bVdz2FQVBfd1VQdzu/7r9R/NiiS1TKXnTUldpmE1Z2kSN
        ALBjkIjoDGMq8YlK+R4Pw5+D4w==
X-Google-Smtp-Source: ABdhPJy/L9qAeACUYTmweyUFS9pNNxRrKwqLON0XCFhLcLmffYCohvW4vQnr/k0oyGFlb3Kr0h84uQ==
X-Received: by 2002:a17:902:b201:b0:149:4b25:332d with SMTP id t1-20020a170902b20100b001494b25332dmr1201061plr.17.1642020554893;
        Wed, 12 Jan 2022 12:49:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mw8sm487817pjb.42.2022.01.12.12.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 12:49:14 -0800 (PST)
Date:   Wed, 12 Jan 2022 12:49:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: Use memset_after() to zero struct mlx5_ib_mr
Message-ID: <202201121247.BB9F6E9@keescook>
References: <20211118203138.1287134-1-keescook@chromium.org>
 <YZpPr2P11LJNtrIm@unreal>
 <20211207184729.GA118570@nvidia.com>
 <202112071138.64C168D@keescook>
 <20211207194525.GL6385@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207194525.GL6385@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 07, 2021 at 03:45:25PM -0400, Jason Gunthorpe wrote:
> On Tue, Dec 07, 2021 at 11:41:07AM -0800, Kees Cook wrote:
> > On Tue, Dec 07, 2021 at 02:47:29PM -0400, Jason Gunthorpe wrote:
> > > On Sun, Nov 21, 2021 at 03:54:55PM +0200, Leon Romanovsky wrote:
> > > > On Thu, Nov 18, 2021 at 12:31:38PM -0800, Kees Cook wrote:
> > > > > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > > > > field bounds checking for memset(), avoid intentionally writing across
> > > > > neighboring fields.
> > > > > 
> > > > > Use memset_after() to zero the end of struct mlx5_ib_mr that should
> > > > > be initialized.
> > > > > 
> > > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > >  drivers/infiniband/hw/mlx5/mlx5_ib.h | 5 ++---
> > > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > > > > index e636e954f6bf..af94c9fe8753 100644
> > > > > +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > > > > @@ -665,8 +665,7 @@ struct mlx5_ib_mr {
> > > > >  	/* User MR data */
> > > > >  	struct mlx5_cache_ent *cache_ent;
> > > > >  	struct ib_umem *umem;
> > > > > -
> > > > > -	/* This is zero'd when the MR is allocated */
> > > > > +	/* Everything after umem is zero'd when the MR is allocated */
> > > > >  	union {
> > > > >  		/* Used only while the MR is in the cache */
> > > > >  		struct {
> > > > > @@ -718,7 +717,7 @@ struct mlx5_ib_mr {
> > > > >  /* Zero the fields in the mr that are variant depending on usage */
> > > > >  static inline void mlx5_clear_mr(struct mlx5_ib_mr *mr)
> > > > >  {
> > > > > -	memset(mr->out, 0, sizeof(*mr) - offsetof(struct mlx5_ib_mr, out));
> > > > > +	memset_after(mr, 0, umem);
> > > > 
> > > > I think that it is not equivalent change and you need "memset_after(mr, 0, cache_ent);"
> > > > to clear umem pointer too.
> > > 
> > > Kees?
> > 
> > Oops, sorry, I missed the ealrier reply!
> > 
> > I don't think that matches -- the original code wipes from the start of
> > "out" to the end of the struct. "out" is the first thing in the union
> > after "umem", so "umem" was not wiped before. I retained that behavior
> > ("wipe everything after umem").
> > 
> > Am I misunderstanding the desired behavior here?
> 
> Ah, it is this patch:
> 
> commit f0ae4afe3d35e67db042c58a52909e06262b740f
> Author: Alaa Hleihel <alaa@nvidia.com>
> Date:   Mon Nov 22 13:41:51 2021 +0200
> 
>     RDMA/mlx5: Fix releasing unallocated memory in dereg MR flow
> 
> Which moved umem into the union that is causing the confusion
> 
> It hasn't quite made it to a rc release yet, so I suppose the answer
> is to rebase this on that then it is as Leon  says about cache_ent

The umem patch appears to have been reverted. Should I send an updated
patch for memset_after()? I think it would simply be:

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index e3c33be9c5a0..a58f69b19705 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -667,7 +667,7 @@ struct mlx5_ib_mr {
 	struct mlx5_cache_ent *cache_ent;
 	struct ib_umem *umem;
 
-	/* This is zero'd when the MR is allocated */
+	/* Everything after umem is zero'd when MR allocated */
 	union {
 		/* Used only while the MR is in the cache */
 		struct {
@@ -719,7 +719,7 @@ struct mlx5_ib_mr {
 /* Zero the fields in the mr that are variant depending on usage */
 static inline void mlx5_clear_mr(struct mlx5_ib_mr *mr)
 {
-	memset(mr->out, 0, sizeof(*mr) - offsetof(struct mlx5_ib_mr, out));
+	memset_after(mr, 0, umem);
 }
 
 static inline bool is_odp_mr(struct mlx5_ib_mr *mr)

-- 
Kees Cook
