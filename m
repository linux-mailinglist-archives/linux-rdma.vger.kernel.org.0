Return-Path: <linux-rdma+bounces-2876-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D188FC83B
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 11:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F81284668
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 09:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C48C49629;
	Wed,  5 Jun 2024 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uef4gJAk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF5918FDB0
	for <linux-rdma@vger.kernel.org>; Wed,  5 Jun 2024 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580701; cv=none; b=QVVCmLzY6zbBwd3QcFFw7he6rfEyDXYKsqJ0tuFp49ewOa1ULm/LLQQuBI9yXe32ikU2u2T1eXZYn2x4Qe+rSA5nVr4oETvw+6vKrsjyEA9hiFJOb+33blDMpKgndfKtILJ7eytC1DuRRkYEFUMF2owGKq9KfPvRmP2jQmhtcyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580701; c=relaxed/simple;
	bh=7ViuhaZ0vOQ1hkJ64ymeyVoHRmW0wh10SrFbHtwmOx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQmHKlZ3Sq3sK97ThhVdmNLlJEZU58GBihoEkjooqGpnrWtj38ChWTR11yYX2CSAkmZe19nYKLNZUm38IaCccy3E/efqwCFKJADgtKm04jeIQ36JtWH7a//Wd+bQg+mkGDJqBPlxvgxFJalqztVHUP+vy2EgtNzRsd04DErD0wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uef4gJAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A097C3277B;
	Wed,  5 Jun 2024 09:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717580700;
	bh=7ViuhaZ0vOQ1hkJ64ymeyVoHRmW0wh10SrFbHtwmOx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uef4gJAkLqlydWHUl2ak7SEESIBIvhd5O/mIcxqEHp2ke28HqbGJXW5mUTI12fb/0
	 au1QDb+rprRhgyQCrgS6o8GCOynsbs28SntKhcRbDkKDeGeXvjqOPZsk0gyCQgB1zc
	 FIvfmhg33Ai3TtNwP9Kl0ZFkPe0FM14myJcf6iEez8tFVfjjS3GDvRv4x15jXBIS6P
	 hUE+sWSxcnJvRFB7BRcKEH51M/cTvhYBdIoxHaCJQcWCj5Ld5rJJW2N0HOZGb72kaP
	 fsMrYl50HY6LfPdFHCfgqdNYDhs1JA3sJSQ634icSj4IA3A5Pudfcx+j+YO+fr09xR
	 YHdZZjUJihWLQ==
Date: Wed, 5 Jun 2024 12:44:56 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-rc 1/6] RDMA/cache: Release GID table even if leak
 is detected
Message-ID: <20240605094456.GA19021@unreal>
References: <cover.1716900410.git.leon@kernel.org>
 <a62560af06ba82c88ef9194982bfa63d14768ff9.1716900410.git.leon@kernel.org>
 <20240604163636.GK19897@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604163636.GK19897@nvidia.com>

On Tue, Jun 04, 2024 at 01:36:36PM -0300, Jason Gunthorpe wrote:
> On Tue, May 28, 2024 at 03:52:51PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > When the table is released, we nullify pointer to GID table, it means
> > that in case GID entry leak is detected, we will leak table too.
> > 
> > Delete code that prevents table destruction.
> 
> This converts a memory leak into a UAF, it doesn't seem like a good direction??

Maybe we should convert dev_err() to be WARN_ON(). I didn't see any
complains about GID entry leaks. It is debug print.

Thanks

> 
> Jason
> 

