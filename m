Return-Path: <linux-rdma+bounces-2269-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC1A8BC06E
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 15:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01028B20D1F
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 13:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF18B1865B;
	Sun,  5 May 2024 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFCeer+y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F48D18C36
	for <linux-rdma@vger.kernel.org>; Sun,  5 May 2024 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714914193; cv=none; b=PN5A36re0V5COhpje744eoDPWgapOADvL0qNn87Ho43NMt+P1wOHqp/mCIT9JI46BdO4dWhsLts7M+XyIkQP+X4zeivVs54miIOkhHsbnSuZaaF8pSBvr0IiBB8UeNWIC0H13ivhTNDprQO+apJZxZUJ3ffRPjVFAYNxpz0gS6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714914193; c=relaxed/simple;
	bh=76Rh/dQ0eOO9Pcd/NpYHjt9L23E+AGFrZq3SLjrkTPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGYRHNzXB4WucEZXAleMWNpm3ATUtihcekyU1gPNxbLqkJzfiq5Q+QbhuGMxvOn6VLE3aKtYHFe82O34athbwRKoR/OIcXOk9CwgjdQonbOxOyKhyT21EhoJGkG0XlByn1upuDGMhcClxXvPel6BnV3G08r6p9PLAizyxdMEblM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFCeer+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A858FC113CC;
	Sun,  5 May 2024 13:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714914193;
	bh=76Rh/dQ0eOO9Pcd/NpYHjt9L23E+AGFrZq3SLjrkTPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HFCeer+yqevtgph/kD39vZUawf1gieqcdeLV6rU/F/3icJeP5JiLo22ilax81gDON
	 2JQbAF568dfIlzEQjph5/mea2HO4Yf8pOwM3HyycGu9oUJtJgGlFN2QQbimvXDbGqu
	 0l4hc8uI3ks/P+kIw65dzFGkr+J0fztvKHeB1024xKHsVOnh/hQVZBCIFLIJ2qM760
	 KYJH+JU6S85JwJ2ocH+8hvTzx8dR02scxKlI2ieM6dYGf+Pdjgrx1qLJV5f92RSdEi
	 hRK66jk8W7vgpyLEybRspxzHcGqaKIe/if2AlDFb07uaKd/dC0cOjJaEMntBgAk+Wq
	 ylpwb6kJ7+P6A==
Date: Sun, 5 May 2024 16:03:09 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 1/1] IB: sw: rdmavt: mr: use 'time_left' variable with
 wait_for_completion_timeout()
Message-ID: <20240505130309.GA68202@unreal>
References: <20240502210559.11795-2-wsa+renesas@sang-engineering.com>
 <dc2783fa-de8b-4609-8ce6-f168b5dbfeff@cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc2783fa-de8b-4609-8ce6-f168b5dbfeff@cornelisnetworks.com>

On Thu, May 02, 2024 at 05:37:35PM -0400, Dennis Dalessandro wrote:
> On 5/2/24 5:05 PM, Wolfram Sang wrote:
> > There is a confusing pattern in the kernel to use a variable named 'timeout' to
> > store the result of wait_for_completion_timeout() causing patterns like:
> > 
> > 	timeout = wait_for_completion_timeout(...)
> > 	if (!timeout) return -ETIMEDOUT;
> > 
> > with all kinds of permutations. Use 'time_left' as a variable to make the code
> > self explaining.
> > 
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >  drivers/infiniband/sw/rdmavt/mr.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdmavt/mr.c
> > index 7a9afd5231d5..689e708032fd 100644
> > --- a/drivers/infiniband/sw/rdmavt/mr.c
> > +++ b/drivers/infiniband/sw/rdmavt/mr.c
> > @@ -441,7 +441,7 @@ static void rvt_dereg_clean_qps(struct rvt_mregion *mr)
> >   */
> >  static int rvt_check_refs(struct rvt_mregion *mr, const char *t)
> >  {
> > -	unsigned long timeout;
> > +	unsigned long time_left;
> >  	struct rvt_dev_info *rdi = ib_to_rvt(mr->pd->device);
> >  
> >  	if (mr->lkey) {
> > @@ -451,8 +451,8 @@ static int rvt_check_refs(struct rvt_mregion *mr, const char *t)
> >  		synchronize_rcu();
> >  	}
> >  
> > -	timeout = wait_for_completion_timeout(&mr->comp, 5 * HZ);
> > -	if (!timeout) {
> > +	time_left = wait_for_completion_timeout(&mr->comp, 5 * HZ);
> > +	if (!time_left) {
> >  		rvt_pr_err(rdi,
> >  			   "%s timeout mr %p pd %p lkey %x refcount %ld\n",
> >  			   t, mr, mr->pd, mr->lkey,
> 
> Nah. Disagree. I think the code is just fine as it is.

I agree with Dennis. Let's drop this patch.

Thanks

> 
> -Denny

