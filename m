Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBA13A11CC
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 12:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbhFIK51 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Jun 2021 06:57:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238498AbhFIK5Y (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Jun 2021 06:57:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B16D8613B1;
        Wed,  9 Jun 2021 10:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623236126;
        bh=CEckOtKHisKW5/GmFdQ+82S9aKodcrglK4CUrAikFAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XzNEs1e+jId8cYbVSqbWqQQj/hUXdu9OOOEo4NluJi4Xl7RzrfxH1qVw9Fur+frzy
         8bCR9Q45NEBT2KE7jgoiMjyGzi1QFweRgXTUwq40iUVAUGL3ndEn6wbEPZsEEtanAc
         epkCFAQKrmcEBLKlmukJKZvJpKF18stR5yVF8akxYZrZdiZmtjB9CvudXFnEUKJvRq
         2yz0m13oelzZFFqlgaaIQPohqReBwUJ2spo0ZwvILkbDwV/WTrY9lOBXFlEK64p+Go
         vd2+MkKYaaUiTfSA8WlbAozbFrJl0UQLoLuhUtV24jU/l1SNht+Q7O96TsjbOgUxNS
         9cI4fPTeDS1QQ==
Date:   Wed, 9 Jun 2021 13:55:22 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Bloch <markb@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA: Verify port when creating flow rule
Message-ID: <YMCeGiLRG9aTIC2O@unreal>
References: <07ddc8516a0e53e54e3cf5cbbff19cac6cda3d82.1623129061.git.leonro@nvidia.com>
 <20210608200935.GA992630@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608200935.GA992630@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 08, 2021 at 05:09:35PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 08, 2021 at 08:12:24AM +0300, Leon Romanovsky wrote:
> > @@ -3198,6 +3199,13 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
> >  	if (err)
> >  		return err;
> >  
> > +	ucontext = ib_uverbs_get_ucontext(attrs);
> > +	if (IS_ERR(ucontext))
> > +		return PTR_ERR(ucontext);
> 
> ib_uverbs_get_ucontext() should only be used by methods that don't
> have a uboject, this one does so it should be using uobj->context
> instead

Why "should"?
At the end, we will get same ucontext.

> 
> It looks like this can be moved down to after the uobject is allocated

The idea is to fail early, before first kmalloc and uobj_alloc, so we won't need
to do any error unwinding.

> 
> Jason
