Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C82532A819
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Mar 2021 18:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573865AbhCBRJH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Mar 2021 12:09:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:35444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1382894AbhCBK1i (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 2 Mar 2021 05:27:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D41D364EE8;
        Tue,  2 Mar 2021 10:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614680817;
        bh=0NoY57+k+b4pCUG11G42aDY5MHuEkNJa2tzFGLgOR6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A7IzscKjRjsCVQPeH3NajUo5vP6Qk2u+/FD4hPMtZh4Q0lscAxaxXZdchMajR+d3i
         K01qBhx/UCGiHEqiD29n1LzR7EyxIuBNh14ujmCv6IaZsJtHbO0l6wTBEoI4Qp+Cfn
         veE0DTRgnG7OjC7X+tbYMClP9zjM9w8pJNduJYLEPi/k67MlrGBt6ytBj6iHHcodid
         ANZc7En12Ubo5xMX0yOAWJETpF7OXYfLJpNCretrLkBfvBNJpfTZyPCmSFspCrV8T4
         9ncPOY9n7tjkKEwLHmywtpQFpuEzZYFz4ocSy6M0+rSXgjavEccCA3/sfua6ApnMV4
         A2bE6Xq6zJQ4g==
Date:   Tue, 2 Mar 2021 12:26:53 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc 2/2] RDMA/uverbs: Fix kernel-doc warning of
 _uverbs_alloc
Message-ID: <YD4S7ZmdphBUOMmB@unreal>
References: <20210302074214.1054299-1-leon@kernel.org>
 <20210302074214.1054299-3-leon@kernel.org>
 <20210302093223.GB2690909@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210302093223.GB2690909@dell>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 02, 2021 at 09:32:23AM +0000, Lee Jones wrote:
> On Tue, 02 Mar 2021, Leon Romanovsky wrote:
>
> > From: Leon Romanovsky <leonro@nvidia.com>
> >
> > Fix the following W=1 compilation warning:
> > drivers/infiniband/core/uverbs_ioctl.c:108: warning: expecting prototype for uverbs_alloc(). Prototype was for _uverbs_alloc() instead
> >
> > Fixes: 461bb2eee4e1 ("IB/uverbs: Add a simple allocator to uverbs_attr_bundle")
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/infiniband/core/uverbs_ioctl.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
> > index e47c5949013f..3871049a48f7 100644
> > --- a/drivers/infiniband/core/uverbs_ioctl.c
> > +++ b/drivers/infiniband/core/uverbs_ioctl.c
> > @@ -90,8 +90,8 @@ void uapi_compute_bundle_size(struct uverbs_api_ioctl_method *method_elm,
> >  	WARN_ON_ONCE(method_elm->bundle_size > PAGE_SIZE);
> >  }
> >
> > -/**
> > - * uverbs_alloc() - Quickly allocate memory for use with a bundle
> > +/*
>
> Why are you also demoting the header?

It is mistake. thanks

>
> It looks fine to me.  Just correct the function name.
>
> > + * _uverbs_alloc() - Quickly allocate memory for use with a bundle
> >   * @bundle: The bundle
> >   * @size: Number of bytes to allocate
> >   * @flags: Allocator flags
>
> --
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
