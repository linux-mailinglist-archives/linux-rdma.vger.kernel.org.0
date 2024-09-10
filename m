Return-Path: <linux-rdma+bounces-4856-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCA2973724
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 14:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4BE1C24006
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 12:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF9118C34D;
	Tue, 10 Sep 2024 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iws9POTR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684F81E493;
	Tue, 10 Sep 2024 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725971031; cv=none; b=s+DZcqhvVWdIAMKC4TWM+VsMmaAAXmkQLBIIR+EczLSeRtkJzedvv/PFF791h6qY8Pllwg3xCE5hUXWkJRwTggQhM6hgQvxDaMznH4hzFhU8Vcv9ALV7ZUWxzz1MsJHC8t+zTCdJdiZEFDNGIJ1M/KfnGQgHO1MDD8qag+JdDWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725971031; c=relaxed/simple;
	bh=oErQ0EOlxZmE4HoRmhvWuqG3bduQ0mATRTnoZBsg/1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnP6VAxfPzzECyopLo1+62oOf6a5C74lQo3UcYzw+aZIgbXf8b+QdbU9SY/POgfr6unMp4QOEuR14a0Wm7htz5Hek5Xo1gCcBE2AJRf6SjWlaty2Abv2W1R615SPxJTXZlsH7cZU0wyNbA2tDyvTvX+AF+44kzRsVdTyubvn1RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iws9POTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E46C4CEC3;
	Tue, 10 Sep 2024 12:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725971031;
	bh=oErQ0EOlxZmE4HoRmhvWuqG3bduQ0mATRTnoZBsg/1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iws9POTR/rqseG8qE9h0MTQx1zFEhWxJBiHOoonYa/bvgCZGF+CQb+TmA/NZo+dRW
	 wmMqsRTbxi8JpbMDS3kcq8brGh78jI2EUrhpE0NQg91oZKPQ+TkOcxH1yynft+elzz
	 hxVuDcf6w4Vvkfq+Yb5tcuL39+QnAkaX8pcdOuBjZ+ouR442kjey/rIOrqBIniedV1
	 bUVVII5qOxjNkemcL2bwjzYa6eFEtn0Wtn2qo4IfdIDgCmN1+JtYYNJ9kMR4VKfCIa
	 qsjxpuoge2jzrT+mE8IKcKc3TBkpOEQBnYqp4ywQroS/+kpRdjwFHEklfJhA6hbfsH
	 1lUjaICfdIZTA==
Date: Tue, 10 Sep 2024 15:23:45 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yu Jiaoliang <yujiaoliang@vivo.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Erick Archer <erick.archer@gmx.com>,
	Akiva Goldberger <agoldberger@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Rohit Chavan <roheetchavan@gmail.com>,
	Shigeru Yoshida <syoshida@redhat.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v2 rdma-next] RDMA: Use ERR_CAST to return an
 error-valued pointer
Message-ID: <20240910122345.GZ4026@unreal>
References: <20240906062141.1845816-1-yujiaoliang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240906062141.1845816-1-yujiaoliang@vivo.com>

On Fri, Sep 06, 2024 at 02:21:36PM +0800, Yu Jiaoliang wrote:
> Instead of directly casting and returning an error-valued pointer,
> use ERR_CAST to make the error handling more explicit and improve
> code clarity.
> 
> Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
> ---
> v2:
> - Additional modifications in file /drivers/infiniband/hw/irdma/verbs.c
> v1: https://lore.kernel.org/all/20240905110615.GU4026@unreal/
> ---
>  drivers/infiniband/core/mad_rmpp.c   | 2 +-
>  drivers/infiniband/core/uverbs_cmd.c | 2 +-
>  drivers/infiniband/core/verbs.c      | 2 +-
>  drivers/infiniband/hw/irdma/verbs.c  | 4 ++--
>  4 files changed, 5 insertions(+), 5 deletions(-)

It is still incomplete.
Something like that will give you a better result:
➜  kernel git:(wip/leon-for-next) git grep "return (" drivers/infiniband/ | grep "\*"

Thanks

