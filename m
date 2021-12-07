Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB4146C3C5
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 20:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbhLGToj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 14:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbhLGToj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Dec 2021 14:44:39 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ECAC061746
        for <linux-rdma@vger.kernel.org>; Tue,  7 Dec 2021 11:41:08 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so262957pjb.5
        for <linux-rdma@vger.kernel.org>; Tue, 07 Dec 2021 11:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ctfRGVnbZ5UzVvW76lJpHV55yVu735c4sanjvxj5i6g=;
        b=gGwiu8mVrsst9qCWyF8JSYof1zhfxWJtWrF4/VNNPFbt+9liMSH+avbw0kQCH5Mt6h
         NvVvY0BOSfu3wzytgep0jDQ5jIJpcAd9nfpvO7Ztp+NXHI92e2xlgx/OWtTcFUcbxuFi
         5hoyie7jpkcFRfDG/W/Wa7ybZTgb2nAyVFDlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ctfRGVnbZ5UzVvW76lJpHV55yVu735c4sanjvxj5i6g=;
        b=FwJQSmvKgb2sT7/pwKY+sX7m9R5zoX1q+/pNC9Und1z0vF+m4hrIXucwtItJsFJKQW
         k1IF8b7Vp5r8FnUAkkHHZm1u6dBSL3BhTVk22zK0Y6anr1J5BxiCchWTp/F7Hdl5JHty
         pnIxO14BGLedr6c7nnapj6sYDBh6EGhGQyYR/1J2VgrtYapRFhMT6XZ5kinIlrwn3thG
         PwmPU3GZ6UF4LjHWW82XpmsYRM/Rt516saWwvsLxAUEQSWdpZIcqVN8yO2MP6sPO34QN
         jtNxgSW4lsSMvIj9AHeTGUN1/OScGKcJjo3erq7+tymsW+4Wh7uM5GkeHeVdQRc1MN78
         dTwg==
X-Gm-Message-State: AOAM530g5ia6HBZShGki0jvZVQCdL8CIf94YKkRy5ZINledW/tAgTQ7P
        XsTV/ibeNRB+kZnCXKN/+UjjHw==
X-Google-Smtp-Source: ABdhPJyMHxBe2uwEACS+gk84ue+Eh1Ae4nS/CMUFSNlmEgNXRaRvfz7t8KT5kQ/IkoTPMtotRgyvjw==
X-Received: by 2002:a17:90a:670e:: with SMTP id n14mr1531197pjj.144.1638906068073;
        Tue, 07 Dec 2021 11:41:08 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l21sm3549042pjt.24.2021.12.07.11.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 11:41:07 -0800 (PST)
Date:   Tue, 7 Dec 2021 11:41:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: Use memset_after() to zero struct mlx5_ib_mr
Message-ID: <202112071138.64C168D@keescook>
References: <20211118203138.1287134-1-keescook@chromium.org>
 <YZpPr2P11LJNtrIm@unreal>
 <20211207184729.GA118570@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207184729.GA118570@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 07, 2021 at 02:47:29PM -0400, Jason Gunthorpe wrote:
> On Sun, Nov 21, 2021 at 03:54:55PM +0200, Leon Romanovsky wrote:
> > On Thu, Nov 18, 2021 at 12:31:38PM -0800, Kees Cook wrote:
> > > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > > field bounds checking for memset(), avoid intentionally writing across
> > > neighboring fields.
> > > 
> > > Use memset_after() to zero the end of struct mlx5_ib_mr that should
> > > be initialized.
> > > 
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > >  drivers/infiniband/hw/mlx5/mlx5_ib.h | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > > index e636e954f6bf..af94c9fe8753 100644
> > > +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > > @@ -665,8 +665,7 @@ struct mlx5_ib_mr {
> > >  	/* User MR data */
> > >  	struct mlx5_cache_ent *cache_ent;
> > >  	struct ib_umem *umem;
> > > -
> > > -	/* This is zero'd when the MR is allocated */
> > > +	/* Everything after umem is zero'd when the MR is allocated */
> > >  	union {
> > >  		/* Used only while the MR is in the cache */
> > >  		struct {
> > > @@ -718,7 +717,7 @@ struct mlx5_ib_mr {
> > >  /* Zero the fields in the mr that are variant depending on usage */
> > >  static inline void mlx5_clear_mr(struct mlx5_ib_mr *mr)
> > >  {
> > > -	memset(mr->out, 0, sizeof(*mr) - offsetof(struct mlx5_ib_mr, out));
> > > +	memset_after(mr, 0, umem);
> > 
> > I think that it is not equivalent change and you need "memset_after(mr, 0, cache_ent);"
> > to clear umem pointer too.
> 
> Kees?

Oops, sorry, I missed the ealrier reply!

I don't think that matches -- the original code wipes from the start of
"out" to the end of the struct. "out" is the first thing in the union
after "umem", so "umem" was not wiped before. I retained that behavior
("wipe everything after umem").

Am I misunderstanding the desired behavior here?

Thanks!

-- 
Kees Cook
