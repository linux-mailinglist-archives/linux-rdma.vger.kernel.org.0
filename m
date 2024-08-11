Return-Path: <linux-rdma+bounces-4304-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D58094E078
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Aug 2024 10:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224C728182C
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Aug 2024 08:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D411C6B4;
	Sun, 11 Aug 2024 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tARJ+876"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC742E3F7;
	Sun, 11 Aug 2024 08:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723364331; cv=none; b=REidEMN9y9JWQlXwaLMY8AjVzS0hFEbGQ1x6IlmYVBCuC+0yFor1F0SeOUTStoHNfHkHJH2/6Al2O8mkCwYCRiCvQFx7JYSnfvrmoBi9UaMCVnFmJvFSIdRHggH2cpxnBJYCZf0gGUo6YQf1VajyPLsAX/7RhRNNqfm6/QYGUQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723364331; c=relaxed/simple;
	bh=6ENBaNzhU1rwlJF1irIBi9hRAI3UkLpjUrOOeyLoqA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcUR3wE3+myjsvGjGjuosGB/AkNfdja3XsD5ZI91fwMNyIQVJa8WKSfOQFfqlE687wh49yGNUMr8qCr6PAs5JQmm4GHFJisT2g2GWZMzhHLb6XhMlyejhT7QiMUuzkCXIebZup6oCvH6WUewcPSpmR8yW47zEoHOiVgNFYNDtRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tARJ+876; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8724C4AF09;
	Sun, 11 Aug 2024 08:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723364330;
	bh=6ENBaNzhU1rwlJF1irIBi9hRAI3UkLpjUrOOeyLoqA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tARJ+876/DypRG5E4NgYVw8B+6uywL0cqU9BdrdlxH0n6tYZsugYUkSVt8mTMOG47
	 EWlXmZ4HXtRaPBFafcL2KGu5k2RJcD89eQlmoIr1THAq8ifkViBj/TwW1ZJlmZSf5z
	 E926Cpups6697ypAlMLzLM0tWYNAQ4g+86Gkt1gbTunko8Xg8G6C7hcLrtK0eUc0wd
	 /epkQCODchav/m4lu+aV5wCLUNjtUuONeEWoXPA0pomz2OO/srIqAIgOpwj9IUA3Qh
	 bqoRxfh8eGidLcOAfSRYmyYkI9P5/FLgvpcdMzMpXUJtMoEdZJLgYgBEB3rODnWZKi
	 3pw6ahGZxKKSw==
Date: Sun, 11 Aug 2024 11:18:46 +0300
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next 0/3] RDMA: Provide an API for drivers to
 disassociate mmap pages
Message-ID: <20240811081846.GA448562@unreal>
References: <20240726071910.626802-1-huangjunxian6@hisilicon.com>
 <172285563690.428749.9415541768231694130.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <172285563690.428749.9415541768231694130.b4-ty@kernel.org>

On Mon, Aug 05, 2024 at 02:00:36PM +0300, Leon Romanovsky wrote:
>=20
> On Fri, 26 Jul 2024 15:19:07 +0800, Junxian Huang wrote:
> > Provide an API rdma_user_mmap_disassociate() for drivers to disassociate
> > mmap pages. Use this API in hns to prevent userspace from ringing doorb=
ell
> > when HW is reset.
> >=20
> > Chengchang Tang (3):
> >   RDMA/core: Provide rdma_user_mmap_disassociate() to disassociate mmap
> >     pages
> >   RDMA/hns: Link all uctx to uctx_list on a device
> >   RDMA/hns: Disassociate mmap pages for all uctx when HW is being reset
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [1/3] RDMA/core: Provide rdma_user_mmap_disassociate() to disassociate mm=
ap pages
>       https://git.kernel.org/rdma/rdma/c/29df39ce0a64f0

Junxian, sorry but I had to drop this series from my wip branch,

The more kbuilds reports I got the more I realized that this series
needs more work.

My main concern is that in first patch, you put uverbs_user_mmap_disassocia=
te() function in
ib_core_verbs.c, which is not the right place for it. This function should =
stay in uverbs_main.c
which is protected by right "depends on" in Kconfig.

Please fix this and resend the series.

Thanks

> [2/3] RDMA/hns: Link all uctx to uctx_list on a device
>       https://git.kernel.org/rdma/rdma/c/bb5b2b25624fa9
> [3/3] RDMA/hns: Disassociate mmap pages for all uctx when HW is being res=
et
>       https://git.kernel.org/rdma/rdma/c/e60457876e3223
>=20
> Best regards,
> --=20
> Leon Romanovsky <leon@kernel.org>
>=20

