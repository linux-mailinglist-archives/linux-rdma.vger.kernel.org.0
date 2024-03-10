Return-Path: <linux-rdma+bounces-1356-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049648775F3
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 10:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33026B2131C
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 09:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F1D1DDDB;
	Sun, 10 Mar 2024 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1ImGlUR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFCC1DFD2;
	Sun, 10 Mar 2024 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710062699; cv=none; b=WCDMWHDCjARYqdd30e8zw+TWvJ/xdDkll9FYf4VEKo/5w+Hd5u6Iy3e6s1ru/ju0e8JwpQLz/XsMXJ39i1BWsG3RpM8caorWM82B2AnJpVi/F87f/y1iuwgbUKIvOuYaBrBKI/Vs3O+f6iNT4WhClr3V0ibmlyveRdKBdq11p9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710062699; c=relaxed/simple;
	bh=P4ZM/mizClm/AHwxqWX/09R1OQ5BDYw3G6pF7eCt3Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVt2Lc7Kb+PuURWVqVLpAzT7v3fuMUt3pPgk694QUwbfSCOgD2Nr1bjmMNt9OGh2IeKN9dVixMzlVB9HodtBKxsIRLq91783fqvgZP5+NkGtkQ7c8/3GaTeJNGEPKcXmXHbN9wbxeCP0IsNdWhz8ex272phLUC2AHArASz+Arjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1ImGlUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D96C433F1;
	Sun, 10 Mar 2024 09:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710062698;
	bh=P4ZM/mizClm/AHwxqWX/09R1OQ5BDYw3G6pF7eCt3Yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g1ImGlURaLnRTv/IYCL48IuBeXzuto6vTT3xVCYgw9ZZCpWskBmaDuAKqv576m9XX
	 06XVeZSyIKqI5tFO2eZb5FxOgkSLL18TfzrUO3xXPm8JIXN1mc2WZJcOUv29mKE5qR
	 ufGjfD5/rlUBaz8BAc/V/BaH2uWwVct7tG/K2be5TeFhfpJN8IxEf8R+C3SVTeOm3S
	 ikZQFX0kOTOU5XL4adI+RusxIZqlScqroRAhEtYiRi0yBHmaveDYFxy2g2OTlkH28t
	 pdPt1TqJs+UA1popkuZlBx/AUGZAJRVD8oqA6qutu7GC5ZT4YT1mTgsd+66apJ/XhC
	 exGkyV8NbfYGg==
Date: Sun, 10 Mar 2024 11:24:54 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Wenchao Hao <haowenchao2@huawei.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/restrack: Fix potential invalid address access
Message-ID: <20240310092454.GA12921@unreal>
References: <20240301095514.3598280-1-haowenchao2@huawei.com>
 <20240307091317.GA8392@unreal>
 <c84561e1-0fc5-4381-961f-a246b577938f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c84561e1-0fc5-4381-961f-a246b577938f@huawei.com>

On Thu, Mar 07, 2024 at 10:17:59PM +0800, Wenchao Hao wrote:
> On 2024/3/7 17:13, Leon Romanovsky wrote:
> > On Fri, Mar 01, 2024 at 05:55:15PM +0800, Wenchao Hao wrote:
> > > struct rdma_restrack_entry's kern_name was set to KBUILD_MODNAME
> > > in ib_create_cq(), while if the module exited but forgot del this
> > > rdma_restrack_entry, it would cause a invalid address access in
> > > rdma_restrack_clean() when print the owner of this rdma_restrack_entry.
> > > 
> > > Fix this issue by using kstrdup() to set rdma_restrack_entry's
> > > kern_name.
> > 
> > I don't like kstrdup() and would like to avoid it, this rdma_restrack_clean()
> > is purely for debugging and for a long time all upstream ULPs are "clean"
> > from these not-released bugs.
> > 
> > So my suggestion is to delete that part of code and it will be good enough.
> > 
> 
> It's OK for me. When found this issue, my first plan is to remove the code, but
> I do not know why these code is added, so decide to using kstrdup() to work around
> it.

This code helped us to find one forgotten PD release in one of the ULPs. But it is not needed anymore.

> 
> Then what to do next? Do I need to post another patch or you would fix it by yourself?

Please send new patch, thanks.

